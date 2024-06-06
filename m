Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2050.outbound.protection.outlook.com [40.92.103.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D77D19D898;
	Thu,  6 Jun 2024 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717656605; cv=fail; b=twniLYYVIT+dIsCjeuCQRnW0W3rNx62zSBnvZAUs+/ooqc2PXLZdTdVH0DpbniFkn695iXjDdg4odJvlh5oe3REQVzKmpFq0WviS3uITH+9cwNyZEn/K2xCufAY0PTtNeXBE3A/s+EzcJ9vvZcQntXQuzU2zZMi+w5wEQUbe878=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717656605; c=relaxed/simple;
	bh=TK9N1wGIK9y06GWgxpI+U6X2BdhbB1j+YXsXrtirBE0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ykqd4Fo89HCUp/10dtwWvLHS0FJnr7JYlG7FlYUS0za6QUOZTSzB2FtYBEZctSujX0iPNUlypu9+clc8cts5CpwHU9aSpHzxAX4bIVRgbjRfQ+yDxXUdTbNE1zgvZIDO9XpcaqmvzB4FibzErIA/f0rcSz/LrJzwjDCFTqGrp7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=dYYm//49; arc=fail smtp.client-ip=40.92.103.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="dYYm//49"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOuGL2dXzbG6QPQmZBdMpx95ldrktwBodB2e6styVqagbW0giEjaeH7IcwyNUsZiASM/fyER8y0PQ86bQZaP0Had3norAB/yhKfSj6EaAq97nHngSTQpoND9RvcXspvUTkaP7rN03cP8FHoxumvLxZNz/dV69JJr8HRhpj8G4lWpCCpJrmg3LOzdGYC6lDIz0UIpjF9kDEhk065PAZuvTUdVm1ka3jZi42pfZK9tLYGecjTF8Tt+9x5GFoHXNPhTPNtReuvMJzXjB5L/5oQAzX2HXBgyHvQMUcs2XGC378icIxAd2SJjIP6rxXgsldDf9cq5Z9g9PUylmb2aFF53Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TK9N1wGIK9y06GWgxpI+U6X2BdhbB1j+YXsXrtirBE0=;
 b=c795yPkvljPd54mgP4IlJzUocR2nn1BLk8lLyui5gOicF7DPIFW8HG26WmQSt/tVUSkHRzC06vOxu2Etbae2SxKKzwpHkcCE0zSVy49u0KughjRI9touMmpui5+FbpJAglkhkvTsSwu4bzQMpm9ZrbW5ExYktCYFAvL1mANkFysrOzggkA4F8cIwN42XJqWBDdi8IGN+ML96xiRjV2K3C90KaeibOeBHGALmVhZIcEqGMETqdbh9k8PBtAMx4msQPsaC2HTZKLTCiKU4CF0Cg/WYmqi5e2aJlNbGb9HDXGPl2DY1qFnbYJnjmathY15D2Uds4o8/Ba4gy6QjeKamOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TK9N1wGIK9y06GWgxpI+U6X2BdhbB1j+YXsXrtirBE0=;
 b=dYYm//49xL5DCP55TUIYVMWnsYeJZiWOuELNLsHcc3VzJORFAncCmKN2BBxEwbXqadhb6SBmMu8Ytwgs40uPALQcxKKQakc5KbMm/+Ar5X4qAMUG8ppa6OclvWw6nJ1uZPcNEbeiX07ihJXV2Cp1btMg+5d9WSJ3EEblpO5cChNf5S6POmAzOkUVpaVt95VPNIhWKwMd+oZq430OrpwSkmHTRVJi1gcF7ubhaNPmJ33NhW5ouH/oxiTqt0GJEBgL+srCLUn72WDg6lhrold3xXKPsFkfI5C6euzG0g4eKtgGV2YuMOIIV4OLoqQPQ1nd7eLlmHun7Yv+ILvAHvDAAQ==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 MA0P287MB2125.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:103::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.31; Thu, 6 Jun 2024 06:49:59 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%7]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 06:49:59 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "mcgrof@kernel.org" <mcgrof@kernel.org>, "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Current status and possible improvements in
 CONFIG_MODULE_FORCE_UNLOAD
Thread-Topic: Current status and possible improvements in
 CONFIG_MODULE_FORCE_UNLOAD
Thread-Index: AQHat92/O7UUpgMSCkmL1ayN4UTeWA==
Date: Thu, 6 Jun 2024 06:49:59 +0000
Message-ID:
 <MA0P287MB021781F0CCD7C62CAC608714B8FA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [8gupDJrd7krmrdAGLWuAsbSXa9ZAxkkI]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|MA0P287MB2125:EE_
x-ms-office365-filtering-correlation-id: 3b945e12-dac1-485d-f2e4-08dc85f4e23b
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|3412199016|440099019|102099023;
x-microsoft-antispam-message-info:
 JR/UXFcvHVN9yfTDoxuUJqzsS+jLU/fZ4m+qIBIjmVPfQoHH9ayt3HaZB8jhNsdXF+O2nSnb5iNb08+BUx7n/1AQ47o+T27mReP/zP/bTvhrd0L5TTFWHIw0RjHaNniKQ2fyDSfBQ8kJiGVeoJp17P3l21YH6hNKp5a/dciLwaq4/x1d+H4OxT0H5XLi7uxqZl2p2u3oQi4pmlfH3jyw1Pp0EpVqn76/OYcvbrjz2tzQKOF8UvFm65OEk2SMME0PHYXvRx8CPUlQ+b5eDcJhL6kAEnSM/4Ko0Ny/kZnYG3x5D/wzjkhwirdrBaJIguO3D8AOIItxvxVWYi0UGZ8hYVhBiRP50QqmM5jn6EmiA+IPHjmLNHT1RMsdk6usLx43QUUciUkeX/IAJlObYlCdjHSkRTHGFFg0ciPMotA5ke5oZU1fgpPtnhnlShGIaqmRd7HWYvgADvOk+VHBr65A4D71skmXO6jArfFfUT3eGugI7GCaPUWllXZck+WUKmoydaQRZlHE74ldsti5lu2drr2E4KULdQWTZm7kW3MdvcyuqoRAF2aLtkAwUpfAYNvY
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mb0qsrCq2+2fGq047rPHIX8ahqxyRv4fDjuzXW88j7McxbxWANrhzD5lK6qA?=
 =?us-ascii?Q?wX7hK7V68QDK7Vm3Ygl4l4BV1YhUF8Rnb5azYeWwuIKQKht1kXK7EUFJ1goi?=
 =?us-ascii?Q?Mm+ueqEPXkz0nxrcHqH72yY3I6bfSvIqLltsX5thTQsxHrc+tiXqZAgKiXQk?=
 =?us-ascii?Q?JfPutZSrwXeujZXc5X8w54jpL7wX7AizYtk29gPnkNv0sWzFRxfTLYcGAWJA?=
 =?us-ascii?Q?KlRsPsf0ZSMfefbR1OYCp6EvV/waqhL+tooNpekVwNlO3cs7YAF3hb/otL4f?=
 =?us-ascii?Q?7pDCAv/aiZ34atgt37KnI5vqy55B0swrm3yVe1ApqVnKrey+4sElPpwDKd+T?=
 =?us-ascii?Q?antoL8s8dv06tdxitupRP1B9J/MhTn66pJg7t35flrgnn2HXsZME7M3GIp3R?=
 =?us-ascii?Q?q9oTDQCxy/f5UKyBqnWdYPGbC/pybVyPf+zE8j9ygrKEGN65uJh7c70E3xN/?=
 =?us-ascii?Q?2K8yPqYNzlXUmcETCedvHpzA6d7xNx+jmbcSCTtAWEQKLvznCIu2+EGQU8uO?=
 =?us-ascii?Q?BKGKZmYndvhYylYv2dObJ82C5Y+HSEYdfsleT3ZNNA+/Cx8mI7t4KHzmAZX9?=
 =?us-ascii?Q?XX4qQeuWraDL5APUfO2LYnfwOgi4CARYjLaG2O+7zuTjlcYRMcFLEaSq//Sq?=
 =?us-ascii?Q?4YUT3E1rmIOPkei3xnEOZ0o8yPWUXfX2Kd214njiYvN1WPBAiqq1sH7beWUA?=
 =?us-ascii?Q?Phrm24yHOfgL0DfVpMs4R1YeqQDDtVzSC/G9OykAwADeDKhTHlyLNivgRcdi?=
 =?us-ascii?Q?en0lUQ5DuFc8sqvEdMH2WG54WW9NeyzmDhiZYosNT+Xcr/9eHoClqRHAqxU5?=
 =?us-ascii?Q?M9/fWv7PyTFf+HXA4rWyvFFVh1SqtEDNwEsSLoecVt6ajDH7pBAtW8AUyraj?=
 =?us-ascii?Q?+6ry/Vk5uexqys2NL8Hky57556/Ny6pFIXzuodQTuBl1xO4ZuxjUQvhc62qL?=
 =?us-ascii?Q?ksz6tNib6H+EmyNvFp+5Xafc4EuKivvn8s0+B2yAgeM1T+938x/5bfXSoecI?=
 =?us-ascii?Q?2xvLWLvtCMTXdWTc7C7ii7JUqkNS5SDoAUfV441YcBf0Zn29JsQR9m6BAx/Z?=
 =?us-ascii?Q?7bofcVj0ApZlNsd6gcMJ7cLYJ7LliHCg+gJTjK4YW4YwVUnL2EB2VRnMJizi?=
 =?us-ascii?Q?z/1GJawH88z+MrKIDkhb5iIolGL8b8FlcTu6JULn54Pt9DgXDxq5/U2wYc4X?=
 =?us-ascii?Q?HxUq0+3JdzWshAoe6I/xMqQaECj7xun8OJmwSWxx8/pSqOdxjhucJTT5LTs?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID:
 <87C6861F1D3FF3499AE05689A18E319F@sct-15-20-4755-11-msonline-outlook-bafef.templateTenant>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b945e12-dac1-485d-f2e4-08dc85f4e23b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 06:49:59.3240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2125

Hi

I am Aditya Garg. I often require using out of tree drivers to support vari=
ous hardwares on Linux. Sometimes the provider doesn't write good drivers, =
and often they have to be force unloaded. It's a common thing in proprietar=
y drivers. I know the author of the driver should take note of the issues, =
but still the force unloading of the modules does come in handy many times.

Unfortunately if CONFIG_MODULE_FORCE_UNLOAD is not enabled in your kernel, =
which most probably is not enabled if you are using a Distribution pre comp=
iled kernel, you have to recompile the whole kernel again.

I want wondering if instead of a kernel config option, we could use a kerne=
l parameter to enable/disable this feature, I believe it should act as a be=
tter alternative. After all there must be people like me who are forced to =
recompile the whole linux kernel just for the sake of getting a functionali=
ty.

I hope for a reply and suggestions

Regards
Aditya=
