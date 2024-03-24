/*
 Navicat Premium Data Transfer

 Source Server         : 123
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : bysj

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 15/11/2022 10:12:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for calendar
-- ----------------------------
DROP TABLE IF EXISTS `calendar`;
CREATE TABLE `calendar`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `date` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日期',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `date_uni`(`date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of calendar
-- ----------------------------
INSERT INTO `calendar` VALUES (1, '2022-07-28', '联系指导老师、确定选题');
INSERT INTO `calendar` VALUES (3, '2022-11-20', '可以离校');
INSERT INTO `calendar` VALUES (5, '2022-09-15', '完成开题报告');
INSERT INTO `calendar` VALUES (6, '2022-09-20', '收集资料，技术调研和积累，修改开题报告');
INSERT INTO `calendar` VALUES (7, '2022-10-01', '系统框架搭建、功能设计与实现');
INSERT INTO `calendar` VALUES (9, '2022-10-25', '功能完善及代码测试');
INSERT INTO `calendar` VALUES (10, '2022-10-31', '代码测试，论文修改，论文定稿');
INSERT INTO `calendar` VALUES (11, '2022-11-15', '毕业设计论文答辩');
INSERT INTO `calendar` VALUES (49, '2022-10-26', '今天要学习');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名称',
  `foreign_id` int(0) NULL DEFAULT NULL COMMENT '业务模块的id',
  `pid` int(0) NULL DEFAULT NULL COMMENT '父级评论id',
  `target` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '回复对象',
  `createtime` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (35, '学校安排在哪里看？', 'student1', 1, NULL, NULL, '2022-10-20 06:20:48');
INSERT INTO `comment` VALUES (36, '请进入日程安排界面查看。', 'admin', 1, 35, 'student1', '2022-10-20 06:21:25');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `cid` int(0) NOT NULL AUTO_INCREMENT,
  `cname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '选题名',
  `remake` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `uid` int(0) NOT NULL COMMENT '发布人id',
  `introduction` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '简介',
  `nandu` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '难度',
  `effort` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工作量',
  `status` tinyint(0) NULL DEFAULT NULL COMMENT '状态',
  `num` int(0) NOT NULL COMMENT '需要人数',
  PRIMARY KEY (`cid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `uid` FOREIGN KEY (`uid`) REFERENCES `easyuser` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (25, '基于SpringBoot框架的医疗挂号系统的设计与实现', '', 2, '本系统用户角色分为三个类型，即管理员、医生以及病人', '难', '适中', 1, 1);
INSERT INTO `course` VALUES (28, '基于SpringBoot框架的招聘网站的设计与实现', '通过', 2, '本系统用户角色分为三个类型，即管理员、教师以及学生', '易', '大', 1, 2);
INSERT INTO `course` VALUES (29, '基于SpringBoot+Vue框架前后端分离的音乐管理系统', '', 3, '本系统用户角色分为三个类型，即管理员、教师以及学生', '一般', '小', 1, 1);
INSERT INTO `course` VALUES (30, '基于SpringBoot+Vue框架前后端分离的在线购物平台的设计与实现', '', 3, '本系统用户角色分为三个类型，即管理员、教师以及学生', '难', '适中', 1, 1);
INSERT INTO `course` VALUES (31, '基于SpringBoot的疾病预防系统的设计与实现', '通过', 2, '本系统用户角色分为三个类型，即管理员、教师以及学生', '适中', '一般', 1, 1);
INSERT INTO `course` VALUES (39, '基于SpringBoot+Vue框架前后端分离的在线办公系统', '', 3, '本系统用户角色分为三个类型', '难', '大', 1, 2);
INSERT INTO `course` VALUES (42, '基于Spring Boot的物流配送管理系统设计与实现', '', 1, '本系统用户角色分为三个类型，即管理员、教师以及学生', '一般', '大', 0, 3);
INSERT INTO `course` VALUES (43, '基于Spring Boot的智慧取餐柜管理系统设计与实现', NULL, 1, '本系统用户角色分为三个类型', '一般', '大', 0, 3);
INSERT INTO `course` VALUES (58, '基于Android的个人健康管理系统设计与实现', '', 3, 'java web 管理系统 毕设选题', '难', '大', 0, 2);
INSERT INTO `course` VALUES (59, '基于物联网的图书馆网络方案设计与实现', NULL, 1, 'java web 平台/业务系统 毕设选题', '难', '大', 1, 3);
INSERT INTO `course` VALUES (60, '基于安卓的聊天系统设计与实现', NULL, 1, 'java web 管理系统 毕设选题', '难', '小', 1, 2);

-- ----------------------------
-- Table structure for easyuser
-- ----------------------------
DROP TABLE IF EXISTS `easyuser`;
CREATE TABLE `easyuser`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `roleId` int(0) NOT NULL,
  `state` tinyint(0) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `roleId`(`roleId`) USING BTREE,
  CONSTRAINT `roleId` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 81 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of easyuser
-- ----------------------------
INSERT INTO `easyuser` VALUES (1, 'admin', '123456', '2608440484@qq.com', 1, 1);
INSERT INTO `easyuser` VALUES (2, 'system', '123456', 'zzz20020312@163.com', 1, 1);
INSERT INTO `easyuser` VALUES (3, 'teacher1', '123456', '2608440484@qq.com', 2, 1);
INSERT INTO `easyuser` VALUES (4, 'teacher2', '123456', '1900364029@qq.com', 2, 1);
INSERT INTO `easyuser` VALUES (5, 'teacher3', '123456', '1900364029@qq.com', 2, 1);
INSERT INTO `easyuser` VALUES (6, 'teacher4', '123456', '1900364029@qq.com', 2, 1);
INSERT INTO `easyuser` VALUES (7, 'teacher5', '123456', '1900364029@qq.com', 2, 1);
INSERT INTO `easyuser` VALUES (8, 'teacher6', '123456', '1900364029@qq.com', 2, 1);
INSERT INTO `easyuser` VALUES (9, 'teacher7', '123456', '1900364029@qq.com', 2, 1);
INSERT INTO `easyuser` VALUES (10, 'student1', '123456', '1900364029@qq.com', 3, 1);
INSERT INTO `easyuser` VALUES (11, 'student2', '123456', '123@qq.com', 3, 1);
INSERT INTO `easyuser` VALUES (12, 'student3', '123456', '123456@qq.com', 3, 1);
INSERT INTO `easyuser` VALUES (13, 'student4', '123456', '123@qq.com', 3, 1);
INSERT INTO `easyuser` VALUES (14, 'student5', '123456', '123@qq.com', 3, 1);
INSERT INTO `easyuser` VALUES (15, 'student6', '123456', '123456@qq.com', 3, 1);
INSERT INTO `easyuser` VALUES (16, 'student7', '123456', '123456@qq.com', 3, 1);
INSERT INTO `easyuser` VALUES (17, 'student8', '123456', '123456@qq.com', 3, 1);
INSERT INTO `easyuser` VALUES (18, 'student9', '123456', '123456@qq.com', 3, 1);
INSERT INTO `easyuser` VALUES (19, 'student10', '123456', '123456@qq.com', 3, 1);
INSERT INTO `easyuser` VALUES (20, 'student11', '123456', '123456@qq.com', 3, 1);
INSERT INTO `easyuser` VALUES (21, 'student12', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (22, 'student13', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (23, 'student14', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (24, 'student15', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (25, 'student16', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (26, 'student17', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (29, 'student20', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (30, 'student21', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (31, 'student22', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (32, 'student23', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (33, 'student24', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (34, 'student25', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (35, 'test22', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (36, 'test23', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (37, 'test24', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (38, 'test25', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (39, 'test26', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (40, 'test27', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (41, 'test28', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (42, 'test29', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (43, 'test30', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (44, 'test31', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (45, 'test32', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (46, 'test33', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (47, 'test34', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (48, 'test35', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (49, 'test36', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (62, 'test3', '123456', '123456@qq.com', 3, 1);
INSERT INTO `easyuser` VALUES (63, 'test1', '123456', '123456@qq.com', 3, 0);
INSERT INTO `easyuser` VALUES (70, 'test37', '111111', '123456@qq.com', 4, 1);
INSERT INTO `easyuser` VALUES (72, 'test80', '123456', '123456@qq.com', 4, 1);
INSERT INTO `easyuser` VALUES (73, 'test90', '123456', '123456@qq.com', 3, 1);

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件名',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '存储路径',
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '上传日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of file
-- ----------------------------

-- ----------------------------
-- Table structure for loginrecord
-- ----------------------------
DROP TABLE IF EXISTS `loginrecord`;
CREATE TABLE `loginrecord`  (
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `time` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ip` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`username`) USING BTREE,
  CONSTRAINT `name` FOREIGN KEY (`username`) REFERENCES `easyuser` (`username`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 429 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of loginrecord
-- ----------------------------
INSERT INTO `loginrecord` VALUES ('admin', 212, '2022-09-14 10:27:34', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('admin', 213, '2022-09-14 10:28:15', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('student1', 214, '2022-09-14 10:29:49', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('admin', 215, '2022-09-14 10:31:32', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('admin', 216, '2022-09-14 10:32:50', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('admin', 217, '2022-09-14 10:33:00', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('admin', 218, '2022-09-14 10:37:59', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('admin', 219, '2022-09-14 10:38:46', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('admin', 220, '2022-09-14 10:42:32', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('admin', 221, '2022-09-14 10:47:12', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('student1', 222, '2022-09-14 10:48:10', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('student1', 223, '2022-09-14 10:50:58', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('student1', 224, '2022-09-14 10:52:16', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('student1', 225, '2022-09-14 10:59:42', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('admin', 226, '2022-09-14 10:59:56', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('teacher1', 227, '2022-09-14 11:00:25', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('admin', 228, '2022-09-14 14:34:06', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 229, '2022-09-14 14:49:39', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 230, '2022-09-14 14:51:44', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 231, '2022-09-14 15:00:43', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('teacher1', 232, '2022-09-14 15:00:55', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 233, '2022-09-14 15:09:24', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 234, '2022-09-14 15:25:35', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 235, '2022-09-14 15:27:24', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('teacher1', 236, '2022-09-14 15:27:38', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 237, '2022-09-14 15:28:21', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('teacher1', 238, '2022-09-14 15:28:45', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 239, '2022-09-14 15:41:02', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 240, '2022-09-14 16:09:36', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 241, '2022-09-14 16:15:35', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 242, '2022-09-14 16:17:41', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('student1', 243, '2022-09-14 16:19:27', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('teacher1', 245, '2022-09-14 16:20:11', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 246, '2022-09-14 16:24:13', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 247, '2022-09-14 16:52:50', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('student1', 248, '2022-09-14 16:53:25', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 249, '2022-09-14 16:59:46', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 250, '2022-09-14 17:06:35', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('teacher1', 251, '2022-09-14 17:07:59', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 252, '2022-09-15 10:05:08', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 253, '2022-09-15 10:09:32', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('student2', 254, '2022-09-15 10:19:24', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 255, '2022-09-15 10:20:31', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 256, '2022-09-15 10:29:16', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 257, '2022-09-15 10:38:12', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('student1', 258, '2022-09-15 10:38:50', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 259, '2022-09-19 15:42:57', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('admin', 260, '2022-09-19 15:47:14', '192.168.237.55');
INSERT INTO `loginrecord` VALUES ('admin', 261, '2022-09-19 16:55:00', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 262, '2022-09-19 20:44:52', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 263, '2022-09-20 08:29:47', '10.24.109.249');
INSERT INTO `loginrecord` VALUES ('student1', 266, '2022-09-20 08:52:16', '10.24.109.249');
INSERT INTO `loginrecord` VALUES ('teacher1', 267, '2022-09-20 08:58:03', '10.24.109.249');
INSERT INTO `loginrecord` VALUES ('admin', 268, '2022-09-20 08:58:18', '10.24.109.249');
INSERT INTO `loginrecord` VALUES ('system', 269, '2022-09-20 08:59:39', '10.24.109.249');
INSERT INTO `loginrecord` VALUES ('teacher1', 270, '2022-09-20 09:01:42', '10.24.109.249');
INSERT INTO `loginrecord` VALUES ('admin', 271, '2022-09-20 09:04:30', '10.24.109.249');
INSERT INTO `loginrecord` VALUES ('admin', 272, '2022-09-20 10:36:04', '10.24.109.249');
INSERT INTO `loginrecord` VALUES ('admin', 273, '2022-09-22 08:53:47', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('teacher1', 274, '2022-09-22 08:58:43', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('system', 275, '2022-09-22 08:59:00', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('teacher1', 276, '2022-09-22 08:59:49', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 277, '2022-09-22 09:01:20', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 278, '2022-09-22 10:59:42', '192.168.222.55');
INSERT INTO `loginrecord` VALUES ('admin', 279, '2022-10-05 08:38:44', '10.24.109.249');
INSERT INTO `loginrecord` VALUES ('admin', 280, '2022-10-05 08:41:00', '10.24.109.249');
INSERT INTO `loginrecord` VALUES ('admin', 281, '2022-10-05 08:44:38', '10.24.109.249');
INSERT INTO `loginrecord` VALUES ('admin', 282, '2022-10-05 08:51:11', '10.24.109.249');
INSERT INTO `loginrecord` VALUES ('admin', 283, '2022-10-05 09:01:11', '10.24.109.249');
INSERT INTO `loginrecord` VALUES ('admin', 284, '2022-10-05 09:28:41', '10.24.109.249');
INSERT INTO `loginrecord` VALUES ('admin', 285, '2022-10-05 10:34:45', '10.24.109.249');
INSERT INTO `loginrecord` VALUES ('admin', 286, '2022-10-05 10:37:24', '10.24.109.249');
INSERT INTO `loginrecord` VALUES ('admin', 287, '2022-10-05 10:43:34', '10.24.109.249');
INSERT INTO `loginrecord` VALUES ('admin', 288, '2022-10-05 13:25:17', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 289, '2022-10-05 13:55:12', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('teacher1', 290, '2022-10-05 14:02:09', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('teacher1', 291, '2022-10-05 14:05:59', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 292, '2022-10-05 14:06:09', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 293, '2022-10-05 14:25:55', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 294, '2022-10-05 18:36:29', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 295, '2022-10-05 18:36:53', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 296, '2022-10-05 20:26:37', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 297, '2022-10-06 08:36:38', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 298, '2022-10-06 08:41:50', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('student1', 299, '2022-10-06 08:52:50', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('teacher1', 300, '2022-10-06 08:53:58', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 301, '2022-10-06 08:55:40', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('student1', 302, '2022-10-06 08:58:01', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 303, '2022-10-06 09:04:30', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('teacher1', 304, '2022-10-06 09:05:48', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 305, '2022-10-06 09:06:19', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 306, '2022-10-06 11:01:58', '192.168.222.55');
INSERT INTO `loginrecord` VALUES ('admin', 307, '2022-10-06 11:17:57', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 308, '2022-10-06 20:42:14', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 309, '2022-10-06 21:00:31', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 310, '2022-10-08 14:36:53', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('system', 311, '2022-10-08 14:43:37', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('system', 312, '2022-10-08 14:55:04', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('system', 313, '2022-10-08 15:43:13', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('system', 314, '2022-10-08 15:45:33', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 315, '2022-10-10 14:13:53', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('student1', 316, '2022-10-10 14:14:34', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('admin', 317, '2022-10-10 14:37:12', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('student1', 318, '2022-10-10 14:42:53', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('student1', 319, '2022-10-10 17:01:58', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('student1', 320, '2022-10-10 17:02:45', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('student1', 321, '2022-10-11 11:17:39', '192.168.222.55');
INSERT INTO `loginrecord` VALUES ('admin', 322, '2022-10-11 11:17:50', '192.168.222.55');
INSERT INTO `loginrecord` VALUES ('admin', 323, '2022-10-11 11:35:44', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 324, '2022-10-11 12:37:31', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 325, '2022-10-11 12:57:49', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 326, '2022-10-12 09:15:49', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('admin', 327, '2022-10-12 12:12:44', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 328, '2022-10-12 13:53:24', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 329, '2022-10-12 13:56:22', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 330, '2022-10-12 14:54:45', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 331, '2022-10-12 14:54:45', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 332, '2022-10-12 20:00:47', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 333, '2022-10-12 22:42:52', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 334, '2022-10-12 22:45:02', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 335, '2022-10-12 22:45:45', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 336, '2022-10-13 08:14:35', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 337, '2022-10-13 08:20:12', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('teacher1', 338, '2022-10-13 08:22:36', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('teacher1', 339, '2022-10-13 08:33:09', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 340, '2022-10-13 08:33:21', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 341, '2022-10-13 09:05:12', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('teacher1', 342, '2022-10-13 09:06:37', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 343, '2022-10-13 09:06:55', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 344, '2022-10-13 09:23:23', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 345, '2022-10-13 10:11:18', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 346, '2022-10-13 10:11:26', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 347, '2022-10-14 08:08:36', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('teacher1', 348, '2022-10-14 08:09:58', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('admin', 349, '2022-10-14 08:10:22', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('admin', 350, '2022-10-14 09:20:00', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('admin', 351, '2022-10-14 09:33:23', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('admin', 352, '2022-10-18 08:24:43', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('student1', 353, '2022-10-18 09:21:29', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('teacher1', 354, '2022-10-18 09:39:21', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('admin', 355, '2022-10-18 10:22:38', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('admin', 356, '2022-10-18 21:17:39', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 357, '2022-10-19 08:39:38', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('admin', 358, '2022-10-20 14:20:10', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('student1', 359, '2022-10-20 14:20:22', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('admin', 360, '2022-10-20 14:20:58', '10.18.200.124');
INSERT INTO `loginrecord` VALUES ('student1', 361, '2022-10-21 09:41:50', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('student1', 362, '2022-10-24 08:38:34', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('admin', 363, '2022-10-24 08:39:29', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('admin', 364, '2022-10-25 09:00:20', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('admin', 365, '2022-10-26 09:44:12', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('admin', 366, '2022-10-26 09:46:52', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('teacher1', 367, '2022-10-26 10:12:38', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('student1', 368, '2022-10-26 10:13:51', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('admin', 369, '2022-10-26 10:15:25', '10.24.110.217');
INSERT INTO `loginrecord` VALUES ('admin', 370, '2022-10-26 12:40:52', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 371, '2022-10-26 13:47:05', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 372, '2022-10-26 13:51:54', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 373, '2022-10-26 13:52:02', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 374, '2022-10-26 13:52:20', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 375, '2022-10-26 13:52:24', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('system', 376, '2022-10-26 13:52:36', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('system', 377, '2022-10-26 13:53:23', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 379, '2022-10-26 13:54:45', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 382, '2022-10-26 13:59:51', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('system', 383, '2022-10-26 14:04:12', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('system', 384, '2022-10-26 14:05:09', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('system', 385, '2022-10-26 14:05:54', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('teacher1', 386, '2022-10-26 14:17:03', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('teacher1', 387, '2022-10-26 14:36:33', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 388, '2022-10-26 14:37:28', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 389, '2022-10-26 14:37:38', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 391, '2022-10-26 14:39:32', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 393, '2022-10-26 14:39:59', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('student1', 394, '2022-10-26 14:41:45', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('student1', 395, '2022-10-26 14:43:15', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 398, '2022-10-26 14:48:12', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 399, '2022-10-26 14:54:36', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 400, '2022-10-26 14:54:41', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 402, '2022-10-26 14:55:41', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 403, '2022-10-29 16:22:38', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 404, '2022-10-29 18:04:37', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 405, '2022-10-30 10:28:26', '10.21.145.158');
INSERT INTO `loginrecord` VALUES ('admin', 406, '2022-11-03 17:38:02', '127.0.0.1');
INSERT INTO `loginrecord` VALUES ('admin', 407, '2022-11-03 21:01:22', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 408, '2022-11-03 21:04:29', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 409, '2022-11-05 11:47:55', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 410, '2022-11-05 12:22:08', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 411, '2022-11-08 11:26:05', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('teacher1', 412, '2022-11-08 11:45:35', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 413, '2022-11-08 11:46:49', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 414, '2022-11-08 14:51:23', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 415, '2022-11-08 14:51:23', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 416, '2022-11-08 14:57:20', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 417, '2022-11-08 16:35:12', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 418, '2022-11-08 20:49:51', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 419, '2022-11-08 20:53:28', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 420, '2022-11-08 20:54:44', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 421, '2022-11-08 21:04:41', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 422, '2022-11-09 20:53:30', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 423, '2022-11-09 21:08:35', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 424, '2022-11-09 21:12:56', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 425, '2022-11-09 21:51:50', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 426, '2022-11-09 21:54:46', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 427, '2022-11-10 08:33:51', '192.168.118.55');
INSERT INTO `loginrecord` VALUES ('admin', 428, '2022-11-10 10:11:19', '127.0.0.1');
INSERT INTO `loginrecord` VALUES ('admin', 429, '2022-11-10 10:54:47', '192.168.118.55');

-- ----------------------------
-- Table structure for mainmenu
-- ----------------------------
DROP TABLE IF EXISTS `mainmenu`;
CREATE TABLE `mainmenu`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 700 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mainmenu
-- ----------------------------
INSERT INTO `mainmenu` VALUES (50, '个人中心', '/self');
INSERT INTO `mainmenu` VALUES (100, '权限管理', '/admin');
INSERT INTO `mainmenu` VALUES (200, '选题管理', '/use');
INSERT INTO `mainmenu` VALUES (300, '学生中心', '/stu');
INSERT INTO `mainmenu` VALUES (400, '访问记录', '/log');
INSERT INTO `mainmenu` VALUES (500, '公告栏', '/notice');
INSERT INTO `mainmenu` VALUES (600, '学生答疑', '/comment');
INSERT INTO `mainmenu` VALUES (700, '日程安排', '/date');

-- ----------------------------
-- Table structure for noticelist
-- ----------------------------
DROP TABLE IF EXISTS `noticelist`;
CREATE TABLE `noticelist`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `state` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10030 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of noticelist
-- ----------------------------
INSERT INTO `noticelist` VALUES (10019, '2022-09-19 :06:07:41', '在规定的时间内上报可参加第一次答辩的学生名单，凡不能参加的学\r\n生第一次毕业答辩成绩为不合格（学院有二次答辩，成绩不合格者可\r\n继续参加第二次答辩）。\r\n', 1);
INSERT INTO `noticelist` VALUES (10020, '2022-09-19 :06:14:12', '课题汇总表提交结束后录入知网查重系统生成学生查重用户名、密码，\r\n并下发至指导老师（教务办执行，已下发，在专业带头人及教研室主\r\n任群中）。\r\n', 1);
INSERT INTO `noticelist` VALUES (10021, '2022-09-23 :09:34:06', '毕业设计的抽检名单从各二级学院提交的《常州信息职业技术学院毕\r\n业设计（论文）情况汇总表》中按2%的比例随机产生。（包括可参加第\r\n一次答辩和不能参加第一次答辩的学生）。\r\n', 1);
INSERT INTO `noticelist` VALUES (10022, '2022-09-23 :09:34:24', '如学校抽检到不能参加第一次答辩的学生，答辩成绩即为不合\r\n格，并会从学生中继续抽取直到符合人数为止。\r\n', 1);
INSERT INTO `noticelist` VALUES (10026, '2022-10-26 :02:07:32', '凡在学校抽检中成绩不合格的，等待学校组织的第二次毕业答辩抽检。', 1);

-- ----------------------------
-- Table structure for reference
-- ----------------------------
DROP TABLE IF EXISTS `reference`;
CREATE TABLE `reference`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `aname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参考文献名字',
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者',
  `publication` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出版社',
  `date` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出版时间',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reference
-- ----------------------------
INSERT INTO `reference` VALUES (1, 'Spring Boot编程思想(核心篇)', '小马哥', '电子工业出版社', '2019-04-01', '专著');
INSERT INTO `reference` VALUES (2, 'Spring Boot企业级开发教程', '黑马程序员', '人民邮电出版社', '2019-09-01', '专著');
INSERT INTO `reference` VALUES (3, 'Java EE框架应用开发（SpringBoot+VueJS）', '无', '机械工业出版社', '	2021-10-10', '专著');
INSERT INTO `reference` VALUES (4, 'Java Web程序设计任务教程', '黑马程序员', '人民邮电出版社', '2019-09-01', '专著');
INSERT INTO `reference` VALUES (5, 'Spring Boot实战', '克雷格·沃斯', '人民邮电出版社', '2019-10-01', '专著');
INSERT INTO `reference` VALUES (6, 'Spring微服务实战(第2版)', '约翰·卡内尔', '人民邮电出版社', '2022-05', '专著');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `roleId` int(0) NOT NULL,
  `roleName` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sort` int(0) NULL DEFAULT NULL,
  `status` tinyint(0) NULL DEFAULT NULL,
  `ps` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`roleId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '管理员', 1, 1, '负责添加用户，角色修改、权限、题目审核等');
INSERT INTO `role` VALUES (2, '教师', 2, 1, '添加选题');
INSERT INTO `role` VALUES (3, '学生', 3, 1, '选题，查看选题');
INSERT INTO `role` VALUES (4, '游客', 4, 1, '通过注册页面注册的角色');

-- ----------------------------
-- Table structure for rolemenu
-- ----------------------------
DROP TABLE IF EXISTS `rolemenu`;
CREATE TABLE `rolemenu`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `roleId` int(0) NULL DEFAULT NULL,
  `menuid` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `roleId`(`roleId`) USING BTREE,
  INDEX `menuid`(`menuid`) USING BTREE,
  CONSTRAINT `rolemenu_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `rolemenu_ibfk_2` FOREIGN KEY (`menuid`) REFERENCES `submenu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 904 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rolemenu
-- ----------------------------
INSERT INTO `rolemenu` VALUES (849, 4, 103);
INSERT INTO `rolemenu` VALUES (871, 1, 103);
INSERT INTO `rolemenu` VALUES (872, 1, 101);
INSERT INTO `rolemenu` VALUES (873, 1, 102);
INSERT INTO `rolemenu` VALUES (874, 1, 201);
INSERT INTO `rolemenu` VALUES (875, 1, 202);
INSERT INTO `rolemenu` VALUES (876, 1, 203);
INSERT INTO `rolemenu` VALUES (877, 1, 301);
INSERT INTO `rolemenu` VALUES (878, 1, 302);
INSERT INTO `rolemenu` VALUES (879, 1, 303);
INSERT INTO `rolemenu` VALUES (880, 1, 304);
INSERT INTO `rolemenu` VALUES (881, 1, 305);
INSERT INTO `rolemenu` VALUES (882, 1, 306);
INSERT INTO `rolemenu` VALUES (883, 1, 401);
INSERT INTO `rolemenu` VALUES (884, 1, 402);
INSERT INTO `rolemenu` VALUES (885, 1, 501);
INSERT INTO `rolemenu` VALUES (886, 1, 502);
INSERT INTO `rolemenu` VALUES (887, 1, 601);
INSERT INTO `rolemenu` VALUES (888, 1, 602);
INSERT INTO `rolemenu` VALUES (889, 1, 701);
INSERT INTO `rolemenu` VALUES (890, 2, 103);
INSERT INTO `rolemenu` VALUES (891, 2, 202);
INSERT INTO `rolemenu` VALUES (892, 2, 303);
INSERT INTO `rolemenu` VALUES (893, 2, 305);
INSERT INTO `rolemenu` VALUES (894, 2, 501);
INSERT INTO `rolemenu` VALUES (895, 2, 601);
INSERT INTO `rolemenu` VALUES (896, 2, 702);
INSERT INTO `rolemenu` VALUES (897, 3, 103);
INSERT INTO `rolemenu` VALUES (898, 3, 301);
INSERT INTO `rolemenu` VALUES (899, 3, 302);
INSERT INTO `rolemenu` VALUES (900, 3, 304);
INSERT INTO `rolemenu` VALUES (901, 3, 306);
INSERT INTO `rolemenu` VALUES (902, 3, 501);
INSERT INTO `rolemenu` VALUES (903, 3, 601);
INSERT INTO `rolemenu` VALUES (904, 3, 702);

-- ----------------------------
-- Table structure for source
-- ----------------------------
DROP TABLE IF EXISTS `source`;
CREATE TABLE `source`  (
  `sid` int(0) NOT NULL AUTO_INCREMENT,
  `cid` int(0) NOT NULL COMMENT '选题id',
  `username` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '选题人名称',
  PRIMARY KEY (`sid`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  CONSTRAINT `cid` FOREIGN KEY (`cid`) REFERENCES `course` (`cid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `username` FOREIGN KEY (`username`) REFERENCES `easyuser` (`username`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 83 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for submenu
-- ----------------------------
DROP TABLE IF EXISTS `submenu`;
CREATE TABLE `submenu`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mid` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mid`(`mid`) USING BTREE,
  CONSTRAINT `submenu_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `mainmenu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 702 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of submenu
-- ----------------------------
INSERT INTO `submenu` VALUES (101, '用户权限', '/user', 100);
INSERT INTO `submenu` VALUES (102, '角色权限', '/rights', 100);
INSERT INTO `submenu` VALUES (103, '个人信息', '/info', 50);
INSERT INTO `submenu` VALUES (201, '选题审核', '/verify', 200);
INSERT INTO `submenu` VALUES (202, '个人选题', '/course', 200);
INSERT INTO `submenu` VALUES (203, '所有选题', '/allCourse', 200);
INSERT INTO `submenu` VALUES (301, '题目选择', '/source', 300);
INSERT INTO `submenu` VALUES (302, '我的选题', '/mycourse', 300);
INSERT INTO `submenu` VALUES (303, '论文查看', '/download', 300);
INSERT INTO `submenu` VALUES (304, '论文提交', '/upload', 300);
INSERT INTO `submenu` VALUES (305, '文献管理', '/manageReference', 300);
INSERT INTO `submenu` VALUES (306, '参考文献', '/reference', 300);
INSERT INTO `submenu` VALUES (401, '访问次数', '/visit', 400);
INSERT INTO `submenu` VALUES (402, '访问列表', '/visitor', 400);
INSERT INTO `submenu` VALUES (501, '查看公告', '/announce', 500);
INSERT INTO `submenu` VALUES (502, '公告管理', '/manage', 500);
INSERT INTO `submenu` VALUES (601, '学生留言', '/comment', 600);
INSERT INTO `submenu` VALUES (602, '问答管理', '/manageComment', 600);
INSERT INTO `submenu` VALUES (701, '日程管理', '/calendar', 700);
INSERT INTO `submenu` VALUES (702, '查看日程', '/lookCalendar', 700);

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `trueName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `birth` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `idcard` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uname`(`username`) USING BTREE,
  CONSTRAINT `uname` FOREIGN KEY (`username`) REFERENCES `easyuser` (`username`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES (4, '石博老师', 'teacher1', '男', '1985-10-10T16:00:00.000Z', '南京', '110', '123456123456789123');
INSERT INTO `user_info` VALUES (5, '管理员', 'admin', '女', '2002-03-11T16:00:00.000Z', '江苏徐州', '18552893312', '123456987123321546');
INSERT INTO `user_info` VALUES (6, 'zzz', 'student1', '男', '2022-09-12T16:00:00.000Z', '常州', '18552893312', '320304');
INSERT INTO `user_info` VALUES (7, '伊泽瑞尔', 'system', '男', '2022-10-18T16:00:00.000Z', '战争学院', '110', '探险家不需要身份证');

SET FOREIGN_KEY_CHECKS = 1;
