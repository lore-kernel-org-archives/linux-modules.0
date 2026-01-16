Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8E3225760;
	Fri, 16 Jan 2026 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591094; cv=fail; b=UYFB3hGTvFNUzsRqqqzYTh7tMhzGkTUkMQ2hrD4ctJ1nyybGe9aZGT7tLAgf+PqoMcGxNAurRUPmRnP0zqW+WS63Cj7EWRUdEnGNQJz3hvf2OP13cy3cYytne8aywe1fIcuxY+erngRXlWI6dtVhUILrdmeq1Rvd0IvcIp4MUVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591094; c=relaxed/simple;
	bh=bEUdwlETfgkr96e3vhu2sRLWEV5dmsST2FNlqcBhUFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CWOirQwDjn8nsv3D2TC+Wd+fFgWNGf05kBAVjAuM02fvoo8+pKCnyMe2E0xlX8V9IypNYFJYlB1zywgaFJWHZevzcww36Y2ayVpQI2wm39y/ZTz+tS6rm57okf6tZ01xwe8nHxUSdLWex5sgjEaelGQQzzk2YQ5kjetrq3vouA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=M8xzppxd; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="M8xzppxd"
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60GHdk40001316;
	Fri, 16 Jan 2026 18:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=bEUdwlE
	Tfgkr96e3vhu2sRLWEV5dmsST2FNlqcBhUFY=; b=M8xzppxdcQoQixlZco069FY
	22Luz97Yhx3XsXlhFn/a638mzmeZVX19RXYmrul00J46YrT2d03vdBd5DYmiNaMf
	DRTHaQwRbSpqzq9DViDpE13eXPgpo/tw9sxutKbyXaEZeDX6vzfjGT82q7LBPrAa
	0DB2mpl2ebPm/auF/XzbTCoSDs7utdl0p+n3oQ0Tz6JUB6vtGcOrlfM7+tySC62N
	a5QR8wkHcwEZgEQiU/YNK9qElsm/JSbYa0sBoP6Jq8h1A/XwOQ88gijnKNiWVLwT
	UQ3ga1iF89pS1zj3HW6+DiL5tLF+iKjpe8tRIoD8K1DEMueEgwDAwaynx+HtDVQ=
	=
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4bn1ftdmtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 18:45:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ue5/pVQeMDtUil8cWMy/65hppEYhUdmOzAXrpMLnXDApB84Dzjlp3wEr3qCLST6/IlBIPupKWqQnU4GK7fQUb1GWM+vD20bcKkj5d1+YL8Zd1iXqxK3NsXS8Y+ZuZ7DmJo6lD9lFthsY5E6zc0tGToKnvqaUbwYLCoCSak2jOHqRX1i4Z37K6CkA3IN+8+pJbKxOrhsEZSEn6BaxW2QVgUPhFK0x+HnIjq5JGTNShKeVwrquT5EIvlaaozuoBO4sKxPJed7AuGy/50zfN5RXU4djzn44HCH1HxMtDS7X1Jy4nzPPGcdDNpgP92lcEMA8OTwhyUhmpJknE1X/bHcLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEUdwlETfgkr96e3vhu2sRLWEV5dmsST2FNlqcBhUFY=;
 b=zEbkRZEjWWqRAQSJ4aVMQ0nHLye7KSPRRdVfOx2gyKQQ5exOl1/2i3HAja79JVDwwGf1d89ktHwI9DfUnRDSSVOQ4ihjWNi1f32oYmhMTV8058R16/3+9aS/eA9TAiiJL/6GIJ+pI9xJ4R1DnS3F3CxH+XMtfAK91vdy1/qSXOhYFmllGJ9W+6jM6lM8eQ9Hc4Q1ITl1x29W3EtJlgz9il5aMOG2iFpMa3R1GTWA1xIhVY647xJTg6I7Eax9SgMnz/Yz4a5VLsVq30jCKywqjKyBAhsoP5jZca1y1/4LQCVMN0KLen3VtD+dU5m38sNyjq290VkbGhBpe37Yn9yYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by SJ2PR13MB6120.namprd13.prod.outlook.com (2603:10b6:a03:4fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 18:45:07 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%7]) with mapi id 15.20.9499.005; Fri, 16 Jan 2026
 18:45:07 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "petr.pavlu@suse.com"
	<petr.pavlu@suse.com>,
        "da.gomez@kernel.org" <da.gomez@kernel.org>
CC: "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kernel: modules: Add SPDX license identifier to kmod.c
Thread-Topic: [PATCH] kernel: modules: Add SPDX license identifier to kmod.c
Thread-Index: AQHchnvAtOVKPESxe0eZEln61uIK4rVUb1cAgACkYjA=
Date: Fri, 16 Jan 2026 18:45:07 +0000
Message-ID:
 <MW5PR13MB5632A29DF79B1052ADAA91C3FD8DA@MW5PR13MB5632.namprd13.prod.outlook.com>
References: <20260116000431.643070-1-tim.bird@sony.com>
 <3beb5db7-efb8-4a68-b5fb-aa2aed2ac52f@kernel.org>
In-Reply-To: <3beb5db7-efb8-4a68-b5fb-aa2aed2ac52f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|SJ2PR13MB6120:EE_
x-ms-office365-filtering-correlation-id: d95a5b11-3428-4d0b-c3c0-08de552f5e95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2ZBcUxHQ0tsNVprSG5YcUNaRHdjaHJyWmtROFI0NW4yanpVZk1QeXFwODJi?=
 =?utf-8?B?OUtEUG1XQ0lFMFUybFJibzV6SFJtTnJldDBWZHhnWHNUUGcxQ2hZR25pTEd6?=
 =?utf-8?B?ME44MXlucmVGUzl3RWErd0NmUENCcGt0K2NxK3h4Y1NGZnNuVmZ6Mm1QMjVP?=
 =?utf-8?B?K1JYbjZkYmNSWDJRUVMwU0dqZ3I5SUNESGxOYlFaK0JMWVhUbjBiSUF5RTZH?=
 =?utf-8?B?SFREbk1wRk1oNG9Mc1MrSVlKS2wwaWlvYi9oSHkvNFdHeWdJVFA5KzBxbGxT?=
 =?utf-8?B?Q05ua0FzRkttbFM2eEdxdkNXcWRwc2hBazBxZzVuem1MYlFNdysxaUE1ZFlI?=
 =?utf-8?B?N0RPdm9IZXZRRitEWUh4SWRPYnhaYkdlQnllTDN6UGdVVSsyT0tkVGlNVUdV?=
 =?utf-8?B?NThmdEx1cEljbXlNd2JNOVFyekJTd0gvSjV2NzBLdmpDcUpVSEpYV2lTNU5H?=
 =?utf-8?B?YVR3QXl1Q21qczUreEhZSGNZUnNocnZHTURuVWRzVkpTZE5wWDF0N1lQWE5B?=
 =?utf-8?B?am5ORUxTN1BNZk4rU2NyRkNYTndGYm5FZHFIM3BVK3BHMjVxNTFXZmduUE9s?=
 =?utf-8?B?cUJvSW12VGhLTmpFK08xcFhONVZRNHJkK2t6STd2ZmxkVWtHeVVDUExLa2Nn?=
 =?utf-8?B?c1JXb09PbHNaT0djS3Bid1BBblNCc1M5RHpDSUE1Y3V2SlhDSkJlMFVZc0Ez?=
 =?utf-8?B?S0NBUWRwRWs0VmNWRjMvcUp0dXRMZ1NxbFdQcVBENFBWYUtLeXRLdllNSDFH?=
 =?utf-8?B?ZFJCekpDSzZYWWNVN0xvYXVIaStDa01Id0hMbmJ0WTJtTG11VnNyZ3BIUGJB?=
 =?utf-8?B?YktlaU0yT21IYWl1eHJDbnlva3pFRUJ6dGorejIzaDhHRXFoMmdTMHoxWVM0?=
 =?utf-8?B?R1pjeGtnUE16NDF5cmMyYVdkVEpINzZ3UjRVMytCN0xPZHVqbTgvKzgwemc2?=
 =?utf-8?B?TUk0RjJJemMyMW9GeVZUa2JNVkw2Q2ZPSElaVVBqSUFWNUszNm9IZWZzSmxl?=
 =?utf-8?B?WU5hZ1VtcC9QQzI2S1VEM29UR29FSzRXYlRrdElBektTaDM1M3JwZ25senhi?=
 =?utf-8?B?aFlVRjhRREJiNE5VZEZBMkNkaXgvdC8zSTdEeno1aEl5RkFDM3dTZUxMVlBs?=
 =?utf-8?B?Z3FPT1oreXZEOXpzR21uWndyTFdYMVFCV3g0b0xQOWtKcU9jMDBRcy9kM0VP?=
 =?utf-8?B?NHhQUlRJMjFsYU45N2wzbHNhaCs5aEFuOEIxSmVjSndjYlg2elJHb0JjOFE2?=
 =?utf-8?B?aWhNbHFvdWUyWUVUK0VEdGtrbmpaU0lVRzZ3MCtCV285d0pEbzEzemVrazRz?=
 =?utf-8?B?SC9FM3NtL0lHd2F6U2NQa2k0b0dKeVN1blVxUWJ5RGMyanVyTmVYc1pqeTUx?=
 =?utf-8?B?SGdjSkhDVFM3VlJWbHpEbGJHVnY4ajdrZm5xYnB5eEhZREgvemJQc2VOS3BN?=
 =?utf-8?B?bkhCTVZoNkZjN2t5TlRhbGVhY0MrVjd1ZmtZN24yMUY0dFlERkhRdFhabEV0?=
 =?utf-8?B?VnNRSGEwU3oyNjI4ckNxZXVzZlBVajBVNlRjcHZvdlZUTkpxVFJRNnlsK3Aw?=
 =?utf-8?B?QlY5RlIxRDFTL1F2bk56SDRnaW1ldmovQTFjMDBqZ0lwaEwxK2xjUHpvTFNR?=
 =?utf-8?B?RmZoc3cwVmxuNTNhTEZ0RllFZWI3TlRWZUIxL0pNQmNrY3AvOGtNc2tXT2lv?=
 =?utf-8?B?UHpqbHM1eUhER2l6UzRqUDQ0b1gvOHcxUVdZb1NVUWtsVjNja0E1MXhCMlEz?=
 =?utf-8?B?bnNtamdKckg3Y3BxZ3NseDRUeVhyOXpWTzB5ejJVZmlxYk1SdjZZOVluaEN5?=
 =?utf-8?B?d3FLUmpWOFk3SVg1MStWTkhtUHk5NUpJMVc4Z0t6Z1d3d0xvcWQrL3Z6S2ll?=
 =?utf-8?B?bUFTdUw1cFB4VTJnZXFjeVFaNjNud3VpVUpvUlVrM3JrZHF3Uk5NNlE3MVJh?=
 =?utf-8?B?d0R2a016UHJheUlWZWN1MUU4Y2pVTmN3V2VSMG9sZHhCRXArM0lsWXRiQStE?=
 =?utf-8?B?WjgrYTdPVVgxUHFBck93YXZjL1QzSXZXYUpCTElrc0w2RFVzdzQ4OHpIVmZq?=
 =?utf-8?B?SXZoUkIvanJDcHJZTlhwZ1FVbXhsN2xoRXBJcnJWZUJPV2dLMDZnS1AwMVNs?=
 =?utf-8?B?aUZodE01dkZ5aW54dW9Tdm80ZE93eEkrb3pGWVB5Yk1yMWQ4bnNDUytRdTRH?=
 =?utf-8?Q?on9xi6d1tfS5IY5NnZZbmHw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEkrekxJR3pZbHBjaU91cmJESHR0N3ZPWGdWcG1yeDR3d2RublpndThqdFhx?=
 =?utf-8?B?WjFuV0JWeVZGN1VlMjhRY3JHOGRuVlNWdFhWL2JSMlRTMEtzWDNwT3NRUHIz?=
 =?utf-8?B?emVDaktjMTdtQVB6Q2RNTHFhNUJPczdwc1JOdU9hNmo4YTdnZTlDQm5hbVlI?=
 =?utf-8?B?bFRzeHRSdjdzV0htM3QydGhJYVNjc3JJeWU4WUxzUXNLUHdZOGY0YzJwamhR?=
 =?utf-8?B?V3pFNFh5aWtTWnAvUmNOaUxrdDdHVkdnYTVaK3MrbVZ1dzdtVlJ1a0FiMThN?=
 =?utf-8?B?Y0hhNkNJdjJBaW5sOFpycUFrQnZuVDZiREYxajhpQmdXdzJuWlNNSDl3Z3Vn?=
 =?utf-8?B?MmorV3M0TDJWUFFpK0Y1eVM1YW5RZ0FUZkJ5OHVFT0p4aFdZUktEcThmYUg4?=
 =?utf-8?B?N25RVDlwVE5taktBZGJLNzNCZ0VCM01TTWgrTlNDdStPV2J0U1RFTHRkMmxw?=
 =?utf-8?B?dUpKZDNsM2hqWnZ2Mm1QRXhybmpRZXZSZS81b3dueU93Y1RMTElUZkxlMXFp?=
 =?utf-8?B?TE5HRVk5TUNtRmtoNnc1aXJVTkM0TC8xazJuMmxib29nSHNhVy8rc3VwajEw?=
 =?utf-8?B?aFNUQTdWUmg2bzlldGx1L1pybEtIUHc4NzVGSStHM3NxZEpDRVBWRXhQeXFH?=
 =?utf-8?B?VWhUR21hamNscmV5ZW0xeDhuSGg3Vk9wZTd5QVUxYm9kTU1QTCt1d2M0MUJ4?=
 =?utf-8?B?ZWRldW04NHJoeUNCb2ZmTGZvNjFwRmE3eFEwK0Jici9XS2FiZWtYb3hxcXNH?=
 =?utf-8?B?UDVncHZSS0JVRlExS2VYU25ZcGtHQ25VRnN6V2FMZno3R1FPV2dQRWlJckZN?=
 =?utf-8?B?Rkx6WmVtVEhpaTV1ZGtReU91L0FiZTVxYmRDbXhIU29KWndXYVQwQytUVXJJ?=
 =?utf-8?B?c3VJMHd5aFFXYkZVeTJiYzJYN3NFbnh5U2xzSlVWSTFTd3Vac0JzUWdaSWV0?=
 =?utf-8?B?bmY2N3RoRWVWMDZxa2lQMTNlcGwxYytVOWwxeUxLcDJLakZuRHpJZVFmT2ZJ?=
 =?utf-8?B?eEZiclllZ2Z2aXlMSmNZbERadjZQZG5KbUsvR1JURjlpaTdoUjdFdytIM3R6?=
 =?utf-8?B?bThtdzFCeGlqMy81Y3RhWGFwdzlJcGJDejVMQ0JyNnR1c1NGaWlya0c4dlBl?=
 =?utf-8?B?LzNxS0RqR1BtRmZSbUJqb09jMnBOMCtXTHBxcmFNbGVBYzBSbVdMbG1ab0xP?=
 =?utf-8?B?dVZ4SjBpWjNpUE5TcEFtME1TUmFpL2lYMStKQVRRTDNkOVJKYlVYdDQ0OU1D?=
 =?utf-8?B?TUNZdWlNQXVkZzV3Tm42c3hleWwxMHk5ME1EUVBXVHFPTTRDSk1Dd2xMVWpK?=
 =?utf-8?B?ekl0Y0lqN1kycmhRTVFjaWltYU9vaGlvbzJjZEM0Z1lFUElwNlNReDJrV2Zp?=
 =?utf-8?B?Mm9HZnV4ZitWUTdkMmtySWc3NXpyV0hCQklPUEZMTjJRRWh2TE5xTjA4OS9p?=
 =?utf-8?B?R1hpUmFob3Y2SUJMbjByaVBwQzNxM0kwcDN2SVhYOFFUY0dXZURGYml4OVhM?=
 =?utf-8?B?WEViVXlvNjRJUW15UHB1R2tKd3UxWTkyUHhDRUk2L0tJV1ExeSs3eFhiTXJK?=
 =?utf-8?B?OU4yMzNjK0RNeE8zQzdsUXZpRTBKQTNWZ0M2RG1HeW85UFB6SWhwYWVVZ0c0?=
 =?utf-8?B?cEx1aTAvN0pIS1Z3L013YVN4bEhvTUt1TUs3WjlEVUxuZEJ0aFFvOUp4UGQx?=
 =?utf-8?B?eG5qUXQ0SFEvbU9CMUIwVVJES2JoQ1p5aWxhTkFhcmxwakdZaEtpMkVmdjIv?=
 =?utf-8?B?c2dZTjRCY1Rob0FJM3FXYnFvRVpYQy9KaGNDRFg5SGZLUGdKVjdlTFB4ZVJD?=
 =?utf-8?B?NFpVQlpvNTRQZE81RlNBN2t0NXJURmNLQTFZVllHV2I1cU9SV0RaYTB0L3Yv?=
 =?utf-8?B?aXdjcVI0a2U0K0xXZHZhNTlYSkZackdKOEhUVitYYjhta2FhSGUxTkprbzFk?=
 =?utf-8?B?by9ab3ZnalVpbTdIVDh6SUtacUlSdlhPcUg0dVBoY3N6cHBJTWtwWWE0RU1G?=
 =?utf-8?B?eVZsMVBiNmxiTWFVQ05rbFFVUnVia0tUWDI0SCt5RDdZeWkxQklEOVVINDV0?=
 =?utf-8?B?ajljN213bVVONTJNa3FOZ2lhWWVCczBxSm1qa0J1Q1ZTMm5lMnY4MkM2Ui96?=
 =?utf-8?B?T2xUaFFSTVIrVm1oUms4V1JtangxcVhDeFBrUHBKT1hhNzZnd2VnYjZkeDVl?=
 =?utf-8?B?MlU3Y3FQbEtFR2laNGR0OUZ6OGN6VTJOeTNUTXhEQndPMkhyYXFYZmFHK0xw?=
 =?utf-8?B?emRmOUVxbVRBb0hwZ0hnbTFtb2JNN0lMSWRaNy9ObEZhamd0MjF1QWxIcE9G?=
 =?utf-8?Q?WwQtl7H8Eg0GweXe2X?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/G1hLn6CKPxHfpTjf0llSXOrZmuYJzLVX5iGs+wHIbaXydrqnnC/37LvogHoe7lsIbOWSsgwuvVkEhIAwscPmR7n+PpsFfFUX7VEb30ZOeCijiFr1/wsomDhgwziEMLwu5+9HmEIMqmfmbtgnR5j4/FnDXegXKQsMo+BfD3FGnTh4q3AOWtyEXTdWFkNcMdgYBzh9PevGggGz/sR7EM0x+dAY4rLKCjLoymTCStm5R52ephGvldbg57nKVvM5iYPtCYQPzJUdL+RliMMat3W5gCIhAtRaXGB+sRW7X2RB2RSZ3xR75q14umWVqlnAuMQPyaEtCiszxRbptu6h0bYf3J+TgodjYpitjYzosMj0PPYxdBTc6wtW/sh6VLt4VGGdpyyMNb3MfIv/IP7LhV8b5h9QrIV9M3cJDzWBSJz7GOCz41H7tnTw/HEuXAW4KB0dkrYjDDrKpfB4CBzIShuunYB4u06m8oDlXubDvU7VHjeMFNQ45clPNXdYifaZDktPoFhuzs3YTnX0XuuUS8n2XXAHS5BPA6smMrfUjjsUKBfyWZBT6YI6AQ3zqoRnzAENlHJfS6uXEnIiYRYwVuOoHeZ2ZMLpXWXllicOHH+LXP1BHOUEW8DOjprLIXf9sdx
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95a5b11-3428-4d0b-c3c0-08de552f5e95
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 18:45:07.1566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IKDScA4/4BF2uJ7mvsMIqWhvJHbqIJy2HO/y+19yKao/HYS/O2HfiSbx4TaLRp4wTJhAkWrUiMvk0Y+Ed4yCEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR13MB6120
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEzOCBTYWx0ZWRfX6HGmCtqUeS3y Djrvv2FQbsrR525IdoSNIV5LNVcnxH5t327i90wpzgb2DGunEB3nF8k0tUs2jT1kM/+Uazua74t PAx/j52HnCQN31bcE2/05EvPvUxMSuOTfBgxkWpeH0GXHe5qQRv38uCAjZj2OxJeWiupEK2+xEY
 CSP2GmXumO78VlgnR/aYBhP8iPIkCG3eMckQase6I5qzKtTzWtvSqzhXbYWYaQJXLHeF/EvqWsv bqIZ1DmhgTdMw7555sNdc/zA/2LSMbD3Pv0Y9Fn/1SW6VuN05DsQL/cL42/kbPjX2+oAjk3oljc oO6qMVTQiFpIfrS6Gh6eZbDIJIciYb9Wn+xK5fgEkkIbli5cX3W0OcBCTPl/7dvWaAYpIyNIPG9
 6WsLwayz46QiKnHgaEam+BDt6tSMramhDS05oqCUwK7SfFTmknlWPYUeE16Ai40tu/6/X8RfSVq PFS7Zc6EEYVYkpQYscg==
X-Authority-Analysis: v=2.4 cv=DvBbOW/+ c=1 sm=1 tr=0 ts=696a873a cx=c_pps a=fOo0+MOGfjr111H4QC4BGg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=_EeEMxcBAAAA:8 a=VwQbUJbxAAAA:8 a=z6gsHLkEAAAA:8 a=xUUDyG1Ms3oSyEIXPTEA:9 a=QEXdDO2ut3YA:10 a=-UZi6s5u-ZMA:10
X-Proofpoint-GUID: SdIdLPGamowsVgWNCPKkBGzSbbPX-fYS
X-Proofpoint-ORIG-GUID: SdIdLPGamowsVgWNCPKkBGzSbbPX-fYS
X-Sony-Outbound-GUID: SdIdLPGamowsVgWNCPKkBGzSbbPX-fYS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_07,2026-01-15_02,2025-10-01_01

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3RvcGhlIExlcm95IChD
UyBHUk9VUCkgPGNobGVyb3lAa2VybmVsLm9yZz4NCj4gDQo+IA0KPiBMZSAxNi8wMS8yMDI2IMOg
IDAxOjA0LCBUaW0gQmlyZCBhIMOpY3JpdCA6DQo+ID4gW1ZvdXMgbmUgcmVjZXZleiBwYXMgc291
dmVudCBkZSBjb3VycmllcnMgZGUgdGltLmJpcmRAc29ueS5jb20uIETDqWNvdXZyZXogcG91cnF1
b2kgY2VjaSBlc3QgaW1wb3J0YW50IMOgDQo+IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5k
ZXJJZGVudGlmaWNhdGlvbiBdDQo+ID4NCj4gPiBBZGQgYSBHUEwtMi4wIGxpY2Vuc2UgaWRlbnRp
ZmllciBsaW5lIGZvciB0aGlzIGZpbGUuDQo+ID4NCj4gPiBrbW9kLmMgd2FzIG9yaWdpbmFsbHkg
aW50cm9kdWNlZCBpbiB0aGUga2VybmVsIGluIEZlYnJ1YXJ5DQo+ID4gb2YgMTk5OCBieSBMaW51
cyBUb3J2YWxkcyAtIHdobyB3YXMgZmFtaWxpYXIgd2l0aCBrZXJuZWwNCj4gPiBsaWNlbnNpbmcg
YXQgdGhlIHRpbWUgdGhpcyB3YXMgaW50cm9kdWNlZC4NCj4gDQo+IDE5OTggPw0KWWVzLiAgVGhl
IGZpbGUga2VybmVsL2ttb2QuYyBmaXJzdCBhcHBlYXJlZCBpbiBrZXJuZWwgdmVyc2lvbiAyLjEu
OTAsDQpyZWxlYXNlZCBvbiBNYXJjaCAxOCwgMTk5OC4NCg0KPiANCj4gVGhpcyBmaWxlIGhhcyBD
b3B5cmlnaHQgKEMpIDIwMjMgTHVpcyBDaGFtYmVybGFpbiA8bWNncm9mQGtlcm5lbC5vcmc+DQo+
IGFkZGVkIGJ5IGNvbW1pdCA4NjYwNDg0ZWQxY2YgKCJtb2R1bGU6IGFkZCBkZWJ1Z2dpbmcgYXV0
by1sb2FkIGR1cGxpY2F0ZQ0KPiBtb2R1bGUgc3VwcG9ydCIpDQpUaGF0IGNvcHlyaWdodCBsaW5l
IHdhcyBhZGRlZCBsYXRlci4gDQoNCldoaWxlIExpbnVzIGZpcnN0IGludHJvZHVjZWQgdGhlIGZp
bGUsIHNvbWUgb2YgdGhlIGNvZGUgd2FzIGxpa2VseSBhdXRob3JlZCBieQ0KS2lyayBQZXRlcnNv
biwgd2hvc2UgbmFtZSBpcyBpbiB0aGUgaGVhZGVyIChidXQgd2l0aG91dCBhIGZvcm1hbCBjb3B5
cmlnaHQNCm5vdGljZS4gDQogICAtLSBUaW0NCg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFRpbSBCaXJkIDx0aW0uYmlyZEBzb255LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGtlcm5lbC9tb2R1
bGUva21vZC5jIHwgMSArDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvbW9kdWxlL2ttb2QuYyBiL2tlcm5lbC9tb2R1bGUv
a21vZC5jDQo+ID4gaW5kZXggMjVmMjUzODEyNTEyLi5hMjVkY2NkZjdhYTcgMTAwNjQ0DQo+ID4g
LS0tIGEva2VybmVsL21vZHVsZS9rbW9kLmMNCj4gPiArKysgYi9rZXJuZWwvbW9kdWxlL2ttb2Qu
Yw0KPiA+IEBAIC0xLDMgKzEsNCBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMA0KPiA+ICAgLyoNCj4gPiAgICAqIGttb2QgLSB0aGUga2VybmVsIG1vZHVsZSBsb2Fk
ZXINCj4gPiAgICAqDQo+ID4gLS0NCj4gPiAyLjQzLjANCj4gPg0KPiA+DQoNCg==
