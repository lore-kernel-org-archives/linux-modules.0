Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010001.outbound.protection.outlook.com [52.103.32.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C9C2F9D9E;
	Tue, 30 Sep 2025 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759227942; cv=fail; b=mDzqGCD1AtfVvLeb4KQIh4SIQI41K8NHh5xBxavonNsz0iVcuVeh3k4wIRYZ3w6iWNf5ktcvFryHP1MpWo6Bk7llVuhJow5QaHPDZ6NijXRSNcGHJ+E6T6O5nJN0ou0FGKhrG4Uu1xmj+kyDgYvnHIdvcr4maS8SYL4i58+B9II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759227942; c=relaxed/simple;
	bh=bUjx40Z7MxkQZkpIvRy015QSsqMrj3HMDcrNpIbj3mE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=M6e8ZX+sHB+fwX9IZgzrNes+Tymz5M+co3/HATh9P3A1s+BsSkKXwsuFLQSZudf3nuP5qIdiaBPEHNueIYLVWccGmP3c0DnJ9rCLvNaCiAU1aoyvSm/dagw7CSl8dcxsKUbaQE+WAFv7+2Pk9RUOw/ZddL4OTVRaMcwpZBr5cxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=EtZFHogx; arc=fail smtp.client-ip=52.103.32.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="EtZFHogx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlc4sbpSRP3ujLxaPAFtpjX1505lnx1YvBqtfJ2Oj07HZWug2Q8gEL/PyxqVPi+6uyZ7TkuAIC460YPOSk5kk6D9hQ42Px8v0rdYAsrYJV6yRYLrauFaYsS7Yux+TDeynxCY4ySkxMnOhWbge0xu1hPPLgJSPPAxbk6FqfLnxO5KooenfjnwtAh4dsB3yjSQ4skfdGKvHWPxkYJabY8/9o4n483wxhyqghncr0IRpxYQOR3sNfMtN4eAdM7lznyJgPxNhARPlp+aPQW54OU0a8D/h3T9Oq5dx2tctf+HIGYjHT002Xp/9kIaRsD1yN0Zfddpg2EBfMmX7p+3Tjx+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0h3hQ2odg3XRbz+/FzXSMC5FyzAwnh6UAVV29UT+8m4=;
 b=hWpqk4C7nhhzyds8iVl0Z3DyCxFuHjEDPCt2uz0TEOCeKEZNI9XcsmPunThhLx8VsIaF8/c97OrdEpIgLixBfVKkK8/22yUV4vV3FdOrwZEfYu1H9giu26gZBoHyh8DMG/Lwx8SOS2bD0VEDFjiQVjY2hg7FQesAyz8gVvWdpviEgSf+W7e8SNtS2VrT6jLbdj3SfZj22j+Qh4adXg/TK8hQCIKEVhdKiFvkH6G5HVAXBiPHRMXU7TmAr2sz3rNzmvCUsxzkHjP/KOkU0/YoNPPvi5IsSug7ITwJKfrGXlLrn0Sr+dBh8smzqj7GTpTj7pynIKJx64/0TwiP7aUG9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0h3hQ2odg3XRbz+/FzXSMC5FyzAwnh6UAVV29UT+8m4=;
 b=EtZFHogxsSmDaLt0Tzi0UnXCcq2TWD9tO1Zmzk84ZpBY4M7W5VEufTa7XEO8dvew/AgX8rAS51TJO1k/LwzgINIC1uoDpxMJ2lqMjBORhHXzCLmZvfxX/cwLcw5K1cq3dizGl0DficJaYdGj3I5HhA5P7MyZk3ORcKgbEJd6iTAJPuW9RS6iFpfqO5/UbyU0AgOdopV3AiotvntdmjXu+mrYMiiCMFoNgLxs7C2w4Xa+KGdIcdUxdFzcAyYToAwc2F2bnshkgu3H0hDTAmWmEG9Hrx8td2f/SJNfuf9aRflOaZBOuUvHO71fFKE2GxN1WoM5xOLGPmJ5CU8zkpEHIQ==
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com (2603:10a6:803:85::14)
 by DU0PR02MB9395.eurprd02.prod.outlook.com (2603:10a6:10:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 10:25:37 +0000
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::60e5:4de0:ff18:2fb1]) by VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::60e5:4de0:ff18:2fb1%3]) with mapi id 15.20.9160.013; Tue, 30 Sep 2025
 10:25:37 +0000
From: David Binderman <dcb314@hotmail.com>
To: "mcgrof@kernel.org" <mcgrof@kernel.org>, "petr.pavlu@suse.com"
	<petr.pavlu@suse.com>, "da.gomez@kernel.org" <da.gomez@kernel.org>,
	"samitolvanen@google.com" <samitolvanen@google.com>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: linux-6.17/kernel/module/sysfs.c:275: Always true test in for loop ?
Thread-Topic: linux-6.17/kernel/module/sysfs.c:275: Always true test in for
 loop ?
Thread-Index: AQHcMfQsAnMo3slzvEG35zIVVtK0zg==
Date: Tue, 30 Sep 2025 10:25:37 +0000
Message-ID:
 <VI1PR02MB3952FA1785356790D290CE949C1AA@VI1PR02MB3952.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB3952:EE_|DU0PR02MB9395:EE_
x-ms-office365-filtering-correlation-id: 27e0a21c-7550-4bde-6df2-08de000bb2b8
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|31061999003|461199028|15030799006|15080799012|8060799015|8062599012|39105399003|40105399003|51005399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?tT8oeB+bQ0P1RneCa0ERZ+GVRZsXi6UHQIUL8I6JGZv4ER8SfUUXDc/9lx?=
 =?iso-8859-1?Q?XgMvE+c9/dLHpG/FuffWjHNbK9K+LFM+206bk76lD6aX1lazKEY4SJNa1I?=
 =?iso-8859-1?Q?p3HAw5M0XoXoPoX8RdeLFs2Jvtbjg6w2FPri6P14zD69PY3H/ei7q5eTiV?=
 =?iso-8859-1?Q?LEHy0lbTF7/CZUJzC7UoxKP5GBjnAiIv8m5AU85xDmWpekku2ZCzn6cfMZ?=
 =?iso-8859-1?Q?6P+uUeZe3HQpSibEPvM2VRS9Uy7aAMy2oKyJEaSI6+eBs0HyRbK0LvV9EP?=
 =?iso-8859-1?Q?9+svrs1F87lLv/PQ6aGE9m0sq1iq9/O55unFtNxdxLFriw/Ds/xCr5OxdU?=
 =?iso-8859-1?Q?PynbhTUO6ol2iVj2T8QKQOGbAa87JhrjIcI+AqiTDm3eosZwmukZFgch06?=
 =?iso-8859-1?Q?ZfCWdM1iKyLBQNzZxBdamXSbZ5FKnGbhqIxQq2D+XYGKI4bItbQXq+1vFC?=
 =?iso-8859-1?Q?9Kg4EbenkinwQO9FzmVARuDwtt+3P/2bmVlpSGSmcQMO3eQRxA7HIL8AHH?=
 =?iso-8859-1?Q?30YFHBU4T+Wl/x98WiERjEWC6L/wot18eu2MIsQJZX7w1euO/AIkalg9x/?=
 =?iso-8859-1?Q?9pVKPMWALROLPStN8xC/RdVOvRUcUMVjUgBjy0K5MzyZe9N53SShRWVqdr?=
 =?iso-8859-1?Q?wWhh0iWT/5641qy/sj5cKEHZIzn000QtilgDx383p006YseInTxMh24MCc?=
 =?iso-8859-1?Q?IJYxrljFsHQQzEqdLSPU4hiywkx8F4grhss/IeR3zZfxsuWWs1NGvE/ndp?=
 =?iso-8859-1?Q?vHviqFvxKQOrrDmF0KNzqPN1+D5q/2DBlFkohTIxkzUvJjVEAAIgky7IgF?=
 =?iso-8859-1?Q?FzIZjz5xgfPToSzZvcwN4AP1bBrNAv1FT8aUHk/Xcc58LK+wErU7niEO2q?=
 =?iso-8859-1?Q?5YDSkUffKE6nOViY6NhJ2Ot3dTvEfQmoIqQUwXfcIn/1xc53KBEn4Mv1ys?=
 =?iso-8859-1?Q?BF14+8BGKZMupYD/R+c0/9I3rURIre8Omgxknbekon3q8lkUPsKTqqVyv8?=
 =?iso-8859-1?Q?Rz/LmU2Yai1r6EsJiHTfuS0OsuE7nSHNOTCdw64XO76AI9Gv2YL7qu58az?=
 =?iso-8859-1?Q?89FKv26bTsg9FhxT33qvVIhkKHqFicrCPm71/vQWZ5wc3LFYDCb+Bn/UHU?=
 =?iso-8859-1?Q?LEhvN7ocj7RA4vNBwdHzKTB4AE7UnT79rSmqqINu20fF+ZbiJF7Kbe7wGL?=
 =?iso-8859-1?Q?AivGDIWX/BRtITKU6TfZRuQpZddmV2HhTMpvP0G5fsECHJQb/D6YWZvURd?=
 =?iso-8859-1?Q?+OCx//yv0IKOlLLz2vJqGt3m10uK9WhRgKCI50JSCbOjo61VbM+PZlp1sR?=
 =?iso-8859-1?Q?OUZN?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yiBqo908UENH8p4aTYJc/RZhwO8rSQC4rFyJdSqf7smomia7Xuh8NNJ1vw?=
 =?iso-8859-1?Q?6ww6FiPkL8eFkwO5Y7YofR39FXlbUbs6p2+JrTZ9ZBFk+ZVAL0zTiFvR2C?=
 =?iso-8859-1?Q?nsUl2qdRLDbjlC8QOfLGyFkUwmI/9hR2ZFhFKvDgHQeGCLTNHXqoz5Lxtf?=
 =?iso-8859-1?Q?12De/g0uhw/iJ5kV3n7NBZrj5oMJBEE6vOv1l9mQ2ngWaYhVO0DoeF3xZa?=
 =?iso-8859-1?Q?RXIftjKfm2zJuU0wxAhXYXdqEgj/cX7aUXx8lTjnYwxhoRGOzYSwvM9cKL?=
 =?iso-8859-1?Q?/TK4H5CWaEqt9PFaiDVJqTJBfbHGn+e5iyMOjZpDIpDF+Jqmt05kkxjGdO?=
 =?iso-8859-1?Q?iZFU9F5j4XUYfyJHKP9FW2mZvb/JDM9fYF7aY7923iPpvXe32LtCfaYY+u?=
 =?iso-8859-1?Q?xNofC0cZ8cE1PUb7s11uwOAOqVe+8jMiEOin3aqy3aHS7omOtGWioOBzpW?=
 =?iso-8859-1?Q?4cwT4SLNCsgiySoWcXsSLQyOvnUmzqxOtyUkrHoZ+EhEO8BFH47qZ3ku8W?=
 =?iso-8859-1?Q?DJiE7Z9qIUqPZxh+Pej8RATKuZAuNMFtSvodGxbHvDCYNJx+cb/lIvTyDY?=
 =?iso-8859-1?Q?FGBTFdySMOVlp0yaCs/nrPMiDfvGmW+DDWO82KEoJzt+ifdOiA28vXuLmm?=
 =?iso-8859-1?Q?91x9QxKVOY5Ba8vN2YxntqFrvP2PbM51OVeVOpqcpyQUsLzEp3FsPRrEA8?=
 =?iso-8859-1?Q?THM1FizyE0kE+IGkuo7pVN5zligfW8gbqjBXRO8O1RTiodHdyFva9hibjx?=
 =?iso-8859-1?Q?TbU9DHMlZ07tgBwIAZgfcZZ3FRI8IcPDcAa0NQB9APR7RlbOSZn0T5fDVo?=
 =?iso-8859-1?Q?Iv0EcD3POxietAD1kvtQRidPs0+pa+Hcyyh+9ZMvHd2GrV40c+C1G/R2wG?=
 =?iso-8859-1?Q?zAP3GyOo5a8u3IM6zquf4zPYrX3djoOEbZWSzn4sTx1hYxWZC4meXYUcGf?=
 =?iso-8859-1?Q?hKcrBr4vkIos/RW+3TP97gl2mXNiYB9hMd/H3vpgm1AHSXSMITG8RHiLpR?=
 =?iso-8859-1?Q?uQ1z1fqBw2AZLa2oX8bIE9ffoz/ONVvWmAanRSRnr93AL7tBl2OO6GdZa+?=
 =?iso-8859-1?Q?61SxsedU2OtxrIGvuoDaKItYupipTihZj4VeY9OX4bfsh+7mWgmyEY4h7u?=
 =?iso-8859-1?Q?A2pq0o+5j/m0ju2qyJQIdO9vrcTCxPh9stH2ZqHnU0mhcgWh1Ri1HaJIy+?=
 =?iso-8859-1?Q?kPkgTlvrUxy6u2805LrpG1GMBrSlFUz0QblPMuCuERqvx1Bm++SLJOMedb?=
 =?iso-8859-1?Q?Suqh3lShlypcU68WKbgA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB3952.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e0a21c-7550-4bde-6df2-08de000bb2b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 10:25:37.5938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9395

Hello there,=0A=
=0A=
Static analyser cppcheck says:=0A=
=0A=
linux-6.17/kernel/module/sysfs.c:275:20: style: Pointer expression 'attr=3D=
&mod->modinfo_attrs[i]' converted to bool is always true. [knownPointerToBo=
ol]=0A=
=0A=
Source code is=0A=
=0A=
    for (i =3D 0; (attr =3D &mod->modinfo_attrs[i]); i++) {=0A=
=0A=
Suggest code rework.=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
