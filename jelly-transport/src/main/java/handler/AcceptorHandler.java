package handler;

import io.netty.channel.Channel;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.handler.codec.http.FullHttpRequest;
import io.netty.handler.codec.http.websocketx.WebSocketServerHandshaker;
import io.netty.handler.codec.http.websocketx.WebSocketServerHandshakerFactory;
import org.apache.log4j.Logger;
import protocol.MessageHolder;
import protocol.ProtocolHeader;
import queue.TaskQueue;

import java.util.concurrent.BlockingQueue;

/**
 * 最终接收数据的Handler，将待处理数据放入阻塞队列中，由服务模块take and deal.
 *
 * @author Yohann.
 */
public class AcceptorHandler extends ChannelInboundHandlerAdapter {
    private static final Logger logger = Logger.getLogger(AcceptorHandler.class);

    private final BlockingQueue<MessageHolder> taskQueue;


    private WebSocketServerHandshaker handshaker;
    public AcceptorHandler() {
        taskQueue = TaskQueue.getQueue();
    }

    @Override
    public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
        if (msg instanceof MessageHolder) {
            MessageHolder messageHolder = (MessageHolder) msg;
            // 指定Channel
            messageHolder.setChannel(ctx.channel());
            // 添加到任务队列
            boolean offer = taskQueue.offer(messageHolder);
            logger.info("TaskQueue添加任务: taskQueue=" + taskQueue.size());
            if (!offer) {
                // 服务器繁忙
                logger.warn("服务器繁忙，拒绝服务");
                // 繁忙响应
                response(ctx.channel(), messageHolder.getSign());
            }
        } else if(msg instanceof FullHttpRequest){
            handleHttpRequest(ctx,(FullHttpRequest)msg);
//            throw new IllegalArgumentException("msg is not instance of MessageHolder");
        }
    }

    private void handleHttpRequest(ChannelHandlerContext ctx, FullHttpRequest request) {
        if (!request.decoderResult().isSuccess() || !"websocket".equals(request.headers().get("Upgrade"))) {
            logger.warn("protobuf don't support websocket");
            ctx.channel().close();
            return;
        }
        WebSocketServerHandshakerFactory handshakerFactory = new WebSocketServerHandshakerFactory(
                "ws://localhost:20000/websocket", null, true);
        handshaker = handshakerFactory.newHandshaker(request);
        if (handshaker == null) {
            WebSocketServerHandshakerFactory.sendUnsupportedVersionResponse(ctx.channel());
        } else {
            // 动态加入websocket的编解码处理
            handshaker.handshake(ctx.channel(), request);
        }
    }


    /**
     * 服务器繁忙响应
     *
     * @param channel
     * @param sign
     */
    private void response(Channel channel, byte sign) {
        MessageHolder messageHolder = new MessageHolder();
        messageHolder.setSign(ProtocolHeader.RESPONSE);
        messageHolder.setType(sign);
        messageHolder.setStatus(ProtocolHeader.SERVER_BUSY);
        messageHolder.setBody("");
        channel.writeAndFlush(messageHolder);
    }
}
