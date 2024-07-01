Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10036145B09
	for <linux-modules@vger.kernel.org>; Mon,  1 Jul 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838386; cv=fail; b=PCulxMsnmMyOqVS4pdQh3PCV8pkJiq5ix1v7NRAc8L3fBXasL7dQFGpScwehM8UF4bFM+Zm1GB87aFD7HVjcQMYwQ3qG7dXpE+BfNM/MaeyI4kSzdVFuNiO1R9kFG2ZreUEuUrGNQvaMlJMpkbQR7IDe1FHDBkVyjsOAdMa0uG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838386; c=relaxed/simple;
	bh=VPbBg07ecQaYAztQOYd/kldyr1w7hq1eOzVPN6SXwZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XV20VUZ9t29kCezVVcZbCXWDTvQ11X7qnBXi5LRRckmieDHoIP/urZc7nOaSgRcDTGd5sRAjiKaLJaXE1WxKFWEhnNlhW7hQwrThvqvJ8EzZux+2j1tsdn8c1V5HSsV4+QtrGPp950J95azd0o0XSSS7hvBeGhRuZa24PLMOD08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=HesAJGEf; arc=fail smtp.client-ip=173.37.86.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="HesAJGEf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=7419; q=dns/txt; s=iport;
  t=1719838384; x=1721047984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EmHcBNoHAJ1cmn1POTwhYKEmvh03fxWBiIoY79agFbw=;
  b=HesAJGEfcv0NEHuaPv3RgvXKO+6OkrvEC4O/B1Z1Tk7zV4efVgW76T3O
   MbJIJ6ryV48lZa5s9t0PUGHPSQH0ZK5PfefR+rgBNG0QUCTtvJfk8XXeM
   th4apdeOacraZC3mrWCk4Rjty1vzataIOrItTIt5j+OnELK5wb/CufK2f
   A=;
X-CSE-ConnectionGUID: xEMUwHTYSC2J+ejTsnCcBQ==
X-CSE-MsgGUID: UfZ/g2QaSw2VBMm+BeNk8Q==
X-IPAS-Result: =?us-ascii?q?A0ABAACbpYJmmJxdJa1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQCWBFgUBAQEBCwGBcVJ6gR5IiCEDhE5fiG4DkUSMSYElA1YPA?=
 =?us-ascii?q?QEBDQEBRAQBAYISgnQCiQ0CJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEFAQEFA?=
 =?us-ascii?q?QEBAgEHBRQBAQEBAQEBAR4ZBQ4QJ4YBhl0BAQEBAgESKD8FCwIBCA4DBAEBA?=
 =?us-ascii?q?R4QMR0IAgQOBQgagl6CQiMDAaA8AYFAAoooeIE0gQGCGAXeABiBMAGIMAGKP?=
 =?us-ascii?q?Ccbgg2BV3mBNzg+hEMChBOCLwSBEYlCg2iEXoFEEoEKLxeDBA4rgWoFC4NLg?=
 =?us-ascii?q?hmBSII9Jgs9hC8wh35UexwDWSECEQFVExcLPh0CFgMbFAQwDwkLJikGOQISD?=
 =?us-ascii?q?AYGBlk0CQQjAwgEA0IDIHERAwQaBAsHd4FxgTQEE0eBN4lsDIMtKYFJJ4EMg?=
 =?us-ascii?q?w1LbIQDgWsMYYhngQ+BPoFiAYNKS4R4HUADC209NRQbBQSBNQWtBQc9GzYBG?=
 =?us-ascii?q?xUqKyFSDSoEBQEFDA0RDZJfOIMPrg+BPQoog2uUZ40AF6o5mGejPA8NhQkCB?=
 =?us-ascii?q?AIEBQIPAQEGgWc6SIETcBU7gmdSGQ+OOs17eDsCBwsBAQMJhkiEIgEB?=
IronPort-PHdr: A9a23:uMuPRBUbNNFNlIdzi+Mr1hBxgLzV8K02AWYlg6HPw5pUeailupP6M
 1OavrNmjUTCWsPQ7PcXw+bVsqW1QWUb+t7Bq3ENdpVQSgUIwdsbhQ0uAcOJSAX7IffmYjZ8H
 ZFqX15+9Hb9Ok9QS47lf1OHmnSp9nYJHwnncw98J+D7AInX2tq81+2o/ZrOSw5JnzG6J7h1K
 Ub+oQDYrMJDmYJ5Me5x0k7Tr3lFcPgeyWJzcFSUmRu9rsvl9594+CMWsPUkn/M=
IronPort-Data: A9a23:kIXPRK8COguBQQpFrVIZDrUDnn6TJUtcMsCJ2f8bNWPcYEJGY0x3n
 GdOCjuGa/nZYzejf4ojOd6+oUoB75PRz9NlSwQ/pC5EQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEzmB4E7rauW8xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4ujyyHjEAX9gWIsbTpNs/vrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2kmEKgl5cZLMFplr
 95bJTIxdRaojMiPlefTpulE3qzPLeHxN48Z/3pn1zycULAtQIvIROPB4towMDUY358VW62BI
 ZtCL2MyMnwsYDUXUrsTIIw1nOqygH7iWzZZs1mS46Ew5gA/ySQriuW9bIOEIofiqcN9o0iq4
 W2cxm3CHUskHvmaihCI1HH8v7qa9c/8cNlPTOLjrKECbEeo7mgSDgAGEF68reS9h1WWRd1SM
 QoX9zAooKx081akJuQRRDWiq3KC+xUbQdcVTqsx6RqGzezf5APx6nU4oiBpePEDidAWeQ0R/
 QWr3N7rOSdpm7a/cCfInluLlg+aNS8QJG4EQCYLSwoZ/tXuyL3faDqRFL6P94br17XI9SHM/
 tyckMQpa1wuYSMjza63+xXMhCih48WPRQ8u7QKRVWWghu+YWGJHT9L1gbQ4xa8cRGp8crVnl
 CNe8yR5xLtSZaxhbATXHI0w8EiBvp5pygH0j191BIUG/D+w4XOldo04yGghfRY3apxYKGS5P
 BW7VeZtCHl7YSXCgUhfPt3ZNijW5fmI+SnND6qNN4EfOPCdiifZrHo1DaJv44wduBNxyf5kY
 8jznTeEBncBAqMv1yutW+oYyvcqwCt4rV4/trilpylLJYG2PSbPIZ9caQPmRrlgsMus/l6Pm
 /4BbJTi9vmqeLCkCsUh2dRNfQliwLlSLc2elvG7gcbefFE/QzF5UaS5LHFIU9UNopm5X9zgp
 xmVckRZ01H4w3bALG23hrpLMdsDgb4XQaoHABER
IronPort-HdrOrdr: A9a23:2w8rMaskKVQLbWWmgfWo72FQ7skCCoAji2hC6mlwRA09TyXGrb
 HMoB1L73/JYWgqOU3IwerwRpVoIUmxyXZ0ibNhW4tKLzOWyVdAS7sSrLcKogeQVREWmdQtr5
 uIH5IObOEYSGIK8voSgzPIU+rIouP3jZxA7N22pxwCPGMaDp2IrT0JdjpzeXcGPTWucKBJb6
 Z0kfA33wZIF05nCfhTL0N1LNTrlpngrr6jSxgAABIs9QmJih2VyJOSKXKl9yZbeQlihZM5/0
 b4syGR3MieWveApSP05iv21dB7idHhwtxMCIinkc4OMAjhjQ6uecBIR6CClCpdmpDs1H8a1P
 335zswNcV67H3cOkuvpwH25gXm2DEyr1f/1F6jh2f5q8CRfkN+NyMBv/McTvLq0TtngDhO6t
 MT44tfjesOMfr0plW72zEPbWAwqqP7mwt5rQdZtQ0ubWJXUs4ikWVYxjIXLH/FdxiKtLzO14
 JVfZzhDPo6SyLuU1nJ+mZo29CiRXI1A1OPRVUDoNWc13xMkGl+1FZw/r1Top4szuN3d3B/3Z
 WPDo140LVVCsMGZ6N0A+kMBcOxF2zWWBrJdGafO07uGq0LM2/E78ef2sR72Mi6PJgTiJcikp
 XIV11V8WY0ZkL1EMWLmJlG6ArETmmxVSnkjste+596sLvhQ6eDC1zOdHk+18+75/kPCMzSXP
 i+fJpQHv/4NGPrXZ1E2gXvMqMiYUX2kPdl8+rTd2j+1P4jcLeawtAzWMyjU4bQLQ==
X-Talos-CUID: 9a23:5KLF0G4NDXzBRlFmvdss5GMxJ98FTkzm5y3yYEK6NX1vY7a/cArF
X-Talos-MUID: 9a23:0S02WghHXpwiQDNfy5C4R8MpCclapKv0MUk2js84keyBdgZ9HTTNtWHi
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 12:51:55 +0000
Received: from rcdn-opgw-3.cisco.com (rcdn-opgw-3.cisco.com [72.163.7.164])
	by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 461CpsUC007143
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-modules@vger.kernel.org>; Mon, 1 Jul 2024 12:51:55 GMT
X-CSE-ConnectionGUID: LJO9cCmhR56FPTXpErkhHA==
X-CSE-MsgGUID: Dh8t9opMQPe6fkKm2u4GNw==
Authentication-Results: rcdn-opgw-3.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=vchernou@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.09,176,1716249600"; 
   d="scan'208";a="21884993"
Received: from mail-mw2nam04lp2170.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.170])
  by rcdn-opgw-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 12:51:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWhnCDlfNx+ATc7+h/6MmdDRz+aC+ND/UUB5NFMiy0nyesqawseUE1qGZyh35MmGupi/P+rvMf8Hb0xJlG/Iuiqw9Wos5hFzQrumwWYAIamg5DBETmCqlWDZ1CTvYGbe+abP0VsOB1ysAkcaiLqOqCdhsafzIg4/dq5h7eGYOMGaV/Og1GS4JCUSRljJirl9dynmbV1hVOdNkndkG5pPRu9F2EWvhHcezm77PieOycKXd43oODxcNeByv3hKXKmpd+M8EyRDO/15eeZq6my/B3k/aTr5rwAX+8oG23Pe7y3yoNWZ+ERgPiI0aEk/FFE2M6Udd++L/ZAvtVpfsjGJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmHcBNoHAJ1cmn1POTwhYKEmvh03fxWBiIoY79agFbw=;
 b=S1TWLc+Tp6/n23lgUczyI5nbpYPvihUCyzvskr0AGpQZfWm+r7GHDoHcQIHkpKpsQoNEw7NdQiP40tDUIJaTMmrXhO+RhuDRGaoiaIS2aU5Bq8+hhe3MebMSlq4DLbVwlcxeyOSTsTZPZ29/oXXi6n/zi4H6DU53z+JGkYuZquM0/LdKeV3ZjHvvhrRvV8n7lNG/58QOzZxOGjJHldYGwJnrWFA6AjKeIb9PZR5KfmvrL0MLJslJIM50SP6b5kYPMTZ6QO5PLmY5HO/LLUkSf7xdtYZ99JxtOacS8PANNm5uPz+A0XyDjdzFseSuc7rbYCCFcWWCOtk8L3zyCqNjmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) by
 SA1PR11MB8475.namprd11.prod.outlook.com (2603:10b6:806:3a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 12:51:50 +0000
Received: from DS0PR11MB7765.namprd11.prod.outlook.com
 ([fe80::9840:ad29:c571:9c68]) by DS0PR11MB7765.namprd11.prod.outlook.com
 ([fe80::9840:ad29:c571:9c68%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 12:51:50 +0000
From: "Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)"
	<vchernou@cisco.com>
To: Nicolas Schier <n.schier@avm.de>
CC: Lucas De Marchi <lucas.demarchi@intel.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        Lucas De
 Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [MODALTS v0.1 4/4] add modules deps alternatives description
Thread-Topic: [MODALTS v0.1 4/4] add modules deps alternatives description
Thread-Index: AQHaosw6qlfEDe8qx06xqsYjBzFaELHeBg2AgAPSJB+AADdQgIAADm5I
Date: Mon, 1 Jul 2024 12:51:50 +0000
Message-ID:
 <DS0PR11MB77651EE7F968FA7D2E0FAB0EDED32@DS0PR11MB7765.namprd11.prod.outlook.com>
References: <20240510112128.2417494-4-vchernou@cisco.com>
 <z6dffospgjlmczpc3ydj34t7rf37dq7f5vjjd4e6txpw2hmoex@6s26au6y4puj>
 <DS0PR11MB7765763AE24FC792CB3F72BFDED32@DS0PR11MB7765.namprd11.prod.outlook.com>
 <20240701-grinning-sapphire-labrador-eaa91e@buildd>
In-Reply-To: <20240701-grinning-sapphire-labrador-eaa91e@buildd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7765:EE_|SA1PR11MB8475:EE_
x-ms-office365-filtering-correlation-id: ce2a00a6-e98a-4229-d5c9-08dc99cc9364
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?n+hPyYUxV3gh8Otp172BsIXx6n1BbRiA8neq0/Ia+BHxlmy3umuaqljgja3Y?=
 =?us-ascii?Q?aVX1iQwTy2QIzXXMFGowI5K1yxVZn/SYEvcVY4tgr2ba/n/I6go2ddo1AMkt?=
 =?us-ascii?Q?SrBaHWD5L1wYupqzAMA3fvhM9DWA2KRhjXSMWI/Sv71kQ2Oq+rOwowIP3whi?=
 =?us-ascii?Q?k13j0QxkMeHmPE/YU3tBrfP+gAygj1Wy9Vx8uozqyrsjsheZqNPuz5fJyAKy?=
 =?us-ascii?Q?HxgPh91IsyOoZnL+QQb0sqZYYZYFzWqfW+cJkMfEW0J0G3x3wB72O6rg8aDZ?=
 =?us-ascii?Q?W6kzId6mag8iUkgFshzHPv/YfOxrNwTkp93uUlqlJjDuj6WPa5XYWGAf25nc?=
 =?us-ascii?Q?/wXJmjHnpCSk3tCAQk3qq+LDs0s/h/wGHlRgfMx3sMNji07I23erhLoYdEGb?=
 =?us-ascii?Q?hsGrk5h62PJRmaUKtBUmHdVRQO2wkPtYn6EzCOw/hie11tFcnTur3aFOj8k+?=
 =?us-ascii?Q?ek81voMVcVrpRq2vZJvqRaWuFYv/AwPvjEcPsRgRdGErAvIp2tWTJgwjqxpq?=
 =?us-ascii?Q?lfHkE8OFhe1L5AMh7uW1Y89NTAqOMLZivOcMd6J0P3Kfu3VONrVKuQyPWM0v?=
 =?us-ascii?Q?fBvmAQIIv9i4aAsG6COo8pXbQE8LnSmWgrgMKVit0+rjGrs/kmxFkgItzprR?=
 =?us-ascii?Q?DXnq/zAuJo/DDRC+Zjl3brTzvX7DF4DTTPOVzZUAdluuZkxpl4ULRQgw5OtV?=
 =?us-ascii?Q?V3fUtEgybp5ADffFpFFg7dlyRJxOhEO/InGj5+BtaHjyLZvbeOYImFOR9/rQ?=
 =?us-ascii?Q?6SWDBjwUMC+ffKcbwbqNl0HeXmP8k+PiyarsGB/CvO6HchoLfzzOuo2LZFRQ?=
 =?us-ascii?Q?O8wXeByiEH4Xaofk/QIHpIq+i3RolrnUNEpBOTbxhwzPACA9mSIzACIg4c3r?=
 =?us-ascii?Q?CyYm/TmTHFx5ScSJXjhMWg8KG49TtZXrzHkb7mk1WHCp7juJdaz/cMuG4vWW?=
 =?us-ascii?Q?4c19NCABFmfTLKASEBkZ7VJCnQuxdQZofLk40haobdZdrcTaPtkxPIvqirOb?=
 =?us-ascii?Q?3HZ0Q+VY4852SuQfCyoHzb0zJ+/UqZecbKDviCwfVNlUDYBNKCV9XssT/gDL?=
 =?us-ascii?Q?Rr63/k+2Ki8G6Ge9ywrcDUNS11NtQeAy2vEs6WWR0m9xJ7ale6WTQV9xl8Dk?=
 =?us-ascii?Q?WVptR31UKXPEblXFQ6mfXJGn15EwF6THkGRGNJOaMqaDO6m4LflpsqN2M/vO?=
 =?us-ascii?Q?/mpywYbmes7LN6EBepv0f/+nniwS+S7d8X6bOc09RdZOj+KTnCnScMM6jTAq?=
 =?us-ascii?Q?xka8hw6Vff23bN1+uvguzgGjwzbeX9bfWthSLA0Juta+rwrc+Of4rNM8T7C4?=
 =?us-ascii?Q?VjR5UI1sR9ooNwW/Ct8XAVi7gZ5PW7N/Je81MrnNjuABeCKwIHeMfzzX2Y53?=
 =?us-ascii?Q?yK465FiAiFEDfyeL/SUDegce6ceEvARAU3YpUj2dwof3v86vWQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7765.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gbqHJ3GWOg7iI8sWVh2mxNSe12VLmwIx3iFjMumFF//8c31XVgep0YWxg+KY?=
 =?us-ascii?Q?mrF5NFU3bQCgTGbnnfbSLpTmp2n6N42IvmBiOz5CW0MNY1eUAbwYYXnZcE3K?=
 =?us-ascii?Q?Y1WVV+Qe1XpBAltI8gLu3oYq1krhKiRlqyyPnsG9HAGq/9G6XTcpzO7FSE+v?=
 =?us-ascii?Q?OeDSgYnMtddhAFalPJMo3NwV3DYuNO+IAsvM+m2wDkkHXpyR8O6PTjurSn2f?=
 =?us-ascii?Q?iVjpW24gbp4soiBaivakxcN9OYs3r04A63Ab9sZIJEwG5fK9Aoo+qpGRgTre?=
 =?us-ascii?Q?VRn5RNwQdy3f03XRxBjG4WwCrbnp2uSwne280QgSXihoYshjk3pEof0Dy+DD?=
 =?us-ascii?Q?1UGv+Bb7H8oqX26r9jGyhSdn1y+6z7K5RUTLJGZ5WPwVGCbaSNZJBs57F/jF?=
 =?us-ascii?Q?CWLBMu+iFiV0K8vsb5gqMsJosEdcJbeCaH+knm7tDHH9rRZd6ZJUHYtLI+kX?=
 =?us-ascii?Q?w6R0z7lrp2D0W/qBwTv3SXvGbuZ4iHOxBlageM35vW0mjWJZRTNozs+uiEB9?=
 =?us-ascii?Q?Q58ipvKbf7/GctvuDsYWdvgTrO84ZW9P9ONHjuObZmsLh72Z82BGoprAkVZm?=
 =?us-ascii?Q?L1sLF1HWPX+s02XJp8muHz3iz5xKRdI4pJM88KeQsxLEHajDzC71yCGe6aWg?=
 =?us-ascii?Q?HXcErZEKVNvtjYkiSAp2BAv35PVw2Ph5EO9Bxs9Vsu2lC92aoUmIo69PUHZd?=
 =?us-ascii?Q?6VgXU8BhS1oYyvNqD7DMqQtRkzxglBpJlG550ihZZWPSEHLxxqYuuiBplcFS?=
 =?us-ascii?Q?oUqukyvByX13vO7hPTYTEaWtr8mZJXy2AjE0mOZDGj+wpTctueCtxPmyS6xe?=
 =?us-ascii?Q?W/ENaDHJ7KPGlKjMOt2y9ZJJgQSdVQ8DmDo7ZPIZS5ljMTyYYLOUBr+lm635?=
 =?us-ascii?Q?xvuo1RhweUXpq2KWFYDcMQ0Hi1+nFenQkrlWTaGWXv+zNyt9t2R1uo2VQU3G?=
 =?us-ascii?Q?eTcoRNnzeEoTpxgYdOREblx0cBB364Ayul0LFmUA4P+POX+i06gX8kCIjAey?=
 =?us-ascii?Q?u/tVYcLoo9Tm1zjvGm7RWKFU5a8Uuc+8LBJfqhAiA4tHwabapTBaxzd39Yf3?=
 =?us-ascii?Q?QZq7ioiA+vwLAK14ZHQCyQhZimaN8uqbpzCIq61+eQC7oVOmtGoXi2qXW0Fx?=
 =?us-ascii?Q?3BS4yRznn7YuwaeRZzq71DSxDw3Ye3qXm/uiumMuSMD3ApiS4LCN6Fcw/aq7?=
 =?us-ascii?Q?UaX9t4TkuTPMzVmv/N3lqz6mo4QhMXKhBzX2HL0CaZsI7W4N+HFu2o7fx+Sv?=
 =?us-ascii?Q?8f2xN/hzxfKTE17BQcq58ZKa42MSKJNN3H4Ha9wc1jwcjOrW8seKaldBwcp5?=
 =?us-ascii?Q?+LSxEPHP/JPF+TvzKiWwRCnVFK2YxK4ddQ9HPLVCo9rp35llLHU1mMlAkuUU?=
 =?us-ascii?Q?ohXu6tpqa75e93pu9s7tPFAcC0wBsPjceXwN/kpRd1YqRxOEFqitlWKjGuVE?=
 =?us-ascii?Q?nh2aegNEaMRo6q5aaRGewnpCRbGrcMBpJNsJ9mklthocP3QrHK1GMZiRkbLr?=
 =?us-ascii?Q?sK/bB7b/+wKTM54YMjSL2knL5P7wIsDVWvBWpf8k6D/N3/bfr0yT/eTXtbRY?=
 =?us-ascii?Q?sy14hmlKeKOfxDXnyMqNq918KS065D5+SQElqNO+0smOwtu3vDJ31AIjPQXq?=
 =?us-ascii?Q?qw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2a00a6-e98a-4229-d5c9-08dc99cc9364
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 12:51:50.4725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ph3XJVIXxX2zqUdDQNUFHgGUkMg4RK4vopYT+c0eVkdSADEbJtuPjIjteC4TKOZE5h7xRP3+TfVK/+i+exYNhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8475
X-Outbound-SMTP-Client: 72.163.7.164, rcdn-opgw-3.cisco.com
X-Outbound-Node: rcdn-core-5.cisco.com

Hi Nicolas,

> It sounds to me, as if you would like to auto-generate modprobe.d/ files
> for your platforms at boot time and implement the pre-loading of some
> modules before some others with common modprobe.d syntax (e.g.
> 'install', cp. modprobe.d(5)).  But you probably evaluated that before
> implementing your patches?

Some kind but not exactly. I try to provide method to avoid regenerating
modules deps db during runtime

> If your module load order is just platform dependent, I do not yet
> understand, why (possibly boot-time dynamic) depmod.d configuration is
> not sufficiently flexible enough.  I probably have missing some
> important point.

Device filesystem mounted as readonly to reduce security riscs so using
depmod during boot time is restricted

> I strongly support Lucas' request for a cover-letter.
Probably, it will be a good idea to prepare test repo with couple of simple
modules to demonstrate what patchset do

> Kind regards,
> Nicolas

Thank you Nicolas for review :)
Best regards,
Valerii

________________________________________
From: Nicolas Schier <n.schier@avm.de>
Sent: Monday, July 1, 2024 1:33 PM
To: Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)
Cc: Lucas De Marchi; linux-modules@vger.kernel.org; xe-linux-external(maile=
r list); Lucas De Marchi
Subject: Re: [MODALTS v0.1 4/4] add modules deps alternatives description

On Mon, Jul 01, 2024 at 09:23:03AM +0000, Valerii Chernous wrote:
> >On Fri, May 10, 2024 at 04:21:28AM GMT, Valerii Chernous wrote:
> >>Cc: xe-linux-external@cisco.com
> >>Cc: Valerii Chernous <vchernou@cisco.com>
> >>Signed-off-by: Valerii Chernous <vchernou@cisco.com>
> >>---
> >> README.deps.alternatives.txt | 40 ++++++++++++++++++++++++++++++++++++
> >> 1 file changed, 40 insertions(+)
> >> create mode 100644 README.deps.alternatives.txt
> >>
> >>diff --git a/README.deps.alternatives.txt b/README.deps.alternatives.tx=
t
> >>new file mode 100644
> >>index 0000000..9ad3ce5
> >>--- /dev/null
> >>+++ b/README.deps.alternatives.txt
> >>@@ -0,0 +1,40 @@
> >>+Modules alternatives feature allow to calculate dependency alternative=
s
> >>+during build time and aviod to regenerate modules db into runtime
> >>+
> >>+To enable deps alternatives calculation use "-D" flag with depmod,
> >>+it will create indexes modules.alternatives and modules.alternatives.b=
in
> >>+This indexes will be used by modprobe in runtime
> >>+By default modprobe will load first(primary/major) dependency from lis=
t
> >>+If it required to load alternative module, it should be done manually =
before
> >>+loading main modules set.
> >>+For example systemd service that detect platform type can load require=
d platform
> >>+modules and after it run main device initialization
> >>+In case when alternative module loaded, modprobe detect this and skip =
to load primary
> >>+dependency
> >>+
> >>+modules deps alternatives generation basic algorithm description
> >>+1. Load modules information(imported/exported symbols)
> >>+2. Find depended symbol alternatives(create list available symbols
> >>+   alternatives instead of storing last one)
> >>+3. Choise primary/major alternative per depended symbol correspond to
> >>+   build time dependency(build time deps getting from module info sect=
ion)
> >>+4. Create a list of dependency modules alternatives correspond to next=
 rule:
> >>+4.1 All modules alternatives for module dependency should provide all =
symbols
> >>+5 Store modules alternatives index(modules.alternatives) as key:value =
where
> >>+key is a pair depended#_#primary_depency,
> >>+value is list of all modules that provide all symbols from primary_dep=
ency
> >>+for depended module
> >>+
> >>+Note:
> >>+Current implementation/algorithm doesn't cover variant where requred s=
ymbols
> >>+from primary deps provided by more that one modules. Exporting all sym=
bols in
> >>+alternative depency that used by depended module from primary_depency =
is
> >>+mandatory!
> >>+
> >>+Note:
> >>+modules.dep index different for standard/basic and modules alternative=
s algorithms
> >>+modules.dep for modules alternatives algorithm contain only direct dep=
endencies and
> >>+full dependency list will be calculated into runtime correspond to pre=
ferred alternative.
> >>+modules.dep for standard/basic algorithm contain full dependency list =
for module and
> >>+can't be changed during runtime without rebuild database via depmod
>
>
> >well... this kind of explains the what, but still no clue on why.
> >If multiple different modules are providing the same symbol, then they
> >are doing things wrong.
>
> >If there are multiple variants of the same module (again, is this about
> >external modules?), then I see no advantage to delay the decisions from
> >depmod-time to modprobe-time. Just setup your depmod.d configuration.
>
> >Also end users have not visibility on a README.deps.alternatives.txt
> >file. Documentation in kmod is kept on man pages.
>
>
> >Lucas De Marchi
>
> First at all, thank you for review, Lucas.
> Let me try to explain feature more:
> 1. You are correct, feature tested on external modules
>
> 2.
> >If multiple different modules are providing the same symbol, then they
> >are doing things wrong.
>
> Modules exported the same api(the same functions) and on my opinion it's =
ok
> and kernel process normally different modules with the same exports. One =
major
> restriction is only one module with the same symbols can be loaded on the=
 same
> time but it's ok in my case(as I described, in my case, it's per platform
> modules and devices with different hardware using the same software image=
).
>
> 3.
> >If there are multiple variants of the same module (again, is this about
> >external modules?), then I see no advantage to delay the decisions from
> >depmod-time to modprobe-time. Just setup your depmod.d configuration.
>
> It can be different variant of the same module but maybe not. For example=
 it
> can be cryptography modules. Modules provide the same api but implementat=
ion
> of api is totally different and depend on specific hardware. With modules
> alternatives feature it's easy to use this kind of modules. You can use
> required alternative for specific hardware and all depended modules can u=
se
> external functions directly without any wrappers or "if" statements to re=
solve
> dependencies.
> With using depmod.d configuration it's possible to choose primary alterna=
tive
> into build time but in my case required alternative is unknown during bui=
ld time,
> it will be known only into runtime. In this case it required to regenerat=
e
> modules db into runtime and I try to avoid this.

It sounds to me, as if you would like to auto-generate modprobe.d/ files
for your platforms at boot time and implement the pre-loading of some
modules before some others with common modprobe.d syntax (e.g.
'install', cp. modprobe.d(5)).  But you probably evaluated that before
implementing your patches?

If your module load order is just platform dependent, I do not yet
understand, why (possibly boot-time dynamic) depmod.d configuration is
not sufficiently flexible enough.  I probably have missing some
important point.

I strongly support Lucas' request for a cover-letter.

Kind regards,
Nicolas
