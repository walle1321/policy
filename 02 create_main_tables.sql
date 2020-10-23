SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sl_config
-- 双录配置信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_config`;
CREATE TABLE `sl_config`
(
    `id`           BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '序号',
    `config_type`  VARCHAR(40) NOT NULL COMMENT '配置类型',
    `config_code`  VARCHAR(40) NOT NULL COMMENT '配置编码',
    `config_name`  VARCHAR(128) DEFAULT NULL COMMENT '配置名称',
    `config_value` TEXT         DEFAULT NULL COMMENT '配置值',
    `desc`         VARCHAR(256) DEFAULT NULL COMMENT '配置说明',
    `status`       TINYINT(1)   DEFAULT 1 COMMENT '数据状态(1-有效，0-无效)',
    `create_time`  DATETIME     DEFAULT NULL COMMENT '创建时间',
    `modify_time`  DATETIME     DEFAULT NULL COMMENT '修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_config` (`config_type`, `config_code`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录配置信息';

-- ----------------------------
-- Table structure for sl_org_access_whitelist
-- 双录机构访问权限白名单
-- ----------------------------
DROP TABLE IF EXISTS `sl_org_access_whitelist`;
CREATE TABLE `sl_org_access_whitelist`
(
    `id`          bigint(8)    NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    `org_code`    varchar(40)  NOT NULL COMMENT '机构编码',
    `org_name`    varchar(128) NOT NULL COMMENT '机构名称',
    `channels`    varchar(128) DEFAULT NULL COMMENT '渠道列表(枚举值，多个用逗号分隔(如A11,A12,A13)，null表示不限)',
    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
    `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_org` (`org_code`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录机构访问权限白名单';

-- ----------------------------
-- Table structure for sl_policy_record
-- 保单的双录信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_policy_record`;
CREATE TABLE `sl_policy_record`
(
    `businum`       VARCHAR(40) NOT NULL COMMENT '双录业务号',
    `agent_code`    VARCHAR(40) DEFAULT NULL COMMENT '所属代理人编号',
    `first_record`  VARCHAR(40) NOT NULL COMMENT '首次双录编号',
    `last_record`   VARCHAR(40) NOT NULL COMMENT '最后一次双录编号',
    `record_list`   TEXT        DEFAULT NULL COMMENT '双录列表(按制顺序排序)',
    `policy_status` VARCHAR(20) NOT NULL COMMENT '保单双录状态(枚举值：K-数据待上传，J-数据上传中,D-数据解析中,M-质检中,P-不质检,L-质检不通过（待整改）,S-质检已通过）',
    `create_time`   DATETIME    DEFAULT NULL COMMENT '创建时间',
    `modify_time`   DATETIME    DEFAULT NULL COMMENT '修改时间',
    PRIMARY KEY (`businum`),
    KEY `idx_agent` (`agent_code`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='保单的双录信息';

-- ----------------------------
-- Table structure for sl_record
-- 双录录制信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_record`;
CREATE TABLE `sl_record`

    `record_no`          VARCHAR(40) NOT NULL COMMENT '双录编号',
    `record_type`        VARCHAR(8)  NOT NULL COMMENT '录制类型(枚举值: A-新录制，R-整改)',
    `businums`           VARCHAR(512) DEFAULT NULL COMMENT '双录业务编号（多个用逗号,分隔)',
    `first_record`       VARCHAR(40)  DEFAULT NULL COMMENT '首次双录编号（用于整改视频，首次双录为NULL)',
    `amended_record`     VARCHAR(40)  DEFAULT NULL COMMENT '被整改的视频编号（即前一个视频）',
    `record_status`      INTEGER(4)  NOT NULL COMMENT '双录状态（枚举值:1-录制中,10-待上传,11-上传中,20-待视频处理,21-视频处理中,22-视频处理失败,30-待质检,31-质检中，32-质检不通过,33-质检通过，34-不质检)',
    `record_status_desc` TEXT         DEFAULT NULL COMMENT '双录状态描述',
    `source`             VARCHAR(20)  DEFAULT NULL COMMENT '录制来源(枚举值：BBApp,BCApp,YBTApp,FTApp)',
    `record_mode`        VARCHAR(8)   DEFAULT NULL COMMENT '录制方式(枚举值：1-自读(纸质文档)，2-自读(无纸化文档)，3-语音播报（纸质文档），4-语音播报（无纸化文档），5-远程双录)',
    `record_time`        DATETIME     DEFAULT NULL COMMENT '视频录制时间',
    `upload_time`        DATETIME     DEFAULT NULL COMMENT '视频上传时间',
    `record_device_id`   VARCHAR(64)  DEFAULT NULL COMMENT '视频录制设备ID',
    `record_device_info` VARCHAR(256) DEFAULT NULL COMMENT '录制的设置信息',
    `qc_result`          VARCHAR(8)   DEFAULT NULL COMMENT '质检结论(枚举值：S-通过，L-未通过)',
    `qc_time`            DATETIME     DEFAULT NULL COMMENT '质检时间',
    `session`            VARCHAR(40)  DEFAULT NULL COMMENT '前端APP的会话ID',
    `create_time`        DATETIME     DEFAULT NULL COMMENT '记录创建时间',
    `modify_time`        DATETIME     DEFAULT NULL COMMENT '记录修改时间',
    PRIMARY KEY (`record_no`),
    KEY `idx_session` (`session`)
) ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录录制信息';

-- ----------------------------
-- Table structure for sl_record_policy_info
-- 双录单的保单信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_record_policy_info`;
CREATE TABLE `sl_record_policy_info`
(
    `id`           BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '序号',
    `record_no`    VARCHAR(40) NOT NULL COMMENT '双录号',
    `businum`      VARCHAR(40) NOT NULL COMMENT '双录业务号',
    `busitype`     VARCHAR(8)  NOT NULL COMMENT '双录业务类型(枚举值：NEW-新契约,POS-保全新增附约)',
    `change_id`     BIGINT(8)   DEFAULT NULL COMMENT '保全批改号(业务类型为保全新增时有效)',
    `propose_code` VARCHAR(40) DEFAULT NULL COMMENT '保全申请号(业务类型为保全新增时有效)',
    `propose_date` DATE        DEFAULT NULL COMMENT '保全申请日期(业务类型为保全新增时有效)',
    `policy_code`  VARCHAR(40) DEFAULT NULL COMMENT '保单号(业务类型为保全新增时有效)',
    `accept_time`  DATETIME     DEFAULT NULL COMMENT '保单承保时间(业务类型为保全新增时有效)',
    `apply_code`   VARCHAR(40) DEFAULT NULL COMMENT '投保单号',
    `apply_date`   DATE        DEFAULT NULL COMMENT '投保日期',
    `appnt_age`    INTEGER(4)  DEFAULT NULL COMMENT '投保人投保时年龄',
    `self_policy`  VARCHAR(8)  DEFAULT NULL COMMENT '是否是自保件',
    `organ_id`     VARCHAR(40) DEFAULT NULL COMMENT '投保单归属机构',
    `sell_way`     VARCHAR(8)  DEFAULT NULL COMMENT '投保单归属渠道',
    `sell_channel` VARCHAR(8)  DEFAULT NULL COMMENT '投保单销售渠道',
    `bank_code`    VARCHAR(40) DEFAULT NULL COMMENT '投保单归属银行',
    `create_time`  DATETIME    DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_record_busi` (`record_no`, `businum`),
    KEY `idx_applycode` (`apply_code`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录单的保单信息';

-- ----------------------------
-- Table structure for sl_record_policy_product
-- 双录单的险种信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_record_policy_product`;
CREATE TABLE `sl_record_policy_product`
(
    `id`                 BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '序号',
    `record_no`          VARCHAR(40) NOT NULL COMMENT '双录号',
    `businum`            VARCHAR(40) NOT NULL COMMENT '双录业务号',
    `product_id`         BIGINT(8)   NOT NULL COMMENT '险种ID',
    `product_code`       VARCHAR(40) NOT NULL COMMENT '险种内部代码(internal_id)',
    `product_name`       VARCHAR(255) DEFAULT NULL COMMENT '险种名称',
    `new_product`       VARCHAR(8) DEFAULT NULL COMMENT '是否为新增险种(Y或N，双录业务类型为保全新增时有效）',
    `be_relationed_with` VARCHAR(8)   DEFAULT NULL COMMENT '投保人与被保人的关系（枚举值：0-无关或不确定, 1-配偶, 2-子女, 3-父母, 4-亲属, 5-本人, 6-其它, 7-雇佣, 8-代理人, 9-朋友, 10-同事, 96-父子, 97-父女, 98-母子, 99-母女）',
    `ins_type`           VARCHAR(8)   DEFAULT NULL COMMENT '主附险约别(枚举值：1-主险，2-附险，3-可选责任）',
    `prem`               VARCHAR(40)  DEFAULT NULL COMMENT '保费',
    `charge_type`        VARCHAR(8)   DEFAULT NULL COMMENT '缴费方式(枚举值：0-无关或不确定，1-年交，2-半年交，3-季交，4-月交，5-趸交，6-不定期，7-趸交按月付款）',
    `charge_year`        VARCHAR(20)  DEFAULT NULL COMMENT '缴费年期',
    `charge_period`      VARCHAR(8)   DEFAULT NULL COMMENT '缴费年期类型值（枚举值：0-无关，1-趸交，2-按年限交，3-交至某确定年龄，4-终生交费，5-不定期交，6-按月交）',
    `coverage_year`      VARCHAR(20)  DEFAULT NULL COMMENT '保障年期',
    `coverage_period`    VARCHAR(8)   DEFAULT NULL COMMENT '保障年期类型标记值（枚举值：0-无关，1-保终身，2-按年限保，3-保至某确定年龄，4-按月保，5-按天保）',
    `min_rate`           VARCHAR(40)  DEFAULT NULL COMMENT '最低保证利率',
    `amount`            VARCHAR(40) DEFAULT NULL COMMENT '投保总额',
    `cash_value`         VARCHAR(40)  DEFAULT NULL COMMENT '险种的第一年末现金价值',
    `create_time`        DATETIME     DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_record_busi` (`record_no`, `businum`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录单的险种信息';

-- ----------------------------
-- Table structure for sl_record_policy_agent
-- 双录单的代理人信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_record_policy_agent`;
CREATE TABLE `sl_record_policy_agent`
(
    `id`          BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '序号',
    `record_no`   VARCHAR(40) NOT NULL COMMENT '双录号',
    `businum`     VARCHAR(40) NOT NULL COMMENT '双录业务号',
    `agent_code`  VARCHAR(40) NOT NULL COMMENT '代理人工号',
    `agent_cate`  VARCHAR(8)  DEFAULT NULL COMMENT '代理人所属渠道',
    `name`        VARCHAR(40) DEFAULT NULL COMMENT '代理人姓名',
    `org_code`    VARCHAR(40) DEFAULT NULL COMMENT '代理所属机构编码',
    `gender`      VARCHAR(8)  DEFAULT NULL COMMENT '代理人性别',
    `birthday`    DATE        DEFAULT NULL COMMENT '代理人生日',
    `certi_type`  INTEGER(4)  DEFAULT NULL COMMENT '代理人证件类型(枚举值：1-身份证；2-军人证；3-护照；4-出生证；5-异常身份证；6-港澳居民来往内地通行证；7-士兵证；8-警官证；9-其他；12-居民户口簿；16-港澳居民居住证；61-外国人永久居住证；909-代理人执业证)',
    `certi_code`  VARCHAR(40) DEFAULT NULL COMMENT '代理人证件号码',
    `cellphone`   VARCHAR(40) DEFAULT NULL COMMENT '代理人手机号码',
    `create_time` DATETIME    DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_record_busi` (`record_no`, `businum`),
    KEY `idx_record` (`record_no`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录单的代理人信息';

-- ----------------------------
-- Table structure for sl_record_policy_appnt
-- 双录单的投保人信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_record_policy_appnt`;
CREATE TABLE `sl_record_policy_appnt`
(
    `id`                 BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '序号',
    `record_no`          VARCHAR(40) NOT NULL COMMENT '双录号',
    `businum`            VARCHAR(40) NOT NULL COMMENT '双录业务号',
    `appnt_name`         VARCHAR(40)  DEFAULT NULL COMMENT '投保人姓名',
    `appnt_gender`       VARCHAR(8)   DEFAULT NULL COMMENT '投保人性别',
    `appnt_birthday`     DATE         DEFAULT NULL COMMENT '投保人生日',
    `appnt_certi_type`   INTEGER(4)   DEFAULT NULL COMMENT '投保人证件类型(枚举值：1-身份证；2-军人证；3-护照；4-出生证；5-异常身份证；6-港澳居民来往内地通行证；7-士兵证；8-警官证；9-其他；12-居民户口簿；16-港澳居民居住证；61-外国人永久居住证；909-代理人执业证)',
    `appnt_certi_code`   VARCHAR(40)  DEFAULT NULL COMMENT '投保人证件号码',
    `appnt_address`      VARCHAR(255) DEFAULT NULL COMMENT '投保人住址',
    `appnt_rela_address` VARCHAR(255) DEFAULT NULL COMMENT '投保人联系地址',
    `create_time`        DATETIME     DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_record_busi` (`record_no`, `businum`),
    KEY `idx_record` (`record_no`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录单的投保人信息';

-- ----------------------------
-- Table structure for sl_record_policy_insured
-- 双录单的被保人信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_record_policy_insured`;
CREATE TABLE `sl_record_policy_insured`
(
    `id`                   BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '序号',
    `record_no`            VARCHAR(40) NOT NULL COMMENT '双录号',
    `businum`              VARCHAR(40) NOT NULL COMMENT '双录业务号',
    `product_id`           BIGINT(8)   NOT NULL COMMENT '险种ID',
    `insured_name`         VARCHAR(40)  DEFAULT NULL COMMENT '被保人姓名',
    `insured_gender`       VARCHAR(8)   DEFAULT NULL COMMENT '被保人性别',
    `insured_birthday`     DATETIME     DEFAULT NULL COMMENT '被保人生日',
    `insured_certi_type`   INTEGER(4)   DEFAULT NULL COMMENT '被保人证件类型(枚举值：1-身份证；2-军人证；3-护照；4-出生证；5-异常身份证；6-港澳居民来往内地通行证；7-士兵证；8-警官证；9-其他；12-居民户口簿；16-港澳居民居住证；61-外国人永久居住证；909-代理人执业证)',
    `insured_certi_code`   VARCHAR(40) NOT NULL COMMENT '被保人证件号码',
    `insured_address`      VARCHAR(255) DEFAULT NULL COMMENT '被保人住址',
    `insured_rela_address` VARCHAR(255) DEFAULT NULL COMMENT '被保人联系地址',
    `create_time`          DATETIME     DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_record_busi` (`record_no`, `businum`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录单的被保人信息';

-- ----------------------------
-- Table structure for sl_record_talk
-- 双录话术信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_record_talk`;
CREATE TABLE `sl_record_talk`
(
    `id`                 BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '序号',
    `record_no`          VARCHAR(40) NOT NULL COMMENT '双录编号',
    `broadcastable`      CHAR(1)  DEFAULT NULL COMMENT '是否可以语音播报(Y或N)',
    `create_time`        DATETIME DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_record` (`record_no`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录话术信息';

-- ----------------------------
-- Table structure for sl_record_talk_step
-- 双录话术环节信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_record_talk_step`;
CREATE TABLE `sl_record_talk_step`
(
    `id`            BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '话术环节ID',
    `record_no`     VARCHAR(40) NOT NULL COMMENT '双录编号',
    `talk_id`       VARCHAR(40) NOT NULL COMMENT '对应的话术ID',
    `qc_point_id`   VARCHAR(40) NOT NULL COMMENT '对应的质检要点ID',
    `qc_point_name` VARCHAR(64) NOT NULL COMMENT '对应质检要点名称',
    `talk_content`  TEXT     DEFAULT NULL COMMENT '生成的话术内容',
    `talk_question` TEXT     DEFAULT NULL COMMENT '生成的话术问题',
    `broadcastable` CHAR(1)  DEFAULT NULL COMMENT '是否可以语音播报(Y或N)',
    `operate_tips`  TEXT     DEFAULT NULL COMMENT '环节操作提示',
    `step_order`    INTEGER(4)  NOT NULL COMMENT '双录环节序号',
    `create_time`   DATETIME DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_record` (`record_no`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录话术环节信息';

-- ----------------------------
-- Table structure for sl_record_talk_aicheck
-- 双录话术环节的智能检测信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_record_talk_aicheck`;
CREATE TABLE `sl_record_talk_aicheck`
(
    `id`                 BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    `record_no`          VARCHAR(40) NOT NULL COMMENT '双录编号',
    `step_id`            BIGINT(8)   NOT NULL COMMENT '环节ID',
    `aicheck_type`       INTEGER(4)  DEFAULT NULL COMMENT '智能检测类型(枚举值：1-faceV,2-vaR,3-ptR,4-idR,5-jump)',
    `jump_on_success`    CHAR(1)      DEFAULT NULL COMMENT '成功后是否自动跳转(Y-是，N-否)',
    `screen_tips`        VARCHAR(255) DEFAULT NULL COMMENT '屏幕提示语',
    `va_answerer_role`   INTEGER(4)   DEFAULT NULL COMMENT '语音回答者角色(枚举值：1-代理人,2-投保人,3-被保人)',
    `va_expected_answer` VARCHAR(255) DEFAULT NULL COMMENT '语音识别时的期望回答的内容',
    `id_holder_role`     INTEGER(4)   DEFAULT NULL COMMENT '身份证识别的持证人的角色(枚举值：1-代理人,2-投保人,3-被保人)',
    `id_side_type`       INTEGER(4)   DEFAULT NULL COMMENT '身份证识别时证件正反面类型（枚举值：1-正面,2-反面,3-正反面)',
    `pt_doc_category`    VARCHAR(20)  DEFAULT NULL COMMENT '标题检测时的文档类别',
    `pt_doc_codes`       VARCHAR(255) DEFAULT NULL COMMENT '标题检测室的文档编号（险种的ProductId)（多个用逗号,分隔)',
    `create_time`        DATETIME     DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_record_step` (`record_no`, `step_id`),
    KEY `idx_record` (`record_no`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录话术环节的智能检测信息';


-- ----------------------------
-- Table structure for sl_record_talk_docshow
-- 双录话术环节的无纸化文档展示信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_record_talk_docshow`;
CREATE TABLE `sl_record_talk_docshow`
(
    `id`            BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    `record_no`     VARCHAR(40) NOT NULL COMMENT '双录编号',
    `step_id`       BIGINT(8)   NOT NULL COMMENT '环节ID',
    `doc_category`  VARCHAR(20) NOT NULL COMMENT '文档类别（枚举值：RISK_SPEC,INSUR_CLAUSE,INSUR_LIAB,ESCP_CLAUSE,APPLY_NOTICE,APPLY_CONFIRM,INSUR_PLAN,HLTH_NOTICE）',
    `doc_code`      VARCHAR(128) NOT NULL COMMENT '文档编号(多个使用逗号英文逗号分隔)',
    `need_sign`     CHAR(1)     DEFAULT 'N' COMMENT '文档是否需要签名',
    `sign_roles`    VARCHAR(32) DEFAULT NULL COMMENT '需签名者的角色(枚举值：1-代理人,2-投保人,3-被保人)(多个用,分隔)',
    `comment_roles` VARCHAR(32) DEFAULT NULL COMMENT '需抄录者的角色（枚举值：1-代理人,2-投保人,3-被保人)(多个用,分隔)',
    `create_time`   DATETIME    DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_record_step` (`record_no`, `step_id`),
    KEY `idx_record` (`record_no`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录话术环节的无纸化文档展示信息';

-- ----------------------------
-- Table structure for sl_record_certi_picture
-- 双录证件类型信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_record_certi_picture`;
CREATE TABLE `sl_record_certi_picture`
(
    `id`                BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '序号',
    `record_no`         VARCHAR(40) NOT NULL COMMENT '双录编号',
    `holder_name`       VARCHAR(40) NOT NULL COMMENT '持有人姓名',
    `holder_certi_type` INTEGER(4)    DEFAULT NULL COMMENT '持有人证件类型',
    `holder_certi_code` VARCHAR(40)   DEFAULT NULL COMMENT '持有人证件号',
    `pic_name`          VARCHAR(64)   DEFAULT NULL COMMENT '图片名称',
    `pic_type`          VARCHAR(16)   DEFAULT NULL COMMENT '图片类型(JPG...)',
    `pic_url`           VARCHAR(1024) DEFAULT NULL COMMENT '图片URL',
    `pic_url_exptime`   DATETIME      DEFAULT NULL COMMENT '图片URL失效时间(null表示永不失效)',
    `create_time`       DATETIME      DEFAULT NULL COMMENT '记录创建时间',
    `modify_time`       DATETIME      DEFAULT NULL COMMENT '记录修改时间',
    PRIMARY KEY (`id`),
    KEY `idx_record` (`record_no`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录证件类型信息';

-- ----------------------------
-- Table structure for sl_record_signeddoc
-- 双录已签名文档信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_record_signeddoc`;
CREATE TABLE `sl_record_signeddoc`
(
    `id`           BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '序号',
    `record_no`    VARCHAR(40) NOT NULL COMMENT '双录编号',
    `businum`      VARCHAR(40) NOT NULL COMMENT '双录业务单号',
    `doc_category` VARCHAR(16) NOT NULL COMMENT '文档类别',
    `doc_code`     VARCHAR(64) NOT NULL COMMENT '文档编号',
    `doc_name`     VARCHAR(128) DEFAULT NULL COMMENT '文档名称',
    `page_num`     INTEGER(4)   DEFAULT NULL COMMENT '页码',
    `tiff_url`     VARCHAR(512) DEFAULT NULL COMMENT 'TIFF影像文档URL',
    `gen_time`     DATETIME     DEFAULT NULL COMMENT '影像文档生成时间',
    `create_time`  DATETIME     DEFAULT NULL COMMENT '记录创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_record_busi` (`record_no`, `businum`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录已签名文档信息';

-- ----------------------------
-- Table structure for sl_record_aicheck
-- 双录智能预检结果信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_record_aicheck`;
CREATE TABLE `sl_record_aicheck`
(
    `id`                       BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '序号',
    `record_no`                VARCHAR(40) NOT NULL COMMENT '双录编号',
    `aicheck_result`           VARCHAR(8)   DEFAULT NULL COMMENT '智能检测结论(枚举值：S-通过，L-未通过)',
    `aicheck_desc`             VARCHAR(512) DEFAULT NULL COMMENT '智能检测描述',
    `persons_on_screen_ratio`  VARCHAR(30)  DEFAULT NULL COMMENT '人物同框比例(小数，用字符串表示)',
    `persons_on_screen_detail` TEXT         DEFAULT NULL COMMENT '人物同框详细信息',
    `face_check_result`        VARCHAR(8)   DEFAULT NULL COMMENT '人脸比对结果（枚举值：S-通过，L-未通过)',
    `face_check_desc`          VARCHAR(512) DEFAULT NULL COMMENT '人脸比对结果描述',
    `create_time`              DATETIME     DEFAULT NULL COMMENT '记录创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_record` (`record_no`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录智能预检结果信息';

-- ----------------------------
-- Table structure for sl_record_video
-- 双录视频信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_record_video`;
CREATE TABLE `sl_record_video`
(
    `id`                          BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '序号',
    `record_no`                   VARCHAR(40) NOT NULL COMMENT '双录编号',
    `video_name`                  VARCHAR(255)  DEFAULT NULL COMMENT '视频文件名',
    `video_type`                  VARCHAR(32)   DEFAULT NULL COMMENT '视频类型',
    `video_time_len`              BIGINT(8)     DEFAULT NULL COMMENT '视频时长（秒）',
    `video_record_time`           DATETIME      DEFAULT NULL COMMENT '视频开始录制时间',
    `video_upload_time`           DATETIME      DEFAULT NULL COMMENT '视频数据上传时间',
    `uploaded_zip_url`            VARCHAR(512)  DEFAULT NULL COMMENT '上传zip数据URL',
    `video_file_url`              VARCHAR(1024) DEFAULT NULL COMMENT '视频文件URL',
    `video_file_url_exptime`      DATETIME      DEFAULT NULL COMMENT '视频文件URL失效时间(null表示永不失效)',
    `video_vod_url`               VARCHAR(1024) DEFAULT NULL COMMENT '视频点播地址URL',
    `video_vod_url_exptime`       DATETIME      DEFAULT NULL COMMENT '视频点播地址URL(null表示永不失效)',
    `video_thumbnail_url`         VARCHAR(1024) DEFAULT NULL COMMENT '视频缩略图URL',
    `video_thumbnail_url_exptime` DATETIME      DEFAULT NULL COMMENT '视频缩略图URL(null表示永不失效)',
    `create_time`                 DATETIME      DEFAULT NULL COMMENT '记录创建时间',
    `modify_time`                 DATETIME      DEFAULT NULL COMMENT '记录修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_record` (`record_no`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录视频信息';

-- ----------------------------
-- Table structure for sl_record_video_step
-- 双录视频环节信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_record_video_step`;
CREATE TABLE `sl_record_video_step`
(
    `id`                          BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '序号',
    `record_no`                   VARCHAR(40) NOT NULL COMMENT '双录编号',
    `step_id`                     BIGINT(8)   NOT NULL COMMENT '双录视频环节信息ID',
    `video_content`               TEXT          DEFAULT NULL COMMENT '视频中的环节语音内容（若开通自动语音识别)',
    `step_screenshot_url`         VARCHAR(1024) DEFAULT NULL COMMENT '视频抽帧图片的URL',
    `step_screenshot_url_exptime` DATETIME      DEFAULT NULL COMMENT '视频抽帧图片的URL(null表示永不失效)',
    `step_start_time`             BIGINT(8)     DEFAULT NULL COMMENT '环节起始时刻',
    `step_end_time`               BIGINT(8)     DEFAULT NULL COMMENT '环节结束时刻',
    `aicheck_time`                BIGINT(8)     DEFAULT NULL COMMENT '环节的智能检测起始时刻',
    `aicheck_result`              VARCHAR(8)    DEFAULT NULL COMMENT '环节智能检测结论',
    `aicheck_desc`                VARCHAR(255)  DEFAULT NULL COMMENT '环节智能检测结论描述',
    `create_time`                 DATETIME      DEFAULT NULL COMMENT '记录创建时间',
    `modify_time`                 DATETIME      DEFAULT NULL COMMENT '记录修改时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_record_step` (`record_no`, `step_id`),
    KEY `idx_record` (`record_no`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录视频环节信息';

-- ----------------------------
-- Table structure for sl_record_video_qcfeedback
-- 双录视频质检反馈信息
-- ----------------------------
DROP TABLE IF EXISTS `sl_record_video_qcfeedback`;
CREATE TABLE `sl_record_video_qcfeedback`
(
    `id`               BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '双录视频质检反馈信息ID',
    `record_no`        VARCHAR(40) NOT NULL COMMENT '双录编号',
    `step_id`          BIGINT(8)   NOT NULL COMMENT '视频环节ID(0表示非特定环节)',
    `step_qc_result`   VARCHAR(8)  NOT NULL COMMENT '环节质检结论',
    `step_qc_feedback` TEXT     DEFAULT NULL COMMENT '环节质检反馈描述',
    `create_time`      DATETIME DEFAULT NULL COMMENT '记录创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_record_step` (`record_no`, `step_id`),
    KEY `idx_record` (`record_no`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录视频质检反馈信息';

-- ----------------------------
-- Table structure for sl_record_upload
-- 腾讯云双录上传记录
-- ----------------------------
DROP TABLE IF EXISTS `sl_record_upload`;
CREATE TABLE `sl_record_upload`
(
    `id`             BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '序号',
    `record_no`      VARCHAR(40) NOT NULL COMMENT '双录编号',
    `bucket_name`    VARCHAR(128) DEFAULT NULL COMMENT '上传桶名',
    `cos_path`      VARCHAR(255) DEFAULT NULL COMMENT '上传路径',
    `serial_num`     VARCHAR(40)  DEFAULT NULL COMMENT '上传序列号',
    `device_info`    VARCHAR(128) DEFAULT NULL COMMENT '设备信息',
    `version_num`    VARCHAR(10)  DEFAULT NULL COMMENT '前端版本号',
    `request_type`   VARCHAR(20)  DEFAULT NULL COMMENT '请求类型（枚举值：SIGN, CREDENTIAL)',
    `request_time`   DATETIME     DEFAULT NULL COMMENT '请求时间',
    `response_value` TEXT         DEFAULT NULL COMMENT '响应内容',
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_record` (`record_no`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='腾讯云双录上传记录';

-- -----------------------------------------------------
-- Create table `sl_record_task`
-- 双录的相关任务
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sl_record_task`;
CREATE TABLE `sl_record_task`
(
    `id`            BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    `record_no`     VARCHAR(40) NOT NULL COMMENT '双录编号',
    `task_type`     TINYINT(1)  NOT NULL COMMENT '任务类型(枚举值：1-UPLOAD,2-VIDEOPROC,3-QC)',
    `task_status`   TINYINT(1)  NOT NULL COMMENT '任务状态（枚举值：0-INIT,10-EXECUTING,20-FINISHED,30-FAILED)',
    `retried_count` INTEGER(4) DEFAULT 0 COMMENT '重试次数',
    `execute_time`  DATETIME   DEFAULT NULL COMMENT '上次执行时间',
    `finish_time`   DATETIME   DEFAULT NULL COMMENT '上次完成时间',
    `create_time`   DATETIME   DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `ux_record_task` (`record_no`, `task_type`),
    KEY `idx_record` (`record_no`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录的相关任务';

-- ----------------------------
-- Table structure for sl_trial
-- 双录试练记录
-- ----------------------------
DROP TABLE IF EXISTS `sl_trial`;
CREATE TABLE `sl_trial`
(
    `id`          BIGINT(8)   NOT NULL AUTO_INCREMENT COMMENT '序号',
    `organ_id`    VARCHAR(40) NOT NULL COMMENT '机构id',
    `agent_code`  VARCHAR(40) NOT NULL COMMENT '代理人工号',
    `agent_name`  VARCHAR(40)  DEFAULT NULL COMMENT '代理人姓名',
    `businums`    VARCHAR(255) DEFAULT NULL COMMENT '投保单号(多个用逗号,分隔)',
    `trial_time`  DATETIME     DEFAULT NULL COMMENT '试练时间',
    `create_time` DATETIME     DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_org` (`organ_id`),
    KEY `idx_agent` (`agent_code`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT ='双录试练记录';

