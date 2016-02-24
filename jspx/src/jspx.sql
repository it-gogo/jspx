/*
Navicat MySQL Data Transfer

Source Server         : 199_mysql
Source Server Version : 50027
Source Host           : 192.168.1.199:3306
Source Database       : jspx

Target Server Type    : MYSQL
Target Server Version : 50027
File Encoding         : 65001

Date: 2016-02-24 18:10:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `application_class_student`
-- ----------------------------
DROP TABLE IF EXISTS `application_class_student`;
CREATE TABLE `application_class_student` (
  `id` varchar(100) NOT NULL,
  `classId` varchar(100) default NULL,
  `studentId` varchar(100) default NULL,
  `reason` varchar(400) default NULL,
  `status` char(1) default NULL,
  `applicationDate` varchar(25) default NULL,
  `applicant` varchar(100) default NULL,
  `checkor` varchar(100) default NULL,
  `checkDate` varchar(25) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of application_class_student
-- ----------------------------

-- ----------------------------
-- Table structure for `artificial_attendance`
-- ----------------------------
DROP TABLE IF EXISTS `artificial_attendance`;
CREATE TABLE `artificial_attendance` (
  `id` varchar(100) NOT NULL,
  `studentId` varchar(100) default NULL,
  `categoryId` char(1) default NULL,
  `date` varchar(23) default NULL,
  `remark` text,
  `creator` varchar(100) default NULL,
  `createdate` varchar(23) default NULL,
  `isDeleted` char(1) default NULL,
  `attendanceId` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of artificial_attendance
-- ----------------------------
INSERT INTO `artificial_attendance` VALUES ('577a4a260e0646f2a7aa108d6072933b', '229799ab07c64edcab110052c8aec85f', '2', '2016-02-24 16:47:56', '12323231', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-02-24 16:43:50', '1', '1');

-- ----------------------------
-- Table structure for `attendance_info`
-- ----------------------------
DROP TABLE IF EXISTS `attendance_info`;
CREATE TABLE `attendance_info` (
  `id` int(11) NOT NULL auto_increment,
  `idcard` varchar(20) default NULL,
  `attendanceDate` varchar(23) default NULL,
  `ip` varchar(50) default NULL,
  `createdate` varchar(23) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of attendance_info
-- ----------------------------

-- ----------------------------
-- Table structure for `attendance_time`
-- ----------------------------
DROP TABLE IF EXISTS `attendance_time`;
CREATE TABLE `attendance_time` (
  `id` varchar(100) NOT NULL,
  `classTimeId` varchar(100) default NULL,
  `attendanceTime` varchar(23) default NULL,
  `creator` varchar(100) default NULL,
  `createdate` varchar(23) default NULL,
  `type` char(1) default NULL,
  `beforeAttendance` int(11) default NULL,
  `absenteeism` int(11) default NULL,
  `afterAttendance` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of attendance_time
-- ----------------------------
INSERT INTO `attendance_time` VALUES ('32535c631a574471afbe11d88c011443', '23ce6657d4674b93addb01aa26223ef8', '2015-08-14 12:08:21', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-09-25 14:08:33', '2', '20', '30', '5');
INSERT INTO `attendance_time` VALUES ('67468f87108e422588f3a8fe67e08d59', '23ce6657d4674b93addb01aa26223ef8', '2015-08-14 08:08:02', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-09-25 14:08:17', '1', '25', '30', '5');
INSERT INTO `attendance_time` VALUES ('cb03c1bf1ea445a4b8b7a0c4df8d759f', '23ce6657d4674b93addb01aa26223ef8', '2015-08-14 16:10:14', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-09-25 08:52:24', '1', '15', '20', '5');

-- ----------------------------
-- Table structure for `class_info`
-- ----------------------------
DROP TABLE IF EXISTS `class_info`;
CREATE TABLE `class_info` (
  `id` varchar(100) NOT NULL,
  `name` varchar(50) default NULL,
  `classTeacher` varchar(100) default NULL,
  `categoryId` varchar(100) default NULL,
  `creator` varchar(100) default NULL,
  `createdate` varchar(23) default NULL,
  `isDeleted` char(1) default NULL,
  `introduction` text,
  `courseId` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of class_info
-- ----------------------------
INSERT INTO `class_info` VALUES ('c192cb2ec8a746f1b82a9ee1be5053bb', '新教师生态培训(第一期)', '77b5d12d8dd64e069021e0d03f15692a', '13f93084f85144d980147764651bf69c', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:51:51', '0', null, '50030dff568448f58bbed5536e588eef');

-- ----------------------------
-- Table structure for `class_student`
-- ----------------------------
DROP TABLE IF EXISTS `class_student`;
CREATE TABLE `class_student` (
  `id` varchar(100) NOT NULL,
  `classId` varchar(100) default NULL,
  `studentId` varchar(100) default NULL,
  `scores` varchar(20) default NULL,
  `isPass` char(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of class_student
-- ----------------------------
INSERT INTO `class_student` VALUES ('002a334cbab44d35936dd9902bb28567', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'dbde107e72464faf9c5eb87a229d060e', '90', null);
INSERT INTO `class_student` VALUES ('003d2cef3a584b328726b9f57c7d728d', 'c192cb2ec8a746f1b82a9ee1be5053bb', '8d48fec5178f433ea79fc8f0a4ee6fe8', '85', null);
INSERT INTO `class_student` VALUES ('0041aeeed4ba45c8a3a13b4cb4138131', 'c192cb2ec8a746f1b82a9ee1be5053bb', '665140f3a59c43228d41f107ba5fc4ab', null, null);
INSERT INTO `class_student` VALUES ('007f10f7172d46849ffc2ce9e4c0728b', 'c192cb2ec8a746f1b82a9ee1be5053bb', '61976ac863594373ba0746f513c858d2', null, null);
INSERT INTO `class_student` VALUES ('06b03906af2e45d59dbfd47088422487', 'c192cb2ec8a746f1b82a9ee1be5053bb', '6a65a2f693a94b758d98d0fbbf545597', null, null);
INSERT INTO `class_student` VALUES ('06c859feacc645d69c4329e62afb8b68', 'c192cb2ec8a746f1b82a9ee1be5053bb', '8845bbdd64ad487fa61dbf1f72774981', null, null);
INSERT INTO `class_student` VALUES ('06e3fe6ff64b4a5a8c00e84140ed728d', 'c192cb2ec8a746f1b82a9ee1be5053bb', '81bcefe6accd48e1a2f9ea96d4687244', null, null);
INSERT INTO `class_student` VALUES ('07e133ae24234fc8999b0d6ff48b745d', 'c192cb2ec8a746f1b82a9ee1be5053bb', '61a505e9ec1b4c3a92a31aea6aba4ac7', null, null);
INSERT INTO `class_student` VALUES ('096c4a0411c8451ab383bd812a09075c', 'c192cb2ec8a746f1b82a9ee1be5053bb', '8dfd992418924e87a2559fea0900547c', '75', null);
INSERT INTO `class_student` VALUES ('0abdabe27ce948018fbb650aa92d6118', 'c192cb2ec8a746f1b82a9ee1be5053bb', '9d38fe06359342f48bef018db72b7f54', null, null);
INSERT INTO `class_student` VALUES ('0ce69b6360b548a39fdad95d60590af0', 'c192cb2ec8a746f1b82a9ee1be5053bb', '015538f2daa2403098a0f8c3371202b0', null, null);
INSERT INTO `class_student` VALUES ('0d7620eb4d5040888d1b5fca03d3988d', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'db010960b18b4385bd7af25a570f0ad4', null, null);
INSERT INTO `class_student` VALUES ('10c591ede2764d0ea75b8353407a9370', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'e62454d7c1364687a359c61467cad575', null, null);
INSERT INTO `class_student` VALUES ('13e356abe1be4c14aed3e26a0c0c840f', 'c192cb2ec8a746f1b82a9ee1be5053bb', '58302b4afc6544c1be8b6a636cb36cfc', null, null);
INSERT INTO `class_student` VALUES ('1426a06e5dc34b3290fc5ca1f966d7cc', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'a361846973824cc99bad1fe4e3cc9808', null, null);
INSERT INTO `class_student` VALUES ('1ef1ac3514fd4f5488ff565f35f0e162', 'c192cb2ec8a746f1b82a9ee1be5053bb', '9d37e71c9823459b9206fbb6f6c598d8', null, null);
INSERT INTO `class_student` VALUES ('1fa5f12d193043a09b2b761632871be8', 'c192cb2ec8a746f1b82a9ee1be5053bb', '94f7a3891b784fcea0f57b962958a598', null, null);
INSERT INTO `class_student` VALUES ('1fae5998a40e49419bacb387b21dbf24', 'c192cb2ec8a746f1b82a9ee1be5053bb', '77aab57958ad407bb9be8c4af9817a01', null, null);
INSERT INTO `class_student` VALUES ('20169985bedd4973af508bebc9c6eaab', 'c192cb2ec8a746f1b82a9ee1be5053bb', '0eff6353f18c4d2eb720839f5365eb5b', null, null);
INSERT INTO `class_student` VALUES ('215abf16bd4940a8a3d1a80d1764ffbd', 'c192cb2ec8a746f1b82a9ee1be5053bb', '6fbb811756a14d83b494e9e1325acedf', null, null);
INSERT INTO `class_student` VALUES ('2175fed1ac6844b0a67e6bfc08e34246', 'c192cb2ec8a746f1b82a9ee1be5053bb', '5c8990b310f647a7b8842e6810e0dea7', null, null);
INSERT INTO `class_student` VALUES ('22ec5c683f3c4e4fbb8fcd34007c8276', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'c39c5db3412f472a95cd6ae30e2e0976', null, null);
INSERT INTO `class_student` VALUES ('2579f580cbc242d981212fd686a5fb51', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'fb94ff53b7414a0a825050486e954042', null, null);
INSERT INTO `class_student` VALUES ('2731371db72e4a3ab445c2f52deb0c3f', 'c192cb2ec8a746f1b82a9ee1be5053bb', '35ddbf8b00204f1d8f37f82241afd19a', null, null);
INSERT INTO `class_student` VALUES ('29bc7a9e9a844100aa15c8a9e93e67a1', 'c192cb2ec8a746f1b82a9ee1be5053bb', '3a34d009ec3f4fea9ae9e86bd05699a5', null, null);
INSERT INTO `class_student` VALUES ('350a2882aab447a5acc5cb3a4bb202fa', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'ac55c5dfc1b54beba2b61b65078ce089', null, null);
INSERT INTO `class_student` VALUES ('3729a5768b02460981a49e3010167fe5', 'c192cb2ec8a746f1b82a9ee1be5053bb', '7c49c5937f0c49dfb7a20ed305164b9a', null, null);
INSERT INTO `class_student` VALUES ('442b030d367f43aea15ff6e5e991e40c', 'c192cb2ec8a746f1b82a9ee1be5053bb', '579879f3be6b48dfb57ed51ec40ce3ac', null, null);
INSERT INTO `class_student` VALUES ('461e1bed5d5b4172a72570e4f204fe87', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'b583dd763ef34c50a0951cc27e8b692a', null, null);
INSERT INTO `class_student` VALUES ('4a9447e8f76e4b46b2fdf0bb2cb10a9c', 'c192cb2ec8a746f1b82a9ee1be5053bb', '2cae55af9be844d78b5735ee07e66903', null, null);
INSERT INTO `class_student` VALUES ('4e10347101954ae5ad34a4d27b74e88d', 'c192cb2ec8a746f1b82a9ee1be5053bb', '27ece220a3cd4cff848e332dbcd0a830', null, null);
INSERT INTO `class_student` VALUES ('51abbdd063a94dfcb2e5c3776bdc514f', 'c192cb2ec8a746f1b82a9ee1be5053bb', '1bf7ff548c174bf8b599c3ca434b1c33', null, null);
INSERT INTO `class_student` VALUES ('51e189553c8548219b111311f2c1cbb9', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'bc703e15a4234ee88688bea8d08ff93d', null, null);
INSERT INTO `class_student` VALUES ('5d1a6a3166654177bf2895cead2aed3c', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'd29930f8fe234e719672f68150e70fae', null, null);
INSERT INTO `class_student` VALUES ('5fdb8ed379884f53b8e3f8134bf4c2ea', 'c192cb2ec8a746f1b82a9ee1be5053bb', '13cae959d2c64589bf23f94e47bccdba', null, null);
INSERT INTO `class_student` VALUES ('62ccc501dd9f45e4a7365fa50fb6836c', 'c192cb2ec8a746f1b82a9ee1be5053bb', '0a206081f6f74cf6b8f6e73e4a4126dd', null, null);
INSERT INTO `class_student` VALUES ('66126f9a657b4cd0b4dc5bb329f04d85', 'c192cb2ec8a746f1b82a9ee1be5053bb', '987873c302824864a54962ab667fff08', null, null);
INSERT INTO `class_student` VALUES ('6741e6543e254f8aa204a3365f8877b7', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'd84eba72bfb84e82bc3dd5d808d8742a', null, null);
INSERT INTO `class_student` VALUES ('6853c6ff09904c52b6af60c21b523989', 'c192cb2ec8a746f1b82a9ee1be5053bb', '163cc2f33b5847b38ea972401aa5a569', null, null);
INSERT INTO `class_student` VALUES ('6a3d434196a9482782d3fc2af3d78e07', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'e502b0ccd0f94eea962e8f282c5e92a2', null, null);
INSERT INTO `class_student` VALUES ('6ae49a23107d4c9aad4f777b07ec4ac8', 'c192cb2ec8a746f1b82a9ee1be5053bb', '929f0b27c92f4681b4536ba5cec8b32e', null, null);
INSERT INTO `class_student` VALUES ('6b985b732815494ab25b19caa5e3f0c4', 'c192cb2ec8a746f1b82a9ee1be5053bb', '00317770ebde4c37ad40fb60f5fd068d', null, null);
INSERT INTO `class_student` VALUES ('6e2bb004b0764dd792e72e1366edde14', 'c192cb2ec8a746f1b82a9ee1be5053bb', '32f920a6d2374276a6ceb27b1c9039cf', null, null);
INSERT INTO `class_student` VALUES ('6eb0d4ec41e64824a77ed148eea36dc2', 'c192cb2ec8a746f1b82a9ee1be5053bb', '2bed786f0db44c4bb2857f001302c120', null, null);
INSERT INTO `class_student` VALUES ('7018e2c9cd224671a093331a4a5f1309', 'c192cb2ec8a746f1b82a9ee1be5053bb', '1afec74fa0e7459188455740efe918c6', null, null);
INSERT INTO `class_student` VALUES ('76708048443e4b719ebc4cca8d0ff0b7', 'c192cb2ec8a746f1b82a9ee1be5053bb', '6abe9f1db5ad4738bc732b62ce75ccad', null, null);
INSERT INTO `class_student` VALUES ('7cc140eeafe9455c90b1b1e7f53f1b9e', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'e20c4462998047e58df06086fea23643', null, null);
INSERT INTO `class_student` VALUES ('81611dd594e04b68952537db78560453', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'adb54c0d7cf54bf9ad89e7a9cbb99e1f', null, null);
INSERT INTO `class_student` VALUES ('8c6eee22cef147189d6a4977580d5b00', 'c192cb2ec8a746f1b82a9ee1be5053bb', '1bb8e36d17da4208a2d202f0cc5a6c12', null, null);
INSERT INTO `class_student` VALUES ('8e3dc00d0a7d4b268230ca6d4af4e075', 'c192cb2ec8a746f1b82a9ee1be5053bb', '26d1a4cfa9ed4cf2baa62425527e2f76', null, null);
INSERT INTO `class_student` VALUES ('8fb7c903cada4efeab2a4eff6b6f1c20', 'c192cb2ec8a746f1b82a9ee1be5053bb', '8fb608179f224f4181bd706bc4cac03f', null, null);
INSERT INTO `class_student` VALUES ('929d3c7ec81f44188baa2de9addfdb68', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'a5a6631fca4b4de7b6675a30ec317585', null, null);
INSERT INTO `class_student` VALUES ('934db684aa0246a8bcfde2c4954d8f65', 'c192cb2ec8a746f1b82a9ee1be5053bb', '336c1f7f509f49bb8fbea232b54efdbd', null, null);
INSERT INTO `class_student` VALUES ('96051c7e1820423ab74809db2166f955', 'c192cb2ec8a746f1b82a9ee1be5053bb', '2e6e5b7997fe4597ad8acf3af34988ef', null, null);
INSERT INTO `class_student` VALUES ('99e9171f3a9a403c905d19c47a5739fa', 'c192cb2ec8a746f1b82a9ee1be5053bb', '134d89f33ef64172916cfaafda184d87', null, null);
INSERT INTO `class_student` VALUES ('9a9ab37756794ad28a502497c82bd8c7', 'c192cb2ec8a746f1b82a9ee1be5053bb', '079d38c48b94412ba6f2cb7aed3200b6', null, null);
INSERT INTO `class_student` VALUES ('9b5c2bb90bce403fb531ee643655a75c', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'b1a7b07d650e4a309a1c40eb29d421e0', null, null);
INSERT INTO `class_student` VALUES ('9e99a260dd4a474fafc6aca42a67f24c', 'c192cb2ec8a746f1b82a9ee1be5053bb', '1dcddd0e159c4b558339dc0e96346041', null, null);
INSERT INTO `class_student` VALUES ('a53ea42aacae43b7998e75817519ae5d', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'bde73acc10b34224b66adef4ef794557', null, null);
INSERT INTO `class_student` VALUES ('abdd32c627de4a14a139bb60e5b32c7e', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'a9a1977952b64e88a352a8272f91ace2', null, null);
INSERT INTO `class_student` VALUES ('b0bf63a756b441958d73fd371e534c55', 'c192cb2ec8a746f1b82a9ee1be5053bb', '18b6db99f7f34c939072225471043139', null, null);
INSERT INTO `class_student` VALUES ('b9904b154f11454bbc19d40ada65b4af', 'c192cb2ec8a746f1b82a9ee1be5053bb', '900fd1c9d4374e9bbc17d633d447d9fb', null, null);
INSERT INTO `class_student` VALUES ('bb2827c8376f482e852a835b540a079c', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'd9e09bfbb59942d0958a22c71d94a825', null, null);
INSERT INTO `class_student` VALUES ('bdad8bee88264a31a4487431a4daac6a', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'c74a9ef4aa9b4cd9bf26abc14fd36e08', null, null);
INSERT INTO `class_student` VALUES ('beec5dd0945e4288bd36ed67d72b81f8', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'd5a0cdfaae594125b7de403b962d8123', null, null);
INSERT INTO `class_student` VALUES ('c0322e07e41e49c48b77069d3252d991', 'c192cb2ec8a746f1b82a9ee1be5053bb', '17812e3d26a84daba20c35fedc91dbee', null, null);
INSERT INTO `class_student` VALUES ('c9e8c80925a8466d8194a82a90978af9', 'c192cb2ec8a746f1b82a9ee1be5053bb', '4e474e40a3f4429eb29b25b46ab03883', null, null);
INSERT INTO `class_student` VALUES ('cdcd357a9c724ead97b785ca27536c57', 'c192cb2ec8a746f1b82a9ee1be5053bb', '229799ab07c64edcab110052c8aec85f', null, null);
INSERT INTO `class_student` VALUES ('d4af765f84144fda87389e2456414a50', 'c192cb2ec8a746f1b82a9ee1be5053bb', '4f1bb4674bd645a0b131937bc4f0100a', null, null);
INSERT INTO `class_student` VALUES ('d8ca43dfa4974399b3e09460ef1b6a61', 'c192cb2ec8a746f1b82a9ee1be5053bb', '04c07692fa6b4150a2b2741b056f2c1a', null, null);
INSERT INTO `class_student` VALUES ('da03a61d0d3f4ed5b459879273167963', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'c4082c28721746bc8f6b5190f55f63b1', null, null);
INSERT INTO `class_student` VALUES ('dd2e84519c02427e971ca91f9bb7c423', 'c192cb2ec8a746f1b82a9ee1be5053bb', '384fe8e5c4414ef69bd4a6e8f8fa3176', null, null);
INSERT INTO `class_student` VALUES ('e1b0b88aa12d4db584508b99549a5c1d', 'c192cb2ec8a746f1b82a9ee1be5053bb', '5fda5fc575814287beff7df3b0387628', null, null);
INSERT INTO `class_student` VALUES ('e8b99bdfda5e43a88701b12d71766d0a', 'c192cb2ec8a746f1b82a9ee1be5053bb', '12b2a12b95d94f40b48f871b8036f7ee', null, null);
INSERT INTO `class_student` VALUES ('e8f3b6f9ac9d4471aaf55808d801da67', 'c192cb2ec8a746f1b82a9ee1be5053bb', '89e20d1672c74c8b936414ff580b6243', null, null);
INSERT INTO `class_student` VALUES ('eb7ed2daddb14c568f0eb22e6fb9011a', 'c192cb2ec8a746f1b82a9ee1be5053bb', '979aee99fe3b484e873ddf87b11e1cfb', null, null);
INSERT INTO `class_student` VALUES ('f0de23adbafa4efa8e114e350e84db0a', 'c192cb2ec8a746f1b82a9ee1be5053bb', '3fe7f3043707471ba027c45afc87cee8', null, null);
INSERT INTO `class_student` VALUES ('f493ab507ace4e90a2cf979aceb175da', 'c192cb2ec8a746f1b82a9ee1be5053bb', '8ccc73b9765f46789ecacb74bf5b8818', null, null);
INSERT INTO `class_student` VALUES ('f7b82946418d44c8b9894a9fdbd8adba', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'f33dea578e884799bd4796b4dd02b5f6', null, null);
INSERT INTO `class_student` VALUES ('fb412d39f88c4a4abde16b44e4d914e2', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'd589d07ab31f4f76b459de0c8f368aba', null, null);
INSERT INTO `class_student` VALUES ('ff2e1d0da821423a935557b403496ebc', 'c192cb2ec8a746f1b82a9ee1be5053bb', 'e3e75c92d2a544daa2997f1ffd142c4a', null, null);

-- ----------------------------
-- Table structure for `class_time`
-- ----------------------------
DROP TABLE IF EXISTS `class_time`;
CREATE TABLE `class_time` (
  `id` varchar(100) NOT NULL,
  `classId` varchar(100) default NULL,
  `classDate` varchar(10) default NULL,
  `beginTime` varchar(5) default NULL,
  `endTime` varchar(5) default NULL,
  `address` varchar(200) default NULL,
  `content` text,
  `creator` varchar(100) default NULL,
  `createdate` varchar(23) default NULL,
  `isDeleted` char(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of class_time
-- ----------------------------
INSERT INTO `class_time` VALUES ('ec950d1195654441ad93f20276594e0c', 'c192cb2ec8a746f1b82a9ee1be5053bb', '2016-02-24', '01:00', '23:00', null, null, '2476f88b4855495cb249594dcf4341f5', '2016-02-24 16:47:34', '0');

-- ----------------------------
-- Table structure for `class_xd`
-- ----------------------------
DROP TABLE IF EXISTS `class_xd`;
CREATE TABLE `class_xd` (
  `id` varchar(100) NOT NULL,
  `classId` varchar(100) default NULL,
  `xdId` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of class_xd
-- ----------------------------

-- ----------------------------
-- Table structure for `class_xk`
-- ----------------------------
DROP TABLE IF EXISTS `class_xk`;
CREATE TABLE `class_xk` (
  `id` varchar(100) NOT NULL,
  `classId` varchar(100) default NULL,
  `xkId` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of class_xk
-- ----------------------------

-- ----------------------------
-- Table structure for `code_data`
-- ----------------------------
DROP TABLE IF EXISTS `code_data`;
CREATE TABLE `code_data` (
  `id` varchar(100) NOT NULL,
  `typeId` varchar(100) default NULL,
  `name` varchar(100) default NULL,
  `isActives` char(1) default NULL,
  `isDeleted` char(1) default NULL,
  `creator` varchar(100) default NULL,
  `createdate` varchar(23) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of code_data
-- ----------------------------
INSERT INTO `code_data` VALUES ('009cedf7da7748518408aeccc03d0b6c', '769a6443dce04df6915d88bc041f26d9', '高中心理', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 10:29:41');
INSERT INTO `code_data` VALUES ('00e7e48ea26841c7a01ac84d53d0336a', '0cfbaafced094ae8939bfb0f87c106a4', '藏族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:11:14');
INSERT INTO `code_data` VALUES ('01215736a8ba435ab2539867f82c70c7', '0cfbaafced094ae8939bfb0f87c106a4', '畲族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:21:08');
INSERT INTO `code_data` VALUES ('02e736acfbc54af0ba7fe8c41a2e7ad6', '62036660b54f40fbb933933a2c075d08', '中国国民党革命委员会', '0', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:39:53');
INSERT INTO `code_data` VALUES ('031765676dbe4b398cb4fa9469009de2', '769a6443dce04df6915d88bc041f26d9', '初中化学', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:31:39');
INSERT INTO `code_data` VALUES ('03271e4e24bb4c149cbbc69ef59e6b61', '0cfbaafced094ae8939bfb0f87c106a4', '塔塔尔族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:25:35');
INSERT INTO `code_data` VALUES ('0346b53d98ae4bf4876745ee21fcc171', '0cfbaafced094ae8939bfb0f87c106a4', '基诺族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:26:18');
INSERT INTO `code_data` VALUES ('063e881fe2a24b12b15279aae55aa6cd', '62036660b54f40fbb933933a2c075d08', '九三学社', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:41:01');
INSERT INTO `code_data` VALUES ('06a04482244f4f53b3483200b1c6b10e', '0cfbaafced094ae8939bfb0f87c106a4', '京族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:25:27');
INSERT INTO `code_data` VALUES ('0736efcbffc14d558c1f5d62b7748bdc', '0cfbaafced094ae8939bfb0f87c106a4', '汉族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:10:53');
INSERT INTO `code_data` VALUES ('0aaaba9e88d64245b829730ff4740629', '0cfbaafced094ae8939bfb0f87c106a4', '毛难族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:23:22');
INSERT INTO `code_data` VALUES ('0b87f509087a461f8fe5209c502bd85b', '0cfbaafced094ae8939bfb0f87c106a4', '白族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:19:06');
INSERT INTO `code_data` VALUES ('0d80cf0201334afda038dc164ef1e3de', '0cfbaafced094ae8939bfb0f87c106a4', '俄罗斯族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:24:45');
INSERT INTO `code_data` VALUES ('112195027cee4c99a648ca211445dc20', '9a6b8dfa0a93455f97f61150cfcd364f', '数学', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-09-23 18:51:03');
INSERT INTO `code_data` VALUES ('13c5f255e43a48a285126668d89a45e1', '769a6443dce04df6915d88bc041f26d9', '初中语文', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:31:07');
INSERT INTO `code_data` VALUES ('13f93084f85144d980147764651bf69c', '3201a7266c764ed6a17a3a3ec2a6e232', '培训班', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 14:55:02');
INSERT INTO `code_data` VALUES ('16372a1715a4469c882bd5051a068637', '0cfbaafced094ae8939bfb0f87c106a4', '塔吉克族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:24:00');
INSERT INTO `code_data` VALUES ('18b3a7f1f6184a5d80f4423d541f0041', '0cfbaafced094ae8939bfb0f87c106a4', '赫哲族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:25:56');
INSERT INTO `code_data` VALUES ('18d1fd3f6da44bfdb887379b92e7be06', '9c55d48fda4c4210ab82f3ab560ccf95', '公办学校', '1', '0', null, null);
INSERT INTO `code_data` VALUES ('1aee79eb0e8a4d6d86fef100e5aac805', '769a6443dce04df6915d88bc041f26d9', '初中体育', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:32:41');
INSERT INTO `code_data` VALUES ('1bd86e2cf42c4816abd591794f713985', '0cfbaafced094ae8939bfb0f87c106a4', '仫佬族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:22:44');
INSERT INTO `code_data` VALUES ('1dbb1bd7923d45478a9e97dec0397629', '0cfbaafced094ae8939bfb0f87c106a4', '侗族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:18:52');
INSERT INTO `code_data` VALUES ('1df544b4e2834eaf97803c51fae7368f', '769a6443dce04df6915d88bc041f26d9', '初中英语', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:31:28');
INSERT INTO `code_data` VALUES ('21270ba66aaa4d57a535db9f64306426', '769a6443dce04df6915d88bc041f26d9', '小学信息技术', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:30:27');
INSERT INTO `code_data` VALUES ('255b050b543249178f30d69f5c1388bd', '0cfbaafced094ae8939bfb0f87c106a4', '佤族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:21:02');
INSERT INTO `code_data` VALUES ('25e9729ce2d24686943d20a2d33f9d07', '769a6443dce04df6915d88bc041f26d9', '高中历史', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:36:50');
INSERT INTO `code_data` VALUES ('2755fa3f1ef749c3a2bef8a00aa4de43', '62036660b54f40fbb933933a2c075d08', '中国共产党', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 11:18:43');
INSERT INTO `code_data` VALUES ('27aad655ceb54a608c9f708bc2f2d44f', '0cfbaafced094ae8939bfb0f87c106a4', '达斡尔族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:22:37');
INSERT INTO `code_data` VALUES ('294c00138dde4bf9a2b23d996fd46e5f', '769a6443dce04df6915d88bc041f26d9', '高中物理', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:36:27');
INSERT INTO `code_data` VALUES ('2bdfe481999e4ea0a1102076eb08dc76', '3a7d167c2e1d4c5b9230223ea9f15544', '高中', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 08:51:08');
INSERT INTO `code_data` VALUES ('2c5e786414fe4fc683b83ef67695c2d1', '0cfbaafced094ae8939bfb0f87c106a4', '蒙古族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:10:59');
INSERT INTO `code_data` VALUES ('2e96280642d84076832a6fddaead50f7', '769a6443dce04df6915d88bc041f26d9', '小学品生', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:29:56');
INSERT INTO `code_data` VALUES ('318bf55f8ea345ee856f7f53d2fc971f', '0cfbaafced094ae8939bfb0f87c106a4', '布依族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:17:07');
INSERT INTO `code_data` VALUES ('32a0d4a4448a4d9286be94bafb01c33d', '0cfbaafced094ae8939bfb0f87c106a4', '保安族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:25:13');
INSERT INTO `code_data` VALUES ('336ba07939ea4ac5b8183f16d9cddeca', '0cfbaafced094ae8939bfb0f87c106a4', '\'阿昌族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:23:47');
INSERT INTO `code_data` VALUES ('33846eb101834f918c0b9ed9052fac31', '769a6443dce04df6915d88bc041f26d9', '高中数学', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:36:15');
INSERT INTO `code_data` VALUES ('3581c96657694fb78dba835ddb175384', '769a6443dce04df6915d88bc041f26d9', '初中政治', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:32:26');
INSERT INTO `code_data` VALUES ('36b5f8619e31461c8a8701cf0ff6cfe7', '769a6443dce04df6915d88bc041f26d9', '小学语文', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 08:51:24');
INSERT INTO `code_data` VALUES ('405128b096b24da0b026ecc2e5b38f96', '0cfbaafced094ae8939bfb0f87c106a4', '维吾尔族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:11:22');
INSERT INTO `code_data` VALUES ('47e885c2e73f410989004284a5ae0492', '0cfbaafced094ae8939bfb0f87c106a4', '撒拉族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:23:14');
INSERT INTO `code_data` VALUES ('48f92f5aea864ef19520dc279b71d3dc', '43557a76686d41a08394cd3cf9503327', '幼儿园', '1', '0', null, null);
INSERT INTO `code_data` VALUES ('4a2d7c6155ca4a9f9fe000639ebd941c', '3a7d167c2e1d4c5b9230223ea9f15544', '中职', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 09:10:44');
INSERT INTO `code_data` VALUES ('4c9bf90552bd43ed9a7d464c8ca31a3a', '0cfbaafced094ae8939bfb0f87c106a4', '苗族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:16:45');
INSERT INTO `code_data` VALUES ('4eba1c17815e4d70bb26155cfd08d008', '769a6443dce04df6915d88bc041f26d9', '学前教育', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 10:34:56');
INSERT INTO `code_data` VALUES ('4f45bc83ce124d82857b6d2cffc215b3', '769a6443dce04df6915d88bc041f26d9', '高中体育', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:37:08');
INSERT INTO `code_data` VALUES ('52916f4e85e049f79191544ad20fdf80', '0cfbaafced094ae8939bfb0f87c106a4', '乌孜别克族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:24:37');
INSERT INTO `code_data` VALUES ('54ac3ad8cb79442cba99f3b64a42e07d', '769a6443dce04df6915d88bc041f26d9', '高中英语', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:36:20');
INSERT INTO `code_data` VALUES ('55a0b6cb5ecf4a74913568543a8bc3f6', '0cfbaafced094ae8939bfb0f87c106a4', '满族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:18:46');
INSERT INTO `code_data` VALUES ('583dfea38bbe4801aba866170d155f57', '769a6443dce04df6915d88bc041f26d9', '小学音乐', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:30:12');
INSERT INTO `code_data` VALUES ('58b5552febe4427e9c89ad985ebd1b4a', '769a6443dce04df6915d88bc041f26d9', '高中生物', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:36:42');
INSERT INTO `code_data` VALUES ('5ab9f9e8f5c6451995308ff83837b030', '0cfbaafced094ae8939bfb0f87c106a4', '黎族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:20:49');
INSERT INTO `code_data` VALUES ('5b4106de00e647c586ebf8d0482490f6', '0cfbaafced094ae8939bfb0f87c106a4', '裕固族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:25:20');
INSERT INTO `code_data` VALUES ('5ddf22229e5c4ceba31e0f84a5f77a04', '3a7d167c2e1d4c5b9230223ea9f15544', '学前', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 08:50:39');
INSERT INTO `code_data` VALUES ('5de66794ac5149dd96d8915027d9eab7', '0cfbaafced094ae8939bfb0f87c106a4', '高山族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:21:16');
INSERT INTO `code_data` VALUES ('60f2a980b672467eb16e95922706f25b', '0cfbaafced094ae8939bfb0f87c106a4', '拉祜族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:21:26');
INSERT INTO `code_data` VALUES ('6279cdc2ac5d4dbc97dcf300e51d384e', '769a6443dce04df6915d88bc041f26d9', '小学科学', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:30:36');
INSERT INTO `code_data` VALUES ('632bd03649fe4c3fbab1940abc400231', '0cfbaafced094ae8939bfb0f87c106a4', '土族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:22:27');
INSERT INTO `code_data` VALUES ('6691edf7b53b475b804d519b7c988a9d', '0cfbaafced094ae8939bfb0f87c106a4', '门巴族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:26:03');
INSERT INTO `code_data` VALUES ('66ebf42ae8a440c78f6940acb1c98059', '0cfbaafced094ae8939bfb0f87c106a4', '鄂伦春族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:25:49');
INSERT INTO `code_data` VALUES ('6cd73eb955c14264a79ad20e43cf0124', '0cfbaafced094ae8939bfb0f87c106a4', '柯尔克孜族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:22:11');
INSERT INTO `code_data` VALUES ('6d72803ba3d243b2a3aab27eababce3a', '62036660b54f40fbb933933a2c075d08', '中国民主建国会', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:40:17');
INSERT INTO `code_data` VALUES ('7139b5f60b46448a83f67c7c0217c9ff', '769a6443dce04df6915d88bc041f26d9', '初中地理', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:34:10');
INSERT INTO `code_data` VALUES ('7353a169c3a44a508002d9103c0c868d', '769a6443dce04df6915d88bc041f26d9', '小学综合实践', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:30:57');
INSERT INTO `code_data` VALUES ('796a1bf195424800bd331e590877aa3d', '769a6443dce04df6915d88bc041f26d9', '初中历史', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:31:59');
INSERT INTO `code_data` VALUES ('84e2bc002e0c4495bdf76f9114a594f6', '62036660b54f40fbb933933a2c075d08', '中国农工民主党', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:40:42');
INSERT INTO `code_data` VALUES ('86879dfc63ea4e49a0c71b8c78aa4d4b', '769a6443dce04df6915d88bc041f26d9', '小学美术', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:30:19');
INSERT INTO `code_data` VALUES ('87dee275de5346c9ace3965ec2bf48a7', '0cfbaafced094ae8939bfb0f87c106a4', '哈萨克族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:20:11');
INSERT INTO `code_data` VALUES ('8a41b012c0a64013af6f30a0ec68bfce', '0cfbaafced094ae8939bfb0f87c106a4', '彝族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:16:52');
INSERT INTO `code_data` VALUES ('8d5a5c09d78847d1a4c41abaf20eef15', '769a6443dce04df6915d88bc041f26d9', '高中化学', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:36:32');
INSERT INTO `code_data` VALUES ('8f5f5af7b7ee47dcb1b6bf615524bb4f', '0cfbaafced094ae8939bfb0f87c106a4', '回族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:11:07');
INSERT INTO `code_data` VALUES ('8ffc4b908f0f406684cd0e6273f20d6d', '0cfbaafced094ae8939bfb0f87c106a4', '崩龙族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:24:59');
INSERT INTO `code_data` VALUES ('916c0ef83f9048688bc3c7c3849f79ff', '9c55d48fda4c4210ab82f3ab560ccf95', '民办学校', '1', '0', null, null);
INSERT INTO `code_data` VALUES ('91e448e7a283442592fe0e09df2f7536', '769a6443dce04df6915d88bc041f26d9', '小学数学', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 08:51:52');
INSERT INTO `code_data` VALUES ('93647df8cc86477899a88704724f1a57', '0cfbaafced094ae8939bfb0f87c106a4', '傈僳族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:20:56');
INSERT INTO `code_data` VALUES ('961049bb29e349a4969500e6e5360c82', '769a6443dce04df6915d88bc041f26d9', '初中物理', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:31:34');
INSERT INTO `code_data` VALUES ('99d9eebda0e74ad2badc27b3afc2dcc1', '769a6443dce04df6915d88bc041f26d9', '初中劳动与技术', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:33:17');
INSERT INTO `code_data` VALUES ('9b0b1fa35dfe4ccaa324cc6c7d1fcde5', '769a6443dce04df6915d88bc041f26d9', '高中音乐', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:37:16');
INSERT INTO `code_data` VALUES ('9d741ef3b735494f97b2b88267c47f59', '0cfbaafced094ae8939bfb0f87c106a4', '朝鲜族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:17:14');
INSERT INTO `code_data` VALUES ('9e9d2a20e2e94c81afa9501b2509f981', '3a7d167c2e1d4c5b9230223ea9f15544', '小学', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 08:50:46');
INSERT INTO `code_data` VALUES ('a2660da89f7a48ea9e3bbda9e682631f', '0cfbaafced094ae8939bfb0f87c106a4', '东乡族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:21:48');
INSERT INTO `code_data` VALUES ('a333480d0d814879be3375667dc45fe5', '769a6443dce04df6915d88bc041f26d9', '高中美术', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:37:21');
INSERT INTO `code_data` VALUES ('a3dd479888294110897b522bbdcbb0f3', '769a6443dce04df6915d88bc041f26d9', '小学体育', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:30:04');
INSERT INTO `code_data` VALUES ('a45217a5bf8c49c59875ee0d538837d3', '769a6443dce04df6915d88bc041f26d9', '高中通用技术', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:37:42');
INSERT INTO `code_data` VALUES ('a5ccd1a11c6545bc8773bb2863bd1fd0', '62036660b54f40fbb933933a2c075d08', '中国致公党', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:40:51');
INSERT INTO `code_data` VALUES ('a9ad5c2748c94da188567e8d3c7dc305', '769a6443dce04df6915d88bc041f26d9', '初中音乐', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:32:46');
INSERT INTO `code_data` VALUES ('a9d27464be884e93ba2c76b1e5386f12', '62036660b54f40fbb933933a2c075d08', '中国民主同盟', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:40:05');
INSERT INTO `code_data` VALUES ('ab987428bb424a8aa1c8eaa29aae929f', '0cfbaafced094ae8939bfb0f87c106a4', '普米族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:23:54');
INSERT INTO `code_data` VALUES ('ad16028c10f44dcb8fef1211f9f2fe81', '9a6b8dfa0a93455f97f61150cfcd364f', '礼仪', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-09-23 18:50:16');
INSERT INTO `code_data` VALUES ('ae90fe83493644c58f38f000819114de', '0cfbaafced094ae8939bfb0f87c106a4', '纳西族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:21:55');
INSERT INTO `code_data` VALUES ('b34a3fb4bbbb4590a29dfb11aa98996e', '3a7d167c2e1d4c5b9230223ea9f15544', '初中', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 08:51:01');
INSERT INTO `code_data` VALUES ('b3ca7bda3ed9481c8331e69a54b7fb4c', '0cfbaafced094ae8939bfb0f87c106a4', '怒族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:24:30');
INSERT INTO `code_data` VALUES ('b559aea4da264baf934be51e81bfff0a', '43557a76686d41a08394cd3cf9503327', '小学', '1', '0', null, null);
INSERT INTO `code_data` VALUES ('b6b1c525623a41198695456e59522e43', '769a6443dce04df6915d88bc041f26d9', '小学英语', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 08:51:58');
INSERT INTO `code_data` VALUES ('b8e77d75acc0494bac66a6df318676b8', '43557a76686d41a08394cd3cf9503327', '中职', '1', '0', null, null);
INSERT INTO `code_data` VALUES ('b92e009628c14191b4d909d2cfaead4b', '0cfbaafced094ae8939bfb0f87c106a4', '鄂温克族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:24:51');
INSERT INTO `code_data` VALUES ('bc8c42ac0e694e419f5efebe45bfe655', '0cfbaafced094ae8939bfb0f87c106a4', '景颇族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:22:04');
INSERT INTO `code_data` VALUES ('bf1d6218194848f0a8f9a99e6af11a21', '0cfbaafced094ae8939bfb0f87c106a4', '哈尼族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:19:58');
INSERT INTO `code_data` VALUES ('c0f56a2429d648b5a86555e43d33136d', '0cfbaafced094ae8939bfb0f87c106a4', '傣族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:20:18');
INSERT INTO `code_data` VALUES ('c438b9814f494e32b74d8c8915f9e936', '769a6443dce04df6915d88bc041f26d9', '高中语文', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:36:09');
INSERT INTO `code_data` VALUES ('c477f117f3404d3b8002be4893e2055d', '769a6443dce04df6915d88bc041f26d9', '高中地理', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:36:56');
INSERT INTO `code_data` VALUES ('c83880827f6e4cf280694e3666535f0c', '769a6443dce04df6915d88bc041f26d9', '小学心理', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 10:29:48');
INSERT INTO `code_data` VALUES ('cb6a76b00e46438496848e5f19eda3bc', '0cfbaafced094ae8939bfb0f87c106a4', '瑶族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:19:00');
INSERT INTO `code_data` VALUES ('cfb83148030b463a93b2c8c5bb84c668', '769a6443dce04df6915d88bc041f26d9', '初中生物', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:31:51');
INSERT INTO `code_data` VALUES ('d02f839a5c1a4e9eb6c29958a819a434', '0cfbaafced094ae8939bfb0f87c106a4', '仡佬族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:23:30');
INSERT INTO `code_data` VALUES ('d3b2f69376134532bc205d5b27e959bd', '43557a76686d41a08394cd3cf9503327', '九年制', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 10:48:17');
INSERT INTO `code_data` VALUES ('d43dc6cec5ba40019670659e4b2deb8d', '0cfbaafced094ae8939bfb0f87c106a4', '土家族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:19:51');
INSERT INTO `code_data` VALUES ('d76df435a99c43779ed62aff5651dd14', '0cfbaafced094ae8939bfb0f87c106a4', '独龙族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:25:42');
INSERT INTO `code_data` VALUES ('d891e9e981c444d6978a5ce5fd30af76', '0cfbaafced094ae8939bfb0f87c106a4', '羌族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:22:51');
INSERT INTO `code_data` VALUES ('da2c6fcff1194c1aa8d6e69d2b224051', '0cfbaafced094ae8939bfb0f87c106a4', '壮族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:16:59');
INSERT INTO `code_data` VALUES ('da8011d67ec74a01beef7c6043de450c', '769a6443dce04df6915d88bc041f26d9', '小学品社', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 08:51:33');
INSERT INTO `code_data` VALUES ('deaf2241ce284d4bad214713253a33d1', '0cfbaafced094ae8939bfb0f87c106a4', '锡伯族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:23:38');
INSERT INTO `code_data` VALUES ('df51094287554eeca1bb0f2a94635e76', '9a6b8dfa0a93455f97f61150cfcd364f', '语文', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-09-23 18:50:56');
INSERT INTO `code_data` VALUES ('e28c2c707c6e4cca9117468f17f8426c', '769a6443dce04df6915d88bc041f26d9', '高中政治', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:37:02');
INSERT INTO `code_data` VALUES ('e505e6f9a2c9449f93fd6fee9d842fd8', '62036660b54f40fbb933933a2c075d08', '中国民主促进会', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:40:27');
INSERT INTO `code_data` VALUES ('e98b4f5b28d54d8db9e1eb8d78701322', '769a6443dce04df6915d88bc041f26d9', '初中信息技术', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:33:01');
INSERT INTO `code_data` VALUES ('e9f25d1df91a4267b2736ec5ea682461', '62036660b54f40fbb933933a2c075d08', '台湾民主自治同盟', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:41:14');
INSERT INTO `code_data` VALUES ('ec786d68d9414af4b33cc5d66be5466e', '769a6443dce04df6915d88bc041f26d9', '初中数学', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:31:22');
INSERT INTO `code_data` VALUES ('ef807a340e044440b36cceb76777ea63', '769a6443dce04df6915d88bc041f26d9', '初中心理', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 10:29:33');
INSERT INTO `code_data` VALUES ('f04dca35c3224b6a9a6f7bcf735989f2', '0cfbaafced094ae8939bfb0f87c106a4', '珞巴族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:26:09');
INSERT INTO `code_data` VALUES ('f0d98ba91a20417ebc5b4e515c58ed6e', '0cfbaafced094ae8939bfb0f87c106a4', '水族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:21:35');
INSERT INTO `code_data` VALUES ('f40e91767ed04cbaa047182f83dc8f97', '769a6443dce04df6915d88bc041f26d9', '初中综合实践', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:35:58');
INSERT INTO `code_data` VALUES ('f55c0462da414c12bae6192a91c45044', '43557a76686d41a08394cd3cf9503327', '中学', '1', '0', null, null);
INSERT INTO `code_data` VALUES ('f941a871684f42eab623bcea0ac11fb0', '43557a76686d41a08394cd3cf9503327', '完中', '1', '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:38:12');
INSERT INTO `code_data` VALUES ('f9c53e590692430aaa7dd1f0a4607ef2', '769a6443dce04df6915d88bc041f26d9', '初中美术', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:32:51');
INSERT INTO `code_data` VALUES ('fe90d4c8e64b4149a8778b278d11dfff', '769a6443dce04df6915d88bc041f26d9', '高中信息技术', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:37:35');
INSERT INTO `code_data` VALUES ('ff735cc63ec547108b64f4508dc4256b', '0cfbaafced094ae8939bfb0f87c106a4', '布朗族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:22:57');

-- ----------------------------
-- Table structure for `code_type`
-- ----------------------------
DROP TABLE IF EXISTS `code_type`;
CREATE TABLE `code_type` (
  `id` varchar(100) NOT NULL,
  `code` varchar(10) default NULL,
  `name` varchar(100) default NULL,
  `isActives` char(1) default NULL,
  `isDeleted` char(1) default NULL,
  `creator` varchar(100) default NULL,
  `createdate` varchar(23) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of code_type
-- ----------------------------
INSERT INTO `code_type` VALUES ('0cfbaafced094ae8939bfb0f87c106a4', 'MZ', '民族', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 10:10:26');
INSERT INTO `code_type` VALUES ('3201a7266c764ed6a17a3a3ec2a6e232', 'BJLB', '班级类别', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 14:54:42');
INSERT INTO `code_type` VALUES ('3a7d167c2e1d4c5b9230223ea9f15544', 'XD', '学段', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 08:49:59');
INSERT INTO `code_type` VALUES ('43557a76686d41a08394cd3cf9503327', 'XXLX', '学校类型', '1', '0', null, null);
INSERT INTO `code_type` VALUES ('62036660b54f40fbb933933a2c075d08', 'DP', '党派', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 11:18:28');
INSERT INTO `code_type` VALUES ('769a6443dce04df6915d88bc041f26d9', 'XK', '学科', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 08:50:16');
INSERT INTO `code_type` VALUES ('9a6b8dfa0a93455f97f61150cfcd364f', 'KM', '科目', '1', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-09-23 18:49:53');
INSERT INTO `code_type` VALUES ('9c55d48fda4c4210ab82f3ab560ccf95', 'XXLB', '学校类别', '1', '0', null, null);

-- ----------------------------
-- Table structure for `course_data`
-- ----------------------------
DROP TABLE IF EXISTS `course_data`;
CREATE TABLE `course_data` (
  `id` varchar(100) NOT NULL,
  `courseId` varchar(100) default NULL,
  `name` varchar(20) default NULL,
  `dataUrl` varchar(200) default NULL,
  `remark` text,
  `creator` varchar(100) default NULL,
  `createdate` varchar(23) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_data
-- ----------------------------
INSERT INTO `course_data` VALUES ('31b96708e1554402b8abf997c2b75e8b', '50030dff568448f58bbed5536e588eef', '测试', 'admin/course/20160219162435830.png', '参数', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-02-19 16:24:41');
INSERT INTO `course_data` VALUES ('dff2738774b148bbb7da96e79f4d267d', '50030dff568448f58bbed5536e588eef', '测试2', 'admin/course/20160219165659675.xls', null, '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-02-19 16:56:59');

-- ----------------------------
-- Table structure for `course_management`
-- ----------------------------
DROP TABLE IF EXISTS `course_management`;
CREATE TABLE `course_management` (
  `id` varchar(100) NOT NULL,
  `name` varchar(50) default NULL,
  `instructorId` varchar(100) default NULL,
  `introduction` text,
  `creator` varchar(100) default NULL,
  `createdate` varchar(23) default NULL,
  `isDeleted` char(1) default NULL,
  `dataUrl` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_management
-- ----------------------------
INSERT INTO `course_management` VALUES ('50030dff568448f58bbed5536e588eef', '新教师生态培训', null, null, '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:49:51', '0', null);

-- ----------------------------
-- Table structure for `homework_manager`
-- ----------------------------
DROP TABLE IF EXISTS `homework_manager`;
CREATE TABLE `homework_manager` (
  `id` varchar(100) NOT NULL,
  `title` varchar(100) default NULL,
  `homeworkUrl` varchar(255) default NULL,
  `uploader` varchar(100) NOT NULL,
  `classId` varchar(100) NOT NULL,
  `endUploadTime` varchar(30) default NULL,
  `uploadTime` varchar(30) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of homework_manager
-- ----------------------------

-- ----------------------------
-- Table structure for `lesson_management`
-- ----------------------------
DROP TABLE IF EXISTS `lesson_management`;
CREATE TABLE `lesson_management` (
  `id` varchar(100) NOT NULL,
  `courseId` varchar(100) default NULL,
  `subjectId` varchar(100) default NULL,
  `lesson` varchar(20) default NULL,
  `creator` varchar(100) default NULL,
  `createdate` varchar(23) default NULL,
  `instructor` varchar(20) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lesson_management
-- ----------------------------

-- ----------------------------
-- Table structure for `menu_info`
-- ----------------------------
DROP TABLE IF EXISTS `menu_info`;
CREATE TABLE `menu_info` (
  `id` varchar(100) NOT NULL,
  `code` varchar(50) default NULL,
  `pid` varchar(100) default NULL,
  `pcode` varchar(50) default NULL,
  `name` varchar(20) default NULL,
  `urls` varchar(100) default NULL,
  `series` int(11) default NULL,
  `seq` int(11) default NULL,
  `isActives` char(1) default NULL,
  `isDeleted` char(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu_info
-- ----------------------------
INSERT INTO `menu_info` VALUES ('024080a7cb1a4608ad891073fbc5ef50', '102120', 'b1e9d5ab4cbf48fd86c6477b256ad972', '102', '分数录入', '../baseinfo/classStudent/redirectScores.do', '2', '16', '1', '0');
INSERT INTO `menu_info` VALUES ('03b90404ce4a4c1da08cd4672233b2ee', '101102', '0d8a183fbec544c38538c8eb14b6379a', '101', '单位组织机构管理', '../baseinfo/unitInfo/redirect.do', '2', '7', '1', '0');
INSERT INTO `menu_info` VALUES ('0c269659b12c453a9c68fdb85561c0fc', '102116', 'b1e9d5ab4cbf48fd86c6477b256ad972', '102', '公告通知', '../train/noticeInfo/redirect.do', '2', '12', '1', '0');
INSERT INTO `menu_info` VALUES ('0d8a183fbec544c38538c8eb14b6379a', '101', null, null, '基础数据管理', '#', '1', '4', '1', '0');
INSERT INTO `menu_info` VALUES ('100567d9ce5c43f59f82e2c65ac6fb4d', '102115', 'b1e9d5ab4cbf48fd86c6477b256ad972', '102', '申请受理', '../baseinfo/accepte/redirect.do', '2', '11', '1', '0');
INSERT INTO `menu_info` VALUES ('15f2b550ea3c40acb2dd1aca661ee393', '102111', 'b1e9d5ab4cbf48fd86c6477b256ad972', '102', '上课时间设置', '../baseinfo/classTime/redirect.do', '2', '3', '1', '0');
INSERT INTO `menu_info` VALUES ('180f15acb45c4b308f90e0fe1fd2af59', '100', null, null, '系统管理', '#', '1', '1', '1', '0');
INSERT INTO `menu_info` VALUES ('4f46f5b185d2483db5ab35bff1883884', '102113', 'b1e9d5ab4cbf48fd86c6477b256ad972', '102', '考勤信息统计', '../baseinfo/attendanceInfo/redirect.do', '2', '5', '1', '0');
INSERT INTO `menu_info` VALUES ('76df85616dc644b28d2270944bc6f82c', '100101', '180f15acb45c4b308f90e0fe1fd2af59', '100', '菜单管理', '../platform/menuInfo/redirect.do', '2', '3', '1', '0');
INSERT INTO `menu_info` VALUES ('860b8f73c73e429d966a7ffdccd413c0', '101103', '0d8a183fbec544c38538c8eb14b6379a', '101', '老师信息', '../baseinfo/teacherInfo/redirect.do', '2', '8', '1', '0');
INSERT INTO `menu_info` VALUES ('87758ff40704448bbd6ba1eaf78eb891', '102114', 'b1e9d5ab4cbf48fd86c6477b256ad972', '102', '学生申请', '../baseinfo/application/redirect.do', '2', '10', '1', '0');
INSERT INTO `menu_info` VALUES ('a2d9d56dd028462fb517b0d0e68c21da', '102109', 'b1e9d5ab4cbf48fd86c6477b256ad972', '102', '时间设置', '../baseinfo/timeSetting/add.do', '2', '2', '1', '0');
INSERT INTO `menu_info` VALUES ('a6116d48aa3f4822b29879ebbf9d2841', '101100', '0d8a183fbec544c38538c8eb14b6379a', '101', '字典类型管理', '../baseinfo/codeType/redirect.do', '2', '5', '1', '0');
INSERT INTO `menu_info` VALUES ('b1e9d5ab4cbf48fd86c6477b256ad972', '102', null, null, '培训管理', '#', '1', '2', '1', '0');
INSERT INTO `menu_info` VALUES ('ca830adc41174d39a00643c3a84290f5', '102117', 'b1e9d5ab4cbf48fd86c6477b256ad972', '102', '课程管理', '../baseinfo/courseManagement/redirect.do', '2', '13', '1', '0');
INSERT INTO `menu_info` VALUES ('cd638a75dffb4c00aa1dba3c9a53a2eb', '101101', '0d8a183fbec544c38538c8eb14b6379a', '101', '字典数据', '../baseinfo/codeData/redirect.do', '2', '6', '1', '0');
INSERT INTO `menu_info` VALUES ('cf70fca02e7944268e0d0a1db115f38f', '102118', 'b1e9d5ab4cbf48fd86c6477b256ad972', '102', '作业管理', '../baseinfo/homework/redirect.do', '2', '14', '1', '0');
INSERT INTO `menu_info` VALUES ('e9c4e47d3fb6417c828e1f7dd6548508', '102112', 'b1e9d5ab4cbf48fd86c6477b256ad972', '102', '人工考勤', '../baseinfo/artificialAttendance/redirect.do', '2', '4', '1', '0');
INSERT INTO `menu_info` VALUES ('eb122ac445a8406493b3eef355e7d83a', '100100', '180f15acb45c4b308f90e0fe1fd2af59', '100', '用户管理', '../platform/userInfo/redirect.do', '2', '2', '1', '0');
INSERT INTO `menu_info` VALUES ('efbdcd4f8cbb45cab2ac9069ea93a2bd', '100102', '180f15acb45c4b308f90e0fe1fd2af59', '100', '角色管理', '../platform/role/redirect.do', '2', '9', '1', '0');
INSERT INTO `menu_info` VALUES ('f7fc2c99fd9d41ea8b69fdb1a1698872', '102119', 'b1e9d5ab4cbf48fd86c6477b256ad972', '102', '培训资格确认', '../baseinfo/accreditation/redirect.do', '2', '15', '1', '0');
INSERT INTO `menu_info` VALUES ('fe84bca0763b45848e1547d1100aed03', '102110', 'b1e9d5ab4cbf48fd86c6477b256ad972', '102', '培训班级管理', '../baseinfo/classInfo/redirect.do', '2', '1', '1', '0');

-- ----------------------------
-- Table structure for `notice_info`
-- ----------------------------
DROP TABLE IF EXISTS `notice_info`;
CREATE TABLE `notice_info` (
  `id` varchar(100) NOT NULL,
  `type` char(1) default NULL,
  `content` text,
  `creator` varchar(100) default NULL,
  `createdate` varchar(23) default NULL,
  `isDeleted` char(1) default NULL,
  `title` varchar(200) default NULL,
  `classId` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notice_info
-- ----------------------------

-- ----------------------------
-- Table structure for `quota_allocation`
-- ----------------------------
DROP TABLE IF EXISTS `quota_allocation`;
CREATE TABLE `quota_allocation` (
  `id` varchar(100) NOT NULL,
  `classId` varchar(100) default NULL,
  `schoolId` varchar(100) default NULL,
  `number` int(11) default NULL,
  `creator` varchar(100) default NULL,
  `createdate` varchar(23) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of quota_allocation
-- ----------------------------

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` varchar(100) NOT NULL,
  `name` varchar(50) default NULL,
  `status` varchar(20) default NULL,
  `createTime` varchar(50) default NULL,
  `updateTime` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('ce51f896209341e3b73c43c41174d19e', '学员权限', '启用', '2015-09-01 16:07:16', '2016-01-13 11:57:06');
INSERT INTO `role` VALUES ('e7579b7a56554ca2bac59e3cc2aa6d28', '超级管理员', '启用', '2015-08-31 10:20:51', '2015-08-31 10:20:51');

-- ----------------------------
-- Table structure for `role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu` (
  `id` varchar(100) NOT NULL,
  `roleId` varchar(100) default NULL,
  `menuId` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES ('0ea93d1e63aa422f99dafcd55465f8a5', 'e7579b7a56554ca2bac59e3cc2aa6d28', 'ca830adc41174d39a00643c3a84290f5');
INSERT INTO `role_menu` VALUES ('2c65153ec7b346e984ac6f81ea52311b', 'e7579b7a56554ca2bac59e3cc2aa6d28', 'a6116d48aa3f4822b29879ebbf9d2841');
INSERT INTO `role_menu` VALUES ('2eba8042dfe34d2980acfb5e8d3abb8a', 'e7579b7a56554ca2bac59e3cc2aa6d28', '76df85616dc644b28d2270944bc6f82c');
INSERT INTO `role_menu` VALUES ('3f54831556f44c1cbddc0b0498e490fc', 'e7579b7a56554ca2bac59e3cc2aa6d28', '0d8a183fbec544c38538c8eb14b6379a');
INSERT INTO `role_menu` VALUES ('474d11fdd7024046bb93917593957c3b', 'e7579b7a56554ca2bac59e3cc2aa6d28', '03b90404ce4a4c1da08cd4672233b2ee');
INSERT INTO `role_menu` VALUES ('4f7b6b7e44174a518124851aac96472d', 'e7579b7a56554ca2bac59e3cc2aa6d28', 'cf70fca02e7944268e0d0a1db115f38f');
INSERT INTO `role_menu` VALUES ('549fec8575e445dd90c89d568eced9cc', 'e7579b7a56554ca2bac59e3cc2aa6d28', 'eb122ac445a8406493b3eef355e7d83a');
INSERT INTO `role_menu` VALUES ('69e0fd37445f4b00801db419e4db424f', 'e7579b7a56554ca2bac59e3cc2aa6d28', '4f46f5b185d2483db5ab35bff1883884');
INSERT INTO `role_menu` VALUES ('69e329223a6b40e19367927bebd715a5', 'e7579b7a56554ca2bac59e3cc2aa6d28', 'e9c4e47d3fb6417c828e1f7dd6548508');
INSERT INTO `role_menu` VALUES ('77e992bf3a6441c1b714f1d1473a958f', 'e7579b7a56554ca2bac59e3cc2aa6d28', 'b1e9d5ab4cbf48fd86c6477b256ad972');
INSERT INTO `role_menu` VALUES ('7a56fda1b9234e95a3c42249b67d90bd', 'e7579b7a56554ca2bac59e3cc2aa6d28', '87758ff40704448bbd6ba1eaf78eb891');
INSERT INTO `role_menu` VALUES ('9bbb5f4c183d43bc9fbbd95de5e63eac', 'e7579b7a56554ca2bac59e3cc2aa6d28', 'cd638a75dffb4c00aa1dba3c9a53a2eb');
INSERT INTO `role_menu` VALUES ('a566231598be45328b9793a9ab88ed7f', 'e7579b7a56554ca2bac59e3cc2aa6d28', 'efbdcd4f8cbb45cab2ac9069ea93a2bd');
INSERT INTO `role_menu` VALUES ('abfa5e7a368f4a4d9a3f4154490c2205', 'e7579b7a56554ca2bac59e3cc2aa6d28', 'fe84bca0763b45848e1547d1100aed03');
INSERT INTO `role_menu` VALUES ('bb0a7c31cd434e9ba7ce75bfb6771773', 'e7579b7a56554ca2bac59e3cc2aa6d28', '0c269659b12c453a9c68fdb85561c0fc');
INSERT INTO `role_menu` VALUES ('cc6425722f46467885fbb57be5bcea4e', 'e7579b7a56554ca2bac59e3cc2aa6d28', 'f7fc2c99fd9d41ea8b69fdb1a1698872');
INSERT INTO `role_menu` VALUES ('ccb7d2f466484d5094b0a8dd076076c8', 'e7579b7a56554ca2bac59e3cc2aa6d28', '024080a7cb1a4608ad891073fbc5ef50');
INSERT INTO `role_menu` VALUES ('ce3667b899404ca49dedf1da8db3ce1f', 'e7579b7a56554ca2bac59e3cc2aa6d28', '15f2b550ea3c40acb2dd1aca661ee393');
INSERT INTO `role_menu` VALUES ('de44820f83214885b4ae915265c72531', 'e7579b7a56554ca2bac59e3cc2aa6d28', '100567d9ce5c43f59f82e2c65ac6fb4d');
INSERT INTO `role_menu` VALUES ('ee47215e9c504572af98f3e9cd19e4ee', 'e7579b7a56554ca2bac59e3cc2aa6d28', '180f15acb45c4b308f90e0fe1fd2af59');
INSERT INTO `role_menu` VALUES ('f2eac7a7054a4a7892c146adf17e20c9', 'ce51f896209341e3b73c43c41174d19e', '0c269659b12c453a9c68fdb85561c0fc');
INSERT INTO `role_menu` VALUES ('f3cd43771d6a4718865e1369bfe1c2f6', 'e7579b7a56554ca2bac59e3cc2aa6d28', 'a2d9d56dd028462fb517b0d0e68c21da');
INSERT INTO `role_menu` VALUES ('f67ed88f5d91450f82ff037b82fbbe03', 'e7579b7a56554ca2bac59e3cc2aa6d28', '860b8f73c73e429d966a7ffdccd413c0');

-- ----------------------------
-- Table structure for `role_user`
-- ----------------------------
DROP TABLE IF EXISTS `role_user`;
CREATE TABLE `role_user` (
  `id` varchar(100) NOT NULL,
  `roleId` varchar(100) default NULL,
  `userId` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_user
-- ----------------------------
INSERT INTO `role_user` VALUES ('0033b443f5f74786ad5cad1627a9f232', 'ce51f896209341e3b73c43c41174d19e', '043686149b2b45bdb48cca07a33b46c9');
INSERT INTO `role_user` VALUES ('00840492f1ec497198d26b01198c3a56', 'ce51f896209341e3b73c43c41174d19e', '21b5dca5c08247a9a31ee12cef6a8cb9');
INSERT INTO `role_user` VALUES ('01693f76c3b94d7ebebc793f3177ad61', 'ce51f896209341e3b73c43c41174d19e', '80e794bc9dc0440a8e2c517a63861f72');
INSERT INTO `role_user` VALUES ('01b4ed4a638443a1a48869f584d157f2', 'ce51f896209341e3b73c43c41174d19e', 'e5d635eaf61d430f89ed1dd99af733a7');
INSERT INTO `role_user` VALUES ('01cb5557420b4192b82fcb9b41d2e6e9', 'ce51f896209341e3b73c43c41174d19e', '2fde332658504dd59c80be9432071f11');
INSERT INTO `role_user` VALUES ('01e53beb1af7491181759cfe0d0bd9ac', 'ce51f896209341e3b73c43c41174d19e', '89d08a90bcb24cd0948d22af74185973');
INSERT INTO `role_user` VALUES ('0302ca11afff4819b0a2cce2d3afc899', 'ce51f896209341e3b73c43c41174d19e', '456b5e67e7834c3da4ccdca049db7303');
INSERT INTO `role_user` VALUES ('032770e505db4529b319112827ca4efa', 'ce51f896209341e3b73c43c41174d19e', 'a698991c4b4f4662826b46c89d4f4139');
INSERT INTO `role_user` VALUES ('035751b08c2440ac97661dfee6f7b3ab', 'ce51f896209341e3b73c43c41174d19e', '3da53ef8becb44c1b7c8bf29162883e9');
INSERT INTO `role_user` VALUES ('036b60d761f44e58ad8cbd9be4d6d3c6', 'ce51f896209341e3b73c43c41174d19e', '6d920693aa5e481e9e70a54da9f9d66c');
INSERT INTO `role_user` VALUES ('037056b92a7c4004a52bb918f218b0f0', 'ce51f896209341e3b73c43c41174d19e', '4bf7feee557c4095bdc2ffcc04b094f1');
INSERT INTO `role_user` VALUES ('0395321e17c84bb283213ed44cdbcaee', 'ce51f896209341e3b73c43c41174d19e', 'e22805d4dd404d0b9bbabbd66a48a037');
INSERT INTO `role_user` VALUES ('03a0d572ecb54c4da0c0bc66be95bcd5', 'ce51f896209341e3b73c43c41174d19e', 'b221e4b48c62480aa7620b2498f42ad1');
INSERT INTO `role_user` VALUES ('0476cc8d3a654d61bfbb6208d03c631f', 'ce51f896209341e3b73c43c41174d19e', 'd3a9f59d12024c5e834757921e3c4e06');
INSERT INTO `role_user` VALUES ('0559c725e62343ee9012a55f829ba3ed', 'ce51f896209341e3b73c43c41174d19e', 'd7dbc7d872eb42918f75d8112e0f4758');
INSERT INTO `role_user` VALUES ('0644b5e019154cd29ca0b56180b4005f', 'ce51f896209341e3b73c43c41174d19e', 'c9a767423e184a649190f055bb3455bb');
INSERT INTO `role_user` VALUES ('06e24fb73e7040599c719425016da3e6', 'ce51f896209341e3b73c43c41174d19e', '0cf130ccf3a047c4aa1246774c68e003');
INSERT INTO `role_user` VALUES ('06ee3c334d004fd59da2df3a7b0b1d72', 'ce51f896209341e3b73c43c41174d19e', '85f4753afa154f4cb4255014b4bdce4c');
INSERT INTO `role_user` VALUES ('06ff3adfa6b544ceb32d38007f5fd7c4', 'ce51f896209341e3b73c43c41174d19e', '058bd011e9f94bfcbba3dde670693588');
INSERT INTO `role_user` VALUES ('0706790e6f554db1bb508e50945c4f94', 'ce51f896209341e3b73c43c41174d19e', '66c62d6f827040b6b1648eb6051a24e8');
INSERT INTO `role_user` VALUES ('077edc5f18c040b2bbf42040b8891122', 'ce51f896209341e3b73c43c41174d19e', '28b579787a9644ca838d7025d8ed3a38');
INSERT INTO `role_user` VALUES ('07bb7b6f908e4c24bf7e5bcf43ce70fe', 'ce51f896209341e3b73c43c41174d19e', 'de49fc1fcae1402f8d371ccc62968626');
INSERT INTO `role_user` VALUES ('082e3f3f72aa4ea2bc451e6aa66ebea5', 'ce51f896209341e3b73c43c41174d19e', '5eaf4d0406294ea19395f9839cbb9d8f');
INSERT INTO `role_user` VALUES ('0867ed086ac94525985b647fec343767', 'ce51f896209341e3b73c43c41174d19e', '9ec5305ecf714064bb0c6e164af1aa1c');
INSERT INTO `role_user` VALUES ('091d6269aaca45fbb140778dae98c3f4', 'ce51f896209341e3b73c43c41174d19e', '9a785e448f514709bae97cb8101d983b');
INSERT INTO `role_user` VALUES ('0a97126202a647c5ba36f008aeec8741', 'ce51f896209341e3b73c43c41174d19e', 'e22c9bf0bf82435d90f2218c95913a1b');
INSERT INTO `role_user` VALUES ('0b31b6373dda43a09ae2536994d9da6b', 'ce51f896209341e3b73c43c41174d19e', 'b85ed299dbc34cd083a012f183305f00');
INSERT INTO `role_user` VALUES ('0c670ac361ea436e8778af54c17d3dbe', 'ce51f896209341e3b73c43c41174d19e', 'd929dbae2a954f6681cce273f28c2029');
INSERT INTO `role_user` VALUES ('0cfe24142d02434abe423978f8adf25e', 'ce51f896209341e3b73c43c41174d19e', '13dce7e644404bd197ce67eb494376bf');
INSERT INTO `role_user` VALUES ('0d5414e0238b43bfa20596a317979908', 'ce51f896209341e3b73c43c41174d19e', '1a47b4d52e3242729c55a1e396294d31');
INSERT INTO `role_user` VALUES ('0dac2ee812d74cffadd24621bcecf2c4', 'ce51f896209341e3b73c43c41174d19e', 'c1d181bb595345afa17a1b7d82edfdce');
INSERT INTO `role_user` VALUES ('0dc92d6572134ffb91de8c870aa9812c', 'ce51f896209341e3b73c43c41174d19e', 'c0638af9388f45e2bcac37aa96783bfd');
INSERT INTO `role_user` VALUES ('0e00cda825844e39a792f90ac95efc28', 'ce51f896209341e3b73c43c41174d19e', '823c22ff7901479e95d55228ebd2c3f6');
INSERT INTO `role_user` VALUES ('0e3f5c80c8174cf39a8f9b065c331b00', 'ce51f896209341e3b73c43c41174d19e', '9487d51bf5404672af5bb603b527a563');
INSERT INTO `role_user` VALUES ('0ed15c00d491419690713615be831e89', 'ce51f896209341e3b73c43c41174d19e', 'bd5bba5a926b4fcab4f291b2b9494be4');
INSERT INTO `role_user` VALUES ('100d201c781341189190fb506a62886b', 'ce51f896209341e3b73c43c41174d19e', 'eadc45bbe45f4104b2f2cc56db40cead');
INSERT INTO `role_user` VALUES ('106996e7ff5b4d29816e4fdcc341e260', 'ce51f896209341e3b73c43c41174d19e', 'f37ae90f771648f98b004d590aead17c');
INSERT INTO `role_user` VALUES ('11015a55686f48e08069e4873f7294c1', 'ce51f896209341e3b73c43c41174d19e', '72f337f45756428c985d2193c0255232');
INSERT INTO `role_user` VALUES ('118adac065184e3ba7276979a067cfdf', 'ce51f896209341e3b73c43c41174d19e', '0c3f089937a247fca6cd1be297114c80');
INSERT INTO `role_user` VALUES ('11a41e13683a40d2b5030a448fa1863f', 'ce51f896209341e3b73c43c41174d19e', 'cd31fcdaa8db486589035cf50322b959');
INSERT INTO `role_user` VALUES ('12e538949ae74ff3b39241d940e3d52b', 'ce51f896209341e3b73c43c41174d19e', '8d117c3b8eaa45aaa0a81c0821bce075');
INSERT INTO `role_user` VALUES ('12efc71b55e94cef8c3ce230b4aad8b8', 'ce51f896209341e3b73c43c41174d19e', '927adeb2b0e54c31b1e4cd991041e234');
INSERT INTO `role_user` VALUES ('1315c9e5ea994bfe81a2f169cc2b6d0f', 'ce51f896209341e3b73c43c41174d19e', '9183f85ec28c4456b42867a7d19efa62');
INSERT INTO `role_user` VALUES ('1411ed6f8a404db7ad023808ce3eb3b2', 'ce51f896209341e3b73c43c41174d19e', 'b6f96c4866074ad1bbf851b6f1c15fa6');
INSERT INTO `role_user` VALUES ('148fb7934eaf4b93800e933e9baf4c0f', 'ce51f896209341e3b73c43c41174d19e', '759ade9bb0b5491a92f552faf235da93');
INSERT INTO `role_user` VALUES ('153dbdb9bd7b4be5a4eb9616b779b754', 'ce51f896209341e3b73c43c41174d19e', 'b0459d6af76546ebb9630713400432fb');
INSERT INTO `role_user` VALUES ('16384a5d297d45379b796f6484578efd', 'ce51f896209341e3b73c43c41174d19e', '235b7df8b369472196b542d6fcd244ba');
INSERT INTO `role_user` VALUES ('16c7afe02a104fa99b1e30158c3d767c', 'ce51f896209341e3b73c43c41174d19e', 'a415fec225104189909ed20f128d78d8');
INSERT INTO `role_user` VALUES ('174eb45a49e74ab0ba035034934a2699', 'ce51f896209341e3b73c43c41174d19e', '4b1e47c16aca4e919109d0a6a2fd4d9b');
INSERT INTO `role_user` VALUES ('1772b43a52884672a72a6c6a347897e3', 'ce51f896209341e3b73c43c41174d19e', 'b342f8df24574919b612f7e2907b2f4b');
INSERT INTO `role_user` VALUES ('17a317679f2e4bb9b1b8bc6ef99e1319', 'ce51f896209341e3b73c43c41174d19e', '70c393d5d2454010a7381f8cc0b9599e');
INSERT INTO `role_user` VALUES ('17b5308d210c4a5191973b824a078fd6', 'ce51f896209341e3b73c43c41174d19e', '4f3adc4ebbe94e8d8af381d37d1f610e');
INSERT INTO `role_user` VALUES ('17be9c17007f4aba8664f2b2d73dbaf3', 'ce51f896209341e3b73c43c41174d19e', '154492e773a84d0884f0ded2c9bb31a3');
INSERT INTO `role_user` VALUES ('18181f780bf44d0c98bbe60c0b526662', 'ce51f896209341e3b73c43c41174d19e', 'f56d1627d684406f9b39c7e96e706ce2');
INSERT INTO `role_user` VALUES ('18190bb9e9a448c1ad634602178b866c', 'ce51f896209341e3b73c43c41174d19e', '2f2f74ff3b3645a09e3062dd4b4f9b79');
INSERT INTO `role_user` VALUES ('184888da03704e96b2698bc1e897eab4', 'ce51f896209341e3b73c43c41174d19e', '09c612bcff0d4b6e9b9785378df1d613');
INSERT INTO `role_user` VALUES ('1881d72d40a7436e8c18580d4b92dd4c', 'ce51f896209341e3b73c43c41174d19e', '3a461d8904e2429f833b5db643939dc1');
INSERT INTO `role_user` VALUES ('194043361a5b4a52948431383ae8bd9e', 'ce51f896209341e3b73c43c41174d19e', '77f1a70c4a1343f98499dfa64d199226');
INSERT INTO `role_user` VALUES ('19b34079d8584a4684506549c6418027', 'ce51f896209341e3b73c43c41174d19e', '35f68b9871624bd990e552bdc99231df');
INSERT INTO `role_user` VALUES ('1b316bb7d1a9438fb93f42ae30d965ae', 'ce51f896209341e3b73c43c41174d19e', '63b8931defa743668388599ea35341fd');
INSERT INTO `role_user` VALUES ('1b329003426447f190af77055fe827c9', 'ce51f896209341e3b73c43c41174d19e', 'ea30ad9630b7465cbe15fd17288b35cc');
INSERT INTO `role_user` VALUES ('1b5fcaef1bda4599b78cf3a48801879d', 'ce51f896209341e3b73c43c41174d19e', '88294196507c4711be6c1aeedd1acf4f');
INSERT INTO `role_user` VALUES ('1bcef86bedf84a00b853871e8abdebd3', 'ce51f896209341e3b73c43c41174d19e', 'e17e5e4f02fe4b6c9db516b2e16c4df5');
INSERT INTO `role_user` VALUES ('1bf80d6b680846b3ba10a172b26575da', 'ce51f896209341e3b73c43c41174d19e', '65ddca56b12b454b9bdf4dfad0ab1b91');
INSERT INTO `role_user` VALUES ('1ca50c1e9cdc4fc2b642944f3af676da', 'ce51f896209341e3b73c43c41174d19e', '438f805356cf4253b192b72306c45c7a');
INSERT INTO `role_user` VALUES ('1cc326d37f2547efa2ff8e206a5a09e5', 'ce51f896209341e3b73c43c41174d19e', 'fac8a4e2f09340618a0cb518dbc989a3');
INSERT INTO `role_user` VALUES ('1d7da571395343a0901f00ae6f6c6082', 'ce51f896209341e3b73c43c41174d19e', '61e3413879284c87a2ab499a078a44fd');
INSERT INTO `role_user` VALUES ('1e13c4eda4eb4efa9ddb5f64fc40a71b', 'ce51f896209341e3b73c43c41174d19e', '471cf970af4b4b3eabca2ced60c4dcf5');
INSERT INTO `role_user` VALUES ('1e43199311a448df9e0f4d85d3623aa7', 'ce51f896209341e3b73c43c41174d19e', '91677998b0b24f1c8e6f30387bc6ad26');
INSERT INTO `role_user` VALUES ('1ea63b23ba4143f486d15c827e7af82c', 'ce51f896209341e3b73c43c41174d19e', 'e29a4ff3b5f44ffa987b3ab7cb515e38');
INSERT INTO `role_user` VALUES ('1f937775f3604084b7dcb6c5d4eaa8a1', 'ce51f896209341e3b73c43c41174d19e', '12dd64f4cbb841c9a71d69cbb555097f');
INSERT INTO `role_user` VALUES ('1fdce1e924024a1d843993af5b60fe0f', 'ce51f896209341e3b73c43c41174d19e', '3562950982a04b9fa9edbab2ecf02996');
INSERT INTO `role_user` VALUES ('2051190dc2a74a4985f7b3b4f7342b31', 'ce51f896209341e3b73c43c41174d19e', 'f5ecbc2283d34e7588bb831a276f5db9');
INSERT INTO `role_user` VALUES ('20ef97c9e07e458bb18be55b76f23bac', 'ce51f896209341e3b73c43c41174d19e', '9187fab2df54438185dd3c388eb76910');
INSERT INTO `role_user` VALUES ('210ce932e8ec489b98d84545dc11cbde', 'ce51f896209341e3b73c43c41174d19e', '58fc814b001c416d8d16b4c16e430d7d');
INSERT INTO `role_user` VALUES ('2135a650bb3e45b3989c9403b7e2daa7', 'ce51f896209341e3b73c43c41174d19e', '9c0b956981934393be0a338a87d4c0be');
INSERT INTO `role_user` VALUES ('21d3a6fbf0ae4b04b6cd735de2596e9e', 'ce51f896209341e3b73c43c41174d19e', '82ab96a71a8843bdb4ab44edce9bd46c');
INSERT INTO `role_user` VALUES ('2216a2a0df574933a8bd8d6723b72bfd', 'ce51f896209341e3b73c43c41174d19e', '86bf9b1796e74268bab6d964d816b4e0');
INSERT INTO `role_user` VALUES ('22350a79cdba4f8cace6721b07a31b6b', 'ce51f896209341e3b73c43c41174d19e', '82e422ee4caa4dd6a3e08528de2ea1c5');
INSERT INTO `role_user` VALUES ('23a1cd98e1ef43e0972d807ef4f303ef', 'ce51f896209341e3b73c43c41174d19e', '03989c9314714fcd8be50208b3f6a715');
INSERT INTO `role_user` VALUES ('24712bab70414c9b90f926863aa63726', 'ce51f896209341e3b73c43c41174d19e', 'ec0da29557a04f948063716e7fa46814');
INSERT INTO `role_user` VALUES ('24a41fb4e903459aba032a8cb48b42eb', 'ce51f896209341e3b73c43c41174d19e', '152ae310c4f64532a28a1885f2751c07');
INSERT INTO `role_user` VALUES ('2500c91e7e7a47dd9f243dd6035ad834', 'ce51f896209341e3b73c43c41174d19e', 'b8c866aa53514839bbdb005f1a50676c');
INSERT INTO `role_user` VALUES ('268a5613d28e41609a0e011a3f457ced', 'ce51f896209341e3b73c43c41174d19e', '780a0b8cb51b442aae51ad0f49629d4f');
INSERT INTO `role_user` VALUES ('270aba03da0c430181897d42f9f4c5b5', 'ce51f896209341e3b73c43c41174d19e', '40335c6c8e0c4d6e995c3922155cb1e0');
INSERT INTO `role_user` VALUES ('275a1b8c1d25449f88a8bc5cec9ac127', 'ce51f896209341e3b73c43c41174d19e', '994de0ff62b84bfbb50fbe538bea0c49');
INSERT INTO `role_user` VALUES ('27738617f66d4d899b0f0bf1b8da624b', 'ce51f896209341e3b73c43c41174d19e', '30a08584558f42fca926b3f589b67e87');
INSERT INTO `role_user` VALUES ('2778efa7a810477b8ad9c1e10bda5939', 'ce51f896209341e3b73c43c41174d19e', '150f8c9d18654162ba62d0185b9126a0');
INSERT INTO `role_user` VALUES ('27839df128254438a5572bf360cafbbc', 'ce51f896209341e3b73c43c41174d19e', '7e17d67d47394eb08b68f236da5fb804');
INSERT INTO `role_user` VALUES ('28732c51ac3945d0bb95db6ffc3d2ee9', 'ce51f896209341e3b73c43c41174d19e', 'a2fc79ac8ab54b61b2ff467ceedcbe6f');
INSERT INTO `role_user` VALUES ('288b248af3824d289fb8fc3398be84c6', 'ce51f896209341e3b73c43c41174d19e', 'cec5b22031d34101902498deba3347c7');
INSERT INTO `role_user` VALUES ('28998c4a09b544fbbbed65bfac2d6331', 'ce51f896209341e3b73c43c41174d19e', 'f645d3e12b364d0381249a9d6d088181');
INSERT INTO `role_user` VALUES ('28d7dbf4aebd49babb2749bb014bdfc4', 'ce51f896209341e3b73c43c41174d19e', '16e7f4d81dc24644b522d4c5a541fc9d');
INSERT INTO `role_user` VALUES ('2918aeb60b324620858415be8e7ec0f5', 'ce51f896209341e3b73c43c41174d19e', '3c8a03b838954ce5a05b3b109a4918f1');
INSERT INTO `role_user` VALUES ('2a2d8864e4f64752a68a361f4abf28ad', 'ce51f896209341e3b73c43c41174d19e', '1fdbef2120124d04a92854690f589a19');
INSERT INTO `role_user` VALUES ('2ae427fc6be64ecaab152737494016ec', 'ce51f896209341e3b73c43c41174d19e', 'fb062d51a7b8433eb48cf9e34ebb5812');
INSERT INTO `role_user` VALUES ('2b940479c6d64df1be7b248095f1c487', 'ce51f896209341e3b73c43c41174d19e', 'ea3dfd7476394d858077ee3cf693099e');
INSERT INTO `role_user` VALUES ('2c4fc371f06a4cf19b01c7a56a7047b7', 'ce51f896209341e3b73c43c41174d19e', '2e1d1a6c160f479a9cf1522e31840835');
INSERT INTO `role_user` VALUES ('2cd65568c36f44d99d7b195595f2219c', 'ce51f896209341e3b73c43c41174d19e', '9c26fbfc34064b518e64cda9c2b0614f');
INSERT INTO `role_user` VALUES ('2d0dfadd3dad47e4aee97b6926afb928', 'ce51f896209341e3b73c43c41174d19e', '105c8a68fd754e5e8f55c777c4aae192');
INSERT INTO `role_user` VALUES ('2d3df5caf2de4d11abce71572619cdd0', 'ce51f896209341e3b73c43c41174d19e', 'f4697e3246c54e4dbbae628f7dfb03a8');
INSERT INTO `role_user` VALUES ('2d431c15405b41d1ae62236e3ae2c293', 'ce51f896209341e3b73c43c41174d19e', '93af510e01e04d83b6a1b86cae2d3a78');
INSERT INTO `role_user` VALUES ('2d96d6523b7d40799244467fcbc58c19', 'ce51f896209341e3b73c43c41174d19e', 'b7b232fd1f1e4106bb4d99d7e795f002');
INSERT INTO `role_user` VALUES ('2d9b228c21a8427fb01f260ef7f7adb7', 'ce51f896209341e3b73c43c41174d19e', '67b39f3ca0764133add6f56abd1c1cae');
INSERT INTO `role_user` VALUES ('2dec79bb1a05491b879d6d3c1d107493', 'ce51f896209341e3b73c43c41174d19e', 'b2ae4531a1484461bedf823c61bf74bd');
INSERT INTO `role_user` VALUES ('2e8040c6c79d4e99ab7214a3f1b9fc19', 'ce51f896209341e3b73c43c41174d19e', 'dbfdc7d8502149fea09354581f2160d4');
INSERT INTO `role_user` VALUES ('2f77babccf774498bcf283d1579b0246', 'ce51f896209341e3b73c43c41174d19e', '198b684372e84319a73cd6fce10a8559');
INSERT INTO `role_user` VALUES ('2fb92f97c5d14016a0e91a0dcdb3541b', 'ce51f896209341e3b73c43c41174d19e', '42f69c7555fd470fac0681d26762c28d');
INSERT INTO `role_user` VALUES ('30769e66e7fb4b1183a6c7b89564a6b1', 'ce51f896209341e3b73c43c41174d19e', '9c59c5ea313944a5aff32bcd1460846f');
INSERT INTO `role_user` VALUES ('31343fc70937420baccedb1978529d4d', 'ce51f896209341e3b73c43c41174d19e', '31d0704f45284a96ad0edf4302f38038');
INSERT INTO `role_user` VALUES ('31c4da1aa2d242d0b4f197c8dc2c7557', 'ce51f896209341e3b73c43c41174d19e', 'c4dca0d57bbf4290842c202d93270944');
INSERT INTO `role_user` VALUES ('32d9b59f079c43c1aa507b1b9208da93', 'ce51f896209341e3b73c43c41174d19e', '1b3a84fb5e3f4a09bc686a7282ba41bd');
INSERT INTO `role_user` VALUES ('32f93d14cf8e4b4484bc1ff550acaae6', 'ce51f896209341e3b73c43c41174d19e', '7a1465c8b4bf4932b8b8a58ae9446d13');
INSERT INTO `role_user` VALUES ('340d579ba7dd47b6999fea30a7334a6e', 'ce51f896209341e3b73c43c41174d19e', '3b5696847388435ab73b6fe51b2b3c05');
INSERT INTO `role_user` VALUES ('3502592d32b0495495530ddcf2dd6bb7', 'ce51f896209341e3b73c43c41174d19e', 'a45e6958da5347d4bf4e5c01ea809ce6');
INSERT INTO `role_user` VALUES ('35455f6f33364461aa7424cfb75082c4', 'ce51f896209341e3b73c43c41174d19e', '2f8532a61fbc42f39d5a0549ee6e13ad');
INSERT INTO `role_user` VALUES ('3551edfcbe74403a87514474a3c5dc76', 'ce51f896209341e3b73c43c41174d19e', '44af998d4f1c49bc9f9c799fc84a6c00');
INSERT INTO `role_user` VALUES ('356b803a2efa47888eaa93bd4ea1127f', 'ce51f896209341e3b73c43c41174d19e', '5d9efb709fb94f539c3b27292e508291');
INSERT INTO `role_user` VALUES ('35dc0cca79d44c319404d0345efc16fc', 'ce51f896209341e3b73c43c41174d19e', '56d68e8041e64957a799d908da8f47c0');
INSERT INTO `role_user` VALUES ('37918139bc9a42a395acf65360c559b1', 'ce51f896209341e3b73c43c41174d19e', '4abcd8244c7246b1ab28b71038adc9a1');
INSERT INTO `role_user` VALUES ('3798cda9edae4e908dd294da3f926868', 'ce51f896209341e3b73c43c41174d19e', '6c6e12e7aa1d43e49345718b20201aeb');
INSERT INTO `role_user` VALUES ('382da9f477bd4ecd806fa99fecb3e1ca', 'ce51f896209341e3b73c43c41174d19e', '31ce12dc138f403a9bd4696c1b4b5fbc');
INSERT INTO `role_user` VALUES ('38622f3db63d413ebdd2167f265fa44b', 'ce51f896209341e3b73c43c41174d19e', 'c4448ba0954c41baaf58c28e1ce7b88f');
INSERT INTO `role_user` VALUES ('388f3435683a4514b710c7b82f26ae3d', 'ce51f896209341e3b73c43c41174d19e', 'a621ae30c4e44873b5571eb6bdaf8ce7');
INSERT INTO `role_user` VALUES ('38a682f3a028402497faf0247142792c', 'ce51f896209341e3b73c43c41174d19e', '4441a713c5e24f1f8e59d23028ddb12f');
INSERT INTO `role_user` VALUES ('38dbd7bd557d4eeabee578d253083947', 'ce51f896209341e3b73c43c41174d19e', '2f6c9d8aa10d4a818098d8986dbd4de6');
INSERT INTO `role_user` VALUES ('3980f04a845f461d9230c90b860cd97e', 'ce51f896209341e3b73c43c41174d19e', 'f1e5ad79bcf74b3fa48c1e577840df5f');
INSERT INTO `role_user` VALUES ('39b6c2fb714646bbaf2fa94725708c85', 'ce51f896209341e3b73c43c41174d19e', '21ceaa5b311e4ef1adf574136ab080b6');
INSERT INTO `role_user` VALUES ('39c82eb4e8b248e1b7355f9e7dc00dc2', 'ce51f896209341e3b73c43c41174d19e', '5b8c1f5bcd5445c49715748aac5c7242');
INSERT INTO `role_user` VALUES ('39e23b9599be48e995a51164ab3f072f', 'ce51f896209341e3b73c43c41174d19e', '37b9b988dded46268104bedf996d145c');
INSERT INTO `role_user` VALUES ('3af6afdf0e414145a1288f4eb1c09342', 'ce51f896209341e3b73c43c41174d19e', '5b0c7e5b75244de9ac1c1b61cb697b40');
INSERT INTO `role_user` VALUES ('3b0bd24bf83e48ba89089926f6e65891', 'ce51f896209341e3b73c43c41174d19e', '76c397d5695d425396e2280b9133a7f4');
INSERT INTO `role_user` VALUES ('3b67b4b360e64126a593d5bf06e0d0d9', 'ce51f896209341e3b73c43c41174d19e', '491c72a0899e44cf865e02355671f148');
INSERT INTO `role_user` VALUES ('3b75a0a026344622b1fe11d207276d61', 'ce51f896209341e3b73c43c41174d19e', '2c49611b9e9b4e8d8bf8b27d4b21f352');
INSERT INTO `role_user` VALUES ('3be08228079b466bbc1b85dc99ea6688', 'ce51f896209341e3b73c43c41174d19e', '0784003b3d1b47faadf839038c4e2c6e');
INSERT INTO `role_user` VALUES ('3bf8520962aa4bbdb302ac35532863f4', 'ce51f896209341e3b73c43c41174d19e', '67726193cca64a9bb8b3d6fbc7630026');
INSERT INTO `role_user` VALUES ('3c37816b336548edab22ae7a7f86d7b1', 'ce51f896209341e3b73c43c41174d19e', '8b4541ee6b1a40878228241bcdfc1b36');
INSERT INTO `role_user` VALUES ('3c3ee3566c52455aa2dddda733de35a6', 'ce51f896209341e3b73c43c41174d19e', '9cbe1536e9284062a3ae0d2435f386e4');
INSERT INTO `role_user` VALUES ('3cded892cc89433bbf794605beaece5a', 'ce51f896209341e3b73c43c41174d19e', '76d657d66818419687ed61ccf5d5e5b1');
INSERT INTO `role_user` VALUES ('3d0d1dfb78bb49afb06b187743fa0ff6', 'ce51f896209341e3b73c43c41174d19e', '2fd44a17b346479097e53a6b23fc9fd7');
INSERT INTO `role_user` VALUES ('3e16085313c04b6890469dc019c25005', 'ce51f896209341e3b73c43c41174d19e', '00d78b24b9554ab5a9fc3cbf2c34c122');
INSERT INTO `role_user` VALUES ('3eb0a58792484d94a1aef7804c0fd9a0', 'ce51f896209341e3b73c43c41174d19e', '38bf82a6cf114671a2ae28b8145025a8');
INSERT INTO `role_user` VALUES ('3ecf733e7a4f411fbfa910e075092f5e', 'ce51f896209341e3b73c43c41174d19e', 'fe3f6fdb3d9641e49024dd3034c11d5c');
INSERT INTO `role_user` VALUES ('3f3998b1fed948999ea6704c0a6fc263', 'ce51f896209341e3b73c43c41174d19e', '32c69bdcfc6547c98d43b4840a0f510e');
INSERT INTO `role_user` VALUES ('3fac870057cb492c97268cfebfc3f4d4', 'ce51f896209341e3b73c43c41174d19e', 'ccd92ad628b5434a9bc47ac84397804a');
INSERT INTO `role_user` VALUES ('3fea962a5728473ba5070598c29d95d6', 'ce51f896209341e3b73c43c41174d19e', 'e6e69ad33dae47dfa5d1206bcfcd1604');
INSERT INTO `role_user` VALUES ('4031de38e99c44fa90e997feb1ab738a', 'ce51f896209341e3b73c43c41174d19e', '32b40b6937d74e9fa9de14a20a036789');
INSERT INTO `role_user` VALUES ('411607df00e744d5b90987b5eb8427f7', 'ce51f896209341e3b73c43c41174d19e', 'c3e8c52e214842968a441de2cbd52f61');
INSERT INTO `role_user` VALUES ('4128ec0163a44aa393be7b974715dacc', 'ce51f896209341e3b73c43c41174d19e', '81ed14eddd88493db797473034842a4a');
INSERT INTO `role_user` VALUES ('41356610d19f4f4dbabc818c3fa37857', 'ce51f896209341e3b73c43c41174d19e', 'd1f5fa6119b4430fbd993d0a3e0861bb');
INSERT INTO `role_user` VALUES ('4224cb542da04b08b092a5395ce2fbe9', 'ce51f896209341e3b73c43c41174d19e', 'f20970f736b54369b129485d40fd0bc0');
INSERT INTO `role_user` VALUES ('42718f0d17f14d449a829bfa35a92bb3', 'ce51f896209341e3b73c43c41174d19e', '366d48558739470abfa0526f7a0c76dd');
INSERT INTO `role_user` VALUES ('4276b755749d47a19e9cf6c0d61a15cc', 'ce51f896209341e3b73c43c41174d19e', 'a09e5649b9ff461bafeb6398466f48fe');
INSERT INTO `role_user` VALUES ('42cbcc0dfe6a48c5bd2dbdc6cafcf061', 'ce51f896209341e3b73c43c41174d19e', '211da4c2e6c1493687e5f4812c34f2fd');
INSERT INTO `role_user` VALUES ('43100c9431304403971263ee253310ec', 'ce51f896209341e3b73c43c41174d19e', '6c33bc7714fd4494af16f9497f750a37');
INSERT INTO `role_user` VALUES ('436e2842a8374b1099de175c382c9bb0', 'ce51f896209341e3b73c43c41174d19e', 'ccbce7eaf5a84fa6ad2470bcd1355545');
INSERT INTO `role_user` VALUES ('44ef0dd892c54b10bed8779ec2162f2f', 'ce51f896209341e3b73c43c41174d19e', '8f79754111254ae8bec31138a5f1f03b');
INSERT INTO `role_user` VALUES ('44f6d9cd46244dc09e7e4fb7c5e1cade', 'ce51f896209341e3b73c43c41174d19e', '466f55ecfbc8433c80bc5fb29c6b1006');
INSERT INTO `role_user` VALUES ('45b1f0937be04acb96163551f8009174', 'ce51f896209341e3b73c43c41174d19e', '55f47668beb54d3fb9cc507d508a0d87');
INSERT INTO `role_user` VALUES ('464833fa12f84c249fe0e386e55a1b6a', 'ce51f896209341e3b73c43c41174d19e', '8d6ee1b0c16d4375939d06dbbcf2f065');
INSERT INTO `role_user` VALUES ('46597ce972e945fb9041bbcbf07619d3', 'ce51f896209341e3b73c43c41174d19e', '8840b9066a594db4afef7805330d66a6');
INSERT INTO `role_user` VALUES ('46ffe66ffe38419fa62e2db734ec0407', 'ce51f896209341e3b73c43c41174d19e', 'cdcdb277406e4ebeb2e48acfe3ede94d');
INSERT INTO `role_user` VALUES ('47477d525af443fa838e1f9273e08155', 'ce51f896209341e3b73c43c41174d19e', 'f33fe4d0cad04de4be3ef3e8d4b4cf86');
INSERT INTO `role_user` VALUES ('4750b083b20248869714172b580a4953', 'ce51f896209341e3b73c43c41174d19e', 'dc4fc94626914654b4a641dd731385c9');
INSERT INTO `role_user` VALUES ('4770738a67d946b4815a77b4ffcdced1', 'ce51f896209341e3b73c43c41174d19e', '5026245a68664301b15847ca217dafdd');
INSERT INTO `role_user` VALUES ('478279751c9f474a831b542696e91a33', 'ce51f896209341e3b73c43c41174d19e', 'c5d35bf33ea847dd855696677e7ad921');
INSERT INTO `role_user` VALUES ('4791eaee72504f44a4b84a4606fdf964', 'ce51f896209341e3b73c43c41174d19e', '8115532c5bff459292d7d970b4af750f');
INSERT INTO `role_user` VALUES ('47a6bb0681f340cf966325534ad6892a', 'ce51f896209341e3b73c43c41174d19e', '32a55c96331649ababcb04d7f61b66a3');
INSERT INTO `role_user` VALUES ('47b9674d4c314a48bf72844951521e4e', 'ce51f896209341e3b73c43c41174d19e', '579b2d25047d40688ee6db45ff79f7a9');
INSERT INTO `role_user` VALUES ('47c0933a955f4180be22629372b0dcb5', 'ce51f896209341e3b73c43c41174d19e', '6261b5b5270147f58ff8e9e2c36c7b10');
INSERT INTO `role_user` VALUES ('49293246a8b04dfaa8e2f0443110e09b', 'ce51f896209341e3b73c43c41174d19e', 'c4749e3b26b24aaf846cdbd076f6e9e9');
INSERT INTO `role_user` VALUES ('4943caf6299d4dc3a5bb6b78dcc15223', 'ce51f896209341e3b73c43c41174d19e', 'a491267d19a147b2ae65fa42c457e0e5');
INSERT INTO `role_user` VALUES ('49c0ffe55e064a49ad72c0b76bdfac04', 'ce51f896209341e3b73c43c41174d19e', 'eb7fad8381e943afbd6bc273e06b4ae6');
INSERT INTO `role_user` VALUES ('4a66815893204846a24678c65a810402', 'ce51f896209341e3b73c43c41174d19e', 'af966a187ae143edab9696e17ddea040');
INSERT INTO `role_user` VALUES ('4adee9dd2c4044b182dcb4af64049ae4', 'ce51f896209341e3b73c43c41174d19e', 'ce75ee1ed93941eb8d23a48efe585c99');
INSERT INTO `role_user` VALUES ('4b1b78a3ffa24186aa0ae7badd4ae132', 'ce51f896209341e3b73c43c41174d19e', '939960253ee7410386d1afe8fe031368');
INSERT INTO `role_user` VALUES ('4b90964e2590436fa51fde2f7fa24c8f', 'ce51f896209341e3b73c43c41174d19e', '64c985b094f145eca30c0a7a2e92380a');
INSERT INTO `role_user` VALUES ('4b90d04e64114d9eaf1859ed5bd2d52e', 'ce51f896209341e3b73c43c41174d19e', '5bc23557979b4cafbcca1896cf775171');
INSERT INTO `role_user` VALUES ('4b95487524244d50800111e2fbb7557a', 'ce51f896209341e3b73c43c41174d19e', 'c949ed23514a42a5916dc13aeac4f33d');
INSERT INTO `role_user` VALUES ('4b9932f79f464d31871ae40a0aceeeaf', 'ce51f896209341e3b73c43c41174d19e', '70a2bccb98a74437b3440968e3578093');
INSERT INTO `role_user` VALUES ('4c29fa5166bb4b19a0a7c93580cbcfc4', 'ce51f896209341e3b73c43c41174d19e', '496178156fec4f2aa2df070bb633fb02');
INSERT INTO `role_user` VALUES ('4c59f2bfac07410d973c597868f93379', 'ce51f896209341e3b73c43c41174d19e', '5bc9598873354d96a1b285524bab356d');
INSERT INTO `role_user` VALUES ('4ec39dfc542340e7a9c0a3e54ed5ac7c', 'ce51f896209341e3b73c43c41174d19e', 'f20df1c25b644c00ba96290cbdc2ebe7');
INSERT INTO `role_user` VALUES ('4ef897ff31ef4685b535966e9d57561f', 'ce51f896209341e3b73c43c41174d19e', '6d38ab1713b14b5e8fa16eac48028b47');
INSERT INTO `role_user` VALUES ('4fd1acc816ec4f938ec4dc33f7725cf3', 'ce51f896209341e3b73c43c41174d19e', '333097d947a245c1bb2da35f54a7bea5');
INSERT INTO `role_user` VALUES ('4ff5db2663e144a6821d5c502efd566f', 'ce51f896209341e3b73c43c41174d19e', 'd584b691569f41f48be529426c49e8be');
INSERT INTO `role_user` VALUES ('500ab772f20e470f8b72b1d91b8125db', 'ce51f896209341e3b73c43c41174d19e', 'f716fbe406964b85a23f40b8f9c3b05b');
INSERT INTO `role_user` VALUES ('50541993019a456b86f59ec7d1395fa6', 'ce51f896209341e3b73c43c41174d19e', 'aa9af4fc7a194d38ad570d759ae307fb');
INSERT INTO `role_user` VALUES ('517bd65256144d059388828772366ba9', 'ce51f896209341e3b73c43c41174d19e', '565ac11128ce4a08a379950b60fa0ff4');
INSERT INTO `role_user` VALUES ('51eed99ef1094dd39cfc918144e2f700', 'ce51f896209341e3b73c43c41174d19e', '757e4a3ffe434132a45495e5ac906e5c');
INSERT INTO `role_user` VALUES ('52562a5597fd4b0f896eb9e91145069b', 'ce51f896209341e3b73c43c41174d19e', '1bcc93225f694c97b61eba9f5d0c39cf');
INSERT INTO `role_user` VALUES ('534e0a90c3ed4e84b1eb03240568f882', 'ce51f896209341e3b73c43c41174d19e', '85c8593ad0e14316b87ff3964a0bd15e');
INSERT INTO `role_user` VALUES ('536f91061fa14d42850fc89073bb3036', 'ce51f896209341e3b73c43c41174d19e', 'dffb9dc64c38430f9880d88da7ffc57d');
INSERT INTO `role_user` VALUES ('54b88805423f41d8898bc55b40288afc', 'ce51f896209341e3b73c43c41174d19e', 'ff2bf552cb374b4c9c78857d4ec1ae83');
INSERT INTO `role_user` VALUES ('550b35f792784d93a76a11e637c42e8b', 'ce51f896209341e3b73c43c41174d19e', '3a3ee5663cbe4a44b9f9ab26d139e7c6');
INSERT INTO `role_user` VALUES ('55714d8822184a82b0b33ef53f6bc214', 'ce51f896209341e3b73c43c41174d19e', '8f0a90b93e0e428c83d5d10ca5451f2d');
INSERT INTO `role_user` VALUES ('5597bd363ed64861a7b8d8845d6c3dd1', 'ce51f896209341e3b73c43c41174d19e', 'bf4d250a158340d884b047235b372469');
INSERT INTO `role_user` VALUES ('565ab48de44240a29e69839ad5869e7d', 'ce51f896209341e3b73c43c41174d19e', '15a1118814a34714ae3fb44f44ce445c');
INSERT INTO `role_user` VALUES ('56e2dbb974db40c88d7619f49315fbf1', 'ce51f896209341e3b73c43c41174d19e', 'a999426824724ba2935debed231eefde');
INSERT INTO `role_user` VALUES ('57479801ae644cb1a9f5d8880ad50d92', 'ce51f896209341e3b73c43c41174d19e', '2c87c264125744e58c7b080d7d20c3f9');
INSERT INTO `role_user` VALUES ('5763dc3b38a2498ab1d56b48f513f74a', 'ce51f896209341e3b73c43c41174d19e', '5aa67b57c7234a3c8101d28824b14525');
INSERT INTO `role_user` VALUES ('585a922b94cc474f96a2ee3e201182b9', 'ce51f896209341e3b73c43c41174d19e', '631d4e8077fb4665b42fcadeb4e434e0');
INSERT INTO `role_user` VALUES ('587737fdffe247d794ae1be02a98bbbf', 'ce51f896209341e3b73c43c41174d19e', '6c41871c5b9f4b36a3cc211789ef8f2b');
INSERT INTO `role_user` VALUES ('59060244e2ae482ab204826eb7c48cbd', 'ce51f896209341e3b73c43c41174d19e', 'b89453b37e5b40908517fdd771424fe0');
INSERT INTO `role_user` VALUES ('59adba22a7e84900826586a181c0fe90', 'ce51f896209341e3b73c43c41174d19e', '02ae5c19d7ba48779baa9d217604425b');
INSERT INTO `role_user` VALUES ('5a54f5b622d7463fbeabadc634bddafb', 'ce51f896209341e3b73c43c41174d19e', '6932ae96f16c4e4691b1d779e4a3635e');
INSERT INTO `role_user` VALUES ('5ac21bb7bdb14cb385de3fb809db0194', 'ce51f896209341e3b73c43c41174d19e', '91f7e31d68444d9f8a52dcec65368b96');
INSERT INTO `role_user` VALUES ('5ac22c67a82c418f97ceafd45aa136c1', 'ce51f896209341e3b73c43c41174d19e', '62c2636f39fe4cc8be3e2c9c5e8bbc2d');
INSERT INTO `role_user` VALUES ('5acd5851f38944ad8fa9b16a970aff79', 'ce51f896209341e3b73c43c41174d19e', '4ed35730f7bb48179a596a9c253fb957');
INSERT INTO `role_user` VALUES ('5addaf6475714d259a3066083a0434dc', 'ce51f896209341e3b73c43c41174d19e', '437a05239f8240c0af226898ddc78143');
INSERT INTO `role_user` VALUES ('5b84ba3c92dc4105a144cd1dab71ca6e', 'ce51f896209341e3b73c43c41174d19e', 'b5d8cbf362114a3e89fce14351d820df');
INSERT INTO `role_user` VALUES ('5ddbf8a33d434f16a9f6b7327367d4c3', 'ce51f896209341e3b73c43c41174d19e', 'bf19448a98e74ce28f96b5b1781ab3b1');
INSERT INTO `role_user` VALUES ('5e957696f887468e88616f9a6285b439', 'ce51f896209341e3b73c43c41174d19e', '8366897e445e41eaa4c6fe4c018243ab');
INSERT INTO `role_user` VALUES ('5ed0390610b94a62a059002ce4683c6f', 'ce51f896209341e3b73c43c41174d19e', '44a8835ff6c644efbd5b579d83d818a8');
INSERT INTO `role_user` VALUES ('60177d76a5de4c4cb6c5767fffb953e8', 'ce51f896209341e3b73c43c41174d19e', 'd7e3b1f9e4e949708c6522affe810f5c');
INSERT INTO `role_user` VALUES ('6047c0b3908d4b8fb5bedfc4e8a8a77a', 'ce51f896209341e3b73c43c41174d19e', 'ce62194ca1324b69b60b7a620a54c3d9');
INSERT INTO `role_user` VALUES ('60d78aefac2c4be0be534a76ba89d546', 'ce51f896209341e3b73c43c41174d19e', '931e15e1e3874de095fb5b5b1fb00250');
INSERT INTO `role_user` VALUES ('610d324eed244fcfa29954b992aaa4d9', 'ce51f896209341e3b73c43c41174d19e', '303b5b11350246f6b0a4dca68a08f60f');
INSERT INTO `role_user` VALUES ('617be21e4f644ac3ba49bec3225b1f76', 'ce51f896209341e3b73c43c41174d19e', 'cdb9424e53d44dd2bdc655f8c1172e31');
INSERT INTO `role_user` VALUES ('62b6f0bfcd5e4691ad262f5aa5025618', 'ce51f896209341e3b73c43c41174d19e', 'b389330abdb8488b9dbe7e7cab9341c2');
INSERT INTO `role_user` VALUES ('630f1593d9bc4fceb6694129adaf59a9', 'ce51f896209341e3b73c43c41174d19e', '2643dd1d0a2544b7a6102cdeaa64677c');
INSERT INTO `role_user` VALUES ('639e34bb93194945aa74787090b5f8bf', 'ce51f896209341e3b73c43c41174d19e', '4231773c87474fcf8f5139fb317fc509');
INSERT INTO `role_user` VALUES ('63cf47f393104c2ea948eb1f6e2289cd', 'ce51f896209341e3b73c43c41174d19e', '022a132a325845459957732a25085712');
INSERT INTO `role_user` VALUES ('64ce0bf6448e40e38f9b384f5cebedf6', 'ce51f896209341e3b73c43c41174d19e', '4345175df7ff4c51a243a88f0fc4fd9c');
INSERT INTO `role_user` VALUES ('655df0d839494d859d4a8357b60e57de', 'ce51f896209341e3b73c43c41174d19e', '195c863fd9e245678b7434902930ead2');
INSERT INTO `role_user` VALUES ('6611bb32e2a744deb7d7e411dbb845dc', 'ce51f896209341e3b73c43c41174d19e', '75e9906f81814639b4d8e393a9c8655c');
INSERT INTO `role_user` VALUES ('67073db56c384b26960858be36fdc06c', 'ce51f896209341e3b73c43c41174d19e', '9e8257a519574249a6ba77577e5ffd3b');
INSERT INTO `role_user` VALUES ('67566560fba94002ba622f9ce11238d4', 'ce51f896209341e3b73c43c41174d19e', 'b03182ff15be4e84a96eac259007d652');
INSERT INTO `role_user` VALUES ('67e00f60648148dba6bf524871ef67bb', 'ce51f896209341e3b73c43c41174d19e', '8d6ca1b512d541b3afab36b3df43fa59');
INSERT INTO `role_user` VALUES ('69517d10a087426e9fae771389be815b', 'ce51f896209341e3b73c43c41174d19e', '1aa2646e5ce94c6a855b2c303c51eee7');
INSERT INTO `role_user` VALUES ('696b9506324341f68c5bd71f1f57b068', 'ce51f896209341e3b73c43c41174d19e', '5bbd0c00ac174b598ed6bd1eecc68d8d');
INSERT INTO `role_user` VALUES ('6972a1129a024268950628da3842a4dd', 'ce51f896209341e3b73c43c41174d19e', 'ae71083c10d84081a63bfe7a7d560437');
INSERT INTO `role_user` VALUES ('69d1fdc2c97a45eb8bf2c81c7036dca7', 'ce51f896209341e3b73c43c41174d19e', '3c90780b16f74a458b00a40166e61998');
INSERT INTO `role_user` VALUES ('69dae48053b74652813ff607e1758157', 'ce51f896209341e3b73c43c41174d19e', '03231a74edc4450491c24b3bda70a34f');
INSERT INTO `role_user` VALUES ('69ed9b1131a34e29aa323535cfe6a3a9', 'ce51f896209341e3b73c43c41174d19e', '28bf6dcadb9f42b8b2487718ad09ec4e');
INSERT INTO `role_user` VALUES ('6a3a0ec6556b4fb7a66409070ebec73a', 'ce51f896209341e3b73c43c41174d19e', 'e28fe642f348434b9717dfcca9b2786a');
INSERT INTO `role_user` VALUES ('6aa5f8b9be1840f98467cee794e4211e', 'ce51f896209341e3b73c43c41174d19e', 'fdf49324a9254634a4ac8c56304de04f');
INSERT INTO `role_user` VALUES ('6af87746b82845e6b4a1451417844f6b', 'ce51f896209341e3b73c43c41174d19e', 'a990c9dca6b64f61b51e1722311afbfa');
INSERT INTO `role_user` VALUES ('6b30c908e2724aec8e5629524f723233', 'ce51f896209341e3b73c43c41174d19e', '049e2e4e4b3a42d188399eaeab348682');
INSERT INTO `role_user` VALUES ('6c1dd0631aee4e79829f9767e02e24d9', 'ce51f896209341e3b73c43c41174d19e', 'a30b8455ef3e485180cd1e2abc610527');
INSERT INTO `role_user` VALUES ('6c5ab752ede64fd598e5ab914647cce4', 'ce51f896209341e3b73c43c41174d19e', 'e5dfb7d21bf046d8979d36ac58994ab0');
INSERT INTO `role_user` VALUES ('6d20bb7abca340f4ab5cfb7e8bfb7b03', 'ce51f896209341e3b73c43c41174d19e', '7a35f7b249e14ca1b1e678071686ef61');
INSERT INTO `role_user` VALUES ('6d49ad23bee141c38a50c5e740f81882', 'ce51f896209341e3b73c43c41174d19e', 'b1ffd058cde34f45b79a5919eeaf90b5');
INSERT INTO `role_user` VALUES ('6d6c5bf2d72f4d42bb5e1f4b42a46b13', 'ce51f896209341e3b73c43c41174d19e', 'fa08ddc31f77450da6c284d82d79acfc');
INSERT INTO `role_user` VALUES ('6e650e1eb9c944e8ae0138097d75f59f', 'ce51f896209341e3b73c43c41174d19e', 'cb438d822403460d86858f554f409070');
INSERT INTO `role_user` VALUES ('7029da1d5f2c44b098e95587f86a37be', 'ce51f896209341e3b73c43c41174d19e', 'a98f360b6a364f2cb42af0f9aa761027');
INSERT INTO `role_user` VALUES ('7033166d6c844cd78051112f7794423e', 'ce51f896209341e3b73c43c41174d19e', '81636086f9b9410abd6757f0bc8750a3');
INSERT INTO `role_user` VALUES ('70e34ff1a93046f49d0bf90b4924ac86', 'ce51f896209341e3b73c43c41174d19e', '3d001f7eee0f4509ba743dc993481afc');
INSERT INTO `role_user` VALUES ('711827b8bcdc418fbf940701411c53f1', 'ce51f896209341e3b73c43c41174d19e', '3eea546d0f1044c697fa029c7529e65a');
INSERT INTO `role_user` VALUES ('713d6bba2b4e4bf89b626158ec392167', 'ce51f896209341e3b73c43c41174d19e', '38ce2c35660441e7a15b5ae6e652e638');
INSERT INTO `role_user` VALUES ('715a790529a446cb8df473bf93966456', 'ce51f896209341e3b73c43c41174d19e', '2e554ec627ca4ee0b03f47f6f5559c21');
INSERT INTO `role_user` VALUES ('715ef42fc21c43e6a218262d414ed6fa', 'ce51f896209341e3b73c43c41174d19e', '10b3d14f32584d5bba838e118f687364');
INSERT INTO `role_user` VALUES ('71716254ebd145e3bba5f9dd7742dfe1', 'ce51f896209341e3b73c43c41174d19e', '60c6becf197a409f80be5a37ff9eb812');
INSERT INTO `role_user` VALUES ('71def2b6d6a5476f82e05692230c60ba', 'ce51f896209341e3b73c43c41174d19e', '3df0724c615d4ae487d7e315a7d93617');
INSERT INTO `role_user` VALUES ('72700e5435c14ac1b281ce0806a0b712', 'ce51f896209341e3b73c43c41174d19e', 'b4c28ec281c0442da6dee75517f6bfa4');
INSERT INTO `role_user` VALUES ('727062eeebff484a81e3193292b0a218', 'ce51f896209341e3b73c43c41174d19e', '1fb423db52064adf894854e234bdad7f');
INSERT INTO `role_user` VALUES ('73a5e7a591df464a8ca2d13ac3b9ba95', 'ce51f896209341e3b73c43c41174d19e', '6e78b3ca60bf4bdd93062b9543960982');
INSERT INTO `role_user` VALUES ('743721d3d6d744f1b6312802efb462df', 'ce51f896209341e3b73c43c41174d19e', '567decc8f6e24c7689c2a0d80ce10d44');
INSERT INTO `role_user` VALUES ('745e9f5f5e5e440fb0d254dfe5e18992', 'ce51f896209341e3b73c43c41174d19e', '30a4924104ac476a8a20e21ee5745288');
INSERT INTO `role_user` VALUES ('74b02e4184d14ae8b2934c39edbf3326', 'ce51f896209341e3b73c43c41174d19e', 'c0c6394e95154e52adfdf444c9cbeff9');
INSERT INTO `role_user` VALUES ('74ca48c47a104da68b762222cdaca753', 'ce51f896209341e3b73c43c41174d19e', '23363c8c98e1488cb75e8c438efd3ec5');
INSERT INTO `role_user` VALUES ('74f9928eccf44ae59f019247a3b2dc73', 'ce51f896209341e3b73c43c41174d19e', '7031592cc18b4ba1aaf58270c9464c37');
INSERT INTO `role_user` VALUES ('753eec95324c4460a97ab0db20d1d735', 'ce51f896209341e3b73c43c41174d19e', 'caa8b1003f3a423386080656b0c77712');
INSERT INTO `role_user` VALUES ('77183d197034421f8017eb2b8a79f2d7', 'ce51f896209341e3b73c43c41174d19e', '1651483e3961472faee26bda62782d36');
INSERT INTO `role_user` VALUES ('784c36fe76114d3ea21d5fe77d06d359', 'ce51f896209341e3b73c43c41174d19e', '475c3cf1f7f04f6291cf0ae99d0dd48d');
INSERT INTO `role_user` VALUES ('7922f509d11140928e73623ecc319b80', 'ce51f896209341e3b73c43c41174d19e', '62188be5bdaf4fc1900718b144be489e');
INSERT INTO `role_user` VALUES ('792d5d2007db4bb1bb83f24766d44f68', 'ce51f896209341e3b73c43c41174d19e', '74545ef9505247a993302a9c35443b0b');
INSERT INTO `role_user` VALUES ('79858296d5f14607b47383fd5b3de000', 'ce51f896209341e3b73c43c41174d19e', '9816784502844ea18adf620b19dd3167');
INSERT INTO `role_user` VALUES ('79dad9553e554539bce4331952b1919d', 'ce51f896209341e3b73c43c41174d19e', '62237905b7e143da94392d4f104902de');
INSERT INTO `role_user` VALUES ('7a3afc4cbe36481493292996f4eb4b61', 'ce51f896209341e3b73c43c41174d19e', '79963c3edfdb41f283bb31c47970aea2');
INSERT INTO `role_user` VALUES ('7ad22ad2ef2244c2bd267e491587123f', 'ce51f896209341e3b73c43c41174d19e', '387bac6e1b084a5497502cbf2153deec');
INSERT INTO `role_user` VALUES ('7b0e0b425e3c49c7b5de4637acc42507', 'ce51f896209341e3b73c43c41174d19e', '4b977a50925544e3ab546ef63d9049ae');
INSERT INTO `role_user` VALUES ('7b1a255753ff425ea3fe28f43a1e0f71', 'ce51f896209341e3b73c43c41174d19e', 'e9d2a09936b64defb32fcbf9608e1d01');
INSERT INTO `role_user` VALUES ('7bc9ff0aa6664a62add5639fd3412608', 'ce51f896209341e3b73c43c41174d19e', '01b9bc0da0204ca4a6621e31420c3adf');
INSERT INTO `role_user` VALUES ('7c52d7f5582d46b28115a6c2e686d007', 'ce51f896209341e3b73c43c41174d19e', 'f4bae582cb1f4fe2ac187866148cb79f');
INSERT INTO `role_user` VALUES ('7c5fbfdc4fca46ada8dc0cfe258af8df', 'ce51f896209341e3b73c43c41174d19e', '314165e06d1340c78a7fcb513097d768');
INSERT INTO `role_user` VALUES ('7d06817e55124e71a7a3b191ae3e3dc6', 'ce51f896209341e3b73c43c41174d19e', 'b114944abb884c6888d4d1bb8a442941');
INSERT INTO `role_user` VALUES ('7da40cbc7c4d488aa18672e0aa976031', 'ce51f896209341e3b73c43c41174d19e', '68f5bed1d2db42a880169c870a7ffbe3');
INSERT INTO `role_user` VALUES ('7e2960e909ae4e64ae93857ce535c837', 'ce51f896209341e3b73c43c41174d19e', '356c24897b1b4c3a8f89c2913ead8882');
INSERT INTO `role_user` VALUES ('7f0a5dd599ee4104af778c375ebcb138', 'ce51f896209341e3b73c43c41174d19e', '71053e8ab1e54506a5583741b248eff4');
INSERT INTO `role_user` VALUES ('7f4d8aa1b1bb42c88b556e0613e8d224', 'ce51f896209341e3b73c43c41174d19e', 'd4e263b65fc541239441b20278949675');
INSERT INTO `role_user` VALUES ('7f768305d0ed4493b5d5ad71c7becb80', 'ce51f896209341e3b73c43c41174d19e', 'c76187ff39ca44729066fd47e9c3f905');
INSERT INTO `role_user` VALUES ('7fe892ae240d4eccaef649abc9624216', 'ce51f896209341e3b73c43c41174d19e', '90f85118accb4220ae253b07527071d0');
INSERT INTO `role_user` VALUES ('80ac65c8f644450f8269791f1601ad63', 'ce51f896209341e3b73c43c41174d19e', '66c56ef078be4b088d1be14f2e9e3c7f');
INSERT INTO `role_user` VALUES ('811f43433fbc4ae79941193255f606b9', 'ce51f896209341e3b73c43c41174d19e', '1146a98128144668a6d2e87c0ee7bd71');
INSERT INTO `role_user` VALUES ('821f3b1b701a4a5b8a0ba93ae29ea474', 'ce51f896209341e3b73c43c41174d19e', 'ec5a4a070304409b84231cad9c34fbea');
INSERT INTO `role_user` VALUES ('8241119e20b34bbeac1964b995b4d9b7', 'ce51f896209341e3b73c43c41174d19e', 'ef3225c4836b442fbbd99b7f44c8d134');
INSERT INTO `role_user` VALUES ('82d28e2b3670460fa36801de3ecdb175', 'ce51f896209341e3b73c43c41174d19e', 'c934f8e315554af5884657da846d95a5');
INSERT INTO `role_user` VALUES ('838c5c9ccb6b42448e7ec5baafed04d7', 'ce51f896209341e3b73c43c41174d19e', '270ae71b59d345ac9a9541992638bb1e');
INSERT INTO `role_user` VALUES ('8394e3dc981a4caa991ae50358e8fad2', 'ce51f896209341e3b73c43c41174d19e', 'f968da1799e84c26a53bdd36a50bc552');
INSERT INTO `role_user` VALUES ('84d14433e45d48baaa7863aa1bc83f26', 'ce51f896209341e3b73c43c41174d19e', 'a9332f710cab4067bb4d7e4e9f869372');
INSERT INTO `role_user` VALUES ('84f8ca6126564f1a856d1aa31301509c', 'ce51f896209341e3b73c43c41174d19e', '23671a0f33ac4782a1fecfe84cb09bd4');
INSERT INTO `role_user` VALUES ('851e0321b2714640a5637594e76667ee', 'ce51f896209341e3b73c43c41174d19e', '3156328904c04d159986c11ba1a478b8');
INSERT INTO `role_user` VALUES ('856f11796cb74395833a5f86f449c8fc', 'ce51f896209341e3b73c43c41174d19e', '4d2cf5512c9b4cce900ec49de3040966');
INSERT INTO `role_user` VALUES ('866f763f2bd347b1a633c07101634f83', 'ce51f896209341e3b73c43c41174d19e', '0cb61700329e45ef97bc729c7083d48a');
INSERT INTO `role_user` VALUES ('8675e09eed8542c3b2fdb49ac437cf75', 'ce51f896209341e3b73c43c41174d19e', 'b2b2a55f182f4618a841030d0f4c54d4');
INSERT INTO `role_user` VALUES ('867d0438c09b416ea7f6564863907ba7', 'ce51f896209341e3b73c43c41174d19e', 'f6a24db3895c4a9b983393a7deb2bf6b');
INSERT INTO `role_user` VALUES ('871bfd635232422cbcd99f8a6866b720', 'ce51f896209341e3b73c43c41174d19e', '614e3ec286d147549f8258a7a1de4bf4');
INSERT INTO `role_user` VALUES ('872caa01d6f34f909b2f3c8a93f945fd', 'ce51f896209341e3b73c43c41174d19e', '573125482d89490fbdc1115d31cb65ba');
INSERT INTO `role_user` VALUES ('874c6134fb1c44f48724c061f72868ce', 'ce51f896209341e3b73c43c41174d19e', '6d02fdfc22a9426096faea39aa204ad0');
INSERT INTO `role_user` VALUES ('8779ec58fc52489b8c487fc756a12d58', 'ce51f896209341e3b73c43c41174d19e', 'e40b8d9f152745e4bd7ea750bb74d1e4');
INSERT INTO `role_user` VALUES ('87f097829d0647d9be7acb153716e880', 'ce51f896209341e3b73c43c41174d19e', 'a868336b7f6a45a698ff35f1b29d6363');
INSERT INTO `role_user` VALUES ('87f6364888b14194a36ba1337b5f89f3', 'ce51f896209341e3b73c43c41174d19e', '98e353f6d94c48c3a677ed2a824e0701');
INSERT INTO `role_user` VALUES ('883039e912e847289b9751bc5cca6b93', 'ce51f896209341e3b73c43c41174d19e', '719442d9169d48adb609f4f9c413cd32');
INSERT INTO `role_user` VALUES ('89a7f689a12943238c08e627f3b2d6be', 'ce51f896209341e3b73c43c41174d19e', 'c430a9a7d806425a998a6d9fe5a7e034');
INSERT INTO `role_user` VALUES ('8aa14107b3274637a3be40c6d486c648', 'ce51f896209341e3b73c43c41174d19e', '0d3638ed1eda4269b7bf52b4a7e81171');
INSERT INTO `role_user` VALUES ('8ac3352b528e446c992490b23e18941c', 'ce51f896209341e3b73c43c41174d19e', '0e8d7a2f2a604132915b6f49354e2ee1');
INSERT INTO `role_user` VALUES ('8ae71b24763f4575afc117f8d4008e99', 'ce51f896209341e3b73c43c41174d19e', 'cd086e5ffb3843bc9fd5d1a01cb6185f');
INSERT INTO `role_user` VALUES ('8b07b3842d7947dbb92a88b5dba54ed1', 'ce51f896209341e3b73c43c41174d19e', '6c360e1a35974ea6a071fefe6e7e2214');
INSERT INTO `role_user` VALUES ('8b0bfe9e8a1a4350876a24e42cda1d5c', 'ce51f896209341e3b73c43c41174d19e', '6502dfc2c18e4c89a5ed4766ba507dee');
INSERT INTO `role_user` VALUES ('8b50a8a45451469eb7652dff2d803a4d', 'ce51f896209341e3b73c43c41174d19e', '5f4ece3741fc4c618e2c4b01012711d3');
INSERT INTO `role_user` VALUES ('8c2e04cf1d5a46a9a6466dba103e784d', 'ce51f896209341e3b73c43c41174d19e', '667273d639974dfe9eaf63b4326a9ea2');
INSERT INTO `role_user` VALUES ('8ca619530c2940438ed558447aee8b39', 'ce51f896209341e3b73c43c41174d19e', '26b4cb63374842c582c769b37d07c115');
INSERT INTO `role_user` VALUES ('8ccff86744cd4d71b6fffb539aa54e74', 'ce51f896209341e3b73c43c41174d19e', '10b666bfa2a44b808e650e02464588f7');
INSERT INTO `role_user` VALUES ('8cde4892b9194144903165bda1be9c37', 'ce51f896209341e3b73c43c41174d19e', '3f3cb489ffe445e7816c14a12c7c4e5c');
INSERT INTO `role_user` VALUES ('8d57431a6a2a4ee1ae8543bc92f2f737', 'ce51f896209341e3b73c43c41174d19e', 'f4a802bcad3d46d2b496129507f1498b');
INSERT INTO `role_user` VALUES ('8d750da53c564a3a8ed0e068a692aba3', 'ce51f896209341e3b73c43c41174d19e', 'ce918d26ef8549888b9d3a1e8e70208e');
INSERT INTO `role_user` VALUES ('8dc0fa4f225a46f1b5ae39bc31bdff5e', 'ce51f896209341e3b73c43c41174d19e', 'b37f990359a54834b8392da959cce9cf');
INSERT INTO `role_user` VALUES ('8df2f586837a48758f3284a7c902321f', 'ce51f896209341e3b73c43c41174d19e', 'e0f17f639d654a599742cb8e361930ad');
INSERT INTO `role_user` VALUES ('8e0faae81c934040a4f22bd49bb54a5b', 'ce51f896209341e3b73c43c41174d19e', '2514c1a1fce746539693538c371752b4');
INSERT INTO `role_user` VALUES ('903d21f19c5745858b242d7edb9c3cc8', 'ce51f896209341e3b73c43c41174d19e', 'afed65c6f17c454894c22eb8107116ea');
INSERT INTO `role_user` VALUES ('915125dd3861491d9903b674071ccd5d', 'ce51f896209341e3b73c43c41174d19e', '8cc78e3bd2c64d9e97ad29b334902cd9');
INSERT INTO `role_user` VALUES ('92a038f6ab9d4dd58b14a52955cd4b62', 'ce51f896209341e3b73c43c41174d19e', '502e526602b44186afebdcbbc570c258');
INSERT INTO `role_user` VALUES ('931de9c0f1534a3d8f641648b86442c4', 'ce51f896209341e3b73c43c41174d19e', 'f0e0c22331eb479a9112f0fc723cd193');
INSERT INTO `role_user` VALUES ('932b23df69824f1dbb1d19c07757d25f', 'ce51f896209341e3b73c43c41174d19e', '0317f9dcca3f41fc8f4e074061bdb12c');
INSERT INTO `role_user` VALUES ('935dccd033a748b08ece5a3f9f10af05', 'ce51f896209341e3b73c43c41174d19e', '918739be8d944eafb26847186f65c0c2');
INSERT INTO `role_user` VALUES ('939762d3689a450fbdec6fc13752a53f', 'ce51f896209341e3b73c43c41174d19e', '5cbebc115c9042d88eaed99821296f93');
INSERT INTO `role_user` VALUES ('93cf5f83de3e4bc5a7e8282318b0ca26', 'ce51f896209341e3b73c43c41174d19e', '6d3a91ac1eb14d078e2ae95309cfb431');
INSERT INTO `role_user` VALUES ('94673df726984fd688b02dae2435c9ae', 'ce51f896209341e3b73c43c41174d19e', 'cd8079c0ee92456d803abbfea0df2854');
INSERT INTO `role_user` VALUES ('949a1a22a36f4066af8df1f83f193c14', 'ce51f896209341e3b73c43c41174d19e', '6d154f567bd34012bcf5dd5e7aadff61');
INSERT INTO `role_user` VALUES ('9501545248204ddb82c922d75a1cb43b', 'ce51f896209341e3b73c43c41174d19e', 'fd65f0bcac8b43cdb579633084663b55');
INSERT INTO `role_user` VALUES ('95b3cfbee0c54336afead39049a0c413', 'ce51f896209341e3b73c43c41174d19e', '950fb32f89ad4d6ab5ee492037abd351');
INSERT INTO `role_user` VALUES ('96360ca6de3b45f7b99dccdf29ec7368', 'ce51f896209341e3b73c43c41174d19e', '67f6d4b17348405283fd0d15cd452a67');
INSERT INTO `role_user` VALUES ('963a520288704d78be510303a4ad6d3a', 'ce51f896209341e3b73c43c41174d19e', '4561a1cd00664e44aa1bc086a6f31aad');
INSERT INTO `role_user` VALUES ('9786663e0cb04061bde39283f5ac2dd5', 'ce51f896209341e3b73c43c41174d19e', '41616db1bdac43279076a0a0f8dda0b1');
INSERT INTO `role_user` VALUES ('97a73d47591c434e9ac67fb04d34e473', 'ce51f896209341e3b73c43c41174d19e', 'e2e417f285134bff9803004d3cc35f0e');
INSERT INTO `role_user` VALUES ('983d1168708c41ea80989f96ec5c0c48', 'ce51f896209341e3b73c43c41174d19e', '31275135910540d39b5ad9bf7e810918');
INSERT INTO `role_user` VALUES ('98457784fa354bad9f588de85d974d96', 'ce51f896209341e3b73c43c41174d19e', 'c708a946de5940598d308f015cbd6406');
INSERT INTO `role_user` VALUES ('98b72dd5b8a3479eb93c07146f180d40', 'ce51f896209341e3b73c43c41174d19e', '5258d4ac0cfc44098795ee7be63312b2');
INSERT INTO `role_user` VALUES ('9944e999155f4cc2a0bab4f96ffbb861', 'ce51f896209341e3b73c43c41174d19e', '7d23ea764c38480aa8c0424da4d2efcb');
INSERT INTO `role_user` VALUES ('99737150d09c472f9cae557124ffe8b3', 'ce51f896209341e3b73c43c41174d19e', '4f7e7c20bfe4415493a8a21776cc184f');
INSERT INTO `role_user` VALUES ('99f2c5b47c184665b070f271d6b8a647', 'ce51f896209341e3b73c43c41174d19e', '751f4646a60e4a7180a15d47614ae6be');
INSERT INTO `role_user` VALUES ('9a016743109b46939e81d6613bbea14d', 'ce51f896209341e3b73c43c41174d19e', '1b59a40f2f0642a9906ecdaf8560ede2');
INSERT INTO `role_user` VALUES ('9a1f8fd282164ebc9831d745b2592555', 'ce51f896209341e3b73c43c41174d19e', '6075b8c7e6384de58f06c52f67ba3082');
INSERT INTO `role_user` VALUES ('9ab3930d16664f66a9e70552975566f2', 'ce51f896209341e3b73c43c41174d19e', 'e58fb2ce0e4b4a13af8a73c1d07873f5');
INSERT INTO `role_user` VALUES ('9ae0e66df4154c28bd2fa9806191aada', 'ce51f896209341e3b73c43c41174d19e', 'e79c543d609243649cc54c06f498f978');
INSERT INTO `role_user` VALUES ('9b2fea3533f947ed9311b9d55e98b183', 'ce51f896209341e3b73c43c41174d19e', '6d7df8109f414ce18530c67a693560f6');
INSERT INTO `role_user` VALUES ('9bcc5b059c484340bc05fa4c5964d6f6', 'ce51f896209341e3b73c43c41174d19e', '286f10f3c9f249c6bc5999921074db1d');
INSERT INTO `role_user` VALUES ('9c1baade75754860bdeb7aa341eb81d3', 'ce51f896209341e3b73c43c41174d19e', '31f7a54960db4c78aef50f196ba80c7e');
INSERT INTO `role_user` VALUES ('9c6b4706141b46e2a43b53d263336530', 'ce51f896209341e3b73c43c41174d19e', '4a04d21a1c9d4d2286dfdb2b5ec7b735');
INSERT INTO `role_user` VALUES ('9ca14058aac741c990df62e7fc67795c', 'ce51f896209341e3b73c43c41174d19e', '61644323d7c84607ad2a2ed8410f49fa');
INSERT INTO `role_user` VALUES ('9cc28ac2bdb045e9b1927b4932b1b10e', 'ce51f896209341e3b73c43c41174d19e', 'a7cd54c4b1ae4c4f8980d4e50f7d36c6');
INSERT INTO `role_user` VALUES ('9cdee040339045638c8caacb2eca1904', 'ce51f896209341e3b73c43c41174d19e', 'a535df96aca740f28413c3e7ff1d3fdb');
INSERT INTO `role_user` VALUES ('9ef9175abbd7481c830b7e0efe0d886d', 'ce51f896209341e3b73c43c41174d19e', 'af77fcd02c414de9a0043fff9eb14f92');
INSERT INTO `role_user` VALUES ('9f162a0f24c344e3b03d230f13c1344f', 'ce51f896209341e3b73c43c41174d19e', '53e84d04bb0242d2a10cab355137322c');
INSERT INTO `role_user` VALUES ('9fb42a4b64e0421fb233dd5b03be7775', 'ce51f896209341e3b73c43c41174d19e', '563a3133a15c4e8c89a9a1ec83fab30b');
INSERT INTO `role_user` VALUES ('9fb8f4c2bcbe40d9bc75eadb9c721e4d', 'ce51f896209341e3b73c43c41174d19e', '32082411cb60405b87e25ada8f99ea63');
INSERT INTO `role_user` VALUES ('a08fc47896d84400862cf235dbe771ff', 'ce51f896209341e3b73c43c41174d19e', 'c5291d398ab14450be0d1e1df5439593');
INSERT INTO `role_user` VALUES ('a09320fc2c7846999c29f8f23e36d9a5', 'ce51f896209341e3b73c43c41174d19e', 'bb528ecc8c79479daaacac93818a006c');
INSERT INTO `role_user` VALUES ('a0eac7b9485b4a75acb1b673de5f94b8', 'ce51f896209341e3b73c43c41174d19e', '17f4133fa5b54730b0efe60493bf6c39');
INSERT INTO `role_user` VALUES ('a1712342097049538b84aa9bf665ea70', 'ce51f896209341e3b73c43c41174d19e', '6537069a41cd4b2daf767462397be67d');
INSERT INTO `role_user` VALUES ('a17139e40a3148828525f9f0c8612ccd', 'ce51f896209341e3b73c43c41174d19e', '3b9434cd9e004d47823f3c61a4a66b23');
INSERT INTO `role_user` VALUES ('a1e3fafda5fa46ebbf6d5d7572ef3278', 'ce51f896209341e3b73c43c41174d19e', '576ebacc8df3430182fc136047751159');
INSERT INTO `role_user` VALUES ('a231e56353a44c73aedc53fe3858b7ff', 'ce51f896209341e3b73c43c41174d19e', '9a8d158587714ecdb230dc99ba346a12');
INSERT INTO `role_user` VALUES ('a358ad9e4cdb4426b2256b45af06149c', 'ce51f896209341e3b73c43c41174d19e', '1ea8301f430044d1a9c63fa7eb3621b2');
INSERT INTO `role_user` VALUES ('a41cf1a380f94bb396fa2193dfb34a38', 'ce51f896209341e3b73c43c41174d19e', '1f2e3920326244e0956454cbd2938144');
INSERT INTO `role_user` VALUES ('a43cd316f97744eaab200e7a91d4dcd8', 'ce51f896209341e3b73c43c41174d19e', '88dcd6fc6d2947f988abee637bcdab2f');
INSERT INTO `role_user` VALUES ('a450aed418284b429009768515d99418', 'ce51f896209341e3b73c43c41174d19e', '345997327da84dbeb9e722c2e3277aa2');
INSERT INTO `role_user` VALUES ('a49de998dec24d329a7c55ad56a8f1a5', 'ce51f896209341e3b73c43c41174d19e', 'ed5540a5e5d34e34b948f5b9d5fff941');
INSERT INTO `role_user` VALUES ('a4c8b474e83e4bcda38bb2e0e59d4480', 'ce51f896209341e3b73c43c41174d19e', '5bb92fef3c2b4d1e8630892c83c19f0e');
INSERT INTO `role_user` VALUES ('a5bcc2cfb94a47199365b0ef9d49d708', 'ce51f896209341e3b73c43c41174d19e', '7785cf7c621243a287a52ffff69e8903');
INSERT INTO `role_user` VALUES ('a5fae6c20c0c46f6abaa8d2f799c8fb0', 'ce51f896209341e3b73c43c41174d19e', '3f650732d2bc4fe998d85bc14bfe5d3a');
INSERT INTO `role_user` VALUES ('a63f500592b44c1d805d809df5225958', 'ce51f896209341e3b73c43c41174d19e', '6a39b447b3054c248121b2d7ffbf41cb');
INSERT INTO `role_user` VALUES ('a69397c36f7646128dab5f102e3a1594', 'ce51f896209341e3b73c43c41174d19e', '9505e8a945574c30baceb78df05973ad');
INSERT INTO `role_user` VALUES ('a736bf099ab34336a40f7c4d5c85206b', 'ce51f896209341e3b73c43c41174d19e', 'ee7d985ac69f43edaba0b3d29fca4cf9');
INSERT INTO `role_user` VALUES ('a73c1b55d8ef44fb9a0a46ec538a3878', 'ce51f896209341e3b73c43c41174d19e', '7d4ca477929345538e8c1c187e219b74');
INSERT INTO `role_user` VALUES ('a75a9b9b15124e9580e2be2808110463', 'ce51f896209341e3b73c43c41174d19e', '314ea98d5c6c45d880ef9cd8d420b190');
INSERT INTO `role_user` VALUES ('a788a486c3f7475f964ce6dd2ae80604', 'ce51f896209341e3b73c43c41174d19e', '24a5f001c2a54cf6b572d802e33839b0');
INSERT INTO `role_user` VALUES ('a79811406489429dbe79ae618f5ebecd', 'ce51f896209341e3b73c43c41174d19e', '3e4d7f5bbc854b6b80dec6e33fe9e6e8');
INSERT INTO `role_user` VALUES ('a7c11fe40dc441b3b74fa74b854384a5', 'ce51f896209341e3b73c43c41174d19e', 'f673428667c7414d957abf5f750c89d9');
INSERT INTO `role_user` VALUES ('a7ee3556ecbb4aa5a7ee326c2b10d1d8', 'ce51f896209341e3b73c43c41174d19e', 'a73ce7a517d24e748dcc5790a423cb95');
INSERT INTO `role_user` VALUES ('a8406951b89a4d5ba4b01270eb6e010f', 'ce51f896209341e3b73c43c41174d19e', '0a7330197ae24ee68c0ff39b837ed847');
INSERT INTO `role_user` VALUES ('a8abe96c6c3a4e73a7ad28a8eb4dd564', 'ce51f896209341e3b73c43c41174d19e', '6182ac21f8094530ac7d6c4034545a61');
INSERT INTO `role_user` VALUES ('a8c8c68807b64b8bba400ce5f776df84', 'ce51f896209341e3b73c43c41174d19e', 'ca1a1ad5bbe14fba9c9468dacf3a5757');
INSERT INTO `role_user` VALUES ('a956eed27a1d4cfbaa80e94153351cb4', 'ce51f896209341e3b73c43c41174d19e', 'f6cf1eaca66647d39c23c0d88ea6f75b');
INSERT INTO `role_user` VALUES ('a9c9fcc6fc7c483995832fb24ad51195', 'ce51f896209341e3b73c43c41174d19e', '7ac3089666cf4dd6b974d40484ed5f53');
INSERT INTO `role_user` VALUES ('a9f50bcc38a442f0ab94b1b4b3bc0410', 'ce51f896209341e3b73c43c41174d19e', 'f53a148669074558b8dc00fc9f7193bb');
INSERT INTO `role_user` VALUES ('aadfe53c9f8c48cfa0d433a8eb3b943d', 'ce51f896209341e3b73c43c41174d19e', '285001ae0e8b4551a424d3ad752c2e3d');
INSERT INTO `role_user` VALUES ('ab0cffcef635417cb556d68f51ca2329', 'ce51f896209341e3b73c43c41174d19e', 'ca06b07b526b4b7f93e9995b0ef7a7b6');
INSERT INTO `role_user` VALUES ('ab8e6ac30bca400ba7114b255e54697f', 'ce51f896209341e3b73c43c41174d19e', '4f6aacc6948244519c8b4e50b07df08d');
INSERT INTO `role_user` VALUES ('ad2fa02e26d74ce1a23c64f178d29c06', 'ce51f896209341e3b73c43c41174d19e', '017dd32feb054c58941c5d47c3d64a29');
INSERT INTO `role_user` VALUES ('ad72c0fd4b1c4f04b6f5d909f548fbfe', 'ce51f896209341e3b73c43c41174d19e', '081163a1873d42e5b2c862f95b31789b');
INSERT INTO `role_user` VALUES ('ae2f6b792577437795d12b5f643f6258', 'ce51f896209341e3b73c43c41174d19e', 'f5fb26d558534f29903f56346fe2f166');
INSERT INTO `role_user` VALUES ('af47a65ac969422d83242f40383444cc', 'ce51f896209341e3b73c43c41174d19e', '14688d1ee0af4cd0a29b46af5911ca62');
INSERT INTO `role_user` VALUES ('b014998587714c7293235f67202fa79c', 'ce51f896209341e3b73c43c41174d19e', 'f9ee9fb19897404b9acd895307e8b0e2');
INSERT INTO `role_user` VALUES ('b0c91f870c504ef5b343ad24cc325068', 'ce51f896209341e3b73c43c41174d19e', '0c2ac9d9567747eaa517570ac77d3a21');
INSERT INTO `role_user` VALUES ('b0d2cc1a3f0244098209e84a100de4be', 'ce51f896209341e3b73c43c41174d19e', '4c80a2bbc2944e3c9cc0c9a3f8aa990e');
INSERT INTO `role_user` VALUES ('b17497e53fd24e828221a3634f7f6ce2', 'ce51f896209341e3b73c43c41174d19e', '24260789263041a28e848850a940ccc4');
INSERT INTO `role_user` VALUES ('b19605c581ca41458afca3f6b71e54af', 'ce51f896209341e3b73c43c41174d19e', 'a81c22d7001449868525c212b4bc4501');
INSERT INTO `role_user` VALUES ('b2063ff760de4d74a02e5fe9daade28e', 'ce51f896209341e3b73c43c41174d19e', '234c2c6d34f645aab78a041d4819cb11');
INSERT INTO `role_user` VALUES ('b241c07f672242d9a72b7e4681669353', 'ce51f896209341e3b73c43c41174d19e', '6e8db93ef9db49838fd0b1b8621e9e21');
INSERT INTO `role_user` VALUES ('b248379742934d009817b5572bfa4c9d', 'ce51f896209341e3b73c43c41174d19e', '5a71bf1ef06a4bd8b8e361c7ea3d71b2');
INSERT INTO `role_user` VALUES ('b24d9892ff8145018fbc3a36cb4e7d3b', 'ce51f896209341e3b73c43c41174d19e', 'bfcb23bf8e3840f1873cdd3b22d9e4b2');
INSERT INTO `role_user` VALUES ('b2aa3b533e944b7bb544c0a6bca6e18f', 'ce51f896209341e3b73c43c41174d19e', 'f5f9afe3e3c64b0e95fdae05048aaf39');
INSERT INTO `role_user` VALUES ('b2b78f42be7b49b9b68b30a21c61ef5e', 'ce51f896209341e3b73c43c41174d19e', '6b0ca891f85a4cd4ade76c6f6c0ec061');
INSERT INTO `role_user` VALUES ('b35d0c0b50ac45f48dae9013ae6bbc35', 'ce51f896209341e3b73c43c41174d19e', '2ceb17978a824074bf2dc14ec8dbd6d5');
INSERT INTO `role_user` VALUES ('b481ad33dff84f3c9cc4f2fbb1a5e1eb', 'ce51f896209341e3b73c43c41174d19e', '29c802a592584b0f8b373a25316c7ea0');
INSERT INTO `role_user` VALUES ('b4f2be21bb654814bda858061a001696', 'ce51f896209341e3b73c43c41174d19e', '9c06dd1b6d3942feaad27d92909cbb71');
INSERT INTO `role_user` VALUES ('b59d8f749ac14dd98884d1e9ec5bbdf9', 'ce51f896209341e3b73c43c41174d19e', '9079be6713ab4d529be7b6f4dbdcbefb');
INSERT INTO `role_user` VALUES ('b61aa7c50b6e43759365c7408a9b0829', 'ce51f896209341e3b73c43c41174d19e', '8b92716499b741bba86a76aa4625175e');
INSERT INTO `role_user` VALUES ('b64a695ed162431cb98258340e2ec0ac', 'e7579b7a56554ca2bac59e3cc2aa6d28', '2476f88b4855495cb249594dcf4341f5');
INSERT INTO `role_user` VALUES ('b729f28b2bfa4ea0a06841db496a0578', 'ce51f896209341e3b73c43c41174d19e', '5b53802d38e24775bf92e01759046a1a');
INSERT INTO `role_user` VALUES ('b73c2f726b7f4531b916e2801742a867', 'ce51f896209341e3b73c43c41174d19e', '2ce80f7221d845258d194246c41f4164');
INSERT INTO `role_user` VALUES ('b757bbffed2a4db2b4751b52c49ec91d', 'ce51f896209341e3b73c43c41174d19e', '6edca6f8d68848709a21e0d2a489d357');
INSERT INTO `role_user` VALUES ('b771069624d44dfa9b5840a23c6c7c4e', 'ce51f896209341e3b73c43c41174d19e', '79ddff632a31427c82f3901db2fc9449');
INSERT INTO `role_user` VALUES ('b78e72a4ebb54e03a53b02278d45dafd', 'ce51f896209341e3b73c43c41174d19e', '393c78b8fee242298b5503934b94946b');
INSERT INTO `role_user` VALUES ('b7b797750b4f461995546a01b217739e', 'ce51f896209341e3b73c43c41174d19e', '11b4e079f24e4952b8ec82caf2f75b06');
INSERT INTO `role_user` VALUES ('b7e6a31b19f64bc08873f891ee84628d', 'ce51f896209341e3b73c43c41174d19e', 'd81cd868e29e4856ae15b26754129901');
INSERT INTO `role_user` VALUES ('b80bf6eef46542fe8c176e628c2cb1b9', 'ce51f896209341e3b73c43c41174d19e', '01a55332519342af866f424f40b465ee');
INSERT INTO `role_user` VALUES ('b84a423900094bb688c8ac07a22efa74', 'ce51f896209341e3b73c43c41174d19e', '2a5db6bb3f7c43c4ba92adab6f6109fa');
INSERT INTO `role_user` VALUES ('ba740b4c7eb94db48170f046c2c93304', 'ce51f896209341e3b73c43c41174d19e', '9ba102b8561d4517bf9bc0eb02c8b20a');
INSERT INTO `role_user` VALUES ('bb2b35607beb474f89fe51107fb01898', 'ce51f896209341e3b73c43c41174d19e', '35abb216b13f4dac94e238c1f5d487f5');
INSERT INTO `role_user` VALUES ('bb323069ceec439dbe5ed2064106299f', 'ce51f896209341e3b73c43c41174d19e', '1c8b5c8792894d40af0399f60f3ec470');
INSERT INTO `role_user` VALUES ('bbb966a25d124eaba62521408775c272', 'ce51f896209341e3b73c43c41174d19e', '0d66c6ea4c514dafbbd992150217ec6a');
INSERT INTO `role_user` VALUES ('bbef8ec981564983baa7af22b59ccb10', 'ce51f896209341e3b73c43c41174d19e', '670cd09708994d54b5d77904eedafaaf');
INSERT INTO `role_user` VALUES ('bccdfe6a7b77472883328a1a69bd6bbe', 'ce51f896209341e3b73c43c41174d19e', '5e7883c70c19455582ccf7e2f50a171c');
INSERT INTO `role_user` VALUES ('bdcb3b1dadb84225814b4203730c7d81', 'ce51f896209341e3b73c43c41174d19e', 'a9a2dd67f4774ffb8852851b800bf486');
INSERT INTO `role_user` VALUES ('bdf2d7a153014d8f89172c98c305b66c', 'ce51f896209341e3b73c43c41174d19e', 'dd966233b5404c2db25287a73e69ab5c');
INSERT INTO `role_user` VALUES ('be733e30e3e44b2da53c5dbda77b333a', 'ce51f896209341e3b73c43c41174d19e', '6c9213d886f240dfb01cc72e78e35bbe');
INSERT INTO `role_user` VALUES ('bec48f71b0834848ab1356ca44fa1736', 'ce51f896209341e3b73c43c41174d19e', '49677cca2f2e4a078e2ddc60ab978c9c');
INSERT INTO `role_user` VALUES ('bef3104e851845949aa4646ccb105bc4', 'ce51f896209341e3b73c43c41174d19e', 'f7bc0452de464da88fdc8a2539ff5cb9');
INSERT INTO `role_user` VALUES ('bf93d667d8a240378bfa877da386226e', 'ce51f896209341e3b73c43c41174d19e', '84bb344930d74a838f524dc9998c58ce');
INSERT INTO `role_user` VALUES ('c036e7a7fe4d45509e71d779ee517aad', 'ce51f896209341e3b73c43c41174d19e', '97276c6a5d6441a792fd7a581a636686');
INSERT INTO `role_user` VALUES ('c0595e0754bd469e927cc9236a2e0a69', 'ce51f896209341e3b73c43c41174d19e', '0f50b0af7597493f81a7bc0f945f4e02');
INSERT INTO `role_user` VALUES ('c07d0b812c7548a39e196d43cf63ddb1', 'ce51f896209341e3b73c43c41174d19e', '7f8d894f402748b880a6680db2aa8c16');
INSERT INTO `role_user` VALUES ('c0f2cd296fcd491ab738614103b2d51a', 'ce51f896209341e3b73c43c41174d19e', 'e589c4b39bb14452b1ed43fb93190097');
INSERT INTO `role_user` VALUES ('c128fc3b742d4c959c322cb5ab680ae5', 'ce51f896209341e3b73c43c41174d19e', '22df65d8c9044f8e97b98a4330444e03');
INSERT INTO `role_user` VALUES ('c18c40937ab043e78eff0c2fea42f2a3', 'ce51f896209341e3b73c43c41174d19e', 'daf4dfbc81c94dc9bed31d7fc07e54ea');
INSERT INTO `role_user` VALUES ('c1c56c6baf374e74ace1395a285a0f29', 'ce51f896209341e3b73c43c41174d19e', '2c05125d230c4370868b0693d673f644');
INSERT INTO `role_user` VALUES ('c1ef36bfb96d4e0fa3beac03fc228cd6', 'ce51f896209341e3b73c43c41174d19e', '66df8f4c1ef24b208a83e6b97100f736');
INSERT INTO `role_user` VALUES ('c26670051717457081c3a786dd513dd0', 'ce51f896209341e3b73c43c41174d19e', 'd471092c9ce14a649e629b34503b4f09');
INSERT INTO `role_user` VALUES ('c2862b8d4f6c472e87c10a16a9d017a0', 'ce51f896209341e3b73c43c41174d19e', '78957f9245fd470f913cb146f4538cda');
INSERT INTO `role_user` VALUES ('c2ac9d0bcf714a3e9c7d25da8485c03d', 'ce51f896209341e3b73c43c41174d19e', '1fc699f5596048efa892bc5b6e2b9aa6');
INSERT INTO `role_user` VALUES ('c2adb1704dc84f5ebb45125f6250c245', 'ce51f896209341e3b73c43c41174d19e', '1d26b1c027b44b6c829c9414c95f42b7');
INSERT INTO `role_user` VALUES ('c34bcb23bd5142598540c8b59cfbee86', 'ce51f896209341e3b73c43c41174d19e', '67854b1f7ec84c05a3408d124c4ec722');
INSERT INTO `role_user` VALUES ('c3b8ccfdccbe4e57a8fd74e7958589fe', 'ce51f896209341e3b73c43c41174d19e', '529b3a9353ae4855831d09fc56b85495');
INSERT INTO `role_user` VALUES ('c418cbe02faf4187ab73f7c333d1b948', 'ce51f896209341e3b73c43c41174d19e', '873f4bbe21bb4008803d3c82dc214ad8');
INSERT INTO `role_user` VALUES ('c427b422a41c43edb344db6bc10fdb42', 'ce51f896209341e3b73c43c41174d19e', '857b1ebba1c845afa2504403e198ce63');
INSERT INTO `role_user` VALUES ('c4b8c1542e6944bf8a4df4a1a30cf2b7', 'ce51f896209341e3b73c43c41174d19e', '9e8dd27e47b446458ac07b297033fe4b');
INSERT INTO `role_user` VALUES ('c4cb673784114c5fbe660df1a984e109', 'ce51f896209341e3b73c43c41174d19e', 'db1047f4653e4c3f81477118e811b134');
INSERT INTO `role_user` VALUES ('c54d725d0bce4c62aba03e8044b0abd5', 'ce51f896209341e3b73c43c41174d19e', '0c1b159f6f7e49fb91128e2e04f0cafe');
INSERT INTO `role_user` VALUES ('c56d8f4714ac45078ca71d361954cce9', 'ce51f896209341e3b73c43c41174d19e', '219cb01936004fe6aaa1eca92631f813');
INSERT INTO `role_user` VALUES ('c5d66d6eac2645d48cc23d4e6b1ceefa', 'ce51f896209341e3b73c43c41174d19e', 'd9e4d8f2d85c45beb5e842703ac6381f');
INSERT INTO `role_user` VALUES ('c5f26c7830f842318dd538b151fada65', 'ce51f896209341e3b73c43c41174d19e', '3f0ce24dc59241c68997e657eca4b9f3');
INSERT INTO `role_user` VALUES ('c668efed75384119bb343757a010abb5', 'ce51f896209341e3b73c43c41174d19e', 'c98e48f2203e492aa9b2af635c077783');
INSERT INTO `role_user` VALUES ('c72468cad7444f67a54e6af6bc3bb601', 'ce51f896209341e3b73c43c41174d19e', 'd20448d766fb46b1bfa86779acd025e3');
INSERT INTO `role_user` VALUES ('c72ee88237d548d9ac0ac684d099535f', 'ce51f896209341e3b73c43c41174d19e', '5e8523f848204d0fb50969d137846bd8');
INSERT INTO `role_user` VALUES ('c77e249e267c4f67b1d5ddc28211561b', 'ce51f896209341e3b73c43c41174d19e', 'a18d6700166a4083be221626db2d2f4f');
INSERT INTO `role_user` VALUES ('c89255c7f8bb460e8e3f7082ae3e5f81', 'ce51f896209341e3b73c43c41174d19e', 'f71cdc99e64f4472b766cfc501632c9c');
INSERT INTO `role_user` VALUES ('c9fbdd59b59e485ba99194aff006fcbf', 'ce51f896209341e3b73c43c41174d19e', '8d1e146b1ceb4fec8d434ee797db5de3');
INSERT INTO `role_user` VALUES ('ca1e6b3c59a84936ad8066147047342f', 'ce51f896209341e3b73c43c41174d19e', 'c27639666aa24d608c6bef0bddca72cc');
INSERT INTO `role_user` VALUES ('ca3f5931853a482794de9745fda599eb', 'ce51f896209341e3b73c43c41174d19e', '9c433edaf86148a99bd65cc27b92958f');
INSERT INTO `role_user` VALUES ('caaa4e0d73d14a51954561af81cf6b2d', 'ce51f896209341e3b73c43c41174d19e', '42c2ceaae29b4eb8858e0ea610b8a860');
INSERT INTO `role_user` VALUES ('caed0cdbad3048828471d57f83fd2061', 'ce51f896209341e3b73c43c41174d19e', 'e24623e06c1a447591c33eb3df75d3b6');
INSERT INTO `role_user` VALUES ('cb121cde1312424a8d45d4c8682222ff', 'ce51f896209341e3b73c43c41174d19e', '427bac43bfe942fbba3ec81d58dffd9a');
INSERT INTO `role_user` VALUES ('cb2c19d07ff1464b8eb1dd7cdf85402f', 'ce51f896209341e3b73c43c41174d19e', '203eaa6eee2d418dbc2ff7d646c007dd');
INSERT INTO `role_user` VALUES ('cbf4430cc8c04a649f0119b3ee696849', 'ce51f896209341e3b73c43c41174d19e', 'c45d06aba6d74f7aae37fe5578a986b6');
INSERT INTO `role_user` VALUES ('cd3236b7a81a4df18bdbaa5a83b73c2a', 'ce51f896209341e3b73c43c41174d19e', '1c8ccb46dfcc4deabe9549e457182ad4');
INSERT INTO `role_user` VALUES ('ce05d8c416564fcfb0ee5814fcbaeec2', 'ce51f896209341e3b73c43c41174d19e', '61540e02b2c34d7c939441e17ac8c425');
INSERT INTO `role_user` VALUES ('ce4be9ee50a54430a54b7e5793d3ecd7', 'ce51f896209341e3b73c43c41174d19e', 'aeb2f17ef5564baab9a91c05537233f8');
INSERT INTO `role_user` VALUES ('d0c3128e1a0a4ba0aa67dca0e2e0264b', 'ce51f896209341e3b73c43c41174d19e', '4ee486a7fac64ac3b54c98792d7fbde1');
INSERT INTO `role_user` VALUES ('d18259dbc48042a1ae795ac489a4e669', 'ce51f896209341e3b73c43c41174d19e', '1547e2a83ada4c4cb34d1ab27122bb74');
INSERT INTO `role_user` VALUES ('d27b87189cf64290a2b74b437ece1cb9', 'ce51f896209341e3b73c43c41174d19e', 'fd0d387d69cb43ec943e6167022575e0');
INSERT INTO `role_user` VALUES ('d2e72a592c114f7bb3142ef84aa8c4f7', 'ce51f896209341e3b73c43c41174d19e', 'c6a99108325349499340b58dd4cfbed0');
INSERT INTO `role_user` VALUES ('d41c99e2143c495580a23f0efcee6a6a', 'ce51f896209341e3b73c43c41174d19e', '6a98cd8c311b4631bde44577e69f1d77');
INSERT INTO `role_user` VALUES ('d4453644994942039b43ca779baf05d2', 'ce51f896209341e3b73c43c41174d19e', '6a1821ea598e44329f802fee98bb8761');
INSERT INTO `role_user` VALUES ('d44d7e4047504ce38e2ab1a50b70dd8c', 'ce51f896209341e3b73c43c41174d19e', '3395f365a21547ca8490f4d1004bfaf1');
INSERT INTO `role_user` VALUES ('d5b74656649847da899c3d982dd09194', 'ce51f896209341e3b73c43c41174d19e', '60afb4e267704f46b79ca2d73f70b115');
INSERT INTO `role_user` VALUES ('d5c27a4781ea4e0999dd5015eba76fc8', 'ce51f896209341e3b73c43c41174d19e', '398c5167de2943d0ad35acf8bdf37b4b');
INSERT INTO `role_user` VALUES ('d61331f2659a4f1a934a8bb237f1a759', 'ce51f896209341e3b73c43c41174d19e', '5313b7c9218f4bac836f5590e82cde42');
INSERT INTO `role_user` VALUES ('d61e800298714999ae30e7e51ebd29b2', 'ce51f896209341e3b73c43c41174d19e', '3bc32d21b2a442b1915295225344a6d5');
INSERT INTO `role_user` VALUES ('d647c6336cf24d6e9fa6da6b45615ee5', 'ce51f896209341e3b73c43c41174d19e', '6f1c8308c8a042f4a3273ee6d57e993b');
INSERT INTO `role_user` VALUES ('d6eae8037fec4322bfa209d818a27c8a', 'ce51f896209341e3b73c43c41174d19e', 'b9fc3c211108474aa94fb6e16b7182ec');
INSERT INTO `role_user` VALUES ('d745879f124a470db47c0adee0018be8', 'ce51f896209341e3b73c43c41174d19e', 'ffc76b95de494baab57f7709d5164b34');
INSERT INTO `role_user` VALUES ('d78b5963e67c42709ad518e56f585db2', 'ce51f896209341e3b73c43c41174d19e', '8dddfbbd8964412184467b50ed2c1c2d');
INSERT INTO `role_user` VALUES ('d7bbc0206bad4a87babb547c13eca6b4', 'ce51f896209341e3b73c43c41174d19e', '9274c4bea5ef4cd7bcd82b76b7dcbcf0');
INSERT INTO `role_user` VALUES ('d82ad3ea10f646e1b9b59e329d09070b', 'ce51f896209341e3b73c43c41174d19e', '0e06a5d4f0de4d0cb7486dde2eaf0605');
INSERT INTO `role_user` VALUES ('d839da15b4ef4fa5a0a524e05b0fc56b', 'ce51f896209341e3b73c43c41174d19e', 'baf2ec42ea884961973b0c52ccbb897f');
INSERT INTO `role_user` VALUES ('d8524f882c82401ca3e21fc27caa981a', 'ce51f896209341e3b73c43c41174d19e', '6f54bd09493144f6bfdfe6169d81659b');
INSERT INTO `role_user` VALUES ('d88950041ba34a6ea8c3b16aed6de57d', 'ce51f896209341e3b73c43c41174d19e', '10cb47af6fb745d5ab83a368158e5b7d');
INSERT INTO `role_user` VALUES ('d8e5907eae1a4477872dcd988f8eed25', 'ce51f896209341e3b73c43c41174d19e', 'd37ee3b1cb4d449094ed5919e962ff4b');
INSERT INTO `role_user` VALUES ('d9ff0ee752e44d03a771a26c467943c0', 'ce51f896209341e3b73c43c41174d19e', '5513635d584c441da2f8eada5b62a9c7');
INSERT INTO `role_user` VALUES ('da27976eedc14ff5917982bd19aeaa0c', 'ce51f896209341e3b73c43c41174d19e', '26c0c9f87fac47058c5a8904e9481dd1');
INSERT INTO `role_user` VALUES ('db1b248c3bc24805b49d984f3246760a', 'ce51f896209341e3b73c43c41174d19e', '68da2397ece44a97aea5c29ce974e9eb');
INSERT INTO `role_user` VALUES ('dbb7e82cd5da4217bc921eb9ab0ff588', 'ce51f896209341e3b73c43c41174d19e', 'ad681341ecca4462bfee59241d43c1da');
INSERT INTO `role_user` VALUES ('dbc27ec0b7e240ddb7eaa4f8b747f81d', 'e7579b7a56554ca2bac59e3cc2aa6d28', '4b1e47c16aca4e919109d0a6a2fd4d9b');
INSERT INTO `role_user` VALUES ('dbe8128e599e44adb0deaaf95e9b971f', 'ce51f896209341e3b73c43c41174d19e', 'ff5b9173f25749eea838928fd10a4969');
INSERT INTO `role_user` VALUES ('dc258f4898824992822f932646f1c03b', 'ce51f896209341e3b73c43c41174d19e', '5b87dfc8d34f4b17b3f88c02d929edb2');
INSERT INTO `role_user` VALUES ('dc4b1cb1c6634b5083de9fef14ce5200', 'ce51f896209341e3b73c43c41174d19e', 'af272b1d00fa4ecfb72fc991aa4aa50d');
INSERT INTO `role_user` VALUES ('dc608fc696814cb49b32077ee2937ee1', 'ce51f896209341e3b73c43c41174d19e', '5bb0fffe61514ad08f8eafbfbabba487');
INSERT INTO `role_user` VALUES ('dc82803835924c5f91eff173f358f1e9', 'ce51f896209341e3b73c43c41174d19e', '08bcba599aba4eafbb85b8b3ebdde584');
INSERT INTO `role_user` VALUES ('dcf8abc2e600482c98117537a8cca97c', 'ce51f896209341e3b73c43c41174d19e', '144f999122a34e979e69de06fb38b267');
INSERT INTO `role_user` VALUES ('dd2ab70c35c547189c632a44805cc504', 'ce51f896209341e3b73c43c41174d19e', '5d15a4afbd714b288f0f1449a8a865c5');
INSERT INTO `role_user` VALUES ('dd3ebb9244474a1ba487a01640522ad4', 'ce51f896209341e3b73c43c41174d19e', 'ea3bab000ddd4829912ea476142a2bd8');
INSERT INTO `role_user` VALUES ('dd6ccf8fd7ce48609389c0c69639caac', 'ce51f896209341e3b73c43c41174d19e', '2d8517add7a14518a4d2bbb8d741059c');
INSERT INTO `role_user` VALUES ('dd7e4bcba8464e7a94d1c3eb9c658c3b', 'ce51f896209341e3b73c43c41174d19e', 'a5d080b8d2d645fdafac7660d839bf55');
INSERT INTO `role_user` VALUES ('dd9d077bcb89470aafa473a3d1f2e3bf', 'ce51f896209341e3b73c43c41174d19e', 'd020635e4e47479da0371511575beab5');
INSERT INTO `role_user` VALUES ('ddd01bca93da4be0b08ac21905b0cc3c', 'ce51f896209341e3b73c43c41174d19e', '0402376e4d9e48a9b0ee12a2624d3b28');
INSERT INTO `role_user` VALUES ('dddf071db25f406e8635b14d0fe9a4d0', 'ce51f896209341e3b73c43c41174d19e', '98308c3fe9674365a8cb5942ce4b1487');
INSERT INTO `role_user` VALUES ('dde1dd8303194f3d92a19f2a7bc6819c', 'ce51f896209341e3b73c43c41174d19e', 'fa641326536d4917abf594925d4f5a57');
INSERT INTO `role_user` VALUES ('de39e6cb4b874f94ab8c45eae4a19886', 'ce51f896209341e3b73c43c41174d19e', 'cb03a8de61f2474ea44d054eff53415d');
INSERT INTO `role_user` VALUES ('df13d7fcbad44289bfa5d135985afe6a', 'ce51f896209341e3b73c43c41174d19e', 'f22c1744ab5e4f9f945581b12d2c441d');
INSERT INTO `role_user` VALUES ('dfb33aee5dfd4c0ea339f00472a77cbb', 'ce51f896209341e3b73c43c41174d19e', '1e3ac74c98934c81ba9a4df593b6b7ee');
INSERT INTO `role_user` VALUES ('dfbd5f80d22e495191860e60d645abb7', 'ce51f896209341e3b73c43c41174d19e', '667004423ad647fd970aec0f5328aa0b');
INSERT INTO `role_user` VALUES ('dff04ddeda3248d7ba77a6e87a0b0e2a', 'ce51f896209341e3b73c43c41174d19e', '4b8e947aeb8d48e7bbd6424daf0f97ae');
INSERT INTO `role_user` VALUES ('e04509d8f93c4220aca6df04010c3d23', 'ce51f896209341e3b73c43c41174d19e', 'a19a768ef11b40e5abe1fc590712fbf7');
INSERT INTO `role_user` VALUES ('e0875bbd980d4713a5a405b50748b144', 'ce51f896209341e3b73c43c41174d19e', '009e6bad70f145fe8c280b9d61fe4344');
INSERT INTO `role_user` VALUES ('e08c3466c91f4a75bbe28ccfb8f3affc', 'ce51f896209341e3b73c43c41174d19e', 'c03ce39a11034952ad84053169a7f6e7');
INSERT INTO `role_user` VALUES ('e09981c6840b4cfe94a532d5a64d3857', 'ce51f896209341e3b73c43c41174d19e', '1a96c8474ecb483f860bebd1a34b0b33');
INSERT INTO `role_user` VALUES ('e1c1a2edb9f248f1acb02f51fd83b43c', 'ce51f896209341e3b73c43c41174d19e', 'de949c54281c487ab4b9db8914ddb3ea');
INSERT INTO `role_user` VALUES ('e28e7e2644f4499bb8d94c64b2e39bfe', 'ce51f896209341e3b73c43c41174d19e', 'ecbed3a6f88b4f4e8e8485aa74b7a51c');
INSERT INTO `role_user` VALUES ('e388c1cad4b8497091558190bff905d8', 'ce51f896209341e3b73c43c41174d19e', '374ffbe2013f4e3dad06a29ebceec06d');
INSERT INTO `role_user` VALUES ('e3ae4b6338e6461cb26f8ee47a0c02bd', 'ce51f896209341e3b73c43c41174d19e', 'd7a39b9ca48a4e56aff8e5555aebd9e4');
INSERT INTO `role_user` VALUES ('e4268c8144cd421b8c2e09ed255e3dd4', 'ce51f896209341e3b73c43c41174d19e', '565314c714764af28917ff17663fd8ee');
INSERT INTO `role_user` VALUES ('e5978c63bed64e9598baf4ff7bda9a23', 'ce51f896209341e3b73c43c41174d19e', 'd068c8e3150a4e528cbe41bbff3e4d5a');
INSERT INTO `role_user` VALUES ('e5ce1a3dc1f0469fb4bda599aa79fb05', 'ce51f896209341e3b73c43c41174d19e', '56fd725c83d04abf93cbac34dd1705bc');
INSERT INTO `role_user` VALUES ('e5d47eccc8d940eb9755758a301421e4', 'ce51f896209341e3b73c43c41174d19e', 'f29d270a12ef4015846fd2c4b83c7a01');
INSERT INTO `role_user` VALUES ('e5e0cdddd4634756be8b7929c677cf42', 'ce51f896209341e3b73c43c41174d19e', '74435701fb5f4454bcbe8b834e1292d7');
INSERT INTO `role_user` VALUES ('e61cb9b0ff704efc909aad53c1448cbf', 'ce51f896209341e3b73c43c41174d19e', 'a34544c643e04a68bb8029b190363687');
INSERT INTO `role_user` VALUES ('e630ce9b7e114f0c8c0a996a8973a9cd', 'ce51f896209341e3b73c43c41174d19e', 'c9ec811ca13f43bc91b0c870c1f53a29');
INSERT INTO `role_user` VALUES ('e63381bae00a48c985fec408fc57d845', 'ce51f896209341e3b73c43c41174d19e', 'd1bc8ec617aa4499a7a774338f88a74a');
INSERT INTO `role_user` VALUES ('e6717608b95d42b7821a930fa63a1c01', 'ce51f896209341e3b73c43c41174d19e', '75ebefc4d9c84b778f00dbc43a011b27');
INSERT INTO `role_user` VALUES ('e6ec8c7037704533a575d2cb43b8af18', 'ce51f896209341e3b73c43c41174d19e', '48138840b1bb4f1fb6e7e0bea687af82');
INSERT INTO `role_user` VALUES ('e7d3c611b6de4d4e929a4951c0a52632', 'ce51f896209341e3b73c43c41174d19e', '9b6d9b2931a74924aa5b3b9e5ed27d8a');
INSERT INTO `role_user` VALUES ('e7e0377eb9714f30bff754c5d2606ae4', 'ce51f896209341e3b73c43c41174d19e', 'e4f3a630711046f0ae9ef6653ad807ee');
INSERT INTO `role_user` VALUES ('e83e3922ae8147bea1f1351d200846f8', 'ce51f896209341e3b73c43c41174d19e', '3d7f17a1f768422f97c0a5cfa862e9ed');
INSERT INTO `role_user` VALUES ('e8cec31a9b5d491888d2d24edd11c2d5', 'ce51f896209341e3b73c43c41174d19e', '61ef295131e54da395da20d8a2035364');
INSERT INTO `role_user` VALUES ('e9ab91be3fc446958306793147824195', 'ce51f896209341e3b73c43c41174d19e', '481106a194d1415ca29fa9f3ab0d15a9');
INSERT INTO `role_user` VALUES ('ea13c7595f1741e8af1cdeea80db747d', 'ce51f896209341e3b73c43c41174d19e', 'b4046ef493e44a3db2e9d102f0c7e094');
INSERT INTO `role_user` VALUES ('ea28da81788b4592be415c5404d68512', 'ce51f896209341e3b73c43c41174d19e', '6f1ecaaa77114f43b76e82edaba82adb');
INSERT INTO `role_user` VALUES ('ea86a08274064a41a66c8bc411b7ac4a', 'ce51f896209341e3b73c43c41174d19e', '0f842ca3180242989914735e24d6a5f0');
INSERT INTO `role_user` VALUES ('eb380653dfcb42aab6f5ea30c8c4308c', 'ce51f896209341e3b73c43c41174d19e', 'ceaad194b5a84cc4946c32c479a94055');
INSERT INTO `role_user` VALUES ('eb76f4f053af47e3a6b96377c9267478', 'ce51f896209341e3b73c43c41174d19e', '56222eaba68d43b18a7469edd7b7092e');
INSERT INTO `role_user` VALUES ('eb7d7ca6ccce4d5bbea0a0a8c8facc40', 'ce51f896209341e3b73c43c41174d19e', 'aa6c5f989c07448592864af0d33e8591');
INSERT INTO `role_user` VALUES ('ec23727fb22d48ac8f32639dc5c1fa5d', 'ce51f896209341e3b73c43c41174d19e', 'cfb4304d00ae45e9b228f19e23558644');
INSERT INTO `role_user` VALUES ('ec37d99d89814662ac83c1371bec02a1', 'ce51f896209341e3b73c43c41174d19e', 'bdf5b27511a44c3d99d146d5d70f5994');
INSERT INTO `role_user` VALUES ('ec938d634c50441eba159b0ed3d2c109', 'ce51f896209341e3b73c43c41174d19e', '09f98f44b19d4889bdc8709bdc315917');
INSERT INTO `role_user` VALUES ('ed02022f115a4007bc44a586e23b25fd', 'ce51f896209341e3b73c43c41174d19e', 'af08cec990ca48149f88aaa26425a02c');
INSERT INTO `role_user` VALUES ('ed467bad6ab7492384f69e752b142af3', 'ce51f896209341e3b73c43c41174d19e', '55e5568aa4a54b4f919d507cc872ade5');
INSERT INTO `role_user` VALUES ('edb96bf7badc4b2f9926dd9ad2924a43', 'ce51f896209341e3b73c43c41174d19e', 'ba3f80a3ddf8402eb012d204ff084cdd');
INSERT INTO `role_user` VALUES ('edda17960d3842aa9360b196825dff17', 'ce51f896209341e3b73c43c41174d19e', '9a9a5233ca8949c38804eedb5ecb8e9a');
INSERT INTO `role_user` VALUES ('eef9789ca39f425aa8e334053bf2f959', 'ce51f896209341e3b73c43c41174d19e', 'd3f244c424e74471840c298761dcfaf9');
INSERT INTO `role_user` VALUES ('ef1f76250c614bc59a722ae60b6460e4', 'ce51f896209341e3b73c43c41174d19e', 'eb9cd0a5df8945c8959d3fbd56f8afa1');
INSERT INTO `role_user` VALUES ('ef401be4e2f8453ba4aeaf227ea697a3', 'ce51f896209341e3b73c43c41174d19e', '86b5a91cbd714563984c490318c161dd');
INSERT INTO `role_user` VALUES ('f1cacd3898fb4daca70d630caa6ccbb5', 'ce51f896209341e3b73c43c41174d19e', '3890c6fab4e5410ba81b6cc4d7494f0a');
INSERT INTO `role_user` VALUES ('f1f50a4f0d6e467eaa43b38d0d9849f5', 'ce51f896209341e3b73c43c41174d19e', 'b114ad6c7e744acab8476ef467e71f69');
INSERT INTO `role_user` VALUES ('f1f8d80c4819484297eb84d0f523464e', 'ce51f896209341e3b73c43c41174d19e', '4a0579fcdc6c46bba1f59879cc264211');
INSERT INTO `role_user` VALUES ('f222d8a35b32432cbc4e77e5d69fec9a', 'ce51f896209341e3b73c43c41174d19e', 'cb110b48aed048bdb8f5bba484918c37');
INSERT INTO `role_user` VALUES ('f264807a198d47cb875dcc50391adfb0', 'ce51f896209341e3b73c43c41174d19e', '324139cfe7804681a80de3fe3139bfbd');
INSERT INTO `role_user` VALUES ('f2e4e0e60339493eb5ad9ddb847bc31d', 'ce51f896209341e3b73c43c41174d19e', 'fad46e5b81014e17b338b2e42d5a18ff');
INSERT INTO `role_user` VALUES ('f32ff986e06f4daca347d6bb4bcdfb6d', 'ce51f896209341e3b73c43c41174d19e', '7a9532024bff4cffa416c817fc95cfdb');
INSERT INTO `role_user` VALUES ('f3a12622326445249563348f7ac5c93d', 'ce51f896209341e3b73c43c41174d19e', '97dc845ec23c4db5be0b1edc470dac34');
INSERT INTO `role_user` VALUES ('f45b229f68744f678320f83f186e626b', 'ce51f896209341e3b73c43c41174d19e', '0ce7b49be8fd48348e9d840378a5d1b4');
INSERT INTO `role_user` VALUES ('f535aa9eb20f461f8bfaaf0461205792', 'ce51f896209341e3b73c43c41174d19e', '3ff13312783b4c4eb226c31206d94764');
INSERT INTO `role_user` VALUES ('f5ad076c8ec84fd883c6611d74f37607', 'ce51f896209341e3b73c43c41174d19e', '42e3f6e8c0e04a7abf3b824a70abf717');
INSERT INTO `role_user` VALUES ('f696e48630bf4a4c9f2c48dbca7b4840', 'ce51f896209341e3b73c43c41174d19e', '64217b9c09364dd7a81afec0c225fcd3');
INSERT INTO `role_user` VALUES ('f6ff9440e35f474d905a3728cd74e01e', 'ce51f896209341e3b73c43c41174d19e', 'caa7a07dddba40309a5e58b461354a96');
INSERT INTO `role_user` VALUES ('f8443aee7a5c414fb5d5362b34e7f3a0', 'ce51f896209341e3b73c43c41174d19e', 'adc7d51073cf431b974fa29bfeb9ada3');
INSERT INTO `role_user` VALUES ('f90e9180c2ac4d14987b35b7be2ca1eb', 'ce51f896209341e3b73c43c41174d19e', '97de5ae9b8224b8d98d0ff2ae369fe5b');
INSERT INTO `role_user` VALUES ('f9641d25e7194914b965e0101da6430c', 'ce51f896209341e3b73c43c41174d19e', 'd8b42c7dc71e4ceb8709897d9621028b');
INSERT INTO `role_user` VALUES ('f9d89e8bf94c40cb9fea706d4eead16d', 'ce51f896209341e3b73c43c41174d19e', '9c0622b25033431abaf11a78f26a1e76');
INSERT INTO `role_user` VALUES ('fa47c130a903416aa2773c8a67adfee5', 'ce51f896209341e3b73c43c41174d19e', '4936419467e24111b75d93577365aae1');
INSERT INTO `role_user` VALUES ('fb3f497fbe1b46769ef141ac3062fd67', 'ce51f896209341e3b73c43c41174d19e', '2d7ad9f368824c7992b8c09370b38f82');
INSERT INTO `role_user` VALUES ('fb6ff911ad5845909cc6e88de98678a7', 'ce51f896209341e3b73c43c41174d19e', '4ba58ae38b594ec2839f1c8660927b88');
INSERT INTO `role_user` VALUES ('fb71cf8c6f2e430798656f2b5ca8f1b5', 'ce51f896209341e3b73c43c41174d19e', '7642ffbae67b40a59252070f96997716');
INSERT INTO `role_user` VALUES ('fbd2f7178f4f4c18973be82282ed5cf8', 'ce51f896209341e3b73c43c41174d19e', '12839bde7eed4b0db1c58bad8c55cadb');
INSERT INTO `role_user` VALUES ('fbd888608819454a99fdcc8742c52d69', 'ce51f896209341e3b73c43c41174d19e', '776362f31a4b459fba4730229b38cafe');
INSERT INTO `role_user` VALUES ('fbe5ae6a07d747f5a78e5e95b0bbf97b', 'ce51f896209341e3b73c43c41174d19e', 'e1bb5be1341047f199f07e151cc89625');
INSERT INTO `role_user` VALUES ('fc321b763bf54d5fbad642bb6413e409', 'ce51f896209341e3b73c43c41174d19e', 'd4b155436ec74adfb262c1d6a98f6226');
INSERT INTO `role_user` VALUES ('fc430714c9b44286b732fcab7817cf15', 'ce51f896209341e3b73c43c41174d19e', '8c029f0962a94b8a881c3ce84b894add');
INSERT INTO `role_user` VALUES ('fc4cb55359cf4b278af1b0630ea9d492', 'ce51f896209341e3b73c43c41174d19e', 'b3ab5dd1c5e74bd89ebae81cf84defb2');
INSERT INTO `role_user` VALUES ('fdde2bb4169148ec9e3a3b23ec775e3a', 'ce51f896209341e3b73c43c41174d19e', '5156d7a0c0cf404184152be95ddc6c3e');
INSERT INTO `role_user` VALUES ('fe0700eef72b4308ba5fbf824b1ad50c', 'ce51f896209341e3b73c43c41174d19e', '6558857117724314807f31d66f6dfe48');
INSERT INTO `role_user` VALUES ('fe50fdf1cb3d49ce82640ec43a801006', 'ce51f896209341e3b73c43c41174d19e', '3149482f04ae4ac7b95e3973519a6ddb');
INSERT INTO `role_user` VALUES ('fe8022d0d7bf4ff5b781d68a2a5b1391', 'ce51f896209341e3b73c43c41174d19e', 'd39ef1c93be84accb8faebe815a30fc4');
INSERT INTO `role_user` VALUES ('ff8d03b810d74756ae92ac5e0bf7a1fa', 'ce51f896209341e3b73c43c41174d19e', 'f7bb4a83c29e4897b5cc10db767c69a6');

-- ----------------------------
-- Table structure for `school_info`
-- ----------------------------
DROP TABLE IF EXISTS `school_info`;
CREATE TABLE `school_info` (
  `id` varchar(100) NOT NULL,
  `name` varchar(100) default NULL,
  `code` varchar(50) default NULL,
  `typeId` varchar(100) default NULL,
  `categoryId` varchar(100) default NULL,
  `seq` int(11) default NULL,
  `unitId` varchar(100) default NULL,
  `isDeleted` char(1) default NULL,
  `creator` varchar(100) default NULL,
  `createdate` varchar(23) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of school_info
-- ----------------------------
INSERT INTO `school_info` VALUES ('1', null, null, null, '**asasdfghasdfgh', null, null, null, null, null);

-- ----------------------------
-- Table structure for `teacher_info`
-- ----------------------------
DROP TABLE IF EXISTS `teacher_info`;
CREATE TABLE `teacher_info` (
  `id` varchar(100) NOT NULL,
  `userId` varchar(100) default NULL,
  `schoolId` varchar(100) default NULL,
  `name` varchar(50) default NULL,
  `sex` char(1) default NULL,
  `raceId` varchar(100) default NULL,
  `partisanId` varchar(100) default NULL,
  `idcard` varchar(18) default NULL,
  `telephone` varchar(15) default NULL,
  `address` varchar(200) default NULL,
  `qq` varchar(15) default NULL,
  `wechat` varchar(100) default NULL,
  `zkxdId` varchar(100) default NULL,
  `zkxkId` varchar(100) default NULL,
  `fkxdId` varchar(100) default NULL,
  `fkxkId` varchar(100) default NULL,
  `createdate` varchar(23) default NULL,
  `creator` varchar(100) default NULL,
  `isDeleted` char(1) default NULL,
  `card` varchar(10) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher_info
-- ----------------------------
INSERT INTO `teacher_info` VALUES ('00317770ebde4c37ad40fb60f5fd068d', 'e9b952b4587c45abb7346a22538fbab7', '7af7012dc4644a049045d32c0f0bd839', '曾凯虹', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350824199108290026', '18850582203', null, null, null, '9e9d2a20e2e94c81afa9501b2509f981', '91e448e7a283442592fe0e09df2f7536', null, null, null, null, '0', null);
INSERT INTO `teacher_info` VALUES ('015538f2daa2403098a0f8c3371202b0', 'd2c267afd23d4592916146a7589db250', '8a3ef695e7524bf1964532cd2a197712', '杜娟', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '420922199106140041', '18459264703', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', '1df544b4e2834eaf97803c51fae7368f', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('04c07692fa6b4150a2b2741b056f2c1a', 'ce498490d4204f92ac95a2367d983ed1', '715297a51a3e4e34a29a2f7be2543843', '苗永丹', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '350427198903050024', '13850826042', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '86879dfc63ea4e49a0c71b8c78aa4d4b', null, null, '2016-01-13 11:47:55', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('079d38c48b94412ba6f2cb7aed3200b6', 'a6820011f7c841969e6b58700a76ddd6', 'ce4b08939a4b4f0282eda631aea02a31', '郭志贤', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350629198005041023', '18120762109', '', '', null, '5ddf22229e5c4ceba31e0f84a5f77a04', '4eba1c17815e4d70bb26155cfd08d008', null, null, '2016-01-13 11:47:55', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('0a206081f6f74cf6b8f6e73e4a4126dd', '28ce79b597fd4c1981524dc65c81bc66', '8a3ef695e7524bf1964532cd2a197712', '陈智坚', '1', '0736efcbffc14d558c1f5d62b7748bdc', null, '350206198910072018', '15985848885', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', 'a3dd479888294110897b522bbdcbb0f3', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('0eff6353f18c4d2eb720839f5365eb5b', 'ab2ab29f57c5440d8fde2a9abc81d74f', '095dde26e77c405bb1e24129794ea2f2', '江甜', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '340828199003243000', '15159237348', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', '3581c96657694fb78dba835ddb175384', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('12b2a12b95d94f40b48f871b8036f7ee', '6299ee5df3e24a9a90f3f0b291b0774e', '8a3ef695e7524bf1964532cd2a197712', '李岩', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '22020419930606302X', '15604323757', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', 'a3dd479888294110897b522bbdcbb0f3', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('134d89f33ef64172916cfaafda184d87', 'f4f7f3ac43a3489e9eb115b707035dc7', '69856c57d29448fba7557bb0bd066222', '徐欢欢', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350681199101031108', '15980760653', '', '', null, '5ddf22229e5c4ceba31e0f84a5f77a04', '4eba1c17815e4d70bb26155cfd08d008', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('13cae959d2c64589bf23f94e47bccdba', '262e25951add4091bb86c3504d87ece5', '8a3ef695e7524bf1964532cd2a197712', '陈佳琦', '1', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '35021219871118003X', '15880255715', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('163cc2f33b5847b38ea972401aa5a569', '81716d731b1841b2a313b80cde07041d', '7af7012dc4644a049045d32c0f0bd839', '丘晓芳', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350823198707174923', '18659276376', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('17812e3d26a84daba20c35fedc91dbee', 'f099244c6ec947008669ea9fedb4589d', 'dc402aa598e441b7aed6aefe6ce39ce4', '魏秋霖', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350128199210085528', '18850560832', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '7353a169c3a44a508002d9103c0c868d', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('18b6db99f7f34c939072225471043139', '32928ca42a3f469287eef80e0ef58992', 'a036677ec60d438e97fe54144dff7f78', '李春敏', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350600197905030525', '18064460906', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('1afec74fa0e7459188455740efe918c6', '36aef5822c6244268df19b884663b283', '8a3ef695e7524bf1964532cd2a197712', '李日松', '1', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '370782198901093076', '15080304393', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', 'ec786d68d9414af4b33cc5d66be5466e', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('1bb8e36d17da4208a2d202f0cc5a6c12', 'd45ee888e6f44f949c2466ff622a68c0', '398fde1e08aa4fcba247b920fa187ffa', '连丽美', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350322197811145120', '13860487923', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '86879dfc63ea4e49a0c71b8c78aa4d4b', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('1bf7ff548c174bf8b599c3ca434b1c33', '14addd23875349f7909bdf1aa6c3aa88', '8a3ef695e7524bf1964532cd2a197712', '林惠兰', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '350628198809022040', '17750669701', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '21270ba66aaa4d57a535db9f64306426', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('1dcddd0e159c4b558339dc0e96346041', 'a8618c938ca64704b45702f7f8eaed9e', '1d49f6195dc6450794bb667db3b5d63b', '陈韶娟', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350628197510290000', '15306007449', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '583dfea38bbe4801aba866170d155f57', '9e9d2a20e2e94c81afa9501b2509f981', 'da8011d67ec74a01beef7c6043de450c', '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('229799ab07c64edcab110052c8aec85f', 'd9c393eb678c41848d739c3bb2dd3148', '715297a51a3e4e34a29a2f7be2543843', '方晓凡', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '350523197504261321', '18950189155', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '91e448e7a283442592fe0e09df2f7536', '9e9d2a20e2e94c81afa9501b2509f981', '2e96280642d84076832a6fddaead50f7', '2016-01-13 11:47:55', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('26d1a4cfa9ed4cf2baa62425527e2f76', '9771e2069f59406c90b351c36b86a22a', '6097e232161c4bf6961cf946bb8fe805', '叶  璐', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350123198803080000', '13720889953', '一年段', '美术', null, '9e9d2a20e2e94c81afa9501b2509f981', '86879dfc63ea4e49a0c71b8c78aa4d4b', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('27ece220a3cd4cff848e332dbcd0a830', '3d23737176a642d59fee5326a7e0f195', '41fa7688e49c41b4bbf9131bed79f672', '程娴', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350481199212250521', '18750204186', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '7353a169c3a44a508002d9103c0c868d', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('2bed786f0db44c4bb2857f001302c120', '95f74540dbc14df0abb8d01b76383bde', 'a036677ec60d438e97fe54144dff7f78', '林清铃', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '35068119861122102X', '15959600319', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('2cae55af9be844d78b5735ee07e66903', '51e9b4b54da543fd99cf498ac55e7ae4', '6097e232161c4bf6961cf946bb8fe805', '周灵敏', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '35092419930607002X', '15259500155', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', '9e9d2a20e2e94c81afa9501b2509f981', '86879dfc63ea4e49a0c71b8c78aa4d4b', '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('2e6e5b7997fe4597ad8acf3af34988ef', '5204a7ca0b8245a29a467fba8a8cd9eb', '398fde1e08aa4fcba247b920fa187ffa', '孙玲玲', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350211199109053028', '18959260921', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '583dfea38bbe4801aba866170d155f57', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('32f920a6d2374276a6ceb27b1c9039cf', 'dbe2fc6d341b43bb811829bd5263ce45', '6097e232161c4bf6961cf946bb8fe805', '李丽瑛', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350824199002240047', '13306040032', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '21270ba66aaa4d57a535db9f64306426', '9e9d2a20e2e94c81afa9501b2509f981', '2e96280642d84076832a6fddaead50f7', '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('336c1f7f509f49bb8fbea232b54efdbd', '091f986b51024a2eabca8cbf5f88cd6c', '715297a51a3e4e34a29a2f7be2543843', '杨丽萍', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350625197706030028', '18750949966', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', '9e9d2a20e2e94c81afa9501b2509f981', '86879dfc63ea4e49a0c71b8c78aa4d4b', '2016-01-13 11:47:55', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('35ddbf8b00204f1d8f37f82241afd19a', 'dbd5b2c483ec48ba90c2bb3866d6a553', '095dde26e77c405bb1e24129794ea2f2', '付成雪', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '22012219880823400', '18259226590', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', '13c5f255e43a48a285126668d89a45e1', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('384fe8e5c4414ef69bd4a6e8f8fa3176', 'f5a3e9353743424fb5798501e12a8cf6', '3a3127a2a54143cf8d7446d60d4b83e2', '汤秋诗', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '352230199210062149', '15659816470', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '86879dfc63ea4e49a0c71b8c78aa4d4b', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('3a34d009ec3f4fea9ae9e86bd05699a5', 'b26cb4fec3944660bf6307967b3d9146', '8a3ef695e7524bf1964532cd2a197712', '谢雨丽', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '140123198908057048', '15105996463', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', '13c5f255e43a48a285126668d89a45e1', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('3fe7f3043707471ba027c45afc87cee8', 'c62a810b55ea4bde982403eb0ec65b2e', '715297a51a3e4e34a29a2f7be2543843', '杨玉婷', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350205199306121029', '18250761801', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', null, null, '2016-01-13 11:47:55', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('4e474e40a3f4429eb29b25b46ab03883', 'a766e60aecde4f85b8b75614195e692b', '53a83fd979244e1f89817578acb9760f', '林燕', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350204199303122046', '18059257967', '', '', null, '2bdfe481999e4ea0a1102076eb08dc76', '13c5f255e43a48a285126668d89a45e1', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('4f1bb4674bd645a0b131937bc4f0100a', 'cd206beb50f147fba71fcac9f6173552', '6097e232161c4bf6961cf946bb8fe805', '柯文雅', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '350205199302233525', '15805940223', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', '9e9d2a20e2e94c81afa9501b2509f981', '86879dfc63ea4e49a0c71b8c78aa4d4b', '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('579879f3be6b48dfb57ed51ec40ce3ac', '83f70ed77ab940a2a4c8693c6d8cdd38', '095dde26e77c405bb1e24129794ea2f2', '信琴琴', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '14262198906144726', '18859658182', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', 'ec786d68d9414af4b33cc5d66be5466e', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('58302b4afc6544c1be8b6a636cb36cfc', '63adbd4755f14d43ba37c7685b564e0a', '62b8b24b2c494c1b96d99fb67dfd983c', '颜雅恩', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350205198509182521', '13695014253', '', '', null, '5ddf22229e5c4ceba31e0f84a5f77a04', '4eba1c17815e4d70bb26155cfd08d008', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('5c8990b310f647a7b8842e6810e0dea7', 'c7bff0e443274a4099dfbaa57443b3da', '8a3ef695e7524bf1964532cd2a197712', '郭碧微', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '420116199203050063', '15859206095', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', '13c5f255e43a48a285126668d89a45e1', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('5fda5fc575814287beff7df3b0387628', 'fb878193b2144cbca55ef46259c479ba', '095dde26e77c405bb1e24129794ea2f2', '徐瑶瑶', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '362331198805133929', '18850563220', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', 'e98b4f5b28d54d8db9e1eb8d78701322', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('61976ac863594373ba0746f513c858d2', '12ed3cdbb03e42cca1f86bd69c5e0eab', '095dde26e77c405bb1e24129794ea2f2', '申琛', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '421102199008250505', '15871413553', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', '13c5f255e43a48a285126668d89a45e1', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('61a505e9ec1b4c3a92a31aea6aba4ac7', 'f3183830b0c54f38b83ce2abed78211e', '53a83fd979244e1f89817578acb9760f', '黄佳蔚', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '230405199110170623', '15985806431', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', '1df544b4e2834eaf97803c51fae7368f', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('665140f3a59c43228d41f107ba5fc4ab', 'fcdec8c396444163ae0b6dc8a455c5ea', '8a3ef695e7524bf1964532cd2a197712', '杜蕊', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350430199301030029', '15960380356', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('6a65a2f693a94b758d98d0fbbf545597', 'd9ca90982484440f8bf828474939d459', 'd95cbb0855b14638bc647090eac5d913', '方晓萍', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350622199208030025', '18850223768', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '6279cdc2ac5d4dbc97dcf300e51d384e', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('6abe9f1db5ad4738bc732b62ce75ccad', '9b9efa4209ae418a9f2bbb701b6a027b', '715297a51a3e4e34a29a2f7be2543843', '于艳', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '210882198912121221', '18359215260', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', '1df544b4e2834eaf97803c51fae7368f', null, null, '2016-01-13 11:47:55', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('6fbb811756a14d83b494e9e1325acedf', 'f4d3fec29e904b39bd5e11e169b372ba', 'e0e4a99ece4343f889c48316b5928814', '周艺婷', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350524198912203068', '18359811655', '', '', null, '5ddf22229e5c4ceba31e0f84a5f77a04', '4eba1c17815e4d70bb26155cfd08d008', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('77aab57958ad407bb9be8c4af9817a01', '79b8fb9c3bf54bb7b6a361ebf8c5efcc', '8a3ef695e7524bf1964532cd2a197712', '卢溢红', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '350681198702130027', '15160502858', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('77b5d12d8dd64e069021e0d03f15692a', '2476f88b4855495cb249594dcf4341f5', 'e3af6af2e02b4833999e35cd5113f0fc', '班主任', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '352602197602060019', null, null, null, null, null, null, null, null, '2016-01-13 11:51:18', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('7c49c5937f0c49dfb7a20ed305164b9a', '5614ccf2ebac49228524ea875ec683c9', '8a3ef695e7524bf1964532cd2a197712', '范眉云', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '352123197312115020', '15960225972', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '6279cdc2ac5d4dbc97dcf300e51d384e', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('81bcefe6accd48e1a2f9ea96d4687244', 'a75d5d1e8e6f4c97aa279df77d85578c', '8a3ef695e7524bf1964532cd2a197712', '周丽娜', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '350783199010180229', '18750923117', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', 'f9c53e590692430aaa7dd1f0a4607ef2', 'b34a3fb4bbbb4590a29dfb11aa98996e', '99d9eebda0e74ad2badc27b3afc2dcc1', '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('8845bbdd64ad487fa61dbf1f72774981', '9077e871084046928cd3602029fba0f9', 'ce4b08939a4b4f0282eda631aea02a31', '杨佳雯', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '350205199308190028', '15060883280', '', '', null, '5ddf22229e5c4ceba31e0f84a5f77a04', '4eba1c17815e4d70bb26155cfd08d008', null, null, '2016-01-13 11:47:55', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('89e20d1672c74c8b936414ff580b6243', 'bb4d656f0d69454fa1064e77073492c9', 'a036677ec60d438e97fe54144dff7f78', '陈琳 ', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '450111198801131524', '18259209753', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', 'a3dd479888294110897b522bbdcbb0f3', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('8ccc73b9765f46789ecacb74bf5b8818', '823d9a86d45f4b53bf7b5017ab67e9af', 'a036677ec60d438e97fe54144dff7f78', '蔡梓媚', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350205199211012022', '15860790120', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '91e448e7a283442592fe0e09df2f7536', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('8d48fec5178f433ea79fc8f0a4ee6fe8', 'e0121161ff00484aa436a3a7d4fda98d', '7a9e529ad1844dfc8c1bc5a8725b51c8', '孙艺菲', '0', '55a0b6cb5ecf4a74913568543a8bc3f6', null, '220323199005250467', '15159268234', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', '13c5f255e43a48a285126668d89a45e1', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('8dfd992418924e87a2559fea0900547c', '7c1343cc590f48fea3d2da9fe6817940', 'e93a20da5c1d43ed830ea696eb78f686', '叶光桦', '1', '0736efcbffc14d558c1f5d62b7748bdc', null, '35042619901106551x', '18959298677', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', 'a3dd479888294110897b522bbdcbb0f3', null, null, '2016-01-13 11:47:55', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('8fb608179f224f4181bd706bc4cac03f', 'd8450cdb94ca42ad83ed253701c9b4fc', '53a83fd979244e1f89817578acb9760f', '陈进中', '1', '0736efcbffc14d558c1f5d62b7748bdc', null, '350628199211223512', '13860446827', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', '1aee79eb0e8a4d6d86fef100e5aac805', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('900fd1c9d4374e9bbc17d633d447d9fb', 'd9457510ad19404498555c43734c8dc3', 'd95cbb0855b14638bc647090eac5d913', '陆声明', '1', '0736efcbffc14d558c1f5d62b7748bdc', null, '450881198510280930', '15859205725', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', 'a3dd479888294110897b522bbdcbb0f3', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('929f0b27c92f4681b4536ba5cec8b32e', '4d638e896c814cea8b7d5c5fae45b0d9', '6097e232161c4bf6961cf946bb8fe805', '李欣欣', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350205199206242042', '18850239750', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '91e448e7a283442592fe0e09df2f7536', '9e9d2a20e2e94c81afa9501b2509f981', '2e96280642d84076832a6fddaead50f7', '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('94f7a3891b784fcea0f57b962958a598', 'efa6916dec3d4d1cbe309b1a17ecf5f1', '8a3ef695e7524bf1964532cd2a197712', '张婕', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350425198901180068', '18650026107', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '583dfea38bbe4801aba866170d155f57', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('979aee99fe3b484e873ddf87b11e1cfb', '2fc50269990a424aa17d9bc06a41465a', '8a3ef695e7524bf1964532cd2a197712', '李俊', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '511302198303160041', '18030095031', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', 'ec786d68d9414af4b33cc5d66be5466e', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('987873c302824864a54962ab667fff08', 'c8672f3ba28743f3a7d94e054c4be8ba', '398fde1e08aa4fcba247b920fa187ffa', '罗佳璐', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350783198812200000', '18950109255', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('9d37e71c9823459b9206fbb6f6c598d8', 'a6e7d28f2afc4c9ab96366197fa8c4b6', '8a3ef695e7524bf1964532cd2a197712', '叶平宝', '1', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '35058319910720891X', '18759266054', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', '961049bb29e349a4969500e6e5360c82', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('9d38fe06359342f48bef018db72b7f54', '48c686ddce0249d68527153a9d1e9b40', 'dc402aa598e441b7aed6aefe6ce39ce4', '林毅娜', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350205199203013041', '15980769984', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '91e448e7a283442592fe0e09df2f7536', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('a361846973824cc99bad1fe4e3cc9808', '1f8cb5a74b5c4157ada492d112868074', '715297a51a3e4e34a29a2f7be2543843', '姚秀玉', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '350622199105150067', '13600725606', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', '9e9d2a20e2e94c81afa9501b2509f981', '86879dfc63ea4e49a0c71b8c78aa4d4b', '2016-01-13 11:47:55', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('a5a6631fca4b4de7b6675a30ec317585', '5bec19d4b13e4df385698cf5f1d98251', '3f04124f60234b7fad704494ecb0e7d6', '林春萍', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '350500197208201000', '13959832377', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('a9a1977952b64e88a352a8272f91ace2', '11d6744f79bf46a29885022c6b0006fc', '8a3ef695e7524bf1964532cd2a197712', '林丽娜', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '350322198709130023', '13400675860', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', '1df544b4e2834eaf97803c51fae7368f', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('ac55c5dfc1b54beba2b61b65078ce089', '8b3767b44f534ba89545a9bb7e640e73', '8a3ef695e7524bf1964532cd2a197712', '陈婷', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '350622199202130041', '18850561736', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('adb54c0d7cf54bf9ad89e7a9cbb99e1f', '8a1e518a2bba4512b300f01e4f87d642', 'a036677ec60d438e97fe54144dff7f78', '吴其左', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350725199107214014', '15606906660', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', '9e9d2a20e2e94c81afa9501b2509f981', 'da8011d67ec74a01beef7c6043de450c', '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('b1a7b07d650e4a309a1c40eb29d421e0', '11b2557dce644d63bae1152410e98c46', '715297a51a3e4e34a29a2f7be2543843', '毛佳玲', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '362423199111040621', '15260201182', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', '13c5f255e43a48a285126668d89a45e1', null, null, '2016-01-13 11:47:55', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('b583dd763ef34c50a0951cc27e8b692a', '376c254a1208438c8f4ed323bbd0a619', 'fff55931933d4378abcf2fc9b0f8200c', '俞韵', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350722199404180026', '15059495818', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '583dfea38bbe4801aba866170d155f57', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('bc703e15a4234ee88688bea8d08ff93d', '6ca3a8e7b9ba45379ebf6aa00218002f', 'ad5b4792dfad45e897d90a5f3df47d72', '戴幼娟', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350623198207161025', '15960635917', '', '', null, '5ddf22229e5c4ceba31e0f84a5f77a04', '4eba1c17815e4d70bb26155cfd08d008', null, null, '2016-01-13 11:47:55', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('bde73acc10b34224b66adef4ef794557', '1bfbe1772236462882bf9296d0cc0488', '3f04124f60234b7fad704494ecb0e7d6', '翁圆', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '352227198910201000', '13609515290', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '6279cdc2ac5d4dbc97dcf300e51d384e', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('c39c5db3412f472a95cd6ae30e2e0976', 'bf2e47192f7347768e63eccf7b0302e0', 'a036677ec60d438e97fe54144dff7f78', '罗佳宇', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '352202199305050129', '18559228314', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '583dfea38bbe4801aba866170d155f57', '9e9d2a20e2e94c81afa9501b2509f981', '86879dfc63ea4e49a0c71b8c78aa4d4b', '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('c4082c28721746bc8f6b5190f55f63b1', '6bdcdd6142964dce90f9042c6e902da4', '1e82e33c01d143599ca8a2103f7cc991', '陈林丹', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '35230199204100022', '15606925603', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '583dfea38bbe4801aba866170d155f57', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('c74a9ef4aa9b4cd9bf26abc14fd36e08', '5aa4e9069d054a5fbec0cfd4c3b0e6c5', '3f04124f60234b7fad704494ecb0e7d6', '陈巧君', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '35020519911012910', '18050121908', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '6279cdc2ac5d4dbc97dcf300e51d384e', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('d29930f8fe234e719672f68150e70fae', '76842a711c914aeca7ddb4bae29fdd4a', '095dde26e77c405bb1e24129794ea2f2', '林琳', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '220581199309061205', '18250764150\n', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', 'a9ad5c2748c94da188567e8d3c7dc305', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('d589d07ab31f4f76b459de0c8f368aba', 'f05ac3ba38c94f949f35414e30736bd3', '6097e232161c4bf6961cf946bb8fe805', '丁云苑', '0', '8f5f5af7b7ee47dcb1b6bf615524bb4f', '2755fa3f1ef749c3a2bef8a00aa4de43', '350203199107023028', '15060773053', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '7353a169c3a44a508002d9103c0c868d', '9e9d2a20e2e94c81afa9501b2509f981', '6279cdc2ac5d4dbc97dcf300e51d384e', '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('d5a0cdfaae594125b7de403b962d8123', '00eef7cb4c9b4675a00c78f070138de0', '6097e232161c4bf6961cf946bb8fe805', '陈桂虹', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '359001197605190529', '13850850989', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', '9e9d2a20e2e94c81afa9501b2509f981', '86879dfc63ea4e49a0c71b8c78aa4d4b', '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('d84eba72bfb84e82bc3dd5d808d8742a', 'df4741cefd3042f38e79acb8c4ff8bf8', 'a036677ec60d438e97fe54144dff7f78', '郭晶晶', '1', '0736efcbffc14d558c1f5d62b7748bdc', null, '350681199208281107', '18850588627', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('d9e09bfbb59942d0958a22c71d94a825', '337f6c0ec7b040d79b2135174a2bd7f7', 'fff55931933d4378abcf2fc9b0f8200c', '赵霏霏', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350403199004200045', '18150387320', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '86879dfc63ea4e49a0c71b8c78aa4d4b', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('db010960b18b4385bd7af25a570f0ad4', '51633eeae6884bbaaa573838c38d0e8b', '7a9e529ad1844dfc8c1bc5a8725b51c8', '江静怡', '0', '0736efcbffc14d558c1f5d62b7748bdc', '2755fa3f1ef749c3a2bef8a00aa4de43', '350723198908050040', '15960819692', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', 'a9ad5c2748c94da188567e8d3c7dc305', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('dbde107e72464faf9c5eb87a229d060e', 'd862340b2455434ead47a32c974bdd5c', '398fde1e08aa4fcba247b920fa187ffa', '郑慧娟', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350430198902051000', '18759220583', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '91e448e7a283442592fe0e09df2f7536', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('e20c4462998047e58df06086fea23643', '797bf02e8b5944fabc2aa779857b80df', 'ad5b4792dfad45e897d90a5f3df47d72', '张桂如', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350221197708056021', '15160737003', '', '', null, '5ddf22229e5c4ceba31e0f84a5f77a04', '4eba1c17815e4d70bb26155cfd08d008', null, null, '2016-01-13 11:47:55', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('e3e75c92d2a544daa2997f1ffd142c4a', '550fa93739d647bab83735f09091c8ab', '715297a51a3e4e34a29a2f7be2543843', '秦天', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '152801198906140626', '18259425200', '', '', null, 'b34a3fb4bbbb4590a29dfb11aa98996e', 'ef807a340e044440b36cceb76777ea63', 'b34a3fb4bbbb4590a29dfb11aa98996e', '3581c96657694fb78dba835ddb175384', '2016-01-13 11:47:55', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('e502b0ccd0f94eea962e8f282c5e92a2', '99b1d48fae1e4b6c970102ecca839168', '398fde1e08aa4fcba247b920fa187ffa', '冯艳', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '420221197007260000', '13599914612', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('e62454d7c1364687a359c61467cad575', 'f4b2334bb6554a2e9864fcf8ac51ed65', '715297a51a3e4e34a29a2f7be2543843', '吴颖颖', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '330325198210120446', '15305779529', '15305779529', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '91e448e7a283442592fe0e09df2f7536', '9e9d2a20e2e94c81afa9501b2509f981', '7353a169c3a44a508002d9103c0c868d', '2016-01-13 11:47:55', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('f33dea578e884799bd4796b4dd02b5f6', 'eb075b8a50b6426886ff9620f8a9b963', 'ad5b4792dfad45e897d90a5f3df47d72', '沈美容', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350521198210087585', '13559480027', '', '', null, '5ddf22229e5c4ceba31e0f84a5f77a04', '4eba1c17815e4d70bb26155cfd08d008', null, null, '2016-01-13 11:47:55', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);
INSERT INTO `teacher_info` VALUES ('fb94ff53b7414a0a825050486e954042', '838bb2e9160c485a8f8e1e60236d8570', 'a036677ec60d438e97fe54144dff7f78', '王婷婷', '0', '0736efcbffc14d558c1f5d62b7748bdc', null, '350627199301113521', '18759282045', '', '', null, '9e9d2a20e2e94c81afa9501b2509f981', '36b5f8619e31461c8a8701cf0ff6cfe7', null, null, '2016-01-13 11:41:30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '0', null);

-- ----------------------------
-- Table structure for `time_setting`
-- ----------------------------
DROP TABLE IF EXISTS `time_setting`;
CREATE TABLE `time_setting` (
  `id` varchar(100) NOT NULL,
  `beforeClass` int(11) default NULL,
  `afterClass` int(11) default NULL,
  `beforeFinishClass` int(11) default NULL,
  `afterFinishClass` int(11) default NULL,
  `absenteeism` int(11) default NULL,
  `creator` varchar(100) default NULL,
  `createdate` varchar(23) default NULL,
  `isAfterClassPunch` char(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of time_setting
-- ----------------------------
INSERT INTO `time_setting` VALUES ('57cb702559ce44b38d190968eac2aced', '20', '5', '2', '20', '30', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-14 14:42:18', '1');

-- ----------------------------
-- Table structure for `unit_info`
-- ----------------------------
DROP TABLE IF EXISTS `unit_info`;
CREATE TABLE `unit_info` (
  `id` varchar(100) NOT NULL,
  `pid` varchar(100) default NULL,
  `name` varchar(100) default NULL,
  `isEdb` char(1) default NULL,
  `seq` int(11) default NULL,
  `isDeleted` char(1) default NULL,
  `creator` varchar(100) default NULL,
  `createdate` varchar(23) default NULL,
  `code` varchar(50) default NULL,
  `type` char(1) default NULL,
  `typeId` varchar(100) default NULL,
  `categoryId` varchar(100) default NULL,
  `flag` varchar(50) default NULL,
  `pflag` varchar(50) default NULL,
  `userId` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of unit_info
-- ----------------------------
INSERT INTO `unit_info` VALUES ('00d1c489a89042debd3fb5f2e3fd4b1d', '470b3d0f1c79426b90024450573dd72b', '海沧区绿苑幼儿园', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCYEY00002', '2', '48f92f5aea864ef19520dc279b71d3dc', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '904a6b3beca4457d9dfb167d4e8e5e83');
INSERT INTO `unit_info` VALUES ('05fe0bb545cf4bd8b6df85cb148c8e40', '470b3d0f1c79426b90024450573dd72b', '厦门海沧延奎小学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:05', 'XMHCXX00001', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', 'beab6488a225454cac2bcab18b4a2331');
INSERT INTO `unit_info` VALUES ('0810647f9dd24265ab3e72163dd70ef2', '0b3d8f5b55cf48f78a3825cfe354fec0', '蔡塘中学', null, null, '0', '5a71bf1ef06a4bd8b8e361c7ea3d71b2', '2015-08-12 10:20:47', '123456', '2', 'f55c0462da414c12bae6192a91c45044', '18d1fd3f6da44bfdb887379b92e7be06', '102106102', '102106', '67726193cca64a9bb8b3d6fbc7630026');
INSERT INTO `unit_info` VALUES ('095dde26e77c405bb1e24129794ea2f2', '470b3d0f1c79426b90024450573dd72b', '华中师范大学厦门海沧附属中学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCZX00004', '2', 'f55c0462da414c12bae6192a91c45044', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '2348ba148df14098b2029a259ec86db2');
INSERT INTO `unit_info` VALUES ('0b3d8f5b55cf48f78a3825cfe354fec0', '470b3d0f1c79426b90024450573dd72b', '测试教育局', '1', null, '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-10 11:36:59', '1', '1', null, null, '102106', '102', '5a71bf1ef06a4bd8b8e361c7ea3d71b2');
INSERT INTO `unit_info` VALUES ('1384cabae34d4f5fb1a2f19a4fc0bff8', '0b3d8f5b55cf48f78a3825cfe354fec0', '测试下级', '0', null, '1', '5a71bf1ef06a4bd8b8e361c7ea3d71b2', '2015-08-10 12:14:43', '1', '1', null, null, '102106100', '102106', '1e3ac74c98934c81ba9a4df593b6b7ee');
INSERT INTO `unit_info` VALUES ('1d49f6195dc6450794bb667db3b5d63b', '470b3d0f1c79426b90024450573dd72b', '海沧区锦里小学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCXX00012', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', 'd39746fab0354f92b32add4936701729');
INSERT INTO `unit_info` VALUES ('1e04b288705540edbeb1e7c392f03557', '470b3d0f1c79426b90024450573dd72b', '海沧区洪塘小学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCXX00009', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '8177eb904f62437fb07e843ef2e93caa');
INSERT INTO `unit_info` VALUES ('1e82e33c01d143599ca8a2103f7cc991', '470b3d0f1c79426b90024450573dd72b', '海沧区贞岱小学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCXX00010', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', 'a21a2b65cab04df0976c9161fcc7ef3e');
INSERT INTO `unit_info` VALUES ('2f26dd700d044eefb865c41a33f5bf91', '470b3d0f1c79426b90024450573dd72b', '厦门思明区实验幼儿园', null, '1', '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-19 16:52:36', '10001', '2', '48f92f5aea864ef19520dc279b71d3dc', '18d1fd3f6da44bfdb887379b92e7be06', '102111', '102', 'd7e3b1f9e4e949708c6522affe810f5c');
INSERT INTO `unit_info` VALUES ('372a981ec514494db737a4e06efaa82d', '470b3d0f1c79426b90024450573dd72b', '海沧区东瑶小学 ', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCXX00007', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', 'f0cf74d87008410fb392c8d6792eacb9');
INSERT INTO `unit_info` VALUES ('398fde1e08aa4fcba247b920fa187ffa', '470b3d0f1c79426b90024450573dd72b', '海沧区霞阳小学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:18:43', 'XMHCXX00016', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102107', '102', 'c53815ecba78427b8fbf2f1308890841');
INSERT INTO `unit_info` VALUES ('3a3127a2a54143cf8d7446d60d4b83e2', '470b3d0f1c79426b90024450573dd72b', '海沧区鼎美小学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCXX00005', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '684a0c09ef6d47c6b60c204f4223303b');
INSERT INTO `unit_info` VALUES ('3f04124f60234b7fad704494ecb0e7d6', '470b3d0f1c79426b90024450573dd72b', '海沧区天心岛小学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:05', 'XMHCXX00003', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '31eb840e9c414387902f49c7e1796de6');
INSERT INTO `unit_info` VALUES ('41fa7688e49c41b4bbf9131bed79f672', '470b3d0f1c79426b90024450573dd72b', '海沧区钟山小学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:21:28', 'XMHCXX00018', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102109', '102', 'ec00eb3c71674b7aa1803b09c306e697');
INSERT INTO `unit_info` VALUES ('470b3d0f1c79426b90024450573dd72b', null, '厦门市海沧区教育局', '1', null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-10 10:02:44', '343500', '1', null, null, '102', null, '29c802a592584b0f8b373a25316c7ea0');
INSERT INTO `unit_info` VALUES ('4af1c54217e14b009f990e3dc7631f4f', '0b3d8f5b55cf48f78a3825cfe354fec0', '测试小学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 11:28:32', 'cs', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102106101', '102106', 'a45e6958da5347d4bf4e5c01ea809ce6');
INSERT INTO `unit_info` VALUES ('53a83fd979244e1f89817578acb9760f', '470b3d0f1c79426b90024450573dd72b', '厦门市海沧中学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCZX00002', '2', 'f55c0462da414c12bae6192a91c45044', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '485b0b0feee747f7a27bf53e9d2eca25');
INSERT INTO `unit_info` VALUES ('5f719eb8b2404e34b6c7dd49e7b6e7a9', '470b3d0f1c79426b90024450573dd72b', '厦门海沧实验中学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCZX00001', '2', 'f55c0462da414c12bae6192a91c45044', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '3adfe6e2d6564b89bff98446a33e6f53');
INSERT INTO `unit_info` VALUES ('6097e232161c4bf6961cf946bb8fe805', '470b3d0f1c79426b90024450573dd72b', '海沧区第二实验小学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:20:06', 'XMHCXX00017', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102108', '102', 'e0b5a5e80fc94c9e8448824e8b7328e4');
INSERT INTO `unit_info` VALUES ('62b8b24b2c494c1b96d99fb67dfd983c', '470b3d0f1c79426b90024450573dd72b', '海沧区东孚中心幼儿园', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCYEY00003', '2', '48f92f5aea864ef19520dc279b71d3dc', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '49bba825d5864a969f9f4250f64b912f');
INSERT INTO `unit_info` VALUES ('65150158577747f4816cdfe8c84619a5', '470b3d0f1c79426b90024450573dd72b', '测试', '1', null, '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 08:32:44', 'cs', '1', null, null, '102107', '102', 'e1bb5be1341047f199f07e151cc89625');
INSERT INTO `unit_info` VALUES ('69856c57d29448fba7557bb0bd066222', '470b3d0f1c79426b90024450573dd72b', '海沧区未来之星幼儿园', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCYEY00007', '2', '48f92f5aea864ef19520dc279b71d3dc', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '75c6d5d21c4f44c699aa9a0b48e5b5b4');
INSERT INTO `unit_info` VALUES ('6b28d4c60cd54bbab998220346d80d0f', '470b3d0f1c79426b90024450573dd72b', '海沧职业中专学校', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCZX00001', '2', 'b8e77d75acc0494bac66a6df318676b8', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '7824215f86ad4654ae719f1d5d5a79e2');
INSERT INTO `unit_info` VALUES ('715297a51a3e4e34a29a2f7be2543843', '470b3d0f1c79426b90024450573dd72b', '北师大厦门海沧附属学校', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCJN00001', '2', 'd3b2f69376134532bc205d5b27e959bd', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '51defd164b7a4ec7a70e6121cab3b31b');
INSERT INTO `unit_info` VALUES ('7485a1105d5741e2a31918fc568c28cb', '470b3d0f1c79426b90024450573dd72b', '厦门市第十一中学', null, '2', '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:44:37', '34350002002', '2', 'f55c0462da414c12bae6192a91c45044', '18d1fd3f6da44bfdb887379b92e7be06', '102108', '102', 'bf4d250a158340d884b047235b372469');
INSERT INTO `unit_info` VALUES ('75a58eee7db04599b361cee190306c7a', '470b3d0f1c79426b90024450573dd72b', '海沧区天湖幼儿园', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCYEY00010', '2', '48f92f5aea864ef19520dc279b71d3dc', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '0576f6f955014cd4a14ced9b360643c3');
INSERT INTO `unit_info` VALUES ('75acb5763ba74074bc4aec101c374001', '470b3d0f1c79426b90024450573dd72b', '厦门市金鸡亭小学', null, null, '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-10 11:00:01', '34350001002', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102102', '102', '84bb344930d74a838f524dc9998c58ce');
INSERT INTO `unit_info` VALUES ('7a9e529ad1844dfc8c1bc5a8725b51c8', '470b3d0f1c79426b90024450573dd72b', '厦门一中海沧分校', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCZX00003', '2', 'f55c0462da414c12bae6192a91c45044', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '9ae9de6cda1f4636b97e1702a1b06f37');
INSERT INTO `unit_info` VALUES ('7af7012dc4644a049045d32c0f0bd839', '470b3d0f1c79426b90024450573dd72b', '厦门外国语学校海沧附属学校', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCJN00002', '2', 'd3b2f69376134532bc205d5b27e959bd', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '6cca37d050aa4e659ad68bf429f03072');
INSERT INTO `unit_info` VALUES ('80aca882ea014229bea76498a16d7d85', '470b3d0f1c79426b90024450573dd72b', '海沧区海沧中心小学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCXX00011', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '36f5004484ea4eb8843dabf93ac1e7cd');
INSERT INTO `unit_info` VALUES ('881bbffc3c1842b1a3fd64db6806d03d', '470b3d0f1c79426b90024450573dd72b', '厦门市何厝小学', null, null, '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-10 11:00:23', '34350001003', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102103', '102', '4a04d21a1c9d4d2286dfdb2b5ec7b735');
INSERT INTO `unit_info` VALUES ('8a3ef695e7524bf1964532cd2a197712', '470b3d0f1c79426b90024450573dd72b', '厦门双十中学海沧附属学校', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCJN00003', '2', 'd3b2f69376134532bc205d5b27e959bd', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', 'd56dbd2e59c942429947d4bb139b2532');
INSERT INTO `unit_info` VALUES ('98101e13a3cb4a388a05afef62dfc07d', '470b3d0f1c79426b90024450573dd72b', '厦门思明测试中学', null, '6', '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-19 19:03:14', '测试001', '2', 'f55c0462da414c12bae6192a91c45044', '18d1fd3f6da44bfdb887379b92e7be06', '102112', '102', '0784003b3d1b47faadf839038c4e2c6e');
INSERT INTO `unit_info` VALUES ('9c8f3d278d314f1cb3f77e8e6cc3059a', '470b3d0f1c79426b90024450573dd72b', '海沧区海沧实验幼儿园', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCYEY00001', '2', '48f92f5aea864ef19520dc279b71d3dc', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '8253537439e14c79985e5b7ee4d132fd');
INSERT INTO `unit_info` VALUES ('a036677ec60d438e97fe54144dff7f78', '470b3d0f1c79426b90024450573dd72b', '华中师范大学厦门海沧附属小学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCXX00014', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '395ed2b203004e228faf7850b694331a');
INSERT INTO `unit_info` VALUES ('a3c305ba8a184151a493bae6f6cc9bc1', '470b3d0f1c79426b90024450573dd72b', '民办测试中学', null, '1', '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-19 19:04:07', '测试002', '2', 'f55c0462da414c12bae6192a91c45044', '916c0ef83f9048688bc3c7c3849f79ff', '102113', '102', '32c69bdcfc6547c98d43b4840a0f510e');
INSERT INTO `unit_info` VALUES ('aacc5ebfe0894a0391c6f476781f1adf', '470b3d0f1c79426b90024450573dd72b', '海沧区海沧幼儿园', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCYEY00005', '2', '48f92f5aea864ef19520dc279b71d3dc', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '1376fe8e7e7d4aaf827f60f6fe7562bb');
INSERT INTO `unit_info` VALUES ('ad5b4792dfad45e897d90a5f3df47d72', '470b3d0f1c79426b90024450573dd72b', '海沧区天竺幼儿园', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCYEY00004', '2', '48f92f5aea864ef19520dc279b71d3dc', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '4d91282436cf4f35a20a00ec324b101f');
INSERT INTO `unit_info` VALUES ('b0e7000070de45498abb2bba5ba4b37a', '470b3d0f1c79426b90024450573dd72b', '12', '1', null, '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-11 13:56:52', '123', '1', null, null, '102108', '102', '6c33bc7714fd4494af16f9497f750a37');
INSERT INTO `unit_info` VALUES ('b506814a224549c1943ba981f43368bd', '470b3d0f1c79426b90024450573dd72b', '海沧区育才小学 ', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:05', 'XMHCXX00002', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '0fb5520392024d80bd6e6fafd0b7013c');
INSERT INTO `unit_info` VALUES ('bc2971a0d7c34ce5a5103c56512fe556', '470b3d0f1c79426b90024450573dd72b', '海沧区新阳幼儿园', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCYEY00006', '2', '48f92f5aea864ef19520dc279b71d3dc', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '5e71bef04654433ca4ec17435bb13e01');
INSERT INTO `unit_info` VALUES ('ce4b08939a4b4f0282eda631aea02a31', '470b3d0f1c79426b90024450573dd72b', '海沧区海霞幼儿园', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCYEY00009', '2', '48f92f5aea864ef19520dc279b71d3dc', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', 'd2523530d806462c86f017982b633b5c');
INSERT INTO `unit_info` VALUES ('d95cbb0855b14638bc647090eac5d913', '470b3d0f1c79426b90024450573dd72b', '海沧区东孚中心小学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:05', 'XMHCXX00004', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '3fa2f1e484a3431a9ce31d870692aa01');
INSERT INTO `unit_info` VALUES ('db74ff47b39146f3a4bb456e7b4b8bdb', '470b3d0f1c79426b90024450573dd72b', '厦门市莲花小学', null, null, '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-10 10:57:21', '34350001001', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102101', '102', 'f5f9afe3e3c64b0e95fdae05048aaf39');
INSERT INTO `unit_info` VALUES ('dc402aa598e441b7aed6aefe6ce39ce4', '470b3d0f1c79426b90024450573dd72b', '海沧区东埔小学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCXX00006', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', 'b1d713ff3d0d4676b88f8543b5cef422');
INSERT INTO `unit_info` VALUES ('dec62cce01a64f08973ecb1bfbb05c81', '470b3d0f1c79426b90024450573dd72b', '厦门市华侨中学', null, '10', '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:46:57', '34350003001', '2', 'f55c0462da414c12bae6192a91c45044', '18d1fd3f6da44bfdb887379b92e7be06', '102109', '102', null);
INSERT INTO `unit_info` VALUES ('dee998716b8f4063a401d2a5ba842d5e', '470b3d0f1c79426b90024450573dd72b', '厦门市莲花中学', null, '1', '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:43:42', '34350002001', '2', 'f55c0462da414c12bae6192a91c45044', '18d1fd3f6da44bfdb887379b92e7be06', '102107', '102', null);
INSERT INTO `unit_info` VALUES ('e0e4a99ece4343f889c48316b5928814', '470b3d0f1c79426b90024450573dd72b', '海沧区新绿幼儿园', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCYEY00008', '2', '48f92f5aea864ef19520dc279b71d3dc', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '74e831a1c9cc45899a842fcb1f9ef141');
INSERT INTO `unit_info` VALUES ('e1fc6a956c64445aad99d6b6cacc0a58', null, '测试user', '0', '1', '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-10 12:35:43', '1', '1', null, null, '103', null, '1fdbef2120124d04a92854690f589a19');
INSERT INTO `unit_info` VALUES ('e3af6af2e02b4833999e35cd5113f0fc', '470b3d0f1c79426b90024450573dd72b', '海沧区教师进修学校', '0', '0', '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-10 10:03:04', '34350001001', '1', null, null, '102105', '102', 'dd966233b5404c2db25287a73e69ab5c');
INSERT INTO `unit_info` VALUES ('e3def80547e14a8abfcf367cd7dfe8fb', '470b3d0f1c79426b90024450573dd72b', '厦门市湖滨中学', null, '11', '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-12 09:51:36', '34350003002', '2', 'f55c0462da414c12bae6192a91c45044', '18d1fd3f6da44bfdb887379b92e7be06', '102110', '102', null);
INSERT INTO `unit_info` VALUES ('e6c5d1ffe693495283b5447d0a9f96b1', null, '测试教育局', '0', null, '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-10 10:03:40', '12', '1', null, null, '101', null, '31ce12dc138f403a9bd4696c1b4b5fbc');
INSERT INTO `unit_info` VALUES ('e861c76094cf4e1ab02a5268275b7d84', '470b3d0f1c79426b90024450573dd72b', '海沧区新江中心小学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCXX00015', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '82b69b2e407447b5923c9a97ba43d6cf');
INSERT INTO `unit_info` VALUES ('e93a20da5c1d43ed830ea696eb78f686', '470b3d0f1c79426b90024450573dd72b', '海沧区青礁小学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCXX00013', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '1012005d89934e9ca66f7b805152cbc8');
INSERT INTO `unit_info` VALUES ('ed6e2aea06c74fad9e3c0a6a812ec2b3', '470b3d0f1c79426b90024450573dd72b', '厦门市外国语附属小学', null, null, '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-10 11:02:34', '34350001004', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102104', '102', 'e28fe642f348434b9717dfcca9b2786a');
INSERT INTO `unit_info` VALUES ('f3c084915f084106a2f9e3cc350afcbe', '470b3d0f1c79426b90024450573dd72b', '厦门市何厝中学', null, '5', '1', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2015-08-20 15:23:22', '35532522', '2', 'f55c0462da414c12bae6192a91c45044', '18d1fd3f6da44bfdb887379b92e7be06', '102112', '102', '719442d9169d48adb609f4f9c413cd32');
INSERT INTO `unit_info` VALUES ('fff55931933d4378abcf2fc9b0f8200c', '470b3d0f1c79426b90024450573dd72b', '海沧区凤山小学', null, null, '0', '4b1e47c16aca4e919109d0a6a2fd4d9b', '2016-01-13 11:09:06', 'XMHCXX00008', '2', 'b559aea4da264baf934be51e81bfff0a', '18d1fd3f6da44bfdb887379b92e7be06', '102106', '102', '0c0d6e7edf5b44c187190cd2b3050e23');

-- ----------------------------
-- Table structure for `upload_log`
-- ----------------------------
DROP TABLE IF EXISTS `upload_log`;
CREATE TABLE `upload_log` (
  `id` varchar(100) NOT NULL,
  `userId` varchar(100) default NULL,
  `homeworkId` varchar(100) default NULL,
  `uploadUrl` varchar(255) default NULL,
  `uploadTime` varchar(30) default NULL,
  `score` varchar(30) default NULL,
  `assessTime` varchar(30) default NULL,
  `assesstor` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of upload_log
-- ----------------------------
INSERT INTO `upload_log` VALUES ('05bdb7e4e537476ba529d51c10b61ba8', '6d920693aa5e481e9e70a54da9f9d66c', '25df5697af194b1cb9f76d5799bccb0d', 'homework/20150928/reupload/1443426064895.txt', '2015-09-28 15:41:08', '65', '2015-10-06 11:19:52', 'c934f8e315554af5884657da846d95a5');
INSERT INTO `upload_log` VALUES ('ee68e56a42f04ba6bdb8040892d1c9ad', '88294196507c4711be6c1aeedd1acf4f', '25df5697af194b1cb9f76d5799bccb0d', 'homework/20150928/reupload/1443426130175.txt', '2015-09-28 15:42:11', '35', '2015-10-06 11:20:00', 'c934f8e315554af5884657da846d95a5');
INSERT INTO `upload_log` VALUES ('4a27db84e962419daf78a8e37e65a43d', '6d920693aa5e481e9e70a54da9f9d66c', '0495ce8439ef4b8eb59cfbda98a3bfd8', 'homework/20150928/reupload/1443432716252.txt', '2015-09-28 17:31:58', '55', '2015-10-06 11:12:05', 'c934f8e315554af5884657da846d95a5');
INSERT INTO `upload_log` VALUES ('5420d5f8f2f44c5f8c7412fb962d09cb', '88294196507c4711be6c1aeedd1acf4f', '0495ce8439ef4b8eb59cfbda98a3bfd8', 'homework/20150928/reupload/1443432750619.doc', '2015-09-28 17:32:32', '45', '2015-10-06 11:18:46', 'c934f8e315554af5884657da846d95a5');
INSERT INTO `upload_log` VALUES ('e9751c2ff1c84f059da477f75f1e5d43', '6d920693aa5e481e9e70a54da9f9d66c', '646d2b5cdbd44c17aac12a6e5877b5d3', 'homework/20151022/reupload/1445506593531.txt', '2015-10-22 17:36:35', null, null, null);

-- ----------------------------
-- Table structure for `user_info`
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` varchar(100) NOT NULL,
  `text` varchar(100) default NULL,
  `password` varchar(100) default NULL,
  `isActives` char(1) default NULL,
  `isDeleted` char(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('00eef7cb4c9b4675a00c78f070138de0', '陈桂虹', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('0576f6f955014cd4a14ced9b360643c3', 'hcthyey', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('0784003b3d1b47faadf839038c4e2c6e', 'admin2', 'ICy5YqxZB1uWSwcVLSNLcA==', '1', '0');
INSERT INTO `user_info` VALUES ('091f986b51024a2eabca8cbf5f88cd6c', '杨丽萍', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('0c0d6e7edf5b44c187190cd2b3050e23', 'hcqfsxx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('0fb5520392024d80bd6e6fafd0b7013c', 'hcqycxx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('1012005d89934e9ca66f7b805152cbc8', 'hcqqjxx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('11b2557dce644d63bae1152410e98c46', '毛佳玲', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('11d6744f79bf46a29885022c6b0006fc', '林丽娜', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('12ed3cdbb03e42cca1f86bd69c5e0eab', '申琛', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('1376fe8e7e7d4aaf827f60f6fe7562bb', 'hcyey', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('14addd23875349f7909bdf1aa6c3aa88', '林惠兰', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('1bfbe1772236462882bf9296d0cc0488', '翁圆', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('1f8cb5a74b5c4157ada492d112868074', '姚秀玉', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('2348ba148df14098b2029a259ec86db2', 'hsdhcfszx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('2476f88b4855495cb249594dcf4341f5', 'hcgzr', '4QrcOUm6Wau+VuBX8g+IPg==', null, '0');
INSERT INTO `user_info` VALUES ('262e25951add4091bb86c3504d87ece5', '陈佳琦', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('28ce79b597fd4c1981524dc65c81bc66', '陈智坚', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('29c802a592584b0f8b373a25316c7ea0', 'xmhcjyj', 'xMpCOKC5I4INzFCab3WEmw==', null, '0');
INSERT INTO `user_info` VALUES ('2fc50269990a424aa17d9bc06a41465a', '李俊', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('31eb840e9c414387902f49c7e1796de6', 'hcqtxdxx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('32928ca42a3f469287eef80e0ef58992', '李春敏', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('32c69bdcfc6547c98d43b4840a0f510e', 'admin3', 'ICy5YqxZB1uWSwcVLSNLcA==', '1', '0');
INSERT INTO `user_info` VALUES ('337f6c0ec7b040d79b2135174a2bd7f7', '赵霏霏', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('36aef5822c6244268df19b884663b283', '李日松', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('36f5004484ea4eb8843dabf93ac1e7cd', 'hcqhczxxx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('376c254a1208438c8f4ed323bbd0a619', '俞韵', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('395ed2b203004e228faf7850b694331a', 'hsdhcfsxx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('3adfe6e2d6564b89bff98446a33e6f53', 'hcsyzx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('3d23737176a642d59fee5326a7e0f195', '程娴', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('3fa2f1e484a3431a9ce31d870692aa01', 'hcqdfzxxx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('485b0b0feee747f7a27bf53e9d2eca25', 'hczx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('48c686ddce0249d68527153a9d1e9b40', '林毅娜', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('49bba825d5864a969f9f4250f64b912f', 'hcdfzxyey', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('4a04d21a1c9d4d2286dfdb2b5ec7b735', 'xmhcxx', 'xMpCOKC5I4INzFCab3WEmw==', null, '0');
INSERT INTO `user_info` VALUES ('4b1e47c16aca4e919109d0a6a2fd4d9b', 'admin', '4QrcOUm6Wau+VuBX8g+IPg==', '1', '0');
INSERT INTO `user_info` VALUES ('4d638e896c814cea8b7d5c5fae45b0d9', '李欣欣', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('4d91282436cf4f35a20a00ec324b101f', 'hctzyeye', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('51633eeae6884bbaaa573838c38d0e8b', '江静怡', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('51defd164b7a4ec7a70e6121cab3b31b', 'bsdhcfx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('51e9b4b54da543fd99cf498ac55e7ae4', '周灵敏', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('5204a7ca0b8245a29a467fba8a8cd9eb', '孙玲玲', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('550fa93739d647bab83735f09091c8ab', '秦天', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('5614ccf2ebac49228524ea875ec683c9', '范眉云', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('5aa4e9069d054a5fbec0cfd4c3b0e6c5', '陈巧君', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('5bec19d4b13e4df385698cf5f1d98251', '林春萍', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('5e71bef04654433ca4ec17435bb13e01', 'hcxyyey', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('6299ee5df3e24a9a90f3f0b291b0774e', '李岩', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('63adbd4755f14d43ba37c7685b564e0a', '颜雅恩', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('684a0c09ef6d47c6b60c204f4223303b', 'hcqdmxx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('6bdcdd6142964dce90f9042c6e902da4', '陈林丹', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('6ca3a8e7b9ba45379ebf6aa00218002f', '戴幼娟', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('6cca37d050aa4e659ad68bf429f03072', 'wgyhcfx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('719442d9169d48adb609f4f9c413cd32', 'xmhczx', 'ICy5YqxZB1uWSwcVLSNLcA==', '1', '0');
INSERT INTO `user_info` VALUES ('74e831a1c9cc45899a842fcb1f9ef141', 'hcxlyey', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('75c6d5d21c4f44c699aa9a0b48e5b5b4', 'hcwlzxyey', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('76842a711c914aeca7ddb4bae29fdd4a', '林琳', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('7824215f86ad4654ae719f1d5d5a79e2', 'hczz', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('797bf02e8b5944fabc2aa779857b80df', '张桂如', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('79b8fb9c3bf54bb7b6a361ebf8c5efcc', '卢溢红', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('7c1343cc590f48fea3d2da9fe6817940', '叶光桦', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('81716d731b1841b2a313b80cde07041d', '丘晓芳', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('8177eb904f62437fb07e843ef2e93caa', 'hcqhtxx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('823d9a86d45f4b53bf7b5017ab67e9af', '蔡梓媚', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('8253537439e14c79985e5b7ee4d132fd', 'hcsyyey', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('82b69b2e407447b5923c9a97ba43d6cf', 'hcqxjzxxx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('838bb2e9160c485a8f8e1e60236d8570', '王婷婷', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('83f70ed77ab940a2a4c8693c6d8cdd38', '信琴琴', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('8a1e518a2bba4512b300f01e4f87d642', '吴其左', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('8b3767b44f534ba89545a9bb7e640e73', '陈婷', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('904a6b3beca4457d9dfb167d4e8e5e83', 'hclyyey', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('9077e871084046928cd3602029fba0f9', '杨佳雯', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('95f74540dbc14df0abb8d01b76383bde', '林清铃', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('9771e2069f59406c90b351c36b86a22a', '叶  璐', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('99b1d48fae1e4b6c970102ecca839168', '冯艳', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('9ae9de6cda1f4636b97e1702a1b06f37', 'yzhcfx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('9b9efa4209ae418a9f2bbb701b6a027b', '于艳', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('a21a2b65cab04df0976c9161fcc7ef3e', 'hcqzdxx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('a6820011f7c841969e6b58700a76ddd6', '郭志贤', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('a6e7d28f2afc4c9ab96366197fa8c4b6', '叶平宝', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('a75d5d1e8e6f4c97aa279df77d85578c', '周丽娜', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('a766e60aecde4f85b8b75614195e692b', '林燕', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('a8618c938ca64704b45702f7f8eaed9e', '陈韶娟', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('ab2ab29f57c5440d8fde2a9abc81d74f', '江甜', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('b1d713ff3d0d4676b88f8543b5cef422', 'hcqdpxx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('b26cb4fec3944660bf6307967b3d9146', '谢雨丽', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('bb4d656f0d69454fa1064e77073492c9', '陈琳 ', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('beab6488a225454cac2bcab18b4a2331', 'xmhcykxx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('bf2e47192f7347768e63eccf7b0302e0', '罗佳宇', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('bf4d250a158340d884b047235b372469', 'admin1', 'ICy5YqxZB1uWSwcVLSNLcA==', '1', '0');
INSERT INTO `user_info` VALUES ('c53815ecba78427b8fbf2f1308890841', 'hcqxyxx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('c62a810b55ea4bde982403eb0ec65b2e', '杨玉婷', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('c7bff0e443274a4099dfbaa57443b3da', '郭碧微', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('c8672f3ba28743f3a7d94e054c4be8ba', '罗佳璐', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('cd206beb50f147fba71fcac9f6173552', '柯文雅', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('ce498490d4204f92ac95a2367d983ed1', '苗永丹', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('d2523530d806462c86f017982b633b5c', 'hchxyey', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('d2c267afd23d4592916146a7589db250', '杜娟', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('d39746fab0354f92b32add4936701729', 'hcqjlxx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('d45ee888e6f44f949c2466ff622a68c0', '连丽美', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('d56dbd2e59c942429947d4bb139b2532', 'sszxhcfx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('d8450cdb94ca42ad83ed253701c9b4fc', '陈进中', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('d862340b2455434ead47a32c974bdd5c', '郑慧娟', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('d9457510ad19404498555c43734c8dc3', '陆声明', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('d9c393eb678c41848d739c3bb2dd3148', '方晓凡', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('d9ca90982484440f8bf828474939d459', '方晓萍', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('dbd5b2c483ec48ba90c2bb3866d6a553', '付成雪', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('dbe2fc6d341b43bb811829bd5263ce45', '李丽瑛', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('dd966233b5404c2db25287a73e69ab5c', 'hcjsjxxx', 'xMpCOKC5I4INzFCab3WEmw==', null, '0');
INSERT INTO `user_info` VALUES ('df4741cefd3042f38e79acb8c4ff8bf8', '郭晶晶', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('e0121161ff00484aa436a3a7d4fda98d', '孙艺菲', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('e0b5a5e80fc94c9e8448824e8b7328e4', 'hcqdysx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('e28fe642f348434b9717dfcca9b2786a', 'xmwgyfsxx', 'xMpCOKC5I4INzFCab3WEmw==', null, '0');
INSERT INTO `user_info` VALUES ('e9b952b4587c45abb7346a22538fbab7', '曾凯虹', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('eb075b8a50b6426886ff9620f8a9b963', '沈美容', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('ec00eb3c71674b7aa1803b09c306e697', 'hcqzsxx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('efa6916dec3d4d1cbe309b1a17ecf5f1', '张婕', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('f05ac3ba38c94f949f35414e30736bd3', '丁云苑', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('f099244c6ec947008669ea9fedb4589d', '魏秋霖', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('f0cf74d87008410fb392c8d6792eacb9', 'hcqdyxx', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('f3183830b0c54f38b83ce2abed78211e', '黄佳蔚', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('f4b2334bb6554a2e9864fcf8ac51ed65', '吴颖颖', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('f4d3fec29e904b39bd5e11e169b372ba', '周艺婷', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('f4f7f3ac43a3489e9eb115b707035dc7', '徐欢欢', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('f5a3e9353743424fb5798501e12a8cf6', '汤秋诗', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('f5f9afe3e3c64b0e95fdae05048aaf39', 'xmlhxxx', 'xMpCOKC5I4INzFCab3WEmw==', null, '0');
INSERT INTO `user_info` VALUES ('fb878193b2144cbca55ef46259c479ba', '徐瑶瑶', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('fcdec8c396444163ae0b6dc8a455c5ea', '杜蕊', 'yIN7I/+Kqoot3pFUc84JkQ==', '1', '0');
INSERT INTO `user_info` VALUES ('ff2bf552cb374b4c9c78857d4ec1ae83', 'xmsdsyzx', '4QrcOUm6Wau+VuBX8g+IPg==', null, '0');

-- ----------------------------
-- Table structure for `use_lesson`
-- ----------------------------
DROP TABLE IF EXISTS `use_lesson`;
CREATE TABLE `use_lesson` (
  `id` varchar(100) NOT NULL,
  `lessonId` varchar(100) default NULL,
  `classTimeId` varchar(100) default NULL,
  `useLesson` varchar(20) default NULL,
  `creator` varchar(100) default NULL,
  `createdate` varchar(23) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of use_lesson
-- ----------------------------
INSERT INTO `use_lesson` VALUES ('001fe7448b854dc28dc7d53b59ab6ce0', '7c5d5ac29f9a49dfaa46a36ebbd47a80', '23ce6657d4674b93addb01aa26223ef8', '2', 'c934f8e315554af5884657da846d95a5', '2015-09-24 15:43:01');
INSERT INTO `use_lesson` VALUES ('39a99df44b1840cd80832414bba73c9d', '7c5d5ac29f9a49dfaa46a36ebbd47a80', '806e86b0bb3e416eaf2755d74c1bc50c', '3', 'c934f8e315554af5884657da846d95a5', '2015-09-24 14:36:32');
INSERT INTO `use_lesson` VALUES ('8a52c01d99d7449084be71b274ff02db', '968c3b578bf049558bb49c0a5e92a9c7', '23ce6657d4674b93addb01aa26223ef8', '5', 'c934f8e315554af5884657da846d95a5', '2015-09-24 15:43:01');
INSERT INTO `use_lesson` VALUES ('903b809c26c14ec8a39ce8f086fe2253', '968c3b578bf049558bb49c0a5e92a9c7', 'c98676f14e8640438ae3e3350281736a', '2', 'c934f8e315554af5884657da846d95a5', '2015-09-24 14:41:05');
INSERT INTO `use_lesson` VALUES ('df807bebfe9c42be8388f151eac7571c', 'b7012c0f297f4028af0d37747beed021', '806e86b0bb3e416eaf2755d74c1bc50c', '10', 'c934f8e315554af5884657da846d95a5', '2015-09-24 14:36:32');
INSERT INTO `use_lesson` VALUES ('f2e0e08dea304bdcaf4c042d0c6a81ec', 'b7012c0f297f4028af0d37747beed021', '23ce6657d4674b93addb01aa26223ef8', '1', 'c934f8e315554af5884657da846d95a5', '2015-09-24 15:43:01');
