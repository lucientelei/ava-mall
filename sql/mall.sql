/*
 Navicat Premium Data Transfer

 Source Server         : local-mysql
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : mall

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 12/09/2021 22:11:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cms_help
-- ----------------------------
DROP TABLE IF EXISTS `cms_help`;
CREATE TABLE `cms_help`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) NULL DEFAULT NULL,
  `icon` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `show_status` int(1) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `read_count` int(1) NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '帮助表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_help
-- ----------------------------

-- ----------------------------
-- Table structure for cms_help_category
-- ----------------------------
DROP TABLE IF EXISTS `cms_help_category`;
CREATE TABLE `cms_help_category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类图标',
  `help_count` int(11) NULL DEFAULT NULL COMMENT '专题数量',
  `show_status` int(2) NULL DEFAULT NULL,
  `sort` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '帮助分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_help_category
-- ----------------------------

-- ----------------------------
-- Table structure for cms_member_report
-- ----------------------------
DROP TABLE IF EXISTS `cms_member_report`;
CREATE TABLE `cms_member_report`  (
  `id` bigint(20) NULL DEFAULT NULL,
  `report_type` int(1) NULL DEFAULT NULL COMMENT '举报类型：0->商品评价；1->话题内容；2->用户评论',
  `report_member_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '举报人',
  `create_time` datetime NULL DEFAULT NULL,
  `report_object` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `report_status` int(1) NULL DEFAULT NULL COMMENT '举报状态：0->未处理；1->已处理',
  `handle_status` int(1) NULL DEFAULT NULL COMMENT '处理结果：0->无效；1->有效；2->恶意',
  `note` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户举报表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_member_report
-- ----------------------------

-- ----------------------------
-- Table structure for cms_prefrence_area
-- ----------------------------
DROP TABLE IF EXISTS `cms_prefrence_area`;
CREATE TABLE `cms_prefrence_area`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sub_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pic` varbinary(500) NULL DEFAULT NULL COMMENT '展示图片',
  `sort` int(11) NULL DEFAULT NULL,
  `show_status` int(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '优选专区' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_prefrence_area
-- ----------------------------
INSERT INTO `cms_prefrence_area` VALUES (1, '让音质更出众', '音质不打折 完美现场感', NULL, NULL, 1);
INSERT INTO `cms_prefrence_area` VALUES (2, '让音质更出众22', '让音质更出众22', NULL, NULL, NULL);
INSERT INTO `cms_prefrence_area` VALUES (3, '让音质更出众33', NULL, NULL, NULL, NULL);
INSERT INTO `cms_prefrence_area` VALUES (4, '让音质更出众44', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for cms_prefrence_area_product_relation
-- ----------------------------
DROP TABLE IF EXISTS `cms_prefrence_area_product_relation`;
CREATE TABLE `cms_prefrence_area_product_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `prefrence_area_id` bigint(20) NULL DEFAULT NULL,
  `product_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '优选专区和产品关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_prefrence_area_product_relation
-- ----------------------------
INSERT INTO `cms_prefrence_area_product_relation` VALUES (1, 1, 12);
INSERT INTO `cms_prefrence_area_product_relation` VALUES (2, 1, 13);
INSERT INTO `cms_prefrence_area_product_relation` VALUES (3, 1, 14);
INSERT INTO `cms_prefrence_area_product_relation` VALUES (4, 1, 18);
INSERT INTO `cms_prefrence_area_product_relation` VALUES (5, 1, 7);
INSERT INTO `cms_prefrence_area_product_relation` VALUES (6, 2, 7);
INSERT INTO `cms_prefrence_area_product_relation` VALUES (7, 1, 22);
INSERT INTO `cms_prefrence_area_product_relation` VALUES (24, 1, 23);

-- ----------------------------
-- Table structure for cms_subject
-- ----------------------------
DROP TABLE IF EXISTS `cms_subject`;
CREATE TABLE `cms_subject`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) NULL DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pic` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专题主图',
  `product_count` int(11) NULL DEFAULT NULL COMMENT '关联产品数量',
  `recommend_status` int(1) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `collect_count` int(11) NULL DEFAULT NULL,
  `read_count` int(11) NULL DEFAULT NULL,
  `comment_count` int(11) NULL DEFAULT NULL,
  `album_pics` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '画册图片用逗号分割',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `show_status` int(1) NULL DEFAULT NULL COMMENT '显示状态：0->不显示；1->显示',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `forward_count` int(11) NULL DEFAULT NULL COMMENT '转发数',
  `category_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专题分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '专题表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_subject
-- ----------------------------
INSERT INTO `cms_subject` VALUES (1, 1, 'polo衬衫的也时尚', NULL, NULL, NULL, '2018-11-11 13:26:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '服装专题');
INSERT INTO `cms_subject` VALUES (2, 2, '大牌手机低价秒', NULL, NULL, NULL, '2018-11-12 13:27:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '手机专题');
INSERT INTO `cms_subject` VALUES (3, 2, '晓龙845新品上市', NULL, NULL, NULL, '2018-11-13 13:27:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '手机专题');
INSERT INTO `cms_subject` VALUES (4, 1, '夏天应该穿什么', NULL, NULL, NULL, '2018-11-01 13:27:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '服装专题');
INSERT INTO `cms_subject` VALUES (5, 1, '夏季精选', NULL, NULL, NULL, '2018-11-06 13:27:18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '服装专题');
INSERT INTO `cms_subject` VALUES (6, 2, '品牌手机降价', NULL, NULL, NULL, '2018-11-07 13:27:21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '手机专题');

-- ----------------------------
-- Table structure for cms_subject_category
-- ----------------------------
DROP TABLE IF EXISTS `cms_subject_category`;
CREATE TABLE `cms_subject_category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类图标',
  `subject_count` int(11) NULL DEFAULT NULL COMMENT '专题数量',
  `show_status` int(2) NULL DEFAULT NULL,
  `sort` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '专题分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_subject_category
-- ----------------------------
INSERT INTO `cms_subject_category` VALUES (1, '服装专题', NULL, NULL, NULL, NULL);
INSERT INTO `cms_subject_category` VALUES (2, '手机专题', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for cms_subject_comment
-- ----------------------------
DROP TABLE IF EXISTS `cms_subject_comment`;
CREATE TABLE `cms_subject_comment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `subject_id` bigint(20) NULL DEFAULT NULL,
  `member_nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `member_icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `show_status` int(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '专题评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_subject_comment
-- ----------------------------

-- ----------------------------
-- Table structure for cms_subject_product_relation
-- ----------------------------
DROP TABLE IF EXISTS `cms_subject_product_relation`;
CREATE TABLE `cms_subject_product_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `subject_id` bigint(20) NULL DEFAULT NULL,
  `product_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '专题商品关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_subject_product_relation
-- ----------------------------
INSERT INTO `cms_subject_product_relation` VALUES (1, 1, 12);
INSERT INTO `cms_subject_product_relation` VALUES (2, 1, 13);
INSERT INTO `cms_subject_product_relation` VALUES (3, 1, 14);
INSERT INTO `cms_subject_product_relation` VALUES (4, 1, 18);
INSERT INTO `cms_subject_product_relation` VALUES (5, 1, 7);
INSERT INTO `cms_subject_product_relation` VALUES (6, 2, 7);
INSERT INTO `cms_subject_product_relation` VALUES (7, 1, 22);
INSERT INTO `cms_subject_product_relation` VALUES (29, 1, 23);
INSERT INTO `cms_subject_product_relation` VALUES (30, 4, 23);
INSERT INTO `cms_subject_product_relation` VALUES (31, 5, 23);
INSERT INTO `cms_subject_product_relation` VALUES (41, 2, 26);
INSERT INTO `cms_subject_product_relation` VALUES (42, 3, 26);
INSERT INTO `cms_subject_product_relation` VALUES (43, 6, 26);

-- ----------------------------
-- Table structure for cms_topic
-- ----------------------------
DROP TABLE IF EXISTS `cms_topic`;
CREATE TABLE `cms_topic`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `start_time` datetime NULL DEFAULT NULL,
  `end_time` datetime NULL DEFAULT NULL,
  `attend_count` int(11) NULL DEFAULT NULL COMMENT '参与人数',
  `attention_count` int(11) NULL DEFAULT NULL COMMENT '关注人数',
  `read_count` int(11) NULL DEFAULT NULL,
  `award_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '奖品名称',
  `attend_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参与方式',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '话题内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '话题表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_topic
-- ----------------------------

-- ----------------------------
-- Table structure for cms_topic_category
-- ----------------------------
DROP TABLE IF EXISTS `cms_topic_category`;
CREATE TABLE `cms_topic_category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类图标',
  `subject_count` int(11) NULL DEFAULT NULL COMMENT '专题数量',
  `show_status` int(2) NULL DEFAULT NULL,
  `sort` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '话题分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_topic_category
-- ----------------------------

-- ----------------------------
-- Table structure for cms_topic_comment
-- ----------------------------
DROP TABLE IF EXISTS `cms_topic_comment`;
CREATE TABLE `cms_topic_comment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `topic_id` bigint(20) NULL DEFAULT NULL,
  `member_icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `show_status` int(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '专题评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_topic_comment
-- ----------------------------

-- ----------------------------
-- Table structure for oms_cart_item
-- ----------------------------
DROP TABLE IF EXISTS `oms_cart_item`;
CREATE TABLE `oms_cart_item`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NULL DEFAULT NULL,
  `product_sku_id` bigint(20) NULL DEFAULT NULL,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `quantity` int(11) NULL DEFAULT NULL COMMENT '购买数量',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '添加到购物车的价格',
  `product_pic` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品主图',
  `product_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `product_sub_title` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品副标题（卖点）',
  `product_sku_code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品sku条码',
  `member_nickname` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员昵称',
  `create_date` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `modify_date` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `delete_status` int(1) NULL DEFAULT 0 COMMENT '是否删除',
  `product_category_id` bigint(20) NULL DEFAULT NULL COMMENT '商品分类',
  `product_brand` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_sn` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_attr` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品销售属性:[{\"key\":\"颜色\",\"value\":\"颜色\"},{\"key\":\"容量\",\"value\":\"4G\"}]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '购物车表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_cart_item
-- ----------------------------
INSERT INTO `oms_cart_item` VALUES (12, 26, 90, 1, 1, 3788.00, NULL, '华为 HUAWEI P20', 'AI智慧全面屏 6GB +64GB 亮黑色 全网通版 移动联通电信4G手机 双卡双待手机 双卡双待', '201806070026001', 'windir', '2018-08-27 16:53:44', NULL, 1, 19, NULL, NULL, NULL);
INSERT INTO `oms_cart_item` VALUES (13, 27, 98, 1, 3, 2699.00, NULL, '小米8', '骁龙845处理器，红外人脸解锁，AI变焦双摄，AI语音助手小米6X低至1299，点击抢购', '201808270027001', 'windir', '2018-08-27 17:11:53', NULL, 1, 19, NULL, NULL, NULL);
INSERT INTO `oms_cart_item` VALUES (14, 28, 102, 1, 1, 649.00, NULL, '红米5A', '8天超长待机，137g轻巧机身，高通骁龙处理器小米6X低至1299，点击抢购', '201808270028001', 'windir', '2018-08-27 17:18:02', NULL, 1, 19, NULL, NULL, NULL);
INSERT INTO `oms_cart_item` VALUES (15, 28, 103, 1, 1, 699.00, NULL, '红米5A', '8天超长待机，137g轻巧机身，高通骁龙处理器小米6X低至1299，点击抢购', '201808270028001', 'windir', '2018-08-28 10:22:45', NULL, 1, 19, NULL, NULL, NULL);
INSERT INTO `oms_cart_item` VALUES (16, 29, 106, 1, 1, 5499.00, NULL, 'Apple iPhone 8 Plus', '【限时限量抢购】Apple产品年中狂欢节，好物尽享，美在智慧！速来 >> 勾选[保障服务][原厂保2年]，获得AppleCare+全方位服务计划，原厂延保售后无忧。', '201808270029001', 'windir', '2018-08-28 10:50:50', NULL, 1, 19, NULL, NULL, NULL);
INSERT INTO `oms_cart_item` VALUES (19, 36, 163, 1, 3, 100.00, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg', '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码', '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码', '202002210036001', 'windir', '2020-02-25 15:51:59', NULL, 1, 29, 'NIKE', '6799345', '[{\"key\":\"颜色\",\"value\":\"红色\"},{\"key\":\"尺寸\",\"value\":\"38\"},{\"key\":\"风格\",\"value\":\"秋季\"}]');
INSERT INTO `oms_cart_item` VALUES (20, 36, 164, 1, 2, 120.00, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg', '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码', '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码', '202002210036001', 'windir', '2020-02-25 15:54:23', NULL, 1, 29, 'NIKE', '6799345', '[{\"key\":\"颜色\",\"value\":\"红色\"},{\"key\":\"尺寸\",\"value\":\"38\"},{\"key\":\"风格\",\"value\":\"夏季\"}]');
INSERT INTO `oms_cart_item` VALUES (21, 36, 164, 1, 2, 120.00, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg', '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码', '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码', '202002210036001', 'windir', '2020-02-25 16:49:53', NULL, 1, 29, 'NIKE', '6799345', '[{\"key\":\"颜色\",\"value\":\"红色\"},{\"key\":\"尺寸\",\"value\":\"38\"},{\"key\":\"风格\",\"value\":\"夏季\"}]');
INSERT INTO `oms_cart_item` VALUES (22, 36, 164, 10, 2, 120.00, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b19403eN9f0b3cb8.jpg', '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码', '耐克NIKE 男子 气垫 休闲鞋 AIR MAX 90 ESSENTIAL 运动鞋 AJ1285-101白色41码', '202002210036001', NULL, '2021-09-06 22:17:52', '2021-09-06 22:14:05', 1, 29, 'NIKE', '6799345', '');
INSERT INTO `oms_cart_item` VALUES (23, 26, 164, 10, 1, 3788.00, NULL, '华为 HUAWEI P20', 'AI智慧全面屏 6GB +64GB 亮黑色 全网通版 移动联通电信4G手机 双卡双待手机 双卡双待', '201806070026001', NULL, '2021-09-06 22:24:00', '2021-09-06 22:14:05', 1, 19, '华为', '6799345', '');
INSERT INTO `oms_cart_item` VALUES (24, 30, 179, 10, 1, 98.00, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5ad83a4fN6ff67ecd.jpg!cc_350x449.jpg', 'HLA海澜之家简约动物印花短袖T恤', '2018夏季新品微弹舒适新款短T男生 6月6日-6月20日，满300减30，参与互动赢百元礼券，立即分享赢大奖', '202002250035009', 'lucien_ssa', '2021-09-09 15:27:45', '2021-09-09 15:24:42', 1, 8, '海澜之家', '6799345', NULL);
INSERT INTO `oms_cart_item` VALUES (25, 28, 103, 10, 1, 649.00, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '小米 红米5A 全网通版 3GB+32GB 香槟金 移动联通电信4G手机 双卡双待', '8天超长待机，137g轻巧机身，高通骁龙处理器小米6X低至1299，点击抢购', '201808270028002', 'lucien_ssa', '2021-09-09 15:49:30', '2021-09-09 15:41:52', 1, 19, '小米', '7437789', NULL);
INSERT INTO `oms_cart_item` VALUES (26, 28, 103, 10, 1, 649.00, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '小米 红米5A 全网通版 3GB+32GB 香槟金 移动联通电信4G手机 双卡双待', '8天超长待机，137g轻巧机身，高通骁龙处理器小米6X低至1299，点击抢购', '201808270028002', 'lucien_ssa', '2021-09-09 17:04:22', '2021-09-09 17:04:06', 1, 19, '小米', '7437789', NULL);
INSERT INTO `oms_cart_item` VALUES (27, 28, 103, 10, 1, 649.00, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '小米 红米5A 全网通版 3GB+32GB 香槟金 移动联通电信4G手机 双卡双待', '8天超长待机，137g轻巧机身，高通骁龙处理器小米6X低至1299，点击抢购', '201808270028002', 'lucien_ssa', '2021-09-09 17:10:31', '2021-09-09 17:04:06', 1, 19, '小米', '7437789', NULL);
INSERT INTO `oms_cart_item` VALUES (28, 28, 103, 10, 1, 649.00, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '小米 红米5A 全网通版 3GB+32GB 香槟金 移动联通电信4G手机 双卡双待', '8天超长待机，137g轻巧机身，高通骁龙处理器小米6X低至1299，点击抢购', '201808270028002', 'lucien_ssa', '2021-09-09 17:13:49', '2021-09-09 17:04:06', 1, 19, '小米', '7437789', NULL);
INSERT INTO `oms_cart_item` VALUES (29, 38, 38, 10, 1, 599.00, 'https://img.alicdn.com/imgextra/i2/2865745622/O1CN01HfoCnq1rOvJbQlMA8_!!0-item_pic.jpg_430x430q90.jpg', '火影忍者手办 羁绊火焰宇智波鼬 佐助动漫手办模型摆件盒装礼品', '火影忍者手办 羁绊火焰宇智波鼬 佐助动漫手办模型摆件盒装礼品', '202109150027038', 'lucien_ssa', '2021-09-12 15:23:06', '2021-09-12 15:23:06', 1, 62, '范思哲', '6938233', NULL);
INSERT INTO `oms_cart_item` VALUES (30, 34, 34, 10, 1, 999.00, 'https://img.alicdn.com/imgextra/i1/1916629511/O1CN01mmZBhe2K85g7wOxfd_!!1916629511.jpg_430x430q90.jpg', '[全款预售]SEGA EVA新世纪福音战士剧场版终 明日香 景品手办', '[全款预售]SEGA EVA新世纪福音战士剧场版终 明日香 景品手办', '202109150027034', 'lucien_ssa', '2021-09-12 15:42:53', '2021-09-12 15:42:53', 1, 66, '范思哲', '5464542', NULL);
INSERT INTO `oms_cart_item` VALUES (31, 33, 33, 10, 1, 228.00, 'https://gd3.alicdn.com/imgextra/i3/3381629725/O1CN01QaB5cG2Li6E4KJn0M_!!3381629725.jpg_400x400.jpg', '海洋堂新世纪福音战士EVA成品初号机', '海洋堂新世纪福音战士EVA成品初号机', '202109150027033', 'lucien_ssa', '2021-09-12 17:43:28', '2021-09-12 17:43:28', 1, 66, '范思哲', '5435341', NULL);
INSERT INTO `oms_cart_item` VALUES (32, 27, 27, 10, 1, 5978.00, 'https://img.alicdn.com/imgextra/i1/2200877014436/O1CN016ekYBX1idjahukrhA_!!2200877014436.jpg_430x430q90.jpg', '索尼PS5主机 电视游戏机 无光驱版 超 蓝光8K 日版家用单机怪物', '索尼PS5主机 电视游戏机 无光驱版 超 蓝光8K 日版家用单机怪物', '202109150027027', 'lucien_ssa', '2021-09-12 19:21:29', '2021-09-12 19:21:29', 1, 36, '范思哲', '3532343', NULL);
INSERT INTO `oms_cart_item` VALUES (33, 26, 26, 10, 1, 1399.00, 'https://img.alicdn.com/imgextra/i4/647482297/O1CN01WcLlx41Sq4SglOLBs_!!647482297.jpg_430x430q90.jpg', 'Beats Solo Pro头戴式耳机无线蓝牙b魔音降噪运动耳麦高音质', 'Beats Solo Pro头戴式耳机无线蓝牙b魔音苹果降噪运动耳麦高音质', '202109150027026', 'lucien_ssa', '2021-09-12 19:29:40', '2021-09-12 19:29:40', 1, 35, '范思哲', '5352342', NULL);
INSERT INTO `oms_cart_item` VALUES (34, 16, 16, 10, 1, 7488.00, 'https://img.alicdn.com/imgextra/i4/2024314280/O1CN01mT2FdK1hUHrFa4LK6_!!2024314280.jpg_430x430q90.jpg', '【旗舰新品】华为P50 Pro 4G全网通搭载HarmonyOS 2麒麟9000华为手机华为官方旗舰店正品p50pro', '【旗舰新品】华为P50 Pro 4G全网通搭载HarmonyOS 2麒麟9000华为手机华为官方旗舰店正品p50pro', '202109150027016', 'lucien_ssa', '2021-09-12 19:30:11', '2021-09-12 19:30:11', 1, 30, '华为', '2343525', NULL);
INSERT INTO `oms_cart_item` VALUES (35, 33, 33, 10, 1, 228.00, 'https://gd3.alicdn.com/imgextra/i3/3381629725/O1CN01QaB5cG2Li6E4KJn0M_!!3381629725.jpg_400x400.jpg', '海洋堂新世纪福音战士EVA成品初号机', '海洋堂新世纪福音战士EVA成品初号机', '202109150027033', 'lucien_ssa', '2021-09-12 19:58:16', '2021-09-12 19:58:16', 1, 66, '范思哲', '5435341', NULL);
INSERT INTO `oms_cart_item` VALUES (36, 33, 33, 10, 1, 228.00, 'https://gd3.alicdn.com/imgextra/i3/3381629725/O1CN01QaB5cG2Li6E4KJn0M_!!3381629725.jpg_400x400.jpg', '海洋堂新世纪福音战士EVA成品初号机', '海洋堂新世纪福音战士EVA成品初号机', '202109150027033', 'lucien_ssa', '2021-09-12 19:59:27', '2021-09-12 19:59:27', 1, 66, '范思哲', '5435341', NULL);
INSERT INTO `oms_cart_item` VALUES (37, 33, 33, 10, 2, 228.00, 'https://gd3.alicdn.com/imgextra/i3/3381629725/O1CN01QaB5cG2Li6E4KJn0M_!!3381629725.jpg_400x400.jpg', '海洋堂新世纪福音战士EVA成品初号机', '海洋堂新世纪福音战士EVA成品初号机', '202109150027033', 'lucien_ssa', '2021-09-12 20:00:46', '2021-09-12 20:00:46', 1, 66, '范思哲', '5435341', NULL);
INSERT INTO `oms_cart_item` VALUES (38, 22, 22, 10, 1, 7599.00, 'https://img.alicdn.com/imgextra/i1/2279837698/O1CN016r3Dsh26jjcIUgSsU_!!2279837698.jpg_430x430q90.jpg', 'Xiaomi/小米 11 Ultra 5G手机全网通官方旗舰店正品官网至尊版系列10新款pro红米青春手机', 'Xiaomi/小米 11 Ultra 5G手机全网通官方旗舰店正品官网至尊版系列10新款pro红米青春手机', '202109150027022', 'lucien_ssa', '2021-09-12 20:00:52', '2021-09-12 20:00:52', 1, 34, '小米', '2353522', NULL);
INSERT INTO `oms_cart_item` VALUES (39, 37, 37, 10, 1, 2249.00, 'https://img.alicdn.com/imgextra/i2/594767740/O1CN01KBVDeF272yAoep8KZ_!!594767740.jpg_430x430q90.jpg', '乐高机械组成人乐高布加迪威龙 Bugatti Chiron拼插积木玩具42083', '乐高机械组成人乐高布加迪威龙 Bugatti Chiron拼插积木玩具42083', '202109150027037', 'lucien_ssa', '2021-09-12 20:01:04', '2021-09-12 20:01:04', 1, 65, '范思哲', '5847988', NULL);
INSERT INTO `oms_cart_item` VALUES (40, 18, 18, 10, 1, 6799.00, 'https://img.alicdn.com/imgextra/i1/1917047079/O1CN01xeHXfg22AEQKtkTiK_!!1917047079.png_430x430q90.jpg', 'Apple/苹果 iPhone 12 国行手机', 'Apple/苹果 iPhone 12【直营国行】Apple/苹果 AirPods Pro耳机三代原装正品 全国联保', '202109150027018', 'lucien_ssa', '2021-09-12 22:02:26', '2021-09-12 22:02:26', 1, 31, '苹果', '1243543', NULL);
INSERT INTO `oms_cart_item` VALUES (41, 14, 14, 10, 1, 219.00, 'http://yanxuan.nosdn.127.net/c83a3881704094ddd3970099ca77d115.png', '清欢日式可调节台灯 木铁结合，全体可调节', '清欢日式可调节台灯 木铁结合，全体可调节', '202109150027014', 'lucien_ssa', '2021-09-12 22:08:45', '2021-09-12 22:08:45', 1, 54, '万和', '4512354', NULL);

-- ----------------------------
-- Table structure for oms_company_address
-- ----------------------------
DROP TABLE IF EXISTS `oms_company_address`;
CREATE TABLE `oms_company_address`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `address_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址名称',
  `send_status` int(1) NULL DEFAULT NULL COMMENT '默认发货地址：0->否；1->是',
  `receive_status` int(1) NULL DEFAULT NULL COMMENT '是否默认收货地址：0->否；1->是',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收发货人姓名',
  `phone` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人电话',
  `province` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '省/直辖市',
  `city` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '市',
  `region` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区',
  `detail_address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公司收发货地址表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_company_address
-- ----------------------------
INSERT INTO `oms_company_address` VALUES (1, '深圳发货点', 1, 1, '大梨', '18000000000', '广东省', '深圳市', '南山区', '科兴科学园');
INSERT INTO `oms_company_address` VALUES (2, '北京发货点', 0, 0, '大梨', '18000000000', '北京市', NULL, '南山区', '科兴科学园');
INSERT INTO `oms_company_address` VALUES (3, '南京发货点', 0, 0, '大梨', '18000000000', '江苏省', '南京市', '南山区', '科兴科学园');

-- ----------------------------
-- Table structure for oms_order
-- ----------------------------
DROP TABLE IF EXISTS `oms_order`;
CREATE TABLE `oms_order`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `member_id` bigint(20) NOT NULL,
  `coupon_id` bigint(20) NULL DEFAULT NULL,
  `order_sn` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `create_time` datetime NULL DEFAULT NULL COMMENT '提交时间',
  `member_username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户帐号',
  `total_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '订单总金额',
  `pay_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '应付金额（实际支付金额）',
  `freight_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '运费金额',
  `promotion_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '促销优化金额（促销价、满减、阶梯价）',
  `integration_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '积分抵扣金额',
  `coupon_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '优惠券抵扣金额',
  `discount_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '管理员后台调整订单使用的折扣金额',
  `pay_type` int(1) NULL DEFAULT NULL COMMENT '支付方式：0->未支付；1->支付宝；2->微信',
  `source_type` int(1) NULL DEFAULT NULL COMMENT '订单来源：0->PC订单；1->app订单',
  `status` int(1) NULL DEFAULT NULL COMMENT '订单状态：0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->无效订单',
  `order_type` int(1) NULL DEFAULT NULL COMMENT '订单类型：0->正常订单；1->秒杀订单',
  `delivery_company` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物流公司(配送方式)',
  `delivery_sn` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物流单号',
  `auto_confirm_day` int(11) NULL DEFAULT NULL COMMENT '自动确认时间（天）',
  `integration` int(11) NULL DEFAULT NULL COMMENT '可以获得的积分',
  `growth` int(11) NULL DEFAULT NULL COMMENT '可以活动的成长值',
  `promotion_info` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动信息',
  `bill_type` int(1) NULL DEFAULT NULL COMMENT '发票类型：0->不开发票；1->电子发票；2->纸质发票',
  `bill_header` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发票抬头',
  `bill_content` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发票内容',
  `bill_receiver_phone` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收票人电话',
  `bill_receiver_email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收票人邮箱',
  `receiver_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货人姓名',
  `receiver_phone` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货人电话',
  `receiver_post_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人邮编',
  `receiver_province` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '省份/直辖市',
  `receiver_city` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '城市',
  `receiver_region` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区',
  `receiver_detail_address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `note` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单备注',
  `confirm_status` int(1) NULL DEFAULT NULL COMMENT '确认收货状态：0->未确认；1->已确认',
  `delete_status` int(1) NOT NULL DEFAULT 0 COMMENT '删除状态：0->未删除；1->已删除',
  `use_integration` int(11) NULL DEFAULT NULL COMMENT '下单时使用的积分',
  `payment_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `delivery_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `receive_time` datetime NULL DEFAULT NULL COMMENT '确认收货时间',
  `comment_time` datetime NULL DEFAULT NULL COMMENT '评价时间',
  `modify_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_order
-- ----------------------------
INSERT INTO `oms_order` VALUES (1, 10, NULL, '2021091201null000004', '2021-09-12 17:45:05', 'lucien', 228.00, 228.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1, 1, 1, 0, NULL, NULL, 15, 0, 0, '无优惠', NULL, NULL, NULL, NULL, NULL, '陈少111', '13556787083', '440104', '广东省', '广州市', '越秀区', '越秀一路', NULL, 0, 0, NULL, '2021-09-12 18:57:12', NULL, NULL, NULL, NULL);
INSERT INTO `oms_order` VALUES (2, 10, NULL, '2021091201null000005', '2021-09-12 20:01:11', 'lucien', 2249.00, 2249.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1, 1, 1, 0, NULL, NULL, 15, 0, 0, '无优惠', NULL, NULL, NULL, NULL, NULL, 'cxyxxx', '13556787083', '441927', '广东省', '东莞市', '常平镇', '紫荆花园晓辉道51B', NULL, 0, 0, NULL, '2021-09-12 20:03:58', NULL, NULL, NULL, NULL);
INSERT INTO `oms_order` VALUES (4, 10, NULL, '2021091201null000007', '2021-09-12 20:04:54', 'lucien', 7599.00, 7599.00, 0.00, 0.00, 0.00, 0.00, 0.00, NULL, 1, 4, 0, NULL, NULL, 15, 0, 0, '无优惠', NULL, NULL, NULL, NULL, NULL, 'cxyxxx', '13556787083', '441927', '广东省', '东莞市', '常平镇', '紫荆花园晓辉道51B', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `oms_order` VALUES (5, 10, NULL, '2021091201null000008', '2021-09-12 20:12:07', 'lucien', 456.00, 456.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1, 1, 3, 0, '顺丰快递', '125564343', 15, 0, 0, '无优惠', NULL, NULL, NULL, NULL, NULL, 'cxyxxx', '13556787083', '441927', '广东省', '东莞市', '常平镇', '紫荆花园晓辉道51B', NULL, 1, 0, NULL, '2021-09-12 20:12:09', '2021-09-12 20:17:52', '2021-09-12 20:30:11', NULL, NULL);
INSERT INTO `oms_order` VALUES (6, 10, NULL, '2021091201null000009', '2021-09-12 22:03:05', 'lucien', 6799.00, 6799.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1, 1, 3, 0, '圆通快递', '1234567890', 15, 0, 0, '无优惠', NULL, NULL, NULL, NULL, NULL, '测试', '13556787083', '110101', '北京市', '北京市', '东城区', '测试', NULL, 1, 0, NULL, '2021-09-12 22:03:06', '2021-09-12 22:07:08', '2021-09-12 22:07:28', NULL, NULL);
INSERT INTO `oms_order` VALUES (7, 10, NULL, '2021091201null000010', '2021-09-12 22:09:05', 'lucien', 219.00, 219.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1, 1, 1, 0, NULL, NULL, 15, 0, 0, '无优惠', NULL, NULL, NULL, NULL, NULL, 'cxyxxx', '13556787083', '441927', '广东省', '东莞市', '常平镇', '紫荆花园晓辉道51B', NULL, 0, 0, NULL, '2021-09-12 22:09:06', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for oms_order_item
-- ----------------------------
DROP TABLE IF EXISTS `oms_order_item`;
CREATE TABLE `oms_order_item`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NULL DEFAULT NULL COMMENT '订单id',
  `order_sn` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `product_id` bigint(20) NULL DEFAULT NULL,
  `product_pic` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_brand` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_sn` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '销售价格',
  `product_quantity` int(11) NULL DEFAULT NULL COMMENT '购买数量',
  `product_sku_id` bigint(20) NULL DEFAULT NULL COMMENT '商品sku编号',
  `product_sku_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品sku条码',
  `product_category_id` bigint(20) NULL DEFAULT NULL COMMENT '商品分类id',
  `promotion_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品促销名称',
  `promotion_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品促销分解金额',
  `coupon_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '优惠券优惠分解金额',
  `integration_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '积分优惠分解金额',
  `real_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '该商品经过优惠后的分解金额',
  `gift_integration` int(11) NULL DEFAULT 0,
  `gift_growth` int(11) NULL DEFAULT 0,
  `product_attr` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品销售属性:[{\"key\":\"颜色\",\"value\":\"颜色\"},{\"key\":\"容量\",\"value\":\"4G\"}]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单中所包含的商品' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_order_item
-- ----------------------------
INSERT INTO `oms_order_item` VALUES (1, 1, '2021091201null000004', 33, 'https://gd3.alicdn.com/imgextra/i3/3381629725/O1CN01QaB5cG2Li6E4KJn0M_!!3381629725.jpg_400x400.jpg', '海洋堂新世纪福音战士EVA成品初号机', '范思哲', '5435341', 228.00, 1, 33, '202109150027033', 66, '无优惠', 0.00, 0.00, 0.00, 228.00, 0, 0, NULL);
INSERT INTO `oms_order_item` VALUES (2, 2, '2021091201null000005', 37, 'https://img.alicdn.com/imgextra/i2/594767740/O1CN01KBVDeF272yAoep8KZ_!!594767740.jpg_430x430q90.jpg', '乐高机械组成人乐高布加迪威龙 Bugatti Chiron拼插积木玩具42083', '范思哲', '5847988', 2249.00, 1, 37, '202109150027037', 65, '无优惠', 0.00, 0.00, 0.00, 2249.00, 0, 0, NULL);
INSERT INTO `oms_order_item` VALUES (3, 4, '2021091201null000007', 22, 'https://img.alicdn.com/imgextra/i1/2279837698/O1CN016r3Dsh26jjcIUgSsU_!!2279837698.jpg_430x430q90.jpg', 'Xiaomi/小米 11 Ultra 5G手机全网通官方旗舰店正品官网至尊版系列10新款pro红米青春手机', '小米', '2353522', 7599.00, 1, 22, '202109150027022', 34, '无优惠', 0.00, 0.00, 0.00, 7599.00, 0, 0, NULL);
INSERT INTO `oms_order_item` VALUES (4, 5, '2021091201null000008', 33, 'https://gd3.alicdn.com/imgextra/i3/3381629725/O1CN01QaB5cG2Li6E4KJn0M_!!3381629725.jpg_400x400.jpg', '海洋堂新世纪福音战士EVA成品初号机', '范思哲', '5435341', 228.00, 2, 33, '202109150027033', 66, '无优惠', 0.00, 0.00, 0.00, 228.00, 0, 0, NULL);
INSERT INTO `oms_order_item` VALUES (5, 6, '2021091201null000009', 18, 'https://img.alicdn.com/imgextra/i1/1917047079/O1CN01xeHXfg22AEQKtkTiK_!!1917047079.png_430x430q90.jpg', 'Apple/苹果 iPhone 12 国行手机', '苹果', '1243543', 6799.00, 1, 18, '202109150027018', 31, '无优惠', 0.00, 0.00, 0.00, 6799.00, 0, 0, NULL);
INSERT INTO `oms_order_item` VALUES (6, 7, '2021091201null000010', 14, 'http://yanxuan.nosdn.127.net/c83a3881704094ddd3970099ca77d115.png', '清欢日式可调节台灯 木铁结合，全体可调节', '万和', '4512354', 219.00, 1, 14, '202109150027014', 54, '无优惠', 0.00, 0.00, 0.00, 219.00, 0, 0, NULL);

-- ----------------------------
-- Table structure for oms_order_operate_history
-- ----------------------------
DROP TABLE IF EXISTS `oms_order_operate_history`;
CREATE TABLE `oms_order_operate_history`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NULL DEFAULT NULL COMMENT '订单id',
  `operate_man` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人：用户；系统；后台管理员',
  `create_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `order_status` int(1) NULL DEFAULT NULL COMMENT '订单状态：0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->无效订单',
  `note` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单操作历史记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_order_operate_history
-- ----------------------------
INSERT INTO `oms_order_operate_history` VALUES (1, 12, '后台管理员', '2021-09-06 14:08:29', 4, '修改订单备注信息:备注订单测试');
INSERT INTO `oms_order_operate_history` VALUES (2, 20, '后台管理员', '2021-09-06 14:13:25', 3, '修改订单备注信息:完成订单\n');
INSERT INTO `oms_order_operate_history` VALUES (3, 29, '后台管理员', '2021-09-06 14:14:07', 4, '订单关闭:关闭订单');
INSERT INTO `oms_order_operate_history` VALUES (4, 18, '后台管理员', '2021-09-06 14:21:56', 2, '商家发货');
INSERT INTO `oms_order_operate_history` VALUES (5, 5, '后台管理员', '2021-09-12 20:17:52', 2, '商家发货');
INSERT INTO `oms_order_operate_history` VALUES (6, 6, '后台管理员', '2021-09-12 22:07:08', 2, '商家发货');

-- ----------------------------
-- Table structure for oms_order_return_apply
-- ----------------------------
DROP TABLE IF EXISTS `oms_order_return_apply`;
CREATE TABLE `oms_order_return_apply`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NULL DEFAULT NULL COMMENT '订单id',
  `company_address_id` bigint(20) NULL DEFAULT NULL COMMENT '收货地址表id',
  `product_id` bigint(20) NULL DEFAULT NULL COMMENT '退货商品id',
  `order_sn` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `create_time` datetime NULL DEFAULT NULL COMMENT '申请时间',
  `member_username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员用户名',
  `return_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '退款金额',
  `return_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退货人姓名',
  `return_phone` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退货人电话',
  `status` int(1) NULL DEFAULT NULL COMMENT '申请状态：0->待处理；1->退货中；2->已完成；3->已拒绝',
  `handle_time` datetime NULL DEFAULT NULL COMMENT '处理时间',
  `product_pic` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `product_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `product_brand` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品品牌',
  `product_attr` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品销售属性：颜色：红色；尺码：xl;',
  `product_count` int(11) NULL DEFAULT NULL COMMENT '退货数量',
  `product_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品单价',
  `product_real_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品实际支付单价',
  `reason` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原因',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `proof_pics` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '凭证图片，以逗号隔开',
  `handle_note` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处理备注',
  `handle_man` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处理人员',
  `receive_man` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人',
  `receive_time` datetime NULL DEFAULT NULL COMMENT '收货时间',
  `receive_note` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单退货申请' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_order_return_apply
-- ----------------------------
INSERT INTO `oms_order_return_apply` VALUES (3, 12, NULL, 26, '201809150101000001', '2018-10-17 14:34:57', 'test', NULL, '大梨', '18000000000', 0, NULL, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20', '华为', '颜色：金色;内存：16G', 1, 3788.00, 3585.98, '质量问题', '老是卡', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg,http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `oms_order_return_apply` VALUES (4, 12, 2, 27, '201809150101000001', '2018-10-17 14:40:21', 'test', 3585.98, '大梨', '18000000000', 1, '2018-10-18 13:54:10', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8', '小米', '颜色：黑色;内存：32G', 1, 2699.00, 2022.81, '质量问题', '不够高端', '', '已经处理了', 'admin', NULL, NULL, NULL);
INSERT INTO `oms_order_return_apply` VALUES (5, 12, 3, 28, '201809150101000001', '2018-10-17 14:44:18', 'test', 3585.98, '大梨', '18000000000', 2, '2018-10-18 13:55:28', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米', '颜色：金色;内存：16G', 1, 649.00, 591.05, '质量问题', '颜色太土', '', '已经处理了', 'admin', 'admin', '2018-10-18 13:55:58', '已经处理了');
INSERT INTO `oms_order_return_apply` VALUES (8, 13, NULL, 28, '201809150102000002', '2018-10-17 14:44:18', 'test', NULL, '大梨', '18000000000', 3, '2018-10-18 13:57:12', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米', '颜色：金色;内存：16G', 1, 649.00, 591.05, '质量问题', '颜色太土', '', '理由不够充分', 'admin', NULL, NULL, NULL);
INSERT INTO `oms_order_return_apply` VALUES (9, 14, 2, 26, '201809130101000001', '2018-10-17 14:34:57', 'test', 3500.00, '大梨', '18000000000', 2, '2018-10-24 15:44:56', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20', '华为', '颜色：金色;内存：16G', 1, 3788.00, 3585.98, '质量问题', '老是卡', '', '呵呵', 'admin', 'admin', '2018-10-24 15:46:35', '收货了');
INSERT INTO `oms_order_return_apply` VALUES (10, 14, NULL, 27, '201809130101000001', '2018-10-17 14:40:21', 'test', NULL, '大梨', '18000000000', 3, '2018-10-24 15:46:57', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8', '小米', '颜色：黑色;内存：32G', 1, 2699.00, 2022.81, '质量问题', '不够高端', '', '就是不退', 'admin', NULL, NULL, NULL);
INSERT INTO `oms_order_return_apply` VALUES (11, 14, 2, 28, '201809130101000001', '2018-10-17 14:44:18', 'test', 591.05, '大梨', '18000000000', 2, '2021-09-06 15:29:52', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米', '颜色：金色;内存：16G', 1, 649.00, 591.05, '质量问题', '颜色太土', '', '可以退款', 'admin', NULL, NULL, NULL);
INSERT INTO `oms_order_return_apply` VALUES (13, 15, NULL, 27, '201809130102000002', '2018-10-17 14:40:21', 'test', NULL, '大梨', '18000000000', 3, '2018-10-24 17:23:30', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8', '小米', '颜色：黑色;内存：32G', 1, 2699.00, 2022.81, '质量问题', '不够高端', '', '无法退货', 'admin', NULL, NULL, NULL);
INSERT INTO `oms_order_return_apply` VALUES (16, 16, NULL, 27, '201809140101000001', '2018-10-17 14:40:21', 'test', NULL, '大梨', '18000000000', 0, NULL, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8', '小米', '颜色：黑色;内存：32G', 1, 2699.00, 2022.81, '质量问题', '不够高端', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `oms_order_return_apply` VALUES (17, 16, NULL, 28, '201809140101000001', '2018-10-17 14:44:18', 'test', NULL, '大梨', '18000000000', 0, NULL, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米', '颜色：金色;内存：16G', 1, 649.00, 591.05, '质量问题', '颜色太土', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `oms_order_return_apply` VALUES (18, 17, NULL, 26, '201809150101000003', '2018-10-17 14:34:57', 'test', NULL, '大梨', '18000000000', 0, NULL, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20', '华为', '颜色：金色;内存：16G', 1, 3788.00, 3585.98, '质量问题', '老是卡', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `oms_order_return_apply` VALUES (19, 17, NULL, 27, '201809150101000003', '2018-10-17 14:40:21', 'test', NULL, '大梨', '18000000000', 0, NULL, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8', '小米', '颜色：黑色;内存：32G', 1, 2699.00, 2022.81, '质量问题', '不够高端', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `oms_order_return_apply` VALUES (20, 17, NULL, 28, '201809150101000003', '2018-10-17 14:44:18', 'test', NULL, '大梨', '18000000000', 0, NULL, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米', '颜色：金色;内存：16G', 1, 649.00, 591.05, '质量问题', '颜色太土', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `oms_order_return_apply` VALUES (21, 18, NULL, 26, '201809150102000004', '2018-10-17 14:34:57', 'test', NULL, '大梨', '18000000000', 0, NULL, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20', '华为', '颜色：金色;内存：16G', 1, 3788.00, 3585.98, '质量问题', '老是卡', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `oms_order_return_apply` VALUES (22, 18, NULL, 27, '201809150102000004', '2018-10-17 14:40:21', 'test', NULL, '大梨', '18000000000', 0, NULL, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8', '小米', '颜色：黑色;内存：32G', 1, 2699.00, 2022.81, '质量问题', '不够高端', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `oms_order_return_apply` VALUES (23, 18, NULL, 28, '201809150102000004', '2018-10-17 14:44:18', 'test', NULL, '大梨', '18000000000', 0, NULL, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米', '颜色：金色;内存：16G', 1, 649.00, 591.05, '质量问题', '颜色太土', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `oms_order_return_apply` VALUES (24, 19, NULL, 26, '201809130101000003', '2018-10-17 14:34:57', 'test', NULL, '大梨', '18000000000', 0, NULL, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '华为 HUAWEI P20', '华为', '颜色：金色;内存：16G', 1, 3788.00, 3585.98, '质量问题', '老是卡', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `oms_order_return_apply` VALUES (25, 19, NULL, 27, '201809130101000003', '2018-10-17 14:40:21', 'test', NULL, '大梨', '18000000000', 0, NULL, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/xiaomi.jpg', '小米8', '小米', '颜色：黑色;内存：32G', 1, 2699.00, 2022.81, '质量问题', '不够高端', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `oms_order_return_apply` VALUES (26, 19, NULL, 28, '201809130101000003', '2018-10-17 14:44:18', 'test', NULL, '大梨', '18000000000', 0, NULL, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5a9d248cN071f4959.jpg', '红米5A', '小米', '颜色：金色;内存：16G', 1, 649.00, 591.05, '质量问题', '颜色太土', '', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for oms_order_return_reason
-- ----------------------------
DROP TABLE IF EXISTS `oms_order_return_reason`;
CREATE TABLE `oms_order_return_reason`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退货类型',
  `sort` int(11) NULL DEFAULT NULL,
  `status` int(1) NULL DEFAULT NULL COMMENT '状态：0->不启用；1->启用',
  `create_time` datetime NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '退货原因表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_order_return_reason
-- ----------------------------
INSERT INTO `oms_order_return_reason` VALUES (1, '质量问题', 1, 1, '2018-10-17 10:00:45');
INSERT INTO `oms_order_return_reason` VALUES (2, '尺码太大', 1, 1, '2018-10-17 10:01:03');
INSERT INTO `oms_order_return_reason` VALUES (3, '颜色不喜欢', 1, 1, '2018-10-17 10:01:13');
INSERT INTO `oms_order_return_reason` VALUES (4, '7天无理由退货', 1, 1, '2018-10-17 10:01:47');
INSERT INTO `oms_order_return_reason` VALUES (5, '价格问题', 1, 1, '2018-10-17 10:01:57');
INSERT INTO `oms_order_return_reason` VALUES (12, '发票问题', 0, 1, '2018-10-19 16:28:36');
INSERT INTO `oms_order_return_reason` VALUES (13, '其他问题', 0, 1, '2018-10-19 16:28:51');
INSERT INTO `oms_order_return_reason` VALUES (14, '物流问题', 0, 1, '2018-10-19 16:29:01');
INSERT INTO `oms_order_return_reason` VALUES (15, '售后问题', 0, 1, '2018-10-19 16:29:11');

-- ----------------------------
-- Table structure for oms_order_setting
-- ----------------------------
DROP TABLE IF EXISTS `oms_order_setting`;
CREATE TABLE `oms_order_setting`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `flash_order_overtime` int(11) NULL DEFAULT NULL COMMENT '秒杀订单超时关闭时间(分)',
  `normal_order_overtime` int(11) NULL DEFAULT NULL COMMENT '正常订单超时时间(分)',
  `confirm_overtime` int(11) NULL DEFAULT NULL COMMENT '发货后自动确认收货时间（天）',
  `finish_overtime` int(11) NULL DEFAULT NULL COMMENT '自动完成交易时间，不能申请售后（天）',
  `comment_overtime` int(11) NULL DEFAULT NULL COMMENT '订单完成后自动好评时间（天）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单设置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_order_setting
-- ----------------------------
INSERT INTO `oms_order_setting` VALUES (1, 60, 120, 15, 7, 7);

-- ----------------------------
-- Table structure for pms_album
-- ----------------------------
DROP TABLE IF EXISTS `pms_album`;
CREATE TABLE `pms_album`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cover_pic` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pic_count` int(11) NULL DEFAULT NULL,
  `sort` int(11) NULL DEFAULT NULL,
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '相册表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_album
-- ----------------------------

-- ----------------------------
-- Table structure for pms_album_pic
-- ----------------------------
DROP TABLE IF EXISTS `pms_album_pic`;
CREATE TABLE `pms_album_pic`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) NULL DEFAULT NULL,
  `pic` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '画册图片表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_album_pic
-- ----------------------------

-- ----------------------------
-- Table structure for pms_brand
-- ----------------------------
DROP TABLE IF EXISTS `pms_brand`;
CREATE TABLE `pms_brand`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `first_letter` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '首字母',
  `sort` int(11) NULL DEFAULT NULL,
  `factory_status` int(1) NULL DEFAULT NULL COMMENT '是否为品牌制造商：0->不是；1->是',
  `show_status` int(1) NULL DEFAULT NULL,
  `product_count` int(11) NULL DEFAULT NULL COMMENT '产品数量',
  `product_comment_count` int(11) NULL DEFAULT NULL COMMENT '产品评论数量',
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '品牌logo',
  `big_pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专区大图',
  `brand_story` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '品牌故事',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '品牌表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_brand
-- ----------------------------
INSERT INTO `pms_brand` VALUES (1, '万和', 'W', 0, 1, 1, 100, 100, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg(5).jpg', '', 'Victoria\'s Secret的故事');
INSERT INTO `pms_brand` VALUES (2, '三星', 'S', 300, 1, 1, 100, 100, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg (1).jpg', NULL, '三星的故事');
INSERT INTO `pms_brand` VALUES (3, '华为', 'H', 500, 1, 1, 100, 100, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg (2).jpg', NULL, 'Victoria\'s Secret的故事');
INSERT INTO `pms_brand` VALUES (4, '格力', 'G', 0, 1, 1, 100, 100, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg (3).jpg', NULL, 'Victoria\'s Secret的故事');
INSERT INTO `pms_brand` VALUES (5, '方太', 'F', 0, 1, 1, 100, 100, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg (4).jpg', NULL, 'Victoria\'s Secret的故事');
INSERT INTO `pms_brand` VALUES (6, '小米', 'M', 400, 1, 1, 100, 100, 'https://tse1-mm.cn.bing.net/th/id/R-C.0491f4625a596241f295ae63818375ab?rik=ClrO90q4wis2yQ&riu=http%3a%2f%2fpic192.nipic.com%2ffile%2f20181119%2f20144696_101353530633_2.jpg&ehk=CqChGIZznDZrMoIYukeNVGxUhxKJx4ivfK%2bipHxtCJg%3d&risl=&pid=ImgRaw&r=0', '', '小米手机的故事');
INSERT INTO `pms_brand` VALUES (7, 'OPPO', 'O', 0, 1, 1, 88, 500, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg(6).jpg', '', 'string');
INSERT INTO `pms_brand` VALUES (8, '七匹狼', 'S', 300, 1, 1, 77, 400, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180518/1522738681.jpg', NULL, 'BOOB的故事');
INSERT INTO `pms_brand` VALUES (9, '海澜之家', 'H', 0, 1, 1, 66, 300, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/LOGO1024.png', '', '海澜之家的故事');
INSERT INTO `pms_brand` VALUES (10, '苹果', 'A', 450, 1, 1, 55, 200, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg.jpg', NULL, '苹果的故事');
INSERT INTO `pms_brand` VALUES (11, 'NIKE', 'N', 0, 1, 1, 33, 100, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/timg (51).jpg', '', 'NIKE的故事');
INSERT INTO `pms_brand` VALUES (12, 'MUJI', 'M', 0, 1, 1, 30, 100, 'https://img.zcool.cn/community/014b8e5c910518a801214168790d89.jpg@260w_195h_1c_1e_1o_100sh.jpg', '', '严选精选了MUJI制造商和生产原料，\n用几乎零利润的价格，剔除品牌溢价，\n让用户享受原品牌的品质生活。');
INSERT INTO `pms_brand` VALUES (13, '范思哲', 'F', 250, 1, 1, 30, 100, 'https://tse2-mm.cn.bing.net/th/id/OIP-C.JsqFgIfNblNWyNiJAr06IQHaHa?pid=ImgDet&rs=1', '', '严选找寻意大利奢侈品牌范思哲Versace的制造商，\n致力于为用户带来精致、优雅、时尚的皮包，\n传承独特美感，体验品质生活。');

-- ----------------------------
-- Table structure for pms_comment
-- ----------------------------
DROP TABLE IF EXISTS `pms_comment`;
CREATE TABLE `pms_comment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NULL DEFAULT NULL,
  `member_nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `star` int(3) NULL DEFAULT NULL COMMENT '评价星数：0->5',
  `member_ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评价的ip',
  `create_time` datetime NULL DEFAULT NULL,
  `show_status` int(1) NULL DEFAULT NULL,
  `product_attribute` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '购买时的商品属性',
  `collect_couont` int(11) NULL DEFAULT NULL,
  `read_count` int(11) NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `pics` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上传图片地址，以逗号隔开',
  `member_icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论用户头像',
  `replay_count` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品评价表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_comment
-- ----------------------------

-- ----------------------------
-- Table structure for pms_comment_replay
-- ----------------------------
DROP TABLE IF EXISTS `pms_comment_replay`;
CREATE TABLE `pms_comment_replay`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) NULL DEFAULT NULL,
  `member_nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `member_icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `type` int(1) NULL DEFAULT NULL COMMENT '评论人员类型；0->会员；1->管理员',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品评价回复表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_comment_replay
-- ----------------------------

-- ----------------------------
-- Table structure for pms_feight_template
-- ----------------------------
DROP TABLE IF EXISTS `pms_feight_template`;
CREATE TABLE `pms_feight_template`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `charge_type` int(1) NULL DEFAULT NULL COMMENT '计费类型:0->按重量；1->按件数',
  `first_weight` decimal(10, 2) NULL DEFAULT NULL COMMENT '首重kg',
  `first_fee` decimal(10, 2) NULL DEFAULT NULL COMMENT '首费（元）',
  `continue_weight` decimal(10, 2) NULL DEFAULT NULL,
  `continme_fee` decimal(10, 2) NULL DEFAULT NULL,
  `dest` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目的地（省、市）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '运费模版' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_feight_template
-- ----------------------------

-- ----------------------------
-- Table structure for pms_member_price
-- ----------------------------
DROP TABLE IF EXISTS `pms_member_price`;
CREATE TABLE `pms_member_price`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NULL DEFAULT NULL,
  `member_level_id` bigint(20) NULL DEFAULT NULL,
  `member_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '会员价格',
  `member_level_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 252 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品会员价格表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_member_price
-- ----------------------------
INSERT INTO `pms_member_price` VALUES (26, 7, 1, 500.00, NULL);
INSERT INTO `pms_member_price` VALUES (27, 8, 1, 500.00, NULL);
INSERT INTO `pms_member_price` VALUES (28, 9, 1, 500.00, NULL);
INSERT INTO `pms_member_price` VALUES (29, 10, 1, 500.00, NULL);
INSERT INTO `pms_member_price` VALUES (30, 11, 1, 500.00, NULL);
INSERT INTO `pms_member_price` VALUES (31, 12, 1, 500.00, NULL);
INSERT INTO `pms_member_price` VALUES (32, 13, 1, 500.00, NULL);
INSERT INTO `pms_member_price` VALUES (33, 14, 1, 500.00, NULL);
INSERT INTO `pms_member_price` VALUES (37, 18, 1, 500.00, NULL);
INSERT INTO `pms_member_price` VALUES (44, 7, 2, 480.00, NULL);
INSERT INTO `pms_member_price` VALUES (45, 7, 3, 450.00, NULL);
INSERT INTO `pms_member_price` VALUES (52, 22, 1, NULL, NULL);
INSERT INTO `pms_member_price` VALUES (53, 22, 2, NULL, NULL);
INSERT INTO `pms_member_price` VALUES (54, 22, 3, NULL, NULL);
INSERT INTO `pms_member_price` VALUES (58, 24, 1, NULL, NULL);
INSERT INTO `pms_member_price` VALUES (59, 24, 2, NULL, NULL);
INSERT INTO `pms_member_price` VALUES (60, 24, 3, NULL, NULL);
INSERT INTO `pms_member_price` VALUES (112, 23, 1, 88.00, '黄金会员');
INSERT INTO `pms_member_price` VALUES (113, 23, 2, 88.00, '白金会员');
INSERT INTO `pms_member_price` VALUES (114, 23, 3, 66.00, '钻石会员');
INSERT INTO `pms_member_price` VALUES (142, 31, 1, NULL, '黄金会员');
INSERT INTO `pms_member_price` VALUES (143, 31, 2, NULL, '白金会员');
INSERT INTO `pms_member_price` VALUES (144, 31, 3, NULL, '钻石会员');
INSERT INTO `pms_member_price` VALUES (148, 32, 1, NULL, '黄金会员');
INSERT INTO `pms_member_price` VALUES (149, 32, 2, NULL, '白金会员');
INSERT INTO `pms_member_price` VALUES (150, 32, 3, NULL, '钻石会员');
INSERT INTO `pms_member_price` VALUES (154, 33, 1, NULL, '黄金会员');
INSERT INTO `pms_member_price` VALUES (155, 33, 2, NULL, '白金会员');
INSERT INTO `pms_member_price` VALUES (156, 33, 3, NULL, '钻石会员');
INSERT INTO `pms_member_price` VALUES (175, 34, 1, NULL, '黄金会员');
INSERT INTO `pms_member_price` VALUES (176, 34, 2, NULL, '白金会员');
INSERT INTO `pms_member_price` VALUES (177, 34, 3, NULL, '钻石会员');
INSERT INTO `pms_member_price` VALUES (178, 30, 1, NULL, '黄金会员');
INSERT INTO `pms_member_price` VALUES (179, 30, 2, NULL, '白金会员');
INSERT INTO `pms_member_price` VALUES (180, 30, 3, NULL, '钻石会员');
INSERT INTO `pms_member_price` VALUES (192, 27, 1, NULL, '黄金会员');
INSERT INTO `pms_member_price` VALUES (193, 27, 2, NULL, '白金会员');
INSERT INTO `pms_member_price` VALUES (194, 27, 3, NULL, '钻石会员');
INSERT INTO `pms_member_price` VALUES (195, 28, 1, NULL, '黄金会员');
INSERT INTO `pms_member_price` VALUES (196, 28, 2, NULL, '白金会员');
INSERT INTO `pms_member_price` VALUES (197, 28, 3, NULL, '钻石会员');
INSERT INTO `pms_member_price` VALUES (198, 29, 1, NULL, '黄金会员');
INSERT INTO `pms_member_price` VALUES (199, 29, 2, NULL, '白金会员');
INSERT INTO `pms_member_price` VALUES (200, 29, 3, NULL, '钻石会员');
INSERT INTO `pms_member_price` VALUES (201, 26, 1, NULL, '黄金会员');
INSERT INTO `pms_member_price` VALUES (202, 26, 2, NULL, '白金会员');
INSERT INTO `pms_member_price` VALUES (203, 26, 3, NULL, '钻石会员');
INSERT INTO `pms_member_price` VALUES (246, 36, 1, NULL, '黄金会员');
INSERT INTO `pms_member_price` VALUES (247, 36, 2, NULL, '白金会员');
INSERT INTO `pms_member_price` VALUES (248, 36, 3, NULL, '钻石会员');
INSERT INTO `pms_member_price` VALUES (249, 35, 1, NULL, '黄金会员');
INSERT INTO `pms_member_price` VALUES (250, 35, 2, NULL, '白金会员');
INSERT INTO `pms_member_price` VALUES (251, 35, 3, NULL, '钻石会员');

-- ----------------------------
-- Table structure for pms_product
-- ----------------------------
DROP TABLE IF EXISTS `pms_product`;
CREATE TABLE `pms_product`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `brand_id` bigint(20) NULL DEFAULT NULL,
  `product_category_id` bigint(20) NULL DEFAULT NULL,
  `feight_template_id` bigint(20) NULL DEFAULT NULL,
  `product_attribute_category_id` bigint(20) NULL DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_sn` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货号',
  `delete_status` int(1) NULL DEFAULT NULL COMMENT '删除状态：0->未删除；1->已删除',
  `publish_status` int(1) NULL DEFAULT NULL COMMENT '上架状态：0->下架；1->上架',
  `new_status` int(1) NULL DEFAULT NULL COMMENT '新品状态:0->不是新品；1->新品',
  `recommand_status` int(1) NULL DEFAULT NULL COMMENT '推荐状态；0->不推荐；1->推荐',
  `verify_status` int(1) NULL DEFAULT NULL COMMENT '审核状态：0->未审核；1->审核通过',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `sale` int(11) NULL DEFAULT NULL COMMENT '销量',
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `promotion_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '促销价格',
  `gift_growth` int(11) NULL DEFAULT 0 COMMENT '赠送的成长值',
  `gift_point` int(11) NULL DEFAULT 0 COMMENT '赠送的积分',
  `use_point_limit` int(11) NULL DEFAULT NULL COMMENT '限制使用的积分数',
  `sub_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '副标题',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '商品描述',
  `original_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '市场价',
  `stock` int(11) NULL DEFAULT NULL COMMENT '库存',
  `low_stock` int(11) NULL DEFAULT NULL COMMENT '库存预警值',
  `unit` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位',
  `weight` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品重量，默认为克',
  `preview_status` int(1) NULL DEFAULT NULL COMMENT '是否为预告商品：0->不是；1->是',
  `service_ids` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '以逗号分割的产品服务：1->无忧退货；2->快速退款；3->免费包邮',
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `album_pics` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '画册图片，连产品图片限制为5张，以逗号分割',
  `detail_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `detail_desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `detail_html` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '产品详情网页内容',
  `detail_mobile_html` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '移动端网页详情',
  `promotion_start_time` datetime NULL DEFAULT NULL COMMENT '促销开始时间',
  `promotion_end_time` datetime NULL DEFAULT NULL COMMENT '促销结束时间',
  `promotion_per_limit` int(11) NULL DEFAULT NULL COMMENT '活动限购数量',
  `promotion_type` int(1) NULL DEFAULT NULL COMMENT '促销类型：0->没有促销使用原价;1->使用促销价；2->使用会员价；3->使用阶梯价格；4->使用满减价格；5->限时购',
  `brand_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '品牌名称',
  `product_category_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pms_product
-- ----------------------------
INSERT INTO `pms_product` VALUES (1, 3, 30, 0, 3, '华为 HUAWEI P20 全网通P20系列商务智能拍照4G手机双卡双待	\r\n ', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '6946605', 0, 1, 1, 1, 0, 100, 0, 3788.00, NULL, 3788, 3788, 0, 'AI智慧全面屏 6GB +64GB 亮黑色 全网通版 移动联通电信4G手机 双卡双待手机 双卡双待', 'AI智慧全面屏 6GB +64GB 亮黑色 全网通版 移动联通电信4G手机 双卡双待手机 双卡双待', 4288.00, 1000, 0, '件', 0.00, 1, '', '', '', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ab46a3cN616bdc41.jpg,http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf5fN2522b9dc.jpg', '', '', '<p><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ad44f1cNf51f3bb0.jpg\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ad44fa8Nfcf71c10.jpg\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ad44fa9N40e78ee0.jpg\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ad457f4N1c94bdda.jpg\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ad457f5Nd30de41d.jpg\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5b10fb0eN0eb053fb.jpg\" /></p>', '', NULL, NULL, 0, 1, '华为', '手机数码');
INSERT INTO `pms_product` VALUES (2, 10, 31, 0, 3, 'Apple iPhone 8 Plus 64GB 红色特别版 移动联通电信4G手机', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg', '7437799', 0, 1, 1, 1, 0, 0, 0, 5499.00, NULL, 5499, 5499, 0, '【限时限量抢购】Apple产品年中狂欢节，好物尽享，美在智慧！速来 >> 勾选[保障服务][原厂保2年]，获得AppleCare+全方位服务计划，原厂延保售后无忧。', '【限时限量抢购】Apple产品年中狂欢节，好物尽享，美在智慧！速来 >> 勾选[保障服务][原厂保2年]，获得AppleCare+全方位服务计划，原厂延保售后无忧。', 5499.00, 100, 0, '', 0.00, 0, '', '', '', '', '', '', '<div id=\"J_DivItemDesc\" class=\"content\"><p><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/1094656908/O1CN01oFbRLf20tuibfy5oO_!!1094656908.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/1094656908/O1CN01C3dkN120tuiZSU1sV_!!1094656908.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/1094656908/O1CN016CSlK120tuiYU7kgy_!!1094656908.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/1094656908/O1CN01ded4h320tuiYU64iN_!!1094656908.jpg\" style=\"max-width: 750.0px;\"></p></div>', '', NULL, NULL, 0, 0, '苹果', '手机数码');
INSERT INTO `pms_product` VALUES (3, 6, 34, 0, 3, '小米（MI）小米电视4A ', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b02804dN66004d73.jpg', '4609652', 0, 1, 0, 0, 0, 0, 0, 2499.00, NULL, 0, 0, 0, '小米（MI）小米电视4A 55英寸 L55M5-AZ/L55M5-AD 2GB+8GB HDR 4K超高清 人工智能网络液晶平板电视', '小米（MI）小米电视4A 55英寸 L55M5-AZ/L55M5-AD 2GB+8GB HDR 4K超高清 人工智能网络液晶平板电视', 2499.00, 100, 0, '', 0.00, 0, '', '', '', '', '', '', '<p><a href=\"https://luckygo.ews.m.jaeapp.com/?i=LDzRHzLHzRFzLJzSEzLDzRIzLJzSCzLEzSD\" target=\"_blank\"></a><a href=\"https://shop.m.taobao.com/shop/sr.htm?p=1S0j22_75sPo_0_iRjD1\" target=\"_blank\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01cxBBMs29zFsoBSXYy_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></a><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01kPmJLb29zFsCp4Gif_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><a href=\"https://luckygo.ews.m.jaeapp.com/?i=LDzRHzLHzRFzLJzSEzLDzRIzLJzSCzLEzSD\" target=\"_blank\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01ACZVYY29zFngntEjm_!!1714128138.jpg\" align=\"absmiddle\" style=\"width: 790.0px;\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1714128138/O1CN01kHKZxu29zFkdsE7YF_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN019TvqJy29zFkjWpGoi_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01plIaGz29zFkinmTe3_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN014HZiQT29zFkgSVAQL_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01k7JRT629zFkh0Q9FN_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01G5DeXz29zFkhzNYwg_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1714128138/O1CN01eVnHVU29zFkdsEiyf_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></a></p>', '', NULL, NULL, 0, 0, '小米', '手机数码');
INSERT INTO `pms_product` VALUES (4, 6, 34, 0, 3, '小米（MI）小米电视4A 65英寸', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b028530N51eee7d4.jpg', '4609660', 0, 1, 0, 0, 0, 0, 0, 3999.00, NULL, 0, 0, 0, ' L65M5-AZ/L65M5-AD 2GB+8GB HDR 4K超高清 人工智能网络液晶平板电视', ' L65M5-AZ/L65M5-AD 2GB+8GB HDR 4K超高清 人工智能网络液晶平板电视', 3999.00, 100, 0, '', 0.00, 0, '', '', '', '', '', '', '<p><a href=\"https://luckygo.ews.m.jaeapp.com/?i=LDzRHzLHzRFzLJzSEzLDzRIzLJzSCzLEzSD\" target=\"_blank\"></a><a href=\"https://shop.m.taobao.com/shop/sr.htm?p=1S0j22_75sPo_0_iRjD1\" target=\"_blank\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01cxBBMs29zFsoBSXYy_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></a><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01kPmJLb29zFsCp4Gif_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><a href=\"https://luckygo.ews.m.jaeapp.com/?i=LDzRHzLHzRFzLJzSEzLDzRIzLJzSCzLEzSD\" target=\"_blank\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01ACZVYY29zFngntEjm_!!1714128138.jpg\" align=\"absmiddle\" style=\"width: 790.0px;\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1714128138/O1CN01kHKZxu29zFkdsE7YF_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN019TvqJy29zFkjWpGoi_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01plIaGz29zFkinmTe3_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN014HZiQT29zFkgSVAQL_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01k7JRT629zFkh0Q9FN_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01G5DeXz29zFkhzNYwg_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1714128138/O1CN01eVnHVU29zFkdsEiyf_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></a></p>', '', NULL, NULL, 0, 0, '小米', '手机数码');
INSERT INTO `pms_product` VALUES (5, 1, 53, 0, 5, '皇室御用超柔毛巾 至柔至软，热销50万条', 'http://yanxuan.nosdn.127.net/ad5a317216f9da495b144070ecf1f957.png', '4566564', 0, 1, 1, 1, 0, 0, 0, 79.00, NULL, 0, 0, 0, '皇室御用超柔毛巾 至柔至软，热销50万条', '皇室御用超柔毛巾 至柔至软，热销50万条', 79.00, 100, 0, NULL, 0.00, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' <p><img src=\"https://img.alicdn.com/imgextra/i2/2207949670707/O1CN01CR6P5v1H5qd8e8f3H_!!2207949670707-0-scmitem176000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2207949670707/O1CN01AiBEWZ1H5qgkaoHwX_!!2207949670707-0-scmitem176000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2207949670707/O1CN01pC8rSz1H5qd0VWU2k_!!2207949670707-0-scmitem176000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2207949670707/O1CN01Pk4wja1H5qdB4qy1H_!!2207949670707-0-scmitem176000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2207949670707/O1CN01mNGUz11H5qd99TThj_!!2207949670707-0-scmitem176000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2207949670707/O1CN014KhSVT1H5qdAtXhXV_!!2207949670707-0-scmitem176000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2207949670707/O1CN01LONMMZ1H5qdAtXy9d_!!2207949670707-0-scmitem176000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> </p>', ' ', NULL, NULL, 0, 0, '万和', '被子');
INSERT INTO `pms_product` VALUES (6, 1, 53, 0, 5, '意式毛线绣球四件套 浪漫毛线绣球，简约而不简单', 'http://yanxuan.nosdn.127.net/5350e35e6f22165f38928f3c2c52ac57.png', '4534365', 0, 1, 1, 1, 0, 0, 0, 319.00, NULL, 0, 0, 0, '意式毛线绣球四件套 浪漫毛线绣球，简约而不简单', '意式毛线绣球四件套 浪漫毛线绣球，简约而不简单', 319.00, 100, 0, NULL, 0.00, 0, '  ', ' ', ' ', ' ', ' ', ' ', ' <p><img src=\"http://yanxuan.nosdn.127.net/3f63478dd19081036c7c8061a88438b3.jpg\" _src=\"http://yanxuan.nosdn.127.net/3f63478dd19081036c7c8061a88438b3.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a437697cad2ac00a76b8a2a9f9f7819b.jpg\" _src=\"http://yanxuan.nosdn.127.net/a437697cad2ac00a76b8a2a9f9f7819b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/30607b946fa5245ab1376d28ab8d68c6.jpg\" _src=\"http://yanxuan.nosdn.127.net/30607b946fa5245ab1376d28ab8d68c6.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d18e17059acf20d507fdb8f7054968a8.jpg\" _src=\"http://yanxuan.nosdn.127.net/d18e17059acf20d507fdb8f7054968a8.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/61a0539ce8ca1f38cce7c5647c94aaf7.jpg\" _src=\"http://yanxuan.nosdn.127.net/61a0539ce8ca1f38cce7c5647c94aaf7.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ec45424eef32b60e477bf6860f6c3ac2.jpg\" _src=\"http://yanxuan.nosdn.127.net/ec45424eef32b60e477bf6860f6c3ac2.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d2fb058299e851d21128af4c29bbf40f.jpg\" _src=\"http://yanxuan.nosdn.127.net/d2fb058299e851d21128af4c29bbf40f.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/88fcf4d3d09cc26809eaabf0df4ddc84.jpg\" _src=\"http://yanxuan.nosdn.127.net/88fcf4d3d09cc26809eaabf0df4ddc84.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/505360bfb9ae52b707d194195b547d1e.jpg\" _src=\"http://yanxuan.nosdn.127.net/505360bfb9ae52b707d194195b547d1e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d359fdfda280d2c7681adee5a533a65d.jpg\" _src=\"http://yanxuan.nosdn.127.net/d359fdfda280d2c7681adee5a533a65d.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/e6276ab49a773dedadd75da6529fc41b.jpg\" _src=\"http://yanxuan.nosdn.127.net/e6276ab49a773dedadd75da6529fc41b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/c6057375f8fdafdc1e8e7a894bb2f39a.jpg\" _src=\"http://yanxuan.nosdn.127.net/c6057375f8fdafdc1e8e7a894bb2f39a.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/2059408e8aee017c85e47c7267af21bc.jpg\" _src=\"http://yanxuan.nosdn.127.net/2059408e8aee017c85e47c7267af21bc.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0a7e4c7b19fd7822f89ccd63ca94b234.jpg\" _src=\"http://yanxuan.nosdn.127.net/0a7e4c7b19fd7822f89ccd63ca94b234.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/937329152fc61bff06d29d4b316b7259.jpg\" _src=\"http://yanxuan.nosdn.127.net/937329152fc61bff06d29d4b316b7259.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f7bc2c66157bd5e2cdc978460214d33c.jpg\" _src=\"http://yanxuan.nosdn.127.net/f7bc2c66157bd5e2cdc978460214d33c.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/55d327d74e2c768006fcce7f83cf0051.jpg\" _src=\"http://yanxuan.nosdn.127.net/55d327d74e2c768006fcce7f83cf0051.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/5d06b9bef3bae34d66d38e30fad204d4.jpg\" _src=\"http://yanxuan.nosdn.127.net/5d06b9bef3bae34d66d38e30fad204d4.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/e1f4f2ee0a473c251c055ffeb25426d0.jpg\" _src=\"http://yanxuan.nosdn.127.net/e1f4f2ee0a473c251c055ffeb25426d0.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/7b7efe85839b1f1ea17c829563fc9206.jpg\" _src=\"http://yanxuan.nosdn.127.net/7b7efe85839b1f1ea17c829563fc9206.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ca4091e28e5b8cfd76c1ad3de8fda999.jpg\" _src=\"http://yanxuan.nosdn.127.net/ca4091e28e5b8cfd76c1ad3de8fda999.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ebd7266b6b01bddadf4903e8ca66a82a.jpg\" _src=\"http://yanxuan.nosdn.127.net/ebd7266b6b01bddadf4903e8ca66a82a.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/db777171b81a10c51bae065de7fbef7f.jpg\" _src=\"http://yanxuan.nosdn.127.net/db777171b81a10c51bae065de7fbef7f.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/416626d4074c929f080eff87586a49e2.jpg\" _src=\"http://yanxuan.nosdn.127.net/416626d4074c929f080eff87586a49e2.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/c23701559de65d814e9062847e87c6db.jpg\" _src=\"http://yanxuan.nosdn.127.net/c23701559de65d814e9062847e87c6db.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/200d89ca470fa10ac02971f26cf8f7fd.jpg\" _src=\"http://yanxuan.nosdn.127.net/200d89ca470fa10ac02971f26cf8f7fd.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d6c39f0cf32656244e699eb21089f434.jpg\" _src=\"http://yanxuan.nosdn.127.net/d6c39f0cf32656244e699eb21089f434.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/287fa73c7e8b56eb8bd0ecee08c865da.jpg\" _src=\"http://yanxuan.nosdn.127.net/287fa73c7e8b56eb8bd0ecee08c865da.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0807995485258c26c712169290aac892.jpg\" _src=\"http://yanxuan.nosdn.127.net/0807995485258c26c712169290aac892.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/c29f153a2fada82300a904b2ca46eeeb.jpg\" _src=\"http://yanxuan.nosdn.127.net/c29f153a2fada82300a904b2ca46eeeb.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/bcd0c03d117c27a5c8856aabe577535e.jpg\" _src=\"http://yanxuan.nosdn.127.net/bcd0c03d117c27a5c8856aabe577535e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f9d6c1f265a891458ec9646801a9f790.jpg\" _src=\"http://yanxuan.nosdn.127.net/f9d6c1f265a891458ec9646801a9f790.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/6bce3852bdd99bc428e5339dcec1749b.jpg\" _src=\"http://yanxuan.nosdn.127.net/6bce3852bdd99bc428e5339dcec1749b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0076b7513361cb10daa6cdae51b0238f.jpg\" _src=\"http://yanxuan.nosdn.127.net/0076b7513361cb10daa6cdae51b0238f.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b289f3fdd57ba7c2f9bfed5cc235ad5d.jpg\" _src=\"http://yanxuan.nosdn.127.net/b289f3fdd57ba7c2f9bfed5cc235ad5d.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ea27ef8fcca46882e225ab03f29cc4c3.jpg\" _src=\"http://yanxuan.nosdn.127.net/ea27ef8fcca46882e225ab03f29cc4c3.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/c0bbddfd513a56bb4b4e60b0d7485261.jpg\" _src=\"http://yanxuan.nosdn.127.net/c0bbddfd513a56bb4b4e60b0d7485261.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/9b6904ddbb813688f8e1c36874437b8b.jpg\" _src=\"http://yanxuan.nosdn.127.net/9b6904ddbb813688f8e1c36874437b8b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/87439f2dc3805340736a508bfb4fc044.jpg\" _src=\"http://yanxuan.nosdn.127.net/87439f2dc3805340736a508bfb4fc044.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/29ca62c0aee1df52a9435ed2bf915b06.jpg\" _src=\"http://yanxuan.nosdn.127.net/29ca62c0aee1df52a9435ed2bf915b06.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/993cfb5a549e93a86ac5a5485221ded3.jpg\" _src=\"http://yanxuan.nosdn.127.net/993cfb5a549e93a86ac5a5485221ded3.jpg\" style=\"\"/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p>', ' ', NULL, NULL, 0, 0, '万和', '被子');
INSERT INTO `pms_product` VALUES (7, 1, 53, 0, 5, '日式和风懒人沙发 优质莱卡纯棉，和风家居新体验', 'http://yanxuan.nosdn.127.net/149dfa87a7324e184c5526ead81de9ad.png', '4533243', 0, 1, 1, 1, 0, 0, 0, 619.00, NULL, 0, 0, 0, '日式和风懒人沙发 优质莱卡纯棉，和风家居新体验', '日式和风懒人沙发 优质莱卡纯棉，和风家居新体验', 619.00, 100, 0, NULL, 0.00, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' <p><br/></p><p><img src=\"http://yanxuan.nosdn.127.net/34a6a0daa3f7a397a38aad14cb9e90fa.jpg\" _src=\"http://yanxuan.nosdn.127.net/34a6a0daa3f7a397a38aad14cb9e90fa.jpg\"/><br/></p><p><img src=\"http://yanxuan.nosdn.127.net/76637af0eec246b318cb129b768de637.jpg\" _src=\"http://yanxuan.nosdn.127.net/76637af0eec246b318cb129b768de637.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/18fee22626e61fc1d1a01916914016ba.jpg\" _src=\"http://yanxuan.nosdn.127.net/18fee22626e61fc1d1a01916914016ba.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/91f57a9bb142e1c1e2ff0bbea6f9af96.jpg\" _src=\"http://yanxuan.nosdn.127.net/91f57a9bb142e1c1e2ff0bbea6f9af96.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/252d80fd75eb1254d746d0b57c267650.jpg\" _src=\"http://yanxuan.nosdn.127.net/252d80fd75eb1254d746d0b57c267650.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/4b07697992a2b14de6fd0a5811936d71.jpg\" _src=\"http://yanxuan.nosdn.127.net/4b07697992a2b14de6fd0a5811936d71.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/c499439d6081bb4e836955b7514c1b96.jpg\" _src=\"http://yanxuan.nosdn.127.net/c499439d6081bb4e836955b7514c1b96.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/bed437fdc091d020a8f805bcc8830bd8.jpg\" _src=\"http://yanxuan.nosdn.127.net/bed437fdc091d020a8f805bcc8830bd8.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0fc5febdb817abd7a1040bab03f048b7.jpg\" _src=\"http://yanxuan.nosdn.127.net/0fc5febdb817abd7a1040bab03f048b7.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a0417b3986c9dc082124fcc360390021.jpg\" _src=\"http://yanxuan.nosdn.127.net/a0417b3986c9dc082124fcc360390021.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a5c9d24c652d4dee7946ef925105f3f2.jpg\" _src=\"http://yanxuan.nosdn.127.net/a5c9d24c652d4dee7946ef925105f3f2.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b10272c58f95dd6737ce1cd41452a21d.jpg\" _src=\"http://yanxuan.nosdn.127.net/b10272c58f95dd6737ce1cd41452a21d.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/510c6ef36760238b38ed59cd6e47a21f.png\" _src=\"http://yanxuan.nosdn.127.net/510c6ef36760238b38ed59cd6e47a21f.png\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/6371348b917c021c55dc393fc59d4d28.png\" _src=\"http://yanxuan.nosdn.127.net/6371348b917c021c55dc393fc59d4d28.png\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/de4079b128e57c5c0fa8a8177e9bc6e7.png\" _src=\"http://yanxuan.nosdn.127.net/de4079b128e57c5c0fa8a8177e9bc6e7.png\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/160966fbc772787f824dc1dbd5afb16d.png\" _src=\"http://yanxuan.nosdn.127.net/160966fbc772787f824dc1dbd5afb16d.png\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/bb3c8d3f10f2aca0908871c8e598aa0e.jpg\" _src=\"http://yanxuan.nosdn.127.net/bb3c8d3f10f2aca0908871c8e598aa0e.jpg\"/></p><p><br/></p>', ' ', NULL, NULL, 0, 0, '万和', '家具');
INSERT INTO `pms_product` VALUES (8, 1, 53, 0, 5, '色织华夫格夏凉被 凹凸华夫格织法，舒适轻柔', 'http://yanxuan.nosdn.127.net/07376e78bf4fb8a5aa8e6a0b1437c3ad.png', '4543364', 0, 1, 1, 1, 0, 0, 0, 319.00, NULL, 0, 0, 0, '色织华夫格夏凉被 凹凸华夫格织法，舒适轻柔', '色织华夫格夏凉被 凹凸华夫格织法，舒适轻柔', 319.00, 100, 0, NULL, 0.00, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' <p><img src=\"http://yanxuan.nosdn.127.net/70e21fc5c723dc6adcb1b531553597d9.jpg\" _src=\"http://yanxuan.nosdn.127.net/70e21fc5c723dc6adcb1b531553597d9.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/fcdf78276ab0bcd8ed80a3dda8c29b6a.jpg\" _src=\"http://yanxuan.nosdn.127.net/fcdf78276ab0bcd8ed80a3dda8c29b6a.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/1eb088a53d00f094bbac4b1f7a662457.jpg\" _src=\"http://yanxuan.nosdn.127.net/1eb088a53d00f094bbac4b1f7a662457.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/86be51c377922edd23e48b9d0c51d5dc.jpg\" _src=\"http://yanxuan.nosdn.127.net/86be51c377922edd23e48b9d0c51d5dc.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/e9cadf6589933fab072aef8c0644bb91.jpg\" _src=\"http://yanxuan.nosdn.127.net/e9cadf6589933fab072aef8c0644bb91.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/adbb912f1131f821f4d01bb29ed31450.jpg\" _src=\"http://yanxuan.nosdn.127.net/adbb912f1131f821f4d01bb29ed31450.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/8309ca74e9ecea295882b68cc0080652.jpg\" _src=\"http://yanxuan.nosdn.127.net/8309ca74e9ecea295882b68cc0080652.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/4cce90d2ad13258af815b828dd3fa34f.jpg\" _src=\"http://yanxuan.nosdn.127.net/4cce90d2ad13258af815b828dd3fa34f.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0ad6cf5c7f4ed107d39997ce1acfffd2.jpg\" _src=\"http://yanxuan.nosdn.127.net/0ad6cf5c7f4ed107d39997ce1acfffd2.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/4b867cc1a9f3c0046b40118e009a2cbd.jpg\" _src=\"http://yanxuan.nosdn.127.net/4b867cc1a9f3c0046b40118e009a2cbd.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b14b08ce203d77633340b1677f6196b6.jpg\" _src=\"http://yanxuan.nosdn.127.net/b14b08ce203d77633340b1677f6196b6.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b697d210e3137bc9fa8f5b74a9916ce6.jpg\" _src=\"http://yanxuan.nosdn.127.net/b697d210e3137bc9fa8f5b74a9916ce6.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a8b23b600cb5848d00eb1a176554f5de.jpg\" _src=\"http://yanxuan.nosdn.127.net/a8b23b600cb5848d00eb1a176554f5de.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0b76964151af30178e74e28d0d590fd7.jpg\" _src=\"http://yanxuan.nosdn.127.net/0b76964151af30178e74e28d0d590fd7.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3eda6586081f50314690ab9f141d1758.jpg\" _src=\"http://yanxuan.nosdn.127.net/3eda6586081f50314690ab9f141d1758.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/939f9ac497e48529e0c44ef5af32f329.jpg\" _src=\"http://yanxuan.nosdn.127.net/939f9ac497e48529e0c44ef5af32f329.jpg\" style=\"\"/></p><p><br/></p>', ' ', NULL, NULL, 0, 0, '万和', '被子');
INSERT INTO `pms_product` VALUES (9, 1, 50, 0, 5, '100年传世珐琅锅 全家系列 特质铸铁，大容量全家共享', 'http://yanxuan.nosdn.127.net/c39d54c06a71b4b61b6092a0d31f2335.png', '4523425', 0, 1, 1, 1, 0, 0, 0, 398.00, NULL, 0, 0, 0, '100年传世珐琅锅 全家系列 特质铸铁，大容量全家共享', '100年传世珐琅锅 全家系列 特质铸铁，大容量全家共享', 398.00, 100, 0, NULL, 0.00, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' <p><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN010F43k81owPLbaDWac_!!3192155289.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01GVp9g51owPLWUeVgA_!!3192155289.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01I0pPlI1owPLabm8t4_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01wEiXBg1owPLZsmyOP_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01Wvimll1owPLY34R3y_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN015VlaBI1owPLZslMeC_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01VbINp61owPLXljH3m_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN015IVOBn1owPLWUeVgy_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01lbinQH1owPLb7WSYt_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01hw1I8A1owPLc1NjHx_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01Dpt0xi1owPLb7YbcL_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN017DBrBS1owPLWUgWKX_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01L1qITs1owPLYU87of_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01HLcYrq1owPLZgfKdU_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01aA4wof1owPLVKSqsL_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01DrJeMc1owPLWUgFhi_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01eZsYUA1owPLabmPXM_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN016dQtz01owPLYU8G9C_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01SVysHk1owPLYME219_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01J5UQn91owPLYMCtMd_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01XJnV6N1owPLb7WrXU_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01IItU7s1owPLY362si_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01oEEvKU1owPLZgdrB5_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01k4Pisv1owPLXljTa0_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN019XbpVR1owPLZgdO6t_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01Quq7cb1owPLXlmYp0_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN017NhvmJ1owPLYU0H0t_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01miP3eX1owPLabnxBx_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01Qqm2hw1owPLYU7SHT_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01TYDSOq1owPLabncOa_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01cvon2L1owPLYU8KK7_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN0166iHKo1owPLYU7zXm_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01NmnWBD1owPLbaEKXU_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01ij7U6m1owPLXlkgRR_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01chrFfn1owPLYTyfGV_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01iZRSU51owPLXlk9B1_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01HgaP4L1owPLQl9H9j_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01R3qoqc1owPLQlB5PF_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN019D5gEp1owPLYMElmS_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01sXe5dl1owPLc1OT6c_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01DULS9C1owPLYU0PMG_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01rx75zR1owPLY37SAU_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01H9l9OO1owPLWUfqqS_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN014Ml5Cx1owPLY37mwk_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01DjMuhH1owPLYTyOdD_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01rZEI4O1owPLb7YTNR_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01z0ugHu1owPLZBuNTv_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01NVswYF1owPLZspWTl_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01i5bIJe1owPLbaECH8_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN016D5JhJ1owPLZBwOBM_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01u83w631owPLYU0fz0_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01AQCSre1owPLc1PfwT_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN012fc1Ut1owPLYU7n73_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN013FTlsN1owPLb7aHff_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01yTk7VZ1owPLZgeGC0_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01NDevPh1owPLZsmm3K_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01X9it9O1owPLWI1Vvz_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01xPWNeT1owPLbaFsFZ_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN019mGaN81owPLZgfKjJ_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01RrSPx61owPLc1QDDc_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01FIzjqY1owPLabocpl_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01MmijWV1owPLb7YL5g_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01h9HceI1owPLZBuiIJ_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN010bL4cC1owPLbaFfmb_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01vsv5KX1owPLY36Jax_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01UfZAeC1owPLZBvBNh_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN0182sngq1owPLaboh0M_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01rKElkz1owPLZgeGDp_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01pcVRJs1owPLc1Pk8m_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01idKTOt1owPLbaEOmA_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01hwGDsP1owPLZBwFuD_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN017dKu9n1owPLZggwWS_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01AeO69o1owPLZsnqbm_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN0169xKBq1owPLVKSWCw_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01pFpkyV1owPLb7ZTpy_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01R8lu161owPLc1QsoE_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01285guz1owPLY36z97_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01bSWWSt1owPLWUhSgE_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01YVF2Xt1owPLYTz4HH_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01S83CAn1owPLYTySsd_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01eZqxce1owPLZBwrLH_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01nnKHFJ1owPLZBuunh_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01J9Zr9t1owPLWI1733_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN019KscTF1owPLXlkx9k_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01yOeAN61owPLbaHcOH_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01Fux6xc1owPLWUhb0i_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN019bo7y71owPLb7axJG_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN0182zV531owPLZspvUH_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01c8op7O1owPLbaIguu_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01yIrdIX1owPLZsnmUQ_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN011ohcNb1owPLYUB0is_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01Ip7V3p1owPLXlmxtQ_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"></p>', ' ', NULL, NULL, 0, 0, '万和', '家具');
INSERT INTO `pms_product` VALUES (10, 1, 54, 0, 5, '方形封闭式宠物窝 封闭式设计猫咪独享', 'http://yanxuan.nosdn.127.net/337da7094c1df295ca0f0b8baa55b2d5.png', '4523434', 0, 1, 1, 1, 0, 0, 0, 119.00, NULL, 0, 0, 0, '方形封闭式宠物窝 封闭式设计猫咪独享', '方形封闭式宠物窝 封闭式设计猫咪独享', 119.00, 100, 0, NULL, 0.00, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' <p><img src=\"http://yanxuan.nosdn.127.net/09f022af55341d80d5d3ad620ce6d779.jpg\" _src=\"http://yanxuan.nosdn.127.net/09f022af55341d80d5d3ad620ce6d779.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d75ea4c580effd435ed00f652c01a778.jpg\" _src=\"http://yanxuan.nosdn.127.net/d75ea4c580effd435ed00f652c01a778.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/8fad82d53a0494c625608786f5931950.jpg\" _src=\"http://yanxuan.nosdn.127.net/8fad82d53a0494c625608786f5931950.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0a1d8a1cb8a57ae7921f34a9d761f3aa.jpg\" _src=\"http://yanxuan.nosdn.127.net/0a1d8a1cb8a57ae7921f34a9d761f3aa.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/261670eea6a48c7e307393ce295e2ce5.jpg\" _src=\"http://yanxuan.nosdn.127.net/261670eea6a48c7e307393ce295e2ce5.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/11bfc68005a0ce9b80e01f614a259af7.jpg\" _src=\"http://yanxuan.nosdn.127.net/11bfc68005a0ce9b80e01f614a259af7.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/688f822cf34c656367cccfb0d9f72151.jpg\" _src=\"http://yanxuan.nosdn.127.net/688f822cf34c656367cccfb0d9f72151.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f3721906d7c6c0c30193d4778eff9e4e.jpg\" _src=\"http://yanxuan.nosdn.127.net/f3721906d7c6c0c30193d4778eff9e4e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/090e9c28dc2736a1246ef914e35634c4.jpg\" _src=\"http://yanxuan.nosdn.127.net/090e9c28dc2736a1246ef914e35634c4.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f31d497ae028ff2c2e933d712ccc055d.jpg\" _src=\"http://yanxuan.nosdn.127.net/f31d497ae028ff2c2e933d712ccc055d.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a424b9e51b854c4abf61b8c1c1cdf1aa.jpg\" _src=\"http://yanxuan.nosdn.127.net/a424b9e51b854c4abf61b8c1c1cdf1aa.jpg\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/7660d03152dea988256eac3be92541b3.jpg\" _src=\"http://yanxuan.nosdn.127.net/7660d03152dea988256eac3be92541b3.jpg\" style=\"\"/></p><p><br/></p>', ' ', NULL, NULL, 0, 0, '万和', '家具');
INSERT INTO `pms_product` VALUES (11, 1, 54, 0, 5, '六边形南瓜式宠物窝 给萌宠柔软包裹的归家感', 'http://yanxuan.nosdn.127.net/58ed94b63b39339e7814f1339013793c.png', '4532411', 0, 1, 1, 1, 0, 0, 0, 139.00, NULL, 0, 0, 0, '六边形南瓜式宠物窝 给萌宠柔软包裹的归家感', '六边形南瓜式宠物窝 给萌宠柔软包裹的归家感', 139.00, 100, 0, NULL, 0.00, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' <p><img src=\"http://yanxuan.nosdn.127.net/44f4fe5b43365884131b07c25b3c54ca.jpg\" _src=\"http://yanxuan.nosdn.127.net/44f4fe5b43365884131b07c25b3c54ca.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/beabfe6fd0717daa3544ac7c2d82b430.jpg\" _src=\"http://yanxuan.nosdn.127.net/beabfe6fd0717daa3544ac7c2d82b430.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/25467804bf2eed0d07f171c10f798d2e.jpg\" _src=\"http://yanxuan.nosdn.127.net/25467804bf2eed0d07f171c10f798d2e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/7fced8c058df228bed15bc8822fa871c.jpg\" _src=\"http://yanxuan.nosdn.127.net/7fced8c058df228bed15bc8822fa871c.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a3eea3bd19f75f01a7ed424be3aa9d42.jpg\" _src=\"http://yanxuan.nosdn.127.net/a3eea3bd19f75f01a7ed424be3aa9d42.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/e30076799805a678af405dce6ccf6d62.jpg\" _src=\"http://yanxuan.nosdn.127.net/e30076799805a678af405dce6ccf6d62.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ac4cdbb579512a23287b4a43639b5e34.jpg\" _src=\"http://yanxuan.nosdn.127.net/ac4cdbb579512a23287b4a43639b5e34.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/2cf8b27e7c89f0a46cbd330bb81ab1a5.jpg\" _src=\"http://yanxuan.nosdn.127.net/2cf8b27e7c89f0a46cbd330bb81ab1a5.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3021babd417d3b3791db8b9684c9a07e.jpg\" _src=\"http://yanxuan.nosdn.127.net/3021babd417d3b3791db8b9684c9a07e.jpg\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a72b172bf0e8ad6d0d6735750e1d375c.jpg\" _src=\"http://yanxuan.nosdn.127.net/a72b172bf0e8ad6d0d6735750e1d375c.jpg\" style=\"\"/></p><p><br/></p>', ' ', NULL, NULL, 0, 0, '万和', '家具');
INSERT INTO `pms_product` VALUES (12, 1, 54, 0, 5, '日式纯色水洗亚麻抱枕 水洗亚麻，透气亲肤', 'http://yanxuan.nosdn.127.net/8a9ee5ba08929cc9e40b973607d2f633.png', '4521354', 0, 1, 1, 1, 0, 0, 0, 99.00, NULL, 0, 0, 0, '日式纯色水洗亚麻抱枕 水洗亚麻，透气亲肤', '日式纯色水洗亚麻抱枕 水洗亚麻，透气亲肤', 99.00, 100, 0, NULL, 0.00, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' <p><img src=\"http://yanxuan.nosdn.127.net/6b69f7597ccffd27d77467d9d04eb294.jpg\" _src=\"http://yanxuan.nosdn.127.net/6b69f7597ccffd27d77467d9d04eb294.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a89ca371ef07355c1feb293db961bd30.jpg\" _src=\"http://yanxuan.nosdn.127.net/a89ca371ef07355c1feb293db961bd30.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/2076e89c5f8fde4f44f918bd02d18eb7.jpg\" _src=\"http://yanxuan.nosdn.127.net/2076e89c5f8fde4f44f918bd02d18eb7.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/5c9111e4dcc13cb41db98f68086cc620.jpg\" _src=\"http://yanxuan.nosdn.127.net/5c9111e4dcc13cb41db98f68086cc620.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/8f0645abcf883e7a863f32ce95f3c26b.jpg\" _src=\"http://yanxuan.nosdn.127.net/8f0645abcf883e7a863f32ce95f3c26b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/76a2b12f2d0f48f268d18b0ca0d1d6bb.jpg\" _src=\"http://yanxuan.nosdn.127.net/76a2b12f2d0f48f268d18b0ca0d1d6bb.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a91f75159867f33a91f4e9992e00afa1.jpg\" _src=\"http://yanxuan.nosdn.127.net/a91f75159867f33a91f4e9992e00afa1.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/93de61256a8ff3a8aa4bb90847ff454e.jpg\" _src=\"http://yanxuan.nosdn.127.net/93de61256a8ff3a8aa4bb90847ff454e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f611f99bea2920881e1421c110970234.jpg\" _src=\"http://yanxuan.nosdn.127.net/f611f99bea2920881e1421c110970234.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a292339423f141ad5d7a4011ea316956.jpg\" _src=\"http://yanxuan.nosdn.127.net/a292339423f141ad5d7a4011ea316956.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/2045ae4f861d9eae6af351b9d82c9239.jpg\" _src=\"http://yanxuan.nosdn.127.net/2045ae4f861d9eae6af351b9d82c9239.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/398718a6d579c4af5f255909283e44a2.jpg\" _src=\"http://yanxuan.nosdn.127.net/398718a6d579c4af5f255909283e44a2.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/5be95e2db627908d23605fe042af2937.jpg\" _src=\"http://yanxuan.nosdn.127.net/5be95e2db627908d23605fe042af2937.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/50a4fa0f67aa85dfaad36695225fe2f8.jpg\" _src=\"http://yanxuan.nosdn.127.net/50a4fa0f67aa85dfaad36695225fe2f8.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/7c825e297cfbaaae632146a55c61dc3c.jpg\" _src=\"http://yanxuan.nosdn.127.net/7c825e297cfbaaae632146a55c61dc3c.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/261c7819e7e9ac165e64cae88a59f70c.jpg\" _src=\"http://yanxuan.nosdn.127.net/261c7819e7e9ac165e64cae88a59f70c.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ec83f40d91fcc79f59a2479dffeb4565.jpg\" _src=\"http://yanxuan.nosdn.127.net/ec83f40d91fcc79f59a2479dffeb4565.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/26f3e85402086b7d261a650e244dc676.jpg\" _src=\"http://yanxuan.nosdn.127.net/26f3e85402086b7d261a650e244dc676.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/dccb68f0d97112d245ab1924744b94b8.jpg\" _src=\"http://yanxuan.nosdn.127.net/dccb68f0d97112d245ab1924744b94b8.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/aaba69949efd7ed85e72071f4ade4945.jpg\" _src=\"http://yanxuan.nosdn.127.net/aaba69949efd7ed85e72071f4ade4945.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3f23300061e5cf871e86a51f0012e885.jpg\" _src=\"http://yanxuan.nosdn.127.net/3f23300061e5cf871e86a51f0012e885.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a55eedca057e0c973549ac8f13b47800.jpg\" _src=\"http://yanxuan.nosdn.127.net/a55eedca057e0c973549ac8f13b47800.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/abf16e831285e3d97dbb60a3162e7968.jpg\" _src=\"http://yanxuan.nosdn.127.net/abf16e831285e3d97dbb60a3162e7968.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a9390c8dab9fc7d8c27ac9410eb0340c.jpg\" _src=\"http://yanxuan.nosdn.127.net/a9390c8dab9fc7d8c27ac9410eb0340c.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/8feb2be5afec5abe439cf1b42683373f.jpg\" _src=\"http://yanxuan.nosdn.127.net/8feb2be5afec5abe439cf1b42683373f.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/beb7620d0f685ab9c3af7ed18284b29e.jpg\" _src=\"http://yanxuan.nosdn.127.net/beb7620d0f685ab9c3af7ed18284b29e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/7f70ceed2078d44d747a9ce369feee9e.jpg\" _src=\"http://yanxuan.nosdn.127.net/7f70ceed2078d44d747a9ce369feee9e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/5469e219bd5347568337746b257f094e.jpg\" _src=\"http://yanxuan.nosdn.127.net/5469e219bd5347568337746b257f094e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a177a6b6e58580809330895ebdbaff6b.jpg\" _src=\"http://yanxuan.nosdn.127.net/a177a6b6e58580809330895ebdbaff6b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/9db0090d56ab757babb2ba661726cbe3.jpg\" _src=\"http://yanxuan.nosdn.127.net/9db0090d56ab757babb2ba661726cbe3.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/6363637e0dd2fc670745c217b2a5cbfc.jpg\" _src=\"http://yanxuan.nosdn.127.net/6363637e0dd2fc670745c217b2a5cbfc.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/1af1bde98f1497f591f62bff99ccca54.jpg\" _src=\"http://yanxuan.nosdn.127.net/1af1bde98f1497f591f62bff99ccca54.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/69d034b353ae2e6e30afb6c21483690f.jpg\" _src=\"http://yanxuan.nosdn.127.net/69d034b353ae2e6e30afb6c21483690f.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/4e29d6ac5ed040d63847ca456a179d43.jpg\" _src=\"http://yanxuan.nosdn.127.net/4e29d6ac5ed040d63847ca456a179d43.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/29e460fba57f67cd83121f6cb917cfbd.jpg\" _src=\"http://yanxuan.nosdn.127.net/29e460fba57f67cd83121f6cb917cfbd.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/16090c02f4d4b76c6be82d98e489586e.jpg\" _src=\"http://yanxuan.nosdn.127.net/16090c02f4d4b76c6be82d98e489586e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/c840eb66cf002227c52a13fbe55f657b.jpg\" _src=\"http://yanxuan.nosdn.127.net/c840eb66cf002227c52a13fbe55f657b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/16f65265b0942a60f3241704dc29be13.jpg\" _src=\"http://yanxuan.nosdn.127.net/16f65265b0942a60f3241704dc29be13.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/54a63da54b4e80867d8cd92d1ea9576e.jpg\" _src=\"http://yanxuan.nosdn.127.net/54a63da54b4e80867d8cd92d1ea9576e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ebd0b906076850983e5a2aae9f667ce7.jpg\" _src=\"http://yanxuan.nosdn.127.net/ebd0b906076850983e5a2aae9f667ce7.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/bbf32cdc82643a85c12ff05ea88088ad.jpg\" _src=\"http://yanxuan.nosdn.127.net/bbf32cdc82643a85c12ff05ea88088ad.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ca6e3ccc3725c3f58338b62a5a0655d3.jpg\" _src=\"http://yanxuan.nosdn.127.net/ca6e3ccc3725c3f58338b62a5a0655d3.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/6ef02962e6155f811566aad168dabbec.jpg\" _src=\"http://yanxuan.nosdn.127.net/6ef02962e6155f811566aad168dabbec.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/832735166071f05288ffd347dff58ee6.jpg\" _src=\"http://yanxuan.nosdn.127.net/832735166071f05288ffd347dff58ee6.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/4fc490c4e9a0a0fa0affd317b8526f4e.jpg\" _src=\"http://yanxuan.nosdn.127.net/4fc490c4e9a0a0fa0affd317b8526f4e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/1b05f975f16c09f106c81533c1a249b0.jpg\" _src=\"http://yanxuan.nosdn.127.net/1b05f975f16c09f106c81533c1a249b0.jpg\" style=\"\"/></p><p><br/></p>', ' ', NULL, NULL, 0, 0, '万和', '家具');
INSERT INTO `pms_product` VALUES (13, 1, 54, 0, 5, '澳洲羊羔毛华夫格盖毯 美利奴全新羊羔毛的细腻触感', 'http://yanxuan.nosdn.127.net/a803c68ea88e3116023b45ac9ea99510.png', '4533432', 0, 1, 1, 1, 0, 0, 0, 369.00, NULL, 0, 0, 0, '澳洲羊羔毛华夫格盖毯 美利奴全新羊羔毛的细腻触感', '澳洲羊羔毛华夫格盖毯 美利奴全新羊羔毛的细腻触感', 369.00, 100, 0, NULL, 0.00, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' <p><img src=\"http://yanxuan.nosdn.127.net/3f743d4b4f30ddffdfee6339d83701c9.jpg\" _src=\"http://yanxuan.nosdn.127.net/3f743d4b4f30ddffdfee6339d83701c9.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/bf2c4b3d138da32aae6b3ffcdaedeb73.jpg\" _src=\"http://yanxuan.nosdn.127.net/bf2c4b3d138da32aae6b3ffcdaedeb73.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3536d6deabba614dd9a8730875a37d36.jpg\" _src=\"http://yanxuan.nosdn.127.net/3536d6deabba614dd9a8730875a37d36.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b8d889753ccee9174a5449041aba57db.jpg\" _src=\"http://yanxuan.nosdn.127.net/b8d889753ccee9174a5449041aba57db.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0785a14712f2d585fea3776a8775f1e4.jpg\" _src=\"http://yanxuan.nosdn.127.net/0785a14712f2d585fea3776a8775f1e4.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b0c3756c5f4e96c0f37167dce9628a8b.jpg\" _src=\"http://yanxuan.nosdn.127.net/b0c3756c5f4e96c0f37167dce9628a8b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/4a196080fd7b76bf9e4b2c97afc1028d.jpg\" _src=\"http://yanxuan.nosdn.127.net/4a196080fd7b76bf9e4b2c97afc1028d.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/e0d6859834701a093327e3710b52b5b0.jpg\" _src=\"http://yanxuan.nosdn.127.net/e0d6859834701a093327e3710b52b5b0.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/db0116b70973635ca8ff7be78bf5f541.jpg\" _src=\"http://yanxuan.nosdn.127.net/db0116b70973635ca8ff7be78bf5f541.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f066780f86264b0bc037b945b81b1406.jpg\" _src=\"http://yanxuan.nosdn.127.net/f066780f86264b0bc037b945b81b1406.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f0d87991c9a1874693cfecc52c6e1197.jpg\" _src=\"http://yanxuan.nosdn.127.net/f0d87991c9a1874693cfecc52c6e1197.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0a450d55776a981ac9aa87af0a7c418f.jpg\" _src=\"http://yanxuan.nosdn.127.net/0a450d55776a981ac9aa87af0a7c418f.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b450e5950181bf464baff2b7e79188d6.jpg\" _src=\"http://yanxuan.nosdn.127.net/b450e5950181bf464baff2b7e79188d6.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/bebe0b8259c7fdd88509947ef0a8037a.jpg\" _src=\"http://yanxuan.nosdn.127.net/bebe0b8259c7fdd88509947ef0a8037a.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/10be9b68827caaa1b67077c7c5bdf05b.jpg\" _src=\"http://yanxuan.nosdn.127.net/10be9b68827caaa1b67077c7c5bdf05b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/56c0dd020ab4aceeb696520df5c8780c.jpg\" _src=\"http://yanxuan.nosdn.127.net/56c0dd020ab4aceeb696520df5c8780c.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d2176b1f79b255d89206f044e42c3812.jpg\" _src=\"http://yanxuan.nosdn.127.net/d2176b1f79b255d89206f044e42c3812.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/389af26a26c1ac3ebae82afeca4850f2.jpg\" _src=\"http://yanxuan.nosdn.127.net/389af26a26c1ac3ebae82afeca4850f2.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0897b52523d43efaa5b66449d97a2e5c.jpg\" _src=\"http://yanxuan.nosdn.127.net/0897b52523d43efaa5b66449d97a2e5c.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3fbbb2da0b5019ddacc6761ebc691902.jpg\" _src=\"http://yanxuan.nosdn.127.net/3fbbb2da0b5019ddacc6761ebc691902.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/1d8576b1472852a8ab96a30d4d8536c6.jpg\" _src=\"http://yanxuan.nosdn.127.net/1d8576b1472852a8ab96a30d4d8536c6.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/4df95e96ca354efec574e01297fd9e2b.jpg\" _src=\"http://yanxuan.nosdn.127.net/4df95e96ca354efec574e01297fd9e2b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d98a831ff4adeccd093c3fd8ddbc026b.jpg\" _src=\"http://yanxuan.nosdn.127.net/d98a831ff4adeccd093c3fd8ddbc026b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f6050089684ca291a045ab0eea483aab.jpg\" _src=\"http://yanxuan.nosdn.127.net/f6050089684ca291a045ab0eea483aab.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/96b0c33ae3b402863bde7b830b817866.jpg\" _src=\"http://yanxuan.nosdn.127.net/96b0c33ae3b402863bde7b830b817866.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/6d7d595ae0df9e126dca6926b17c3afe.jpg\" _src=\"http://yanxuan.nosdn.127.net/6d7d595ae0df9e126dca6926b17c3afe.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a4230ca0e414599c38b22c677eac8a2f.jpg\" _src=\"http://yanxuan.nosdn.127.net/a4230ca0e414599c38b22c677eac8a2f.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/aad253305dcdb44bdbfb519a503823da.jpg\" _src=\"http://yanxuan.nosdn.127.net/aad253305dcdb44bdbfb519a503823da.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b512ead08406712b5d98abf20ebe7691.jpg\" _src=\"http://yanxuan.nosdn.127.net/b512ead08406712b5d98abf20ebe7691.jpg\" style=\"\"/></p><p><br/></p>', ' ', NULL, NULL, 0, 0, '万和', '家具');
INSERT INTO `pms_product` VALUES (14, 1, 54, 0, 5, '清欢日式可调节台灯 木铁结合，全体可调节', 'http://yanxuan.nosdn.127.net/c83a3881704094ddd3970099ca77d115.png', '4512354', 0, 1, 1, 1, 0, 0, 0, 219.00, NULL, 0, 0, 0, '清欢日式可调节台灯 木铁结合，全体可调节', '清欢日式可调节台灯 木铁结合，全体可调节', 219.00, 100, 0, NULL, 0.00, 0, '', ' ', ' ', ' ', ' ', ' ', ' <p><img src=\"http://yanxuan.nosdn.127.net/15e1d839714a67bff57259d61d7ca2e5.jpg\" _src=\"http://yanxuan.nosdn.127.net/15e1d839714a67bff57259d61d7ca2e5.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/43ba9bbc931f954e0aaeb90631a179ac.jpg\" _src=\"http://yanxuan.nosdn.127.net/43ba9bbc931f954e0aaeb90631a179ac.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ac5ca160c90c1a700160d5d024ad611b.jpg\" _src=\"http://yanxuan.nosdn.127.net/ac5ca160c90c1a700160d5d024ad611b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0f2d157d83955d5c616dc3d647da6f66.jpg\" _src=\"http://yanxuan.nosdn.127.net/0f2d157d83955d5c616dc3d647da6f66.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a2ee5af100a5432f0614e9717196787e.jpg\" _src=\"http://yanxuan.nosdn.127.net/a2ee5af100a5432f0614e9717196787e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/91fb28c19d495e47797ef250940ab618.jpg\" _src=\"http://yanxuan.nosdn.127.net/91fb28c19d495e47797ef250940ab618.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/6f37742eed13ea12d8c341e1e3b988e9.jpg\" _src=\"http://yanxuan.nosdn.127.net/6f37742eed13ea12d8c341e1e3b988e9.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/5ff15b419a0248b7b53bd60286067766.jpg\" _src=\"http://yanxuan.nosdn.127.net/5ff15b419a0248b7b53bd60286067766.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/21c4dacdc844da911e43eaac0975908a.jpg\" _src=\"http://yanxuan.nosdn.127.net/21c4dacdc844da911e43eaac0975908a.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3f8741dd387c51378f78bdbf65856a41.jpg\" _src=\"http://yanxuan.nosdn.127.net/3f8741dd387c51378f78bdbf65856a41.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/dbe9726936999c62ac8bce3b620cd045.jpg\" _src=\"http://yanxuan.nosdn.127.net/dbe9726936999c62ac8bce3b620cd045.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d12ad2de3cb646e76380c064ccfe038f.jpg\" _src=\"http://yanxuan.nosdn.127.net/d12ad2de3cb646e76380c064ccfe038f.jpg\" style=\"\"/></p><p><br/></p>', ' ', NULL, NULL, 0, 0, '万和', '家具');
INSERT INTO `pms_product` VALUES (15, 3, 30, 0, 3, '华为Mate 40 Pro 4G麒麟曲面华为手机4g手机智能手机华为官方旗舰店mate40pro', 'https://img.alicdn.com/imgextra/i1/2838892713/O1CN01FQ69AI1VubCzlAzxB_!!0-item_pic.jpg_430x430q90.jpg', '3543543', 0, 1, 1, 1, 0, 0, 0, 6099.00, NULL, 0, 0, 0, '华为Mate 40 Pro 4G麒麟曲面华为手机4g手机智能手机华为官方旗舰店mate40pro', '华为Mate 40 Pro 4G麒麟曲面华为手机4g手机智能手机华为官方旗舰店mate40pro', 6099.00, 100, 0, NULL, 0.00, 0, '', NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01OpTSba1VubD4cpJiK_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/TB2vbKTgHArBKNjSZFLXXc_dVXa_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01sx3JEX1VubD1UVV2U_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01sdVgGG1VubD6nfEk2_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01E5ZlFd1VubD0EZtoL_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN017LAhra1VubD1kTfYK_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01KshuGt1VubCxenTQB_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN019lwo3i1VubCxensNV_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01t6VwkB1VubCwERR3M_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01fgufJg1VubD3lMoyR_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01cFbUtW1VubD0COovF_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01Nust0w1VubCyEFnBT_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01vdxhTK1VubCwEQxxC_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01pSl16B1VubD6nfZYg_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01fEsRon1VubD5yY1I5_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01GkA7tk1VubD5HOdxy_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01FuKFpI1VubD3lMkpz_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN019lxW3z1VubCyEHwFo_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01vJmvHM1VubD3lNUaN_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01KaZsux1VubD0EaR7O_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01YZKHTG1VubCyEI0PM_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01vwN4pf1VubD6nfZaA_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01bnWqPs1VubD4FKIm5_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01h7LRGx1VubD7S6AjB_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01Viu4Dv1VubD0EbAra_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN010G61NF1VubCxeqxic_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01QoAWzw1VubD4FMz8a_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01A0WT2r1VubD5HOAu4_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01okBoN01VubD7S7JR7_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01OSQJ7j1VubCxer1sm_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01G4SAhi1VubD0CNgHm_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN013kwXkx1VubD1UUE8L_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01mM9F5M1VubD3lMp38_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01w43zZC1VubD3lMxOu_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01KEAHr81VubD2thVNn_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01b6L78y1VubD3lOlo5_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01EMbdi71VubD0CSVuo_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01lqmpDD1VubCyELy1T_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01prLTNk1VubD2tkvbR_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN0148r2OR1VubD5yeWyk_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01hH3KsL1VubD4FRcPJ_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01PLwvsZ1VubD7S9roB_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01n8k5z81VubCwEY0yj_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN016X8IZj1Vub8wYRqqN_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, '华为', '手机数码');
INSERT INTO `pms_product` VALUES (16, 3, 30, 0, 3, '【旗舰新品】华为P50 Pro 4G全网通搭载HarmonyOS 2麒麟9000华为手机华为官方旗舰店正品p50pro', 'https://img.alicdn.com/imgextra/i4/2024314280/O1CN01mT2FdK1hUHrFa4LK6_!!2024314280.jpg_430x430q90.jpg', '2343525', 0, 1, 1, 1, 0, 0, 0, 7488.00, NULL, 0, 0, 0, '【旗舰新品】华为P50 Pro 4G全网通搭载HarmonyOS 2麒麟9000华为手机华为官方旗舰店正品p50pro', '【旗舰新品】华为P50 Pro 4G全网通搭载HarmonyOS 2麒麟9000华为手机华为官方旗舰店正品p50pro', 7488.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01YWuuBq1VubDpYER3N_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01g58P1h1VubDn732oG_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01hF9lQa1VubDyuDzRD_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN013YCfRy1VubDrDmHeW_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01Ga8cYr1VubDiT2RLQ_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01pPGzmj1VubDxIOrTK_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN016eLylU1VubDiT3NVH_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01guAY1F1VubDiT32ke_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01x3kHec1VubDv21Ppv_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01vqUraq1VubDxINzQb_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN018hejDS1VubDsuoCMW_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01lyS8Ky1VubDseSSnj_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01bzmTWn1VubDv1zbYR_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01uKW7n11VubDrDpEdN_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN018o2TZY1VubDv22M5E_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN014Hut9u1VubDv23hDW_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01kZG6xc1VubDrmkC9w_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01827RQs1VubDiT32mG_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01wQiWn41VubDn76w4W_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01yUKC0p1VubDvWvpuc_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01BFQJ1t1VubDn74ipm_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01ZTGV5e1VubDyuG0B7_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01KaAHJU1VubDwZMXKb_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01ruCNZC1VubDxIOnMf_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01GTHHBC1VubDwZKBoL_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01WSgoeH1VubDoaSKPQ_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01ls9TFS1VubDsunSgN_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01dZFjOj1VubDxIPCJM_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN014OwcN31VubDv23lPk_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01JbKPjX1Vub8xCTg6O_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> </p>', NULL, NULL, NULL, 0, 0, '华为', '手机数码');
INSERT INTO `pms_product` VALUES (17, 3, 30, 0, 3, '华为平板HUAWEI MatePad Pro 10.8英寸2021款鸿蒙HarmonyOS官方新品教育数码学生电脑8GB内存', 'https://img.alicdn.com/imgextra/i2/2838892713/O1CN016tezkQ1VubD4AbBxX_!!2838892713.jpg_430x430q90.jpg', '2425343', 0, 1, 1, 1, 0, 0, 0, 4299.00, NULL, 0, 0, 0, '华为平板HUAWEI MatePad Pro 10.8英寸2021款鸿蒙HarmonyOS官方新品教育数码学生电脑8GB内存', '华为平板HUAWEI MatePad Pro 10.8英寸2021款鸿蒙HarmonyOS官方新品教育数码学生电脑8GB内存', 4299.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01cIJDXV1VubEEzKcok_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN012SbO6Z1VubDN6DYs0_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01fwQYhJ1VubD63d9KS_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01aGIm7X1VubD2yy2qn_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01ME0Yh91VubDlhNt03_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01pHh6r11Vub9uANS94_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01mOFtWp1VubDYe3G9Z_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01DmOiIr1VubDX3O23R_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\" data-spm-anchor-id=\"a220o.1000855.0.i0.494e35ae0Eipxj\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01H5yIwO1VubDYe1iUD_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01vnR8iy1VubDRCD8Ob_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01teVwo81VubDRCDo00_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN0110oYhX1VubDWM9gqO_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN013b7tAq1VubDYe5L35_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01cIRc5q1VubDWM8HWq_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01EFSvBZ1VubDRCGp97_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01Rq1tdY1VubDWM8Lhr_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01AyimLk1Vub8sk4O3e_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, '华为', '手机数码');
INSERT INTO `pms_product` VALUES (18, 10, 31, 0, 3, 'Apple/苹果 iPhone 12 国行手机', 'https://img.alicdn.com/imgextra/i1/1917047079/O1CN01xeHXfg22AEQKtkTiK_!!1917047079.png_430x430q90.jpg', '1243543', 0, 1, 1, 1, 0, 0, 0, 6799.00, NULL, 0, 0, 0, 'Apple/苹果 iPhone 12【直营国行】Apple/苹果 AirPods Pro耳机三代原装正品 全国联保', 'Apple/苹果 iPhone 12', 6799.00, 199, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<div class=\"content ke-post\" style=\"height: auto;\"><div style=\"width: 790.0px;\">	<div style=\"float: left;\">		 <img src=\"https://img.alicdn.com/imgextra/i4/1917047079/O1CN01m365lv22AERZKUNBg_!!1917047079.jpg\" width=\"790\" border=\"0\" class=\"img-ks-lazyload\">	</div>	<div style=\"float: left;margin-top: 6.0px;\">		 <img src=\"https://img.alicdn.com/imgextra/i3/1917047079/O1CN01DUglFy22AESAm9BFq_!!1917047079.jpg\" width=\"790\" border=\"0\" class=\"img-ks-lazyload\">	</div>	<div style=\"float: left;\">		 <img src=\"https://img.alicdn.com/imgextra/i1/1917047079/O1CN01H0KILj22AERzyp2VZ_!!1917047079.jpg\" width=\"790\" border=\"0\" class=\"img-ks-lazyload\">	</div>	<div style=\"float: left;\">		 <img src=\"https://img.alicdn.com/imgextra/i4/1917047079/O1CN01nLojAj22AERtg5MjN_!!1917047079.jpg\" width=\"790\" border=\"0\" class=\"img-ks-lazyload\">	</div>	<div style=\"float: left;\">		 <img src=\"https://img.alicdn.com/imgextra/i4/1917047079/O1CN01kesoUZ22AERtvONkH_!!1917047079.jpg\" width=\"790\" border=\"0\" class=\"img-ks-lazyload\">	</div>	<div style=\"float: left;\">		 <img src=\"https://img.alicdn.com/imgextra/i4/1917047079/O1CN01DLhGVL22AEOYEuVHp_!!1917047079.jpg\" width=\"790\" border=\"0\" class=\"img-ks-lazyload\">	</div></div></div>', NULL, NULL, NULL, 0, 0, '苹果', '手机数码');
INSERT INTO `pms_product` VALUES (19, 10, 31, 0, 3, '【直营国行】Apple/苹果 AirPods Pro耳机三代原装正品 全国联保', 'https://img.alicdn.com/imgextra/i2/2200877014436/O1CN01anNk4S1idjZTDktag_!!2200877014436.jpg_430x430q90.jpg', '2354344', 0, 1, 1, 1, 0, 0, 0, 1778.00, NULL, 0, 0, 0, '【直营国行】Apple/苹果 AirPods Pro耳机三代原装正品 全国联保', '【直营国行】Apple/苹果 AirPods Pro耳机三代原装正品 全国联保', 1778.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN01TBYQAD26TFHLj8qqx_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN018fGCQU26TFHOCaxVd_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2208774577662/O1CN01TA2FYd26TFHMJK9wz_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2208774577662/O1CN01KuXr9f26TFHMSY10j_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2208774577662/O1CN015y7q0m26TFHQonltB_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN01hXTx5T26TFHPzhhDg_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2208774577662/O1CN01j6RF9826TFHR9H16P_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN010WFToD26TFHMJI55s_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN01tc4qV326TFHLn9rTf_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2208774577662/O1CN01XFNWaG26TFHMSaEEz_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN01RcIhuQ26TFHOCZcLq_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN01P1v1s926TFHJiPRJA_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2208774577662/O1CN01bawyiF26TFHPLtIY9_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN01skzS1c26TFJQ51Vup_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2208774577662/O1CN01jvSnhj26TFJRxjwE2_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2208774577662/O1CN01WjWtis26TFJTkm6ab_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2208774577662/O1CN01VdZldp26TFJZt1W1w_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN01zm24T226TFJRxjGe5_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2208774577662/O1CN01QhVaqH26TFJWz0HMX_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2208774577662/O1CN014ldHx426TFJRLWMIQ_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2208774577662/O1CN01EXQMmE26TFJV8Dp6B_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2208774577662/O1CN011IYQUp26TFJRxlPjX_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, '苹果', '手机数码');
INSERT INTO `pms_product` VALUES (20, 10, 31, 0, 3, 'Apple/苹果 11 英寸 iPad Pro', 'https://img.alicdn.com/imgextra/i1/1917047079/O1CN01qC9RZb22AEQNIo08f_!!2-item_pic.png_430x430q90.jpg', '2343534', 0, 1, 1, 1, 0, 0, 0, 6999.00, NULL, 0, 0, 0, 'Apple/苹果 11 英寸 iPad Pro', 'Apple/苹果 11 英寸 iPad Pro', 6999.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<div style=\"float: left;margin-top: 6.0px;\">		 <img src=\"https://img.alicdn.com/imgextra/i1/1917047079/O1CN01JZhXa422AEQSb3ocg_!!1917047079.png\" width=\"790\" border=\"0\" class=\"img-ks-lazyload\"></div><div style=\"float: left;margin-top: 6.0px;\">		 <img src=\"https://img.alicdn.com/imgextra/i4/1917047079/O1CN01nMg2h122AEQQPt9Po_!!1917047079.png\" width=\"790\" border=\"0\" class=\"img-ks-lazyload\">	</div>', NULL, NULL, NULL, 0, 0, '苹果', '手机数码');
INSERT INTO `pms_product` VALUES (21, 6, 34, 0, 3, '小米MIX 4CUP全面屏骁龙888+智能电竞游戏小米官方旗舰店5g手机新款小米mix4小米手机小米11红米', 'https://img.alicdn.com/imgextra/O1CN016FuwY324luG6F3Vck_!!6000000007432-0-remus.jpg_430x430q90.jpg', '3543345', 0, 1, 1, 1, 0, 0, 0, 5598.00, NULL, 0, 0, 0, '小米MIX 4CUP全面屏骁龙888+智能电竞游戏小米官方旗舰店5g手机新款小米mix4小米手机小米11红米Xiaomi/小米 11 Ultra 5G手机全网通官方旗舰店正品官网至尊版系列10新款pro红米青春手机', '小米MIX 4CUP全面屏骁龙888+智能电竞游戏小米官方旗舰店5g手机新款小米mix4小米手机小米11红米', 5598.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<div class=\"content ke-post\" style=\"height: auto;\"><p><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN018XqdEH29zFshRnytX_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01EFcvPs29zFsukZ9ar_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p> <p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 6重好礼去往手机端查看</p> <p><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01mXZUjZ29zFsmO1xXH_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1714128138/O1CN01ljotnq29zFsmO3ANm_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01kvjUDh29zFsiSfDdq_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01sxpn4H29zFslMSMPC_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01m1SU9o29zFseNPLCJ_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN010envFK29zFsmO1l4A_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01eGo5YL29zFsYFmtd4_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01zrQj5C29zFsctWz7D_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01GxcCP029zFseNNKRX_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01fgmBqm29zFsfwNQSd_!!1714128138.gif\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01PfQwVX29zFsah2YjC_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01O8jD4Z29zFsn7N97c_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01wAu8G229zFsij6rJF_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1714128138/O1CN011VF6RT29zFskrKF4n_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01LkDyih29zFseNNb4Y_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p> <p><img src=\"https://img.alicdn.com/imgextra/i1/1714128138/O1CN013ceVUf29zFsvTgZdo_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p></div>', NULL, NULL, NULL, 0, 0, '小米', '手机数码');
INSERT INTO `pms_product` VALUES (22, 6, 34, 0, 3, 'Xiaomi/小米 11 Ultra 5G手机全网通官方旗舰店正品官网至尊版系列10新款pro红米青春手机', 'https://img.alicdn.com/imgextra/i1/2279837698/O1CN016r3Dsh26jjcIUgSsU_!!2279837698.jpg_430x430q90.jpg', '2353522', 0, 1, 1, 1, 0, 0, 0, 7599.00, NULL, 0, 0, 0, 'Xiaomi/小米 11 Ultra 5G手机全网通官方旗舰店正品官网至尊版系列10新款pro红米青春手机', 'Xiaomi/小米 11 Ultra 5G手机全网通官方旗舰店正品官网至尊版系列10新款pro红米青春手机', 7599.00, 100, 0, '', 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<div class=\"content ke-post\" style=\"height: auto;\"><p><img src=\"https://img.alicdn.com/imgextra/i2/2279837698/O1CN01yy0HLV26jjcHkFXMG_!!2279837698.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2279837698/O1CN01nExqp626jjcBHgYIb_!!2279837698.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2279837698/O1CN01QQZb3j26jjc8ZUQVp_!!2279837698.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2279837698/O1CN01tcWrPk26jjcCPpzw1_!!2279837698.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2279837698/O1CN01QHADse26jjc824n1l_!!2279837698.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2279837698/O1CN012FZxND26jjc8ZVMjJ_!!2279837698.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2279837698/O1CN01ImBALt26jjcAmY277_!!2279837698.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2279837698/O1CN01Fcu6VP26jjc826w4W_!!2279837698.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i4/2279837698/O1CN01ZQNVVv26jjcCPs4ph_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i3/2279837698/O1CN013ylXZu26jjcDaeFR6_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i1/2279837698/O1CN01pbDG1N26jjcCPssjV_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i2/2279837698/O1CN01Yd92nT26jjcC8Rwlr_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i1/2279837698/O1CN01hDlLP826jjc6XHR5q_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i4/2279837698/O1CN01qg0gDr26jjcC8Qfn3_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i3/2279837698/O1CN0129wtV426jjcG7h5tH_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i2/2279837698/O1CN01mVRrtr26jjcG7dfnw_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i1/2279837698/O1CN01w67M8h26jjcGq81gK_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i1/2279837698/O1CN01w6reEM26jjcF3GbIP_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i2/2279837698/O1CN010iYqtR26jjcDabpn9_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i2/2279837698/O1CN01bagS5U26jjcC8Pjaw_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i3/2279837698/O1CN01c5odgv26jjcIUkpOj_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i3/2279837698/O1CN01vbjWzi26jjcEZIidt_!!2279837698.jpg\" align=\"absmiddle\"> </p></div>', NULL, NULL, NULL, 0, 0, '小米', '手机数码');
INSERT INTO `pms_product` VALUES (23, 13, 21, 0, 5, '新款 周大福珠宝首饰福字足金黄金手链计价F222900精选', 'https://img.alicdn.com/imgextra/i3/407700539/O1CN01hPH4eF1FquAsynxJN_!!0-item_pic.jpg_430x430q90.jpg', '5453434', 0, 1, 1, 1, 0, 0, 0, 728.00, NULL, 0, 0, 0, '新款 周大福珠宝首饰福字足金黄金手链计价F222900精选', '新款 周大福珠宝首饰福字足金黄金手链计价F222900精选', 728.00, 100, 0, '', 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p style=\"text-align: center;\"><img src=\"https://img.alicdn.com/imgextra/i1/407700539/O1CN01fzUMnw1Fqu5WUoAKN_!!407700539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/407700539/O1CN01AWCSRQ1FquAk8CyLk_!!407700539.jpg\" align=\"absmiddle\" style=\"width: 550.0px;\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/407700539/O1CN01UqiaZs1FquAj2KVtI_!!407700539.jpg\" align=\"absmiddle\" style=\"width: 550.0px;\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/407700539/O1CN01Pam5rT1FquAiSDN0a_!!407700539.jpg\" align=\"absmiddle\" style=\"width: 550.0px;\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/407700539/TB263NhaGAoBKNjSZSyXXaHAVXa-407700539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/407700539/TB2RpeQXYZnBKNjSZFKXXcGOVXa-407700539.png\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i1/407700539/TB2KcmHdVXXXXXtXXXXXXXXXXXX_!!407700539.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i3/407700539/O1CN01CTAqWI1Fqu51USdnk_!!407700539.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i1/407700539/O1CN0124HtsB1FquAiwEwbR_!!407700539.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i1/407700539/TB2sQ64b9CWBuNjy0FhXXb6EVXa-407700539.jpg\" align=\"absmiddle\"></p>', NULL, NULL, NULL, 0, 0, '范思哲', '手链');
INSERT INTO `pms_product` VALUES (24, 13, 20, 0, 5, '施华洛世奇 SWAROVSKI INFINITY 女项链礼物', 'https://img.alicdn.com/imgextra/https://img.alicdn.com/imgextra/i2/2576722561/O1CN01iPI1O21UmyzT2KOC9_!!2576722561.jpg_430x430q90.jpg', '5352312', 0, 1, 1, 1, 0, 0, 0, 1290.00, NULL, 0, 0, 0, '施华洛世奇 SWAROVSKI INFINITY 女项链礼物', '施华洛世奇 SWAROVSKI INFINITY 女项链礼物', 1290.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i1/2576722561/O1CN01Wi2Kxb1Umz1FK4HP4_!!2576722561.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2576722561/O1CN01cXYfC91Umz1Ckd8Hg_!!2576722561.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2576722561/O1CN01wCvQAX1Umz1B81fVp_!!2576722561.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2576722561/O1CN01lmWNVr1Umz16zF8fT_!!2576722561.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2576722561/O1CN01fEKi5a1Umz1H4jxbB_!!2576722561.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, '施华洛世奇', NULL);
INSERT INTO `pms_product` VALUES (25, 13, 21, 0, 5, '天王表钢带简约情侣手表男士女士休闲石英表生日礼物3798', 'https://img.alicdn.com/imgextra/i3/1125378539/TB2mCXLX6TpK1RjSZKPXXa3UpXa_!!1125378539.jpg_430x430q90.jpg', '3534534', 0, 1, 1, 1, 0, 0, 0, 1199.00, NULL, 0, 0, 0, '天王表钢带简约情侣手表男士女士休闲石英表生日礼物3798', '天王表钢带简约情侣手表男士女士休闲石英表生日礼物3798', 1199.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i2/1125378539/O1CN01wi3pFK2CwugOYAdVV_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1125378539/O1CN01FtB1302CwugJ0NylQ_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1125378539/O1CN01XZRPBT2CwugHUJ8O9_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1125378539/O1CN01bLoTDu2CwugKwMsbl_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1125378539/O1CN01WmXuYu2CwugJ0Ly2F_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1125378539/O1CN01xHaeQT2Cwug8tnEfo_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1125378539/O1CN012BIR4Y2CwugN7x3aG_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1125378539/O1CN01qbcq8A2CwugHYqHqO_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1125378539/O1CN01Dle9bH2CwugFYQD4y_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1125378539/O1CN01SbkTUV2CwugN7yX2L_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1125378539/O1CN016tksZX2Cwugnb5Lse_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1125378539/O1CN01pk15392CwugOYC6z5_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1125378539/O1CN012sEGp52CwugHYpgRR_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1125378539/O1CN010hMgYU2CwugIjtihq_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1125378539/O1CN01Ha01As2CwugIjtr23_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1125378539/O1CN01xSMC7U2CwugJ0Kxej_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, NULL, '耳机');
INSERT INTO `pms_product` VALUES (26, 13, 35, 0, 5, 'Beats Solo Pro头戴式耳机无线蓝牙b魔音降噪运动耳麦高音质', 'https://img.alicdn.com/imgextra/i4/647482297/O1CN01WcLlx41Sq4SglOLBs_!!647482297.jpg_430x430q90.jpg', '5352342', 0, 1, 1, 1, 0, 0, 0, 1399.00, NULL, 0, 0, 0, 'Beats Solo Pro头戴式耳机无线蓝牙b魔音降噪运动耳麦高音质', 'Beats Solo Pro头戴式耳机无线蓝牙b魔音降噪运动耳麦高音质', 1399.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i2/647482297/O1CN01MnmORS1Sq4SxSmZGI_!!647482297.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/647482297/O1CN01NXdU4o1Sq4T5aQHLf_!!647482297.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/647482297/O1CN017DdaDk1Sq4T9X3A3E_!!647482297.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/647482297/O1CN01Mokk521Sq4T79L0rB_!!647482297.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/647482297/O1CN01TPuzdK1Sq4T1iBHvA_!!647482297.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/647482297/O1CN01HMaNmK1Sq4SxSjgRP_!!647482297.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/647482297/O1CN01uqrlkm1Sq4T4ZVplM_!!647482297.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/647482297/O1CN01HMujdY1Sq4T63tY2E_!!647482297.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, NULL, '次时代主机');
INSERT INTO `pms_product` VALUES (27, 13, 36, 0, 5, '索尼PS5主机 电视游戏机 无光驱版 超 蓝光8K 日版家用单机怪物', 'https://img.alicdn.com/imgextra/i1/2200877014436/O1CN016ekYBX1idjahukrhA_!!2200877014436.jpg_430x430q90.jpg', '3532343', 0, 1, 1, 1, 0, 0, 0, 5978.00, NULL, 0, 0, 0, '索尼PS5主机 电视游戏机 无光驱版 超 蓝光8K 日版家用单机怪物', '索尼PS5主机 电视游戏机 无光驱版 超 蓝光8K 日版家用单机怪物', 5978.00, 199, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i4/3596652968/O1CN01Oosbmu1XnOAEfSgVb_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/3596652968/O1CN01NR0qUm1XnOANtcaLI_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/3596652968/O1CN01K8q3ln1XnOASj7VcP_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/3596652968/O1CN01sFmGLE1XnOAQFd8Ie_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/3596652968/O1CN01COdpEW1XnOANGRrFD_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/3596652968/O1CN01IFWogx1XnOAT7JMeP_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/3596652968/O1CN01G6OC4e1XnOAN48nk7_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/3596652968/O1CN01rQkysO1XnOARqP8ai_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/3596652968/O1CN01KBZSSY1XnOAEfZCEF_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/3596652968/O1CN01TSgSAC1XnOAKZGQgB_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> </p>', NULL, NULL, NULL, 0, 0, NULL, '次时代主机');
INSERT INTO `pms_product` VALUES (28, 13, 37, 0, 5, '日本直邮Nintendo/任天堂Switch掌上游戏机NS红蓝手柄续航增强版', 'https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01BqPY9s1vlbMPxJiEh_!!2201168176213.jpg_430x430q90.jpg', '5435432', 0, 1, 1, 1, 0, 0, 0, 2599.00, NULL, 0, 0, 0, '日本直邮Nintendo/任天堂Switch掌上游戏机NS红蓝手柄续航增强版', '日本直邮Nintendo/任天堂Switch掌上游戏机NS红蓝手柄续航增强版', 2599.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<div class=\"content ke-post\" style=\"height: auto;\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i2/2201168176213/O1CN012CRXXX1vlbPphjezH_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01MdAfgE1vlbHcbnRPn_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i4/2201168176213/O1CN013AiaqL1vlbS92pX7W_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i3/2201168176213/O1CN01B5fQQy1vlbSDIWeqS_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN019QyH8Z1vlbSCnjHrB_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01CK5URe1vlbS6LK6Yc_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01Buy4Rj1vlbSGfdrkw_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01SmMssQ1vlbSGfe4D8_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i4/2201168176213/O1CN01CgQBZO1vlbS9YIC84_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i4/2201168176213/O1CN01RMmGJ11vlbSF4By1t_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i4/2201168176213/O1CN01CePTYx1vlbMOXCe89_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i4/2201168176213/O1CN01UwIinW1vlbQWTHXYE_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01XwKIbd1vlbQaVApZy_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01flPWJB1vlbHcwtUIF_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01eftHq81vlbQTrrQNK_!!2201168176213.jpg\" class=\"img-ks-lazyload\"></div>', NULL, NULL, NULL, 0, 0, NULL, '手办玩具');
INSERT INTO `pms_product` VALUES (29, 13, 60, 0, 5, '日本直邮海贼王超级DX波特卡斯?D?艾斯 26mm 人偶', 'https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01X5D1o01vlbRMW5gCH_!!2201168176213.jpg_430x430q90.jpg', '5432311', 0, 1, 1, 1, 0, 0, 0, 479.00, NULL, 0, 0, 0, '日本直邮海贼王超级DX波特卡斯?D?艾斯 26mm 人偶', '日本直邮海贼王超级DX波特卡斯?D?艾斯 26mm 人偶', 479.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<div class=\"content ke-post\" style=\"height: auto;\"><img src=\"https://img.alicdn.com/imgextra/i2/2201168176213/O1CN012CRXXX1vlbPphjezH_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01MdAfgE1vlbHcbnRPn_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01zGwXI11vlbRUC3Esj_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01zGwXI11vlbRUC3Esj_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2201168176213/O1CN01F4HdWS1vlbRWOIljo_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01R01VvS1vlbRWOIyDd_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01BPAHxo1vlbRP4xiGo_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01MDrL1l1vlbRL4cUqc_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2201168176213/O1CN01UwIinW1vlbQWTHXYE_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01XwKIbd1vlbQaVApZy_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01flPWJB1vlbHcwtUIF_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01eftHq81vlbQTrrQNK_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"></div>', NULL, NULL, NULL, 0, 0, NULL, '手办玩具');
INSERT INTO `pms_product` VALUES (30, 13, 61, 0, 5, '新品 眼镜厂 鬼灭之刃景品手办 绊之装玖之型蝴蝶忍', 'https://img.alicdn.com/imgextra/i3/833261111/O1CN014MMkx01K4sfv0hKnn_!!833261111.png_430x430q90.jpg', '6343122', 0, 1, 1, 1, 0, 0, 0, 139.00, NULL, 0, 0, 0, '新品 眼镜厂 鬼灭之刃景品手办 绊之装玖之型蝴蝶忍', '新品 眼镜厂 鬼灭之刃景品手办 绊之装玖之型蝴蝶忍', 139.00, 199, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i3/833261111/O1CN01GVhTK31K4sfEG9nHh_!!833261111.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, NULL, '手办玩具');
INSERT INTO `pms_product` VALUES (31, 13, 61, 0, 5, '新品 眼镜厂  鬼灭之刃 绊之装陆之型 炭治郎', 'https://img.alicdn.com/imgextra/i1/833261111/O1CN01yB5M6b1K4saHiFU5A_!!833261111.jpg_430x430q90.jpg', '4363781', 0, 1, 1, 1, 0, 0, 0, 179.00, NULL, 0, 0, 0, '新品 眼镜厂  鬼灭之刃 绊之装陆之型 炭治郎', '新品 眼镜厂  鬼灭之刃 绊之装陆之型 炭治郎', 179.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i3/833261111/O1CN01LJ9xCC1K4sgH5A1Kz_!!833261111.jpg\" alt=\"万代商品详情页修DEMO-0927_02_01.jpg\" class=\"img-ks-lazyload\"> <a href=\"https://bandai.tmall.com/p/rd655524.htm\" target=\"_blank\"><img src=\"https://img.alicdn.com/imgextra/i1/833261111/O1CN01VHLOGn1K4seJr5x3z_!!833261111.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></a> <img src=\"https://img.alicdn.com/imgextra/i1/833261111/O1CN010wkTVa1K4seGEap1z_!!833261111.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> <img src=\"https://img.alicdn.com/imgextra/i3/833261111/O1CN01sdJhKw1K4sj7JQuQz_!!833261111.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/833261111/O1CN014oouZr1K4saJc64Hz_!!833261111.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, NULL, '手办玩具');
INSERT INTO `pms_product` VALUES (32, 13, 64, 0, 5, '现货 眼镜厂 海外限定 SMSP 孙悟空 漫画色 龙珠 赛亚人手办 景品', 'https://gd1.alicdn.com/imgextra/i1/612966252/O1CN01airkQ51w3Stv4zncN_!!612966252.jpg', '5432232', 0, 1, 1, 1, 0, 0, 0, 285.00, NULL, 0, 0, 0, '现货 眼镜厂 海外限定 SMSP 孙悟空 漫画色 龙珠 赛亚人手办 景品', '现货 眼镜厂 海外限定 SMSP 孙悟空 漫画色 龙珠 赛亚人手办 景品', 285.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/612966252/O1CN01Zfd3qs1w3St4dFo46_!!612966252.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/612966252/O1CN01dGpyDQ1w3St3rpzOn_!!612966252.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/612966252/O1CN01bfrrgb1w3SsuzsrOT_!!612966252.jpg\" style=\"max-width: 750.0px;\"></p>', NULL, NULL, NULL, 0, 0, NULL, '手办玩具');
INSERT INTO `pms_product` VALUES (33, 13, 66, 0, 5, '海洋堂新世纪福音战士EVA成品初号机', 'https://gd3.alicdn.com/imgextra/i3/3381629725/O1CN01QaB5cG2Li6E4KJn0M_!!3381629725.jpg_400x400.jpg', '5435341', 0, 1, 1, 1, 0, 0, 0, 228.00, NULL, 0, 0, 0, '海洋堂新世纪福音战士EVA成品初号机', '海洋堂新世纪福音战士EVA成品初号机', 228.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3381629725/O1CN01DZM08k2Li6IfoLMoZ_!!3381629725.png\" style=\"max-width: 750.0px;\"></p>', NULL, NULL, NULL, 0, 0, NULL, '手办玩具');
INSERT INTO `pms_product` VALUES (34, 13, 66, 0, 5, '[全款预售]SEGA EVA新世纪福音战士剧场版终 明日香 景品手办', 'https://img.alicdn.com/imgextra/i1/1916629511/O1CN01mmZBhe2K85g7wOxfd_!!1916629511.jpg_430x430q90.jpg', '5464542', 0, 1, 1, 1, 0, 0, 0, 999.00, NULL, 0, 0, 0, '[全款预售]SEGA EVA新世纪福音战士剧场版终 明日香 景品手办', '[全款预售]SEGA EVA新世纪福音战士剧场版终 明日香 景品手办', 999.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<div> <img src=\"https://img.alicdn.com/imgextra/i1/1916629511/O1CN01ByUd5t2K85gF4RjPp_!!1916629511.jpg\" alt=\"详情1.jpg\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1916629511/O1CN01SoqQDn2K85g7R2Csk_!!1916629511.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1916629511/O1CN01zD9Y0L2K85g950GLC_!!1916629511.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1916629511/O1CN01Dk3kJt2K85gAERFul_!!1916629511.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1916629511/O1CN01b1GIIn2K85gAERahr_!!1916629511.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> </div>', NULL, NULL, NULL, 0, 0, NULL, '手办玩具');
INSERT INTO `pms_product` VALUES (35, 13, 66, 0, 5, '日本寿屋 新世纪福音战士 EVA 绫波零手办摆件青少年成人玩具收藏', 'https://img.alicdn.com/imgextra/i1/2200877014436/O1CN01C00EWE1idjdHq0XHC_!!2200877014436.jpg_430x430q90.jpg', '6433215', 0, 1, 1, 1, 0, 0, 0, 685.00, NULL, 0, 0, 0, '日本寿屋 新世纪福音战士 EVA 绫波零手办摆件青少年成人玩具收藏', '日本寿屋 新世纪福音战士 EVA 绫波零手办摆件青少年成人玩具收藏', 685.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i2/2207611753309/O1CN01E028HG1aJZGOC5wWs_!!2207611753309-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> </p>', NULL, NULL, NULL, 0, 0, NULL, '手办玩具');
INSERT INTO `pms_product` VALUES (36, 13, 66, 0, 5, '【直营】BANDAI万代Figure-rise Standard86不存在的战区蕾娜手办', 'https://img.alicdn.com/imgextra/i4/2200877014436/O1CN01JSPiOI1idjdZCtMHb_!!2200877014436.jpg_430x430q90.jpg', '4645657', 0, 1, 1, 1, 0, 0, 0, 169.00, NULL, 0, 0, 0, '【直营】BANDAI万代Figure-rise Standard86不存在的战区蕾娜手办', '【直营】BANDAI万代Figure-rise Standard86不存在的战区蕾娜手办', 169.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i4/2207611753309/O1CN01xC1nWy1aJZGpaTdnp_!!2207611753309-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, NULL, '手办玩具');
INSERT INTO `pms_product` VALUES (37, 13, 65, 0, 5, '乐高机械组成人乐高布加迪威龙 Bugatti Chiron拼插积木玩具42083', 'https://img.alicdn.com/imgextra/i2/594767740/O1CN01KBVDeF272yAoep8KZ_!!594767740.jpg_430x430q90.jpg', '5847988', 0, 1, 1, 1, 0, 0, 0, 2249.00, NULL, 0, 0, 0, '乐高机械组成人乐高布加迪威龙 Bugatti Chiron拼插积木玩具42083', '乐高机械组成人乐高布加迪威龙 Bugatti Chiron拼插积木玩具42083', 2249.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i3/594767740/O1CN01vP0Mjs272yAv2Opxz_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/594767740/O1CN01MwchnI272yAxMkXAf_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/594767740/O1CN01HnN5zQ272yAwXNLFX_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/594767740/O1CN01oNcrcx272yAuitLA5_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/594767740/O1CN01Na2Fz3272yAuiu0lJ_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/594767740/O1CN01uJEmex272yAwXPp79_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/594767740/O1CN013bN2db272yAwXOHSZ_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/594767740/O1CN01w27Li7272yAqBTQMD_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/594767740/O1CN01Y0L5NS272yAvtZPR1_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/594767740/O1CN01CeEChk272yAsCPrXv_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/594767740/O1CN01hEDzlR272yAsz14Tc_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/594767740/O1CN01s28xtV272yAsoJZoJ_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/594767740/O1CN01TflNdB272yAjzrJkR_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/594767740/O1CN011ErMej272yAuiuTtB_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> </p>', NULL, NULL, NULL, 0, 0, NULL, '手办玩具');
INSERT INTO `pms_product` VALUES (38, 13, 62, 0, 5, '火影忍者手办 羁绊火焰宇智波鼬 佐助动漫手办模型摆件盒装礼品', 'https://img.alicdn.com/imgextra/i2/2865745622/O1CN01HfoCnq1rOvJbQlMA8_!!0-item_pic.jpg_430x430q90.jpg', '6938233', 0, 1, 1, 1, 0, 0, 0, 599.00, NULL, 0, 0, 0, '火影忍者手办 羁绊火焰宇智波鼬 佐助动漫手办模型摆件盒装礼品', '火影忍者手办 羁绊火焰宇智波鼬 佐助动漫手办模型摆件盒装礼品', 599.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i4/2865745622/O1CN01Vgh0gE1rOvJgt7TVh_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2865745622/O1CN01sgtpVw1rOvJhm8qcA_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2865745622/O1CN01BrJAVB1rOvJdc7EXc_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2865745622/O1CN01BMWuO21rOvJfqzVGm_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2865745622/O1CN01CMKpxe1rOvJbreiAY_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2865745622/O1CN01cMmCXM1rOvJbrfzAJ_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2865745622/O1CN01MXGMa71rOvJekm6IV_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2865745622/O1CN01uxavGt1rOvJgt7XgF_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2865745622/O1CN01uFTkvo1rOvJdc8NFB_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2865745622/O1CN01kz1ETJ1rOvJeZLh9R_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2865745622/O1CN01flJMDi1rOvJiPtDcb_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2865745622/O1CN01TmWpdF1rOvJjIQBB8_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> </p>', NULL, NULL, NULL, 0, 0, NULL, '手办玩具');

-- ----------------------------
-- Table structure for pms_product_attribute
-- ----------------------------
DROP TABLE IF EXISTS `pms_product_attribute`;
CREATE TABLE `pms_product_attribute`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_attribute_category_id` bigint(20) NULL DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `select_type` int(1) NULL DEFAULT NULL COMMENT '属性选择类型：0->唯一；1->单选；2->多选',
  `input_type` int(1) NULL DEFAULT NULL COMMENT '属性录入方式：0->手工录入；1->从列表中选取',
  `input_list` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '可选值列表，以逗号隔开',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序字段：最高的可以单独上传图片',
  `filter_type` int(1) NULL DEFAULT NULL COMMENT '分类筛选样式：1->普通；1->颜色',
  `search_type` int(1) NULL DEFAULT NULL COMMENT '检索类型；0->不需要进行检索；1->关键字检索；2->范围检索',
  `related_status` int(1) NULL DEFAULT NULL COMMENT '相同属性产品是否关联；0->不关联；1->关联',
  `hand_add_status` int(1) NULL DEFAULT NULL COMMENT '是否支持手动新增；0->不支持；1->支持',
  `type` int(1) NULL DEFAULT NULL COMMENT '属性的类型；0->规格；1->参数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品属性参数表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_product_attribute
-- ----------------------------
INSERT INTO `pms_product_attribute` VALUES (1, 1, '尺寸', 2, 1, 'M,X,XL,2XL,3XL,4XL', 0, 0, 0, 0, 0, 0);
INSERT INTO `pms_product_attribute` VALUES (7, 1, '颜色', 2, 1, '黑色,红色,白色,粉色', 100, 0, 0, 0, 1, 0);
INSERT INTO `pms_product_attribute` VALUES (13, 0, '上市年份', 1, 1, '2013年,2014年,2015年,2016年,2017年', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (14, 0, '上市年份1', 1, 1, '2013年,2014年,2015年,2016年,2017年', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (15, 0, '上市年份2', 1, 1, '2013年,2014年,2015年,2016年,2017年', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (16, 0, '上市年份3', 1, 1, '2013年,2014年,2015年,2016年,2017年', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (17, 0, '上市年份4', 1, 1, '2013年,2014年,2015年,2016年,2017年', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (18, 0, '上市年份5', 1, 1, '2013年,2014年,2015年,2016年,2017年', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (19, 0, '适用对象', 1, 1, '青年女性,中年女性', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (20, 0, '适用对象1', 2, 1, '青年女性,中年女性', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (21, 0, '适用对象3', 2, 1, '青年女性,中年女性', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (24, 1, '商品编号', 1, 0, '', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (25, 1, '适用季节', 1, 1, '春季,夏季,秋季,冬季', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (32, 2, '适用人群', 0, 1, '老年,青年,中年', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (33, 2, '风格', 0, 1, '嘻哈风格,基础大众,商务正装', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (35, 2, '颜色', 0, 0, '', 100, 0, 0, 0, 1, 0);
INSERT INTO `pms_product_attribute` VALUES (37, 1, '适用人群', 1, 1, '儿童,青年,中年,老年', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (38, 1, '上市时间', 1, 1, '2017年秋,2017年冬,2018年春,2018年夏', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (39, 1, '袖长', 1, 1, '短袖,长袖,中袖', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (40, 2, '尺码', 0, 1, '29,30,31,32,33,34', 0, 0, 0, 0, 0, 0);
INSERT INTO `pms_product_attribute` VALUES (41, 2, '适用场景', 0, 1, '居家,运动,正装', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (42, 2, '上市时间', 0, 1, '2018年春,2018年夏', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (43, 3, '颜色', 0, 0, '', 100, 0, 0, 0, 1, 0);
INSERT INTO `pms_product_attribute` VALUES (44, 3, '容量', 0, 1, '16G,32G,64G,128G', 0, 0, 0, 0, 0, 0);
INSERT INTO `pms_product_attribute` VALUES (45, 3, '屏幕尺寸', 0, 0, '', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (46, 3, '网络', 0, 1, '3G,4G', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (47, 3, '系统', 0, 1, 'Android,IOS', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (48, 3, '电池容量', 0, 0, '', 0, 0, 0, 0, 0, 1);
INSERT INTO `pms_product_attribute` VALUES (49, 11, '颜色', 0, 1, '红色,蓝色,绿色', 0, 1, 0, 0, 0, 0);
INSERT INTO `pms_product_attribute` VALUES (50, 11, '尺寸', 0, 1, '38,39,40', 0, 0, 0, 0, 0, 0);
INSERT INTO `pms_product_attribute` VALUES (51, 11, '风格', 0, 1, '夏季,秋季', 0, 0, 0, 0, 0, 0);

-- ----------------------------
-- Table structure for pms_product_attribute_category
-- ----------------------------
DROP TABLE IF EXISTS `pms_product_attribute_category`;
CREATE TABLE `pms_product_attribute_category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `attribute_count` int(11) NULL DEFAULT 0 COMMENT '属性数量',
  `param_count` int(11) NULL DEFAULT 0 COMMENT '参数数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品属性分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_product_attribute_category
-- ----------------------------
INSERT INTO `pms_product_attribute_category` VALUES (1, '服装-T恤', 7, 5);
INSERT INTO `pms_product_attribute_category` VALUES (2, '服装-裤装', 2, 4);
INSERT INTO `pms_product_attribute_category` VALUES (3, '手机数码-手机通讯', 2, 4);
INSERT INTO `pms_product_attribute_category` VALUES (4, '配件', 0, 0);
INSERT INTO `pms_product_attribute_category` VALUES (5, '居家', 0, 0);
INSERT INTO `pms_product_attribute_category` VALUES (6, '洗护', 0, 0);
INSERT INTO `pms_product_attribute_category` VALUES (10, '测试分类', 0, 0);
INSERT INTO `pms_product_attribute_category` VALUES (11, '服装-鞋帽', 3, 0);

-- ----------------------------
-- Table structure for pms_product_attribute_value
-- ----------------------------
DROP TABLE IF EXISTS `pms_product_attribute_value`;
CREATE TABLE `pms_product_attribute_value`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NULL DEFAULT NULL,
  `product_attribute_id` bigint(20) NULL DEFAULT NULL,
  `value` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手动添加规格或参数的值，参数单值，规格有多个时以逗号隔开',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 233 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '存储产品参数信息的表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_product_attribute_value
-- ----------------------------
INSERT INTO `pms_product_attribute_value` VALUES (1, 9, 1, 'X');
INSERT INTO `pms_product_attribute_value` VALUES (2, 10, 1, 'X');
INSERT INTO `pms_product_attribute_value` VALUES (3, 11, 1, 'X');
INSERT INTO `pms_product_attribute_value` VALUES (4, 12, 1, 'X');
INSERT INTO `pms_product_attribute_value` VALUES (5, 13, 1, 'X');
INSERT INTO `pms_product_attribute_value` VALUES (6, 14, 1, 'X');
INSERT INTO `pms_product_attribute_value` VALUES (7, 18, 1, 'X');
INSERT INTO `pms_product_attribute_value` VALUES (8, 7, 1, 'X');
INSERT INTO `pms_product_attribute_value` VALUES (9, 7, 1, 'XL');
INSERT INTO `pms_product_attribute_value` VALUES (10, 7, 1, 'XXL');
INSERT INTO `pms_product_attribute_value` VALUES (11, 22, 7, 'x,xx');
INSERT INTO `pms_product_attribute_value` VALUES (12, 22, 24, 'no110');
INSERT INTO `pms_product_attribute_value` VALUES (13, 22, 25, '春季');
INSERT INTO `pms_product_attribute_value` VALUES (14, 22, 37, '青年');
INSERT INTO `pms_product_attribute_value` VALUES (15, 22, 38, '2018年春');
INSERT INTO `pms_product_attribute_value` VALUES (16, 22, 39, '长袖');
INSERT INTO `pms_product_attribute_value` VALUES (124, 23, 7, '米白色,浅黄色');
INSERT INTO `pms_product_attribute_value` VALUES (125, 23, 24, 'no1098');
INSERT INTO `pms_product_attribute_value` VALUES (126, 23, 25, '春季');
INSERT INTO `pms_product_attribute_value` VALUES (127, 23, 37, '青年');
INSERT INTO `pms_product_attribute_value` VALUES (128, 23, 38, '2018年春');
INSERT INTO `pms_product_attribute_value` VALUES (129, 23, 39, '长袖');
INSERT INTO `pms_product_attribute_value` VALUES (130, 1, 13, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (131, 1, 14, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (132, 1, 15, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (133, 1, 16, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (134, 1, 17, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (135, 1, 18, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (136, 1, 19, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (137, 1, 20, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (138, 1, 21, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (139, 2, 13, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (140, 2, 14, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (141, 2, 15, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (142, 2, 16, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (143, 2, 17, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (144, 2, 18, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (145, 2, 19, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (146, 2, 20, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (147, 2, 21, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (183, 31, 24, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (184, 31, 25, '夏季');
INSERT INTO `pms_product_attribute_value` VALUES (185, 31, 37, '青年');
INSERT INTO `pms_product_attribute_value` VALUES (186, 31, 38, '2018年夏');
INSERT INTO `pms_product_attribute_value` VALUES (187, 31, 39, '短袖');
INSERT INTO `pms_product_attribute_value` VALUES (198, 30, 24, NULL);
INSERT INTO `pms_product_attribute_value` VALUES (199, 30, 25, '夏季');
INSERT INTO `pms_product_attribute_value` VALUES (200, 30, 37, '青年');
INSERT INTO `pms_product_attribute_value` VALUES (201, 30, 38, '2018年夏');
INSERT INTO `pms_product_attribute_value` VALUES (202, 30, 39, '短袖');
INSERT INTO `pms_product_attribute_value` VALUES (213, 27, 43, '黑色,蓝色');
INSERT INTO `pms_product_attribute_value` VALUES (214, 27, 45, '5.8');
INSERT INTO `pms_product_attribute_value` VALUES (215, 27, 46, '4G');
INSERT INTO `pms_product_attribute_value` VALUES (216, 27, 47, 'Android');
INSERT INTO `pms_product_attribute_value` VALUES (217, 27, 48, '3000ml');
INSERT INTO `pms_product_attribute_value` VALUES (218, 28, 43, '金色,银色');
INSERT INTO `pms_product_attribute_value` VALUES (219, 28, 45, '5.0');
INSERT INTO `pms_product_attribute_value` VALUES (220, 28, 46, '4G');
INSERT INTO `pms_product_attribute_value` VALUES (221, 28, 47, 'Android');
INSERT INTO `pms_product_attribute_value` VALUES (222, 28, 48, '2800ml');
INSERT INTO `pms_product_attribute_value` VALUES (223, 29, 43, '金色,银色');
INSERT INTO `pms_product_attribute_value` VALUES (224, 29, 45, '4.7');
INSERT INTO `pms_product_attribute_value` VALUES (225, 29, 46, '4G');
INSERT INTO `pms_product_attribute_value` VALUES (226, 29, 47, 'IOS');
INSERT INTO `pms_product_attribute_value` VALUES (227, 29, 48, '1960ml');
INSERT INTO `pms_product_attribute_value` VALUES (228, 26, 43, '金色,银色');
INSERT INTO `pms_product_attribute_value` VALUES (229, 26, 45, '5.0');
INSERT INTO `pms_product_attribute_value` VALUES (230, 26, 46, '4G');
INSERT INTO `pms_product_attribute_value` VALUES (231, 26, 47, 'Android');
INSERT INTO `pms_product_attribute_value` VALUES (232, 26, 48, '3000');

-- ----------------------------
-- Table structure for pms_product_category
-- ----------------------------
DROP TABLE IF EXISTS `pms_product_category`;
CREATE TABLE `pms_product_category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '上机分类的编号：0表示一级分类',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `level` int(1) NULL DEFAULT NULL COMMENT '分类级别：0->1级；1->2级',
  `product_count` int(11) NULL DEFAULT NULL,
  `product_unit` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nav_status` int(1) NULL DEFAULT NULL COMMENT '是否显示在导航栏：0->不显示；1->显示',
  `show_status` int(1) NULL DEFAULT NULL COMMENT '显示状态：0->不显示；1->显示',
  `sort` int(11) NULL DEFAULT NULL,
  `icon` varchar(350) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 74 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pms_product_category
-- ----------------------------
INSERT INTO `pms_product_category` VALUES (1, 0, '服装', 0, 100, '件', 1, 1, 1, NULL, '服装', '服装分类');
INSERT INTO `pms_product_category` VALUES (2, 0, '潮流配饰', 0, 100, '', 1, 1, 1, NULL, '潮流配饰', '潮流配饰');
INSERT INTO `pms_product_category` VALUES (3, 0, '手机数码', 0, 100, '件', 1, 1, 1, NULL, '手机数码', '手机数码');
INSERT INTO `pms_product_category` VALUES (4, 0, '家具家装', 0, 100, '件', 1, 1, 1, NULL, '家具家装', '家具家装');
INSERT INTO `pms_product_category` VALUES (5, 0, '家用电器', 0, 100, '件', 1, 1, 1, NULL, '家用电器', '家用电器');
INSERT INTO `pms_product_category` VALUES (6, 0, '模玩盲盒', 0, 100, NULL, 1, 1, 1, NULL, '模玩盲盒', '模玩盲盒');
INSERT INTO `pms_product_category` VALUES (7, 0, '休闲食品', 0, 100, '件', 1, 1, 1, NULL, '休闲零食', '零食分类');
INSERT INTO `pms_product_category` VALUES (10, 1, '外套', 1, 100, '件', 1, 1, 0, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i1/2146928739/O1CN01NXcLin2EQVuctfvKH_!!0-item_pic.jpg_460x460Q90.jpg_.webp', '外套', '外套');
INSERT INTO `pms_product_category` VALUES (11, 1, 'T恤', 1, 100, '件', 1, 1, 0, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i1/2981481474/O1CN01u6WE181Ml8PkYzeFL_!!2981481474-0-lubanu-s.jpg_460x460Q90.jpg_.webp', 'T恤', 'T恤');
INSERT INTO `pms_product_category` VALUES (12, 1, '休闲裤', 1, 100, '件', 1, 1, 0, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i1/3081350486/O1CN01xl6r9O1FSdBh4awp8_!!0-item_pic.jpg_460x460Q90.jpg_.webp', '休闲裤', '休闲裤');
INSERT INTO `pms_product_category` VALUES (13, 1, '牛仔裤', 1, 100, '件', 1, 1, 0, 'https://g-search3.alicdn.com/img/bao/uploaded/i4/i2/178076662/O1CN01W04l321z5F914cWrj_!!178076662.jpg_460x460Q90.jpg_.webp', '牛仔裤', '牛仔裤');
INSERT INTO `pms_product_category` VALUES (14, 1, '衬衫', 1, 100, '件', 1, 1, 0, 'https://g-search2.alicdn.com/img/bao/uploaded/i4/i2/178076662/O1CN01dHGt3j1z5FHlCyOfg_!!0-item_pic.jpg_460x460Q90.jpg_.webp', '衬衫', '衬衫分类');
INSERT INTO `pms_product_category` VALUES (15, 1, '男鞋', 1, 0, '', 0, 0, 0, 'https://g-search1.alicdn.com/img/bao/uploaded/i4/i4/325718097/O1CN01sAa4VS29gTdIlAfsw_!!0-item_pic.jpg_460x460Q90.jpg_.webp', '', '');
INSERT INTO `pms_product_category` VALUES (16, 1, '女鞋', 1, 0, NULL, 0, 0, 0, 'https://img.alicdn.com/imgextra/i1/520557274/O1CN01VX891323bXg5TWPbF-520557274.jpg_430x430q90.jpg', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (20, 2, '项链', 1, 0, NULL, 0, 0, 0, 'https://img.alicdn.com/imgextra/https://img.alicdn.com/imgextra/i2/2576722561/O1CN010bHcdW1UmyznjQBTj_!!2576722561.jpg_430x430q90.jpg', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (21, 2, '手饰', 1, 0, NULL, 0, 0, 0, 'https://img.alicdn.com/imgextra/i2/2210376801617/O1CN01VELGyu1Nod8XvLMSt_!!2-item_pic.png_430x430q90.jpg', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (22, 2, '戒指', 1, 0, NULL, 0, 0, 0, 'https://img.alicdn.com/imgextra/i2/2206840659250/O1CN01v2BO8d2ICYJOHrXFD_!!0-item_pic.jpg_430x430q90.jpg', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (23, 2, '耳饰', 1, 0, NULL, 0, 0, 0, 'https://img.alicdn.com/imgextra/i3/2207647442508/O1CN01oKCySW1UOi1IVNAmC_!!2207647442508.png_430x430q90.jpg', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (24, 2, '太阳镜', 1, 0, NULL, 0, 0, 0, 'https://img.alicdn.com/imgextra/i1/2200635948283/O1CN01gbyimZ2B3fFLwYg5Q_!!0-item_pic.jpg_60x60q90.jpg', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (25, 2, '鸭舌帽', 1, 0, NULL, 0, 0, 0, 'https://gd1.alicdn.com/imgextra/i1/2039170120/O1CN0128sr1s1Cl0CYQOfUW_!!2039170120.jpg_400x400.jpg', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (26, 2, '袜子', 1, 0, NULL, 0, 0, 0, 'https://img.alicdn.com/imgextra/i3/2201196294013/O1CN015x0izs1fW077FzlsW_!!2201196294013.jpg_60x60q90.jpg', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (30, 3, '华为', 1, 0, '件', 0, 0, 0, 'https://img.sj33.cn/uploads/allimg/201401/7-140131201634S2.png', '', '');
INSERT INTO `pms_product_category` VALUES (31, 3, '苹果', 1, 0, '', 0, 0, 0, 'https://img.zcool.cn/community/019eb159c27142a801218e18a868e3.jpg@1280w_1l_2o_100sh.jpg', '', '');
INSERT INTO `pms_product_category` VALUES (32, 3, 'OPPO', 1, 0, '', 0, 0, 0, 'https://tse2-mm.cn.bing.net/th/id/OIP-C.cx5Eb4MbS4w9TfRq0rsTVQHaBO?pid=ImgDet&rs=1', '', '');
INSERT INTO `pms_product_category` VALUES (33, 3, 'VIVO', 1, 0, '', 0, 0, 0, 'http://bpic.588ku.com/element_origin_min_pic/17/03/06/8b73209e86c33cffed6bead67093aadc.jpg', '', '');
INSERT INTO `pms_product_category` VALUES (34, 3, '小米', 1, 0, '', 0, 0, 0, 'https://tse4-mm.cn.bing.net/th/id/OIP-C.BJH0YlpZYkHyla5jgYN1qwHaHa?w=210&h=210&c=7&r=0&o=5&dpr=1.5&pid=1.7', '', '');
INSERT INTO `pms_product_category` VALUES (35, 3, 'Beats', 1, 0, '', 0, 0, 0, 'https://tse4-mm.cn.bing.net/th/id/OIP-C.O0o5J0QYinnU9De0M-S_WAHaFo?w=211&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7', '', '');
INSERT INTO `pms_product_category` VALUES (36, 3, '索尼', 1, 0, NULL, 0, 0, 0, 'https://tse3-mm.cn.bing.net/th/id/OIP-C.RC_TTDTmYFhlMojZC9i6dgHaBo?w=333&h=77&c=7&r=0&o=5&dpr=1.5&pid=1.7', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (37, 3, '任天堂', 1, 0, NULL, 0, 0, 0, 'https://tse1-mm.cn.bing.net/th/id/R-C.a3f0e2baf18a29e523f06a7217e883b5?rik=63oWxgyG%2fnakvQ&riu=http%3a%2f%2fpic128.nipic.com%2ffile%2f20170429%2f22861242_112549847616_2.jpg&ehk=5tMs0YkGaQhtdHAwzP1njaKV%2bV9jwNF39DpbzT6j2lA%3d&risl=&pid=ImgRaw&r=0', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (40, 4, '电视', 1, 0, '', 0, 0, 0, 'https://tse2-mm.cn.bing.net/th/id/OIP-C.YlcBO4mf5xEqpScJen_AgwHaHa?pid=ImgDet&rs=1', '', '');
INSERT INTO `pms_product_category` VALUES (41, 4, '空调', 1, 0, '', 0, 0, 0, 'https://tse1-mm.cn.bing.net/th/id/R-C.87d31ceeeb02d1fc55e239d4c3e3f50b?rik=284u5qLnyvoaeA&riu=http%3a%2f%2fwww.gzjinsong.com%2fmedia%2f2181%2f2.png&ehk=da6ayftxnzfZBBN7MZRqAikOj9qjHYWkOZk5S6mSnKE%3d&risl=&pid=ImgRaw&r=0', '', '');
INSERT INTO `pms_product_category` VALUES (42, 4, '洗衣机', 1, 0, '', 0, 0, 0, 'https://tse1-mm.cn.bing.net/th/id/OIP-C.KVv5Qvk1vyfIC6zFCxBhIwHaHa?pid=ImgDet&rs=1', '', '');
INSERT INTO `pms_product_category` VALUES (43, 4, '冰箱', 1, 0, '', 0, 0, 0, 'https://tse4-mm.cn.bing.net/th/id/OIP-C.88vNLqpYBbvBNvtDQEsMkwHaLH?pid=ImgDet&rs=1', '', '');
INSERT INTO `pms_product_category` VALUES (44, 4, '厨卫大电', 1, 0, '', 0, 0, 0, 'https://tse1-mm.cn.bing.net/th/id/R-C.5db76a50721944250a913badcebf2b54?rik=D1mQmDob9oMDKQ&riu=http%3a%2f%2fwww.oppein.com%2fupfile%2f2016%2f08%2f20160806144135_867.jpg&ehk=UFv3dz3zjxk7RuRFO5S5vziBVhNGv2lcbzwY5%2bfACt4%3d&risl=&pid=ImgRaw&r=0', '', '');
INSERT INTO `pms_product_category` VALUES (45, 4, '厨房小电', 1, 0, '', 0, 0, 0, 'https://tse1-mm.cn.bing.net/th/id/OIP-C.F4nTqAUoa79jATmDzxk2cAHaGf?pid=ImgDet&rs=1', '', '');
INSERT INTO `pms_product_category` VALUES (46, 4, '生活电器', 1, 0, '', 0, 0, 0, 'https://tse2-mm.cn.bing.net/th/id/OIP-C.HlFkMincGcdVvm3Nd8_9AQHaHa?pid=ImgDet&rs=1', '', '');
INSERT INTO `pms_product_category` VALUES (50, 5, '厨房卫浴', 1, 0, '', 0, 0, 0, 'https://tse3-mm.cn.bing.net/th/id/OIP-C.nWo-z90q-y2wLY6MJ5NYfQHaHa?pid=ImgDet&rs=1', '', '');
INSERT INTO `pms_product_category` VALUES (51, 5, '灯饰照明', 1, 0, '', 0, 0, 0, 'https://tse4-mm.cn.bing.net/th/id/OIP-C.VNuxGku8bO2MC8OTFv3JLAHaGL?pid=ImgDet&rs=1', '', '');
INSERT INTO `pms_product_category` VALUES (52, 5, '五金工具', 1, 0, '', 0, 0, 0, 'https://tse1-mm.cn.bing.net/th/id/OIP-C.rwuiAO0b8RHHgGisCXNYUAHaHa?pid=ImgDet&rs=1', '', '');
INSERT INTO `pms_product_category` VALUES (53, 5, '卧室家具', 1, 0, '', 0, 0, 0, 'https://tse2-mm.cn.bing.net/th/id/OIP-C.6TPFcm-OuVME1fFno2QwhgHaFj?pid=ImgDet&rs=1', '', '');
INSERT INTO `pms_product_category` VALUES (54, 5, '客厅家具', 1, 0, '', 0, 0, 0, 'https://img.zcool.cn/community/0158f65603a36932f875a132050063.jpg@1280w_1l_2o_100sh.jpg', '', '');
INSERT INTO `pms_product_category` VALUES (60, 6, '海贼王', 1, 0, NULL, 0, 0, 0, 'https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01zGwXI11vlbRUC3Esj_!!2201168176213.jpg', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (61, 6, '鬼灭之刃', 1, 0, NULL, 0, 0, 0, 'https://img.alicdn.com/imgextra/i3/833261111/O1CN014MMkx01K4sfv0hKnn_!!833261111.png_430x430q90.jpg', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (62, 6, '火影忍者', 1, 0, NULL, 0, 0, 0, 'https://img.alicdn.com/imgextra/i1/36073717/O1CN01y0SxTW1dKQriTUipm_!!36073717.jpg', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (63, 6, '漫威', 1, 0, NULL, 0, 0, 0, 'https://gd3.alicdn.com/imgextra/i3/3165482766/O1CN0145o6w91WIs7hSps4B_!!3165482766.jpg_400x400.jpg', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (64, 6, '龙珠', 1, 0, NULL, 0, 0, 0, 'https://gd1.alicdn.com/imgextra/i1/612966252/O1CN01airkQ51w3Stv4zncN_!!612966252.jpg_400x400.jpg', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (65, 6, '乐高', 1, 0, NULL, 0, 0, 0, 'https://img.alicdn.com/imgextra/i1/4120005381/O1CN011pcXhficbc3lZ2S_!!4120005381-0-scmitem1000.jpg', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (66, 6, 'EVA', 1, 0, NULL, 0, 0, 0, 'https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01c6YZ6d1vlbSbLdWJ2_!!2201168176213.jpg', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (70, 7, '糖果 巧克力', 1, 0, NULL, 0, 0, 0, 'https://tse1-mm.cn.bing.net/th/id/OIP-C.32NvqPIJ6W2EEl_UZllEUwHaHa?pid=ImgDet&rs=1', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (71, 7, '糕饼', 1, 0, NULL, 0, 0, 0, 'https://tse2-mm.cn.bing.net/th/id/OIP-C.NsuiTbbrcy5l1vLusAIfGQHaE8?pid=ImgDet&rs=1', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (72, 7, '谷物类制品', 1, 0, NULL, 0, 0, 0, 'https://tse3-mm.cn.bing.net/th/id/OIP-C.LGsQUtjese_WwDsXZmQPQgHaER?pid=ImgDet&rs=1', NULL, NULL);
INSERT INTO `pms_product_category` VALUES (73, 7, '果仁类制品', 1, 0, NULL, 0, 0, 0, 'https://tse4-mm.cn.bing.net/th/id/OIP-C.Z_OPnUi4_sCl7Suiiit5PgHaHa?pid=ImgDet&rs=1', NULL, NULL);

-- ----------------------------
-- Table structure for pms_product_category_attribute_relation
-- ----------------------------
DROP TABLE IF EXISTS `pms_product_category_attribute_relation`;
CREATE TABLE `pms_product_category_attribute_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_category_id` bigint(20) NULL DEFAULT NULL,
  `product_attribute_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品的分类和属性的关系表，用于设置分类筛选条件（只支持一级分类）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_product_category_attribute_relation
-- ----------------------------
INSERT INTO `pms_product_category_attribute_relation` VALUES (1, 24, 24);
INSERT INTO `pms_product_category_attribute_relation` VALUES (5, 26, 24);
INSERT INTO `pms_product_category_attribute_relation` VALUES (7, 28, 24);
INSERT INTO `pms_product_category_attribute_relation` VALUES (9, 25, 24);
INSERT INTO `pms_product_category_attribute_relation` VALUES (10, 25, 25);
INSERT INTO `pms_product_category_attribute_relation` VALUES (11, 52, 46);
INSERT INTO `pms_product_category_attribute_relation` VALUES (12, 52, NULL);

-- ----------------------------
-- Table structure for pms_product_full_reduction
-- ----------------------------
DROP TABLE IF EXISTS `pms_product_full_reduction`;
CREATE TABLE `pms_product_full_reduction`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NULL DEFAULT NULL,
  `full_price` decimal(10, 2) NULL DEFAULT NULL,
  `reduce_price` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 80 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品满减表(只针对同商品)' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_product_full_reduction
-- ----------------------------
INSERT INTO `pms_product_full_reduction` VALUES (1, 7, 100.00, 20.00);
INSERT INTO `pms_product_full_reduction` VALUES (2, 8, 100.00, 20.00);
INSERT INTO `pms_product_full_reduction` VALUES (3, 9, 100.00, 20.00);
INSERT INTO `pms_product_full_reduction` VALUES (4, 10, 100.00, 20.00);
INSERT INTO `pms_product_full_reduction` VALUES (5, 11, 100.00, 20.00);
INSERT INTO `pms_product_full_reduction` VALUES (6, 12, 100.00, 20.00);
INSERT INTO `pms_product_full_reduction` VALUES (7, 13, 100.00, 20.00);
INSERT INTO `pms_product_full_reduction` VALUES (8, 14, 100.00, 20.00);
INSERT INTO `pms_product_full_reduction` VALUES (9, 18, 100.00, 20.00);
INSERT INTO `pms_product_full_reduction` VALUES (10, 7, 200.00, 50.00);
INSERT INTO `pms_product_full_reduction` VALUES (11, 7, 300.00, 100.00);
INSERT INTO `pms_product_full_reduction` VALUES (14, 22, 0.00, 0.00);
INSERT INTO `pms_product_full_reduction` VALUES (16, 24, 0.00, 0.00);
INSERT INTO `pms_product_full_reduction` VALUES (34, 23, 0.00, 0.00);
INSERT INTO `pms_product_full_reduction` VALUES (44, 31, 0.00, 0.00);
INSERT INTO `pms_product_full_reduction` VALUES (46, 32, 0.00, 0.00);
INSERT INTO `pms_product_full_reduction` VALUES (48, 33, 0.00, 0.00);
INSERT INTO `pms_product_full_reduction` VALUES (55, 34, 0.00, 0.00);
INSERT INTO `pms_product_full_reduction` VALUES (56, 30, 0.00, 0.00);
INSERT INTO `pms_product_full_reduction` VALUES (59, 27, 0.00, 0.00);
INSERT INTO `pms_product_full_reduction` VALUES (60, 28, 500.00, 50.00);
INSERT INTO `pms_product_full_reduction` VALUES (61, 28, 1000.00, 120.00);
INSERT INTO `pms_product_full_reduction` VALUES (62, 29, 0.00, 0.00);
INSERT INTO `pms_product_full_reduction` VALUES (63, 26, 0.00, 0.00);
INSERT INTO `pms_product_full_reduction` VALUES (78, 36, 0.00, 0.00);
INSERT INTO `pms_product_full_reduction` VALUES (79, 35, 0.00, 0.00);

-- ----------------------------
-- Table structure for pms_product_ladder
-- ----------------------------
DROP TABLE IF EXISTS `pms_product_ladder`;
CREATE TABLE `pms_product_ladder`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NULL DEFAULT NULL,
  `count` int(11) NULL DEFAULT NULL COMMENT '满足的商品数量',
  `discount` decimal(10, 2) NULL DEFAULT NULL COMMENT '折扣',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '折后价格',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品阶梯价格表(只针对同商品)' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_product_ladder
-- ----------------------------
INSERT INTO `pms_product_ladder` VALUES (1, 7, 3, 0.70, 0.00);
INSERT INTO `pms_product_ladder` VALUES (2, 8, 3, 0.70, 0.00);
INSERT INTO `pms_product_ladder` VALUES (3, 9, 3, 0.70, 0.00);
INSERT INTO `pms_product_ladder` VALUES (4, 10, 3, 0.70, 0.00);
INSERT INTO `pms_product_ladder` VALUES (5, 11, 3, 0.70, 0.00);
INSERT INTO `pms_product_ladder` VALUES (6, 12, 3, 0.70, 0.00);
INSERT INTO `pms_product_ladder` VALUES (7, 13, 3, 0.70, 0.00);
INSERT INTO `pms_product_ladder` VALUES (8, 14, 3, 0.70, 0.00);
INSERT INTO `pms_product_ladder` VALUES (12, 18, 3, 0.70, 0.00);
INSERT INTO `pms_product_ladder` VALUES (14, 7, 4, 0.60, 0.00);
INSERT INTO `pms_product_ladder` VALUES (15, 7, 5, 0.50, 0.00);
INSERT INTO `pms_product_ladder` VALUES (18, 22, 0, 0.00, 0.00);
INSERT INTO `pms_product_ladder` VALUES (20, 24, 0, 0.00, 0.00);
INSERT INTO `pms_product_ladder` VALUES (38, 23, 0, 0.00, 0.00);
INSERT INTO `pms_product_ladder` VALUES (48, 31, 0, 0.00, 0.00);
INSERT INTO `pms_product_ladder` VALUES (50, 32, 0, 0.00, 0.00);
INSERT INTO `pms_product_ladder` VALUES (52, 33, 0, 0.00, 0.00);
INSERT INTO `pms_product_ladder` VALUES (59, 34, 0, 0.00, 0.00);
INSERT INTO `pms_product_ladder` VALUES (60, 30, 0, 0.00, 0.00);
INSERT INTO `pms_product_ladder` VALUES (64, 27, 2, 0.80, 0.00);
INSERT INTO `pms_product_ladder` VALUES (65, 27, 3, 0.75, 0.00);
INSERT INTO `pms_product_ladder` VALUES (66, 28, 0, 0.00, 0.00);
INSERT INTO `pms_product_ladder` VALUES (67, 29, 0, 0.00, 0.00);
INSERT INTO `pms_product_ladder` VALUES (68, 26, 0, 0.00, 0.00);
INSERT INTO `pms_product_ladder` VALUES (83, 36, 0, 0.00, 0.00);
INSERT INTO `pms_product_ladder` VALUES (84, 35, 0, 0.00, 0.00);

-- ----------------------------
-- Table structure for pms_product_operate_log
-- ----------------------------
DROP TABLE IF EXISTS `pms_product_operate_log`;
CREATE TABLE `pms_product_operate_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NULL DEFAULT NULL,
  `price_old` decimal(10, 2) NULL DEFAULT NULL,
  `price_new` decimal(10, 2) NULL DEFAULT NULL,
  `sale_price_old` decimal(10, 2) NULL DEFAULT NULL,
  `sale_price_new` decimal(10, 2) NULL DEFAULT NULL,
  `gift_point_old` int(11) NULL DEFAULT NULL COMMENT '赠送的积分',
  `gift_point_new` int(11) NULL DEFAULT NULL,
  `use_point_limit_old` int(11) NULL DEFAULT NULL,
  `use_point_limit_new` int(11) NULL DEFAULT NULL,
  `operate_man` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人',
  `create_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_product_operate_log
-- ----------------------------

-- ----------------------------
-- Table structure for pms_product_vertify_record
-- ----------------------------
DROP TABLE IF EXISTS `pms_product_vertify_record`;
CREATE TABLE `pms_product_vertify_record`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `vertify_man` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `status` int(1) NULL DEFAULT NULL,
  `detail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '反馈详情',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品审核记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_product_vertify_record
-- ----------------------------
INSERT INTO `pms_product_vertify_record` VALUES (1, 1, '2018-04-27 16:36:41', 'test', 1, '验证通过');
INSERT INTO `pms_product_vertify_record` VALUES (2, 2, '2018-04-27 16:36:41', 'test', 1, '验证通过');

-- ----------------------------
-- Table structure for pms_sku_stock
-- ----------------------------
DROP TABLE IF EXISTS `pms_sku_stock`;
CREATE TABLE `pms_sku_stock`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NULL DEFAULT NULL,
  `sku_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'sku编码',
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `stock` int(11) NULL DEFAULT 0 COMMENT '库存',
  `low_stock` int(11) NULL DEFAULT NULL COMMENT '预警库存',
  `pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '展示图片',
  `sale` int(11) NULL DEFAULT NULL COMMENT '销量',
  `promotion_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '单品促销价格',
  `lock_stock` int(11) NULL DEFAULT 0 COMMENT '锁定库存',
  `sp_data` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品销售属性，json格式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'sku的库存' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_sku_stock
-- ----------------------------
INSERT INTO `pms_sku_stock` VALUES (0, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `pms_sku_stock` VALUES (1, 1, '202109150027001', 3788.00, 100, 10, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (2, 2, '202109150027002', 5499.00, 100, 10, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (3, 3, '202109150027003', 2499.00, 100, 10, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b02804dN66004d73.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (4, 4, '202109150027004', 3999.00, 100, 10, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b028530N51eee7d4.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (5, 5, '202109150027005', 79.00, 100, 10, 'http://yanxuan.nosdn.127.net/ad5a317216f9da495b144070ecf1f957.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (6, 6, '202109150027006', 319.00, 100, 10, 'http://yanxuan.nosdn.127.net/5350e35e6f22165f38928f3c2c52ac57.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (7, 7, '202109150027007', 619.00, 100, 10, 'http://yanxuan.nosdn.127.net/149dfa87a7324e184c5526ead81de9ad.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (8, 8, '202109150027008', 319.00, 100, 10, 'http://yanxuan.nosdn.127.net/07376e78bf4fb8a5aa8e6a0b1437c3ad.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (9, 9, '202109150027009', 398.00, 100, 10, 'http://yanxuan.nosdn.127.net/c39d54c06a71b4b61b6092a0d31f2335.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (10, 10, '202109150027010', 119.00, 100, 10, 'http://yanxuan.nosdn.127.net/337da7094c1df295ca0f0b8baa55b2d5.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (11, 11, '202109150027011', 139.00, 100, 10, 'http://yanxuan.nosdn.127.net/58ed94b63b39339e7814f1339013793c.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (12, 12, '202109150027012', 99.00, 100, 10, 'http://yanxuan.nosdn.127.net/8a9ee5ba08929cc9e40b973607d2f633.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (13, 13, '202109150027013', 369.00, 100, 10, 'http://yanxuan.nosdn.127.net/a803c68ea88e3116023b45ac9ea99510.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (14, 14, '202109150027014', 219.00, 99, 10, 'http://yanxuan.nosdn.127.net/c83a3881704094ddd3970099ca77d115.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (15, 15, '202109150027015', 6099.00, 100, 10, 'https://img.alicdn.com/imgextra/i1/2838892713/O1CN01FQ69AI1VubCzlAzxB_!!0-item_pic.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (16, 16, '202109150027016', 7488.00, 100, 10, 'https://img.alicdn.com/imgextra/i4/2024314280/O1CN01mT2FdK1hUHrFa4LK6_!!2024314280.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (17, 17, '202109150027017', 4299.00, 100, 10, 'https://img.alicdn.com/imgextra/i2/2838892713/O1CN016tezkQ1VubD4AbBxX_!!2838892713.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (18, 18, '202109150027018', 6799.00, 99, 10, 'https://img.alicdn.com/imgextra/i1/1917047079/O1CN01xeHXfg22AEQKtkTiK_!!1917047079.png_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (19, 19, '202109150027019', 1778.00, 100, 10, 'https://img.alicdn.com/imgextra/i2/2200877014436/O1CN01anNk4S1idjZTDktag_!!2200877014436.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (20, 20, '202109150027020', 6999.00, 100, 10, 'https://img.alicdn.com/imgextra/i1/1917047079/O1CN01qC9RZb22AEQNIo08f_!!2-item_pic.png_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (21, 21, '202109150027021', 5598.00, 100, 10, 'https://img.alicdn.com/imgextra/O1CN016FuwY324luG6F3Vck_!!6000000007432-0-remus.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (22, 22, '202109150027022', 7599.00, 100, 10, 'https://img.alicdn.com/imgextra/i1/2279837698/O1CN016r3Dsh26jjcIUgSsU_!!2279837698.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (23, 23, '202109150027023', 728.00, 100, 10, 'https://img.alicdn.com/imgextra/i3/407700539/O1CN01hPH4eF1FquAsynxJN_!!0-item_pic.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (24, 24, '202109150027024', 1290.00, 100, 10, 'https://img.alicdn.com/imgextra/https://img.alicdn.com/imgextra/i2/2576722561/O1CN01iPI1O21UmyzT2KOC9_!!2576722561.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (25, 25, '202109150027025', 1199.00, 100, 10, 'https://img.alicdn.com/imgextra/i3/1125378539/TB2mCXLX6TpK1RjSZKPXXa3UpXa_!!1125378539.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (26, 26, '202109150027026', 1399.00, 100, 10, 'https://img.alicdn.com/imgextra/i4/647482297/O1CN01WcLlx41Sq4SglOLBs_!!647482297.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (27, 27, '202109150027027', 5978.00, 100, 10, 'https://img.alicdn.com/imgextra/i1/2200877014436/O1CN016ekYBX1idjahukrhA_!!2200877014436.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (28, 28, '202109150027028', 2599.00, 100, 10, 'https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01BqPY9s1vlbMPxJiEh_!!2201168176213.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (29, 29, '202109150027029', 479.00, 100, 10, 'https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01X5D1o01vlbRMW5gCH_!!2201168176213.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (30, 30, '202109150027030', 139.00, 100, 10, 'https://img.alicdn.com/imgextra/i3/833261111/O1CN014MMkx01K4sfv0hKnn_!!833261111.png_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (31, 31, '202109150027031', 179.00, 100, 10, 'https://img.alicdn.com/imgextra/i1/833261111/O1CN01yB5M6b1K4saHiFU5A_!!833261111.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (32, 32, '202109150027032', 285.00, 100, 10, 'https://gd1.alicdn.com/imgextra/i1/612966252/O1CN01airkQ51w3Stv4zncN_!!612966252.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (33, 33, '202109150027033', 228.00, 97, 10, 'https://gd3.alicdn.com/imgextra/i3/3381629725/O1CN01QaB5cG2Li6E4KJn0M_!!3381629725.jpg_400x400.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (34, 34, '202109150027034', 999.00, 100, 10, 'https://img.alicdn.com/imgextra/i1/1916629511/O1CN01mmZBhe2K85g7wOxfd_!!1916629511.jpg_430x430q90.jpg', NULL, NULL, 1, NULL);
INSERT INTO `pms_sku_stock` VALUES (35, 35, '202109150027035', 685.00, 100, 10, 'https://img.alicdn.com/imgextra/i1/2200877014436/O1CN01C00EWE1idjdHq0XHC_!!2200877014436.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (36, 36, '202109150027036', 169.00, 100, 10, 'https://img.alicdn.com/imgextra/i4/2200877014436/O1CN01JSPiOI1idjdZCtMHb_!!2200877014436.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (37, 37, '202109150027037', 2249.00, 99, 10, 'https://img.alicdn.com/imgextra/i2/594767740/O1CN01KBVDeF272yAoep8KZ_!!594767740.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (38, 38, '202109150027038', 599.00, 100, 10, 'https://img.alicdn.com/imgextra/i2/2865745622/O1CN01HfoCnq1rOvJbQlMA8_!!0-item_pic.jpg_430x430q90.jpg', NULL, NULL, 1, NULL);

-- ----------------------------
-- Table structure for sms_coupon
-- ----------------------------
DROP TABLE IF EXISTS `sms_coupon`;
CREATE TABLE `sms_coupon`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(1) NULL DEFAULT NULL COMMENT '优惠券类型；0->全场赠券；1->会员赠券；2->购物赠券；3->注册赠券',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `platform` int(1) NULL DEFAULT NULL COMMENT '使用平台：0->全部；1->移动；2->PC',
  `count` int(11) NULL DEFAULT NULL COMMENT '数量',
  `amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '金额',
  `per_limit` int(11) NULL DEFAULT NULL COMMENT '每人限领张数',
  `min_point` decimal(10, 2) NULL DEFAULT NULL COMMENT '使用门槛；0表示无门槛',
  `start_time` datetime NULL DEFAULT NULL,
  `end_time` datetime NULL DEFAULT NULL,
  `use_type` int(1) NULL DEFAULT NULL COMMENT '使用类型：0->全场通用；1->指定分类；2->指定商品',
  `note` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `publish_count` int(11) NULL DEFAULT NULL COMMENT '发行数量',
  `use_count` int(11) NULL DEFAULT NULL COMMENT '已使用数量',
  `receive_count` int(11) NULL DEFAULT NULL COMMENT '领取数量',
  `enable_time` datetime NULL DEFAULT NULL COMMENT '可以领取的日期',
  `code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '优惠码',
  `member_level` int(1) NULL DEFAULT NULL COMMENT '可领取的会员类型：0->无限时',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '优惠券表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sms_coupon
-- ----------------------------
INSERT INTO `sms_coupon` VALUES (2, 0, '全品类通用券', 0, 92, 10.00, 1, 100.00, '2018-08-27 16:40:47', '2018-11-23 16:40:47', 0, '满100减10', 100, 0, 8, '2018-08-27 16:40:47', NULL, NULL);
INSERT INTO `sms_coupon` VALUES (3, 0, '小米手机专用券', 0, 92, 50.00, 1, 1000.00, '2018-08-27 16:40:47', '2018-11-16 16:40:47', 2, '小米手机专用优惠券', 100, 0, 8, '2018-08-27 16:40:47', NULL, NULL);
INSERT INTO `sms_coupon` VALUES (4, 0, '手机品类专用券', 0, 92, 300.00, 1, 2000.00, '2018-08-27 16:40:47', '2018-09-15 16:40:47', 1, '手机分类专用优惠券', 100, 0, 8, '2018-08-27 16:40:47', NULL, NULL);
INSERT INTO `sms_coupon` VALUES (7, 0, 'T恤分类专用优惠券', 0, 93, 50.00, 1, 500.00, '2018-08-27 16:40:47', '2018-08-15 16:40:47', 1, '满500减50', 100, 0, 7, '2018-08-27 16:40:47', NULL, NULL);
INSERT INTO `sms_coupon` VALUES (8, 0, '新优惠券', 0, 100, 100.00, 1, 1000.00, '2018-11-08 00:00:00', '2018-11-27 00:00:00', 0, '测试', 100, 0, 1, NULL, NULL, NULL);
INSERT INTO `sms_coupon` VALUES (9, 0, '全品类通用券', 0, 100, 5.00, 1, 100.00, '2018-11-08 00:00:00', '2018-11-10 00:00:00', 0, NULL, 100, 0, 1, NULL, NULL, NULL);
INSERT INTO `sms_coupon` VALUES (10, 0, '全品类通用券', 0, 100, 15.00, 1, 200.00, '2018-11-08 00:00:00', '2018-11-10 00:00:00', 0, NULL, 100, 0, 1, NULL, NULL, NULL);
INSERT INTO `sms_coupon` VALUES (11, 0, '全品类通用券', 0, 1000, 50.00, 1, 1000.00, '2018-11-08 00:00:00', '2018-11-10 00:00:00', 0, NULL, 1000, 0, 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon` VALUES (12, 0, '移动端全品类通用券', 1, 1, 10.00, 1, 100.00, '2018-11-08 00:00:00', '2018-11-10 00:00:00', 0, NULL, 100, 0, 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon` VALUES (19, 0, '手机分类专用', 0, 100, 100.00, 1, 1000.00, '2018-11-09 00:00:00', '2018-11-17 00:00:00', 1, '手机分类专用', 100, 0, 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon` VALUES (20, 0, '小米手机专用', 0, 100, 200.00, 1, 1000.00, '2018-11-09 00:00:00', '2018-11-24 00:00:00', 2, '小米手机专用', 100, 0, 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon` VALUES (21, 0, 'xxx', 0, 100, 10.00, 1, 100.00, '2018-11-09 00:00:00', '2018-11-30 00:00:00', 2, NULL, 100, 0, 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon` VALUES (22, 0, 'string', 0, 0, 0.00, 0, 0.00, '2019-08-18 15:36:11', '2019-08-18 15:36:11', 0, 'string', 0, 0, 0, '2019-08-18 15:36:11', 'string', 0);
INSERT INTO `sms_coupon` VALUES (23, 0, '有效期测试', 0, 100, 10.00, 1, 100.00, '2019-10-05 00:00:00', '2019-10-09 00:00:00', 0, NULL, 100, 0, 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon` VALUES (24, 0, '测试优惠券', 0, 100, 10.00, 0, 0.00, '2021-09-06 00:00:00', '2021-10-06 00:00:00', 0, '测试券', 100, 0, 0, '2021-09-07 14:53:00', NULL, NULL);

-- ----------------------------
-- Table structure for sms_coupon_history
-- ----------------------------
DROP TABLE IF EXISTS `sms_coupon_history`;
CREATE TABLE `sms_coupon_history`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `coupon_id` bigint(20) NULL DEFAULT NULL,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `coupon_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `member_nickname` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '领取人昵称',
  `get_type` int(1) NULL DEFAULT NULL COMMENT '获取类型：0->后台赠送；1->主动获取',
  `create_time` datetime NULL DEFAULT NULL,
  `use_status` int(1) NULL DEFAULT NULL COMMENT '使用状态：0->未使用；1->已使用；2->已过期',
  `use_time` datetime NULL DEFAULT NULL COMMENT '使用时间',
  `order_id` bigint(20) NULL DEFAULT NULL COMMENT '订单编号',
  `order_sn` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单号码',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_member_id`(`member_id`) USING BTREE,
  INDEX `idx_coupon_id`(`coupon_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '优惠券使用、领取历史表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sms_coupon_history
-- ----------------------------
INSERT INTO `sms_coupon_history` VALUES (2, 2, 1, '4931048380330002', 'windir', 1, '2018-08-29 14:04:12', 1, '2018-11-12 14:38:47', 12, '201809150101000001');
INSERT INTO `sms_coupon_history` VALUES (3, 3, 1, '4931048380330003', 'windir', 1, '2018-08-29 14:04:29', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (4, 4, 1, '4931048380330004', 'windir', 1, '2018-08-29 14:04:32', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (11, 7, 1, '4931048380330001', 'windir', 1, '2018-09-04 16:21:50', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (12, 2, 4, '0340981248320004', 'zhensan', 1, '2018-11-12 14:16:50', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (13, 3, 4, '0342977234360004', 'zhensan', 1, '2018-11-12 14:17:10', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (14, 4, 4, '0343342928830004', 'zhensan', 1, '2018-11-12 14:17:13', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (15, 2, 5, '0351883832180005', 'lisi', 1, '2018-11-12 14:18:39', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (16, 3, 5, '0352201672680005', 'lisi', 1, '2018-11-12 14:18:42', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (17, 4, 5, '0352505810180005', 'lisi', 1, '2018-11-12 14:18:45', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (18, 2, 6, '0356114588380006', 'wangwu', 1, '2018-11-12 14:19:21', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (19, 3, 6, '0356382856920006', 'wangwu', 1, '2018-11-12 14:19:24', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (20, 4, 6, '0356656798470006', 'wangwu', 1, '2018-11-12 14:19:27', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (21, 2, 3, '0363644984620003', 'windy', 1, '2018-11-12 14:20:36', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (22, 3, 3, '0363932820300003', 'windy', 1, '2018-11-12 14:20:39', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (23, 4, 3, '0364238275840003', 'windy', 1, '2018-11-12 14:20:42', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (24, 2, 7, '0385034833070007', 'lion', 1, '2018-11-12 14:24:10', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (25, 3, 7, '0385350208650007', 'lion', 1, '2018-11-12 14:24:13', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (26, 4, 7, '0385632733900007', 'lion', 1, '2018-11-12 14:24:16', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (27, 2, 8, '0388779132990008', 'shari', 1, '2018-11-12 14:24:48', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (28, 3, 8, '0388943658810008', 'shari', 1, '2018-11-12 14:24:49', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (29, 4, 8, '0389069398320008', 'shari', 1, '2018-11-12 14:24:51', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (30, 2, 9, '0390753935250009', 'aewen', 1, '2018-11-12 14:25:08', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (31, 3, 9, '0390882954470009', 'aewen', 1, '2018-11-12 14:25:09', 0, NULL, NULL, NULL);
INSERT INTO `sms_coupon_history` VALUES (32, 4, 9, '0391025542810009', 'aewen', 1, '2018-11-12 14:25:10', 0, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sms_coupon_product_category_relation
-- ----------------------------
DROP TABLE IF EXISTS `sms_coupon_product_category_relation`;
CREATE TABLE `sms_coupon_product_category_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `coupon_id` bigint(20) NULL DEFAULT NULL,
  `product_category_id` bigint(20) NULL DEFAULT NULL,
  `product_category_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品分类名称',
  `parent_category_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '优惠券和产品分类关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sms_coupon_product_category_relation
-- ----------------------------
INSERT INTO `sms_coupon_product_category_relation` VALUES (4, 19, 30, '手机配件', '手机数码');

-- ----------------------------
-- Table structure for sms_coupon_product_relation
-- ----------------------------
DROP TABLE IF EXISTS `sms_coupon_product_relation`;
CREATE TABLE `sms_coupon_product_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `coupon_id` bigint(20) NULL DEFAULT NULL,
  `product_id` bigint(20) NULL DEFAULT NULL,
  `product_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `product_sn` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '优惠券和产品的关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sms_coupon_product_relation
-- ----------------------------
INSERT INTO `sms_coupon_product_relation` VALUES (9, 21, 33, '小米（MI）小米电视4A ', '4609652');

-- ----------------------------
-- Table structure for sms_flash_promotion
-- ----------------------------
DROP TABLE IF EXISTS `sms_flash_promotion`;
CREATE TABLE `sms_flash_promotion`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `start_date` date NULL DEFAULT NULL COMMENT '开始日期',
  `end_date` date NULL DEFAULT NULL COMMENT '结束日期',
  `status` int(1) NULL DEFAULT NULL COMMENT '上下线状态',
  `create_time` datetime NULL DEFAULT NULL COMMENT '秒杀时间段名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '限时购表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sms_flash_promotion
-- ----------------------------
INSERT INTO `sms_flash_promotion` VALUES (2, '春季家电家具疯狂秒杀1', '2018-11-12', '2018-11-23', 1, '2018-11-16 11:12:13');
INSERT INTO `sms_flash_promotion` VALUES (3, '手机特卖', '2018-11-03', '2018-11-10', 1, '2018-11-16 11:11:31');
INSERT INTO `sms_flash_promotion` VALUES (4, '春季家电家具疯狂秒杀3', '2018-11-24', '2018-11-25', 1, '2018-11-16 11:12:19');
INSERT INTO `sms_flash_promotion` VALUES (5, '春季家电家具疯狂秒杀4', '2018-11-16', '2018-11-16', 1, '2018-11-16 11:12:24');
INSERT INTO `sms_flash_promotion` VALUES (6, '春季家电家具疯狂秒杀5', '2018-11-16', '2018-11-16', 1, '2018-11-16 11:12:31');
INSERT INTO `sms_flash_promotion` VALUES (7, '春季家电家具疯狂秒杀6', '2018-11-16', '2018-11-16', 1, '2018-11-16 11:12:35');
INSERT INTO `sms_flash_promotion` VALUES (8, '春季家电家具疯狂秒杀7', '2018-11-16', '2018-11-16', 0, '2018-11-16 11:12:39');
INSERT INTO `sms_flash_promotion` VALUES (9, '春季家电家具疯狂秒杀8', '2018-11-16', '2018-11-16', 0, '2018-11-16 11:12:42');
INSERT INTO `sms_flash_promotion` VALUES (13, '测试', '2018-11-01', '2018-11-30', 0, '2018-11-19 10:34:24');

-- ----------------------------
-- Table structure for sms_flash_promotion_log
-- ----------------------------
DROP TABLE IF EXISTS `sms_flash_promotion_log`;
CREATE TABLE `sms_flash_promotion_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NULL DEFAULT NULL,
  `product_id` bigint(20) NULL DEFAULT NULL,
  `member_phone` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `product_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `subscribe_time` datetime NULL DEFAULT NULL COMMENT '会员订阅时间',
  `send_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '限时购通知记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sms_flash_promotion_log
-- ----------------------------

-- ----------------------------
-- Table structure for sms_flash_promotion_product_relation
-- ----------------------------
DROP TABLE IF EXISTS `sms_flash_promotion_product_relation`;
CREATE TABLE `sms_flash_promotion_product_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `flash_promotion_id` bigint(20) NULL DEFAULT NULL,
  `flash_promotion_session_id` bigint(20) NULL DEFAULT NULL COMMENT '编号',
  `product_id` bigint(20) NULL DEFAULT NULL,
  `flash_promotion_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '限时购价格',
  `flash_promotion_count` int(11) NULL DEFAULT NULL COMMENT '限时购数量',
  `flash_promotion_limit` int(11) NULL DEFAULT NULL COMMENT '每人限购数量',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品限时购与商品关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sms_flash_promotion_product_relation
-- ----------------------------
INSERT INTO `sms_flash_promotion_product_relation` VALUES (1, 2, 1, 26, 3000.00, 10, 1, 0);
INSERT INTO `sms_flash_promotion_product_relation` VALUES (2, 2, 1, 27, 2000.00, 10, 1, 20);
INSERT INTO `sms_flash_promotion_product_relation` VALUES (3, 2, 1, 28, 599.00, 19, 1, 0);
INSERT INTO `sms_flash_promotion_product_relation` VALUES (4, 2, 1, 29, 4999.00, 10, 1, 100);
INSERT INTO `sms_flash_promotion_product_relation` VALUES (9, 2, 2, 26, 2999.00, 100, 1, 0);
INSERT INTO `sms_flash_promotion_product_relation` VALUES (10, 2, 2, 27, NULL, NULL, NULL, NULL);
INSERT INTO `sms_flash_promotion_product_relation` VALUES (11, 2, 2, 28, NULL, NULL, NULL, NULL);
INSERT INTO `sms_flash_promotion_product_relation` VALUES (12, 2, 2, 29, NULL, NULL, NULL, NULL);
INSERT INTO `sms_flash_promotion_product_relation` VALUES (13, 2, 2, 30, NULL, NULL, NULL, NULL);
INSERT INTO `sms_flash_promotion_product_relation` VALUES (14, 2, 3, 31, NULL, NULL, NULL, NULL);
INSERT INTO `sms_flash_promotion_product_relation` VALUES (15, 2, 3, 32, NULL, NULL, NULL, NULL);
INSERT INTO `sms_flash_promotion_product_relation` VALUES (16, 2, 4, 33, NULL, NULL, NULL, NULL);
INSERT INTO `sms_flash_promotion_product_relation` VALUES (17, 2, 4, 34, NULL, NULL, NULL, NULL);
INSERT INTO `sms_flash_promotion_product_relation` VALUES (18, 2, 5, 36, NULL, NULL, NULL, NULL);
INSERT INTO `sms_flash_promotion_product_relation` VALUES (19, 2, 6, 33, NULL, NULL, NULL, NULL);
INSERT INTO `sms_flash_promotion_product_relation` VALUES (20, 2, 6, 34, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sms_flash_promotion_session
-- ----------------------------
DROP TABLE IF EXISTS `sms_flash_promotion_session`;
CREATE TABLE `sms_flash_promotion_session`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '场次名称',
  `start_time` time NULL DEFAULT NULL COMMENT '每日开始时间',
  `end_time` time NULL DEFAULT NULL COMMENT '每日结束时间',
  `status` int(1) NULL DEFAULT NULL COMMENT '启用状态：0->不启用；1->启用',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '限时购场次表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sms_flash_promotion_session
-- ----------------------------
INSERT INTO `sms_flash_promotion_session` VALUES (1, '8:00', '08:00:29', '09:00:33', 1, '2018-11-16 13:22:17');
INSERT INTO `sms_flash_promotion_session` VALUES (2, '10:00', '10:00:33', '11:00:33', 1, '2018-11-16 13:22:34');
INSERT INTO `sms_flash_promotion_session` VALUES (3, '12:00', '12:00:00', '13:00:22', 1, '2018-11-16 13:22:37');
INSERT INTO `sms_flash_promotion_session` VALUES (4, '14:00', '14:00:00', '15:00:00', 1, '2018-11-16 13:22:41');
INSERT INTO `sms_flash_promotion_session` VALUES (5, '16:00', '16:00:00', '17:00:00', 1, '2018-11-16 13:22:45');
INSERT INTO `sms_flash_promotion_session` VALUES (6, '18:00', '18:00:00', '19:00:00', 1, '2018-11-16 13:21:34');
INSERT INTO `sms_flash_promotion_session` VALUES (7, '20:00', '20:00:33', '21:00:33', 0, '2018-11-16 13:22:55');

-- ----------------------------
-- Table structure for sms_home_advertise
-- ----------------------------
DROP TABLE IF EXISTS `sms_home_advertise`;
CREATE TABLE `sms_home_advertise`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int(1) NULL DEFAULT NULL COMMENT '轮播位置：0->PC首页轮播；1->app首页轮播',
  `pic` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `start_time` datetime NULL DEFAULT NULL,
  `end_time` datetime NULL DEFAULT NULL,
  `status` int(1) NULL DEFAULT NULL COMMENT '上下线状态：0->下线；1->上线',
  `click_count` int(11) NULL DEFAULT NULL COMMENT '点击数',
  `order_count` int(11) NULL DEFAULT NULL COMMENT '下单数',
  `url` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '链接地址',
  `note` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `sort` int(11) NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '首页轮播广告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sms_home_advertise
-- ----------------------------
INSERT INTO `sms_home_advertise` VALUES (2, '夏季大热促销', 1, 'https://img.alicdn.com/tfs/TB1wOidVWL7gK0jSZFBXXXZZpXa-520-280.jpg', '2018-11-01 14:01:37', '2018-11-15 14:01:37', 1, 0, 0, NULL, '夏季大热促销', 0);
INSERT INTO `sms_home_advertise` VALUES (3, '夏季大热促销1', 1, 'https://img.alicdn.com/tfs/TB1wOidVWL7gK0jSZFBXXXZZpXa-520-280.jpg', '2018-11-13 14:01:37', '2018-11-13 14:01:37', 0, 0, 0, NULL, '夏季大热促销1', 0);
INSERT INTO `sms_home_advertise` VALUES (4, '夏季大热促销2', 1, 'https://img.alicdn.com/tfs/TB1wOidVWL7gK0jSZFBXXXZZpXa-520-280.jpg', '2018-11-13 14:01:37', '2018-11-13 14:01:37', 1, 0, 0, NULL, '夏季大热促销2', 0);
INSERT INTO `sms_home_advertise` VALUES (9, '电影推荐广告', 1, 'https://img.alicdn.com/tfs/TB1wOidVWL7gK0jSZFBXXXZZpXa-520-280.jpg', '2018-11-01 00:00:00', '2018-11-24 00:00:00', 1, 0, 0, 'www.baidu.com', '电影推荐广告', 100);
INSERT INTO `sms_home_advertise` VALUES (10, '汽车促销广告', 1, 'https://gtms01.alicdn.com/tps/i1/TB1r4h8JXXXXXXoXXXXvKyzTVXX-520-280.jpg', '2018-11-13 00:00:00', '2018-11-24 00:00:00', 1, 0, 0, 'xxx', NULL, 99);
INSERT INTO `sms_home_advertise` VALUES (11, '汽车推荐广告', 1, 'https://img.alicdn.com/tfs/TB1wOidVWL7gK0jSZFBXXXZZpXa-520-280.jpg', '2018-11-13 00:00:00', '2018-11-30 00:00:00', 1, 0, 0, 'xxx', NULL, 98);

-- ----------------------------
-- Table structure for sms_home_brand
-- ----------------------------
DROP TABLE IF EXISTS `sms_home_brand`;
CREATE TABLE `sms_home_brand`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `brand_id` bigint(20) NULL DEFAULT NULL,
  `brand_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `recommend_status` int(1) NULL DEFAULT NULL,
  `sort` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '首页推荐品牌表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sms_home_brand
-- ----------------------------
INSERT INTO `sms_home_brand` VALUES (1, 1, '万和', 1, 0);
INSERT INTO `sms_home_brand` VALUES (2, 2, '三星', 1, 300);
INSERT INTO `sms_home_brand` VALUES (6, 3, '华为', 1, 500);
INSERT INTO `sms_home_brand` VALUES (8, 4, '格力', 1, 0);
INSERT INTO `sms_home_brand` VALUES (31, 5, '方太', 0, 0);
INSERT INTO `sms_home_brand` VALUES (33, 7, 'OPPO', 1, 0);
INSERT INTO `sms_home_brand` VALUES (34, 8, '七匹狼', 0, 0);
INSERT INTO `sms_home_brand` VALUES (35, 9, '海澜之家', 1, 300);
INSERT INTO `sms_home_brand` VALUES (36, 10, '苹果', 1, 450);
INSERT INTO `sms_home_brand` VALUES (37, 11, 'NIKE', 1, 0);
INSERT INTO `sms_home_brand` VALUES (38, 12, 'MUJI', 1, 0);
INSERT INTO `sms_home_brand` VALUES (39, 13, '范思哲', 1, 250);
INSERT INTO `sms_home_brand` VALUES (42, 6, '小米', 1, 300);

-- ----------------------------
-- Table structure for sms_home_new_product
-- ----------------------------
DROP TABLE IF EXISTS `sms_home_new_product`;
CREATE TABLE `sms_home_new_product`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NULL DEFAULT NULL,
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `recommend_status` int(1) NULL DEFAULT NULL,
  `sort` int(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '新鲜好物表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sms_home_new_product
-- ----------------------------
INSERT INTO `sms_home_new_product` VALUES (1, 16, '【旗舰新品】华为P50 Pro 4G全网通搭载HarmonyOS 2麒麟9000华为手机华为官方旗舰店正品p50pro', 1, 100);
INSERT INTO `sms_home_new_product` VALUES (2, 22, 'Xiaomi/小米 11 Ultra 5G手机全网通官方旗舰店正品官网至尊版系列10新款pro红米青春手机', 1, 100);
INSERT INTO `sms_home_new_product` VALUES (3, 18, 'Apple/苹果 iPhone 12', 1, 100);
INSERT INTO `sms_home_new_product` VALUES (4, 27, '索尼PS5主机 电视游戏机 无光驱版 超 蓝光8K 日版家用单机怪物', 1, 100);
INSERT INTO `sms_home_new_product` VALUES (5, 26, 'Beats Solo Pro头戴式耳机无线蓝牙b魔音苹果降噪运动耳麦高音质', 1, 150);
INSERT INTO `sms_home_new_product` VALUES (6, 33, '海洋堂新世纪福音战士EVA成品初号机', 1, 200);

-- ----------------------------
-- Table structure for sms_home_recommend_product
-- ----------------------------
DROP TABLE IF EXISTS `sms_home_recommend_product`;
CREATE TABLE `sms_home_recommend_product`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NULL DEFAULT NULL,
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `recommend_status` int(1) NULL DEFAULT NULL,
  `sort` int(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '人气推荐商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sms_home_recommend_product
-- ----------------------------
INSERT INTO `sms_home_recommend_product` VALUES (1, 15, '华为Mate 40 Pro 4G麒麟曲面华为手机4g手机智能手机华为官方旗舰店mate40pro', 1, 100);
INSERT INTO `sms_home_recommend_product` VALUES (2, 25, '天王表钢带简约情侣手表男士女士休闲石英表生日礼物3798', 1, 80);
INSERT INTO `sms_home_recommend_product` VALUES (3, 28, '日本直邮Nintendo/任天堂Switch掌上游戏机NS红蓝手柄续航增强版', 1, 200);
INSERT INTO `sms_home_recommend_product` VALUES (4, 34, '[全款预售]SEGA EVA新世纪福音战士剧场版终 明日香 景品手办', 1, 500);
INSERT INTO `sms_home_recommend_product` VALUES (5, 37, '乐高机械组成人乐高布加迪威龙 Bugatti Chiron拼插积木玩具42083', 1, 400);
INSERT INTO `sms_home_recommend_product` VALUES (6, 10, '方形封闭式宠物窝 封闭式设计猫咪独享', 1, 0);
INSERT INTO `sms_home_recommend_product` VALUES (7, 14, '清欢日式可调节台灯 木铁结合，全体可调节', 1, 0);

-- ----------------------------
-- Table structure for sms_home_recommend_subject
-- ----------------------------
DROP TABLE IF EXISTS `sms_home_recommend_subject`;
CREATE TABLE `sms_home_recommend_subject`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `subject_id` bigint(20) NULL DEFAULT NULL,
  `subject_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `recommend_status` int(1) NULL DEFAULT NULL,
  `sort` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '首页推荐专题表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sms_home_recommend_subject
-- ----------------------------
INSERT INTO `sms_home_recommend_subject` VALUES (14, 1, 'polo衬衫的也时尚', 1, 0);
INSERT INTO `sms_home_recommend_subject` VALUES (15, 2, '大牌手机低价秒', 1, 0);
INSERT INTO `sms_home_recommend_subject` VALUES (16, 3, '晓龙845新品上市', 1, 0);
INSERT INTO `sms_home_recommend_subject` VALUES (17, 4, '夏天应该穿什么', 1, 0);
INSERT INTO `sms_home_recommend_subject` VALUES (18, 5, '夏季精选', 1, 100);
INSERT INTO `sms_home_recommend_subject` VALUES (19, 6, '品牌手机降价', 1, 0);

-- ----------------------------
-- Table structure for ums_admin
-- ----------------------------
DROP TABLE IF EXISTS `ums_admin`;
CREATE TABLE `ums_admin`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `nick_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `note` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `login_time` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `status` int(1) NULL DEFAULT 1 COMMENT '帐号启用状态：0->禁用；1->启用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_admin
-- ----------------------------
INSERT INTO `ums_admin` VALUES (1, 'test', 'd941cf1382c4ddb8c1b11620cd5d6279', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg.jpg', 'test@qq.com', '测试账号', NULL, '2018-09-29 13:55:30', '2021-09-08 09:52:44', 1);
INSERT INTO `ums_admin` VALUES (3, 'admin', 'd941cf1382c4ddb8c1b11620cd5d6279', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/timg.jpg', 'admin@163.com', '系统管理员', '系统管理员', '2018-10-08 13:32:47', '2021-09-08 09:53:52', 1);
INSERT INTO `ums_admin` VALUES (4, 'macro', '$2a$10$Bx4jZPR7GhEpIQfefDQtVeS58GfT5n6mxs/b4nLLK65eMFa16topa', 'string', 'macro@qq.com', 'macro', 'macro专用', '2019-10-06 15:53:51', '2020-02-03 14:55:55', 1);
INSERT INTO `ums_admin` VALUES (6, 'productAdmin', 'd941cf1382c4ddb8c1b11620cd5d6279', NULL, 'product@qq.com', '商品管理员', '只有商品权限', '2020-02-07 16:15:08', '2021-09-08 09:53:14', 1);
INSERT INTO `ums_admin` VALUES (7, 'orderAdmin', 'd941cf1382c4ddb8c1b11620cd5d6279', NULL, 'order@qq.com', '订单管理员', '只有订单管理权限', '2020-02-07 16:15:50', '2021-09-08 11:13:22', 1);
INSERT INTO `ums_admin` VALUES (8, 'lucien', 'd941cf1382c4ddb8c1b11620cd5d6279', '', '799774821@qq.com', 'lucien_xxx', 'cxy专用', '2021-08-25 18:10:21', '2021-09-12 20:15:56', 1);

-- ----------------------------
-- Table structure for ums_admin_login_log
-- ----------------------------
DROP TABLE IF EXISTS `ums_admin_login_log`;
CREATE TABLE `ums_admin_login_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_agent` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览器登录类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 305 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户登录日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_admin_login_log
-- ----------------------------
INSERT INTO `ums_admin_login_log` VALUES (1, 3, '2018-12-23 14:27:00', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (2, 3, '2019-04-07 16:04:39', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (3, 3, '2019-04-08 21:47:52', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (4, 3, '2019-04-08 21:48:18', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (5, 3, '2019-04-18 22:18:40', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (6, 3, '2019-04-20 12:45:16', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (7, 3, '2019-05-19 14:52:12', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (8, 3, '2019-05-25 15:00:17', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (9, 3, '2019-06-19 20:11:42', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (10, 3, '2019-06-30 10:33:48', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (11, 3, '2019-06-30 10:34:31', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (12, 3, '2019-06-30 10:35:34', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (13, 3, '2019-07-27 17:11:01', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (14, 3, '2019-07-27 17:13:18', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (15, 3, '2019-07-27 17:15:35', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (16, 3, '2019-07-27 17:17:11', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (17, 3, '2019-07-27 17:18:34', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (18, 3, '2019-07-27 21:21:52', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (19, 3, '2019-07-27 21:34:29', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (20, 3, '2019-07-27 21:35:17', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (21, 3, '2019-07-27 21:35:48', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (22, 3, '2019-07-27 21:40:33', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (23, 3, '2019-08-18 16:00:38', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (24, 3, '2019-08-18 16:01:06', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (25, 3, '2019-08-18 16:47:01', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (26, 3, '2019-10-06 15:54:23', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (27, 3, '2019-10-06 16:03:28', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (28, 3, '2019-10-06 16:04:51', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (29, 3, '2019-10-06 16:06:44', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (30, 3, '2019-10-06 16:14:51', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (31, 1, '2019-10-06 16:15:09', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (32, 1, '2019-10-06 16:16:14', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (33, 3, '2019-10-06 16:16:35', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (34, 3, '2019-10-06 16:16:42', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (35, 3, '2019-10-07 15:20:48', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (36, 3, '2019-10-07 15:40:07', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (37, 3, '2019-10-07 16:34:15', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (38, 3, '2019-10-09 21:19:08', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (39, 4, '2019-10-09 21:30:35', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (40, 4, '2019-10-09 21:31:30', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (41, 4, '2019-10-09 21:32:39', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (42, 4, '2019-10-09 21:33:27', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (43, 4, '2019-10-09 21:33:50', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (44, 3, '2019-10-20 16:02:53', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (45, 3, '2019-10-23 21:20:55', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (46, 3, '2019-10-27 21:41:45', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (47, 3, '2019-11-09 16:44:57', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (48, 3, '2019-11-09 16:46:56', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (49, 3, '2019-11-09 16:49:55', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (50, 3, '2019-11-23 14:17:16', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (51, 6, '2019-11-23 14:52:30', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (52, 3, '2019-11-23 15:07:24', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (53, 3, '2019-11-30 21:25:30', '192.168.3.185', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (54, 3, '2019-11-30 21:27:54', '192.168.3.185', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (55, 3, '2019-12-28 15:23:01', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (56, 3, '2020-01-01 15:21:46', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (57, 3, '2020-01-04 16:00:54', '192.168.3.185', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (58, 3, '2020-02-01 15:05:19', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (59, 3, '2020-02-01 15:36:05', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (60, 3, '2020-02-01 15:36:36', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (61, 3, '2020-02-01 15:37:30', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (62, 3, '2020-02-01 15:37:46', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (63, 3, '2020-02-01 15:38:20', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (64, 3, '2020-02-01 15:38:33', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (65, 3, '2020-02-01 15:39:06', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (66, 3, '2020-02-01 15:41:31', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (67, 3, '2020-02-01 15:43:17', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (68, 3, '2020-02-01 15:44:34', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (69, 3, '2020-02-01 15:45:10', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (70, 3, '2020-02-01 15:46:04', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (71, 3, '2020-02-01 15:48:33', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (72, 3, '2020-02-01 16:00:07', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (73, 3, '2020-02-01 16:07:25', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (74, 3, '2020-02-01 16:08:22', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (75, 3, '2020-02-02 15:28:13', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (76, 3, '2020-02-02 15:44:37', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (77, 3, '2020-02-02 15:45:25', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (78, 3, '2020-02-02 15:52:32', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (79, 3, '2020-02-02 15:53:44', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (80, 3, '2020-02-02 15:54:36', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (81, 3, '2020-02-02 16:01:00', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (82, 3, '2020-02-02 16:05:19', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (83, 3, '2020-02-02 16:06:31', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (84, 3, '2020-02-02 16:17:26', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (85, 3, '2020-02-02 16:18:45', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (86, 3, '2020-02-02 16:19:05', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (87, 3, '2020-02-02 16:19:23', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (88, 3, '2020-02-02 16:22:27', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (89, 3, '2020-02-02 16:23:30', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (90, 3, '2020-02-02 16:23:48', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (91, 3, '2020-02-02 16:24:38', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (92, 3, '2020-02-02 16:25:22', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (93, 3, '2020-02-02 16:26:19', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (94, 3, '2020-02-02 16:26:31', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (95, 3, '2020-02-02 16:27:08', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (96, 3, '2020-02-02 16:31:02', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (97, 3, '2020-02-02 16:31:08', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (98, 3, '2020-02-02 16:31:25', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (99, 3, '2020-02-02 16:31:50', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (100, 3, '2020-02-02 16:33:22', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (101, 3, '2020-02-02 16:33:41', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (102, 3, '2020-02-02 16:34:58', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (103, 3, '2020-02-02 16:38:42', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (104, 3, '2020-02-02 16:39:41', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (105, 3, '2020-02-02 16:42:22', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (106, 3, '2020-02-02 16:46:21', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (107, 3, '2020-02-02 16:50:23', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (108, 3, '2020-02-02 16:51:11', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (109, 3, '2020-02-02 16:51:22', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (110, 3, '2020-02-02 16:52:00', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (111, 3, '2020-02-02 17:01:05', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (112, 3, '2020-02-03 10:43:22', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (113, 3, '2020-02-03 10:45:29', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (114, 3, '2020-02-03 10:46:33', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (115, 3, '2020-02-03 10:54:33', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (116, 3, '2020-02-03 14:24:47', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (117, 3, '2020-02-03 14:25:38', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (118, 5, '2020-02-03 15:22:28', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (119, 5, '2020-02-03 15:23:00', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (120, 5, '2020-02-03 15:24:29', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (121, 3, '2020-02-03 15:24:50', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (122, 5, '2020-02-03 15:27:18', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (123, 3, '2020-02-03 15:27:33', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (124, 3, '2020-02-03 15:29:06', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (125, 5, '2020-02-03 15:33:25', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (126, 3, '2020-02-03 15:33:51', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (127, 1, '2020-02-03 15:34:35', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (128, 3, '2020-02-03 15:34:47', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (129, 3, '2020-02-04 14:14:46', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (130, 3, '2020-02-05 10:33:35', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (131, 3, '2020-02-05 10:36:21', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (132, 3, '2020-02-05 16:34:37', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (133, 4, '2020-02-05 16:58:37', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (134, 3, '2020-02-05 16:59:03', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (135, 3, '2020-02-06 10:25:02', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (136, 3, '2020-02-07 14:34:34', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (137, 3, '2020-02-07 14:36:20', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (138, 1, '2020-02-07 14:43:34', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (139, 3, '2020-02-07 15:18:06', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (140, 3, '2020-02-07 15:20:07', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (141, 3, '2020-02-07 15:22:20', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (142, 3, '2020-02-07 15:22:28', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (143, 3, '2020-02-07 15:55:11', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (144, 3, '2020-02-07 15:56:04', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (145, 3, '2020-02-07 15:58:49', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (146, 6, '2020-02-07 16:16:21', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (147, 7, '2020-02-07 16:16:37', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (148, 3, '2020-02-07 16:18:39', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (149, 7, '2020-02-07 16:20:06', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (150, 3, '2020-02-07 16:20:44', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (151, 3, '2020-02-07 16:32:31', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (152, 3, '2020-02-07 19:32:34', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (153, 3, '2020-02-07 19:32:48', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (154, 3, '2020-02-07 19:33:01', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (155, 3, '2020-02-07 19:33:06', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (156, 3, '2020-02-07 19:33:21', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (157, 3, '2020-02-07 19:35:33', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (158, 3, '2020-02-07 19:37:10', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (159, 3, '2020-02-07 19:37:14', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (160, 3, '2020-02-07 19:37:25', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (161, 3, '2020-02-07 19:45:41', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (162, 3, '2020-02-07 19:47:45', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (163, 3, '2020-02-07 20:02:25', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (164, 6, '2020-02-07 20:10:55', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (165, 6, '2020-02-07 20:11:02', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (166, 6, '2020-02-07 20:13:44', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (167, 6, '2020-02-07 20:17:14', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (168, 3, '2020-02-07 20:17:44', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (169, 6, '2020-02-07 20:18:13', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (170, 3, '2020-02-10 10:28:14', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (171, 3, '2020-02-10 10:45:15', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (172, 3, '2020-02-10 10:57:46', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (173, 3, '2020-02-10 10:59:06', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (174, 3, '2020-02-10 11:04:19', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (175, 3, '2020-02-10 11:05:55', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (176, 3, '2020-02-10 11:06:45', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (177, 3, '2020-02-10 11:07:41', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (178, 3, '2020-02-10 11:08:13', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (179, 3, '2020-02-10 11:10:02', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (180, 6, '2020-02-10 14:25:17', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (181, 6, '2020-02-10 14:29:14', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (182, 3, '2020-02-10 16:09:16', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (183, 3, '2020-02-20 14:39:19', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (184, 8, '2020-02-20 17:14:58', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (185, 8, '2020-02-20 17:17:04', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (186, 8, '2020-02-20 17:17:42', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (187, 8, '2020-02-21 10:26:56', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (188, 8, '2020-02-21 10:28:54', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (189, 8, '2020-02-21 10:32:25', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (190, 8, '2020-02-21 10:33:41', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (191, 8, '2020-02-21 10:35:58', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (192, 8, '2020-02-21 10:36:49', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (193, 3, '2020-02-21 11:10:11', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (194, 3, '2020-02-25 16:11:13', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (195, 3, '2020-02-25 16:46:29', '0:0:0:0:0:0:0:1', NULL, NULL);
INSERT INTO `ums_admin_login_log` VALUES (196, 8, '2021-08-25 18:10:44', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (197, 8, '2021-08-25 18:21:32', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (198, 8, '2021-08-25 18:24:10', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (199, 8, '2021-08-26 16:12:33', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (200, 8, '2021-08-26 16:14:16', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (201, 8, '2021-08-27 16:01:45', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (202, 8, '2021-08-27 16:05:05', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (203, 8, '2021-08-27 16:35:34', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (204, 8, '2021-08-27 16:55:50', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (205, 8, '2021-08-27 16:58:09', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (206, 8, '2021-08-30 09:52:51', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (207, 8, '2021-08-30 09:53:42', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (208, 8, '2021-08-30 09:59:44', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (209, 8, '2021-08-30 10:09:04', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (210, 8, '2021-08-30 10:18:28', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (211, 1, '2021-08-30 10:24:31', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (212, 1, '2021-08-30 10:26:10', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (213, 8, '2021-08-30 10:28:17', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (214, 8, '2021-08-30 10:37:42', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (215, 8, '2021-08-30 11:17:47', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (216, 8, '2021-08-30 14:26:20', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (217, 1, '2021-08-30 14:28:38', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (218, 8, '2021-08-30 20:48:50', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (219, 8, '2021-08-31 08:59:46', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (220, 8, '2021-08-31 19:22:53', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (221, 8, '2021-09-01 14:01:09', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (222, 8, '2021-09-01 16:27:49', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (223, 8, '2021-09-01 20:18:50', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (224, 8, '2021-09-01 21:08:00', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (225, 8, '2021-09-02 10:53:11', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (226, 8, '2021-09-02 19:31:47', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (227, 8, '2021-09-02 19:35:39', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (228, 8, '2021-09-02 19:36:12', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (229, 8, '2021-09-02 20:47:10', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (230, 8, '2021-09-03 09:37:15', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (231, 8, '2021-09-03 09:44:41', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (232, 8, '2021-09-03 09:47:04', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (233, 8, '2021-09-03 09:48:36', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (234, 8, '2021-09-03 10:01:40', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (235, 8, '2021-09-03 10:02:28', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (236, 8, '2021-09-03 10:04:47', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (237, 8, '2021-09-03 10:04:51', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (238, 8, '2021-09-03 10:06:14', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (239, 8, '2021-09-03 10:07:05', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (240, 8, '2021-09-03 10:07:51', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (241, 8, '2021-09-03 10:08:30', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (242, 8, '2021-09-03 10:09:20', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (243, 8, '2021-09-03 10:09:45', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (244, 8, '2021-09-03 10:10:04', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (245, 8, '2021-09-03 10:10:29', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (246, 8, '2021-09-03 10:14:00', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (247, 8, '2021-09-03 10:23:54', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (248, 8, '2021-09-03 10:24:41', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (249, 8, '2021-09-03 10:25:39', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (250, 8, '2021-09-03 10:26:34', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (251, 8, '2021-09-03 10:26:52', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (252, 8, '2021-09-03 10:27:53', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (253, 8, '2021-09-03 10:28:11', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (254, 8, '2021-09-03 10:29:34', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (255, 8, '2021-09-03 10:30:30', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (256, 8, '2021-09-03 10:31:27', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (257, 8, '2021-09-03 10:32:00', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (258, 8, '2021-09-03 10:32:46', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (259, 8, '2021-09-03 10:33:15', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (260, 8, '2021-09-03 10:34:06', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (261, 8, '2021-09-03 10:34:28', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (262, 8, '2021-09-03 11:25:34', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (263, 8, '2021-09-03 15:36:15', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (264, 8, '2021-09-03 15:37:31', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (265, 8, '2021-09-03 19:38:05', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (266, 8, '2021-09-06 08:46:27', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (267, 8, '2021-09-06 14:03:05', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (268, 8, '2021-09-06 19:10:44', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (269, 8, '2021-09-06 19:12:05', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (270, 8, '2021-09-06 19:14:16', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (271, 8, '2021-09-06 19:17:24', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (272, 8, '2021-09-06 19:25:32', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (273, 8, '2021-09-06 19:28:11', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (274, 8, '2021-09-06 19:29:46', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (275, 8, '2021-09-06 19:32:07', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (276, 8, '2021-09-06 19:36:20', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (277, 8, '2021-09-06 19:38:28', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (278, 8, '2021-09-06 19:40:41', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (279, 8, '2021-09-06 19:42:18', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (280, 8, '2021-09-06 19:43:42', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (281, 8, '2021-09-06 19:45:04', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (282, 8, '2021-09-06 19:47:31', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (283, 8, '2021-09-06 19:49:00', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (284, 8, '2021-09-06 19:50:03', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (285, 8, '2021-09-06 19:51:41', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (286, 8, '2021-09-08 09:24:54', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (287, 8, '2021-09-08 09:33:22', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (288, 8, '2021-09-08 09:34:37', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (289, 8, '2021-09-08 09:36:54', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (290, 8, '2021-09-08 09:37:41', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (291, 8, '2021-09-08 09:40:30', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (292, 8, '2021-09-08 09:42:18', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (293, 8, '2021-09-08 09:43:07', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (294, 8, '2021-09-08 09:48:29', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (295, 8, '2021-09-08 09:52:33', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (296, 1, '2021-09-08 09:52:44', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (297, 6, '2021-09-08 09:53:14', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (298, 8, '2021-09-08 09:53:27', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (299, 7, '2021-09-08 09:53:33', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (300, 3, '2021-09-08 09:53:52', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (301, 7, '2021-09-08 11:13:22', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (302, 8, '2021-09-08 11:13:39', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (303, 8, '2021-09-10 22:12:48', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (304, 8, '2021-09-12 20:15:56', '127.0.0.1', NULL, 'Chrome 9');

-- ----------------------------
-- Table structure for ums_admin_permission_relation
-- ----------------------------
DROP TABLE IF EXISTS `ums_admin_permission_relation`;
CREATE TABLE `ums_admin_permission_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(20) NULL DEFAULT NULL,
  `permission_id` bigint(20) NULL DEFAULT NULL,
  `type` int(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户和权限关系表(除角色中定义的权限以外的加减权限)' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_admin_permission_relation
-- ----------------------------

-- ----------------------------
-- Table structure for ums_admin_role_relation
-- ----------------------------
DROP TABLE IF EXISTS `ums_admin_role_relation`;
CREATE TABLE `ums_admin_role_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(20) NULL DEFAULT NULL,
  `role_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户和角色关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_admin_role_relation
-- ----------------------------
INSERT INTO `ums_admin_role_relation` VALUES (26, 3, 5);
INSERT INTO `ums_admin_role_relation` VALUES (27, 6, 1);
INSERT INTO `ums_admin_role_relation` VALUES (28, 7, 2);
INSERT INTO `ums_admin_role_relation` VALUES (29, 1, 2);
INSERT INTO `ums_admin_role_relation` VALUES (30, 4, 5);
INSERT INTO `ums_admin_role_relation` VALUES (31, 8, 5);
INSERT INTO `ums_admin_role_relation` VALUES (33, 9, 1);

-- ----------------------------
-- Table structure for ums_growth_change_history
-- ----------------------------
DROP TABLE IF EXISTS `ums_growth_change_history`;
CREATE TABLE `ums_growth_change_history`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `change_type` int(1) NULL DEFAULT NULL COMMENT '改变类型：0->增加；1->减少',
  `change_count` int(11) NULL DEFAULT NULL COMMENT '积分改变数量',
  `operate_man` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人员',
  `operate_note` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作备注',
  `source_type` int(1) NULL DEFAULT NULL COMMENT '积分来源：0->购物；1->管理员修改',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '成长值变化历史记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_growth_change_history
-- ----------------------------
INSERT INTO `ums_growth_change_history` VALUES (1, 1, '2018-08-29 17:16:35', 0, 1000, 'test', '测试使用', 1);

-- ----------------------------
-- Table structure for ums_integration_change_history
-- ----------------------------
DROP TABLE IF EXISTS `ums_integration_change_history`;
CREATE TABLE `ums_integration_change_history`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `change_type` int(1) NULL DEFAULT NULL COMMENT '改变类型：0->增加；1->减少',
  `change_count` int(11) NULL DEFAULT NULL COMMENT '积分改变数量',
  `operate_man` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人员',
  `operate_note` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作备注',
  `source_type` int(1) NULL DEFAULT NULL COMMENT '积分来源：0->购物；1->管理员修改',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '积分变化历史记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_integration_change_history
-- ----------------------------

-- ----------------------------
-- Table structure for ums_integration_consume_setting
-- ----------------------------
DROP TABLE IF EXISTS `ums_integration_consume_setting`;
CREATE TABLE `ums_integration_consume_setting`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deduction_per_amount` int(11) NULL DEFAULT NULL COMMENT '每一元需要抵扣的积分数量',
  `max_percent_per_order` int(11) NULL DEFAULT NULL COMMENT '每笔订单最高抵用百分比',
  `use_unit` int(11) NULL DEFAULT NULL COMMENT '每次使用积分最小单位100',
  `coupon_status` int(1) NULL DEFAULT NULL COMMENT '是否可以和优惠券同用；0->不可以；1->可以',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '积分消费设置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_integration_consume_setting
-- ----------------------------
INSERT INTO `ums_integration_consume_setting` VALUES (1, 100, 50, 100, 1);

-- ----------------------------
-- Table structure for ums_member
-- ----------------------------
DROP TABLE IF EXISTS `ums_member`;
CREATE TABLE `ums_member`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_level_id` bigint(20) NULL DEFAULT NULL,
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `nickname` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `phone` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `status` int(1) NULL DEFAULT NULL COMMENT '帐号启用状态:0->禁用；1->启用',
  `create_time` datetime NULL DEFAULT NULL COMMENT '注册时间',
  `icon` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `gender` int(1) NULL DEFAULT NULL COMMENT '性别：0->未知；1->男；2->女',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `city` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所做城市',
  `job` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职业',
  `personalized_signature` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个性签名',
  `source_type` int(1) NULL DEFAULT NULL COMMENT '用户来源',
  `integration` int(11) NULL DEFAULT NULL COMMENT '积分',
  `growth` int(11) NULL DEFAULT NULL COMMENT '成长值',
  `luckey_count` int(11) NULL DEFAULT NULL COMMENT '剩余抽奖次数',
  `history_integration` int(11) NULL DEFAULT NULL COMMENT '历史积分数量',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_username`(`username`) USING BTREE,
  UNIQUE INDEX `idx_phone`(`phone`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_member
-- ----------------------------
INSERT INTO `ums_member` VALUES (1, 4, 'test', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG', 'windir', '18061581849', 1, '2018-08-02 10:35:44', NULL, 1, '2009-06-01', '上海', '学生', 'test', NULL, 5000, NULL, NULL, NULL);
INSERT INTO `ums_member` VALUES (3, 4, 'windy', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG', 'windy', '18061581848', 1, '2018-08-03 16:46:38', NULL, NULL, NULL, NULL, NULL, 'test', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ums_member` VALUES (4, 4, 'zhengsan', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG', 'zhengsan', '18061581847', 1, '2018-11-12 14:12:04', NULL, NULL, NULL, NULL, NULL, 'test', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ums_member` VALUES (5, 4, 'lisi', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG', 'lisi', '18061581841', 1, '2018-11-12 14:12:38', NULL, NULL, NULL, NULL, NULL, 'test', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ums_member` VALUES (6, 4, 'wangwu', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG', 'wangwu', '18061581842', 1, '2018-11-12 14:13:09', NULL, NULL, NULL, NULL, NULL, 'test', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ums_member` VALUES (7, 4, 'lion', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG', 'lion', '18061581845', 1, '2018-11-12 14:21:39', NULL, NULL, NULL, NULL, NULL, 'test', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ums_member` VALUES (8, 4, 'shari', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG', 'shari', '18061581844', 1, '2018-11-12 14:22:00', NULL, NULL, NULL, NULL, NULL, 'test', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ums_member` VALUES (9, 4, 'aewen', '$2a$10$NZ5o7r2E.ayT2ZoxgjlI.eJ6OEYqjH7INR/F.mXDbjZJi9HF0YCVG', 'aewen', '18061581843', 1, '2018-11-12 14:22:55', NULL, NULL, NULL, NULL, NULL, 'test', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `ums_member` VALUES (10, 4, 'lucien', 'd941cf1382c4ddb8c1b11620cd5d6279', 'lucien_ssa', '13556787083', 1, '2021-08-31 15:02:01', 'https://tse1-mm.cn.bing.net/th/id/OIP-C.yRIXnUfY40-4ViK0NygIkgAAAA?pid=ImgDet&rs=1', NULL, NULL, NULL, NULL, 'test', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for ums_member_level
-- ----------------------------
DROP TABLE IF EXISTS `ums_member_level`;
CREATE TABLE `ums_member_level`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `growth_point` int(11) NULL DEFAULT NULL,
  `default_status` int(1) NULL DEFAULT NULL COMMENT '是否为默认等级：0->不是；1->是',
  `free_freight_point` decimal(10, 2) NULL DEFAULT NULL COMMENT '免运费标准',
  `comment_growth_point` int(11) NULL DEFAULT NULL COMMENT '每次评价获取的成长值',
  `priviledge_free_freight` int(1) NULL DEFAULT NULL COMMENT '是否有免邮特权',
  `priviledge_sign_in` int(1) NULL DEFAULT NULL COMMENT '是否有签到特权',
  `priviledge_comment` int(1) NULL DEFAULT NULL COMMENT '是否有评论获奖励特权',
  `priviledge_promotion` int(1) NULL DEFAULT NULL COMMENT '是否有专享活动特权',
  `priviledge_member_price` int(1) NULL DEFAULT NULL COMMENT '是否有会员价格特权',
  `priviledge_birthday` int(1) NULL DEFAULT NULL COMMENT '是否有生日特权',
  `note` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员等级表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_member_level
-- ----------------------------
INSERT INTO `ums_member_level` VALUES (1, '黄金会员', 1000, 0, 199.00, 5, 1, 1, 1, 1, 1, 1, NULL);
INSERT INTO `ums_member_level` VALUES (2, '白金会员', 5000, 0, 99.00, 10, 1, 1, 1, 1, 1, 1, NULL);
INSERT INTO `ums_member_level` VALUES (3, '钻石会员', 15000, 0, 69.00, 15, 1, 1, 1, 1, 1, 1, NULL);
INSERT INTO `ums_member_level` VALUES (4, '普通会员', 1, 1, 199.00, 20, 1, 1, 1, 1, 0, 0, NULL);

-- ----------------------------
-- Table structure for ums_member_login_log
-- ----------------------------
DROP TABLE IF EXISTS `ums_member_login_log`;
CREATE TABLE `ums_member_login_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `login_type` int(1) NULL DEFAULT NULL COMMENT '登录类型：0->PC；1->android;2->ios;3->小程序',
  `province` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员登录记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_member_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for ums_member_member_tag_relation
-- ----------------------------
DROP TABLE IF EXISTS `ums_member_member_tag_relation`;
CREATE TABLE `ums_member_member_tag_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `tag_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和标签关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_member_member_tag_relation
-- ----------------------------

-- ----------------------------
-- Table structure for ums_member_product_category_relation
-- ----------------------------
DROP TABLE IF EXISTS `ums_member_product_category_relation`;
CREATE TABLE `ums_member_product_category_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `product_category_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员与产品分类关系表（用户喜欢的分类）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_member_product_category_relation
-- ----------------------------

-- ----------------------------
-- Table structure for ums_member_receive_address
-- ----------------------------
DROP TABLE IF EXISTS `ums_member_receive_address`;
CREATE TABLE `ums_member_receive_address`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人名称',
  `phone_number` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `default_status` int(1) NULL DEFAULT NULL COMMENT '是否为默认',
  `post_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮政编码',
  `province` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '省份/直辖市',
  `city` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '城市',
  `region` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区',
  `detail_address` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址(街道)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员收货地址表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_member_receive_address
-- ----------------------------
INSERT INTO `ums_member_receive_address` VALUES (1, 1, '大梨', '18033441849', 0, '518000', '广东省', '深圳市', '南山区', '科兴科学园');
INSERT INTO `ums_member_receive_address` VALUES (3, 1, '大梨', '18033441849', 0, '518000', '广东省', '深圳市', '福田区', '清水河街道');
INSERT INTO `ums_member_receive_address` VALUES (4, 1, '大梨', '18033441849', 1, '518000', '广东省', '深圳市', '福田区', '东晓街道');
INSERT INTO `ums_member_receive_address` VALUES (5, 10, 'cxyxxx', '13556787083', 1, '441927', '广东省', '东莞市', '常平镇', '紫荆花园晓辉道51B');
INSERT INTO `ums_member_receive_address` VALUES (7, 10, '陈少111', '13556787083', 0, '440104', '广东省', '广州市', '越秀区', '越秀一路');
INSERT INTO `ums_member_receive_address` VALUES (8, 10, '测试', '13556787083', 0, '110101', '北京市', '北京市', '东城区', '测试');

-- ----------------------------
-- Table structure for ums_member_rule_setting
-- ----------------------------
DROP TABLE IF EXISTS `ums_member_rule_setting`;
CREATE TABLE `ums_member_rule_setting`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `continue_sign_day` int(11) NULL DEFAULT NULL COMMENT '连续签到天数',
  `continue_sign_point` int(11) NULL DEFAULT NULL COMMENT '连续签到赠送数量',
  `consume_per_point` decimal(10, 2) NULL DEFAULT NULL COMMENT '每消费多少元获取1个点',
  `low_order_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '最低获取点数的订单金额',
  `max_point_per_order` int(11) NULL DEFAULT NULL COMMENT '每笔订单最高获取点数',
  `type` int(1) NULL DEFAULT NULL COMMENT '类型：0->积分规则；1->成长值规则',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员积分成长规则表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_member_rule_setting
-- ----------------------------

-- ----------------------------
-- Table structure for ums_member_statistics_info
-- ----------------------------
DROP TABLE IF EXISTS `ums_member_statistics_info`;
CREATE TABLE `ums_member_statistics_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) NULL DEFAULT NULL,
  `consume_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '累计消费金额',
  `order_count` int(11) NULL DEFAULT NULL COMMENT '订单数量',
  `coupon_count` int(11) NULL DEFAULT NULL COMMENT '优惠券数量',
  `comment_count` int(11) NULL DEFAULT NULL COMMENT '评价数',
  `return_order_count` int(11) NULL DEFAULT NULL COMMENT '退货数量',
  `login_count` int(11) NULL DEFAULT NULL COMMENT '登录次数',
  `attend_count` int(11) NULL DEFAULT NULL COMMENT '关注数量',
  `fans_count` int(11) NULL DEFAULT NULL COMMENT '粉丝数量',
  `collect_product_count` int(11) NULL DEFAULT NULL,
  `collect_subject_count` int(11) NULL DEFAULT NULL,
  `collect_topic_count` int(11) NULL DEFAULT NULL,
  `collect_comment_count` int(11) NULL DEFAULT NULL,
  `invite_friend_count` int(11) NULL DEFAULT NULL,
  `recent_order_time` datetime NULL DEFAULT NULL COMMENT '最后一次下订单时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员统计信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_member_statistics_info
-- ----------------------------

-- ----------------------------
-- Table structure for ums_member_tag
-- ----------------------------
DROP TABLE IF EXISTS `ums_member_tag`;
CREATE TABLE `ums_member_tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `finish_order_count` int(11) NULL DEFAULT NULL COMMENT '自动打标签完成订单数量',
  `finish_order_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '自动打标签完成订单金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户标签表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_member_tag
-- ----------------------------

-- ----------------------------
-- Table structure for ums_member_task
-- ----------------------------
DROP TABLE IF EXISTS `ums_member_task`;
CREATE TABLE `ums_member_task`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `growth` int(11) NULL DEFAULT NULL COMMENT '赠送成长值',
  `intergration` int(11) NULL DEFAULT NULL COMMENT '赠送积分',
  `type` int(1) NULL DEFAULT NULL COMMENT '任务类型：0->新手任务；1->日常任务',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '会员任务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_member_task
-- ----------------------------

-- ----------------------------
-- Table structure for ums_menu
-- ----------------------------
DROP TABLE IF EXISTS `ums_menu`;
CREATE TABLE `ums_menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父级ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `level` int(4) NULL DEFAULT NULL COMMENT '菜单级数',
  `sort` int(4) NULL DEFAULT NULL COMMENT '菜单排序',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端名称',
  `icon` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端图标',
  `hidden` int(1) NULL DEFAULT NULL COMMENT '前端隐藏',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_menu
-- ----------------------------
INSERT INTO `ums_menu` VALUES (1, 0, '2020-02-02 14:50:36', '商品', 0, 0, 'pms', 'product', 0);
INSERT INTO `ums_menu` VALUES (2, 1, '2020-02-02 14:51:50', '商品列表', 1, 0, 'product', 'product-list', 0);
INSERT INTO `ums_menu` VALUES (3, 1, '2020-02-02 14:52:44', '添加商品', 1, 0, 'addProduct', 'product-add', 0);
INSERT INTO `ums_menu` VALUES (4, 1, '2020-02-02 14:53:51', '商品分类', 1, 0, 'productCate', 'product-cate', 0);
INSERT INTO `ums_menu` VALUES (5, 1, '2020-02-02 14:54:51', '商品类型', 1, 0, 'productAttr', 'product-attr', 0);
INSERT INTO `ums_menu` VALUES (6, 1, '2020-02-02 14:56:29', '品牌管理', 1, 0, 'brand', 'product-brand', 0);
INSERT INTO `ums_menu` VALUES (7, 0, '2020-02-02 16:54:07', '订单', 0, 0, 'oms', 'order', 0);
INSERT INTO `ums_menu` VALUES (8, 7, '2020-02-02 16:55:18', '订单列表', 1, 0, 'order', 'product-list', 0);
INSERT INTO `ums_menu` VALUES (9, 7, '2020-02-02 16:56:46', '订单设置', 1, 0, 'orderSetting', 'order-setting', 0);
INSERT INTO `ums_menu` VALUES (10, 7, '2020-02-02 16:57:39', '退货申请处理', 1, 0, 'returnApply', 'order-return', 0);
INSERT INTO `ums_menu` VALUES (11, 7, '2020-02-02 16:59:40', '退货原因设置', 1, 0, 'returnReason', 'order-return-reason', 0);
INSERT INTO `ums_menu` VALUES (12, 0, '2020-02-04 16:18:00', '营销', 0, 0, 'sms', 'sms', 0);
INSERT INTO `ums_menu` VALUES (13, 12, '2020-02-04 16:19:22', '秒杀活动列表', 1, 0, 'flash', 'sms-flash', 0);
INSERT INTO `ums_menu` VALUES (14, 12, '2020-02-04 16:20:16', '优惠券列表', 1, 0, 'coupon', 'sms-coupon', 0);
INSERT INTO `ums_menu` VALUES (16, 12, '2020-02-07 16:22:38', '品牌推荐', 1, 0, 'homeBrand', 'product-brand', 0);
INSERT INTO `ums_menu` VALUES (17, 12, '2020-02-07 16:23:14', '新品推荐', 1, 0, 'homeNew', 'sms-new', 0);
INSERT INTO `ums_menu` VALUES (18, 12, '2020-02-07 16:26:38', '人气推荐', 1, 0, 'homeHot', 'sms-hot', 0);
INSERT INTO `ums_menu` VALUES (19, 12, '2020-02-07 16:28:16', '专题推荐', 1, 0, 'homeSubject', 'sms-subject', 0);
INSERT INTO `ums_menu` VALUES (20, 12, '2020-02-07 16:28:42', '广告列表', 1, 0, 'homeAdvertise', 'sms-ad', 0);
INSERT INTO `ums_menu` VALUES (21, 0, '2020-02-07 16:29:13', '权限', 0, 0, 'ums', 'ums', 0);
INSERT INTO `ums_menu` VALUES (22, 21, '2020-02-07 16:29:51', '用户列表', 1, 0, 'admin', 'ums-admin', 0);
INSERT INTO `ums_menu` VALUES (23, 21, '2020-02-07 16:30:13', '角色列表', 1, 0, 'role', 'ums-role', 0);
INSERT INTO `ums_menu` VALUES (24, 21, '2020-02-07 16:30:53', '菜单列表', 1, 0, 'menu', 'ums-menu', 0);
INSERT INTO `ums_menu` VALUES (25, 21, '2020-02-07 16:31:13', '资源列表', 1, 0, 'resource', 'ums-resource', 0);

-- ----------------------------
-- Table structure for ums_permission
-- ----------------------------
DROP TABLE IF EXISTS `ums_permission`;
CREATE TABLE `ums_permission`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) NULL DEFAULT NULL COMMENT '父级权限id',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `value` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限值',
  `icon` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `type` int(1) NULL DEFAULT NULL COMMENT '权限类型：0->目录；1->菜单；2->按钮（接口绑定权限）',
  `uri` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端资源路径',
  `status` int(1) NULL DEFAULT NULL COMMENT '启用状态；0->禁用；1->启用',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_permission
-- ----------------------------
INSERT INTO `ums_permission` VALUES (1, 0, '商品', NULL, NULL, 0, NULL, 1, '2018-09-29 16:15:14', 0);
INSERT INTO `ums_permission` VALUES (2, 1, '商品列表', 'pms:product:read', NULL, 1, '/pms/product/index', 1, '2018-09-29 16:17:01', 0);
INSERT INTO `ums_permission` VALUES (3, 1, '添加商品', 'pms:product:create', NULL, 1, '/pms/product/add', 1, '2018-09-29 16:18:51', 0);
INSERT INTO `ums_permission` VALUES (4, 1, '商品分类', 'pms:productCategory:read', NULL, 1, '/pms/productCate/index', 1, '2018-09-29 16:23:07', 0);
INSERT INTO `ums_permission` VALUES (5, 1, '商品类型', 'pms:productAttribute:read', NULL, 1, '/pms/productAttr/index', 1, '2018-09-29 16:24:43', 0);
INSERT INTO `ums_permission` VALUES (6, 1, '品牌管理', 'pms:brand:read', NULL, 1, '/pms/brand/index', 1, '2018-09-29 16:25:45', 0);
INSERT INTO `ums_permission` VALUES (7, 2, '编辑商品', 'pms:product:update', NULL, 2, '/pms/product/updateProduct', 1, '2018-09-29 16:34:23', 0);
INSERT INTO `ums_permission` VALUES (8, 2, '删除商品', 'pms:product:delete', NULL, 2, '/pms/product/delete', 1, '2018-09-29 16:38:33', 0);
INSERT INTO `ums_permission` VALUES (9, 4, '添加商品分类', 'pms:productCategory:create', NULL, 2, '/pms/productCate/create', 1, '2018-09-29 16:43:23', 0);
INSERT INTO `ums_permission` VALUES (10, 4, '修改商品分类', 'pms:productCategory:update', NULL, 2, '/pms/productCate/update', 1, '2018-09-29 16:43:55', 0);
INSERT INTO `ums_permission` VALUES (11, 4, '删除商品分类', 'pms:productCategory:delete', NULL, 2, '/pms/productAttr/delete', 1, '2018-09-29 16:44:38', 0);
INSERT INTO `ums_permission` VALUES (12, 5, '添加商品类型', 'pms:productAttribute:create', NULL, 2, '/pms/productAttr/create', 1, '2018-09-29 16:45:25', 0);
INSERT INTO `ums_permission` VALUES (13, 5, '修改商品类型', 'pms:productAttribute:update', NULL, 2, '/pms/productAttr/update', 1, '2018-09-29 16:48:08', 0);
INSERT INTO `ums_permission` VALUES (14, 5, '删除商品类型', 'pms:productAttribute:delete', NULL, 2, '/pms/productAttr/delete', 1, '2018-09-29 16:48:44', 0);
INSERT INTO `ums_permission` VALUES (15, 6, '添加品牌', 'pms:brand:create', NULL, 2, '/pms/brand/add', 1, '2018-09-29 16:49:34', 0);
INSERT INTO `ums_permission` VALUES (16, 6, '修改品牌', 'pms:brand:update', NULL, 2, '/pms/brand/update', 1, '2018-09-29 16:50:55', 0);
INSERT INTO `ums_permission` VALUES (17, 6, '删除品牌', 'pms:brand:delete', NULL, 2, '/pms/brand/delete', 1, '2018-09-29 16:50:59', 0);
INSERT INTO `ums_permission` VALUES (18, 0, '首页', NULL, NULL, 0, NULL, 1, '2018-09-29 16:51:57', 0);

-- ----------------------------
-- Table structure for ums_resource
-- ----------------------------
DROP TABLE IF EXISTS `ums_resource`;
CREATE TABLE `ums_resource`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源名称',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源URL',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `category_id` bigint(20) NULL DEFAULT NULL COMMENT '资源分类ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台资源表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_resource
-- ----------------------------
INSERT INTO `ums_resource` VALUES (1, '2020-02-04 17:04:55', '商品品牌管理', '/brand/**', NULL, 1);
INSERT INTO `ums_resource` VALUES (2, '2020-02-04 17:05:35', '商品属性分类管理', '/productAttribute/**', NULL, 1);
INSERT INTO `ums_resource` VALUES (3, '2020-02-04 17:06:13', '商品属性管理', '/productAttribute/**', NULL, 1);
INSERT INTO `ums_resource` VALUES (4, '2020-02-04 17:07:15', '商品分类管理', '/productCategory/**', NULL, 1);
INSERT INTO `ums_resource` VALUES (5, '2020-02-04 17:09:16', '商品管理', '/product/**', NULL, 1);
INSERT INTO `ums_resource` VALUES (6, '2020-02-04 17:09:53', '商品库存管理', '/sku/**', NULL, 1);
INSERT INTO `ums_resource` VALUES (8, '2020-02-05 14:43:37', '订单管理', '/order/**', '', 2);
INSERT INTO `ums_resource` VALUES (9, '2020-02-05 14:44:22', ' 订单退货申请管理', '/returnApply/**', '', 2);
INSERT INTO `ums_resource` VALUES (10, '2020-02-05 14:45:08', '退货原因管理', '/returnReason/**', '', 2);
INSERT INTO `ums_resource` VALUES (11, '2020-02-05 14:45:43', '订单设置管理', '/orderSetting/**', '', 2);
INSERT INTO `ums_resource` VALUES (12, '2020-02-05 14:46:23', '收货地址管理', '/companyAddress/**', '', 2);
INSERT INTO `ums_resource` VALUES (13, '2020-02-07 16:37:22', '优惠券管理', '/coupon/**', '', 3);
INSERT INTO `ums_resource` VALUES (14, '2020-02-07 16:37:59', '优惠券领取记录管理', '/couponHistory/**', '', 3);
INSERT INTO `ums_resource` VALUES (15, '2020-02-07 16:38:28', '限时购活动管理', '/flash/**', '', 3);
INSERT INTO `ums_resource` VALUES (16, '2020-02-07 16:38:59', '限时购商品关系管理', '/flashProductRelation/**', '', 3);
INSERT INTO `ums_resource` VALUES (17, '2020-02-07 16:39:22', '限时购场次管理', '/flashSession/**', '', 3);
INSERT INTO `ums_resource` VALUES (18, '2020-02-07 16:40:07', '首页轮播广告管理', '/home/advertise/**', '', 3);
INSERT INTO `ums_resource` VALUES (19, '2020-02-07 16:40:34', '首页品牌管理', '/home/brand/**', '', 3);
INSERT INTO `ums_resource` VALUES (20, '2020-02-07 16:41:06', '首页新品管理', '/home/newProduct/**', '', 3);
INSERT INTO `ums_resource` VALUES (21, '2020-02-07 16:42:16', '首页人气推荐管理', '/home/recommendProduct/**', '', 3);
INSERT INTO `ums_resource` VALUES (22, '2020-02-07 16:42:48', '首页专题推荐管理', '/home/recommendSubject/**', '', 3);
INSERT INTO `ums_resource` VALUES (23, '2020-02-07 16:44:56', ' 商品优选管理', '/prefrenceArea/**', '', 5);
INSERT INTO `ums_resource` VALUES (24, '2020-02-07 16:45:39', '商品专题管理', '/subject/**', '', 5);
INSERT INTO `ums_resource` VALUES (25, '2020-02-07 16:47:34', '后台用户管理', '/admin/**', '', 4);
INSERT INTO `ums_resource` VALUES (26, '2020-02-07 16:48:24', '后台用户角色管理', '/role/**', '', 4);
INSERT INTO `ums_resource` VALUES (27, '2020-02-07 16:48:48', '后台菜单管理', '/menu/**', '', 4);
INSERT INTO `ums_resource` VALUES (28, '2020-02-07 16:49:18', '后台资源分类管理', '/resourceCategory/**', '', 4);
INSERT INTO `ums_resource` VALUES (29, '2020-02-07 16:49:45', '后台资源管理', '/resource/**', '', 4);

-- ----------------------------
-- Table structure for ums_resource_category
-- ----------------------------
DROP TABLE IF EXISTS `ums_resource_category`;
CREATE TABLE `ums_resource_category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  `sort` int(4) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资源分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_resource_category
-- ----------------------------
INSERT INTO `ums_resource_category` VALUES (1, '2020-02-05 10:21:44', '商品模块', 0);
INSERT INTO `ums_resource_category` VALUES (2, '2020-02-05 10:22:34', '订单模块', 0);
INSERT INTO `ums_resource_category` VALUES (3, '2020-02-05 10:22:48', '营销模块', 0);
INSERT INTO `ums_resource_category` VALUES (4, '2020-02-05 10:23:04', '权限模块', 0);
INSERT INTO `ums_resource_category` VALUES (5, '2020-02-07 16:34:27', '内容模块', 0);
INSERT INTO `ums_resource_category` VALUES (6, '2020-02-07 16:35:49', '其他模块', 0);

-- ----------------------------
-- Table structure for ums_role
-- ----------------------------
DROP TABLE IF EXISTS `ums_role`;
CREATE TABLE `ums_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `admin_count` int(11) NULL DEFAULT NULL COMMENT '后台用户数量',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `status` int(1) NULL DEFAULT 1 COMMENT '启用状态：0->禁用；1->启用',
  `sort` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_role
-- ----------------------------
INSERT INTO `ums_role` VALUES (1, '商品管理员', '只能查看及操作商品', 0, '2020-02-03 16:50:37', 1, 0);
INSERT INTO `ums_role` VALUES (2, '订单管理员', '只能查看及操作订单', 0, '2018-09-30 15:53:45', 1, 0);
INSERT INTO `ums_role` VALUES (5, '超级管理员', '拥有所有查看和操作功能', 0, '2020-02-02 15:11:05', 1, 0);

-- ----------------------------
-- Table structure for ums_role_menu_relation
-- ----------------------------
DROP TABLE IF EXISTS `ums_role_menu_relation`;
CREATE TABLE `ums_role_menu_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NULL DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 120 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台角色菜单关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_role_menu_relation
-- ----------------------------
INSERT INTO `ums_role_menu_relation` VALUES (33, 1, 1);
INSERT INTO `ums_role_menu_relation` VALUES (34, 1, 2);
INSERT INTO `ums_role_menu_relation` VALUES (35, 1, 3);
INSERT INTO `ums_role_menu_relation` VALUES (36, 1, 4);
INSERT INTO `ums_role_menu_relation` VALUES (37, 1, 5);
INSERT INTO `ums_role_menu_relation` VALUES (38, 1, 6);
INSERT INTO `ums_role_menu_relation` VALUES (53, 2, 7);
INSERT INTO `ums_role_menu_relation` VALUES (54, 2, 8);
INSERT INTO `ums_role_menu_relation` VALUES (55, 2, 9);
INSERT INTO `ums_role_menu_relation` VALUES (56, 2, 10);
INSERT INTO `ums_role_menu_relation` VALUES (57, 2, 11);
INSERT INTO `ums_role_menu_relation` VALUES (96, 5, 1);
INSERT INTO `ums_role_menu_relation` VALUES (97, 5, 2);
INSERT INTO `ums_role_menu_relation` VALUES (98, 5, 3);
INSERT INTO `ums_role_menu_relation` VALUES (99, 5, 4);
INSERT INTO `ums_role_menu_relation` VALUES (100, 5, 5);
INSERT INTO `ums_role_menu_relation` VALUES (101, 5, 6);
INSERT INTO `ums_role_menu_relation` VALUES (102, 5, 7);
INSERT INTO `ums_role_menu_relation` VALUES (103, 5, 8);
INSERT INTO `ums_role_menu_relation` VALUES (104, 5, 9);
INSERT INTO `ums_role_menu_relation` VALUES (105, 5, 10);
INSERT INTO `ums_role_menu_relation` VALUES (106, 5, 11);
INSERT INTO `ums_role_menu_relation` VALUES (107, 5, 12);
INSERT INTO `ums_role_menu_relation` VALUES (108, 5, 13);
INSERT INTO `ums_role_menu_relation` VALUES (109, 5, 14);
INSERT INTO `ums_role_menu_relation` VALUES (110, 5, 16);
INSERT INTO `ums_role_menu_relation` VALUES (111, 5, 17);
INSERT INTO `ums_role_menu_relation` VALUES (112, 5, 18);
INSERT INTO `ums_role_menu_relation` VALUES (113, 5, 19);
INSERT INTO `ums_role_menu_relation` VALUES (114, 5, 20);
INSERT INTO `ums_role_menu_relation` VALUES (115, 5, 21);
INSERT INTO `ums_role_menu_relation` VALUES (116, 5, 22);
INSERT INTO `ums_role_menu_relation` VALUES (117, 5, 23);
INSERT INTO `ums_role_menu_relation` VALUES (118, 5, 24);
INSERT INTO `ums_role_menu_relation` VALUES (119, 5, 25);

-- ----------------------------
-- Table structure for ums_role_permission_relation
-- ----------------------------
DROP TABLE IF EXISTS `ums_role_permission_relation`;
CREATE TABLE `ums_role_permission_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NULL DEFAULT NULL,
  `permission_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户角色和权限关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_role_permission_relation
-- ----------------------------
INSERT INTO `ums_role_permission_relation` VALUES (1, 1, 1);
INSERT INTO `ums_role_permission_relation` VALUES (2, 1, 2);
INSERT INTO `ums_role_permission_relation` VALUES (3, 1, 3);
INSERT INTO `ums_role_permission_relation` VALUES (4, 1, 7);
INSERT INTO `ums_role_permission_relation` VALUES (5, 1, 8);
INSERT INTO `ums_role_permission_relation` VALUES (6, 2, 4);
INSERT INTO `ums_role_permission_relation` VALUES (7, 2, 9);
INSERT INTO `ums_role_permission_relation` VALUES (8, 2, 10);
INSERT INTO `ums_role_permission_relation` VALUES (9, 2, 11);
INSERT INTO `ums_role_permission_relation` VALUES (10, 3, 5);
INSERT INTO `ums_role_permission_relation` VALUES (11, 3, 12);
INSERT INTO `ums_role_permission_relation` VALUES (12, 3, 13);
INSERT INTO `ums_role_permission_relation` VALUES (13, 3, 14);
INSERT INTO `ums_role_permission_relation` VALUES (14, 4, 6);
INSERT INTO `ums_role_permission_relation` VALUES (15, 4, 15);
INSERT INTO `ums_role_permission_relation` VALUES (16, 4, 16);
INSERT INTO `ums_role_permission_relation` VALUES (17, 4, 17);

-- ----------------------------
-- Table structure for ums_role_resource_relation
-- ----------------------------
DROP TABLE IF EXISTS `ums_role_resource_relation`;
CREATE TABLE `ums_role_resource_relation`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  `resource_id` bigint(20) NULL DEFAULT NULL COMMENT '资源ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 206 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台角色资源关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_role_resource_relation
-- ----------------------------
INSERT INTO `ums_role_resource_relation` VALUES (103, 2, 8);
INSERT INTO `ums_role_resource_relation` VALUES (104, 2, 9);
INSERT INTO `ums_role_resource_relation` VALUES (105, 2, 10);
INSERT INTO `ums_role_resource_relation` VALUES (106, 2, 11);
INSERT INTO `ums_role_resource_relation` VALUES (107, 2, 12);
INSERT INTO `ums_role_resource_relation` VALUES (170, 1, 1);
INSERT INTO `ums_role_resource_relation` VALUES (171, 1, 2);
INSERT INTO `ums_role_resource_relation` VALUES (172, 1, 3);
INSERT INTO `ums_role_resource_relation` VALUES (173, 1, 4);
INSERT INTO `ums_role_resource_relation` VALUES (174, 1, 5);
INSERT INTO `ums_role_resource_relation` VALUES (175, 1, 6);
INSERT INTO `ums_role_resource_relation` VALUES (176, 1, 23);
INSERT INTO `ums_role_resource_relation` VALUES (177, 1, 24);
INSERT INTO `ums_role_resource_relation` VALUES (178, 5, 1);
INSERT INTO `ums_role_resource_relation` VALUES (179, 5, 2);
INSERT INTO `ums_role_resource_relation` VALUES (180, 5, 3);
INSERT INTO `ums_role_resource_relation` VALUES (181, 5, 4);
INSERT INTO `ums_role_resource_relation` VALUES (182, 5, 5);
INSERT INTO `ums_role_resource_relation` VALUES (183, 5, 6);
INSERT INTO `ums_role_resource_relation` VALUES (184, 5, 8);
INSERT INTO `ums_role_resource_relation` VALUES (185, 5, 9);
INSERT INTO `ums_role_resource_relation` VALUES (186, 5, 10);
INSERT INTO `ums_role_resource_relation` VALUES (187, 5, 11);
INSERT INTO `ums_role_resource_relation` VALUES (188, 5, 12);
INSERT INTO `ums_role_resource_relation` VALUES (189, 5, 13);
INSERT INTO `ums_role_resource_relation` VALUES (190, 5, 14);
INSERT INTO `ums_role_resource_relation` VALUES (191, 5, 15);
INSERT INTO `ums_role_resource_relation` VALUES (192, 5, 16);
INSERT INTO `ums_role_resource_relation` VALUES (193, 5, 17);
INSERT INTO `ums_role_resource_relation` VALUES (194, 5, 18);
INSERT INTO `ums_role_resource_relation` VALUES (195, 5, 19);
INSERT INTO `ums_role_resource_relation` VALUES (196, 5, 20);
INSERT INTO `ums_role_resource_relation` VALUES (197, 5, 21);
INSERT INTO `ums_role_resource_relation` VALUES (198, 5, 22);
INSERT INTO `ums_role_resource_relation` VALUES (199, 5, 23);
INSERT INTO `ums_role_resource_relation` VALUES (200, 5, 24);
INSERT INTO `ums_role_resource_relation` VALUES (201, 5, 25);
INSERT INTO `ums_role_resource_relation` VALUES (202, 5, 26);
INSERT INTO `ums_role_resource_relation` VALUES (203, 5, 27);
INSERT INTO `ums_role_resource_relation` VALUES (204, 5, 28);
INSERT INTO `ums_role_resource_relation` VALUES (205, 5, 29);

SET FOREIGN_KEY_CHECKS = 1;
