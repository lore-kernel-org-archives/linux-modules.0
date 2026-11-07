Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.144.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794039658;
	b=isp4OH8kbCl1gXEOqtkQ1QAgrz6S5QTjhBXHfS6mlU2yjGIXkeAOeQlr+oN4FFvtp28u
	 HdgBcOr2UyLlvDXH9IYrZAuJIxbXWd6WkxDDp3iDYqnI4yba7/jrKVxSB8PbXumxdOM5s
	 y+CHdeTZdl6HaJUrg1FZowETVIFLMXWMtkuK0DtU/QjQJTsIJxAtqjQVi8IWBS3Vl7KNh
	 yMTlziEViR+2/2A5rmKO6V43jsX3xqDZmmjT1iGM8vi13cmE7xUe0PkYMF3Rvw0YxNrDf
	 NhV8WfXwtVwEUuk83GE5AqyrhNTikfwp8sBPV76OjNav9+C2NmBv3gR6AiYTYNXf69w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794039658;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:msip_labels:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BRkK43TJvIPcgLlGFbWyAPXaDmVS1TUfwtVZJOatSX4=;
	b=obxoXs+gSll0EFnx1xvGgUeGx0fxG2hwM5xHG7YkTp2rChEztmqVEBscsAwka9lckOVX
	 aPXzQrkiD7JsV2PK2cuwlJnHebTHFktkIh+sYOz9RRK2scsKH01t2C21ewkAh6tmbK3w7
	 vjH+HtwFoqXcwZ1KiigpUwV4D9hHWIJy6NN3KSuriMTONeMoQdRtWW5b146i9nneoMQZt
	 zqToMfTEhOyOfma7ubc2gP62HQw15Cn5Q27fN3jbYD8b7ujXHnH6c9FsV6fpsv5dEPFMt
	 sBZx7r9VE7APNKutOFOLi7cS/sp7sFvI5357uykeublC9kwCtOIWlEa0XyqfhqWyrFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wsu.edu;
	spf=pass smtp.mailfrom=wsu.edu;
	dkim=pass header.d=wsu.edu header.i=@wsu.edu header.a=rsa-sha256 header.s=pp1 header.b="q/cblCLV";
	dkim=pass header.d=wsu.edu header.i=@wsu.edu header.a=rsa-sha256 header.s=selector2 header.b=dlyUi0kR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.144.34
Received: from mx0a-0007b301.pphosted.com (mx0a-0007b301.pphosted.com [67.231.144.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599B606A326;
	Sat,  7 Nov 2026 08:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3599B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wsu.edu header.i=@wsu.edu header.a=rsa-sha256 header.s=pp1 header.b=q/cblCLV;
	dkim=pass (2048-bit key, unprotected) header.d=wsu.edu header.i=@wsu.edu header.a=rsa-sha256 header.s=selector2 header.b=dlyUi0kR
Received: from pps.filterd (m0269475.ppops.net [127.0.0.1])
	by mx0a-.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A75hluS3630832;
	Sat, 7 Nov 2026 00:20:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wsu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=BRkK43TJvIPcgLlGFbWyAPXaDmVS
	1TUfwtVZJOatSX4=; b=q/cblCLVe6SKwqYuDI5mcV9BCL0KQBueFJrA/PgxnYDs
	u186o+z+A3+krvnaAI59X84F4+r3m2xBVJO5QgDSOS9uiE5n9HrQpig1o9KhwxEx
	oFyoG2L/sNUIK1IBI8wAdfoBJSa2Cqy01crGwIboJobUC7wpV+V3isOPski41wRI
	rKZhS95XGZG84dc6Rgtj28s3A3IwNGVy7U7MadpyE13GXNVPsMh19O82WtwPDhTa
	tIV7qL3cN0BgIz9FZwuvip8tO6gdOP53SO31KvDNrOMt3VhR1nxiQ7Rsv91z+UmH
	uEZ++hdVBVPt4trQ7ACrYDK/vp9QlTIGW+18HuYAVA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020099.outbound.protection.outlook.com [40.93.198.99])
	by mx0a-.pphosted.com (PPS) with ESMTPS id 4hs3qu4d8q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 07 Nov 2026 00:20:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCMXJco7lFh78fzgBoJG+nHya2elAtAJDwmAswp4id+CbHO+kvAqqLNbomsASrSBoRhE75mXCoDIlU/GMtxb6mmBZ80Iz1Fzwj3SeX12vob1pRs+aL5OE0J7qTfwQtLeCFaFkePVodQH5BMJLco48XApfDS2riqAjYdD7cPweCsTD3kB0S1YXRovJQB/q3z57zpXKSJe0XheWnGU+tYXWH2vsJMPYfdUG8Q1ZBS1Dth42hAzuVcF+j/vFQUjdoSWv4d6BZGCFN0PfD3h96Gq58PQlSXd8ZGg6tURE2s2ucVboIoLolH8YTEbvaxxduZJCCEMJJ+bphj4eN+v4C6d0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRkK43TJvIPcgLlGFbWyAPXaDmVS1TUfwtVZJOatSX4=;
 b=Ha0gQwGef+IduZOen+1c4HUDQvu2a5eL1COEvtIFNyoxZY4vXGcea8uNSf+fBksk97QCrU0MK8phisqizSul5gE/oG/VLVnKSF5pEpMbSME5vFRg1UgYEMZEvXrOokM6rwGx28YWui65glPzTyv6VZTEkBl3+IMnbcBTWnUqJK7FSoS/i/O1ZgGt+PV8vjsbNyFvZXelCwUtKW+KLjXA6pusq6G7yhzRTGDDFqXFi6c+HNv0h5tfZ9SEMZPOJiJ4/h0ufZ1THDGQj3mq3iep8v5FZwT9tFC4FbnocgUoz98gH3TLMhR9ckidYKjuB0xZbQQwlCuvBuLZs5KBD2Azpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wsu.edu; dmarc=pass action=none header.from=wsu.edu; dkim=pass
 header.d=wsu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wsu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRkK43TJvIPcgLlGFbWyAPXaDmVS1TUfwtVZJOatSX4=;
 b=dlyUi0kRHmnRTG+vWvDx/2aSRGtesrZk1cqtKvk+jhcqax4pSACmq3o5o8jbLEqPug3hGtCapUpQ2UOvAckPnAQB481GfCWWkJ14ngQ6l9FBXB+hgty2sG1bY7KBiX8shQ1pzozxnbHEgT+vq+BtN3f/M+rG/KI+3eMAePfsBVfZldIs/XvaPDF0z/P3Qcvh2Lop+ax5aE9lE5UuEYiV5LoazcM0CKi5buDW4wjtFw4bmIgRz45g5jru85/B3s2ejTGAmZ9HVUBlgs1RVRrUIXK6sYLlqz4HKFLl3/r/aK1MycHIwRvV9HMD9e0lgqwU8bi6inld1JxMBFVfwHBsmQ==
Received: from DS4PR01MB994453.prod.exchangelabs.com (2603:10b6:8:35c::18) by
 LV5PR01MB9444.prod.exchangelabs.com (2603:10b6:408:300::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.5; Sat, 7 Nov 2026 08:20:38 +0000
Received: from DS4PR01MB994453.prod.exchangelabs.com
 ([fe80::e4b8:f0ff:396a:103]) by DS4PR01MB994453.prod.exchangelabs.com
 ([fe80::e4b8:f0ff:396a:103%3]) with mapi id 15.21.0615.005; Sat, 7 Nov 2026
 08:20:38 +0000
From: "Puranam, Ananta Srikar" <srikar.puranam@wsu.edu>
To: "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "petr.pavlu@suse.com"
	<petr.pavlu@suse.com>,
        "da.gomez@kernel.org" <da.gomez@kernel.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>
CC: "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Priya, Swarn"
	<swarn.priya@wsu.edu>,
        "Ammanaghatta Shivakumar, Basavesh"
	<basavesh.shivakumar@wsu.edu>
Subject: [BUG] module: non-power-of-two sh_addralign is accepted and not
  honored
Thread-Topic: [BUG] module: non-power-of-two sh_addralign is accepted and not
  honored
Thread-Index: AQHdbpBazd52t3XGWkSRaUDGbWvVLw==
Date: Sat, 7 Nov 2026 08:20:38 +0000
Message-ID:
 <DS4PR01MB9944536F8F91384DA8D660D148EA752@DS4PR01MB994453.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wsu.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR01MB994453:EE_|LV5PR01MB9444:EE_
x-ms-office365-filtering-correlation-id: 06cc1654-cead-43bd-a0b5-08df3ca80131
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|786006|18002099003|38070700021|5023799004|11063799006|56012099006|261009220027099003|261009221227099003|261009221727099003|261102123227099003|261009223327099003|261022075727099003|261022105027099003|261022113327099003|261021121427099003|261021123027099003|261028144727099003|261009223027099003|261026121527099003|261026140227099003|10067099003|6133799003;
x-microsoft-antispam-message-info:
 +fh7yWh6I6v+dgh+SxALYb1U1PtOOmiJ6cAUGbHI2jnaeXprbL+1FN3O6dmWGOjTrrYV7MZURGtWUcEXYtZID1UCwb8cVAj5viz4E3qhr6MIt622txoJul6mJp2VxSSMzhwldiiyAW5OyAHb6slK/hXKCMEipG3MIQqDDIpdwH0lXKUyTP7CpAseqW4Y0+gkAqc2E0wLed2KB/5Ek2BFeZ3C+i+Oc7i0f9gCtOQ5vfTo/6sUtfd4sjaQ+E0oqBZBzcwDIxZeUyMNPXKqDeTvNr0psC5BtWO6v34qi1IoM+e6X9tvtRA/OvIb5gfbegohEDayNiG9BkDFoGegj//+yPHCHuDGTitGCrAhY4rgu0dw+jfCjyHGKiPAF/83ZhnUJXak4erBWPqoQCkI1jarjZOcPQDq/Y+htkYUHrt1EfEhc2EcAFXQsllzVv/FTMEk+iU2Sj0yt+igc2KlYjZ+OwHLnD7Xg3eKSk+mTjAgkGOqGW0TyxJiQJsiyQl6UCcH5S1Rzje5H5UMPTu6zZ1S4WvVoxx0XjGAa7TdhFpognto/vjGu3XysFxlklP+PLffrkZCZOpMN1S6jRidkL/tnVwI7dzkEZOPoOD8AeprCR/OFIJxwN2FdnQ3HI7bGk38Lx4endCxUNN43qIlxRsdpaX1t0TAxx1X/jUr32tK1anczm9+k13aNf53BFWGB+X6GbyRIgkXq00uVU105J0uKUJ/aeIa0ZKUubzLipjK1nc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR01MB994453.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(786006)(18002099003)(38070700021)(5023799004)(11063799006)(56012099006)(261009220027099003)(261009221227099003)(261009221727099003)(261102123227099003)(261009223327099003)(261022075727099003)(261022105027099003)(261022113327099003)(261021121427099003)(261021123027099003)(261028144727099003)(261009223027099003)(261026121527099003)(261026140227099003)(10067099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?4hfe3eQXAnYLz+x3NxW2W88cOVLk6SKCcx7SCbMz74DpMNjgzbxJnabNaa?=
 =?iso-8859-1?Q?eCjOQrQpcK9qZhydmoPl64JmQQVTBYntJgaigxEMbs1gn3C0kYPNjYM9fy?=
 =?iso-8859-1?Q?cDvWX1SEpBALbx8KJVr4ypncR/hd8XiGDSQ+6zFId+6fIYBe27dtGQZnGo?=
 =?iso-8859-1?Q?UVs8Z8X3lQyPPCXCxfu5NT+hJoxoTHu7CtQn6SWzUdvcWMHFrMDoNTFnjU?=
 =?iso-8859-1?Q?O0rMTYRAQiN+j5wuq9oeyx13SvSAeelNEHraCGlBxyimjHrPV3cIU9X+6w?=
 =?iso-8859-1?Q?RFmTdYaIFLn8hqHnw0LRhgF4X8bjSme+LM5SMzsDZYsZWYMvLWimQoIPZJ?=
 =?iso-8859-1?Q?3oCZM0txko2lR3qwsxKouhW8bgljOZFYMBgmx1yPjmnJyBBV3nzpVW9FCD?=
 =?iso-8859-1?Q?Y6Birek0mm8A/mx60DkBtsTaBEXrZuhrFUhcRZCoeojMoyZIy74K1pkZzM?=
 =?iso-8859-1?Q?LA08Yram+91JHwK5P+QSr11ifkMCv4ZnYA8B5cuS6eAeoli2WrvyflPFqC?=
 =?iso-8859-1?Q?m5+gLr9gK8uk8flcj3yzWu4yHZg/d4J7Sr/bRD4kyZZ86KwVl+2VA04CFv?=
 =?iso-8859-1?Q?Ot73hJh6OauoHW9/wD+3M0KWZj0d/cm36Ni0p64jGYRTQrKIzpou0qL0JX?=
 =?iso-8859-1?Q?o6wkMNTwHuWlAJYg8zm56eXp9q1yY8EoKKUL8zBLg5ACfkd2fCvVJfZwej?=
 =?iso-8859-1?Q?MkLA4L/6OUONkF3iYtJ2DMhz+dZUb/pj6YKsf2CrFPOW57HyOwUN+6W7Ek?=
 =?iso-8859-1?Q?xDa7RAM+y4bxEIhC0iymDJMTMv0qm/Ce/p7bSN9jP1ZLKqVFAmrLlu//wk?=
 =?iso-8859-1?Q?7t0g6CNNNyMd+XK+Hzyl6QLqt/hmEoVGgSHxVkSgIoJuIw9LC1H/l0LLca?=
 =?iso-8859-1?Q?5IVgA6Nwq70qG+DGg++5TBtqVnhAvRP3mTmHThMS6WPys7znVB7mZVtz/U?=
 =?iso-8859-1?Q?hz5cIVOlgFBDB0veMZgezWf5cRO1m8ZaCMHj8YibVl+CEiLuvsHLcpU07U?=
 =?iso-8859-1?Q?8dZpMFGwq8dF2pLkpF/XZQeAiVKWwRZV9kEC/PFMAy6YoT4wkU0GygwApk?=
 =?iso-8859-1?Q?/mXFoxIlC0Gtcr2BxqOo/dxUlsuP4aGoJbIkbZKRhtH2uf7KhBAY16AoSR?=
 =?iso-8859-1?Q?wfLCie2u9bHGVET/QBdfxdSmeqt0CnMZGlV9VQx5I//c1JurTkq1xsukhW?=
 =?iso-8859-1?Q?W/yxibhc47MOnwIcXq8AmPi+Ybl5S/oRQwF5XYDq7XADzCc4cV6aWaJ8Lq?=
 =?iso-8859-1?Q?4XJDzNUzkw9O9w9XXRTZEvR7YG2s90l2PWW5mKgyt/nuJrIp++84bdv44N?=
 =?iso-8859-1?Q?b8iOMTa8DtMcE8Q/DQ6V3wzFp/5+UTbpO9GMSmfcl7mHYTQKYsDFZHr/Uy?=
 =?iso-8859-1?Q?d9AHLT0Rz9U+X2qQxDwssso3RoUbQa4mqfxte5Plr0lOxr2mcNac6PRI/T?=
 =?iso-8859-1?Q?EibCFdGFTKGYTA5zLv2wJqEi7v1WimUUgrqYLgV0AqdTp5gBSOXRcsoIaN?=
 =?iso-8859-1?Q?XON/15wc+5TNe8X5CkAvO4VNDGnk14FV0UVZ2LjhcV/6UEle8QFqqJM1N/?=
 =?iso-8859-1?Q?tHFeSUuRrGaQm+Yij2NDc8AQNmUFUW10jvNX9hQw6WwalQDTzC8AqofEaj?=
 =?iso-8859-1?Q?zV2SogA9mLGiU2/PBuJC0Wv9pxQ+OKC8+7+HlW3+AaKJic+5nGwRa9yOJN?=
 =?iso-8859-1?Q?9J/r9KNYiMSY9ixslYkg34w9Uxg/yW1zsQWtsqHMnq/aX+PoqNnuEVcpKv?=
 =?iso-8859-1?Q?qLQdTyMHHbLr/WxMPxou8ZyEsdDGCpXaRKT8mJPnkmT0gwiQLO+AkpQIZL?=
 =?iso-8859-1?Q?x7iD9Bnhrg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	eWY70yyLletwZhVU+5cGJKkMqq77h+ocsdwNVgLnWYCehYKGSmM1eSP48W+DY9Ni7BfnL8c/kL3IM5KcN9bSpdI3jUGaBIqtT2FtRa7sKi/92p/b/Ahcu4WsZHHAJLKUybDP0KmeJvFsECbZsNKGgEUJE6G/FW5qnH8mQQMB+NRT1HL/Txtysah+3etVKgtpTRymgFyFx9C5nL1kkHkm0fdw3dt5OqwJHGcDkJeykxiBrqAwjFktorf+OqGPtuhxjpVHjzU1C7t6aqe1ErHuq6tHRAomNoWLrnKzHqw3TMuat0JO963L5vMdHmHGc+vFM8nnZnnpFgOqfibMGZbCBQ==
X-OriginatorOrg: wsu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PR01MB994453.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cc1654-cead-43bd-a0b5-08df3ca80131
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 08:20:38.0909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b52be471-f7f1-47b4-a879-0c799bb53db5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMkeJZIJYihq6NV4qS+Aa8TfAfvawf9vPLF0M+w0GwVoq9Z7X2O9pC7GlxPVAPAzE0eH/L4ql0BpAK9Ka/wdew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR01MB9444
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAzMiBTYWx0ZWRfX9fNDZlAMjuWd
 IkPMzrZFvfCLjqS1KZbJw0A3PQMd91sjWLRXYdlNoSahSAKbN8GKfs/hJuRSmJJbFTpgiTJCsbb
 H4aKCsIuVxKgnU5hNVgr9fXTYVrN4DZGicHeVYj559q4URzJSqpZcuqPp6zHBVMr6D0wpXMlBIA
 OciF24sYyRl3dscLns9f+h3B/nTJBAiHs69p61GALyDKj6QgU/THpPhADpZREVgIbVCyYa4yP7J
 uKW7PMjyTD+NwkpTtN+ef6Bs3j/TyvaThZLJe6y8Vpjn3+i9OZLBvx1Qun+fjGMEgbRWFmNCx1+
 NEM/ZKd0tbZ53Z+/4oHp1Uc/WYkct3BaR7uc46OyzXrQKr1PiFO0BtgkDnKUToCx5ymnGBsIiE3
 IY1cRs0HuiitHbstfCdqQFjUWR4w/irWMfLPiqmxzpbdtOXr9jsuVFITqJvn2f+iLn0NxwJLuN3
 0gspWHAqoWJDua1fcJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAzMiBTYWx0ZWRfX3h6e3MbEpPuy
 2M2ctMHiAqDSahdLHAc7irBeOCvJutslslBOGnG8W+6hZ640PCj53WDZqyg9LiQFxl2eOUGAGRX
 dBzT/tnrh8l+KEHwvvcXB7gYWpDi0NuKLzmHJ0NiBibxbCdRTFtd
X-Proofpoint-GUID: UhPepXPOw1HgdA6YtT_NuNkAQIEhsExw
X-Proofpoint-ORIG-GUID: UhPepXPOw1HgdA6YtT_NuNkAQIEhsExw
X-Authority-Analysis: v=2.4 cv=OofaWC/t c=1 sm=1 tr=0 ts=6aeedf59 cx=c_pps
 a=GknEWMF7HrfbFJOd498rxg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=WNJZbBgGTWIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QNy-vP4XruPnrUY3G42T:22 a=FH6lt2noPR-fR3qg0_jt:22
 a=EbyLl3isfdTh4VHtqawA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070032

Hi,=0A=
=0A=
I'm Ananta Srikar Puranam, a PhD student at Washington State University.=0A=
I'm reporting this bug on behalf of my team: Dr. Swarn Priya and=0A=
Dr. Basavesh Ammanaghatta Shivakumar (both Cc'd).=0A=
=0A=
The module loader accepts an allocated ELF section whose sh_addralign is=0A=
not zero, one, or a power of two, and then places the section at an=0A=
address that does not satisfy the declared alignment.  ELF requires=0A=
sh_addralign to be 0, 1, or a positive power of two, but nothing in the=0A=
section-header validation checks it.=0A=
=0A=
Trigger=0A=
=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
A matched pair built from one minimal external module whose only data=0A=
is an 8-byte-aligned u64 in .data:=0A=
=0A=
  control.ko  .data sh_addralign =3D 8   (as built)=0A=
  invalid.ko  .data sh_addralign =3D 5   (only that header field changed;=
=0A=
                                        the files differ in one byte)=0A=
=0A=
The module's init function prints the live address of the object and=0A=
its remainder modulo 5 and modulo 8.=0A=
=0A=
Observed (current mainline, x86_64)=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
  control (sh_addralign=3D8):=0A=
    module_align_repro: address=3Dffffffffc03f6010 remainder_mod_5=3D2=0A=
                        remainder_mod_8=3D0 value=3D7=0A=
  invalid (sh_addralign=3D5):=0A=
    insmod exit status: 0=0A=
    module_align_repro: address=3Dffffffffc03f6010 remainder_mod_5=3D2=0A=
                        remainder_mod_8=3D0 value=3D7=0A=
=0A=
(each message is one line in dmesg; wrapped here)=0A=
=0A=
The invalid module loads, and its section address is not a multiple of=0A=
the declared alignment.  There is no oops, warning, or other kernel=0A=
message.=0A=
=0A=
Tested=0A=
=3D=3D=3D=3D=3D=3D=0A=
=0A=
  - Mainline a91337fb5e8e ("Merge tag 'configfs-7.4-rc2' ..."),=0A=
    7.4.0-rc1-00590-ga91337fb5e8e, x86_64 under KVM:=0A=
      invalid twin accepted with the alignment not honored in 3/3 loads;=0A=
      control loaded 8-byte aligned in 3/3=0A=
  - Earlier validation on the same commit (separate build and guest):=0A=
    invalid twin accepted at ffffffffa0201010, remainder 4 modulo 5.=0A=
=0A=
Cause=0A=
=3D=3D=3D=3D=3D=0A=
=0A=
The section layout in module_get_offset_and_type() does:=0A=
=0A=
        offset =3D ALIGN(mod->mem[type].size, sechdr->sh_addralign ?: 1);=
=0A=
=0A=
ALIGN() is mask-based and assumes a power of two:=0A=
((x) + (a - 1)) & ~(a - 1).  For a =3D 5 this is (x + 4) & ~4, which only=
=0A=
clears bit 2, so the result is not, in general, a multiple of 5.=0A=
elf_validity_cache_sechdrs() validates section types, offsets and=0A=
sizes, but never checks sh_addralign, so the value reaches ALIGN()=0A=
unchecked.=0A=
=0A=
The same unchecked value is also used for the per-cpu section=0A=
(percpu_modalloc()), the kallsyms layout (kernel/module/kallsyms.c), and=0A=
codetag sections.  I have only exercised the ordinary .data layout path.=0A=
=0A=
This behavior is already present in the initial git import,=0A=
1da177e4c3f4 ("Linux-2.6.12-rc2").=0A=
=0A=
Impact=0A=
=3D=3D=3D=3D=3D=3D=0A=
=0A=
Triggering requires CONFIG_MODULES=3Dy and permission to load a module=0A=
(CAP_SYS_MODULE).  I observed a successful load with an alignment the=0A=
loader does not honor, not a crash, memory corruption, or an=0A=
unprivileged boundary crossing.  Per=0A=
Documentation/process/threat-model.rst I am treating this as an ELF=0A=
validation and loader correctness bug, not a vulnerability.  Standard=0A=
toolchains do not emit such values; the input is a malformed module.=0A=
=0A=
Setup=0A=
=3D=3D=3D=3D=3D=0A=
=0A=
  Host:       Ubuntu 26.04.1 LTS, x86_64=0A=
  Toolchain:  Ubuntu GCC 15.2.0 / GNU ld 2.46 (built with O=3D)=0A=
  Config:     x86_64_defconfig plus kernel/configs/kvm_guest.config,=0A=
              resolved with olddefconfig; no other changes=0A=
              (full .config available)=0A=
  Module:     out-of-tree, built with M=3D against the same build tree;=0A=
              the invalid twin is the built .ko with only .data's=0A=
              sh_addralign rewritten from 8 to 5=0A=
  QEMU:       qemu-system-x86_64 10.2.1 with KVM, -smp 16 -m 8G=0A=
  Guest:      Ubuntu 26.04 amd64 rootfs (debootstrap); modules loaded=0A=
              with insmod over SSH=0A=
=0A=
The source reproducer (module and header-patching script) is available=0A=
privately on request.  Per Documentation/process/security-bugs.rst I=0A=
have not posted it to the list.=0A=
=0A=
Fix=0A=
=3D=3D=3D=0A=
=0A=
A proposed patch rejects a nonzero sh_addralign that is not a power of=0A=
two in elf_validity_cache_sechdrs(), before any layout or allocation,=0A=
with -ENOEXEC and:=0A=
=0A=
  Invalid ELF section alignment 5 in section 9=0A=
=0A=
On a91337fb5e8e with the patch applied (x86_64 KVM), the control still=0A=
loaded and the invalid twin was rejected with ENOEXEC, with no oops or=0A=
warning.  I will send it as a separate patch.=0A=
=0A=
Tool transparency=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
The root-cause analysis, original reproducer and proposed fix were=0A=
prepared with the help of an AI coding assistant (OpenAI Codex).  The=0A=
QEMU/KVM reproduction environment and the reproducer used for the=0A=
results above were set up with Anthropic's Claude Code.  I re-ran the=0A=
reproduction myself and have checked the statements in this report.=0A=
=0A=
Thanks,=0A=
Srikar=
