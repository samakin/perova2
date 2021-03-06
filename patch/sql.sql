-- 1
DROP TABLE IF EXISTS PC_ALT_ARTICLES;
CREATE TABLE PC_ALT_ARTICLES
(
  ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ORIGINAL VARCHAR(64) NOT NULL,
  ALTERNATIVE VARCHAR(64) NOT NULL
);
ALTER TABLE `PC_ALT_ARTICLES` ADD UNIQUE `unique_org_alt`(`ORIGINAL`, `ALTERNATIVE`);

-- 2
DROP TABLE IF EXISTS PC_MAIL_IMPORTER_CRONTAB;
CREATE TABLE PC_MAIL_IMPORTER_CRONTAB
(
  ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  STATUS TINYINT DEFAULT 1 NOT NULL,
  TIME_START DATETIME NOT NULL,
  TIME_END DATETIME,
  CSV_PATH VARCHAR(255),
  MAIL_DATE_SENT DATETIME,
  REASON LONGTEXT
);

-- 3
DROP TABLE IF EXISTS TDM_PRICES;
CREATE TABLE TDM_PRICES
(
  ID INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  BKEY VARCHAR(64) NOT NULL,
  AKEY VARCHAR(64) NOT NULL,
  ARTICLE VARCHAR(32) NOT NULL,
  ALT_NAME VARCHAR(128) DEFAULT '' NOT NULL,
  BRAND VARCHAR(32) NOT NULL,
  PRICE FLOAT(12,2) NOT NULL,
  TYPE INT(2) NOT NULL,
  CURRENCY VARCHAR(3) NOT NULL,
  DAY INT(4) NOT NULL,
  AVAILABLE INT(4) NOT NULL,
  SUPPLIER VARCHAR(32) NOT NULL,
  STOCK VARCHAR(32) NOT NULL,
  OPTIONS VARCHAR(64) NOT NULL,
  CODE VARCHAR(32) NOT NULL,
  DATE VARCHAR(10) NOT NULL,
  PC_MODEL VARCHAR(36),
  PC_SKU VARCHAR(36),
  PC_MANUFACTURER VARCHAR(36),
  PRIMARY KEY (ID)
);
CREATE INDEX IDX_BA_KEY ON TDM_PRICES (BKEY, AKEY);
CREATE INDEX IDX_AB_KEY ON TDM_PRICES (AKEY, BKEY);
CREATE INDEX IDX_CROSS_GENERATION ON TDM_PRICES (PC_MODEL, AKEY, BKEY);

UPDATE TDM_LANGS SET VALUE = 'Цена магазин (грн.)' WHERE CODE = 'PRICE_OPTION_SET' AND LANG = 'ru';
UPDATE TDM_LANGS SET VALUE = 'грн.' WHERE CODE = 'Pcs' AND LANG = 'ru';

-- Install PC Autopart Brands Module
DROP TABLE IF EXISTS oc_pc_autopart_brands;
CREATE TABLE oc_pc_autopart_brands
(
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  brand VARCHAR(255) NOT NULL,
  website VARCHAR(255),
  logo VARCHAR(255),
  description LONGTEXT,
  PRIMARY KEY (id),
  CONSTRAINT unq_oc_pc_autopart_brands_brand UNIQUE (brand)
);

ALTER TABLE `TDM_PRICES` ADD COLUMN `PC_OC_CROSS_ID` INT(11);
ALTER TABLE `TDM_PRICES` ADD UNIQUE `UNQ_PC_OC_CROSS_ID` (`PC_OC_CROSS_ID`);
