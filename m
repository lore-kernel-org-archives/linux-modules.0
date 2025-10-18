Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020129.outbound.protection.outlook.com [52.101.195.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A201E2858;
	Sat, 18 Oct 2025 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760810543; cv=fail; b=MhnrurrB33R8Q/0E4xCQU/NfBTGxioTN+XIE02S2MSPlCXadlQM4BysM5wQjfQZrEMx8kK79PvXw+Hlm5geGQG5GsUZD6jTm84v1UKlDEXeUG9SBr14OjRE/xHmYQFS/6G8dfv4PgBW1Lg7dBVhLn6s9cp5WHMah+ZRSGvS+Bug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760810543; c=relaxed/simple;
	bh=haJKTxZVqjwXR2pB4eRiThrt3PuNoX4OswXMfnu3res=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=johEZXEQxABRK+K/qBhGyOeIaZIlasECwv+urYkjT9CRHYb7iH2jaHtzWvbNBxtALbwf+Yytm8f317Ccs/aP9+MD5OFb9VxDWyOI3ysRvJ5YAU7MntgcfYFc5/JJERPia5bI6NqFsWfnYUF5QW7tO5DVEobpY0Ac7QQaaSei2yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcAQmK/n3hhpO3YuOIsX+IJmUXo8C9EPqJLB6ujPJ8LqT5A5N1HFD95TIlCz4OBudoEZLpnztcSDSVHaXZch7rml55tGMbpvDKIUKmrJEOaCCWXbck6NeMNO7XbbwnVG/panrwszHg8LO9U3tUacKNcSfBGXLXOwSxt+zC9CtMucBanoOjPUj1D79dC9JMzgMvD2Sn5yB2D8/8GZoQm0BsBkmiuJ0sd6RsRHAF+G6umD47B2Uslv9E4UWfrDBRFQavjBvmka5Ia8hmq+NDFX6sRYUbMEh5Q7HhZug7PDM9dA9fMfBbt0MQhSL2Adl+3BYyeafwRJk5m9STzlCQrTjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+HOFmLGo9kuFJ+K+QvdR/Xe1ltHxGrHUSce/xYvb7M=;
 b=H0j3pc0cAZOwvgjMxwXc4fWrVsdKL91FLh1fuWdV3plMeekGGefXhMvNy7ImUAObZpfAfk3HtXzoAUZibk9/iz4OQ4yG6lWPFjfF7IqbiC4t6vleVr6aqaiIY1qh5XKW6AsA9bxdAZ8uPxV9WqdqIYVEzB/cznZucYMqZ3yLq5Dy38nGdmFOhppoofGVQy9Us6k0LltyxOW1OvtjuykWJrDKenP4ZXa6qs6RQCOPZcd6kjbIE2G4MMjYNMnTSXZG6Jb6cXd8EI+81t3TXC1ePcKbPKp5janINKt4wItVdQa21XPrxdqPDNBEZ0i2cLFqO678HWYpbpwWnWLkN34J5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO8P123MB7747.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 18:02:18 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 18:02:17 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add myself as reviewer for module support
Date: Sat, 18 Oct 2025 14:02:10 -0400
Message-ID: <20251018180210.347619-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CWLP265CA0544.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:18d::12) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO8P123MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 12fe017c-db0d-4fca-f246-08de0e70799d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y2gLfUiddpkuRtZC5jib91YYFble6oEQrEvUJ+hnruQ0pVs12dyev1oI9sXE?=
 =?us-ascii?Q?xb2dFZqyePGEl/JGue238SG3jiTpb//dh/sL2ON8y9XDI64xnBmO9P5QaPQE?=
 =?us-ascii?Q?Zn7PwTmU4fdpOoIoFFTanH0CXn8sskx4Vdoe2RbJDzJkpkW0VK9pt8R4OQG3?=
 =?us-ascii?Q?K05V1rmI5vRQlhCZqzoXOaD5w5PtqtjR/KpX0LruDio3ZMzhmBKpGdUH9+FX?=
 =?us-ascii?Q?Xvstcqv0cnvVPd3rdjz0zFBMM5cMOjeOR9UpBVWLE/Z7nLpoTanvmO5yoEB5?=
 =?us-ascii?Q?rum+DqwCmHf2PATRxKW7ze1sDGimpUhP4vFFNDPqaXuDbzT2a7z8lY4K1OxV?=
 =?us-ascii?Q?qigmq8FK1OOHI4MmqnMUMljrPeSAj2xxi7Ek8bKnJD8d3A4iz1LX58yaIfUE?=
 =?us-ascii?Q?6mJwS2EbQQQwE4kbJeVzbnf026yL1ClMvgfynGjZcUPs6um/IIkwBJrVKbQj?=
 =?us-ascii?Q?Kw9KqwAM//ecK+uw1g51OFS759wEhK3PsrgUdk9P1R3rcq8yRtkkJp6FhnOf?=
 =?us-ascii?Q?Iu/hjSPlhDva7bIPkBQdhVJ6EkamsIjg5dU7/LKwkrgY6hdqMbOmJKHGSWJa?=
 =?us-ascii?Q?kUtrOkplEELxnq2xYHu7GnB1GfZbCTIOIRuNp/S6f6egrcbeBJy0OfxrGw8v?=
 =?us-ascii?Q?2gfIO61XuF6zDBTZ3wpu8BC1HC00jUC9I9Nlf3tTkwHBzoBs70QE5atFYpS2?=
 =?us-ascii?Q?aZ3JmsznKqN0D1moWKZvSAyOBgPFwDTn72XC6nEorJ6uH5b/QF8JC9uVeqol?=
 =?us-ascii?Q?vtmgfmHiYHQg5XKvKFJGS1/sKWCqITu7Nn3HSBOuS8b7DUZAh2dFHrg3uEL/?=
 =?us-ascii?Q?jcS4ukqFGWJfQHEID36T5ExeZQCkt1fIGE0TsJ1KVxkKQy3+Lb2TKb/MVdsZ?=
 =?us-ascii?Q?rZtWsKP28pRFC9ZY8bktkBQvn7s7pguWxl6jMJkuTbXmwx0KYx/QhYM+tF5i?=
 =?us-ascii?Q?hMCkp+IgQxchBGl6+zN7KsF9E2LSf2DEt7ibIBzqWXQJCwlIISDo3fXWyDYi?=
 =?us-ascii?Q?v5l7x4WFHCgMbMbfH8pIDxzmdrHGJJ0wd+H4LsuR5W2Wrnw1rqKPHUNfTuZk?=
 =?us-ascii?Q?+sT+wbkkHP1Z3H3IltCjlcC3y8YOYoDFeZ3QS4S7iF5l93iZnaPgqm+3zSzL?=
 =?us-ascii?Q?jnNx1gSthc76/XoDN8prs9aYF40JcEEw8XNW53k9UCY7DSsBgn1uhNNFr0J7?=
 =?us-ascii?Q?I9jMY0gyZiy40IOp8yL3LnpkSTgwlZU5jWtqbxmZ73SLZ5ENOPHlTI+eNkgJ?=
 =?us-ascii?Q?15tJ/VOlLLrgLsN6HXG2JgmrO787VfSjKQplpJgdmjLXEqU0AWniQt2XP7wb?=
 =?us-ascii?Q?RMQkqT6HUkZdvQyleb3Pn0uql07n9o2Z9sIBsAj5zP6n2XSxyL0W4zjPvp4Y?=
 =?us-ascii?Q?6V/TKoRjGm72ApUuJ0M01w40szmoQwWtAWDMiriomWbIJmXu1jOqOSeZuy8B?=
 =?us-ascii?Q?PVxBB3WFUb/g5wyLi/EGPvidbrkbHWQU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X35EqqtxzPJEkkcuoS1liA4UMQDjfGIEA/5gVlG9rGryMRn372czKvdeTBAB?=
 =?us-ascii?Q?D2O/tvNX/FPpnW4KUXkJGLQ+WpohCz5Mr7inNic6X7urkcYMhnYEbvOOYSmN?=
 =?us-ascii?Q?ivZedsO1LlSbSwV7fwPbVKVgmuzQdaIKioZS23SB9oEy1iXcmepRomIXMHag?=
 =?us-ascii?Q?91seM6OkyCinlkpdo6WDXXm14MRLMU5gF4ymHj4lwz1TccrccS/8kPiD8EOF?=
 =?us-ascii?Q?Gnb7pCyNbpB2y9aXjhjmsHx1volVDbSnS7sMOYABgCucV0y8PmWffKTWO4Fr?=
 =?us-ascii?Q?lA4ws4bl8ZPJbTWCjaZCz2xaQBmA+1Knup9p63J8dRFyNOwRfdc3kbPY6/cg?=
 =?us-ascii?Q?KzR930QSbfqOH6YPwgGJatgJ8ULve1JOfS/sCM6SSyGgReS1E45LJFjAI2y7?=
 =?us-ascii?Q?PqYo/tT0rJKMaWV3LjdAU1vukQbdQ5s/jsBKn6kBe3DVln2DtZ2/sM5d2HkM?=
 =?us-ascii?Q?O9Gk/DZnpzQ8besPLMf3jeOO3GCz2mXnkTvUOYpS8+PwZj95Dw++106oEFUz?=
 =?us-ascii?Q?6m/0QQ+pepgoMiJXub2PrHUxqDcCq1NK9viGbnNvhew/hwxtB2JM7nVu7S7V?=
 =?us-ascii?Q?LgeUUv8l1reOLb2lI2pOsQPl3e4H8eAvuUhAk7N0MbtHPfi7BlEV1RGutrD7?=
 =?us-ascii?Q?VkMllQO8CDkvCkb6qjHS5AJjjNN5vcm58E7vkEWm+p7detPYfsywGsDzawrR?=
 =?us-ascii?Q?R2q6Nb+elqrnyQnhCA1uJv8bfPmSd4Jhv8di3wpCvrj1WcIyX9LWK1fvUWRQ?=
 =?us-ascii?Q?r/SchY9U8ibtLA7yOCtwvVhjJW/1vYWJQdvDQaiW6CNIUo27clPIKAuBBkCE?=
 =?us-ascii?Q?Grh84yQyhBRml7LEc1SUcGpl2h25J83ZliPnm/teQhIYX8xYfsUE8zwYCjWo?=
 =?us-ascii?Q?4Lm5cJzunC3JIIpBL8ThCBegSMRHRdXOYPtXJ86d6iGLVjFBOL2b3uP9XAwr?=
 =?us-ascii?Q?Ewk98cItRc+jT7fDBkR0SGYrVvXPPpasQ3dTxUd2ijZpc6ZidDpsyEcrkjYV?=
 =?us-ascii?Q?8/Ux7EZ49MzWjg6RxOjktax6HxHVD9akssRBxJLHzDQ7l1tpEOv/01+hJxab?=
 =?us-ascii?Q?i5InxR07+RQJuH5g6eAuLl3i1EHKetKmD0AS/PwOtie3pcHdc4GXFqwa/nN0?=
 =?us-ascii?Q?Tl+ku06uHXPRKKWBK5xB7HU1N0c4bOlgk7vc8KIMz69rHMhIVwGYb+XlbjSN?=
 =?us-ascii?Q?8q1nGFwyaqsXEBeuwArh9kFs/WewRMTLN88JFa2Jw3WXLo/LwPyXiyy4HK05?=
 =?us-ascii?Q?zSDgFg5w7o0MhAep7Pj7LDIRn/v0sIdwdN2Gv+t24x0eVlomNVpa2SiBMonj?=
 =?us-ascii?Q?j2JbtdG3MGF8QRfHhTOmR4QuQvafuecYV0EkPeh/+cZBbvSawJ0GV8lQ8wQT?=
 =?us-ascii?Q?YFnMGuda7QzRbxhiwOZI4/pc94vF4FKOyPN37/bb7Vsl8H1E8ofp1CkOe5nX?=
 =?us-ascii?Q?9f/4Dv+a74nfxVPOanKgQBr7DJtxmSY4P0s82bvPyfVITbDgJS33b9MKtmg7?=
 =?us-ascii?Q?tleRxVwHxZk7O7znuucXmQtoeubEmPHHBaSKzjOdWqIy63rXZmMQ2NNC5GMZ?=
 =?us-ascii?Q?fH4lceIVdqnPALk6SmG8FNIb1TbK4vcwiHPwiLQw?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fe017c-db0d-4fca-f246-08de0e70799d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 18:02:17.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: up6GGW7aIthyx380iKzh3APA0PxkAT68FQXEx3TmrBB6Cm3ipKGmOVTM0Rke7AXkcLbFMQBSPZM9JlCYozmu6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB7747

Voluntering as a reviewer for Module support.

Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 545a4776795e..c6c860ccdbef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17392,6 +17392,7 @@ M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Petr Pavlu <petr.pavlu@suse.com>
 M:	Daniel Gomez <da.gomez@kernel.org>
 R:	Sami Tolvanen <samitolvanen@google.com>
+R:	Aaron Tomlin <atomlin@atomlin.com>
 L:	linux-modules@vger.kernel.org
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-- 
2.49.0

