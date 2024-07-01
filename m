Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B7525622
	for <linux-modules@vger.kernel.org>; Mon,  1 Jul 2024 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825797; cv=fail; b=K4uq1rfbYzFpv3JAT4JV1b+uK+LFU23ZGxCInZwX6fZ0LLRARpU5e+JGYPWbcQO2Jk7dgJ3pMgv/uQH2QLEjagNOiPHkj5jajVhqhlmb+F3KRViNFHyxSXLEV1T3VxG67dOPiWdKJQMCxWsb0moWjKD2Owo0dPck5nfAA8L2BCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825797; c=relaxed/simple;
	bh=lXfdhgYweNTWsVkWUzvETQJ8PZwlZr9ufdDoQxpX2aE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RMnx3GgHttu50pfn9+YLr6Tw9tQJDrZPd04FaRph+f4IxWuB9ewd96lPGXnYFT5IwG6ONpctRNp4L8MBwI1jVMRdzrYq3FVAUGKHimnAH9ks/g3PguGYF1TJpxGC119enYK6suivfgmjlieYXJG+i8qF2xugPovDL+4LyvgMpAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=ajeTx9K2; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=nS325dyk; arc=fail smtp.client-ip=173.37.142.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ajeTx9K2";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="nS325dyk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=9337; q=dns/txt; s=iport;
  t=1719825795; x=1721035395;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/HCqw0cGcQXablblfl3kzSdSbxIOUclCYuhYeEuezQs=;
  b=ajeTx9K28LYGsS6ftRTgC3D5m5ejwNz/JZ8FXBVLD5VHCeB3elK//WWc
   Xtlyx7zAVg+A1gh6Y5W2/SOBnh5nc9o9X51VHKQhKeuUcPoWU04YCfJxM
   iCcQ4AHUeZv3IfGZCRkht/mlKMbqtmJ6YKMex9wG37wNHnjgSfXoell5O
   I=;
X-CSE-ConnectionGUID: X+ukOy8ERtOT5LQywHb1Gw==
X-CSE-MsgGUID: Dy9qr9/3TrqCTQHTFbyNWA==
X-IPAS-Result: =?us-ascii?q?A0ABAACudIJmmJ1dJa1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQCWBFgUBAQEBCwGBcVJ6gR5IiCEDhE5fiG4Dng2BJQNWDwEBA?=
 =?us-ascii?q?Q0BAUQEAQGCEoJ0AokNAiY0CQ4BAgICAQEBAQMCAwEBAQEBAQEBAQUBAQUBA?=
 =?us-ascii?q?QECAQcFFAEBAQEBAQEBHhkFEA4nhXQNhl0BAQEBAxIoBgEBNwEPAgEIEQQBA?=
 =?us-ascii?q?QEeEDEdCAIEDgUIGoJegmUDAaBOAYFAAoooeIE0gQGCDAEBBgQF3XcJGIEwA?=
 =?us-ascii?q?YgwAYo8JxuCDYFXeYE3OD6CYQKBYAKEE4IvgRWJQoNohF6BVoEKL4MbDiuFR?=
 =?us-ascii?q?YIZgUiBPn8mC4EahAKHflR7HANZIQIRAVUTFws+HQIWAxsUBDAPCQsmKQY5A?=
 =?us-ascii?q?hIMBgYGWTQJBCMDCAQDQgMgcREDBBoECwd3gXGBNAQTR4E3iWwMgy0pgUkng?=
 =?us-ascii?q?QyDDUtshAOBawxhiGeBD4E+gWIBg0pLhHgdQAMLbT01FBsFBIE1Ba0FBz0bN?=
 =?us-ascii?q?jEqKyFSDQogBAYFDCuSXziDD64PgT0KKINroWcXqjmYZ6M8hSUCBAIEBQIPA?=
 =?us-ascii?q?QEGgWc6SIETcBU7gmdSGQ+OIRmDYcoieDsCBwsBAQMJhkiEIgEB?=
IronPort-PHdr: A9a23:Zpc3IxSKUqwkYkloD9p5mfJv4dpso3fLVj580XJvo6hFfqLm+IztI
 wmFo/5sl1TOG47c7qEMh+nXtvX4UHcbqdaasX8EeYBRTRJNl8gMngIhDcLEQU32JfLndWo7S
 exJVURu+DewNk0GUN3maQjqq2appSUXBg25MAN0IurvHYuHkc+32vq0/ID7aARTjz37arR3f
 126qAzLvZwOiJB5YuYpnwHEoHZDZ6xaxHg9I1WVkle06pK7/YVo9GJbvPdJyg==
IronPort-Data: A9a23:7aCWLK5IJy7zO5LaA1dSQAxRtCHHchMFZxGqfqrLsTDasY5as4F+v
 mMbWDrTbqmKMWr8L9sia9u3pBlQscKEy4NnTgpspCA0Zn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyKa+1H0dOC88BGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wq8qUzBHf/g2QoajxPs/rZwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eDc4F+cFmUUx06
 dskdRQ0fw+jjbuZ3+fuIgVsrpxLwMjDJogTvDRryivUSKhgSpHYSKKM7thdtNsyrpkRRrCFO
 IxIMnw2MUuojx5nYj/7DLogl+elnH/4bhVTqUmeouw85G27IAlZi+CxaoCFKozULSlTtmqJ9
 3vcriOiPgsDH+Cm6Qar+GOKucaayEsXX6pJSeXnraQ16LGJ/UQXCRsLRR6+pvWkjkOlc8xQJ
 lZS+Sc0q6U2skuxQbHAswaQunWIuFsXXMBdVrN84wCWwa2S6AGcboQZctJfQOxlqcwRVGwH7
 EOuo47NPC1wkLfMZm3Io994sgiOESQSKGYDYwoNQg0E/8TvrekPYvTnEIwL/Emd0ISdJN3g/
 w1muhTSkFn6sCLm/7+w8VaCiDW2q92XCAU0/Q7QGGmi62uVhbJJhaT2tzA3Dt4ZcO51q2VtW
 lBfx6ByC8hVUfmweNSlGrllIV1Qz6/t3MfgqVBuBYI90D+m5mSue4tdiBknex44bJ5eJW6yM
 BOJ0e+02HO1FCb0BUOQS9/uY/nGMYCxfTgYfqmON4MVM8IZmPGvonE1PiZ8IFwBYGB3zPlgY
 s3EGSpdJX0bEq9ghCGnXPsQ1KRjxyY1gwvuqWPTkXyaPU6lTCfNE98taQLWBshgtfPsiFuOq
 b53aZDVoyizpcWjOEE7B6ZJcwBTRZX6bLirw/Fqmhmre1s6QD95WqGKnNvMueVNxsxoqwsBx
 VnkMmdww1vkjnqBIgKPAk2Popu1NXqjhRrX5RARAGs=
IronPort-HdrOrdr: A9a23:h0ujpagdkArtlVXVP3EFNWAG1HBQX6h23DAbv31ZSRFFG/FwyP
 re/8jzhCWVtN9OYhAdcIi7Sdi9qBPnmaKc4eEqTM6ftXrdyRuVxeZZnMvfKlzbamzDH4tmpM
 VdmsdFeaDN5DRB/KHHCUyDYqgdKbq8geOVbIXlvgtQpGhRAskKgXYde2Km+w9NNXZ77PECZe
 KhD7981kCdkAMsH7+G7xc+Lo7+TvTw5eDbSC9DLSQKrCOJijSl4qP7FR+34jcyOgkk/Z4StU
 L+v0jc/KuMj9GXoyWw64bU1ftrseqk7uEGKN2Hi8ATJDmpoB2vfp5dV7qLuy1wiP2z6X4x+e
 O85isIDoBW0Tf8b2u1qRzi103LyzA18ULvzleenD/KvdH5fjQnEMBM7LgpNicxqnBQ++2U4p
 g7hl5xhKAnVS8oWx6NvOQgYisa0HZcZ0BSy9L7wUYvDLf2I4Uh3rD3tHklZavoWhiKqrzO1I
 JVfZ7hDDE8SyLHU5jU01MftOCETzA9GAyLTVMFvdHQ2z9KnGphx09d38AHmGwcnahNB6Wsyt
 60eJiAros+A/M+fOZ4HqMMUMG3AmvCTVbFN3+TO03uEOUCN2jWo5D67b0p7KXyEaZ4gqcaid
 DEShdVpGQyc0XhBYmH24BK6AnERCG4US72ws9T6pBlsvn3RabtMyeEVFcy+vHQ7Mk3E4neQb
 K+KZhWC/jsIS/nHptIxRT3X91IJXwXQKQuy50GspK104r2w6HRx6XmmazoVc3Q+B4fKxXCPk
 c=
X-Talos-CUID: =?us-ascii?q?9a23=3AI/T+u2pXQG4Mytl/8AjTupzmUfBmb3763Sf9GVO?=
 =?us-ascii?q?fNTtNcayKaVXJ17wxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Am19L7QxTRzj97Q63Qfh+0JDrzh2aqIi/WVkXwNJ?=
 =?us-ascii?q?dh9OdHhBJGwuzhiWRfaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by alln-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 09:23:07 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
	by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 4619N75E023285
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-modules@vger.kernel.org>; Mon, 1 Jul 2024 09:23:07 GMT
X-CSE-ConnectionGUID: DKfz1iCvQP21IETQ56XmKQ==
X-CSE-MsgGUID: W+TAC9K6RRSvkjSfLZCJCg==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=vchernou@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.09,175,1716249600"; 
   d="scan'208";a="16634329"
Received: from mail-mw2nam10lp2046.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.46])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 09:23:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PepGyz8bks4W3oQyB5tSc69GqWzswo/pxbWvy/zOnRyBmvmprJE/DFkBeS666QrxiMHHURsIEcvSz/p3hmCl6mT6KYzXuQsGS0ctYcQ5x8vuRDySXBMNEa7w5q+3uO57qrViDZRh7loVpKRMgxsMIyBAiFtZwYLm2OWOu2NL2I4EuBH9RaDCmif23V3IbtsBVZXwQWioDd0MS4OfcoezPrgeQgS+1gNAfkL6pOlQk7BP0u1PydZoTka79m0tXWJWtdMVjx0rZC70hVus9s9dznMUvJ22mUGIBre5yvjb6Lm7nMPqLYco77lgi2/S6D8JVX4VUD27cAvuc3Ur8JKrVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HCqw0cGcQXablblfl3kzSdSbxIOUclCYuhYeEuezQs=;
 b=SlmuBiCVKhVukbbS9e+YLIlJm5bVlxy9iNiTZYDoIJdU0G9HPUwgYIfomV5oQ5WlEuZYZeuEfbnH9wtIQC8wmd8ZYfSZLtQARNtbZ/EcILWv4yM7N/2OogZFmjlNngyifwsdRZShvgeOl3zxpV9kzSEahCMQx7IoyKlDk5v7GCXBbqui7QAdeHu3/6JYVpDw4glmxhl3wG3fVjyfoZDHebpQ3NwwF1Mi3duh2yeHRJreajGcjpt+LzEB6PMGepksloYdbkB2ZmYbbuaByIzyNtocYTX9rAsjVu6jE43GBNpCDAi7igPWo3rosGlWB8j23KKP6fsMkE3II0Pb9wyJoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HCqw0cGcQXablblfl3kzSdSbxIOUclCYuhYeEuezQs=;
 b=nS325dykEv3JG9rnsRNGEXwZmT/5yMV8p8FGVa7VN7Q2xXvsXe6xBKlCQVWFXhe2j45jgNJw9W7XcGZpDY5/RxxZGS3JpG0JRH/LzFpVUh4pEA3TZqBN+qngCC4CEdvL5yKHSnpNdfF+nPEDWVAeuZI2U8JBiI1890xNxReSe2A=
Received: from DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) by
 IA1PR11MB7822.namprd11.prod.outlook.com (2603:10b6:208:3f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 09:23:03 +0000
Received: from DS0PR11MB7765.namprd11.prod.outlook.com
 ([fe80::9840:ad29:c571:9c68]) by DS0PR11MB7765.namprd11.prod.outlook.com
 ([fe80::9840:ad29:c571:9c68%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 09:23:03 +0000
From: "Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)"
	<vchernou@cisco.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        Nicolas
 Schier <n.schier@avm.de>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [MODALTS v0.1 4/4] add modules deps alternatives description
Thread-Topic: [MODALTS v0.1 4/4] add modules deps alternatives description
Thread-Index: AQHaosw6qlfEDe8qx06xqsYjBzFaELHeBg2AgAPSJB8=
Date: Mon, 1 Jul 2024 09:23:03 +0000
Message-ID:
 <DS0PR11MB7765763AE24FC792CB3F72BFDED32@DS0PR11MB7765.namprd11.prod.outlook.com>
References: <20240510112128.2417494-4-vchernou@cisco.com>
 <z6dffospgjlmczpc3ydj34t7rf37dq7f5vjjd4e6txpw2hmoex@6s26au6y4puj>
In-Reply-To: <z6dffospgjlmczpc3ydj34t7rf37dq7f5vjjd4e6txpw2hmoex@6s26au6y4puj>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7765:EE_|IA1PR11MB7822:EE_
x-ms-office365-filtering-correlation-id: a463c029-9977-4132-2812-08dc99af6896
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bA2TujwYamG3OD95E4xGmJEnHUpY6QPx1tXVlZrWavArlxdP2pqOAoVCO/7b?=
 =?us-ascii?Q?hEpeYKnCV+TeKMiiXgyLtJkBvRCKHe3q9Qgyozis8cL5gwVP8VfJhqaCe26Y?=
 =?us-ascii?Q?m+LILfsDw46KFZcQT71fauvFo9CC1O7P14HZpbmtQuECm1nzDaHVZnpX+0vI?=
 =?us-ascii?Q?Vw7jeGS1NmMxPkAY3qxj9yVIujD9XkGzUHAj+AXswqrbLEn+Vzct9vBfFACx?=
 =?us-ascii?Q?8VEw+DRYGpnuKnMRc9JzelYcXlC+NnY4BMdAtRpO7u2BODNAywOnc05ANxjZ?=
 =?us-ascii?Q?VWSaGcoIyNgurvJtr0OkAKc1W9Mu3BxlyDCLsBqWWdZbig6AcPiUQygtIcxM?=
 =?us-ascii?Q?0Ro3QQVadbUcAp8jdSpqIArI9LvWOLtJGY/hy4f/swJ6s3fDM/Zneiwo58A7?=
 =?us-ascii?Q?NqPgRFTnY7eivOGI/+mcQkVB6yMOdvmmFQMmUyqg0K6BZV2yz4Xe7NpS81zW?=
 =?us-ascii?Q?zOk66dO0gAYGvDElLprloiSEwpKMZpRb7/jmSjfU1LhZwjlCFgudvu6QmRS0?=
 =?us-ascii?Q?w7etiZwtb1MyecD8QG8h07DwvOkxzaYlFWR0QTboet7sLeQERt1gc0kzun5D?=
 =?us-ascii?Q?MxkWChL/KXgjrf8ajRRVv/usVU0wOQKJJhpyoSWTpLhQEKnZd/iagZn4IJjk?=
 =?us-ascii?Q?VO+Tmozdoyym8BFr3X38NhVw6TCGQpmSwPnvf/odCfh8/3wbV+/NpCCpx2MJ?=
 =?us-ascii?Q?WmCD9uiRRnrfMv3hDDvm4P9J/tlPh/MSB1ezKqF/MorMLoD7Fglbt45Rz9GS?=
 =?us-ascii?Q?z61MeS4R7K+oNy4V9IjkzMkMV8Iru4HPQPn9gepYiqZ/FklnVpuE8pPhM2zr?=
 =?us-ascii?Q?F4GgUw5+b8r5kisM287nJeC6RdSvZMltsFVXhFbt5qi6Ga56nM9TFFp5zI6Q?=
 =?us-ascii?Q?OmBnC14h4GfBNquk+IviiPvbzFatAiw4Hbnuu8VQHjoXif0B+MdlnN2GUhD3?=
 =?us-ascii?Q?2/vuh9me6Igwn6Hohb+d1cQhk+bmFa2o3k1QAUJiD0cA8LSgh8H6N3LAtTUs?=
 =?us-ascii?Q?L6XYkR5VlZurbzieL5IzSAbncjaZ+VszP7vj5mhRO2aHI7e5IE5rmRxLfXdO?=
 =?us-ascii?Q?sbqcfvreBUCAzUqtQ2Q3lkUFbfFAaE5JXo0rI9G11fsPb92IWgSqlzy0uIUa?=
 =?us-ascii?Q?Kk+rpCEMv01o2OGM2L7le4UfEQUJiP3s3wwEhiXw9Sl1JsoYYPO6kAZKPwPt?=
 =?us-ascii?Q?ibtAkA/Nh3nxtAENPZWnZCB27U34OjmdR0L+Td13X4HdFNsQZOr20IUefGHu?=
 =?us-ascii?Q?uo1mwg8uAyJz2LfCOTzOZoUN6GGnHd61xJCI+piDvLfAZdNlvlKqRFizZt1f?=
 =?us-ascii?Q?DWRH7MGDquZK6I4bMzKnoUDz7myPOzB82cCUf5HQ1viAp5vTKHu+ZKgpSlqk?=
 =?us-ascii?Q?JKVA3SHZ/u4CX5HXESVc1ig4VnUCtyLnQryghEPvm97pyVCUOA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7765.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5qH2gRw5TX2AeumnXAlHpOVnxWr0U0cqUqE2O5B7e1i2oUKOQfkGJD/g2lQ9?=
 =?us-ascii?Q?6rWgtvfekrFKM3/VvOc8Bb+0s7acd3NXgDlhTU3xF2CDUYWPzNJtc6IfCRku?=
 =?us-ascii?Q?GFBCJjFWYxvoRg+CP1HFFXGEmHQMZcrQiQR7EU0enPY7HKff1a3TjrVV63/i?=
 =?us-ascii?Q?OTfPnmFxph4CQYKFrZsUbE7G0UNGCWz2q4Aq2HdEYRvNLjaK7yjIOMCUHmvH?=
 =?us-ascii?Q?nuGxWVSJv2qDeOXmOKB/ELc2qwqSZ8C25TIHyXMguAnpq7pu/8H56ugN6c70?=
 =?us-ascii?Q?BbRyB1wWKcmoEKKCFbvdgXdCr3+HmQ6isU1M1pJdxvimJrNwoP3YjY0Q1sOD?=
 =?us-ascii?Q?hXU9xMmthkyRcTLvpxRFrGJDjnqhLOc62Q9JhLmvMdTcUuLalmeqqhezD1+E?=
 =?us-ascii?Q?9Jls1N9tNp6jtbyV7Eh3BsQDKMyQeX1lpM43tDwqk+UfRFPP9w9VQ3c7ckd7?=
 =?us-ascii?Q?Asy3q2d/j/HT5RcaxOmGmR9zOSfibIuaeDWOzMbNY5wCWZd41MBlZmokN9px?=
 =?us-ascii?Q?y00nskIG58KhowosCWe/3p/Xx9/o3Z1SHy0uKu8zGtkPlSr7lxs1p3TuzPhN?=
 =?us-ascii?Q?A86hMiQAQIWXH3FVYTk2OnCUs6qZlkBVpTbsoXIbi95prHMwmgqd+UKv2mAa?=
 =?us-ascii?Q?8/rayv0Jf7U89XTQ/X0dpHPO8pIvframC2cD9pNYTUg9zljzVyqtL862Iihj?=
 =?us-ascii?Q?4IvE7HSyNbZ79wBQi3kOb9yKRxifFU9YdmLcelJ95Obh8YliY2xkDm/1HlmA?=
 =?us-ascii?Q?rJh4thZ2w8Ld1opiwmp3uPwc1geWAW3kZJMGJPTMc48+YZSYDm9p8BL9y/p0?=
 =?us-ascii?Q?AAolmjPl1eGZoj9B5cV+86m7dZJsEghMXLtWyrl3+KqBAJ0foy0TyG623Mys?=
 =?us-ascii?Q?4AK2QMtHkEasp7btL3OT3iLHaZqd8RVcdaXw3qqP0EiwKT8xnHDpS/MfC5ha?=
 =?us-ascii?Q?c1fXuBsYwIJ1+xEzwHpYvYQzv40+n7i2eVgk0JzwHC89hVMXcpk8sWalKLIo?=
 =?us-ascii?Q?aSozhs7g95c+XNSry1+8FK2poX27bks/SqmW08ta/vVJJh3sRD20vId1/fPW?=
 =?us-ascii?Q?ibbhbSm+QQ1LPn2M8quuc5vxeYsnacz4oF+QrBrB8hNMihSJfd0QCLL+LY+l?=
 =?us-ascii?Q?t1h3UtcJO+HSXKV6xwAyAzeRdS5n2EcmP8o7zsjT4Q1c+gCIq15GVkW/z1Q9?=
 =?us-ascii?Q?1sIOchiTIrcUZleptZZDCRI+KLXmw+Oyw9n9zKTLEnSEkz3UXVsKXoI2WS0Q?=
 =?us-ascii?Q?t1MjBECjwCMWdF2l0j3Od2bn7hzcJMetWb96r8WvRgyvuwBYdyW1ek/+2oQ+?=
 =?us-ascii?Q?weRwvt3vwm8OR7xN5Buvr/EdA2CghIKL0XdYeVHYD/3cb3uUakce/k8sBvDx?=
 =?us-ascii?Q?s1qoavOy7qFTHvT1bmLqppGVyAjwvAseDQDBiklQ8YTqOFrTawptVqFhKBk6?=
 =?us-ascii?Q?ntDPt89v+9j+jQHI2kJnokqg8+7TgLO72u0dJZz3uUf1USFukdJ/5vl4s3+7?=
 =?us-ascii?Q?V702mBTSii91nZNLBHqzq7tzpKR3DX3c5b/D51JFu4Tuk0lzkHi9WOY7XamZ?=
 =?us-ascii?Q?OEGy0iqDqa82pbFA6r4sOTz9FgwM/ywetVIu7RYeXiXjyH5kEXJj2JR2cl2V?=
 =?us-ascii?Q?Hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7765.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a463c029-9977-4132-2812-08dc99af6896
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 09:23:03.2190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mz3/6AL+NZm3eKkLRJBdDIGeFHA72iZ/YYlmwtQxUSn6Q9oz2ztJ5XUNeKivQI1tONyKZGM5TV/VcdHQ+stzXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7822
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: rcdn-core-6.cisco.com

>On Fri, May 10, 2024 at 04:21:28AM GMT, Valerii Chernous wrote:
>>Cc: xe-linux-external@cisco.com
>>Cc: Valerii Chernous <vchernou@cisco.com>
>>Signed-off-by: Valerii Chernous <vchernou@cisco.com>
>>---
>> README.deps.alternatives.txt | 40 ++++++++++++++++++++++++++++++++++++
>> 1 file changed, 40 insertions(+)
>> create mode 100644 README.deps.alternatives.txt
>>
>>diff --git a/README.deps.alternatives.txt b/README.deps.alternatives.txt
>>new file mode 100644
>>index 0000000..9ad3ce5
>>--- /dev/null
>>+++ b/README.deps.alternatives.txt
>>@@ -0,0 +1,40 @@
>>+Modules alternatives feature allow to calculate dependency alternatives
>>+during build time and aviod to regenerate modules db into runtime
>>+
>>+To enable deps alternatives calculation use "-D" flag with depmod,
>>+it will create indexes modules.alternatives and modules.alternatives.bin
>>+This indexes will be used by modprobe in runtime
>>+By default modprobe will load first(primary/major) dependency from list
>>+If it required to load alternative module, it should be done manually be=
fore
>>+loading main modules set.
>>+For example systemd service that detect platform type can load required =
platform
>>+modules and after it run main device initialization
>>+In case when alternative module loaded, modprobe detect this and skip to=
 load primary
>>+dependency
>>+
>>+modules deps alternatives generation basic algorithm description
>>+1. Load modules information(imported/exported symbols)
>>+2. Find depended symbol alternatives(create list available symbols
>>+   alternatives instead of storing last one)
>>+3. Choise primary/major alternative per depended symbol correspond to
>>+   build time dependency(build time deps getting from module info sectio=
n)
>>+4. Create a list of dependency modules alternatives correspond to next r=
ule:
>>+4.1 All modules alternatives for module dependency should provide all sy=
mbols
>>+5 Store modules alternatives index(modules.alternatives) as key:value wh=
ere
>>+key is a pair depended#_#primary_depency,
>>+value is list of all modules that provide all symbols from primary_depen=
cy
>>+for depended module
>>+
>>+Note:
>>+Current implementation/algorithm doesn't cover variant where requred sym=
bols
>>+from primary deps provided by more that one modules. Exporting all symbo=
ls in
>>+alternative depency that used by depended module from primary_depency is
>>+mandatory!
>>+
>>+Note:
>>+modules.dep index different for standard/basic and modules alternatives =
algorithms
>>+modules.dep for modules alternatives algorithm contain only direct depen=
dencies and
>>+full dependency list will be calculated into runtime correspond to prefe=
rred alternative.
>>+modules.dep for standard/basic algorithm contain full dependency list fo=
r module and
>>+can't be changed during runtime without rebuild database via depmod


>well... this kind of explains the what, but still no clue on why.
>If multiple different modules are providing the same symbol, then they
>are doing things wrong.

>If there are multiple variants of the same module (again, is this about
>external modules?), then I see no advantage to delay the decisions from
>depmod-time to modprobe-time. Just setup your depmod.d configuration.

>Also end users have not visibility on a README.deps.alternatives.txt
>file. Documentation in kmod is kept on man pages.


>Lucas De Marchi

First at all, thank you for review, Lucas.
Let me try to explain feature more:
1. You are correct, feature tested on external modules

2.
>If multiple different modules are providing the same symbol, then they
>are doing things wrong.

Modules exported the same api(the same functions) and on my opinion it's ok
and kernel process normally different modules with the same exports. One ma=
jor
restriction is only one module with the same symbols can be loaded on the s=
ame
time but it's ok in my case(as I described, in my case, it's per platform
modules and devices with different hardware using the same software image).

3.
>If there are multiple variants of the same module (again, is this about
>external modules?), then I see no advantage to delay the decisions from
>depmod-time to modprobe-time. Just setup your depmod.d configuration.

It can be different variant of the same module but maybe not. For example i=
t
can be cryptography modules. Modules provide the same api but implementatio=
n
of api is totally different and depend on specific hardware. With modules
alternatives feature it's easy to use this kind of modules. You can use
required alternative for specific hardware and all depended modules can use
external functions directly without any wrappers or "if" statements to reso=
lve
dependencies.
With using depmod.d configuration it's possible to choose primary alternati=
ve
into build time but in my case required alternative is unknown during build=
 time,
it will be known only into runtime. In this case it required to regenerate
modules db into runtime and I try to avoid this.

4.
>Also end users have not visibility on a README.deps.alternatives.txt
>file. Documentation in kmod is kept on man pages.

I can rework feature description to man pages format but at this moment for=
 me
important to know is modules alternatives feature acceptable for kmod proje=
ct?
If yes, and finally it will be merged I'm ready to spend more time to
working on it

Best regards,
Valerii

________________________________________
From: Lucas De Marchi <lucas.demarchi@intel.com>
Sent: Friday, June 28, 2024 11:55 PM
To: Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)
Cc: linux-modules@vger.kernel.org; xe-linux-external(mailer list); Nicolas =
Schier; Lucas De Marchi
Subject: Re: [MODALTS v0.1 4/4] add modules deps alternatives description

On Fri, May 10, 2024 at 04:21:28AM GMT, Valerii Chernous wrote:
>Cc: xe-linux-external@cisco.com
>Cc: Valerii Chernous <vchernou@cisco.com>
>Signed-off-by: Valerii Chernous <vchernou@cisco.com>
>---
> README.deps.alternatives.txt | 40 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 40 insertions(+)
> create mode 100644 README.deps.alternatives.txt
>
>diff --git a/README.deps.alternatives.txt b/README.deps.alternatives.txt
>new file mode 100644
>index 0000000..9ad3ce5
>--- /dev/null
>+++ b/README.deps.alternatives.txt
>@@ -0,0 +1,40 @@
>+Modules alternatives feature allow to calculate dependency alternatives
>+during build time and aviod to regenerate modules db into runtime
>+
>+To enable deps alternatives calculation use "-D" flag with depmod,
>+it will create indexes modules.alternatives and modules.alternatives.bin
>+This indexes will be used by modprobe in runtime
>+By default modprobe will load first(primary/major) dependency from list
>+If it required to load alternative module, it should be done manually bef=
ore
>+loading main modules set.
>+For example systemd service that detect platform type can load required p=
latform
>+modules and after it run main device initialization
>+In case when alternative module loaded, modprobe detect this and skip to =
load primary
>+dependency
>+
>+modules deps alternatives generation basic algorithm description
>+1. Load modules information(imported/exported symbols)
>+2. Find depended symbol alternatives(create list available symbols
>+   alternatives instead of storing last one)
>+3. Choise primary/major alternative per depended symbol correspond to
>+   build time dependency(build time deps getting from module info section=
)
>+4. Create a list of dependency modules alternatives correspond to next ru=
le:
>+4.1 All modules alternatives for module dependency should provide all sym=
bols
>+    from primary/major dependency module
>+5 Store modules alternatives index(modules.alternatives) as key:value whe=
re
>+key is a pair depended#_#primary_depency,
>+value is list of all modules that provide all symbols from primary_depenc=
y
>+for depended module
>+
>+Note:
>+Current implementation/algorithm doesn't cover variant where requred symb=
ols
>+from primary deps provided by more that one modules. Exporting all symbol=
s in
>+alternative depency that used by depended module from primary_depency is
>+mandatory!
>+
>+Note:
>+modules.dep index different for standard/basic and modules alternatives a=
lgorithms
>+modules.dep for modules alternatives algorithm contain only direct depend=
encies and
>+full dependency list will be calculated into runtime correspond to prefer=
red alternative.
>+modules.dep for standard/basic algorithm contain full dependency list for=
 module and
>+can't be changed during runtime without rebuild database via depmod


well... this kind of explains the what, but still no clue on why.
If multiple different modules are providing the same symbol, then they
are doing things wrong.

If there are multiple variants of the same module (again, is this about
external modules?), then I see no advantage to delay the decisions from
depmod-time to modprobe-time. Just setup your depmod.d configuration.

Also end users have not visibility on a README.deps.alternatives.txt
file. Documentation in kmod is kept on man pages.


Lucas De Marchi

>--
>2.35.6
>
