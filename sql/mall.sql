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

 Date: 29/10/2021 10:08:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '购物车表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_cart_item
-- ----------------------------
INSERT INTO `oms_cart_item` VALUES (1, 33, 33, 10, 1, 228.00, 'https://gd3.alicdn.com/imgextra/i3/3381629725/O1CN01QaB5cG2Li6E4KJn0M_!!3381629725.jpg_400x400.jpg', '海洋堂新世纪福音战士EVA成品初号机', '海洋堂新世纪福音战士EVA成品初号机', '202109150027033', 'lucien_ssa', '2021-10-15 21:21:52', '2021-10-15 21:21:52', 1, 66, '眼镜厂', '5435341', NULL);
INSERT INTO `oms_cart_item` VALUES (2, 26, 26, 10, 1, 1399.00, 'https://img.alicdn.com/imgextra/i4/647482297/O1CN01WcLlx41Sq4SglOLBs_!!647482297.jpg_430x430q90.jpg', 'Beats Solo Pro头戴式耳机无线蓝牙b魔音降噪运动耳麦高音质', 'Beats Solo Pro头戴式耳机无线蓝牙b魔音降噪运动耳麦高音质', '202109150027026', 'lucien_ssa', '2021-10-15 21:22:30', '2021-10-15 21:22:30', 1, 35, '眼镜厂', '5352342', NULL);

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
  `status` int(1) NULL DEFAULT NULL COMMENT '订单状态：0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->退货订单',
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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_order
-- ----------------------------
INSERT INTO `oms_order` VALUES (1, 10, NULL, '202109270101000001', '2021-09-27 09:16:34', 'lucien', 99.00, 99.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1, 1, 5, 0, '顺丰快递', '202110927812', 15, 0, NULL, 'null', NULL, NULL, NULL, NULL, NULL, 'cxyxxx', '13556787083', '441927', '广东省', '东莞市', '常平镇', '紫荆花园晓辉道51B', '用户要求发顺丰', 0, 0, NULL, '2021-09-27 09:16:38', '2021-09-27 09:39:02', NULL, NULL, '2021-09-27 09:38:15');
INSERT INTO `oms_order` VALUES (2, 10, NULL, '202110150101000001', '2021-10-15 21:21:56', 'lucien', 228.00, 228.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1, 1, 1, 0, NULL, NULL, 15, 0, NULL, 'null', NULL, NULL, NULL, NULL, NULL, 'cxyxxx', '13556787083', '441927', '广东省', '东莞市', '常平镇', '紫荆花园晓辉道51B', NULL, 0, 0, NULL, '2021-10-15 21:21:56', NULL, NULL, NULL, NULL);
INSERT INTO `oms_order` VALUES (3, 10, NULL, '202110150101000002', '2021-10-15 21:22:34', 'lucien', 1399.00, 1399.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1, 1, 1, 0, NULL, NULL, 15, 0, NULL, 'null', NULL, NULL, NULL, NULL, NULL, 'cxyxxx', '13556787083', '441927', '广东省', '东莞市', '常平镇', '紫荆花园晓辉道51B', NULL, 0, 0, NULL, '2021-10-15 21:22:43', NULL, NULL, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单中所包含的商品' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_order_item
-- ----------------------------
INSERT INTO `oms_order_item` VALUES (1, 1, '202109270101000001', 39, 'http://yanxuan.nosdn.127.net/dbc5b25b824c3b3d7ff43b56ca35eee9.png', '北欧简约山形纹绣花抱枕 精细刺绣，舒适立体', '优衣库', '2354545', 99.00, 1, 39, '202109270027039', 53, NULL, NULL, NULL, 0.00, NULL, 0, 0, NULL);
INSERT INTO `oms_order_item` VALUES (2, 2, '202110150101000001', 33, 'https://gd3.alicdn.com/imgextra/i3/3381629725/O1CN01QaB5cG2Li6E4KJn0M_!!3381629725.jpg_400x400.jpg', '海洋堂新世纪福音战士EVA成品初号机', '眼镜厂', '5435341', 228.00, 1, 33, '202109150027033', 66, NULL, NULL, NULL, 0.00, NULL, 0, 0, NULL);
INSERT INTO `oms_order_item` VALUES (3, 3, '202110150101000002', 26, 'https://img.alicdn.com/imgextra/i4/647482297/O1CN01WcLlx41Sq4SglOLBs_!!647482297.jpg_430x430q90.jpg', 'Beats Solo Pro头戴式耳机无线蓝牙b魔音降噪运动耳麦高音质', '眼镜厂', '5352342', 1399.00, 1, 26, '202109150027026', 35, NULL, NULL, NULL, 0.00, NULL, 0, 0, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单操作历史记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_order_operate_history
-- ----------------------------
INSERT INTO `oms_order_operate_history` VALUES (1, 1, '后台管理员', '2021-09-27 09:38:15', 1, '修改订单备注信息:用户要求发顺丰');
INSERT INTO `oms_order_operate_history` VALUES (2, 1, '后台管理员', '2021-09-27 09:39:03', 2, '商家发货');

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单退货申请' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_order_return_apply
-- ----------------------------
INSERT INTO `oms_order_return_apply` VALUES (1, 1, 1, 1, '202109270101000001', '2021-09-27 09:39:52', 'lucien', 99.00, 'cxyxxx', '13556787083', 1, '2021-09-27 09:56:33', 'http://yanxuan.nosdn.127.net/dbc5b25b824c3b3d7ff43b56ca35eee9.png', '北欧简约山形纹绣花抱枕 精细刺绣，舒适立体', '优衣库', NULL, 1, 99.00, 99.00, '颜色不喜欢', '我不想要了', NULL, '确认退货', 'admin', NULL, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '品牌表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_brand
-- ----------------------------
INSERT INTO `pms_brand` VALUES (1, '优衣库', 'Y', 0, 1, 1, 100, 100, 'https://tse1-mm.cn.bing.net/th/id/OIP-C.zoHIAwOUiQPygObglZNQzwAAAA?pid=ImgDet&rs=1', '', 'Victoria\'s Secret的故事');
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
INSERT INTO `pms_brand` VALUES (13, '眼镜厂', 'F', 250, 1, 1, 30, 100, 'https://tse3-mm.cn.bing.net/th/id/OIP-C.UWfXN6640uX0p6t3rlNtLgHaDF?pid=ImgDet&rs=1', '', '眼镜厂');

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
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pms_product
-- ----------------------------
INSERT INTO `pms_product` VALUES (1, 3, 30, 0, 3, '华为 HUAWEI P20 全网通P20系列商务智能拍照4G手机双卡双待	\r\n ', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', '6946605', 0, 1, 1, 1, 1, 100, 23, 3788.00, NULL, 3788, 3788, 0, 'AI智慧全面屏 6GB +64GB 亮黑色 全网通版 移动联通电信4G手机 双卡双待手机 双卡双待', 'AI智慧全面屏 6GB +64GB 亮黑色 全网通版 移动联通电信4G手机 双卡双待手机 双卡双待', 4288.00, 1000, 0, '件', 0.00, 1, '', '', '', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ab46a3cN616bdc41.jpg,http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf5fN2522b9dc.jpg', '', '', '<p><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ad44f1cNf51f3bb0.jpg\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ad44fa8Nfcf71c10.jpg\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ad44fa9N40e78ee0.jpg\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ad457f4N1c94bdda.jpg\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ad457f5Nd30de41d.jpg\" /><img class=\"wscnph\" src=\"http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5b10fb0eN0eb053fb.jpg\" /></p>', '', NULL, NULL, 0, 1, '华为', '手机数码');
INSERT INTO `pms_product` VALUES (2, 10, 31, 0, 3, 'Apple iPhone 8 Plus 64GB 红色特别版 移动联通电信4G手机', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg', '7437799', 0, 1, 1, 1, 1, 0, 17, 5499.00, NULL, 5499, 5499, 0, '【限时限量抢购】Apple产品年中狂欢节，好物尽享，美在智慧！速来 >> 勾选[保障服务][原厂保2年]，获得AppleCare+全方位服务计划，原厂延保售后无忧。', '【限时限量抢购】Apple产品年中狂欢节，好物尽享，美在智慧！速来 >> 勾选[保障服务][原厂保2年]，获得AppleCare+全方位服务计划，原厂延保售后无忧。', 5499.00, 100, 0, '', 0.00, 0, '', '', '', '', '', '', '<div id=\"J_DivItemDesc\" class=\"content\"><p><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/1094656908/O1CN01oFbRLf20tuibfy5oO_!!1094656908.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/1094656908/O1CN01C3dkN120tuiZSU1sV_!!1094656908.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/1094656908/O1CN016CSlK120tuiYU7kgy_!!1094656908.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/1094656908/O1CN01ded4h320tuiYU64iN_!!1094656908.jpg\" style=\"max-width: 750.0px;\"></p></div>', '', NULL, NULL, 0, 0, '苹果', '手机数码');
INSERT INTO `pms_product` VALUES (3, 6, 34, 0, 3, '小米（MI）小米电视4A ', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b02804dN66004d73.jpg', '4609652', 0, 1, 0, 0, 1, 0, 16, 2499.00, NULL, 0, 0, 0, '小米（MI）小米电视4A 55英寸 L55M5-AZ/L55M5-AD 2GB+8GB HDR 4K超高清 人工智能网络液晶平板电视', '小米（MI）小米电视4A 55英寸 L55M5-AZ/L55M5-AD 2GB+8GB HDR 4K超高清 人工智能网络液晶平板电视', 2499.00, 100, 0, '', 0.00, 0, '', '', '', '', '', '', '<p><a href=\"https://luckygo.ews.m.jaeapp.com/?i=LDzRHzLHzRFzLJzSEzLDzRIzLJzSCzLEzSD\" target=\"_blank\"></a><a href=\"https://shop.m.taobao.com/shop/sr.htm?p=1S0j22_75sPo_0_iRjD1\" target=\"_blank\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01cxBBMs29zFsoBSXYy_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></a><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01kPmJLb29zFsCp4Gif_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><a href=\"https://luckygo.ews.m.jaeapp.com/?i=LDzRHzLHzRFzLJzSEzLDzRIzLJzSCzLEzSD\" target=\"_blank\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01ACZVYY29zFngntEjm_!!1714128138.jpg\" align=\"absmiddle\" style=\"width: 790.0px;\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1714128138/O1CN01kHKZxu29zFkdsE7YF_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN019TvqJy29zFkjWpGoi_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01plIaGz29zFkinmTe3_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN014HZiQT29zFkgSVAQL_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01k7JRT629zFkh0Q9FN_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01G5DeXz29zFkhzNYwg_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1714128138/O1CN01eVnHVU29zFkdsEiyf_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></a></p>', '', NULL, NULL, 0, 0, '小米', '手机数码');
INSERT INTO `pms_product` VALUES (4, 6, 34, 0, 3, '小米（MI）小米电视4A 65英寸', 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b028530N51eee7d4.jpg', '4609660', 0, 1, 0, 0, 1, 0, 7, 3999.00, NULL, 0, 0, 0, ' L65M5-AZ/L65M5-AD 2GB+8GB HDR 4K超高清 人工智能网络液晶平板电视', ' L65M5-AZ/L65M5-AD 2GB+8GB HDR 4K超高清 人工智能网络液晶平板电视', 3999.00, 100, 0, '', 0.00, 0, '', '', '', '', '', '', '<p><a href=\"https://luckygo.ews.m.jaeapp.com/?i=LDzRHzLHzRFzLJzSEzLDzRIzLJzSCzLEzSD\" target=\"_blank\"></a><a href=\"https://shop.m.taobao.com/shop/sr.htm?p=1S0j22_75sPo_0_iRjD1\" target=\"_blank\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01cxBBMs29zFsoBSXYy_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></a><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01kPmJLb29zFsCp4Gif_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><a href=\"https://luckygo.ews.m.jaeapp.com/?i=LDzRHzLHzRFzLJzSEzLDzRIzLJzSCzLEzSD\" target=\"_blank\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01ACZVYY29zFngntEjm_!!1714128138.jpg\" align=\"absmiddle\" style=\"width: 790.0px;\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1714128138/O1CN01kHKZxu29zFkdsE7YF_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN019TvqJy29zFkjWpGoi_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01plIaGz29zFkinmTe3_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN014HZiQT29zFkgSVAQL_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01k7JRT629zFkh0Q9FN_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01G5DeXz29zFkhzNYwg_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1714128138/O1CN01eVnHVU29zFkdsEiyf_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></a></p>', '', NULL, NULL, 0, 0, '小米', '手机数码');
INSERT INTO `pms_product` VALUES (5, 1, 53, 0, 5, '皇室御用超柔毛巾 至柔至软，热销50万条', 'http://yanxuan.nosdn.127.net/ad5a317216f9da495b144070ecf1f957.png', '4566564', 0, 1, 1, 1, 1, 0, 15, 79.00, NULL, 0, 0, 0, '皇室御用超柔毛巾 至柔至软，热销50万条', '皇室御用超柔毛巾 至柔至软，热销50万条', 79.00, 100, 0, NULL, 0.00, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' <p><img src=\"https://img.alicdn.com/imgextra/i2/2207949670707/O1CN01CR6P5v1H5qd8e8f3H_!!2207949670707-0-scmitem176000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2207949670707/O1CN01AiBEWZ1H5qgkaoHwX_!!2207949670707-0-scmitem176000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2207949670707/O1CN01pC8rSz1H5qd0VWU2k_!!2207949670707-0-scmitem176000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2207949670707/O1CN01Pk4wja1H5qdB4qy1H_!!2207949670707-0-scmitem176000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2207949670707/O1CN01mNGUz11H5qd99TThj_!!2207949670707-0-scmitem176000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2207949670707/O1CN014KhSVT1H5qdAtXhXV_!!2207949670707-0-scmitem176000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2207949670707/O1CN01LONMMZ1H5qdAtXy9d_!!2207949670707-0-scmitem176000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> </p>', ' ', NULL, NULL, 0, 0, '万和', '被子');
INSERT INTO `pms_product` VALUES (6, 1, 53, 0, 5, '意式毛线绣球四件套 浪漫毛线绣球，简约而不简单', 'http://yanxuan.nosdn.127.net/5350e35e6f22165f38928f3c2c52ac57.png', '4534365', 0, 1, 1, 1, 1, 0, 1, 319.00, NULL, 0, 0, 0, '意式毛线绣球四件套 浪漫毛线绣球，简约而不简单', '意式毛线绣球四件套 浪漫毛线绣球，简约而不简单', 319.00, 100, 0, NULL, 0.00, 0, '  ', ' ', ' ', ' ', ' ', ' ', ' <p><img src=\"http://yanxuan.nosdn.127.net/3f63478dd19081036c7c8061a88438b3.jpg\" _src=\"http://yanxuan.nosdn.127.net/3f63478dd19081036c7c8061a88438b3.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a437697cad2ac00a76b8a2a9f9f7819b.jpg\" _src=\"http://yanxuan.nosdn.127.net/a437697cad2ac00a76b8a2a9f9f7819b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/30607b946fa5245ab1376d28ab8d68c6.jpg\" _src=\"http://yanxuan.nosdn.127.net/30607b946fa5245ab1376d28ab8d68c6.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d18e17059acf20d507fdb8f7054968a8.jpg\" _src=\"http://yanxuan.nosdn.127.net/d18e17059acf20d507fdb8f7054968a8.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/61a0539ce8ca1f38cce7c5647c94aaf7.jpg\" _src=\"http://yanxuan.nosdn.127.net/61a0539ce8ca1f38cce7c5647c94aaf7.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ec45424eef32b60e477bf6860f6c3ac2.jpg\" _src=\"http://yanxuan.nosdn.127.net/ec45424eef32b60e477bf6860f6c3ac2.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d2fb058299e851d21128af4c29bbf40f.jpg\" _src=\"http://yanxuan.nosdn.127.net/d2fb058299e851d21128af4c29bbf40f.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/88fcf4d3d09cc26809eaabf0df4ddc84.jpg\" _src=\"http://yanxuan.nosdn.127.net/88fcf4d3d09cc26809eaabf0df4ddc84.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/505360bfb9ae52b707d194195b547d1e.jpg\" _src=\"http://yanxuan.nosdn.127.net/505360bfb9ae52b707d194195b547d1e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d359fdfda280d2c7681adee5a533a65d.jpg\" _src=\"http://yanxuan.nosdn.127.net/d359fdfda280d2c7681adee5a533a65d.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/e6276ab49a773dedadd75da6529fc41b.jpg\" _src=\"http://yanxuan.nosdn.127.net/e6276ab49a773dedadd75da6529fc41b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/c6057375f8fdafdc1e8e7a894bb2f39a.jpg\" _src=\"http://yanxuan.nosdn.127.net/c6057375f8fdafdc1e8e7a894bb2f39a.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/2059408e8aee017c85e47c7267af21bc.jpg\" _src=\"http://yanxuan.nosdn.127.net/2059408e8aee017c85e47c7267af21bc.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0a7e4c7b19fd7822f89ccd63ca94b234.jpg\" _src=\"http://yanxuan.nosdn.127.net/0a7e4c7b19fd7822f89ccd63ca94b234.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/937329152fc61bff06d29d4b316b7259.jpg\" _src=\"http://yanxuan.nosdn.127.net/937329152fc61bff06d29d4b316b7259.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f7bc2c66157bd5e2cdc978460214d33c.jpg\" _src=\"http://yanxuan.nosdn.127.net/f7bc2c66157bd5e2cdc978460214d33c.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/55d327d74e2c768006fcce7f83cf0051.jpg\" _src=\"http://yanxuan.nosdn.127.net/55d327d74e2c768006fcce7f83cf0051.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/5d06b9bef3bae34d66d38e30fad204d4.jpg\" _src=\"http://yanxuan.nosdn.127.net/5d06b9bef3bae34d66d38e30fad204d4.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/e1f4f2ee0a473c251c055ffeb25426d0.jpg\" _src=\"http://yanxuan.nosdn.127.net/e1f4f2ee0a473c251c055ffeb25426d0.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/7b7efe85839b1f1ea17c829563fc9206.jpg\" _src=\"http://yanxuan.nosdn.127.net/7b7efe85839b1f1ea17c829563fc9206.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ca4091e28e5b8cfd76c1ad3de8fda999.jpg\" _src=\"http://yanxuan.nosdn.127.net/ca4091e28e5b8cfd76c1ad3de8fda999.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ebd7266b6b01bddadf4903e8ca66a82a.jpg\" _src=\"http://yanxuan.nosdn.127.net/ebd7266b6b01bddadf4903e8ca66a82a.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/db777171b81a10c51bae065de7fbef7f.jpg\" _src=\"http://yanxuan.nosdn.127.net/db777171b81a10c51bae065de7fbef7f.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/416626d4074c929f080eff87586a49e2.jpg\" _src=\"http://yanxuan.nosdn.127.net/416626d4074c929f080eff87586a49e2.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/c23701559de65d814e9062847e87c6db.jpg\" _src=\"http://yanxuan.nosdn.127.net/c23701559de65d814e9062847e87c6db.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/200d89ca470fa10ac02971f26cf8f7fd.jpg\" _src=\"http://yanxuan.nosdn.127.net/200d89ca470fa10ac02971f26cf8f7fd.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d6c39f0cf32656244e699eb21089f434.jpg\" _src=\"http://yanxuan.nosdn.127.net/d6c39f0cf32656244e699eb21089f434.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/287fa73c7e8b56eb8bd0ecee08c865da.jpg\" _src=\"http://yanxuan.nosdn.127.net/287fa73c7e8b56eb8bd0ecee08c865da.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0807995485258c26c712169290aac892.jpg\" _src=\"http://yanxuan.nosdn.127.net/0807995485258c26c712169290aac892.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/c29f153a2fada82300a904b2ca46eeeb.jpg\" _src=\"http://yanxuan.nosdn.127.net/c29f153a2fada82300a904b2ca46eeeb.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/bcd0c03d117c27a5c8856aabe577535e.jpg\" _src=\"http://yanxuan.nosdn.127.net/bcd0c03d117c27a5c8856aabe577535e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f9d6c1f265a891458ec9646801a9f790.jpg\" _src=\"http://yanxuan.nosdn.127.net/f9d6c1f265a891458ec9646801a9f790.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/6bce3852bdd99bc428e5339dcec1749b.jpg\" _src=\"http://yanxuan.nosdn.127.net/6bce3852bdd99bc428e5339dcec1749b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0076b7513361cb10daa6cdae51b0238f.jpg\" _src=\"http://yanxuan.nosdn.127.net/0076b7513361cb10daa6cdae51b0238f.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b289f3fdd57ba7c2f9bfed5cc235ad5d.jpg\" _src=\"http://yanxuan.nosdn.127.net/b289f3fdd57ba7c2f9bfed5cc235ad5d.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ea27ef8fcca46882e225ab03f29cc4c3.jpg\" _src=\"http://yanxuan.nosdn.127.net/ea27ef8fcca46882e225ab03f29cc4c3.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/c0bbddfd513a56bb4b4e60b0d7485261.jpg\" _src=\"http://yanxuan.nosdn.127.net/c0bbddfd513a56bb4b4e60b0d7485261.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/9b6904ddbb813688f8e1c36874437b8b.jpg\" _src=\"http://yanxuan.nosdn.127.net/9b6904ddbb813688f8e1c36874437b8b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/87439f2dc3805340736a508bfb4fc044.jpg\" _src=\"http://yanxuan.nosdn.127.net/87439f2dc3805340736a508bfb4fc044.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/29ca62c0aee1df52a9435ed2bf915b06.jpg\" _src=\"http://yanxuan.nosdn.127.net/29ca62c0aee1df52a9435ed2bf915b06.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/993cfb5a549e93a86ac5a5485221ded3.jpg\" _src=\"http://yanxuan.nosdn.127.net/993cfb5a549e93a86ac5a5485221ded3.jpg\" style=\"\"/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p>', ' ', NULL, NULL, 0, 0, '万和', '被子');
INSERT INTO `pms_product` VALUES (7, 1, 53, 0, 5, '日式和风懒人沙发 优质莱卡纯棉，和风家居新体验', 'http://yanxuan.nosdn.127.net/149dfa87a7324e184c5526ead81de9ad.png', '4533243', 0, 1, 1, 1, 1, 0, 19, 619.00, NULL, 0, 0, 0, '日式和风懒人沙发 优质莱卡纯棉，和风家居新体验', '日式和风懒人沙发 优质莱卡纯棉，和风家居新体验', 619.00, 100, 0, NULL, 0.00, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' <p><br/></p><p><img src=\"http://yanxuan.nosdn.127.net/34a6a0daa3f7a397a38aad14cb9e90fa.jpg\" _src=\"http://yanxuan.nosdn.127.net/34a6a0daa3f7a397a38aad14cb9e90fa.jpg\"/><br/></p><p><img src=\"http://yanxuan.nosdn.127.net/76637af0eec246b318cb129b768de637.jpg\" _src=\"http://yanxuan.nosdn.127.net/76637af0eec246b318cb129b768de637.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/18fee22626e61fc1d1a01916914016ba.jpg\" _src=\"http://yanxuan.nosdn.127.net/18fee22626e61fc1d1a01916914016ba.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/91f57a9bb142e1c1e2ff0bbea6f9af96.jpg\" _src=\"http://yanxuan.nosdn.127.net/91f57a9bb142e1c1e2ff0bbea6f9af96.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/252d80fd75eb1254d746d0b57c267650.jpg\" _src=\"http://yanxuan.nosdn.127.net/252d80fd75eb1254d746d0b57c267650.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/4b07697992a2b14de6fd0a5811936d71.jpg\" _src=\"http://yanxuan.nosdn.127.net/4b07697992a2b14de6fd0a5811936d71.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/c499439d6081bb4e836955b7514c1b96.jpg\" _src=\"http://yanxuan.nosdn.127.net/c499439d6081bb4e836955b7514c1b96.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/bed437fdc091d020a8f805bcc8830bd8.jpg\" _src=\"http://yanxuan.nosdn.127.net/bed437fdc091d020a8f805bcc8830bd8.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0fc5febdb817abd7a1040bab03f048b7.jpg\" _src=\"http://yanxuan.nosdn.127.net/0fc5febdb817abd7a1040bab03f048b7.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a0417b3986c9dc082124fcc360390021.jpg\" _src=\"http://yanxuan.nosdn.127.net/a0417b3986c9dc082124fcc360390021.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a5c9d24c652d4dee7946ef925105f3f2.jpg\" _src=\"http://yanxuan.nosdn.127.net/a5c9d24c652d4dee7946ef925105f3f2.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b10272c58f95dd6737ce1cd41452a21d.jpg\" _src=\"http://yanxuan.nosdn.127.net/b10272c58f95dd6737ce1cd41452a21d.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/510c6ef36760238b38ed59cd6e47a21f.png\" _src=\"http://yanxuan.nosdn.127.net/510c6ef36760238b38ed59cd6e47a21f.png\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/6371348b917c021c55dc393fc59d4d28.png\" _src=\"http://yanxuan.nosdn.127.net/6371348b917c021c55dc393fc59d4d28.png\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/de4079b128e57c5c0fa8a8177e9bc6e7.png\" _src=\"http://yanxuan.nosdn.127.net/de4079b128e57c5c0fa8a8177e9bc6e7.png\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/160966fbc772787f824dc1dbd5afb16d.png\" _src=\"http://yanxuan.nosdn.127.net/160966fbc772787f824dc1dbd5afb16d.png\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/bb3c8d3f10f2aca0908871c8e598aa0e.jpg\" _src=\"http://yanxuan.nosdn.127.net/bb3c8d3f10f2aca0908871c8e598aa0e.jpg\"/></p><p><br/></p>', ' ', NULL, NULL, 0, 0, '万和', '家具');
INSERT INTO `pms_product` VALUES (8, 1, 53, 0, 5, '色织华夫格夏凉被 凹凸华夫格织法，舒适轻柔', 'http://yanxuan.nosdn.127.net/07376e78bf4fb8a5aa8e6a0b1437c3ad.png', '4543364', 0, 1, 1, 1, 1, 0, 2, 319.00, NULL, 0, 0, 0, '色织华夫格夏凉被 凹凸华夫格织法，舒适轻柔', '色织华夫格夏凉被 凹凸华夫格织法，舒适轻柔', 319.00, 100, 0, NULL, 0.00, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' <p><img src=\"http://yanxuan.nosdn.127.net/70e21fc5c723dc6adcb1b531553597d9.jpg\" _src=\"http://yanxuan.nosdn.127.net/70e21fc5c723dc6adcb1b531553597d9.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/fcdf78276ab0bcd8ed80a3dda8c29b6a.jpg\" _src=\"http://yanxuan.nosdn.127.net/fcdf78276ab0bcd8ed80a3dda8c29b6a.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/1eb088a53d00f094bbac4b1f7a662457.jpg\" _src=\"http://yanxuan.nosdn.127.net/1eb088a53d00f094bbac4b1f7a662457.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/86be51c377922edd23e48b9d0c51d5dc.jpg\" _src=\"http://yanxuan.nosdn.127.net/86be51c377922edd23e48b9d0c51d5dc.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/e9cadf6589933fab072aef8c0644bb91.jpg\" _src=\"http://yanxuan.nosdn.127.net/e9cadf6589933fab072aef8c0644bb91.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/adbb912f1131f821f4d01bb29ed31450.jpg\" _src=\"http://yanxuan.nosdn.127.net/adbb912f1131f821f4d01bb29ed31450.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/8309ca74e9ecea295882b68cc0080652.jpg\" _src=\"http://yanxuan.nosdn.127.net/8309ca74e9ecea295882b68cc0080652.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/4cce90d2ad13258af815b828dd3fa34f.jpg\" _src=\"http://yanxuan.nosdn.127.net/4cce90d2ad13258af815b828dd3fa34f.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0ad6cf5c7f4ed107d39997ce1acfffd2.jpg\" _src=\"http://yanxuan.nosdn.127.net/0ad6cf5c7f4ed107d39997ce1acfffd2.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/4b867cc1a9f3c0046b40118e009a2cbd.jpg\" _src=\"http://yanxuan.nosdn.127.net/4b867cc1a9f3c0046b40118e009a2cbd.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b14b08ce203d77633340b1677f6196b6.jpg\" _src=\"http://yanxuan.nosdn.127.net/b14b08ce203d77633340b1677f6196b6.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b697d210e3137bc9fa8f5b74a9916ce6.jpg\" _src=\"http://yanxuan.nosdn.127.net/b697d210e3137bc9fa8f5b74a9916ce6.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a8b23b600cb5848d00eb1a176554f5de.jpg\" _src=\"http://yanxuan.nosdn.127.net/a8b23b600cb5848d00eb1a176554f5de.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0b76964151af30178e74e28d0d590fd7.jpg\" _src=\"http://yanxuan.nosdn.127.net/0b76964151af30178e74e28d0d590fd7.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3eda6586081f50314690ab9f141d1758.jpg\" _src=\"http://yanxuan.nosdn.127.net/3eda6586081f50314690ab9f141d1758.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/939f9ac497e48529e0c44ef5af32f329.jpg\" _src=\"http://yanxuan.nosdn.127.net/939f9ac497e48529e0c44ef5af32f329.jpg\" style=\"\"/></p><p><br/></p>', ' ', NULL, NULL, 0, 0, '万和', '被子');
INSERT INTO `pms_product` VALUES (9, 1, 50, 0, 5, '100年传世珐琅锅 全家系列 特质铸铁，大容量全家共享', 'http://yanxuan.nosdn.127.net/c39d54c06a71b4b61b6092a0d31f2335.png', '4523425', 0, 1, 1, 1, 1, 0, 3, 398.00, NULL, 0, 0, 0, '100年传世珐琅锅 全家系列 特质铸铁，大容量全家共享', '100年传世珐琅锅 全家系列 特质铸铁，大容量全家共享', 398.00, 100, 0, NULL, 0.00, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' <p><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN010F43k81owPLbaDWac_!!3192155289.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01GVp9g51owPLWUeVgA_!!3192155289.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01I0pPlI1owPLabm8t4_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01wEiXBg1owPLZsmyOP_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01Wvimll1owPLY34R3y_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN015VlaBI1owPLZslMeC_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01VbINp61owPLXljH3m_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN015IVOBn1owPLWUeVgy_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01lbinQH1owPLb7WSYt_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01hw1I8A1owPLc1NjHx_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01Dpt0xi1owPLb7YbcL_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN017DBrBS1owPLWUgWKX_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01L1qITs1owPLYU87of_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01HLcYrq1owPLZgfKdU_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01aA4wof1owPLVKSqsL_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01DrJeMc1owPLWUgFhi_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01eZsYUA1owPLabmPXM_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN016dQtz01owPLYU8G9C_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01SVysHk1owPLYME219_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01J5UQn91owPLYMCtMd_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01XJnV6N1owPLb7WrXU_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01IItU7s1owPLY362si_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01oEEvKU1owPLZgdrB5_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01k4Pisv1owPLXljTa0_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN019XbpVR1owPLZgdO6t_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01Quq7cb1owPLXlmYp0_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN017NhvmJ1owPLYU0H0t_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01miP3eX1owPLabnxBx_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01Qqm2hw1owPLYU7SHT_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01TYDSOq1owPLabncOa_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01cvon2L1owPLYU8KK7_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN0166iHKo1owPLYU7zXm_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01NmnWBD1owPLbaEKXU_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01ij7U6m1owPLXlkgRR_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01chrFfn1owPLYTyfGV_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01iZRSU51owPLXlk9B1_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01HgaP4L1owPLQl9H9j_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01R3qoqc1owPLQlB5PF_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN019D5gEp1owPLYMElmS_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01sXe5dl1owPLc1OT6c_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01DULS9C1owPLYU0PMG_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01rx75zR1owPLY37SAU_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01H9l9OO1owPLWUfqqS_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN014Ml5Cx1owPLY37mwk_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01DjMuhH1owPLYTyOdD_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01rZEI4O1owPLb7YTNR_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01z0ugHu1owPLZBuNTv_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01NVswYF1owPLZspWTl_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01i5bIJe1owPLbaECH8_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN016D5JhJ1owPLZBwOBM_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01u83w631owPLYU0fz0_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01AQCSre1owPLc1PfwT_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN012fc1Ut1owPLYU7n73_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN013FTlsN1owPLb7aHff_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01yTk7VZ1owPLZgeGC0_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01NDevPh1owPLZsmm3K_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01X9it9O1owPLWI1Vvz_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01xPWNeT1owPLbaFsFZ_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN019mGaN81owPLZgfKjJ_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01RrSPx61owPLc1QDDc_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01FIzjqY1owPLabocpl_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01MmijWV1owPLb7YL5g_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01h9HceI1owPLZBuiIJ_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN010bL4cC1owPLbaFfmb_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01vsv5KX1owPLY36Jax_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01UfZAeC1owPLZBvBNh_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN0182sngq1owPLaboh0M_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01rKElkz1owPLZgeGDp_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01pcVRJs1owPLc1Pk8m_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01idKTOt1owPLbaEOmA_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01hwGDsP1owPLZBwFuD_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN017dKu9n1owPLZggwWS_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01AeO69o1owPLZsnqbm_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN0169xKBq1owPLVKSWCw_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01pFpkyV1owPLb7ZTpy_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01R8lu161owPLc1QsoE_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01285guz1owPLY36z97_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/3192155289/O1CN01bSWWSt1owPLWUhSgE_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01YVF2Xt1owPLYTz4HH_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN01S83CAn1owPLYTySsd_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01eZqxce1owPLZBwrLH_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01nnKHFJ1owPLZBuunh_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01J9Zr9t1owPLWI1733_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN019KscTF1owPLXlkx9k_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01yOeAN61owPLbaHcOH_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN01Fux6xc1owPLWUhb0i_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN019bo7y71owPLb7axJG_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3192155289/O1CN0182zV531owPLZspvUH_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01c8op7O1owPLbaIguu_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01yIrdIX1owPLZsnmUQ_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/3192155289/O1CN011ohcNb1owPLYUB0is_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/3192155289/O1CN01Ip7V3p1owPLXlmxtQ_!!3192155289.jpg\" class=\"\" style=\"max-width: 750.0px;\"></p>', ' ', NULL, NULL, 0, 0, '万和', '家具');
INSERT INTO `pms_product` VALUES (10, 1, 54, 0, 5, '方形封闭式宠物窝 封闭式设计猫咪独享', 'http://yanxuan.nosdn.127.net/337da7094c1df295ca0f0b8baa55b2d5.png', '4523434', 0, 1, 1, 1, 1, 0, 1, 119.00, NULL, 0, 0, 0, '方形封闭式宠物窝 封闭式设计猫咪独享', '方形封闭式宠物窝 封闭式设计猫咪独享', 119.00, 100, 0, NULL, 0.00, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' <p><img src=\"http://yanxuan.nosdn.127.net/09f022af55341d80d5d3ad620ce6d779.jpg\" _src=\"http://yanxuan.nosdn.127.net/09f022af55341d80d5d3ad620ce6d779.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d75ea4c580effd435ed00f652c01a778.jpg\" _src=\"http://yanxuan.nosdn.127.net/d75ea4c580effd435ed00f652c01a778.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/8fad82d53a0494c625608786f5931950.jpg\" _src=\"http://yanxuan.nosdn.127.net/8fad82d53a0494c625608786f5931950.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0a1d8a1cb8a57ae7921f34a9d761f3aa.jpg\" _src=\"http://yanxuan.nosdn.127.net/0a1d8a1cb8a57ae7921f34a9d761f3aa.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/261670eea6a48c7e307393ce295e2ce5.jpg\" _src=\"http://yanxuan.nosdn.127.net/261670eea6a48c7e307393ce295e2ce5.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/11bfc68005a0ce9b80e01f614a259af7.jpg\" _src=\"http://yanxuan.nosdn.127.net/11bfc68005a0ce9b80e01f614a259af7.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/688f822cf34c656367cccfb0d9f72151.jpg\" _src=\"http://yanxuan.nosdn.127.net/688f822cf34c656367cccfb0d9f72151.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f3721906d7c6c0c30193d4778eff9e4e.jpg\" _src=\"http://yanxuan.nosdn.127.net/f3721906d7c6c0c30193d4778eff9e4e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/090e9c28dc2736a1246ef914e35634c4.jpg\" _src=\"http://yanxuan.nosdn.127.net/090e9c28dc2736a1246ef914e35634c4.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f31d497ae028ff2c2e933d712ccc055d.jpg\" _src=\"http://yanxuan.nosdn.127.net/f31d497ae028ff2c2e933d712ccc055d.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a424b9e51b854c4abf61b8c1c1cdf1aa.jpg\" _src=\"http://yanxuan.nosdn.127.net/a424b9e51b854c4abf61b8c1c1cdf1aa.jpg\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/7660d03152dea988256eac3be92541b3.jpg\" _src=\"http://yanxuan.nosdn.127.net/7660d03152dea988256eac3be92541b3.jpg\" style=\"\"/></p><p><br/></p>', ' ', NULL, NULL, 0, 0, '万和', '家具');
INSERT INTO `pms_product` VALUES (11, 1, 54, 0, 5, '六边形南瓜式宠物窝 给萌宠柔软包裹的归家感', 'http://yanxuan.nosdn.127.net/58ed94b63b39339e7814f1339013793c.png', '4532411', 0, 1, 1, 1, 1, 0, 2, 139.00, NULL, 0, 0, 0, '六边形南瓜式宠物窝 给萌宠柔软包裹的归家感', '六边形南瓜式宠物窝 给萌宠柔软包裹的归家感', 139.00, 100, 0, NULL, 0.00, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' <p><img src=\"http://yanxuan.nosdn.127.net/44f4fe5b43365884131b07c25b3c54ca.jpg\" _src=\"http://yanxuan.nosdn.127.net/44f4fe5b43365884131b07c25b3c54ca.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/beabfe6fd0717daa3544ac7c2d82b430.jpg\" _src=\"http://yanxuan.nosdn.127.net/beabfe6fd0717daa3544ac7c2d82b430.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/25467804bf2eed0d07f171c10f798d2e.jpg\" _src=\"http://yanxuan.nosdn.127.net/25467804bf2eed0d07f171c10f798d2e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/7fced8c058df228bed15bc8822fa871c.jpg\" _src=\"http://yanxuan.nosdn.127.net/7fced8c058df228bed15bc8822fa871c.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a3eea3bd19f75f01a7ed424be3aa9d42.jpg\" _src=\"http://yanxuan.nosdn.127.net/a3eea3bd19f75f01a7ed424be3aa9d42.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/e30076799805a678af405dce6ccf6d62.jpg\" _src=\"http://yanxuan.nosdn.127.net/e30076799805a678af405dce6ccf6d62.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ac4cdbb579512a23287b4a43639b5e34.jpg\" _src=\"http://yanxuan.nosdn.127.net/ac4cdbb579512a23287b4a43639b5e34.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/2cf8b27e7c89f0a46cbd330bb81ab1a5.jpg\" _src=\"http://yanxuan.nosdn.127.net/2cf8b27e7c89f0a46cbd330bb81ab1a5.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3021babd417d3b3791db8b9684c9a07e.jpg\" _src=\"http://yanxuan.nosdn.127.net/3021babd417d3b3791db8b9684c9a07e.jpg\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a72b172bf0e8ad6d0d6735750e1d375c.jpg\" _src=\"http://yanxuan.nosdn.127.net/a72b172bf0e8ad6d0d6735750e1d375c.jpg\" style=\"\"/></p><p><br/></p>', ' ', NULL, NULL, 0, 0, '万和', '家具');
INSERT INTO `pms_product` VALUES (12, 1, 54, 0, 5, '日式纯色水洗亚麻抱枕 水洗亚麻，透气亲肤', 'http://yanxuan.nosdn.127.net/8a9ee5ba08929cc9e40b973607d2f633.png', '4521354', 0, 1, 1, 1, 1, 0, 36, 99.00, NULL, 0, 0, 0, '日式纯色水洗亚麻抱枕 水洗亚麻，透气亲肤', '日式纯色水洗亚麻抱枕 水洗亚麻，透气亲肤', 99.00, 100, 0, NULL, 0.00, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' <p><img src=\"http://yanxuan.nosdn.127.net/6b69f7597ccffd27d77467d9d04eb294.jpg\" _src=\"http://yanxuan.nosdn.127.net/6b69f7597ccffd27d77467d9d04eb294.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a89ca371ef07355c1feb293db961bd30.jpg\" _src=\"http://yanxuan.nosdn.127.net/a89ca371ef07355c1feb293db961bd30.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/2076e89c5f8fde4f44f918bd02d18eb7.jpg\" _src=\"http://yanxuan.nosdn.127.net/2076e89c5f8fde4f44f918bd02d18eb7.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/5c9111e4dcc13cb41db98f68086cc620.jpg\" _src=\"http://yanxuan.nosdn.127.net/5c9111e4dcc13cb41db98f68086cc620.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/8f0645abcf883e7a863f32ce95f3c26b.jpg\" _src=\"http://yanxuan.nosdn.127.net/8f0645abcf883e7a863f32ce95f3c26b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/76a2b12f2d0f48f268d18b0ca0d1d6bb.jpg\" _src=\"http://yanxuan.nosdn.127.net/76a2b12f2d0f48f268d18b0ca0d1d6bb.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a91f75159867f33a91f4e9992e00afa1.jpg\" _src=\"http://yanxuan.nosdn.127.net/a91f75159867f33a91f4e9992e00afa1.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/93de61256a8ff3a8aa4bb90847ff454e.jpg\" _src=\"http://yanxuan.nosdn.127.net/93de61256a8ff3a8aa4bb90847ff454e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f611f99bea2920881e1421c110970234.jpg\" _src=\"http://yanxuan.nosdn.127.net/f611f99bea2920881e1421c110970234.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a292339423f141ad5d7a4011ea316956.jpg\" _src=\"http://yanxuan.nosdn.127.net/a292339423f141ad5d7a4011ea316956.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/2045ae4f861d9eae6af351b9d82c9239.jpg\" _src=\"http://yanxuan.nosdn.127.net/2045ae4f861d9eae6af351b9d82c9239.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/398718a6d579c4af5f255909283e44a2.jpg\" _src=\"http://yanxuan.nosdn.127.net/398718a6d579c4af5f255909283e44a2.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/5be95e2db627908d23605fe042af2937.jpg\" _src=\"http://yanxuan.nosdn.127.net/5be95e2db627908d23605fe042af2937.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/50a4fa0f67aa85dfaad36695225fe2f8.jpg\" _src=\"http://yanxuan.nosdn.127.net/50a4fa0f67aa85dfaad36695225fe2f8.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/7c825e297cfbaaae632146a55c61dc3c.jpg\" _src=\"http://yanxuan.nosdn.127.net/7c825e297cfbaaae632146a55c61dc3c.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/261c7819e7e9ac165e64cae88a59f70c.jpg\" _src=\"http://yanxuan.nosdn.127.net/261c7819e7e9ac165e64cae88a59f70c.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ec83f40d91fcc79f59a2479dffeb4565.jpg\" _src=\"http://yanxuan.nosdn.127.net/ec83f40d91fcc79f59a2479dffeb4565.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/26f3e85402086b7d261a650e244dc676.jpg\" _src=\"http://yanxuan.nosdn.127.net/26f3e85402086b7d261a650e244dc676.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/dccb68f0d97112d245ab1924744b94b8.jpg\" _src=\"http://yanxuan.nosdn.127.net/dccb68f0d97112d245ab1924744b94b8.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/aaba69949efd7ed85e72071f4ade4945.jpg\" _src=\"http://yanxuan.nosdn.127.net/aaba69949efd7ed85e72071f4ade4945.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3f23300061e5cf871e86a51f0012e885.jpg\" _src=\"http://yanxuan.nosdn.127.net/3f23300061e5cf871e86a51f0012e885.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a55eedca057e0c973549ac8f13b47800.jpg\" _src=\"http://yanxuan.nosdn.127.net/a55eedca057e0c973549ac8f13b47800.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/abf16e831285e3d97dbb60a3162e7968.jpg\" _src=\"http://yanxuan.nosdn.127.net/abf16e831285e3d97dbb60a3162e7968.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a9390c8dab9fc7d8c27ac9410eb0340c.jpg\" _src=\"http://yanxuan.nosdn.127.net/a9390c8dab9fc7d8c27ac9410eb0340c.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/8feb2be5afec5abe439cf1b42683373f.jpg\" _src=\"http://yanxuan.nosdn.127.net/8feb2be5afec5abe439cf1b42683373f.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/beb7620d0f685ab9c3af7ed18284b29e.jpg\" _src=\"http://yanxuan.nosdn.127.net/beb7620d0f685ab9c3af7ed18284b29e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/7f70ceed2078d44d747a9ce369feee9e.jpg\" _src=\"http://yanxuan.nosdn.127.net/7f70ceed2078d44d747a9ce369feee9e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/5469e219bd5347568337746b257f094e.jpg\" _src=\"http://yanxuan.nosdn.127.net/5469e219bd5347568337746b257f094e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a177a6b6e58580809330895ebdbaff6b.jpg\" _src=\"http://yanxuan.nosdn.127.net/a177a6b6e58580809330895ebdbaff6b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/9db0090d56ab757babb2ba661726cbe3.jpg\" _src=\"http://yanxuan.nosdn.127.net/9db0090d56ab757babb2ba661726cbe3.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/6363637e0dd2fc670745c217b2a5cbfc.jpg\" _src=\"http://yanxuan.nosdn.127.net/6363637e0dd2fc670745c217b2a5cbfc.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/1af1bde98f1497f591f62bff99ccca54.jpg\" _src=\"http://yanxuan.nosdn.127.net/1af1bde98f1497f591f62bff99ccca54.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/69d034b353ae2e6e30afb6c21483690f.jpg\" _src=\"http://yanxuan.nosdn.127.net/69d034b353ae2e6e30afb6c21483690f.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/4e29d6ac5ed040d63847ca456a179d43.jpg\" _src=\"http://yanxuan.nosdn.127.net/4e29d6ac5ed040d63847ca456a179d43.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/29e460fba57f67cd83121f6cb917cfbd.jpg\" _src=\"http://yanxuan.nosdn.127.net/29e460fba57f67cd83121f6cb917cfbd.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/16090c02f4d4b76c6be82d98e489586e.jpg\" _src=\"http://yanxuan.nosdn.127.net/16090c02f4d4b76c6be82d98e489586e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/c840eb66cf002227c52a13fbe55f657b.jpg\" _src=\"http://yanxuan.nosdn.127.net/c840eb66cf002227c52a13fbe55f657b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/16f65265b0942a60f3241704dc29be13.jpg\" _src=\"http://yanxuan.nosdn.127.net/16f65265b0942a60f3241704dc29be13.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/54a63da54b4e80867d8cd92d1ea9576e.jpg\" _src=\"http://yanxuan.nosdn.127.net/54a63da54b4e80867d8cd92d1ea9576e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ebd0b906076850983e5a2aae9f667ce7.jpg\" _src=\"http://yanxuan.nosdn.127.net/ebd0b906076850983e5a2aae9f667ce7.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/bbf32cdc82643a85c12ff05ea88088ad.jpg\" _src=\"http://yanxuan.nosdn.127.net/bbf32cdc82643a85c12ff05ea88088ad.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ca6e3ccc3725c3f58338b62a5a0655d3.jpg\" _src=\"http://yanxuan.nosdn.127.net/ca6e3ccc3725c3f58338b62a5a0655d3.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/6ef02962e6155f811566aad168dabbec.jpg\" _src=\"http://yanxuan.nosdn.127.net/6ef02962e6155f811566aad168dabbec.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/832735166071f05288ffd347dff58ee6.jpg\" _src=\"http://yanxuan.nosdn.127.net/832735166071f05288ffd347dff58ee6.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/4fc490c4e9a0a0fa0affd317b8526f4e.jpg\" _src=\"http://yanxuan.nosdn.127.net/4fc490c4e9a0a0fa0affd317b8526f4e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/1b05f975f16c09f106c81533c1a249b0.jpg\" _src=\"http://yanxuan.nosdn.127.net/1b05f975f16c09f106c81533c1a249b0.jpg\" style=\"\"/></p><p><br/></p>', ' ', NULL, NULL, 0, 0, '万和', '家具');
INSERT INTO `pms_product` VALUES (13, 1, 54, 0, 5, '澳洲羊羔毛华夫格盖毯 美利奴全新羊羔毛的细腻触感', 'http://yanxuan.nosdn.127.net/a803c68ea88e3116023b45ac9ea99510.png', '4533432', 0, 1, 1, 1, 1, 0, 33, 369.00, NULL, 0, 0, 0, '澳洲羊羔毛华夫格盖毯 美利奴全新羊羔毛的细腻触感', '澳洲羊羔毛华夫格盖毯 美利奴全新羊羔毛的细腻触感', 369.00, 100, 0, NULL, 0.00, 0, ' ', ' ', ' ', ' ', ' ', ' ', ' <p><img src=\"http://yanxuan.nosdn.127.net/3f743d4b4f30ddffdfee6339d83701c9.jpg\" _src=\"http://yanxuan.nosdn.127.net/3f743d4b4f30ddffdfee6339d83701c9.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/bf2c4b3d138da32aae6b3ffcdaedeb73.jpg\" _src=\"http://yanxuan.nosdn.127.net/bf2c4b3d138da32aae6b3ffcdaedeb73.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3536d6deabba614dd9a8730875a37d36.jpg\" _src=\"http://yanxuan.nosdn.127.net/3536d6deabba614dd9a8730875a37d36.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b8d889753ccee9174a5449041aba57db.jpg\" _src=\"http://yanxuan.nosdn.127.net/b8d889753ccee9174a5449041aba57db.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0785a14712f2d585fea3776a8775f1e4.jpg\" _src=\"http://yanxuan.nosdn.127.net/0785a14712f2d585fea3776a8775f1e4.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b0c3756c5f4e96c0f37167dce9628a8b.jpg\" _src=\"http://yanxuan.nosdn.127.net/b0c3756c5f4e96c0f37167dce9628a8b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/4a196080fd7b76bf9e4b2c97afc1028d.jpg\" _src=\"http://yanxuan.nosdn.127.net/4a196080fd7b76bf9e4b2c97afc1028d.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/e0d6859834701a093327e3710b52b5b0.jpg\" _src=\"http://yanxuan.nosdn.127.net/e0d6859834701a093327e3710b52b5b0.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/db0116b70973635ca8ff7be78bf5f541.jpg\" _src=\"http://yanxuan.nosdn.127.net/db0116b70973635ca8ff7be78bf5f541.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f066780f86264b0bc037b945b81b1406.jpg\" _src=\"http://yanxuan.nosdn.127.net/f066780f86264b0bc037b945b81b1406.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f0d87991c9a1874693cfecc52c6e1197.jpg\" _src=\"http://yanxuan.nosdn.127.net/f0d87991c9a1874693cfecc52c6e1197.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0a450d55776a981ac9aa87af0a7c418f.jpg\" _src=\"http://yanxuan.nosdn.127.net/0a450d55776a981ac9aa87af0a7c418f.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b450e5950181bf464baff2b7e79188d6.jpg\" _src=\"http://yanxuan.nosdn.127.net/b450e5950181bf464baff2b7e79188d6.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/bebe0b8259c7fdd88509947ef0a8037a.jpg\" _src=\"http://yanxuan.nosdn.127.net/bebe0b8259c7fdd88509947ef0a8037a.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/10be9b68827caaa1b67077c7c5bdf05b.jpg\" _src=\"http://yanxuan.nosdn.127.net/10be9b68827caaa1b67077c7c5bdf05b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/56c0dd020ab4aceeb696520df5c8780c.jpg\" _src=\"http://yanxuan.nosdn.127.net/56c0dd020ab4aceeb696520df5c8780c.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d2176b1f79b255d89206f044e42c3812.jpg\" _src=\"http://yanxuan.nosdn.127.net/d2176b1f79b255d89206f044e42c3812.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/389af26a26c1ac3ebae82afeca4850f2.jpg\" _src=\"http://yanxuan.nosdn.127.net/389af26a26c1ac3ebae82afeca4850f2.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0897b52523d43efaa5b66449d97a2e5c.jpg\" _src=\"http://yanxuan.nosdn.127.net/0897b52523d43efaa5b66449d97a2e5c.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3fbbb2da0b5019ddacc6761ebc691902.jpg\" _src=\"http://yanxuan.nosdn.127.net/3fbbb2da0b5019ddacc6761ebc691902.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/1d8576b1472852a8ab96a30d4d8536c6.jpg\" _src=\"http://yanxuan.nosdn.127.net/1d8576b1472852a8ab96a30d4d8536c6.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/4df95e96ca354efec574e01297fd9e2b.jpg\" _src=\"http://yanxuan.nosdn.127.net/4df95e96ca354efec574e01297fd9e2b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d98a831ff4adeccd093c3fd8ddbc026b.jpg\" _src=\"http://yanxuan.nosdn.127.net/d98a831ff4adeccd093c3fd8ddbc026b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f6050089684ca291a045ab0eea483aab.jpg\" _src=\"http://yanxuan.nosdn.127.net/f6050089684ca291a045ab0eea483aab.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/96b0c33ae3b402863bde7b830b817866.jpg\" _src=\"http://yanxuan.nosdn.127.net/96b0c33ae3b402863bde7b830b817866.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/6d7d595ae0df9e126dca6926b17c3afe.jpg\" _src=\"http://yanxuan.nosdn.127.net/6d7d595ae0df9e126dca6926b17c3afe.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a4230ca0e414599c38b22c677eac8a2f.jpg\" _src=\"http://yanxuan.nosdn.127.net/a4230ca0e414599c38b22c677eac8a2f.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/aad253305dcdb44bdbfb519a503823da.jpg\" _src=\"http://yanxuan.nosdn.127.net/aad253305dcdb44bdbfb519a503823da.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b512ead08406712b5d98abf20ebe7691.jpg\" _src=\"http://yanxuan.nosdn.127.net/b512ead08406712b5d98abf20ebe7691.jpg\" style=\"\"/></p><p><br/></p>', ' ', NULL, NULL, 0, 0, '万和', '家具');
INSERT INTO `pms_product` VALUES (14, 1, 54, 0, 5, '清欢日式可调节台灯 木铁结合，全体可调节', 'http://yanxuan.nosdn.127.net/c83a3881704094ddd3970099ca77d115.png', '4512354', 0, 1, 1, 1, 1, 0, 2, 219.00, NULL, 0, 0, 0, '清欢日式可调节台灯 木铁结合，全体可调节', '清欢日式可调节台灯 木铁结合，全体可调节', 219.00, 100, 0, NULL, 0.00, 0, '', ' ', ' ', ' ', ' ', ' ', ' <p><img src=\"http://yanxuan.nosdn.127.net/15e1d839714a67bff57259d61d7ca2e5.jpg\" _src=\"http://yanxuan.nosdn.127.net/15e1d839714a67bff57259d61d7ca2e5.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/43ba9bbc931f954e0aaeb90631a179ac.jpg\" _src=\"http://yanxuan.nosdn.127.net/43ba9bbc931f954e0aaeb90631a179ac.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ac5ca160c90c1a700160d5d024ad611b.jpg\" _src=\"http://yanxuan.nosdn.127.net/ac5ca160c90c1a700160d5d024ad611b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0f2d157d83955d5c616dc3d647da6f66.jpg\" _src=\"http://yanxuan.nosdn.127.net/0f2d157d83955d5c616dc3d647da6f66.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a2ee5af100a5432f0614e9717196787e.jpg\" _src=\"http://yanxuan.nosdn.127.net/a2ee5af100a5432f0614e9717196787e.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/91fb28c19d495e47797ef250940ab618.jpg\" _src=\"http://yanxuan.nosdn.127.net/91fb28c19d495e47797ef250940ab618.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/6f37742eed13ea12d8c341e1e3b988e9.jpg\" _src=\"http://yanxuan.nosdn.127.net/6f37742eed13ea12d8c341e1e3b988e9.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/5ff15b419a0248b7b53bd60286067766.jpg\" _src=\"http://yanxuan.nosdn.127.net/5ff15b419a0248b7b53bd60286067766.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/21c4dacdc844da911e43eaac0975908a.jpg\" _src=\"http://yanxuan.nosdn.127.net/21c4dacdc844da911e43eaac0975908a.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3f8741dd387c51378f78bdbf65856a41.jpg\" _src=\"http://yanxuan.nosdn.127.net/3f8741dd387c51378f78bdbf65856a41.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/dbe9726936999c62ac8bce3b620cd045.jpg\" _src=\"http://yanxuan.nosdn.127.net/dbe9726936999c62ac8bce3b620cd045.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d12ad2de3cb646e76380c064ccfe038f.jpg\" _src=\"http://yanxuan.nosdn.127.net/d12ad2de3cb646e76380c064ccfe038f.jpg\" style=\"\"/></p><p><br/></p>', ' ', NULL, NULL, 0, 0, '万和', '家具');
INSERT INTO `pms_product` VALUES (15, 3, 30, 0, 3, '华为Mate 40 Pro 4G麒麟曲面华为手机4g手机智能手机华为官方旗舰店mate40pro', 'https://img.alicdn.com/imgextra/i1/2838892713/O1CN01FQ69AI1VubCzlAzxB_!!0-item_pic.jpg_430x430q90.jpg', '3543543', 0, 1, 1, 1, 1, 0, 4, 6099.00, NULL, 0, 0, 0, '华为Mate 40 Pro 4G麒麟曲面华为手机4g手机智能手机华为官方旗舰店mate40pro', '华为Mate 40 Pro 4G麒麟曲面华为手机4g手机智能手机华为官方旗舰店mate40pro', 6099.00, 100, 0, NULL, 0.00, 0, '', NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01OpTSba1VubD4cpJiK_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/TB2vbKTgHArBKNjSZFLXXc_dVXa_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01sx3JEX1VubD1UVV2U_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01sdVgGG1VubD6nfEk2_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01E5ZlFd1VubD0EZtoL_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN017LAhra1VubD1kTfYK_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01KshuGt1VubCxenTQB_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN019lwo3i1VubCxensNV_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01t6VwkB1VubCwERR3M_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01fgufJg1VubD3lMoyR_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01cFbUtW1VubD0COovF_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01Nust0w1VubCyEFnBT_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01vdxhTK1VubCwEQxxC_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01pSl16B1VubD6nfZYg_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01fEsRon1VubD5yY1I5_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01GkA7tk1VubD5HOdxy_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01FuKFpI1VubD3lMkpz_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN019lxW3z1VubCyEHwFo_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01vJmvHM1VubD3lNUaN_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01KaZsux1VubD0EaR7O_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01YZKHTG1VubCyEI0PM_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01vwN4pf1VubD6nfZaA_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01bnWqPs1VubD4FKIm5_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01h7LRGx1VubD7S6AjB_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01Viu4Dv1VubD0EbAra_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN010G61NF1VubCxeqxic_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01QoAWzw1VubD4FMz8a_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01A0WT2r1VubD5HOAu4_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01okBoN01VubD7S7JR7_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01OSQJ7j1VubCxer1sm_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01G4SAhi1VubD0CNgHm_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN013kwXkx1VubD1UUE8L_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01mM9F5M1VubD3lMp38_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01w43zZC1VubD3lMxOu_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01KEAHr81VubD2thVNn_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01b6L78y1VubD3lOlo5_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01EMbdi71VubD0CSVuo_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01lqmpDD1VubCyELy1T_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01prLTNk1VubD2tkvbR_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN0148r2OR1VubD5yeWyk_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01hH3KsL1VubD4FRcPJ_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01PLwvsZ1VubD7S9roB_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01n8k5z81VubCwEY0yj_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN016X8IZj1Vub8wYRqqN_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, '华为', '手机数码');
INSERT INTO `pms_product` VALUES (16, 3, 30, 0, 3, '【旗舰新品】华为P50 Pro 4G全网通搭载HarmonyOS 2麒麟9000华为手机华为官方旗舰店正品p50pro', 'https://img.alicdn.com/imgextra/i4/2024314280/O1CN01mT2FdK1hUHrFa4LK6_!!2024314280.jpg_430x430q90.jpg', '2343525', 0, 1, 1, 1, 1, 0, 8, 7488.00, NULL, 0, 0, 0, '【旗舰新品】华为P50 Pro 4G全网通搭载HarmonyOS 2麒麟9000华为手机华为官方旗舰店正品p50pro', '【旗舰新品】华为P50 Pro 4G全网通搭载HarmonyOS 2麒麟9000华为手机华为官方旗舰店正品p50pro', 7488.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01YWuuBq1VubDpYER3N_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01g58P1h1VubDn732oG_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01hF9lQa1VubDyuDzRD_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN013YCfRy1VubDrDmHeW_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01Ga8cYr1VubDiT2RLQ_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01pPGzmj1VubDxIOrTK_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN016eLylU1VubDiT3NVH_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01guAY1F1VubDiT32ke_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01x3kHec1VubDv21Ppv_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01vqUraq1VubDxINzQb_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN018hejDS1VubDsuoCMW_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01lyS8Ky1VubDseSSnj_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01bzmTWn1VubDv1zbYR_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01uKW7n11VubDrDpEdN_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN018o2TZY1VubDv22M5E_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN014Hut9u1VubDv23hDW_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01kZG6xc1VubDrmkC9w_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01827RQs1VubDiT32mG_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01wQiWn41VubDn76w4W_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01yUKC0p1VubDvWvpuc_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01BFQJ1t1VubDn74ipm_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01ZTGV5e1VubDyuG0B7_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01KaAHJU1VubDwZMXKb_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01ruCNZC1VubDxIOnMf_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01GTHHBC1VubDwZKBoL_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01WSgoeH1VubDoaSKPQ_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01ls9TFS1VubDsunSgN_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01dZFjOj1VubDxIPCJM_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN014OwcN31VubDv23lPk_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01JbKPjX1Vub8xCTg6O_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> </p>', NULL, NULL, NULL, 0, 0, '华为', '手机数码');
INSERT INTO `pms_product` VALUES (17, 3, 30, 0, 3, '华为平板HUAWEI MatePad Pro 10.8英寸2021款鸿蒙HarmonyOS官方新品教育数码学生电脑8GB内存', 'https://img.alicdn.com/imgextra/i2/2838892713/O1CN016tezkQ1VubD4AbBxX_!!2838892713.jpg_430x430q90.jpg', '2425343', 0, 1, 1, 1, 1, 0, 9, 4299.00, NULL, 0, 0, 0, '华为平板HUAWEI MatePad Pro 10.8英寸2021款鸿蒙HarmonyOS官方新品教育数码学生电脑8GB内存', '华为平板HUAWEI MatePad Pro 10.8英寸2021款鸿蒙HarmonyOS官方新品教育数码学生电脑8GB内存', 4299.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01cIJDXV1VubEEzKcok_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN012SbO6Z1VubDN6DYs0_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01fwQYhJ1VubD63d9KS_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01aGIm7X1VubD2yy2qn_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01ME0Yh91VubDlhNt03_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01pHh6r11Vub9uANS94_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01mOFtWp1VubDYe3G9Z_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01DmOiIr1VubDX3O23R_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\" data-spm-anchor-id=\"a220o.1000855.0.i0.494e35ae0Eipxj\"><img src=\"https://img.alicdn.com/imgextra/i3/2838892713/O1CN01H5yIwO1VubDYe1iUD_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2838892713/O1CN01vnR8iy1VubDRCD8Ob_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01teVwo81VubDRCDo00_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN0110oYhX1VubDWM9gqO_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN013b7tAq1VubDYe5L35_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01cIRc5q1VubDWM8HWq_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01EFSvBZ1VubDRCGp97_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2838892713/O1CN01Rq1tdY1VubDWM8Lhr_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2838892713/O1CN01AyimLk1Vub8sk4O3e_!!2838892713.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, '华为', '手机数码');
INSERT INTO `pms_product` VALUES (18, 10, 31, 0, 3, 'Apple/苹果 iPhone 12 国行手机', 'https://img.alicdn.com/imgextra/i1/1917047079/O1CN01xeHXfg22AEQKtkTiK_!!1917047079.png_430x430q90.jpg', '1243543', 0, 1, 1, 1, 1, 0, 10, 6799.00, NULL, 0, 0, 0, 'Apple/苹果 iPhone 12【直营国行】Apple/苹果 AirPods Pro耳机三代原装正品 全国联保', 'Apple/苹果 iPhone 12', 6799.00, 199, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<div class=\"content ke-post\" style=\"height: auto;\"><div style=\"width: 790.0px;\">	<div style=\"float: left;\">		 <img src=\"https://img.alicdn.com/imgextra/i4/1917047079/O1CN01m365lv22AERZKUNBg_!!1917047079.jpg\" width=\"790\" border=\"0\" class=\"img-ks-lazyload\">	</div>	<div style=\"float: left;margin-top: 6.0px;\">		 <img src=\"https://img.alicdn.com/imgextra/i3/1917047079/O1CN01DUglFy22AESAm9BFq_!!1917047079.jpg\" width=\"790\" border=\"0\" class=\"img-ks-lazyload\">	</div>	<div style=\"float: left;\">		 <img src=\"https://img.alicdn.com/imgextra/i1/1917047079/O1CN01H0KILj22AERzyp2VZ_!!1917047079.jpg\" width=\"790\" border=\"0\" class=\"img-ks-lazyload\">	</div>	<div style=\"float: left;\">		 <img src=\"https://img.alicdn.com/imgextra/i4/1917047079/O1CN01nLojAj22AERtg5MjN_!!1917047079.jpg\" width=\"790\" border=\"0\" class=\"img-ks-lazyload\">	</div>	<div style=\"float: left;\">		 <img src=\"https://img.alicdn.com/imgextra/i4/1917047079/O1CN01kesoUZ22AERtvONkH_!!1917047079.jpg\" width=\"790\" border=\"0\" class=\"img-ks-lazyload\">	</div>	<div style=\"float: left;\">		 <img src=\"https://img.alicdn.com/imgextra/i4/1917047079/O1CN01DLhGVL22AEOYEuVHp_!!1917047079.jpg\" width=\"790\" border=\"0\" class=\"img-ks-lazyload\">	</div></div></div>', NULL, NULL, NULL, 0, 0, '苹果', '手机数码');
INSERT INTO `pms_product` VALUES (19, 10, 31, 0, 3, '【直营国行】Apple/苹果 AirPods Pro耳机三代原装正品 全国联保', 'https://img.alicdn.com/imgextra/i2/2200877014436/O1CN01anNk4S1idjZTDktag_!!2200877014436.jpg_430x430q90.jpg', '2354344', 0, 1, 1, 1, 1, 0, 7, 1778.00, NULL, 0, 0, 0, '【直营国行】Apple/苹果 AirPods Pro耳机三代原装正品 全国联保', '【直营国行】Apple/苹果 AirPods Pro耳机三代原装正品 全国联保', 1778.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN01TBYQAD26TFHLj8qqx_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN018fGCQU26TFHOCaxVd_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2208774577662/O1CN01TA2FYd26TFHMJK9wz_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2208774577662/O1CN01KuXr9f26TFHMSY10j_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2208774577662/O1CN015y7q0m26TFHQonltB_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN01hXTx5T26TFHPzhhDg_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2208774577662/O1CN01j6RF9826TFHR9H16P_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN010WFToD26TFHMJI55s_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN01tc4qV326TFHLn9rTf_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2208774577662/O1CN01XFNWaG26TFHMSaEEz_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN01RcIhuQ26TFHOCZcLq_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN01P1v1s926TFHJiPRJA_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2208774577662/O1CN01bawyiF26TFHPLtIY9_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN01skzS1c26TFJQ51Vup_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2208774577662/O1CN01jvSnhj26TFJRxjwE2_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2208774577662/O1CN01WjWtis26TFJTkm6ab_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2208774577662/O1CN01VdZldp26TFJZt1W1w_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2208774577662/O1CN01zm24T226TFJRxjGe5_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2208774577662/O1CN01QhVaqH26TFJWz0HMX_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2208774577662/O1CN014ldHx426TFJRLWMIQ_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2208774577662/O1CN01EXQMmE26TFJV8Dp6B_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2208774577662/O1CN011IYQUp26TFJRxlPjX_!!2208774577662-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, '苹果', '手机数码');
INSERT INTO `pms_product` VALUES (20, 10, 31, 0, 3, 'Apple/苹果 11 英寸 iPad Pro', 'https://img.alicdn.com/imgextra/i1/1917047079/O1CN01qC9RZb22AEQNIo08f_!!2-item_pic.png_430x430q90.jpg', '2343534', 0, 1, 1, 1, 1, 0, 15, 6999.00, NULL, 0, 0, 0, 'Apple/苹果 11 英寸 iPad Pro', 'Apple/苹果 11 英寸 iPad Pro', 6999.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<div style=\"float: left;margin-top: 6.0px;\">		 <img src=\"https://img.alicdn.com/imgextra/i1/1917047079/O1CN01JZhXa422AEQSb3ocg_!!1917047079.png\" width=\"790\" border=\"0\" class=\"img-ks-lazyload\"></div><div style=\"float: left;margin-top: 6.0px;\">		 <img src=\"https://img.alicdn.com/imgextra/i4/1917047079/O1CN01nMg2h122AEQQPt9Po_!!1917047079.png\" width=\"790\" border=\"0\" class=\"img-ks-lazyload\">	</div>', NULL, NULL, NULL, 0, 0, '苹果', '手机数码');
INSERT INTO `pms_product` VALUES (21, 6, 34, 0, 3, '小米MIX 4CUP全面屏骁龙888+智能电竞游戏小米官方旗舰店5g手机新款小米mix4小米手机小米11红米', 'https://img.alicdn.com/imgextra/O1CN016FuwY324luG6F3Vck_!!6000000007432-0-remus.jpg_430x430q90.jpg', '3543345', 0, 1, 1, 1, 1, 0, 7, 5598.00, NULL, 0, 0, 0, '小米MIX 4CUP全面屏骁龙888+智能电竞游戏小米官方旗舰店5g手机新款小米mix4小米手机小米11红米Xiaomi/小米 11 Ultra 5G手机全网通官方旗舰店正品官网至尊版系列10新款pro红米青春手机', '小米MIX 4CUP全面屏骁龙888+智能电竞游戏小米官方旗舰店5g手机新款小米mix4小米手机小米11红米', 5598.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<div class=\"content ke-post\" style=\"height: auto;\"><p><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN018XqdEH29zFshRnytX_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01EFcvPs29zFsukZ9ar_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p> <p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 6重好礼去往手机端查看</p> <p><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01mXZUjZ29zFsmO1xXH_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1714128138/O1CN01ljotnq29zFsmO3ANm_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01kvjUDh29zFsiSfDdq_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01sxpn4H29zFslMSMPC_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01m1SU9o29zFseNPLCJ_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN010envFK29zFsmO1l4A_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01eGo5YL29zFsYFmtd4_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01zrQj5C29zFsctWz7D_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01GxcCP029zFseNNKRX_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01fgmBqm29zFsfwNQSd_!!1714128138.gif\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1714128138/O1CN01PfQwVX29zFsah2YjC_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1714128138/O1CN01O8jD4Z29zFsn7N97c_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01wAu8G229zFsij6rJF_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1714128138/O1CN011VF6RT29zFskrKF4n_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1714128138/O1CN01LkDyih29zFseNNb4Y_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p> <p><img src=\"https://img.alicdn.com/imgextra/i1/1714128138/O1CN013ceVUf29zFsvTgZdo_!!1714128138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p></div>', NULL, NULL, NULL, 0, 0, '小米', '手机数码');
INSERT INTO `pms_product` VALUES (22, 6, 34, 0, 3, 'Xiaomi/小米 11 Ultra 5G手机全网通官方旗舰店正品官网至尊版系列10新款pro红米青春手机', 'https://img.alicdn.com/imgextra/i1/2279837698/O1CN016r3Dsh26jjcIUgSsU_!!2279837698.jpg_430x430q90.jpg', '2353522', 0, 1, 1, 1, 1, 0, 8, 7599.00, NULL, 0, 0, 0, 'Xiaomi/小米 11 Ultra 5G手机全网通官方旗舰店正品官网至尊版系列10新款pro红米青春手机', 'Xiaomi/小米 11 Ultra 5G手机全网通官方旗舰店正品官网至尊版系列10新款pro红米青春手机', 7599.00, 100, 0, '', 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<div class=\"content ke-post\" style=\"height: auto;\"><p><img src=\"https://img.alicdn.com/imgextra/i2/2279837698/O1CN01yy0HLV26jjcHkFXMG_!!2279837698.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2279837698/O1CN01nExqp626jjcBHgYIb_!!2279837698.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2279837698/O1CN01QQZb3j26jjc8ZUQVp_!!2279837698.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2279837698/O1CN01tcWrPk26jjcCPpzw1_!!2279837698.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2279837698/O1CN01QHADse26jjc824n1l_!!2279837698.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2279837698/O1CN012FZxND26jjc8ZVMjJ_!!2279837698.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2279837698/O1CN01ImBALt26jjcAmY277_!!2279837698.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2279837698/O1CN01Fcu6VP26jjc826w4W_!!2279837698.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i4/2279837698/O1CN01ZQNVVv26jjcCPs4ph_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i3/2279837698/O1CN013ylXZu26jjcDaeFR6_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i1/2279837698/O1CN01pbDG1N26jjcCPssjV_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i2/2279837698/O1CN01Yd92nT26jjcC8Rwlr_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i1/2279837698/O1CN01hDlLP826jjc6XHR5q_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i4/2279837698/O1CN01qg0gDr26jjcC8Qfn3_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i3/2279837698/O1CN0129wtV426jjcG7h5tH_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i2/2279837698/O1CN01mVRrtr26jjcG7dfnw_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i1/2279837698/O1CN01w67M8h26jjcGq81gK_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i1/2279837698/O1CN01w6reEM26jjcF3GbIP_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i2/2279837698/O1CN010iYqtR26jjcDabpn9_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i2/2279837698/O1CN01bagS5U26jjcC8Pjaw_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i3/2279837698/O1CN01c5odgv26jjcIUkpOj_!!2279837698.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i3/2279837698/O1CN01vbjWzi26jjcEZIidt_!!2279837698.jpg\" align=\"absmiddle\"> </p></div>', NULL, NULL, NULL, 0, 0, '小米', '手机数码');
INSERT INTO `pms_product` VALUES (23, 13, 21, 0, 5, '新款 周大福珠宝首饰福字足金黄金手链计价F222900精选', 'https://img.alicdn.com/imgextra/i3/407700539/O1CN01hPH4eF1FquAsynxJN_!!0-item_pic.jpg_430x430q90.jpg', '5453434', 0, 1, 1, 1, 1, 0, 32, 728.00, NULL, 0, 0, 0, '新款 周大福珠宝首饰福字足金黄金手链计价F222900精选', '新款 周大福珠宝首饰福字足金黄金手链计价F222900精选', 728.00, 100, 0, '', 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p style=\"text-align: center;\"><img src=\"https://img.alicdn.com/imgextra/i1/407700539/O1CN01fzUMnw1Fqu5WUoAKN_!!407700539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/407700539/O1CN01AWCSRQ1FquAk8CyLk_!!407700539.jpg\" align=\"absmiddle\" style=\"width: 550.0px;\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/407700539/O1CN01UqiaZs1FquAj2KVtI_!!407700539.jpg\" align=\"absmiddle\" style=\"width: 550.0px;\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/407700539/O1CN01Pam5rT1FquAiSDN0a_!!407700539.jpg\" align=\"absmiddle\" style=\"width: 550.0px;\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/407700539/TB263NhaGAoBKNjSZSyXXaHAVXa-407700539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/407700539/TB2RpeQXYZnBKNjSZFKXXcGOVXa-407700539.png\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i1/407700539/TB2KcmHdVXXXXXtXXXXXXXXXXXX_!!407700539.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i3/407700539/O1CN01CTAqWI1Fqu51USdnk_!!407700539.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i1/407700539/O1CN0124HtsB1FquAiwEwbR_!!407700539.jpg\" align=\"absmiddle\"><img src=\"//img-tmdetail.alicdn.com/tps/i3/T1BYd_XwFcXXb9RTPq-90-90.png\" data-ks-lazyload=\"https://img.alicdn.com/imgextra/i1/407700539/TB2sQ64b9CWBuNjy0FhXXb6EVXa-407700539.jpg\" align=\"absmiddle\"></p>', NULL, NULL, NULL, 0, 0, '范思哲', '手链');
INSERT INTO `pms_product` VALUES (24, 13, 20, 0, 5, '施华洛世奇 SWAROVSKI INFINITY 女项链礼物', 'https://img.alicdn.com/imgextra/https://img.alicdn.com/imgextra/i2/2576722561/O1CN01iPI1O21UmyzT2KOC9_!!2576722561.jpg_430x430q90.jpg', '5352312', 0, 1, 1, 1, 1, 0, 15, 1290.00, NULL, 0, 0, 0, '施华洛世奇 SWAROVSKI INFINITY 女项链礼物', '施华洛世奇 SWAROVSKI INFINITY 女项链礼物', 1290.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i1/2576722561/O1CN01Wi2Kxb1Umz1FK4HP4_!!2576722561.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2576722561/O1CN01cXYfC91Umz1Ckd8Hg_!!2576722561.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2576722561/O1CN01wCvQAX1Umz1B81fVp_!!2576722561.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2576722561/O1CN01lmWNVr1Umz16zF8fT_!!2576722561.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2576722561/O1CN01fEKi5a1Umz1H4jxbB_!!2576722561.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, '施华洛世奇', NULL);
INSERT INTO `pms_product` VALUES (25, 13, 21, 0, 5, '天王表钢带简约情侣手表男士女士休闲石英表生日礼物3798', 'https://img.alicdn.com/imgextra/i3/1125378539/TB2mCXLX6TpK1RjSZKPXXa3UpXa_!!1125378539.jpg_430x430q90.jpg', '3534534', 0, 1, 1, 1, 1, 0, 18, 1199.00, NULL, 0, 0, 0, '天王表钢带简约情侣手表男士女士休闲石英表生日礼物3798', '天王表钢带简约情侣手表男士女士休闲石英表生日礼物3798', 1199.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i2/1125378539/O1CN01wi3pFK2CwugOYAdVV_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1125378539/O1CN01FtB1302CwugJ0NylQ_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1125378539/O1CN01XZRPBT2CwugHUJ8O9_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1125378539/O1CN01bLoTDu2CwugKwMsbl_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1125378539/O1CN01WmXuYu2CwugJ0Ly2F_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1125378539/O1CN01xHaeQT2Cwug8tnEfo_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1125378539/O1CN012BIR4Y2CwugN7x3aG_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1125378539/O1CN01qbcq8A2CwugHYqHqO_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1125378539/O1CN01Dle9bH2CwugFYQD4y_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1125378539/O1CN01SbkTUV2CwugN7yX2L_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1125378539/O1CN016tksZX2Cwugnb5Lse_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1125378539/O1CN01pk15392CwugOYC6z5_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1125378539/O1CN012sEGp52CwugHYpgRR_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1125378539/O1CN010hMgYU2CwugIjtihq_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/1125378539/O1CN01Ha01As2CwugIjtr23_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1125378539/O1CN01xSMC7U2CwugJ0Kxej_!!1125378539.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, NULL, '耳机');
INSERT INTO `pms_product` VALUES (26, 13, 35, 0, 5, 'Beats Solo Pro头戴式耳机无线蓝牙b魔音降噪运动耳麦高音质', 'https://img.alicdn.com/imgextra/i4/647482297/O1CN01WcLlx41Sq4SglOLBs_!!647482297.jpg_430x430q90.jpg', '5352342', 0, 1, 1, 1, 1, 0, 16, 1399.00, NULL, 0, 0, 0, 'Beats Solo Pro头戴式耳机无线蓝牙b魔音降噪运动耳麦高音质', 'Beats Solo Pro头戴式耳机无线蓝牙b魔音降噪运动耳麦高音质', 1399.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i2/647482297/O1CN01MnmORS1Sq4SxSmZGI_!!647482297.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/647482297/O1CN01NXdU4o1Sq4T5aQHLf_!!647482297.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/647482297/O1CN017DdaDk1Sq4T9X3A3E_!!647482297.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/647482297/O1CN01Mokk521Sq4T79L0rB_!!647482297.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/647482297/O1CN01TPuzdK1Sq4T1iBHvA_!!647482297.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/647482297/O1CN01HMaNmK1Sq4SxSjgRP_!!647482297.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/647482297/O1CN01uqrlkm1Sq4T4ZVplM_!!647482297.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/647482297/O1CN01HMujdY1Sq4T63tY2E_!!647482297.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, NULL, '次时代主机');
INSERT INTO `pms_product` VALUES (27, 13, 36, 0, 5, '索尼PS5主机 电视游戏机 无光驱版 超 蓝光8K 日版家用单机怪物', 'https://img.alicdn.com/imgextra/i1/2200877014436/O1CN016ekYBX1idjahukrhA_!!2200877014436.jpg_430x430q90.jpg', '3532343', 0, 1, 1, 1, 1, 0, 3, 5978.00, NULL, 0, 0, 0, '索尼PS5主机 电视游戏机 无光驱版 超 蓝光8K 日版家用单机怪物', '索尼PS5主机 电视游戏机 无光驱版 超 蓝光8K 日版家用单机怪物', 5978.00, 199, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i4/3596652968/O1CN01Oosbmu1XnOAEfSgVb_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/3596652968/O1CN01NR0qUm1XnOANtcaLI_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/3596652968/O1CN01K8q3ln1XnOASj7VcP_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/3596652968/O1CN01sFmGLE1XnOAQFd8Ie_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/3596652968/O1CN01COdpEW1XnOANGRrFD_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/3596652968/O1CN01IFWogx1XnOAT7JMeP_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/3596652968/O1CN01G6OC4e1XnOAN48nk7_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/3596652968/O1CN01rQkysO1XnOARqP8ai_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/3596652968/O1CN01KBZSSY1XnOAEfZCEF_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/3596652968/O1CN01TSgSAC1XnOAKZGQgB_!!3596652968-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> </p>', NULL, NULL, NULL, 0, 0, NULL, '次时代主机');
INSERT INTO `pms_product` VALUES (28, 13, 37, 0, 5, '日本直邮Nintendo/任天堂Switch掌上游戏机NS红蓝手柄续航增强版', 'https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01BqPY9s1vlbMPxJiEh_!!2201168176213.jpg_430x430q90.jpg', '5435432', 0, 1, 1, 1, 1, 0, 4, 2599.00, NULL, 0, 0, 0, '日本直邮Nintendo/任天堂Switch掌上游戏机NS红蓝手柄续航增强版', '日本直邮Nintendo/任天堂Switch掌上游戏机NS红蓝手柄续航增强版', 2599.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<div class=\"content ke-post\" style=\"height: auto;\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i2/2201168176213/O1CN012CRXXX1vlbPphjezH_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01MdAfgE1vlbHcbnRPn_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i4/2201168176213/O1CN013AiaqL1vlbS92pX7W_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i3/2201168176213/O1CN01B5fQQy1vlbSDIWeqS_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN019QyH8Z1vlbSCnjHrB_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01CK5URe1vlbS6LK6Yc_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01Buy4Rj1vlbSGfdrkw_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01SmMssQ1vlbSGfe4D8_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i4/2201168176213/O1CN01CgQBZO1vlbS9YIC84_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i4/2201168176213/O1CN01RMmGJ11vlbSF4By1t_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i4/2201168176213/O1CN01CePTYx1vlbMOXCe89_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i4/2201168176213/O1CN01UwIinW1vlbQWTHXYE_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01XwKIbd1vlbQaVApZy_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01flPWJB1vlbHcwtUIF_!!2201168176213.jpg\" class=\"img-ks-lazyload\"><img width=\"790px\" style=\"display: block;\" src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01eftHq81vlbQTrrQNK_!!2201168176213.jpg\" class=\"img-ks-lazyload\"></div>', NULL, NULL, NULL, 0, 0, '眼镜厂', '手办玩具');
INSERT INTO `pms_product` VALUES (29, 13, 60, 0, 5, '日本直邮海贼王超级DX波特卡斯?D?艾斯 26mm 人偶', 'https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01X5D1o01vlbRMW5gCH_!!2201168176213.jpg_430x430q90.jpg', '5432311', 0, 1, 1, 1, 1, 0, 20, 479.00, NULL, 0, 0, 0, '日本直邮海贼王超级DX波特卡斯?D?艾斯 26mm 人偶', '日本直邮海贼王超级DX波特卡斯?D?艾斯 26mm 人偶', 479.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<div class=\"content ke-post\" style=\"height: auto;\"><img src=\"https://img.alicdn.com/imgextra/i2/2201168176213/O1CN012CRXXX1vlbPphjezH_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01MdAfgE1vlbHcbnRPn_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01zGwXI11vlbRUC3Esj_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01zGwXI11vlbRUC3Esj_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2201168176213/O1CN01F4HdWS1vlbRWOIljo_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01R01VvS1vlbRWOIyDd_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01BPAHxo1vlbRP4xiGo_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01MDrL1l1vlbRL4cUqc_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2201168176213/O1CN01UwIinW1vlbQWTHXYE_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01XwKIbd1vlbQaVApZy_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01flPWJB1vlbHcwtUIF_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2201168176213/O1CN01eftHq81vlbQTrrQNK_!!2201168176213.jpg\" style=\"display: block;\" width=\"790px\" class=\"img-ks-lazyload\"></div>', NULL, NULL, NULL, 0, 0, '眼镜厂', '手办玩具');
INSERT INTO `pms_product` VALUES (30, 13, 61, 0, 5, '新品 眼镜厂 鬼灭之刃景品手办 绊之装玖之型蝴蝶忍', 'https://img.alicdn.com/imgextra/i3/833261111/O1CN014MMkx01K4sfv0hKnn_!!833261111.png_430x430q90.jpg', '6343122', 0, 1, 1, 1, 1, 0, 5, 139.00, NULL, 0, 0, 0, '新品 眼镜厂 鬼灭之刃景品手办 绊之装玖之型蝴蝶忍', '新品 眼镜厂 鬼灭之刃景品手办 绊之装玖之型蝴蝶忍', 139.00, 199, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i3/833261111/O1CN01GVhTK31K4sfEG9nHh_!!833261111.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, '眼镜厂', '手办玩具');
INSERT INTO `pms_product` VALUES (31, 13, 61, 0, 5, '新品 眼镜厂  鬼灭之刃 绊之装陆之型 炭治郎', 'https://img.alicdn.com/imgextra/i1/833261111/O1CN01yB5M6b1K4saHiFU5A_!!833261111.jpg_430x430q90.jpg', '4363781', 0, 1, 1, 1, 1, 0, 1, 179.00, NULL, 0, 0, 0, '新品 眼镜厂  鬼灭之刃 绊之装陆之型 炭治郎', '新品 眼镜厂  鬼灭之刃 绊之装陆之型 炭治郎', 179.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i3/833261111/O1CN01LJ9xCC1K4sgH5A1Kz_!!833261111.jpg\" alt=\"万代商品详情页修DEMO-0927_02_01.jpg\" class=\"img-ks-lazyload\"> <a href=\"https://bandai.tmall.com/p/rd655524.htm\" target=\"_blank\"><img src=\"https://img.alicdn.com/imgextra/i1/833261111/O1CN01VHLOGn1K4seJr5x3z_!!833261111.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></a> <img src=\"https://img.alicdn.com/imgextra/i1/833261111/O1CN010wkTVa1K4seGEap1z_!!833261111.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> <img src=\"https://img.alicdn.com/imgextra/i3/833261111/O1CN01sdJhKw1K4sj7JQuQz_!!833261111.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/833261111/O1CN014oouZr1K4saJc64Hz_!!833261111.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, '眼镜厂', '手办玩具');
INSERT INTO `pms_product` VALUES (32, 13, 64, 0, 5, '现货 眼镜厂 海外限定 SMSP 孙悟空 漫画色 龙珠 赛亚人手办 景品', 'https://gd1.alicdn.com/imgextra/i1/612966252/O1CN01airkQ51w3Stv4zncN_!!612966252.jpg', '5432232', 0, 1, 1, 1, 1, 0, 3, 285.00, NULL, 0, 0, 0, '现货 眼镜厂 海外限定 SMSP 孙悟空 漫画色 龙珠 赛亚人手办 景品', '现货 眼镜厂 海外限定 SMSP 孙悟空 漫画色 龙珠 赛亚人手办 景品', 285.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/612966252/O1CN01Zfd3qs1w3St4dFo46_!!612966252.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/612966252/O1CN01dGpyDQ1w3St3rpzOn_!!612966252.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/612966252/O1CN01bfrrgb1w3SsuzsrOT_!!612966252.jpg\" style=\"max-width: 750.0px;\"></p>', NULL, NULL, NULL, 0, 0, '眼镜厂', '手办玩具');
INSERT INTO `pms_product` VALUES (33, 13, 66, 0, 5, '海洋堂新世纪福音战士EVA成品初号机', 'https://gd3.alicdn.com/imgextra/i3/3381629725/O1CN01QaB5cG2Li6E4KJn0M_!!3381629725.jpg_400x400.jpg', '5435341', 0, 1, 1, 1, 1, 0, 24, 228.00, NULL, 0, 0, 0, '海洋堂新世纪福音战士EVA成品初号机', '海洋堂新世纪福音战士EVA成品初号机', 228.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/3381629725/O1CN01DZM08k2Li6IfoLMoZ_!!3381629725.png\" style=\"max-width: 750.0px;\"></p>', NULL, NULL, NULL, 0, 0, '眼镜厂', '手办玩具');
INSERT INTO `pms_product` VALUES (34, 13, 66, 0, 5, '[全款预售]SEGA EVA新世纪福音战士剧场版终 明日香 景品手办', 'https://img.alicdn.com/imgextra/i1/1916629511/O1CN01mmZBhe2K85g7wOxfd_!!1916629511.jpg_430x430q90.jpg', '5464542', 0, 1, 1, 1, 1, 0, 25, 999.00, NULL, 0, 0, 0, '[全款预售]SEGA EVA新世纪福音战士剧场版终 明日香 景品手办', '[全款预售]SEGA EVA新世纪福音战士剧场版终 明日香 景品手办', 999.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<div> <img src=\"https://img.alicdn.com/imgextra/i1/1916629511/O1CN01ByUd5t2K85gF4RjPp_!!1916629511.jpg\" alt=\"详情1.jpg\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1916629511/O1CN01SoqQDn2K85g7R2Csk_!!1916629511.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/1916629511/O1CN01zD9Y0L2K85g950GLC_!!1916629511.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/1916629511/O1CN01Dk3kJt2K85gAERFul_!!1916629511.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/1916629511/O1CN01b1GIIn2K85gAERahr_!!1916629511.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> </div>', NULL, NULL, NULL, 0, 0, '眼镜厂', '手办玩具');
INSERT INTO `pms_product` VALUES (35, 13, 66, 0, 5, '日本寿屋 新世纪福音战士 EVA 绫波零手办摆件青少年成人玩具收藏', 'https://img.alicdn.com/imgextra/i1/2200877014436/O1CN01C00EWE1idjdHq0XHC_!!2200877014436.jpg_430x430q90.jpg', '6433215', 0, 1, 1, 1, 1, 0, 24, 685.00, NULL, 0, 0, 0, '日本寿屋 新世纪福音战士 EVA 绫波零手办摆件青少年成人玩具收藏', '日本寿屋 新世纪福音战士 EVA 绫波零手办摆件青少年成人玩具收藏', 685.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i2/2207611753309/O1CN01E028HG1aJZGOC5wWs_!!2207611753309-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> </p>', NULL, NULL, NULL, 0, 0, '眼镜厂', '手办玩具');
INSERT INTO `pms_product` VALUES (36, 13, 66, 0, 5, '【直营】BANDAI万代Figure-rise Standard86不存在的战区蕾娜手办', 'https://img.alicdn.com/imgextra/i4/2200877014436/O1CN01JSPiOI1idjdZCtMHb_!!2200877014436.jpg_430x430q90.jpg', '4645657', 0, 1, 1, 1, 1, 0, 23, 169.00, NULL, 0, 0, 0, '【直营】BANDAI万代Figure-rise Standard86不存在的战区蕾娜手办', '【直营】BANDAI万代Figure-rise Standard86不存在的战区蕾娜手办', 169.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i4/2207611753309/O1CN01xC1nWy1aJZGpaTdnp_!!2207611753309-0-scmitem1000.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"></p>', NULL, NULL, NULL, 0, 0, '眼镜厂', '手办玩具');
INSERT INTO `pms_product` VALUES (37, 13, 65, 0, 5, '乐高机械组成人乐高布加迪威龙 Bugatti Chiron拼插积木玩具42083', 'https://img.alicdn.com/imgextra/i2/594767740/O1CN01KBVDeF272yAoep8KZ_!!594767740.jpg_430x430q90.jpg', '5847988', 0, 1, 1, 1, 1, 0, 19, 2249.00, NULL, 0, 0, 0, '乐高机械组成人乐高布加迪威龙 Bugatti Chiron拼插积木玩具42083', '乐高机械组成人乐高布加迪威龙 Bugatti Chiron拼插积木玩具42083', 2249.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i3/594767740/O1CN01vP0Mjs272yAv2Opxz_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/594767740/O1CN01MwchnI272yAxMkXAf_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/594767740/O1CN01HnN5zQ272yAwXNLFX_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/594767740/O1CN01oNcrcx272yAuitLA5_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/594767740/O1CN01Na2Fz3272yAuiu0lJ_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/594767740/O1CN01uJEmex272yAwXPp79_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/594767740/O1CN013bN2db272yAwXOHSZ_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/594767740/O1CN01w27Li7272yAqBTQMD_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/594767740/O1CN01Y0L5NS272yAvtZPR1_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/594767740/O1CN01CeEChk272yAsCPrXv_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/594767740/O1CN01hEDzlR272yAsz14Tc_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/594767740/O1CN01s28xtV272yAsoJZoJ_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/594767740/O1CN01TflNdB272yAjzrJkR_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/594767740/O1CN011ErMej272yAuiuTtB_!!594767740.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> </p>', NULL, NULL, NULL, 0, 0, '眼镜厂', '手办玩具');
INSERT INTO `pms_product` VALUES (38, 13, 62, 0, 5, '火影忍者手办 羁绊火焰宇智波鼬 佐助动漫手办模型摆件盒装礼品', 'https://img.alicdn.com/imgextra/i2/2865745622/O1CN01HfoCnq1rOvJbQlMA8_!!0-item_pic.jpg_430x430q90.jpg', '6938233', 0, 1, 1, 1, 1, 0, 22, 599.00, NULL, 0, 0, 0, '火影忍者手办 羁绊火焰宇智波鼬 佐助动漫手办模型摆件盒装礼品', '火影忍者手办 羁绊火焰宇智波鼬 佐助动漫手办模型摆件盒装礼品', 599.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i4/2865745622/O1CN01Vgh0gE1rOvJgt7TVh_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2865745622/O1CN01sgtpVw1rOvJhm8qcA_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2865745622/O1CN01BrJAVB1rOvJdc7EXc_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2865745622/O1CN01BMWuO21rOvJfqzVGm_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2865745622/O1CN01CMKpxe1rOvJbreiAY_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2865745622/O1CN01cMmCXM1rOvJbrfzAJ_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2865745622/O1CN01MXGMa71rOvJekm6IV_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2865745622/O1CN01uxavGt1rOvJgt7XgF_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2865745622/O1CN01uFTkvo1rOvJdc8NFB_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2865745622/O1CN01kz1ETJ1rOvJeZLh9R_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2865745622/O1CN01flJMDi1rOvJiPtDcb_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2865745622/O1CN01TmWpdF1rOvJjIQBB8_!!2865745622.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> </p>', NULL, NULL, NULL, 0, 0, '眼镜厂', '手办玩具');
INSERT INTO `pms_product` VALUES (39, 1, 53, 0, 13, '北欧简约山形纹绣花抱枕 精细刺绣，舒适立体', 'http://yanxuan.nosdn.127.net/dbc5b25b824c3b3d7ff43b56ca35eee9.png', '2354545', 0, 1, 1, 1, 1, 0, 42, 99.00, NULL, 0, 0, 0, '北欧简约山形纹绣花抱枕 精细刺绣，舒适立体', '北欧简约山形纹绣花抱枕 精细刺绣，舒适立体', 99.00, 199, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"http://yanxuan.nosdn.127.net/5737ca831d2cd44a2242eb0992583faf.jpg\" _src=\"http://yanxuan.nosdn.127.net/5737ca831d2cd44a2242eb0992583faf.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/1160e68bcdeba98d2aada60af18c03c8.jpg\" _src=\"http://yanxuan.nosdn.127.net/1160e68bcdeba98d2aada60af18c03c8.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/c3772cb0d0f4767217726f9af7faa396.jpg\" _src=\"http://yanxuan.nosdn.127.net/c3772cb0d0f4767217726f9af7faa396.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/715a7f19500f5c28d9f73d37ebb1c557.jpg\" _src=\"http://yanxuan.nosdn.127.net/715a7f19500f5c28d9f73d37ebb1c557.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/84238cd8ab59b2fe193b825a3e89fd65.jpg\" _src=\"http://yanxuan.nosdn.127.net/84238cd8ab59b2fe193b825a3e89fd65.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f4efe768f21095587d8bb4db202b2e23.jpg\" _src=\"http://yanxuan.nosdn.127.net/f4efe768f21095587d8bb4db202b2e23.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/dbb5a935340a7ff61de6bec5fa3fd985.jpg\" _src=\"http://yanxuan.nosdn.127.net/dbb5a935340a7ff61de6bec5fa3fd985.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b0750c142e857a922d77999a48760cb9.jpg\" _src=\"http://yanxuan.nosdn.127.net/b0750c142e857a922d77999a48760cb9.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d742c6ee8b65f2812784e13c2efd04fc.jpg\" _src=\"http://yanxuan.nosdn.127.net/d742c6ee8b65f2812784e13c2efd04fc.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3aada66e84ec86907ca941fbc5235f12.jpg\" _src=\"http://yanxuan.nosdn.127.net/3aada66e84ec86907ca941fbc5235f12.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/bb0fd8620c6d6208773667096709ba2b.jpg\" _src=\"http://yanxuan.nosdn.127.net/bb0fd8620c6d6208773667096709ba2b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/82b0a7a951c15b41eb5a4bb688dd74dc.jpg\" _src=\"http://yanxuan.nosdn.127.net/82b0a7a951c15b41eb5a4bb688dd74dc.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/274fea6d222c1da9c687cb73f0f4f993.jpg\" _src=\"http://yanxuan.nosdn.127.net/274fea6d222c1da9c687cb73f0f4f993.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/fc87ced2f7b274139bb079a75f7adf91.jpg\" _src=\"http://yanxuan.nosdn.127.net/fc87ced2f7b274139bb079a75f7adf91.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3a7f98096222daadf9820e1075670173.jpg\" _src=\"http://yanxuan.nosdn.127.net/3a7f98096222daadf9820e1075670173.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/26501a456d9e85980e12efe92120de56.jpg\" _src=\"http://yanxuan.nosdn.127.net/26501a456d9e85980e12efe92120de56.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/7a9fbd6be2b2a3c2c83d4edaad2086a6.jpg\" _src=\"http://yanxuan.nosdn.127.net/7a9fbd6be2b2a3c2c83d4edaad2086a6.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/a3bf915e824b8b917c893167a99a3773.jpg\" _src=\"http://yanxuan.nosdn.127.net/a3bf915e824b8b917c893167a99a3773.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/211b5a457edcb05d3f3d21ff69c48398.jpg\" _src=\"http://yanxuan.nosdn.127.net/211b5a457edcb05d3f3d21ff69c48398.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/cc0105d79ff4744f0680cbd2f87a8060.jpg\" _src=\"http://yanxuan.nosdn.127.net/cc0105d79ff4744f0680cbd2f87a8060.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f1da6da8c6b7b52f958fdec1dd7769c6.jpg\" _src=\"http://yanxuan.nosdn.127.net/f1da6da8c6b7b52f958fdec1dd7769c6.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/88ed21fc61da4f79545941fffce1f68c.jpg\" _src=\"http://yanxuan.nosdn.127.net/88ed21fc61da4f79545941fffce1f68c.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/6eb4abc57dbd46d6dcc38cac3bd32c68.jpg\" _src=\"http://yanxuan.nosdn.127.net/6eb4abc57dbd46d6dcc38cac3bd32c68.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3c54b9b585c2e03559865e086f9b45bd.jpg\" _src=\"http://yanxuan.nosdn.127.net/3c54b9b585c2e03559865e086f9b45bd.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/f88e9af10088b3a0b4669b27ef2fcadb.jpg\" _src=\"http://yanxuan.nosdn.127.net/f88e9af10088b3a0b4669b27ef2fcadb.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/6b249bac9bf3aa94bf4fffb5ac4d1e70.jpg\" _src=\"http://yanxuan.nosdn.127.net/6b249bac9bf3aa94bf4fffb5ac4d1e70.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b7ded1405eaa6f687eeb9e31b469d5de.jpg\" _src=\"http://yanxuan.nosdn.127.net/b7ded1405eaa6f687eeb9e31b469d5de.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3d072d1f04f7d94495227cf25b591744.jpg\" _src=\"http://yanxuan.nosdn.127.net/3d072d1f04f7d94495227cf25b591744.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/89f67b83d74f2a18b680bb5e6ef0d721.jpg\" _src=\"http://yanxuan.nosdn.127.net/89f67b83d74f2a18b680bb5e6ef0d721.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/236e948413b249b5ea4c1f6f8e835641.jpg\" _src=\"http://yanxuan.nosdn.127.net/236e948413b249b5ea4c1f6f8e835641.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b799d3613b5e3b87d89a608533473df8.jpg\" _src=\"http://yanxuan.nosdn.127.net/b799d3613b5e3b87d89a608533473df8.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/e6d4af8873253a0b5ae097c15c3628c0.jpg\" _src=\"http://yanxuan.nosdn.127.net/e6d4af8873253a0b5ae097c15c3628c0.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/fc017dc5a790385f6a96b43cf1a5b867.jpg\" _src=\"http://yanxuan.nosdn.127.net/fc017dc5a790385f6a96b43cf1a5b867.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0f10cc90e368fad0bd49fafc3b9047b5.jpg\" _src=\"http://yanxuan.nosdn.127.net/0f10cc90e368fad0bd49fafc3b9047b5.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/864bf5646ba2ad778f507c224973bca7.jpg\" _src=\"http://yanxuan.nosdn.127.net/864bf5646ba2ad778f507c224973bca7.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/0443f772258e35af98be389a08fd85b8.jpg\" _src=\"http://yanxuan.nosdn.127.net/0443f772258e35af98be389a08fd85b8.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/821926b210f311717fdaa0eccb142e37.jpg\" _src=\"http://yanxuan.nosdn.127.net/821926b210f311717fdaa0eccb142e37.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/24d0ab5a259a662501e813cf21d752d8.jpg\" _src=\"http://yanxuan.nosdn.127.net/24d0ab5a259a662501e813cf21d752d8.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b58c263c7e090c68d77e056c9d9afe27.jpg\" _src=\"http://yanxuan.nosdn.127.net/b58c263c7e090c68d77e056c9d9afe27.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d50d8b9f53f54ff0c066de7b39b2601c.jpg\" _src=\"http://yanxuan.nosdn.127.net/d50d8b9f53f54ff0c066de7b39b2601c.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b382bfe1d8797e845bbcfd9dce361f76.jpg\" _src=\"http://yanxuan.nosdn.127.net/b382bfe1d8797e845bbcfd9dce361f76.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3aecb3e8d261312596727f56b54a0fa2.jpg\" _src=\"http://yanxuan.nosdn.127.net/3aecb3e8d261312596727f56b54a0fa2.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/c733463829f1fe8fa61998ae7c2ae37b.jpg\" _src=\"http://yanxuan.nosdn.127.net/c733463829f1fe8fa61998ae7c2ae37b.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/da2850f298b6cf4108e00a06bbc59821.jpg\" _src=\"http://yanxuan.nosdn.127.net/da2850f298b6cf4108e00a06bbc59821.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/bd0924729a92af064c2108569e9d9463.jpg\" _src=\"http://yanxuan.nosdn.127.net/bd0924729a92af064c2108569e9d9463.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b819438a87396b0e3cc22202fc19caf0.jpg\" _src=\"http://yanxuan.nosdn.127.net/b819438a87396b0e3cc22202fc19caf0.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/3ea853201f8ad389ae3068f3d765aa44.jpg\" _src=\"http://yanxuan.nosdn.127.net/3ea853201f8ad389ae3068f3d765aa44.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/5ef9093e1959a79178c32d5fc0fbe996.jpg\" _src=\"http://yanxuan.nosdn.127.net/5ef9093e1959a79178c32d5fc0fbe996.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/da1d1a9a1e2afe85b640d573085a3d24.jpg\" _src=\"http://yanxuan.nosdn.127.net/da1d1a9a1e2afe85b640d573085a3d24.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/ce702a9ac92d3666be5d4de2af5e03ab.jpg\" _src=\"http://yanxuan.nosdn.127.net/ce702a9ac92d3666be5d4de2af5e03ab.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/b43f6da048bbc7206990d9ff972a23ba.jpg\" _src=\"http://yanxuan.nosdn.127.net/b43f6da048bbc7206990d9ff972a23ba.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/22eb869c0f07b55826e1e183dd498f3f.jpg\" _src=\"http://yanxuan.nosdn.127.net/22eb869c0f07b55826e1e183dd498f3f.jpg\" style=\"\"/></p><p><img src=\"http://yanxuan.nosdn.127.net/d2c6bf7e29f0e8380ebef90b3bab2294.jpg\" _src=\"http://yanxuan.nosdn.127.net/d2c6bf7e29f0e8380ebef90b3bab2294.jpg\" style=\"\"/></p><p><br/></p>', NULL, NULL, NULL, 0, 0, '万和', NULL);
INSERT INTO `pms_product` VALUES (40, 1, 10, 0, 11, '炸街牛仔外套男春秋潮牌ins港风嘻哈夹克秋季潮流痞帅高级感上衣', 'https://img.alicdn.com/imgextra/i1/2146928739/O1CN01NXcLin2EQVuctfvKH_!!0-item_pic.jpg_430x430q90.jpg', '4534543', 0, 1, 1, 1, 1, 0, 12, 88.00, NULL, 0, 0, 0, '炸街牛仔外套男春秋潮牌ins港风嘻哈夹克秋季潮流痞帅高级感上衣', '炸街牛仔外套男春秋潮牌ins港风嘻哈夹克秋季潮流痞帅高级感上衣', 88.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i3/2146928739/O1CN01cw8vRd2EQVuUAClHh_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2146928739/O1CN01KQWxUm2EQVuitohW0_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2146928739/O1CN01bNv4dy2EQVujnJk7D_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2146928739/O1CN01iq1trZ2EQVuaHgHAQ_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2146928739/O1CN01zvloKq2EQVudTtyrW_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2146928739/O1CN01yBW8R92EQVuh9DWHl_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2146928739/O1CN01qPKyg52EQVuiDDdFZ_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2146928739/O1CN011CXzxt2EQVufj196H_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2146928739/O1CN011dGHar2EQVuYoGBdC_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i1/2146928739/O1CN01r9o7sy2EQVuUAEN6G_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2146928739/O1CN01ZPjhDg2EQVueIiKT7_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2146928739/O1CN01T4Ntde2EQVukVtTBv_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2146928739/O1CN01M1GAd42EQVujnIT7O_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2146928739/O1CN01Vy3sc92EQVuasXGjK_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/2146928739/O1CN01LRr3pW2EQVuh9FvzH_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2146928739/O1CN01B9K6Bd2EQVufj2Lz2_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/2146928739/O1CN01urz3VH2EQVueZTEox_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2146928739/O1CN017sFmvn2EQVuasZstZ_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/2146928739/O1CN01TCvJKf2EQVuasXsAf_!!2146928739.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> </p>', NULL, NULL, NULL, 0, 0, '万和', NULL);
INSERT INTO `pms_product` VALUES (41, 1, 10, 0, 11, '【经典款】TheNorthFace北面防风夹克男防风防泼水秋冬上新|7QPF', 'https://img.alicdn.com/imgextra/i1/928417138/O1CN01jSa1My22bFodIAtG9_!!0-item_pic.jpg_430x430q90.jpg', '4354356', 0, 1, 1, 1, 1, 0, 21, 1098.00, NULL, 0, 0, 0, '【经典款】TheNorthFace北面防风夹克男防风防泼水秋冬上新|7QPF', '【经典款】TheNorthFace北面防风夹克男防风防泼水秋冬上新|7QPF', 1098.00, 199, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img src=\"https://img.alicdn.com/imgextra/i4/928417138/O1CN01XjyHoz22bFobmRKYW_!!928417138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/928417138/O1CN01rWx6iB22bFdFfccWF_!!928417138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/928417138/O1CN01zbtcPO22bFfNg8W81_!!928417138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><br> <img src=\"https://img.alicdn.com/imgextra/i3/928417138/O1CN014RYUG822bFohoPtVP_!!928417138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/928417138/O1CN01WCNCkP22bFdFghAKT_!!928417138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i4/928417138/O1CN01fQUKkC22bFoii7xhZ_!!928417138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/928417138/O1CN01uSZgH622bFog3ThM7_!!928417138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/928417138/O1CN01V5yu4q22bFojRfIn4_!!928417138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/928417138/O1CN01IZ0ETV22bFojRfEdx_!!928417138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/928417138/O1CN01nvb7VK22bFobjCBkP_!!928417138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/928417138/O1CN01KfE69I22bFdF1hBAe_!!928417138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i2/928417138/O1CN01UAEUdr22bFojRfltZ_!!928417138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"><img src=\"https://img.alicdn.com/imgextra/i3/928417138/O1CN01izz2Vz22bFoea2GKA_!!928417138.jpg\" align=\"absmiddle\" class=\"img-ks-lazyload\"> </p>', NULL, NULL, NULL, 0, 0, 'The North Face', NULL);
INSERT INTO `pms_product` VALUES (42, 1, 10, 0, 11, '2021秋冬新款TheNorthFace北面潮牌户外男拼色连帽夹克外套', 'https://gd3.alicdn.com/imgextra/i4/1645999081/O1CN017z5hUT2Gx9NEBAmVV_!!1645999081.jpg_400x400.jpg', '655r434', 0, 1, 1, 1, 1, 0, 18, 748.00, NULL, 0, 0, 0, '2021秋冬新款TheNorthFace北面潮牌户外男拼色连帽夹克外套', '2021秋冬新款TheNorthFace北面潮牌户外男拼色连帽夹克外套', 748.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/1645999081/O1CN01esQ4u62Gx9NGvn0M4_!!1645999081.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/1645999081/O1CN01O1hUt12Gx9NLM0jxb_!!1645999081.jpg\" style=\"max-width: 750.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/1645999081/O1CN013BwxoZ2Gx9NFI1Muw_!!1645999081.jpg\" style=\"max-width: 750.0px;\"></p>', NULL, NULL, NULL, 0, 0, 'The North Face', NULL);
INSERT INTO `pms_product` VALUES (43, 1, 11, 0, 11, 'Couple Hunnid 谢帝 CH基础logo白色打底休闲宽松纯棉长袖T恤男士', 'https://img.alicdn.com/imgextra/i1/2211009479694/O1CN01tbObGO2LTuAFOdSNx_!!2211009479694.jpg_400x400.jpg', '5434352', 0, 1, 1, 1, 1, 0, 30, 199.00, NULL, 0, 0, 0, 'Couple Hunnid 谢帝 CH基础logo白色打底休闲宽松纯棉长袖T恤男士', 'Couple Hunnid 谢帝 CH基础logo白色打底休闲宽松纯棉长袖T恤男士', 199.00, 100, 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, '<p style=\"text-align: center;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/2211009479694/O1CN01r9ydR82LTuAAiYaQL_!!2211009479694.jpg\" style=\"max-width: 350.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/2211009479694/O1CN01FrVaEI2LTuALEhFkK_!!2211009479694.jpg\" style=\"max-width: 350.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/2211009479694/O1CN01iXC7ZF2LTuAErkMQq_!!2211009479694.jpg\" style=\"max-width: 350.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/2211009479694/O1CN01HztQQW2LTuAHItOK4_!!2211009479694.jpg\" style=\"max-width: 350.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/2211009479694/O1CN01qACfFV2LTuADzRllk_!!2211009479694.jpg\" class=\"\" style=\"max-width: 350.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/2211009479694/O1CN01r8mlq42LTuADzPguW_!!2211009479694.jpg\" class=\"\" style=\"max-width: 350.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/2211009479694/O1CN01xBGSVf2LTuALEif4k_!!2211009479694.jpg\" class=\"\" style=\"max-width: 350.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/2211009479694/O1CN01blmFIq2LTuADTC2Fc_!!2211009479694.jpg\" class=\"\" style=\"max-width: 350.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/2211009479694/O1CN01i06tFH2LTuABH9jSw_!!2211009479694.jpg\" class=\"\" style=\"max-width: 350.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i4/2211009479694/O1CN013jgkA62LTuAErk1ek_!!2211009479694.jpg\" class=\"\" style=\"max-width: 350.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/2211009479694/O1CN01ZFWTr82LTuADzQUno_!!2211009479694.jpg\" class=\"\" style=\"max-width: 350.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i2/2211009479694/O1CN01oOX4Ku2LTuAAiYBUL_!!2211009479694.jpg\" class=\"\" style=\"max-width: 350.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/2211009479694/O1CN014tICVs2LTuAIraEUT_!!2211009479694.jpg\" class=\"\" style=\"max-width: 350.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/2211009479694/O1CN01dt9Bry2LTuABH7aO9_!!2211009479694.jpg\" class=\"\" style=\"max-width: 350.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i1/2211009479694/O1CN01tFQW1y2LTuABH9836_!!2211009479694.jpg\" class=\"\" style=\"max-width: 350.0px;\"><img align=\"absmiddle\" src=\"https://img.alicdn.com/imgextra/i3/2211009479694/O1CN01GkCMYm2LTuAAiaCDw_!!2211009479694.jpg\" class=\"\" style=\"max-width: 350.0px;\"></p>', NULL, NULL, NULL, 0, 0, '优衣库', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品属性分类表' ROW_FORMAT = Dynamic;

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
INSERT INTO `pms_product_attribute_category` VALUES (12, '总类', 100, 100);
INSERT INTO `pms_product_attribute_category` VALUES (13, '12323', 0, 0);

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
INSERT INTO `pms_product_category` VALUES (5, 1, '家用电器', 1, 100, '件', 1, 1, 1, NULL, '家用电器', '家用电器');
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
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'sku的库存' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pms_sku_stock
-- ----------------------------
INSERT INTO `pms_sku_stock` VALUES (1, 1, '202109150027001', 3788.00, 100, 10, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180607/5ac1bf58Ndefaac16.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (2, 2, '202109150027002', 5499.00, 100, 10, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5acc5248N6a5f81cd.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (3, 3, '202109150027003', 2499.00, 100, 10, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b02804dN66004d73.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (4, 4, '202109150027004', 3999.00, 100, 10, 'http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20180615/5b028530N51eee7d4.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (5, 5, '202109150027005', 79.00, 100, 10, 'http://yanxuan.nosdn.127.net/ad5a317216f9da495b144070ecf1f957.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (6, 6, '202109150027006', 319.00, 100, 10, 'http://yanxuan.nosdn.127.net/5350e35e6f22165f38928f3c2c52ac57.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (7, 7, '202109150027007', 619.00, 100, 10, 'http://yanxuan.nosdn.127.net/149dfa87a7324e184c5526ead81de9ad.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (8, 8, '202109150027008', 319.00, 100, 10, 'http://yanxuan.nosdn.127.net/07376e78bf4fb8a5aa8e6a0b1437c3ad.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (9, 9, '202109150027009', 398.00, 100, 10, 'http://yanxuan.nosdn.127.net/c39d54c06a71b4b61b6092a0d31f2335.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (10, 10, '202109150027010', 119.00, 99, 10, 'http://yanxuan.nosdn.127.net/337da7094c1df295ca0f0b8baa55b2d5.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (11, 11, '202109150027011', 139.00, 100, 10, 'http://yanxuan.nosdn.127.net/58ed94b63b39339e7814f1339013793c.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (12, 12, '202109150027012', 99.00, 100, 10, 'http://yanxuan.nosdn.127.net/8a9ee5ba08929cc9e40b973607d2f633.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (13, 13, '202109150027013', 369.00, 100, 10, 'http://yanxuan.nosdn.127.net/a803c68ea88e3116023b45ac9ea99510.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (14, 14, '202109150027014', 219.00, 99, 10, 'http://yanxuan.nosdn.127.net/c83a3881704094ddd3970099ca77d115.png', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (15, 15, '202109150027015', 6099.00, 100, 10, 'https://img.alicdn.com/imgextra/i1/2838892713/O1CN01FQ69AI1VubCzlAzxB_!!0-item_pic.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (16, 16, '202109150027016', 7488.00, 100, 10, 'https://img.alicdn.com/imgextra/i4/2024314280/O1CN01mT2FdK1hUHrFa4LK6_!!2024314280.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (17, 17, '202109150027017', 4299.00, 100, 10, 'https://img.alicdn.com/imgextra/i2/2838892713/O1CN016tezkQ1VubD4AbBxX_!!2838892713.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (18, 18, '202109150027018', 6799.00, 99, 10, 'https://img.alicdn.com/imgextra/i1/1917047079/O1CN01xeHXfg22AEQKtkTiK_!!1917047079.png_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (19, 19, '202109150027019', 1778.00, 99, 10, 'https://img.alicdn.com/imgextra/i2/2200877014436/O1CN01anNk4S1idjZTDktag_!!2200877014436.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (20, 20, '202109150027020', 6999.00, 100, 10, 'https://img.alicdn.com/imgextra/i1/1917047079/O1CN01qC9RZb22AEQNIo08f_!!2-item_pic.png_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (21, 21, '202109150027021', 5598.00, 100, 10, 'https://img.alicdn.com/imgextra/O1CN016FuwY324luG6F3Vck_!!6000000007432-0-remus.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (22, 22, '202109150027022', 7599.00, 100, 10, 'https://img.alicdn.com/imgextra/i1/2279837698/O1CN016r3Dsh26jjcIUgSsU_!!2279837698.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (23, 23, '202109150027023', 728.00, 100, 10, 'https://img.alicdn.com/imgextra/i3/407700539/O1CN01hPH4eF1FquAsynxJN_!!0-item_pic.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (24, 24, '202109150027024', 1290.00, 100, 10, 'https://img.alicdn.com/imgextra/https://img.alicdn.com/imgextra/i2/2576722561/O1CN01iPI1O21UmyzT2KOC9_!!2576722561.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (25, 25, '202109150027025', 1199.00, 100, 10, 'https://img.alicdn.com/imgextra/i3/1125378539/TB2mCXLX6TpK1RjSZKPXXa3UpXa_!!1125378539.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (26, 26, '202109150027026', 1399.00, 99, 10, 'https://img.alicdn.com/imgextra/i4/647482297/O1CN01WcLlx41Sq4SglOLBs_!!647482297.jpg_430x430q90.jpg', NULL, NULL, -1, NULL);
INSERT INTO `pms_sku_stock` VALUES (27, 27, '202109150027027', 5978.00, 100, 10, 'https://img.alicdn.com/imgextra/i1/2200877014436/O1CN016ekYBX1idjahukrhA_!!2200877014436.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (28, 28, '202109150027028', 2599.00, 100, 10, 'https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01BqPY9s1vlbMPxJiEh_!!2201168176213.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (29, 29, '202109150027029', 479.00, 100, 10, 'https://img.alicdn.com/imgextra/i2/2201168176213/O1CN01X5D1o01vlbRMW5gCH_!!2201168176213.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (30, 30, '202109150027030', 139.00, 99, 10, 'https://img.alicdn.com/imgextra/i3/833261111/O1CN014MMkx01K4sfv0hKnn_!!833261111.png_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (31, 31, '202109150027031', 179.00, 100, 10, 'https://img.alicdn.com/imgextra/i1/833261111/O1CN01yB5M6b1K4saHiFU5A_!!833261111.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (32, 32, '202109150027032', 285.00, 100, 10, 'https://gd1.alicdn.com/imgextra/i1/612966252/O1CN01airkQ51w3Stv4zncN_!!612966252.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (33, 33, '202109150027033', 228.00, 95, 10, 'https://gd3.alicdn.com/imgextra/i3/3381629725/O1CN01QaB5cG2Li6E4KJn0M_!!3381629725.jpg_400x400.jpg', NULL, NULL, -2, NULL);
INSERT INTO `pms_sku_stock` VALUES (34, 34, '202109150027034', 999.00, 99, 10, 'https://img.alicdn.com/imgextra/i1/1916629511/O1CN01mmZBhe2K85g7wOxfd_!!1916629511.jpg_430x430q90.jpg', NULL, NULL, 1, NULL);
INSERT INTO `pms_sku_stock` VALUES (35, 35, '202109150027035', 685.00, 100, 10, 'https://img.alicdn.com/imgextra/i1/2200877014436/O1CN01C00EWE1idjdHq0XHC_!!2200877014436.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (36, 36, '202109150027036', 169.00, 100, 10, 'https://img.alicdn.com/imgextra/i4/2200877014436/O1CN01JSPiOI1idjdZCtMHb_!!2200877014436.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (37, 37, '202109150027037', 2249.00, 99, 10, 'https://img.alicdn.com/imgextra/i2/594767740/O1CN01KBVDeF272yAoep8KZ_!!594767740.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (38, 38, '202109150027038', 599.00, 100, 10, 'https://img.alicdn.com/imgextra/i2/2865745622/O1CN01HfoCnq1rOvJbQlMA8_!!0-item_pic.jpg_430x430q90.jpg', NULL, NULL, 1, NULL);
INSERT INTO `pms_sku_stock` VALUES (39, 39, '202109270027039', 99.00, 99, 10, 'http://yanxuan.nosdn.127.net/dbc5b25b824c3b3d7ff43b56ca35eee9.png', NULL, NULL, -1, NULL);
INSERT INTO `pms_sku_stock` VALUES (40, 40, '202109270027040', 88.00, 100, 10, 'https://img.alicdn.com/imgextra/i1/2146928739/O1CN01NXcLin2EQVuctfvKH_!!0-item_pic.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (41, 41, '202109270027041', 1098.00, 100, 10, 'https://img.alicdn.com/imgextra/i1/928417138/O1CN01jSa1My22bFodIAtG9_!!0-item_pic.jpg_430x430q90.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (42, 42, '202109270027042', 748.00, 100, 10, 'https://gd3.alicdn.com/imgextra/i4/1645999081/O1CN017z5hUT2Gx9NEBAmVV_!!1645999081.jpg_400x400.jpg', NULL, NULL, 0, NULL);
INSERT INTO `pms_sku_stock` VALUES (43, 43, '202109270027043', 199.00, 100, 10, 'https://img.alicdn.com/imgextra/i1/2211009479694/O1CN01tbObGO2LTuAFOdSNx_!!2211009479694.jpg_400x400.jpg', NULL, NULL, 0, NULL);

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
INSERT INTO `ums_admin` VALUES (8, 'lucien', 'd941cf1382c4ddb8c1b11620cd5d6279', '', '799774821@qq.com', 'lucien_xxx', 'cxy专用', '2021-08-25 18:10:21', '2021-09-27 08:54:32', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台用户登录日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_admin_login_log
-- ----------------------------
INSERT INTO `ums_admin_login_log` VALUES (1, 8, '2021-09-06 19:47:31', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (2, 8, '2021-09-06 19:49:00', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (3, 8, '2021-09-06 19:50:03', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (4, 8, '2021-09-06 19:51:41', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (5, 8, '2021-09-08 09:24:54', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (6, 8, '2021-09-08 09:33:22', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (7, 8, '2021-09-08 09:34:37', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (8, 8, '2021-09-08 09:36:54', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (9, 8, '2021-09-17 21:33:43', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (10, 8, '2021-09-18 22:13:16', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (11, 8, '2021-09-26 20:15:35', '127.0.0.1', NULL, 'Chrome 9');
INSERT INTO `ums_admin_login_log` VALUES (12, 8, '2021-09-27 08:54:32', '127.0.0.1', NULL, 'Chrome 9');

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
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台菜单表' ROW_FORMAT = Dynamic;

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
INSERT INTO `ums_menu` VALUES (26, 21, '2021-09-10 14:00:00', '登录日志', 1, 0, 'loginlo', 'ums-loginlo', 0);

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
