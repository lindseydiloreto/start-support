-- MariaDB dump 10.18  Distrib 10.5.8-MariaDB, for Linux (x86_64)
--
-- Host: mysql-5.7-3306.database.nitro    Database: etc_startsupport
-- ------------------------------------------------------
-- Server version	5.7.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_zfvidqzpnilpqazeqjhrgmdzuenjnjgvmikc` (`sessionId`,`volumeId`),
  KEY `idx_bafnrkeqnyjqgptxhkkqcjbiggttdevjstdx` (`volumeId`),
  CONSTRAINT `fk_qanrhysqfadjqhbwcbaqasuhhmdkoamhukje` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `uploaderId` int(11) DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_lcdrynzjsjkopegwapdfqknygppnmfubycyl` (`filename`,`folderId`),
  KEY `idx_sihbyfrqtqtjuhyjoyqlvkawrerjwjwvhvqi` (`folderId`),
  KEY `idx_izybibxemwyexsogihcwwsdcpjtmfdhffzjo` (`volumeId`),
  KEY `fk_meyuhftehcqxvzglwvvjfhyfesdttlnuwqul` (`uploaderId`),
  CONSTRAINT `fk_abwzuozuboortlwhwufoorqxvpxwomrlrnfr` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_eoshdswgdohdnfuzntjjnrmtovoohsscucml` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_meyuhftehcqxvzglwvvjfhyfesdttlnuwqul` FOREIGN KEY (`uploaderId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_qdvdjrfxmchiybibxcxxycuidioxtwkwjfsr` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `error` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_frykvsmkvqlpibfyykljgjtsswcramuvmdnk` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ywyndkmtibaoxyjzrpsmlajgozckccyonies` (`name`),
  KEY `idx_qhvxglvlvjkhafeuhzhtlbukesnbgubcfomn` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_czrsvqvbdfqkpbpwmbtqozyehtkrhbdhxrzh` (`groupId`),
  KEY `fk_wiibscokczalienkzepcvnchfyfvcpgyyjka` (`parentId`),
  CONSTRAINT `fk_lrudfemzmmulqhzjqqkcvcwvczjvginuhhop` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rhgfqupsuluwrsusbuykmwoqnazhkhvbdfdp` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wiibscokczalienkzepcvnchfyfvcpgyyjka` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_uyensvpgxadzkcfjqhnagdlxgbreehavwybb` (`name`),
  KEY `idx_aexgaobxsgichffengtvhhbkvwcxnehyorrc` (`handle`),
  KEY `idx_rdjpdxbukgvxxgiekpwllnxnbikbmyaovtdd` (`structureId`),
  KEY `idx_iwqdkfzqgsgcxakkhcganzealxslgmyiklwx` (`fieldLayoutId`),
  KEY `idx_aejnptfyhsnifufraztfkbmtmhkzrsgrzyrc` (`dateDeleted`),
  CONSTRAINT `fk_dqoxnawqmpocpjbwzpithdwapmgqwsjjmtin` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_poqflxncozhxznyltogsggusncxtbnbzbvcm` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_xcshopqjtevjijowrmrwpcqfzqiumoyrrblp` (`groupId`,`siteId`),
  KEY `idx_hbilfurswjqhlkdlkiutyiphyihlwnqewtgn` (`siteId`),
  CONSTRAINT `fk_qngdjsppwvomagatnvwvlcfhwzqksoxetnbg` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tlkveteuinjztqfijivtrxjvfvkzlhqqmkkd` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedattributes`
--

DROP TABLE IF EXISTS `changedattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedattributes` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `idx_sscivjnwfbbuoehylbtodtbkfkhzamjfxsat` (`elementId`,`siteId`,`dateUpdated`),
  KEY `fk_hgiyhmmjynpajmpknlezozknpehdwmcoutri` (`siteId`),
  KEY `fk_giartvuejaazfytkbgpojvohbjxlksicolxj` (`userId`),
  CONSTRAINT `fk_giartvuejaazfytkbgpojvohbjxlksicolxj` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_hgiyhmmjynpajmpknlezozknpehdwmcoutri` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_zyovyrkwtohegpnazjumwwwewszbznjeqkus` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedfields`
--

DROP TABLE IF EXISTS `changedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedfields` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `idx_ieexccnpesfhxajdvraybrfpbspxkfjvveca` (`elementId`,`siteId`,`dateUpdated`),
  KEY `fk_lewzsfufnmeuvdokpejofvanzlytbiscbqjd` (`siteId`),
  KEY `fk_grvjhjrutmstchofavqskonatpegasqmltlm` (`fieldId`),
  KEY `fk_lctywkjfyutxtybeykcxwnmtbndjcwevcgdg` (`userId`),
  CONSTRAINT `fk_grvjhjrutmstchofavqskonatpegasqmltlm` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_jppakumutbhmzdmtgigfqpqondjktyqvzprs` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_lctywkjfyutxtybeykcxwnmtbndjcwevcgdg` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_lewzsfufnmeuvdokpejofvanzlytbiscbqjd` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_oyhlqyrdytedkljiwftihvoahexrfgpudayp` (`elementId`,`siteId`),
  KEY `idx_rceuqyhwhvfesjdeixbpeetxmgsqwmxmvuyz` (`siteId`),
  KEY `idx_xpsidwrezzqqfmmjmsukzeeymomkgqzhdqtz` (`title`),
  CONSTRAINT `fk_sgjilpycrvxhlgokopzwpdmseygzlhcvoiuu` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wngzidwdnxiwueicjqncubrrpyeqplgfsadi` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_avxsnwksxuozeamzgfdenhpqyzxkqvdftxpa` (`userId`),
  CONSTRAINT `fk_avxsnwksxuozeamzgfdenhpqyzxkqvdftxpa` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` text,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_itgyzjyqmqckvbmxtejvgsroclqjgrlvwsvv` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `trackChanges` tinyint(1) NOT NULL DEFAULT '0',
  `dateLastMerged` datetime DEFAULT NULL,
  `saved` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_amcdhthijmgvbhvajfetwozykebsrxarqpsd` (`saved`),
  KEY `fk_aahfcubrlhslbguxqavdkpvcnehkwkklbwxu` (`creatorId`),
  KEY `fk_vqmdntjptodipcihsizufpdxsnujwyggsqip` (`sourceId`),
  CONSTRAINT `fk_aahfcubrlhslbguxqavdkpvcnehkwkklbwxu` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_vqmdntjptodipcihsizufpdxsnujwyggsqip` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_bhprpbzxkvnvxaxlhnexkefapxgiigowtiqu` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ncozcgwdrlrhzgduzqxkxynzqthbbfcydawv` (`dateDeleted`),
  KEY `idx_ilvqkkqbncozzomzgsasnycpiuazicxycdxs` (`fieldLayoutId`),
  KEY `idx_elwgpimbodbbtbriyajuwpvldzfubskchgmh` (`type`),
  KEY `idx_eiowerssljxcvyaoawevepnoejcmixfpidln` (`enabled`),
  KEY `idx_igzzjhypbwkakdnvxgqadihqhujgeagameyn` (`archived`,`dateCreated`),
  KEY `idx_nroeocqunxtoesnsyzrlxlkpjelnrkrutxvj` (`archived`,`dateDeleted`,`draftId`,`revisionId`),
  KEY `fk_wsywrzonnntqwpqujuigwyduffsygeborvdm` (`draftId`),
  KEY `fk_gjrgnbksagzbaumtlogxoqhyfgijynqknxbu` (`revisionId`),
  CONSTRAINT `fk_bgxwtfyquuvuihkvsnxkbkvpqimmciigksvb` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_gjrgnbksagzbaumtlogxoqhyfgijynqknxbu` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wsywrzonnntqwpqujuigwyduffsygeborvdm` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_tgqphqsnwpatwixnddeqqrbknywiiioujxdg` (`elementId`,`siteId`),
  KEY `idx_gykjlmoltgjjrcbauzaelbrmqbclwwqihehu` (`siteId`),
  KEY `idx_sjnpnlvgyojjfwkirpstqpcbjfhycotendxy` (`slug`,`siteId`),
  KEY `idx_lvksgxkqsyqljpwmexgrolialbtlxxyvhkwl` (`enabled`),
  KEY `idx_zgtfcuatquwimzykouodbsgcufqglsicmjqk` (`uri`,`siteId`),
  CONSTRAINT `fk_njtpmaypfsocnbfwfxmmmdhzacymwteyqqzt` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_xzaoouajjyjqyzceaqseimdosekgylpgbmxa` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_qwkeyoxtaversezqswbhibpelvwwbkzuoxca` (`postDate`),
  KEY `idx_pcpdcbkxgxlaevirsknvwingtuvqncsgeygk` (`expiryDate`),
  KEY `idx_bapktsgxxjjvlpwfgekkglshzlkkvvgdksvo` (`authorId`),
  KEY `idx_cmdnxjzbwxupucjcnyunnzbchrltilkegkkm` (`sectionId`),
  KEY `idx_odfynpcdsxhhpnnyjjzsvuwxkwfxrhlcqarb` (`typeId`),
  KEY `fk_qwptvdprtcgbdzhznchhczwihlbpwttqbera` (`parentId`),
  CONSTRAINT `fk_neevwqpgvsmcnjqdopfcrlufuyhvlhfktjjx` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_pallilybwifcdmsdfwecolzhixexflzsetnf` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_peqzuzkmjacagduospsggmycbsycwovhvtpd` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_qwptvdprtcgbdzhznchhczwihlbpwttqbera` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_wnknwsebkmypakqtmbejdcpcafuppwrkaisj` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text,
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_sgtqwkwgbxbazcdubumtsstsvrelazegjlhs` (`name`,`sectionId`),
  KEY `idx_iyfdvanjsafdaqrejupcuzbhqbjoxnibgnxu` (`handle`,`sectionId`),
  KEY `idx_bszsspjsjmftntqwqhdoycshftvsehpctkmz` (`sectionId`),
  KEY `idx_miiuvxizanvuydglsfhjgrjcknhhjizznijz` (`fieldLayoutId`),
  KEY `idx_epwgxikazhseyzbplpirqcytdtxllvofyazu` (`dateDeleted`),
  CONSTRAINT `fk_abkehpvbvdfkxmauomxmykedtgnlfksqldgl` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rdblmrluvyfkoeeqymbunaqdrxrnzmowzszp` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ygedjasfcdhwvrowkatgfmuokmyruqwdwxax` (`name`),
  KEY `idx_ftqenwnmqazueqsrvofolaxkrllvxhqodbkz` (`dateDeleted`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ohdnvgapvewhpgncjcpoxjiitswuunusjpie` (`layoutId`,`fieldId`),
  KEY `idx_hkfddzemjgactvsrbexjmdigmhdqutdimufa` (`sortOrder`),
  KEY `idx_dfkbhtedftvyczdfuulykeenabwvhnticbez` (`tabId`),
  KEY `idx_itrcsvsjhabwdpnpxwcdlbxfednofuppxcno` (`fieldId`),
  CONSTRAINT `fk_ftdavwaebzwohpleiuyanbdubqdclslaesko` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_whqaqhmtanfkouxzxwklazkldmfmzjjtlzep` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_yxkzvpfrkejetgbagaxzbxohggudznwnuhvn` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_uszenskwpulptpsbwzosjspmgvlsrukazjde` (`dateDeleted`),
  KEY `idx_fectfzpxusxvrecytxcobudyyngwogsendfl` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `elements` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_vjfmyyrlskispmowmtypqrmqwixhybcyurae` (`sortOrder`),
  KEY `idx_agaudpiohizygxambxgokvjwxcbmudfxxpgd` (`layoutId`),
  CONSTRAINT `fk_yczoysfbsbqmdqgwldobeiewlqxeuffujekr` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_jfoeajsyopcguamdnelgbipgnlkoiaghyaud` (`handle`,`context`),
  KEY `idx_vnsgbodkftsyokzzglkpaulbjrpfgqprymyg` (`groupId`),
  KEY `idx_btrsurssvuwtfxkshittgrphuvilwyggxxpt` (`context`),
  CONSTRAINT `fk_gkwuttfunlcaxxaostefnrepxjosurlcrkau` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_pdmqxuewmaittrqmataduychqxbyyaxjdfns` (`name`),
  KEY `idx_jjaaotuskcgkgxjsgiksbicqkcynwbayykoi` (`handle`),
  KEY `idx_lflrkgcbbcjezywvaaojwcjlygcecabkzwkb` (`fieldLayoutId`),
  CONSTRAINT `fk_qakywqyalzpejcsxhgkprjvctxwsodtocxba` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_wrebhrfkaxhxyaoeynkxhntadyyqkknivigm` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqlschemas`
--

DROP TABLE IF EXISTS `gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text,
  `isPublic` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqltokens`
--

DROP TABLE IF EXISTS `gqltokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqltokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_nkpsmqnozynhaqrviwifcccvoxioufgmlxet` (`accessToken`),
  UNIQUE KEY `idx_ggixaylavksllrueymbevhiorkktxxkkvsbl` (`name`),
  KEY `fk_iivuuzrwdhdkcwrdzklkxlrmodmqjiynorqn` (`schemaId`),
  CONSTRAINT `fk_iivuuzrwdhdkcwrdzklkxlrmodmqjiynorqn` FOREIGN KEY (`schemaId`) REFERENCES `gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `configVersion` char(12) NOT NULL DEFAULT '000000000000',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_fvpqpryinrqvettjsatlkdxspsauvoqqcyhc` (`ownerId`),
  KEY `idx_zhfngmoofwpqpkmznxqaoordiofppxwowjlk` (`fieldId`),
  KEY `idx_vfnsummjxgtdmhjolkfydfetsizujcbmcbtz` (`typeId`),
  KEY `idx_aftzmxzpkymbzmmpxyvjyezagmniydgxgtyi` (`sortOrder`),
  CONSTRAINT `fk_lljojvgdnvndnocaraktzjfcuogjjdcuxhwi` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_nhpcxqnddnujoxurbelyanizaggosgfmpsfx` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_pyhkfdvzzqsqhuppkfshzgkeultdxxidmjnm` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_vvmojeumedvrranmdkrweqlbnhzqtruwsgch` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_dijiylkczeylwikbgvmebblbnogvnxbkrkmm` (`name`,`fieldId`),
  KEY `idx_ybnrvhbeaziybydvypyvkexknfjfhagwhhmx` (`handle`,`fieldId`),
  KEY `idx_ggtzwpjybevocppozgaqafihpmphxzrkziwn` (`fieldId`),
  KEY `idx_sbsrtnbshrtrkyfdxcdznefqbhcayqopolih` (`fieldLayoutId`),
  CONSTRAINT `fk_bwvqtoucjtizqejqxfzpsxszfepjyhiwdmpx` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_sbynkywinhjjesdphtcasqkplottdygfgrqw` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `track` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_uyfobugdouhfgjbsdwyjkhnyswkraqvgsxrl` (`track`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','trial','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_wixvavemqetzvffifmnogsrwwdglsjcbziop` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projectconfig`
--

DROP TABLE IF EXISTS `projectconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projectconfignames`
--

DROP TABLE IF EXISTS `projectconfignames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectconfignames` (
  `uid` char(36) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `idx_onbgvvysvetyrolesugppebzzhzrxkcvvlwf` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `idx_ycmringmykxxsfcqbxjoypgzewjozsrbayrk` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_dnudfpzvivjubofwgnkswcstdhevgmoftukh` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `idx_btthwoflhyxshzetldpkthkxgdfdwbdebajz` (`sourceId`),
  KEY `idx_zkbojmsioxxzshnacxozmjveyympdqfiqtja` (`targetId`),
  KEY `idx_loxwlrrtxagwpansglowwscuffgtewjsucoy` (`sourceSiteId`),
  CONSTRAINT `fk_dosiztqaomqogoppfopqhbfnvpnhbozithio` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_klgmznrvatdoguaxciwhaxfwxjrggoeignpn` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_lywxxfqnuifrwcmuozyjpalnctfqekfjrivd` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_sojbnbhokvmnukuswyuhcoebenksalbvpkes` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_wwwgzucjqnnizoglzimskhfzngqiwhmfnkwr` (`sourceId`,`num`),
  KEY `fk_axjhigevccukysxuwzwhapdkdywdopkzzozj` (`creatorId`),
  CONSTRAINT `fk_axjhigevccukysxuwzwhapdkdywdopkzzozj` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_qlplxhpjdqgkzeasvbpydfqtatmsweqzcepi` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `idx_arsixxcjhnmttntdgogzhxeiwrflxamkgobd` (`keywords`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_zbbcoyfuiibcftmjpjezntizhyestyidvosg` (`handle`),
  KEY `idx_rsorkcdpjtghtqlnhgoqwbeanpnpxkiwkscg` (`name`),
  KEY `idx_okwpvojxwecxjsblsmneyiqzxituvtozevwy` (`structureId`),
  KEY `idx_iywwuqmieobkfxuumebeulgtrjhlaozhcaym` (`dateDeleted`),
  CONSTRAINT `fk_oxechcqrovvluzdnophecyvozxfiuymkebqt` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_eaupnjdwoqdkpesewfbjvhgenidssbjxbbbu` (`sectionId`,`siteId`),
  KEY `idx_rwtwyroazldlyttsmgwhthndrabwnrhltfmr` (`siteId`),
  CONSTRAINT `fk_nfhbytdjpnrxpkdxldkmtxrfrduonkumpipg` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_nucrrbsuafpfgabjxxwrqoxaljtclxfjczyr` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_xpjasasytnwiglzeasuobspsgmgemvesthxl` (`uid`),
  KEY `idx_ztawdvczlyzwkqxdrcncejrraaxxtvxblcvq` (`token`),
  KEY `idx_jejdwgxntmaxchrhwgdkxotzakgzddjjztac` (`dateUpdated`),
  KEY `idx_hepovwfmjgbhvpuvocrtgjorbaahfbfyylru` (`userId`),
  CONSTRAINT `fk_dolzvofxomknnafrazweeslduojrhahdonym` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_bptpzcakqjxdwqyxizbbtuqstoxkyzqhowmy` (`userId`,`message`),
  CONSTRAINT `fk_nfkyaczmmmpaxdgsonocepdxxsrtblikktgi` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_aawqtjysahozsdhfmcpbnehelunfzeiuvhzi` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_mcydnbfewolgjzdeoumluzttnhnwenyezblk` (`dateDeleted`),
  KEY `idx_dchcfgqptbwihhgbgphkpnwqtewwbawmthtj` (`handle`),
  KEY `idx_yhittuqrsrcngwuxrowxccjbouxezeiycvio` (`sortOrder`),
  KEY `fk_vcpozwvyamsftywxhqbxfvbpkqcnbsdmekdh` (`groupId`),
  CONSTRAINT `fk_vcpozwvyamsftywxhqbxfvbpkqcnbsdmekdh` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ocwjrrkwfjmcianvsdywsksfjstmniyeggoh` (`structureId`,`elementId`),
  KEY `idx_wqgsujgykcfjwlorwdyvtcmrvqttxidcdyyl` (`root`),
  KEY `idx_qwtdgztkwcakgnqydefhthosqmtvtqieegfs` (`lft`),
  KEY `idx_rgjiczoeoqflfkulxfqxunjrvpaylqlqozdd` (`rgt`),
  KEY `idx_xipdijsiuctklxijfajnsodbbzrcksrvqypb` (`level`),
  KEY `idx_mgpfwuckfogymnakezkksopbbwctxbpgmeky` (`elementId`),
  CONSTRAINT `fk_ooudgqpnuyyiibwfkvygeizbsqguxqvsyfkj` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_phanijbmnrastdohpvveabtusixbokxghpkr` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_jogtnpwzvuthkoiodfdlervzjevpcsgidqem` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_zhqvzgalktflvlqqltoxkozffnhsscejahrf` (`key`,`language`),
  KEY `idx_tambieypjlfzmphhjuigbnieqfmsjigatotw` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_qmfyvtibkilrhxgxrlkwkxhhqjudhmbmlyoe` (`name`),
  KEY `idx_erpiwslomtqgigwquojhbynqafqdmfkzkcyt` (`handle`),
  KEY `idx_mzawnroxjrfepryvzqzltqpbvqvrenekivpw` (`dateDeleted`),
  KEY `fk_ayidzctbtucwhdksglupsrcgifcrlctrqjsr` (`fieldLayoutId`),
  CONSTRAINT `fk_ayidzctbtucwhdksglupsrcgifcrlctrqjsr` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_sdwxagtdstjuelcedvnkswyjmejitminlaav` (`groupId`),
  CONSTRAINT `fk_ojgfqheoefldkktelixaukmlhsapbxlczqvf` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_skxejxhgcgnyqjjtlgbjcmmflsqgdkaldftq` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecacheelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ztduoqegezhmwvwradmjdemjdvszkgkuqjvy` (`cacheId`),
  KEY `idx_kuxmxnlyzyehnfgynnypvgdpanmxlahkvwcm` (`elementId`),
  CONSTRAINT `fk_tfshdgsztkdleuavkllnilwawgjkteurgnwt` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_zluegyibzjzusbloozbnmqsqowaluzsiphsl` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_roknqtftbibjemcwpylfodmffyzisrbroisa` (`cacheId`),
  KEY `idx_ftagsioqtwjrgnskggsokhtbqcgaoguzvecn` (`type`),
  CONSTRAINT `fk_yfvyngcqjntzsniehhsjemcvhbxklhdecwco` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_dawkkfqcnocwqrhwwtykmdbsnpwpncuhegon` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `idx_fumxlerkgucteseaczmnschelrtyahszhoaq` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `idx_hhvpeslayakfbnjipaomaexadkniqfkefgsi` (`siteId`),
  CONSTRAINT `fk_kfencvuiqtclgnyaiagmxobwlcagoabelxvz` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_xlutpwcoewiioauqxdeddozvwfdsjwckabra` (`token`),
  KEY `idx_hurexmjuxgosnbddrckcgdgkwrkrmelbcjxj` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_bilepcehgmlesiwhlqdbnkxfjussqcdjujin` (`handle`),
  KEY `idx_kcyunguokogpmviqvsbynhztamhknublptqn` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ntepbhkikrxjhqokbzvjmrohqzxwsxgxolrt` (`groupId`,`userId`),
  KEY `idx_niawliirqvsblptbqhfospmbxnarhkzkefib` (`userId`),
  CONSTRAINT `fk_xnnyziilndwkfckawvprokcwtmlkbdteupdj` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_xucpqrenfjdbobvqgvfmehjesqzevnjtbern` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_citbfkoqfyafdcsorwcooctzloykkkiysgxb` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_gkyyzzfyxwwhhhdvplkcoqfxmrgrcgbkpjyp` (`permissionId`,`groupId`),
  KEY `idx_iwvtjfsfdcrwlmkvtjgyqaquhjuvkqmbtmaf` (`groupId`),
  CONSTRAINT `fk_bwptrxkxhstrqbvwokxfnwovftuzypoiascs` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_jyftqfunyrhwfofaorlgwrpgixjxmxppzros` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_cjremocpkalbustgnhldpslcgryzciegaxmu` (`permissionId`,`userId`),
  KEY `idx_ucwpcwkxdximihbrbxdfockgndmypzbylhie` (`userId`),
  CONSTRAINT `fk_ncxgpfqlxhrbtpewgkpxcwnpjxarjcnqeblx` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_prhqhiyflheqvsdoitwnpetotxmxwvucwjqd` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `fk_xsyrclkuaxjzqluewcntmpcisejgwqcozlwe` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ljdubdohnzwgfyxsknctgnpfekzyduzslyuv` (`uid`),
  KEY `idx_moizfuiziqyxritapjtzfsikyubihxdfjrnq` (`verificationCode`),
  KEY `idx_qiwjojnmlhcahcqdegosocssntdladiypbsf` (`email`),
  KEY `idx_jwwqqpxfbsogywazktygxxndrzxsxkchjzvo` (`username`),
  KEY `fk_qoygufrkudelpzwyjeywvfhnwjbfmmnjwskh` (`photoId`),
  CONSTRAINT `fk_mkbryyyjhdshhyttjddfetnuqnljdcrjjdvg` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_qoygufrkudelpzwyjeywvfhnwjbfmmnjwskh` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ujzvddzpyrgaibmnoflckchrpciaazaeotds` (`name`,`parentId`,`volumeId`),
  KEY `idx_ztcsdrtwmnfwlryubycsmcujbxelbpcwcvej` (`parentId`),
  KEY `idx_bhzkoeazsoetrlihbqamaiuyndxiigdzpzhv` (`volumeId`),
  CONSTRAINT `fk_kinibqfhwqcewqwwmeqxwifibjyqcrqiqxbe` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_zbummzcfswjxkqllnxfcvrbzqpqgfqjrdmnx` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_wbjrkgcadrfhlupejkruzyucdflryqoyhmnh` (`name`),
  KEY `idx_ssysugvfpnohswzdzyyuvmabkccqfewqdomm` (`handle`),
  KEY `idx_infklwkpsohwwymmwaflsbcvpsyfacqrmqvj` (`fieldLayoutId`),
  KEY `idx_lxeioeytcbcjiikyzdwvdwfswhyhgjlwzyvs` (`dateDeleted`),
  CONSTRAINT `fk_pbskptwddyfworgytnmjjuskiepujgfzpuhx` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_molpkzbcnethajhqnzhopynghfkyscduwkwg` (`userId`),
  CONSTRAINT `fk_gyxstwgoswsoaufdizybpkaodyarrydlenbd` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'etc_startsupport'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-12 20:14:48
-- MariaDB dump 10.18  Distrib 10.5.8-MariaDB, for Linux (x86_64)
--
-- Host: mysql-5.7-3306.database.nitro    Database: etc_startsupport
-- ------------------------------------------------------
-- Server version	5.7.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedattributes`
--

LOCK TABLES `changedattributes` WRITE;
/*!40000 ALTER TABLE `changedattributes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `changedattributes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedfields`
--

LOCK TABLES `changedfields` WRITE;
/*!40000 ALTER TABLE `changedfields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `changedfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,1,NULL,'2021-03-16 03:57:21','2021-03-16 03:57:21','289a037d-9471-4c53-93b8-b511d0ffbe4d'),(3,3,1,'Lorem ipsum dolor sit amet','2021-03-16 05:34:14','2021-03-16 05:34:14','14a8bb4e-f333-4f74-a1ef-205764ef5cf1'),(4,4,1,'Lorem ipsum dolor sit amet','2021-03-16 05:34:14','2021-03-16 05:34:14','b6cc4cbd-6355-4a83-ab49-1a195cf314f7'),(6,6,1,'Consectetur adipiscing elit','2021-03-16 05:34:40','2021-03-16 05:34:40','d031d122-9c10-4648-be78-74d328d36361'),(7,7,1,'Consectetur adipiscing elit','2021-03-16 05:34:40','2021-03-16 05:34:40','6f34c371-bd4c-4b9d-b826-e40904dd841d'),(9,9,1,'Etiam tortor arcu, semper vitae','2021-03-16 05:34:58','2021-03-16 05:34:58','74026829-4f5b-4393-9aa0-a0e4556de2a6'),(10,10,1,'Etiam tortor arcu, semper vitae','2021-03-16 05:34:58','2021-03-16 05:34:58','62b4a27d-9329-468c-aa3b-1083e4ea38cf'),(12,12,1,'Tempus ac, lobortis eu velit','2021-03-16 05:35:15','2021-03-16 05:35:15','6084c525-b5bd-4b6a-a5e4-12596bc6c456'),(13,13,1,'Tempus ac, lobortis eu velit','2021-03-16 05:35:15','2021-03-16 05:35:15','04376108-f63c-4e63-9ac8-6813d0960f73'),(15,15,1,'Donec in turpis magna','2021-03-16 05:35:31','2021-03-16 05:35:31','05a553ca-5270-4edf-82ec-132b800a0c7c'),(16,16,1,'Donec in turpis magna','2021-03-16 05:35:31','2021-03-16 05:35:31','a807dfdf-56a8-465b-8f26-a2ab9f080e77');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `drafts`
--

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elementindexsettings` VALUES (1,'craft\\elements\\Entry','{\"sources\":{\"section:cdedd782-0fc6-4b42-b649-057561d72f0f\":{\"tableAttributes\":{\"1\":\"uri\"}}}}','2021-03-16 05:36:16','2021-03-16 05:36:16','c8be1d38-8a9e-438a-a0a8-1c7c156333eb');
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2021-03-16 03:57:21','2021-03-16 03:57:21',NULL,'082c7e3f-2887-4bd4-aa0e-43f40f3d0d33'),(3,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2021-03-16 05:34:14','2021-03-16 05:34:14',NULL,'95abe0a0-ea68-43b3-9961-bb4df277f83f'),(4,NULL,1,1,'craft\\elements\\Entry',1,0,'2021-03-16 05:34:14','2021-03-16 05:34:14',NULL,'26d696da-8bcc-4cdd-906d-785f85571807'),(6,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2021-03-16 05:34:40','2021-03-16 05:34:40',NULL,'f82ad1d5-fbef-44eb-9383-f305dbf6c6fd'),(7,NULL,2,1,'craft\\elements\\Entry',1,0,'2021-03-16 05:34:40','2021-03-16 05:34:40',NULL,'0069bdba-2a8d-4544-8573-75d5dadf4f00'),(9,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2021-03-16 05:34:58','2021-03-16 05:34:58',NULL,'f422ba96-f8a5-4acc-b997-bb531807a72a'),(10,NULL,3,1,'craft\\elements\\Entry',1,0,'2021-03-16 05:34:58','2021-03-16 05:34:58',NULL,'ba840186-67b0-4991-a30f-c290fcc83276'),(12,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2021-03-16 05:35:15','2021-03-16 05:35:15',NULL,'82936cc1-9270-4de7-b8c5-839950277d50'),(13,NULL,4,1,'craft\\elements\\Entry',1,0,'2021-03-16 05:35:15','2021-03-16 05:35:15',NULL,'6d2dbc12-9ed1-42f3-9f85-201f8d40453c'),(15,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2021-03-16 05:35:31','2021-03-16 05:35:31',NULL,'1e812e6a-8bf7-40a1-baa9-7a1eaab78306'),(16,NULL,5,1,'craft\\elements\\Entry',1,0,'2021-03-16 05:35:31','2021-03-16 05:35:31',NULL,'d7323921-692c-4ce1-85aa-3e86e96571f7');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2021-03-16 03:57:21','2021-03-16 03:57:21','c34e8f7b-80dd-41bb-9b9f-8f91caa50e3d'),(3,3,1,'lorem-ipsum-dolor-sit-amet','news/lorem-ipsum-dolor-sit-amet',1,'2021-03-16 05:34:14','2021-03-16 05:34:14','5370b78b-8058-4c94-9cc9-f0ae8a5ee78c'),(4,4,1,'lorem-ipsum-dolor-sit-amet','news/lorem-ipsum-dolor-sit-amet',1,'2021-03-16 05:34:14','2021-03-16 05:34:14','30c852da-91c1-4b53-ba4a-2caef96b73a6'),(6,6,1,'consectetur-adipiscing-elit','news/consectetur-adipiscing-elit',1,'2021-03-16 05:34:40','2021-03-16 05:34:40','f352f9c5-df88-4855-ad5d-d8052143b3e4'),(7,7,1,'consectetur-adipiscing-elit','news/consectetur-adipiscing-elit',1,'2021-03-16 05:34:40','2021-03-16 05:34:40','c6610133-e286-4c81-bd58-bc9e5be4600d'),(9,9,1,'etiam-tortor-arcu-semper-vitae','news/etiam-tortor-arcu-semper-vitae',1,'2021-03-16 05:34:58','2021-03-16 05:34:58','2123c0b0-cf86-468b-8ace-5cb55e6e7522'),(10,10,1,'etiam-tortor-arcu-semper-vitae','news/etiam-tortor-arcu-semper-vitae',1,'2021-03-16 05:34:58','2021-03-16 05:34:58','69dff3f6-eb36-49f3-95e5-0e8e7bd5e5f0'),(12,12,1,'tempus-ac-lobortis-eu-velit','news/tempus-ac-lobortis-eu-velit',1,'2021-03-16 05:35:15','2021-03-16 05:35:15','ee2a7e8e-f770-4ed4-820d-ab3852e90ab0'),(13,13,1,'tempus-ac-lobortis-eu-velit','news/tempus-ac-lobortis-eu-velit',1,'2021-03-16 05:35:15','2021-03-16 05:35:15','11063818-2d94-4f5f-8849-23cad8c65f99'),(15,15,1,'donec-in-turpis-magna','news/donec-in-turpis-magna',1,'2021-03-16 05:35:31','2021-03-16 05:35:31','b7a43211-a8ae-4e55-89d1-41e4fffffcb7'),(16,16,1,'donec-in-turpis-magna','news/donec-in-turpis-magna',1,'2021-03-16 05:35:31','2021-03-16 05:35:31','4e9bab1b-727b-4756-8e21-0693e77dd99f');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entries` VALUES (3,1,NULL,1,1,'2021-03-16 05:33:00',NULL,NULL,'2021-03-16 05:34:14','2021-03-16 05:34:14','533011b7-0a55-460f-997f-5f39161b0e3b'),(4,1,NULL,1,1,'2021-03-16 05:33:00',NULL,NULL,'2021-03-16 05:34:14','2021-03-16 05:34:14','d009f469-8054-4792-b7f1-975707c05404'),(6,1,NULL,1,1,'2021-03-16 05:34:00',NULL,NULL,'2021-03-16 05:34:40','2021-03-16 05:34:40','2652914f-b2c8-416c-8e0f-769d53fbdb52'),(7,1,NULL,1,1,'2021-03-16 05:34:00',NULL,NULL,'2021-03-16 05:34:40','2021-03-16 05:34:40','4a7669af-e98a-45ba-996c-15a95bee2d63'),(9,1,NULL,1,1,'2021-03-16 05:34:00',NULL,NULL,'2021-03-16 05:34:58','2021-03-16 05:34:58','68312407-0939-4fee-91a4-e44d189076cf'),(10,1,NULL,1,1,'2021-03-16 05:34:00',NULL,NULL,'2021-03-16 05:34:58','2021-03-16 05:34:58','c90ed402-4602-495f-8f55-2f20d5133c99'),(12,1,NULL,1,1,'2021-03-16 05:34:00',NULL,NULL,'2021-03-16 05:35:15','2021-03-16 05:35:15','2fc9ebb1-1f53-4d59-9192-cfccdcfae98e'),(13,1,NULL,1,1,'2021-03-16 05:34:00',NULL,NULL,'2021-03-16 05:35:15','2021-03-16 05:35:15','f8030f7f-8956-40e4-9db3-69852776ffaa'),(15,1,NULL,1,1,'2021-03-16 05:35:00',NULL,NULL,'2021-03-16 05:35:31','2021-03-16 05:35:31','197250b9-4080-4246-8a61-6487fe2850e2'),(16,1,NULL,1,1,'2021-03-16 05:35:00',NULL,NULL,'2021-03-16 05:35:31','2021-03-16 05:35:31','8f54c743-7429-455b-81bf-9df9c1ede782');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entrytypes` VALUES (1,1,1,'News','news',1,'site',NULL,NULL,1,'2021-03-16 05:33:09','2021-03-16 05:33:09',NULL,'870d532f-0e15-492f-b612-2993a53ff2a7');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'Common','2021-03-16 03:57:21','2021-03-16 03:57:21',NULL,'346dbf48-246e-41c7-abd1-472a53a63d84');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouts` VALUES (1,'craft\\elements\\Entry','2021-03-16 05:33:09','2021-03-16 05:33:09',NULL,'89cf31b5-5b4e-4bee-a7e5-4af567a071c0');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouttabs` VALUES (1,1,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100}]',1,'2021-03-16 05:33:09','2021-03-16 05:33:09','062eb7c3-4b72-4cc3-b708-1a74db900799');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqlschemas`
--

LOCK TABLES `gqlschemas` WRITE;
/*!40000 ALTER TABLE `gqlschemas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `gqlschemas` VALUES (1,'Public Schema','[]',1,'2021-04-12 20:13:19','2021-04-12 20:13:19','17b3017f-8b9f-41dc-958f-f1d1f2b92f6f');
/*!40000 ALTER TABLE `gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqltokens`
--

LOCK TABLES `gqltokens` WRITE;
/*!40000 ALTER TABLE `gqltokens` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `gqltokens` VALUES (1,'Public Token','__PUBLIC__',1,NULL,NULL,1,'2021-04-12 20:13:19','2021-04-12 20:13:19','ae28f6e1-56f4-496f-a697-236692988f69');
/*!40000 ALTER TABLE `gqltokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `info` VALUES (1,'3.6.11.2','3.6.7',0,'isqnbdijvnkq','ovnvogvdozoj','2021-03-16 03:57:21','2021-04-12 20:13:19','beaa6886-ed17-458a-ba8c-8a32b434d8a8');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES (1,'craft','Install','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','5a2a936c-7734-4415-a656-078e786ff207'),(2,'craft','m150403_183908_migrations_table_changes','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','780c7f45-e3b1-4ef1-87d9-a25b2cd2fdd3'),(3,'craft','m150403_184247_plugins_table_changes','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','da76431c-1692-454c-8bca-28a1ab1827ee'),(4,'craft','m150403_184533_field_version','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','f95376f4-dadb-4a7c-8111-8dfd379b5f36'),(5,'craft','m150403_184729_type_columns','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','71b71ee2-f776-41ec-84d2-926b069177df'),(6,'craft','m150403_185142_volumes','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','a18dfa30-58ee-4a55-a962-698c695172a4'),(7,'craft','m150428_231346_userpreferences','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','04ec8194-c1ae-4d38-b0c5-0005a8f9b2bb'),(8,'craft','m150519_150900_fieldversion_conversion','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','e8071c4e-6c3b-43d8-b4c3-e20d2dbfeba1'),(9,'craft','m150617_213829_update_email_settings','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','8e345e87-a371-4af9-a3aa-f4a82dc5c321'),(10,'craft','m150721_124739_templatecachequeries','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','a98b575b-c8cc-4f63-af2d-6758238f6334'),(11,'craft','m150724_140822_adjust_quality_settings','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','6d901576-4f82-4bba-bbdc-923b71e28364'),(12,'craft','m150815_133521_last_login_attempt_ip','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','ae934e95-996d-47fa-b4bf-ff0b4b4d2081'),(13,'craft','m151002_095935_volume_cache_settings','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','074705ad-d347-4efb-b842-38a370f7aef8'),(14,'craft','m151005_142750_volume_s3_storage_settings','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','9dc33781-317a-44d2-b5cd-374125d6c6b1'),(15,'craft','m151016_133600_delete_asset_thumbnails','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','6ebf56c0-1e79-40b3-9fcd-4d2ebcaae165'),(16,'craft','m151209_000000_move_logo','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','03c78d88-9853-4ebc-b849-b7150e2625e6'),(17,'craft','m151211_000000_rename_fileId_to_assetId','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','c193575e-0772-4e96-b623-ff4af63bb4af'),(18,'craft','m151215_000000_rename_asset_permissions','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','542e75e6-3029-4e6c-933a-02168131969c'),(19,'craft','m160707_000001_rename_richtext_assetsource_setting','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','a1fb7973-bfd2-45a4-9e3d-dfdf9ae849d3'),(20,'craft','m160708_185142_volume_hasUrls_setting','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','d544ddd1-b4b4-4bc8-9227-5a166ae3e0f8'),(21,'craft','m160714_000000_increase_max_asset_filesize','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','4bc9f118-40da-494b-8b30-13697569ad9e'),(22,'craft','m160727_194637_column_cleanup','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','6dbf559c-7a9c-42af-979b-7a3e6f30a679'),(23,'craft','m160804_110002_userphotos_to_assets','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','ad53b76d-f9f7-46ce-b352-be5039b5b613'),(24,'craft','m160807_144858_sites','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','4865fba7-c138-4b01-931f-7d9443e660bd'),(25,'craft','m160829_000000_pending_user_content_cleanup','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','a3ce0091-69cb-4649-9a0a-e876bb2c5fdb'),(26,'craft','m160830_000000_asset_index_uri_increase','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','0ffca3f0-5f48-4380-816d-a89b4a82acc9'),(27,'craft','m160912_230520_require_entry_type_id','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','4f31dc1b-a788-4172-8ee4-a032324e06a4'),(28,'craft','m160913_134730_require_matrix_block_type_id','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','7824468e-14c7-49fa-8bc1-aae653ec2fd2'),(29,'craft','m160920_174553_matrixblocks_owner_site_id_nullable','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','69e5cd1e-c8af-4817-a0e8-20b61c9086de'),(30,'craft','m160920_231045_usergroup_handle_title_unique','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','cfe34009-7695-4a1e-932d-eaef99270b57'),(31,'craft','m160925_113941_route_uri_parts','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','e2156517-e89d-4bb0-8203-dc69d4f686c1'),(32,'craft','m161006_205918_schemaVersion_not_null','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','c08dc8de-a9f9-4652-9439-ae4b1339c7dd'),(33,'craft','m161007_130653_update_email_settings','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','1687960e-1047-4aba-b5f6-93f03aafc3fb'),(34,'craft','m161013_175052_newParentId','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','3ed8c777-ee10-4e67-8fce-5d27995aadac'),(35,'craft','m161021_102916_fix_recent_entries_widgets','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','7af17af8-a931-4993-b45b-7b8c8faf6d63'),(36,'craft','m161021_182140_rename_get_help_widget','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','8c01dddb-40ba-4eb6-97b0-fd37751e5d48'),(37,'craft','m161025_000000_fix_char_columns','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','99795e62-007d-424e-be85-18d8427eadbc'),(38,'craft','m161029_124145_email_message_languages','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','d7e8b1a9-a5e1-4cf2-aa08-f8925efc4a46'),(39,'craft','m161108_000000_new_version_format','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','00190d47-068c-45b1-9687-b8f7fa74d25e'),(40,'craft','m161109_000000_index_shuffle','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','f0d5c801-3590-4298-9f7d-b78e113f50e4'),(41,'craft','m161122_185500_no_craft_app','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','35d78252-ad19-45d3-8cff-6954523e9397'),(42,'craft','m161125_150752_clear_urlmanager_cache','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','4e6d7b32-e58d-40b2-9f74-04bd755bd45b'),(43,'craft','m161220_000000_volumes_hasurl_notnull','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','0acd855f-cde0-4935-b3b5-6bfe73ee8ee1'),(44,'craft','m170114_161144_udates_permission','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','cf0a7044-fe87-4596-ba81-ab0a4fa4f50b'),(45,'craft','m170120_000000_schema_cleanup','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','b0cd8556-e740-4d6d-9b2a-f91258514359'),(46,'craft','m170126_000000_assets_focal_point','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','2f9869ee-7df8-4247-a64d-74f7369c646c'),(47,'craft','m170206_142126_system_name','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','f9045652-ee20-4552-9f42-0dd5192b79cb'),(48,'craft','m170217_044740_category_branch_limits','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','e642cba8-bf61-4c47-b79c-119a7e79f348'),(49,'craft','m170217_120224_asset_indexing_columns','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','a24f7a59-e2cb-4abd-b81a-3c69d772bff9'),(50,'craft','m170223_224012_plain_text_settings','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','25647c93-2e7a-4073-a94d-2f26346631ea'),(51,'craft','m170227_120814_focal_point_percentage','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','8a52601a-97cc-4106-b5c3-94f6a36e11d9'),(52,'craft','m170228_171113_system_messages','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','50aa732c-7699-4c7e-89f4-0cba468b77e8'),(53,'craft','m170303_140500_asset_field_source_settings','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','1203a775-8f1e-43ca-a3e7-381517bbb123'),(54,'craft','m170306_150500_asset_temporary_uploads','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','2448883f-b1d4-4d40-81ef-89680395b302'),(55,'craft','m170523_190652_element_field_layout_ids','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','1e8879c2-1755-431b-a246-a692cef555e1'),(56,'craft','m170621_195237_format_plugin_handles','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','7327b537-1178-43f0-862e-840f031bf5b5'),(57,'craft','m170630_161027_deprecation_line_nullable','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','7a37901f-9a21-46b4-9ecd-54cea95eac20'),(58,'craft','m170630_161028_deprecation_changes','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','217d6721-ec82-4648-80ea-48c6d53c4d27'),(59,'craft','m170703_181539_plugins_table_tweaks','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','357d669a-a635-477c-8b63-d362ee9a666f'),(60,'craft','m170704_134916_sites_tables','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','d75969f9-80c0-4b11-ae99-b618803cdba9'),(61,'craft','m170706_183216_rename_sequences','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','69fb5769-fdf6-483f-bfb7-b8a7489ef64c'),(62,'craft','m170707_094758_delete_compiled_traits','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','63b38aa1-71cb-457c-8aaf-a6fa96475d80'),(63,'craft','m170731_190138_drop_asset_packagist','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','79bda933-f2f9-416b-b0f3-24fc2d192cdf'),(64,'craft','m170810_201318_create_queue_table','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','edfad968-2e9b-41b8-bab1-65d6ee1c611a'),(65,'craft','m170903_192801_longblob_for_queue_jobs','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','9e3158c0-0338-4d2b-9125-276c9f8e8d0e'),(66,'craft','m170914_204621_asset_cache_shuffle','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','3aa1b42e-a5ce-4dc5-ac46-2ebc79753a2a'),(67,'craft','m171011_214115_site_groups','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','747b7469-5192-4949-b2f5-3f408369c200'),(68,'craft','m171012_151440_primary_site','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','327d9828-ad47-48fe-a10f-9ab835c711fb'),(69,'craft','m171013_142500_transform_interlace','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','98de6885-b176-4bea-be89-fb6866bab805'),(70,'craft','m171016_092553_drop_position_select','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','2ad8431c-3c00-4ac0-8fac-410db41576e0'),(71,'craft','m171016_221244_less_strict_translation_method','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','ebe20021-df0a-4483-9d65-517a93830a16'),(72,'craft','m171107_000000_assign_group_permissions','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','1aba3745-cc8c-46b2-8dc0-ab63c5d46b29'),(73,'craft','m171117_000001_templatecache_index_tune','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','29f3325a-fe67-48ce-a9ed-161653fa8ae5'),(74,'craft','m171126_105927_disabled_plugins','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','8970356c-1a8f-4628-8fa2-626a2d0f3350'),(75,'craft','m171130_214407_craftidtokens_table','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','09b54a8e-6efa-43bb-874f-47b907b7340a'),(76,'craft','m171202_004225_update_email_settings','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','2bb11090-c10c-462a-bbad-3242d23837ba'),(77,'craft','m171204_000001_templatecache_index_tune_deux','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','c07bb8f6-ed6b-489c-ac7d-d17a2668ec48'),(78,'craft','m171205_130908_remove_craftidtokens_refreshtoken_column','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','1e651802-4d16-4b7c-a87e-9a5567a72483'),(79,'craft','m171218_143135_longtext_query_column','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','4cccbcce-e65f-42fe-a6f0-f7860e02afac'),(80,'craft','m171231_055546_environment_variables_to_aliases','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','ad060702-e641-406e-a1f8-249871e56667'),(81,'craft','m180113_153740_drop_users_archived_column','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','9038faa0-264a-4eb9-8222-463ccaaa9f9a'),(82,'craft','m180122_213433_propagate_entries_setting','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','35f6d9c5-81bc-4452-a9e1-dc5e30de44f5'),(83,'craft','m180124_230459_fix_propagate_entries_values','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','c3ab7b73-0fee-43fe-babf-1759cadeec82'),(84,'craft','m180128_235202_set_tag_slugs','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','7f133ff9-248a-4388-9c97-bbd03bdfc677'),(85,'craft','m180202_185551_fix_focal_points','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','a74684c0-8af0-4ba5-a7d5-027daba092ac'),(86,'craft','m180217_172123_tiny_ints','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','2a3591d2-8fc6-4739-8b06-737d3a7add75'),(87,'craft','m180321_233505_small_ints','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','1dfd9d8d-869e-485d-b935-4c91880c29e6'),(88,'craft','m180404_182320_edition_changes','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','c7121bca-c09d-4851-a7db-8b9a94e64cce'),(89,'craft','m180411_102218_fix_db_routes','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','51aa95e9-0a87-4ff6-9076-a0d7c48600b5'),(90,'craft','m180416_205628_resourcepaths_table','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','2164b5bd-3c00-4b95-9dbb-0930f35a01f9'),(91,'craft','m180418_205713_widget_cleanup','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','e334d85b-ecbe-4a35-bca7-16e461f5df11'),(92,'craft','m180425_203349_searchable_fields','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','a7ef419b-0c7a-4e95-97e4-2689b869a289'),(93,'craft','m180516_153000_uids_in_field_settings','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','f421e3e1-123b-4720-a9cb-b25c666dfab3'),(94,'craft','m180517_173000_user_photo_volume_to_uid','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','ddd396a0-7cc2-4435-8951-a3171d759f8f'),(95,'craft','m180518_173000_permissions_to_uid','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','870a5359-470b-4728-85b7-424e4d8e3ba9'),(96,'craft','m180520_173000_matrix_context_to_uids','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','0cd05415-5a2d-4c17-a2dd-3914a9a29596'),(97,'craft','m180521_172900_project_config_table','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','3b2e5915-117d-4124-ab83-ac0b846c6ff9'),(98,'craft','m180521_173000_initial_yml_and_snapshot','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','895cf93f-14f4-409c-921b-02c427cc3314'),(99,'craft','m180731_162030_soft_delete_sites','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','ed8e6207-d873-4232-b124-0cad7294d894'),(100,'craft','m180810_214427_soft_delete_field_layouts','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','1b5b0497-f491-4ba2-a743-df1c7be126b9'),(101,'craft','m180810_214439_soft_delete_elements','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','ed382c37-921a-4ba0-b773-143fbd59fa11'),(102,'craft','m180824_193422_case_sensitivity_fixes','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','cbc092ee-fa56-446d-b497-7bfbf66f4be3'),(103,'craft','m180901_151639_fix_matrixcontent_tables','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','f98170cd-061e-430a-9cb8-3386a5c41ef7'),(104,'craft','m180904_112109_permission_changes','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','c05a6ac9-de52-4357-a93c-c90e4fd07e1b'),(105,'craft','m180910_142030_soft_delete_sitegroups','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','d5fe31a7-531e-4e57-bbfd-77065cee53db'),(106,'craft','m181011_160000_soft_delete_asset_support','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','13573dcf-85b9-4fd5-ab34-d80b805048e8'),(107,'craft','m181016_183648_set_default_user_settings','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','3c7b745f-1ba1-4c06-b2a6-32d8a4d5d212'),(108,'craft','m181017_225222_system_config_settings','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','11d6c90b-d06f-453f-bb61-a44f5421f13c'),(109,'craft','m181018_222343_drop_userpermissions_from_config','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','481c2a69-4c34-4294-af25-8392e32a0c24'),(110,'craft','m181029_130000_add_transforms_routes_to_config','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','3dd25121-b616-4913-931f-787447c446a4'),(111,'craft','m181112_203955_sequences_table','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','ef076720-3112-43a8-a687-0a6ead25de66'),(112,'craft','m181121_001712_cleanup_field_configs','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','b20a8d91-689f-4d0b-b223-ea568f910745'),(113,'craft','m181128_193942_fix_project_config','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','213ea66f-f150-4490-877d-f301c018c61d'),(114,'craft','m181130_143040_fix_schema_version','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','d9588060-8bbc-43bc-8b70-23f03f7f295a'),(115,'craft','m181211_143040_fix_entry_type_uids','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','3833a783-0d27-49ce-952a-548cddabf496'),(116,'craft','m181217_153000_fix_structure_uids','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','76d54786-65b8-43f2-a5e0-63cf72936372'),(117,'craft','m190104_152725_store_licensed_plugin_editions','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','575aa22e-3480-4e2d-8c7f-9e0b29ef280f'),(118,'craft','m190108_110000_cleanup_project_config','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','48c67281-b4fb-43cd-a75c-6eb75b68285a'),(119,'craft','m190108_113000_asset_field_setting_change','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','000fd945-928f-42c5-853e-1fa011ba334e'),(120,'craft','m190109_172845_fix_colspan','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','2f96f83c-940c-4f65-a4eb-3ab947051c21'),(121,'craft','m190110_150000_prune_nonexisting_sites','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','63f99884-d557-4a5d-b908-a2796200279d'),(122,'craft','m190110_214819_soft_delete_volumes','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','86d6f257-37ca-480a-90c7-b295313d66c0'),(123,'craft','m190112_124737_fix_user_settings','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','80a19893-b1d6-4721-be90-c1137af753aa'),(124,'craft','m190112_131225_fix_field_layouts','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','217f5142-057e-4ecc-b5dc-1749a6d0d450'),(125,'craft','m190112_201010_more_soft_deletes','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','e4984c22-7631-4f66-962d-e5631b632243'),(126,'craft','m190114_143000_more_asset_field_setting_changes','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','8a7db609-a2bf-490c-946e-92b700ca3573'),(127,'craft','m190121_120000_rich_text_config_setting','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','c1e5d214-4ba9-409b-b197-ea4d6f73ced3'),(128,'craft','m190125_191628_fix_email_transport_password','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','b1962130-fc4b-440d-bb78-0319eec24f3c'),(129,'craft','m190128_181422_cleanup_volume_folders','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','1f327331-7bd8-41db-8142-74ac6718a2a7'),(130,'craft','m190205_140000_fix_asset_soft_delete_index','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','b269cb4e-3305-48a3-bb7e-5f6bab44c0c2'),(131,'craft','m190218_143000_element_index_settings_uid','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','58890896-18b0-4d88-aa50-5aee33eb0078'),(132,'craft','m190312_152740_element_revisions','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','029c1c60-d879-4715-8dca-93af08f5b434'),(133,'craft','m190327_235137_propagation_method','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','2120ffa6-76ad-43d3-b07f-194159f73d10'),(134,'craft','m190401_223843_drop_old_indexes','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','6f3d7edd-93f5-4007-a2b5-23dc95024040'),(135,'craft','m190416_014525_drop_unique_global_indexes','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','66643211-e74b-49d9-9ab4-fe541d12944a'),(136,'craft','m190417_085010_add_image_editor_permissions','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','edb1a885-8b52-4aed-807f-d85002439b5c'),(137,'craft','m190502_122019_store_default_user_group_uid','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','bad7caf9-a39b-4b7c-ae44-60d8e61588eb'),(138,'craft','m190504_150349_preview_targets','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','2e14c326-c98c-4717-9e84-122f87e5c071'),(139,'craft','m190516_184711_job_progress_label','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','2641718d-cb76-46c5-9333-39767856babb'),(140,'craft','m190523_190303_optional_revision_creators','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','2dbcc74a-5f28-4fff-a630-9b31f55643d0'),(141,'craft','m190529_204501_fix_duplicate_uids','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','ec5b9b93-a603-44a2-ab54-3a8506ce4540'),(142,'craft','m190605_223807_unsaved_drafts','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','ef15c7c7-0cf6-476e-a436-773024fec1c9'),(143,'craft','m190607_230042_entry_revision_error_tables','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','05df0a23-d966-4c12-bdac-beddb57e4382'),(144,'craft','m190608_033429_drop_elements_uid_idx','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','a846d1fb-0318-401c-834a-441e1f1d5fda'),(145,'craft','m190617_164400_add_gqlschemas_table','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','2b732d7d-4d87-48b9-9509-374741084068'),(146,'craft','m190624_234204_matrix_propagation_method','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','766dc7d3-ad08-46af-89dd-b8358be127e6'),(147,'craft','m190711_153020_drop_snapshots','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','8e2a2392-8dd7-40d3-b614-395c55b44440'),(148,'craft','m190712_195914_no_draft_revisions','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','063aaecf-f89b-46b0-9bc3-ede8d00da56d'),(149,'craft','m190723_140314_fix_preview_targets_column','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','fb6bc6fa-5df6-43ec-914f-f2c287d35bf5'),(150,'craft','m190820_003519_flush_compiled_templates','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','3ae31dc5-4808-430e-9605-b7de8c00ccd2'),(151,'craft','m190823_020339_optional_draft_creators','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','cac4bd74-a602-40c3-bf96-6af706589930'),(152,'craft','m190913_152146_update_preview_targets','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','d1066a2d-10d1-4650-9bfd-67ed0aed088c'),(153,'craft','m191107_122000_add_gql_project_config_support','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','bf880c30-ab83-4608-b0bd-67157faf77c1'),(154,'craft','m191204_085100_pack_savable_component_settings','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','d4954993-f9da-4efe-8d35-d81ff13e66f8'),(155,'craft','m191206_001148_change_tracking','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','8ef473b0-286c-4012-a486-b052ff072a37'),(156,'craft','m191216_191635_asset_upload_tracking','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','f9aede47-57f4-4e00-8517-05473d6639f0'),(157,'craft','m191222_002848_peer_asset_permissions','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','b678b988-989f-4ad7-8f96-14c4b406eb52'),(158,'craft','m200127_172522_queue_channels','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','3a877a97-6cab-4907-b771-4ba34a8afea4'),(159,'craft','m200211_175048_truncate_element_query_cache','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','bb86fc1f-4d6b-4339-b6a7-fe5554f23d69'),(160,'craft','m200213_172522_new_elements_index','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','a395326b-9708-48bf-807a-64c3bddb617d'),(161,'craft','m200228_195211_long_deprecation_messages','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','153f26d0-6e4c-4bd0-a75d-480220285c1a'),(162,'craft','m200306_054652_disabled_sites','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','52d5ce87-cd64-4afc-838d-c33c5a2ca4e1'),(163,'craft','m200522_191453_clear_template_caches','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','9a4cba0f-15d7-4747-9031-898da78d86c0'),(164,'craft','m200606_231117_migration_tracks','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','b1974519-37e6-45d2-842f-b4271daa4dab'),(165,'craft','m200619_215137_title_translation_method','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','1db29f11-42fa-4a7f-8694-bf55e81d6a20'),(166,'craft','m200620_005028_user_group_descriptions','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','aca34a63-727b-4d9c-aa8b-b5cd3d4f92ea'),(167,'craft','m200620_230205_field_layout_changes','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','1fd59795-cc34-41f8-914c-f7a4620d5d75'),(168,'craft','m200625_131100_move_entrytypes_to_top_project_config','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','04e3c7c8-c933-4679-a968-7dc22008b355'),(169,'craft','m200629_112700_remove_project_config_legacy_files','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','0e3f6556-bde9-4102-a383-7323341c3488'),(170,'craft','m200630_183000_drop_configmap','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','eab5e6b2-56c0-4f5b-8527-020a6f944baf'),(171,'craft','m200715_113400_transform_index_error_flag','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','ccf51b8b-530f-40bc-b41f-22fbd3cf036e'),(172,'craft','m200716_110900_replace_file_asset_permissions','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','c92ceea4-e3a0-421c-a81c-ae331b750be9'),(173,'craft','m200716_153800_public_token_settings_in_project_config','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','1256ec22-8d17-483a-9727-fa416a96e7aa'),(174,'craft','m200720_175543_drop_unique_constraints','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','3f963c70-d341-42ec-bf2a-27412b56becc'),(175,'craft','m200825_051217_project_config_version','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','283954b9-fcfd-4653-a3db-1bad757dd451'),(176,'craft','m201116_190500_asset_title_translation_method','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','073080ce-2f8a-43b5-b367-dc521e17b61e'),(177,'craft','m201124_003555_plugin_trials','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','501cf4bc-63d8-42dd-bd2a-4f44bf6aff0a'),(178,'craft','m210209_135503_soft_delete_field_groups','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','c67d5688-ba1a-4f18-ad0c-9694208500a6'),(179,'craft','m210212_223539_delete_invalid_drafts','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','ee38d944-7a00-495c-8862-37c75fddfb3f'),(180,'craft','m210214_202731_track_saved_drafts','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','70c14866-bc1d-4d72-bf03-eea61022e8bb'),(181,'craft','m210223_150900_add_new_element_gql_schema_components','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','0e9e9bb2-7f99-43f1-ad1d-cf89b7ff71c7'),(182,'craft','m210224_162000_add_projectconfignames_table','2021-03-16 03:57:22','2021-03-16 03:57:22','2021-03-16 03:57:22','5ef2744c-07d8-4897-b1c4-0d9082a44c22'),(183,'craft','m210326_132000_invalidate_projectconfig_cache','2021-04-12 20:12:22','2021-04-12 20:12:22','2021-04-12 20:12:22','63263b47-3ae5-42ca-ba2a-0fb50052b60e');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `plugins` VALUES (1,'cp-field-inspect','1.2.4','1.0.0','unknown',NULL,'2021-03-16 04:34:30','2021-03-16 04:34:30','2021-04-12 20:13:04','e0c68430-82d9-493b-aff4-72b3998d0d85'),(2,'dashboard-begone','1.0.1','1.0.0','unknown',NULL,'2021-03-16 04:34:45','2021-03-16 04:34:45','2021-04-12 20:13:04','b53df91c-ccba-4aeb-9b89-b9a2aa0114e5'),(3,'mailgun','1.4.3','1.0.0','unknown',NULL,'2021-03-16 04:35:05','2021-03-16 04:35:05','2021-04-12 20:13:04','99d5c015-8aeb-4e9f-aa66-981530b3ced6'),(4,'sidebar-admin-links','1.1.0','1.0.0','unknown',NULL,'2021-03-17 04:04:47','2021-03-17 04:04:47','2021-04-12 20:13:04','fe8e1f6f-143e-46f4-ba6b-db78bf1b2eb1');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `projectconfig`
--

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `projectconfig` VALUES ('dateModified','1618258398'),('email.fromEmail','\"$BUSINESS_EMAIL\"'),('email.fromName','\"$BUSINESS_NAME\"'),('email.replyToEmail','null'),('email.template','null'),('email.transportSettings.apiKey','\"$MAILGUN_APIKEY\"'),('email.transportSettings.domain','\"$MAILGUN_DOMAIN\"'),('email.transportSettings.endpoint','\"$MAILGUN_ENDPOINT\"'),('email.transportType','\"craft\\\\mailgun\\\\MailgunAdapter\"'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.autocapitalize','true'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.autocomplete','false'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.autocorrect','true'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.class','null'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.disabled','false'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.id','null'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.instructions','null'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.label','null'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.max','null'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.min','null'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.name','null'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.orientation','null'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.placeholder','null'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.readonly','false'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.requirable','false'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.size','null'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.step','null'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.tip','null'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.title','null'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.warning','null'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.elements.0.width','100'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.name','\"Content\"'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.fieldLayouts.89cf31b5-5b4e-4bee-a7e5-4af567a071c0.tabs.0.sortOrder','1'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.handle','\"news\"'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.hasTitleField','true'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.name','\"News\"'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.section','\"cdedd782-0fc6-4b42-b649-057561d72f0f\"'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.sortOrder','1'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.titleFormat','null'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.titleTranslationKeyFormat','null'),('entryTypes.870d532f-0e15-492f-b612-2993a53ff2a7.titleTranslationMethod','\"site\"'),('fieldGroups.346dbf48-246e-41c7-abd1-472a53a63d84.name','\"Common\"'),('graphql.publicToken.enabled','true'),('graphql.publicToken.expiryDate','null'),('graphql.schemas.17b3017f-8b9f-41dc-958f-f1d1f2b92f6f.isPublic','true'),('graphql.schemas.17b3017f-8b9f-41dc-958f-f1d1f2b92f6f.name','\"Public Schema\"'),('plugins.cp-field-inspect.edition','\"standard\"'),('plugins.cp-field-inspect.enabled','true'),('plugins.cp-field-inspect.schemaVersion','\"1.0.0\"'),('plugins.dashboard-begone.edition','\"standard\"'),('plugins.dashboard-begone.enabled','true'),('plugins.dashboard-begone.schemaVersion','\"1.0.0\"'),('plugins.mailgun.edition','\"standard\"'),('plugins.mailgun.enabled','true'),('plugins.mailgun.schemaVersion','\"1.0.0\"'),('plugins.sidebar-admin-links.edition','\"standard\"'),('plugins.sidebar-admin-links.enabled','true'),('plugins.sidebar-admin-links.schemaVersion','\"1.0.0\"'),('sections.cdedd782-0fc6-4b42-b649-057561d72f0f.enableVersioning','true'),('sections.cdedd782-0fc6-4b42-b649-057561d72f0f.handle','\"news\"'),('sections.cdedd782-0fc6-4b42-b649-057561d72f0f.name','\"News\"'),('sections.cdedd782-0fc6-4b42-b649-057561d72f0f.propagationMethod','\"all\"'),('sections.cdedd782-0fc6-4b42-b649-057561d72f0f.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.enabledByDefault','true'),('sections.cdedd782-0fc6-4b42-b649-057561d72f0f.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.hasUrls','true'),('sections.cdedd782-0fc6-4b42-b649-057561d72f0f.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.template','\"news/_entry\"'),('sections.cdedd782-0fc6-4b42-b649-057561d72f0f.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.uriFormat','\"news/{slug}\"'),('sections.cdedd782-0fc6-4b42-b649-057561d72f0f.type','\"channel\"'),('siteGroups.57cd948a-2dfe-4550-b0f2-053ee01da77c.name','\"Default\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.baseUrl','\"$SITE_BASEURL\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.enabled','true'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.handle','\"default\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.hasUrls','true'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.language','\"en-US\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.name','\"$BUSINESS_NAME\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.primary','true'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.siteGroup','\"57cd948a-2dfe-4550-b0f2-053ee01da77c\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.sortOrder','1'),('system.edition','\"solo\"'),('system.live','true'),('system.name','\"$BUSINESS_NAME\"'),('system.retryDuration','null'),('system.schemaVersion','\"3.6.7\"'),('system.timeZone','\"America/Los_Angeles\"'),('users.allowPublicRegistration','false'),('users.defaultGroup','null'),('users.photoSubpath','null'),('users.photoVolumeUid','null'),('users.requireEmailVerification','true');
/*!40000 ALTER TABLE `projectconfig` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `projectconfignames`
--

LOCK TABLES `projectconfignames` WRITE;
/*!40000 ALTER TABLE `projectconfignames` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `projectconfignames` VALUES ('17b3017f-8b9f-41dc-958f-f1d1f2b92f6f','Public Schema'),('1891a55f-7f04-4fc8-abfd-3fd84207d90b','$BUSINESS_NAME'),('346dbf48-246e-41c7-abd1-472a53a63d84','Common'),('57cd948a-2dfe-4550-b0f2-053ee01da77c','Default'),('870d532f-0e15-492f-b612-2993a53ff2a7','News'),('cdedd782-0fc6-4b42-b649-057561d72f0f','News');
/*!40000 ALTER TABLE `projectconfignames` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `resourcepaths` VALUES ('105f501b','@app/web/assets/craftsupport/dist'),('1372a18a','@app/web/assets/generalsettings/dist'),('13e52610','@lib/jquery-touch-events'),('14411ad2','@lib/picturefill'),('16065eac','@app/web/assets/updateswidget/dist'),('1ae43a83','@lib/d3'),('1bdd9ce1','@lib/iframe-resizer'),('20906d8f','@app/web/assets/updates/dist'),('21a43b4','@lib/jquery-ui'),('252ddd','@app/web/assets/dbbackup/dist'),('29592d05','@lib/garnishjs'),('2ab4159e','@app/web/assets/plugins/dist'),('31a72d83','@app/web/assets/recententries/dist'),('3c1ff93b','@lib/fabric'),('3c3d91c9','@lib/vue'),('3ded125e','@lib/element-resize-detector'),('403f3756','@lib/selectize'),('42f3becd','@lib/selectize'),('489ffa47','@lib/xregexp'),('4a5373dc','@lib/xregexp'),('4cb3d811','@lib/velocity'),('4dd4aea3','@craft/web/assets/updates/dist'),('509477f9','@lib/jquery.payment'),('50d050f2','@craft/web/assets/admintable/dist'),('54646649','@app/web/assets/updates/dist'),('5d3ae3c6','@app/web/assets/feed/dist'),('5d3c2f6c','@bower/jquery/dist'),('644ff1f7','@app/web/assets/sites/dist'),('6bc8caa5','@craft/web/assets/fields/dist'),('716469cc','@app/web/assets/dashboard/dist'),('727b0ffe','@app/web/assets/cp/dist'),('75baf7b8','@lib/axios'),('7760a232','@lib/timepicker'),('7cace404','@lib/element-resize-detector'),('819d92d','@craft/web/assets/cp/dist'),('8329eca','@lib/jquery-touch-events'),('833c9e8f','@bower/jquery/dist'),('85e83e6f','@lib/selectize'),('863f84d2','@lib/fileupload'),('8964d128','@lib/velocity'),('8969943c','@lib/d3'),('8a9cbbc5','@lib/iframe-resizer'),('8ba858b3','@lib/velocity'),('8cc2f1b8','@app/web/assets/recententries/dist'),('8e61014f','@craft/web/assets/plugins/dist'),('8e94c61a','@lib/jquery.payment'),('905d96b','@danieltott/sidebaradminlinks/assetbundles/sidebaradminlinks/dist'),('91a36c1c','@craft/web/assets/editsection/dist'),('93c5fab0','@craft/web/assets/feed/dist'),('95437ec0','@lib/jquery.payment'),('95ff1c73','@craft/web/assets/updateswidget/dist'),('969f4ba4','@lib/xregexp'),('984e4eee','@lib/axios'),('98eb2655','@bower/jquery/dist'),('9e1bae23','@app/web/assets/utilities/dist'),('9f0ceea2','@app/web/assets/craftsupport/dist'),('9fe1c4de','@craft/web/assets/pluginstore/dist'),('a243b','@lib/iframe-resizer'),('a3cfb2fb','@lib/garnishjs'),('a4d67039','@craft/web/assets/login/dist'),('ab638297','@app/web/assets/updateswidget/dist'),('af4c03bf','@app/web/assets/login/dist'),('b25e6f5c','@craft/web/assets/recententries/dist'),('b2692780','@app/web/assets/cp/dist'),('b32eec5','@app/web/assets/login/dist'),('b5cbf6b5','@craft/web/assets/craftsupport/dist'),('b68966c5','@lib/fabric'),('b77b8da0','@lib/element-resize-detector'),('bf5cd1b9','@craft/web/assets/dbbackup/dist'),('c77e7288','@lib/fileupload'),('c7cd4a8d','@lib/jquery-ui'),('c8286266','@lib/d3'),('ca91b2c','@lib/fileupload'),('cbab6f0b','@craft/web/assets/sites/dist'),('cd1a0ac4','@lib/axios'),('d19613eb','@lib/picturefill'),('d2695d7f','@app/web/assets/feed/dist'),('d33b2f3a','@craft/web/assets/editentry/dist'),('d573fd28','@craft/web/assets/utilities/dist'),('d6322f29','@lib/jquery-touch-events'),('dc1af257','@lib/jquery-ui'),('e23d202a','@lib/vue'),('e28e44a1','@lib/garnishjs'),('eaefa5e5','@app/web/assets/utilities/dist'),('ebb734f3','@danieltott/sidebaradminlinks/assetbundles/sidebaradminlinks/dist'),('f39ded3a','@craft/web/assets/dashboard/dist'),('f627557c','@danieltott/sidebaradminlinks/assetbundles/sidebaradminlinks/dist'),('f7c8909f','@lib/fabric'),('f96a208','@lib/picturefill'),('fb8cc4d7','@appicons'),('fc60ecb2','@app/web/assets/cp/dist'),('fe37d775','@app/web/assets/dashboard/dist');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `revisions` VALUES (1,3,1,1,''),(2,6,1,1,''),(3,9,1,1,''),(4,12,1,1,''),(5,15,1,1,'');
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `searchindex` VALUES (1,'email',0,1,' support doublesecretagency com '),(1,'firstname',0,1,''),(1,'fullname',0,1,''),(1,'lastname',0,1,''),(1,'slug',0,1,''),(1,'username',0,1,' support doublesecretagency com '),(3,'slug',0,1,' lorem ipsum dolor sit amet '),(3,'title',0,1,' lorem ipsum dolor sit amet '),(6,'slug',0,1,' consectetur adipiscing elit '),(6,'title',0,1,' consectetur adipiscing elit '),(9,'slug',0,1,' etiam tortor arcu semper vitae '),(9,'title',0,1,' etiam tortor arcu semper vitae '),(12,'slug',0,1,' tempus ac lobortis eu velit '),(12,'title',0,1,' tempus ac lobortis eu velit '),(15,'slug',0,1,' donec in turpis magna '),(15,'title',0,1,' donec in turpis magna ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections` VALUES (1,NULL,'News','news','channel',1,'all',NULL,'2021-03-16 05:33:09','2021-03-16 05:33:09',NULL,'cdedd782-0fc6-4b42-b649-057561d72f0f');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections_sites` VALUES (1,1,1,1,'news/{slug}','news/_entry',1,'2021-03-16 05:33:09','2021-03-16 05:33:09','9de4aa5e-cef8-4043-8767-911c5519782c');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sitegroups` VALUES (1,'Default','2021-03-16 03:57:21','2021-03-16 03:57:21',NULL,'57cd948a-2dfe-4550-b0f2-053ee01da77c'),(2,'Support','2021-03-16 03:57:21','2021-03-16 04:41:26','2021-03-16 04:41:26','6e6b14bc-1a96-45e9-9eb7-1b912125958e');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sites` VALUES (1,1,1,1,'$BUSINESS_NAME','default','en-US',1,'$SITE_BASEURL',1,'2021-03-16 03:57:21','2021-03-16 04:39:51',NULL,'1891a55f-7f04-4fc8-abfd-3fd84207d90b'),(2,2,0,1,'$BUSINESS_NAME','other','en-US',1,'$SITE_BASEURL',1,'2021-03-16 03:57:21','2021-03-16 04:39:51','2021-03-16 04:41:09','310ba39b-5558-4721-b083-904b69997c25');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\"}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (1,'support@doublesecretagency.com',NULL,NULL,NULL,'support@doublesecretagency.com','$2y$13$mi8NDt2ERJsRqv75bmOJ4.GEl6Av2SA8IJCCWjrCSnV2d9Btf2Zem',1,0,0,0,'2021-04-12 20:08:41',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2021-03-16 03:57:21','2021-03-16 03:57:21','2021-04-12 20:08:41','61664a7f-d291-4d0d-9c0a-a35bffc8be28');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"siteId\":2,\"section\":\"*\",\"limit\":10}',1,'2021-03-16 04:05:00','2021-03-16 04:05:00','c68ba0e7-845d-4a87-9804-e2c39fbe2796'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2021-03-16 04:05:00','2021-03-16 04:05:00','88ad7c3b-c312-46e8-9d50-1d7db0a96275'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2021-03-16 04:05:00','2021-03-16 04:05:00','50c9f3d3-1700-4894-a79a-25108e95f3f3'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2021-03-16 04:05:00','2021-03-16 04:05:00','9fb5bc49-a4d5-4c27-8b4e-5fe76e5ee20c');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'etc_startsupport'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-12 20:14:49
