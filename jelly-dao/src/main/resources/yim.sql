/*
 Navicat Premium Data Transfer

 Source Server         : localhot-111-db
 Source Server Type    : MySQL
 Source Server Version : 50630
 Source Host           : 192.168.0.111
 Source Database       : yim

 Target Server Type    : MySQL
 Target Server Version : 50630
 File Encoding         : utf-8

 Date: 12/07/2018 17:52:30 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `friends`
-- ----------------------------
DROP TABLE IF EXISTS `friends`;
CREATE TABLE `friends` (
  `username` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Table structure for `groups`
-- ----------------------------
DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `name` varchar(20) NOT NULL,
  `creater` varchar(20) DEFAULT NULL,
  `member_1` varchar(20) DEFAULT NULL,
  `member_2` varchar(20) DEFAULT NULL,
  `member_3` varchar(20) DEFAULT NULL,
  `member_4` varchar(20) DEFAULT NULL,
  `member_5` varchar(20) DEFAULT NULL,
  `member_6` varchar(20) DEFAULT NULL,
  `member_7` varchar(20) DEFAULT NULL,
  `member_8` varchar(20) DEFAULT NULL,
  `member_9` varchar(20) DEFAULT NULL,
  `member_10` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Records of `groups`
-- ----------------------------
BEGIN;
INSERT INTO `groups` VALUES ('testgroup', 'admin', 'caogw', null, null, null, null, null, null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `offline_msg`
-- ----------------------------
DROP TABLE IF EXISTS `offline_msg`;
CREATE TABLE `offline_msg` (
  `id` varchar(20) NOT NULL,
  `sender` varchar(20) DEFAULT NULL,
  `receiver` varchar(20) DEFAULT NULL,
  `message` varchar(20) DEFAULT NULL,
  `time` bigint(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Table structure for `offline_msg_group`
-- ----------------------------
DROP TABLE IF EXISTS `offline_msg_group`;
CREATE TABLE `offline_msg_group` (
  `id` varchar(20) NOT NULL,
  `sender` varchar(20) DEFAULT NULL,
  `receiver` varchar(20) DEFAULT NULL,
  `group` varchar(20) DEFAULT NULL,
  `message` varchar(20) DEFAULT NULL,
  `time` bigint(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` varchar(20) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `sex` varchar(20) DEFAULT NULL,
  `age` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `introduction` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
--  Records of `users`
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('1', 'admin', '123456', '管理员', '1', '1', '1', '1', '1'), ('2', 'caogw', '123456', '旺旺', '1', '1', '1', '1', '1');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
