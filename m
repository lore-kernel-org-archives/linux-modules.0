Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.144.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794377364;
	b=hYKCLVT9E/jiMRaAXpN2Kz8+556dpkVROt4RTatQHyMgJqbM05fmAMM5EVCZSM2fbdyE
	 7OSqRItJxUwI3/kjmc3QarNx72YLE0mIJ/13FtuxCj51jSViKhzDnawap0S1wcbghoxhx
	 bHSl0+PqBSLe9hggMHdG8UKAk73qK7pv9Ipm49X/Rv6Ppl5H5BebNjLeBaC71NZSeKPiS
	 9DuEeJBGBGX/tPtvpbKc65JZbeyDf7/6+bK4aQPlhpDM3V15w7x9nLIPXY0RQk7Oz8WLW
	 lW9vxtFUx0wHznSJeHdUDKjHTBebMd2NChLfAX/Glc7tK0PDr34viZxmi3xV4b6s1Dg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377364;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=GEEBoRfQahvsI+21R5p2EQ7Ng0vgYA/ndxvCJdqUU9Q=;
	b=T6miGmyNf3Cf69BX37vIsNoiK0FcrsS1m0P0LMyvaFOez1JxwbDdyhkvvssQOgy5bEpg
	 lJgYXsbshdlDKvaUDlXvYaRQmTXC2P4SkdmZmJ3qExiOM9OtdtpHgyaj6vEuLBP/gFNw2
	 ovMW0vNUj7nalv9OQEy7imEpgQ0GOSDQgEzKOExtb/rbV8e6K2PF9i6XiGlX1ayUI/ntR
	 wir+WG6aJJUO4M/Zg1OAUiX0/5BXWjZ0706P3of7Y3eWTbysk4sdlLZTYVNNiQVkcFF0D
	 SdsXOmi2cUIQQKca7p+dmc27lRi8F7SUccSKb5XoQPCwc13i751rkN6RZZ3Zd2RqOsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wsu.edu;
	spf=pass smtp.mailfrom=wsu.edu;
	dkim=pass header.d=wsu.edu header.i=@wsu.edu header.a=rsa-sha256 header.s=pp1 header.b=bSB+AjcC;
	dkim=pass header.d=wsu.edu header.i=@wsu.edu header.a=rsa-sha256 header.s=selector2 header.b=dPaBAflD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.144.34
Received: from mx0a-0007b301.pphosted.com (mx0a-0007b301.pphosted.com [67.231.144.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A81606A31C;
	Wed, 11 Nov 2026 06:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22A81606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wsu.edu header.i=@wsu.edu header.a=rsa-sha256 header.s=pp1 header.b=bSB+AjcC;
	dkim=pass (2048-bit key, unprotected) header.d=wsu.edu header.i=@wsu.edu header.a=rsa-sha256 header.s=selector2 header.b=dPaBAflD
Received: from pps.filterd (m0380078.ppops.net [127.0.0.1])
	by mx0a-.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5N5mJ970628;
	Tue, 10 Nov 2026 22:09:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wsu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=GEEBoRfQahvsI+21R5p2EQ7Ng0vg
	YA/ndxvCJdqUU9Q=; b=bSB+AjcCHapwayrp4RWU9XE4VD5F8xinTTqALKd+nj0L
	jyMuu8CFnkz2QLEjzpb8KDwYmrEXd3nIA5TwcG8AwHYyjZrCzso6BIv8/Lr+iRtV
	iTiy2I6JvBY6JFCD9flPpwxomJehozk3WFqaBxmQQ2ArLeKPVzNDYWmJxy4u0JE2
	bOZPDmZrmw+a1X7dHwV3KnM6C/8poqSPQoQqFO+7xGjHXlUqzCtSFTW8L5MPwT0h
	aXM80jb+OU/khXrozkDub9F0Lir7yb3ivjpG2DkLn61qATrDnp1sZXpvWFhbTae/
	/62R6Xrx65iB9lbO107Nd+v66GfPjfTXgGXZVfw4WQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020098.outbound.protection.outlook.com [40.93.198.98])
	by mx0a-.pphosted.com (PPS) with ESMTPS id 4hv7q5t13q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 22:09:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrucN6En6NJ96Bsjfv2Wurl73qHlDg2YreHef2tRqGnisHXzcH/+86AST1NyL18Lr0TxuO1njgl5f9ysG3N3V7fL3NTWABBQxxwrXEIIHzuDW+5lTd2ErDRnsi4+FZQUeks32KhsfBziqclhZ1QYQQP48dKDd5uIKuNZuqVUgI4mBjrSIFLWHXuL50k+pVkdXQJRzFcbUnC/Yhdr11zmVGAHmNhxw0vVyt2BQezIaBXNGtCfNAnW8LiJQuCy49Af0s/lkRjQcLkilw3479AqlRRrWD/ZV7tCMkAVd8zr3Fna+2mXFRrn7XA5vfncDYOrX77gWBYansHguXLquSNvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEEBoRfQahvsI+21R5p2EQ7Ng0vgYA/ndxvCJdqUU9Q=;
 b=yMCQ7+e8vpOFIaxYozv8+5RsiSrHrDdJ2ZEFmx8mQKg5HpFGKzu4CzQjlcEJS/qJvaPF0xXP9YpHdECYTNZJ9z+nHdRNrejCdk0ssh6sUFNtw0aQP1fF7KkGC4bhb5yhidi4p+c9MlHrRCrbr4oPsPGvxbEUNKyW0ujj8jrvT5OIYMV7iWR9x2yyVH2iFdVzfgUHd7hJTcbyR2Ic5N9oGuYw4NP+up399OzA4iWTQWKqodGR6ntACefirAG4WqanqO5tO8NMI0qag1u4/iElUXwcHB18NT0wW0szZ3oNermzllxWhamYAMAQ2n6Rlc1361Usycq8iU1h9zqagJbBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wsu.edu; dmarc=pass action=none header.from=wsu.edu; dkim=pass
 header.d=wsu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wsu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEEBoRfQahvsI+21R5p2EQ7Ng0vgYA/ndxvCJdqUU9Q=;
 b=dPaBAflDampt9pPqB8biW1Cb0BJxuT8pUQ7G6JuV1PdGRmV5JBURKfRhYL9DXbou/rVVI0P9SUfeI/SefCiWdzvREYgVDFX0BBFohB4wd+litEnsM82tldw2aTl2rB3DIkOWCh+/NICHnBeCTUeC6zybyZCbs1sGrDRtURBYuJ24ESQEnL4R0nbalwDrzDpJ/yWFhIVnpk/GqpJFqr9F6QfwAo+DhrbzT53DJ8a9SCoqtLQ1+jgW0SDGl1mpdDhoawSymHgqiNIv+l6+vOQYv4ZKgQFYVU5o/fZ0C3HKJ+I74u95tSkpgclCvSOHPReK0KqJRwwmTYsMSXHlQypJbA==
Received: from SA1PR01MB994441.prod.exchangelabs.com (2603:10b6:806:4d1::16)
 by CO1PR01MB6744.prod.exchangelabs.com (2603:10b6:303:d6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.10; Wed, 11 Nov 2026 06:09:06 +0000
Received: from SA1PR01MB994441.prod.exchangelabs.com
 ([fe80::8117:28f:e4b8:674d]) by SA1PR01MB994441.prod.exchangelabs.com
 ([fe80::8117:28f:e4b8:674d%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:09:06 +0000
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
Subject: [BUG] module: compressed-module decoders accept incomplete or invalid
 integrity data
Thread-Topic: [BUG] module: compressed-module decoders accept incomplete or
 invalid integrity data
Thread-Index: AQHdcZ7Sj8gzPlTq/E2Y4/1hShVG8Q==
Date: Wed, 11 Nov 2026 06:09:05 +0000
Message-ID:
 <SA1PR01MB9944414037B9EFEB0DC1F57AD9EA712@SA1PR01MB994441.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wsu.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR01MB994441:EE_|CO1PR01MB6744:EE_
x-ms-office365-filtering-correlation-id: f80ec803-ee9d-44a4-7b0a-08df3fba4abc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|786006|366016|10067099003|18002099003|6133799003|3023799007|38070700021|261102123227099003|261022075727099003|56012099006|11063799006|5023799004|261028144727099003|261009221727099003|261026121527099003|261009220027099003|261022115727099003|261026140227099003|261009223027099003|261009223327099003|261021123027099003|261022105027099003|261021121427099003|261009221227099003;
x-microsoft-antispam-message-info:
 acRQjls4zB1NV3twxkOEJxPX/7Q456HkvCI9cl8pkjWrIvg4pW0ThNtmRHA4h8liijbakjsJells86isi+6QZHlWZFnhYIcUDG5oQzrdkaNpl+JtVoO3yyhhdV8Xqje5BFaTNaVyDiKwrhQSrjSt2sFQe1eQGovymMwX+dZ/saLgjrmlvpHpkBgCIa+Pp6XcIU1q5vRItmXiKepxE/hjOE5zn81cKlOaSsHoC2EhwCK5eLxAMLx3fcdcV6y16j6Jr0rtXP2dFdlXEypYNrdlK9x4U/vgFYsdetY9whgmlaLf7ZvQ5za33lZAysDBxNFLKhdTHjpVQUPjj6wu7JeZiSyBB/GGtZKaNv5bo0jE1iehimm/Fhe7FttP+4pyrT5umKTNZjJ9R8s10W5Je7tE2EbvwQuFIhKhDgSiUYm3FwLpo7ODn74c8mkBLZuGBh9/WrwJDXtOATeK+tyIiWwj2mwM5R5uwrnjtRTbUwA59pkQC+d2imS1631/X9oiAWYCPRItVIBTjRFe4xweXq2z8zni271r9oxDKGf97qXQ7n9mk7dhaR4wEV7Y44vW3P8uoVYE1JPgYTUgKuEQ7ztEDzL+BtXKxr5e1I1QrVbBkSvaFgqvEJh+A/ZVFRUGuG0Qdv1u2vPD7QLJ27uS49IabvkXZ2vegj8BXd6IUfIuFKVRCn+04peec5JSUIweyzKkJ/u1dDFARvSR+n3pXIdMbw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB994441.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(786006)(366016)(10067099003)(18002099003)(6133799003)(3023799007)(38070700021)(261102123227099003)(261022075727099003)(56012099006)(11063799006)(5023799004)(261028144727099003)(261009221727099003)(261026121527099003)(261009220027099003)(261022115727099003)(261026140227099003)(261009223027099003)(261009223327099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009221227099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XeeTaovBBCvF5/XB98jpk3BtwuKjGqfqHyzj/JA+OwyVUP6yaxQKAT1L5Y?=
 =?iso-8859-1?Q?bR14qmQP33RIDu/HKo0EbvPPb4MkiBT+r+4ENhoPmPt7ixie6dRM2FnoQ6?=
 =?iso-8859-1?Q?W4cZxenaTvIEOQ/xCb1l1GCfFKKJZjHvRrGAL3Ch5HekGrHBkxafgZTlwY?=
 =?iso-8859-1?Q?e/Czw5wYJpccz471UwJg0Vr2xABuFoBnkfF1dP82BGQSN81+yELKDV2+F+?=
 =?iso-8859-1?Q?82iWVU5rcTtGTjWSaqE5yfNg3ud8kFvTdmPxLuIjriYGztBFyK0Jd2MB6Z?=
 =?iso-8859-1?Q?AaybVwufY/rDglabMggwLCoNUrlkpwls61eIenzDSLlzAgUOWGa4BkH5M8?=
 =?iso-8859-1?Q?Gg5+pvU1rRcmFPYlEW3F2oX+rketO21ujn7Gx5cBPn/f2Z7wgreB9NlUaI?=
 =?iso-8859-1?Q?c8z4/HUfogRZSWGroFsLOQiz2zntnS3Plp4jlsUKPuZOcyIs1z1HNYHeyM?=
 =?iso-8859-1?Q?GTrb1KirqKh3hLhaxB+ehq6xO7oT9lZ9Ve9WmZSnx+KAD/DRM9VnCBSRNC?=
 =?iso-8859-1?Q?6EbW02xG2om4xtaYXbn88nR2mi8IBzHRk79rKq7DGod/wEkWj5E9HUmCJI?=
 =?iso-8859-1?Q?m1EC0Y6ravEdOGSz/OEugXtgmqkK8kZNFDu0js/MBmFLvhWDOPCQyNTl1p?=
 =?iso-8859-1?Q?XtxY47M8Gp7yhPnILmMGuYTTZs9CzhWlXbrSIp/mAxgyKt0HAiRo0O6u1E?=
 =?iso-8859-1?Q?NRPw2d74EgOsgW8dJ515mnYtT/hnYZTzSGZPxeheQoNUJglglC64arNY7F?=
 =?iso-8859-1?Q?kokbae5A3/q90cYY9+kMBQAouStD9p/lmTSWB0uBqQi4maDB6H0ChMKhxo?=
 =?iso-8859-1?Q?QEVTC+GBYPGZ+gJA6gGWh1NN2j0NFyiPm8Jz68x1LukG7138cYEo6MfdWw?=
 =?iso-8859-1?Q?v9N8qviLzi2CMEvM4xMEyYzyiDMeVpuwqxJw34Wcasr1cnQ8yRmHMaI97V?=
 =?iso-8859-1?Q?9XsHgAIciqoBc9K92qieWTDaSO+lSKn7cqZcoQF0wnooeUDLbVfhOJNo1E?=
 =?iso-8859-1?Q?3mip+2pTSTQbpFTv95vkww6gT3Dt8p/7ximpbIF1e+4MWhSg+5RAcGKjoS?=
 =?iso-8859-1?Q?YyUnIE7eo35zJc5eEAyslMiCbzroNPKxNDL7TR/zkMRpSuVPc3IRxLAg8C?=
 =?iso-8859-1?Q?oACkHg28/MPdY1nQL8H1aO1q99FFIVkwYPLfA3nTISjhNoTk+5JL7PCYA/?=
 =?iso-8859-1?Q?3Iuv7vjev7WhXFUmI0HqZPeYzuT6wiTX9EoWHbWwD4zrOBVaO29eNwXjKV?=
 =?iso-8859-1?Q?nKMdsQTUO+daVSUYwHG3OTaw5jabrUIgYaZq9WeP/vK/ZgR3aqYF5FTGZc?=
 =?iso-8859-1?Q?fupZTq/Sdi3GCZn3ywPRx1vOASMBY4Tk+8bJZmRO6/rpsU+nn2/VM3osfs?=
 =?iso-8859-1?Q?7gEKMU+NEtr/05SFPB6hhpYNIrp9ttzDQU/zw3UR9ATXRBb6gDo5LQypyd?=
 =?iso-8859-1?Q?89WybMCDUwj3o8e7KOIzG3YNSH2IYRW1Ae6yZBLERsGIjMp25+Y9P9djgd?=
 =?iso-8859-1?Q?uYx/Az/aVkXxpxawr6g7z7X4tnuaSoTQ/nQh8nZXWcev0s2DazkrUQUQtX?=
 =?iso-8859-1?Q?U+UR0GHmo+ydvAV5pikIlBflBbR1IniGIuubKOjJazGbyKK0mxLUCHZHAr?=
 =?iso-8859-1?Q?W/6CiJdq5YWfvrJMJ6DEeqM98+Ao25jN2v4ktuvJjLb0mO4Y4u7rfrbCCi?=
 =?iso-8859-1?Q?GzWbloP2btHNYuuH9ucBnG3Hnc+F1hnY1Q4FhFxnWUkx4lZqigk7qbMpHV?=
 =?iso-8859-1?Q?D74T1uoysl6Y53Dulxl1Z7oFSDQDNkabJ8pvVTndv84VwQEqH5zKFnKzul?=
 =?iso-8859-1?Q?aR6MKd5jpQ=3D=3D?=
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
	DU4YNAXFDpepfuREayIymof1X6nxc4zqapt7sIqsS5C80pCEaF8zdl2ADGh/hEHMVDBjCFqWdYKOgQl0R1T5wKBmT5cZulr5Mqi2a8vdUtZ159m9t8CPjfi+2CKfrmYeKXUYj98GbmB2RP9GZtWprofHUT1dtD1KVcuB8DinxTjGbGEKlZkCBMegDS3bj/6uKTniNY6CecsY3rY1dm6jVRo/nHREyvS1A3avw3NC/5QLK4opBvkV79wgId0eihfz2cyqX8x+MtWcE+QKrbmsrKdqzyws8W/nf3HDQmhncXuw3/8kmEiFsNwRSOWJs1Z/tacI92OdLryQQrgDAV8wew==
X-OriginatorOrg: wsu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB994441.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80ec803-ee9d-44a4-7b0a-08df3fba4abc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 06:09:05.9607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b52be471-f7f1-47b4-a879-0c799bb53db5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGGGnfSEGLsEDSGLOIDW2iiAJZTxSUBN+izKcClO9WlcDmmjHoxGmOYDTGAHrKfmefO8cUtWhDUDMOaLVIEyWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6744
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyMyBTYWx0ZWRfX+f6kfqWBs0Q9
 6/QVpsEHuAFW4y5B8KphGwfwO8urQEhuveRCSBCm6xEHNN2oF9v5FXovD5tHZ4Nu/cPcME1laYj
 c0wZwkFBmAuR0P5BJFgmMOUjyl5ABg/FKS7TSk4zrpU9LBbj7PpVz5kTy35yOsrhSjm/KDMXpb6
 Pli00aLf2TbzRaIYohhMddfxluPAV0uAGAYmEh08lTUd5ZijsCsEUEZxB90kmfmRZAaT2dbb6kb
 6i7RXRLIiNLzsuFI/T9Pee47w5FFTvqQEiM2qCsDaFd1pv+eqXIfM6bY6/Q8c8qT5bVIcW07lFS
 YoL2hMFvmJ8FlUR4CYGONL9yizQPT/Q2kNzYElqRuoUxtkZm7YGuWP5AD5ndHoNUSmrKF3BR33m
 sB2LnfpuHikCLZioSUbbxXRDAhqlus+FlyRvwPO8JmM1kdXgqZuyX2185SEj9alWOyZ4SwokVWg
 D0Ut/IlbYSis/ksdmhw==
X-Proofpoint-ORIG-GUID: KlDkz5gH4SsBno0v6TJmIH__6hXp5RcW
X-Authority-Analysis: v=2.4 cv=W62txhWk c=1 sm=1 tr=0 ts=6af40685 cx=c_pps
 a=5WG37Iiv9zZuKkK3l3Cj4Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=WNJZbBgGTWIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QNy-vP4XruPnrUY3G42T:22 a=4sU0x0kF9hyHJ1ZizX4c:22
 a=eEQwqMApyrIH9XVNC-EA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: KlDkz5gH4SsBno0v6TJmIH__6hXp5RcW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyMyBTYWx0ZWRfXxXVKUt2x2Jk4
 s8aVM+5hlGfiktf1RbgMBTkGGX2YxEKTeJls2g7xBAUXJuoFfQynLuXMUW/EmtDphyxphrBvCdN
 lbjHwqXIB5WEDfQrUSIYeimYmbDmJE93/XmzecSrTXwU6JeyZ6ho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110023

Hi,=0A=
=0A=
I'm Ananta Srikar Puranam, a PhD student at Washington State University.=0A=
I'm reporting this bug on behalf of my team: Dr. Swarn Priya and=0A=
Dr. Basavesh Ammanaghatta Shivakumar (both Cc'd).=0A=
=0A=
With CONFIG_MODULE_DECOMPRESS, finit_module() with=0A=
MODULE_INIT_COMPRESSED_FILE loads a gzip-compressed module whose CRC32=0A=
is wrong or whose trailer is truncated, and a zstd-compressed module=0A=
whose frame checksum is truncated.  The gzip and zstd command-line=0A=
tools reject the same files.=0A=
=0A=
Trigger=0A=
=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
One minimal external module, compressed once per codec, and variants=0A=
that change only the integrity data:=0A=
=0A=
  gzip-control              the module gzip-compressed at level 9,=0A=
                            single member=0A=
  gzip-bad-crc32            control with the low bit of the first=0A=
                            CRC32 byte flipped=0A=
  gzip-incomplete-trailer   control with the last byte (end of ISIZE)=0A=
                            removed=0A=
  zstd-control              zstd -19 --check of the module, one frame=0A=
  zstd-incomplete-checksum  control with the last byte of the 4-byte=0A=
                            content checksum removed=0A=
=0A=
Each file is loaded with finit_module(fd, "", MODULE_INIT_COMPRESSED_FILE);=
=0A=
an accepted module is then removed with delete_module().=0A=
=0A=
Observed (current mainline, x86_64)=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
gzip kernel, every case loads and unloads:=0A=
=0A=
  case=3Dgzip-control.bin            load=3D0 errno=3D0 after=3D1 unload=3D=
0 cleanup=3D0=0A=
  case=3Dgzip-bad-crc32.bin          load=3D0 errno=3D0 after=3D1 unload=3D=
0 cleanup=3D0=0A=
  case=3Dgzip-incomplete-trailer.bin load=3D0 errno=3D0 after=3D1 unload=3D=
0 cleanup=3D0=0A=
=0A=
zstd kernel:=0A=
=0A=
  case=3Dzstd-control.bin            load=3D0 errno=3D0 after=3D1 unload=3D=
0 cleanup=3D0=0A=
  case=3Dzstd-incomplete-checksum.bin load=3D0 errno=3D0 after=3D1 unload=
=3D0 cleanup=3D0=0A=
=0A=
(load is the finit_module() return value; after=3D1 means the module is=0A=
listed in /proc/modules; cleanup=3D0 means it is gone after unload.  The=0A=
loader's before=3D0 and unload_errno=3D0 fields are omitted.)=0A=
=0A=
For every case, dmesg shows only the module's own init and exit=0A=
messages (plus the out-of-tree taint notice on the first load):=0A=
=0A=
  compressed_repro: loaded=0A=
  compressed_repro: unloaded=0A=
=0A=
There is no decompression error, warning, or oops.=0A=
=0A=
The same files on the host:=0A=
=0A=
  $ gzip -t gzip-bad-crc32.bin=0A=
  gzip: gzip-bad-crc32.bin: invalid compressed data--crc error=0A=
  $ gzip -t gzip-incomplete-trailer.bin=0A=
  gzip: gzip-incomplete-trailer.bin: unexpected end of file=0A=
  $ zstd -t zstd-incomplete-checksum.bin=0A=
  zstd-incomplete-checksum.bin : Read error (39) : premature end=0A=
=0A=
gzip -t and zstd -t accept both control files.=0A=
=0A=
Tested=0A=
=3D=3D=3D=3D=3D=3D=0A=
=0A=
  - Mainline 067c5c24cef2 ("Merge tag 'page_alloc-for-7.4-rc2' ..."),=0A=
    7.4.0-rc2-g067c5c24cef2, x86_64 under KVM, one kernel per codec:=0A=
      gzip: bad CRC32 and truncated trailer loaded in 3/3 boots;=0A=
            control loaded in 3/3=0A=
      zstd: truncated checksum loaded in 3/3 boots; control loaded=0A=
            in 3/3=0A=
    Each accepted module was unloaded and absent afterwards.=0A=
=0A=
Cause=0A=
=3D=3D=3D=3D=3D=0A=
=0A=
In kernel/module/decompress.c, module_gzip_decompress() skips the gzip=0A=
header itself and inflates the payload as raw DEFLATE:=0A=
=0A=
        rc =3D zlib_inflateInit2(&s, -MAX_WBITS);=0A=
=0A=
and returns success as soon as inflate reports the end of the DEFLATE=0A=
stream:=0A=
=0A=
        if (rc !=3D Z_STREAM_END) {=0A=
                pr_err("decompression failed with status %d\n", rc);=0A=
                retval =3D -EINVAL;=0A=
                goto out_inflate_end;=0A=
        }=0A=
=0A=
        retval =3D new_size;=0A=
=0A=
With negative window bits zlib does not process the gzip wrapper, and=0A=
nothing reads the 8-byte CRC32/ISIZE trailer that follows the DEFLATE=0A=
data, so a wrong or missing trailer is not noticed.=0A=
=0A=
module_zstd_decompress() loops with:=0A=
=0A=
        } while (zstd_dec.pos =3D=3D PAGE_SIZE && ret !=3D 0);=0A=
=0A=
and afterwards only checks whether zstd_decompress_stream() returned an=0A=
error.  A nonzero, non-error return means the frame is not finished,=0A=
for example because checksum bytes are still expected.  When the last=0A=
call fills less than a page the loop exits, that return value is never=0A=
checked, and the function reports success.=0A=
=0A=
The gzip path was introduced by:=0A=
=0A=
  b1ae6dc41eaa ("module: add in-kernel support for decompressing")=0A=
=0A=
which is in v5.17-rc1 and later, and the zstd path by:=0A=
=0A=
  169a58ad824d ("module/decompress: Support zstd in-kernel decompression")=
=0A=
=0A=
which is in v6.2-rc1 and later.=0A=
=0A=
Impact=0A=
=3D=3D=3D=3D=3D=3D=0A=
=0A=
Triggering requires CONFIG_MODULE_DECOMPRESS and permission to load a=0A=
module (CAP_SYS_MODULE).  I observed modules loading from compressed=0A=
files that fail their format's own integrity check, not a crash,=0A=
memory corruption, or an unprivileged boundary crossing.  With module=0A=
signing the signature is checked on the decompressed image, so this=0A=
does not bypass signature verification; I tested with signing=0A=
disabled.  Per Documentation/process/threat-model.rst I am treating=0A=
this as a correctness and integrity-checking bug, not a vulnerability.=0A=
=0A=
Setup=0A=
=3D=3D=3D=3D=3D=0A=
=0A=
  Host:       Ubuntu 26.04.1 LTS, x86_64=0A=
  Toolchain:  Ubuntu GCC 15.2.0 / GNU ld 2.46 (built with O=3D)=0A=
  Config:     x86_64_defconfig plus kernel/configs/kvm_guest.config=0A=
              plus=0A=
                CONFIG_MODULES=3Dy=0A=
                CONFIG_MODULE_UNLOAD=3Dy=0A=
                CONFIG_MODULE_COMPRESS=3Dy=0A=
                CONFIG_MODULE_COMPRESS_GZIP=3Dy (or _ZSTD=3Dy)=0A=
                CONFIG_MODULE_DECOMPRESS=3Dy=0A=
                # CONFIG_MODULE_SIG is not set=0A=
              (resolved with olddefconfig; full .config available)=0A=
  Module:     minimal out-of-tree GPL module, built with M=3D against=0A=
              the same build tree; the compressed files are produced=0A=
              on the host from that .ko=0A=
  Host tools: gzip 1.14, zstd v1.5.7=0A=
  QEMU:       qemu-system-x86_64 10.2.1 with KVM, -smp 16 -m 8G=0A=
  Guest:      Ubuntu 26.04 amd64 rootfs (debootstrap); cases loaded=0A=
              over SSH by a small static loader that calls=0A=
              finit_module() and delete_module(), with dmesg read=0A=
              after each load=0A=
=0A=
The source reproducer (module, case generator and QEMU wrapper) is=0A=
available privately on request.  Per=0A=
Documentation/process/security-bugs.rst I have not posted it to the=0A=
list.=0A=
=0A=
Possible fix=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
The gzip path could check the CRC32 and ISIZE in the trailer against=0A=
the decompressed output after Z_STREAM_END, and the zstd path could=0A=
require that zstd_decompress_stream() returned 0 (frame complete)=0A=
before reporting success.  I have not written or tested a patch.=0A=
=0A=
Tool transparency=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
The root-cause analysis and original reproducer were prepared with the=0A=
help of an AI coding assistant (OpenAI Codex).  The QEMU/KVM=0A=
reproduction environment and the reproducer used for the results above=0A=
were set up with Anthropic's Claude Code.  I re-ran the reproduction=0A=
myself and have checked the statements in this report.=0A=
=0A=
Thanks,=0A=
Srikar=
