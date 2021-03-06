/*
Navicat MySQL Data Transfer

Source Server         : 192.168.1.10
Source Server Version : 50709
Source Host           : 192.168.1.10:3306
Source Database       : oa

Target Server Type    : MYSQL
Target Server Version : 50709
File Encoding         : 65001

Date: 2015-12-31 11:11:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin_notice
-- ----------------------------
DROP TABLE IF EXISTS `admin_notice`;
CREATE TABLE `admin_notice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `dept_id` bigint(20) DEFAULT NULL,
  `file_ids` varchar(255) DEFAULT NULL,
  `content` text,
  `status` int(255) DEFAULT '1' COMMENT '1正常2删除',
  `create_time` bigint(20) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_notice_company` (`company_id`),
  KEY `fk_notice_dept` (`dept_id`),
  CONSTRAINT `fk_notice_company` FOREIGN KEY (`company_id`) REFERENCES `base_company` (`id`),
  CONSTRAINT `fk_notice_dept` FOREIGN KEY (`dept_id`) REFERENCES `base_company_dept` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_notice
-- ----------------------------
INSERT INTO `admin_notice` VALUES ('11', '222222', null, null, null, '222222222', '1', '1450661000994', '53');
INSERT INTO `admin_notice` VALUES ('12', '333333333', null, null, null, '3333333333', '1', '1450661000995', '53');
INSERT INTO `admin_notice` VALUES ('13', '44444444444', null, null, null, '4444444444444', '1', '1450661000996', '53');
INSERT INTO `admin_notice` VALUES ('14', '555555555555', null, null, null, '555555555555', '1', '1450661000997', '53');
INSERT INTO `admin_notice` VALUES ('15', '666666666', null, null, null, '666666666', '1', '1450661000998', '53');
INSERT INTO `admin_notice` VALUES ('16', '7777777', null, null, null, '777777777', '1', '1450661000999', '53');
INSERT INTO `admin_notice` VALUES ('17', 'ewqeqwe', '19', null, null, 'eqweqweqweqweeqweqwe', '1', '1450748393599', '53');
INSERT INTO `admin_notice` VALUES ('18', 'esfadsfd', '19', null, null, '公告fdsafasdfadsfdsafadsfdsf', '1', '1450753606140', '53');
INSERT INTO `admin_notice` VALUES ('19', '测试公告1', '19', null, null, 'dsfasdfdsafgrfdsgdfgdfgdsfdsafsfdsf', '1', '1450753623639', '53');

-- ----------------------------
-- Table structure for admin_op_log
-- ----------------------------
DROP TABLE IF EXISTS `admin_op_log`;
CREATE TABLE `admin_op_log` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `type` int(11) DEFAULT '1' COMMENT '1登陆2聊天3任务4文档5注销6其它',
  `occur_url` varchar(100) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `occur_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1161 DEFAULT CHARSET=utf8 COMMENT='记录登陆、注销。删除状态。';

-- ----------------------------
-- Records of admin_op_log
-- ----------------------------
INSERT INTO `admin_op_log` VALUES ('1024', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451449297437');
INSERT INTO `admin_op_log` VALUES ('1025', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451449499333');
INSERT INTO `admin_op_log` VALUES ('1026', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451449575780');
INSERT INTO `admin_op_log` VALUES ('1027', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451449611489');
INSERT INTO `admin_op_log` VALUES ('1028', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451449716127');
INSERT INTO `admin_op_log` VALUES ('1029', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451452469802');
INSERT INTO `admin_op_log` VALUES ('1030', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451453206188');
INSERT INTO `admin_op_log` VALUES ('1031', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451453644684');
INSERT INTO `admin_op_log` VALUES ('1032', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451453836841');
INSERT INTO `admin_op_log` VALUES ('1033', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451453920308');
INSERT INTO `admin_op_log` VALUES ('1034', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451454176963');
INSERT INTO `admin_op_log` VALUES ('1035', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451454216685');
INSERT INTO `admin_op_log` VALUES ('1036', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451454307856');
INSERT INTO `admin_op_log` VALUES ('1037', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451454404846');
INSERT INTO `admin_op_log` VALUES ('1038', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451454508250');
INSERT INTO `admin_op_log` VALUES ('1039', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451454580129');
INSERT INTO `admin_op_log` VALUES ('1040', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451454747396');
INSERT INTO `admin_op_log` VALUES ('1041', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451454902104');
INSERT INTO `admin_op_log` VALUES ('1042', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451455357504');
INSERT INTO `admin_op_log` VALUES ('1043', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451455408262');
INSERT INTO `admin_op_log` VALUES ('1044', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451455483293');
INSERT INTO `admin_op_log` VALUES ('1045', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451455615991');
INSERT INTO `admin_op_log` VALUES ('1046', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451455689326');
INSERT INTO `admin_op_log` VALUES ('1047', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451455869533');
INSERT INTO `admin_op_log` VALUES ('1048', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451455999960');
INSERT INTO `admin_op_log` VALUES ('1049', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451456062920');
INSERT INTO `admin_op_log` VALUES ('1050', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451456437163');
INSERT INTO `admin_op_log` VALUES ('1051', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451456617891');
INSERT INTO `admin_op_log` VALUES ('1052', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451456714774');
INSERT INTO `admin_op_log` VALUES ('1053', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451456669130');
INSERT INTO `admin_op_log` VALUES ('1054', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451456736618');
INSERT INTO `admin_op_log` VALUES ('1055', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451456816677');
INSERT INTO `admin_op_log` VALUES ('1056', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451456970036');
INSERT INTO `admin_op_log` VALUES ('1057', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451457205029');
INSERT INTO `admin_op_log` VALUES ('1058', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451457302924');
INSERT INTO `admin_op_log` VALUES ('1059', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451457379218');
INSERT INTO `admin_op_log` VALUES ('1060', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451457892935');
INSERT INTO `admin_op_log` VALUES ('1061', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451457969235');
INSERT INTO `admin_op_log` VALUES ('1062', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451458027099');
INSERT INTO `admin_op_log` VALUES ('1063', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451458127627');
INSERT INTO `admin_op_log` VALUES ('1064', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451458439574');
INSERT INTO `admin_op_log` VALUES ('1065', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451458387463');
INSERT INTO `admin_op_log` VALUES ('1066', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451458619572');
INSERT INTO `admin_op_log` VALUES ('1067', '162', '1', '/frontLogin', 'id为162的用户齐天大圣登陆系统', '1451458756703');
INSERT INTO `admin_op_log` VALUES ('1068', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451458916630');
INSERT INTO `admin_op_log` VALUES ('1069', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451458960549');
INSERT INTO `admin_op_log` VALUES ('1070', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451459198090');
INSERT INTO `admin_op_log` VALUES ('1071', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451459341326');
INSERT INTO `admin_op_log` VALUES ('1072', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451459338111');
INSERT INTO `admin_op_log` VALUES ('1073', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451459371843');
INSERT INTO `admin_op_log` VALUES ('1074', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451459567488');
INSERT INTO `admin_op_log` VALUES ('1075', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451459640774');
INSERT INTO `admin_op_log` VALUES ('1076', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451460051623');
INSERT INTO `admin_op_log` VALUES ('1077', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451460160281');
INSERT INTO `admin_op_log` VALUES ('1078', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451460638179');
INSERT INTO `admin_op_log` VALUES ('1079', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451461506188');
INSERT INTO `admin_op_log` VALUES ('1080', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451461848865');
INSERT INTO `admin_op_log` VALUES ('1081', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451462018045');
INSERT INTO `admin_op_log` VALUES ('1082', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451462693234');
INSERT INTO `admin_op_log` VALUES ('1083', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451464237905');
INSERT INTO `admin_op_log` VALUES ('1084', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451466130079');
INSERT INTO `admin_op_log` VALUES ('1085', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451466532270');
INSERT INTO `admin_op_log` VALUES ('1086', '123', '1', '/adminLogin', '用户祝枝山登陆系统', '1451466701636');
INSERT INTO `admin_op_log` VALUES ('1087', '123', '1', '/adminLogin', '用户祝枝山登陆系统', '1451466669864');
INSERT INTO `admin_op_log` VALUES ('1088', '123', '1', '/frontLogin', 'id为123的用户祝枝山登陆系统', '1451466690688');
INSERT INTO `admin_op_log` VALUES ('1089', '167', '6', '/frontRegisterStepThree', 'id为167的用户王宝强@黄渤进行了用户注册', '1451467657358');
INSERT INTO `admin_op_log` VALUES ('1090', '167', '6', '/frontCreateCompany', 'id为167的用户王宝强@黄渤注册了公司泰囧并创建了公司群', '1451467691103');
INSERT INTO `admin_op_log` VALUES ('1091', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451467719159');
INSERT INTO `admin_op_log` VALUES ('1092', '167', '1', '/adminLogin', '用户王宝强@黄渤登陆系统', '1451467755295');
INSERT INTO `admin_op_log` VALUES ('1093', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451468250369');
INSERT INTO `admin_op_log` VALUES ('1094', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451468537894');
INSERT INTO `admin_op_log` VALUES ('1095', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451468737896');
INSERT INTO `admin_op_log` VALUES ('1096', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451468828671');
INSERT INTO `admin_op_log` VALUES ('1097', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451469121632');
INSERT INTO `admin_op_log` VALUES ('1098', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451469087015');
INSERT INTO `admin_op_log` VALUES ('1099', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451469434389');
INSERT INTO `admin_op_log` VALUES ('1100', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451469406119');
INSERT INTO `admin_op_log` VALUES ('1101', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451469547300');
INSERT INTO `admin_op_log` VALUES ('1102', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451469610836');
INSERT INTO `admin_op_log` VALUES ('1103', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451470156114');
INSERT INTO `admin_op_log` VALUES ('1104', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451470172749');
INSERT INTO `admin_op_log` VALUES ('1105', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451470496528');
INSERT INTO `admin_op_log` VALUES ('1106', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451470563770');
INSERT INTO `admin_op_log` VALUES ('1107', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451471925031');
INSERT INTO `admin_op_log` VALUES ('1108', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451472097262');
INSERT INTO `admin_op_log` VALUES ('1109', '167', '5', '/adminLogout', '用户王宝强@黄渤离开系统', '1451472405079');
INSERT INTO `admin_op_log` VALUES ('1110', '167', '1', '/adminLogin', '用户王宝强@黄渤登陆系统', '1451472435353');
INSERT INTO `admin_op_log` VALUES ('1111', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451472506226');
INSERT INTO `admin_op_log` VALUES ('1112', '54', '1', '/adminLogin', '用户切勿登陆系统', '1451472570998');
INSERT INTO `admin_op_log` VALUES ('1113', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451472697668');
INSERT INTO `admin_op_log` VALUES ('1114', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451472640390');
INSERT INTO `admin_op_log` VALUES ('1115', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451474190331');
INSERT INTO `admin_op_log` VALUES ('1116', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451474147687');
INSERT INTO `admin_op_log` VALUES ('1117', '167', '1', '/adminLogin', '用户王宝强@黄渤登陆系统', '1451474172219');
INSERT INTO `admin_op_log` VALUES ('1118', '167', '1', '/adminLogin', '用户王宝强@黄渤登陆系统', '1451475237138');
INSERT INTO `admin_op_log` VALUES ('1119', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451475915569');
INSERT INTO `admin_op_log` VALUES ('1120', '167', '1', '/adminLogin', '用户王宝强@黄渤登陆系统', '1451476249478');
INSERT INTO `admin_op_log` VALUES ('1121', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451476499569');
INSERT INTO `admin_op_log` VALUES ('1122', '167', '1', '/adminLogin', '用户王宝强@黄渤登陆系统', '1451477093447');
INSERT INTO `admin_op_log` VALUES ('1123', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451477426660');
INSERT INTO `admin_op_log` VALUES ('1124', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451477464186');
INSERT INTO `admin_op_log` VALUES ('1125', '167', '1', '/adminLogin', '用户王宝强@黄渤登陆系统', '1451477519069');
INSERT INTO `admin_op_log` VALUES ('1126', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451477574943');
INSERT INTO `admin_op_log` VALUES ('1127', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451477724690');
INSERT INTO `admin_op_log` VALUES ('1128', '167', '1', '/adminLogin', '用户王宝强@黄渤登陆系统', '1451477749200');
INSERT INTO `admin_op_log` VALUES ('1129', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451477986160');
INSERT INTO `admin_op_log` VALUES ('1130', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451478264164');
INSERT INTO `admin_op_log` VALUES ('1131', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451523989517');
INSERT INTO `admin_op_log` VALUES ('1132', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451524126800');
INSERT INTO `admin_op_log` VALUES ('1133', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451525027350');
INSERT INTO `admin_op_log` VALUES ('1134', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451525676830');
INSERT INTO `admin_op_log` VALUES ('1135', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451525915026');
INSERT INTO `admin_op_log` VALUES ('1136', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451526447144');
INSERT INTO `admin_op_log` VALUES ('1137', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451527091403');
INSERT INTO `admin_op_log` VALUES ('1138', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451527308488');
INSERT INTO `admin_op_log` VALUES ('1139', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451527683695');
INSERT INTO `admin_op_log` VALUES ('1140', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451527686511');
INSERT INTO `admin_op_log` VALUES ('1141', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451527916219');
INSERT INTO `admin_op_log` VALUES ('1142', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451528512695');
INSERT INTO `admin_op_log` VALUES ('1143', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451528585115');
INSERT INTO `admin_op_log` VALUES ('1144', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451528680461');
INSERT INTO `admin_op_log` VALUES ('1145', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451529256626');
INSERT INTO `admin_op_log` VALUES ('1146', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451529356188');
INSERT INTO `admin_op_log` VALUES ('1147', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451530099915');
INSERT INTO `admin_op_log` VALUES ('1148', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451530153492');
INSERT INTO `admin_op_log` VALUES ('1149', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451530288311');
INSERT INTO `admin_op_log` VALUES ('1150', '48', '1', '/frontLogin', 'id为48的用户陈印泉登陆系统', '1451530350942');
INSERT INTO `admin_op_log` VALUES ('1151', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451530465270');
INSERT INTO `admin_op_log` VALUES ('1152', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451530415944');
INSERT INTO `admin_op_log` VALUES ('1153', '48', '1', '/frontLogin', 'id为48的用户陈印泉登陆系统', '1451530476734');
INSERT INTO `admin_op_log` VALUES ('1154', '167', '1', '/frontLogin', 'id为167的用户王宝强@黄渤登陆系统', '1451530551536');
INSERT INTO `admin_op_log` VALUES ('1155', '166', '1', '/frontLogin', 'id为166的用户晁天王登陆系统', '1451530642045');
INSERT INTO `admin_op_log` VALUES ('1156', '54', '1', '/frontLogin', 'id为54的用户切勿登陆系统', '1451530658308');
INSERT INTO `admin_op_log` VALUES ('1157', '45', '1', '/frontLogin', 'id为45的用户镇元大仙1登陆系统', '1451530725420');
INSERT INTO `admin_op_log` VALUES ('1158', '45', '1', '/adminLogin', '用户镇元大仙1登陆系统', '1451530975603');
INSERT INTO `admin_op_log` VALUES ('1159', '167', '1', '/adminLogin', '用户王宝强@黄渤登陆系统', '1451531014063');
INSERT INTO `admin_op_log` VALUES ('1160', '45', '1', '/frontLogin', 'id为45的用户镇元大仙1登陆系统', '1451531060614');

-- ----------------------------
-- Table structure for base_company
-- ----------------------------
DROP TABLE IF EXISTS `base_company`;
CREATE TABLE `base_company` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '公司名',
  `industry_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '1正常2注销3禁用',
  `create_time` bigint(20) DEFAULT NULL,
  `company_logo` bigint(20) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `update_time` bigint(20) DEFAULT NULL,
  `province_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `district_id` int(11) DEFAULT NULL,
  `addr` varchar(255) DEFAULT NULL,
  `contact_user` varchar(255) DEFAULT NULL,
  `tel` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_log` (`company_logo`),
  KEY `fk_zip_province` (`province_id`),
  KEY `fk_zip_city` (`city_id`),
  KEY `fk_zip_area` (`district_id`),
  CONSTRAINT `fk_company_log` FOREIGN KEY (`company_logo`) REFERENCES `oa_file` (`id`),
  CONSTRAINT `fk_zip_area` FOREIGN KEY (`district_id`) REFERENCES `base_zip` (`id`),
  CONSTRAINT `fk_zip_city` FOREIGN KEY (`city_id`) REFERENCES `base_zip` (`id`),
  CONSTRAINT `fk_zip_province` FOREIGN KEY (`province_id`) REFERENCES `base_zip` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of base_company
-- ----------------------------
INSERT INTO `base_company` VALUES ('5', '测试公司1', null, '1', '1450157525223', null, '5', '1450875364555', null, null, null, null, null, null);
INSERT INTO `base_company` VALUES ('8', '华山派', '3', '2', '1450572682102', null, '42', null, '1356', '1405', null, null, '令狐冲', null);
INSERT INTO `base_company` VALUES ('9', '少林寺', '2', '2', '1450574552765', null, '43', null, '1651', '1666', null, null, '李连杰', null);
INSERT INTO `base_company` VALUES ('10', '武当山', '1', '3', '1450585704035', null, '44', null, '1845', '1894', null, null, '冲虚道长', null);
INSERT INTO `base_company` VALUES ('11', '万寿山五庄观', '1', '3', '1450586023515', null, '45', null, '1001', '1067', null, null, '镇元大仙', null);
INSERT INTO `base_company` VALUES ('12', '德云社', '4', '3', '1450594448067', null, '46', null, '230', '243', null, null, '郭德纲', null);
INSERT INTO `base_company` VALUES ('13', '锦衣卫', '4', '3', '1450595208661', null, '47', null, '1479', '1492', null, null, '甄子丹', null);
INSERT INTO `base_company` VALUES ('14', '嘻哈包袱铺', '1', '3', '1450595648589', null, '48', null, '1651', '1773', null, null, '陈印泉', null);
INSERT INTO `base_company` VALUES ('15', '春熙路', '3', '3', '1450597088937', null, '49', null, '2459', '1222', null, null, '杨过', null);
INSERT INTO `base_company` VALUES ('16', '寻龙诀', '3', '3', '1450597430109', null, '50', null, '1479', '1608', null, null, '胡八一', null);
INSERT INTO `base_company` VALUES ('17', '国际金融中心', '2', '3', '1450597759623', null, '51', null, '2498', '2499', null, null, '李宗盛', null);
INSERT INTO `base_company` VALUES ('18', '纱帽街北站', '3', '3', '1450599008380', null, '52', null, '1252', '1297', null, null, '哈哈', null);
INSERT INTO `base_company` VALUES ('19', '若翼java后台开发', '1', '3', '1450661001144', null, '53', null, '1651', '1831', null, null, '何文均', null);
INSERT INTO `base_company` VALUES ('20', '阿么nvxie', null, '1', '1450755233928', null, '53', '1450926006921', null, null, null, null, '何文均', null);
INSERT INTO `base_company` VALUES ('21', '卖女鞋到阿么2', null, '1', '1450755914835', null, '53', '1450790206585', null, null, null, null, '何文均', null);
INSERT INTO `base_company` VALUES ('22', '大阿萨德', null, '1', '1450853021399', null, '54', '1450952487820', null, null, null, null, '切勿', null);
INSERT INTO `base_company` VALUES ('23', '若翼', null, '1', '1450854391292', null, '54', null, null, null, null, null, '切勿', null);
INSERT INTO `base_company` VALUES ('24', '花果山水帘洞', null, '1', '1450872500042', null, '74', null, null, null, null, null, 'zss', null);
INSERT INTO `base_company` VALUES ('25', '四川', null, '1', '1450872847789', null, '75', null, null, null, null, null, '周星星', null);
INSERT INTO `base_company` VALUES ('26', '若翼网络', null, '1', '1450875901229', null, '42', '1450877872510', null, null, null, null, '令狐冲', null);
INSERT INTO `base_company` VALUES ('27', '狮驼山', null, '1', '1450919462525', null, '96', null, null, null, null, null, '灞波儿奔', null);
INSERT INTO `base_company` VALUES ('28', '若翼网络', null, '1', '1450920439399', null, '44', '1450924695816', null, null, null, null, '冲虚道长', null);
INSERT INTO `base_company` VALUES ('29', '阿么商城', null, '1', '1450920533812', null, '44', '1450924964353', null, null, null, null, '冲虚道长', null);
INSERT INTO `base_company` VALUES ('30', 'java开发2', null, '1', '1450921223143', null, '44', null, null, null, null, null, '冲虚道长', null);
INSERT INTO `base_company` VALUES ('31', '唐伯虎', null, '1', '1450929353074', null, '122', null, null, null, null, null, 'superman', null);
INSERT INTO `base_company` VALUES ('32', '鬼吹灯', null, '1', '1450954263917', null, '159', null, null, null, null, null, 'shieryYang', null);
INSERT INTO `base_company` VALUES ('33', '花果山水帘洞1', null, '1', '1450956377013', null, '162', null, null, null, null, null, '齐天大圣', null);
INSERT INTO `base_company` VALUES ('34', '梁山泊', null, '1', '1451027573860', null, '166', null, null, null, null, null, '立地太岁', null);
INSERT INTO `base_company` VALUES ('35', '阿么', null, '1', '1451294498431', null, '54', null, null, null, null, null, '切勿', null);
INSERT INTO `base_company` VALUES ('36', 'XXX公司', null, '1', '1451379724648', null, '45', null, null, null, null, null, '镇元大仙1', null);
INSERT INTO `base_company` VALUES ('37', 'rqwrewrewr', null, '1', '1451381780630', null, '33', null, null, null, null, null, '周星星i', null);
INSERT INTO `base_company` VALUES ('38', '泰囧', null, '1', '1451467690936', null, '167', null, null, null, null, null, '王宝强@黄渤', null);
INSERT INTO `base_company` VALUES ('39', '韩囧', null, '1', '1451474234503', null, '167', null, null, null, null, null, '王宝强@黄渤', null);

-- ----------------------------
-- Table structure for base_company_dept
-- ----------------------------
DROP TABLE IF EXISTS `base_company_dept`;
CREATE TABLE `base_company_dept` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `company_id` bigint(11) DEFAULT NULL,
  `dept_order` int(11) NOT NULL,
  `level` int(11) DEFAULT '1' COMMENT '层级，1为顶部部门',
  `status` int(11) DEFAULT '1' COMMENT '1正常2删除',
  `parent_id` int(11) DEFAULT '0' COMMENT '0为顶级部门，',
  `create_time` bigint(20) DEFAULT NULL,
  `update_time` bigint(20) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_company_com_id` (`company_id`),
  KEY `fk_company_user_id` (`creator_id`),
  CONSTRAINT `fk_company_com_id` FOREIGN KEY (`company_id`) REFERENCES `base_company` (`id`),
  CONSTRAINT `fk_company_user_id` FOREIGN KEY (`creator_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of base_company_dept
-- ----------------------------
INSERT INTO `base_company_dept` VALUES ('83', 'java开发', '5', '0', null, '1', '0', '1450568300462', '1450864009045', '5');
INSERT INTO `base_company_dept` VALUES ('84', 'iOS研发部1', '5', '0', null, '1', '83', '1450568491806', '1450875223686', '5');
INSERT INTO `base_company_dept` VALUES ('85', '阿萨德', '11', '0', null, '1', '83', '1450568886602', '1450568919452', '5');
INSERT INTO `base_company_dept` VALUES ('86', '人事部', '18', '0', null, '1', '0', '1450569165912', '1450570544447', '5');
INSERT INTO `base_company_dept` VALUES ('87', '阿萨德2', '10', '0', null, '1', '0', '1450661709168', '1450662729333', '53');
INSERT INTO `base_company_dept` VALUES ('88', '好好干', '23', '0', null, '1', '0', '1450748272242', '1451015749111', '53');
INSERT INTO `base_company_dept` VALUES ('89', '水电费对方是个', '13', '0', null, '1', '0', '1450748521698', null, '53');
INSERT INTO `base_company_dept` VALUES ('96', '开发部1', '20', '0', null, '1', null, '1450788075034', '1450875042845', '53');
INSERT INTO `base_company_dept` VALUES ('99', '阿萨德', '23', '0', null, '1', null, '1450854472091', null, '54');
INSERT INTO `base_company_dept` VALUES ('100', '餐饮部', '24', '0', null, '1', null, '1450864225622', null, '5');
INSERT INTO `base_company_dept` VALUES ('101', 'java', '26', '0', null, '1', null, '1450876036159', '1450877361225', '42');
INSERT INTO `base_company_dept` VALUES ('102', '采购部1', '26', '0', null, '2', null, '1450876285825', '1450877709495', '42');
INSERT INTO `base_company_dept` VALUES ('105', '财务部', '26', '0', null, '1', null, '1450877309152', '1450879121276', '42');
INSERT INTO `base_company_dept` VALUES ('106', '研发部', '28', '0', null, '1', null, '1450920545047', '1450924824827', '44');
INSERT INTO `base_company_dept` VALUES ('107', '采购部', '28', '0', null, '1', null, '1450921368116', '1450924850119', '44');
INSERT INTO `base_company_dept` VALUES ('108', '人力资源部', '29', '0', null, '1', null, '1450925016977', '1450925050671', '44');
INSERT INTO `base_company_dept` VALUES ('109', '好好干', '22', '0', null, '1', null, '1450955837486', '1450955859046', '54');
INSERT INTO `base_company_dept` VALUES ('110', '泰囧一部', '38', '0', null, '1', null, '1451472466602', '1451475965526', '167');
INSERT INTO `base_company_dept` VALUES ('111', '泰囧二部', '38', '0', null, '1', null, '1451473398739', null, '167');
INSERT INTO `base_company_dept` VALUES ('113', '韩囧一部', '39', '0', null, '1', null, '1451474352724', null, '167');

-- ----------------------------
-- Table structure for base_company_user
-- ----------------------------
DROP TABLE IF EXISTS `base_company_user`;
CREATE TABLE `base_company_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `company_id` bigint(20) NOT NULL,
  `dept_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT '职位',
  `role_id` int(11) NOT NULL,
  `create_time` bigint(20) DEFAULT NULL,
  `update_time` bigint(20) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_com_user_com_id` (`company_id`),
  KEY `fk_com_user_user_id` (`user_id`),
  KEY `fk_com_user_dept_id` (`dept_id`),
  CONSTRAINT `fk_com_user_com_id` FOREIGN KEY (`company_id`) REFERENCES `base_company` (`id`),
  CONSTRAINT `fk_com_user_dept_id` FOREIGN KEY (`dept_id`) REFERENCES `base_company_dept` (`id`),
  CONSTRAINT `fk_com_user_user_id` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of base_company_user
-- ----------------------------
INSERT INTO `base_company_user` VALUES ('19', '30', '5', '84', '没有', '1', '1450568593288', '1450875157689', '5');
INSERT INTO `base_company_user` VALUES ('21', '32', '5', '84', 'qwe', '3', '1450568978324', '1450875223728', '5');
INSERT INTO `base_company_user` VALUES ('22', '33', '5', '85', '搞笑我们是专业的', '1', '1450569016292', '1450662534013', '5');
INSERT INTO `base_company_user` VALUES ('28', '53', '21', null, '二姨太', '1', '1450755914935', '1450929440103', '53');
INSERT INTO `base_company_user` VALUES ('30', '54', '22', '109', 'sd ', '2', '1450853021455', '1451026357033', '54');
INSERT INTO `base_company_user` VALUES ('31', '54', '23', '99', 'hj', '2', '1450854391326', '1451026500059', '54');
INSERT INTO `base_company_user` VALUES ('33', '45', '5', null, '麻瓜2', '1', '1450863645222', '1450873596959', '5');
INSERT INTO `base_company_user` VALUES ('34', '46', '5', '86', '安徽', '1', '1450863882110', '1450870258475', '5');
INSERT INTO `base_company_user` VALUES ('35', '47', '5', '84', '12345', '1', '1450864252201', '1450870053844', '5');
INSERT INTO `base_company_user` VALUES ('38', '45', '21', null, '若翼返回', '1', '1450874961029', '1450928985713', '53');
INSERT INTO `base_company_user` VALUES ('39', '42', '26', '105', '主管', '1', '1450875901233', '1450877405528', '42');
INSERT INTO `base_company_user` VALUES ('40', '45', '26', '101', '到时候', '1', '1450876172934', '1450876328470', '42');
INSERT INTO `base_company_user` VALUES ('41', '46', '26', null, null, '1', '1450876222707', null, '42');
INSERT INTO `base_company_user` VALUES ('42', '78', '5', '83', null, '1', '1450876903883', null, '78');
INSERT INTO `base_company_user` VALUES ('43', '80', '5', '83', null, '1', '1450877428654', null, '80');
INSERT INTO `base_company_user` VALUES ('44', '47', '26', null, null, '3', '1450877384750', '1450877419244', '42');
INSERT INTO `base_company_user` VALUES ('45', '48', '26', '105', '对方删除', '3', '1450877504663', '1450879121324', '42');
INSERT INTO `base_company_user` VALUES ('46', '81', '5', '84', null, '1', '1450877669611', null, '81');
INSERT INTO `base_company_user` VALUES ('47', '82', '5', '84', null, '1', '1450877796957', null, '82');
INSERT INTO `base_company_user` VALUES ('48', '96', '27', null, null, '2', '1450919462600', null, '96');
INSERT INTO `base_company_user` VALUES ('53', '44', '30', null, null, '0', '1450921223217', null, '44');
INSERT INTO `base_company_user` VALUES ('54', '47', '28', '107', '的', '3', '1450921325779', '1450924850197', '44');
INSERT INTO `base_company_user` VALUES ('55', '46', '28', '107', '二', '1', '1450921380941', '1450921925318', '44');
INSERT INTO `base_company_user` VALUES ('56', '48', '28', null, null, '0', '1450921875670', null, '44');
INSERT INTO `base_company_user` VALUES ('57', '121', '5', '84', null, '1', '1450924725881', null, '121');
INSERT INTO `base_company_user` VALUES ('58', '47', '21', null, null, '0', '1450926469011', null, '53');
INSERT INTO `base_company_user` VALUES ('59', '122', '31', null, null, '2', '1450929353184', null, '122');
INSERT INTO `base_company_user` VALUES ('60', '48', '20', null, null, '0', '1450929494690', null, '53');
INSERT INTO `base_company_user` VALUES ('61', '123', '5', '83', null, '1', '1450929738570', null, '123');
INSERT INTO `base_company_user` VALUES ('62', '124', '5', '83', null, '1', '1450942340452', null, '124');
INSERT INTO `base_company_user` VALUES ('63', '125', '5', '83', null, '1', '1450942891136', null, '125');
INSERT INTO `base_company_user` VALUES ('64', '126', '5', '83', null, '1', '1450943072485', null, '126');
INSERT INTO `base_company_user` VALUES ('65', '49', '26', '105', null, '0', '1450944525129', null, '42');
INSERT INTO `base_company_user` VALUES ('66', '127', '5', '83', null, '1', '1450945441579', null, '127');
INSERT INTO `base_company_user` VALUES ('67', '129', '26', '105', null, '1', '1450947547017', null, '129');
INSERT INTO `base_company_user` VALUES ('68', '152', '5', null, null, '1', '1450951854899', null, '152');
INSERT INTO `base_company_user` VALUES ('69', '155', '8', null, null, '1', '1450952191604', null, '155');
INSERT INTO `base_company_user` VALUES ('72', '158', '5', null, null, '1', '1450953984491', null, '158');
INSERT INTO `base_company_user` VALUES ('73', '159', '32', null, null, '2', '1450954263932', null, '159');
INSERT INTO `base_company_user` VALUES ('74', '162', '33', null, null, '2', '1450956377046', null, '162');
INSERT INTO `base_company_user` VALUES ('75', '163', '33', null, null, '1', '1450956515243', null, '163');
INSERT INTO `base_company_user` VALUES ('76', '164', '5', '84', null, '1', '1450956615828', null, '164');
INSERT INTO `base_company_user` VALUES ('77', '45', '23', '88', null, '0', '1450956596573', null, '54');
INSERT INTO `base_company_user` VALUES ('78', '47', '23', '99', null, '0', '1450956652953', null, '54');
INSERT INTO `base_company_user` VALUES ('80', '165', '5', null, null, '1', '1450956883955', '1451007540959', '165');
INSERT INTO `base_company_user` VALUES ('81', '166', '34', null, '老板', '2', '1451027573906', null, '166');
INSERT INTO `base_company_user` VALUES ('84', '54', '35', null, null, '2', '1451294498434', null, '54');
INSERT INTO `base_company_user` VALUES ('86', '33', '37', null, null, '2', '1451381780671', null, '33');
INSERT INTO `base_company_user` VALUES ('87', '167', '38', null, '嘿不GV从', '2', '1451467690979', '1451476019127', '167');
INSERT INTO `base_company_user` VALUES ('89', '167', '39', null, '撒', '2', '1451474234506', '1451474365568', '167');
INSERT INTO `base_company_user` VALUES ('91', '46', '38', '110', 'kl', '1', '1451475878933', '1451475948366', '167');
INSERT INTO `base_company_user` VALUES ('92', '45', '39', null, 'r', '1', '1451476281904', '1451476406098', '167');
INSERT INTO `base_company_user` VALUES ('93', '47', '39', null, null, '0', '1451477116270', null, '167');
INSERT INTO `base_company_user` VALUES ('94', '48', '39', null, null, '0', '1451477146134', null, '167');

-- ----------------------------
-- Table structure for base_industry
-- ----------------------------
DROP TABLE IF EXISTS `base_industry`;
CREATE TABLE `base_industry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of base_industry
-- ----------------------------
INSERT INTO `base_industry` VALUES ('1', '农、林、牧、渔业');
INSERT INTO `base_industry` VALUES ('2', '信息传输、软件和信息技术服务业');
INSERT INTO `base_industry` VALUES ('3', '金融业');
INSERT INTO `base_industry` VALUES ('4', '服务业');

-- ----------------------------
-- Table structure for base_role
-- ----------------------------
DROP TABLE IF EXISTS `base_role`;
CREATE TABLE `base_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT '1' COMMENT '1员工2公司管理员3部门管理员4系统平台管理员',
  `create_time` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of base_role
-- ----------------------------
INSERT INTO `base_role` VALUES ('1', '员工', null, '1');
INSERT INTO `base_role` VALUES ('2', '公司管理员', null, '1');
INSERT INTO `base_role` VALUES ('3', '部门管理员', null, '1');
INSERT INTO `base_role` VALUES ('4', '平台管理员', null, '1');

-- ----------------------------
-- Table structure for base_user
-- ----------------------------
DROP TABLE IF EXISTS `base_user`;
CREATE TABLE `base_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(20) DEFAULT NULL,
  `pwd` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `province` int(11) DEFAULT NULL,
  `city` int(11) DEFAULT NULL,
  `area` int(11) DEFAULT NULL,
  `create_time` bigint(20) NOT NULL,
  `update_time` bigint(20) DEFAULT NULL,
  `head_img` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT NULL COMMENT '1正常2禁用3未激活',
  PRIMARY KEY (`id`),
  KEY `fk_user_head_id` (`head_img`),
  CONSTRAINT `fk_user_head_id` FOREIGN KEY (`head_img`) REFERENCES `oa_file` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of base_user
-- ----------------------------
INSERT INTO `base_user` VALUES ('5', null, '96e79218965eb72c92a549dd5a330112', '张三', '1234561@qq.com', null, null, null, '1450261627257', null, null, '1');
INSERT INTO `base_user` VALUES ('28', '13512345678', 'e10adc3949ba59abbe56e057f20f883e', '张大炮', '1234562@qq.com', null, null, null, '1450568343233', '1450568474867', null, '3');
INSERT INTO `base_user` VALUES ('29', '13512345678', 'e10adc3949ba59abbe56e057f20f883e', '李四', '1234563@qq.com', null, null, null, '1450568550310', '1450569261540', null, '3');
INSERT INTO `base_user` VALUES ('30', '18812345678', 'e10adc3949ba59abbe56e057f20f883e', '王五', 'ww@qq.com', null, null, null, '1450568593279', '1450875157680', null, '3');
INSERT INTO `base_user` VALUES ('31', '18888889912', 'e10adc3949ba59abbe56e057f20f883e', '王麻子', 'ww22w@q.cv', null, null, null, '1450568700821', '1450568712787', null, '3');
INSERT INTO `base_user` VALUES ('32', '18812345678', 'e10adc3949ba59abbe56e057f20f883e', '秦莞尔', '1@qq.com', null, null, null, '1450568978314', '1450869966287', null, '3');
INSERT INTO `base_user` VALUES ('33', '18312342567', '96e79218965eb72c92a549dd5a330112', '周星星i', 'www@q.cv', null, null, null, '1450569016206', '1450662534003', null, '1');
INSERT INTO `base_user` VALUES ('34', '18812345678', 'e10adc3949ba59abbe56e057f20f883e', '大毛', '1234356@qq.com', null, null, null, '1450569113052', null, null, '3');
INSERT INTO `base_user` VALUES ('35', '18812345678', 'e10adc3949ba59abbe56e057f20f883e', '二毛', '1234256@qq.aa', null, null, null, '1450569134627', '1450662161623', null, '3');
INSERT INTO `base_user` VALUES ('37', '13512345678', 'e10adc3949ba59abbe56e057f20f883e', '三毛', 'www@q.cv', null, null, null, '1450569683116', null, null, '3');
INSERT INTO `base_user` VALUES ('38', '18812345678', 'e10adc3949ba59abbe56e057f20f883e', '四毛', 'www@q.cf', null, null, null, '1450570129573', '1450670702371', null, '3');
INSERT INTO `base_user` VALUES ('42', '13999999999', '96e79218965eb72c92a549dd5a330112', '令狐冲', '13999999999@139.com', '1356', '1405', null, '1450572681992', '1450877405507', null, '1');
INSERT INTO `base_user` VALUES ('43', '13888888888', '96e79218965eb72c92a549dd5a330112', '李连杰', '13888888888@139.com', '1651', '1666', null, '1450574552644', null, null, '3');
INSERT INTO `base_user` VALUES ('44', '14780491871', '96e79218965eb72c92a549dd5a330112', '冲虚道长', '14780491874@139.com', '1845', '1894', null, '1450585703954', '1450920599138', null, '1');
INSERT INTO `base_user` VALUES ('45', '13900000000', '96e79218965eb72c92a549dd5a330112', '镇元大仙1', 'notification@todayoffice.cn', '1001', '1067', null, '1450586023442', '1451476406090', null, '1');
INSERT INTO `base_user` VALUES ('46', '13111111111', '1bbd886460827015e5d605ed44252251', '太极', 'ruoy2i_te2st1@sina.com', '230', '243', null, '1450594447976', '1451475948361', null, '1');
INSERT INTO `base_user` VALUES ('47', '13222222222', '1bbd886460827015e5d605ed44252251', '甄子丹', 'ru2oyi_te2st1@sina.com', '1479', '1492', null, '1450595208520', '1450921902352', null, '1');
INSERT INTO `base_user` VALUES ('48', '18999999999', '96e79218965eb72c92a549dd5a330112', '陈印泉', 'ru3oyi_te2st1@sina.com', '1651', '1773', null, '1450595648488', '1450879115715', null, '1');
INSERT INTO `base_user` VALUES ('49', '13777777777', 'bae5e3208a3c700e3db642b6631e95b9', '杨过', 'ru4oyi_te2st1@sina.com', '2459', '1222', null, '1450597088816', null, null, '1');
INSERT INTO `base_user` VALUES ('50', '15200000000', 'd27d320c27c3033b7883347d8beca317', '胡八一', 'ru6oyi_te2st1@sina.com', '1479', '1608', null, '1450597430038', null, null, '3');
INSERT INTO `base_user` VALUES ('51', '14788888888', 'e3ceb5881a0a1fdaad01296d7554868d', '李宗盛', 'ru7oyi_te2st1@sina.com', '2498', '2499', null, '1450597759483', null, null, '1');
INSERT INTO `base_user` VALUES ('52', '13888888888', '48776ea3bd34f9995a1c3e71cd61870d', '哈哈', 'ru9oyi_te2st1@sina.com', '1252', '1297', null, '1450599008286', null, null, '1');
INSERT INTO `base_user` VALUES ('53', '14780491872', 'e3ceb5881a0a1fdaad01296d7554868d', '何文均', '54534128@qq.com', '1651', '1831', null, '1450661000993', '1450929440106', null, '1');
INSERT INTO `base_user` VALUES ('54', '13512349978', '96e79218965eb72c92a549dd5a330112', '切勿', '1234156@qq.com', null, null, null, '1450663834651', '1451113501683', null, '1');
INSERT INTO `base_user` VALUES ('56', '18815978632', '96e79218965eb72c92a549dd5a330112', 'a到时候', '123456@qq.com', null, null, null, '1450766336418', null, null, '3');
INSERT INTO `base_user` VALUES ('71', '14780491374', '96e79218965eb72c92a549dd5a330112', 'zss', null, null, null, null, '1450871886088', null, null, '1');
INSERT INTO `base_user` VALUES ('72', '13466666666', '96e79218965eb72c92a549dd5a330112', 'wqe', null, null, null, null, '1450872264541', null, null, '1');
INSERT INTO `base_user` VALUES ('73', '15877777777', 'e3ceb5881a0a1fdaad01296d7554868d', '222', null, null, null, null, '1450872403077', null, null, '1');
INSERT INTO `base_user` VALUES ('74', '14780491873', '96e79218965eb72c92a549dd5a330112', 'zss', null, null, null, null, '1450872488747', null, null, '1');
INSERT INTO `base_user` VALUES ('75', '13221111111', '96e79218965eb72c92a549dd5a330112', '周星星', null, null, null, null, '1450872832523', null, null, '1');
INSERT INTO `base_user` VALUES ('76', '14780491832', '96e79218965eb72c92a549dd5a330112', '周星驰', null, null, null, null, '1450874797366', null, null, '1');
INSERT INTO `base_user` VALUES ('77', '13568888888', 'e3ceb5881a0a1fdaad01296d7554868d', '孙猴子', null, null, null, null, '1450874893965', null, null, '1');
INSERT INTO `base_user` VALUES ('78', '13244444444', '1a100d2c0dab19c4430e7d73762b3423', '猪八戒', null, null, null, null, '1450876896241', null, null, '1');
INSERT INTO `base_user` VALUES ('79', '15688888888', 'b857eed5c9405c1f2b98048aae506792', '沙悟净', null, null, null, null, '1450877210455', null, null, '1');
INSERT INTO `base_user` VALUES ('80', '15695555555', '5b1b68a9abf4d2cd155c81a9225fd158', '和尚', null, null, null, null, '1450877422060', null, null, '1');
INSERT INTO `base_user` VALUES ('81', '15755555555', 'dd4380f850c9a0139b63e1874db34230', '白骨精', null, null, null, null, '1450877645694', null, null, '1');
INSERT INTO `base_user` VALUES ('82', '15987777777', 'e3ceb5881a0a1fdaad01296d7554868d', '女儿国', null, null, null, null, '1450877779393', null, null, '1');
INSERT INTO `base_user` VALUES ('83', '13985555555', 'dc0fa7df3d07904a09288bd2d2bb5f40', '张无忌', null, null, null, null, '1450877994600', null, null, '1');
INSERT INTO `base_user` VALUES ('84', '18900000000', 'd27d320c27c3033b7883347d8beca317', '罗永浩', null, null, null, null, '1450878178040', null, null, '1');
INSERT INTO `base_user` VALUES ('85', '15834343434', '96e79218965eb72c92a549dd5a330112', '无厘头', null, null, null, null, '1450878302700', null, null, '1');
INSERT INTO `base_user` VALUES ('86', '13655555555', '1a100d2c0dab19c4430e7d73762b3423', '麻辣烫', null, null, null, null, '1450878505805', null, null, '1');
INSERT INTO `base_user` VALUES ('87', '13563333333', 'f63f4fbc9f8c85d409f2f59f2b9e12d5', '老板', null, null, null, null, '1450878748665', null, null, '1');
INSERT INTO `base_user` VALUES ('88', '13455555555', 'e3ceb5881a0a1fdaad01296d7554868d', '勺子', null, null, null, null, '1450879328931', null, null, '1');
INSERT INTO `base_user` VALUES ('89', '13525252777', 'e3ceb5881a0a1fdaad01296d7554868d', 'aa', null, null, null, null, '1450879523323', null, null, '1');
INSERT INTO `base_user` VALUES ('90', '13211222222', '1a100d2c0dab19c4430e7d73762b3423', '3', null, null, null, null, '1450879653733', null, null, '1');
INSERT INTO `base_user` VALUES ('91', '13573737373', '96e79218965eb72c92a549dd5a330112', '3243', null, null, null, null, '1450880023282', null, null, '1');
INSERT INTO `base_user` VALUES ('92', '13588777777', '96e79218965eb72c92a549dd5a330112', '2132', null, null, null, null, '1450880261473', null, null, '1');
INSERT INTO `base_user` VALUES ('93', '15869999933', 'e3ceb5881a0a1fdaad01296d7554868d', '3213', null, null, null, null, '1450880328711', null, null, '1');
INSERT INTO `base_user` VALUES ('94', '13455444444', 'd27d320c27c3033b7883347d8beca317', '4', null, null, null, null, '1450880563867', null, null, '1');
INSERT INTO `base_user` VALUES ('95', '15874111111', '96e79218965eb72c92a549dd5a330112', '奔波儿灞', null, null, null, null, '1450919065696', null, null, '1');
INSERT INTO `base_user` VALUES ('96', '15634444444', '96e79218965eb72c92a549dd5a330112', '灞波儿奔', null, null, null, null, '1450919448737', null, null, '1');
INSERT INTO `base_user` VALUES ('97', '13290000000', '96e79218965eb72c92a549dd5a330112', '金角大王', null, null, null, null, '1450919513545', null, null, '1');
INSERT INTO `base_user` VALUES ('98', '13857777777', 'e3ceb5881a0a1fdaad01296d7554868d', '银角大王', null, null, null, null, '1450919662993', null, null, '1');
INSERT INTO `base_user` VALUES ('99', '14875555555', 'e3ceb5881a0a1fdaad01296d7554868d', '东方不败', null, null, null, null, '1450919784960', null, null, '1');
INSERT INTO `base_user` VALUES ('100', '13524444444', '1a100d2c0dab19c4430e7d73762b3423', '牛魔王', null, null, null, null, '1450919871818', null, null, '1');
INSERT INTO `base_user` VALUES ('101', '13254666666', '96e79218965eb72c92a549dd5a330112', '铁扇公主', null, null, null, null, '1450920113892', null, null, '1');
INSERT INTO `base_user` VALUES ('102', '18477777777', '1a100d2c0dab19c4430e7d73762b3423', '444444', null, null, null, null, '1450920236493', null, null, '1');
INSERT INTO `base_user` VALUES ('103', '13865555555', '5b1b68a9abf4d2cd155c81a9225fd158', '红孩儿', null, null, null, null, '1450920502761', null, null, '1');
INSERT INTO `base_user` VALUES ('104', '13658777777', '96e79218965eb72c92a549dd5a330112', '太上老君', null, null, null, null, '1450920665187', null, null, '1');
INSERT INTO `base_user` VALUES ('105', '13589999933', '96e79218965eb72c92a549dd5a330112', '牛大', null, null, null, null, '1450920790197', null, null, '1');
INSERT INTO `base_user` VALUES ('106', '13548887777', '96e79218965eb72c92a549dd5a330112', '晁天王', null, null, null, null, '1450920998350', null, null, '1');
INSERT INTO `base_user` VALUES ('107', '13788855555', '96e79218965eb72c92a549dd5a330112', '423423', null, null, null, null, '1450922253454', null, null, '1');
INSERT INTO `base_user` VALUES ('108', '13231222222', '96e79218965eb72c92a549dd5a330112', '545341434', null, null, null, null, '1450922539687', null, null, '1');
INSERT INTO `base_user` VALUES ('109', '13454211111', '96e79218965eb72c92a549dd5a330112', '112', null, null, null, null, '1450922746522', null, null, '1');
INSERT INTO `base_user` VALUES ('110', '13424555555', '96e79218965eb72c92a549dd5a330112', '343', null, null, null, null, '1450922960992', null, null, '1');
INSERT INTO `base_user` VALUES ('111', '13321111111', '5b1b68a9abf4d2cd155c81a9225fd158', '4', null, null, null, null, '1450923039965', null, null, '1');
INSERT INTO `base_user` VALUES ('112', '13455443221', '96e79218965eb72c92a549dd5a330112', '455', null, null, null, null, '1450923365836', null, null, '1');
INSERT INTO `base_user` VALUES ('113', '13548965755', '96e79218965eb72c92a549dd5a330112', '55', null, null, null, null, '1450923536398', null, null, '1');
INSERT INTO `base_user` VALUES ('114', '13746746462', '5b1b68a9abf4d2cd155c81a9225fd158', '55', null, null, null, null, '1450923609806', null, null, '1');
INSERT INTO `base_user` VALUES ('115', '13588987882', '96e79218965eb72c92a549dd5a330112', '5466', null, null, null, null, '1450923716095', null, null, '1');
INSERT INTO `base_user` VALUES ('116', '13765456578', '96e79218965eb72c92a549dd5a330112', '5453412', null, null, null, null, '1450923880253', null, null, '1');
INSERT INTO `base_user` VALUES ('117', '13422211111', '96e79218965eb72c92a549dd5a330112', '5453', null, null, null, null, '1450923956648', null, null, '1');
INSERT INTO `base_user` VALUES ('118', '13212233333', '96e79218965eb72c92a549dd5a330112', '5434', null, null, null, null, '1450924020459', null, null, '1');
INSERT INTO `base_user` VALUES ('119', '14333333333', '96e79218965eb72c92a549dd5a330112', '45', null, null, null, null, '1450924162520', null, null, '1');
INSERT INTO `base_user` VALUES ('120', '14477777777', '96e79218965eb72c92a549dd5a330112', '666', null, null, null, null, '1450924310428', null, null, '1');
INSERT INTO `base_user` VALUES ('121', '13587965412', 'e3ceb5881a0a1fdaad01296d7554868d', '测试成功', null, null, null, null, '1450924709254', null, null, '1');
INSERT INTO `base_user` VALUES ('122', '14780391874', '96e79218965eb72c92a549dd5a330112', 'superman', null, null, null, null, '1450929339170', null, null, '1');
INSERT INTO `base_user` VALUES ('123', null, '96e79218965eb72c92a549dd5a330112', '祝枝山', 'ruoyi_tes3t1@sina.com', null, null, null, '1450929716635', null, null, '1');
INSERT INTO `base_user` VALUES ('124', '14780491890', '5b1b68a9abf4d2cd155c81a9225fd158', '叫你一声你敢答应吗', null, null, null, null, '1450942340341', null, null, '1');
INSERT INTO `base_user` VALUES ('125', '14780491889', '1a100d2c0dab19c4430e7d73762b3423', '宋江', null, null, null, null, '1450942890975', null, null, '1');
INSERT INTO `base_user` VALUES ('126', '13287452145', '5b1b68a9abf4d2cd155c81a9225fd158', '运城宋押司', null, null, null, null, '1450943072304', null, null, '1');
INSERT INTO `base_user` VALUES ('127', '13243434343', 'e3ceb5881a0a1fdaad01296d7554868d', '赤脚大仙', null, null, null, null, '1450945441488', null, null, '1');
INSERT INTO `base_user` VALUES ('128', '14755855578', 'e3ceb5881a0a1fdaad01296d7554868d', '3213', null, null, null, null, '1450946945462', null, null, '1');
INSERT INTO `base_user` VALUES ('129', '13540752062', '96e79218965eb72c92a549dd5a330112', '二蛋', null, null, null, null, '1450947546876', null, null, '1');
INSERT INTO `base_user` VALUES ('152', '14780391874', '96e79218965eb72c92a549dd5a330112', '张三链子', null, null, null, null, '1450951825646', null, null, '1');
INSERT INTO `base_user` VALUES ('155', '14780491811', '96e79218965eb72c92a549dd5a330112', '胡八一', null, null, null, null, '1450952183758', null, null, '1');
INSERT INTO `base_user` VALUES ('158', '14780491874', '96e79218965eb72c92a549dd5a330112', '摸金校尉', null, null, null, null, '1450953979973', null, null, '1');
INSERT INTO `base_user` VALUES ('159', '14780491812', '96e79218965eb72c92a549dd5a330112', 'shieryYang', null, null, null, null, '1450954256245', null, null, '1');
INSERT INTO `base_user` VALUES ('160', '13587456214', '96e79218965eb72c92a549dd5a330112', '在注册公司前退出', null, null, null, null, '1450955835539', null, null, '3');
INSERT INTO `base_user` VALUES ('161', '13533332222', '96e79218965eb72c92a549dd5a330112', '曹操', null, null, null, null, '1450956127155', null, null, '4');
INSERT INTO `base_user` VALUES ('162', '13574847474', '96e79218965eb72c92a549dd5a330112', '齐天大圣', null, null, null, null, '1450956295522', null, null, '1');
INSERT INTO `base_user` VALUES ('163', '13244445332', '96e79218965eb72c92a549dd5a330112', '和尚2', null, null, null, null, '1450956479457', null, null, '1');
INSERT INTO `base_user` VALUES ('164', '13876838383', '96e79218965eb72c92a549dd5a330112', '女儿国', null, null, null, null, '1450956598386', null, null, '1');
INSERT INTO `base_user` VALUES ('165', null, '96e79218965eb72c92a549dd5a330112', '和大牛', 'jack9527521@qq.com', null, null, null, '1450956878219', null, null, '1');
INSERT INTO `base_user` VALUES ('166', '13432333332', '96e79218965eb72c92a549dd5a330112', '晁天王', 'ruoyi_tes33t1@sina.com', null, null, null, '1451027561361', '1451377426425', '7', '1');
INSERT INTO `base_user` VALUES ('167', null, '96e79218965eb72c92a549dd5a330112', '王宝强@黄渤', '964097953@qq.com', null, null, null, '1451467657327', '1451476019129', null, '1');

-- ----------------------------
-- Table structure for base_zip
-- ----------------------------
DROP TABLE IF EXISTS `base_zip`;
CREATE TABLE `base_zip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(40) DEFAULT NULL,
  `province` varchar(40) DEFAULT NULL,
  `city` varchar(40) DEFAULT NULL,
  `district` varchar(40) DEFAULT NULL,
  `parent` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3929 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of base_zip
-- ----------------------------
INSERT INTO `base_zip` VALUES ('1', '000000', '中华人民共和国', '', '', '0');
INSERT INTO `base_zip` VALUES ('2', '110000', '北京市', '', '', '1');
INSERT INTO `base_zip` VALUES ('3', '110101', '', '', '东城区', '3925');
INSERT INTO `base_zip` VALUES ('4', '110102', '', '', '西城区', '3925');
INSERT INTO `base_zip` VALUES ('5', '110105', '', '', '朝阳区', '3925');
INSERT INTO `base_zip` VALUES ('6', '110106', '', '', '丰台区', '3925');
INSERT INTO `base_zip` VALUES ('7', '110107', '', '', '石景山区', '3925');
INSERT INTO `base_zip` VALUES ('8', '110108', '', '', '海淀区', '3925');
INSERT INTO `base_zip` VALUES ('9', '110109', '', '', '门头沟区', '3925');
INSERT INTO `base_zip` VALUES ('10', '110111', '', '', '房山区', '3925');
INSERT INTO `base_zip` VALUES ('11', '110112', '', '', '通州区', '3925');
INSERT INTO `base_zip` VALUES ('12', '110113', '', '', '顺义区', '3925');
INSERT INTO `base_zip` VALUES ('13', '110114', '', '', '昌平区', '3925');
INSERT INTO `base_zip` VALUES ('14', '110115', '', '', '大兴区', '3925');
INSERT INTO `base_zip` VALUES ('15', '110116', '', '', '怀柔区', '3925');
INSERT INTO `base_zip` VALUES ('16', '110117', '', '', '平谷区', '3925');
INSERT INTO `base_zip` VALUES ('17', '110228', '', '', '密云县', '3925');
INSERT INTO `base_zip` VALUES ('18', '110229', '', '', '延庆县', '3925');
INSERT INTO `base_zip` VALUES ('19', '120000', '天津市', '天津市', '', '1');
INSERT INTO `base_zip` VALUES ('20', '120101', '', '', '和平区', '3926');
INSERT INTO `base_zip` VALUES ('21', '120102', '', '', '河东区', '3926');
INSERT INTO `base_zip` VALUES ('22', '120103', '', '', '河西区', '3926');
INSERT INTO `base_zip` VALUES ('23', '120104', '', '', '南开区', '3926');
INSERT INTO `base_zip` VALUES ('24', '120105', '', '', '河北区', '3926');
INSERT INTO `base_zip` VALUES ('25', '120106', '', '', '红桥区', '3926');
INSERT INTO `base_zip` VALUES ('26', '120110', '', '', '东丽区', '3926');
INSERT INTO `base_zip` VALUES ('27', '120111', '', '', '西青区', '3926');
INSERT INTO `base_zip` VALUES ('28', '120112', '', '', '津南区', '3926');
INSERT INTO `base_zip` VALUES ('29', '120113', '', '', '北辰区', '3926');
INSERT INTO `base_zip` VALUES ('30', '120114', '', '', '武清区', '3926');
INSERT INTO `base_zip` VALUES ('31', '120115', '', '', '宝坻区', '3926');
INSERT INTO `base_zip` VALUES ('32', '120116', '', '', '滨海新区', '3926');
INSERT INTO `base_zip` VALUES ('33', '120221', '', '', '宁河县', '3926');
INSERT INTO `base_zip` VALUES ('34', '120223', '', '', '静海县', '3926');
INSERT INTO `base_zip` VALUES ('35', '120225', '', '', '蓟县', '19');
INSERT INTO `base_zip` VALUES ('36', '130000', '河北省', '', '', '1');
INSERT INTO `base_zip` VALUES ('37', '130100', '', '石家庄市', '', '36');
INSERT INTO `base_zip` VALUES ('38', '130101', '', '', '市辖区', '37');
INSERT INTO `base_zip` VALUES ('39', '130102', '', '', '长安区', '37');
INSERT INTO `base_zip` VALUES ('40', '130104', '', '', '桥西区', '37');
INSERT INTO `base_zip` VALUES ('41', '130105', '', '', '新华区', '37');
INSERT INTO `base_zip` VALUES ('42', '130107', '', '', '井陉矿区', '37');
INSERT INTO `base_zip` VALUES ('43', '130108', '', '', '裕华区', '37');
INSERT INTO `base_zip` VALUES ('44', '130109', '', '', '藁城区', '37');
INSERT INTO `base_zip` VALUES ('45', '130110', '', '', '鹿泉区', '37');
INSERT INTO `base_zip` VALUES ('46', '130111', '', '', '栾城区', '37');
INSERT INTO `base_zip` VALUES ('47', '130121', '', '', '井陉县', '37');
INSERT INTO `base_zip` VALUES ('48', '130123', '', '', '正定县', '37');
INSERT INTO `base_zip` VALUES ('49', '130125', '', '', '行唐县', '37');
INSERT INTO `base_zip` VALUES ('50', '130126', '', '', '灵寿县', '37');
INSERT INTO `base_zip` VALUES ('51', '130127', '', '', '高邑县', '37');
INSERT INTO `base_zip` VALUES ('52', '130128', '', '', '深泽县', '37');
INSERT INTO `base_zip` VALUES ('53', '130129', '', '', '赞皇县', '37');
INSERT INTO `base_zip` VALUES ('54', '130130', '', '', '无极县', '37');
INSERT INTO `base_zip` VALUES ('55', '130131', '', '', '平山县', '37');
INSERT INTO `base_zip` VALUES ('56', '130132', '', '', '元氏县', '37');
INSERT INTO `base_zip` VALUES ('57', '130133', '', '', '赵县', '37');
INSERT INTO `base_zip` VALUES ('58', '130181', '', '', '辛集市', '37');
INSERT INTO `base_zip` VALUES ('59', '130183', '', '', '晋州市', '37');
INSERT INTO `base_zip` VALUES ('60', '130184', '', '', '新乐市', '37');
INSERT INTO `base_zip` VALUES ('61', '130200', '', '唐山市', '', '36');
INSERT INTO `base_zip` VALUES ('62', '130201', '', '', '市辖区', '61');
INSERT INTO `base_zip` VALUES ('63', '130202', '', '', '路南区', '61');
INSERT INTO `base_zip` VALUES ('64', '130203', '', '', '路北区', '61');
INSERT INTO `base_zip` VALUES ('65', '130204', '', '', '古冶区', '61');
INSERT INTO `base_zip` VALUES ('66', '130205', '', '', '开平区', '61');
INSERT INTO `base_zip` VALUES ('67', '130207', '', '', '丰南区', '61');
INSERT INTO `base_zip` VALUES ('68', '130208', '', '', '丰润区', '61');
INSERT INTO `base_zip` VALUES ('69', '130209', '', '', '曹妃甸区', '61');
INSERT INTO `base_zip` VALUES ('70', '130223', '', '', '滦县', '61');
INSERT INTO `base_zip` VALUES ('71', '130224', '', '', '滦南县', '61');
INSERT INTO `base_zip` VALUES ('72', '130225', '', '', '乐亭县', '61');
INSERT INTO `base_zip` VALUES ('73', '130227', '', '', '迁西县', '61');
INSERT INTO `base_zip` VALUES ('74', '130229', '', '', '玉田县', '61');
INSERT INTO `base_zip` VALUES ('75', '130281', '', '', '遵化市', '61');
INSERT INTO `base_zip` VALUES ('76', '130283', '', '', '迁安市', '61');
INSERT INTO `base_zip` VALUES ('77', '130300', '', '秦皇岛市', '', '36');
INSERT INTO `base_zip` VALUES ('78', '130301', '', '', '市辖区', '77');
INSERT INTO `base_zip` VALUES ('79', '130302', '', '', '海港区', '77');
INSERT INTO `base_zip` VALUES ('80', '130303', '', '', '山海关区', '77');
INSERT INTO `base_zip` VALUES ('81', '130304', '', '', '北戴河区', '77');
INSERT INTO `base_zip` VALUES ('82', '130321', '', '', '青龙满族自治县', '77');
INSERT INTO `base_zip` VALUES ('83', '130322', '', '', '昌黎县', '77');
INSERT INTO `base_zip` VALUES ('84', '130323', '', '', '抚宁县', '77');
INSERT INTO `base_zip` VALUES ('85', '130324', '', '', '卢龙县', '77');
INSERT INTO `base_zip` VALUES ('86', '130400', '', '邯郸市', '', '36');
INSERT INTO `base_zip` VALUES ('87', '130401', '', '', '市辖区', '86');
INSERT INTO `base_zip` VALUES ('88', '130402', '', '', '邯山区', '86');
INSERT INTO `base_zip` VALUES ('89', '130403', '', '', '丛台区', '86');
INSERT INTO `base_zip` VALUES ('90', '130404', '', '', '复兴区', '86');
INSERT INTO `base_zip` VALUES ('91', '130406', '', '', '峰峰矿区', '86');
INSERT INTO `base_zip` VALUES ('92', '130421', '', '', '邯郸县', '86');
INSERT INTO `base_zip` VALUES ('93', '130423', '', '', '临漳县', '86');
INSERT INTO `base_zip` VALUES ('94', '130424', '', '', '成安县', '86');
INSERT INTO `base_zip` VALUES ('95', '130425', '', '', '大名县', '86');
INSERT INTO `base_zip` VALUES ('96', '130426', '', '', '涉县', '86');
INSERT INTO `base_zip` VALUES ('97', '130427', '', '', '磁县', '86');
INSERT INTO `base_zip` VALUES ('98', '130428', '', '', '肥乡县', '86');
INSERT INTO `base_zip` VALUES ('99', '130429', '', '', '永年县', '86');
INSERT INTO `base_zip` VALUES ('100', '130430', '', '', '邱县', '86');
INSERT INTO `base_zip` VALUES ('101', '130431', '', '', '鸡泽县', '86');
INSERT INTO `base_zip` VALUES ('102', '130432', '', '', '广平县', '86');
INSERT INTO `base_zip` VALUES ('103', '130433', '', '', '馆陶县', '86');
INSERT INTO `base_zip` VALUES ('104', '130434', '', '', '魏县', '86');
INSERT INTO `base_zip` VALUES ('105', '130435', '', '', '曲周县', '86');
INSERT INTO `base_zip` VALUES ('106', '130481', '', '', '武安市', '86');
INSERT INTO `base_zip` VALUES ('107', '130500', '', '邢台市', '', '36');
INSERT INTO `base_zip` VALUES ('108', '130501', '', '', '市辖区', '107');
INSERT INTO `base_zip` VALUES ('109', '130502', '', '', '桥东区', '107');
INSERT INTO `base_zip` VALUES ('110', '130503', '', '', '桥西区', '107');
INSERT INTO `base_zip` VALUES ('111', '130521', '', '', '邢台县', '107');
INSERT INTO `base_zip` VALUES ('112', '130522', '', '', '临城县', '107');
INSERT INTO `base_zip` VALUES ('113', '130523', '', '', '内丘县', '107');
INSERT INTO `base_zip` VALUES ('114', '130524', '', '', '柏乡县', '107');
INSERT INTO `base_zip` VALUES ('115', '130525', '', '', '隆尧县', '107');
INSERT INTO `base_zip` VALUES ('116', '130526', '', '', '任县', '107');
INSERT INTO `base_zip` VALUES ('117', '130527', '', '', '南和县', '107');
INSERT INTO `base_zip` VALUES ('118', '130528', '', '', '宁晋县', '107');
INSERT INTO `base_zip` VALUES ('119', '130529', '', '', '巨鹿县', '107');
INSERT INTO `base_zip` VALUES ('120', '130530', '', '', '新河县', '107');
INSERT INTO `base_zip` VALUES ('121', '130531', '', '', '广宗县', '107');
INSERT INTO `base_zip` VALUES ('122', '130532', '', '', '平乡县', '107');
INSERT INTO `base_zip` VALUES ('123', '130533', '', '', '威县', '107');
INSERT INTO `base_zip` VALUES ('124', '130534', '', '', '清河县', '107');
INSERT INTO `base_zip` VALUES ('125', '130535', '', '', '临西县', '107');
INSERT INTO `base_zip` VALUES ('126', '130581', '', '', '南宫市', '107');
INSERT INTO `base_zip` VALUES ('127', '130582', '', '', '沙河市', '107');
INSERT INTO `base_zip` VALUES ('128', '130600', '', '保定市', '', '36');
INSERT INTO `base_zip` VALUES ('129', '130601', '', '', '市辖区', '128');
INSERT INTO `base_zip` VALUES ('130', '130602', '', '', '新市区', '128');
INSERT INTO `base_zip` VALUES ('131', '130603', '', '', '北市区', '128');
INSERT INTO `base_zip` VALUES ('132', '130604', '', '', '南市区', '128');
INSERT INTO `base_zip` VALUES ('133', '130621', '', '', '满城县', '128');
INSERT INTO `base_zip` VALUES ('134', '130622', '', '', '清苑县', '128');
INSERT INTO `base_zip` VALUES ('135', '130623', '', '', '涞水县', '128');
INSERT INTO `base_zip` VALUES ('136', '130624', '', '', '阜平县', '128');
INSERT INTO `base_zip` VALUES ('137', '130625', '', '', '徐水县', '128');
INSERT INTO `base_zip` VALUES ('138', '130626', '', '', '定兴县', '128');
INSERT INTO `base_zip` VALUES ('139', '130627', '', '', '唐县', '128');
INSERT INTO `base_zip` VALUES ('140', '130628', '', '', '高阳县', '128');
INSERT INTO `base_zip` VALUES ('141', '130629', '', '', '容城县', '128');
INSERT INTO `base_zip` VALUES ('142', '130630', '', '', '涞源县', '128');
INSERT INTO `base_zip` VALUES ('143', '130631', '', '', '望都县', '128');
INSERT INTO `base_zip` VALUES ('144', '130632', '', '', '安新县', '128');
INSERT INTO `base_zip` VALUES ('145', '130633', '', '', '易县', '128');
INSERT INTO `base_zip` VALUES ('146', '130634', '', '', '曲阳县', '128');
INSERT INTO `base_zip` VALUES ('147', '130635', '', '', '蠡县', '128');
INSERT INTO `base_zip` VALUES ('148', '130636', '', '', '顺平县', '128');
INSERT INTO `base_zip` VALUES ('149', '130637', '', '', '博野县', '128');
INSERT INTO `base_zip` VALUES ('150', '130638', '', '', '雄县', '128');
INSERT INTO `base_zip` VALUES ('151', '130681', '', '', '涿州市', '128');
INSERT INTO `base_zip` VALUES ('152', '130682', '', '', '定州市', '128');
INSERT INTO `base_zip` VALUES ('153', '130683', '', '', '安国市', '128');
INSERT INTO `base_zip` VALUES ('154', '130684', '', '', '高碑店市', '128');
INSERT INTO `base_zip` VALUES ('155', '130700', '', '张家口市', '', '36');
INSERT INTO `base_zip` VALUES ('156', '130701', '', '', '市辖区', '155');
INSERT INTO `base_zip` VALUES ('157', '130702', '', '', '桥东区', '155');
INSERT INTO `base_zip` VALUES ('158', '130703', '', '', '桥西区', '155');
INSERT INTO `base_zip` VALUES ('159', '130705', '', '', '宣化区', '155');
INSERT INTO `base_zip` VALUES ('160', '130706', '', '', '下花园区', '155');
INSERT INTO `base_zip` VALUES ('161', '130721', '', '', '宣化县', '155');
INSERT INTO `base_zip` VALUES ('162', '130722', '', '', '张北县', '155');
INSERT INTO `base_zip` VALUES ('163', '130723', '', '', '康保县', '155');
INSERT INTO `base_zip` VALUES ('164', '130724', '', '', '沽源县', '155');
INSERT INTO `base_zip` VALUES ('165', '130725', '', '', '尚义县', '155');
INSERT INTO `base_zip` VALUES ('166', '130726', '', '', '蔚县', '155');
INSERT INTO `base_zip` VALUES ('167', '130727', '', '', '阳原县', '155');
INSERT INTO `base_zip` VALUES ('168', '130728', '', '', '怀安县', '155');
INSERT INTO `base_zip` VALUES ('169', '130729', '', '', '万全县', '155');
INSERT INTO `base_zip` VALUES ('170', '130730', '', '', '怀来县', '155');
INSERT INTO `base_zip` VALUES ('171', '130731', '', '', '涿鹿县', '155');
INSERT INTO `base_zip` VALUES ('172', '130732', '', '', '赤城县', '155');
INSERT INTO `base_zip` VALUES ('173', '130733', '', '', '崇礼县', '155');
INSERT INTO `base_zip` VALUES ('174', '130800', '', '承德市', '', '36');
INSERT INTO `base_zip` VALUES ('175', '130801', '', '', '市辖区', '174');
INSERT INTO `base_zip` VALUES ('176', '130802', '', '', '双桥区', '174');
INSERT INTO `base_zip` VALUES ('177', '130803', '', '', '双滦区', '174');
INSERT INTO `base_zip` VALUES ('178', '130804', '', '', '鹰手营子矿区', '174');
INSERT INTO `base_zip` VALUES ('179', '130821', '', '', '承德县', '174');
INSERT INTO `base_zip` VALUES ('180', '130822', '', '', '兴隆县', '174');
INSERT INTO `base_zip` VALUES ('181', '130823', '', '', '平泉县', '174');
INSERT INTO `base_zip` VALUES ('182', '130824', '', '', '滦平县', '174');
INSERT INTO `base_zip` VALUES ('183', '130825', '', '', '隆化县', '174');
INSERT INTO `base_zip` VALUES ('184', '130826', '', '', '丰宁满族自治县', '174');
INSERT INTO `base_zip` VALUES ('185', '130827', '', '', '宽城满族自治县', '174');
INSERT INTO `base_zip` VALUES ('186', '130828', '', '', '围场满族蒙古族自治县', '174');
INSERT INTO `base_zip` VALUES ('187', '130900', '', '沧州市', '', '36');
INSERT INTO `base_zip` VALUES ('188', '130901', '', '', '市辖区', '187');
INSERT INTO `base_zip` VALUES ('189', '130902', '', '', '新华区', '187');
INSERT INTO `base_zip` VALUES ('190', '130903', '', '', '运河区', '187');
INSERT INTO `base_zip` VALUES ('191', '130921', '', '', '沧县', '187');
INSERT INTO `base_zip` VALUES ('192', '130922', '', '', '青县', '187');
INSERT INTO `base_zip` VALUES ('193', '130923', '', '', '东光县', '187');
INSERT INTO `base_zip` VALUES ('194', '130924', '', '', '海兴县', '187');
INSERT INTO `base_zip` VALUES ('195', '130925', '', '', '盐山县', '187');
INSERT INTO `base_zip` VALUES ('196', '130926', '', '', '肃宁县', '187');
INSERT INTO `base_zip` VALUES ('197', '130927', '', '', '南皮县', '187');
INSERT INTO `base_zip` VALUES ('198', '130928', '', '', '吴桥县', '187');
INSERT INTO `base_zip` VALUES ('199', '130929', '', '', '献县', '187');
INSERT INTO `base_zip` VALUES ('200', '130930', '', '', '孟村回族自治县', '187');
INSERT INTO `base_zip` VALUES ('201', '130981', '', '', '泊头市', '187');
INSERT INTO `base_zip` VALUES ('202', '130982', '', '', '任丘市', '187');
INSERT INTO `base_zip` VALUES ('203', '130983', '', '', '黄骅市', '187');
INSERT INTO `base_zip` VALUES ('204', '130984', '', '', '河间市', '187');
INSERT INTO `base_zip` VALUES ('205', '131000', '', '廊坊市', '', '36');
INSERT INTO `base_zip` VALUES ('206', '131001', '', '', '市辖区', '205');
INSERT INTO `base_zip` VALUES ('207', '131002', '', '', '安次区', '205');
INSERT INTO `base_zip` VALUES ('208', '131003', '', '', '广阳区', '205');
INSERT INTO `base_zip` VALUES ('209', '131022', '', '', '固安县', '205');
INSERT INTO `base_zip` VALUES ('210', '131023', '', '', '永清县', '205');
INSERT INTO `base_zip` VALUES ('211', '131024', '', '', '香河县', '205');
INSERT INTO `base_zip` VALUES ('212', '131025', '', '', '大城县', '205');
INSERT INTO `base_zip` VALUES ('213', '131026', '', '', '文安县', '205');
INSERT INTO `base_zip` VALUES ('214', '131028', '', '', '大厂回族自治县', '205');
INSERT INTO `base_zip` VALUES ('215', '131081', '', '', '霸州市', '205');
INSERT INTO `base_zip` VALUES ('216', '131082', '', '', '三河市', '205');
INSERT INTO `base_zip` VALUES ('217', '131100', '', '衡水市', '', '36');
INSERT INTO `base_zip` VALUES ('218', '131101', '', '', '市辖区', '217');
INSERT INTO `base_zip` VALUES ('219', '131102', '', '', '桃城区', '217');
INSERT INTO `base_zip` VALUES ('220', '131121', '', '', '枣强县', '217');
INSERT INTO `base_zip` VALUES ('221', '131122', '', '', '武邑县', '217');
INSERT INTO `base_zip` VALUES ('222', '131123', '', '', '武强县', '217');
INSERT INTO `base_zip` VALUES ('223', '131124', '', '', '饶阳县', '217');
INSERT INTO `base_zip` VALUES ('224', '131125', '', '', '安平县', '217');
INSERT INTO `base_zip` VALUES ('225', '131126', '', '', '故城县', '217');
INSERT INTO `base_zip` VALUES ('226', '131127', '', '', '景县', '217');
INSERT INTO `base_zip` VALUES ('227', '131128', '', '', '阜城县', '217');
INSERT INTO `base_zip` VALUES ('228', '131181', '', '', '冀州市', '217');
INSERT INTO `base_zip` VALUES ('229', '131182', '', '', '深州市', '217');
INSERT INTO `base_zip` VALUES ('230', '140000', '山西省', '', '', '1');
INSERT INTO `base_zip` VALUES ('231', '140100', '', '太原市', '', '230');
INSERT INTO `base_zip` VALUES ('232', '140101', '', '', '市辖区', '231');
INSERT INTO `base_zip` VALUES ('233', '140105', '', '', '小店区', '231');
INSERT INTO `base_zip` VALUES ('234', '140106', '', '', '迎泽区', '231');
INSERT INTO `base_zip` VALUES ('235', '140107', '', '', '杏花岭区', '231');
INSERT INTO `base_zip` VALUES ('236', '140108', '', '', '尖草坪区', '231');
INSERT INTO `base_zip` VALUES ('237', '140109', '', '', '万柏林区', '231');
INSERT INTO `base_zip` VALUES ('238', '140110', '', '', '晋源区', '231');
INSERT INTO `base_zip` VALUES ('239', '140121', '', '', '清徐县', '231');
INSERT INTO `base_zip` VALUES ('240', '140122', '', '', '阳曲县', '231');
INSERT INTO `base_zip` VALUES ('241', '140123', '', '', '娄烦县', '231');
INSERT INTO `base_zip` VALUES ('242', '140181', '', '', '古交市', '231');
INSERT INTO `base_zip` VALUES ('243', '140200', '', '大同市', '', '230');
INSERT INTO `base_zip` VALUES ('244', '140201', '', '', '市辖区', '243');
INSERT INTO `base_zip` VALUES ('245', '140202', '', '', '城区', '243');
INSERT INTO `base_zip` VALUES ('246', '140203', '', '', '矿区', '243');
INSERT INTO `base_zip` VALUES ('247', '140211', '', '', '南郊区', '243');
INSERT INTO `base_zip` VALUES ('248', '140212', '', '', '新荣区', '243');
INSERT INTO `base_zip` VALUES ('249', '140221', '', '', '阳高县', '243');
INSERT INTO `base_zip` VALUES ('250', '140222', '', '', '天镇县', '243');
INSERT INTO `base_zip` VALUES ('251', '140223', '', '', '广灵县', '243');
INSERT INTO `base_zip` VALUES ('252', '140224', '', '', '灵丘县', '243');
INSERT INTO `base_zip` VALUES ('253', '140225', '', '', '浑源县', '243');
INSERT INTO `base_zip` VALUES ('254', '140226', '', '', '左云县', '243');
INSERT INTO `base_zip` VALUES ('255', '140227', '', '', '大同县', '243');
INSERT INTO `base_zip` VALUES ('256', '140300', '', '阳泉市', '', '230');
INSERT INTO `base_zip` VALUES ('257', '140301', '', '', '市辖区', '256');
INSERT INTO `base_zip` VALUES ('258', '140302', '', '', '城区', '256');
INSERT INTO `base_zip` VALUES ('259', '140303', '', '', '矿区', '256');
INSERT INTO `base_zip` VALUES ('260', '140311', '', '', '郊区', '256');
INSERT INTO `base_zip` VALUES ('261', '140321', '', '', '平定县', '256');
INSERT INTO `base_zip` VALUES ('262', '140322', '', '', '盂县', '256');
INSERT INTO `base_zip` VALUES ('263', '140400', '', '长治市', '', '230');
INSERT INTO `base_zip` VALUES ('264', '140401', '', '', '市辖区', '263');
INSERT INTO `base_zip` VALUES ('265', '140402', '', '', '城区', '263');
INSERT INTO `base_zip` VALUES ('266', '140411', '', '', '郊区', '263');
INSERT INTO `base_zip` VALUES ('267', '140421', '', '', '长治县', '263');
INSERT INTO `base_zip` VALUES ('268', '140423', '', '', '襄垣县', '263');
INSERT INTO `base_zip` VALUES ('269', '140424', '', '', '屯留县', '263');
INSERT INTO `base_zip` VALUES ('270', '140425', '', '', '平顺县', '263');
INSERT INTO `base_zip` VALUES ('271', '140426', '', '', '黎城县', '263');
INSERT INTO `base_zip` VALUES ('272', '140427', '', '', '壶关县', '263');
INSERT INTO `base_zip` VALUES ('273', '140428', '', '', '长子县', '263');
INSERT INTO `base_zip` VALUES ('274', '140429', '', '', '武乡县', '263');
INSERT INTO `base_zip` VALUES ('275', '140430', '', '', '沁县', '263');
INSERT INTO `base_zip` VALUES ('276', '140431', '', '', '沁源县', '263');
INSERT INTO `base_zip` VALUES ('277', '140481', '', '', '潞城市', '263');
INSERT INTO `base_zip` VALUES ('278', '140500', '', '晋城市', '', '230');
INSERT INTO `base_zip` VALUES ('279', '140501', '', '', '市辖区', '278');
INSERT INTO `base_zip` VALUES ('280', '140502', '', '', '城区', '278');
INSERT INTO `base_zip` VALUES ('281', '140521', '', '', '沁水县', '278');
INSERT INTO `base_zip` VALUES ('282', '140522', '', '', '阳城县', '278');
INSERT INTO `base_zip` VALUES ('283', '140524', '', '', '陵川县', '278');
INSERT INTO `base_zip` VALUES ('284', '140525', '', '', '泽州县', '278');
INSERT INTO `base_zip` VALUES ('285', '140581', '', '', '高平市', '278');
INSERT INTO `base_zip` VALUES ('286', '140600', '', '朔州市', '', '230');
INSERT INTO `base_zip` VALUES ('287', '140601', '', '', '市辖区', '286');
INSERT INTO `base_zip` VALUES ('288', '140602', '', '', '朔城区', '286');
INSERT INTO `base_zip` VALUES ('289', '140603', '', '', '平鲁区', '286');
INSERT INTO `base_zip` VALUES ('290', '140621', '', '', '山阴县', '286');
INSERT INTO `base_zip` VALUES ('291', '140622', '', '', '应县', '286');
INSERT INTO `base_zip` VALUES ('292', '140623', '', '', '右玉县', '286');
INSERT INTO `base_zip` VALUES ('293', '140624', '', '', '怀仁县', '286');
INSERT INTO `base_zip` VALUES ('294', '140700', '', '晋中市', '', '230');
INSERT INTO `base_zip` VALUES ('295', '140701', '', '', '市辖区', '294');
INSERT INTO `base_zip` VALUES ('296', '140702', '', '', '榆次区', '294');
INSERT INTO `base_zip` VALUES ('297', '140721', '', '', '榆社县', '294');
INSERT INTO `base_zip` VALUES ('298', '140722', '', '', '左权县', '294');
INSERT INTO `base_zip` VALUES ('299', '140723', '', '', '和顺县', '294');
INSERT INTO `base_zip` VALUES ('300', '140724', '', '', '昔阳县', '294');
INSERT INTO `base_zip` VALUES ('301', '140725', '', '', '寿阳县', '294');
INSERT INTO `base_zip` VALUES ('302', '140726', '', '', '太谷县', '294');
INSERT INTO `base_zip` VALUES ('303', '140727', '', '', '祁县', '294');
INSERT INTO `base_zip` VALUES ('304', '140728', '', '', '平遥县', '294');
INSERT INTO `base_zip` VALUES ('305', '140729', '', '', '灵石县', '294');
INSERT INTO `base_zip` VALUES ('306', '140781', '', '', '介休市', '294');
INSERT INTO `base_zip` VALUES ('307', '140800', '', '运城市', '', '230');
INSERT INTO `base_zip` VALUES ('308', '140801', '', '', '市辖区', '307');
INSERT INTO `base_zip` VALUES ('309', '140802', '', '', '盐湖区', '307');
INSERT INTO `base_zip` VALUES ('310', '140821', '', '', '临猗县', '307');
INSERT INTO `base_zip` VALUES ('311', '140822', '', '', '万荣县', '307');
INSERT INTO `base_zip` VALUES ('312', '140823', '', '', '闻喜县', '307');
INSERT INTO `base_zip` VALUES ('313', '140824', '', '', '稷山县', '307');
INSERT INTO `base_zip` VALUES ('314', '140825', '', '', '新绛县', '307');
INSERT INTO `base_zip` VALUES ('315', '140826', '', '', '绛县', '307');
INSERT INTO `base_zip` VALUES ('316', '140827', '', '', '垣曲县', '307');
INSERT INTO `base_zip` VALUES ('317', '140828', '', '', '夏县', '307');
INSERT INTO `base_zip` VALUES ('318', '140829', '', '', '平陆县', '307');
INSERT INTO `base_zip` VALUES ('319', '140830', '', '', '芮城县', '307');
INSERT INTO `base_zip` VALUES ('320', '140881', '', '', '永济市', '307');
INSERT INTO `base_zip` VALUES ('321', '140882', '', '', '河津市', '307');
INSERT INTO `base_zip` VALUES ('322', '140900', '', '忻州市', '', '230');
INSERT INTO `base_zip` VALUES ('323', '140901', '', '', '市辖区', '322');
INSERT INTO `base_zip` VALUES ('324', '140902', '', '', '忻府区', '322');
INSERT INTO `base_zip` VALUES ('325', '140921', '', '', '定襄县', '322');
INSERT INTO `base_zip` VALUES ('326', '140922', '', '', '五台县', '322');
INSERT INTO `base_zip` VALUES ('327', '140923', '', '', '代县', '322');
INSERT INTO `base_zip` VALUES ('328', '140924', '', '', '繁峙县', '322');
INSERT INTO `base_zip` VALUES ('329', '140925', '', '', '宁武县', '322');
INSERT INTO `base_zip` VALUES ('330', '140926', '', '', '静乐县', '322');
INSERT INTO `base_zip` VALUES ('331', '140927', '', '', '神池县', '322');
INSERT INTO `base_zip` VALUES ('332', '140928', '', '', '五寨县', '322');
INSERT INTO `base_zip` VALUES ('333', '140929', '', '', '岢岚县', '322');
INSERT INTO `base_zip` VALUES ('334', '140930', '', '', '河曲县', '322');
INSERT INTO `base_zip` VALUES ('335', '140931', '', '', '保德县', '322');
INSERT INTO `base_zip` VALUES ('336', '140932', '', '', '偏关县', '322');
INSERT INTO `base_zip` VALUES ('337', '140981', '', '', '原平市', '322');
INSERT INTO `base_zip` VALUES ('338', '141000', '', '临汾市', '', '230');
INSERT INTO `base_zip` VALUES ('339', '141001', '', '', '市辖区', '338');
INSERT INTO `base_zip` VALUES ('340', '141002', '', '', '尧都区', '338');
INSERT INTO `base_zip` VALUES ('341', '141021', '', '', '曲沃县', '338');
INSERT INTO `base_zip` VALUES ('342', '141022', '', '', '翼城县', '338');
INSERT INTO `base_zip` VALUES ('343', '141023', '', '', '襄汾县', '338');
INSERT INTO `base_zip` VALUES ('344', '141024', '', '', '洪洞县', '338');
INSERT INTO `base_zip` VALUES ('345', '141025', '', '', '古县', '338');
INSERT INTO `base_zip` VALUES ('346', '141026', '', '', '安泽县', '338');
INSERT INTO `base_zip` VALUES ('347', '141027', '', '', '浮山县', '338');
INSERT INTO `base_zip` VALUES ('348', '141028', '', '', '吉县', '338');
INSERT INTO `base_zip` VALUES ('349', '141029', '', '', '乡宁县', '338');
INSERT INTO `base_zip` VALUES ('350', '141030', '', '', '大宁县', '338');
INSERT INTO `base_zip` VALUES ('351', '141031', '', '', '隰县', '338');
INSERT INTO `base_zip` VALUES ('352', '141032', '', '', '永和县', '338');
INSERT INTO `base_zip` VALUES ('353', '141033', '', '', '蒲县', '338');
INSERT INTO `base_zip` VALUES ('354', '141034', '', '', '汾西县', '338');
INSERT INTO `base_zip` VALUES ('355', '141081', '', '', '侯马市', '338');
INSERT INTO `base_zip` VALUES ('356', '141082', '', '', '霍州市', '338');
INSERT INTO `base_zip` VALUES ('357', '141100', '', '吕梁市', '', '230');
INSERT INTO `base_zip` VALUES ('358', '141101', '', '', '市辖区', '357');
INSERT INTO `base_zip` VALUES ('359', '141102', '', '', '离石区', '357');
INSERT INTO `base_zip` VALUES ('360', '141121', '', '', '文水县', '357');
INSERT INTO `base_zip` VALUES ('361', '141122', '', '', '交城县', '357');
INSERT INTO `base_zip` VALUES ('362', '141123', '', '', '兴县', '357');
INSERT INTO `base_zip` VALUES ('363', '141124', '', '', '临县', '357');
INSERT INTO `base_zip` VALUES ('364', '141125', '', '', '柳林县', '357');
INSERT INTO `base_zip` VALUES ('365', '141126', '', '', '石楼县', '357');
INSERT INTO `base_zip` VALUES ('366', '141127', '', '', '岚县', '357');
INSERT INTO `base_zip` VALUES ('367', '141128', '', '', '方山县', '357');
INSERT INTO `base_zip` VALUES ('368', '141129', '', '', '中阳县', '357');
INSERT INTO `base_zip` VALUES ('369', '141130', '', '', '交口县', '357');
INSERT INTO `base_zip` VALUES ('370', '141181', '', '', '孝义市', '357');
INSERT INTO `base_zip` VALUES ('371', '141182', '', '', '汾阳市', '357');
INSERT INTO `base_zip` VALUES ('372', '150000', '内蒙古自治区', '', '', '1');
INSERT INTO `base_zip` VALUES ('373', '150100', '', '呼和浩特市', '', '372');
INSERT INTO `base_zip` VALUES ('374', '150101', '', '', '市辖区', '373');
INSERT INTO `base_zip` VALUES ('375', '150102', '', '', '新城区', '373');
INSERT INTO `base_zip` VALUES ('376', '150103', '', '', '回民区', '373');
INSERT INTO `base_zip` VALUES ('377', '150104', '', '', '玉泉区', '373');
INSERT INTO `base_zip` VALUES ('378', '150105', '', '', '赛罕区', '373');
INSERT INTO `base_zip` VALUES ('379', '150121', '', '', '土默特左旗', '373');
INSERT INTO `base_zip` VALUES ('380', '150122', '', '', '托克托县', '373');
INSERT INTO `base_zip` VALUES ('381', '150123', '', '', '和林格尔县', '373');
INSERT INTO `base_zip` VALUES ('382', '150124', '', '', '清水河县', '373');
INSERT INTO `base_zip` VALUES ('383', '150125', '', '', '武川县', '373');
INSERT INTO `base_zip` VALUES ('384', '150200', '', '包头市', '', '372');
INSERT INTO `base_zip` VALUES ('385', '150201', '', '', '市辖区', '384');
INSERT INTO `base_zip` VALUES ('386', '150202', '', '', '东河区', '384');
INSERT INTO `base_zip` VALUES ('387', '150203', '', '', '昆都仑区', '384');
INSERT INTO `base_zip` VALUES ('388', '150204', '', '', '青山区', '384');
INSERT INTO `base_zip` VALUES ('389', '150205', '', '', '石拐区', '384');
INSERT INTO `base_zip` VALUES ('390', '150206', '', '', '白云鄂博矿区', '384');
INSERT INTO `base_zip` VALUES ('391', '150207', '', '', '九原区', '384');
INSERT INTO `base_zip` VALUES ('392', '150221', '', '', '土默特右旗', '384');
INSERT INTO `base_zip` VALUES ('393', '150222', '', '', '固阳县', '384');
INSERT INTO `base_zip` VALUES ('394', '150223', '', '', '达尔罕茂明安联合旗', '384');
INSERT INTO `base_zip` VALUES ('395', '150300', '', '乌海市', '', '372');
INSERT INTO `base_zip` VALUES ('396', '150301', '', '', '市辖区', '395');
INSERT INTO `base_zip` VALUES ('397', '150302', '', '', '海勃湾区', '395');
INSERT INTO `base_zip` VALUES ('398', '150303', '', '', '海南区', '395');
INSERT INTO `base_zip` VALUES ('399', '150304', '', '', '乌达区', '395');
INSERT INTO `base_zip` VALUES ('400', '150400', '', '赤峰市', '', '372');
INSERT INTO `base_zip` VALUES ('401', '150401', '', '', '市辖区', '400');
INSERT INTO `base_zip` VALUES ('402', '150402', '', '', '红山区', '400');
INSERT INTO `base_zip` VALUES ('403', '150403', '', '', '元宝山区', '400');
INSERT INTO `base_zip` VALUES ('404', '150404', '', '', '松山区', '400');
INSERT INTO `base_zip` VALUES ('405', '150421', '', '', '阿鲁科尔沁旗', '400');
INSERT INTO `base_zip` VALUES ('406', '150422', '', '', '巴林左旗', '400');
INSERT INTO `base_zip` VALUES ('407', '150423', '', '', '巴林右旗', '400');
INSERT INTO `base_zip` VALUES ('408', '150424', '', '', '林西县', '400');
INSERT INTO `base_zip` VALUES ('409', '150425', '', '', '克什克腾旗', '400');
INSERT INTO `base_zip` VALUES ('410', '150426', '', '', '翁牛特旗', '400');
INSERT INTO `base_zip` VALUES ('411', '150428', '', '', '喀喇沁旗', '400');
INSERT INTO `base_zip` VALUES ('412', '150429', '', '', '宁城县', '400');
INSERT INTO `base_zip` VALUES ('413', '150430', '', '', '敖汉旗', '400');
INSERT INTO `base_zip` VALUES ('414', '150500', '', '通辽市', '', '372');
INSERT INTO `base_zip` VALUES ('415', '150501', '', '', '市辖区', '414');
INSERT INTO `base_zip` VALUES ('416', '150502', '', '', '科尔沁区', '414');
INSERT INTO `base_zip` VALUES ('417', '150521', '', '', '科尔沁左翼中旗', '414');
INSERT INTO `base_zip` VALUES ('418', '150522', '', '', '科尔沁左翼后旗', '414');
INSERT INTO `base_zip` VALUES ('419', '150523', '', '', '开鲁县', '414');
INSERT INTO `base_zip` VALUES ('420', '150524', '', '', '库伦旗', '414');
INSERT INTO `base_zip` VALUES ('421', '150525', '', '', '奈曼旗', '414');
INSERT INTO `base_zip` VALUES ('422', '150526', '', '', '扎鲁特旗', '414');
INSERT INTO `base_zip` VALUES ('423', '150581', '', '', '霍林郭勒市', '414');
INSERT INTO `base_zip` VALUES ('424', '150600', '', '鄂尔多斯市', '', '372');
INSERT INTO `base_zip` VALUES ('425', '150601', '', '', '市辖区', '424');
INSERT INTO `base_zip` VALUES ('426', '150602', '', '', '东胜区', '424');
INSERT INTO `base_zip` VALUES ('427', '150621', '', '', '达拉特旗', '424');
INSERT INTO `base_zip` VALUES ('428', '150622', '', '', '准格尔旗', '424');
INSERT INTO `base_zip` VALUES ('429', '150623', '', '', '鄂托克前旗', '424');
INSERT INTO `base_zip` VALUES ('430', '150624', '', '', '鄂托克旗', '424');
INSERT INTO `base_zip` VALUES ('431', '150625', '', '', '杭锦旗', '424');
INSERT INTO `base_zip` VALUES ('432', '150626', '', '', '乌审旗', '424');
INSERT INTO `base_zip` VALUES ('433', '150627', '', '', '伊金霍洛旗', '424');
INSERT INTO `base_zip` VALUES ('434', '150700', '', '呼伦贝尔市', '', '372');
INSERT INTO `base_zip` VALUES ('435', '150701', '', '', '市辖区', '434');
INSERT INTO `base_zip` VALUES ('436', '150702', '', '', '海拉尔区', '434');
INSERT INTO `base_zip` VALUES ('437', '150703', '', '', '扎赉诺尔区', '434');
INSERT INTO `base_zip` VALUES ('438', '150721', '', '', '阿荣旗', '434');
INSERT INTO `base_zip` VALUES ('439', '150722', '', '', '莫力达瓦达斡尔族自治旗', '434');
INSERT INTO `base_zip` VALUES ('440', '150723', '', '', '鄂伦春自治旗', '434');
INSERT INTO `base_zip` VALUES ('441', '150724', '', '', '鄂温克族自治旗', '434');
INSERT INTO `base_zip` VALUES ('442', '150725', '', '', '陈巴尔虎旗', '434');
INSERT INTO `base_zip` VALUES ('443', '150726', '', '', '新巴尔虎左旗', '434');
INSERT INTO `base_zip` VALUES ('444', '150727', '', '', '新巴尔虎右旗', '434');
INSERT INTO `base_zip` VALUES ('445', '150781', '', '', '满洲里市', '434');
INSERT INTO `base_zip` VALUES ('446', '150782', '', '', '牙克石市', '434');
INSERT INTO `base_zip` VALUES ('447', '150783', '', '', '扎兰屯市', '434');
INSERT INTO `base_zip` VALUES ('448', '150784', '', '', '额尔古纳市', '434');
INSERT INTO `base_zip` VALUES ('449', '150785', '', '', '根河市', '434');
INSERT INTO `base_zip` VALUES ('450', '150800', '', '巴彦淖尔市', '', '372');
INSERT INTO `base_zip` VALUES ('451', '150801', '', '', '市辖区', '450');
INSERT INTO `base_zip` VALUES ('452', '150802', '', '', '临河区', '450');
INSERT INTO `base_zip` VALUES ('453', '150821', '', '', '五原县', '450');
INSERT INTO `base_zip` VALUES ('454', '150822', '', '', '磴口县', '450');
INSERT INTO `base_zip` VALUES ('455', '150823', '', '', '乌拉特前旗', '450');
INSERT INTO `base_zip` VALUES ('456', '150824', '', '', '乌拉特中旗', '450');
INSERT INTO `base_zip` VALUES ('457', '150825', '', '', '乌拉特后旗', '450');
INSERT INTO `base_zip` VALUES ('458', '150826', '', '', '杭锦后旗', '450');
INSERT INTO `base_zip` VALUES ('459', '150900', '', '乌兰察布市', '', '372');
INSERT INTO `base_zip` VALUES ('460', '150901', '', '', '市辖区', '459');
INSERT INTO `base_zip` VALUES ('461', '150902', '', '', '集宁区', '459');
INSERT INTO `base_zip` VALUES ('462', '150921', '', '', '卓资县', '459');
INSERT INTO `base_zip` VALUES ('463', '150922', '', '', '化德县', '459');
INSERT INTO `base_zip` VALUES ('464', '150923', '', '', '商都县', '459');
INSERT INTO `base_zip` VALUES ('465', '150924', '', '', '兴和县', '459');
INSERT INTO `base_zip` VALUES ('466', '150925', '', '', '凉城县', '459');
INSERT INTO `base_zip` VALUES ('467', '150926', '', '', '察哈尔右翼前旗', '459');
INSERT INTO `base_zip` VALUES ('468', '150927', '', '', '察哈尔右翼中旗', '459');
INSERT INTO `base_zip` VALUES ('469', '150928', '', '', '察哈尔右翼后旗', '459');
INSERT INTO `base_zip` VALUES ('470', '150929', '', '', '四子王旗', '459');
INSERT INTO `base_zip` VALUES ('471', '150981', '', '', '丰镇市', '459');
INSERT INTO `base_zip` VALUES ('472', '152200', '', '兴安盟', '', '372');
INSERT INTO `base_zip` VALUES ('473', '152201', '', '', '乌兰浩特市', '472');
INSERT INTO `base_zip` VALUES ('474', '152202', '', '', '阿尔山市', '472');
INSERT INTO `base_zip` VALUES ('475', '152221', '', '', '科尔沁右翼前旗', '472');
INSERT INTO `base_zip` VALUES ('476', '152222', '', '', '科尔沁右翼中旗', '472');
INSERT INTO `base_zip` VALUES ('477', '152223', '', '', '扎赉特旗', '472');
INSERT INTO `base_zip` VALUES ('478', '152224', '', '', '突泉县', '472');
INSERT INTO `base_zip` VALUES ('479', '152500', '', '锡林郭勒盟', '', '372');
INSERT INTO `base_zip` VALUES ('480', '152501', '', '', '二连浩特市', '479');
INSERT INTO `base_zip` VALUES ('481', '152502', '', '', '锡林浩特市', '479');
INSERT INTO `base_zip` VALUES ('482', '152522', '', '', '阿巴嘎旗', '479');
INSERT INTO `base_zip` VALUES ('483', '152523', '', '', '苏尼特左旗', '479');
INSERT INTO `base_zip` VALUES ('484', '152524', '', '', '苏尼特右旗', '479');
INSERT INTO `base_zip` VALUES ('485', '152525', '', '', '东乌珠穆沁旗', '479');
INSERT INTO `base_zip` VALUES ('486', '152526', '', '', '西乌珠穆沁旗', '479');
INSERT INTO `base_zip` VALUES ('487', '152527', '', '', '太仆寺旗', '479');
INSERT INTO `base_zip` VALUES ('488', '152528', '', '', '镶黄旗', '479');
INSERT INTO `base_zip` VALUES ('489', '152529', '', '', '正镶白旗', '479');
INSERT INTO `base_zip` VALUES ('490', '152530', '', '', '正蓝旗', '479');
INSERT INTO `base_zip` VALUES ('491', '152531', '', '', '多伦县', '479');
INSERT INTO `base_zip` VALUES ('492', '152900', '', '阿拉善盟', '', '372');
INSERT INTO `base_zip` VALUES ('493', '152921', '', '', '阿拉善左旗', '492');
INSERT INTO `base_zip` VALUES ('494', '152922', '', '', '阿拉善右旗', '492');
INSERT INTO `base_zip` VALUES ('495', '152923', '', '', '额济纳旗', '492');
INSERT INTO `base_zip` VALUES ('496', '210000', '辽宁省', '', '', '1');
INSERT INTO `base_zip` VALUES ('497', '210100', '', '沈阳市', '', '496');
INSERT INTO `base_zip` VALUES ('498', '210101', '', '', '市辖区', '497');
INSERT INTO `base_zip` VALUES ('499', '210102', '', '', '和平区', '497');
INSERT INTO `base_zip` VALUES ('500', '210103', '', '', '沈河区', '497');
INSERT INTO `base_zip` VALUES ('501', '210104', '', '', '大东区', '497');
INSERT INTO `base_zip` VALUES ('502', '210105', '', '', '皇姑区', '497');
INSERT INTO `base_zip` VALUES ('503', '210106', '', '', '铁西区', '497');
INSERT INTO `base_zip` VALUES ('504', '210111', '', '', '苏家屯区', '497');
INSERT INTO `base_zip` VALUES ('505', '210112', '', '', '浑南区', '497');
INSERT INTO `base_zip` VALUES ('506', '210113', '', '', '沈北新区', '497');
INSERT INTO `base_zip` VALUES ('507', '210114', '', '', '于洪区', '497');
INSERT INTO `base_zip` VALUES ('508', '210122', '', '', '辽中县', '497');
INSERT INTO `base_zip` VALUES ('509', '210123', '', '', '康平县', '497');
INSERT INTO `base_zip` VALUES ('510', '210124', '', '', '法库县', '497');
INSERT INTO `base_zip` VALUES ('511', '210181', '', '', '新民市', '497');
INSERT INTO `base_zip` VALUES ('512', '210200', '', '大连市', '', '496');
INSERT INTO `base_zip` VALUES ('513', '210201', '', '', '市辖区', '512');
INSERT INTO `base_zip` VALUES ('514', '210202', '', '', '中山区', '512');
INSERT INTO `base_zip` VALUES ('515', '210203', '', '', '西岗区', '512');
INSERT INTO `base_zip` VALUES ('516', '210204', '', '', '沙河口区', '512');
INSERT INTO `base_zip` VALUES ('517', '210211', '', '', '甘井子区', '512');
INSERT INTO `base_zip` VALUES ('518', '210212', '', '', '旅顺口区', '512');
INSERT INTO `base_zip` VALUES ('519', '210213', '', '', '金州区', '512');
INSERT INTO `base_zip` VALUES ('520', '210224', '', '', '长海县', '512');
INSERT INTO `base_zip` VALUES ('521', '210281', '', '', '瓦房店市', '512');
INSERT INTO `base_zip` VALUES ('522', '210282', '', '', '普兰店市', '512');
INSERT INTO `base_zip` VALUES ('523', '210283', '', '', '庄河市', '512');
INSERT INTO `base_zip` VALUES ('524', '210300', '', '鞍山市', '', '496');
INSERT INTO `base_zip` VALUES ('525', '210301', '', '', '市辖区', '524');
INSERT INTO `base_zip` VALUES ('526', '210302', '', '', '铁东区', '524');
INSERT INTO `base_zip` VALUES ('527', '210303', '', '', '铁西区', '524');
INSERT INTO `base_zip` VALUES ('528', '210304', '', '', '立山区', '524');
INSERT INTO `base_zip` VALUES ('529', '210311', '', '', '千山区', '524');
INSERT INTO `base_zip` VALUES ('530', '210321', '', '', '台安县', '524');
INSERT INTO `base_zip` VALUES ('531', '210323', '', '', '岫岩满族自治县', '524');
INSERT INTO `base_zip` VALUES ('532', '210381', '', '', '海城市', '524');
INSERT INTO `base_zip` VALUES ('533', '210400', '', '抚顺市', '', '496');
INSERT INTO `base_zip` VALUES ('534', '210401', '', '', '市辖区', '533');
INSERT INTO `base_zip` VALUES ('535', '210402', '', '', '新抚区', '533');
INSERT INTO `base_zip` VALUES ('536', '210403', '', '', '东洲区', '533');
INSERT INTO `base_zip` VALUES ('537', '210404', '', '', '望花区', '533');
INSERT INTO `base_zip` VALUES ('538', '210411', '', '', '顺城区', '533');
INSERT INTO `base_zip` VALUES ('539', '210421', '', '', '抚顺县', '533');
INSERT INTO `base_zip` VALUES ('540', '210422', '', '', '新宾满族自治县', '533');
INSERT INTO `base_zip` VALUES ('541', '210423', '', '', '清原满族自治县', '533');
INSERT INTO `base_zip` VALUES ('542', '210500', '', '本溪市', '', '496');
INSERT INTO `base_zip` VALUES ('543', '210501', '', '', '市辖区', '542');
INSERT INTO `base_zip` VALUES ('544', '210502', '', '', '平山区', '542');
INSERT INTO `base_zip` VALUES ('545', '210503', '', '', '溪湖区', '542');
INSERT INTO `base_zip` VALUES ('546', '210504', '', '', '明山区', '542');
INSERT INTO `base_zip` VALUES ('547', '210505', '', '', '南芬区', '542');
INSERT INTO `base_zip` VALUES ('548', '210521', '', '', '本溪满族自治县', '542');
INSERT INTO `base_zip` VALUES ('549', '210522', '', '', '桓仁满族自治县', '542');
INSERT INTO `base_zip` VALUES ('550', '210600', '', '丹东市', '', '496');
INSERT INTO `base_zip` VALUES ('551', '210601', '', '', '市辖区', '550');
INSERT INTO `base_zip` VALUES ('552', '210602', '', '', '元宝区', '550');
INSERT INTO `base_zip` VALUES ('553', '210603', '', '', '振兴区', '550');
INSERT INTO `base_zip` VALUES ('554', '210604', '', '', '振安区', '550');
INSERT INTO `base_zip` VALUES ('555', '210624', '', '', '宽甸满族自治县', '550');
INSERT INTO `base_zip` VALUES ('556', '210681', '', '', '东港市', '550');
INSERT INTO `base_zip` VALUES ('557', '210682', '', '', '凤城市', '550');
INSERT INTO `base_zip` VALUES ('558', '210700', '', '锦州市', '', '496');
INSERT INTO `base_zip` VALUES ('559', '210701', '', '', '市辖区', '558');
INSERT INTO `base_zip` VALUES ('560', '210702', '', '', '古塔区', '558');
INSERT INTO `base_zip` VALUES ('561', '210703', '', '', '凌河区', '558');
INSERT INTO `base_zip` VALUES ('562', '210711', '', '', '太和区', '558');
INSERT INTO `base_zip` VALUES ('563', '210726', '', '', '黑山县', '558');
INSERT INTO `base_zip` VALUES ('564', '210727', '', '', '义县', '558');
INSERT INTO `base_zip` VALUES ('565', '210781', '', '', '凌海市', '558');
INSERT INTO `base_zip` VALUES ('566', '210782', '', '', '北镇市', '558');
INSERT INTO `base_zip` VALUES ('567', '210800', '', '营口市', '', '496');
INSERT INTO `base_zip` VALUES ('568', '210801', '', '', '市辖区', '567');
INSERT INTO `base_zip` VALUES ('569', '210802', '', '', '站前区', '567');
INSERT INTO `base_zip` VALUES ('570', '210803', '', '', '西市区', '567');
INSERT INTO `base_zip` VALUES ('571', '210804', '', '', '鲅鱼圈区', '567');
INSERT INTO `base_zip` VALUES ('572', '210811', '', '', '老边区', '567');
INSERT INTO `base_zip` VALUES ('573', '210881', '', '', '盖州市', '567');
INSERT INTO `base_zip` VALUES ('574', '210882', '', '', '大石桥市', '567');
INSERT INTO `base_zip` VALUES ('575', '210900', '', '阜新市', '', '496');
INSERT INTO `base_zip` VALUES ('576', '210901', '', '', '市辖区', '575');
INSERT INTO `base_zip` VALUES ('577', '210902', '', '', '海州区', '575');
INSERT INTO `base_zip` VALUES ('578', '210903', '', '', '新邱区', '575');
INSERT INTO `base_zip` VALUES ('579', '210904', '', '', '太平区', '575');
INSERT INTO `base_zip` VALUES ('580', '210905', '', '', '清河门区', '575');
INSERT INTO `base_zip` VALUES ('581', '210911', '', '', '细河区', '575');
INSERT INTO `base_zip` VALUES ('582', '210921', '', '', '阜新蒙古族自治县', '575');
INSERT INTO `base_zip` VALUES ('583', '210922', '', '', '彰武县', '575');
INSERT INTO `base_zip` VALUES ('584', '211000', '', '辽阳市', '', '496');
INSERT INTO `base_zip` VALUES ('585', '211001', '', '', '市辖区', '584');
INSERT INTO `base_zip` VALUES ('586', '211002', '', '', '白塔区', '584');
INSERT INTO `base_zip` VALUES ('587', '211003', '', '', '文圣区', '584');
INSERT INTO `base_zip` VALUES ('588', '211004', '', '', '宏伟区', '584');
INSERT INTO `base_zip` VALUES ('589', '211005', '', '', '弓长岭区', '584');
INSERT INTO `base_zip` VALUES ('590', '211011', '', '', '太子河区', '584');
INSERT INTO `base_zip` VALUES ('591', '211021', '', '', '辽阳县', '584');
INSERT INTO `base_zip` VALUES ('592', '211081', '', '', '灯塔市', '584');
INSERT INTO `base_zip` VALUES ('593', '211100', '', '盘锦市', '', '496');
INSERT INTO `base_zip` VALUES ('594', '211101', '', '', '市辖区', '593');
INSERT INTO `base_zip` VALUES ('595', '211102', '', '', '双台子区', '593');
INSERT INTO `base_zip` VALUES ('596', '211103', '', '', '兴隆台区', '593');
INSERT INTO `base_zip` VALUES ('597', '211121', '', '', '大洼县', '593');
INSERT INTO `base_zip` VALUES ('598', '211122', '', '', '盘山县', '593');
INSERT INTO `base_zip` VALUES ('599', '211200', '', '铁岭市', '', '496');
INSERT INTO `base_zip` VALUES ('600', '211201', '', '', '市辖区', '599');
INSERT INTO `base_zip` VALUES ('601', '211202', '', '', '银州区', '599');
INSERT INTO `base_zip` VALUES ('602', '211204', '', '', '清河区', '599');
INSERT INTO `base_zip` VALUES ('603', '211221', '', '', '铁岭县', '599');
INSERT INTO `base_zip` VALUES ('604', '211223', '', '', '西丰县', '599');
INSERT INTO `base_zip` VALUES ('605', '211224', '', '', '昌图县', '599');
INSERT INTO `base_zip` VALUES ('606', '211281', '', '', '调兵山市', '599');
INSERT INTO `base_zip` VALUES ('607', '211282', '', '', '开原市', '599');
INSERT INTO `base_zip` VALUES ('608', '211300', '', '朝阳市', '', '496');
INSERT INTO `base_zip` VALUES ('609', '211301', '', '', '市辖区', '608');
INSERT INTO `base_zip` VALUES ('610', '211302', '', '', '双塔区', '608');
INSERT INTO `base_zip` VALUES ('611', '211303', '', '', '龙城区', '608');
INSERT INTO `base_zip` VALUES ('612', '211321', '', '', '朝阳县', '608');
INSERT INTO `base_zip` VALUES ('613', '211322', '', '', '建平县', '608');
INSERT INTO `base_zip` VALUES ('614', '211324', '', '', '喀喇沁左翼蒙古族自治县', '608');
INSERT INTO `base_zip` VALUES ('615', '211381', '', '', '北票市', '608');
INSERT INTO `base_zip` VALUES ('616', '211382', '', '', '凌源市', '608');
INSERT INTO `base_zip` VALUES ('617', '211400', '', '葫芦岛市', '', '496');
INSERT INTO `base_zip` VALUES ('618', '211401', '', '', '市辖区', '617');
INSERT INTO `base_zip` VALUES ('619', '211402', '', '', '连山区', '617');
INSERT INTO `base_zip` VALUES ('620', '211403', '', '', '龙港区', '617');
INSERT INTO `base_zip` VALUES ('621', '211404', '', '', '南票区', '617');
INSERT INTO `base_zip` VALUES ('622', '211421', '', '', '绥中县', '617');
INSERT INTO `base_zip` VALUES ('623', '211422', '', '', '建昌县', '617');
INSERT INTO `base_zip` VALUES ('624', '211481', '', '', '兴城市', '617');
INSERT INTO `base_zip` VALUES ('625', '220000', '吉林省', '', '', '1');
INSERT INTO `base_zip` VALUES ('626', '220100', '', '长春市', '', '625');
INSERT INTO `base_zip` VALUES ('627', '220101', '', '', '市辖区', '626');
INSERT INTO `base_zip` VALUES ('628', '220102', '', '', '南关区', '626');
INSERT INTO `base_zip` VALUES ('629', '220103', '', '', '宽城区', '626');
INSERT INTO `base_zip` VALUES ('630', '220104', '', '', '朝阳区', '626');
INSERT INTO `base_zip` VALUES ('631', '220105', '', '', '二道区', '626');
INSERT INTO `base_zip` VALUES ('632', '220106', '', '', '绿园区', '626');
INSERT INTO `base_zip` VALUES ('633', '220112', '', '', '双阳区', '626');
INSERT INTO `base_zip` VALUES ('634', '220113', '', '', '九台区', '626');
INSERT INTO `base_zip` VALUES ('635', '220122', '', '', '农安县', '626');
INSERT INTO `base_zip` VALUES ('636', '220182', '', '', '榆树市', '626');
INSERT INTO `base_zip` VALUES ('637', '220183', '', '', '德惠市', '626');
INSERT INTO `base_zip` VALUES ('638', '220200', '', '吉林市', '', '625');
INSERT INTO `base_zip` VALUES ('639', '220201', '', '', '市辖区', '638');
INSERT INTO `base_zip` VALUES ('640', '220202', '', '', '昌邑区', '638');
INSERT INTO `base_zip` VALUES ('641', '220203', '', '', '龙潭区', '638');
INSERT INTO `base_zip` VALUES ('642', '220204', '', '', '船营区', '638');
INSERT INTO `base_zip` VALUES ('643', '220211', '', '', '丰满区', '638');
INSERT INTO `base_zip` VALUES ('644', '220221', '', '', '永吉县', '638');
INSERT INTO `base_zip` VALUES ('645', '220281', '', '', '蛟河市', '638');
INSERT INTO `base_zip` VALUES ('646', '220282', '', '', '桦甸市', '638');
INSERT INTO `base_zip` VALUES ('647', '220283', '', '', '舒兰市', '638');
INSERT INTO `base_zip` VALUES ('648', '220284', '', '', '磐石市', '638');
INSERT INTO `base_zip` VALUES ('649', '220300', '', '四平市', '', '625');
INSERT INTO `base_zip` VALUES ('650', '220301', '', '', '市辖区', '649');
INSERT INTO `base_zip` VALUES ('651', '220302', '', '', '铁西区', '649');
INSERT INTO `base_zip` VALUES ('652', '220303', '', '', '铁东区', '649');
INSERT INTO `base_zip` VALUES ('653', '220322', '', '', '梨树县', '649');
INSERT INTO `base_zip` VALUES ('654', '220323', '', '', '伊通满族自治县', '649');
INSERT INTO `base_zip` VALUES ('655', '220381', '', '', '公主岭市', '649');
INSERT INTO `base_zip` VALUES ('656', '220382', '', '', '双辽市', '649');
INSERT INTO `base_zip` VALUES ('657', '220400', '', '辽源市', '', '625');
INSERT INTO `base_zip` VALUES ('658', '220401', '', '', '市辖区', '657');
INSERT INTO `base_zip` VALUES ('659', '220402', '', '', '龙山区', '657');
INSERT INTO `base_zip` VALUES ('660', '220403', '', '', '西安区', '657');
INSERT INTO `base_zip` VALUES ('661', '220421', '', '', '东丰县', '657');
INSERT INTO `base_zip` VALUES ('662', '220422', '', '', '东辽县', '657');
INSERT INTO `base_zip` VALUES ('663', '220500', '', '通化市', '', '625');
INSERT INTO `base_zip` VALUES ('664', '220501', '', '', '市辖区', '663');
INSERT INTO `base_zip` VALUES ('665', '220502', '', '', '东昌区', '663');
INSERT INTO `base_zip` VALUES ('666', '220503', '', '', '二道江区', '663');
INSERT INTO `base_zip` VALUES ('667', '220521', '', '', '通化县', '663');
INSERT INTO `base_zip` VALUES ('668', '220523', '', '', '辉南县', '663');
INSERT INTO `base_zip` VALUES ('669', '220524', '', '', '柳河县', '663');
INSERT INTO `base_zip` VALUES ('670', '220581', '', '', '梅河口市', '663');
INSERT INTO `base_zip` VALUES ('671', '220582', '', '', '集安市', '663');
INSERT INTO `base_zip` VALUES ('672', '220600', '', '白山市', '', '625');
INSERT INTO `base_zip` VALUES ('673', '220601', '', '', '市辖区', '672');
INSERT INTO `base_zip` VALUES ('674', '220602', '', '', '浑江区', '672');
INSERT INTO `base_zip` VALUES ('675', '220605', '', '', '江源区', '672');
INSERT INTO `base_zip` VALUES ('676', '220621', '', '', '抚松县', '672');
INSERT INTO `base_zip` VALUES ('677', '220622', '', '', '靖宇县', '672');
INSERT INTO `base_zip` VALUES ('678', '220623', '', '', '长白朝鲜族自治县', '672');
INSERT INTO `base_zip` VALUES ('679', '220681', '', '', '临江市', '672');
INSERT INTO `base_zip` VALUES ('680', '220700', '', '松原市', '', '625');
INSERT INTO `base_zip` VALUES ('681', '220701', '', '', '市辖区', '680');
INSERT INTO `base_zip` VALUES ('682', '220702', '', '', '宁江区', '680');
INSERT INTO `base_zip` VALUES ('683', '220721', '', '', '前郭尔罗斯蒙古族自治县', '680');
INSERT INTO `base_zip` VALUES ('684', '220722', '', '', '长岭县', '680');
INSERT INTO `base_zip` VALUES ('685', '220723', '', '', '乾安县', '680');
INSERT INTO `base_zip` VALUES ('686', '220781', '', '', '扶余市', '680');
INSERT INTO `base_zip` VALUES ('687', '220800', '', '白城市', '', '625');
INSERT INTO `base_zip` VALUES ('688', '220801', '', '', '市辖区', '687');
INSERT INTO `base_zip` VALUES ('689', '220802', '', '', '洮北区', '687');
INSERT INTO `base_zip` VALUES ('690', '220821', '', '', '镇赉县', '687');
INSERT INTO `base_zip` VALUES ('691', '220822', '', '', '通榆县', '687');
INSERT INTO `base_zip` VALUES ('692', '220881', '', '', '洮南市', '687');
INSERT INTO `base_zip` VALUES ('693', '220882', '', '', '大安市', '687');
INSERT INTO `base_zip` VALUES ('694', '222400', '', '延边朝鲜族自治州', '', '625');
INSERT INTO `base_zip` VALUES ('695', '222401', '', '', '延吉市', '694');
INSERT INTO `base_zip` VALUES ('696', '222402', '', '', '图们市', '694');
INSERT INTO `base_zip` VALUES ('697', '222403', '', '', '敦化市', '694');
INSERT INTO `base_zip` VALUES ('698', '222404', '', '', '珲春市', '694');
INSERT INTO `base_zip` VALUES ('699', '222405', '', '', '龙井市', '694');
INSERT INTO `base_zip` VALUES ('700', '222406', '', '', '和龙市', '694');
INSERT INTO `base_zip` VALUES ('701', '222424', '', '', '汪清县', '694');
INSERT INTO `base_zip` VALUES ('702', '222426', '', '', '安图县', '694');
INSERT INTO `base_zip` VALUES ('703', '230000', '黑龙江省', '', '', '1');
INSERT INTO `base_zip` VALUES ('704', '230100', '', '哈尔滨市', '', '703');
INSERT INTO `base_zip` VALUES ('705', '230101', '', '', '市辖区', '704');
INSERT INTO `base_zip` VALUES ('706', '230102', '', '', '道里区', '704');
INSERT INTO `base_zip` VALUES ('707', '230103', '', '', '南岗区', '704');
INSERT INTO `base_zip` VALUES ('708', '230104', '', '', '道外区', '704');
INSERT INTO `base_zip` VALUES ('709', '230108', '', '', '平房区', '704');
INSERT INTO `base_zip` VALUES ('710', '230109', '', '', '松北区', '704');
INSERT INTO `base_zip` VALUES ('711', '230110', '', '', '香坊区', '704');
INSERT INTO `base_zip` VALUES ('712', '230111', '', '', '呼兰区', '704');
INSERT INTO `base_zip` VALUES ('713', '230112', '', '', '阿城区', '704');
INSERT INTO `base_zip` VALUES ('714', '230113', '', '', '双城区', '704');
INSERT INTO `base_zip` VALUES ('715', '230123', '', '', '依兰县', '704');
INSERT INTO `base_zip` VALUES ('716', '230124', '', '', '方正县', '704');
INSERT INTO `base_zip` VALUES ('717', '230125', '', '', '宾县', '704');
INSERT INTO `base_zip` VALUES ('718', '230126', '', '', '巴彦县', '704');
INSERT INTO `base_zip` VALUES ('719', '230127', '', '', '木兰县', '704');
INSERT INTO `base_zip` VALUES ('720', '230128', '', '', '通河县', '704');
INSERT INTO `base_zip` VALUES ('721', '230129', '', '', '延寿县', '704');
INSERT INTO `base_zip` VALUES ('722', '230183', '', '', '尚志市', '704');
INSERT INTO `base_zip` VALUES ('723', '230184', '', '', '五常市', '704');
INSERT INTO `base_zip` VALUES ('724', '230200', '', '齐齐哈尔市', '', '703');
INSERT INTO `base_zip` VALUES ('725', '230201', '', '', '市辖区', '724');
INSERT INTO `base_zip` VALUES ('726', '230202', '', '', '龙沙区', '724');
INSERT INTO `base_zip` VALUES ('727', '230203', '', '', '建华区', '724');
INSERT INTO `base_zip` VALUES ('728', '230204', '', '', '铁锋区', '724');
INSERT INTO `base_zip` VALUES ('729', '230205', '', '', '昂昂溪区', '724');
INSERT INTO `base_zip` VALUES ('730', '230206', '', '', '富拉尔基区', '724');
INSERT INTO `base_zip` VALUES ('731', '230207', '', '', '碾子山区', '724');
INSERT INTO `base_zip` VALUES ('732', '230208', '', '', '梅里斯达斡尔族区', '724');
INSERT INTO `base_zip` VALUES ('733', '230221', '', '', '龙江县', '724');
INSERT INTO `base_zip` VALUES ('734', '230223', '', '', '依安县', '724');
INSERT INTO `base_zip` VALUES ('735', '230224', '', '', '泰来县', '724');
INSERT INTO `base_zip` VALUES ('736', '230225', '', '', '甘南县', '724');
INSERT INTO `base_zip` VALUES ('737', '230227', '', '', '富裕县', '724');
INSERT INTO `base_zip` VALUES ('738', '230229', '', '', '克山县', '724');
INSERT INTO `base_zip` VALUES ('739', '230230', '', '', '克东县', '724');
INSERT INTO `base_zip` VALUES ('740', '230231', '', '', '拜泉县', '724');
INSERT INTO `base_zip` VALUES ('741', '230281', '', '', '讷河市', '724');
INSERT INTO `base_zip` VALUES ('742', '230300', '', '鸡西市', '', '703');
INSERT INTO `base_zip` VALUES ('743', '230301', '', '', '市辖区', '742');
INSERT INTO `base_zip` VALUES ('744', '230302', '', '', '鸡冠区', '742');
INSERT INTO `base_zip` VALUES ('745', '230303', '', '', '恒山区', '742');
INSERT INTO `base_zip` VALUES ('746', '230304', '', '', '滴道区', '742');
INSERT INTO `base_zip` VALUES ('747', '230305', '', '', '梨树区', '742');
INSERT INTO `base_zip` VALUES ('748', '230306', '', '', '城子河区', '742');
INSERT INTO `base_zip` VALUES ('749', '230307', '', '', '麻山区', '742');
INSERT INTO `base_zip` VALUES ('750', '230321', '', '', '鸡东县', '742');
INSERT INTO `base_zip` VALUES ('751', '230381', '', '', '虎林市', '742');
INSERT INTO `base_zip` VALUES ('752', '230382', '', '', '密山市', '742');
INSERT INTO `base_zip` VALUES ('753', '230400', '', '鹤岗市', '', '703');
INSERT INTO `base_zip` VALUES ('754', '230401', '', '', '市辖区', '753');
INSERT INTO `base_zip` VALUES ('755', '230402', '', '', '向阳区', '753');
INSERT INTO `base_zip` VALUES ('756', '230403', '', '', '工农区', '753');
INSERT INTO `base_zip` VALUES ('757', '230404', '', '', '南山区', '753');
INSERT INTO `base_zip` VALUES ('758', '230405', '', '', '兴安区', '753');
INSERT INTO `base_zip` VALUES ('759', '230406', '', '', '东山区', '753');
INSERT INTO `base_zip` VALUES ('760', '230407', '', '', '兴山区', '753');
INSERT INTO `base_zip` VALUES ('761', '230421', '', '', '萝北县', '753');
INSERT INTO `base_zip` VALUES ('762', '230422', '', '', '绥滨县', '753');
INSERT INTO `base_zip` VALUES ('763', '230500', '', '双鸭山市', '', '703');
INSERT INTO `base_zip` VALUES ('764', '230501', '', '', '市辖区', '763');
INSERT INTO `base_zip` VALUES ('765', '230502', '', '', '尖山区', '763');
INSERT INTO `base_zip` VALUES ('766', '230503', '', '', '岭东区', '763');
INSERT INTO `base_zip` VALUES ('767', '230505', '', '', '四方台区', '763');
INSERT INTO `base_zip` VALUES ('768', '230506', '', '', '宝山区', '763');
INSERT INTO `base_zip` VALUES ('769', '230521', '', '', '集贤县', '763');
INSERT INTO `base_zip` VALUES ('770', '230522', '', '', '友谊县', '763');
INSERT INTO `base_zip` VALUES ('771', '230523', '', '', '宝清县', '763');
INSERT INTO `base_zip` VALUES ('772', '230524', '', '', '饶河县', '763');
INSERT INTO `base_zip` VALUES ('773', '230600', '', '大庆市', '', '703');
INSERT INTO `base_zip` VALUES ('774', '230601', '', '', '市辖区', '773');
INSERT INTO `base_zip` VALUES ('775', '230602', '', '', '萨尔图区', '773');
INSERT INTO `base_zip` VALUES ('776', '230603', '', '', '龙凤区', '773');
INSERT INTO `base_zip` VALUES ('777', '230604', '', '', '让胡路区', '773');
INSERT INTO `base_zip` VALUES ('778', '230605', '', '', '红岗区', '773');
INSERT INTO `base_zip` VALUES ('779', '230606', '', '', '大同区', '773');
INSERT INTO `base_zip` VALUES ('780', '230621', '', '', '肇州县', '773');
INSERT INTO `base_zip` VALUES ('781', '230622', '', '', '肇源县', '773');
INSERT INTO `base_zip` VALUES ('782', '230623', '', '', '林甸县', '773');
INSERT INTO `base_zip` VALUES ('783', '230624', '', '', '杜尔伯特蒙古族自治县', '773');
INSERT INTO `base_zip` VALUES ('784', '230700', '', '伊春市', '', '703');
INSERT INTO `base_zip` VALUES ('785', '230701', '', '', '市辖区', '784');
INSERT INTO `base_zip` VALUES ('786', '230702', '', '', '伊春区', '784');
INSERT INTO `base_zip` VALUES ('787', '230703', '', '', '南岔区', '784');
INSERT INTO `base_zip` VALUES ('788', '230704', '', '', '友好区', '784');
INSERT INTO `base_zip` VALUES ('789', '230705', '', '', '西林区', '784');
INSERT INTO `base_zip` VALUES ('790', '230706', '', '', '翠峦区', '784');
INSERT INTO `base_zip` VALUES ('791', '230707', '', '', '新青区', '784');
INSERT INTO `base_zip` VALUES ('792', '230708', '', '', '美溪区', '784');
INSERT INTO `base_zip` VALUES ('793', '230709', '', '', '金山屯区', '784');
INSERT INTO `base_zip` VALUES ('794', '230710', '', '', '五营区', '784');
INSERT INTO `base_zip` VALUES ('795', '230711', '', '', '乌马河区', '784');
INSERT INTO `base_zip` VALUES ('796', '230712', '', '', '汤旺河区', '784');
INSERT INTO `base_zip` VALUES ('797', '230713', '', '', '带岭区', '784');
INSERT INTO `base_zip` VALUES ('798', '230714', '', '', '乌伊岭区', '784');
INSERT INTO `base_zip` VALUES ('799', '230715', '', '', '红星区', '784');
INSERT INTO `base_zip` VALUES ('800', '230716', '', '', '上甘岭区', '784');
INSERT INTO `base_zip` VALUES ('801', '230722', '', '', '嘉荫县', '784');
INSERT INTO `base_zip` VALUES ('802', '230781', '', '', '铁力市', '784');
INSERT INTO `base_zip` VALUES ('803', '230800', '', '佳木斯市', '', '703');
INSERT INTO `base_zip` VALUES ('804', '230801', '', '', '市辖区', '803');
INSERT INTO `base_zip` VALUES ('805', '230803', '', '', '向阳区', '803');
INSERT INTO `base_zip` VALUES ('806', '230804', '', '', '前进区', '803');
INSERT INTO `base_zip` VALUES ('807', '230805', '', '', '东风区', '803');
INSERT INTO `base_zip` VALUES ('808', '230811', '', '', '郊区', '803');
INSERT INTO `base_zip` VALUES ('809', '230822', '', '', '桦南县', '803');
INSERT INTO `base_zip` VALUES ('810', '230826', '', '', '桦川县', '803');
INSERT INTO `base_zip` VALUES ('811', '230828', '', '', '汤原县', '803');
INSERT INTO `base_zip` VALUES ('812', '230833', '', '', '抚远县', '803');
INSERT INTO `base_zip` VALUES ('813', '230881', '', '', '同江市', '803');
INSERT INTO `base_zip` VALUES ('814', '230882', '', '', '富锦市', '803');
INSERT INTO `base_zip` VALUES ('815', '230900', '', '七台河市', '', '703');
INSERT INTO `base_zip` VALUES ('816', '230901', '', '', '市辖区', '815');
INSERT INTO `base_zip` VALUES ('817', '230902', '', '', '新兴区', '815');
INSERT INTO `base_zip` VALUES ('818', '230903', '', '', '桃山区', '815');
INSERT INTO `base_zip` VALUES ('819', '230904', '', '', '茄子河区', '815');
INSERT INTO `base_zip` VALUES ('820', '230921', '', '', '勃利县', '815');
INSERT INTO `base_zip` VALUES ('821', '231000', '', '牡丹江市', '', '703');
INSERT INTO `base_zip` VALUES ('822', '231001', '', '', '市辖区', '821');
INSERT INTO `base_zip` VALUES ('823', '231002', '', '', '东安区', '821');
INSERT INTO `base_zip` VALUES ('824', '231003', '', '', '阳明区', '821');
INSERT INTO `base_zip` VALUES ('825', '231004', '', '', '爱民区', '821');
INSERT INTO `base_zip` VALUES ('826', '231005', '', '', '西安区', '821');
INSERT INTO `base_zip` VALUES ('827', '231024', '', '', '东宁县', '821');
INSERT INTO `base_zip` VALUES ('828', '231025', '', '', '林口县', '821');
INSERT INTO `base_zip` VALUES ('829', '231081', '', '', '绥芬河市', '821');
INSERT INTO `base_zip` VALUES ('830', '231083', '', '', '海林市', '821');
INSERT INTO `base_zip` VALUES ('831', '231084', '', '', '宁安市', '821');
INSERT INTO `base_zip` VALUES ('832', '231085', '', '', '穆棱市', '821');
INSERT INTO `base_zip` VALUES ('833', '231100', '', '黑河市', '', '703');
INSERT INTO `base_zip` VALUES ('834', '231101', '', '', '市辖区', '833');
INSERT INTO `base_zip` VALUES ('835', '231102', '', '', '爱辉区', '833');
INSERT INTO `base_zip` VALUES ('836', '231121', '', '', '嫩江县', '833');
INSERT INTO `base_zip` VALUES ('837', '231123', '', '', '逊克县', '833');
INSERT INTO `base_zip` VALUES ('838', '231124', '', '', '孙吴县', '833');
INSERT INTO `base_zip` VALUES ('839', '231181', '', '', '北安市', '833');
INSERT INTO `base_zip` VALUES ('840', '231182', '', '', '五大连池市', '833');
INSERT INTO `base_zip` VALUES ('841', '231200', '', '绥化市', '', '703');
INSERT INTO `base_zip` VALUES ('842', '231201', '', '', '市辖区', '841');
INSERT INTO `base_zip` VALUES ('843', '231202', '', '', '北林区', '841');
INSERT INTO `base_zip` VALUES ('844', '231221', '', '', '望奎县', '841');
INSERT INTO `base_zip` VALUES ('845', '231222', '', '', '兰西县', '841');
INSERT INTO `base_zip` VALUES ('846', '231223', '', '', '青冈县', '841');
INSERT INTO `base_zip` VALUES ('847', '231224', '', '', '庆安县', '841');
INSERT INTO `base_zip` VALUES ('848', '231225', '', '', '明水县', '841');
INSERT INTO `base_zip` VALUES ('849', '231226', '', '', '绥棱县', '841');
INSERT INTO `base_zip` VALUES ('850', '231281', '', '', '安达市', '841');
INSERT INTO `base_zip` VALUES ('851', '231282', '', '', '肇东市', '841');
INSERT INTO `base_zip` VALUES ('852', '231283', '', '', '海伦市', '841');
INSERT INTO `base_zip` VALUES ('853', '232700', '', '大兴安岭地区', '', '703');
INSERT INTO `base_zip` VALUES ('854', '232721', '', '', '呼玛县', '853');
INSERT INTO `base_zip` VALUES ('855', '232722', '', '', '塔河县', '853');
INSERT INTO `base_zip` VALUES ('856', '232723', '', '', '漠河县', '853');
INSERT INTO `base_zip` VALUES ('857', '310000', '上海市', '上海市', '', '1');
INSERT INTO `base_zip` VALUES ('858', '310101', '', '', '黄浦区', '3927');
INSERT INTO `base_zip` VALUES ('859', '310104', '', '', '徐汇区', '3927');
INSERT INTO `base_zip` VALUES ('860', '310105', '', '', '长宁区', '3927');
INSERT INTO `base_zip` VALUES ('861', '310106', '', '', '静安区', '3927');
INSERT INTO `base_zip` VALUES ('862', '310107', '', '', '普陀区', '3927');
INSERT INTO `base_zip` VALUES ('863', '310108', '', '', '闸北区', '3927');
INSERT INTO `base_zip` VALUES ('864', '310109', '', '', '虹口区', '3927');
INSERT INTO `base_zip` VALUES ('865', '310110', '', '', '杨浦区', '3927');
INSERT INTO `base_zip` VALUES ('866', '310112', '', '', '闵行区', '3927');
INSERT INTO `base_zip` VALUES ('867', '310113', '', '', '宝山区', '3927');
INSERT INTO `base_zip` VALUES ('868', '310114', '', '', '嘉定区', '3927');
INSERT INTO `base_zip` VALUES ('869', '310115', '', '', '浦东新区', '3927');
INSERT INTO `base_zip` VALUES ('870', '310116', '', '', '金山区', '3927');
INSERT INTO `base_zip` VALUES ('871', '310117', '', '', '松江区', '3927');
INSERT INTO `base_zip` VALUES ('872', '310118', '', '', '青浦区', '3927');
INSERT INTO `base_zip` VALUES ('873', '310120', '', '', '奉贤区', '3927');
INSERT INTO `base_zip` VALUES ('874', '310230', '', '', '崇明县', '3927');
INSERT INTO `base_zip` VALUES ('875', '320000', '江苏省', '', '', '1');
INSERT INTO `base_zip` VALUES ('876', '320100', '', '南京市', '', '875');
INSERT INTO `base_zip` VALUES ('877', '320101', '', '', '市辖区', '876');
INSERT INTO `base_zip` VALUES ('878', '320102', '', '', '玄武区', '876');
INSERT INTO `base_zip` VALUES ('879', '320104', '', '', '秦淮区', '876');
INSERT INTO `base_zip` VALUES ('880', '320105', '', '', '建邺区', '876');
INSERT INTO `base_zip` VALUES ('881', '320106', '', '', '鼓楼区', '876');
INSERT INTO `base_zip` VALUES ('882', '320111', '', '', '浦口区', '876');
INSERT INTO `base_zip` VALUES ('883', '320113', '', '', '栖霞区', '876');
INSERT INTO `base_zip` VALUES ('884', '320114', '', '', '雨花台区', '876');
INSERT INTO `base_zip` VALUES ('885', '320115', '', '', '江宁区', '876');
INSERT INTO `base_zip` VALUES ('886', '320116', '', '', '六合区', '876');
INSERT INTO `base_zip` VALUES ('887', '320117', '', '', '溧水区', '876');
INSERT INTO `base_zip` VALUES ('888', '320118', '', '', '高淳区', '876');
INSERT INTO `base_zip` VALUES ('889', '320200', '', '无锡市', '', '875');
INSERT INTO `base_zip` VALUES ('890', '320201', '', '', '市辖区', '889');
INSERT INTO `base_zip` VALUES ('891', '320202', '', '', '崇安区', '889');
INSERT INTO `base_zip` VALUES ('892', '320203', '', '', '南长区', '889');
INSERT INTO `base_zip` VALUES ('893', '320204', '', '', '北塘区', '889');
INSERT INTO `base_zip` VALUES ('894', '320205', '', '', '锡山区', '889');
INSERT INTO `base_zip` VALUES ('895', '320206', '', '', '惠山区', '889');
INSERT INTO `base_zip` VALUES ('896', '320211', '', '', '滨湖区', '889');
INSERT INTO `base_zip` VALUES ('897', '320281', '', '', '江阴市', '889');
INSERT INTO `base_zip` VALUES ('898', '320282', '', '', '宜兴市', '889');
INSERT INTO `base_zip` VALUES ('899', '320300', '', '徐州市', '', '875');
INSERT INTO `base_zip` VALUES ('900', '320301', '', '', '市辖区', '899');
INSERT INTO `base_zip` VALUES ('901', '320302', '', '', '鼓楼区', '899');
INSERT INTO `base_zip` VALUES ('902', '320303', '', '', '云龙区', '899');
INSERT INTO `base_zip` VALUES ('903', '320305', '', '', '贾汪区', '899');
INSERT INTO `base_zip` VALUES ('904', '320311', '', '', '泉山区', '899');
INSERT INTO `base_zip` VALUES ('905', '320312', '', '', '铜山区', '899');
INSERT INTO `base_zip` VALUES ('906', '320321', '', '', '丰县', '899');
INSERT INTO `base_zip` VALUES ('907', '320322', '', '', '沛县', '899');
INSERT INTO `base_zip` VALUES ('908', '320324', '', '', '睢宁县', '899');
INSERT INTO `base_zip` VALUES ('909', '320381', '', '', '新沂市', '899');
INSERT INTO `base_zip` VALUES ('910', '320382', '', '', '邳州市', '899');
INSERT INTO `base_zip` VALUES ('911', '320400', '', '常州市', '', '875');
INSERT INTO `base_zip` VALUES ('912', '320401', '', '', '市辖区', '911');
INSERT INTO `base_zip` VALUES ('913', '320402', '', '', '天宁区', '911');
INSERT INTO `base_zip` VALUES ('914', '320404', '', '', '钟楼区', '911');
INSERT INTO `base_zip` VALUES ('915', '320405', '', '', '戚墅堰区', '911');
INSERT INTO `base_zip` VALUES ('916', '320411', '', '', '新北区', '911');
INSERT INTO `base_zip` VALUES ('917', '320412', '', '', '武进区', '911');
INSERT INTO `base_zip` VALUES ('918', '320481', '', '', '溧阳市', '911');
INSERT INTO `base_zip` VALUES ('919', '320482', '', '', '金坛市', '911');
INSERT INTO `base_zip` VALUES ('920', '320500', '', '苏州市', '', '875');
INSERT INTO `base_zip` VALUES ('921', '320501', '', '', '市辖区', '920');
INSERT INTO `base_zip` VALUES ('922', '320505', '', '', '虎丘区', '920');
INSERT INTO `base_zip` VALUES ('923', '320506', '', '', '吴中区', '920');
INSERT INTO `base_zip` VALUES ('924', '320507', '', '', '相城区', '920');
INSERT INTO `base_zip` VALUES ('925', '320508', '', '', '姑苏区', '920');
INSERT INTO `base_zip` VALUES ('926', '320509', '', '', '吴江区', '920');
INSERT INTO `base_zip` VALUES ('927', '320581', '', '', '常熟市', '920');
INSERT INTO `base_zip` VALUES ('928', '320582', '', '', '张家港市', '920');
INSERT INTO `base_zip` VALUES ('929', '320583', '', '', '昆山市', '920');
INSERT INTO `base_zip` VALUES ('930', '320585', '', '', '太仓市', '920');
INSERT INTO `base_zip` VALUES ('931', '320600', '', '南通市', '', '875');
INSERT INTO `base_zip` VALUES ('932', '320601', '', '', '市辖区', '931');
INSERT INTO `base_zip` VALUES ('933', '320602', '', '', '崇川区', '931');
INSERT INTO `base_zip` VALUES ('934', '320611', '', '', '港闸区', '931');
INSERT INTO `base_zip` VALUES ('935', '320612', '', '', '通州区', '931');
INSERT INTO `base_zip` VALUES ('936', '320621', '', '', '海安县', '931');
INSERT INTO `base_zip` VALUES ('937', '320623', '', '', '如东县', '931');
INSERT INTO `base_zip` VALUES ('938', '320681', '', '', '启东市', '931');
INSERT INTO `base_zip` VALUES ('939', '320682', '', '', '如皋市', '931');
INSERT INTO `base_zip` VALUES ('940', '320684', '', '', '海门市', '931');
INSERT INTO `base_zip` VALUES ('941', '320700', '', '连云港市', '', '875');
INSERT INTO `base_zip` VALUES ('942', '320701', '', '', '市辖区', '941');
INSERT INTO `base_zip` VALUES ('943', '320703', '', '', '连云区', '941');
INSERT INTO `base_zip` VALUES ('944', '320706', '', '', '海州区', '941');
INSERT INTO `base_zip` VALUES ('945', '320707', '', '', '赣榆区', '941');
INSERT INTO `base_zip` VALUES ('946', '320722', '', '', '东海县', '941');
INSERT INTO `base_zip` VALUES ('947', '320723', '', '', '灌云县', '941');
INSERT INTO `base_zip` VALUES ('948', '320724', '', '', '灌南县', '941');
INSERT INTO `base_zip` VALUES ('949', '320800', '', '淮安市', '', '875');
INSERT INTO `base_zip` VALUES ('950', '320801', '', '', '市辖区', '949');
INSERT INTO `base_zip` VALUES ('951', '320802', '', '', '清河区', '949');
INSERT INTO `base_zip` VALUES ('952', '320803', '', '', '淮安区', '949');
INSERT INTO `base_zip` VALUES ('953', '320804', '', '', '淮阴区', '949');
INSERT INTO `base_zip` VALUES ('954', '320811', '', '', '清浦区', '949');
INSERT INTO `base_zip` VALUES ('955', '320826', '', '', '涟水县', '949');
INSERT INTO `base_zip` VALUES ('956', '320829', '', '', '洪泽县', '949');
INSERT INTO `base_zip` VALUES ('957', '320830', '', '', '盱眙县', '949');
INSERT INTO `base_zip` VALUES ('958', '320831', '', '', '金湖县', '949');
INSERT INTO `base_zip` VALUES ('959', '320900', '', '盐城市', '', '875');
INSERT INTO `base_zip` VALUES ('960', '320901', '', '', '市辖区', '959');
INSERT INTO `base_zip` VALUES ('961', '320902', '', '', '亭湖区', '959');
INSERT INTO `base_zip` VALUES ('962', '320903', '', '', '盐都区', '959');
INSERT INTO `base_zip` VALUES ('963', '320921', '', '', '响水县', '959');
INSERT INTO `base_zip` VALUES ('964', '320922', '', '', '滨海县', '959');
INSERT INTO `base_zip` VALUES ('965', '320923', '', '', '阜宁县', '959');
INSERT INTO `base_zip` VALUES ('966', '320924', '', '', '射阳县', '959');
INSERT INTO `base_zip` VALUES ('967', '320925', '', '', '建湖县', '959');
INSERT INTO `base_zip` VALUES ('968', '320981', '', '', '东台市', '959');
INSERT INTO `base_zip` VALUES ('969', '320982', '', '', '大丰市', '959');
INSERT INTO `base_zip` VALUES ('970', '321000', '', '扬州市', '', '875');
INSERT INTO `base_zip` VALUES ('971', '321001', '', '', '市辖区', '970');
INSERT INTO `base_zip` VALUES ('972', '321002', '', '', '广陵区', '970');
INSERT INTO `base_zip` VALUES ('973', '321003', '', '', '邗江区', '970');
INSERT INTO `base_zip` VALUES ('974', '321012', '', '', '江都区', '970');
INSERT INTO `base_zip` VALUES ('975', '321023', '', '', '宝应县', '970');
INSERT INTO `base_zip` VALUES ('976', '321081', '', '', '仪征市', '970');
INSERT INTO `base_zip` VALUES ('977', '321084', '', '', '高邮市', '970');
INSERT INTO `base_zip` VALUES ('978', '321100', '', '镇江市', '', '875');
INSERT INTO `base_zip` VALUES ('979', '321101', '', '', '市辖区', '978');
INSERT INTO `base_zip` VALUES ('980', '321102', '', '', '京口区', '978');
INSERT INTO `base_zip` VALUES ('981', '321111', '', '', '润州区', '978');
INSERT INTO `base_zip` VALUES ('982', '321112', '', '', '丹徒区', '978');
INSERT INTO `base_zip` VALUES ('983', '321181', '', '', '丹阳市', '978');
INSERT INTO `base_zip` VALUES ('984', '321182', '', '', '扬中市', '978');
INSERT INTO `base_zip` VALUES ('985', '321183', '', '', '句容市', '978');
INSERT INTO `base_zip` VALUES ('986', '321200', '', '泰州市', '', '875');
INSERT INTO `base_zip` VALUES ('987', '321201', '', '', '市辖区', '986');
INSERT INTO `base_zip` VALUES ('988', '321202', '', '', '海陵区', '986');
INSERT INTO `base_zip` VALUES ('989', '321203', '', '', '高港区', '986');
INSERT INTO `base_zip` VALUES ('990', '321204', '', '', '姜堰区', '986');
INSERT INTO `base_zip` VALUES ('991', '321281', '', '', '兴化市', '986');
INSERT INTO `base_zip` VALUES ('992', '321282', '', '', '靖江市', '986');
INSERT INTO `base_zip` VALUES ('993', '321283', '', '', '泰兴市', '986');
INSERT INTO `base_zip` VALUES ('994', '321300', '', '宿迁市', '', '875');
INSERT INTO `base_zip` VALUES ('995', '321301', '', '', '市辖区', '994');
INSERT INTO `base_zip` VALUES ('996', '321302', '', '', '宿城区', '994');
INSERT INTO `base_zip` VALUES ('997', '321311', '', '', '宿豫区', '994');
INSERT INTO `base_zip` VALUES ('998', '321322', '', '', '沭阳县', '994');
INSERT INTO `base_zip` VALUES ('999', '321323', '', '', '泗阳县', '994');
INSERT INTO `base_zip` VALUES ('1000', '321324', '', '', '泗洪县', '994');
INSERT INTO `base_zip` VALUES ('1001', '330000', '浙江省', '', '', '1');
INSERT INTO `base_zip` VALUES ('1002', '330100', '', '杭州市', '', '1001');
INSERT INTO `base_zip` VALUES ('1003', '330101', '', '', '市辖区', '1002');
INSERT INTO `base_zip` VALUES ('1004', '330102', '', '', '上城区', '1002');
INSERT INTO `base_zip` VALUES ('1005', '330103', '', '', '下城区', '1002');
INSERT INTO `base_zip` VALUES ('1006', '330104', '', '', '江干区', '1002');
INSERT INTO `base_zip` VALUES ('1007', '330105', '', '', '拱墅区', '1002');
INSERT INTO `base_zip` VALUES ('1008', '330106', '', '', '西湖区', '1002');
INSERT INTO `base_zip` VALUES ('1009', '330108', '', '', '滨江区', '1002');
INSERT INTO `base_zip` VALUES ('1010', '330109', '', '', '萧山区', '1002');
INSERT INTO `base_zip` VALUES ('1011', '330110', '', '', '余杭区', '1002');
INSERT INTO `base_zip` VALUES ('1012', '330111', '', '', '富阳区', '1002');
INSERT INTO `base_zip` VALUES ('1013', '330122', '', '', '桐庐县', '1002');
INSERT INTO `base_zip` VALUES ('1014', '330127', '', '', '淳安县', '1002');
INSERT INTO `base_zip` VALUES ('1015', '330182', '', '', '建德市', '1002');
INSERT INTO `base_zip` VALUES ('1016', '330185', '', '', '临安市', '1002');
INSERT INTO `base_zip` VALUES ('1017', '330200', '', '宁波市', '', '1001');
INSERT INTO `base_zip` VALUES ('1018', '330201', '', '', '市辖区', '1017');
INSERT INTO `base_zip` VALUES ('1019', '330203', '', '', '海曙区', '1017');
INSERT INTO `base_zip` VALUES ('1020', '330204', '', '', '江东区', '1017');
INSERT INTO `base_zip` VALUES ('1021', '330205', '', '', '江北区', '1017');
INSERT INTO `base_zip` VALUES ('1022', '330206', '', '', '北仑区', '1017');
INSERT INTO `base_zip` VALUES ('1023', '330211', '', '', '镇海区', '1017');
INSERT INTO `base_zip` VALUES ('1024', '330212', '', '', '鄞州区', '1017');
INSERT INTO `base_zip` VALUES ('1025', '330225', '', '', '象山县', '1017');
INSERT INTO `base_zip` VALUES ('1026', '330226', '', '', '宁海县', '1017');
INSERT INTO `base_zip` VALUES ('1027', '330281', '', '', '余姚市', '1017');
INSERT INTO `base_zip` VALUES ('1028', '330282', '', '', '慈溪市', '1017');
INSERT INTO `base_zip` VALUES ('1029', '330283', '', '', '奉化市', '1017');
INSERT INTO `base_zip` VALUES ('1030', '330300', '', '温州市', '', '1001');
INSERT INTO `base_zip` VALUES ('1031', '330301', '', '', '市辖区', '1030');
INSERT INTO `base_zip` VALUES ('1032', '330302', '', '', '鹿城区', '1030');
INSERT INTO `base_zip` VALUES ('1033', '330303', '', '', '龙湾区', '1030');
INSERT INTO `base_zip` VALUES ('1034', '330304', '', '', '瓯海区', '1030');
INSERT INTO `base_zip` VALUES ('1035', '330322', '', '', '洞头县', '1030');
INSERT INTO `base_zip` VALUES ('1036', '330324', '', '', '永嘉县', '1030');
INSERT INTO `base_zip` VALUES ('1037', '330326', '', '', '平阳县', '1030');
INSERT INTO `base_zip` VALUES ('1038', '330327', '', '', '苍南县', '1030');
INSERT INTO `base_zip` VALUES ('1039', '330328', '', '', '文成县', '1030');
INSERT INTO `base_zip` VALUES ('1040', '330329', '', '', '泰顺县', '1030');
INSERT INTO `base_zip` VALUES ('1041', '330381', '', '', '瑞安市', '1030');
INSERT INTO `base_zip` VALUES ('1042', '330382', '', '', '乐清市', '1030');
INSERT INTO `base_zip` VALUES ('1043', '330400', '', '嘉兴市', '', '1001');
INSERT INTO `base_zip` VALUES ('1044', '330401', '', '', '市辖区', '1043');
INSERT INTO `base_zip` VALUES ('1045', '330402', '', '', '南湖区', '1043');
INSERT INTO `base_zip` VALUES ('1046', '330411', '', '', '秀洲区', '1043');
INSERT INTO `base_zip` VALUES ('1047', '330421', '', '', '嘉善县', '1043');
INSERT INTO `base_zip` VALUES ('1048', '330424', '', '', '海盐县', '1043');
INSERT INTO `base_zip` VALUES ('1049', '330481', '', '', '海宁市', '1043');
INSERT INTO `base_zip` VALUES ('1050', '330482', '', '', '平湖市', '1043');
INSERT INTO `base_zip` VALUES ('1051', '330483', '', '', '桐乡市', '1043');
INSERT INTO `base_zip` VALUES ('1052', '330500', '', '湖州市', '', '1001');
INSERT INTO `base_zip` VALUES ('1053', '330501', '', '', '市辖区', '1052');
INSERT INTO `base_zip` VALUES ('1054', '330502', '', '', '吴兴区', '1052');
INSERT INTO `base_zip` VALUES ('1055', '330503', '', '', '南浔区', '1052');
INSERT INTO `base_zip` VALUES ('1056', '330521', '', '', '德清县', '1052');
INSERT INTO `base_zip` VALUES ('1057', '330522', '', '', '长兴县', '1052');
INSERT INTO `base_zip` VALUES ('1058', '330523', '', '', '安吉县', '1052');
INSERT INTO `base_zip` VALUES ('1059', '330600', '', '绍兴市', '', '1001');
INSERT INTO `base_zip` VALUES ('1060', '330601', '', '', '市辖区', '1059');
INSERT INTO `base_zip` VALUES ('1061', '330602', '', '', '越城区', '1059');
INSERT INTO `base_zip` VALUES ('1062', '330603', '', '', '柯桥区', '1059');
INSERT INTO `base_zip` VALUES ('1063', '330604', '', '', '上虞区', '1059');
INSERT INTO `base_zip` VALUES ('1064', '330624', '', '', '新昌县', '1059');
INSERT INTO `base_zip` VALUES ('1065', '330681', '', '', '诸暨市', '1059');
INSERT INTO `base_zip` VALUES ('1066', '330683', '', '', '嵊州市', '1059');
INSERT INTO `base_zip` VALUES ('1067', '330700', '', '金华市', '', '1001');
INSERT INTO `base_zip` VALUES ('1068', '330701', '', '', '市辖区', '1067');
INSERT INTO `base_zip` VALUES ('1069', '330702', '', '', '婺城区', '1067');
INSERT INTO `base_zip` VALUES ('1070', '330703', '', '', '金东区', '1067');
INSERT INTO `base_zip` VALUES ('1071', '330723', '', '', '武义县', '1067');
INSERT INTO `base_zip` VALUES ('1072', '330726', '', '', '浦江县', '1067');
INSERT INTO `base_zip` VALUES ('1073', '330727', '', '', '磐安县', '1067');
INSERT INTO `base_zip` VALUES ('1074', '330781', '', '', '兰溪市', '1067');
INSERT INTO `base_zip` VALUES ('1075', '330782', '', '', '义乌市', '1067');
INSERT INTO `base_zip` VALUES ('1076', '330783', '', '', '东阳市', '1067');
INSERT INTO `base_zip` VALUES ('1077', '330784', '', '', '永康市', '1067');
INSERT INTO `base_zip` VALUES ('1078', '330800', '', '衢州市', '', '1001');
INSERT INTO `base_zip` VALUES ('1079', '330801', '', '', '市辖区', '1078');
INSERT INTO `base_zip` VALUES ('1080', '330802', '', '', '柯城区', '1078');
INSERT INTO `base_zip` VALUES ('1081', '330803', '', '', '衢江区', '1078');
INSERT INTO `base_zip` VALUES ('1082', '330822', '', '', '常山县', '1078');
INSERT INTO `base_zip` VALUES ('1083', '330824', '', '', '开化县', '1078');
INSERT INTO `base_zip` VALUES ('1084', '330825', '', '', '龙游县', '1078');
INSERT INTO `base_zip` VALUES ('1085', '330881', '', '', '江山市', '1078');
INSERT INTO `base_zip` VALUES ('1086', '330900', '', '舟山市', '', '1001');
INSERT INTO `base_zip` VALUES ('1087', '330901', '', '', '市辖区', '1086');
INSERT INTO `base_zip` VALUES ('1088', '330902', '', '', '定海区', '1086');
INSERT INTO `base_zip` VALUES ('1089', '330903', '', '', '普陀区', '1086');
INSERT INTO `base_zip` VALUES ('1090', '330921', '', '', '岱山县', '1086');
INSERT INTO `base_zip` VALUES ('1091', '330922', '', '', '嵊泗县', '1086');
INSERT INTO `base_zip` VALUES ('1092', '331000', '', '台州市', '', '1001');
INSERT INTO `base_zip` VALUES ('1093', '331001', '', '', '市辖区', '1092');
INSERT INTO `base_zip` VALUES ('1094', '331002', '', '', '椒江区', '1092');
INSERT INTO `base_zip` VALUES ('1095', '331003', '', '', '黄岩区', '1092');
INSERT INTO `base_zip` VALUES ('1096', '331004', '', '', '路桥区', '1092');
INSERT INTO `base_zip` VALUES ('1097', '331021', '', '', '玉环县', '1092');
INSERT INTO `base_zip` VALUES ('1098', '331022', '', '', '三门县', '1092');
INSERT INTO `base_zip` VALUES ('1099', '331023', '', '', '天台县', '1092');
INSERT INTO `base_zip` VALUES ('1100', '331024', '', '', '仙居县', '1092');
INSERT INTO `base_zip` VALUES ('1101', '331081', '', '', '温岭市', '1092');
INSERT INTO `base_zip` VALUES ('1102', '331082', '', '', '临海市', '1092');
INSERT INTO `base_zip` VALUES ('1103', '331100', '', '丽水市', '', '1001');
INSERT INTO `base_zip` VALUES ('1104', '331101', '', '', '市辖区', '1103');
INSERT INTO `base_zip` VALUES ('1105', '331102', '', '', '莲都区', '1103');
INSERT INTO `base_zip` VALUES ('1106', '331121', '', '', '青田县', '1103');
INSERT INTO `base_zip` VALUES ('1107', '331122', '', '', '缙云县', '1103');
INSERT INTO `base_zip` VALUES ('1108', '331123', '', '', '遂昌县', '1103');
INSERT INTO `base_zip` VALUES ('1109', '331124', '', '', '松阳县', '1103');
INSERT INTO `base_zip` VALUES ('1110', '331125', '', '', '云和县', '1103');
INSERT INTO `base_zip` VALUES ('1111', '331126', '', '', '庆元县', '1103');
INSERT INTO `base_zip` VALUES ('1112', '331127', '', '', '景宁畲族自治县', '1103');
INSERT INTO `base_zip` VALUES ('1113', '331181', '', '', '龙泉市', '1103');
INSERT INTO `base_zip` VALUES ('1114', '340000', '安徽省', '', '', '1');
INSERT INTO `base_zip` VALUES ('1115', '340100', '', '合肥市', '', '1114');
INSERT INTO `base_zip` VALUES ('1116', '340101', '', '', '市辖区', '1115');
INSERT INTO `base_zip` VALUES ('1117', '340102', '', '', '瑶海区', '1115');
INSERT INTO `base_zip` VALUES ('1118', '340103', '', '', '庐阳区', '1115');
INSERT INTO `base_zip` VALUES ('1119', '340104', '', '', '蜀山区', '1115');
INSERT INTO `base_zip` VALUES ('1120', '340111', '', '', '包河区', '1115');
INSERT INTO `base_zip` VALUES ('1121', '340121', '', '', '长丰县', '1115');
INSERT INTO `base_zip` VALUES ('1122', '340122', '', '', '肥东县', '1115');
INSERT INTO `base_zip` VALUES ('1123', '340123', '', '', '肥西县', '1115');
INSERT INTO `base_zip` VALUES ('1124', '340124', '', '', '庐江县', '1115');
INSERT INTO `base_zip` VALUES ('1125', '340181', '', '', '巢湖市', '1115');
INSERT INTO `base_zip` VALUES ('1126', '340200', '', '芜湖市', '', '1114');
INSERT INTO `base_zip` VALUES ('1127', '340201', '', '', '市辖区', '1126');
INSERT INTO `base_zip` VALUES ('1128', '340202', '', '', '镜湖区', '1126');
INSERT INTO `base_zip` VALUES ('1129', '340203', '', '', '弋江区', '1126');
INSERT INTO `base_zip` VALUES ('1130', '340207', '', '', '鸠江区', '1126');
INSERT INTO `base_zip` VALUES ('1131', '340208', '', '', '三山区', '1126');
INSERT INTO `base_zip` VALUES ('1132', '340221', '', '', '芜湖县', '1126');
INSERT INTO `base_zip` VALUES ('1133', '340222', '', '', '繁昌县', '1126');
INSERT INTO `base_zip` VALUES ('1134', '340223', '', '', '南陵县', '1126');
INSERT INTO `base_zip` VALUES ('1135', '340225', '', '', '无为县', '1126');
INSERT INTO `base_zip` VALUES ('1136', '340300', '', '蚌埠市', '', '1114');
INSERT INTO `base_zip` VALUES ('1137', '340301', '', '', '市辖区', '1136');
INSERT INTO `base_zip` VALUES ('1138', '340302', '', '', '龙子湖区', '1136');
INSERT INTO `base_zip` VALUES ('1139', '340303', '', '', '蚌山区', '1136');
INSERT INTO `base_zip` VALUES ('1140', '340304', '', '', '禹会区', '1136');
INSERT INTO `base_zip` VALUES ('1141', '340311', '', '', '淮上区', '1136');
INSERT INTO `base_zip` VALUES ('1142', '340321', '', '', '怀远县', '1136');
INSERT INTO `base_zip` VALUES ('1143', '340322', '', '', '五河县', '1136');
INSERT INTO `base_zip` VALUES ('1144', '340323', '', '', '固镇县', '1136');
INSERT INTO `base_zip` VALUES ('1145', '340400', '', '淮南市', '', '1114');
INSERT INTO `base_zip` VALUES ('1146', '340401', '', '', '市辖区', '1145');
INSERT INTO `base_zip` VALUES ('1147', '340402', '', '', '大通区', '1145');
INSERT INTO `base_zip` VALUES ('1148', '340403', '', '', '田家庵区', '1145');
INSERT INTO `base_zip` VALUES ('1149', '340404', '', '', '谢家集区', '1145');
INSERT INTO `base_zip` VALUES ('1150', '340405', '', '', '八公山区', '1145');
INSERT INTO `base_zip` VALUES ('1151', '340406', '', '', '潘集区', '1145');
INSERT INTO `base_zip` VALUES ('1152', '340421', '', '', '凤台县', '1145');
INSERT INTO `base_zip` VALUES ('1153', '340500', '', '马鞍山市', '', '1114');
INSERT INTO `base_zip` VALUES ('1154', '340501', '', '', '市辖区', '1153');
INSERT INTO `base_zip` VALUES ('1155', '340503', '', '', '花山区', '1153');
INSERT INTO `base_zip` VALUES ('1156', '340504', '', '', '雨山区', '1153');
INSERT INTO `base_zip` VALUES ('1157', '340506', '', '', '博望区', '1153');
INSERT INTO `base_zip` VALUES ('1158', '340521', '', '', '当涂县', '1153');
INSERT INTO `base_zip` VALUES ('1159', '340522', '', '', '含山县', '1153');
INSERT INTO `base_zip` VALUES ('1160', '340523', '', '', '和县', '1153');
INSERT INTO `base_zip` VALUES ('1161', '340600', '', '淮北市', '', '1114');
INSERT INTO `base_zip` VALUES ('1162', '340601', '', '', '市辖区', '1161');
INSERT INTO `base_zip` VALUES ('1163', '340602', '', '', '杜集区', '1161');
INSERT INTO `base_zip` VALUES ('1164', '340603', '', '', '相山区', '1161');
INSERT INTO `base_zip` VALUES ('1165', '340604', '', '', '烈山区', '1161');
INSERT INTO `base_zip` VALUES ('1166', '340621', '', '', '濉溪县', '1161');
INSERT INTO `base_zip` VALUES ('1167', '340700', '', '铜陵市', '', '1114');
INSERT INTO `base_zip` VALUES ('1168', '340701', '', '', '市辖区', '1167');
INSERT INTO `base_zip` VALUES ('1169', '340702', '', '', '铜官山区', '1167');
INSERT INTO `base_zip` VALUES ('1170', '340703', '', '', '狮子山区', '1167');
INSERT INTO `base_zip` VALUES ('1171', '340711', '', '', '郊区', '1167');
INSERT INTO `base_zip` VALUES ('1172', '340721', '', '', '铜陵县', '1167');
INSERT INTO `base_zip` VALUES ('1173', '340800', '', '安庆市', '', '1114');
INSERT INTO `base_zip` VALUES ('1174', '340801', '', '', '市辖区', '1173');
INSERT INTO `base_zip` VALUES ('1175', '340802', '', '', '迎江区', '1173');
INSERT INTO `base_zip` VALUES ('1176', '340803', '', '', '大观区', '1173');
INSERT INTO `base_zip` VALUES ('1177', '340811', '', '', '宜秀区', '1173');
INSERT INTO `base_zip` VALUES ('1178', '340822', '', '', '怀宁县', '1173');
INSERT INTO `base_zip` VALUES ('1179', '340823', '', '', '枞阳县', '1173');
INSERT INTO `base_zip` VALUES ('1180', '340824', '', '', '潜山县', '1173');
INSERT INTO `base_zip` VALUES ('1181', '340825', '', '', '太湖县', '1173');
INSERT INTO `base_zip` VALUES ('1182', '340826', '', '', '宿松县', '1173');
INSERT INTO `base_zip` VALUES ('1183', '340827', '', '', '望江县', '1173');
INSERT INTO `base_zip` VALUES ('1184', '340828', '', '', '岳西县', '1173');
INSERT INTO `base_zip` VALUES ('1185', '340881', '', '', '桐城市', '1173');
INSERT INTO `base_zip` VALUES ('1186', '341000', '', '黄山市', '', '1114');
INSERT INTO `base_zip` VALUES ('1187', '341001', '', '', '市辖区', '1186');
INSERT INTO `base_zip` VALUES ('1188', '341002', '', '', '屯溪区', '1186');
INSERT INTO `base_zip` VALUES ('1189', '341003', '', '', '黄山区', '1186');
INSERT INTO `base_zip` VALUES ('1190', '341004', '', '', '徽州区', '1186');
INSERT INTO `base_zip` VALUES ('1191', '341021', '', '', '歙县', '1186');
INSERT INTO `base_zip` VALUES ('1192', '341022', '', '', '休宁县', '1186');
INSERT INTO `base_zip` VALUES ('1193', '341023', '', '', '黟县', '1186');
INSERT INTO `base_zip` VALUES ('1194', '341024', '', '', '祁门县', '1186');
INSERT INTO `base_zip` VALUES ('1195', '341100', '', '滁州市', '', '1114');
INSERT INTO `base_zip` VALUES ('1196', '341101', '', '', '市辖区', '1195');
INSERT INTO `base_zip` VALUES ('1197', '341102', '', '', '琅琊区', '1195');
INSERT INTO `base_zip` VALUES ('1198', '341103', '', '', '南谯区', '1195');
INSERT INTO `base_zip` VALUES ('1199', '341122', '', '', '来安县', '1195');
INSERT INTO `base_zip` VALUES ('1200', '341124', '', '', '全椒县', '1195');
INSERT INTO `base_zip` VALUES ('1201', '341125', '', '', '定远县', '1195');
INSERT INTO `base_zip` VALUES ('1202', '341126', '', '', '凤阳县', '1195');
INSERT INTO `base_zip` VALUES ('1203', '341181', '', '', '天长市', '1195');
INSERT INTO `base_zip` VALUES ('1204', '341182', '', '', '明光市', '1195');
INSERT INTO `base_zip` VALUES ('1205', '341200', '', '阜阳市', '', '1114');
INSERT INTO `base_zip` VALUES ('1206', '341201', '', '', '市辖区', '1205');
INSERT INTO `base_zip` VALUES ('1207', '341202', '', '', '颍州区', '1205');
INSERT INTO `base_zip` VALUES ('1208', '341203', '', '', '颍东区', '1205');
INSERT INTO `base_zip` VALUES ('1209', '341204', '', '', '颍泉区', '1205');
INSERT INTO `base_zip` VALUES ('1210', '341221', '', '', '临泉县', '1205');
INSERT INTO `base_zip` VALUES ('1211', '341222', '', '', '太和县', '1205');
INSERT INTO `base_zip` VALUES ('1212', '341225', '', '', '阜南县', '1205');
INSERT INTO `base_zip` VALUES ('1213', '341226', '', '', '颍上县', '1205');
INSERT INTO `base_zip` VALUES ('1214', '341282', '', '', '界首市', '1205');
INSERT INTO `base_zip` VALUES ('1215', '341300', '', '宿州市', '', '1114');
INSERT INTO `base_zip` VALUES ('1216', '341301', '', '', '市辖区', '1215');
INSERT INTO `base_zip` VALUES ('1217', '341302', '', '', '埇桥区', '1215');
INSERT INTO `base_zip` VALUES ('1218', '341321', '', '', '砀山县', '1215');
INSERT INTO `base_zip` VALUES ('1219', '341322', '', '', '萧县', '1215');
INSERT INTO `base_zip` VALUES ('1220', '341323', '', '', '灵璧县', '1215');
INSERT INTO `base_zip` VALUES ('1221', '341324', '', '', '泗县', '1215');
INSERT INTO `base_zip` VALUES ('1222', '341500', '', '六安市', '', '1114');
INSERT INTO `base_zip` VALUES ('1223', '341501', '', '', '市辖区', '1222');
INSERT INTO `base_zip` VALUES ('1224', '341502', '', '', '金安区', '1222');
INSERT INTO `base_zip` VALUES ('1225', '341503', '', '', '裕安区', '1222');
INSERT INTO `base_zip` VALUES ('1226', '341521', '', '', '寿县', '1222');
INSERT INTO `base_zip` VALUES ('1227', '341522', '', '', '霍邱县', '1222');
INSERT INTO `base_zip` VALUES ('1228', '341523', '', '', '舒城县', '1222');
INSERT INTO `base_zip` VALUES ('1229', '341524', '', '', '金寨县', '1222');
INSERT INTO `base_zip` VALUES ('1230', '341525', '', '', '霍山县', '1222');
INSERT INTO `base_zip` VALUES ('1231', '341600', '', '亳州市', '', '1114');
INSERT INTO `base_zip` VALUES ('1232', '341601', '', '', '市辖区', '1231');
INSERT INTO `base_zip` VALUES ('1233', '341602', '', '', '谯城区', '1231');
INSERT INTO `base_zip` VALUES ('1234', '341621', '', '', '涡阳县', '1231');
INSERT INTO `base_zip` VALUES ('1235', '341622', '', '', '蒙城县', '1231');
INSERT INTO `base_zip` VALUES ('1236', '341623', '', '', '利辛县', '1231');
INSERT INTO `base_zip` VALUES ('1237', '341700', '', '池州市', '', '1114');
INSERT INTO `base_zip` VALUES ('1238', '341701', '', '', '市辖区', '1237');
INSERT INTO `base_zip` VALUES ('1239', '341702', '', '', '贵池区', '1237');
INSERT INTO `base_zip` VALUES ('1240', '341721', '', '', '东至县', '1237');
INSERT INTO `base_zip` VALUES ('1241', '341722', '', '', '石台县', '1237');
INSERT INTO `base_zip` VALUES ('1242', '341723', '', '', '青阳县', '1237');
INSERT INTO `base_zip` VALUES ('1243', '341800', '', '宣城市', '', '1114');
INSERT INTO `base_zip` VALUES ('1244', '341801', '', '', '市辖区', '1243');
INSERT INTO `base_zip` VALUES ('1245', '341802', '', '', '宣州区', '1243');
INSERT INTO `base_zip` VALUES ('1246', '341821', '', '', '郎溪县', '1243');
INSERT INTO `base_zip` VALUES ('1247', '341822', '', '', '广德县', '1243');
INSERT INTO `base_zip` VALUES ('1248', '341823', '', '', '泾县', '1243');
INSERT INTO `base_zip` VALUES ('1249', '341824', '', '', '绩溪县', '1243');
INSERT INTO `base_zip` VALUES ('1250', '341825', '', '', '旌德县', '1243');
INSERT INTO `base_zip` VALUES ('1251', '341881', '', '', '宁国市', '1243');
INSERT INTO `base_zip` VALUES ('1252', '350000', '福建省', '', '', '1');
INSERT INTO `base_zip` VALUES ('1253', '350100', '', '福州市', '', '1252');
INSERT INTO `base_zip` VALUES ('1254', '350101', '', '', '市辖区', '1253');
INSERT INTO `base_zip` VALUES ('1255', '350102', '', '', '鼓楼区', '1253');
INSERT INTO `base_zip` VALUES ('1256', '350103', '', '', '台江区', '1253');
INSERT INTO `base_zip` VALUES ('1257', '350104', '', '', '仓山区', '1253');
INSERT INTO `base_zip` VALUES ('1258', '350105', '', '', '马尾区', '1253');
INSERT INTO `base_zip` VALUES ('1259', '350111', '', '', '晋安区', '1253');
INSERT INTO `base_zip` VALUES ('1260', '350121', '', '', '闽侯县', '1253');
INSERT INTO `base_zip` VALUES ('1261', '350122', '', '', '连江县', '1253');
INSERT INTO `base_zip` VALUES ('1262', '350123', '', '', '罗源县', '1253');
INSERT INTO `base_zip` VALUES ('1263', '350124', '', '', '闽清县', '1253');
INSERT INTO `base_zip` VALUES ('1264', '350125', '', '', '永泰县', '1253');
INSERT INTO `base_zip` VALUES ('1265', '350128', '', '', '平潭县', '1253');
INSERT INTO `base_zip` VALUES ('1266', '350181', '', '', '福清市', '1253');
INSERT INTO `base_zip` VALUES ('1267', '350182', '', '', '长乐市', '1253');
INSERT INTO `base_zip` VALUES ('1268', '350200', '', '厦门市', '', '1252');
INSERT INTO `base_zip` VALUES ('1269', '350201', '', '', '市辖区', '1268');
INSERT INTO `base_zip` VALUES ('1270', '350203', '', '', '思明区', '1268');
INSERT INTO `base_zip` VALUES ('1271', '350205', '', '', '海沧区', '1268');
INSERT INTO `base_zip` VALUES ('1272', '350206', '', '', '湖里区', '1268');
INSERT INTO `base_zip` VALUES ('1273', '350211', '', '', '集美区', '1268');
INSERT INTO `base_zip` VALUES ('1274', '350212', '', '', '同安区', '1268');
INSERT INTO `base_zip` VALUES ('1275', '350213', '', '', '翔安区', '1268');
INSERT INTO `base_zip` VALUES ('1276', '350300', '', '莆田市', '', '1252');
INSERT INTO `base_zip` VALUES ('1277', '350301', '', '', '市辖区', '1276');
INSERT INTO `base_zip` VALUES ('1278', '350302', '', '', '城厢区', '1276');
INSERT INTO `base_zip` VALUES ('1279', '350303', '', '', '涵江区', '1276');
INSERT INTO `base_zip` VALUES ('1280', '350304', '', '', '荔城区', '1276');
INSERT INTO `base_zip` VALUES ('1281', '350305', '', '', '秀屿区', '1276');
INSERT INTO `base_zip` VALUES ('1282', '350322', '', '', '仙游县', '1276');
INSERT INTO `base_zip` VALUES ('1283', '350400', '', '三明市', '', '1252');
INSERT INTO `base_zip` VALUES ('1284', '350401', '', '', '市辖区', '1283');
INSERT INTO `base_zip` VALUES ('1285', '350402', '', '', '梅列区', '1283');
INSERT INTO `base_zip` VALUES ('1286', '350403', '', '', '三元区', '1283');
INSERT INTO `base_zip` VALUES ('1287', '350421', '', '', '明溪县', '1283');
INSERT INTO `base_zip` VALUES ('1288', '350423', '', '', '清流县', '1283');
INSERT INTO `base_zip` VALUES ('1289', '350424', '', '', '宁化县', '1283');
INSERT INTO `base_zip` VALUES ('1290', '350425', '', '', '大田县', '1283');
INSERT INTO `base_zip` VALUES ('1291', '350426', '', '', '尤溪县', '1283');
INSERT INTO `base_zip` VALUES ('1292', '350427', '', '', '沙县', '1283');
INSERT INTO `base_zip` VALUES ('1293', '350428', '', '', '将乐县', '1283');
INSERT INTO `base_zip` VALUES ('1294', '350429', '', '', '泰宁县', '1283');
INSERT INTO `base_zip` VALUES ('1295', '350430', '', '', '建宁县', '1283');
INSERT INTO `base_zip` VALUES ('1296', '350481', '', '', '永安市', '1283');
INSERT INTO `base_zip` VALUES ('1297', '350500', '', '泉州市', '', '1252');
INSERT INTO `base_zip` VALUES ('1298', '350501', '', '', '市辖区', '1297');
INSERT INTO `base_zip` VALUES ('1299', '350502', '', '', '鲤城区', '1297');
INSERT INTO `base_zip` VALUES ('1300', '350503', '', '', '丰泽区', '1297');
INSERT INTO `base_zip` VALUES ('1301', '350504', '', '', '洛江区', '1297');
INSERT INTO `base_zip` VALUES ('1302', '350505', '', '', '泉港区', '1297');
INSERT INTO `base_zip` VALUES ('1303', '350521', '', '', '惠安县', '1297');
INSERT INTO `base_zip` VALUES ('1304', '350524', '', '', '安溪县', '1297');
INSERT INTO `base_zip` VALUES ('1305', '350525', '', '', '永春县', '1297');
INSERT INTO `base_zip` VALUES ('1306', '350526', '', '', '德化县', '1297');
INSERT INTO `base_zip` VALUES ('1307', '350527', '', '', '金门县', '1297');
INSERT INTO `base_zip` VALUES ('1308', '350581', '', '', '石狮市', '1297');
INSERT INTO `base_zip` VALUES ('1309', '350582', '', '', '晋江市', '1297');
INSERT INTO `base_zip` VALUES ('1310', '350583', '', '', '南安市', '1297');
INSERT INTO `base_zip` VALUES ('1311', '350600', '', '漳州市', '', '1252');
INSERT INTO `base_zip` VALUES ('1312', '350601', '', '', '市辖区', '1311');
INSERT INTO `base_zip` VALUES ('1313', '350602', '', '', '芗城区', '1311');
INSERT INTO `base_zip` VALUES ('1314', '350603', '', '', '龙文区', '1311');
INSERT INTO `base_zip` VALUES ('1315', '350622', '', '', '云霄县', '1311');
INSERT INTO `base_zip` VALUES ('1316', '350623', '', '', '漳浦县', '1311');
INSERT INTO `base_zip` VALUES ('1317', '350624', '', '', '诏安县', '1311');
INSERT INTO `base_zip` VALUES ('1318', '350625', '', '', '长泰县', '1311');
INSERT INTO `base_zip` VALUES ('1319', '350626', '', '', '东山县', '1311');
INSERT INTO `base_zip` VALUES ('1320', '350627', '', '', '南靖县', '1311');
INSERT INTO `base_zip` VALUES ('1321', '350628', '', '', '平和县', '1311');
INSERT INTO `base_zip` VALUES ('1322', '350629', '', '', '华安县', '1311');
INSERT INTO `base_zip` VALUES ('1323', '350681', '', '', '龙海市', '1311');
INSERT INTO `base_zip` VALUES ('1324', '350700', '', '南平市', '', '1252');
INSERT INTO `base_zip` VALUES ('1325', '350701', '', '', '市辖区', '1324');
INSERT INTO `base_zip` VALUES ('1326', '350702', '', '', '延平区', '1324');
INSERT INTO `base_zip` VALUES ('1327', '350703', '', '', '建阳区', '1324');
INSERT INTO `base_zip` VALUES ('1328', '350721', '', '', '顺昌县', '1324');
INSERT INTO `base_zip` VALUES ('1329', '350722', '', '', '浦城县', '1324');
INSERT INTO `base_zip` VALUES ('1330', '350723', '', '', '光泽县', '1324');
INSERT INTO `base_zip` VALUES ('1331', '350724', '', '', '松溪县', '1324');
INSERT INTO `base_zip` VALUES ('1332', '350725', '', '', '政和县', '1324');
INSERT INTO `base_zip` VALUES ('1333', '350781', '', '', '邵武市', '1324');
INSERT INTO `base_zip` VALUES ('1334', '350782', '', '', '武夷山市', '1324');
INSERT INTO `base_zip` VALUES ('1335', '350783', '', '', '建瓯市', '1324');
INSERT INTO `base_zip` VALUES ('1336', '350800', '', '龙岩市', '', '1252');
INSERT INTO `base_zip` VALUES ('1337', '350801', '', '', '市辖区', '1336');
INSERT INTO `base_zip` VALUES ('1338', '350802', '', '', '新罗区', '1336');
INSERT INTO `base_zip` VALUES ('1339', '350803', '', '', '永定区', '1336');
INSERT INTO `base_zip` VALUES ('1340', '350821', '', '', '长汀县', '1336');
INSERT INTO `base_zip` VALUES ('1341', '350823', '', '', '上杭县', '1336');
INSERT INTO `base_zip` VALUES ('1342', '350824', '', '', '武平县', '1336');
INSERT INTO `base_zip` VALUES ('1343', '350825', '', '', '连城县', '1336');
INSERT INTO `base_zip` VALUES ('1344', '350881', '', '', '漳平市', '1336');
INSERT INTO `base_zip` VALUES ('1345', '350900', '', '宁德市', '', '1252');
INSERT INTO `base_zip` VALUES ('1346', '350901', '', '', '市辖区', '1345');
INSERT INTO `base_zip` VALUES ('1347', '350902', '', '', '蕉城区', '1345');
INSERT INTO `base_zip` VALUES ('1348', '350921', '', '', '霞浦县', '1345');
INSERT INTO `base_zip` VALUES ('1349', '350922', '', '', '古田县', '1345');
INSERT INTO `base_zip` VALUES ('1350', '350923', '', '', '屏南县', '1345');
INSERT INTO `base_zip` VALUES ('1351', '350924', '', '', '寿宁县', '1345');
INSERT INTO `base_zip` VALUES ('1352', '350925', '', '', '周宁县', '1345');
INSERT INTO `base_zip` VALUES ('1353', '350926', '', '', '柘荣县', '1345');
INSERT INTO `base_zip` VALUES ('1354', '350981', '', '', '福安市', '1345');
INSERT INTO `base_zip` VALUES ('1355', '350982', '', '', '福鼎市', '1345');
INSERT INTO `base_zip` VALUES ('1356', '360000', '江西省', '', '', '1');
INSERT INTO `base_zip` VALUES ('1357', '360100', '', '南昌市', '', '1356');
INSERT INTO `base_zip` VALUES ('1358', '360101', '', '', '市辖区', '1357');
INSERT INTO `base_zip` VALUES ('1359', '360102', '', '', '东湖区', '1357');
INSERT INTO `base_zip` VALUES ('1360', '360103', '', '', '西湖区', '1357');
INSERT INTO `base_zip` VALUES ('1361', '360104', '', '', '青云谱区', '1357');
INSERT INTO `base_zip` VALUES ('1362', '360105', '', '', '湾里区', '1357');
INSERT INTO `base_zip` VALUES ('1363', '360111', '', '', '青山湖区', '1357');
INSERT INTO `base_zip` VALUES ('1364', '360121', '', '', '南昌县', '1357');
INSERT INTO `base_zip` VALUES ('1365', '360122', '', '', '新建县', '1357');
INSERT INTO `base_zip` VALUES ('1366', '360123', '', '', '安义县', '1357');
INSERT INTO `base_zip` VALUES ('1367', '360124', '', '', '进贤县', '1357');
INSERT INTO `base_zip` VALUES ('1368', '360200', '', '景德镇市', '', '1356');
INSERT INTO `base_zip` VALUES ('1369', '360201', '', '', '市辖区', '1368');
INSERT INTO `base_zip` VALUES ('1370', '360202', '', '', '昌江区', '1368');
INSERT INTO `base_zip` VALUES ('1371', '360203', '', '', '珠山区', '1368');
INSERT INTO `base_zip` VALUES ('1372', '360222', '', '', '浮梁县', '1368');
INSERT INTO `base_zip` VALUES ('1373', '360281', '', '', '乐平市', '1368');
INSERT INTO `base_zip` VALUES ('1374', '360300', '', '萍乡市', '', '1356');
INSERT INTO `base_zip` VALUES ('1375', '360301', '', '', '市辖区', '1374');
INSERT INTO `base_zip` VALUES ('1376', '360302', '', '', '安源区', '1374');
INSERT INTO `base_zip` VALUES ('1377', '360313', '', '', '湘东区', '1374');
INSERT INTO `base_zip` VALUES ('1378', '360321', '', '', '莲花县', '1374');
INSERT INTO `base_zip` VALUES ('1379', '360322', '', '', '上栗县', '1374');
INSERT INTO `base_zip` VALUES ('1380', '360323', '', '', '芦溪县', '1374');
INSERT INTO `base_zip` VALUES ('1381', '360400', '', '九江市', '', '1356');
INSERT INTO `base_zip` VALUES ('1382', '360401', '', '', '市辖区', '1381');
INSERT INTO `base_zip` VALUES ('1383', '360402', '', '', '庐山区', '1381');
INSERT INTO `base_zip` VALUES ('1384', '360403', '', '', '浔阳区', '1381');
INSERT INTO `base_zip` VALUES ('1385', '360421', '', '', '九江县', '1381');
INSERT INTO `base_zip` VALUES ('1386', '360423', '', '', '武宁县', '1381');
INSERT INTO `base_zip` VALUES ('1387', '360424', '', '', '修水县', '1381');
INSERT INTO `base_zip` VALUES ('1388', '360425', '', '', '永修县', '1381');
INSERT INTO `base_zip` VALUES ('1389', '360426', '', '', '德安县', '1381');
INSERT INTO `base_zip` VALUES ('1390', '360427', '', '', '星子县', '1381');
INSERT INTO `base_zip` VALUES ('1391', '360428', '', '', '都昌县', '1381');
INSERT INTO `base_zip` VALUES ('1392', '360429', '', '', '湖口县', '1381');
INSERT INTO `base_zip` VALUES ('1393', '360430', '', '', '彭泽县', '1381');
INSERT INTO `base_zip` VALUES ('1394', '360481', '', '', '瑞昌市', '1381');
INSERT INTO `base_zip` VALUES ('1395', '360482', '', '', '共青城市', '1381');
INSERT INTO `base_zip` VALUES ('1396', '360500', '', '新余市', '', '1356');
INSERT INTO `base_zip` VALUES ('1397', '360501', '', '', '市辖区', '1396');
INSERT INTO `base_zip` VALUES ('1398', '360502', '', '', '渝水区', '1396');
INSERT INTO `base_zip` VALUES ('1399', '360521', '', '', '分宜县', '1396');
INSERT INTO `base_zip` VALUES ('1400', '360600', '', '鹰潭市', '', '1356');
INSERT INTO `base_zip` VALUES ('1401', '360601', '', '', '市辖区', '1400');
INSERT INTO `base_zip` VALUES ('1402', '360602', '', '', '月湖区', '1400');
INSERT INTO `base_zip` VALUES ('1403', '360622', '', '', '余江县', '1400');
INSERT INTO `base_zip` VALUES ('1404', '360681', '', '', '贵溪市', '1400');
INSERT INTO `base_zip` VALUES ('1405', '360700', '', '赣州市', '', '1356');
INSERT INTO `base_zip` VALUES ('1406', '360701', '', '', '市辖区', '1405');
INSERT INTO `base_zip` VALUES ('1407', '360702', '', '', '章贡区', '1405');
INSERT INTO `base_zip` VALUES ('1408', '360703', '', '', '南康区', '1405');
INSERT INTO `base_zip` VALUES ('1409', '360721', '', '', '赣县', '1405');
INSERT INTO `base_zip` VALUES ('1410', '360722', '', '', '信丰县', '1405');
INSERT INTO `base_zip` VALUES ('1411', '360723', '', '', '大余县', '1405');
INSERT INTO `base_zip` VALUES ('1412', '360724', '', '', '上犹县', '1405');
INSERT INTO `base_zip` VALUES ('1413', '360725', '', '', '崇义县', '1405');
INSERT INTO `base_zip` VALUES ('1414', '360726', '', '', '安远县', '1405');
INSERT INTO `base_zip` VALUES ('1415', '360727', '', '', '龙南县', '1405');
INSERT INTO `base_zip` VALUES ('1416', '360728', '', '', '定南县', '1405');
INSERT INTO `base_zip` VALUES ('1417', '360729', '', '', '全南县', '1405');
INSERT INTO `base_zip` VALUES ('1418', '360730', '', '', '宁都县', '1405');
INSERT INTO `base_zip` VALUES ('1419', '360731', '', '', '于都县', '1405');
INSERT INTO `base_zip` VALUES ('1420', '360732', '', '', '兴国县', '1405');
INSERT INTO `base_zip` VALUES ('1421', '360733', '', '', '会昌县', '1405');
INSERT INTO `base_zip` VALUES ('1422', '360734', '', '', '寻乌县', '1405');
INSERT INTO `base_zip` VALUES ('1423', '360735', '', '', '石城县', '1405');
INSERT INTO `base_zip` VALUES ('1424', '360781', '', '', '瑞金市', '1405');
INSERT INTO `base_zip` VALUES ('1425', '360800', '', '吉安市', '', '1356');
INSERT INTO `base_zip` VALUES ('1426', '360801', '', '', '市辖区', '1425');
INSERT INTO `base_zip` VALUES ('1427', '360802', '', '', '吉州区', '1425');
INSERT INTO `base_zip` VALUES ('1428', '360803', '', '', '青原区', '1425');
INSERT INTO `base_zip` VALUES ('1429', '360821', '', '', '吉安县', '1425');
INSERT INTO `base_zip` VALUES ('1430', '360822', '', '', '吉水县', '1425');
INSERT INTO `base_zip` VALUES ('1431', '360823', '', '', '峡江县', '1425');
INSERT INTO `base_zip` VALUES ('1432', '360824', '', '', '新干县', '1425');
INSERT INTO `base_zip` VALUES ('1433', '360825', '', '', '永丰县', '1425');
INSERT INTO `base_zip` VALUES ('1434', '360826', '', '', '泰和县', '1425');
INSERT INTO `base_zip` VALUES ('1435', '360827', '', '', '遂川县', '1425');
INSERT INTO `base_zip` VALUES ('1436', '360828', '', '', '万安县', '1425');
INSERT INTO `base_zip` VALUES ('1437', '360829', '', '', '安福县', '1425');
INSERT INTO `base_zip` VALUES ('1438', '360830', '', '', '永新县', '1425');
INSERT INTO `base_zip` VALUES ('1439', '360881', '', '', '井冈山市', '1425');
INSERT INTO `base_zip` VALUES ('1440', '360900', '', '宜春市', '', '1356');
INSERT INTO `base_zip` VALUES ('1441', '360901', '', '', '市辖区', '1440');
INSERT INTO `base_zip` VALUES ('1442', '360902', '', '', '袁州区', '1440');
INSERT INTO `base_zip` VALUES ('1443', '360921', '', '', '奉新县', '1440');
INSERT INTO `base_zip` VALUES ('1444', '360922', '', '', '万载县', '1440');
INSERT INTO `base_zip` VALUES ('1445', '360923', '', '', '上高县', '1440');
INSERT INTO `base_zip` VALUES ('1446', '360924', '', '', '宜丰县', '1440');
INSERT INTO `base_zip` VALUES ('1447', '360925', '', '', '靖安县', '1440');
INSERT INTO `base_zip` VALUES ('1448', '360926', '', '', '铜鼓县', '1440');
INSERT INTO `base_zip` VALUES ('1449', '360981', '', '', '丰城市', '1440');
INSERT INTO `base_zip` VALUES ('1450', '360982', '', '', '樟树市', '1440');
INSERT INTO `base_zip` VALUES ('1451', '360983', '', '', '高安市', '1440');
INSERT INTO `base_zip` VALUES ('1452', '361000', '', '抚州市', '', '1356');
INSERT INTO `base_zip` VALUES ('1453', '361001', '', '', '市辖区', '1452');
INSERT INTO `base_zip` VALUES ('1454', '361002', '', '', '临川区', '1452');
INSERT INTO `base_zip` VALUES ('1455', '361021', '', '', '南城县', '1452');
INSERT INTO `base_zip` VALUES ('1456', '361022', '', '', '黎川县', '1452');
INSERT INTO `base_zip` VALUES ('1457', '361023', '', '', '南丰县', '1452');
INSERT INTO `base_zip` VALUES ('1458', '361024', '', '', '崇仁县', '1452');
INSERT INTO `base_zip` VALUES ('1459', '361025', '', '', '乐安县', '1452');
INSERT INTO `base_zip` VALUES ('1460', '361026', '', '', '宜黄县', '1452');
INSERT INTO `base_zip` VALUES ('1461', '361027', '', '', '金溪县', '1452');
INSERT INTO `base_zip` VALUES ('1462', '361028', '', '', '资溪县', '1452');
INSERT INTO `base_zip` VALUES ('1463', '361029', '', '', '东乡县', '1452');
INSERT INTO `base_zip` VALUES ('1464', '361030', '', '', '广昌县', '1452');
INSERT INTO `base_zip` VALUES ('1465', '361100', '', '上饶市', '', '1356');
INSERT INTO `base_zip` VALUES ('1466', '361101', '', '', '市辖区', '1465');
INSERT INTO `base_zip` VALUES ('1467', '361102', '', '', '信州区', '1465');
INSERT INTO `base_zip` VALUES ('1468', '361121', '', '', '上饶县', '1465');
INSERT INTO `base_zip` VALUES ('1469', '361122', '', '', '广丰县', '1465');
INSERT INTO `base_zip` VALUES ('1470', '361123', '', '', '玉山县', '1465');
INSERT INTO `base_zip` VALUES ('1471', '361124', '', '', '铅山县', '1465');
INSERT INTO `base_zip` VALUES ('1472', '361125', '', '', '横峰县', '1465');
INSERT INTO `base_zip` VALUES ('1473', '361126', '', '', '弋阳县', '1465');
INSERT INTO `base_zip` VALUES ('1474', '361127', '', '', '余干县', '1465');
INSERT INTO `base_zip` VALUES ('1475', '361128', '', '', '鄱阳县', '1465');
INSERT INTO `base_zip` VALUES ('1476', '361129', '', '', '万年县', '1465');
INSERT INTO `base_zip` VALUES ('1477', '361130', '', '', '婺源县', '1465');
INSERT INTO `base_zip` VALUES ('1478', '361181', '', '', '德兴市', '1465');
INSERT INTO `base_zip` VALUES ('1479', '370000', '山东省', '', '', '1');
INSERT INTO `base_zip` VALUES ('1480', '370100', '', '济南市', '', '1479');
INSERT INTO `base_zip` VALUES ('1481', '370101', '', '', '市辖区', '1480');
INSERT INTO `base_zip` VALUES ('1482', '370102', '', '', '历下区', '1480');
INSERT INTO `base_zip` VALUES ('1483', '370103', '', '', '市中区', '1480');
INSERT INTO `base_zip` VALUES ('1484', '370104', '', '', '槐荫区', '1480');
INSERT INTO `base_zip` VALUES ('1485', '370105', '', '', '天桥区', '1480');
INSERT INTO `base_zip` VALUES ('1486', '370112', '', '', '历城区', '1480');
INSERT INTO `base_zip` VALUES ('1487', '370113', '', '', '长清区', '1480');
INSERT INTO `base_zip` VALUES ('1488', '370124', '', '', '平阴县', '1480');
INSERT INTO `base_zip` VALUES ('1489', '370125', '', '', '济阳县', '1480');
INSERT INTO `base_zip` VALUES ('1490', '370126', '', '', '商河县', '1480');
INSERT INTO `base_zip` VALUES ('1491', '370181', '', '', '章丘市', '1480');
INSERT INTO `base_zip` VALUES ('1492', '370200', '', '青岛市', '', '1479');
INSERT INTO `base_zip` VALUES ('1493', '370201', '', '', '市辖区', '1492');
INSERT INTO `base_zip` VALUES ('1494', '370202', '', '', '市南区', '1492');
INSERT INTO `base_zip` VALUES ('1495', '370203', '', '', '市北区', '1492');
INSERT INTO `base_zip` VALUES ('1496', '370211', '', '', '黄岛区', '1492');
INSERT INTO `base_zip` VALUES ('1497', '370212', '', '', '崂山区', '1492');
INSERT INTO `base_zip` VALUES ('1498', '370213', '', '', '李沧区', '1492');
INSERT INTO `base_zip` VALUES ('1499', '370214', '', '', '城阳区', '1492');
INSERT INTO `base_zip` VALUES ('1500', '370281', '', '', '胶州市', '1492');
INSERT INTO `base_zip` VALUES ('1501', '370282', '', '', '即墨市', '1492');
INSERT INTO `base_zip` VALUES ('1502', '370283', '', '', '平度市', '1492');
INSERT INTO `base_zip` VALUES ('1503', '370285', '', '', '莱西市', '1492');
INSERT INTO `base_zip` VALUES ('1504', '370300', '', '淄博市', '', '1479');
INSERT INTO `base_zip` VALUES ('1505', '370301', '', '', '市辖区', '1504');
INSERT INTO `base_zip` VALUES ('1506', '370302', '', '', '淄川区', '1504');
INSERT INTO `base_zip` VALUES ('1507', '370303', '', '', '张店区', '1504');
INSERT INTO `base_zip` VALUES ('1508', '370304', '', '', '博山区', '1504');
INSERT INTO `base_zip` VALUES ('1509', '370305', '', '', '临淄区', '1504');
INSERT INTO `base_zip` VALUES ('1510', '370306', '', '', '周村区', '1504');
INSERT INTO `base_zip` VALUES ('1511', '370321', '', '', '桓台县', '1504');
INSERT INTO `base_zip` VALUES ('1512', '370322', '', '', '高青县', '1504');
INSERT INTO `base_zip` VALUES ('1513', '370323', '', '', '沂源县', '1504');
INSERT INTO `base_zip` VALUES ('1514', '370400', '', '枣庄市', '', '1479');
INSERT INTO `base_zip` VALUES ('1515', '370401', '', '', '市辖区', '1514');
INSERT INTO `base_zip` VALUES ('1516', '370402', '', '', '市中区', '1514');
INSERT INTO `base_zip` VALUES ('1517', '370403', '', '', '薛城区', '1514');
INSERT INTO `base_zip` VALUES ('1518', '370404', '', '', '峄城区', '1514');
INSERT INTO `base_zip` VALUES ('1519', '370405', '', '', '台儿庄区', '1514');
INSERT INTO `base_zip` VALUES ('1520', '370406', '', '', '山亭区', '1514');
INSERT INTO `base_zip` VALUES ('1521', '370481', '', '', '滕州市', '1514');
INSERT INTO `base_zip` VALUES ('1522', '370500', '', '东营市', '', '1479');
INSERT INTO `base_zip` VALUES ('1523', '370501', '', '', '市辖区', '1522');
INSERT INTO `base_zip` VALUES ('1524', '370502', '', '', '东营区', '1522');
INSERT INTO `base_zip` VALUES ('1525', '370503', '', '', '河口区', '1522');
INSERT INTO `base_zip` VALUES ('1526', '370521', '', '', '垦利县', '1522');
INSERT INTO `base_zip` VALUES ('1527', '370522', '', '', '利津县', '1522');
INSERT INTO `base_zip` VALUES ('1528', '370523', '', '', '广饶县', '1522');
INSERT INTO `base_zip` VALUES ('1529', '370600', '', '烟台市', '', '1479');
INSERT INTO `base_zip` VALUES ('1530', '370601', '', '', '市辖区', '1529');
INSERT INTO `base_zip` VALUES ('1531', '370602', '', '', '芝罘区', '1529');
INSERT INTO `base_zip` VALUES ('1532', '370611', '', '', '福山区', '1529');
INSERT INTO `base_zip` VALUES ('1533', '370612', '', '', '牟平区', '1529');
INSERT INTO `base_zip` VALUES ('1534', '370613', '', '', '莱山区', '1529');
INSERT INTO `base_zip` VALUES ('1535', '370634', '', '', '长岛县', '1529');
INSERT INTO `base_zip` VALUES ('1536', '370681', '', '', '龙口市', '1529');
INSERT INTO `base_zip` VALUES ('1537', '370682', '', '', '莱阳市', '1529');
INSERT INTO `base_zip` VALUES ('1538', '370683', '', '', '莱州市', '1529');
INSERT INTO `base_zip` VALUES ('1539', '370684', '', '', '蓬莱市', '1529');
INSERT INTO `base_zip` VALUES ('1540', '370685', '', '', '招远市', '1529');
INSERT INTO `base_zip` VALUES ('1541', '370686', '', '', '栖霞市', '1529');
INSERT INTO `base_zip` VALUES ('1542', '370687', '', '', '海阳市', '1529');
INSERT INTO `base_zip` VALUES ('1543', '370700', '', '潍坊市', '', '1479');
INSERT INTO `base_zip` VALUES ('1544', '370701', '', '', '市辖区', '1543');
INSERT INTO `base_zip` VALUES ('1545', '370702', '', '', '潍城区', '1543');
INSERT INTO `base_zip` VALUES ('1546', '370703', '', '', '寒亭区', '1543');
INSERT INTO `base_zip` VALUES ('1547', '370704', '', '', '坊子区', '1543');
INSERT INTO `base_zip` VALUES ('1548', '370705', '', '', '奎文区', '1543');
INSERT INTO `base_zip` VALUES ('1549', '370724', '', '', '临朐县', '1543');
INSERT INTO `base_zip` VALUES ('1550', '370725', '', '', '昌乐县', '1543');
INSERT INTO `base_zip` VALUES ('1551', '370781', '', '', '青州市', '1543');
INSERT INTO `base_zip` VALUES ('1552', '370782', '', '', '诸城市', '1543');
INSERT INTO `base_zip` VALUES ('1553', '370783', '', '', '寿光市', '1543');
INSERT INTO `base_zip` VALUES ('1554', '370784', '', '', '安丘市', '1543');
INSERT INTO `base_zip` VALUES ('1555', '370785', '', '', '高密市', '1543');
INSERT INTO `base_zip` VALUES ('1556', '370786', '', '', '昌邑市', '1543');
INSERT INTO `base_zip` VALUES ('1557', '370800', '', '济宁市', '', '1479');
INSERT INTO `base_zip` VALUES ('1558', '370801', '', '', '市辖区', '1557');
INSERT INTO `base_zip` VALUES ('1559', '370811', '', '', '任城区', '1557');
INSERT INTO `base_zip` VALUES ('1560', '370812', '', '', '兖州区', '1557');
INSERT INTO `base_zip` VALUES ('1561', '370826', '', '', '微山县', '1557');
INSERT INTO `base_zip` VALUES ('1562', '370827', '', '', '鱼台县', '1557');
INSERT INTO `base_zip` VALUES ('1563', '370828', '', '', '金乡县', '1557');
INSERT INTO `base_zip` VALUES ('1564', '370829', '', '', '嘉祥县', '1557');
INSERT INTO `base_zip` VALUES ('1565', '370830', '', '', '汶上县', '1557');
INSERT INTO `base_zip` VALUES ('1566', '370831', '', '', '泗水县', '1557');
INSERT INTO `base_zip` VALUES ('1567', '370832', '', '', '梁山县', '1557');
INSERT INTO `base_zip` VALUES ('1568', '370881', '', '', '曲阜市', '1557');
INSERT INTO `base_zip` VALUES ('1569', '370883', '', '', '邹城市', '1557');
INSERT INTO `base_zip` VALUES ('1570', '370900', '', '泰安市', '', '1479');
INSERT INTO `base_zip` VALUES ('1571', '370901', '', '', '市辖区', '1570');
INSERT INTO `base_zip` VALUES ('1572', '370902', '', '', '泰山区', '1570');
INSERT INTO `base_zip` VALUES ('1573', '370911', '', '', '岱岳区', '1570');
INSERT INTO `base_zip` VALUES ('1574', '370921', '', '', '宁阳县', '1570');
INSERT INTO `base_zip` VALUES ('1575', '370923', '', '', '东平县', '1570');
INSERT INTO `base_zip` VALUES ('1576', '370982', '', '', '新泰市', '1570');
INSERT INTO `base_zip` VALUES ('1577', '370983', '', '', '肥城市', '1570');
INSERT INTO `base_zip` VALUES ('1578', '371000', '', '威海市', '', '1479');
INSERT INTO `base_zip` VALUES ('1579', '371001', '', '', '市辖区', '1578');
INSERT INTO `base_zip` VALUES ('1580', '371002', '', '', '环翠区', '1578');
INSERT INTO `base_zip` VALUES ('1581', '371081', '', '', '文登市', '1578');
INSERT INTO `base_zip` VALUES ('1582', '371082', '', '', '荣成市', '1578');
INSERT INTO `base_zip` VALUES ('1583', '371083', '', '', '乳山市', '1578');
INSERT INTO `base_zip` VALUES ('1584', '371100', '', '日照市', '', '1479');
INSERT INTO `base_zip` VALUES ('1585', '371101', '', '', '市辖区', '1584');
INSERT INTO `base_zip` VALUES ('1586', '371102', '', '', '东港区', '1584');
INSERT INTO `base_zip` VALUES ('1587', '371103', '', '', '岚山区', '1584');
INSERT INTO `base_zip` VALUES ('1588', '371121', '', '', '五莲县', '1584');
INSERT INTO `base_zip` VALUES ('1589', '371122', '', '', '莒县', '1584');
INSERT INTO `base_zip` VALUES ('1590', '371200', '', '莱芜市', '', '1479');
INSERT INTO `base_zip` VALUES ('1591', '371201', '', '', '市辖区', '1590');
INSERT INTO `base_zip` VALUES ('1592', '371202', '', '', '莱城区', '1590');
INSERT INTO `base_zip` VALUES ('1593', '371203', '', '', '钢城区', '1590');
INSERT INTO `base_zip` VALUES ('1594', '371300', '', '临沂市', '', '1479');
INSERT INTO `base_zip` VALUES ('1595', '371301', '', '', '市辖区', '1594');
INSERT INTO `base_zip` VALUES ('1596', '371302', '', '', '兰山区', '1594');
INSERT INTO `base_zip` VALUES ('1597', '371311', '', '', '罗庄区', '1594');
INSERT INTO `base_zip` VALUES ('1598', '371312', '', '', '河东区', '1594');
INSERT INTO `base_zip` VALUES ('1599', '371321', '', '', '沂南县', '1594');
INSERT INTO `base_zip` VALUES ('1600', '371322', '', '', '郯城县', '1594');
INSERT INTO `base_zip` VALUES ('1601', '371323', '', '', '沂水县', '1594');
INSERT INTO `base_zip` VALUES ('1602', '371324', '', '', '兰陵县', '1594');
INSERT INTO `base_zip` VALUES ('1603', '371325', '', '', '费县', '1594');
INSERT INTO `base_zip` VALUES ('1604', '371326', '', '', '平邑县', '1594');
INSERT INTO `base_zip` VALUES ('1605', '371327', '', '', '莒南县', '1594');
INSERT INTO `base_zip` VALUES ('1606', '371328', '', '', '蒙阴县', '1594');
INSERT INTO `base_zip` VALUES ('1607', '371329', '', '', '临沭县', '1594');
INSERT INTO `base_zip` VALUES ('1608', '371400', '', '德州市', '', '1479');
INSERT INTO `base_zip` VALUES ('1609', '371401', '', '', '市辖区', '1608');
INSERT INTO `base_zip` VALUES ('1610', '371402', '', '', '德城区', '1608');
INSERT INTO `base_zip` VALUES ('1611', '371403', '', '', '陵城区', '1608');
INSERT INTO `base_zip` VALUES ('1612', '371422', '', '', '宁津县', '1608');
INSERT INTO `base_zip` VALUES ('1613', '371423', '', '', '庆云县', '1608');
INSERT INTO `base_zip` VALUES ('1614', '371424', '', '', '临邑县', '1608');
INSERT INTO `base_zip` VALUES ('1615', '371425', '', '', '齐河县', '1608');
INSERT INTO `base_zip` VALUES ('1616', '371426', '', '', '平原县', '1608');
INSERT INTO `base_zip` VALUES ('1617', '371427', '', '', '夏津县', '1608');
INSERT INTO `base_zip` VALUES ('1618', '371428', '', '', '武城县', '1608');
INSERT INTO `base_zip` VALUES ('1619', '371481', '', '', '乐陵市', '1608');
INSERT INTO `base_zip` VALUES ('1620', '371482', '', '', '禹城市', '1608');
INSERT INTO `base_zip` VALUES ('1621', '371500', '', '聊城市', '', '1479');
INSERT INTO `base_zip` VALUES ('1622', '371501', '', '', '市辖区', '1621');
INSERT INTO `base_zip` VALUES ('1623', '371502', '', '', '东昌府区', '1621');
INSERT INTO `base_zip` VALUES ('1624', '371521', '', '', '阳谷县', '1621');
INSERT INTO `base_zip` VALUES ('1625', '371522', '', '', '莘县', '1621');
INSERT INTO `base_zip` VALUES ('1626', '371523', '', '', '茌平县', '1621');
INSERT INTO `base_zip` VALUES ('1627', '371524', '', '', '东阿县', '1621');
INSERT INTO `base_zip` VALUES ('1628', '371525', '', '', '冠县', '1621');
INSERT INTO `base_zip` VALUES ('1629', '371526', '', '', '高唐县', '1621');
INSERT INTO `base_zip` VALUES ('1630', '371581', '', '', '临清市', '1621');
INSERT INTO `base_zip` VALUES ('1631', '371600', '', '滨州市', '', '1479');
INSERT INTO `base_zip` VALUES ('1632', '371601', '', '', '市辖区', '1631');
INSERT INTO `base_zip` VALUES ('1633', '371602', '', '', '滨城区', '1631');
INSERT INTO `base_zip` VALUES ('1634', '371603', '', '', '沾化区', '1631');
INSERT INTO `base_zip` VALUES ('1635', '371621', '', '', '惠民县', '1631');
INSERT INTO `base_zip` VALUES ('1636', '371622', '', '', '阳信县', '1631');
INSERT INTO `base_zip` VALUES ('1637', '371623', '', '', '无棣县', '1631');
INSERT INTO `base_zip` VALUES ('1638', '371625', '', '', '博兴县', '1631');
INSERT INTO `base_zip` VALUES ('1639', '371626', '', '', '邹平县', '1631');
INSERT INTO `base_zip` VALUES ('1640', '371700', '', '菏泽市', '', '1479');
INSERT INTO `base_zip` VALUES ('1641', '371701', '', '', '市辖区', '1640');
INSERT INTO `base_zip` VALUES ('1642', '371702', '', '', '牡丹区', '1640');
INSERT INTO `base_zip` VALUES ('1643', '371721', '', '', '曹县', '1640');
INSERT INTO `base_zip` VALUES ('1644', '371722', '', '', '单县', '1640');
INSERT INTO `base_zip` VALUES ('1645', '371723', '', '', '成武县', '1640');
INSERT INTO `base_zip` VALUES ('1646', '371724', '', '', '巨野县', '1640');
INSERT INTO `base_zip` VALUES ('1647', '371725', '', '', '郓城县', '1640');
INSERT INTO `base_zip` VALUES ('1648', '371726', '', '', '鄄城县', '1640');
INSERT INTO `base_zip` VALUES ('1649', '371727', '', '', '定陶县', '1640');
INSERT INTO `base_zip` VALUES ('1650', '371728', '', '', '东明县', '1640');
INSERT INTO `base_zip` VALUES ('1651', '410000', '河南省', '', '', '1');
INSERT INTO `base_zip` VALUES ('1652', '410100', '', '郑州市', '', '1651');
INSERT INTO `base_zip` VALUES ('1653', '410101', '', '', '市辖区', '1652');
INSERT INTO `base_zip` VALUES ('1654', '410102', '', '', '中原区', '1652');
INSERT INTO `base_zip` VALUES ('1655', '410103', '', '', '二七区', '1652');
INSERT INTO `base_zip` VALUES ('1656', '410104', '', '', '管城回族区', '1652');
INSERT INTO `base_zip` VALUES ('1657', '410105', '', '', '金水区', '1652');
INSERT INTO `base_zip` VALUES ('1658', '410106', '', '', '上街区', '1652');
INSERT INTO `base_zip` VALUES ('1659', '410108', '', '', '惠济区', '1652');
INSERT INTO `base_zip` VALUES ('1660', '410122', '', '', '中牟县', '1652');
INSERT INTO `base_zip` VALUES ('1661', '410181', '', '', '巩义市', '1652');
INSERT INTO `base_zip` VALUES ('1662', '410182', '', '', '荥阳市', '1652');
INSERT INTO `base_zip` VALUES ('1663', '410183', '', '', '新密市', '1652');
INSERT INTO `base_zip` VALUES ('1664', '410184', '', '', '新郑市', '1652');
INSERT INTO `base_zip` VALUES ('1665', '410185', '', '', '登封市', '1652');
INSERT INTO `base_zip` VALUES ('1666', '410200', '', '开封市', '', '1651');
INSERT INTO `base_zip` VALUES ('1667', '410201', '', '', '市辖区', '1666');
INSERT INTO `base_zip` VALUES ('1668', '410202', '', '', '龙亭区', '1666');
INSERT INTO `base_zip` VALUES ('1669', '410203', '', '', '顺河回族区', '1666');
INSERT INTO `base_zip` VALUES ('1670', '410204', '', '', '鼓楼区', '1666');
INSERT INTO `base_zip` VALUES ('1671', '410205', '', '', '禹王台区', '1666');
INSERT INTO `base_zip` VALUES ('1672', '410212', '', '', '祥符区', '1666');
INSERT INTO `base_zip` VALUES ('1673', '410221', '', '', '杞县', '1666');
INSERT INTO `base_zip` VALUES ('1674', '410222', '', '', '通许县', '1666');
INSERT INTO `base_zip` VALUES ('1675', '410223', '', '', '尉氏县', '1666');
INSERT INTO `base_zip` VALUES ('1676', '410225', '', '', '兰考县', '1666');
INSERT INTO `base_zip` VALUES ('1677', '410300', '', '洛阳市', '', '1651');
INSERT INTO `base_zip` VALUES ('1678', '410301', '', '', '市辖区', '1677');
INSERT INTO `base_zip` VALUES ('1679', '410302', '', '', '老城区', '1677');
INSERT INTO `base_zip` VALUES ('1680', '410303', '', '', '西工区', '1677');
INSERT INTO `base_zip` VALUES ('1681', '410304', '', '', '瀍河回族区', '1677');
INSERT INTO `base_zip` VALUES ('1682', '410305', '', '', '涧西区', '1677');
INSERT INTO `base_zip` VALUES ('1683', '410306', '', '', '吉利区', '1677');
INSERT INTO `base_zip` VALUES ('1684', '410311', '', '', '洛龙区', '1677');
INSERT INTO `base_zip` VALUES ('1685', '410322', '', '', '孟津县', '1677');
INSERT INTO `base_zip` VALUES ('1686', '410323', '', '', '新安县', '1677');
INSERT INTO `base_zip` VALUES ('1687', '410324', '', '', '栾川县', '1677');
INSERT INTO `base_zip` VALUES ('1688', '410325', '', '', '嵩县', '1677');
INSERT INTO `base_zip` VALUES ('1689', '410326', '', '', '汝阳县', '1677');
INSERT INTO `base_zip` VALUES ('1690', '410327', '', '', '宜阳县', '1677');
INSERT INTO `base_zip` VALUES ('1691', '410328', '', '', '洛宁县', '1677');
INSERT INTO `base_zip` VALUES ('1692', '410329', '', '', '伊川县', '1677');
INSERT INTO `base_zip` VALUES ('1693', '410381', '', '', '偃师市', '1677');
INSERT INTO `base_zip` VALUES ('1694', '410400', '', '平顶山市', '', '1651');
INSERT INTO `base_zip` VALUES ('1695', '410401', '', '', '市辖区', '1694');
INSERT INTO `base_zip` VALUES ('1696', '410402', '', '', '新华区', '1694');
INSERT INTO `base_zip` VALUES ('1697', '410403', '', '', '卫东区', '1694');
INSERT INTO `base_zip` VALUES ('1698', '410404', '', '', '石龙区', '1694');
INSERT INTO `base_zip` VALUES ('1699', '410411', '', '', '湛河区', '1694');
INSERT INTO `base_zip` VALUES ('1700', '410421', '', '', '宝丰县', '1694');
INSERT INTO `base_zip` VALUES ('1701', '410422', '', '', '叶县', '1694');
INSERT INTO `base_zip` VALUES ('1702', '410423', '', '', '鲁山县', '1694');
INSERT INTO `base_zip` VALUES ('1703', '410425', '', '', '郏县', '1694');
INSERT INTO `base_zip` VALUES ('1704', '410481', '', '', '舞钢市', '1694');
INSERT INTO `base_zip` VALUES ('1705', '410482', '', '', '汝州市', '1694');
INSERT INTO `base_zip` VALUES ('1706', '410500', '', '安阳市', '', '1651');
INSERT INTO `base_zip` VALUES ('1707', '410501', '', '', '市辖区', '1706');
INSERT INTO `base_zip` VALUES ('1708', '410502', '', '', '文峰区', '1706');
INSERT INTO `base_zip` VALUES ('1709', '410503', '', '', '北关区', '1706');
INSERT INTO `base_zip` VALUES ('1710', '410505', '', '', '殷都区', '1706');
INSERT INTO `base_zip` VALUES ('1711', '410506', '', '', '龙安区', '1706');
INSERT INTO `base_zip` VALUES ('1712', '410522', '', '', '安阳县', '1706');
INSERT INTO `base_zip` VALUES ('1713', '410523', '', '', '汤阴县', '1706');
INSERT INTO `base_zip` VALUES ('1714', '410526', '', '', '滑县', '1706');
INSERT INTO `base_zip` VALUES ('1715', '410527', '', '', '内黄县', '1706');
INSERT INTO `base_zip` VALUES ('1716', '410581', '', '', '林州市', '1706');
INSERT INTO `base_zip` VALUES ('1717', '410600', '', '鹤壁市', '', '1651');
INSERT INTO `base_zip` VALUES ('1718', '410601', '', '', '市辖区', '1717');
INSERT INTO `base_zip` VALUES ('1719', '410602', '', '', '鹤山区', '1717');
INSERT INTO `base_zip` VALUES ('1720', '410603', '', '', '山城区', '1717');
INSERT INTO `base_zip` VALUES ('1721', '410611', '', '', '淇滨区', '1717');
INSERT INTO `base_zip` VALUES ('1722', '410621', '', '', '浚县', '1717');
INSERT INTO `base_zip` VALUES ('1723', '410622', '', '', '淇县', '1717');
INSERT INTO `base_zip` VALUES ('1724', '410700', '', '新乡市', '', '1651');
INSERT INTO `base_zip` VALUES ('1725', '410701', '', '', '市辖区', '1724');
INSERT INTO `base_zip` VALUES ('1726', '410702', '', '', '红旗区', '1724');
INSERT INTO `base_zip` VALUES ('1727', '410703', '', '', '卫滨区', '1724');
INSERT INTO `base_zip` VALUES ('1728', '410704', '', '', '凤泉区', '1724');
INSERT INTO `base_zip` VALUES ('1729', '410711', '', '', '牧野区', '1724');
INSERT INTO `base_zip` VALUES ('1730', '410721', '', '', '新乡县', '1724');
INSERT INTO `base_zip` VALUES ('1731', '410724', '', '', '获嘉县', '1724');
INSERT INTO `base_zip` VALUES ('1732', '410725', '', '', '原阳县', '1724');
INSERT INTO `base_zip` VALUES ('1733', '410726', '', '', '延津县', '1724');
INSERT INTO `base_zip` VALUES ('1734', '410727', '', '', '封丘县', '1724');
INSERT INTO `base_zip` VALUES ('1735', '410728', '', '', '长垣县', '1724');
INSERT INTO `base_zip` VALUES ('1736', '410781', '', '', '卫辉市', '1724');
INSERT INTO `base_zip` VALUES ('1737', '410782', '', '', '辉县市', '1724');
INSERT INTO `base_zip` VALUES ('1738', '410800', '', '焦作市', '', '1651');
INSERT INTO `base_zip` VALUES ('1739', '410801', '', '', '市辖区', '1738');
INSERT INTO `base_zip` VALUES ('1740', '410802', '', '', '解放区', '1738');
INSERT INTO `base_zip` VALUES ('1741', '410803', '', '', '中站区', '1738');
INSERT INTO `base_zip` VALUES ('1742', '410804', '', '', '马村区', '1738');
INSERT INTO `base_zip` VALUES ('1743', '410811', '', '', '山阳区', '1738');
INSERT INTO `base_zip` VALUES ('1744', '410821', '', '', '修武县', '1738');
INSERT INTO `base_zip` VALUES ('1745', '410822', '', '', '博爱县', '1738');
INSERT INTO `base_zip` VALUES ('1746', '410823', '', '', '武陟县', '1738');
INSERT INTO `base_zip` VALUES ('1747', '410825', '', '', '温县', '1738');
INSERT INTO `base_zip` VALUES ('1748', '410882', '', '', '沁阳市', '1738');
INSERT INTO `base_zip` VALUES ('1749', '410883', '', '', '孟州市', '1738');
INSERT INTO `base_zip` VALUES ('1750', '410900', '', '濮阳市', '', '1651');
INSERT INTO `base_zip` VALUES ('1751', '410901', '', '', '市辖区', '1750');
INSERT INTO `base_zip` VALUES ('1752', '410902', '', '', '华龙区', '1750');
INSERT INTO `base_zip` VALUES ('1753', '410922', '', '', '清丰县', '1750');
INSERT INTO `base_zip` VALUES ('1754', '410923', '', '', '南乐县', '1750');
INSERT INTO `base_zip` VALUES ('1755', '410926', '', '', '范县', '1750');
INSERT INTO `base_zip` VALUES ('1756', '410927', '', '', '台前县', '1750');
INSERT INTO `base_zip` VALUES ('1757', '410928', '', '', '濮阳县', '1750');
INSERT INTO `base_zip` VALUES ('1758', '411000', '', '许昌市', '', '1651');
INSERT INTO `base_zip` VALUES ('1759', '411001', '', '', '市辖区', '1758');
INSERT INTO `base_zip` VALUES ('1760', '411002', '', '', '魏都区', '1758');
INSERT INTO `base_zip` VALUES ('1761', '411023', '', '', '许昌县', '1758');
INSERT INTO `base_zip` VALUES ('1762', '411024', '', '', '鄢陵县', '1758');
INSERT INTO `base_zip` VALUES ('1763', '411025', '', '', '襄城县', '1758');
INSERT INTO `base_zip` VALUES ('1764', '411081', '', '', '禹州市', '1758');
INSERT INTO `base_zip` VALUES ('1765', '411082', '', '', '长葛市', '1758');
INSERT INTO `base_zip` VALUES ('1766', '411100', '', '漯河市', '', '1651');
INSERT INTO `base_zip` VALUES ('1767', '411101', '', '', '市辖区', '1766');
INSERT INTO `base_zip` VALUES ('1768', '411102', '', '', '源汇区', '1766');
INSERT INTO `base_zip` VALUES ('1769', '411103', '', '', '郾城区', '1766');
INSERT INTO `base_zip` VALUES ('1770', '411104', '', '', '召陵区', '1766');
INSERT INTO `base_zip` VALUES ('1771', '411121', '', '', '舞阳县', '1766');
INSERT INTO `base_zip` VALUES ('1772', '411122', '', '', '临颍县', '1766');
INSERT INTO `base_zip` VALUES ('1773', '411200', '', '三门峡市', '', '1651');
INSERT INTO `base_zip` VALUES ('1774', '411201', '', '', '市辖区', '1773');
INSERT INTO `base_zip` VALUES ('1775', '411202', '', '', '湖滨区', '1773');
INSERT INTO `base_zip` VALUES ('1776', '411221', '', '', '渑池县', '1773');
INSERT INTO `base_zip` VALUES ('1777', '411222', '', '', '陕县', '1773');
INSERT INTO `base_zip` VALUES ('1778', '411224', '', '', '卢氏县', '1773');
INSERT INTO `base_zip` VALUES ('1779', '411281', '', '', '义马市', '1773');
INSERT INTO `base_zip` VALUES ('1780', '411282', '', '', '灵宝市', '1773');
INSERT INTO `base_zip` VALUES ('1781', '411300', '', '南阳市', '', '1651');
INSERT INTO `base_zip` VALUES ('1782', '411301', '', '', '市辖区', '1781');
INSERT INTO `base_zip` VALUES ('1783', '411302', '', '', '宛城区', '1781');
INSERT INTO `base_zip` VALUES ('1784', '411303', '', '', '卧龙区', '1781');
INSERT INTO `base_zip` VALUES ('1785', '411321', '', '', '南召县', '1781');
INSERT INTO `base_zip` VALUES ('1786', '411322', '', '', '方城县', '1781');
INSERT INTO `base_zip` VALUES ('1787', '411323', '', '', '西峡县', '1781');
INSERT INTO `base_zip` VALUES ('1788', '411324', '', '', '镇平县', '1781');
INSERT INTO `base_zip` VALUES ('1789', '411325', '', '', '内乡县', '1781');
INSERT INTO `base_zip` VALUES ('1790', '411326', '', '', '淅川县', '1781');
INSERT INTO `base_zip` VALUES ('1791', '411327', '', '', '社旗县', '1781');
INSERT INTO `base_zip` VALUES ('1792', '411328', '', '', '唐河县', '1781');
INSERT INTO `base_zip` VALUES ('1793', '411329', '', '', '新野县', '1781');
INSERT INTO `base_zip` VALUES ('1794', '411330', '', '', '桐柏县', '1781');
INSERT INTO `base_zip` VALUES ('1795', '411381', '', '', '邓州市', '1781');
INSERT INTO `base_zip` VALUES ('1796', '411400', '', '商丘市', '', '1651');
INSERT INTO `base_zip` VALUES ('1797', '411401', '', '', '市辖区', '1796');
INSERT INTO `base_zip` VALUES ('1798', '411402', '', '', '梁园区', '1796');
INSERT INTO `base_zip` VALUES ('1799', '411403', '', '', '睢阳区', '1796');
INSERT INTO `base_zip` VALUES ('1800', '411421', '', '', '民权县', '1796');
INSERT INTO `base_zip` VALUES ('1801', '411422', '', '', '睢县', '1796');
INSERT INTO `base_zip` VALUES ('1802', '411423', '', '', '宁陵县', '1796');
INSERT INTO `base_zip` VALUES ('1803', '411424', '', '', '柘城县', '1796');
INSERT INTO `base_zip` VALUES ('1804', '411425', '', '', '虞城县', '1796');
INSERT INTO `base_zip` VALUES ('1805', '411426', '', '', '夏邑县', '1796');
INSERT INTO `base_zip` VALUES ('1806', '411481', '', '', '永城市', '1796');
INSERT INTO `base_zip` VALUES ('1807', '411500', '', '信阳市', '', '1651');
INSERT INTO `base_zip` VALUES ('1808', '411501', '', '', '市辖区', '1807');
INSERT INTO `base_zip` VALUES ('1809', '411502', '', '', '浉河区', '1807');
INSERT INTO `base_zip` VALUES ('1810', '411503', '', '', '平桥区', '1807');
INSERT INTO `base_zip` VALUES ('1811', '411521', '', '', '罗山县', '1807');
INSERT INTO `base_zip` VALUES ('1812', '411522', '', '', '光山县', '1807');
INSERT INTO `base_zip` VALUES ('1813', '411523', '', '', '新县', '1807');
INSERT INTO `base_zip` VALUES ('1814', '411524', '', '', '商城县', '1807');
INSERT INTO `base_zip` VALUES ('1815', '411525', '', '', '固始县', '1807');
INSERT INTO `base_zip` VALUES ('1816', '411526', '', '', '潢川县', '1807');
INSERT INTO `base_zip` VALUES ('1817', '411527', '', '', '淮滨县', '1807');
INSERT INTO `base_zip` VALUES ('1818', '411528', '', '', '息县', '1807');
INSERT INTO `base_zip` VALUES ('1819', '411600', '', '周口市', '', '1651');
INSERT INTO `base_zip` VALUES ('1820', '411601', '', '', '市辖区', '1819');
INSERT INTO `base_zip` VALUES ('1821', '411602', '', '', '川汇区', '1819');
INSERT INTO `base_zip` VALUES ('1822', '411621', '', '', '扶沟县', '1819');
INSERT INTO `base_zip` VALUES ('1823', '411622', '', '', '西华县', '1819');
INSERT INTO `base_zip` VALUES ('1824', '411623', '', '', '商水县', '1819');
INSERT INTO `base_zip` VALUES ('1825', '411624', '', '', '沈丘县', '1819');
INSERT INTO `base_zip` VALUES ('1826', '411625', '', '', '郸城县', '1819');
INSERT INTO `base_zip` VALUES ('1827', '411626', '', '', '淮阳县', '1819');
INSERT INTO `base_zip` VALUES ('1828', '411627', '', '', '太康县', '1819');
INSERT INTO `base_zip` VALUES ('1829', '411628', '', '', '鹿邑县', '1819');
INSERT INTO `base_zip` VALUES ('1830', '411681', '', '', '项城市', '1819');
INSERT INTO `base_zip` VALUES ('1831', '411700', '', '驻马店市', '', '1651');
INSERT INTO `base_zip` VALUES ('1832', '411701', '', '', '市辖区', '1831');
INSERT INTO `base_zip` VALUES ('1833', '411702', '', '', '驿城区', '1831');
INSERT INTO `base_zip` VALUES ('1834', '411721', '', '', '西平县', '1831');
INSERT INTO `base_zip` VALUES ('1835', '411722', '', '', '上蔡县', '1831');
INSERT INTO `base_zip` VALUES ('1836', '411723', '', '', '平舆县', '1831');
INSERT INTO `base_zip` VALUES ('1837', '411724', '', '', '正阳县', '1831');
INSERT INTO `base_zip` VALUES ('1838', '411725', '', '', '确山县', '1831');
INSERT INTO `base_zip` VALUES ('1839', '411726', '', '', '泌阳县', '1831');
INSERT INTO `base_zip` VALUES ('1840', '411727', '', '', '汝南县', '1831');
INSERT INTO `base_zip` VALUES ('1841', '411728', '', '', '遂平县', '1831');
INSERT INTO `base_zip` VALUES ('1842', '411729', '', '', '新蔡县', '1831');
INSERT INTO `base_zip` VALUES ('1843', '419000', '', '省直辖县级行政区划', '', '1651');
INSERT INTO `base_zip` VALUES ('1844', '419001', '', '', '济源市', '1843');
INSERT INTO `base_zip` VALUES ('1845', '420000', '湖北省', '', '', '1');
INSERT INTO `base_zip` VALUES ('1846', '420100', '', '武汉市', '', '1845');
INSERT INTO `base_zip` VALUES ('1847', '420101', '', '', '市辖区', '1846');
INSERT INTO `base_zip` VALUES ('1848', '420102', '', '', '江岸区', '1846');
INSERT INTO `base_zip` VALUES ('1849', '420103', '', '', '江汉区', '1846');
INSERT INTO `base_zip` VALUES ('1850', '420104', '', '', '硚口区', '1846');
INSERT INTO `base_zip` VALUES ('1851', '420105', '', '', '汉阳区', '1846');
INSERT INTO `base_zip` VALUES ('1852', '420106', '', '', '武昌区', '1846');
INSERT INTO `base_zip` VALUES ('1853', '420107', '', '', '青山区', '1846');
INSERT INTO `base_zip` VALUES ('1854', '420111', '', '', '洪山区', '1846');
INSERT INTO `base_zip` VALUES ('1855', '420112', '', '', '东西湖区', '1846');
INSERT INTO `base_zip` VALUES ('1856', '420113', '', '', '汉南区', '1846');
INSERT INTO `base_zip` VALUES ('1857', '420114', '', '', '蔡甸区', '1846');
INSERT INTO `base_zip` VALUES ('1858', '420115', '', '', '江夏区', '1846');
INSERT INTO `base_zip` VALUES ('1859', '420116', '', '', '黄陂区', '1846');
INSERT INTO `base_zip` VALUES ('1860', '420117', '', '', '新洲区', '1846');
INSERT INTO `base_zip` VALUES ('1861', '420200', '', '黄石市', '', '1845');
INSERT INTO `base_zip` VALUES ('1862', '420201', '', '', '市辖区', '1861');
INSERT INTO `base_zip` VALUES ('1863', '420202', '', '', '黄石港区', '1861');
INSERT INTO `base_zip` VALUES ('1864', '420203', '', '', '西塞山区', '1861');
INSERT INTO `base_zip` VALUES ('1865', '420204', '', '', '下陆区', '1861');
INSERT INTO `base_zip` VALUES ('1866', '420205', '', '', '铁山区', '1861');
INSERT INTO `base_zip` VALUES ('1867', '420222', '', '', '阳新县', '1861');
INSERT INTO `base_zip` VALUES ('1868', '420281', '', '', '大冶市', '1861');
INSERT INTO `base_zip` VALUES ('1869', '420300', '', '十堰市', '', '1845');
INSERT INTO `base_zip` VALUES ('1870', '420301', '', '', '市辖区', '1869');
INSERT INTO `base_zip` VALUES ('1871', '420302', '', '', '茅箭区', '1869');
INSERT INTO `base_zip` VALUES ('1872', '420303', '', '', '张湾区', '1869');
INSERT INTO `base_zip` VALUES ('1873', '420304', '', '', '郧阳区', '1869');
INSERT INTO `base_zip` VALUES ('1874', '420322', '', '', '郧西县', '1869');
INSERT INTO `base_zip` VALUES ('1875', '420323', '', '', '竹山县', '1869');
INSERT INTO `base_zip` VALUES ('1876', '420324', '', '', '竹溪县', '1869');
INSERT INTO `base_zip` VALUES ('1877', '420325', '', '', '房县', '1869');
INSERT INTO `base_zip` VALUES ('1878', '420381', '', '', '丹江口市', '1869');
INSERT INTO `base_zip` VALUES ('1879', '420500', '', '宜昌市', '', '1845');
INSERT INTO `base_zip` VALUES ('1880', '420501', '', '', '市辖区', '1879');
INSERT INTO `base_zip` VALUES ('1881', '420502', '', '', '西陵区', '1879');
INSERT INTO `base_zip` VALUES ('1882', '420503', '', '', '伍家岗区', '1879');
INSERT INTO `base_zip` VALUES ('1883', '420504', '', '', '点军区', '1879');
INSERT INTO `base_zip` VALUES ('1884', '420505', '', '', '猇亭区', '1879');
INSERT INTO `base_zip` VALUES ('1885', '420506', '', '', '夷陵区', '1879');
INSERT INTO `base_zip` VALUES ('1886', '420525', '', '', '远安县', '1879');
INSERT INTO `base_zip` VALUES ('1887', '420526', '', '', '兴山县', '1879');
INSERT INTO `base_zip` VALUES ('1888', '420527', '', '', '秭归县', '1879');
INSERT INTO `base_zip` VALUES ('1889', '420528', '', '', '长阳土家族自治县', '1879');
INSERT INTO `base_zip` VALUES ('1890', '420529', '', '', '五峰土家族自治县', '1879');
INSERT INTO `base_zip` VALUES ('1891', '420581', '', '', '宜都市', '1879');
INSERT INTO `base_zip` VALUES ('1892', '420582', '', '', '当阳市', '1879');
INSERT INTO `base_zip` VALUES ('1893', '420583', '', '', '枝江市', '1879');
INSERT INTO `base_zip` VALUES ('1894', '420600', '', '襄阳市', '', '1845');
INSERT INTO `base_zip` VALUES ('1895', '420601', '', '', '市辖区', '1894');
INSERT INTO `base_zip` VALUES ('1896', '420602', '', '', '襄城区', '1894');
INSERT INTO `base_zip` VALUES ('1897', '420606', '', '', '樊城区', '1894');
INSERT INTO `base_zip` VALUES ('1898', '420607', '', '', '襄州区', '1894');
INSERT INTO `base_zip` VALUES ('1899', '420624', '', '', '南漳县', '1894');
INSERT INTO `base_zip` VALUES ('1900', '420625', '', '', '谷城县', '1894');
INSERT INTO `base_zip` VALUES ('1901', '420626', '', '', '保康县', '1894');
INSERT INTO `base_zip` VALUES ('1902', '420682', '', '', '老河口市', '1894');
INSERT INTO `base_zip` VALUES ('1903', '420683', '', '', '枣阳市', '1894');
INSERT INTO `base_zip` VALUES ('1904', '420684', '', '', '宜城市', '1894');
INSERT INTO `base_zip` VALUES ('1905', '420700', '', '鄂州市', '', '1845');
INSERT INTO `base_zip` VALUES ('1906', '420701', '', '', '市辖区', '1905');
INSERT INTO `base_zip` VALUES ('1907', '420702', '', '', '梁子湖区', '1905');
INSERT INTO `base_zip` VALUES ('1908', '420703', '', '', '华容区', '1905');
INSERT INTO `base_zip` VALUES ('1909', '420704', '', '', '鄂城区', '1905');
INSERT INTO `base_zip` VALUES ('1910', '420800', '', '荆门市', '', '1845');
INSERT INTO `base_zip` VALUES ('1911', '420801', '', '', '市辖区', '1910');
INSERT INTO `base_zip` VALUES ('1912', '420802', '', '', '东宝区', '1910');
INSERT INTO `base_zip` VALUES ('1913', '420804', '', '', '掇刀区', '1910');
INSERT INTO `base_zip` VALUES ('1914', '420821', '', '', '京山县', '1910');
INSERT INTO `base_zip` VALUES ('1915', '420822', '', '', '沙洋县', '1910');
INSERT INTO `base_zip` VALUES ('1916', '420881', '', '', '钟祥市', '1910');
INSERT INTO `base_zip` VALUES ('1917', '420900', '', '孝感市', '', '1845');
INSERT INTO `base_zip` VALUES ('1918', '420901', '', '', '市辖区', '1917');
INSERT INTO `base_zip` VALUES ('1919', '420902', '', '', '孝南区', '1917');
INSERT INTO `base_zip` VALUES ('1920', '420921', '', '', '孝昌县', '1917');
INSERT INTO `base_zip` VALUES ('1921', '420922', '', '', '大悟县', '1917');
INSERT INTO `base_zip` VALUES ('1922', '420923', '', '', '云梦县', '1917');
INSERT INTO `base_zip` VALUES ('1923', '420981', '', '', '应城市', '1917');
INSERT INTO `base_zip` VALUES ('1924', '420982', '', '', '安陆市', '1917');
INSERT INTO `base_zip` VALUES ('1925', '420984', '', '', '汉川市', '1917');
INSERT INTO `base_zip` VALUES ('1926', '421000', '', '荆州市', '', '1845');
INSERT INTO `base_zip` VALUES ('1927', '421001', '', '', '市辖区', '1926');
INSERT INTO `base_zip` VALUES ('1928', '421002', '', '', '沙市区', '1926');
INSERT INTO `base_zip` VALUES ('1929', '421003', '', '', '荆州区', '1926');
INSERT INTO `base_zip` VALUES ('1930', '421022', '', '', '公安县', '1926');
INSERT INTO `base_zip` VALUES ('1931', '421023', '', '', '监利县', '1926');
INSERT INTO `base_zip` VALUES ('1932', '421024', '', '', '江陵县', '1926');
INSERT INTO `base_zip` VALUES ('1933', '421081', '', '', '石首市', '1926');
INSERT INTO `base_zip` VALUES ('1934', '421083', '', '', '洪湖市', '1926');
INSERT INTO `base_zip` VALUES ('1935', '421087', '', '', '松滋市', '1926');
INSERT INTO `base_zip` VALUES ('1936', '421100', '', '黄冈市', '', '1845');
INSERT INTO `base_zip` VALUES ('1937', '421101', '', '', '市辖区', '1936');
INSERT INTO `base_zip` VALUES ('1938', '421102', '', '', '黄州区', '1936');
INSERT INTO `base_zip` VALUES ('1939', '421121', '', '', '团风县', '1936');
INSERT INTO `base_zip` VALUES ('1940', '421122', '', '', '红安县', '1936');
INSERT INTO `base_zip` VALUES ('1941', '421123', '', '', '罗田县', '1936');
INSERT INTO `base_zip` VALUES ('1942', '421124', '', '', '英山县', '1936');
INSERT INTO `base_zip` VALUES ('1943', '421125', '', '', '浠水县', '1936');
INSERT INTO `base_zip` VALUES ('1944', '421126', '', '', '蕲春县', '1936');
INSERT INTO `base_zip` VALUES ('1945', '421127', '', '', '黄梅县', '1936');
INSERT INTO `base_zip` VALUES ('1946', '421181', '', '', '麻城市', '1936');
INSERT INTO `base_zip` VALUES ('1947', '421182', '', '', '武穴市', '1936');
INSERT INTO `base_zip` VALUES ('1948', '421200', '', '咸宁市', '', '1845');
INSERT INTO `base_zip` VALUES ('1949', '421201', '', '', '市辖区', '1948');
INSERT INTO `base_zip` VALUES ('1950', '421202', '', '', '咸安区', '1948');
INSERT INTO `base_zip` VALUES ('1951', '421221', '', '', '嘉鱼县', '1948');
INSERT INTO `base_zip` VALUES ('1952', '421222', '', '', '通城县', '1948');
INSERT INTO `base_zip` VALUES ('1953', '421223', '', '', '崇阳县', '1948');
INSERT INTO `base_zip` VALUES ('1954', '421224', '', '', '通山县', '1948');
INSERT INTO `base_zip` VALUES ('1955', '421281', '', '', '赤壁市', '1948');
INSERT INTO `base_zip` VALUES ('1956', '421300', '', '随州市', '', '1845');
INSERT INTO `base_zip` VALUES ('1957', '421301', '', '', '市辖区', '1956');
INSERT INTO `base_zip` VALUES ('1958', '421303', '', '', '曾都区', '1956');
INSERT INTO `base_zip` VALUES ('1959', '421321', '', '', '随县', '1956');
INSERT INTO `base_zip` VALUES ('1960', '421381', '', '', '广水市', '1956');
INSERT INTO `base_zip` VALUES ('1961', '422800', '', '恩施土家族苗族自治州', '', '1845');
INSERT INTO `base_zip` VALUES ('1962', '422801', '', '', '恩施市', '1961');
INSERT INTO `base_zip` VALUES ('1963', '422802', '', '', '利川市', '1961');
INSERT INTO `base_zip` VALUES ('1964', '422822', '', '', '建始县', '1961');
INSERT INTO `base_zip` VALUES ('1965', '422823', '', '', '巴东县', '1961');
INSERT INTO `base_zip` VALUES ('1966', '422825', '', '', '宣恩县', '1961');
INSERT INTO `base_zip` VALUES ('1967', '422826', '', '', '咸丰县', '1961');
INSERT INTO `base_zip` VALUES ('1968', '422827', '', '', '来凤县', '1961');
INSERT INTO `base_zip` VALUES ('1969', '422828', '', '', '鹤峰县', '1961');
INSERT INTO `base_zip` VALUES ('1970', '429000', '', '省直辖县级行政区划', '', '1845');
INSERT INTO `base_zip` VALUES ('1971', '429004', '', '', '仙桃市', '1970');
INSERT INTO `base_zip` VALUES ('1972', '429005', '', '', '潜江市', '1970');
INSERT INTO `base_zip` VALUES ('1973', '429006', '', '', '天门市', '1970');
INSERT INTO `base_zip` VALUES ('1974', '429021', '', '', '神农架林区', '1970');
INSERT INTO `base_zip` VALUES ('1975', '430000', '湖南省', '', '', '1');
INSERT INTO `base_zip` VALUES ('1976', '430100', '', '长沙市', '', '1975');
INSERT INTO `base_zip` VALUES ('1977', '430101', '', '', '市辖区', '1976');
INSERT INTO `base_zip` VALUES ('1978', '430102', '', '', '芙蓉区', '1976');
INSERT INTO `base_zip` VALUES ('1979', '430103', '', '', '天心区', '1976');
INSERT INTO `base_zip` VALUES ('1980', '430104', '', '', '岳麓区', '1976');
INSERT INTO `base_zip` VALUES ('1981', '430105', '', '', '开福区', '1976');
INSERT INTO `base_zip` VALUES ('1982', '430111', '', '', '雨花区', '1976');
INSERT INTO `base_zip` VALUES ('1983', '430112', '', '', '望城区', '1976');
INSERT INTO `base_zip` VALUES ('1984', '430121', '', '', '长沙县', '1976');
INSERT INTO `base_zip` VALUES ('1985', '430124', '', '', '宁乡县', '1976');
INSERT INTO `base_zip` VALUES ('1986', '430181', '', '', '浏阳市', '1976');
INSERT INTO `base_zip` VALUES ('1987', '430200', '', '株洲市', '', '1975');
INSERT INTO `base_zip` VALUES ('1988', '430201', '', '', '市辖区', '1987');
INSERT INTO `base_zip` VALUES ('1989', '430202', '', '', '荷塘区', '1987');
INSERT INTO `base_zip` VALUES ('1990', '430203', '', '', '芦淞区', '1987');
INSERT INTO `base_zip` VALUES ('1991', '430204', '', '', '石峰区', '1987');
INSERT INTO `base_zip` VALUES ('1992', '430211', '', '', '天元区', '1987');
INSERT INTO `base_zip` VALUES ('1993', '430221', '', '', '株洲县', '1987');
INSERT INTO `base_zip` VALUES ('1994', '430223', '', '', '攸县', '1987');
INSERT INTO `base_zip` VALUES ('1995', '430224', '', '', '茶陵县', '1987');
INSERT INTO `base_zip` VALUES ('1996', '430225', '', '', '炎陵县', '1987');
INSERT INTO `base_zip` VALUES ('1997', '430281', '', '', '醴陵市', '1987');
INSERT INTO `base_zip` VALUES ('1998', '430300', '', '湘潭市', '', '1975');
INSERT INTO `base_zip` VALUES ('1999', '430301', '', '', '市辖区', '1998');
INSERT INTO `base_zip` VALUES ('2000', '430302', '', '', '雨湖区', '1998');
INSERT INTO `base_zip` VALUES ('2001', '430304', '', '', '岳塘区', '1998');
INSERT INTO `base_zip` VALUES ('2002', '430321', '', '', '湘潭县', '1998');
INSERT INTO `base_zip` VALUES ('2003', '430381', '', '', '湘乡市', '1998');
INSERT INTO `base_zip` VALUES ('2004', '430382', '', '', '韶山市', '1998');
INSERT INTO `base_zip` VALUES ('2005', '430400', '', '衡阳市', '', '1975');
INSERT INTO `base_zip` VALUES ('2006', '430401', '', '', '市辖区', '2005');
INSERT INTO `base_zip` VALUES ('2007', '430405', '', '', '珠晖区', '2005');
INSERT INTO `base_zip` VALUES ('2008', '430406', '', '', '雁峰区', '2005');
INSERT INTO `base_zip` VALUES ('2009', '430407', '', '', '石鼓区', '2005');
INSERT INTO `base_zip` VALUES ('2010', '430408', '', '', '蒸湘区', '2005');
INSERT INTO `base_zip` VALUES ('2011', '430412', '', '', '南岳区', '2005');
INSERT INTO `base_zip` VALUES ('2012', '430421', '', '', '衡阳县', '2005');
INSERT INTO `base_zip` VALUES ('2013', '430422', '', '', '衡南县', '2005');
INSERT INTO `base_zip` VALUES ('2014', '430423', '', '', '衡山县', '2005');
INSERT INTO `base_zip` VALUES ('2015', '430424', '', '', '衡东县', '2005');
INSERT INTO `base_zip` VALUES ('2016', '430426', '', '', '祁东县', '2005');
INSERT INTO `base_zip` VALUES ('2017', '430481', '', '', '耒阳市', '2005');
INSERT INTO `base_zip` VALUES ('2018', '430482', '', '', '常宁市', '2005');
INSERT INTO `base_zip` VALUES ('2019', '430500', '', '邵阳市', '', '1975');
INSERT INTO `base_zip` VALUES ('2020', '430501', '', '', '市辖区', '2019');
INSERT INTO `base_zip` VALUES ('2021', '430502', '', '', '双清区', '2019');
INSERT INTO `base_zip` VALUES ('2022', '430503', '', '', '大祥区', '2019');
INSERT INTO `base_zip` VALUES ('2023', '430511', '', '', '北塔区', '2019');
INSERT INTO `base_zip` VALUES ('2024', '430521', '', '', '邵东县', '2019');
INSERT INTO `base_zip` VALUES ('2025', '430522', '', '', '新邵县', '2019');
INSERT INTO `base_zip` VALUES ('2026', '430523', '', '', '邵阳县', '2019');
INSERT INTO `base_zip` VALUES ('2027', '430524', '', '', '隆回县', '2019');
INSERT INTO `base_zip` VALUES ('2028', '430525', '', '', '洞口县', '2019');
INSERT INTO `base_zip` VALUES ('2029', '430527', '', '', '绥宁县', '2019');
INSERT INTO `base_zip` VALUES ('2030', '430528', '', '', '新宁县', '2019');
INSERT INTO `base_zip` VALUES ('2031', '430529', '', '', '城步苗族自治县', '2019');
INSERT INTO `base_zip` VALUES ('2032', '430581', '', '', '武冈市', '2019');
INSERT INTO `base_zip` VALUES ('2033', '430600', '', '岳阳市', '', '1975');
INSERT INTO `base_zip` VALUES ('2034', '430601', '', '', '市辖区', '2033');
INSERT INTO `base_zip` VALUES ('2035', '430602', '', '', '岳阳楼区', '2033');
INSERT INTO `base_zip` VALUES ('2036', '430603', '', '', '云溪区', '2033');
INSERT INTO `base_zip` VALUES ('2037', '430611', '', '', '君山区', '2033');
INSERT INTO `base_zip` VALUES ('2038', '430621', '', '', '岳阳县', '2033');
INSERT INTO `base_zip` VALUES ('2039', '430623', '', '', '华容县', '2033');
INSERT INTO `base_zip` VALUES ('2040', '430624', '', '', '湘阴县', '2033');
INSERT INTO `base_zip` VALUES ('2041', '430626', '', '', '平江县', '2033');
INSERT INTO `base_zip` VALUES ('2042', '430681', '', '', '汨罗市', '2033');
INSERT INTO `base_zip` VALUES ('2043', '430682', '', '', '临湘市', '2033');
INSERT INTO `base_zip` VALUES ('2044', '430700', '', '常德市', '', '1975');
INSERT INTO `base_zip` VALUES ('2045', '430701', '', '', '市辖区', '2044');
INSERT INTO `base_zip` VALUES ('2046', '430702', '', '', '武陵区', '2044');
INSERT INTO `base_zip` VALUES ('2047', '430703', '', '', '鼎城区', '2044');
INSERT INTO `base_zip` VALUES ('2048', '430721', '', '', '安乡县', '2044');
INSERT INTO `base_zip` VALUES ('2049', '430722', '', '', '汉寿县', '2044');
INSERT INTO `base_zip` VALUES ('2050', '430723', '', '', '澧县', '2044');
INSERT INTO `base_zip` VALUES ('2051', '430724', '', '', '临澧县', '2044');
INSERT INTO `base_zip` VALUES ('2052', '430725', '', '', '桃源县', '2044');
INSERT INTO `base_zip` VALUES ('2053', '430726', '', '', '石门县', '2044');
INSERT INTO `base_zip` VALUES ('2054', '430781', '', '', '津市市', '2044');
INSERT INTO `base_zip` VALUES ('2055', '430800', '', '张家界市', '', '1975');
INSERT INTO `base_zip` VALUES ('2056', '430801', '', '', '市辖区', '2055');
INSERT INTO `base_zip` VALUES ('2057', '430802', '', '', '永定区', '2055');
INSERT INTO `base_zip` VALUES ('2058', '430811', '', '', '武陵源区', '2055');
INSERT INTO `base_zip` VALUES ('2059', '430821', '', '', '慈利县', '2055');
INSERT INTO `base_zip` VALUES ('2060', '430822', '', '', '桑植县', '2055');
INSERT INTO `base_zip` VALUES ('2061', '430900', '', '益阳市', '', '1975');
INSERT INTO `base_zip` VALUES ('2062', '430901', '', '', '市辖区', '2061');
INSERT INTO `base_zip` VALUES ('2063', '430902', '', '', '资阳区', '2061');
INSERT INTO `base_zip` VALUES ('2064', '430903', '', '', '赫山区', '2061');
INSERT INTO `base_zip` VALUES ('2065', '430921', '', '', '南县', '2061');
INSERT INTO `base_zip` VALUES ('2066', '430922', '', '', '桃江县', '2061');
INSERT INTO `base_zip` VALUES ('2067', '430923', '', '', '安化县', '2061');
INSERT INTO `base_zip` VALUES ('2068', '430981', '', '', '沅江市', '2061');
INSERT INTO `base_zip` VALUES ('2069', '431000', '', '郴州市', '', '1975');
INSERT INTO `base_zip` VALUES ('2070', '431001', '', '', '市辖区', '2069');
INSERT INTO `base_zip` VALUES ('2071', '431002', '', '', '北湖区', '2069');
INSERT INTO `base_zip` VALUES ('2072', '431003', '', '', '苏仙区', '2069');
INSERT INTO `base_zip` VALUES ('2073', '431021', '', '', '桂阳县', '2069');
INSERT INTO `base_zip` VALUES ('2074', '431022', '', '', '宜章县', '2069');
INSERT INTO `base_zip` VALUES ('2075', '431023', '', '', '永兴县', '2069');
INSERT INTO `base_zip` VALUES ('2076', '431024', '', '', '嘉禾县', '2069');
INSERT INTO `base_zip` VALUES ('2077', '431025', '', '', '临武县', '2069');
INSERT INTO `base_zip` VALUES ('2078', '431026', '', '', '汝城县', '2069');
INSERT INTO `base_zip` VALUES ('2079', '431027', '', '', '桂东县', '2069');
INSERT INTO `base_zip` VALUES ('2080', '431028', '', '', '安仁县', '2069');
INSERT INTO `base_zip` VALUES ('2081', '431081', '', '', '资兴市', '2069');
INSERT INTO `base_zip` VALUES ('2082', '431100', '', '永州市', '', '1975');
INSERT INTO `base_zip` VALUES ('2083', '431101', '', '', '市辖区', '2082');
INSERT INTO `base_zip` VALUES ('2084', '431102', '', '', '零陵区', '2082');
INSERT INTO `base_zip` VALUES ('2085', '431103', '', '', '冷水滩区', '2082');
INSERT INTO `base_zip` VALUES ('2086', '431121', '', '', '祁阳县', '2082');
INSERT INTO `base_zip` VALUES ('2087', '431122', '', '', '东安县', '2082');
INSERT INTO `base_zip` VALUES ('2088', '431123', '', '', '双牌县', '2082');
INSERT INTO `base_zip` VALUES ('2089', '431124', '', '', '道县', '2082');
INSERT INTO `base_zip` VALUES ('2090', '431125', '', '', '江永县', '2082');
INSERT INTO `base_zip` VALUES ('2091', '431126', '', '', '宁远县', '2082');
INSERT INTO `base_zip` VALUES ('2092', '431127', '', '', '蓝山县', '2082');
INSERT INTO `base_zip` VALUES ('2093', '431128', '', '', '新田县', '2082');
INSERT INTO `base_zip` VALUES ('2094', '431129', '', '', '江华瑶族自治县', '2082');
INSERT INTO `base_zip` VALUES ('2095', '431200', '', '怀化市', '', '1975');
INSERT INTO `base_zip` VALUES ('2096', '431201', '', '', '市辖区', '2095');
INSERT INTO `base_zip` VALUES ('2097', '431202', '', '', '鹤城区', '2095');
INSERT INTO `base_zip` VALUES ('2098', '431221', '', '', '中方县', '2095');
INSERT INTO `base_zip` VALUES ('2099', '431222', '', '', '沅陵县', '2095');
INSERT INTO `base_zip` VALUES ('2100', '431223', '', '', '辰溪县', '2095');
INSERT INTO `base_zip` VALUES ('2101', '431224', '', '', '溆浦县', '2095');
INSERT INTO `base_zip` VALUES ('2102', '431225', '', '', '会同县', '2095');
INSERT INTO `base_zip` VALUES ('2103', '431226', '', '', '麻阳苗族自治县', '2095');
INSERT INTO `base_zip` VALUES ('2104', '431227', '', '', '新晃侗族自治县', '2095');
INSERT INTO `base_zip` VALUES ('2105', '431228', '', '', '芷江侗族自治县', '2095');
INSERT INTO `base_zip` VALUES ('2106', '431229', '', '', '靖州苗族侗族自治县', '2095');
INSERT INTO `base_zip` VALUES ('2107', '431230', '', '', '通道侗族自治县', '2095');
INSERT INTO `base_zip` VALUES ('2108', '431281', '', '', '洪江市', '2095');
INSERT INTO `base_zip` VALUES ('2109', '431300', '', '娄底市', '', '1975');
INSERT INTO `base_zip` VALUES ('2110', '431301', '', '', '市辖区', '2109');
INSERT INTO `base_zip` VALUES ('2111', '431302', '', '', '娄星区', '2109');
INSERT INTO `base_zip` VALUES ('2112', '431321', '', '', '双峰县', '2109');
INSERT INTO `base_zip` VALUES ('2113', '431322', '', '', '新化县', '2109');
INSERT INTO `base_zip` VALUES ('2114', '431381', '', '', '冷水江市', '2109');
INSERT INTO `base_zip` VALUES ('2115', '431382', '', '', '涟源市', '2109');
INSERT INTO `base_zip` VALUES ('2116', '433100', '', '湘西土家族苗族自治州', '', '1975');
INSERT INTO `base_zip` VALUES ('2117', '433101', '', '', '吉首市', '2116');
INSERT INTO `base_zip` VALUES ('2118', '433122', '', '', '泸溪县', '2116');
INSERT INTO `base_zip` VALUES ('2119', '433123', '', '', '凤凰县', '2116');
INSERT INTO `base_zip` VALUES ('2120', '433124', '', '', '花垣县', '2116');
INSERT INTO `base_zip` VALUES ('2121', '433125', '', '', '保靖县', '2116');
INSERT INTO `base_zip` VALUES ('2122', '433126', '', '', '古丈县', '2116');
INSERT INTO `base_zip` VALUES ('2123', '433127', '', '', '永顺县', '2116');
INSERT INTO `base_zip` VALUES ('2124', '433130', '', '', '龙山县', '2116');
INSERT INTO `base_zip` VALUES ('2125', '440000', '广东省', '', '', '1');
INSERT INTO `base_zip` VALUES ('2126', '440100', '', '广州市', '', '2125');
INSERT INTO `base_zip` VALUES ('2127', '440101', '', '', '市辖区', '2126');
INSERT INTO `base_zip` VALUES ('2128', '440103', '', '', '荔湾区', '2126');
INSERT INTO `base_zip` VALUES ('2129', '440104', '', '', '越秀区', '2126');
INSERT INTO `base_zip` VALUES ('2130', '440105', '', '', '海珠区', '2126');
INSERT INTO `base_zip` VALUES ('2131', '440106', '', '', '天河区', '2126');
INSERT INTO `base_zip` VALUES ('2132', '440111', '', '', '白云区', '2126');
INSERT INTO `base_zip` VALUES ('2133', '440112', '', '', '黄埔区', '2126');
INSERT INTO `base_zip` VALUES ('2134', '440113', '', '', '番禺区', '2126');
INSERT INTO `base_zip` VALUES ('2135', '440114', '', '', '花都区', '2126');
INSERT INTO `base_zip` VALUES ('2136', '440115', '', '', '南沙区', '2126');
INSERT INTO `base_zip` VALUES ('2137', '440117', '', '', '从化区', '2126');
INSERT INTO `base_zip` VALUES ('2138', '440118', '', '', '增城区', '2126');
INSERT INTO `base_zip` VALUES ('2139', '440200', '', '韶关市', '', '2125');
INSERT INTO `base_zip` VALUES ('2140', '440201', '', '', '市辖区', '2139');
INSERT INTO `base_zip` VALUES ('2141', '440203', '', '', '武江区', '2139');
INSERT INTO `base_zip` VALUES ('2142', '440204', '', '', '浈江区', '2139');
INSERT INTO `base_zip` VALUES ('2143', '440205', '', '', '曲江区', '2139');
INSERT INTO `base_zip` VALUES ('2144', '440222', '', '', '始兴县', '2139');
INSERT INTO `base_zip` VALUES ('2145', '440224', '', '', '仁化县', '2139');
INSERT INTO `base_zip` VALUES ('2146', '440229', '', '', '翁源县', '2139');
INSERT INTO `base_zip` VALUES ('2147', '440232', '', '', '乳源瑶族自治县', '2139');
INSERT INTO `base_zip` VALUES ('2148', '440233', '', '', '新丰县', '2139');
INSERT INTO `base_zip` VALUES ('2149', '440281', '', '', '乐昌市', '2139');
INSERT INTO `base_zip` VALUES ('2150', '440282', '', '', '南雄市', '2139');
INSERT INTO `base_zip` VALUES ('2151', '440300', '', '深圳市', '', '2125');
INSERT INTO `base_zip` VALUES ('2152', '440301', '', '', '市辖区', '2151');
INSERT INTO `base_zip` VALUES ('2153', '440303', '', '', '罗湖区', '2151');
INSERT INTO `base_zip` VALUES ('2154', '440304', '', '', '福田区', '2151');
INSERT INTO `base_zip` VALUES ('2155', '440305', '', '', '南山区', '2151');
INSERT INTO `base_zip` VALUES ('2156', '440306', '', '', '宝安区', '2151');
INSERT INTO `base_zip` VALUES ('2157', '440307', '', '', '龙岗区', '2151');
INSERT INTO `base_zip` VALUES ('2158', '440308', '', '', '盐田区', '2151');
INSERT INTO `base_zip` VALUES ('2159', '440400', '', '珠海市', '', '2125');
INSERT INTO `base_zip` VALUES ('2160', '440401', '', '', '市辖区', '2159');
INSERT INTO `base_zip` VALUES ('2161', '440402', '', '', '香洲区', '2159');
INSERT INTO `base_zip` VALUES ('2162', '440403', '', '', '斗门区', '2159');
INSERT INTO `base_zip` VALUES ('2163', '440404', '', '', '金湾区', '2159');
INSERT INTO `base_zip` VALUES ('2164', '440500', '', '汕头市', '', '2125');
INSERT INTO `base_zip` VALUES ('2165', '440501', '', '', '市辖区', '2164');
INSERT INTO `base_zip` VALUES ('2166', '440507', '', '', '龙湖区', '2164');
INSERT INTO `base_zip` VALUES ('2167', '440511', '', '', '金平区', '2164');
INSERT INTO `base_zip` VALUES ('2168', '440512', '', '', '濠江区', '2164');
INSERT INTO `base_zip` VALUES ('2169', '440513', '', '', '潮阳区', '2164');
INSERT INTO `base_zip` VALUES ('2170', '440514', '', '', '潮南区', '2164');
INSERT INTO `base_zip` VALUES ('2171', '440515', '', '', '澄海区', '2164');
INSERT INTO `base_zip` VALUES ('2172', '440523', '', '', '南澳县', '2164');
INSERT INTO `base_zip` VALUES ('2173', '440600', '', '佛山市', '', '2125');
INSERT INTO `base_zip` VALUES ('2174', '440601', '', '', '市辖区', '2173');
INSERT INTO `base_zip` VALUES ('2175', '440604', '', '', '禅城区', '2173');
INSERT INTO `base_zip` VALUES ('2176', '440605', '', '', '南海区', '2173');
INSERT INTO `base_zip` VALUES ('2177', '440606', '', '', '顺德区', '2173');
INSERT INTO `base_zip` VALUES ('2178', '440607', '', '', '三水区', '2173');
INSERT INTO `base_zip` VALUES ('2179', '440608', '', '', '高明区', '2173');
INSERT INTO `base_zip` VALUES ('2180', '440700', '', '江门市', '', '2125');
INSERT INTO `base_zip` VALUES ('2181', '440701', '', '', '市辖区', '2180');
INSERT INTO `base_zip` VALUES ('2182', '440703', '', '', '蓬江区', '2180');
INSERT INTO `base_zip` VALUES ('2183', '440704', '', '', '江海区', '2180');
INSERT INTO `base_zip` VALUES ('2184', '440705', '', '', '新会区', '2180');
INSERT INTO `base_zip` VALUES ('2185', '440781', '', '', '台山市', '2180');
INSERT INTO `base_zip` VALUES ('2186', '440783', '', '', '开平市', '2180');
INSERT INTO `base_zip` VALUES ('2187', '440784', '', '', '鹤山市', '2180');
INSERT INTO `base_zip` VALUES ('2188', '440785', '', '', '恩平市', '2180');
INSERT INTO `base_zip` VALUES ('2189', '440800', '', '湛江市', '', '2125');
INSERT INTO `base_zip` VALUES ('2190', '440801', '', '', '市辖区', '2189');
INSERT INTO `base_zip` VALUES ('2191', '440802', '', '', '赤坎区', '2189');
INSERT INTO `base_zip` VALUES ('2192', '440803', '', '', '霞山区', '2189');
INSERT INTO `base_zip` VALUES ('2193', '440804', '', '', '坡头区', '2189');
INSERT INTO `base_zip` VALUES ('2194', '440811', '', '', '麻章区', '2189');
INSERT INTO `base_zip` VALUES ('2195', '440823', '', '', '遂溪县', '2189');
INSERT INTO `base_zip` VALUES ('2196', '440825', '', '', '徐闻县', '2189');
INSERT INTO `base_zip` VALUES ('2197', '440881', '', '', '廉江市', '2189');
INSERT INTO `base_zip` VALUES ('2198', '440882', '', '', '雷州市', '2189');
INSERT INTO `base_zip` VALUES ('2199', '440883', '', '', '吴川市', '2189');
INSERT INTO `base_zip` VALUES ('2200', '440900', '', '茂名市', '', '2125');
INSERT INTO `base_zip` VALUES ('2201', '440901', '', '', '市辖区', '2200');
INSERT INTO `base_zip` VALUES ('2202', '440902', '', '', '茂南区', '2200');
INSERT INTO `base_zip` VALUES ('2203', '440904', '', '', '电白区', '2200');
INSERT INTO `base_zip` VALUES ('2204', '440981', '', '', '高州市', '2200');
INSERT INTO `base_zip` VALUES ('2205', '440982', '', '', '化州市', '2200');
INSERT INTO `base_zip` VALUES ('2206', '440983', '', '', '信宜市', '2200');
INSERT INTO `base_zip` VALUES ('2207', '441200', '', '肇庆市', '', '2125');
INSERT INTO `base_zip` VALUES ('2208', '441201', '', '', '市辖区', '2207');
INSERT INTO `base_zip` VALUES ('2209', '441202', '', '', '端州区', '2207');
INSERT INTO `base_zip` VALUES ('2210', '441203', '', '', '鼎湖区', '2207');
INSERT INTO `base_zip` VALUES ('2211', '441223', '', '', '广宁县', '2207');
INSERT INTO `base_zip` VALUES ('2212', '441224', '', '', '怀集县', '2207');
INSERT INTO `base_zip` VALUES ('2213', '441225', '', '', '封开县', '2207');
INSERT INTO `base_zip` VALUES ('2214', '441226', '', '', '德庆县', '2207');
INSERT INTO `base_zip` VALUES ('2215', '441283', '', '', '高要市', '2207');
INSERT INTO `base_zip` VALUES ('2216', '441284', '', '', '四会市', '2207');
INSERT INTO `base_zip` VALUES ('2217', '441300', '', '惠州市', '', '2125');
INSERT INTO `base_zip` VALUES ('2218', '441301', '', '', '市辖区', '2217');
INSERT INTO `base_zip` VALUES ('2219', '441302', '', '', '惠城区', '2217');
INSERT INTO `base_zip` VALUES ('2220', '441303', '', '', '惠阳区', '2217');
INSERT INTO `base_zip` VALUES ('2221', '441322', '', '', '博罗县', '2217');
INSERT INTO `base_zip` VALUES ('2222', '441323', '', '', '惠东县', '2217');
INSERT INTO `base_zip` VALUES ('2223', '441324', '', '', '龙门县', '2217');
INSERT INTO `base_zip` VALUES ('2224', '441400', '', '梅州市', '', '2125');
INSERT INTO `base_zip` VALUES ('2225', '441401', '', '', '市辖区', '2224');
INSERT INTO `base_zip` VALUES ('2226', '441402', '', '', '梅江区', '2224');
INSERT INTO `base_zip` VALUES ('2227', '441403', '', '', '梅县区', '2224');
INSERT INTO `base_zip` VALUES ('2228', '441422', '', '', '大埔县', '2224');
INSERT INTO `base_zip` VALUES ('2229', '441423', '', '', '丰顺县', '2224');
INSERT INTO `base_zip` VALUES ('2230', '441424', '', '', '五华县', '2224');
INSERT INTO `base_zip` VALUES ('2231', '441426', '', '', '平远县', '2224');
INSERT INTO `base_zip` VALUES ('2232', '441427', '', '', '蕉岭县', '2224');
INSERT INTO `base_zip` VALUES ('2233', '441481', '', '', '兴宁市', '2224');
INSERT INTO `base_zip` VALUES ('2234', '441500', '', '汕尾市', '', '2125');
INSERT INTO `base_zip` VALUES ('2235', '441501', '', '', '市辖区', '2234');
INSERT INTO `base_zip` VALUES ('2236', '441502', '', '', '城区', '2234');
INSERT INTO `base_zip` VALUES ('2237', '441521', '', '', '海丰县', '2234');
INSERT INTO `base_zip` VALUES ('2238', '441523', '', '', '陆河县', '2234');
INSERT INTO `base_zip` VALUES ('2239', '441581', '', '', '陆丰市', '2234');
INSERT INTO `base_zip` VALUES ('2240', '441600', '', '河源市', '', '2125');
INSERT INTO `base_zip` VALUES ('2241', '441601', '', '', '市辖区', '2240');
INSERT INTO `base_zip` VALUES ('2242', '441602', '', '', '源城区', '2240');
INSERT INTO `base_zip` VALUES ('2243', '441621', '', '', '紫金县', '2240');
INSERT INTO `base_zip` VALUES ('2244', '441622', '', '', '龙川县', '2240');
INSERT INTO `base_zip` VALUES ('2245', '441623', '', '', '连平县', '2240');
INSERT INTO `base_zip` VALUES ('2246', '441624', '', '', '和平县', '2240');
INSERT INTO `base_zip` VALUES ('2247', '441625', '', '', '东源县', '2240');
INSERT INTO `base_zip` VALUES ('2248', '441700', '', '阳江市', '', '2125');
INSERT INTO `base_zip` VALUES ('2249', '441701', '', '', '市辖区', '2248');
INSERT INTO `base_zip` VALUES ('2250', '441702', '', '', '江城区', '2248');
INSERT INTO `base_zip` VALUES ('2251', '441704', '', '', '阳东区', '2248');
INSERT INTO `base_zip` VALUES ('2252', '441721', '', '', '阳西县', '2248');
INSERT INTO `base_zip` VALUES ('2253', '441781', '', '', '阳春市', '2248');
INSERT INTO `base_zip` VALUES ('2254', '441800', '', '清远市', '', '2125');
INSERT INTO `base_zip` VALUES ('2255', '441801', '', '', '市辖区', '2254');
INSERT INTO `base_zip` VALUES ('2256', '441802', '', '', '清城区', '2254');
INSERT INTO `base_zip` VALUES ('2257', '441803', '', '', '清新区', '2254');
INSERT INTO `base_zip` VALUES ('2258', '441821', '', '', '佛冈县', '2254');
INSERT INTO `base_zip` VALUES ('2259', '441823', '', '', '阳山县', '2254');
INSERT INTO `base_zip` VALUES ('2260', '441825', '', '', '连山壮族瑶族自治县', '2254');
INSERT INTO `base_zip` VALUES ('2261', '441826', '', '', '连南瑶族自治县', '2254');
INSERT INTO `base_zip` VALUES ('2262', '441881', '', '', '英德市', '2254');
INSERT INTO `base_zip` VALUES ('2263', '441882', '', '', '连州市', '2254');
INSERT INTO `base_zip` VALUES ('2264', '441900', '', '东莞市', '', '2125');
INSERT INTO `base_zip` VALUES ('2265', '442000', '', '中山市', '', '2125');
INSERT INTO `base_zip` VALUES ('2266', '445100', '', '潮州市', '', '2125');
INSERT INTO `base_zip` VALUES ('2267', '445101', '', '', '市辖区', '2266');
INSERT INTO `base_zip` VALUES ('2268', '445102', '', '', '湘桥区', '2266');
INSERT INTO `base_zip` VALUES ('2269', '445103', '', '', '潮安区', '2266');
INSERT INTO `base_zip` VALUES ('2270', '445122', '', '', '饶平县', '2266');
INSERT INTO `base_zip` VALUES ('2271', '445200', '', '揭阳市', '', '2125');
INSERT INTO `base_zip` VALUES ('2272', '445201', '', '', '市辖区', '2271');
INSERT INTO `base_zip` VALUES ('2273', '445202', '', '', '榕城区', '2271');
INSERT INTO `base_zip` VALUES ('2274', '445203', '', '', '揭东区', '2271');
INSERT INTO `base_zip` VALUES ('2275', '445222', '', '', '揭西县', '2271');
INSERT INTO `base_zip` VALUES ('2276', '445224', '', '', '惠来县', '2271');
INSERT INTO `base_zip` VALUES ('2277', '445281', '', '', '普宁市', '2271');
INSERT INTO `base_zip` VALUES ('2278', '445300', '', '云浮市', '', '2125');
INSERT INTO `base_zip` VALUES ('2279', '445301', '', '', '市辖区', '2278');
INSERT INTO `base_zip` VALUES ('2280', '445302', '', '', '云城区', '2278');
INSERT INTO `base_zip` VALUES ('2281', '445303', '', '', '云安区', '2278');
INSERT INTO `base_zip` VALUES ('2282', '445321', '', '', '新兴县', '2278');
INSERT INTO `base_zip` VALUES ('2283', '445322', '', '', '郁南县', '2278');
INSERT INTO `base_zip` VALUES ('2284', '445381', '', '', '罗定市', '2278');
INSERT INTO `base_zip` VALUES ('2285', '450000', '广西壮族自治区', '', '', '1');
INSERT INTO `base_zip` VALUES ('2286', '450100', '', '南宁市', '', '2285');
INSERT INTO `base_zip` VALUES ('2287', '450101', '', '', '市辖区', '2286');
INSERT INTO `base_zip` VALUES ('2288', '450102', '', '', '兴宁区', '2286');
INSERT INTO `base_zip` VALUES ('2289', '450103', '', '', '青秀区', '2286');
INSERT INTO `base_zip` VALUES ('2290', '450105', '', '', '江南区', '2286');
INSERT INTO `base_zip` VALUES ('2291', '450107', '', '', '西乡塘区', '2286');
INSERT INTO `base_zip` VALUES ('2292', '450108', '', '', '良庆区', '2286');
INSERT INTO `base_zip` VALUES ('2293', '450109', '', '', '邕宁区', '2286');
INSERT INTO `base_zip` VALUES ('2294', '450122', '', '', '武鸣县', '2286');
INSERT INTO `base_zip` VALUES ('2295', '450123', '', '', '隆安县', '2286');
INSERT INTO `base_zip` VALUES ('2296', '450124', '', '', '马山县', '2286');
INSERT INTO `base_zip` VALUES ('2297', '450125', '', '', '上林县', '2286');
INSERT INTO `base_zip` VALUES ('2298', '450126', '', '', '宾阳县', '2286');
INSERT INTO `base_zip` VALUES ('2299', '450127', '', '', '横县', '2286');
INSERT INTO `base_zip` VALUES ('2300', '450200', '', '柳州市', '', '2285');
INSERT INTO `base_zip` VALUES ('2301', '450201', '', '', '市辖区', '2300');
INSERT INTO `base_zip` VALUES ('2302', '450202', '', '', '城中区', '2300');
INSERT INTO `base_zip` VALUES ('2303', '450203', '', '', '鱼峰区', '2300');
INSERT INTO `base_zip` VALUES ('2304', '450204', '', '', '柳南区', '2300');
INSERT INTO `base_zip` VALUES ('2305', '450205', '', '', '柳北区', '2300');
INSERT INTO `base_zip` VALUES ('2306', '450221', '', '', '柳江县', '2300');
INSERT INTO `base_zip` VALUES ('2307', '450222', '', '', '柳城县', '2300');
INSERT INTO `base_zip` VALUES ('2308', '450223', '', '', '鹿寨县', '2300');
INSERT INTO `base_zip` VALUES ('2309', '450224', '', '', '融安县', '2300');
INSERT INTO `base_zip` VALUES ('2310', '450225', '', '', '融水苗族自治县', '2300');
INSERT INTO `base_zip` VALUES ('2311', '450226', '', '', '三江侗族自治县', '2300');
INSERT INTO `base_zip` VALUES ('2312', '450300', '', '桂林市', '', '2285');
INSERT INTO `base_zip` VALUES ('2313', '450301', '', '', '市辖区', '2312');
INSERT INTO `base_zip` VALUES ('2314', '450302', '', '', '秀峰区', '2312');
INSERT INTO `base_zip` VALUES ('2315', '450303', '', '', '叠彩区', '2312');
INSERT INTO `base_zip` VALUES ('2316', '450304', '', '', '象山区', '2312');
INSERT INTO `base_zip` VALUES ('2317', '450305', '', '', '七星区', '2312');
INSERT INTO `base_zip` VALUES ('2318', '450311', '', '', '雁山区', '2312');
INSERT INTO `base_zip` VALUES ('2319', '450312', '', '', '临桂区', '2312');
INSERT INTO `base_zip` VALUES ('2320', '450321', '', '', '阳朔县', '2312');
INSERT INTO `base_zip` VALUES ('2321', '450323', '', '', '灵川县', '2312');
INSERT INTO `base_zip` VALUES ('2322', '450324', '', '', '全州县', '2312');
INSERT INTO `base_zip` VALUES ('2323', '450325', '', '', '兴安县', '2312');
INSERT INTO `base_zip` VALUES ('2324', '450326', '', '', '永福县', '2312');
INSERT INTO `base_zip` VALUES ('2325', '450327', '', '', '灌阳县', '2312');
INSERT INTO `base_zip` VALUES ('2326', '450328', '', '', '龙胜各族自治县', '2312');
INSERT INTO `base_zip` VALUES ('2327', '450329', '', '', '资源县', '2312');
INSERT INTO `base_zip` VALUES ('2328', '450330', '', '', '平乐县', '2312');
INSERT INTO `base_zip` VALUES ('2329', '450331', '', '', '荔浦县', '2312');
INSERT INTO `base_zip` VALUES ('2330', '450332', '', '', '恭城瑶族自治县', '2312');
INSERT INTO `base_zip` VALUES ('2331', '450400', '', '梧州市', '', '2285');
INSERT INTO `base_zip` VALUES ('2332', '450401', '', '', '市辖区', '2331');
INSERT INTO `base_zip` VALUES ('2333', '450403', '', '', '万秀区', '2331');
INSERT INTO `base_zip` VALUES ('2334', '450405', '', '', '长洲区', '2331');
INSERT INTO `base_zip` VALUES ('2335', '450406', '', '', '龙圩区', '2331');
INSERT INTO `base_zip` VALUES ('2336', '450421', '', '', '苍梧县', '2331');
INSERT INTO `base_zip` VALUES ('2337', '450422', '', '', '藤县', '2331');
INSERT INTO `base_zip` VALUES ('2338', '450423', '', '', '蒙山县', '2331');
INSERT INTO `base_zip` VALUES ('2339', '450481', '', '', '岑溪市', '2331');
INSERT INTO `base_zip` VALUES ('2340', '450500', '', '北海市', '', '2285');
INSERT INTO `base_zip` VALUES ('2341', '450501', '', '', '市辖区', '2340');
INSERT INTO `base_zip` VALUES ('2342', '450502', '', '', '海城区', '2340');
INSERT INTO `base_zip` VALUES ('2343', '450503', '', '', '银海区', '2340');
INSERT INTO `base_zip` VALUES ('2344', '450512', '', '', '铁山港区', '2340');
INSERT INTO `base_zip` VALUES ('2345', '450521', '', '', '合浦县', '2340');
INSERT INTO `base_zip` VALUES ('2346', '450600', '', '防城港市', '', '2285');
INSERT INTO `base_zip` VALUES ('2347', '450601', '', '', '市辖区', '2346');
INSERT INTO `base_zip` VALUES ('2348', '450602', '', '', '港口区', '2346');
INSERT INTO `base_zip` VALUES ('2349', '450603', '', '', '防城区', '2346');
INSERT INTO `base_zip` VALUES ('2350', '450621', '', '', '上思县', '2346');
INSERT INTO `base_zip` VALUES ('2351', '450681', '', '', '东兴市', '2346');
INSERT INTO `base_zip` VALUES ('2352', '450700', '', '钦州市', '', '2285');
INSERT INTO `base_zip` VALUES ('2353', '450701', '', '', '市辖区', '2352');
INSERT INTO `base_zip` VALUES ('2354', '450702', '', '', '钦南区', '2352');
INSERT INTO `base_zip` VALUES ('2355', '450703', '', '', '钦北区', '2352');
INSERT INTO `base_zip` VALUES ('2356', '450721', '', '', '灵山县', '2352');
INSERT INTO `base_zip` VALUES ('2357', '450722', '', '', '浦北县', '2352');
INSERT INTO `base_zip` VALUES ('2358', '450800', '', '贵港市', '', '2285');
INSERT INTO `base_zip` VALUES ('2359', '450801', '', '', '市辖区', '2358');
INSERT INTO `base_zip` VALUES ('2360', '450802', '', '', '港北区', '2358');
INSERT INTO `base_zip` VALUES ('2361', '450803', '', '', '港南区', '2358');
INSERT INTO `base_zip` VALUES ('2362', '450804', '', '', '覃塘区', '2358');
INSERT INTO `base_zip` VALUES ('2363', '450821', '', '', '平南县', '2358');
INSERT INTO `base_zip` VALUES ('2364', '450881', '', '', '桂平市', '2358');
INSERT INTO `base_zip` VALUES ('2365', '450900', '', '玉林市', '', '2285');
INSERT INTO `base_zip` VALUES ('2366', '450901', '', '', '市辖区', '2365');
INSERT INTO `base_zip` VALUES ('2367', '450902', '', '', '玉州区', '2365');
INSERT INTO `base_zip` VALUES ('2368', '450903', '', '', '福绵区', '2365');
INSERT INTO `base_zip` VALUES ('2369', '450921', '', '', '容县', '2365');
INSERT INTO `base_zip` VALUES ('2370', '450922', '', '', '陆川县', '2365');
INSERT INTO `base_zip` VALUES ('2371', '450923', '', '', '博白县', '2365');
INSERT INTO `base_zip` VALUES ('2372', '450924', '', '', '兴业县', '2365');
INSERT INTO `base_zip` VALUES ('2373', '450981', '', '', '北流市', '2365');
INSERT INTO `base_zip` VALUES ('2374', '451000', '', '百色市', '', '2285');
INSERT INTO `base_zip` VALUES ('2375', '451001', '', '', '市辖区', '2374');
INSERT INTO `base_zip` VALUES ('2376', '451002', '', '', '右江区', '2374');
INSERT INTO `base_zip` VALUES ('2377', '451021', '', '', '田阳县', '2374');
INSERT INTO `base_zip` VALUES ('2378', '451022', '', '', '田东县', '2374');
INSERT INTO `base_zip` VALUES ('2379', '451023', '', '', '平果县', '2374');
INSERT INTO `base_zip` VALUES ('2380', '451024', '', '', '德保县', '2374');
INSERT INTO `base_zip` VALUES ('2381', '451025', '', '', '靖西县', '2374');
INSERT INTO `base_zip` VALUES ('2382', '451026', '', '', '那坡县', '2374');
INSERT INTO `base_zip` VALUES ('2383', '451027', '', '', '凌云县', '2374');
INSERT INTO `base_zip` VALUES ('2384', '451028', '', '', '乐业县', '2374');
INSERT INTO `base_zip` VALUES ('2385', '451029', '', '', '田林县', '2374');
INSERT INTO `base_zip` VALUES ('2386', '451030', '', '', '西林县', '2374');
INSERT INTO `base_zip` VALUES ('2387', '451031', '', '', '隆林各族自治县', '2374');
INSERT INTO `base_zip` VALUES ('2388', '451100', '', '贺州市', '', '2285');
INSERT INTO `base_zip` VALUES ('2389', '451101', '', '', '市辖区', '2388');
INSERT INTO `base_zip` VALUES ('2390', '451102', '', '', '八步区', '2388');
INSERT INTO `base_zip` VALUES ('2391', '451119', '', '', '平桂管理区', '2388');
INSERT INTO `base_zip` VALUES ('2392', '451121', '', '', '昭平县', '2388');
INSERT INTO `base_zip` VALUES ('2393', '451122', '', '', '钟山县', '2388');
INSERT INTO `base_zip` VALUES ('2394', '451123', '', '', '富川瑶族自治县', '2388');
INSERT INTO `base_zip` VALUES ('2395', '451200', '', '河池市', '', '2285');
INSERT INTO `base_zip` VALUES ('2396', '451201', '', '', '市辖区', '2395');
INSERT INTO `base_zip` VALUES ('2397', '451202', '', '', '金城江区', '2395');
INSERT INTO `base_zip` VALUES ('2398', '451221', '', '', '南丹县', '2395');
INSERT INTO `base_zip` VALUES ('2399', '451222', '', '', '天峨县', '2395');
INSERT INTO `base_zip` VALUES ('2400', '451223', '', '', '凤山县', '2395');
INSERT INTO `base_zip` VALUES ('2401', '451224', '', '', '东兰县', '2395');
INSERT INTO `base_zip` VALUES ('2402', '451225', '', '', '罗城仫佬族自治县', '2395');
INSERT INTO `base_zip` VALUES ('2403', '451226', '', '', '环江毛南族自治县', '2395');
INSERT INTO `base_zip` VALUES ('2404', '451227', '', '', '巴马瑶族自治县', '2395');
INSERT INTO `base_zip` VALUES ('2405', '451228', '', '', '都安瑶族自治县', '2395');
INSERT INTO `base_zip` VALUES ('2406', '451229', '', '', '大化瑶族自治县', '2395');
INSERT INTO `base_zip` VALUES ('2407', '451281', '', '', '宜州市', '2395');
INSERT INTO `base_zip` VALUES ('2408', '451300', '', '来宾市', '', '2285');
INSERT INTO `base_zip` VALUES ('2409', '451301', '', '', '市辖区', '2408');
INSERT INTO `base_zip` VALUES ('2410', '451302', '', '', '兴宾区', '2408');
INSERT INTO `base_zip` VALUES ('2411', '451321', '', '', '忻城县', '2408');
INSERT INTO `base_zip` VALUES ('2412', '451322', '', '', '象州县', '2408');
INSERT INTO `base_zip` VALUES ('2413', '451323', '', '', '武宣县', '2408');
INSERT INTO `base_zip` VALUES ('2414', '451324', '', '', '金秀瑶族自治县', '2408');
INSERT INTO `base_zip` VALUES ('2415', '451381', '', '', '合山市', '2408');
INSERT INTO `base_zip` VALUES ('2416', '451400', '', '崇左市', '', '2285');
INSERT INTO `base_zip` VALUES ('2417', '451401', '', '', '市辖区', '2416');
INSERT INTO `base_zip` VALUES ('2418', '451402', '', '', '江州区', '2416');
INSERT INTO `base_zip` VALUES ('2419', '451421', '', '', '扶绥县', '2416');
INSERT INTO `base_zip` VALUES ('2420', '451422', '', '', '宁明县', '2416');
INSERT INTO `base_zip` VALUES ('2421', '451423', '', '', '龙州县', '2416');
INSERT INTO `base_zip` VALUES ('2422', '451424', '', '', '大新县', '2416');
INSERT INTO `base_zip` VALUES ('2423', '451425', '', '', '天等县', '2416');
INSERT INTO `base_zip` VALUES ('2424', '451481', '', '', '凭祥市', '2416');
INSERT INTO `base_zip` VALUES ('2425', '460000', '海南省', '', '', '1');
INSERT INTO `base_zip` VALUES ('2426', '460100', '', '海口市', '', '2425');
INSERT INTO `base_zip` VALUES ('2427', '460101', '', '', '市辖区', '2426');
INSERT INTO `base_zip` VALUES ('2428', '460105', '', '', '秀英区', '2426');
INSERT INTO `base_zip` VALUES ('2429', '460106', '', '', '龙华区', '2426');
INSERT INTO `base_zip` VALUES ('2430', '460107', '', '', '琼山区', '2426');
INSERT INTO `base_zip` VALUES ('2431', '460108', '', '', '美兰区', '2426');
INSERT INTO `base_zip` VALUES ('2432', '460200', '', '三亚市', '', '2425');
INSERT INTO `base_zip` VALUES ('2433', '460201', '', '', '市辖区', '2432');
INSERT INTO `base_zip` VALUES ('2434', '460202', '', '', '海棠区', '2432');
INSERT INTO `base_zip` VALUES ('2435', '460203', '', '', '吉阳区', '2432');
INSERT INTO `base_zip` VALUES ('2436', '460204', '', '', '天涯区', '2432');
INSERT INTO `base_zip` VALUES ('2437', '460205', '', '', '崖州区', '2432');
INSERT INTO `base_zip` VALUES ('2438', '460300', '', '三沙市', '', '2425');
INSERT INTO `base_zip` VALUES ('2439', '460321', '', '', '西沙群岛', '2438');
INSERT INTO `base_zip` VALUES ('2440', '460322', '', '', '南沙群岛', '2438');
INSERT INTO `base_zip` VALUES ('2441', '460323', '', '', '中沙群岛的岛礁及其海域', '2438');
INSERT INTO `base_zip` VALUES ('2442', '469000', '', '省直辖县级行政区划', '', '2425');
INSERT INTO `base_zip` VALUES ('2443', '469001', '', '', '五指山市', '2442');
INSERT INTO `base_zip` VALUES ('2444', '469002', '', '', '琼海市', '2442');
INSERT INTO `base_zip` VALUES ('2445', '469003', '', '', '儋州市', '2442');
INSERT INTO `base_zip` VALUES ('2446', '469005', '', '', '文昌市', '2442');
INSERT INTO `base_zip` VALUES ('2447', '469006', '', '', '万宁市', '2442');
INSERT INTO `base_zip` VALUES ('2448', '469007', '', '', '东方市', '2442');
INSERT INTO `base_zip` VALUES ('2449', '469021', '', '', '定安县', '2442');
INSERT INTO `base_zip` VALUES ('2450', '469022', '', '', '屯昌县', '2442');
INSERT INTO `base_zip` VALUES ('2451', '469023', '', '', '澄迈县', '2442');
INSERT INTO `base_zip` VALUES ('2452', '469024', '', '', '临高县', '2442');
INSERT INTO `base_zip` VALUES ('2453', '469025', '', '', '白沙黎族自治县', '2442');
INSERT INTO `base_zip` VALUES ('2454', '469026', '', '', '昌江黎族自治县', '2442');
INSERT INTO `base_zip` VALUES ('2455', '469027', '', '', '乐东黎族自治县', '2442');
INSERT INTO `base_zip` VALUES ('2456', '469028', '', '', '陵水黎族自治县', '2442');
INSERT INTO `base_zip` VALUES ('2457', '469029', '', '', '保亭黎族苗族自治县', '2442');
INSERT INTO `base_zip` VALUES ('2458', '469030', '', '', '琼中黎族苗族自治县', '2442');
INSERT INTO `base_zip` VALUES ('2459', '500000', '重庆市', '重庆市', '', '1');
INSERT INTO `base_zip` VALUES ('2460', '500101', '', '', '万州区', '3928');
INSERT INTO `base_zip` VALUES ('2461', '500102', '', '', '涪陵区', '3928');
INSERT INTO `base_zip` VALUES ('2462', '500103', '', '', '渝中区', '3928');
INSERT INTO `base_zip` VALUES ('2463', '500104', '', '', '大渡口区', '3928');
INSERT INTO `base_zip` VALUES ('2464', '500105', '', '', '江北区', '3928');
INSERT INTO `base_zip` VALUES ('2465', '500106', '', '', '沙坪坝区', '3928');
INSERT INTO `base_zip` VALUES ('2466', '500107', '', '', '九龙坡区', '3928');
INSERT INTO `base_zip` VALUES ('2467', '500108', '', '', '南岸区', '3928');
INSERT INTO `base_zip` VALUES ('2468', '500109', '', '', '北碚区', '3928');
INSERT INTO `base_zip` VALUES ('2469', '500110', '', '', '綦江区', '3928');
INSERT INTO `base_zip` VALUES ('2470', '500111', '', '', '大足区', '3928');
INSERT INTO `base_zip` VALUES ('2471', '500112', '', '', '渝北区', '3928');
INSERT INTO `base_zip` VALUES ('2472', '500113', '', '', '巴南区', '3928');
INSERT INTO `base_zip` VALUES ('2473', '500114', '', '', '黔江区', '3928');
INSERT INTO `base_zip` VALUES ('2474', '500115', '', '', '长寿区', '3928');
INSERT INTO `base_zip` VALUES ('2475', '500116', '', '', '江津区', '3928');
INSERT INTO `base_zip` VALUES ('2476', '500117', '', '', '合川区', '3928');
INSERT INTO `base_zip` VALUES ('2477', '500118', '', '', '永川区', '3928');
INSERT INTO `base_zip` VALUES ('2478', '500119', '', '', '南川区', '3928');
INSERT INTO `base_zip` VALUES ('2479', '500120', '', '', '璧山区', '3928');
INSERT INTO `base_zip` VALUES ('2480', '500151', '', '', '铜梁区', '3928');
INSERT INTO `base_zip` VALUES ('2481', '500223', '', '', '潼南县', '3928');
INSERT INTO `base_zip` VALUES ('2482', '500226', '', '', '荣昌县', '3928');
INSERT INTO `base_zip` VALUES ('2483', '500228', '', '', '梁平县', '3928');
INSERT INTO `base_zip` VALUES ('2484', '500229', '', '', '城口县', '3928');
INSERT INTO `base_zip` VALUES ('2485', '500230', '', '', '丰都县', '3928');
INSERT INTO `base_zip` VALUES ('2486', '500231', '', '', '垫江县', '3928');
INSERT INTO `base_zip` VALUES ('2487', '500232', '', '', '武隆县', '3928');
INSERT INTO `base_zip` VALUES ('2488', '500233', '', '', '忠县', '3928');
INSERT INTO `base_zip` VALUES ('2489', '500234', '', '', '开县', '3928');
INSERT INTO `base_zip` VALUES ('2490', '500235', '', '', '云阳县', '3928');
INSERT INTO `base_zip` VALUES ('2491', '500236', '', '', '奉节县', '3928');
INSERT INTO `base_zip` VALUES ('2492', '500237', '', '', '巫山县', '3928');
INSERT INTO `base_zip` VALUES ('2493', '500238', '', '', '巫溪县', '3928');
INSERT INTO `base_zip` VALUES ('2494', '500240', '', '', '石柱土家族自治县', '3928');
INSERT INTO `base_zip` VALUES ('2495', '500241', '', '', '秀山土家族苗族自治县', '3928');
INSERT INTO `base_zip` VALUES ('2496', '500242', '', '', '酉阳土家族苗族自治县', '3928');
INSERT INTO `base_zip` VALUES ('2497', '500243', '', '', '彭水苗族土家族自治县', '2459');
INSERT INTO `base_zip` VALUES ('2498', '510000', '四川省', '', '', '1');
INSERT INTO `base_zip` VALUES ('2499', '510100', '', '成都市', '', '2498');
INSERT INTO `base_zip` VALUES ('2500', '510101', '', '', '市辖区', '2499');
INSERT INTO `base_zip` VALUES ('2501', '510104', '', '', '锦江区', '2499');
INSERT INTO `base_zip` VALUES ('2502', '510105', '', '', '青羊区', '2499');
INSERT INTO `base_zip` VALUES ('2503', '510106', '', '', '金牛区', '2499');
INSERT INTO `base_zip` VALUES ('2504', '510107', '', '', '武侯区', '2499');
INSERT INTO `base_zip` VALUES ('2505', '510108', '', '', '成华区', '2499');
INSERT INTO `base_zip` VALUES ('2506', '510112', '', '', '龙泉驿区', '2499');
INSERT INTO `base_zip` VALUES ('2507', '510113', '', '', '青白江区', '2499');
INSERT INTO `base_zip` VALUES ('2508', '510114', '', '', '新都区', '2499');
INSERT INTO `base_zip` VALUES ('2509', '510115', '', '', '温江区', '2499');
INSERT INTO `base_zip` VALUES ('2510', '510121', '', '', '金堂县', '2499');
INSERT INTO `base_zip` VALUES ('2511', '510122', '', '', '双流县', '2499');
INSERT INTO `base_zip` VALUES ('2512', '510124', '', '', '郫县', '2499');
INSERT INTO `base_zip` VALUES ('2513', '510129', '', '', '大邑县', '2499');
INSERT INTO `base_zip` VALUES ('2514', '510131', '', '', '蒲江县', '2499');
INSERT INTO `base_zip` VALUES ('2515', '510132', '', '', '新津县', '2499');
INSERT INTO `base_zip` VALUES ('2516', '510181', '', '', '都江堰市', '2499');
INSERT INTO `base_zip` VALUES ('2517', '510182', '', '', '彭州市', '2499');
INSERT INTO `base_zip` VALUES ('2518', '510183', '', '', '邛崃市', '2499');
INSERT INTO `base_zip` VALUES ('2519', '510184', '', '', '崇州市', '2499');
INSERT INTO `base_zip` VALUES ('2520', '510300', '', '自贡市', '', '2498');
INSERT INTO `base_zip` VALUES ('2521', '510301', '', '', '市辖区', '2520');
INSERT INTO `base_zip` VALUES ('2522', '510302', '', '', '自流井区', '2520');
INSERT INTO `base_zip` VALUES ('2523', '510303', '', '', '贡井区', '2520');
INSERT INTO `base_zip` VALUES ('2524', '510304', '', '', '大安区', '2520');
INSERT INTO `base_zip` VALUES ('2525', '510311', '', '', '沿滩区', '2520');
INSERT INTO `base_zip` VALUES ('2526', '510321', '', '', '荣县', '2520');
INSERT INTO `base_zip` VALUES ('2527', '510322', '', '', '富顺县', '2520');
INSERT INTO `base_zip` VALUES ('2528', '510400', '', '攀枝花市', '', '2498');
INSERT INTO `base_zip` VALUES ('2529', '510401', '', '', '市辖区', '2528');
INSERT INTO `base_zip` VALUES ('2530', '510402', '', '', '东区', '2528');
INSERT INTO `base_zip` VALUES ('2531', '510403', '', '', '西区', '2528');
INSERT INTO `base_zip` VALUES ('2532', '510411', '', '', '仁和区', '2528');
INSERT INTO `base_zip` VALUES ('2533', '510421', '', '', '米易县', '2528');
INSERT INTO `base_zip` VALUES ('2534', '510422', '', '', '盐边县', '2528');
INSERT INTO `base_zip` VALUES ('2535', '510500', '', '泸州市', '', '2498');
INSERT INTO `base_zip` VALUES ('2536', '510501', '', '', '市辖区', '2535');
INSERT INTO `base_zip` VALUES ('2537', '510502', '', '', '江阳区', '2535');
INSERT INTO `base_zip` VALUES ('2538', '510503', '', '', '纳溪区', '2535');
INSERT INTO `base_zip` VALUES ('2539', '510504', '', '', '龙马潭区', '2535');
INSERT INTO `base_zip` VALUES ('2540', '510521', '', '', '泸县', '2535');
INSERT INTO `base_zip` VALUES ('2541', '510522', '', '', '合江县', '2535');
INSERT INTO `base_zip` VALUES ('2542', '510524', '', '', '叙永县', '2535');
INSERT INTO `base_zip` VALUES ('2543', '510525', '', '', '古蔺县', '2535');
INSERT INTO `base_zip` VALUES ('2544', '510600', '', '德阳市', '', '2498');
INSERT INTO `base_zip` VALUES ('2545', '510601', '', '', '市辖区', '2544');
INSERT INTO `base_zip` VALUES ('2546', '510603', '', '', '旌阳区', '2544');
INSERT INTO `base_zip` VALUES ('2547', '510623', '', '', '中江县', '2544');
INSERT INTO `base_zip` VALUES ('2548', '510626', '', '', '罗江县', '2544');
INSERT INTO `base_zip` VALUES ('2549', '510681', '', '', '广汉市', '2544');
INSERT INTO `base_zip` VALUES ('2550', '510682', '', '', '什邡市', '2544');
INSERT INTO `base_zip` VALUES ('2551', '510683', '', '', '绵竹市', '2544');
INSERT INTO `base_zip` VALUES ('2552', '510700', '', '绵阳市', '', '2498');
INSERT INTO `base_zip` VALUES ('2553', '510701', '', '', '市辖区', '2552');
INSERT INTO `base_zip` VALUES ('2554', '510703', '', '', '涪城区', '2552');
INSERT INTO `base_zip` VALUES ('2555', '510704', '', '', '游仙区', '2552');
INSERT INTO `base_zip` VALUES ('2556', '510722', '', '', '三台县', '2552');
INSERT INTO `base_zip` VALUES ('2557', '510723', '', '', '盐亭县', '2552');
INSERT INTO `base_zip` VALUES ('2558', '510724', '', '', '安县', '2552');
INSERT INTO `base_zip` VALUES ('2559', '510725', '', '', '梓潼县', '2552');
INSERT INTO `base_zip` VALUES ('2560', '510726', '', '', '北川羌族自治县', '2552');
INSERT INTO `base_zip` VALUES ('2561', '510727', '', '', '平武县', '2552');
INSERT INTO `base_zip` VALUES ('2562', '510781', '', '', '江油市', '2552');
INSERT INTO `base_zip` VALUES ('2563', '510800', '', '广元市', '', '2498');
INSERT INTO `base_zip` VALUES ('2564', '510801', '', '', '市辖区', '2563');
INSERT INTO `base_zip` VALUES ('2565', '510802', '', '', '利州区', '2563');
INSERT INTO `base_zip` VALUES ('2566', '510811', '', '', '昭化区', '2563');
INSERT INTO `base_zip` VALUES ('2567', '510812', '', '', '朝天区', '2563');
INSERT INTO `base_zip` VALUES ('2568', '510821', '', '', '旺苍县', '2563');
INSERT INTO `base_zip` VALUES ('2569', '510822', '', '', '青川县', '2563');
INSERT INTO `base_zip` VALUES ('2570', '510823', '', '', '剑阁县', '2563');
INSERT INTO `base_zip` VALUES ('2571', '510824', '', '', '苍溪县', '2563');
INSERT INTO `base_zip` VALUES ('2572', '510900', '', '遂宁市', '', '2498');
INSERT INTO `base_zip` VALUES ('2573', '510901', '', '', '市辖区', '2572');
INSERT INTO `base_zip` VALUES ('2574', '510903', '', '', '船山区', '2572');
INSERT INTO `base_zip` VALUES ('2575', '510904', '', '', '安居区', '2572');
INSERT INTO `base_zip` VALUES ('2576', '510921', '', '', '蓬溪县', '2572');
INSERT INTO `base_zip` VALUES ('2577', '510922', '', '', '射洪县', '2572');
INSERT INTO `base_zip` VALUES ('2578', '510923', '', '', '大英县', '2572');
INSERT INTO `base_zip` VALUES ('2579', '511000', '', '内江市', '', '2498');
INSERT INTO `base_zip` VALUES ('2580', '511001', '', '', '市辖区', '2579');
INSERT INTO `base_zip` VALUES ('2581', '511002', '', '', '市中区', '2579');
INSERT INTO `base_zip` VALUES ('2582', '511011', '', '', '东兴区', '2579');
INSERT INTO `base_zip` VALUES ('2583', '511024', '', '', '威远县', '2579');
INSERT INTO `base_zip` VALUES ('2584', '511025', '', '', '资中县', '2579');
INSERT INTO `base_zip` VALUES ('2585', '511028', '', '', '隆昌县', '2579');
INSERT INTO `base_zip` VALUES ('2586', '511100', '', '乐山市', '', '2498');
INSERT INTO `base_zip` VALUES ('2587', '511101', '', '', '市辖区', '2586');
INSERT INTO `base_zip` VALUES ('2588', '511102', '', '', '市中区', '2586');
INSERT INTO `base_zip` VALUES ('2589', '511111', '', '', '沙湾区', '2586');
INSERT INTO `base_zip` VALUES ('2590', '511112', '', '', '五通桥区', '2586');
INSERT INTO `base_zip` VALUES ('2591', '511113', '', '', '金口河区', '2586');
INSERT INTO `base_zip` VALUES ('2592', '511123', '', '', '犍为县', '2586');
INSERT INTO `base_zip` VALUES ('2593', '511124', '', '', '井研县', '2586');
INSERT INTO `base_zip` VALUES ('2594', '511126', '', '', '夹江县', '2586');
INSERT INTO `base_zip` VALUES ('2595', '511129', '', '', '沐川县', '2586');
INSERT INTO `base_zip` VALUES ('2596', '511132', '', '', '峨边彝族自治县', '2586');
INSERT INTO `base_zip` VALUES ('2597', '511133', '', '', '马边彝族自治县', '2586');
INSERT INTO `base_zip` VALUES ('2598', '511181', '', '', '峨眉山市', '2586');
INSERT INTO `base_zip` VALUES ('2599', '511300', '', '南充市', '', '2498');
INSERT INTO `base_zip` VALUES ('2600', '511301', '', '', '市辖区', '2599');
INSERT INTO `base_zip` VALUES ('2601', '511302', '', '', '顺庆区', '2599');
INSERT INTO `base_zip` VALUES ('2602', '511303', '', '', '高坪区', '2599');
INSERT INTO `base_zip` VALUES ('2603', '511304', '', '', '嘉陵区', '2599');
INSERT INTO `base_zip` VALUES ('2604', '511321', '', '', '南部县', '2599');
INSERT INTO `base_zip` VALUES ('2605', '511322', '', '', '营山县', '2599');
INSERT INTO `base_zip` VALUES ('2606', '511323', '', '', '蓬安县', '2599');
INSERT INTO `base_zip` VALUES ('2607', '511324', '', '', '仪陇县', '2599');
INSERT INTO `base_zip` VALUES ('2608', '511325', '', '', '西充县', '2599');
INSERT INTO `base_zip` VALUES ('2609', '511381', '', '', '阆中市', '2599');
INSERT INTO `base_zip` VALUES ('2610', '511400', '', '眉山市', '', '2498');
INSERT INTO `base_zip` VALUES ('2611', '511401', '', '', '市辖区', '2610');
INSERT INTO `base_zip` VALUES ('2612', '511402', '', '', '东坡区', '2610');
INSERT INTO `base_zip` VALUES ('2613', '511403', '', '', '彭山区', '2610');
INSERT INTO `base_zip` VALUES ('2614', '511421', '', '', '仁寿县', '2610');
INSERT INTO `base_zip` VALUES ('2615', '511423', '', '', '洪雅县', '2610');
INSERT INTO `base_zip` VALUES ('2616', '511424', '', '', '丹棱县', '2610');
INSERT INTO `base_zip` VALUES ('2617', '511425', '', '', '青神县', '2610');
INSERT INTO `base_zip` VALUES ('2618', '511500', '', '宜宾市', '', '2498');
INSERT INTO `base_zip` VALUES ('2619', '511501', '', '', '市辖区', '2618');
INSERT INTO `base_zip` VALUES ('2620', '511502', '', '', '翠屏区', '2618');
INSERT INTO `base_zip` VALUES ('2621', '511503', '', '', '南溪区', '2618');
INSERT INTO `base_zip` VALUES ('2622', '511521', '', '', '宜宾县', '2618');
INSERT INTO `base_zip` VALUES ('2623', '511523', '', '', '江安县', '2618');
INSERT INTO `base_zip` VALUES ('2624', '511524', '', '', '长宁县', '2618');
INSERT INTO `base_zip` VALUES ('2625', '511525', '', '', '高县', '2618');
INSERT INTO `base_zip` VALUES ('2626', '511526', '', '', '珙县', '2618');
INSERT INTO `base_zip` VALUES ('2627', '511527', '', '', '筠连县', '2618');
INSERT INTO `base_zip` VALUES ('2628', '511528', '', '', '兴文县', '2618');
INSERT INTO `base_zip` VALUES ('2629', '511529', '', '', '屏山县', '2618');
INSERT INTO `base_zip` VALUES ('2630', '511600', '', '广安市', '', '2498');
INSERT INTO `base_zip` VALUES ('2631', '511601', '', '', '市辖区', '2630');
INSERT INTO `base_zip` VALUES ('2632', '511602', '', '', '广安区', '2630');
INSERT INTO `base_zip` VALUES ('2633', '511603', '', '', '前锋区', '2630');
INSERT INTO `base_zip` VALUES ('2634', '511621', '', '', '岳池县', '2630');
INSERT INTO `base_zip` VALUES ('2635', '511622', '', '', '武胜县', '2630');
INSERT INTO `base_zip` VALUES ('2636', '511623', '', '', '邻水县', '2630');
INSERT INTO `base_zip` VALUES ('2637', '511681', '', '', '华蓥市', '2630');
INSERT INTO `base_zip` VALUES ('2638', '511700', '', '达州市', '', '2498');
INSERT INTO `base_zip` VALUES ('2639', '511701', '', '', '市辖区', '2638');
INSERT INTO `base_zip` VALUES ('2640', '511702', '', '', '通川区', '2638');
INSERT INTO `base_zip` VALUES ('2641', '511703', '', '', '达川区', '2638');
INSERT INTO `base_zip` VALUES ('2642', '511722', '', '', '宣汉县', '2638');
INSERT INTO `base_zip` VALUES ('2643', '511723', '', '', '开江县', '2638');
INSERT INTO `base_zip` VALUES ('2644', '511724', '', '', '大竹县', '2638');
INSERT INTO `base_zip` VALUES ('2645', '511725', '', '', '渠县', '2638');
INSERT INTO `base_zip` VALUES ('2646', '511781', '', '', '万源市', '2638');
INSERT INTO `base_zip` VALUES ('2647', '511800', '', '雅安市', '', '2498');
INSERT INTO `base_zip` VALUES ('2648', '511801', '', '', '市辖区', '2647');
INSERT INTO `base_zip` VALUES ('2649', '511802', '', '', '雨城区', '2647');
INSERT INTO `base_zip` VALUES ('2650', '511803', '', '', '名山区', '2647');
INSERT INTO `base_zip` VALUES ('2651', '511822', '', '', '荥经县', '2647');
INSERT INTO `base_zip` VALUES ('2652', '511823', '', '', '汉源县', '2647');
INSERT INTO `base_zip` VALUES ('2653', '511824', '', '', '石棉县', '2647');
INSERT INTO `base_zip` VALUES ('2654', '511825', '', '', '天全县', '2647');
INSERT INTO `base_zip` VALUES ('2655', '511826', '', '', '芦山县', '2647');
INSERT INTO `base_zip` VALUES ('2656', '511827', '', '', '宝兴县', '2647');
INSERT INTO `base_zip` VALUES ('2657', '511900', '', '巴中市', '', '2498');
INSERT INTO `base_zip` VALUES ('2658', '511901', '', '', '市辖区', '2657');
INSERT INTO `base_zip` VALUES ('2659', '511902', '', '', '巴州区', '2657');
INSERT INTO `base_zip` VALUES ('2660', '511903', '', '', '恩阳区', '2657');
INSERT INTO `base_zip` VALUES ('2661', '511921', '', '', '通江县', '2657');
INSERT INTO `base_zip` VALUES ('2662', '511922', '', '', '南江县', '2657');
INSERT INTO `base_zip` VALUES ('2663', '511923', '', '', '平昌县', '2657');
INSERT INTO `base_zip` VALUES ('2664', '512000', '', '资阳市', '', '2498');
INSERT INTO `base_zip` VALUES ('2665', '512001', '', '', '市辖区', '2664');
INSERT INTO `base_zip` VALUES ('2666', '512002', '', '', '雁江区', '2664');
INSERT INTO `base_zip` VALUES ('2667', '512021', '', '', '安岳县', '2664');
INSERT INTO `base_zip` VALUES ('2668', '512022', '', '', '乐至县', '2664');
INSERT INTO `base_zip` VALUES ('2669', '512081', '', '', '简阳市', '2664');
INSERT INTO `base_zip` VALUES ('2670', '513200', '', '阿坝藏族羌族自治州', '', '2498');
INSERT INTO `base_zip` VALUES ('2671', '513221', '', '', '汶川县', '2670');
INSERT INTO `base_zip` VALUES ('2672', '513222', '', '', '理县', '2670');
INSERT INTO `base_zip` VALUES ('2673', '513223', '', '', '茂县', '2670');
INSERT INTO `base_zip` VALUES ('2674', '513224', '', '', '松潘县', '2670');
INSERT INTO `base_zip` VALUES ('2675', '513225', '', '', '九寨沟县', '2670');
INSERT INTO `base_zip` VALUES ('2676', '513226', '', '', '金川县', '2670');
INSERT INTO `base_zip` VALUES ('2677', '513227', '', '', '小金县', '2670');
INSERT INTO `base_zip` VALUES ('2678', '513228', '', '', '黑水县', '2670');
INSERT INTO `base_zip` VALUES ('2679', '513229', '', '', '马尔康县', '2670');
INSERT INTO `base_zip` VALUES ('2680', '513230', '', '', '壤塘县', '2670');
INSERT INTO `base_zip` VALUES ('2681', '513231', '', '', '阿坝县', '2670');
INSERT INTO `base_zip` VALUES ('2682', '513232', '', '', '若尔盖县', '2670');
INSERT INTO `base_zip` VALUES ('2683', '513233', '', '', '红原县', '2670');
INSERT INTO `base_zip` VALUES ('2684', '513300', '', '甘孜藏族自治州', '', '2498');
INSERT INTO `base_zip` VALUES ('2685', '513321', '', '', '康定县', '2684');
INSERT INTO `base_zip` VALUES ('2686', '513322', '', '', '泸定县', '2684');
INSERT INTO `base_zip` VALUES ('2687', '513323', '', '', '丹巴县', '2684');
INSERT INTO `base_zip` VALUES ('2688', '513324', '', '', '九龙县', '2684');
INSERT INTO `base_zip` VALUES ('2689', '513325', '', '', '雅江县', '2684');
INSERT INTO `base_zip` VALUES ('2690', '513326', '', '', '道孚县', '2684');
INSERT INTO `base_zip` VALUES ('2691', '513327', '', '', '炉霍县', '2684');
INSERT INTO `base_zip` VALUES ('2692', '513328', '', '', '甘孜县', '2684');
INSERT INTO `base_zip` VALUES ('2693', '513329', '', '', '新龙县', '2684');
INSERT INTO `base_zip` VALUES ('2694', '513330', '', '', '德格县', '2684');
INSERT INTO `base_zip` VALUES ('2695', '513331', '', '', '白玉县', '2684');
INSERT INTO `base_zip` VALUES ('2696', '513332', '', '', '石渠县', '2684');
INSERT INTO `base_zip` VALUES ('2697', '513333', '', '', '色达县', '2684');
INSERT INTO `base_zip` VALUES ('2698', '513334', '', '', '理塘县', '2684');
INSERT INTO `base_zip` VALUES ('2699', '513335', '', '', '巴塘县', '2684');
INSERT INTO `base_zip` VALUES ('2700', '513336', '', '', '乡城县', '2684');
INSERT INTO `base_zip` VALUES ('2701', '513337', '', '', '稻城县', '2684');
INSERT INTO `base_zip` VALUES ('2702', '513338', '', '', '得荣县', '2684');
INSERT INTO `base_zip` VALUES ('2703', '513400', '', '凉山彝族自治州', '', '2498');
INSERT INTO `base_zip` VALUES ('2704', '513401', '', '', '西昌市', '2703');
INSERT INTO `base_zip` VALUES ('2705', '513422', '', '', '木里藏族自治县', '2703');
INSERT INTO `base_zip` VALUES ('2706', '513423', '', '', '盐源县', '2703');
INSERT INTO `base_zip` VALUES ('2707', '513424', '', '', '德昌县', '2703');
INSERT INTO `base_zip` VALUES ('2708', '513425', '', '', '会理县', '2703');
INSERT INTO `base_zip` VALUES ('2709', '513426', '', '', '会东县', '2703');
INSERT INTO `base_zip` VALUES ('2710', '513427', '', '', '宁南县', '2703');
INSERT INTO `base_zip` VALUES ('2711', '513428', '', '', '普格县', '2703');
INSERT INTO `base_zip` VALUES ('2712', '513429', '', '', '布拖县', '2703');
INSERT INTO `base_zip` VALUES ('2713', '513430', '', '', '金阳县', '2703');
INSERT INTO `base_zip` VALUES ('2714', '513431', '', '', '昭觉县', '2703');
INSERT INTO `base_zip` VALUES ('2715', '513432', '', '', '喜德县', '2703');
INSERT INTO `base_zip` VALUES ('2716', '513433', '', '', '冕宁县', '2703');
INSERT INTO `base_zip` VALUES ('2717', '513434', '', '', '越西县', '2703');
INSERT INTO `base_zip` VALUES ('2718', '513435', '', '', '甘洛县', '2703');
INSERT INTO `base_zip` VALUES ('2719', '513436', '', '', '美姑县', '2703');
INSERT INTO `base_zip` VALUES ('2720', '513437', '', '', '雷波县', '2703');
INSERT INTO `base_zip` VALUES ('2721', '520000', '贵州省', '', '', '1');
INSERT INTO `base_zip` VALUES ('2722', '520100', '', '贵阳市', '', '2721');
INSERT INTO `base_zip` VALUES ('2723', '520101', '', '', '市辖区', '2722');
INSERT INTO `base_zip` VALUES ('2724', '520102', '', '', '南明区', '2722');
INSERT INTO `base_zip` VALUES ('2725', '520103', '', '', '云岩区', '2722');
INSERT INTO `base_zip` VALUES ('2726', '520111', '', '', '花溪区', '2722');
INSERT INTO `base_zip` VALUES ('2727', '520112', '', '', '乌当区', '2722');
INSERT INTO `base_zip` VALUES ('2728', '520113', '', '', '白云区', '2722');
INSERT INTO `base_zip` VALUES ('2729', '520115', '', '', '观山湖区', '2722');
INSERT INTO `base_zip` VALUES ('2730', '520121', '', '', '开阳县', '2722');
INSERT INTO `base_zip` VALUES ('2731', '520122', '', '', '息烽县', '2722');
INSERT INTO `base_zip` VALUES ('2732', '520123', '', '', '修文县', '2722');
INSERT INTO `base_zip` VALUES ('2733', '520181', '', '', '清镇市', '2722');
INSERT INTO `base_zip` VALUES ('2734', '520200', '', '六盘水市', '', '2721');
INSERT INTO `base_zip` VALUES ('2735', '520201', '', '', '钟山区', '2734');
INSERT INTO `base_zip` VALUES ('2736', '520203', '', '', '六枝特区', '2734');
INSERT INTO `base_zip` VALUES ('2737', '520221', '', '', '水城县', '2734');
INSERT INTO `base_zip` VALUES ('2738', '520222', '', '', '盘县', '2734');
INSERT INTO `base_zip` VALUES ('2739', '520300', '', '遵义市', '', '2721');
INSERT INTO `base_zip` VALUES ('2740', '520301', '', '', '市辖区', '2739');
INSERT INTO `base_zip` VALUES ('2741', '520302', '', '', '红花岗区', '2739');
INSERT INTO `base_zip` VALUES ('2742', '520303', '', '', '汇川区', '2739');
INSERT INTO `base_zip` VALUES ('2743', '520321', '', '', '遵义县', '2739');
INSERT INTO `base_zip` VALUES ('2744', '520322', '', '', '桐梓县', '2739');
INSERT INTO `base_zip` VALUES ('2745', '520323', '', '', '绥阳县', '2739');
INSERT INTO `base_zip` VALUES ('2746', '520324', '', '', '正安县', '2739');
INSERT INTO `base_zip` VALUES ('2747', '520325', '', '', '道真仡佬族苗族自治县', '2739');
INSERT INTO `base_zip` VALUES ('2748', '520326', '', '', '务川仡佬族苗族自治县', '2739');
INSERT INTO `base_zip` VALUES ('2749', '520327', '', '', '凤冈县', '2739');
INSERT INTO `base_zip` VALUES ('2750', '520328', '', '', '湄潭县', '2739');
INSERT INTO `base_zip` VALUES ('2751', '520329', '', '', '余庆县', '2739');
INSERT INTO `base_zip` VALUES ('2752', '520330', '', '', '习水县', '2739');
INSERT INTO `base_zip` VALUES ('2753', '520381', '', '', '赤水市', '2739');
INSERT INTO `base_zip` VALUES ('2754', '520382', '', '', '仁怀市', '2739');
INSERT INTO `base_zip` VALUES ('2755', '520400', '', '安顺市', '', '2721');
INSERT INTO `base_zip` VALUES ('2756', '520401', '', '', '市辖区', '2755');
INSERT INTO `base_zip` VALUES ('2757', '520402', '', '', '西秀区', '2755');
INSERT INTO `base_zip` VALUES ('2758', '520403', '', '', '平坝区', '2755');
INSERT INTO `base_zip` VALUES ('2759', '520422', '', '', '普定县', '2755');
INSERT INTO `base_zip` VALUES ('2760', '520423', '', '', '镇宁布依族苗族自治县', '2755');
INSERT INTO `base_zip` VALUES ('2761', '520424', '', '', '关岭布依族苗族自治县', '2755');
INSERT INTO `base_zip` VALUES ('2762', '520425', '', '', '紫云苗族布依族自治县', '2755');
INSERT INTO `base_zip` VALUES ('2763', '520500', '', '毕节市', '', '2721');
INSERT INTO `base_zip` VALUES ('2764', '520501', '', '', '市辖区', '2763');
INSERT INTO `base_zip` VALUES ('2765', '520502', '', '', '七星关区', '2763');
INSERT INTO `base_zip` VALUES ('2766', '520521', '', '', '大方县', '2763');
INSERT INTO `base_zip` VALUES ('2767', '520522', '', '', '黔西县', '2763');
INSERT INTO `base_zip` VALUES ('2768', '520523', '', '', '金沙县', '2763');
INSERT INTO `base_zip` VALUES ('2769', '520524', '', '', '织金县', '2763');
INSERT INTO `base_zip` VALUES ('2770', '520525', '', '', '纳雍县', '2763');
INSERT INTO `base_zip` VALUES ('2771', '520526', '', '', '威宁彝族回族苗族自治县', '2763');
INSERT INTO `base_zip` VALUES ('2772', '520527', '', '', '赫章县', '2763');
INSERT INTO `base_zip` VALUES ('2773', '520600', '', '铜仁市', '', '2721');
INSERT INTO `base_zip` VALUES ('2774', '520601', '', '', '市辖区', '2773');
INSERT INTO `base_zip` VALUES ('2775', '520602', '', '', '碧江区', '2773');
INSERT INTO `base_zip` VALUES ('2776', '520603', '', '', '万山区', '2773');
INSERT INTO `base_zip` VALUES ('2777', '520621', '', '', '江口县', '2773');
INSERT INTO `base_zip` VALUES ('2778', '520622', '', '', '玉屏侗族自治县', '2773');
INSERT INTO `base_zip` VALUES ('2779', '520623', '', '', '石阡县', '2773');
INSERT INTO `base_zip` VALUES ('2780', '520624', '', '', '思南县', '2773');
INSERT INTO `base_zip` VALUES ('2781', '520625', '', '', '印江土家族苗族自治县', '2773');
INSERT INTO `base_zip` VALUES ('2782', '520626', '', '', '德江县', '2773');
INSERT INTO `base_zip` VALUES ('2783', '520627', '', '', '沿河土家族自治县', '2773');
INSERT INTO `base_zip` VALUES ('2784', '520628', '', '', '松桃苗族自治县', '2773');
INSERT INTO `base_zip` VALUES ('2785', '522300', '', '黔西南布依族苗族自治州', '', '2721');
INSERT INTO `base_zip` VALUES ('2786', '522301', '', '', '兴义市', '2785');
INSERT INTO `base_zip` VALUES ('2787', '522322', '', '', '兴仁县', '2785');
INSERT INTO `base_zip` VALUES ('2788', '522323', '', '', '普安县', '2785');
INSERT INTO `base_zip` VALUES ('2789', '522324', '', '', '晴隆县', '2785');
INSERT INTO `base_zip` VALUES ('2790', '522325', '', '', '贞丰县', '2785');
INSERT INTO `base_zip` VALUES ('2791', '522326', '', '', '望谟县', '2785');
INSERT INTO `base_zip` VALUES ('2792', '522327', '', '', '册亨县', '2785');
INSERT INTO `base_zip` VALUES ('2793', '522328', '', '', '安龙县', '2785');
INSERT INTO `base_zip` VALUES ('2794', '522600', '', '黔东南苗族侗族自治州', '', '2721');
INSERT INTO `base_zip` VALUES ('2795', '522601', '', '', '凯里市', '2794');
INSERT INTO `base_zip` VALUES ('2796', '522622', '', '', '黄平县', '2794');
INSERT INTO `base_zip` VALUES ('2797', '522623', '', '', '施秉县', '2794');
INSERT INTO `base_zip` VALUES ('2798', '522624', '', '', '三穗县', '2794');
INSERT INTO `base_zip` VALUES ('2799', '522625', '', '', '镇远县', '2794');
INSERT INTO `base_zip` VALUES ('2800', '522626', '', '', '岑巩县', '2794');
INSERT INTO `base_zip` VALUES ('2801', '522627', '', '', '天柱县', '2794');
INSERT INTO `base_zip` VALUES ('2802', '522628', '', '', '锦屏县', '2794');
INSERT INTO `base_zip` VALUES ('2803', '522629', '', '', '剑河县', '2794');
INSERT INTO `base_zip` VALUES ('2804', '522630', '', '', '台江县', '2794');
INSERT INTO `base_zip` VALUES ('2805', '522631', '', '', '黎平县', '2794');
INSERT INTO `base_zip` VALUES ('2806', '522632', '', '', '榕江县', '2794');
INSERT INTO `base_zip` VALUES ('2807', '522633', '', '', '从江县', '2794');
INSERT INTO `base_zip` VALUES ('2808', '522634', '', '', '雷山县', '2794');
INSERT INTO `base_zip` VALUES ('2809', '522635', '', '', '麻江县', '2794');
INSERT INTO `base_zip` VALUES ('2810', '522636', '', '', '丹寨县', '2794');
INSERT INTO `base_zip` VALUES ('2811', '522700', '', '黔南布依族苗族自治州', '', '2721');
INSERT INTO `base_zip` VALUES ('2812', '522701', '', '', '都匀市', '2811');
INSERT INTO `base_zip` VALUES ('2813', '522702', '', '', '福泉市', '2811');
INSERT INTO `base_zip` VALUES ('2814', '522722', '', '', '荔波县', '2811');
INSERT INTO `base_zip` VALUES ('2815', '522723', '', '', '贵定县', '2811');
INSERT INTO `base_zip` VALUES ('2816', '522725', '', '', '瓮安县', '2811');
INSERT INTO `base_zip` VALUES ('2817', '522726', '', '', '独山县', '2811');
INSERT INTO `base_zip` VALUES ('2818', '522727', '', '', '平塘县', '2811');
INSERT INTO `base_zip` VALUES ('2819', '522728', '', '', '罗甸县', '2811');
INSERT INTO `base_zip` VALUES ('2820', '522729', '', '', '长顺县', '2811');
INSERT INTO `base_zip` VALUES ('2821', '522730', '', '', '龙里县', '2811');
INSERT INTO `base_zip` VALUES ('2822', '522731', '', '', '惠水县', '2811');
INSERT INTO `base_zip` VALUES ('2823', '522732', '', '', '三都水族自治县', '2811');
INSERT INTO `base_zip` VALUES ('2824', '530000', '云南省', '', '', '1');
INSERT INTO `base_zip` VALUES ('2825', '530100', '', '昆明市', '', '2824');
INSERT INTO `base_zip` VALUES ('2826', '530101', '', '', '市辖区', '2825');
INSERT INTO `base_zip` VALUES ('2827', '530102', '', '', '五华区', '2825');
INSERT INTO `base_zip` VALUES ('2828', '530103', '', '', '盘龙区', '2825');
INSERT INTO `base_zip` VALUES ('2829', '530111', '', '', '官渡区', '2825');
INSERT INTO `base_zip` VALUES ('2830', '530112', '', '', '西山区', '2825');
INSERT INTO `base_zip` VALUES ('2831', '530113', '', '', '东川区', '2825');
INSERT INTO `base_zip` VALUES ('2832', '530114', '', '', '呈贡区', '2825');
INSERT INTO `base_zip` VALUES ('2833', '530122', '', '', '晋宁县', '2825');
INSERT INTO `base_zip` VALUES ('2834', '530124', '', '', '富民县', '2825');
INSERT INTO `base_zip` VALUES ('2835', '530125', '', '', '宜良县', '2825');
INSERT INTO `base_zip` VALUES ('2836', '530126', '', '', '石林彝族自治县', '2825');
INSERT INTO `base_zip` VALUES ('2837', '530127', '', '', '嵩明县', '2825');
INSERT INTO `base_zip` VALUES ('2838', '530128', '', '', '禄劝彝族苗族自治县', '2825');
INSERT INTO `base_zip` VALUES ('2839', '530129', '', '', '寻甸回族彝族自治县', '2825');
INSERT INTO `base_zip` VALUES ('2840', '530181', '', '', '安宁市', '2825');
INSERT INTO `base_zip` VALUES ('2841', '530300', '', '曲靖市', '', '2824');
INSERT INTO `base_zip` VALUES ('2842', '530301', '', '', '市辖区', '2841');
INSERT INTO `base_zip` VALUES ('2843', '530302', '', '', '麒麟区', '2841');
INSERT INTO `base_zip` VALUES ('2844', '530321', '', '', '马龙县', '2841');
INSERT INTO `base_zip` VALUES ('2845', '530322', '', '', '陆良县', '2841');
INSERT INTO `base_zip` VALUES ('2846', '530323', '', '', '师宗县', '2841');
INSERT INTO `base_zip` VALUES ('2847', '530324', '', '', '罗平县', '2841');
INSERT INTO `base_zip` VALUES ('2848', '530325', '', '', '富源县', '2841');
INSERT INTO `base_zip` VALUES ('2849', '530326', '', '', '会泽县', '2841');
INSERT INTO `base_zip` VALUES ('2850', '530328', '', '', '沾益县', '2841');
INSERT INTO `base_zip` VALUES ('2851', '530381', '', '', '宣威市', '2841');
INSERT INTO `base_zip` VALUES ('2852', '530400', '', '玉溪市', '', '2824');
INSERT INTO `base_zip` VALUES ('2853', '530401', '', '', '市辖区', '2852');
INSERT INTO `base_zip` VALUES ('2854', '530402', '', '', '红塔区', '2852');
INSERT INTO `base_zip` VALUES ('2855', '530421', '', '', '江川县', '2852');
INSERT INTO `base_zip` VALUES ('2856', '530422', '', '', '澄江县', '2852');
INSERT INTO `base_zip` VALUES ('2857', '530423', '', '', '通海县', '2852');
INSERT INTO `base_zip` VALUES ('2858', '530424', '', '', '华宁县', '2852');
INSERT INTO `base_zip` VALUES ('2859', '530425', '', '', '易门县', '2852');
INSERT INTO `base_zip` VALUES ('2860', '530426', '', '', '峨山彝族自治县', '2852');
INSERT INTO `base_zip` VALUES ('2861', '530427', '', '', '新平彝族傣族自治县', '2852');
INSERT INTO `base_zip` VALUES ('2862', '530428', '', '', '元江哈尼族彝族傣族自治县', '2852');
INSERT INTO `base_zip` VALUES ('2863', '530500', '', '保山市', '', '2824');
INSERT INTO `base_zip` VALUES ('2864', '530501', '', '', '市辖区', '2863');
INSERT INTO `base_zip` VALUES ('2865', '530502', '', '', '隆阳区', '2863');
INSERT INTO `base_zip` VALUES ('2866', '530521', '', '', '施甸县', '2863');
INSERT INTO `base_zip` VALUES ('2867', '530522', '', '', '腾冲县', '2863');
INSERT INTO `base_zip` VALUES ('2868', '530523', '', '', '龙陵县', '2863');
INSERT INTO `base_zip` VALUES ('2869', '530524', '', '', '昌宁县', '2863');
INSERT INTO `base_zip` VALUES ('2870', '530600', '', '昭通市', '', '2824');
INSERT INTO `base_zip` VALUES ('2871', '530601', '', '', '市辖区', '2870');
INSERT INTO `base_zip` VALUES ('2872', '530602', '', '', '昭阳区', '2870');
INSERT INTO `base_zip` VALUES ('2873', '530621', '', '', '鲁甸县', '2870');
INSERT INTO `base_zip` VALUES ('2874', '530622', '', '', '巧家县', '2870');
INSERT INTO `base_zip` VALUES ('2875', '530623', '', '', '盐津县', '2870');
INSERT INTO `base_zip` VALUES ('2876', '530624', '', '', '大关县', '2870');
INSERT INTO `base_zip` VALUES ('2877', '530625', '', '', '永善县', '2870');
INSERT INTO `base_zip` VALUES ('2878', '530626', '', '', '绥江县', '2870');
INSERT INTO `base_zip` VALUES ('2879', '530627', '', '', '镇雄县', '2870');
INSERT INTO `base_zip` VALUES ('2880', '530628', '', '', '彝良县', '2870');
INSERT INTO `base_zip` VALUES ('2881', '530629', '', '', '威信县', '2870');
INSERT INTO `base_zip` VALUES ('2882', '530630', '', '', '水富县', '2870');
INSERT INTO `base_zip` VALUES ('2883', '530700', '', '丽江市', '', '2824');
INSERT INTO `base_zip` VALUES ('2884', '530701', '', '', '市辖区', '2883');
INSERT INTO `base_zip` VALUES ('2885', '530702', '', '', '古城区', '2883');
INSERT INTO `base_zip` VALUES ('2886', '530721', '', '', '玉龙纳西族自治县', '2883');
INSERT INTO `base_zip` VALUES ('2887', '530722', '', '', '永胜县', '2883');
INSERT INTO `base_zip` VALUES ('2888', '530723', '', '', '华坪县', '2883');
INSERT INTO `base_zip` VALUES ('2889', '530724', '', '', '宁蒗彝族自治县', '2883');
INSERT INTO `base_zip` VALUES ('2890', '530800', '', '普洱市', '', '2824');
INSERT INTO `base_zip` VALUES ('2891', '530801', '', '', '市辖区', '2890');
INSERT INTO `base_zip` VALUES ('2892', '530802', '', '', '思茅区', '2890');
INSERT INTO `base_zip` VALUES ('2893', '530821', '', '', '宁洱哈尼族彝族自治县', '2890');
INSERT INTO `base_zip` VALUES ('2894', '530822', '', '', '墨江哈尼族自治县', '2890');
INSERT INTO `base_zip` VALUES ('2895', '530823', '', '', '景东彝族自治县', '2890');
INSERT INTO `base_zip` VALUES ('2896', '530824', '', '', '景谷傣族彝族自治县', '2890');
INSERT INTO `base_zip` VALUES ('2897', '530825', '', '', '镇沅彝族哈尼族拉祜族自治县', '2890');
INSERT INTO `base_zip` VALUES ('2898', '530826', '', '', '江城哈尼族彝族自治县', '2890');
INSERT INTO `base_zip` VALUES ('2899', '530827', '', '', '孟连傣族拉祜族佤族自治县', '2890');
INSERT INTO `base_zip` VALUES ('2900', '530828', '', '', '澜沧拉祜族自治县', '2890');
INSERT INTO `base_zip` VALUES ('2901', '530829', '', '', '西盟佤族自治县', '2890');
INSERT INTO `base_zip` VALUES ('2902', '530900', '', '临沧市', '', '2824');
INSERT INTO `base_zip` VALUES ('2903', '530901', '', '', '市辖区', '2902');
INSERT INTO `base_zip` VALUES ('2904', '530902', '', '', '临翔区', '2902');
INSERT INTO `base_zip` VALUES ('2905', '530921', '', '', '凤庆县', '2902');
INSERT INTO `base_zip` VALUES ('2906', '530922', '', '', '云县', '2902');
INSERT INTO `base_zip` VALUES ('2907', '530923', '', '', '永德县', '2902');
INSERT INTO `base_zip` VALUES ('2908', '530924', '', '', '镇康县', '2902');
INSERT INTO `base_zip` VALUES ('2909', '530925', '', '', '双江拉祜族佤族布朗族傣族自治县', '2902');
INSERT INTO `base_zip` VALUES ('2910', '530926', '', '', '耿马傣族佤族自治县', '2902');
INSERT INTO `base_zip` VALUES ('2911', '530927', '', '', '沧源佤族自治县', '2902');
INSERT INTO `base_zip` VALUES ('2912', '532300', '', '楚雄彝族自治州', '', '2824');
INSERT INTO `base_zip` VALUES ('2913', '532301', '', '', '楚雄市', '2912');
INSERT INTO `base_zip` VALUES ('2914', '532322', '', '', '双柏县', '2912');
INSERT INTO `base_zip` VALUES ('2915', '532323', '', '', '牟定县', '2912');
INSERT INTO `base_zip` VALUES ('2916', '532324', '', '', '南华县', '2912');
INSERT INTO `base_zip` VALUES ('2917', '532325', '', '', '姚安县', '2912');
INSERT INTO `base_zip` VALUES ('2918', '532326', '', '', '大姚县', '2912');
INSERT INTO `base_zip` VALUES ('2919', '532327', '', '', '永仁县', '2912');
INSERT INTO `base_zip` VALUES ('2920', '532328', '', '', '元谋县', '2912');
INSERT INTO `base_zip` VALUES ('2921', '532329', '', '', '武定县', '2912');
INSERT INTO `base_zip` VALUES ('2922', '532331', '', '', '禄丰县', '2912');
INSERT INTO `base_zip` VALUES ('2923', '532500', '', '红河哈尼族彝族自治州', '', '2824');
INSERT INTO `base_zip` VALUES ('2924', '532501', '', '', '个旧市', '2923');
INSERT INTO `base_zip` VALUES ('2925', '532502', '', '', '开远市', '2923');
INSERT INTO `base_zip` VALUES ('2926', '532503', '', '', '蒙自市', '2923');
INSERT INTO `base_zip` VALUES ('2927', '532504', '', '', '弥勒市', '2923');
INSERT INTO `base_zip` VALUES ('2928', '532523', '', '', '屏边苗族自治县', '2923');
INSERT INTO `base_zip` VALUES ('2929', '532524', '', '', '建水县', '2923');
INSERT INTO `base_zip` VALUES ('2930', '532525', '', '', '石屏县', '2923');
INSERT INTO `base_zip` VALUES ('2931', '532527', '', '', '泸西县', '2923');
INSERT INTO `base_zip` VALUES ('2932', '532528', '', '', '元阳县', '2923');
INSERT INTO `base_zip` VALUES ('2933', '532529', '', '', '红河县', '2923');
INSERT INTO `base_zip` VALUES ('2934', '532530', '', '', '金平苗族瑶族傣族自治县', '2923');
INSERT INTO `base_zip` VALUES ('2935', '532531', '', '', '绿春县', '2923');
INSERT INTO `base_zip` VALUES ('2936', '532532', '', '', '河口瑶族自治县', '2923');
INSERT INTO `base_zip` VALUES ('2937', '532600', '', '文山壮族苗族自治州', '', '2824');
INSERT INTO `base_zip` VALUES ('2938', '532601', '', '', '文山市', '2937');
INSERT INTO `base_zip` VALUES ('2939', '532622', '', '', '砚山县', '2937');
INSERT INTO `base_zip` VALUES ('2940', '532623', '', '', '西畴县', '2937');
INSERT INTO `base_zip` VALUES ('2941', '532624', '', '', '麻栗坡县', '2937');
INSERT INTO `base_zip` VALUES ('2942', '532625', '', '', '马关县', '2937');
INSERT INTO `base_zip` VALUES ('2943', '532626', '', '', '丘北县', '2937');
INSERT INTO `base_zip` VALUES ('2944', '532627', '', '', '广南县', '2937');
INSERT INTO `base_zip` VALUES ('2945', '532628', '', '', '富宁县', '2937');
INSERT INTO `base_zip` VALUES ('2946', '532800', '', '西双版纳傣族自治州', '', '2824');
INSERT INTO `base_zip` VALUES ('2947', '532801', '', '', '景洪市', '2946');
INSERT INTO `base_zip` VALUES ('2948', '532822', '', '', '勐海县', '2946');
INSERT INTO `base_zip` VALUES ('2949', '532823', '', '', '勐腊县', '2946');
INSERT INTO `base_zip` VALUES ('2950', '532900', '', '大理白族自治州', '', '2824');
INSERT INTO `base_zip` VALUES ('2951', '532901', '', '', '大理市', '2950');
INSERT INTO `base_zip` VALUES ('2952', '532922', '', '', '漾濞彝族自治县', '2950');
INSERT INTO `base_zip` VALUES ('2953', '532923', '', '', '祥云县', '2950');
INSERT INTO `base_zip` VALUES ('2954', '532924', '', '', '宾川县', '2950');
INSERT INTO `base_zip` VALUES ('2955', '532925', '', '', '弥渡县', '2950');
INSERT INTO `base_zip` VALUES ('2956', '532926', '', '', '南涧彝族自治县', '2950');
INSERT INTO `base_zip` VALUES ('2957', '532927', '', '', '巍山彝族回族自治县', '2950');
INSERT INTO `base_zip` VALUES ('2958', '532928', '', '', '永平县', '2950');
INSERT INTO `base_zip` VALUES ('2959', '532929', '', '', '云龙县', '2950');
INSERT INTO `base_zip` VALUES ('2960', '532930', '', '', '洱源县', '2950');
INSERT INTO `base_zip` VALUES ('2961', '532931', '', '', '剑川县', '2950');
INSERT INTO `base_zip` VALUES ('2962', '532932', '', '', '鹤庆县', '2950');
INSERT INTO `base_zip` VALUES ('2963', '533100', '', '德宏傣族景颇族自治州', '', '2824');
INSERT INTO `base_zip` VALUES ('2964', '533102', '', '', '瑞丽市', '2963');
INSERT INTO `base_zip` VALUES ('2965', '533103', '', '', '芒市', '2963');
INSERT INTO `base_zip` VALUES ('2966', '533122', '', '', '梁河县', '2963');
INSERT INTO `base_zip` VALUES ('2967', '533123', '', '', '盈江县', '2963');
INSERT INTO `base_zip` VALUES ('2968', '533124', '', '', '陇川县', '2963');
INSERT INTO `base_zip` VALUES ('2969', '533300', '', '怒江傈僳族自治州', '', '2824');
INSERT INTO `base_zip` VALUES ('2970', '533321', '', '', '泸水县', '2969');
INSERT INTO `base_zip` VALUES ('2971', '533323', '', '', '福贡县', '2969');
INSERT INTO `base_zip` VALUES ('2972', '533324', '', '', '贡山独龙族怒族自治县', '2969');
INSERT INTO `base_zip` VALUES ('2973', '533325', '', '', '兰坪白族普米族自治县', '2969');
INSERT INTO `base_zip` VALUES ('2974', '533400', '', '迪庆藏族自治州', '', '2824');
INSERT INTO `base_zip` VALUES ('2975', '533401', '', '', '香格里拉市', '2974');
INSERT INTO `base_zip` VALUES ('2976', '533422', '', '', '德钦县', '2974');
INSERT INTO `base_zip` VALUES ('2977', '533423', '', '', '维西傈僳族自治县', '2974');
INSERT INTO `base_zip` VALUES ('2978', '540000', '西藏自治区', '', '', '1');
INSERT INTO `base_zip` VALUES ('2979', '540100', '', '拉萨市', '', '2978');
INSERT INTO `base_zip` VALUES ('2980', '540101', '', '', '市辖区', '2979');
INSERT INTO `base_zip` VALUES ('2981', '540102', '', '', '城关区', '2979');
INSERT INTO `base_zip` VALUES ('2982', '540121', '', '', '林周县', '2979');
INSERT INTO `base_zip` VALUES ('2983', '540122', '', '', '当雄县', '2979');
INSERT INTO `base_zip` VALUES ('2984', '540123', '', '', '尼木县', '2979');
INSERT INTO `base_zip` VALUES ('2985', '540124', '', '', '曲水县', '2979');
INSERT INTO `base_zip` VALUES ('2986', '540125', '', '', '堆龙德庆县', '2979');
INSERT INTO `base_zip` VALUES ('2987', '540126', '', '', '达孜县', '2979');
INSERT INTO `base_zip` VALUES ('2988', '540127', '', '', '墨竹工卡县', '2979');
INSERT INTO `base_zip` VALUES ('2989', '540200', '', '日喀则市', '', '2978');
INSERT INTO `base_zip` VALUES ('2990', '540201', '', '', '市辖区', '2989');
INSERT INTO `base_zip` VALUES ('2991', '540202', '', '', '桑珠孜区', '2989');
INSERT INTO `base_zip` VALUES ('2992', '540221', '', '', '南木林县', '2989');
INSERT INTO `base_zip` VALUES ('2993', '540222', '', '', '江孜县', '2989');
INSERT INTO `base_zip` VALUES ('2994', '540223', '', '', '定日县', '2989');
INSERT INTO `base_zip` VALUES ('2995', '540224', '', '', '萨迦县', '2989');
INSERT INTO `base_zip` VALUES ('2996', '540225', '', '', '拉孜县', '2989');
INSERT INTO `base_zip` VALUES ('2997', '540226', '', '', '昂仁县', '2989');
INSERT INTO `base_zip` VALUES ('2998', '540227', '', '', '谢通门县', '2989');
INSERT INTO `base_zip` VALUES ('2999', '540228', '', '', '白朗县', '2989');
INSERT INTO `base_zip` VALUES ('3000', '540229', '', '', '仁布县', '2989');
INSERT INTO `base_zip` VALUES ('3001', '540230', '', '', '康马县', '2989');
INSERT INTO `base_zip` VALUES ('3002', '540231', '', '', '定结县', '2989');
INSERT INTO `base_zip` VALUES ('3003', '540232', '', '', '仲巴县', '2989');
INSERT INTO `base_zip` VALUES ('3004', '540233', '', '', '亚东县', '2989');
INSERT INTO `base_zip` VALUES ('3005', '540234', '', '', '吉隆县', '2989');
INSERT INTO `base_zip` VALUES ('3006', '540235', '', '', '聂拉木县', '2989');
INSERT INTO `base_zip` VALUES ('3007', '540236', '', '', '萨嘎县', '2989');
INSERT INTO `base_zip` VALUES ('3008', '540237', '', '', '岗巴县', '2989');
INSERT INTO `base_zip` VALUES ('3009', '540300', '', '昌都市', '', '2978');
INSERT INTO `base_zip` VALUES ('3010', '540301', '', '', '市辖区', '3009');
INSERT INTO `base_zip` VALUES ('3011', '540302', '', '', '卡若区', '3009');
INSERT INTO `base_zip` VALUES ('3012', '540321', '', '', '江达县', '3009');
INSERT INTO `base_zip` VALUES ('3013', '540322', '', '', '贡觉县', '3009');
INSERT INTO `base_zip` VALUES ('3014', '540323', '', '', '类乌齐县', '3009');
INSERT INTO `base_zip` VALUES ('3015', '540324', '', '', '丁青县', '3009');
INSERT INTO `base_zip` VALUES ('3016', '540325', '', '', '察雅县', '3009');
INSERT INTO `base_zip` VALUES ('3017', '540326', '', '', '八宿县', '3009');
INSERT INTO `base_zip` VALUES ('3018', '540327', '', '', '左贡县', '3009');
INSERT INTO `base_zip` VALUES ('3019', '540328', '', '', '芒康县', '3009');
INSERT INTO `base_zip` VALUES ('3020', '540329', '', '', '洛隆县', '3009');
INSERT INTO `base_zip` VALUES ('3021', '540330', '', '', '边坝县', '3009');
INSERT INTO `base_zip` VALUES ('3022', '542200', '', '山南地区', '', '2978');
INSERT INTO `base_zip` VALUES ('3023', '542221', '', '', '乃东县', '3022');
INSERT INTO `base_zip` VALUES ('3024', '542222', '', '', '扎囊县', '3022');
INSERT INTO `base_zip` VALUES ('3025', '542223', '', '', '贡嘎县', '3022');
INSERT INTO `base_zip` VALUES ('3026', '542224', '', '', '桑日县', '3022');
INSERT INTO `base_zip` VALUES ('3027', '542225', '', '', '琼结县', '3022');
INSERT INTO `base_zip` VALUES ('3028', '542226', '', '', '曲松县', '3022');
INSERT INTO `base_zip` VALUES ('3029', '542227', '', '', '措美县', '3022');
INSERT INTO `base_zip` VALUES ('3030', '542228', '', '', '洛扎县', '3022');
INSERT INTO `base_zip` VALUES ('3031', '542229', '', '', '加查县', '3022');
INSERT INTO `base_zip` VALUES ('3032', '542231', '', '', '隆子县', '3022');
INSERT INTO `base_zip` VALUES ('3033', '542232', '', '', '错那县', '3022');
INSERT INTO `base_zip` VALUES ('3034', '542233', '', '', '浪卡子县', '3022');
INSERT INTO `base_zip` VALUES ('3035', '542400', '', '那曲地区', '', '2978');
INSERT INTO `base_zip` VALUES ('3036', '542421', '', '', '那曲县', '3035');
INSERT INTO `base_zip` VALUES ('3037', '542422', '', '', '嘉黎县', '3035');
INSERT INTO `base_zip` VALUES ('3038', '542423', '', '', '比如县', '3035');
INSERT INTO `base_zip` VALUES ('3039', '542424', '', '', '聂荣县', '3035');
INSERT INTO `base_zip` VALUES ('3040', '542425', '', '', '安多县', '3035');
INSERT INTO `base_zip` VALUES ('3041', '542426', '', '', '申扎县', '3035');
INSERT INTO `base_zip` VALUES ('3042', '542427', '', '', '索县', '3035');
INSERT INTO `base_zip` VALUES ('3043', '542428', '', '', '班戈县', '3035');
INSERT INTO `base_zip` VALUES ('3044', '542429', '', '', '巴青县', '3035');
INSERT INTO `base_zip` VALUES ('3045', '542430', '', '', '尼玛县', '3035');
INSERT INTO `base_zip` VALUES ('3046', '542431', '', '', '双湖县', '3035');
INSERT INTO `base_zip` VALUES ('3047', '542500', '', '阿里地区', '', '2978');
INSERT INTO `base_zip` VALUES ('3048', '542521', '', '', '普兰县', '3047');
INSERT INTO `base_zip` VALUES ('3049', '542522', '', '', '札达县', '3047');
INSERT INTO `base_zip` VALUES ('3050', '542523', '', '', '噶尔县', '3047');
INSERT INTO `base_zip` VALUES ('3051', '542524', '', '', '日土县', '3047');
INSERT INTO `base_zip` VALUES ('3052', '542525', '', '', '革吉县', '3047');
INSERT INTO `base_zip` VALUES ('3053', '542526', '', '', '改则县', '3047');
INSERT INTO `base_zip` VALUES ('3054', '542527', '', '', '措勤县', '3047');
INSERT INTO `base_zip` VALUES ('3055', '542600', '', '林芝地区', '', '2978');
INSERT INTO `base_zip` VALUES ('3056', '542621', '', '', '林芝县', '3055');
INSERT INTO `base_zip` VALUES ('3057', '542622', '', '', '工布江达县', '3055');
INSERT INTO `base_zip` VALUES ('3058', '542623', '', '', '米林县', '3055');
INSERT INTO `base_zip` VALUES ('3059', '542624', '', '', '墨脱县', '3055');
INSERT INTO `base_zip` VALUES ('3060', '542625', '', '', '波密县', '3055');
INSERT INTO `base_zip` VALUES ('3061', '542626', '', '', '察隅县', '3055');
INSERT INTO `base_zip` VALUES ('3062', '542627', '', '', '朗县', '3055');
INSERT INTO `base_zip` VALUES ('3063', '610000', '陕西省', '', '', '1');
INSERT INTO `base_zip` VALUES ('3064', '610100', '', '西安市', '', '3063');
INSERT INTO `base_zip` VALUES ('3065', '610101', '', '', '市辖区', '3064');
INSERT INTO `base_zip` VALUES ('3066', '610102', '', '', '新城区', '3064');
INSERT INTO `base_zip` VALUES ('3067', '610103', '', '', '碑林区', '3064');
INSERT INTO `base_zip` VALUES ('3068', '610104', '', '', '莲湖区', '3064');
INSERT INTO `base_zip` VALUES ('3069', '610111', '', '', '灞桥区', '3064');
INSERT INTO `base_zip` VALUES ('3070', '610112', '', '', '未央区', '3064');
INSERT INTO `base_zip` VALUES ('3071', '610113', '', '', '雁塔区', '3064');
INSERT INTO `base_zip` VALUES ('3072', '610114', '', '', '阎良区', '3064');
INSERT INTO `base_zip` VALUES ('3073', '610115', '', '', '临潼区', '3064');
INSERT INTO `base_zip` VALUES ('3074', '610116', '', '', '长安区', '3064');
INSERT INTO `base_zip` VALUES ('3075', '610117', '', '', '高陵区', '3064');
INSERT INTO `base_zip` VALUES ('3076', '610122', '', '', '蓝田县', '3064');
INSERT INTO `base_zip` VALUES ('3077', '610124', '', '', '周至县', '3064');
INSERT INTO `base_zip` VALUES ('3078', '610125', '', '', '户县', '3064');
INSERT INTO `base_zip` VALUES ('3079', '610200', '', '铜川市', '', '3063');
INSERT INTO `base_zip` VALUES ('3080', '610201', '', '', '市辖区', '3079');
INSERT INTO `base_zip` VALUES ('3081', '610202', '', '', '王益区', '3079');
INSERT INTO `base_zip` VALUES ('3082', '610203', '', '', '印台区', '3079');
INSERT INTO `base_zip` VALUES ('3083', '610204', '', '', '耀州区', '3079');
INSERT INTO `base_zip` VALUES ('3084', '610222', '', '', '宜君县', '3079');
INSERT INTO `base_zip` VALUES ('3085', '610300', '', '宝鸡市', '', '3063');
INSERT INTO `base_zip` VALUES ('3086', '610301', '', '', '市辖区', '3085');
INSERT INTO `base_zip` VALUES ('3087', '610302', '', '', '渭滨区', '3085');
INSERT INTO `base_zip` VALUES ('3088', '610303', '', '', '金台区', '3085');
INSERT INTO `base_zip` VALUES ('3089', '610304', '', '', '陈仓区', '3085');
INSERT INTO `base_zip` VALUES ('3090', '610322', '', '', '凤翔县', '3085');
INSERT INTO `base_zip` VALUES ('3091', '610323', '', '', '岐山县', '3085');
INSERT INTO `base_zip` VALUES ('3092', '610324', '', '', '扶风县', '3085');
INSERT INTO `base_zip` VALUES ('3093', '610326', '', '', '眉县', '3085');
INSERT INTO `base_zip` VALUES ('3094', '610327', '', '', '陇县', '3085');
INSERT INTO `base_zip` VALUES ('3095', '610328', '', '', '千阳县', '3085');
INSERT INTO `base_zip` VALUES ('3096', '610329', '', '', '麟游县', '3085');
INSERT INTO `base_zip` VALUES ('3097', '610330', '', '', '凤县', '3085');
INSERT INTO `base_zip` VALUES ('3098', '610331', '', '', '太白县', '3085');
INSERT INTO `base_zip` VALUES ('3099', '610400', '', '咸阳市', '', '3063');
INSERT INTO `base_zip` VALUES ('3100', '610401', '', '', '市辖区', '3099');
INSERT INTO `base_zip` VALUES ('3101', '610402', '', '', '秦都区', '3099');
INSERT INTO `base_zip` VALUES ('3102', '610403', '', '', '杨陵区', '3099');
INSERT INTO `base_zip` VALUES ('3103', '610404', '', '', '渭城区', '3099');
INSERT INTO `base_zip` VALUES ('3104', '610422', '', '', '三原县', '3099');
INSERT INTO `base_zip` VALUES ('3105', '610423', '', '', '泾阳县', '3099');
INSERT INTO `base_zip` VALUES ('3106', '610424', '', '', '乾县', '3099');
INSERT INTO `base_zip` VALUES ('3107', '610425', '', '', '礼泉县', '3099');
INSERT INTO `base_zip` VALUES ('3108', '610426', '', '', '永寿县', '3099');
INSERT INTO `base_zip` VALUES ('3109', '610427', '', '', '彬县', '3099');
INSERT INTO `base_zip` VALUES ('3110', '610428', '', '', '长武县', '3099');
INSERT INTO `base_zip` VALUES ('3111', '610429', '', '', '旬邑县', '3099');
INSERT INTO `base_zip` VALUES ('3112', '610430', '', '', '淳化县', '3099');
INSERT INTO `base_zip` VALUES ('3113', '610431', '', '', '武功县', '3099');
INSERT INTO `base_zip` VALUES ('3114', '610481', '', '', '兴平市', '3099');
INSERT INTO `base_zip` VALUES ('3115', '610500', '', '渭南市', '', '3063');
INSERT INTO `base_zip` VALUES ('3116', '610501', '', '', '市辖区', '3115');
INSERT INTO `base_zip` VALUES ('3117', '610502', '', '', '临渭区', '3115');
INSERT INTO `base_zip` VALUES ('3118', '610521', '', '', '华县', '3115');
INSERT INTO `base_zip` VALUES ('3119', '610522', '', '', '潼关县', '3115');
INSERT INTO `base_zip` VALUES ('3120', '610523', '', '', '大荔县', '3115');
INSERT INTO `base_zip` VALUES ('3121', '610524', '', '', '合阳县', '3115');
INSERT INTO `base_zip` VALUES ('3122', '610525', '', '', '澄城县', '3115');
INSERT INTO `base_zip` VALUES ('3123', '610526', '', '', '蒲城县', '3115');
INSERT INTO `base_zip` VALUES ('3124', '610527', '', '', '白水县', '3115');
INSERT INTO `base_zip` VALUES ('3125', '610528', '', '', '富平县', '3115');
INSERT INTO `base_zip` VALUES ('3126', '610581', '', '', '韩城市', '3115');
INSERT INTO `base_zip` VALUES ('3127', '610582', '', '', '华阴市', '3115');
INSERT INTO `base_zip` VALUES ('3128', '610600', '', '延安市', '', '3063');
INSERT INTO `base_zip` VALUES ('3129', '610601', '', '', '市辖区', '3128');
INSERT INTO `base_zip` VALUES ('3130', '610602', '', '', '宝塔区', '3128');
INSERT INTO `base_zip` VALUES ('3131', '610621', '', '', '延长县', '3128');
INSERT INTO `base_zip` VALUES ('3132', '610622', '', '', '延川县', '3128');
INSERT INTO `base_zip` VALUES ('3133', '610623', '', '', '子长县', '3128');
INSERT INTO `base_zip` VALUES ('3134', '610624', '', '', '安塞县', '3128');
INSERT INTO `base_zip` VALUES ('3135', '610625', '', '', '志丹县', '3128');
INSERT INTO `base_zip` VALUES ('3136', '610626', '', '', '吴起县', '3128');
INSERT INTO `base_zip` VALUES ('3137', '610627', '', '', '甘泉县', '3128');
INSERT INTO `base_zip` VALUES ('3138', '610628', '', '', '富县', '3128');
INSERT INTO `base_zip` VALUES ('3139', '610629', '', '', '洛川县', '3128');
INSERT INTO `base_zip` VALUES ('3140', '610630', '', '', '宜川县', '3128');
INSERT INTO `base_zip` VALUES ('3141', '610631', '', '', '黄龙县', '3128');
INSERT INTO `base_zip` VALUES ('3142', '610632', '', '', '黄陵县', '3128');
INSERT INTO `base_zip` VALUES ('3143', '610700', '', '汉中市', '', '3063');
INSERT INTO `base_zip` VALUES ('3144', '610701', '', '', '市辖区', '3143');
INSERT INTO `base_zip` VALUES ('3145', '610702', '', '', '汉台区', '3143');
INSERT INTO `base_zip` VALUES ('3146', '610721', '', '', '南郑县', '3143');
INSERT INTO `base_zip` VALUES ('3147', '610722', '', '', '城固县', '3143');
INSERT INTO `base_zip` VALUES ('3148', '610723', '', '', '洋县', '3143');
INSERT INTO `base_zip` VALUES ('3149', '610724', '', '', '西乡县', '3143');
INSERT INTO `base_zip` VALUES ('3150', '610725', '', '', '勉县', '3143');
INSERT INTO `base_zip` VALUES ('3151', '610726', '', '', '宁强县', '3143');
INSERT INTO `base_zip` VALUES ('3152', '610727', '', '', '略阳县', '3143');
INSERT INTO `base_zip` VALUES ('3153', '610728', '', '', '镇巴县', '3143');
INSERT INTO `base_zip` VALUES ('3154', '610729', '', '', '留坝县', '3143');
INSERT INTO `base_zip` VALUES ('3155', '610730', '', '', '佛坪县', '3143');
INSERT INTO `base_zip` VALUES ('3156', '610800', '', '榆林市', '', '3063');
INSERT INTO `base_zip` VALUES ('3157', '610801', '', '', '市辖区', '3156');
INSERT INTO `base_zip` VALUES ('3158', '610802', '', '', '榆阳区', '3156');
INSERT INTO `base_zip` VALUES ('3159', '610821', '', '', '神木县', '3156');
INSERT INTO `base_zip` VALUES ('3160', '610822', '', '', '府谷县', '3156');
INSERT INTO `base_zip` VALUES ('3161', '610823', '', '', '横山县', '3156');
INSERT INTO `base_zip` VALUES ('3162', '610824', '', '', '靖边县', '3156');
INSERT INTO `base_zip` VALUES ('3163', '610825', '', '', '定边县', '3156');
INSERT INTO `base_zip` VALUES ('3164', '610826', '', '', '绥德县', '3156');
INSERT INTO `base_zip` VALUES ('3165', '610827', '', '', '米脂县', '3156');
INSERT INTO `base_zip` VALUES ('3166', '610828', '', '', '佳县', '3156');
INSERT INTO `base_zip` VALUES ('3167', '610829', '', '', '吴堡县', '3156');
INSERT INTO `base_zip` VALUES ('3168', '610830', '', '', '清涧县', '3156');
INSERT INTO `base_zip` VALUES ('3169', '610831', '', '', '子洲县', '3156');
INSERT INTO `base_zip` VALUES ('3170', '610900', '', '安康市', '', '3063');
INSERT INTO `base_zip` VALUES ('3171', '610901', '', '', '市辖区', '3170');
INSERT INTO `base_zip` VALUES ('3172', '610902000汉滨区', '', '', '', '610902000汉滨区');
INSERT INTO `base_zip` VALUES ('3173', '610921', '', '', '汉阴县', '3170');
INSERT INTO `base_zip` VALUES ('3174', '610922', '', '', '石泉县', '3170');
INSERT INTO `base_zip` VALUES ('3175', '610923', '', '', '宁陕县', '3170');
INSERT INTO `base_zip` VALUES ('3176', '610924', '', '', '紫阳县', '3170');
INSERT INTO `base_zip` VALUES ('3177', '610925', '', '', '岚皋县', '3170');
INSERT INTO `base_zip` VALUES ('3178', '610926', '', '', '平利县', '3170');
INSERT INTO `base_zip` VALUES ('3179', '610927', '', '', '镇坪县', '3170');
INSERT INTO `base_zip` VALUES ('3180', '610928', '', '', '旬阳县', '3170');
INSERT INTO `base_zip` VALUES ('3181', '610929', '', '', '白河县', '3170');
INSERT INTO `base_zip` VALUES ('3182', '611000', '', '商洛市', '', '3063');
INSERT INTO `base_zip` VALUES ('3183', '611001', '', '', '市辖区', '3182');
INSERT INTO `base_zip` VALUES ('3184', '611002', '', '', '商州区', '3182');
INSERT INTO `base_zip` VALUES ('3185', '611021', '', '', '洛南县', '3182');
INSERT INTO `base_zip` VALUES ('3186', '611022', '', '', '丹凤县', '3182');
INSERT INTO `base_zip` VALUES ('3187', '611023', '', '', '商南县', '3182');
INSERT INTO `base_zip` VALUES ('3188', '611024', '', '', '山阳县', '3182');
INSERT INTO `base_zip` VALUES ('3189', '611025', '', '', '镇安县', '3182');
INSERT INTO `base_zip` VALUES ('3190', '611026', '', '', '柞水县', '3182');
INSERT INTO `base_zip` VALUES ('3191', '620000', '甘肃省', '', '', '1');
INSERT INTO `base_zip` VALUES ('3192', '620100', '', '兰州市', '', '3191');
INSERT INTO `base_zip` VALUES ('3193', '620101', '', '', '市辖区', '3192');
INSERT INTO `base_zip` VALUES ('3194', '620102', '', '', '城关区', '3192');
INSERT INTO `base_zip` VALUES ('3195', '620103', '', '', '七里河区', '3192');
INSERT INTO `base_zip` VALUES ('3196', '620104', '', '', '西固区', '3192');
INSERT INTO `base_zip` VALUES ('3197', '620105', '', '', '安宁区', '3192');
INSERT INTO `base_zip` VALUES ('3198', '620111', '', '', '红古区', '3192');
INSERT INTO `base_zip` VALUES ('3199', '620121', '', '', '永登县', '3192');
INSERT INTO `base_zip` VALUES ('3200', '620122', '', '', '皋兰县', '3192');
INSERT INTO `base_zip` VALUES ('3201', '620123', '', '', '榆中县', '3192');
INSERT INTO `base_zip` VALUES ('3202', '620200', '', '嘉峪关市', '', '3191');
INSERT INTO `base_zip` VALUES ('3203', '620201', '', '', '市辖区', '3202');
INSERT INTO `base_zip` VALUES ('3204', '620300', '', '金昌市', '', '3191');
INSERT INTO `base_zip` VALUES ('3205', '620301', '', '', '市辖区', '3204');
INSERT INTO `base_zip` VALUES ('3206', '620302', '', '', '金川区', '3204');
INSERT INTO `base_zip` VALUES ('3207', '620321', '', '', '永昌县', '3204');
INSERT INTO `base_zip` VALUES ('3208', '620400', '', '白银市', '', '3191');
INSERT INTO `base_zip` VALUES ('3209', '620401', '', '', '市辖区', '3208');
INSERT INTO `base_zip` VALUES ('3210', '620402', '', '', '白银区', '3208');
INSERT INTO `base_zip` VALUES ('3211', '620403', '', '', '平川区', '3208');
INSERT INTO `base_zip` VALUES ('3212', '620421', '', '', '靖远县', '3208');
INSERT INTO `base_zip` VALUES ('3213', '620422', '', '', '会宁县', '3208');
INSERT INTO `base_zip` VALUES ('3214', '620423', '', '', '景泰县', '3208');
INSERT INTO `base_zip` VALUES ('3215', '620500', '', '天水市', '', '3191');
INSERT INTO `base_zip` VALUES ('3216', '620501', '', '', '市辖区', '3215');
INSERT INTO `base_zip` VALUES ('3217', '620502', '', '', '秦州区', '3215');
INSERT INTO `base_zip` VALUES ('3218', '620503', '', '', '麦积区', '3215');
INSERT INTO `base_zip` VALUES ('3219', '620521', '', '', '清水县', '3215');
INSERT INTO `base_zip` VALUES ('3220', '620522', '', '', '秦安县', '3215');
INSERT INTO `base_zip` VALUES ('3221', '620523', '', '', '甘谷县', '3215');
INSERT INTO `base_zip` VALUES ('3222', '620524', '', '', '武山县', '3215');
INSERT INTO `base_zip` VALUES ('3223', '620525', '', '', '张家川回族自治县', '3215');
INSERT INTO `base_zip` VALUES ('3224', '620600', '', '武威市', '', '3191');
INSERT INTO `base_zip` VALUES ('3225', '620601', '', '', '市辖区', '3224');
INSERT INTO `base_zip` VALUES ('3226', '620602', '', '', '凉州区', '3224');
INSERT INTO `base_zip` VALUES ('3227', '620621', '', '', '民勤县', '3224');
INSERT INTO `base_zip` VALUES ('3228', '620622', '', '', '古浪县', '3224');
INSERT INTO `base_zip` VALUES ('3229', '620623', '', '', '天祝藏族自治县', '3224');
INSERT INTO `base_zip` VALUES ('3230', '620700', '', '张掖市', '', '3191');
INSERT INTO `base_zip` VALUES ('3231', '620701', '', '', '市辖区', '3230');
INSERT INTO `base_zip` VALUES ('3232', '620702', '', '', '甘州区', '3230');
INSERT INTO `base_zip` VALUES ('3233', '620721', '', '', '肃南裕固族自治县', '3230');
INSERT INTO `base_zip` VALUES ('3234', '620722', '', '', '民乐县', '3230');
INSERT INTO `base_zip` VALUES ('3235', '620723', '', '', '临泽县', '3230');
INSERT INTO `base_zip` VALUES ('3236', '620724', '', '', '高台县', '3230');
INSERT INTO `base_zip` VALUES ('3237', '620725', '', '', '山丹县', '3230');
INSERT INTO `base_zip` VALUES ('3238', '620800', '', '平凉市', '', '3191');
INSERT INTO `base_zip` VALUES ('3239', '620801', '', '', '市辖区', '3238');
INSERT INTO `base_zip` VALUES ('3240', '620802', '', '', '崆峒区', '3238');
INSERT INTO `base_zip` VALUES ('3241', '620821', '', '', '泾川县', '3238');
INSERT INTO `base_zip` VALUES ('3242', '620822', '', '', '灵台县', '3238');
INSERT INTO `base_zip` VALUES ('3243', '620823', '', '', '崇信县', '3238');
INSERT INTO `base_zip` VALUES ('3244', '620824', '', '', '华亭县', '3238');
INSERT INTO `base_zip` VALUES ('3245', '620825', '', '', '庄浪县', '3238');
INSERT INTO `base_zip` VALUES ('3246', '620826', '', '', '静宁县', '3238');
INSERT INTO `base_zip` VALUES ('3247', '620900', '', '酒泉市', '', '3191');
INSERT INTO `base_zip` VALUES ('3248', '620901', '', '', '市辖区', '3247');
INSERT INTO `base_zip` VALUES ('3249', '620902', '', '', '肃州区', '3247');
INSERT INTO `base_zip` VALUES ('3250', '620921', '', '', '金塔县', '3247');
INSERT INTO `base_zip` VALUES ('3251', '620922', '', '', '瓜州县', '3247');
INSERT INTO `base_zip` VALUES ('3252', '620923', '', '', '肃北蒙古族自治县', '3247');
INSERT INTO `base_zip` VALUES ('3253', '620924', '', '', '阿克塞哈萨克族自治县', '3247');
INSERT INTO `base_zip` VALUES ('3254', '620981', '', '', '玉门市', '3247');
INSERT INTO `base_zip` VALUES ('3255', '620982', '', '', '敦煌市', '3247');
INSERT INTO `base_zip` VALUES ('3256', '621000', '', '庆阳市', '', '3191');
INSERT INTO `base_zip` VALUES ('3257', '621001', '', '', '市辖区', '3256');
INSERT INTO `base_zip` VALUES ('3258', '621002', '', '', '西峰区', '3256');
INSERT INTO `base_zip` VALUES ('3259', '621021', '', '', '庆城县', '3256');
INSERT INTO `base_zip` VALUES ('3260', '621022', '', '', '环县', '3256');
INSERT INTO `base_zip` VALUES ('3261', '621023', '', '', '华池县', '3256');
INSERT INTO `base_zip` VALUES ('3262', '621024', '', '', '合水县', '3256');
INSERT INTO `base_zip` VALUES ('3263', '621025', '', '', '正宁县', '3256');
INSERT INTO `base_zip` VALUES ('3264', '621026', '', '', '宁县', '3256');
INSERT INTO `base_zip` VALUES ('3265', '621027', '', '', '镇原县', '3256');
INSERT INTO `base_zip` VALUES ('3266', '621100', '', '定西市', '', '3191');
INSERT INTO `base_zip` VALUES ('3267', '621101', '', '', '市辖区', '3266');
INSERT INTO `base_zip` VALUES ('3268', '621102', '', '', '安定区', '3266');
INSERT INTO `base_zip` VALUES ('3269', '621121', '', '', '通渭县', '3266');
INSERT INTO `base_zip` VALUES ('3270', '621122', '', '', '陇西县', '3266');
INSERT INTO `base_zip` VALUES ('3271', '621123', '', '', '渭源县', '3266');
INSERT INTO `base_zip` VALUES ('3272', '621124', '', '', '临洮县', '3266');
INSERT INTO `base_zip` VALUES ('3273', '621125', '', '', '漳县', '3266');
INSERT INTO `base_zip` VALUES ('3274', '621126', '', '', '岷县', '3266');
INSERT INTO `base_zip` VALUES ('3275', '621200', '', '陇南市', '', '3191');
INSERT INTO `base_zip` VALUES ('3276', '621201', '', '', '市辖区', '3275');
INSERT INTO `base_zip` VALUES ('3277', '621202', '', '', '武都区', '3275');
INSERT INTO `base_zip` VALUES ('3278', '621221', '', '', '成县', '3275');
INSERT INTO `base_zip` VALUES ('3279', '621222', '', '', '文县', '3275');
INSERT INTO `base_zip` VALUES ('3280', '621223', '', '', '宕昌县', '3275');
INSERT INTO `base_zip` VALUES ('3281', '621224', '', '', '康县', '3275');
INSERT INTO `base_zip` VALUES ('3282', '621225', '', '', '西和县', '3275');
INSERT INTO `base_zip` VALUES ('3283', '621226', '', '', '礼县', '3275');
INSERT INTO `base_zip` VALUES ('3284', '621227', '', '', '徽县', '3275');
INSERT INTO `base_zip` VALUES ('3285', '621228', '', '', '两当县', '3275');
INSERT INTO `base_zip` VALUES ('3286', '622900', '', '临夏回族自治州', '', '3191');
INSERT INTO `base_zip` VALUES ('3287', '622901', '', '', '临夏市', '3286');
INSERT INTO `base_zip` VALUES ('3288', '622921', '', '', '临夏县', '3286');
INSERT INTO `base_zip` VALUES ('3289', '622922', '', '', '康乐县', '3286');
INSERT INTO `base_zip` VALUES ('3290', '622923', '', '', '永靖县', '3286');
INSERT INTO `base_zip` VALUES ('3291', '622924', '', '', '广河县', '3286');
INSERT INTO `base_zip` VALUES ('3292', '622925', '', '', '和政县', '3286');
INSERT INTO `base_zip` VALUES ('3293', '622926', '', '', '东乡族自治县', '3286');
INSERT INTO `base_zip` VALUES ('3294', '622927', '', '', '积石山保安族东乡族撒拉族自治县', '3286');
INSERT INTO `base_zip` VALUES ('3295', '623000', '', '甘南藏族自治州', '', '3191');
INSERT INTO `base_zip` VALUES ('3296', '623001', '', '', '合作市', '3295');
INSERT INTO `base_zip` VALUES ('3297', '623021', '', '', '临潭县', '3295');
INSERT INTO `base_zip` VALUES ('3298', '623022', '', '', '卓尼县', '3295');
INSERT INTO `base_zip` VALUES ('3299', '623023', '', '', '舟曲县', '3295');
INSERT INTO `base_zip` VALUES ('3300', '623024', '', '', '迭部县', '3295');
INSERT INTO `base_zip` VALUES ('3301', '623025', '', '', '玛曲县', '3295');
INSERT INTO `base_zip` VALUES ('3302', '623026', '', '', '碌曲县', '3295');
INSERT INTO `base_zip` VALUES ('3303', '623027', '', '', '夏河县', '3295');
INSERT INTO `base_zip` VALUES ('3304', '630000', '青海省', '', '', '1');
INSERT INTO `base_zip` VALUES ('3305', '630100', '', '西宁市', '', '3304');
INSERT INTO `base_zip` VALUES ('3306', '630101', '', '', '市辖区', '3305');
INSERT INTO `base_zip` VALUES ('3307', '630102', '', '', '城东区', '3305');
INSERT INTO `base_zip` VALUES ('3308', '630103', '', '', '城中区', '3305');
INSERT INTO `base_zip` VALUES ('3309', '630104', '', '', '城西区', '3305');
INSERT INTO `base_zip` VALUES ('3310', '630105', '', '', '城北区', '3305');
INSERT INTO `base_zip` VALUES ('3311', '630121', '', '', '大通回族土族自治县', '3305');
INSERT INTO `base_zip` VALUES ('3312', '630122', '', '', '湟中县', '3305');
INSERT INTO `base_zip` VALUES ('3313', '630123', '', '', '湟源县', '3305');
INSERT INTO `base_zip` VALUES ('3314', '630200', '', '海东市', '', '3304');
INSERT INTO `base_zip` VALUES ('3315', '630201', '', '', '市辖区', '3314');
INSERT INTO `base_zip` VALUES ('3316', '630202', '', '', '乐都区', '3314');
INSERT INTO `base_zip` VALUES ('3317', '630221', '', '', '平安县', '3314');
INSERT INTO `base_zip` VALUES ('3318', '630222', '', '', '民和回族土族自治县', '3314');
INSERT INTO `base_zip` VALUES ('3319', '630223', '', '', '互助土族自治县', '3314');
INSERT INTO `base_zip` VALUES ('3320', '630224', '', '', '化隆回族自治县', '3314');
INSERT INTO `base_zip` VALUES ('3321', '630225', '', '', '循化撒拉族自治县', '3314');
INSERT INTO `base_zip` VALUES ('3322', '632200', '', '海北藏族自治州', '', '3304');
INSERT INTO `base_zip` VALUES ('3323', '632221', '', '', '门源回族自治县', '3322');
INSERT INTO `base_zip` VALUES ('3324', '632222', '', '', '祁连县', '3322');
INSERT INTO `base_zip` VALUES ('3325', '632223', '', '', '海晏县', '3322');
INSERT INTO `base_zip` VALUES ('3326', '632224', '', '', '刚察县', '3322');
INSERT INTO `base_zip` VALUES ('3327', '632300', '', '黄南藏族自治州', '', '3304');
INSERT INTO `base_zip` VALUES ('3328', '632321', '', '', '同仁县', '3327');
INSERT INTO `base_zip` VALUES ('3329', '632322', '', '', '尖扎县', '3327');
INSERT INTO `base_zip` VALUES ('3330', '632323', '', '', '泽库县', '3327');
INSERT INTO `base_zip` VALUES ('3331', '632324', '', '', '河南蒙古族自治县', '3327');
INSERT INTO `base_zip` VALUES ('3332', '632500', '', '海南藏族自治州', '', '3304');
INSERT INTO `base_zip` VALUES ('3333', '632521', '', '', '共和县', '3332');
INSERT INTO `base_zip` VALUES ('3334', '632522', '', '', '同德县', '3332');
INSERT INTO `base_zip` VALUES ('3335', '632523', '', '', '贵德县', '3332');
INSERT INTO `base_zip` VALUES ('3336', '632524', '', '', '兴海县', '3332');
INSERT INTO `base_zip` VALUES ('3337', '632525', '', '', '贵南县', '3332');
INSERT INTO `base_zip` VALUES ('3338', '632600', '', '果洛藏族自治州', '', '3304');
INSERT INTO `base_zip` VALUES ('3339', '632621', '', '', '玛沁县', '3338');
INSERT INTO `base_zip` VALUES ('3340', '632622', '', '', '班玛县', '3338');
INSERT INTO `base_zip` VALUES ('3341', '632623', '', '', '甘德县', '3338');
INSERT INTO `base_zip` VALUES ('3342', '632624', '', '', '达日县', '3338');
INSERT INTO `base_zip` VALUES ('3343', '632625', '', '', '久治县', '3338');
INSERT INTO `base_zip` VALUES ('3344', '632626', '', '', '玛多县', '3338');
INSERT INTO `base_zip` VALUES ('3345', '632700', '', '玉树藏族自治州', '', '3304');
INSERT INTO `base_zip` VALUES ('3346', '632701', '', '', '玉树市', '3345');
INSERT INTO `base_zip` VALUES ('3347', '632722', '', '', '杂多县', '3345');
INSERT INTO `base_zip` VALUES ('3348', '632723', '', '', '称多县', '3345');
INSERT INTO `base_zip` VALUES ('3349', '632724', '', '', '治多县', '3345');
INSERT INTO `base_zip` VALUES ('3350', '632725', '', '', '囊谦县', '3345');
INSERT INTO `base_zip` VALUES ('3351', '632726', '', '', '曲麻莱县', '3345');
INSERT INTO `base_zip` VALUES ('3352', '632800', '', '海西蒙古族藏族自治州', '', '3304');
INSERT INTO `base_zip` VALUES ('3353', '632801', '', '', '格尔木市', '3352');
INSERT INTO `base_zip` VALUES ('3354', '632802', '', '', '德令哈市', '3352');
INSERT INTO `base_zip` VALUES ('3355', '632821', '', '', '乌兰县', '3352');
INSERT INTO `base_zip` VALUES ('3356', '632822', '', '', '都兰县', '3352');
INSERT INTO `base_zip` VALUES ('3357', '632823', '', '', '天峻县', '3352');
INSERT INTO `base_zip` VALUES ('3358', '640000', '宁夏回族自治区', '', '', '1');
INSERT INTO `base_zip` VALUES ('3359', '640100', '', '银川市', '', '3358');
INSERT INTO `base_zip` VALUES ('3360', '640101', '', '', '市辖区', '3359');
INSERT INTO `base_zip` VALUES ('3361', '640104', '', '', '兴庆区', '3359');
INSERT INTO `base_zip` VALUES ('3362', '640105', '', '', '西夏区', '3359');
INSERT INTO `base_zip` VALUES ('3363', '640106', '', '', '金凤区', '3359');
INSERT INTO `base_zip` VALUES ('3364', '640121', '', '', '永宁县', '3359');
INSERT INTO `base_zip` VALUES ('3365', '640122', '', '', '贺兰县', '3359');
INSERT INTO `base_zip` VALUES ('3366', '640181', '', '', '灵武市', '3359');
INSERT INTO `base_zip` VALUES ('3367', '640200', '', '石嘴山市', '', '3358');
INSERT INTO `base_zip` VALUES ('3368', '640201', '', '', '市辖区', '3367');
INSERT INTO `base_zip` VALUES ('3369', '640202', '', '', '大武口区', '3367');
INSERT INTO `base_zip` VALUES ('3370', '640205', '', '', '惠农区', '3367');
INSERT INTO `base_zip` VALUES ('3371', '640221', '', '', '平罗县', '3367');
INSERT INTO `base_zip` VALUES ('3372', '640300', '', '吴忠市', '', '3358');
INSERT INTO `base_zip` VALUES ('3373', '640301', '', '', '市辖区', '3372');
INSERT INTO `base_zip` VALUES ('3374', '640302', '', '', '利通区', '3372');
INSERT INTO `base_zip` VALUES ('3375', '640303', '', '', '红寺堡区', '3372');
INSERT INTO `base_zip` VALUES ('3376', '640323', '', '', '盐池县', '3372');
INSERT INTO `base_zip` VALUES ('3377', '640324', '', '', '同心县', '3372');
INSERT INTO `base_zip` VALUES ('3378', '640381', '', '', '青铜峡市', '3372');
INSERT INTO `base_zip` VALUES ('3379', '640400', '', '固原市', '', '3358');
INSERT INTO `base_zip` VALUES ('3380', '640401', '', '', '市辖区', '3379');
INSERT INTO `base_zip` VALUES ('3381', '640402', '', '', '原州区', '3379');
INSERT INTO `base_zip` VALUES ('3382', '640422', '', '', '西吉县', '3379');
INSERT INTO `base_zip` VALUES ('3383', '640423', '', '', '隆德县', '3379');
INSERT INTO `base_zip` VALUES ('3384', '640424', '', '', '泾源县', '3379');
INSERT INTO `base_zip` VALUES ('3385', '640425', '', '', '彭阳县', '3379');
INSERT INTO `base_zip` VALUES ('3386', '640500', '', '中卫市', '', '3358');
INSERT INTO `base_zip` VALUES ('3387', '640501', '', '', '市辖区', '3386');
INSERT INTO `base_zip` VALUES ('3388', '640502', '', '', '沙坡头区', '3386');
INSERT INTO `base_zip` VALUES ('3389', '640521', '', '', '中宁县', '3386');
INSERT INTO `base_zip` VALUES ('3390', '640522', '', '', '海原县', '3386');
INSERT INTO `base_zip` VALUES ('3391', '650000', '新疆维吾尔自治区', '', '', '1');
INSERT INTO `base_zip` VALUES ('3392', '650100', '', '乌鲁木齐市', '', '3391');
INSERT INTO `base_zip` VALUES ('3393', '650101', '', '', '市辖区', '3392');
INSERT INTO `base_zip` VALUES ('3394', '650102', '', '', '天山区', '3392');
INSERT INTO `base_zip` VALUES ('3395', '650103', '', '', '沙依巴克区', '3392');
INSERT INTO `base_zip` VALUES ('3396', '650104', '', '', '新市区', '3392');
INSERT INTO `base_zip` VALUES ('3397', '650105', '', '', '水磨沟区', '3392');
INSERT INTO `base_zip` VALUES ('3398', '650106', '', '', '头屯河区', '3392');
INSERT INTO `base_zip` VALUES ('3399', '650107', '', '', '达坂城区', '3392');
INSERT INTO `base_zip` VALUES ('3400', '650109', '', '', '米东区', '3392');
INSERT INTO `base_zip` VALUES ('3401', '650121', '', '', '乌鲁木齐县', '3392');
INSERT INTO `base_zip` VALUES ('3402', '650200', '', '克拉玛依市', '', '3391');
INSERT INTO `base_zip` VALUES ('3403', '650201', '', '', '市辖区', '3402');
INSERT INTO `base_zip` VALUES ('3404', '650202', '', '', '独山子区', '3402');
INSERT INTO `base_zip` VALUES ('3405', '650203', '', '', '克拉玛依区', '3402');
INSERT INTO `base_zip` VALUES ('3406', '650204', '', '', '白碱滩区', '3402');
INSERT INTO `base_zip` VALUES ('3407', '650205', '', '', '乌尔禾区', '3402');
INSERT INTO `base_zip` VALUES ('3408', '652100', '', '吐鲁番地区', '', '3391');
INSERT INTO `base_zip` VALUES ('3409', '652101', '', '', '吐鲁番市', '3408');
INSERT INTO `base_zip` VALUES ('3410', '652122', '', '', '鄯善县', '3408');
INSERT INTO `base_zip` VALUES ('3411', '652123', '', '', '托克逊县', '3408');
INSERT INTO `base_zip` VALUES ('3412', '652200', '', '哈密地区', '', '3391');
INSERT INTO `base_zip` VALUES ('3413', '652201', '', '', '哈密市', '3412');
INSERT INTO `base_zip` VALUES ('3414', '652222', '', '', '巴里坤哈萨克自治县', '3412');
INSERT INTO `base_zip` VALUES ('3415', '652223', '', '', '伊吾县', '3412');
INSERT INTO `base_zip` VALUES ('3416', '652300', '', '昌吉回族自治州', '', '3391');
INSERT INTO `base_zip` VALUES ('3417', '652301', '', '', '昌吉市', '3416');
INSERT INTO `base_zip` VALUES ('3418', '652302', '', '', '阜康市', '3416');
INSERT INTO `base_zip` VALUES ('3419', '652323', '', '', '呼图壁县', '3416');
INSERT INTO `base_zip` VALUES ('3420', '652324', '', '', '玛纳斯县', '3416');
INSERT INTO `base_zip` VALUES ('3421', '652325', '', '', '奇台县', '3416');
INSERT INTO `base_zip` VALUES ('3422', '652327', '', '', '吉木萨尔县', '3416');
INSERT INTO `base_zip` VALUES ('3423', '652328', '', '', '木垒哈萨克自治县', '3416');
INSERT INTO `base_zip` VALUES ('3424', '652700', '', '博尔塔拉蒙古自治州', '', '3391');
INSERT INTO `base_zip` VALUES ('3425', '652701', '', '', '博乐市', '3424');
INSERT INTO `base_zip` VALUES ('3426', '652702', '', '', '阿拉山口市', '3424');
INSERT INTO `base_zip` VALUES ('3427', '652722', '', '', '精河县', '3424');
INSERT INTO `base_zip` VALUES ('3428', '652723', '', '', '温泉县', '3424');
INSERT INTO `base_zip` VALUES ('3429', '652800', '', '巴音郭楞蒙古自治州', '', '3391');
INSERT INTO `base_zip` VALUES ('3430', '652801', '', '', '库尔勒市', '3429');
INSERT INTO `base_zip` VALUES ('3431', '652822', '', '', '轮台县', '3429');
INSERT INTO `base_zip` VALUES ('3432', '652823', '', '', '尉犁县', '3429');
INSERT INTO `base_zip` VALUES ('3433', '652824', '', '', '若羌县', '3429');
INSERT INTO `base_zip` VALUES ('3434', '652825', '', '', '且末县', '3429');
INSERT INTO `base_zip` VALUES ('3435', '652826', '', '', '焉耆回族自治县', '3429');
INSERT INTO `base_zip` VALUES ('3436', '652827', '', '', '和静县', '3429');
INSERT INTO `base_zip` VALUES ('3437', '652828', '', '', '和硕县', '3429');
INSERT INTO `base_zip` VALUES ('3438', '652829', '', '', '博湖县', '3429');
INSERT INTO `base_zip` VALUES ('3439', '652900', '', '阿克苏地区', '', '3391');
INSERT INTO `base_zip` VALUES ('3440', '652901', '', '', '阿克苏市', '3439');
INSERT INTO `base_zip` VALUES ('3441', '652922', '', '', '温宿县', '3439');
INSERT INTO `base_zip` VALUES ('3442', '652923', '', '', '库车县', '3439');
INSERT INTO `base_zip` VALUES ('3443', '652924', '', '', '沙雅县', '3439');
INSERT INTO `base_zip` VALUES ('3444', '652925', '', '', '新和县', '3439');
INSERT INTO `base_zip` VALUES ('3445', '652926', '', '', '拜城县', '3439');
INSERT INTO `base_zip` VALUES ('3446', '652927', '', '', '乌什县', '3439');
INSERT INTO `base_zip` VALUES ('3447', '652928', '', '', '阿瓦提县', '3439');
INSERT INTO `base_zip` VALUES ('3448', '652929', '', '', '柯坪县', '3439');
INSERT INTO `base_zip` VALUES ('3449', '653000', '', '克孜勒苏柯尔克孜自治州', '', '3391');
INSERT INTO `base_zip` VALUES ('3450', '653001', '', '', '阿图什市', '3449');
INSERT INTO `base_zip` VALUES ('3451', '653022', '', '', '阿克陶县', '3449');
INSERT INTO `base_zip` VALUES ('3452', '653023', '', '', '阿合奇县', '3449');
INSERT INTO `base_zip` VALUES ('3453', '653024', '', '', '乌恰县', '3449');
INSERT INTO `base_zip` VALUES ('3454', '653100', '', '喀什地区', '', '3391');
INSERT INTO `base_zip` VALUES ('3455', '653101', '', '', '喀什市', '3454');
INSERT INTO `base_zip` VALUES ('3456', '653121', '', '', '疏附县', '3454');
INSERT INTO `base_zip` VALUES ('3457', '653122', '', '', '疏勒县', '3454');
INSERT INTO `base_zip` VALUES ('3458', '653123', '', '', '英吉沙县', '3454');
INSERT INTO `base_zip` VALUES ('3459', '653124', '', '', '泽普县', '3454');
INSERT INTO `base_zip` VALUES ('3460', '653125', '', '', '莎车县', '3454');
INSERT INTO `base_zip` VALUES ('3461', '653126', '', '', '叶城县', '3454');
INSERT INTO `base_zip` VALUES ('3462', '653127', '', '', '麦盖提县', '3454');
INSERT INTO `base_zip` VALUES ('3463', '653128', '', '', '岳普湖县', '3454');
INSERT INTO `base_zip` VALUES ('3464', '653129', '', '', '伽师县', '3454');
INSERT INTO `base_zip` VALUES ('3465', '653130', '', '', '巴楚县', '3454');
INSERT INTO `base_zip` VALUES ('3466', '653131', '', '', '塔什库尔干塔吉克自治县', '3454');
INSERT INTO `base_zip` VALUES ('3467', '653200', '', '和田地区', '', '3391');
INSERT INTO `base_zip` VALUES ('3468', '653201', '', '', '和田市', '3467');
INSERT INTO `base_zip` VALUES ('3469', '653221', '', '', '和田县', '3467');
INSERT INTO `base_zip` VALUES ('3470', '653222', '', '', '墨玉县', '3467');
INSERT INTO `base_zip` VALUES ('3471', '653223', '', '', '皮山县', '3467');
INSERT INTO `base_zip` VALUES ('3472', '653224', '', '', '洛浦县', '3467');
INSERT INTO `base_zip` VALUES ('3473', '653225', '', '', '策勒县', '3467');
INSERT INTO `base_zip` VALUES ('3474', '653226', '', '', '于田县', '3467');
INSERT INTO `base_zip` VALUES ('3475', '653227', '', '', '民丰县', '3467');
INSERT INTO `base_zip` VALUES ('3476', '654000', '', '伊犁哈萨克自治州', '', '3391');
INSERT INTO `base_zip` VALUES ('3477', '654002', '', '', '伊宁市', '3476');
INSERT INTO `base_zip` VALUES ('3478', '654003', '', '', '奎屯市', '3476');
INSERT INTO `base_zip` VALUES ('3479', '654004', '', '', '霍尔果斯市', '3476');
INSERT INTO `base_zip` VALUES ('3480', '654021', '', '', '伊宁县', '3476');
INSERT INTO `base_zip` VALUES ('3481', '654022', '', '', '察布查尔锡伯自治县', '3476');
INSERT INTO `base_zip` VALUES ('3482', '654023', '', '', '霍城县', '3476');
INSERT INTO `base_zip` VALUES ('3483', '654024', '', '', '巩留县', '3476');
INSERT INTO `base_zip` VALUES ('3484', '654025', '', '', '新源县', '3476');
INSERT INTO `base_zip` VALUES ('3485', '654026', '', '', '昭苏县', '3476');
INSERT INTO `base_zip` VALUES ('3486', '654027', '', '', '特克斯县', '3476');
INSERT INTO `base_zip` VALUES ('3487', '654028', '', '', '尼勒克县', '3476');
INSERT INTO `base_zip` VALUES ('3488', '654200', '', '', '塔城地区', '3476');
INSERT INTO `base_zip` VALUES ('3489', '654201', '', '', '塔城市', '3476');
INSERT INTO `base_zip` VALUES ('3490', '654202', '', '', '乌苏市', '3476');
INSERT INTO `base_zip` VALUES ('3491', '654221', '', '', '额敏县', '3476');
INSERT INTO `base_zip` VALUES ('3492', '654223', '', '', '沙湾县', '3476');
INSERT INTO `base_zip` VALUES ('3493', '654224', '', '', '托里县', '3476');
INSERT INTO `base_zip` VALUES ('3494', '654225', '', '', '裕民县', '3476');
INSERT INTO `base_zip` VALUES ('3495', '654226', '', '', '和布克赛尔蒙古自治县', '3476');
INSERT INTO `base_zip` VALUES ('3496', '654300', '', '', '阿勒泰地区', '3476');
INSERT INTO `base_zip` VALUES ('3497', '654301', '', '', '阿勒泰市', '3476');
INSERT INTO `base_zip` VALUES ('3498', '654321', '', '', '布尔津县', '3476');
INSERT INTO `base_zip` VALUES ('3499', '654322', '', '', '富蕴县', '3476');
INSERT INTO `base_zip` VALUES ('3500', '654323', '', '', '福海县', '3476');
INSERT INTO `base_zip` VALUES ('3501', '654324', '', '', '哈巴河县', '3476');
INSERT INTO `base_zip` VALUES ('3502', '654325', '', '', '青河县', '3476');
INSERT INTO `base_zip` VALUES ('3503', '654326', '', '', '吉木乃县', '3476');
INSERT INTO `base_zip` VALUES ('3504', '659000', '', '自治区直辖县级行政区划', '', '3391');
INSERT INTO `base_zip` VALUES ('3505', '659001', '', '', '石河子市', '3504');
INSERT INTO `base_zip` VALUES ('3506', '659002', '', '', '阿拉尔市', '3504');
INSERT INTO `base_zip` VALUES ('3507', '659003', '', '', '图木舒克市', '3504');
INSERT INTO `base_zip` VALUES ('3508', '659004', '', '', '五家渠市', '3504');
INSERT INTO `base_zip` VALUES ('3509', '659005', '', '', '北屯市', '3504');
INSERT INTO `base_zip` VALUES ('3510', '659006', '', '', '铁门关市', '3504');
INSERT INTO `base_zip` VALUES ('3511', '659007', '', '', '双河市', '3504');
INSERT INTO `base_zip` VALUES ('3512', '710000', '台湾省', '', '', '1');
INSERT INTO `base_zip` VALUES ('3513', '710100', '', '台北市', '', '3512');
INSERT INTO `base_zip` VALUES ('3514', '710101', '', '', '松山区', '3513');
INSERT INTO `base_zip` VALUES ('3515', '710102', '', '', '信义区', '3513');
INSERT INTO `base_zip` VALUES ('3516', '710103', '', '', '大安区', '3513');
INSERT INTO `base_zip` VALUES ('3517', '710104', '', '', '中山区', '3513');
INSERT INTO `base_zip` VALUES ('3518', '710105', '', '', '中正区', '3513');
INSERT INTO `base_zip` VALUES ('3519', '710106', '', '', '大同区', '3513');
INSERT INTO `base_zip` VALUES ('3520', '710107', '', '', '万华区', '3513');
INSERT INTO `base_zip` VALUES ('3521', '710108', '', '', '文山区', '3513');
INSERT INTO `base_zip` VALUES ('3522', '710109', '', '', '南港区', '3513');
INSERT INTO `base_zip` VALUES ('3523', '710110', '', '', '内湖区', '3513');
INSERT INTO `base_zip` VALUES ('3524', '710111', '', '', '士林区', '3513');
INSERT INTO `base_zip` VALUES ('3525', '710112', '', '', '北投区', '3513');
INSERT INTO `base_zip` VALUES ('3526', '710200', '', '高雄市', '', '3512');
INSERT INTO `base_zip` VALUES ('3527', '710201', '', '', '盐埕区', '3526');
INSERT INTO `base_zip` VALUES ('3528', '710202', '', '', '鼓山区', '3526');
INSERT INTO `base_zip` VALUES ('3529', '710203', '', '', '左营区', '3526');
INSERT INTO `base_zip` VALUES ('3530', '710204', '', '', '楠梓区', '3526');
INSERT INTO `base_zip` VALUES ('3531', '710205', '', '', '三民区', '3526');
INSERT INTO `base_zip` VALUES ('3532', '710206', '', '', '新兴区', '3526');
INSERT INTO `base_zip` VALUES ('3533', '710207', '', '', '前金区', '3526');
INSERT INTO `base_zip` VALUES ('3534', '710208', '', '', '苓雅区', '3526');
INSERT INTO `base_zip` VALUES ('3535', '710209', '', '', '前镇区', '3526');
INSERT INTO `base_zip` VALUES ('3536', '710210', '', '', '旗津区', '3526');
INSERT INTO `base_zip` VALUES ('3537', '710211', '', '', '小港区', '3526');
INSERT INTO `base_zip` VALUES ('3538', '710212', '', '', '凤山区', '3526');
INSERT INTO `base_zip` VALUES ('3539', '710213', '', '', '林园区', '3526');
INSERT INTO `base_zip` VALUES ('3540', '710214', '', '', '大寮区', '3526');
INSERT INTO `base_zip` VALUES ('3541', '710215', '', '', '大树区', '3526');
INSERT INTO `base_zip` VALUES ('3542', '710216', '', '', '大社区', '3526');
INSERT INTO `base_zip` VALUES ('3543', '710217', '', '', '仁武区', '3526');
INSERT INTO `base_zip` VALUES ('3544', '710218', '', '', '鸟松区', '3526');
INSERT INTO `base_zip` VALUES ('3545', '710219', '', '', '冈山区', '3526');
INSERT INTO `base_zip` VALUES ('3546', '710220', '', '', '桥头区', '3526');
INSERT INTO `base_zip` VALUES ('3547', '710221', '', '', '燕巢区', '3526');
INSERT INTO `base_zip` VALUES ('3548', '710222', '', '', '田寮区', '3526');
INSERT INTO `base_zip` VALUES ('3549', '710223', '', '', '阿莲区', '3526');
INSERT INTO `base_zip` VALUES ('3550', '710224', '', '', '路竹区', '3526');
INSERT INTO `base_zip` VALUES ('3551', '710225', '', '', '湖内区', '3526');
INSERT INTO `base_zip` VALUES ('3552', '710226', '', '', '茄萣区', '3526');
INSERT INTO `base_zip` VALUES ('3553', '710227', '', '', '永安区', '3526');
INSERT INTO `base_zip` VALUES ('3554', '710228', '', '', '弥陀区', '3526');
INSERT INTO `base_zip` VALUES ('3555', '710229', '', '', '梓官区', '3526');
INSERT INTO `base_zip` VALUES ('3556', '710230', '', '', '旗山区', '3526');
INSERT INTO `base_zip` VALUES ('3557', '710231', '', '', '美浓区', '3526');
INSERT INTO `base_zip` VALUES ('3558', '710232', '', '', '六龟区', '3526');
INSERT INTO `base_zip` VALUES ('3559', '710233', '', '', '甲仙区', '3526');
INSERT INTO `base_zip` VALUES ('3560', '710234', '', '', '杉林区', '3526');
INSERT INTO `base_zip` VALUES ('3561', '710235', '', '', '内门区', '3526');
INSERT INTO `base_zip` VALUES ('3562', '710236', '', '', '茂林区', '3526');
INSERT INTO `base_zip` VALUES ('3563', '710237', '', '', '桃源区', '3526');
INSERT INTO `base_zip` VALUES ('3564', '710238', '', '', '那玛夏区', '3526');
INSERT INTO `base_zip` VALUES ('3565', '710300', '', '基隆市', '', '3512');
INSERT INTO `base_zip` VALUES ('3566', '710301', '', '', '中正区', '3565');
INSERT INTO `base_zip` VALUES ('3567', '710302', '', '', '七堵区', '3565');
INSERT INTO `base_zip` VALUES ('3568', '710303', '', '', '暖暖区', '3565');
INSERT INTO `base_zip` VALUES ('3569', '710304', '', '', '仁爱区', '3565');
INSERT INTO `base_zip` VALUES ('3570', '710305', '', '', '中山区', '3565');
INSERT INTO `base_zip` VALUES ('3571', '710306', '', '', '安乐区', '3565');
INSERT INTO `base_zip` VALUES ('3572', '710307', '', '', '信义区', '3565');
INSERT INTO `base_zip` VALUES ('3573', '710400', '', '台中市', '', '3512');
INSERT INTO `base_zip` VALUES ('3574', '710401', '', '', '中区', '3573');
INSERT INTO `base_zip` VALUES ('3575', '710402', '', '', '东区', '3573');
INSERT INTO `base_zip` VALUES ('3576', '710403', '', '', '南区', '3573');
INSERT INTO `base_zip` VALUES ('3577', '710404', '', '', '西区', '3573');
INSERT INTO `base_zip` VALUES ('3578', '710405', '', '', '北区', '3573');
INSERT INTO `base_zip` VALUES ('3579', '710406', '', '', '西屯区', '3573');
INSERT INTO `base_zip` VALUES ('3580', '710407', '', '', '南屯区', '3573');
INSERT INTO `base_zip` VALUES ('3581', '710408', '', '', '北屯区', '3573');
INSERT INTO `base_zip` VALUES ('3582', '710409', '', '', '丰原区', '3573');
INSERT INTO `base_zip` VALUES ('3583', '710410', '', '', '东势区', '3573');
INSERT INTO `base_zip` VALUES ('3584', '710411', '', '', '大甲区', '3573');
INSERT INTO `base_zip` VALUES ('3585', '710412', '', '', '清水区', '3573');
INSERT INTO `base_zip` VALUES ('3586', '710413', '', '', '沙鹿区', '3573');
INSERT INTO `base_zip` VALUES ('3587', '710414', '', '', '梧栖区', '3573');
INSERT INTO `base_zip` VALUES ('3588', '710415', '', '', '后里区', '3573');
INSERT INTO `base_zip` VALUES ('3589', '710416', '', '', '神冈区', '3573');
INSERT INTO `base_zip` VALUES ('3590', '710417', '', '', '潭子区', '3573');
INSERT INTO `base_zip` VALUES ('3591', '710418', '', '', '大雅区', '3573');
INSERT INTO `base_zip` VALUES ('3592', '710419', '', '', '新社区', '3573');
INSERT INTO `base_zip` VALUES ('3593', '710420', '', '', '石冈区', '3573');
INSERT INTO `base_zip` VALUES ('3594', '710421', '', '', '外埔区', '3573');
INSERT INTO `base_zip` VALUES ('3595', '710422', '', '', '大安区', '3573');
INSERT INTO `base_zip` VALUES ('3596', '710423', '', '', '乌日区', '3573');
INSERT INTO `base_zip` VALUES ('3597', '710424', '', '', '大肚区', '3573');
INSERT INTO `base_zip` VALUES ('3598', '710425', '', '', '龙井区', '3573');
INSERT INTO `base_zip` VALUES ('3599', '710426', '', '', '雾峰区', '3573');
INSERT INTO `base_zip` VALUES ('3600', '710427', '', '', '太平区', '3573');
INSERT INTO `base_zip` VALUES ('3601', '710428', '', '', '大里区', '3573');
INSERT INTO `base_zip` VALUES ('3602', '710429', '', '', '和平区', '3573');
INSERT INTO `base_zip` VALUES ('3603', '710500', '', '台南市', '', '3512');
INSERT INTO `base_zip` VALUES ('3604', '710501', '', '', '东区', '3603');
INSERT INTO `base_zip` VALUES ('3605', '710502', '', '', '南区', '3603');
INSERT INTO `base_zip` VALUES ('3606', '710504', '', '', '北区', '3603');
INSERT INTO `base_zip` VALUES ('3607', '710506', '', '', '安南区', '3603');
INSERT INTO `base_zip` VALUES ('3608', '710507', '', '', '安平区', '3603');
INSERT INTO `base_zip` VALUES ('3609', '710508', '', '', '中西区', '3603');
INSERT INTO `base_zip` VALUES ('3610', '710509', '', '', '新营区', '3603');
INSERT INTO `base_zip` VALUES ('3611', '710510', '', '', '盐水区', '3603');
INSERT INTO `base_zip` VALUES ('3612', '710511', '', '', '白河区', '3603');
INSERT INTO `base_zip` VALUES ('3613', '710512', '', '', '柳营区', '3603');
INSERT INTO `base_zip` VALUES ('3614', '710513', '', '', '后壁区', '3603');
INSERT INTO `base_zip` VALUES ('3615', '710514', '', '', '东山区', '3603');
INSERT INTO `base_zip` VALUES ('3616', '710515', '', '', '麻豆区', '3603');
INSERT INTO `base_zip` VALUES ('3617', '710516', '', '', '下营区', '3603');
INSERT INTO `base_zip` VALUES ('3618', '710517', '', '', '六甲区', '3603');
INSERT INTO `base_zip` VALUES ('3619', '710518', '', '', '官田区', '3603');
INSERT INTO `base_zip` VALUES ('3620', '710519', '', '', '大内区', '3603');
INSERT INTO `base_zip` VALUES ('3621', '710520', '', '', '佳里区', '3603');
INSERT INTO `base_zip` VALUES ('3622', '710521', '', '', '学甲区', '3603');
INSERT INTO `base_zip` VALUES ('3623', '710522', '', '', '西港区', '3603');
INSERT INTO `base_zip` VALUES ('3624', '710523', '', '', '七股区', '3603');
INSERT INTO `base_zip` VALUES ('3625', '710524', '', '', '将军区', '3603');
INSERT INTO `base_zip` VALUES ('3626', '710525', '', '', '北门区', '3603');
INSERT INTO `base_zip` VALUES ('3627', '710526', '', '', '新化区', '3603');
INSERT INTO `base_zip` VALUES ('3628', '710527', '', '', '善化区', '3603');
INSERT INTO `base_zip` VALUES ('3629', '710528', '', '', '新市区', '3603');
INSERT INTO `base_zip` VALUES ('3630', '710529', '', '', '安定区', '3603');
INSERT INTO `base_zip` VALUES ('3631', '710530', '', '', '山上区', '3603');
INSERT INTO `base_zip` VALUES ('3632', '710531', '', '', '玉井区', '3603');
INSERT INTO `base_zip` VALUES ('3633', '710532', '', '', '楠西区', '3603');
INSERT INTO `base_zip` VALUES ('3634', '710533', '', '', '南化区', '3603');
INSERT INTO `base_zip` VALUES ('3635', '710534', '', '', '左镇区', '3603');
INSERT INTO `base_zip` VALUES ('3636', '710535', '', '', '仁德区', '3603');
INSERT INTO `base_zip` VALUES ('3637', '710536', '', '', '归仁区', '3603');
INSERT INTO `base_zip` VALUES ('3638', '710537', '', '', '关庙区', '3603');
INSERT INTO `base_zip` VALUES ('3639', '710538', '', '', '龙崎区', '3603');
INSERT INTO `base_zip` VALUES ('3640', '710539', '', '', '永康区', '3603');
INSERT INTO `base_zip` VALUES ('3641', '710600', '', '新竹市', '', '3512');
INSERT INTO `base_zip` VALUES ('3642', '710601', '', '', '东区', '3641');
INSERT INTO `base_zip` VALUES ('3643', '710602', '', '', '北区', '3641');
INSERT INTO `base_zip` VALUES ('3644', '710603', '', '', '香山区', '3641');
INSERT INTO `base_zip` VALUES ('3645', '710700', '', '嘉义市', '', '3512');
INSERT INTO `base_zip` VALUES ('3646', '710701', '', '', '东区', '3645');
INSERT INTO `base_zip` VALUES ('3647', '710702', '', '', '西区', '3645');
INSERT INTO `base_zip` VALUES ('3648', '710800', '', '新北市', '', '3512');
INSERT INTO `base_zip` VALUES ('3649', '710801', '', '', '板桥区', '3648');
INSERT INTO `base_zip` VALUES ('3650', '710802', '', '', '三重区', '3648');
INSERT INTO `base_zip` VALUES ('3651', '710803', '', '', '中和区', '3648');
INSERT INTO `base_zip` VALUES ('3652', '710804', '', '', '永和区', '3648');
INSERT INTO `base_zip` VALUES ('3653', '710805', '', '', '新庄区', '3648');
INSERT INTO `base_zip` VALUES ('3654', '710806', '', '', '新店区', '3648');
INSERT INTO `base_zip` VALUES ('3655', '710807', '', '', '树林区', '3648');
INSERT INTO `base_zip` VALUES ('3656', '710808', '', '', '莺歌区', '3648');
INSERT INTO `base_zip` VALUES ('3657', '710809', '', '', '三峡区', '3648');
INSERT INTO `base_zip` VALUES ('3658', '710810', '', '', '淡水区', '3648');
INSERT INTO `base_zip` VALUES ('3659', '710811', '', '', '汐止区', '3648');
INSERT INTO `base_zip` VALUES ('3660', '710812', '', '', '瑞芳区', '3648');
INSERT INTO `base_zip` VALUES ('3661', '710813', '', '', '土城区', '3648');
INSERT INTO `base_zip` VALUES ('3662', '710814', '', '', '芦洲区', '3648');
INSERT INTO `base_zip` VALUES ('3663', '710815', '', '', '五股区', '3648');
INSERT INTO `base_zip` VALUES ('3664', '710816', '', '', '泰山区', '3648');
INSERT INTO `base_zip` VALUES ('3665', '710817', '', '', '林口区', '3648');
INSERT INTO `base_zip` VALUES ('3666', '710818', '', '', '深坑区', '3648');
INSERT INTO `base_zip` VALUES ('3667', '710819', '', '', '石碇区', '3648');
INSERT INTO `base_zip` VALUES ('3668', '710820', '', '', '坪林区', '3648');
INSERT INTO `base_zip` VALUES ('3669', '710821', '', '', '三芝区', '3648');
INSERT INTO `base_zip` VALUES ('3670', '710822', '', '', '石门区', '3648');
INSERT INTO `base_zip` VALUES ('3671', '710823', '', '', '八里区', '3648');
INSERT INTO `base_zip` VALUES ('3672', '710824', '', '', '平溪区', '3648');
INSERT INTO `base_zip` VALUES ('3673', '710825', '', '', '双溪区', '3648');
INSERT INTO `base_zip` VALUES ('3674', '710826', '', '', '贡寮区', '3648');
INSERT INTO `base_zip` VALUES ('3675', '710827', '', '', '金山区', '3648');
INSERT INTO `base_zip` VALUES ('3676', '710828', '', '', '万里区', '3648');
INSERT INTO `base_zip` VALUES ('3677', '710829', '', '', '乌来区', '3648');
INSERT INTO `base_zip` VALUES ('3678', '712200', '', '宜兰县', '', '3512');
INSERT INTO `base_zip` VALUES ('3679', '712201', '', '', '宜兰市', '3678');
INSERT INTO `base_zip` VALUES ('3680', '712221', '', '', '罗东镇', '3678');
INSERT INTO `base_zip` VALUES ('3681', '712222', '', '', '苏澳镇', '3678');
INSERT INTO `base_zip` VALUES ('3682', '712223', '', '', '头城镇', '3678');
INSERT INTO `base_zip` VALUES ('3683', '712224', '', '', '礁溪乡', '3678');
INSERT INTO `base_zip` VALUES ('3684', '712225', '', '', '壮围乡', '3678');
INSERT INTO `base_zip` VALUES ('3685', '712226', '', '', '员山乡', '3678');
INSERT INTO `base_zip` VALUES ('3686', '712227', '', '', '冬山乡', '3678');
INSERT INTO `base_zip` VALUES ('3687', '712228', '', '', '五结乡', '3678');
INSERT INTO `base_zip` VALUES ('3688', '712229', '', '', '三星乡', '3678');
INSERT INTO `base_zip` VALUES ('3689', '712230', '', '', '大同乡', '3678');
INSERT INTO `base_zip` VALUES ('3690', '712231', '', '', '南澳乡', '3678');
INSERT INTO `base_zip` VALUES ('3691', '712300', '', '桃园县', '', '3512');
INSERT INTO `base_zip` VALUES ('3692', '712301', '', '', '桃园市', '3691');
INSERT INTO `base_zip` VALUES ('3693', '712302', '', '', '中坜市', '3691');
INSERT INTO `base_zip` VALUES ('3694', '712303', '', '', '平镇市', '3691');
INSERT INTO `base_zip` VALUES ('3695', '712304', '', '', '八德市', '3691');
INSERT INTO `base_zip` VALUES ('3696', '712305', '', '', '杨梅市', '3691');
INSERT INTO `base_zip` VALUES ('3697', '712321', '', '', '大溪镇', '3691');
INSERT INTO `base_zip` VALUES ('3698', '712323', '', '', '芦竹乡', '3691');
INSERT INTO `base_zip` VALUES ('3699', '712324', '', '', '大园乡', '3691');
INSERT INTO `base_zip` VALUES ('3700', '712325', '', '', '龟山乡', '3691');
INSERT INTO `base_zip` VALUES ('3701', '712327', '', '', '龙潭乡', '3691');
INSERT INTO `base_zip` VALUES ('3702', '712329', '', '', '新屋乡', '3691');
INSERT INTO `base_zip` VALUES ('3703', '712330', '', '', '观音乡', '3691');
INSERT INTO `base_zip` VALUES ('3704', '712331', '', '', '复兴乡', '3691');
INSERT INTO `base_zip` VALUES ('3705', '712400', '', '新竹县', '', '3512');
INSERT INTO `base_zip` VALUES ('3706', '712401', '', '', '竹北市', '3705');
INSERT INTO `base_zip` VALUES ('3707', '712421', '', '', '竹东镇', '3705');
INSERT INTO `base_zip` VALUES ('3708', '712422', '', '', '新埔镇', '3705');
INSERT INTO `base_zip` VALUES ('3709', '712423', '', '', '关西镇', '3705');
INSERT INTO `base_zip` VALUES ('3710', '712424', '', '', '湖口乡', '3705');
INSERT INTO `base_zip` VALUES ('3711', '712425', '', '', '新丰乡', '3705');
INSERT INTO `base_zip` VALUES ('3712', '712426', '', '', '芎林乡', '3705');
INSERT INTO `base_zip` VALUES ('3713', '712427', '', '', '橫山乡', '3705');
INSERT INTO `base_zip` VALUES ('3714', '712428', '', '', '北埔乡', '3705');
INSERT INTO `base_zip` VALUES ('3715', '712429', '', '', '宝山乡', '3705');
INSERT INTO `base_zip` VALUES ('3716', '712430', '', '', '峨眉乡', '3705');
INSERT INTO `base_zip` VALUES ('3717', '712431', '', '', '尖石乡', '3705');
INSERT INTO `base_zip` VALUES ('3718', '712432', '', '', '五峰乡', '3705');
INSERT INTO `base_zip` VALUES ('3719', '712500', '', '苗栗县', '', '3512');
INSERT INTO `base_zip` VALUES ('3720', '712501', '', '', '苗栗市', '3719');
INSERT INTO `base_zip` VALUES ('3721', '712521', '', '', '苑里镇', '3719');
INSERT INTO `base_zip` VALUES ('3722', '712522', '', '', '通霄镇', '3719');
INSERT INTO `base_zip` VALUES ('3723', '712523', '', '', '竹南镇', '3719');
INSERT INTO `base_zip` VALUES ('3724', '712524', '', '', '头份镇', '3719');
INSERT INTO `base_zip` VALUES ('3725', '712525', '', '', '后龙镇', '3719');
INSERT INTO `base_zip` VALUES ('3726', '712526', '', '', '卓兰镇', '3719');
INSERT INTO `base_zip` VALUES ('3727', '712527', '', '', '大湖乡', '3719');
INSERT INTO `base_zip` VALUES ('3728', '712528', '', '', '公馆乡', '3719');
INSERT INTO `base_zip` VALUES ('3729', '712529', '', '', '铜锣乡', '3719');
INSERT INTO `base_zip` VALUES ('3730', '712530', '', '', '南庄乡', '3719');
INSERT INTO `base_zip` VALUES ('3731', '712531', '', '', '头屋乡', '3719');
INSERT INTO `base_zip` VALUES ('3732', '712532', '', '', '三义乡', '3719');
INSERT INTO `base_zip` VALUES ('3733', '712533', '', '', '西湖乡', '3719');
INSERT INTO `base_zip` VALUES ('3734', '712534', '', '', '造桥乡', '3719');
INSERT INTO `base_zip` VALUES ('3735', '712535', '', '', '三湾乡', '3719');
INSERT INTO `base_zip` VALUES ('3736', '712536', '', '', '狮潭乡', '3719');
INSERT INTO `base_zip` VALUES ('3737', '712537', '', '', '泰安乡', '3719');
INSERT INTO `base_zip` VALUES ('3738', '712700', '', '彰化县', '', '3512');
INSERT INTO `base_zip` VALUES ('3739', '712701', '', '', '彰化市', '3738');
INSERT INTO `base_zip` VALUES ('3740', '712721', '', '', '鹿港镇', '3738');
INSERT INTO `base_zip` VALUES ('3741', '712722', '', '', '和美镇', '3738');
INSERT INTO `base_zip` VALUES ('3742', '712723', '', '', '线西乡', '3738');
INSERT INTO `base_zip` VALUES ('3743', '712724', '', '', '伸港乡', '3738');
INSERT INTO `base_zip` VALUES ('3744', '712725', '', '', '福兴乡', '3738');
INSERT INTO `base_zip` VALUES ('3745', '712726', '', '', '秀水乡', '3738');
INSERT INTO `base_zip` VALUES ('3746', '712727', '', '', '花坛乡', '3738');
INSERT INTO `base_zip` VALUES ('3747', '712728', '', '', '芬园乡', '3738');
INSERT INTO `base_zip` VALUES ('3748', '712729', '', '', '员林镇', '3738');
INSERT INTO `base_zip` VALUES ('3749', '712730', '', '', '溪湖镇', '3738');
INSERT INTO `base_zip` VALUES ('3750', '712731', '', '', '田中镇', '3738');
INSERT INTO `base_zip` VALUES ('3751', '712732', '', '', '大村乡', '3738');
INSERT INTO `base_zip` VALUES ('3752', '712733', '', '', '埔盐乡', '3738');
INSERT INTO `base_zip` VALUES ('3753', '712734', '', '', '埔心乡', '3738');
INSERT INTO `base_zip` VALUES ('3754', '712735', '', '', '永靖乡', '3738');
INSERT INTO `base_zip` VALUES ('3755', '712736', '', '', '社头乡', '3738');
INSERT INTO `base_zip` VALUES ('3756', '712737', '', '', '二水乡', '3738');
INSERT INTO `base_zip` VALUES ('3757', '712738', '', '', '北斗镇', '3738');
INSERT INTO `base_zip` VALUES ('3758', '712739', '', '', '二林镇', '3738');
INSERT INTO `base_zip` VALUES ('3759', '712740', '', '', '田尾乡', '3738');
INSERT INTO `base_zip` VALUES ('3760', '712741', '', '', '埤头乡', '3738');
INSERT INTO `base_zip` VALUES ('3761', '712742', '', '', '芳苑乡', '3738');
INSERT INTO `base_zip` VALUES ('3762', '712743', '', '', '大城乡', '3738');
INSERT INTO `base_zip` VALUES ('3763', '712744', '', '', '竹塘乡', '3738');
INSERT INTO `base_zip` VALUES ('3764', '712745', '', '', '溪州乡', '3738');
INSERT INTO `base_zip` VALUES ('3765', '712800', '', '南投县', '', '3512');
INSERT INTO `base_zip` VALUES ('3766', '712801', '', '', '南投市', '3765');
INSERT INTO `base_zip` VALUES ('3767', '712821', '', '', '埔里镇', '3765');
INSERT INTO `base_zip` VALUES ('3768', '712822', '', '', '草屯镇', '3765');
INSERT INTO `base_zip` VALUES ('3769', '712823', '', '', '竹山镇', '3765');
INSERT INTO `base_zip` VALUES ('3770', '712824', '', '', '集集镇', '3765');
INSERT INTO `base_zip` VALUES ('3771', '712825', '', '', '名间乡', '3765');
INSERT INTO `base_zip` VALUES ('3772', '712826', '', '', '鹿谷乡', '3765');
INSERT INTO `base_zip` VALUES ('3773', '712827', '', '', '中寮乡', '3765');
INSERT INTO `base_zip` VALUES ('3774', '712828', '', '', '鱼池乡', '3765');
INSERT INTO `base_zip` VALUES ('3775', '712829', '', '', '国姓乡', '3765');
INSERT INTO `base_zip` VALUES ('3776', '712830', '', '', '水里乡', '3765');
INSERT INTO `base_zip` VALUES ('3777', '712831', '', '', '信义乡', '3765');
INSERT INTO `base_zip` VALUES ('3778', '712832', '', '', '仁爱乡', '3765');
INSERT INTO `base_zip` VALUES ('3779', '712900', '', '云林县', '', '3512');
INSERT INTO `base_zip` VALUES ('3780', '712901', '', '', '斗六市', '3779');
INSERT INTO `base_zip` VALUES ('3781', '712921', '', '', '斗南镇', '3779');
INSERT INTO `base_zip` VALUES ('3782', '712922', '', '', '虎尾镇', '3779');
INSERT INTO `base_zip` VALUES ('3783', '712923', '', '', '西螺镇', '3779');
INSERT INTO `base_zip` VALUES ('3784', '712924', '', '', '土库镇', '3779');
INSERT INTO `base_zip` VALUES ('3785', '712925', '', '', '北港镇', '3779');
INSERT INTO `base_zip` VALUES ('3786', '712926', '', '', '古坑乡', '3779');
INSERT INTO `base_zip` VALUES ('3787', '712927', '', '', '大埤乡', '3779');
INSERT INTO `base_zip` VALUES ('3788', '712928', '', '', '莿桐乡', '3779');
INSERT INTO `base_zip` VALUES ('3789', '712929', '', '', '林内乡', '3779');
INSERT INTO `base_zip` VALUES ('3790', '712930', '', '', '二仑乡', '3779');
INSERT INTO `base_zip` VALUES ('3791', '712931', '', '', '仑背乡', '3779');
INSERT INTO `base_zip` VALUES ('3792', '712932', '', '', '麦寮乡', '3779');
INSERT INTO `base_zip` VALUES ('3793', '712933', '', '', '东势乡', '3779');
INSERT INTO `base_zip` VALUES ('3794', '712934', '', '', '褒忠乡', '3779');
INSERT INTO `base_zip` VALUES ('3795', '712935', '', '', '台西乡', '3779');
INSERT INTO `base_zip` VALUES ('3796', '712936', '', '', '元长乡', '3779');
INSERT INTO `base_zip` VALUES ('3797', '712937', '', '', '四湖乡', '3779');
INSERT INTO `base_zip` VALUES ('3798', '712938', '', '', '口湖乡', '3779');
INSERT INTO `base_zip` VALUES ('3799', '712939', '', '', '水林乡', '3779');
INSERT INTO `base_zip` VALUES ('3800', '713000', '', '嘉义县', '', '3512');
INSERT INTO `base_zip` VALUES ('3801', '713001', '', '', '太保市', '3800');
INSERT INTO `base_zip` VALUES ('3802', '713002', '', '', '朴子市', '3800');
INSERT INTO `base_zip` VALUES ('3803', '713023', '', '', '布袋镇', '3800');
INSERT INTO `base_zip` VALUES ('3804', '713024', '', '', '大林镇', '3800');
INSERT INTO `base_zip` VALUES ('3805', '713025', '', '', '民雄乡', '3800');
INSERT INTO `base_zip` VALUES ('3806', '713026', '', '', '溪口乡', '3800');
INSERT INTO `base_zip` VALUES ('3807', '713027', '', '', '新港乡', '3800');
INSERT INTO `base_zip` VALUES ('3808', '713028', '', '', '六脚乡', '3800');
INSERT INTO `base_zip` VALUES ('3809', '713029', '', '', '东石乡', '3800');
INSERT INTO `base_zip` VALUES ('3810', '713030', '', '', '义竹乡', '3800');
INSERT INTO `base_zip` VALUES ('3811', '713031', '', '', '鹿草乡', '3800');
INSERT INTO `base_zip` VALUES ('3812', '713032', '', '', '水上乡', '3800');
INSERT INTO `base_zip` VALUES ('3813', '713033', '', '', '中埔乡', '3800');
INSERT INTO `base_zip` VALUES ('3814', '713034', '', '', '竹崎乡', '3800');
INSERT INTO `base_zip` VALUES ('3815', '713035', '', '', '梅山乡', '3800');
INSERT INTO `base_zip` VALUES ('3816', '713036', '', '', '番路乡', '3800');
INSERT INTO `base_zip` VALUES ('3817', '713037', '', '', '大埔乡', '3800');
INSERT INTO `base_zip` VALUES ('3818', '713038', '', '', '阿里山乡', '3800');
INSERT INTO `base_zip` VALUES ('3819', '713300', '', '屏东县', '', '3512');
INSERT INTO `base_zip` VALUES ('3820', '713301', '', '', '屏东市', '3819');
INSERT INTO `base_zip` VALUES ('3821', '713321', '', '', '潮州镇', '3819');
INSERT INTO `base_zip` VALUES ('3822', '713322', '', '', '东港镇', '3819');
INSERT INTO `base_zip` VALUES ('3823', '713323', '', '', '恒春镇', '3819');
INSERT INTO `base_zip` VALUES ('3824', '713324', '', '', '万丹乡', '3819');
INSERT INTO `base_zip` VALUES ('3825', '713325', '', '', '长治乡', '3819');
INSERT INTO `base_zip` VALUES ('3826', '713326', '', '', '麟洛乡', '3819');
INSERT INTO `base_zip` VALUES ('3827', '713327', '', '', '九如乡', '3819');
INSERT INTO `base_zip` VALUES ('3828', '713328', '', '', '里港乡', '3819');
INSERT INTO `base_zip` VALUES ('3829', '713329', '', '', '盐埔乡', '3819');
INSERT INTO `base_zip` VALUES ('3830', '713330', '', '', '高树乡', '3819');
INSERT INTO `base_zip` VALUES ('3831', '713331', '', '', '万峦乡', '3819');
INSERT INTO `base_zip` VALUES ('3832', '713332', '', '', '内埔乡', '3819');
INSERT INTO `base_zip` VALUES ('3833', '713333', '', '', '竹田乡', '3819');
INSERT INTO `base_zip` VALUES ('3834', '713334', '', '', '新埤乡', '3819');
INSERT INTO `base_zip` VALUES ('3835', '713335', '', '', '枋寮乡', '3819');
INSERT INTO `base_zip` VALUES ('3836', '713336', '', '', '新园乡', '3819');
INSERT INTO `base_zip` VALUES ('3837', '713337', '', '', '崁顶乡', '3819');
INSERT INTO `base_zip` VALUES ('3838', '713338', '', '', '林边乡', '3819');
INSERT INTO `base_zip` VALUES ('3839', '713339', '', '', '南州乡', '3819');
INSERT INTO `base_zip` VALUES ('3840', '713340', '', '', '佳冬乡', '3819');
INSERT INTO `base_zip` VALUES ('3841', '713341', '', '', '琉球乡', '3819');
INSERT INTO `base_zip` VALUES ('3842', '713342', '', '', '车城乡', '3819');
INSERT INTO `base_zip` VALUES ('3843', '713343', '', '', '满州乡', '3819');
INSERT INTO `base_zip` VALUES ('3844', '713344', '', '', '枋山乡', '3819');
INSERT INTO `base_zip` VALUES ('3845', '713345', '', '', '三地门乡', '3819');
INSERT INTO `base_zip` VALUES ('3846', '713346', '', '', '雾台乡', '3819');
INSERT INTO `base_zip` VALUES ('3847', '713347', '', '', '玛家乡', '3819');
INSERT INTO `base_zip` VALUES ('3848', '713348', '', '', '泰武乡', '3819');
INSERT INTO `base_zip` VALUES ('3849', '713349', '', '', '来义乡', '3819');
INSERT INTO `base_zip` VALUES ('3850', '713350', '', '', '春日乡', '3819');
INSERT INTO `base_zip` VALUES ('3851', '713351', '', '', '狮子乡', '3819');
INSERT INTO `base_zip` VALUES ('3852', '713352', '', '', '牡丹乡', '3819');
INSERT INTO `base_zip` VALUES ('3853', '713400', '', '台东县', '', '3512');
INSERT INTO `base_zip` VALUES ('3854', '713401', '', '', '台东市', '3853');
INSERT INTO `base_zip` VALUES ('3855', '713421', '', '', '成功镇', '3853');
INSERT INTO `base_zip` VALUES ('3856', '713422', '', '', '关山镇', '3853');
INSERT INTO `base_zip` VALUES ('3857', '713423', '', '', '卑南乡', '3853');
INSERT INTO `base_zip` VALUES ('3858', '713424', '', '', '鹿野乡', '3853');
INSERT INTO `base_zip` VALUES ('3859', '713425', '', '', '池上乡', '3853');
INSERT INTO `base_zip` VALUES ('3860', '713426', '', '', '东河乡', '3853');
INSERT INTO `base_zip` VALUES ('3861', '713427', '', '', '长滨乡', '3853');
INSERT INTO `base_zip` VALUES ('3862', '713428', '', '', '太麻里乡', '3853');
INSERT INTO `base_zip` VALUES ('3863', '713429', '', '', '大武乡', '3853');
INSERT INTO `base_zip` VALUES ('3864', '713430', '', '', '绿岛乡', '3853');
INSERT INTO `base_zip` VALUES ('3865', '713431', '', '', '海端乡', '3853');
INSERT INTO `base_zip` VALUES ('3866', '713432', '', '', '延平乡', '3853');
INSERT INTO `base_zip` VALUES ('3867', '713433', '', '', '金峰乡', '3853');
INSERT INTO `base_zip` VALUES ('3868', '713434', '', '', '达仁乡', '3853');
INSERT INTO `base_zip` VALUES ('3869', '713435', '', '', '兰屿乡', '3853');
INSERT INTO `base_zip` VALUES ('3870', '713500', '', '花莲县', '', '3512');
INSERT INTO `base_zip` VALUES ('3871', '713501', '', '', '花莲市', '3870');
INSERT INTO `base_zip` VALUES ('3872', '713521', '', '', '凤林镇', '3870');
INSERT INTO `base_zip` VALUES ('3873', '713522', '', '', '玉里镇', '3870');
INSERT INTO `base_zip` VALUES ('3874', '713523', '', '', '新城乡', '3870');
INSERT INTO `base_zip` VALUES ('3875', '713524', '', '', '吉安乡', '3870');
INSERT INTO `base_zip` VALUES ('3876', '713525', '', '', '寿丰乡', '3870');
INSERT INTO `base_zip` VALUES ('3877', '713526', '', '', '光复乡', '3870');
INSERT INTO `base_zip` VALUES ('3878', '713527', '', '', '丰滨乡', '3870');
INSERT INTO `base_zip` VALUES ('3879', '713528', '', '', '瑞穗乡', '3870');
INSERT INTO `base_zip` VALUES ('3880', '713529', '', '', '富里乡', '3870');
INSERT INTO `base_zip` VALUES ('3881', '713530', '', '', '秀林乡', '3870');
INSERT INTO `base_zip` VALUES ('3882', '713531', '', '', '万荣乡', '3870');
INSERT INTO `base_zip` VALUES ('3883', '713532', '', '', '卓溪乡', '3870');
INSERT INTO `base_zip` VALUES ('3884', '713600', '', '澎湖县', '', '3512');
INSERT INTO `base_zip` VALUES ('3885', '713601', '', '', '马公市', '3884');
INSERT INTO `base_zip` VALUES ('3886', '713621', '', '', '湖西乡', '3884');
INSERT INTO `base_zip` VALUES ('3887', '713622', '', '', '白沙乡', '3884');
INSERT INTO `base_zip` VALUES ('3888', '713623', '', '', '西屿乡', '3884');
INSERT INTO `base_zip` VALUES ('3889', '713624', '', '', '望安乡', '3884');
INSERT INTO `base_zip` VALUES ('3890', '713625', '', '', '七美乡', '3884');
INSERT INTO `base_zip` VALUES ('3891', '810000', '香港特别行政区', '', '', '1');
INSERT INTO `base_zip` VALUES ('3892', '810100', '', '香港岛', '', '3891');
INSERT INTO `base_zip` VALUES ('3893', '810101', '', '', '中西区', '3892');
INSERT INTO `base_zip` VALUES ('3894', '810102', '', '', '湾仔区', '3892');
INSERT INTO `base_zip` VALUES ('3895', '810103', '', '', '东区', '3892');
INSERT INTO `base_zip` VALUES ('3896', '810104', '', '', '南区', '3892');
INSERT INTO `base_zip` VALUES ('3897', '810200', '', '九龙', '', '3891');
INSERT INTO `base_zip` VALUES ('3898', '810201', '', '', '油尖旺区', '3897');
INSERT INTO `base_zip` VALUES ('3899', '810202', '', '', '深水埗区', '3897');
INSERT INTO `base_zip` VALUES ('3900', '810203', '', '', '九龙城区', '3897');
INSERT INTO `base_zip` VALUES ('3901', '810204', '', '', '黄大仙区', '3897');
INSERT INTO `base_zip` VALUES ('3902', '810205', '', '', '观塘区', '3897');
INSERT INTO `base_zip` VALUES ('3903', '810300', '', '新界', '', '3891');
INSERT INTO `base_zip` VALUES ('3904', '810301', '', '', '荃湾区', '3903');
INSERT INTO `base_zip` VALUES ('3905', '810302', '', '', '屯门区', '3903');
INSERT INTO `base_zip` VALUES ('3906', '810303', '', '', '元朗区', '3903');
INSERT INTO `base_zip` VALUES ('3907', '810304', '', '', '北区', '3903');
INSERT INTO `base_zip` VALUES ('3908', '810305', '', '', '大埔区', '3903');
INSERT INTO `base_zip` VALUES ('3909', '810306', '', '', '西贡区', '3903');
INSERT INTO `base_zip` VALUES ('3910', '810307', '', '', '沙田区', '3903');
INSERT INTO `base_zip` VALUES ('3911', '810308', '', '', '葵青区', '3903');
INSERT INTO `base_zip` VALUES ('3912', '810309', '', '', '离岛区', '3903');
INSERT INTO `base_zip` VALUES ('3913', '820000', '澳门特别行政区', '', '', '1');
INSERT INTO `base_zip` VALUES ('3914', '820100', '', '澳门半岛', '', '3913');
INSERT INTO `base_zip` VALUES ('3915', '820101', '', '', '花地玛堂区', '3914');
INSERT INTO `base_zip` VALUES ('3916', '820102', '', '', '圣安多尼堂区', '3914');
INSERT INTO `base_zip` VALUES ('3917', '820103', '', '', '大堂区', '3914');
INSERT INTO `base_zip` VALUES ('3918', '820104', '', '', '望德堂区', '3914');
INSERT INTO `base_zip` VALUES ('3919', '820105', '', '', '风顺堂区', '3914');
INSERT INTO `base_zip` VALUES ('3920', '820200', '', '氹仔岛', '', '3913');
INSERT INTO `base_zip` VALUES ('3921', '820201', '', '', '嘉模堂区', '3920');
INSERT INTO `base_zip` VALUES ('3922', '820300', '', '路环岛', '', '3913');
INSERT INTO `base_zip` VALUES ('3923', '820301', '', '', '圣方济各堂区', '3922');
INSERT INTO `base_zip` VALUES ('3925', '110000', null, '北京市', null, '2');
INSERT INTO `base_zip` VALUES ('3926', '120000', null, '天津市', null, '19');
INSERT INTO `base_zip` VALUES ('3927', '310000', null, '上海市', null, '857');
INSERT INTO `base_zip` VALUES ('3928', '500000', null, '重庆市', null, '2459');

-- ----------------------------
-- Table structure for im_friend
-- ----------------------------
DROP TABLE IF EXISTS `im_friend`;
CREATE TABLE `im_friend` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `friend_category_id` bigint(20) DEFAULT '0',
  `friend_id` bigint(20) DEFAULT NULL,
  `mark_name` varchar(255) DEFAULT NULL,
  `create_time` bigint(20) DEFAULT NULL,
  `request_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_friend_user_id` (`user_id`),
  KEY `fk_friend_friend_id` (`friend_id`),
  KEY `fk_friend_category_id` (`friend_category_id`),
  CONSTRAINT `fk_friend_friend_id` FOREIGN KEY (`friend_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `fk_friend_user_id` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of im_friend
-- ----------------------------
INSERT INTO `im_friend` VALUES ('1', '5', '0', '28', null, null, '5');
INSERT INTO `im_friend` VALUES ('2', '5', '0', '29', null, null, '5');
INSERT INTO `im_friend` VALUES ('3', '5', '0', '30', null, null, '5');
INSERT INTO `im_friend` VALUES ('4', '28', '0', '5', null, null, '5');
INSERT INTO `im_friend` VALUES ('5', '54', null, '42', '令狐冲', '1451138047047', null);
INSERT INTO `im_friend` VALUES ('6', '54', null, '49', '杨过', '1451138093113', null);
INSERT INTO `im_friend` VALUES ('7', '54', null, '50', '胡八一', '1451138124697', null);
INSERT INTO `im_friend` VALUES ('8', '54', null, '53', '何文均', '1451138346722', null);
INSERT INTO `im_friend` VALUES ('9', '54', null, '43', '李连杰', '1451266811613', null);
INSERT INTO `im_friend` VALUES ('10', '161', '0', '166', '互一压到', '324324234234234', '166');
INSERT INTO `im_friend` VALUES ('11', '167', null, '47', '甄子丹', '1451472199643', null);

-- ----------------------------
-- Table structure for im_friend_category
-- ----------------------------
DROP TABLE IF EXISTS `im_friend_category`;
CREATE TABLE `im_friend_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_creator_id_friend` (`creator_id`),
  CONSTRAINT `fk_creator_id_friend` FOREIGN KEY (`creator_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of im_friend_category
-- ----------------------------

-- ----------------------------
-- Table structure for im_group
-- ----------------------------
DROP TABLE IF EXISTS `im_group`;
CREATE TABLE `im_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL COMMENT '群描述',
  `dept_id` bigint(20) DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `head_url` bigint(20) DEFAULT NULL,
  `category` int(11) DEFAULT '1' COMMENT '1个人群2公司群3部门群',
  `creator_id` bigint(20) DEFAULT NULL,
  `create_time` bigint(20) DEFAULT NULL,
  `status` int(11) DEFAULT '1' COMMENT '1正常2禁用',
  PRIMARY KEY (`id`),
  KEY `fk_group_company` (`company_id`),
  KEY `fk_group_dept_id` (`dept_id`),
  CONSTRAINT `fk_group_company` FOREIGN KEY (`company_id`) REFERENCES `base_company` (`id`),
  CONSTRAINT `fk_group_dept_id` FOREIGN KEY (`dept_id`) REFERENCES `base_company_dept` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of im_group
-- ----------------------------
INSERT INTO `im_group` VALUES ('28', '测试公司1', null, null, '5', null, '2', null, null, '1');
INSERT INTO `im_group` VALUES ('29', 'Java研发部', null, '83', '5', null, '3', null, '1450568300515', '1');
INSERT INTO `im_group` VALUES ('30', 'iOS研发部', null, '84', '5', null, '3', null, '1450568491844', '1');
INSERT INTO `im_group` VALUES ('31', '阿萨德', null, '85', null, null, '3', null, '1450568886632', '2');
INSERT INTO `im_group` VALUES ('32', '人事部', null, '86', null, null, '3', null, '1450569166000', '1');
INSERT INTO `im_group` VALUES ('34', '华山派', '华山派', null, '8', null, '2', '42', '1450572682149', '3');
INSERT INTO `im_group` VALUES ('35', '少林寺', '少林寺', null, '9', null, '2', '43', '1450574552805', '3');
INSERT INTO `im_group` VALUES ('36', '武当山', '武当山', null, '10', null, '2', '44', '1450585704095', '3');
INSERT INTO `im_group` VALUES ('37', '万寿山五庄观', '万寿山五庄观', null, '11', null, '2', '45', '1450586023549', '3');
INSERT INTO `im_group` VALUES ('38', '德云社', '德云社', null, '12', null, '2', '46', '1450594448097', '3');
INSERT INTO `im_group` VALUES ('39', '锦衣卫', '锦衣卫', null, '13', null, '2', '47', '1450595208721', '3');
INSERT INTO `im_group` VALUES ('40', '嘻哈包袱铺', '嘻哈包袱铺', null, '14', null, '2', '48', '1450595648619', '3');
INSERT INTO `im_group` VALUES ('41', '春熙路', '春熙路', null, '15', null, '2', '49', '1450597088997', '3');
INSERT INTO `im_group` VALUES ('42', '寻龙诀', '寻龙诀', null, '16', null, '2', '50', '1450597430139', '3');
INSERT INTO `im_group` VALUES ('43', '国际金融中心', '国际金融中心', null, '17', null, '2', '51', '1450597759673', '3');
INSERT INTO `im_group` VALUES ('44', '纱帽街北站', '纱帽街北站', null, '18', null, '2', '52', '1450599008427', '3');
INSERT INTO `im_group` VALUES ('45', '若翼java后台开发', '若翼java后台开发', null, '19', null, '2', '53', '1450661001214', '3');
INSERT INTO `im_group` VALUES ('46', '阿萨德2', null, '87', null, null, '3', null, '1450661709219', '2');
INSERT INTO `im_group` VALUES ('47', '好好干', null, '88', null, null, '3', '53', '1450748272287', '3');
INSERT INTO `im_group` VALUES ('48', '水电费对方是个', null, '89', null, null, '3', '53', '1450748521778', '1');
INSERT INTO `im_group` VALUES ('49', '阿么nvxie', null, null, '20', null, '2', '53', '1450755233983', '1');
INSERT INTO `im_group` VALUES ('50', '卖女鞋到阿么2', null, null, '21', null, '2', '53', '1450755914892', '1');
INSERT INTO `im_group` VALUES ('52', '开发部', null, '96', null, null, '3', '53', '1450788075038', '1');
INSERT INTO `im_group` VALUES ('54', '大阿萨德', '就要我的style', null, '22', null, '2', '54', '1450853021410', '1');
INSERT INTO `im_group` VALUES ('55', '若翼', 'OMG大毛，离开过就都会好的，，', null, '23', null, '2', '54', '1450854391318', '1');
INSERT INTO `im_group` VALUES ('57', '阿萨德', null, '99', null, null, '3', '54', '1450854472093', '1');
INSERT INTO `im_group` VALUES ('58', '餐饮部', null, '100', null, null, '3', '5', '1450864225624', '1');
INSERT INTO `im_group` VALUES ('59', '花果山水帘洞', '花果山水帘洞', null, '24', null, '2', '74', '1450872500073', '3');
INSERT INTO `im_group` VALUES ('60', '四川', '四川', null, '25', null, '2', '75', '1450872847836', '3');
INSERT INTO `im_group` VALUES ('61', '若翼网络', null, null, '26', null, '2', '42', '1450875901231', '1');
INSERT INTO `im_group` VALUES ('62', 'jiava', null, '101', null, null, '3', '42', '1450876036163', '1');
INSERT INTO `im_group` VALUES ('63', '采购部', null, '102', null, null, '3', '42', '1450876285827', '2');
INSERT INTO `im_group` VALUES ('66', '财务部', null, '105', '26', null, '3', '42', '1450877309183', '1');
INSERT INTO `im_group` VALUES ('67', '狮驼山', '狮驼山', null, '27', null, '2', '96', '1450919462632', '3');
INSERT INTO `im_group` VALUES ('68', '若翼网络', null, null, '28', null, '2', '44', '1450920439411', '1');
INSERT INTO `im_group` VALUES ('69', '阿么商城', null, null, '29', null, '2', '44', '1450920533814', '1');
INSERT INTO `im_group` VALUES ('70', '研发部', null, '106', '28', null, '3', '44', '1450920545049', '1');
INSERT INTO `im_group` VALUES ('71', 'java开发2', null, null, '30', null, '2', '44', '1450921223145', '1');
INSERT INTO `im_group` VALUES ('72', '采购部', null, '107', '28', null, '3', '44', '1450921368118', '1');
INSERT INTO `im_group` VALUES ('73', '人力资源部', null, '108', '29', null, '3', '44', '1450925016982', '1');
INSERT INTO `im_group` VALUES ('74', '唐伯虎', '唐伯虎', null, '31', null, '2', '122', '1450929353245', '3');
INSERT INTO `im_group` VALUES ('75', '鬼吹灯', '鬼吹灯', null, '32', null, '2', '159', '1450954263963', '3');
INSERT INTO `im_group` VALUES ('76', '好好干', null, '109', '22', null, '3', '54', '1450955837498', '1');
INSERT INTO `im_group` VALUES ('77', '花果山水帘洞1', '花果山水帘洞1', null, '33', null, '2', '162', '1450956377079', '3');
INSERT INTO `im_group` VALUES ('78', '梁山泊', '梁山泊', null, '34', null, '2', '166', '1451027574072', '3');
INSERT INTO `im_group` VALUES ('96', 'my群', '我的地盘，听我的，额是老大，欧耶', null, null, null, '1', '54', '1451043914366', '1');
INSERT INTO `im_group` VALUES ('97', '我的群2', '水电费,楼兰', null, null, null, '1', '54', '1451044012930', '1');
INSERT INTO `im_group` VALUES ('98', '我的群3', '', null, null, null, '1', '54', '1451131702601', '1');
INSERT INTO `im_group` VALUES ('103', '阿么', '哈哈哈', null, '35', null, '2', '54', '1451294498432', '1');
INSERT INTO `im_group` VALUES ('104', '我的私人群，OMG', '下蛋公鸡，公鸡中的战斗机，欧耶', null, null, null, '1', '54', '1451359355306', '1');
INSERT INTO `im_group` VALUES ('105', '我的新群NO.1', '新群描述...嘿咻嘿咻', null, null, null, '1', '54', '1451362153500', '1');
INSERT INTO `im_group` VALUES ('106', 'XXX公司', 'XXX公司', null, '36', null, '2', '45', '1451379724829', '3');
INSERT INTO `im_group` VALUES ('107', 'rqwrewrewr', 'rqwrewrewr', null, '37', null, '2', '33', '1451381780729', '3');
INSERT INTO `im_group` VALUES ('108', 'myGroup No.2', '什么啊,闪电皇冠', null, null, null, '1', '54', '1451458660496', '1');
INSERT INTO `im_group` VALUES ('109', '泰囧', '泰囧就是囧，嘿咻', null, '38', null, '2', '167', '1451467691055', '3');
INSERT INTO `im_group` VALUES ('110', '泰囧一部', null, '110', '38', null, '3', '167', '1451472466604', '1');
INSERT INTO `im_group` VALUES ('111', '泰囧二部', null, '111', '38', null, '3', '167', '1451473398741', '1');
INSERT INTO `im_group` VALUES ('113', '韩囧', '差评，哼', null, '39', null, '2', '167', '1451474234505', '1');
INSERT INTO `im_group` VALUES ('114', '韩囧一部', null, '113', '39', null, '3', '167', '1451474352725', '1');

-- ----------------------------
-- Table structure for im_group_member
-- ----------------------------
DROP TABLE IF EXISTS `im_group_member`;
CREATE TABLE `im_group_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `group_role` bigint(20) DEFAULT '1' COMMENT '1成员2管理员3创建人',
  `group_mark_name` varchar(255) DEFAULT NULL,
  `join_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_group_mem_user_id` (`user_id`),
  KEY `fk_group_mem_group_id` (`group_id`),
  CONSTRAINT `fk_group_mem_group_id` FOREIGN KEY (`group_id`) REFERENCES `im_group` (`id`),
  CONSTRAINT `fk_group_mem_user_id` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of im_group_member
-- ----------------------------
INSERT INTO `im_group_member` VALUES ('36', '28', '28', '1', '张三', '1450568343252');
INSERT INTO `im_group_member` VALUES ('38', '29', '28', '1', '李四', '1450568550318');
INSERT INTO `im_group_member` VALUES ('40', '30', '28', '1', '王五', '1450568593284');
INSERT INTO `im_group_member` VALUES ('41', '30', '30', '1', '王五', '1450875157688');
INSERT INTO `im_group_member` VALUES ('42', '31', '28', '1', '王麻子', '1450568700827');
INSERT INTO `im_group_member` VALUES ('44', '32', '28', '1', '秦莞尔', '1450568978320');
INSERT INTO `im_group_member` VALUES ('45', '32', '30', '1', '秦莞尔', '1450869966326');
INSERT INTO `im_group_member` VALUES ('46', '33', '28', '1', '周星驰', '1450569016213');
INSERT INTO `im_group_member` VALUES ('47', '33', '31', '1', '周星驰', '1450662534013');
INSERT INTO `im_group_member` VALUES ('48', '34', '28', '1', '大毛', '1450569113060');
INSERT INTO `im_group_member` VALUES ('50', '35', '28', '1', '二毛', '1450569134633');
INSERT INTO `im_group_member` VALUES ('53', '37', '28', '1', '三毛', '1450569683122');
INSERT INTO `im_group_member` VALUES ('55', '38', '28', '1', '四毛', '1450570129613');
INSERT INTO `im_group_member` VALUES ('58', '42', null, '3', '华山派', '1450572682243');
INSERT INTO `im_group_member` VALUES ('59', '43', null, '3', '少林寺', '1450574552855');
INSERT INTO `im_group_member` VALUES ('60', '44', null, '3', '武当山', '1450585704185');
INSERT INTO `im_group_member` VALUES ('61', '45', null, '3', '万寿山五庄观', '1450586023590');
INSERT INTO `im_group_member` VALUES ('62', '46', null, '3', '大概', '1450594448157');
INSERT INTO `im_group_member` VALUES ('63', '47', null, '3', '锦衣卫', '1450595208791');
INSERT INTO `im_group_member` VALUES ('64', '48', null, '3', '嘻哈包袱铺', '1450595648689');
INSERT INTO `im_group_member` VALUES ('65', '49', null, '3', '春熙路', '1450597089047');
INSERT INTO `im_group_member` VALUES ('66', '50', null, '3', '寻龙诀', '1450597430179');
INSERT INTO `im_group_member` VALUES ('67', '51', null, '3', '国际金融中心', '1450597759731');
INSERT INTO `im_group_member` VALUES ('68', '52', null, '3', '纱帽街北站', '1450599008490');
INSERT INTO `im_group_member` VALUES ('69', '53', null, '3', '若翼java后台开发', '1450661001274');
INSERT INTO `im_group_member` VALUES ('71', '53', '49', '3', '何文均', '1450755234074');
INSERT INTO `im_group_member` VALUES ('72', '53', '50', '3', '何文均', '1450755914984');
INSERT INTO `im_group_member` VALUES ('74', '56', '28', null, 'a到时候', '1450766336459');
INSERT INTO `im_group_member` VALUES ('77', '54', '54', '3', '切勿', '1450853021493');
INSERT INTO `im_group_member` VALUES ('78', '54', '55', '3', '切勿', '1450854391342');
INSERT INTO `im_group_member` VALUES ('80', '45', '28', '1', '镇元大仙', '1450863645220');
INSERT INTO `im_group_member` VALUES ('81', '46', '28', '1', '大概', '1450863882106');
INSERT INTO `im_group_member` VALUES ('82', '46', '32', '1', '大概', '1450870258474');
INSERT INTO `im_group_member` VALUES ('83', '47', '28', '1', '甄子丹', '1450864252200');
INSERT INTO `im_group_member` VALUES ('84', '47', '30', '1', '甄子丹', '1450870053844');
INSERT INTO `im_group_member` VALUES ('85', '75', null, '3', '四川', '1450872847867');
INSERT INTO `im_group_member` VALUES ('89', '45', '49', '1', '镇元大仙1', '1450874909204');
INSERT INTO `im_group_member` VALUES ('91', '45', '50', '1', '镇元大仙1', '1450874961028');
INSERT INTO `im_group_member` VALUES ('95', '42', '61', '3', '令狐冲', '1450875901235');
INSERT INTO `im_group_member` VALUES ('96', '45', '61', '1', '镇元大仙1', '1450876172931');
INSERT INTO `im_group_member` VALUES ('98', '46', '61', '1', '大概', '1450876222704');
INSERT INTO `im_group_member` VALUES ('99', '45', '62', '1', '镇元大仙1', '1450876328470');
INSERT INTO `im_group_member` VALUES ('100', '42', '66', '1', '令狐冲', '1450877405528');
INSERT INTO `im_group_member` VALUES ('101', '47', '61', '1', '甄子丹', '1450877384748');
INSERT INTO `im_group_member` VALUES ('103', '48', '61', '1', '陈印泉', '1450877504662');
INSERT INTO `im_group_member` VALUES ('105', '82', '30', '1', null, '1450877797003');
INSERT INTO `im_group_member` VALUES ('106', '48', '66', '1', '陈印泉', '1450879115741');
INSERT INTO `im_group_member` VALUES ('107', '96', null, '3', '狮驼山', '1450919462665');
INSERT INTO `im_group_member` VALUES ('109', '44', '69', '3', '冲虚道长', '1450920533818');
INSERT INTO `im_group_member` VALUES ('114', '44', '71', '3', '冲虚道长', '1450921223219');
INSERT INTO `im_group_member` VALUES ('115', '47', '68', '1', '甄子丹', '1450921325777');
INSERT INTO `im_group_member` VALUES ('117', '46', '68', '1', '大概', '1450921380938');
INSERT INTO `im_group_member` VALUES ('118', '46', '72', '1', '大概', '1450921925317');
INSERT INTO `im_group_member` VALUES ('119', '48', '68', '1', '陈印泉', '1450921875668');
INSERT INTO `im_group_member` VALUES ('120', '47', '72', '1', '甄子丹', '1450921902358');
INSERT INTO `im_group_member` VALUES ('121', '121', '30', '1', 'iOS研发部', '1450924726011');
INSERT INTO `im_group_member` VALUES ('123', '47', '50', '1', '甄子丹', '1450926469009');
INSERT INTO `im_group_member` VALUES ('124', '45', '52', '1', '镇元大仙1', '1450927599324');
INSERT INTO `im_group_member` VALUES ('125', '122', '74', '3', '唐伯虎', '1450929353355');
INSERT INTO `im_group_member` VALUES ('126', '48', '49', '1', '陈印泉', '1450929494687');
INSERT INTO `im_group_member` VALUES ('128', '124', '29', '1', 'Java研发部', '1450942340512');
INSERT INTO `im_group_member` VALUES ('129', '125', '29', '1', 'Java研发部', '1450942891236');
INSERT INTO `im_group_member` VALUES ('130', '126', '29', '1', 'Java研发部', '1450943072545');
INSERT INTO `im_group_member` VALUES ('131', '5', '29', '1', '张三', '1450943072545');
INSERT INTO `im_group_member` VALUES ('132', '28', '29', '1', '张大炮', '1450943072545');
INSERT INTO `im_group_member` VALUES ('133', '29', '29', '1', '李四', '1450943072545');
INSERT INTO `im_group_member` VALUES ('134', '49', '61', '1', '杨过', '1450944525127');
INSERT INTO `im_group_member` VALUES ('135', '49', '66', '1', '杨过', '1450944525134');
INSERT INTO `im_group_member` VALUES ('136', '127', '29', '1', '赤脚大仙', '1450945441629');
INSERT INTO `im_group_member` VALUES ('137', '129', '66', '1', '二蛋', '1450947547077');
INSERT INTO `im_group_member` VALUES ('138', '129', '61', '1', '二蛋', '1450947547137');
INSERT INTO `im_group_member` VALUES ('139', '152', '28', '1', '张三链子', '1450951854947');
INSERT INTO `im_group_member` VALUES ('140', '155', '34', '1', '胡八一', '1450952191667');
INSERT INTO `im_group_member` VALUES ('143', '46', '54', '1', '大概', '1450952772541');
INSERT INTO `im_group_member` VALUES ('145', '158', '28', '1', '摸金校尉', '1450953984537');
INSERT INTO `im_group_member` VALUES ('146', '159', '75', '3', 'shieryYang', '1450954263996');
INSERT INTO `im_group_member` VALUES ('147', '46', '76', '1', '太极', '1450955875679');
INSERT INTO `im_group_member` VALUES ('148', '162', '77', '3', '齐天大圣', '1450956377112');
INSERT INTO `im_group_member` VALUES ('149', '163', '77', '1', '和尚2', '1450956515302');
INSERT INTO `im_group_member` VALUES ('150', '164', '30', '1', '女儿国', '1450956615859');
INSERT INTO `im_group_member` VALUES ('151', '164', '28', '1', '女儿国', '1450956615890');
INSERT INTO `im_group_member` VALUES ('152', '45', '55', '1', '镇元大仙1', '1450956596572');
INSERT INTO `im_group_member` VALUES ('153', '45', '47', '1', '镇元大仙1', '1450956596580');
INSERT INTO `im_group_member` VALUES ('154', '47', '55', '1', '甄子丹', '1450956652951');
INSERT INTO `im_group_member` VALUES ('155', '47', '57', '1', '甄子丹', '1450956652958');
INSERT INTO `im_group_member` VALUES ('156', '46', '55', '1', '太极', '1450956716497');
INSERT INTO `im_group_member` VALUES ('157', '46', '47', '1', '太极', '1450956716507');
INSERT INTO `im_group_member` VALUES ('159', '165', '28', '1', '和大牛', '1450956884002');
INSERT INTO `im_group_member` VALUES ('163', '54', '76', '1', '切勿', '1451026357031');
INSERT INTO `im_group_member` VALUES ('164', '54', '57', '1', '切勿', '1451026500058');
INSERT INTO `im_group_member` VALUES ('165', '166', '78', '3', '立地太岁', '1451027574118');
INSERT INTO `im_group_member` VALUES ('166', '54', '96', '1', '切勿', '1451043914368');
INSERT INTO `im_group_member` VALUES ('167', '54', '97', '3', '切勿', '1451044012932');
INSERT INTO `im_group_member` VALUES ('172', '54', '98', '3', '切勿', '1451131702604');
INSERT INTO `im_group_member` VALUES ('188', '54', '103', '3', '切勿', '1451294498435');
INSERT INTO `im_group_member` VALUES ('189', '54', '104', '1', '切勿', '1451359355310');
INSERT INTO `im_group_member` VALUES ('190', '46', '104', '1', '太极', '1451359355318');
INSERT INTO `im_group_member` VALUES ('191', '54', '105', '3', '切勿', '1451362153503');
INSERT INTO `im_group_member` VALUES ('192', '46', '105', '1', '太极', '1451362153528');
INSERT INTO `im_group_member` VALUES ('193', '45', '105', '1', '镇元大仙1', '1451362153534');
INSERT INTO `im_group_member` VALUES ('194', '47', '105', '1', '甄子丹', '1451362153539');
INSERT INTO `im_group_member` VALUES ('195', '45', '106', '3', '镇元大仙1', '1451379724852');
INSERT INTO `im_group_member` VALUES ('196', '33', '107', '3', '周星星i', '1451381780761');
INSERT INTO `im_group_member` VALUES ('197', '47', '104', '1', '甄子丹', '1451440511217');
INSERT INTO `im_group_member` VALUES ('198', '45', '104', '3', '镇元大仙1', '1451440713901');
INSERT INTO `im_group_member` VALUES ('199', '47', '96', '1', '甄子丹', '1451441034288');
INSERT INTO `im_group_member` VALUES ('200', '45', '96', '3', '镇元大仙1', '1451441102837');
INSERT INTO `im_group_member` VALUES ('201', '54', '108', '3', '切勿', '1451458660499');
INSERT INTO `im_group_member` VALUES ('202', '46', '108', '1', '太极', '1451458660505');
INSERT INTO `im_group_member` VALUES ('203', '47', '108', '1', '甄子丹', '1451458660510');
INSERT INTO `im_group_member` VALUES ('204', '47', '97', '1', '甄子丹', '1451459578880');
INSERT INTO `im_group_member` VALUES ('205', '167', '109', '3', '王宝强@黄渤', '1451467691079');
INSERT INTO `im_group_member` VALUES ('209', '167', '113', '3', '王宝强@黄渤', '1451474234508');
INSERT INTO `im_group_member` VALUES ('213', '46', '109', '1', '太极', '1451475878931');
INSERT INTO `im_group_member` VALUES ('214', '46', '110', '1', '太极', '1451475948364');
INSERT INTO `im_group_member` VALUES ('215', '45', '113', '1', '镇元大仙1', '1451476281902');
INSERT INTO `im_group_member` VALUES ('221', '47', '113', '1', '甄子丹', '1451477116268');
INSERT INTO `im_group_member` VALUES ('222', '48', '113', '1', '陈印泉', '1451477146132');

-- ----------------------------
-- Table structure for im_message
-- ----------------------------
DROP TABLE IF EXISTS `im_message`;
CREATE TABLE `im_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `msg_type` int(10) DEFAULT NULL,
  `msg_id` varchar(100) DEFAULT NULL,
  `belong_id` bigint(50) DEFAULT NULL,
  `src_type` int(10) DEFAULT NULL,
  `fromUser_id` bigint(50) DEFAULT NULL,
  `toUser_id` bigint(50) DEFAULT NULL,
  `msg_content` text,
  `msg_text` text,
  `status` int(10) DEFAULT NULL,
  `send_time` bigint(20) DEFAULT NULL,
  `receive_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_message_from_id` (`fromUser_id`),
  KEY `fk_message_to_id` (`toUser_id`),
  KEY `fk_message_belong_id` (`belong_id`),
  CONSTRAINT `fk_message_belong_id` FOREIGN KEY (`belong_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `fk_message_from_id` FOREIGN KEY (`fromUser_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `fk_message_to_id` FOREIGN KEY (`toUser_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of im_message
-- ----------------------------

-- ----------------------------
-- Table structure for im_session
-- ----------------------------
DROP TABLE IF EXISTS `im_session`;
CREATE TABLE `im_session` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `friend_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT '1' COMMENT '1联系人2部门群',
  `last_message` text,
  `last_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_im_session_userId` (`user_id`),
  KEY `fk_im_session_friend` (`friend_id`),
  CONSTRAINT `fk_im_session_friend` FOREIGN KEY (`friend_id`) REFERENCES `base_user` (`id`),
  CONSTRAINT `fk_im_session_userId` FOREIGN KEY (`user_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of im_session
-- ----------------------------
INSERT INTO `im_session` VALUES ('1', '5', '28', '1', '3ewrewrw', '234234234');
INSERT INTO `im_session` VALUES ('2', '5', '29', '1', 'dfgdfgdfg', '345456345345');
INSERT INTO `im_session` VALUES ('3', '5', '30', '1', 'gfhgfhfgvvc111', '34254234234');

-- ----------------------------
-- Table structure for oa_document
-- ----------------------------
DROP TABLE IF EXISTS `oa_document`;
CREATE TABLE `oa_document` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL COMMENT '1制度2绩效3流程',
  `parent_id` int(11) DEFAULT '0' COMMENT '0表示发布的，其它表示为谁的草稿',
  `content` text,
  `status` int(11) DEFAULT '1' COMMENT '0已发布，1草稿',
  `update_time` bigint(20) DEFAULT NULL,
  `updator_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oa_document
-- ----------------------------
INSERT INTO `oa_document` VALUES ('1', '5', '通知', '83', null, null, '<p>dwadasdasd</p><p><br/></p><p><img style=\"width: 423px; height: 266px;\" alt=\"Koala.jpg\" src=\"/oa-web/upload/166/image/20151230/1451466754068012092_Koala.jpg\" title=\"1451466754068012092_Koala.jpg\" height=\"266\" width=\"423\"/></p>', null, '1451466758825', '123');
INSERT INTO `oa_document` VALUES ('2', '34', '发布', null, null, null, '<p>fsfsadf<br/></p>', null, '1451469553160', '166');
INSERT INTO `oa_document` VALUES ('3', '34', null, null, null, null, '', null, '1451469595067', '166');

-- ----------------------------
-- Table structure for oa_document_history
-- ----------------------------
DROP TABLE IF EXISTS `oa_document_history`;
CREATE TABLE `oa_document_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL COMMENT '1制度2绩效3流程',
  `parent_id` int(11) DEFAULT '0' COMMENT '0表示发布的，其它表示为谁的草稿',
  `content` text,
  `status` int(11) DEFAULT '1' COMMENT '0已发布，1草稿',
  `update_time` bigint(20) DEFAULT NULL,
  `updator_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oa_document_history
-- ----------------------------

-- ----------------------------
-- Table structure for oa_file
-- ----------------------------
DROP TABLE IF EXISTS `oa_file`;
CREATE TABLE `oa_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `file_type` varchar(255) DEFAULT NULL COMMENT '文件的类型：如png,jpg,doc',
  `size` double DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `create_time` bigint(20) DEFAULT NULL,
  `category` int(11) DEFAULT '5' COMMENT '1制度2绩效3流程4任务5头像6其它',
  `status` int(11) DEFAULT '1' COMMENT '1正常2删除',
  PRIMARY KEY (`id`),
  KEY `fk_oa_file_creator` (`creator_id`),
  CONSTRAINT `fk_oa_file_creator` FOREIGN KEY (`creator_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oa_file
-- ----------------------------
INSERT INTO `oa_file` VALUES ('7', 'Koala.jpg', 'image/jpeg', '780831', '/upload/1451449225981_Koala.jpg', '166', '1451449225981', '5', '1');
INSERT INTO `oa_file` VALUES ('8', 'Penguins.jpg', 'image/jpeg', '777835', '/upload/1451458766332_Penguins.jpg', '162', '1451458766332', '5', '1');

-- ----------------------------
-- Table structure for oa_folder
-- ----------------------------
DROP TABLE IF EXISTS `oa_folder`;
CREATE TABLE `oa_folder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT '0' COMMENT '0顶级',
  `create_time` bigint(20) DEFAULT NULL,
  `update_time` bigint(20) DEFAULT NULL,
  `open_status` int(11) DEFAULT '2' COMMENT '1,私密2公开3好友公开',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oa_folder
-- ----------------------------
INSERT INTO `oa_folder` VALUES ('21', 'a', '166', '0', '1451527771901', null, '2');
INSERT INTO `oa_folder` VALUES ('22', 'aa', '166', '0', '1451527787044', null, '2');
INSERT INTO `oa_folder` VALUES ('23', '22', '166', '21', '1451527787111', null, '2');
INSERT INTO `oa_folder` VALUES ('24', '222', '166', '23', '1451527787111', null, '2');

-- ----------------------------
-- Table structure for oa_folder_file
-- ----------------------------
DROP TABLE IF EXISTS `oa_folder_file`;
CREATE TABLE `oa_folder_file` (
  `id` bigint(20) NOT NULL,
  `folder_id` bigint(20) DEFAULT NULL,
  `file_id` bigint(20) DEFAULT NULL,
  `document_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oa_folder_file
-- ----------------------------

-- ----------------------------
-- Table structure for ry_user
-- ----------------------------
DROP TABLE IF EXISTS `ry_user`;
CREATE TABLE `ry_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `birthDay` varchar(20) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `createDate` varchar(20) DEFAULT NULL,
  `headUrl` varchar(200) DEFAULT NULL,
  `lastMsgDate` varchar(20) DEFAULT NULL,
  `lastMsgId` varchar(50) DEFAULT NULL,
  `lastUserId` varchar(50) DEFAULT NULL,
  `mail` varchar(200) DEFAULT NULL,
  `mobile` varchar(200) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `nickName` varchar(200) NOT NULL,
  `onlineStatus` longtext,
  `provice` varchar(255) DEFAULT NULL,
  `pwd` varchar(50) NOT NULL,
  `refer` varchar(50) DEFAULT NULL,
  `sex` varchar(2) DEFAULT NULL,
  `signle` longtext,
  `status` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ry_user
-- ----------------------------

-- ----------------------------
-- Table structure for task_item
-- ----------------------------
DROP TABLE IF EXISTS `task_item`;
CREATE TABLE `task_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `col_type` int(20) DEFAULT '1' COMMENT '1待完成2工作中3已完成',
  `is_check` int(11) DEFAULT '0' COMMENT '0选中1未选中',
  `lab` int(11) DEFAULT '1' COMMENT '1一般2紧急3非常紧急',
  `content` text,
  `creator_id` bigint(20) DEFAULT NULL,
  `create_time` bigint(20) DEFAULT NULL,
  `stop_time` bigint(20) DEFAULT NULL,
  `tag_color` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_item_001` (`creator_id`),
  KEY `FK_9h81bu2csxdk3bapm6ifjrd2o` (`col_type`),
  CONSTRAINT `fk_item_001` FOREIGN KEY (`creator_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task_item
-- ----------------------------

-- ----------------------------
-- Table structure for task_item_file
-- ----------------------------
DROP TABLE IF EXISTS `task_item_file`;
CREATE TABLE `task_item_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) DEFAULT NULL,
  `file_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_itme_file_id` (`file_id`),
  KEY `fk_item_file_itemid` (`item_id`),
  CONSTRAINT `fk_item_file_itemid` FOREIGN KEY (`item_id`) REFERENCES `task_item` (`id`),
  CONSTRAINT `fk_itme_file_id` FOREIGN KEY (`file_id`) REFERENCES `oa_file` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task_item_file
-- ----------------------------

-- ----------------------------
-- Table structure for task_item_worker
-- ----------------------------
DROP TABLE IF EXISTS `task_item_worker`;
CREATE TABLE `task_item_worker` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) DEFAULT NULL,
  `worker_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_work_001` (`item_id`),
  KEY `fk_work_002` (`worker_id`),
  CONSTRAINT `fk_work_001` FOREIGN KEY (`item_id`) REFERENCES `task_item` (`id`),
  CONSTRAINT `fk_work_002` FOREIGN KEY (`worker_id`) REFERENCES `base_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task_item_worker
-- ----------------------------
DROP TRIGGER IF EXISTS `t_afterinsert_on_oa_base_user`;
DELIMITER ;;
CREATE TRIGGER `t_afterinsert_on_oa_base_user` AFTER INSERT ON `base_user` FOR EACH ROW BEGIN
  insert into mail.base_user(id,mobile,name,mail,pwd,create_time,update_time,user_status) values(new.id,new.mobile,new.name,new.mail,new.pwd,new.create_time,new.update_time,new.status);
END
;;
DELIMITER ;
