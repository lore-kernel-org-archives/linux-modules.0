Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F812158213
	for <linux-modules@vger.kernel.org>; Wed, 24 Jul 2024 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825682; cv=fail; b=jhTRIJPO8B4V0eYBejPBENkC5puQPCuE7R4bRU67TquElYVsORr3GHy5/GgBIjScH5tYjdofbLUeduPY8qb7sOWTubfnzUlr+Bg+0EghyvfthEW4+jmnajBwiTgJWjTorfA8kJZMJuv+ARZIhxF7j/5YgOI3o/JlAQtQimf1Vw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825682; c=relaxed/simple;
	bh=JuR5fdvSUV2FRcnCjttl/cQvw+sOZP2lnaBqlNaQ1o8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CdKTpx46k4r7he5S9mnWt5OSALqfFNOHI1NnfBcLq8PHRpL3KgB8Bs8Nsd0+B37UMuyZUqANDvgBEASfRYiIrkHqu7HMir/MEg4kEgtqKa52lIXPWKIUwwuG2v5a2A126tpgWCePkYlwF4bUd2tMGoIeUVEmLf9MkEHyYLUzq3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=P4eMEklK; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Q8isE+9e; arc=fail smtp.client-ip=173.37.86.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="P4eMEklK";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Q8isE+9e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=10389; q=dns/txt;
  s=iport; t=1721825680; x=1723035280;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=inZxtTF4WwwyE/LMvfDIArvBmr9aBTZi+94WPPyI1hM=;
  b=P4eMEklKV3oeFHsp3j2sUWT+v1swmmcWnkvuEmyDb84FL9ONud3SYT3R
   afaKCPPM/KP/RGUuX1aUWbGwY5zvKr2Lb5aNv1rh5T9tip7iTN2Oy8GZO
   frywk/yJP8SIusJasDi++R739kUzzTCBMuv0stqyM9xGmoQGDjI724sit
   I=;
X-CSE-ConnectionGUID: DsC9RSGBSLWI0cmqMUsMHg==
X-CSE-MsgGUID: we7guSCoS32OXlQRrtCH9g==
X-IPAS-Result: =?us-ascii?q?A0ADAAAf+aBmmI9dJa1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUAlgRYGAQEBCwGBcVJ6AoEcSIghA4ROX4hwA5FEjEyBJQNWDwEBAQ0BA?=
 =?us-ascii?q?TkLBAEBghKCdAKJOAImNAkOAQICAgEBAQEDAgMBAQEBAQEBAQEFAQEFAQEBA?=
 =?us-ascii?q?gEHBRQBAQEBAQEBATcFDjuFdQ2GXQEBAQECARIoBgEBNwEECwIBCBEEAQEBH?=
 =?us-ascii?q?hAxHQgCBAENBQgagl4BgkEjAwEQoi4BgUACiih4gTSBAYIMAQEG3gADBhiBM?=
 =?us-ascii?q?AGIIhoBcIlfJxuCDYFXeYE3OD6CYQKBYAKEE4IvgRWGdQGCSoNng0qBE4FEE?=
 =?us-ascii?q?oEKLxaDAg4rgWUFCyaDIQFxgSGBSIE+fSYLPoVDh35UexwDWSECEQFVExcLP?=
 =?us-ascii?q?h0CFgMbFAQwDwkLJikGOQISDAYGBlkyCQQjAwgEA0IDIHERAwQaBAsHd4Fxg?=
 =?us-ascii?q?TQEE0eBN4ldCoMnKYFJJoENgw6BNYN7gWsMYYd2YoEPgT6BYAFJgn5Lg2iCH?=
 =?us-ascii?q?B1AAwttPTUUGwUEgTUFqTmDEGwGAQEFNxs2ARsQBSorIUoIDSoEBQEFDA0PA?=
 =?us-ascii?q?g2SYRQkgxCuG4E9CiiDbIwSiFiBT4syF4QFjQCZN5htII1YlUIEDw2FCQIEA?=
 =?us-ascii?q?gQFAg8BAQaBZzpIgRNwFTuCZ1IZD44hGYNhzAl4OwIHCwEBAwmGSIQiAQE?=
IronPort-PHdr: A9a23:XJ6uBhDLNtIgvI9qsdEnUyQVXRdPi9zP1kY98JErjfdJaqu8us6kN
 03E7vIrh1jMDs3X6PNB3vLfqLuoGXcB7pCIrG0YfdRSWgUEh8Qbk01oAMOMBUDhav+/Ryc7B
 89FElRi+hmG
IronPort-Data: A9a23:0YNOkqDTVU2vERVW/zLjw5YqxClBgxIJ4kV8jS/XYbTApGl3hD0Bm
 GtMUGvQbP7ZYWTzf9F3Oo7goBsC68XWm9Q3OVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4SGcYZtCCeB+39BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357hUmthh
 fuo+5eDYAD/h2YtWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TE7+5FXXsNEqcj3tlWWWpL7
 NklMxUtYUXW7w626OrTpuhEnM8vKozgO5kS/y4mxjDCBvFgSpfGK0nIzYYHh3Fr2YYfRrCHO
 5FxhTlHNHwsZzVRMVcaEpQ5gc+jh2L0dHtTr1f9Sa8fuTOJk10hiuOzWDbTUsOHGspIpW2fn
 Tmc2FT9OysAKPe/mDXQpxpAgceUwHukA9hNfFGizdZugVuO1ikWDxELUVagiee2h1T4WN9FL
 UEQvC00osAPGFeDVNLxWVizp2SJ+0FaUNtLGOp84waIokbJ3+qHLkQfZW97U/MMj+sJZGQh0
 0asosjMJTM65dV5Vkmh3ruTqDqzPw0cImkDeTIIQGM5Dz/L/tpbYvXnEIoLLUKlsuAZDw0c1
 NxjkcTTr68YgchO3KKh8BWYxTmtvZPOCAUy4207v15JDCsnO+ZJhKTxtTA3CMqsyq7CFzFtW
 1BfwKCjABgmV83lqcB0aLxl8EuVz/iEKibAplVkAoMs8T+gk1b6ItoJvm4vfxsyb5hZEdMMX
 KM1kV4PjHO0FCb1BZKbn6rrUKzGMIC5T428DaGOBjawSsUrJVLXlM2RWaJg9zuwyBd3y/5X1
 Wazese3BnFSErV80DezXK8c17Rtrh3SNkuNLa0XOy+PiOLEDFbMEO9tGALXMogRsvjeyC2Lq
 Ik3Cid/40gFOAEISnOJodd7wJFjBSVTOK0aXOQOJrLaelI9RTtwYxITqJt4E7FYc21uvr6g1
 lm2W1RTzxz0gnivFOlAQikLhG/HNXqnkU8GAA==
IronPort-HdrOrdr: A9a23:umTzEahVvf+U6Id01eXAnS8seXBQX6h23DAbv31ZSRFFG/FwyP
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
X-Talos-CUID: =?us-ascii?q?9a23=3AFByqUWlOGGqOnjjZbDdoMcAyJfLXOVHG5ybqGGC?=
 =?us-ascii?q?SMkJWaeWeTEa1xbhBs8U7zg=3D=3D?=
X-Talos-MUID: 9a23:maWrQwkIYhFu5U+W5yawdnp9OZhn/p+FD3tWy7I2v/C+LzBbG2aS2WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 12:53:30 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
	by rcdn-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 46OCrTIh010385
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-modules@vger.kernel.org>; Wed, 24 Jul 2024 12:53:29 GMT
X-CSE-ConnectionGUID: llSD3ZSoQRejJbdxyiJgLg==
X-CSE-MsgGUID: H3dmFY7MSWuv4khckOT3oA==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.09,232,1716249600"; 
   d="scan'208";a="19027145"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 12:53:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7u9PjF6b610qA5zQ1Dy/v31sn93Rs7APahegNSbtPOaUXTGVXnVaj71fzSzRJ+ABM9ZenA0295YYfriQGOfxqcDnyk2PIMNr+TLItJOUl/ZzXXUmo4BP2gBseTryfrgw6CLZb8JCFNRL47EIDMO+3Ka4/CzPlS1iJS/1+q0X9i2UshUKlkZ9Dd+kKAmOofXT2qTcgRS5Fg5V1I1YMtl/IkVvGt60Pgpc0Mh20mNlmJKbm6ilqTbiBdUM1g8qEN+/Qo2X18kY4fyBYRDn253lMfrsdZ7IyNEYels6vCMsdqtZhi/SOC0CPsmZ2ol9Eq+TaNl0/0yymjUytIfW4yUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inZxtTF4WwwyE/LMvfDIArvBmr9aBTZi+94WPPyI1hM=;
 b=K8OTzhu4mhOqBwMIPntqHIDAGTpYkp0bVHv4jFi57bwGf3GD0ee3HTNtXx3NTZ5MFXx6/rtQIcExK3fNENkpc943SLt4d0XFANONMUtKQCme3F4CJ81GNQJTkeGAbLEezolotpIQtwzwHMpDvfk+nmCAiMBkPJB3WLTDc2uZuRhDtEzXYfuyGe7PL+sKOkKpJc4kd9tDvUisFUApOt0eQ6ngIOgkk9kTF/QzB2RiuVmiO830NfWVrL8v1EKBWwWrGrx/jlDD1RyXJVeo7BWVS7pa/mdK45KnYjMAGsh2MOxmIPue1ufq2w1BcrfOvhqrDcfqwMwfjqGyLT4BhFk6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inZxtTF4WwwyE/LMvfDIArvBmr9aBTZi+94WPPyI1hM=;
 b=Q8isE+9eWvvkRX149A1ge8aRCk8rYqTYsaK0DTUppfdavRG7guP6BfHGpKwf2KhwFypcn2k4GV6H+Xf3oGa7Xh9Uvplc4DJSBTz+evzOeThTHZ/yMKN644zIGTV7KZvx8WZNxiYX9aLpByYfUQJpF8U4G3nEunuBBFyVuVYUOU4=
Received: from DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) by
 PH8PR11MB8287.namprd11.prod.outlook.com (2603:10b6:510:1c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 24 Jul
 2024 12:53:25 +0000
Received: from DS0PR11MB7765.namprd11.prod.outlook.com
 ([fe80::9840:ad29:c571:9c68]) by DS0PR11MB7765.namprd11.prod.outlook.com
 ([fe80::9840:ad29:c571:9c68%5]) with mapi id 15.20.7762.027; Wed, 24 Jul 2024
 12:53:25 +0000
From: "Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)"
	<vchernou@cisco.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
        Nicolas Schier
	<n.schier@avm.de>
CC: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        Lucas De
 Marchi <lucas.de.marchi@gmail.com>,
        "Taras Kondratiuk (takondra)"
	<takondra@cisco.com>
Subject: Re: [MODALTS v0.1 4/4] add modules deps alternatives description
Thread-Topic: [MODALTS v0.1 4/4] add modules deps alternatives description
Thread-Index:
 AQHaosw6qlfEDe8qx06xqsYjBzFaELHeBg2AgAPSJB+AADdQgIAADm5IgANGtYCAIOTANQ==
Date: Wed, 24 Jul 2024 12:53:25 +0000
Message-ID:
 <DS0PR11MB7765FADBDD154230336A9589DEAA2@DS0PR11MB7765.namprd11.prod.outlook.com>
References: <20240510112128.2417494-4-vchernou@cisco.com>
 <z6dffospgjlmczpc3ydj34t7rf37dq7f5vjjd4e6txpw2hmoex@6s26au6y4puj>
 <DS0PR11MB7765763AE24FC792CB3F72BFDED32@DS0PR11MB7765.namprd11.prod.outlook.com>
 <20240701-grinning-sapphire-labrador-eaa91e@buildd>
 <DS0PR11MB77651EE7F968FA7D2E0FAB0EDED32@DS0PR11MB7765.namprd11.prod.outlook.com>
 <4onv4473cxas74vt3xjclrjuaagyf6q4wnmfzdbyna5fjah23m@a55vj2kwbiit>
In-Reply-To: <4onv4473cxas74vt3xjclrjuaagyf6q4wnmfzdbyna5fjah23m@a55vj2kwbiit>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7765:EE_|PH8PR11MB8287:EE_
x-ms-office365-filtering-correlation-id: 3a3707e4-8f45-406e-217d-08dcabdf9b7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3aTBh8f3pgNCWPV7bVZ3hq5fNRJO6sei3WzuNKIf/rY1wraWGTMMNQ6/Wbkf?=
 =?us-ascii?Q?1ehzPDTzu7LV1iscLt96NjEhyT8zEtJ33uKZ2jpPVSjFsZsnSjFXR/xcQ0sa?=
 =?us-ascii?Q?G58O9Ekx5BI/T08qtydlhcaf6L1gxiDYegCg8gYUb3z/9dTNq85NpyzANVtG?=
 =?us-ascii?Q?aX+i0sJS8KmbLuUCckyADYqqD9xK94vLtmnnrCkhIgvorOfbuOW8FJpmaGej?=
 =?us-ascii?Q?idkArx9ssWmQ3qAQ1cDsyJJUb8JL76rS80Z5cPCfF13gx/Suy9zKrRiMH8kb?=
 =?us-ascii?Q?cyx24HsSSSVhnTRl4XTaIJOnUnFEDrtvmY8zrrLioApGhnOeZhU7Ql4mwAf1?=
 =?us-ascii?Q?YgPDQBry4LRJ6Kh1WhRpmMfOAVSXmP1fmaOVw61ohUlY/EEoHDaRprR6ujWk?=
 =?us-ascii?Q?qMtWL07A6BY3nL1BrB5G2qQjqcJdByG/7wJ3x/jG+s7fhzJLIy4xlg1WQmnA?=
 =?us-ascii?Q?E036k+BoEPCYvlO03hBJPg00n3LyUkWHBmu7Rg/Ao9Ryny3Z21LENpumkTRO?=
 =?us-ascii?Q?LxqGTYsIjIAhpDlu5VPlkBPq4OZOBNdYN12EmXZDJrK5BoPl/EZoVHxEnqMW?=
 =?us-ascii?Q?M1n+Mju5tUHoR+LePlnYy9C6Hf+Q7uOGR41USTSMprO0P2hOmQ/TnbR/0Upd?=
 =?us-ascii?Q?oZ7Nfisij4D4eFWihIOSy9mEeKGPS9+A+T0yemzsd6ikMRz8OHdlOMhPeLKR?=
 =?us-ascii?Q?+drvGWhRaF+kSuJcRlSwuiZgT9aYMUVXdeBtvQlF1fsFwR8P5opdH9tlGgS7?=
 =?us-ascii?Q?17Ze8NnNAfytk6oObSOdS6qqWdCdhJTJZBaSAk+Iqs3ydon5JQpYiogch0PE?=
 =?us-ascii?Q?9zNguydjctG3iyRzL9L0dO3heOs9Ctdgj+kd0kA5308BUMiitlx7rEAt9+xb?=
 =?us-ascii?Q?tW6eYCC+C9cdvSlOKSpA2hElAz/F5//jyuHUHDSGyKlBJdiM0Du+TcMu9KcV?=
 =?us-ascii?Q?ffy3jyX8XwAo9eo47TkDHtS96stBT78Tuighxrdr9pBvF74iMaeez0CPeF6+?=
 =?us-ascii?Q?Mp30r3e2kF+cgXgu853P4r2UeK5Q9qRmkQB4h2eYPJZ2YboulpC2X4eeVM4P?=
 =?us-ascii?Q?2oxOMLJqHcIMrVL8NiKDiUuvPld0WW9K3TVhwH+M3WFLaswX1Ji+07SqZWF+?=
 =?us-ascii?Q?llf+GM3dVNhqtoIvgitI/8jn7ELoyWOaiuzlsfoIHOnl/ZHuAq7vXpt5eyoT?=
 =?us-ascii?Q?2UrMTpj8GZnaANmZj4osht6VHh9NNAVtGwDIJKQAnB37VrjdarOlrqAvukrX?=
 =?us-ascii?Q?TXzCci2KxvsFDY6xl4hGq8kjlr8uGTqCMB8zvYrJktxkbNIJY5ZGn/RQg1Wk?=
 =?us-ascii?Q?g2MIJIpp8iRgmxC2/SY8n3ngnuJ1lNJbLENicEcdFUIeKcZJMT4uJZsj7t3+?=
 =?us-ascii?Q?xvkrzTg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7765.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/9Z3DG3oR+y6chuHuqlb06Q1/AfZ/K1PP3ze+IielJrcgIRoyVNTL669Pb5P?=
 =?us-ascii?Q?5UhdkLsyuCM0fpvOMGb4QVAopPPo8TRtBElT3Byc5s7qfU4wMbLkSZtnQZJa?=
 =?us-ascii?Q?LpFhWr2Q01MHg1wgI3o5MdqfwOz/5XATd29bk/lDQB8/NJxAk0aw48DFC0Mg?=
 =?us-ascii?Q?VjxruEB0yYSjTR2Fm1yaBQcdbKv5TR3Nh68vAu5X4OzAgi7C3csSEWR2kk+A?=
 =?us-ascii?Q?u2Iw9j6Vyi7QnDxErQ+7pm2GcCzsfxYc0SDVLxXV3PP2r5g4d5UlolivMt8l?=
 =?us-ascii?Q?i/hCG2ZTnt3jd9UUlVLqwIH8tpAMceTu51eoFJTUDa6Vq4+jbpEMD62qdLfR?=
 =?us-ascii?Q?YMB2bqeHyGy/PdM9rfxV4P326xCfIEnH8+QEwkP0RcNppEajIgVnZoS6NQos?=
 =?us-ascii?Q?BhdRGKkMfvN/csGGdkOW0959eew5WnsaheUENaQE4NswVd0NRYmxXZ/X4ZMC?=
 =?us-ascii?Q?dd0V+RWO8h6JhXTqR4WatayOvt4SavvskthdJkuTJXI/xLmM5j873oOcI/xc?=
 =?us-ascii?Q?QUA3c0spmMpiwCyrfrlViWgqIopde0cL3N8hjbEgT2qHUX7TAoQawJbv8jaO?=
 =?us-ascii?Q?YQJEOOkGWIaXJHRb9ADxBQjV3GGvAeeWSjcCH06CQeUs7E0XZv5jHJM6HOMB?=
 =?us-ascii?Q?M4aXqv4escbqt4z3HGWPxnEPYjeii8OofRkFXhsJ2RZeCYf/UWUd5kOitHgs?=
 =?us-ascii?Q?RgyG8qY5uhWJPXQAYDq8EnL+Z3eKjvbaMujlJHLTHungH/eR/dCqkt16vVAW?=
 =?us-ascii?Q?V1PvZMVfFfuo2v5jkr1oZcYhgO0a4hFrJ+vSHc368SDIfcDt5DawxsQhGG35?=
 =?us-ascii?Q?8phCsc5YsP+ywm5JWInbcLj4Jc7slR11K/SmCXBQtdfDrg3RUGgFhT9cPYn6?=
 =?us-ascii?Q?4dUtiRzAYDcG1LUoY+f5BqOfWJwHvH5tRdcieZDUEpTsU7CUhfaXeC6gYe7z?=
 =?us-ascii?Q?Yk2sB+jUSznczBPCROcu5FjLfNJGy7Zmw9gAbxojT6Hrz80VxzGk9Te3yvuk?=
 =?us-ascii?Q?wbBL/axq4EvqwP8yBNe1BbqH0TbfLcU9IJVEjq/0/3+nubgbNAENbHg+YAj5?=
 =?us-ascii?Q?9SGOvp0ICil2F7EJZ+ermf+ynTnIunPkImDuwo8SiWtndaD7TdqG0rDSvLa1?=
 =?us-ascii?Q?e7Y8Jvg7LVciMQy4u5xDXkXA0/yQTgN2cmL95PdwMRquaydyo9lKrAeebmwn?=
 =?us-ascii?Q?YY9kzgC50FWWa8jI5ArFgQnP0drkcNlzvWHWrkZQ7UsNzbCLB0Q1PER9EUkI?=
 =?us-ascii?Q?1Bsi5mykC/mZ2cDUK+gBjkFnmem3aZYKj98w/92INuQaeGRWj+QG180mWUCs?=
 =?us-ascii?Q?bw6XOP0HhK1y3q0vrbyzWXHJVCKlBhtw5VjsN3PEk5HoIASwptNaFEDen2LU?=
 =?us-ascii?Q?U1YK/V/Zb0uDzu9mNmLfTCc2yyX5tUqb9ysXLQEl2/KmKB6jgGr6bJ/MHPpu?=
 =?us-ascii?Q?5CvUvIUol3Gx5SI908HgEsC1D84SyJPQUa0fTIPc30bV+8q9rkTNGtUt5t2V?=
 =?us-ascii?Q?sBYgxJi3siUZNOge1uGNgg8Bms02jct6H6lGu0anK1HQtAvSlGZLFCid1jBs?=
 =?us-ascii?Q?gueylZ2avrSJG4d3pa2U0Z9dio0reo3eRyMHZrdH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3707e4-8f45-406e-217d-08dcabdf9b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 12:53:25.4560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B9ha4DFFNMStSEHJsTTRm6PWuZFT1X8+hAbSiz2dEu8tU7BeToGcMENT5XoiCJ0deR5mNKSozR/jGFQODMRKUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8287
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: rcdn-core-7.cisco.com

Hi Lucas, Nicolas

Sorry for late response. I was busy with other tasks.
I prepared repo with scripts and examples of kernel modules "Hello" like st=
yle
to demonstrate problem and how it can be solved via "modules alternatives".
Please, check my repo to see details:
https://github.com/Valery0xff/kmod_mod_alternatives_test


> depmod is never ever used during boot time... we should be able to boot
> without even have depmod and even without modprobe (since libkmod used
> by systemd should already have everything needed).
Modules alternatives feature is transparent for libkmod users(including
systemd) because it doesn't change kmod external api, only kmod internals
So systemd modules autoload service working well with this patchset

> It looks like you have several modules exporting kind of duplicated
> symbols and want something in runtime to disambiguate which module
> should be loaded. I need an example to understand this... it's sounding
Repo that I shared contain examples of modules to demonstrate problem

> more like the chosen abstraction to have duplicated symbols (rather than =
a
> xxx-common.ko module) is the main thing that could be changed without
> adding complexity to module dep resolution.
Yes, modules alternatives index allow to use modules with the same symbols =
but
from different providers and all deal goes smoothly, without any additional
configs, blacklist, changing index directory, all that required can be stor=
ed
into one location

If you don't want to do build kmod, kernel modules and run scripts you can
check deps_report.txt and load_mods_report.txt that presented into test rep=
o

Best regards,
Valerii

________________________________________
From: Lucas De Marchi <lucas.demarchi@intel.com>
Sent: Wednesday, July 3, 2024 4:27 PM
To: Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)
Cc: Nicolas Schier; linux-modules@vger.kernel.org; xe-linux-external(mailer=
 list); Lucas De Marchi
Subject: Re: [MODALTS v0.1 4/4] add modules deps alternatives description

On Mon, Jul 01, 2024 at 12:51:50PM GMT, Valerii Chernous -X (vchernou - GLO=
BALLOGIC INC at Cisco) wrote:
>Hi Nicolas,
>
>> It sounds to me, as if you would like to auto-generate modprobe.d/ files
>> for your platforms at boot time and implement the pre-loading of some
>> modules before some others with common modprobe.d syntax (e.g.
>> 'install', cp. modprobe.d(5)).  But you probably evaluated that before
>> implementing your patches?
>
>Some kind but not exactly. I try to provide method to avoid regenerating
>modules deps db during runtime
>
>> If your module load order is just platform dependent, I do not yet
>> understand, why (possibly boot-time dynamic) depmod.d configuration is
>> not sufficiently flexible enough.  I probably have missing some
>> important point.
>
>Device filesystem mounted as readonly to reduce security riscs so using
>depmod during boot time is restricted

depmod is never ever used during boot time... we should be able to boot
without even have depmod and even without modprobe (since libkmod used
by systemd should already have everything needed).

It looks like you have several modules exporting kind of duplicated
symbols and want something in runtime to disambiguate which module
should be loaded. I need an example to understand this... it's sounding
more like the chosen abstraction to have duplicated symbols (rather than a
xxx-common.ko module) is the main thing that could be changed without
adding complexity to module dep resolution.

Lucas De Marchi

>
>> I strongly support Lucas' request for a cover-letter.
>Probably, it will be a good idea to prepare test repo with couple of simpl=
e
>modules to demonstrate what patchset do
>
>> Kind regards,
>> Nicolas
>
>Thank you Nicolas for review :)
>Best regards,
>Valerii
>
>________________________________________
>From: Nicolas Schier <n.schier@avm.de>
>Sent: Monday, July 1, 2024 1:33 PM
>To: Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)
>Cc: Lucas De Marchi; linux-modules@vger.kernel.org; xe-linux-external(mail=
er list); Lucas De Marchi
>Subject: Re: [MODALTS v0.1 4/4] add modules deps alternatives description
>
>On Mon, Jul 01, 2024 at 09:23:03AM +0000, Valerii Chernous wrote:
>> >On Fri, May 10, 2024 at 04:21:28AM GMT, Valerii Chernous wrote:
>> >>Cc: xe-linux-external@cisco.com
>> >>Cc: Valerii Chernous <vchernou@cisco.com>
>> >>Signed-off-by: Valerii Chernous <vchernou@cisco.com>
>> >>---
>> >> README.deps.alternatives.txt | 40 +++++++++++++++++++++++++++++++++++=
+
>> >> 1 file changed, 40 insertions(+)
>> >> create mode 100644 README.deps.alternatives.txt
>> >>
>> >>diff --git a/README.deps.alternatives.txt b/README.deps.alternatives.t=
xt
>> >>new file mode 100644
>> >>index 0000000..9ad3ce5
>> >>--- /dev/null
>> >>+++ b/README.deps.alternatives.txt
>> >>@@ -0,0 +1,40 @@
>> >>+Modules alternatives feature allow to calculate dependency alternativ=
es
>> >>+during build time and aviod to regenerate modules db into runtime
>> >>+
>> >>+To enable deps alternatives calculation use "-D" flag with depmod,
>> >>+it will create indexes modules.alternatives and modules.alternatives.=
bin
>> >>+This indexes will be used by modprobe in runtime
>> >>+By default modprobe will load first(primary/major) dependency from li=
st
>> >>+If it required to load alternative module, it should be done manually=
 before
>> >>+loading main modules set.
>> >>+For example systemd service that detect platform type can load requir=
ed platform
>> >>+modules and after it run main device initialization
>> >>+In case when alternative module loaded, modprobe detect this and skip=
 to load primary
>> >>+dependency
>> >>+
>> >>+modules deps alternatives generation basic algorithm description
>> >>+1. Load modules information(imported/exported symbols)
>> >>+2. Find depended symbol alternatives(create list available symbols
>> >>+   alternatives instead of storing last one)
>> >>+3. Choise primary/major alternative per depended symbol correspond to
>> >>+   build time dependency(build time deps getting from module info sec=
tion)
>> >>+4. Create a list of dependency modules alternatives correspond to nex=
t rule:
>> >>+4.1 All modules alternatives for module dependency should provide all=
 symbols
>> >>+5 Store modules alternatives index(modules.alternatives) as key:value=
 where
>> >>+key is a pair depended#_#primary_depency,
>> >>+value is list of all modules that provide all symbols from primary_de=
pency
>> >>+for depended module
>> >>+
>> >>+Note:
>> >>+Current implementation/algorithm doesn't cover variant where requred =
symbols
>> >>+from primary deps provided by more that one modules. Exporting all sy=
mbols in
>> >>+alternative depency that used by depended module from primary_depency=
 is
>> >>+mandatory!
>> >>+
>> >>+Note:
>> >>+modules.dep index different for standard/basic and modules alternativ=
es algorithms
>> >>+modules.dep for modules alternatives algorithm contain only direct de=
pendencies and
>> >>+full dependency list will be calculated into runtime correspond to pr=
eferred alternative.
>> >>+modules.dep for standard/basic algorithm contain full dependency list=
 for module and
>> >>+can't be changed during runtime without rebuild database via depmod
>>
>>
>> >well... this kind of explains the what, but still no clue on why.
>> >If multiple different modules are providing the same symbol, then they
>> >are doing things wrong.
>>
>> >If there are multiple variants of the same module (again, is this about
>> >external modules?), then I see no advantage to delay the decisions from
>> >depmod-time to modprobe-time. Just setup your depmod.d configuration.
>>
>> >Also end users have not visibility on a README.deps.alternatives.txt
>> >file. Documentation in kmod is kept on man pages.
>>
>>
>> >Lucas De Marchi
>>
>> First at all, thank you for review, Lucas.
>> Let me try to explain feature more:
>> 1. You are correct, feature tested on external modules
>>
>> 2.
>> >If multiple different modules are providing the same symbol, then they
>> >are doing things wrong.
>>
>> Modules exported the same api(the same functions) and on my opinion it's=
 ok
>> and kernel process normally different modules with the same exports. One=
 major
>> restriction is only one module with the same symbols can be loaded on th=
e same
>> time but it's ok in my case(as I described, in my case, it's per platfor=
m
>> modules and devices with different hardware using the same software imag=
e).
>>
>> 3.
>> >If there are multiple variants of the same module (again, is this about
>> >external modules?), then I see no advantage to delay the decisions from
>> >depmod-time to modprobe-time. Just setup your depmod.d configuration.
>>
>> It can be different variant of the same module but maybe not. For exampl=
e it
>> can be cryptography modules. Modules provide the same api but implementa=
tion
>> of api is totally different and depend on specific hardware. With module=
s
>> alternatives feature it's easy to use this kind of modules. You can use
>> required alternative for specific hardware and all depended modules can =
use
>> external functions directly without any wrappers or "if" statements to r=
esolve
>> dependencies.
>> With using depmod.d configuration it's possible to choose primary altern=
ative
>> into build time but in my case required alternative is unknown during bu=
ild time,
>> it will be known only into runtime. In this case it required to regenera=
te
>> modules db into runtime and I try to avoid this.
>
>It sounds to me, as if you would like to auto-generate modprobe.d/ files
>for your platforms at boot time and implement the pre-loading of some
>modules before some others with common modprobe.d syntax (e.g.
>'install', cp. modprobe.d(5)).  But you probably evaluated that before
>implementing your patches?
>
>If your module load order is just platform dependent, I do not yet
>understand, why (possibly boot-time dynamic) depmod.d configuration is
>not sufficiently flexible enough.  I probably have missing some
>important point.
>
>I strongly support Lucas' request for a cover-letter.
>
>Kind regards,
>Nicolas
