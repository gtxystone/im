/*
Navicat MySQL Data Transfer

Source Server         : 123.57.47.19
Source Server Version : 50718
Source Host           : 123.57.47.19:3306
Source Database       : imdb

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-03-22 16:42:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for im_admin
-- ----------------------------
DROP TABLE IF EXISTS `im_admin`;
CREATE TABLE `im_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `nickname` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(255) NOT NULL,
  `mobile` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `last_login_ip` varchar(255) DEFAULT NULL,
  `last_login_time` varchar(30) DEFAULT '',
  `expire_time` bigint(20) DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL,
  `roleid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_admin_action
-- ----------------------------
DROP TABLE IF EXISTS `im_admin_action`;
CREATE TABLE `im_admin_action` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `m` varchar(255) DEFAULT NULL,
  `c` varchar(255) DEFAULT NULL,
  `a` varchar(255) DEFAULT NULL,
  `menuid` bigint(20) DEFAULT NULL,
  `isbase` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_admin_privs
-- ----------------------------
DROP TABLE IF EXISTS `im_admin_privs`;
CREATE TABLE `im_admin_privs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `roleid` bigint(20) NOT NULL,
  `menus` text NOT NULL COMMENT '可操作的id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `im_admin_role`;
CREATE TABLE `im_admin_role` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `desc` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_app_push_message
-- ----------------------------
DROP TABLE IF EXISTS `im_app_push_message`;
CREATE TABLE `im_app_push_message` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '通知标题',
  `content` text NOT NULL COMMENT '通知内容',
  `addTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_apps
-- ----------------------------
DROP TABLE IF EXISTS `im_apps`;
CREATE TABLE `im_apps` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `app_id` varchar(120) NOT NULL COMMENT '应用id',
  `app_key` varchar(120) NOT NULL COMMENT '应用密钥',
  `app_secret` varchar(120) NOT NULL COMMENT '应用 安全校验码',
  `app_name` varchar(255) NOT NULL COMMENT '应用名称',
  `app_os` enum('android','ios','web') DEFAULT NULL COMMENT '操作系统',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ext_info` text COMMENT '扩展信息字段',
  `status` smallint(5) NOT NULL DEFAULT '0' COMMENT '状态 0 未审核 1 审核通过 2 拒绝通过 3 禁用',
  `userId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_article
-- ----------------------------
DROP TABLE IF EXISTS `im_article`;
CREATE TABLE `im_article` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `pic` text,
  `type_id` bigint(20) DEFAULT NULL,
  `author` bigint(20) DEFAULT NULL,
  `is_hot` tinyint(1) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_bank_region
-- ----------------------------
DROP TABLE IF EXISTS `im_bank_region`;
CREATE TABLE `im_bank_region` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `regionCode` varchar(10) DEFAULT NULL,
  `regionName` varchar(255) DEFAULT NULL,
  `regionLevel` varchar(255) DEFAULT NULL,
  `regionBelong` varchar(255) DEFAULT NULL,
  `regionProvince` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2316 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_banks
-- ----------------------------
DROP TABLE IF EXISTS `im_banks`;
CREATE TABLE `im_banks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `bankName` varchar(255) DEFAULT NULL COMMENT '银行名称',
  `bankCode` smallint(5) DEFAULT NULL COMMENT '银行代码',
  `cityCode` smallint(5) DEFAULT NULL COMMENT '城市代码',
  `sysBnkCode` bigint(20) DEFAULT NULL COMMENT '开户行银行代码',
  `sysBnkName` varchar(255) DEFAULT NULL COMMENT '开户行名称',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=163510 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_document
-- ----------------------------
DROP TABLE IF EXISTS `im_document`;
CREATE TABLE `im_document` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `_key` varchar(120) DEFAULT NULL COMMENT '文档key值 创建保持唯一性',
  `title` varchar(255) DEFAULT NULL COMMENT '文档标题',
  `content` text,
  `auth` varchar(50) DEFAULT NULL COMMENT '作者',
  `userId` bigint(20) DEFAULT NULL COMMENT '文档创建管理员id',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_favorite
-- ----------------------------
DROP TABLE IF EXISTS `im_favorite`;
CREATE TABLE `im_favorite` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category` int(11) DEFAULT '1' COMMENT '1文本2图片3语音4视频5表情6链接文章',
  `from_id` bigint(20) DEFAULT NULL,
  `from_name` varchar(255) DEFAULT NULL,
  `from_head_url` varchar(255) DEFAULT NULL,
  `create_time` bigint(20) DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=646 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_feed
-- ----------------------------
DROP TABLE IF EXISTS `im_feed`;
CREATE TABLE `im_feed` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `feed_text` text CHARACTER SET utf8mb4,
  `feed_imgs` text,
  `feed_video` text COMMENT '分享的短视频',
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `user_head_url` varchar(255) DEFAULT NULL,
  `create_time` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '1正常-1删除',
  `lat` varchar(10) DEFAULT '',
  `lng` varchar(10) DEFAULT '',
  `address` varchar(255) DEFAULT '',
  `priv` smallint(1) DEFAULT '0' COMMENT '0 公开 1 私密 2 部分可见 3 部分不可见',
  `at` varchar(255) DEFAULT '',
  `uids` text COMMENT '限制部分的的用户id',
  `ext` varchar(4096) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '扩展字段',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2511 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_feed_comment
-- ----------------------------
DROP TABLE IF EXISTS `im_feed_comment`;
CREATE TABLE `im_feed_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `feed_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `user_head_url` varchar(255) DEFAULT NULL,
  `reply_user_id` bigint(20) DEFAULT NULL,
  `reply_user_name` varchar(255) DEFAULT NULL,
  `reply_user_head_url` varchar(255) DEFAULT NULL,
  `comment_text` text CHARACTER SET utf8mb4,
  `create_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `im_feed_id_fk` (`feed_id`),
  CONSTRAINT `im_feed_id_fk` FOREIGN KEY (`feed_id`) REFERENCES `im_feed` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1764 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_feed_gift
-- ----------------------------
DROP TABLE IF EXISTS `im_feed_gift`;
CREATE TABLE `im_feed_gift` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL COMMENT '礼物发送方id',
  `destId` bigint(20) DEFAULT NULL COMMENT '礼物接收方id',
  `feedId` bigint(20) DEFAULT NULL COMMENT '关联的动态id',
  `giftContent` varchar(4096) CHARACTER SET utf8mb4 DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `destId` (`destId`),
  CONSTRAINT `im_feed_gift_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `im_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `im_feed_gift_ibfk_2` FOREIGN KEY (`destId`) REFERENCES `im_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_feed_praise
-- ----------------------------
DROP TABLE IF EXISTS `im_feed_praise`;
CREATE TABLE `im_feed_praise` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `feed_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `user_head_url` varchar(255) DEFAULT NULL,
  `create_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_praise_feed_id` (`feed_id`),
  CONSTRAINT `fk_praise_feed_id` FOREIGN KEY (`feed_id`) REFERENCES `im_feed` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1147 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_feedback
-- ----------------------------
DROP TABLE IF EXISTS `im_feedback`;
CREATE TABLE `im_feedback` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '问题场景',
  `pid` int(11) DEFAULT '0',
  `problem` text COMMENT '问题集',
  `type` int(1) DEFAULT '0' COMMENT '0热点问题，1反馈',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ishot` tinyint(1) DEFAULT '0',
  `icon` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_feedback_information
-- ----------------------------
DROP TABLE IF EXISTS `im_feedback_information`;
CREATE TABLE `im_feedback_information` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `content` text,
  `feedbackid` int(11) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `add_content` varchar(255) DEFAULT NULL,
  `pic` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_friend
-- ----------------------------
DROP TABLE IF EXISTS `im_friend`;
CREATE TABLE `im_friend` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL COMMENT '用户id',
  `friendId` bigint(20) DEFAULT NULL COMMENT '好友id',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注名称',
  `createrId` bigint(20) DEFAULT NULL,
  `createTime` bigint(20) DEFAULT NULL COMMENT '创建时间',
  `isBlack` int(11) DEFAULT '0' COMMENT '0不是黑名单1黑名单',
  `isFriend` int(11) DEFAULT '0' COMMENT '0单向1双向',
  `receiveTip` int(11) DEFAULT '1' COMMENT '1接收提示0不接收提示',
  `bgurl` text COMMENT '好友聊天背景',
  `feedPriv` int(11) DEFAULT '1' COMMENT '好友的朋友圈 1看 0 不看',
  `ufeedPriv` int(11) DEFAULT '1' COMMENT '我的朋友圈对好友权限 0 不可看 1可看',
  `groupid` bigint(20) DEFAULT '0' COMMENT '分组id',
  PRIMARY KEY (`id`),
  KEY `friend_userId` (`userId`),
  KEY `friend_friendId` (`friendId`),
  KEY `friend_isblack` (`isBlack`),
  KEY `friend_isfriend` (`isFriend`),
  KEY `groupid` (`groupid`),
  KEY `feedPriv` (`feedPriv`),
  KEY `ufeedPriv` (`ufeedPriv`)
) ENGINE=InnoDB AUTO_INCREMENT=53779 DEFAULT CHARSET=utf8mb4 COMMENT='好友列表';

-- ----------------------------
-- Table structure for im_friend_group
-- ----------------------------
DROP TABLE IF EXISTS `im_friend_group`;
CREATE TABLE `im_friend_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '好友分组表',
  `userId` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT '' COMMENT '分组名称',
  `sort` smallint(5) DEFAULT '0' COMMENT '分组排序',
  `createTime` bigint(20) DEFAULT NULL,
  `createTimestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `isdefault` smallint(2) DEFAULT '0' COMMENT '默认分组标记',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `isdefault` (`isdefault`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_group
-- ----------------------------
DROP TABLE IF EXISTS `im_group`;
CREATE TABLE `im_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '名称',
  `name` varchar(255) DEFAULT NULL,
  `descriptions` text COMMENT '描述',
  `detail` varchar(255) DEFAULT NULL COMMENT '备注',
  `headUrl` text COMMENT '头像class或者url',
  `createrId` bigint(20) DEFAULT NULL,
  `createTime` bigint(20) DEFAULT NULL,
  `joinStatus` int(11) DEFAULT '0' COMMENT '加群 验证 0-无需验证 1 需要验证消息  2 需要回答问题并由管理员审核 3 需要正确回答问题 4 只允许群成员邀请 5 不允许任何人加入 6 付费加群  ',
  `question` varchar(255) DEFAULT '',
  `answer` varchar(255) DEFAULT '',
  `fee` decimal(10,2) DEFAULT '0.00',
  `level` smallint(5) DEFAULT '0',
  `expire` bigint(20) DEFAULT '0' COMMENT '到期时间',
  PRIMARY KEY (`id`),
  KEY `createrId` (`createrId`),
  KEY `level` (`level`),
  KEY `expire` (`expire`),
  KEY `joinStatus` (`joinStatus`)
) ENGINE=InnoDB AUTO_INCREMENT=2676 DEFAULT CHARSET=utf8mb4 COMMENT='群组';

-- ----------------------------
-- Table structure for im_group_config
-- ----------------------------
DROP TABLE IF EXISTS `im_group_config`;
CREATE TABLE `im_group_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `level` smallint(5) unsigned DEFAULT '0',
  `expire` bigint(20) DEFAULT '0',
  `fee` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `level` (`level`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='群组级别设置';

-- ----------------------------
-- Table structure for im_group_member
-- ----------------------------
DROP TABLE IF EXISTS `im_group_member`;
CREATE TABLE `im_group_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `groupId` bigint(20) DEFAULT NULL COMMENT '群组id',
  `userId` bigint(255) DEFAULT NULL COMMENT '成员id',
  `markName` varchar(255) DEFAULT NULL,
  `role` int(11) DEFAULT '3' COMMENT '成员角色1群主2管理员3普通成员',
  `creatorId` bigint(20) DEFAULT NULL,
  `createTime` bigint(20) DEFAULT NULL,
  `receiveTip` int(11) DEFAULT '0' COMMENT '1接收提示0不接收提示',
  `isAccept` int(11) DEFAULT '0' COMMENT '0未审核1已审核',
  `bgurl` varchar(500) DEFAULT '',
  `silence` bigint(20) DEFAULT '0' COMMENT '禁言时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `groupId` (`groupId`,`userId`),
  KEY `mem_userId` (`userId`),
  KEY `mem_groupId` (`groupId`)
) ENGINE=InnoDB AUTO_INCREMENT=20003 DEFAULT CHARSET=utf8mb4 COMMENT='群组成员';

-- ----------------------------
-- Table structure for im_group_note
-- ----------------------------
DROP TABLE IF EXISTS `im_group_note`;
CREATE TABLE `im_group_note` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(1024) CHARACTER SET utf8mb4 DEFAULT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL COMMENT '发布公告的人',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `title` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_group_trans_log
-- ----------------------------
DROP TABLE IF EXISTS `im_group_trans_log`;
CREATE TABLE `im_group_trans_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  `destId` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_iplist
-- ----------------------------
DROP TABLE IF EXISTS `im_iplist`;
CREATE TABLE `im_iplist` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `country` varchar(255) DEFAULT NULL,
  `provinces` text,
  `ip` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT '1' COMMENT '1正常2禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for im_menu
-- ----------------------------
DROP TABLE IF EXISTS `im_menu`;
CREATE TABLE `im_menu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `pid` bigint(20) NOT NULL,
  `sort` smallint(5) NOT NULL COMMENT '排序',
  `isdisplay` tinyint(1) NOT NULL DEFAULT '1',
  `m` varchar(255) NOT NULL DEFAULT '' COMMENT '模块',
  `c` varchar(255) NOT NULL COMMENT '控制器',
  `a` varchar(255) NOT NULL COMMENT '方法',
  `icon` varchar(255) DEFAULT NULL,
  `site` tinyint(1) DEFAULT '0' COMMENT '0left菜单，1操作功能',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_message
-- ----------------------------
DROP TABLE IF EXISTS `im_message`;
CREATE TABLE `im_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `devType` int(11) DEFAULT NULL COMMENT '消息来源设备类型：1pc 2mac 3android 4other',
  `geoId` int(11) DEFAULT NULL COMMENT '地理位置id',
  `msgId` varchar(255) DEFAULT NULL,
  `fromId` bigint(20) DEFAULT NULL COMMENT '消息来源id',
  `fromType` int(11) DEFAULT NULL COMMENT '消息来源类型：1单聊2群聊',
  `imageIconUrl` varchar(255) DEFAULT NULL,
  `destId` bigint(20) DEFAULT NULL COMMENT '接收消息id',
  `fromName` varchar(255) DEFAULT NULL,
  `content` text,
  `messageType` int(11) DEFAULT NULL COMMENT '消息类型：1文本2图片3文件4语音5视频6其他',
  `sendTime` bigint(20) DEFAULT NULL COMMENT '发送时间',
  `receiveTime` bigint(20) DEFAULT NULL COMMENT '接收时间',
  `version` int(11) DEFAULT NULL COMMENT '消息版本号',
  `status` int(11) DEFAULT NULL COMMENT '消息状态：1已读2未读',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='消息记录';

-- ----------------------------
-- Table structure for im_msg_history
-- ----------------------------
DROP TABLE IF EXISTS `im_msg_history`;
CREATE TABLE `im_msg_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `belongId` bigint(20) DEFAULT NULL,
  `relationMsgId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for im_orders
-- ----------------------------
DROP TABLE IF EXISTS `im_orders`;
CREATE TABLE `im_orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(255) NOT NULL,
  `fee` decimal(18,2) NOT NULL,
  `createtime` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `status` smallint(5) NOT NULL,
  `userId` bigint(20) NOT NULL,
  `tradefee` decimal(18,2) NOT NULL,
  `type` int(11) NOT NULL,
  `desc` text NOT NULL,
  `currencyCode` varchar(255) NOT NULL,
  `plat` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for im_power
-- ----------------------------
DROP TABLE IF EXISTS `im_power`;
CREATE TABLE `im_power` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(64) NOT NULL,
  `foreign_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` blob NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `foreign_id` (`foreign_id`),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_power_tree
-- ----------------------------
DROP TABLE IF EXISTS `im_power_tree`;
CREATE TABLE `im_power_tree` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL,
  `title` varchar(128) NOT NULL,
  `controller` varchar(32) NOT NULL,
  `action` varchar(32) NOT NULL,
  `together` varchar(64) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `list_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_pro
-- ----------------------------
DROP TABLE IF EXISTS `im_pro`;
CREATE TABLE `im_pro` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `agrNo` varchar(30) DEFAULT NULL,
  `serialNo` bigint(20) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for im_program
-- ----------------------------
DROP TABLE IF EXISTS `im_program`;
CREATE TABLE `im_program` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `logo` text,
  `template_id` bigint(20) DEFAULT NULL,
  `lat` varchar(255) DEFAULT NULL,
  `lng` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL COMMENT '省',
  `city` varchar(255) DEFAULT NULL COMMENT '市',
  `county` varchar(255) DEFAULT NULL COMMENT '县、区',
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL COMMENT '网页链接',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_program_data
-- ----------------------------
DROP TABLE IF EXISTS `im_program_data`;
CREATE TABLE `im_program_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `program_id` bigint(20) DEFAULT NULL,
  `data` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_program_goods
-- ----------------------------
DROP TABLE IF EXISTS `im_program_goods`;
CREATE TABLE `im_program_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `goods_name` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT '0.00',
  `goods_thum` varchar(255) DEFAULT NULL,
  `goods_image` text COMMENT '图文详情',
  `parameter` text COMMENT '商品参数',
  `program_id` bigint(20) DEFAULT NULL,
  `market_price` decimal(10,2) DEFAULT '0.00' COMMENT '市场价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_program_type
-- ----------------------------
DROP TABLE IF EXISTS `im_program_type`;
CREATE TABLE `im_program_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `pid` int(11) DEFAULT '0',
  `sort` varchar(255) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_public
-- ----------------------------
DROP TABLE IF EXISTS `im_public`;
CREATE TABLE `im_public` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) NOT NULL,
  `email` varchar(255) DEFAULT '',
  `samNo` varchar(50) DEFAULT '' COMMENT '平台号码',
  `pwd` varchar(255) DEFAULT '' COMMENT '公众号登录密码',
  `name` varchar(255) DEFAULT '' COMMENT '公众号名称',
  `ptype` int(11) DEFAULT '0' COMMENT '公众号类型  0-订阅号 1-服务号 3-小程序',
  `status` int(11) DEFAULT '0' COMMENT '公众号状态 0 -审核中  1- 已开通 2-禁用',
  `pNo` varchar(50) DEFAULT '' COMMENT '注册公众号生成的唯一字符串',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for im_redpacket
-- ----------------------------
DROP TABLE IF EXISTS `im_redpacket`;
CREATE TABLE `im_redpacket` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `redPacketCount` int(255) DEFAULT NULL,
  `redPacketAmount` decimal(10,2) DEFAULT NULL,
  `redPacketContent` text,
  `destType` int(11) DEFAULT NULL COMMENT '1人对人红包2是群红包',
  `destId` bigint(20) DEFAULT NULL,
  `redPacketType` int(11) DEFAULT NULL COMMENT '1随机金额2等额',
  `sendTime` bigint(20) DEFAULT NULL,
  `finishTime` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '1未领取完2已经领取完3已回收',
  `command` varchar(255) DEFAULT NULL COMMENT '口令红包口令',
  `limituser` varchar(4096) DEFAULT '' COMMENT '限制开红包用户id',
  PRIMARY KEY (`id`),
  KEY `redpacket_userid` (`userId`),
  KEY `redpacket_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2026 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for im_redpacket_history
-- ----------------------------
DROP TABLE IF EXISTS `im_redpacket_history`;
CREATE TABLE `im_redpacket_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `redPacketId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `createTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `redhis_packetId` (`redPacketId`),
  KEY `redhis_userId` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=4833 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for im_region
-- ----------------------------
DROP TABLE IF EXISTS `im_region`;
CREATE TABLE `im_region` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `name` varchar(120) NOT NULL DEFAULT '',
  `region_level` tinyint(1) NOT NULL DEFAULT '2',
  `agency_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`pid`),
  KEY `region_type` (`region_level`),
  KEY `agency_id` (`agency_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3425 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_relation
-- ----------------------------
DROP TABLE IF EXISTS `im_relation`;
CREATE TABLE `im_relation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userid` bigint(20) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `createtime` int(11) DEFAULT NULL,
  `exptime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_report_items
-- ----------------------------
DROP TABLE IF EXISTS `im_report_items`;
CREATE TABLE `im_report_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(500) DEFAULT '' COMMENT '举报内容',
  `lang` varchar(10) DEFAULT 'cn' COMMENT '语言包',
  `pid` bigint(20) DEFAULT '0' COMMENT '上级目录',
  `sort` smallint(5) DEFAULT '0' COMMENT '排序',
  `belong` varchar(50) DEFAULT 'user' COMMENT '所属范围',
  `keywords` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_rock
-- ----------------------------
DROP TABLE IF EXISTS `im_rock`;
CREATE TABLE `im_rock` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `lat` varchar(50) NOT NULL,
  `lng` varchar(50) NOT NULL,
  `updatetime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for im_rock_message
-- ----------------------------
DROP TABLE IF EXISTS `im_rock_message`;
CREATE TABLE `im_rock_message` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `destId` bigint(20) DEFAULT NULL,
  `msg` varchar(500) DEFAULT '' COMMENT '消息内容',
  `pid` bigint(20) DEFAULT '0' COMMENT '上级消息的id',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `addTime` bigint(20) DEFAULT NULL COMMENT '添加时间戳',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `destId` (`destId`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_rock_record
-- ----------------------------
DROP TABLE IF EXISTS `im_rock_record`;
CREATE TABLE `im_rock_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL COMMENT '用户id',
  `destId` bigint(20) DEFAULT NULL COMMENT '摇到的用户id',
  `name` varchar(255) DEFAULT '',
  `headUrl` varchar(355) DEFAULT NULL COMMENT '摇一摇的用户头像连接',
  `sex` varchar(20) DEFAULT NULL,
  `distance` bigint(20) DEFAULT '0',
  `sign` varchar(255) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `isdelete` smallint(2) DEFAULT '0' COMMENT '删除标记  0- 未删除 1- 已经删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='摇一摇记录';

-- ----------------------------
-- Table structure for im_sam_number
-- ----------------------------
DROP TABLE IF EXISTS `im_sam_number`;
CREATE TABLE `im_sam_number` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(20) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT '0.00',
  `used` int(10) DEFAULT '0',
  `userId` bigint(20) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rule` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_sam_number_type
-- ----------------------------
DROP TABLE IF EXISTS `im_sam_number_type`;
CREATE TABLE `im_sam_number_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `isdelete` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_share
-- ----------------------------
DROP TABLE IF EXISTS `im_share`;
CREATE TABLE `im_share` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `content` text NOT NULL,
  `createtime` bigint(20) DEFAULT NULL,
  `type` smallint(5) DEFAULT '0' COMMENT '分享类型 0-普通文字 1-图文 ',
  `atwho` text NOT NULL COMMENT '@了谁 格式 id1,id2',
  `pics` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_share_praise
-- ----------------------------
DROP TABLE IF EXISTS `im_share_praise`;
CREATE TABLE `im_share_praise` (
  `sid` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `createtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_share_reply
-- ----------------------------
DROP TABLE IF EXISTS `im_share_reply`;
CREATE TABLE `im_share_reply` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sid` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `fuserId` bigint(20) DEFAULT NULL,
  `content` text,
  `createtime` bigint(20) DEFAULT NULL,
  `type` tinyint(1) DEFAULT '0' COMMENT '0-评论 1-回复评论',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_sys_config
-- ----------------------------
DROP TABLE IF EXISTS `im_sys_config`;
CREATE TABLE `im_sys_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `_key` varchar(255) NOT NULL DEFAULT '',
  `_value` varchar(255) NOT NULL DEFAULT '',
  `status` smallint(5) NOT NULL DEFAULT '0' COMMENT '启用状态',
  `desc` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_top
-- ----------------------------
DROP TABLE IF EXISTS `im_top`;
CREATE TABLE `im_top` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `destType` int(11) DEFAULT NULL,
  `destId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `top_userId` (`userId`),
  KEY `top_destId` (`destId`),
  KEY `top_destType` (`destType`)
) ENGINE=InnoDB AUTO_INCREMENT=1093 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for im_transform
-- ----------------------------
DROP TABLE IF EXISTS `im_transform`;
CREATE TABLE `im_transform` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) NOT NULL,
  `destId` bigint(20) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `msg` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL COMMENT '1待收钱2确认收钱3退回',
  `sendTime` bigint(20) NOT NULL,
  `confirmTime` bigint(20) DEFAULT NULL,
  `groupId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transform_userid` (`userId`),
  KEY `transform_destid` (`destId`),
  KEY `transform_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=912 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for im_transform_aa
-- ----------------------------
DROP TABLE IF EXISTS `im_transform_aa`;
CREATE TABLE `im_transform_aa` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `destId` bigint(20) DEFAULT NULL,
  `destType` smallint(5) DEFAULT '0' COMMENT '起始发送对象 0 个人 1 群组',
  `totalAmount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '总金额',
  `counts` int(11) NOT NULL DEFAULT '0' COMMENT '付款人数',
  `createTime` bigint(20) DEFAULT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  `status` smallint(5) DEFAULT '0' COMMENT '0-进行中 1-已经结束',
  `msg` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `destId` (`destId`),
  KEY `status` (`status`),
  KEY `destType` (`destType`)
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_transform_aa_record
-- ----------------------------
DROP TABLE IF EXISTS `im_transform_aa_record`;
CREATE TABLE `im_transform_aa_record` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `destId` bigint(20) DEFAULT NULL COMMENT 'AA付款id',
  `createTime` bigint(20) DEFAULT NULL COMMENT '付款时间',
  `amount` decimal(10,2) DEFAULT '0.00' COMMENT '付款金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_user
-- ----------------------------
DROP TABLE IF EXISTS `im_user`;
CREATE TABLE `im_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `imNumber` varchar(12) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `idNo` varchar(500) DEFAULT NULL,
  `nickName` varchar(255) DEFAULT NULL COMMENT '昵称',
  `realName` varchar(255) DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL COMMENT '密码',
  `mobile` varchar(255) DEFAULT NULL COMMENT '电话',
  `mail` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `sex` varchar(11) DEFAULT '1' COMMENT '性别0女1男',
  `birthday` bigint(20) DEFAULT NULL COMMENT '生日',
  `sign` varchar(255) DEFAULT NULL COMMENT '签名',
  `province` varchar(11) DEFAULT NULL COMMENT '省份id',
  `isOnline` int(11) DEFAULT '0' COMMENT '0不在线1在线',
  `needAuth` int(11) DEFAULT '1' COMMENT '//加好友是否要认证',
  `searchMobile` int(11) DEFAULT '1',
  `newNotification` int(11) DEFAULT '0',
  `city` varchar(11) DEFAULT NULL COMMENT '市id',
  `district` varchar(11) DEFAULT NULL COMMENT '区县id',
  `createTime` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT '0' COMMENT '1有效0无效',
  `detail` varchar(255) DEFAULT NULL COMMENT '备注',
  `isAuth` int(11) DEFAULT '0' COMMENT '0未认证1已认证',
  `headUrl` text COMMENT '头像class或者url',
  `recommandUserId` bigint(20) DEFAULT '0',
  `longitude` varchar(255) DEFAULT NULL COMMENT '上次出现经度',
  `feedBackImage` text,
  `latitude` varchar(255) DEFAULT NULL COMMENT '纬度',
  `bgurl` text,
  `isdelete` tinyint(1) DEFAULT '0',
  `user_group_id` int(11) DEFAULT '2',
  PRIMARY KEY (`id`),
  KEY `user_mobile` (`mobile`) USING HASH,
  KEY `user_pwd` (`pwd`) USING HASH,
  KEY `user_searchmobile` (`searchMobile`),
  KEY `imNumber` (`imNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=21220 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='基础用户';

-- ----------------------------
-- Table structure for im_user_bankcard
-- ----------------------------
DROP TABLE IF EXISTS `im_user_bankcard`;
CREATE TABLE `im_user_bankcard` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `cardNo` varchar(30) DEFAULT '' COMMENT '银行卡号',
  `bankName` varchar(50) DEFAULT '' COMMENT '银行名称',
  `userName` varchar(50) DEFAULT '' COMMENT '用户姓名',
  `openBankName` varchar(255) DEFAULT '' COMMENT '开户行名称',
  `openBankCode` varchar(50) DEFAULT '',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `province` varchar(50) DEFAULT '',
  `city` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_user_contact
-- ----------------------------
DROP TABLE IF EXISTS `im_user_contact`;
CREATE TABLE `im_user_contact` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `header` varchar(500) DEFAULT NULL COMMENT '通讯录的头像地址',
  `markName` varchar(50) DEFAULT NULL COMMENT '通讯录备注名',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=69167 DEFAULT CHARSET=utf8 COMMENT='用户导入的通讯录';

-- ----------------------------
-- Table structure for im_user_group
-- ----------------------------
DROP TABLE IF EXISTS `im_user_group`;
CREATE TABLE `im_user_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `is_admin` tinyint(1) NOT NULL,
  `title` varchar(64) NOT NULL,
  `alias` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_user_orders
-- ----------------------------
DROP TABLE IF EXISTS `im_user_orders`;
CREATE TABLE `im_user_orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `amount` decimal(20,2) DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COMMENT '充值描述',
  `status` smallint(1) DEFAULT '0' COMMENT '订单状态 0 未支付 1 支付完成  2 取消支付',
  `outTradeNo` varchar(100) DEFAULT '',
  `outString` varchar(4096) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '提交内容',
  `notifyString` varchar(4096) DEFAULT '' COMMENT '异步回调返回内容',
  `createTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `plat` varchar(50) DEFAULT '' COMMENT '支付平台',
  `historyid` bigint(20) DEFAULT NULL,
  `sessionid` varchar(200) DEFAULT NULL,
  `type` int(10) DEFAULT '0' COMMENT '订单类型 0 充值订单 1 购买靓号',
  PRIMARY KEY (`id`),
  KEY `user_orders_plat` (`plat`),
  KEY `user_orders_outTradeNo` (`outTradeNo`)
) ENGINE=InnoDB AUTO_INCREMENT=431 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_user_pay
-- ----------------------------
DROP TABLE IF EXISTS `im_user_pay`;
CREATE TABLE `im_user_pay` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `payPwd` varchar(255) DEFAULT NULL,
  `oldPwd` varchar(255) DEFAULT NULL,
  `createTime` bigint(20) DEFAULT NULL,
  `updateTime` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pay_userid` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=2889 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_user_program
-- ----------------------------
DROP TABLE IF EXISTS `im_user_program`;
CREATE TABLE `im_user_program` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `program_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_user_report
-- ----------------------------
DROP TABLE IF EXISTS `im_user_report`;
CREATE TABLE `im_user_report` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `destId` bigint(20) DEFAULT NULL,
  `destType` tinyint(1) DEFAULT '0' COMMENT '0 投诉个人 1 投诉群组',
  `report_imgs` text CHARACTER SET utf8mb4 COMMENT '投诉图片',
  `report_msg` text CHARACTER SET utf8mb4 COMMENT '投诉消息内容',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(1) DEFAULT '0' COMMENT '处理状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_user_token
-- ----------------------------
DROP TABLE IF EXISTS `im_user_token`;
CREATE TABLE `im_user_token` (
  `userId` bigint(20) unsigned NOT NULL,
  `token` varchar(50) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rtoken` varchar(50) DEFAULT NULL,
  `ctime` int(11) DEFAULT NULL,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`,`userId`),
  UNIQUE KEY `userId` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_version
-- ----------------------------
DROP TABLE IF EXISTS `im_version`;
CREATE TABLE `im_version` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `versions` varchar(255) DEFAULT NULL,
  `content` text,
  `device` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for im_wallet
-- ----------------------------
DROP TABLE IF EXISTS `im_wallet`;
CREATE TABLE `im_wallet` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `money` decimal(10,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '1成功2失败',
  PRIMARY KEY (`id`),
  KEY `wallet_userid` (`userId`),
  KEY `wallet_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=21114 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for im_wallet_history
-- ----------------------------
DROP TABLE IF EXISTS `im_wallet_history`;
CREATE TABLE `im_wallet_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) NOT NULL,
  `moneyType` int(11) NOT NULL COMMENT '1充值2提现3发红包4收红包5发转账6收转账7红包退回8转账退回 9 帐号购买 10 AA收款 11 AA 付款',
  `amount` decimal(10,2) NOT NULL,
  `destType` int(11) DEFAULT '1' COMMENT '1个人id2群id3其它',
  `destId` bigint(20) NOT NULL,
  `moneyDirect` int(11) DEFAULT NULL,
  `content` text,
  `occurTime` bigint(20) NOT NULL,
  `formType` tinyint(1) DEFAULT '0' COMMENT '1后台充值',
  `isdelete` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `wallhis_userid` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=9734 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- View structure for im_friend_view
-- ----------------------------
DROP VIEW IF EXISTS `im_friend_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `im_friend_view` AS select `a`.`userId` AS `userId`,`a`.`remark` AS `remark`,`a`.`isBlack` AS `isBlack`,`a`.`receiveTip` AS `receiveTip`,`b`.`id` AS `id`,`b`.`name` AS `name`,`b`.`nickName` AS `nickName`,`b`.`mobile` AS `mobile`,`b`.`mail` AS `mail`,`b`.`sex` AS `sex`,`b`.`birthday` AS `birthday`,`b`.`sign` AS `sign`,`b`.`province` AS `province`,`b`.`isOnline` AS `isOnline`,`b`.`city` AS `city`,`b`.`district` AS `district`,`b`.`createTime` AS `createTime`,`b`.`status` AS `status`,`b`.`detail` AS `detail`,`b`.`headUrl` AS `headUrl` from (`im_friend` `a` left join `im_user` `b` on((`a`.`friendId` = `b`.`id`))) where (`a`.`isFriend` = 1) ;

-- ----------------------------
-- View structure for im_message_view
-- ----------------------------
DROP VIEW IF EXISTS `im_message_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `im_message_view` AS select `a`.`belongId` AS `belongId`,`b`.`id` AS `id`,`b`.`devType` AS `devType`,`b`.`geoId` AS `geoId`,`b`.`msgId` AS `msgId`,`b`.`fromId` AS `fromId`,`b`.`fromType` AS `fromType`,`b`.`destId` AS `destId`,`b`.`content` AS `content`,`b`.`messageType` AS `messageType`,`b`.`sendTime` AS `sendTime`,`b`.`receiveTime` AS `receiveTime`,`b`.`version` AS `version`,`b`.`status` AS `status` from (`im_msg_history` `a` left join `im_message` `b` on((`a`.`relationMsgId` = `b`.`id`))) ;

-- ----------------------------
-- View structure for im_rock_view
-- ----------------------------
DROP VIEW IF EXISTS `im_rock_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `im_rock_view` AS select `r`.`id` AS `userid`,`r`.`lat` AS `lat`,`r`.`lng` AS `lng`,`r`.`updatetime` AS `updatetime`,`u`.`sex` AS `sex`,`u`.`headUrl` AS `headUrl`,`u`.`name` AS `name` from (`im_rock` `r` join `im_user` `u` on((`r`.`id` = `u`.`id`))) ;

-- ----------------------------
-- View structure for im_share_praise_view
-- ----------------------------
DROP VIEW IF EXISTS `im_share_praise_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `im_share_praise_view` AS select `sp`.`sid` AS `sid`,`sp`.`userId` AS `userId`,`sp`.`createtime` AS `createtime`,`u`.`nickName` AS `nickName` from (`im_share_praise` `sp` join `im_user` `u` on((`u`.`id` = `sp`.`userId`))) ;

-- ----------------------------
-- View structure for im_share_reply_view
-- ----------------------------
DROP VIEW IF EXISTS `im_share_reply_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `im_share_reply_view` AS select `sy`.`id` AS `id`,`sy`.`sid` AS `sid`,`sy`.`userId` AS `userId`,`sy`.`fuserId` AS `fuserId`,`sy`.`content` AS `content`,`sy`.`createtime` AS `createtime`,`sy`.`type` AS `type`,`u`.`nickName` AS `unickname`,`fu`.`nickName` AS `fnickname` from ((`im_share_reply` `sy` join `im_user` `u` on((`sy`.`userId` = `u`.`id`))) join `im_user` `fu` on((`sy`.`fuserId` = `fu`.`id`))) ;

-- ----------------------------
-- View structure for im_share_view
-- ----------------------------
DROP VIEW IF EXISTS `im_share_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `im_share_view` AS select `s`.`id` AS `sid`,`s`.`userId` AS `uid`,`s`.`content` AS `content`,`s`.`createtime` AS `createtime`,`s`.`type` AS `type`,`s`.`atwho` AS `atwho`,`u`.`nickName` AS `nickName`,`u`.`headUrl` AS `headUrl`,(select count(0) from `im_share_praise` `sp` where (`sp`.`sid` = `s`.`id`)) AS `praises`,(select count(0) from `im_share_reply` `sr` where ((`sr`.`sid` = `s`.`id`) and (`sr`.`type` = 0))) AS `replys` from (`im_share` `s` join `im_user` `u` on((`s`.`userId` = `u`.`id`))) ;

-- ----------------------------
-- View structure for im_user_contact_view
-- ----------------------------
DROP VIEW IF EXISTS `im_user_contact_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `im_user_contact_view` AS select `uc`.`userId` AS `userId`,`uc`.`phone` AS `phone`,`uc`.`header` AS `header`,`uc`.`markName` AS `markName`,(select count(0) from `im_user` `u` where (`u`.`mobile` like concat('%',`uc`.`phone`,'%'))) AS `isExists`,(select `u`.`id` from `im_user` `u` where (`u`.`mobile` like concat('%',`uc`.`phone`,'%')) limit 1) AS `fuserId` from `im_user_contact` `uc` ;

-- ----------------------------
-- Function structure for getDistance
-- ----------------------------
DROP FUNCTION IF EXISTS `getDistance`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getDistance`(  
    origLng DECIMAL(20,6), -- 目的地经度 
    origLat DECIMAL(20,6), -- 目的地纬度  
    longitude DECIMAL(20,6), -- 当前所在地点经度  
    latitude DECIMAL(20,6) -- 当前所在地点纬度  
) RETURNS double
BEGIN
      DECLARE result DOUBLE DEFAULT 0; 
      
      SET result = round(6378.138*2*asin(sqrt(pow(sin(
        (origLat*pi()/180-latitude*pi()/180)/2),2)+cos(origLat*pi()/180)*cos(latitude*pi()/180)*
        pow(sin( (origLng*pi()/180-longitude*pi()/180)/2),2)))*1000);
      
      RETURN result;  
     
 END
;;
DELIMITER ;
