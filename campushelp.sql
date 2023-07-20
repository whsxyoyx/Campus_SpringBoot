/*
 Navicat Premium Data Transfer

 Source Server         : MySQL5.5
 Source Server Type    : MySQL
 Source Server Version : 50560 (5.5.60)
 Source Host           : localhost:3306
 Source Schema         : campushelp

 Target Server Type    : MySQL
 Target Server Version : 50560 (5.5.60)
 File Encoding         : 65001

 Date: 20/07/2023 11:33:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `aid` int(6) NOT NULL AUTO_INCREMENT,
  `account` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '123456',
  `name` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'name',
  `addtime` datetime NOT NULL,
  `state` int(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`aid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', '欧阳炫', '2023-02-22 23:16:41', 0);
INSERT INTO `admin` VALUES (2, 'root', 'root', '炫仔', '2023-02-23 13:17:27', 1);
INSERT INTO `admin` VALUES (3, 'xuan', '123456', '炫炫', '2023-04-13 15:47:02', 0);
INSERT INTO `admin` VALUES (6, 'xuan', '123456', '靓仔', '2023-07-18 16:11:05', 0);

-- ----------------------------
-- Table structure for daily
-- ----------------------------
DROP TABLE IF EXISTS `daily`;
CREATE TABLE `daily`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gain` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `question` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `suggest` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `subtime` datetime NOT NULL,
  `lastupdatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sid` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of daily
-- ----------------------------
INSERT INTO `daily` VALUES (5, '干就完了', '啊啊啊啊啊啊', '不要慌，有我在', '2023-02-23 14:04:19', '2023-07-18 15:59:09', 2);
INSERT INTO `daily` VALUES (6, '鱼鱼鱼鱼鱼鱼鱼', '噫噫噫噫噫噫', '呜呜呜呜呜', '2023-02-23 14:04:56', '2023-04-13 11:11:02', 2);
INSERT INTO `daily` VALUES (8, '隔俄国', '回复', '受到攻击', '2023-02-23 14:27:12', '2023-04-13 11:11:02', 7);
INSERT INTO `daily` VALUES (9, '1', '1', '1', '2023-04-05 11:22:15', '2023-04-13 11:11:02', 11);
INSERT INTO `daily` VALUES (13, 'dd', 'dd', 'dd', '2023-04-05 16:28:10', '2023-04-13 11:11:02', 3);
INSERT INTO `daily` VALUES (14, '0', '0', '0', '2023-04-07 15:43:51', '2023-04-13 11:11:02', 5);
INSERT INTO `daily` VALUES (15, '111', '111', '111', '2023-04-07 19:42:51', '2023-04-13 11:11:02', 5);
INSERT INTO `daily` VALUES (16, '22', '22', '22', '2023-04-12 20:54:37', '2023-04-13 11:11:02', 1);
INSERT INTO `daily` VALUES (17, 'efefg', 'dfg', 'efwf', '2023-04-13 11:49:34', '2023-04-13 11:49:34', 1);
INSERT INTO `daily` VALUES (19, '干就完了', '马上就要就业了，害怕', '不要慌，有我在111', '2023-07-18 16:02:30', '2023-07-18 16:02:45', 1);

-- ----------------------------
-- Table structure for reply_comment
-- ----------------------------
DROP TABLE IF EXISTS `reply_comment`;
CREATE TABLE `reply_comment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '回复表id',
  `task_id` bigint(20) NULL DEFAULT NULL COMMENT '任务id',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回复的内容',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回复者用户名',
  `createtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '回复评论的创建时间',
  `reply_id` bigint(20) NULL DEFAULT NULL COMMENT '要回复一级评论的评论id',
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回复者的图像',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of reply_comment
-- ----------------------------
INSERT INTO `reply_comment` VALUES (1, 76, '11111', '欧阳炫', '2023-04-07 10:57:48', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (2, 76, '22222', '欧阳炫', '2023-04-07 10:57:52', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (3, 76, '3333', '欧阳炫', '2023-04-07 11:25:58', 2, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (4, 76, '4444', '欧阳炫', '2023-04-07 11:26:03', 2, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (5, 76, 'pppp', '洪付群', '2023-04-07 13:37:24', 1, 'http://localhost:8080/Campus_Help/upload/d07d6b6f-34fa-43f5-ad9b-dda55968c102.jpg');
INSERT INTO `reply_comment` VALUES (6, 76, '你好呀', '洪付群', '2023-04-07 14:18:13', 3, 'http://localhost:8080/Campus_Help/upload/d07d6b6f-34fa-43f5-ad9b-dda55968c102.jpg');
INSERT INTO `reply_comment` VALUES (7, 76, '0000', '洪付群', '2023-04-07 14:19:30', 1, 'http://localhost:8080/Campus_Help/upload/d07d6b6f-34fa-43f5-ad9b-dda55968c102.jpg');
INSERT INTO `reply_comment` VALUES (8, 76, '9999', '洪付群', '2023-04-07 14:19:41', 2, 'http://localhost:8080/Campus_Help/upload/d07d6b6f-34fa-43f5-ad9b-dda55968c102.jpg');
INSERT INTO `reply_comment` VALUES (9, 76, '耶耶耶耶耶', '洪付群', '2023-04-07 14:24:44', 5, 'http://localhost:8080/Campus_Help/upload/d07d6b6f-34fa-43f5-ad9b-dda55968c102.jpg');
INSERT INTO `reply_comment` VALUES (10, 76, '我来啦，我的小伙伴', '唐文登', '2023-04-07 14:43:50', 5, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg');
INSERT INTO `reply_comment` VALUES (11, 75, '嘿咻嘿咻', '唐文登', '2023-04-07 14:44:49', 6, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg');
INSERT INTO `reply_comment` VALUES (12, 75, '嘿咻嘿咻', '唐文登', '2023-04-07 14:45:01', 6, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg');
INSERT INTO `reply_comment` VALUES (13, 75, 'lll', '唐文登', '2023-04-07 14:45:58', 6, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg');
INSERT INTO `reply_comment` VALUES (14, 76, '嘿咻嘿咻', '唐文登', '2023-04-07 14:46:09', 5, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg');
INSERT INTO `reply_comment` VALUES (15, 75, '嘿咻嘿咻', '唐文登', '2023-04-07 14:47:36', 7, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg');
INSERT INTO `reply_comment` VALUES (16, 76, '胖哥，咋啦，几天不打开始飘了？', '欧阳炫', '2023-04-07 14:51:55', 8, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (17, 61, '你一定不会介意的吧', '欧阳炫', '2023-04-07 15:16:05', 9, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (18, 77, '111', '欧阳炫', '2023-04-07 15:34:18', 10, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (19, 77, 'hei boy,you are very newbee', '余杭', '2023-04-07 15:36:15', 11, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg');
INSERT INTO `reply_comment` VALUES (20, 77, '谢谢', '欧阳炫', '2023-04-07 15:37:06', 12, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (21, 76, '本up主都没说话，先请大家都静一静，我想说一句。\n我最newbee', '李刚', '2023-04-07 15:40:48', 8, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg');
INSERT INTO `reply_comment` VALUES (22, 77, '我也很newbee', '李刚', '2023-04-07 19:31:59', 12, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg');
INSERT INTO `reply_comment` VALUES (23, 77, '我也可以直接按enter键回复你啦', '欧阳炫', '2023-04-07 20:14:55', 27, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (24, 78, '很棒', '余杭', '2023-04-08 09:24:38', 28, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg');
INSERT INTO `reply_comment` VALUES (25, 1, '333', '欧阳炫', '2023-04-12 16:53:36', 32, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (26, 1, '444', '欧阳炫', '2023-04-12 16:53:40', 32, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (27, 1, '555', '欧阳炫', '2023-04-12 16:53:44', 32, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (28, 1, '666', '欧阳炫', '2023-04-12 16:53:55', 32, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (29, 82, '222', '欧阳炫', '2023-04-12 19:37:12', 33, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (30, 88, '666', '欧阳炫', '2023-04-13 11:31:02', 35, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (31, 88, '777', '欧阳炫', '2023-04-13 11:31:08', 35, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (32, 88, '888', '欧阳炫', '2023-04-13 11:31:11', 35, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (33, 89, 'ddd', '欧阳炫', '2023-04-13 11:49:17', 37, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (34, 90, 'sd', '欧阳炫', '2023-04-13 11:53:25', 39, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (35, 90, 'hhhh', '欧阳炫', '2023-04-13 14:03:10', 39, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (36, 90, '5555', '欧阳炫', '2023-04-13 14:04:27', 39, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (37, 90, '哈哈哈哈', '欧阳炫', '2023-04-13 14:04:44', 39, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (38, 76, '谢谢刚子', '欧阳炫', '2023-04-13 16:35:40', 13, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (39, 92, 'test回复', '欧阳炫', '2023-04-14 11:24:55', 40, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (40, 93, '炫炫', '欧阳炫', '2023-04-28 19:00:51', 41, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (41, 93, '炫炫', '欧阳炫', '2023-05-06 19:28:37', 42, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (42, 93, '百合无限好', '欧阳炫', '2023-05-06 19:28:42', 42, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (43, 95, '慌啊啊啊啊啊', '欧阳炫', '2023-05-10 18:41:24', 43, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (44, 17, '11', '欧阳炫', '2023-05-10 18:49:33', 45, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (45, 96, '看见黄瓜', '欧阳炫', '2023-05-10 19:57:16', 46, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (46, 93, '333', '欧阳炫', '2023-05-11 12:27:24', 48, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (47, 94, '不要慌，看我操作', '欧阳炫', '2023-05-11 18:53:53', 49, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (48, 95, '111', '欧阳炫', '2023-05-13 16:27:27', 50, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (49, 95, '谢谢', '欧阳炫', '2023-05-14 00:08:03', 51, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `reply_comment` VALUES (50, 98, '加油，奥里给！！！', '洪付群', '2023-05-17 19:00:02', 53, 'http://localhost:8080/Campus_Help/upload/d07d6b6f-34fa-43f5-ad9b-dda55968c102.jpg');

-- ----------------------------
-- Table structure for school
-- ----------------------------
DROP TABLE IF EXISTS `school`;
CREATE TABLE `school`  (
  `schoolid` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'schoolname',
  `addtime` datetime NOT NULL,
  `state` int(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`schoolid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of school
-- ----------------------------
INSERT INTO `school` VALUES (1, '荆楚理工学院', '2023-02-22 23:17:07', 0);
INSERT INTO `school` VALUES (2, '武汉商学院', '2023-02-23 13:13:26', 0);
INSERT INTO `school` VALUES (3, '北京大学', '2023-02-23 13:13:32', 0);
INSERT INTO `school` VALUES (4, '清华大学', '2023-02-23 13:13:58', 0);
INSERT INTO `school` VALUES (5, '上海复旦大学', '2023-02-23 13:14:36', 0);
INSERT INTO `school` VALUES (6, '武汉大学', '2023-02-23 13:14:43', 0);
INSERT INTO `school` VALUES (7, '华中科技大学', '2023-02-23 13:15:00', 0);
INSERT INTO `school` VALUES (8, '南京大学', '2023-02-23 13:15:37', 0);
INSERT INTO `school` VALUES (9, '武汉理工大学', '2023-02-23 13:15:52', 0);
INSERT INTO `school` VALUES (10, '武汉音乐学院', '2023-02-23 13:16:05', 0);
INSERT INTO `school` VALUES (12, '武汉轻工大学', '2023-02-23 13:16:38', 0);
INSERT INTO `school` VALUES (13, '湖北工业大学', '2023-03-22 18:54:11', 0);
INSERT INTO `school` VALUES (16, '华中师范大学', '2023-04-13 15:44:26', 0);

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task`  (
  `taskid` int(11) NOT NULL AUTO_INCREMENT,
  `publish_user_id` varchar(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发布用户学号',
  `publish_user_name` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发布者学生名字',
  `publish_school_id` int(6) NOT NULL COMMENT '发布用户学校ID',
  `accept_user_id` int(11) NOT NULL DEFAULT 0 COMMENT '接受者id',
  `reward` double(30, 0) NOT NULL DEFAULT 0 COMMENT '任务奖励',
  `addtime` datetime NOT NULL COMMENT '发布时间',
  `endtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `taskname` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `taskcontext` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务描述',
  `state` int(2) NOT NULL DEFAULT 0 COMMENT '任务状态',
  `tasktype` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务类型',
  `img` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg' COMMENT '任务中用户提交的图片',
  PRIMARY KEY (`taskid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES (1, '2', '洪付群', 1, 0, 0, '2023-02-23 13:26:31', '2023-04-05 14:26:45', '电脑便宜处理了', '华为笔记本买到就是赚到', 0, '二手交易', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (2, '2', '洪付群', 1, 0, 0, '2023-02-23 13:29:07', '2023-04-05 14:26:45', 'Java不会求大佬带', '佬带菜', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (3, '1', '欧阳炫', 1, 0, 0, '2023-02-23 13:31:31', '2023-04-05 14:26:45', '学校附近有啥好吃的啊', '大一新生刚报道，求告知', 0, '外出游玩', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (4, '2', '洪付群', 1, 0, 0, '2023-02-23 14:05:25', '2023-04-05 14:26:45', '是否能不公', '的发挥，离开发短信', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (6, '2', '洪付群', 1, 0, 0, '2023-02-23 14:05:37', '2023-04-05 14:26:45', '的发挥空间发短信', '都赋予它热电厂v', 0, '宠物领养', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (7, '2', '洪付群', 1, 1, 10, '2023-02-23 14:05:44', '2023-04-05 14:26:45', '会计那边v的色如太阳金牛', '肉体与可能被v发的', 2, '二手交易', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (9, '2', '洪付群', 1, 0, 0, '2023-02-23 14:06:18', '2023-04-05 14:26:45', '立刻脚后跟的的法国海军', '人推一桶热水', 0, '外出游玩', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (10, '2', '洪付群', 1, 0, 0, '2023-02-23 14:06:25', '2023-04-05 14:26:45', '夫i哦可结合', '二号机韩国', 0, '快递代取', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (12, '2', '洪付群', 1, 0, 0, '2023-02-23 14:06:56', '2023-04-05 14:26:45', '法国和加拿大是', '油然而生的成本和犹太人的', 0, '宠物领养', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (13, '2', '洪付群', 1, 0, 0, '2023-02-23 14:07:07', '2023-04-05 14:26:45', 'OK慕尼黑房地产v吧', '二体看你发的', 0, '快递代取', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (14, '2', '洪付群', 1, 0, 0, '2023-02-23 14:07:14', '2023-04-05 14:26:45', '开办费v就会变的很v和', '多看几遍v卡巴', 0, '宠物领养', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (15, '2', '洪付群', 1, 3, 0, '2023-02-23 14:07:26', '2023-04-05 14:26:45', '，马车上的覅藕色伯爵', '豆瓣第四你覅都', 2, '学习辅导', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (17, '3', '余杭', 3, 0, 10, '2023-02-23 14:11:02', '2023-04-05 14:26:45', '杭杭想考研', '有妹子一起冲的吗', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (18, '3', '余杭', 3, 0, 0, '2023-02-23 14:11:38', '2023-04-05 14:26:45', '杭杭想出去浪', '有妹子一起吗', 0, '外出游玩', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (19, '4', '唐文登', 4, 0, 0, '2023-02-23 14:14:39', '2023-04-05 10:42:52', '胖哥为清华代言人', '我是清华代言人', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (25, '5', '李刚', 5, 0, 0, '2023-02-23 14:17:42', '2023-04-05 10:42:52', '让用户的人', 'u热水地方官员太热', 0, '二手交易', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (26, '5', '李刚', 5, 0, 0, '2023-02-23 14:17:52', '2023-04-05 10:42:52', 'k\'y\'r\'f\'h\'j\'d', '的法国海军内部的撒擦', 0, '宠物领养', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (27, '5', '李刚', 5, 0, 0, '2023-02-23 14:18:00', '2023-04-05 10:42:52', '科技部参数对比', 'vii哦i哦爱哦v不是都', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (28, '5', '李刚', 5, 0, 0, '2023-02-23 14:18:09', '2023-04-05 10:42:52', '卡的巨大九年级', '保健科大夫', 0, '快递代取', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (29, '5', '李刚', 5, 0, 0, '2023-02-23 14:18:18', '2023-04-05 10:42:52', '包括飓风的v卡迪夫空间', '案件滴哦道具ii发', 0, '外出游玩', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (30, '6', '马骏虎', 7, 0, 0, '2023-02-23 14:22:22', '2023-04-05 10:42:52', '虎子哥来了 你们还不跪下', '天佑我虎子哥', 0, '外出游玩', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (31, '7', '炫仔', 9, 0, 0, '2023-02-23 14:26:02', '2023-04-05 10:42:52', '我炫仔 做梦也想不到', '我能考上武汉理工大学', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (32, '1', '欧阳炫', 1, 0, 0, '2023-03-21 19:42:59', '2023-04-05 10:42:52', '斌斌在学习啊ZZZZ', '斌斌你一定行', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (33, '1', '欧阳炫', 1, 0, 0, '2023-04-04 13:29:29', '2023-04-05 10:42:52', '测试连带图片地址上传到MySQL', '也不知道结果怎样', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (35, '1', '欧阳炫', 1, 0, 0, '2023-04-04 13:37:18', '2023-04-05 10:42:52', '科技很发达', '非官方的发', 0, '快递代取', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (36, '1', '欧阳炫', 1, 0, 0, '2023-04-04 13:39:49', '2023-04-05 10:42:45', '的非官方', '太化股份', 0, '快递代取', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (37, '1', '欧阳炫', 1, 0, 0, '2023-04-04 13:41:30', '2023-04-05 10:42:44', '那边v从', '从v吧v从', 0, '快递代取', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (38, '1', '欧阳炫', 1, 0, 0, '2023-04-04 13:42:44', '2023-04-05 10:42:44', '法规规范d', 'd打打点', 0, '快递代取', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (40, '1', '欧阳炫', 1, 0, 0, '2023-04-04 13:49:11', '2023-04-05 10:42:43', '22', '33', 0, '外出游玩', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (48, '1', '欧阳炫', 1, 0, 0, '2023-04-04 14:47:16', '2023-04-04 15:30:26', '日日日日', '帆帆帆帆', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/6dea6db2-3280-44da-949f-5e426615fc29.jpg');
INSERT INTO `task` VALUES (53, '1', '欧阳炫', 1, 0, 0, '2023-04-04 15:37:40', '2023-04-04 15:37:40', 'bckjsbdvkjd', 'sdfghj,', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/9859b9bf-95eb-4068-8e12-084edd9bf2d5.jpg http://localhost:8080/Campus_Help/upload/c3a073c6-a339-49b0-9932-7b3f3faa45a5.jpg http://localhost:8080/Campus_Help/upload/a7b2714e-90c2-426f-a966-1826b17b2d62.png');
INSERT INTO `task` VALUES (55, '1', '欧阳炫', 1, 5, 0, '2023-04-04 15:50:55', '2023-04-04 15:50:55', '测试图片上传', '测试', 2, '二手交易', 'http://localhost:8080/Campus_Help/upload/4a19a064-a7ad-4e02-9b2e-5a4adfd02251.jpg http://localhost:8080/Campus_Help/upload/76976b03-43b4-46c9-add4-a6e5b8f7a621.jpg http://localhost:8080/Campus_Help/upload/f0c994de-6436-4a87-922b-3626ba2e9b06.jpg http://localhost:8080/Campus_Help/upload/78dde2da-ae82-40a9-8c65-a75474a70549.jpg http://localhost:8080/Campus_Help/upload/b775347a-9e9b-4d52-8d44-1ad438968bec.png');
INSERT INTO `task` VALUES (56, '1', '欧阳炫', 1, 0, 0, '2023-04-04 16:31:52', '2023-04-05 10:42:42', '测试文件上传呃呃呃呃呃', '测试文件上传wawawwwaw', 0, '二手交易', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (58, '7', '炫仔', 9, 0, 0, '2023-04-04 18:41:04', '2023-04-05 10:42:42', '炫仔在武汉', '唱、跳、rap、篮球', 0, '外出游玩', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (59, '1', '欧阳炫', 1, 0, 0, '2023-04-04 18:54:41', '2023-04-05 10:42:41', 'BBBBB', '的风格和规范', 0, '宠物领养', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (60, '1', '欧阳炫', 1, 0, 0, '2023-04-04 18:55:00', '2023-04-04 18:55:00', 'AAAAA', '的肉体和规范', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/9cab6028-bee3-4ff6-bcc5-651411213682.jpg http://localhost:8080/Campus_Help/upload/9cb03dba-0220-4c01-8728-17256e689855.jpg http://localhost:8080/Campus_Help/upload/dc53051f-401f-48c6-b9bc-768e764e022d.jpg http://localhost:8080/Campus_Help/upload/0b14f5ea-3d7f-445c-885e-2ef089bf896a.jpg');
INSERT INTO `task` VALUES (61, '1', '欧阳炫', 1, 0, 0, '2023-04-04 19:19:08', '2023-04-04 19:19:08', '阿の百川', '活该你单身', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/305444d0-503a-4b5d-9422-44774f8f7f84.jpg http://localhost:8080/Campus_Help/upload/81380413-eb01-4ccc-b3cd-493a6c057043.jpg http://localhost:8080/Campus_Help/upload/002e4800-4ab8-42bd-9aaf-b2d42bdf347d.jpg http://localhost:8080/Campus_Help/upload/5863b124-4935-4a19-bad7-0a9c9fff8e2b.jpg http://localhost:8080/Campus_Help/upload/e6c3e502-b913-47ea-80da-61de3fea632c.jpg');
INSERT INTO `task` VALUES (62, '1', '欧阳炫', 1, 5, 0, '2023-04-04 19:21:20', '2023-04-05 10:42:40', '我要起飞', '豆腐干反对', 2, '恋爱专家', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (63, '1', '欧阳炫', 1, 0, 0, '2023-04-04 19:23:53', '2023-04-05 10:42:39', '色弱他人的v', '犯得上地方', 0, '外出游玩', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (64, '1', '欧阳炫', 1, 5, 0, '2023-04-04 19:37:16', '2023-04-04 19:37:16', '活到老，学到老', '就会被', 2, '外出游玩', 'http://localhost:8080/Campus_Help/upload/4f694823-9359-451c-b487-b3980d6bdca9.jpg http://localhost:8080/Campus_Help/upload/d07d6b6f-34fa-43f5-ad9b-dda55968c102.jpg http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg http://localhost:8080/Campus_Help/upload/fd64b490-87f8-4c9e-b4b2-b027bfb80125.jpg http://localhost:8080/Campus_Help/upload/ced3f4a2-01b1-450b-a5bf-d93b36343921.jpg http://localhost:8080/Campus_Help/upload/00c4e314-0ac5-4c61-b42f-71ed53be5a42.jpg');
INSERT INTO `task` VALUES (65, '1', '欧阳炫', 1, 11, 0, '2023-04-05 09:32:59', '2023-04-05 09:32:59', '测试', 'test', 2, '外出游玩', 'http://localhost:8080/Campus_Help/upload/bfe8f1c5-be98-4d9d-affb-ae952871ac6e.jpg http://localhost:8080/Campus_Help/upload/590be087-61c7-4e4d-b6b8-6e93085a1541.jpg http://localhost:8080/Campus_Help/upload/b1cf4760-c0bc-44be-893a-113e057d0a1e.jpg http://localhost:8080/Campus_Help/upload/877740e5-bd9d-47c1-96e8-80d09a552fdd.jpg http://localhost:8080/Campus_Help/upload/b44de836-e131-45d7-96ba-18057aa034a7.jpg http://localhost:8080/Campus_Help/upload/16fe85c0-aa58-44d9-a0bd-9049c5bd77a4.jpg');
INSERT INTO `task` VALUES (66, '1', '欧阳炫', 1, 0, 0, '2023-04-05 09:34:43', '2023-04-05 09:34:43', '顶顶顶顶', '事实上仿佛', 1, '二手交易', 'http://localhost:8080/Campus_Help/upload/e234302c-9fc6-4f9e-a2d8-75522e338bbf.jpg');
INSERT INTO `task` VALUES (67, '1', '欧阳炫', 1, 11, 0, '2023-04-05 10:42:22', '2023-04-05 10:42:22', '活该你单身', '哈哈哈哈', 2, '二手交易', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (68, '1', '欧阳炫', 1, 0, 0, '2023-04-05 10:43:26', '2023-04-05 10:43:45', '是的风格和规范', '的法国队', 0, '快递代取', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (69, '1', '欧阳炫', 1, 11, 0, '2023-04-05 10:46:07', '2023-04-05 10:51:53', '詞條', '葡萄糖', 2, '学习辅导', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (70, '1', '欧阳炫', 1, 0, 0, '2023-04-05 10:50:46', '2023-04-05 10:51:56', '的煩煩煩', '77777', 0, '二手交易', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (71, '1', '欧阳炫', 1, 11, 0, '2023-04-05 10:56:13', '2023-04-05 10:56:13', '打打点', '顶顶顶顶', 2, '外出游玩', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (72, '11', '靓仔在这', 4, 0, 0, '2023-04-05 11:17:07', '2023-04-05 11:17:07', '我来啦，快来找我啊', '哈哈哈哈', 1, '二手交易', 'http://localhost:8080/Campus_Help/upload/aa3627bd-686c-4640-89ee-f39ca766ec6a.jpg http://localhost:8080/Campus_Help/upload/e17cc01d-462f-4f77-bbf7-ab3ec949e731.jpg http://localhost:8080/Campus_Help/upload/f0ea0336-3f59-444a-bd36-ac77fc37a41f.jpg http://localhost:8080/Campus_Help/upload/a93b5a9a-8569-4b36-8ab4-ad6ec7b36c51.jpg http://localhost:8080/Campus_Help/upload/c6d69b02-08d2-4c6f-9df4-24f60565f4c5.jpg http://localhost:8080/Campus_Help/upload/d26bb43c-e0e7-45af-b878-7fbc3b82663e.jpg');
INSERT INTO `task` VALUES (73, '1', '欧阳炫', 1, 0, 0, '2023-04-05 18:55:59', '2023-04-05 18:55:59', '谷歌', '反反复复烦烦烦', 0, '恋爱专家', 'http://localhost:8080/Campus_Help/upload/8eaee189-c55e-4319-b886-be8e5227612d.jpg');
INSERT INTO `task` VALUES (74, '1', '欧阳炫', 1, 0, 0, '2023-04-05 21:01:30', '2023-04-05 21:01:30', '后台任务图片放大显示（测试成功）', 'test 耶耶耶耶', 0, '外出游玩', 'http://localhost:8080/Campus_Help/upload/fc930c91-7df0-4c62-a17a-ca92d1798c77.jpg http://localhost:8080/Campus_Help/upload/78cbaf06-d99f-4b27-9f52-fffeb9acfc11.jpg http://localhost:8080/Campus_Help/upload/85e01c21-2a48-4952-8619-a73a07d1244a.jpg http://localhost:8080/Campus_Help/upload/46542739-f020-4bfe-83c5-81c2d076dc1c.jpg http://localhost:8080/Campus_Help/upload/1aa0e960-84ce-46ee-99bc-22b086851ca1.jpg http://localhost:8080/Campus_Help/upload/7ce36827-439f-4533-9380-11f61a879e6e.jpg');
INSERT INTO `task` VALUES (75, '5', '李刚', 5, 0, 10, '2023-04-06 13:36:24', '2023-04-06 13:36:24', '学校附近有啥好玩的地方啊', 'please tell me', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/0f2a5935-b563-458f-abc6-3dbdc46eb2a2.jpg http://localhost:8080/Campus_Help/upload/9ebed02f-ebe9-4fb8-9e50-72803190f25f.jpg http://localhost:8080/Campus_Help/upload/1aa5e032-0d89-411a-ba6e-1672679b4bc4.jpg http://localhost:8080/Campus_Help/upload/39d11f2c-33d9-4481-b0dc-410affb985e8.jpg http://localhost:8080/Campus_Help/upload/8febab83-55d1-49e0-9408-33ae5be477fd.jpg');
INSERT INTO `task` VALUES (76, '5', '李刚', 5, 0, 10, '2023-04-06 13:39:34', '2023-04-06 13:39:34', '我是一条只有三秒钟记忆的鱼', '所有请不要伤害我', 0, '宠物领养', 'http://localhost:8080/Campus_Help/upload/e0856d52-74a8-4abc-8d9a-b3825e08033e.jpg http://localhost:8080/Campus_Help/upload/7c921174-77ab-49aa-8fa3-555b6739623a.jpg http://localhost:8080/Campus_Help/upload/9c9c24ca-bbd2-4833-91a3-9382948173a4.jpg http://localhost:8080/Campus_Help/upload/47f76db8-11d1-41bb-a014-e638f2039767.jpg http://localhost:8080/Campus_Help/upload/2a4aed7f-686d-4ffe-9aaf-c328fac43e9f.jpg http://localhost:8080/Campus_Help/upload/6708d995-3dfb-4f5f-91f0-00c8ec67684e.jpg');
INSERT INTO `task` VALUES (77, '1', '欧阳炫', 1, 0, 0, '2023-04-07 15:22:59', '2023-04-07 15:22:59', '毕设完成啦', '开心啊', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/ab7c3ed3-3ba3-489d-88a6-3b0d65092799.png http://localhost:8080/Campus_Help/upload/f1af896a-b4e8-447e-9986-4c61a5afa2d6.jpg http://localhost:8080/Campus_Help/upload/d2184c89-3140-4286-8d44-72787b82f5b0.jpg http://localhost:8080/Campus_Help/upload/3c378f4a-5684-47f7-b76e-3d209233eab4.jpg http://localhost:8080/Campus_Help/upload/79be7faf-6c64-423e-8d5b-b1f229142725.jpg http://localhost:8080/Campus_Help/upload/83993a90-2d24-49d6-b376-e9442ddf3773.jpg');
INSERT INTO `task` VALUES (78, '1', '欧阳炫', 1, 0, 0, '2023-04-07 20:18:09', '2023-04-07 20:18:09', '开始肝论文了，兄弟们替我加油啊', '我把我最喜欢的几张图都给你们了，替我加油好吗', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (80, '5', '李刚', 5, 0, 0, '2023-04-08 10:50:01', '2023-04-08 10:50:01', 'test成功', '哈哈哈', 1, '二手交易', 'http://localhost:8080/Campus_Help/upload/9e440bed-b8cd-481c-b855-01740ed611b3.jpg http://localhost:8080/Campus_Help/upload/4e4c6311-c709-4681-985c-d0effe4901f6.jpg http://localhost:8080/Campus_Help/upload/f844ff68-da79-457b-8a79-1d7a1165c8a2.jpg http://localhost:8080/Campus_Help/upload/cc86357e-d49f-42c7-8ec1-3c64c9274e74.jpg http://localhost:8080/Campus_Help/upload/d018b6f1-9c21-4a1c-bb59-8eae68ebe5b8.jpg http://localhost:8080/Campus_Help/upload/992eb663-f604-4352-937f-76955d259981.jpg');
INSERT INTO `task` VALUES (81, '1', '欧阳炫', 1, 0, 0, '2023-04-12 16:52:01', '2023-04-12 16:52:01', '1111', '1111', 0, '二手交易', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (83, '1', '欧阳炫', 1, 0, 0, '2023-04-12 20:49:35', '2023-04-12 20:49:35', '11', '11', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/e9fd9909-8e98-411e-8af6-b749b710e323.jpg');
INSERT INTO `task` VALUES (84, '1', '欧阳炫', 1, 0, 0, '2023-04-12 20:54:04', '2023-04-12 20:54:04', '222', '22', 0, '恋爱专家', 'http://localhost:8080/Campus_Help/upload/2c1741d3-0bf5-4dbd-9bf3-0085ef24f4de.jpg');
INSERT INTO `task` VALUES (85, '1', '欧阳炫', 1, 0, 0, '2023-04-12 21:03:01', '2023-04-12 21:03:01', '11', '111', 0, '外出游玩', 'http://localhost:8080/Campus_Help/upload/6895bbe9-e062-4a8f-b503-b1e436ea2a96.jpg');
INSERT INTO `task` VALUES (86, '1', '欧阳炫', 1, 0, 0, '2023-04-12 21:05:05', '2023-04-12 21:05:05', '123456', 'dfd', 0, '二手交易', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (87, '1', '欧阳炫', 1, 0, 0, '2023-04-13 11:30:27', '2023-04-13 11:30:27', '111', '222', 0, '快递代取', 'http://localhost:8080/Campus_Help/upload/11062c00-77dc-4feb-8879-b6ec77e7331c.png');
INSERT INTO `task` VALUES (88, '1', '欧阳炫', 1, 0, 0, '2023-04-13 11:30:48', '2023-04-13 11:30:48', '333', '444', 0, '二手交易', 'http://localhost:8080/Campus_Help/upload/8b505b2f-990b-4b83-b712-9bb1906a085e.jpg http://localhost:8080/Campus_Help/upload/fd519f1d-dc02-4a15-99fd-0554f42559cc.jpg');
INSERT INTO `task` VALUES (89, '1', '欧阳炫', 1, 0, 0, '2023-04-13 11:49:10', '2023-04-13 11:49:10', '333', 'ddd', 0, '宠物领养', 'http://localhost:8080/Campus_Help/upload/27fe92a9-d293-4108-b223-53dff553d88e.jpg http://localhost:8080/Campus_Help/upload/2f36d509-b399-4e9c-9431-3f77a1f9d392.jpg http://localhost:8080/Campus_Help/upload/007dc0c7-046f-42e0-82a0-ed29353166c5.jpg http://localhost:8080/Campus_Help/upload/b3113774-8d2a-4251-84b5-8cd3cf4081ec.jpg http://localhost:8080/Campus_Help/upload/8cd765a0-071c-4c54-a7e8-82d25cd9f753.jpg');
INSERT INTO `task` VALUES (90, '1', '欧阳炫', 1, 0, 0, '2023-04-13 11:53:15', '2023-04-13 11:53:15', '1111', '11111', 0, '快递代取', 'http://localhost:8080/Campus_Help/upload/1990f889-85ed-48fc-ad08-334b26f0b221.jpg http://localhost:8080/Campus_Help/upload/7b02e0ee-1552-46bc-b351-cbccd5d99c3f.jpg http://localhost:8080/Campus_Help/upload/4e6a8e2a-ac78-4bbb-8e98-813897eecfd8.jpg http://localhost:8080/Campus_Help/upload/e684cf5f-f6e6-4012-8fa5-3eacb28f9875.jpg http://localhost:8080/Campus_Help/upload/c1b2b40b-1ebe-4bf6-b8a8-6d920a5371ba.jpg http://localhost:8080/Campus_Help/upload/a515599e-486b-4d3e-9d55-970cbfe0175f.jpg');
INSERT INTO `task` VALUES (91, '1', '欧阳炫', 1, 0, 0, '2023-04-13 16:56:17', '2023-04-13 16:56:17', '我要吃饭啊', '肚子好饿啊，受不了了啊。', 0, '外出游玩', 'http://localhost:8080/Campus_Help/upload/45fe24b9-47b4-4387-8cf8-8dd050b8c908.jpg http://localhost:8080/Campus_Help/upload/ba27ea96-72e1-4629-b8af-665d4a8ca972.jpg http://localhost:8080/Campus_Help/upload/b0c7ae0d-7389-450a-886c-045d45f19bad.jpg http://localhost:8080/Campus_Help/upload/3fb19b73-7f92-4e82-b5ca-d7bbb90bd3a0.jpg http://localhost:8080/Campus_Help/upload/758f4cf5-9bfd-4cbc-8fd4-61953d1a519e.jpg http://localhost:8080/Campus_Help/upload/ddd55b46-2291-4187-9be9-79ef2cad1c1b.jpg');
INSERT INTO `task` VALUES (92, '1', '欧阳炫', 1, 0, 0, '2023-04-14 11:19:25', '2023-04-14 11:19:25', '测试任务发布', 'test', 0, '二手交易', 'http://localhost:8080/Campus_Help/upload/9a3e0a99-5917-4567-95a1-59cc2528f1e8.jpg http://localhost:8080/Campus_Help/upload/93a9739d-cac4-4960-8d63-19b40e79ced6.jpg');
INSERT INTO `task` VALUES (93, '1', '欧阳炫', 1, 0, 0, '2023-04-28 19:00:15', '2023-04-28 19:00:15', '炫仔来咯ooo啊啊啊', '2222', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/4f130683-470e-4a3e-b61d-5ffb07ad5a6e.jpg http://localhost:8080/Campus_Help/upload/deaea014-50a4-4114-a2d2-65055b41801c.jpg http://localhost:8080/Campus_Help/upload/1c7112a1-37cb-431b-8bbf-f81adedeac83.jpg http://localhost:8080/Campus_Help/upload/6c6db1ce-b7a7-495b-9c42-2a4f32801729.jpg http://localhost:8080/Campus_Help/upload/59f3627c-7b77-43fa-9c81-35471abf08f1.jpg');
INSERT INTO `task` VALUES (94, '2', '洪付群', 1, 0, 30, '2023-05-11 12:31:13', '2023-05-11 12:31:13', '要答辩了，救命', '我该怎么办，现在好慌啊', 0, '心理咨询', 'http://localhost:8080/Campus_Help/upload/beafa5c1-cc1e-4feb-9122-59e85cc1d1fe.jpg http://localhost:8080/Campus_Help/upload/ee55b3d7-45c2-4929-9b51-8b669abdb1a5.jpg http://localhost:8080/Campus_Help/upload/80d7b1a6-e43f-4f4d-86a9-0660399b7426.jpg http://localhost:8080/Campus_Help/upload/2d16bb33-b64b-40d6-b7de-e1c845723398.jpg http://localhost:8080/Campus_Help/upload/8c4ad93c-d965-4306-ad1f-61da0b4bb8ac.jpg http://localhost:8080/Campus_Help/upload/d1a0cb44-4c4a-4ceb-ab33-8266b9be55fd.jpg');
INSERT INTO `task` VALUES (95, '1', '欧阳炫', 1, 0, 30, '2023-05-11 12:36:44', '2023-05-11 12:36:44', '快毕业了，激动啊!!!', '激动的心，颤抖的手', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/c0e4a0ac-8e5e-4129-bbbf-8ee9ab701b86.jpg http://localhost:8080/Campus_Help/upload/2f3d4a65-ddb4-49ff-90d1-7af236f393ea.jpg http://localhost:8080/Campus_Help/upload/405695e0-b1f9-4bef-a848-6ec15d5929f4.jpg http://localhost:8080/Campus_Help/upload/fef999a8-8e91-4e21-a12c-f097463ce876.jpg');
INSERT INTO `task` VALUES (96, '1', '欧阳炫', 1, 0, 0, '2023-05-14 10:32:04', '2023-05-14 10:32:04', '111', '1111', 0, '宠物领养', 'http://localhost:8080/Campus_Help/upload/d931ac40-333f-4ed6-a87e-a726a48e3ed5.jpg http://localhost:8080/Campus_Help/upload/633b66b8-aba4-4c93-b0c3-c5a29771d7ce.jpg');
INSERT INTO `task` VALUES (97, '1', '欧阳炫', 1, 0, 0, '2023-05-14 10:32:34', '2023-05-14 10:32:34', '2222', '222', 0, '心理咨询', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (98, '1', '欧阳炫', 1, 0, 0, '2023-05-17 18:56:03', '2023-05-17 18:56:03', '毕业啦', '为了梦想，加油！', 0, '外出游玩', 'http://localhost:8080/Campus_Help/upload/4d8c990b-840d-4c4e-880b-76cbed446b4d.jpg http://localhost:8080/Campus_Help/upload/8e0e8d64-fd21-4503-8ecf-ca5977f6ec92.jpg http://localhost:8080/Campus_Help/upload/cd3fa068-e697-48d0-bad5-a148f131ddb0.jpg http://localhost:8080/Campus_Help/upload/7146bbfa-fba2-4b81-8070-bc41562b9eac.jpg http://localhost:8080/Campus_Help/upload/84ce9cd3-f805-4d4f-95c6-022fac4ad02a.jpg');
INSERT INTO `task` VALUES (99, '2', '洪付群', 1, 0, 0, '2023-05-17 19:55:51', '2023-05-17 19:55:51', '111', '11', 0, '二手交易', 'http://localhost:8080/Campus_Help/upload/8c253b9d-068b-44ab-a57d-e2c873a3096a.png http://localhost:8080/Campus_Help/upload/6562f4d6-c403-4294-8cdb-521c149871e0.jpg http://localhost:8080/Campus_Help/upload/ad327880-035b-40b7-98a6-3d57394d71ad.jpg');
INSERT INTO `task` VALUES (100, '2', '洪付群', 1, 0, 0, '2023-05-17 19:56:14', '2023-05-17 19:56:14', '22', '22', 0, '宠物领养', 'http://localhost:8080/Campus_Help/upload/502323b1-3cfa-4534-b070-dc97026ab33c.jpg');
INSERT INTO `task` VALUES (101, '2', '洪付群', 1, 0, 0, '2023-05-17 19:56:23', '2023-05-17 19:56:23', '33', '33', 0, '学习辅导', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (102, '2', '洪付群', 1, 0, 0, '2023-05-17 19:56:32', '2023-05-17 19:56:32', '44', '44', 0, '宠物领养', 'http://localhost:8080/Campus_Help/upload/83a770a9-f331-4b5f-b737-bdbb9023b439.jpg');
INSERT INTO `task` VALUES (103, '2', '洪付群', 1, 0, 0, '2023-05-17 19:57:01', '2023-05-17 19:57:01', '55', '55', 0, '外出游玩', 'http://localhost:8080/Campus_Help/upload/5383265a-af4c-4117-9756-37c955b56181.jpg');

-- ----------------------------
-- Table structure for task_comment
-- ----------------------------
DROP TABLE IF EXISTS `task_comment`;
CREATE TABLE `task_comment`  (
  `common_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `task_id` bigint(20) NULL DEFAULT NULL COMMENT '任务ID',
  `userName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论的用户名',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户（评论者）ID',
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论内容',
  `parent_comment_id` bigint(11) NULL DEFAULT NULL COMMENT '父评论ID----该字段被废弃',
  `createtime` datetime NULL DEFAULT NULL COMMENT '评论时间',
  `updatetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `target` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目标名----该字段被废弃',
  PRIMARY KEY (`common_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of task_comment
-- ----------------------------
INSERT INTO `task_comment` VALUES (1, 76, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '你好', -1, '2023-04-07 10:56:37', '2023-04-07 10:56:37', NULL);
INSERT INTO `task_comment` VALUES (2, 76, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '我好', -1, '2023-04-07 10:56:52', '2023-04-07 10:56:52', NULL);
INSERT INTO `task_comment` VALUES (3, 76, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '大家好', -1, '2023-04-07 10:56:59', '2023-04-07 10:56:59', NULL);
INSERT INTO `task_comment` VALUES (4, 76, '洪付群', 2, 'http://localhost:8080/Campus_Help/upload/d07d6b6f-34fa-43f5-ad9b-dda55968c102.jpg', '你好', -1, '2023-04-07 14:20:20', '2023-04-07 14:20:20', NULL);
INSERT INTO `task_comment` VALUES (5, 76, '洪付群', 2, 'http://localhost:8080/Campus_Help/upload/d07d6b6f-34fa-43f5-ad9b-dda55968c102.jpg', '评论功能成功啦', -1, '2023-04-07 14:24:35', '2023-04-07 14:24:35', NULL);
INSERT INTO `task_comment` VALUES (6, 75, '唐文登', 4, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg', '耶耶耶耶耶耶', -1, '2023-04-07 14:44:27', '2023-04-07 14:44:27', NULL);
INSERT INTO `task_comment` VALUES (7, 75, '唐文登', 4, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg', '222', -1, '2023-04-07 14:45:52', '2023-04-07 14:45:52', NULL);
INSERT INTO `task_comment` VALUES (8, 76, '唐文登', 4, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg', '我敢说在座的各位都是渣渣', -1, '2023-04-07 14:51:16', '2023-04-07 14:51:16', NULL);
INSERT INTO `task_comment` VALUES (9, 61, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '图我要来，不介意吧', -1, '2023-04-07 15:15:49', '2023-04-07 15:15:49', NULL);
INSERT INTO `task_comment` VALUES (10, 77, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '各位这个时间点，毕设应该都完成了吧', -1, '2023-04-07 15:23:26', '2023-04-07 15:23:26', NULL);
INSERT INTO `task_comment` VALUES (11, 77, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '耶耶耶', -1, '2023-04-07 15:35:24', '2023-04-07 15:35:24', NULL);
INSERT INTO `task_comment` VALUES (12, 77, '余杭', 3, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg', 'newbee-plus up主', -1, '2023-04-07 15:36:49', '2023-04-07 15:36:49', NULL);
INSERT INTO `task_comment` VALUES (13, 76, '李刚', 5, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg', '感谢大家捧场，本人刚刚子，以后有出息了，一定不会忘记文八510的各位，特别是我们的炫炫。', -1, '2023-04-07 15:42:55', '2023-04-07 15:42:55', NULL);
INSERT INTO `task_comment` VALUES (14, 64, '李刚', 5, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg', '好看啊，图我偷了', -1, '2023-04-07 19:36:17', '2023-04-07 19:36:17', NULL);
INSERT INTO `task_comment` VALUES (15, 62, '李刚', 5, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg', '111', -1, '2023-04-07 19:41:53', '2023-04-07 19:41:53', NULL);
INSERT INTO `task_comment` VALUES (16, 62, '李刚', 5, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg', '111', -1, '2023-04-07 19:42:07', '2023-04-07 19:42:07', NULL);
INSERT INTO `task_comment` VALUES (17, 75, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', 'test', -1, '2023-04-07 19:54:17', '2023-04-07 19:54:17', NULL);
INSERT INTO `task_comment` VALUES (18, 75, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '22222', NULL, '2023-04-07 20:03:05', '2023-04-07 20:03:05', NULL);
INSERT INTO `task_comment` VALUES (19, 75, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '323333', NULL, '2023-04-07 20:04:35', '2023-04-07 20:04:35', NULL);
INSERT INTO `task_comment` VALUES (20, 75, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '44444', NULL, '2023-04-07 20:04:39', '2023-04-07 20:04:39', NULL);
INSERT INTO `task_comment` VALUES (21, 75, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '777', -1, '2023-04-07 20:06:13', '2023-04-07 20:06:13', NULL);
INSERT INTO `task_comment` VALUES (22, 75, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '4444', -1, '2023-04-07 20:08:01', '2023-04-07 20:08:01', NULL);
INSERT INTO `task_comment` VALUES (23, 75, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '555', -1, '2023-04-07 20:12:08', '2023-04-07 20:12:08', NULL);
INSERT INTO `task_comment` VALUES (24, 75, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', 'k', -1, '2023-04-07 20:13:03', '2023-04-07 20:13:03', NULL);
INSERT INTO `task_comment` VALUES (25, 75, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '哈哈哈哈哈', NULL, '2023-04-07 20:13:07', '2023-04-07 20:13:07', NULL);
INSERT INTO `task_comment` VALUES (26, 75, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '呼呼呼呼呼', NULL, '2023-04-07 20:13:12', '2023-04-07 20:13:12', NULL);
INSERT INTO `task_comment` VALUES (27, 77, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '不用点击提交按钮，按enter键也可以提交评论了，哈哈哈哈', -1, '2023-04-07 20:13:46', '2023-04-07 20:13:46', NULL);
INSERT INTO `task_comment` VALUES (28, 78, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '都很快乐', -1, '2023-04-08 09:19:18', '2023-04-08 09:19:18', NULL);
INSERT INTO `task_comment` VALUES (29, 55, '余杭', 3, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg', '百合无限好', -1, '2023-04-08 09:27:52', '2023-04-08 09:27:52', NULL);
INSERT INTO `task_comment` VALUES (30, 80, '李刚', 5, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg', 'ok', -1, '2023-04-08 10:50:14', '2023-04-08 10:50:14', NULL);
INSERT INTO `task_comment` VALUES (31, 78, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', 'hhh', -1, '2023-04-12 16:51:09', '2023-04-12 16:51:09', NULL);
INSERT INTO `task_comment` VALUES (32, 1, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '222', -1, '2023-04-12 16:53:30', '2023-04-12 16:53:30', NULL);
INSERT INTO `task_comment` VALUES (33, 82, '百合无限好', 12, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg', '111', -1, '2023-04-12 19:36:41', '2023-04-12 19:36:41', NULL);
INSERT INTO `task_comment` VALUES (34, 82, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '2222', -1, '2023-04-12 19:37:08', '2023-04-12 19:37:08', NULL);
INSERT INTO `task_comment` VALUES (35, 88, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '555', -1, '2023-04-13 11:30:58', '2023-04-13 11:30:58', NULL);
INSERT INTO `task_comment` VALUES (36, 88, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '999', NULL, '2023-04-13 11:31:16', '2023-04-13 11:31:16', NULL);
INSERT INTO `task_comment` VALUES (37, 89, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', 'ddd', -1, '2023-04-13 11:49:15', '2023-04-13 11:49:15', NULL);
INSERT INTO `task_comment` VALUES (38, 89, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', 'fgd', NULL, '2023-04-13 11:49:19', '2023-04-13 11:49:19', NULL);
INSERT INTO `task_comment` VALUES (39, 90, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', 'hapkan', -1, '2023-04-13 11:53:22', '2023-04-13 11:53:22', NULL);
INSERT INTO `task_comment` VALUES (40, 92, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', 'test', -1, '2023-04-14 11:24:43', '2023-04-14 11:24:43', NULL);
INSERT INTO `task_comment` VALUES (41, 93, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '欢迎大家来评论', -1, '2023-04-28 19:00:31', '2023-04-28 19:00:31', NULL);
INSERT INTO `task_comment` VALUES (42, 93, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '你丫的', -1, '2023-05-06 19:28:24', '2023-05-06 19:28:24', NULL);
INSERT INTO `task_comment` VALUES (43, 95, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '不要慌', -1, '2023-05-10 18:41:17', '2023-05-10 18:41:17', NULL);
INSERT INTO `task_comment` VALUES (44, 7, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '快捷回复', -1, '2023-05-10 18:45:49', '2023-05-10 18:45:49', NULL);
INSERT INTO `task_comment` VALUES (45, 17, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '我我我', -1, '2023-05-10 18:49:26', '2023-05-10 18:49:26', NULL);
INSERT INTO `task_comment` VALUES (46, 96, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '巨化股份', -1, '2023-05-10 19:57:12', '2023-05-10 19:57:12', NULL);
INSERT INTO `task_comment` VALUES (47, 93, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '111', -1, '2023-05-10 20:00:46', '2023-05-10 20:00:46', NULL);
INSERT INTO `task_comment` VALUES (48, 93, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '222', -1, '2023-05-11 12:27:21', '2023-05-11 12:27:21', NULL);
INSERT INTO `task_comment` VALUES (49, 94, '洪付群', 2, 'http://localhost:8080/Campus_Help/upload/d07d6b6f-34fa-43f5-ad9b-dda55968c102.jpg', '求大神指导', -1, '2023-05-11 12:33:23', '2023-05-11 12:33:23', NULL);
INSERT INTO `task_comment` VALUES (50, 95, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '加油', -1, '2023-05-13 16:27:17', '2023-05-13 16:27:17', NULL);
INSERT INTO `task_comment` VALUES (51, 95, '洪付群', 2, 'http://localhost:8080/Campus_Help/upload/d07d6b6f-34fa-43f5-ad9b-dda55968c102.jpg', '加油！！！', -1, '2023-05-14 00:07:13', '2023-05-14 00:07:13', NULL);
INSERT INTO `task_comment` VALUES (52, 95, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '111', -1, '2023-05-14 10:31:12', '2023-05-14 10:31:12', NULL);
INSERT INTO `task_comment` VALUES (53, 98, '欧阳炫', 1, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg', '给自己打气！！！', -1, '2023-05-17 18:59:07', '2023-05-17 18:59:07', NULL);

-- ----------------------------
-- Table structure for tasktype
-- ----------------------------
DROP TABLE IF EXISTS `tasktype`;
CREATE TABLE `tasktype`  (
  `addtime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `tasktype` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tasktype
-- ----------------------------
INSERT INTO `tasktype` VALUES ('2023-02-23 13:11:43', '二手交易');
INSERT INTO `tasktype` VALUES ('2023-02-23 13:11:57', '宠物领养');
INSERT INTO `tasktype` VALUES ('2023-02-23 13:12:04', '学习辅导');
INSERT INTO `tasktype` VALUES ('2023-02-23 13:12:29', '快递代取');
INSERT INTO `tasktype` VALUES ('2023-02-23 14:20:19', '外出游玩');
INSERT INTO `tasktype` VALUES ('2023-04-04 19:18:54', '恋爱交流');
INSERT INTO `tasktype` VALUES ('2023-04-13 17:04:28', '心理咨询');
INSERT INTO `tasktype` VALUES ('2023-07-18 19:58:57', '失物招领');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `stuid` int(11) NOT NULL AUTO_INCREMENT,
  `studentid` varchar(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '学号',
  `password` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `schoolid` int(6) NOT NULL,
  `sex` int(2) NOT NULL DEFAULT 0,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'name',
  `registertime` datetime NOT NULL COMMENT '注册时间',
  `money` double(20, 0) NOT NULL DEFAULT 0,
  `state` int(2) NOT NULL DEFAULT 0,
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg',
  PRIMARY KEY (`stuid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '2021204010222', '111111', 1, 0, '欧阳炫', '2023-02-22 23:17:31', 970, 0, 'http://localhost:8080/Campus_Help/upload/2652cdbc-1581-4d29-9302-8415f0375af2.jpg');
INSERT INTO `user` VALUES (2, '2021204010223', '123456', 1, 0, '洪付群', '2023-02-23 13:03:35', 370, 0, 'http://localhost:8080/Campus_Help/upload/d07d6b6f-34fa-43f5-ad9b-dda55968c102.jpg');
INSERT INTO `user` VALUES (3, '2021204010224', '111111', 3, 0, '余杭', '2023-02-23 14:09:40', 40, 0, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg');
INSERT INTO `user` VALUES (4, '2021204010225', '111111', 4, 0, '唐文登', '2023-02-23 14:13:23', 50, 0, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg');
INSERT INTO `user` VALUES (5, '2021204010226', '111111', 5, 0, '李刚', '2023-02-23 14:15:34', 30, 1, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg');
INSERT INTO `user` VALUES (6, '2021204010227', '111111', 7, 0, '马骏虎', '2023-02-23 14:21:23', 50, 1, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg');
INSERT INTO `user` VALUES (7, '2021204010228', '111111', 9, 0, '炫仔', '2023-02-23 14:25:00', 50, 1, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg');
INSERT INTO `user` VALUES (8, '2021204010229', '2021204010229', 10, 0, '炫炫最帅', '2023-02-23 14:30:34', 5201314, 1, 'http://localhost:8080/Campus_Help/upload/942d99d7-1dd9-46ce-9278-94df86c98bad.jpg');

SET FOREIGN_KEY_CHECKS = 1;
