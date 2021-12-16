/*
 Navicat Premium Data Transfer

 Source Server         : MySQL8
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : samsung

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 08/12/2021 00:20:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_cartitem
-- ----------------------------
DROP TABLE IF EXISTS `tb_cartitem`;
CREATE TABLE `tb_cartitem`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `uid` int(0) NOT NULL,
  `pid` int(0) NOT NULL,
  `quantity` int(0) NULL DEFAULT NULL COMMENT '购买数量',
  `totalMoney` decimal(10, 2) NULL DEFAULT NULL COMMENT '总价',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_pid`(`pid`) USING BTREE,
  INDEX `fk_uid`(`uid`) USING BTREE,
  CONSTRAINT `fk_pid` FOREIGN KEY (`pid`) REFERENCES `tb_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_uid` FOREIGN KEY (`uid`) REFERENCES `tb_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_cartitem
-- ----------------------------
INSERT INTO `tb_cartitem` VALUES (59, 1001, 902, 1, 13999.00);
INSERT INTO `tb_cartitem` VALUES (60, 1006, 901, 2, 19998.00);
INSERT INTO `tb_cartitem` VALUES (71, 1001, 902, 3, 41997.00);
INSERT INTO `tb_cartitem` VALUES (95, 1001, 601, 1, 16999.00);
INSERT INTO `tb_cartitem` VALUES (100, 1002, 312, 3, 4797.00);
INSERT INTO `tb_cartitem` VALUES (101, 1006, 601, 2, 33998.00);
INSERT INTO `tb_cartitem` VALUES (102, 1003, 312, 1, 1599.00);

-- ----------------------------
-- Table structure for tb_orderitem
-- ----------------------------
DROP TABLE IF EXISTS `tb_orderitem`;
CREATE TABLE `tb_orderitem`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `orderMoney` decimal(65, 0) NULL DEFAULT 0 COMMENT '订单金额',
  `createTime` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '订单生成时间，默认当前时间',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单状态',
  `receiver` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '接收人（就是此用户名）',
  `receiverAddress` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货地址（就是用户地址）'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_orderitem
-- ----------------------------
INSERT INTO `tb_orderitem` VALUES ('2021-06-15-160202-102', 29163, '2021-06-15 16:02:02', '已完成', 'WCC', '中国安徽');
INSERT INTO `tb_orderitem` VALUES ('2021-06-16-214113-247', 57661, '2021-06-16 21:41:13', '已完成', 'KLX', '安徽马鞍山马师专');
INSERT INTO `tb_orderitem` VALUES ('2021-06-20-184215-247', 57661, '2021-06-20 18:42:15', '已完成', 'KLX', '安徽马鞍山马师专');

-- ----------------------------
-- Table structure for tb_product
-- ----------------------------
DROP TABLE IF EXISTS `tb_product`;
CREATE TABLE `tb_product`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '产品名称',
  `price` decimal(10, 2) NOT NULL COMMENT '价格',
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型',
  `network` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/',
  `stock` int(0) NULL DEFAULT 0 COMMENT '库存',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3356 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_product
-- ----------------------------
INSERT INTO `tb_product` VALUES (100, 'Galaxy Note10', 6999.00, '麦昆黑', '手机', '4G', 1000, 'mobile/n10/n10_b.jpg');
INSERT INTO `tb_product` VALUES (101, 'Galaxy Note10', 6999.00, '密斯白', '手机', '4G', 1000, 'mobile/n10/n10_w.jpg');
INSERT INTO `tb_product` VALUES (102, 'Galaxy Note10', 6999.00, '莫奈彩', '手机', '4G', 1000, 'mobile/n10/n10_m.jpg');
INSERT INTO `tb_product` VALUES (110, 'Neo8K光质量子点家电', 99999.00, '黑色', '家电', 'WIFI6', 500, 'home/tv/QN900A.jpg');
INSERT INTO `tb_product` VALUES (111, 'QLED 8K家电Q950TS', 99999.00, '黑色', '家电', 'WIFI6', 500, 'home/tv/Q950TS.jpg');
INSERT INTO `tb_product` VALUES (112, '画镜系列融入屏TU8000', 2999.00, '黑色', '家电', 'WIFI6', 500, 'home/tv/TU8000.jpg');
INSERT INTO `tb_product` VALUES (113, '4K超高清家电 AU8800', 5499.00, '黑色', '家电', 'WIFI6', 500, 'home/tv/AU8800.jpg');
INSERT INTO `tb_product` VALUES (114, 'QLED光质量子点家电 画境', 7999.00, '黑色', '家电', 'WIFI6', 500, 'home/tv/lifestyle.jpg');
INSERT INTO `tb_product` VALUES (201, 'Galaxy Note10+', 8999.00, '麦昆黑', '手机', '5G', 1000, 'mobile/n10/n10_b.jpg');
INSERT INTO `tb_product` VALUES (202, 'Galaxy Note10+', 8999.00, '密斯白', '手机', '5G', 1000, 'mobile/n10/n10_w.jpg');
INSERT INTO `tb_product` VALUES (203, 'Galaxy Note10+', 8999.00, '莫奈彩', '手机', '5G', 1000, 'mobile/n10/n10_m.jpg');
INSERT INTO `tb_product` VALUES (210, 'Samsung Galaxy Buds', 699.00, '莫奈彩', '穿戴', '/', 1000, 'wear/buds/Buds_m.jpg');
INSERT INTO `tb_product` VALUES (211, 'Samsung Galaxy Buds', 699.00, '清幽白', '穿戴', '/', 1000, 'wear/buds/Buds_w.jpg');
INSERT INTO `tb_product` VALUES (212, 'Samsung Galaxy Buds Pro', 799.00, '幻境银', '穿戴', '/', 1000, 'wear/buds/Buds Pro_y.jpg');
INSERT INTO `tb_product` VALUES (213, 'Samsung Galaxy Buds Pro', 799.00, '梵梦紫', '穿戴', '/', 1000, 'wear/buds/BudsPro_p.jpg');
INSERT INTO `tb_product` VALUES (301, 'Galaxy Note20', 7999.00, '迷雾金', '手机', '5G', 1000, 'mobile/n20/n20_jin.jpg');
INSERT INTO `tb_product` VALUES (302, 'Galaxy Note20', 7999.00, '冷山灰', '手机', '5G', 1000, 'mobile/n20/n20_g.jpg');
INSERT INTO `tb_product` VALUES (310, 'Samsung Galaxy Watch3', 2299.00, '冷山灰', '穿戴', 'WIFI6', 1000, 'wear/watch/watch3_b.jpg');
INSERT INTO `tb_product` VALUES (311, 'Samsung Galaxy Watch3', 2299.00, '秘境白', '穿戴', '4G', 1000, 'wear/watch/watch3_g.jpg');
INSERT INTO `tb_product` VALUES (312, 'Samsung Galaxy Watch Active', 1599.00, '幻游黑', '穿戴', 'WIFI6', 1000, 'wear/watch/watch_active_b.jpg');
INSERT INTO `tb_product` VALUES (313, 'Samsung Galaxy Watch Active', 1599.00, '幻境银', '穿戴', 'WIFI6', 1000, 'wear/watch/watch_active_y.jpg');
INSERT INTO `tb_product` VALUES (401, 'Galaxy Note20 Ultra 5G', 9999.00, '迷雾金', '手机', '5G', 1000, 'mobile/n20/n20u_jin.jpg');
INSERT INTO `tb_product` VALUES (402, 'Galaxy Note20 Ultra 5G', 9999.00, '初露白', '手机', '5G', 1000, 'mobile/n20/n20u_w.jpg');
INSERT INTO `tb_product` VALUES (501, 'Galaxy21', 7999.00, '梵梦紫', '手机', '5G', 1000, 'mobile/s21/s21_zi.jpg');
INSERT INTO `tb_product` VALUES (502, 'Galaxy21', 7999.00, '丝雾白', '手机', '5G', 1000, 'mobile/s21/s21_white.jpg');
INSERT INTO `tb_product` VALUES (503, 'Galaxy21 Ultra', 9999.00, '幽夜黑', '手机', '5G', 1000, 'mobile/s21/s21u_b.jpg');
INSERT INTO `tb_product` VALUES (504, 'Galaxy21 Ultra', 9999.00, '幻境银', '手机', '5G', 1000, 'mobile/s21/s21u_yin.jpg');
INSERT INTO `tb_product` VALUES (601, 'Galaxy Z Fold2', 16999.00, '松烟墨', '手机', '5G', 1000, 'mobile/zFold/ZFold2_b.jpg');
INSERT INTO `tb_product` VALUES (602, 'Galaxy Z Fold2', 16999.00, '迷雾金', '手机', '5G', 1000, 'mobile/zFold/ZFold2_jin.jpg');
INSERT INTO `tb_product` VALUES (701, 'Galaxy Z Flip', 15999.00, '秘境白', '手机', '5G', 1000, 'mobile/zFilp/zfilp_y.jpg');
INSERT INTO `tb_product` VALUES (702, 'Galaxy Z Flip', 15999.00, '迷雾金', '手机', '5G', 1000, 'mobile/zFilp/zfilp_jin.jpg');
INSERT INTO `tb_product` VALUES (803, 'Samsung Galaxy Buds Live', 699.00, '迷雾金', '穿戴', '/', 1000, 'wear/buds/buds-live.jpg');
INSERT INTO `tb_product` VALUES (901, 'Galaxy S20+ 5G\n', 9999.00, '浮氧蓝', '手机', '5G', 1000, 'mobile/s20/s20_lan.jpg');
INSERT INTO `tb_product` VALUES (902, 'Galaxy S20 Ultra 5G', 13999.00, '遐想灰', '手机', '5G', 1000, 'mobile/s20/s20u_hei.jpg');
INSERT INTO `tb_product` VALUES (903, 'Galaxy S20 5G\n', 8999.00, '柔雾粉', '手机', '5G', 1000, 'mobile/s20/s20_fen.jpg');
INSERT INTO `tb_product` VALUES (3356, 'GalaxyBookS', 8999.00, '黑色', '办公', 'WIFI6', 7777, 'office/8e9feGalaxyBookS.jpg');
INSERT INTO `tb_product` VALUES (3357, 'ytjyjtyt', 6546.00, 'tmjhth', '家电', '5G', 555, 'home/ca117Display.jpg');
INSERT INTO `tb_product` VALUES (3358, 'GalaxyWatch4', 3334.00, '黑色', '穿戴', '/', 9999, 'wear/429daWatch4.jpg');

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `sex` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别',
  `tel` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话',
  `birth` date NULL DEFAULT NULL COMMENT '生日',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `headImgUrl` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像路径',
  `role` int(0) NULL DEFAULT 0 COMMENT '角色，1：管理员，2：超级管理员，0：普通用户',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username_unique`(`name`) USING BTREE,
  UNIQUE INDEX `tel_unique`(`tel`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1300 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES (1001, 'KLX', '123', '男', '15268586926', '2021-06-26', '安徽马鞍山马师专', 'nanshen.jpg', 2);
INSERT INTO `tb_user` VALUES (1002, '凤凰战士', '123', '男', '18862673355', '2021-07-01', '中东地区', NULL, 0);
INSERT INTO `tb_user` VALUES (1003, 'SAS', '123', '男', '18837673345', '2021-07-01', '中东地区', NULL, 0);
INSERT INTO `tb_user` VALUES (1006, 'WCC', '123', '女', '15555039105', '1999-06-21', '中国安徽滁州', NULL, 1);
INSERT INTO `tb_user` VALUES (1210, '嫌疑人崔某', '123456', '男', '18845553563', '2021-12-29', '马鞍山', '3bbcaicon.png', 0);
INSERT INTO `tb_user` VALUES (1230, '嫌疑人洪某', '123456', '男', '18557845646', '2021-08-20', '安徽安庆', '2247dytjy.webp', 0);
INSERT INTO `tb_user` VALUES (1270, '神秘开发者', '123', '男', '135252634', '2024-11-01', '中国上海', NULL, 3);
INSERT INTO `tb_user` VALUES (1277, '神秘测试员', '123', '女', '1892671788', '2023-12-05', '中国深圳', NULL, 1);
INSERT INTO `tb_user` VALUES (1292, '违规用户张某', '123456', '男', '18852562969', '2021-12-22', '马鞍山', '2fb14ykyuk.webp', 0);
INSERT INTO `tb_user` VALUES (1293, '神秘用户零零一', '123456', '女', '15738487456', '2022-01-07', '中国北京', 'b6587gthrj.webp', 0);
INSERT INTO `tb_user` VALUES (1294, '张三', '123456', '男', '18789787875', '2021-02-24', '江苏南京', '9b78eh3.jpg', 0);
INSERT INTO `tb_user` VALUES (1295, '李四', '123456', '女', '18758478683', '2027-12-02', '安徽合肥', '0260egthrj.webp', 0);
INSERT INTO `tb_user` VALUES (1296, '王五', '123456', '男', '17847692763', '2017-12-01', '安徽芜湖', '98e20fskjf.jpg', 0);
INSERT INTO `tb_user` VALUES (1297, '神秘用户零零二', '123456', '男', '15226747857', '2021-01-09', '安徽滁州', 'ff329gklw.jpg', 0);
INSERT INTO `tb_user` VALUES (1298, '违规用户崔某', '123456', '男', '16784755854', '2021-12-06', '安徽阜阳', 'd5c61grthth.webp', 0);

SET FOREIGN_KEY_CHECKS = 1;
