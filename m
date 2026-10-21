Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792576759;
	b=HQWYzPGqgxFL9BKuP/MAB9UslMN69hoYo0etdMiVI15O1dpYRUszslPP+qaP4lNLYh1b
	 T+55jsoH3yBunR/YwfAjbH70dgsvQknNrvei5KrLaaFA4SQ/wddMfEwZdCN9fOBs3JuDX
	 //9qKsoTCnzApeTcE3hfO9CGw0dHJALDI/mSufmc0h0KWLg/NlRBDEyl7uGmbeY6fkB69
	 IDWvWEPFmIbS4sq42J4+2JPn/eDyQTCEwcT9gqhMbo9m+amUSG3eCsMcssky//4MtPKuf
	 mYZak/a3rJ318fkAdpPSKKpGkEp9dduTa4Wk+Nkes3WukwzKWORCOqIb0HGaFZ7PGBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576759;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:X-NV-OnPremToCloud:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ox4N2XkxcuApxya1lev2zgvtF9mWfBc1QLOBANYRbxI=;
	b=STugLrkyjxrOUu1td+WB3tBNmn60FpDlNjt1FKvjRmRYZ+F6TAFJ2DKJ/jmQlOEg6ZHY
	 f6N4hAxl0vMmHayYKeR6cpvzlWMHERlx6yyV46xIlqy3h5FJWJP+FFzpTEtwFPo+aHU2w
	 YnFzFzQN7FbxBABSgAslXwzCt8HvjHAncCwcFxAESJVNXHUH/ophHT8g/vd8dOj9T9Jnq
	 R1RyvEzEbs2wg1kAyA0b9gnXSVgKpRivxSeWJr+9fJAkWMi7q60dDjybUCBm7eiq76KDS
	 HpMXzGTEE0quyWGHmVBQTN7sdPHvdOcNq0QFV5usDP39C5lQsVzBLDi/SDQRDeY3eaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cQLNSMzr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.17
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7E6606A319;
	Wed, 21 Oct 2026 09:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA7E6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cQLNSMzr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSZGjIhGOrNi9FvwJP9kOdaqSW1WeUsoSU76zqyZkZ65zgHzDrMDi51aeLE+go7DJBbO46YOLCvVS2VBm6KVfZCYM8KMSmVG9NuMtYXgEGsFe1eKt516X5lmI7BSsGOAoBfIbJcM+Bw0ctJbmAiLqQsmhIIvnFPqNPTkAHJm9pDMT8my/lUYUmYgiGqd9YAUYHPFC0JZ6EDA3BY669GU/FDnRIXpIctE6dP1Fq8Y0PhHCnPq0XNd6phw2pKzGEm4UEqT51/CKhGwt3Eu4zqfGMAiBogmUChqsMM7gvp4PGakYYb9A/IS6bYoIUWdM3c8vTbD0ARXmlWmREKkv4AQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ox4N2XkxcuApxya1lev2zgvtF9mWfBc1QLOBANYRbxI=;
 b=w6L3VNL7LyIHE5SjbFR+h9QaR5e4am1OICZTQEivgkmE0SSRg2LXKlwrUwNtco5+9Jv6AUqUTSbZAVQorjiBPBS3GOCtdhf9libjB+RTMDx+sWpq9tfjfmm96GZhYFtTTHTiQx/Q94gLzVoa/3NEcl+cY5RO91iEmNhpnZ0SCJw3LY1XvBuKe6/YbYcJAA/NJmFK+5ksv1uIZFWBaRmYIPVh/W4JsxVwc+x6dOm4v3r7oKU6KeIxql5/BXEQ+youMUUOA+ejYHFW+ycavoF4CrCTSiFN8o4CxXffXpo+Q/jkghVWlaaEnw/Fshyh0kPU5U1Sav5sT4BDT778jsd+LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=weissschuh.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox4N2XkxcuApxya1lev2zgvtF9mWfBc1QLOBANYRbxI=;
 b=cQLNSMzrdDitkUsp5kYaIxBpJjQJOkWE323Y5bzhbZNuFYlEJrGDpmV8Y/3DzPWAC6EHJzt5LFwozkW/2NACGFbtcCUFhX+36URd74luXDouRMZyONG3GJjAjCyvidS4UsAWfgT9MCl/bolCZAxDcD1teAZFEJ7Q8WWuYifjgXWdkpigQ4DdDnA6B5ajF9fWOEhvnzm5ouPBb73pchLJEQ/Nl+XeIRRnvXlzZjpAkUKNRBbyHBSxlSoHWY/OXSs4x6kOTw3matA4lnLW+S2B/FOGx8is9jbw/jDYnyeiLv/ISSTXi1aiQtSlxLEjpJ1kFDm7tPO88avaWyLs0NFZuQ==
Received: from BYAPR21CA0009.namprd21.prod.outlook.com (2603:10b6:a03:114::19)
 by SA5PPF916D632A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 09:59:12 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::78) by BYAPR21CA0009.outlook.office365.com
 (2603:10b6:a03:114::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.2 via Frontend Transport; Wed, 21
 Oct 2026 09:59:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 09:59:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 21 Oct
 2026 02:59:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 02:59:00 -0700
Received: from inno-dell (10.127.8.11) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Wed, 21 Oct 2026 02:58:51 -0700
Date: Wed, 21 Oct 2026 12:58:49 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>
CC: Alexandre Courbot <acourbot@nvidia.com>, Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?=
 Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel
 Almeida <daniel.almeida@collabora.com>, "Tamir Duberstein"
	<tamird@kernel.org>, Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Andrew
 Morton <akpm@linux-foundation.org>, "Will Deacon" <will@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>, Lyude
 Paul <lyude@redhat.com>, Yury Norov <yury.norov@gmail.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez
	<da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin
	<atomlin@atomlin.com>, "Brendan Higgins" <brendan.higgins@linux.dev>, David
 Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	<linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
	<linux-modules@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<kunit-dev@googlegroups.com>, <driver-core@lists.linux.dev>
Subject: Re: [PATCH RFC 00/11] rust: add support for dynamic debug
Message-ID: <20261021125849.19939717@inno-dell>
In-Reply-To: <ffe50a28-72d7-4b88-b7db-b7a590aacbc4@t-8ch.de>
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
	<DM9OY2QIU84D.2T3QX6SJJI6VH@nvidia.com>
	<310ae622-20e8-42ac-b501-4315c4cd4d14@t-8ch.de>
	<20261020212542.2e3331c4@inno-dell>
	<ffe50a28-72d7-4b88-b7db-b7a590aacbc4@t-8ch.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/pC7BZOMMzsltgZ3OCtkXL_j"
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|SA5PPF916D632A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 807424dd-473d-4168-d33b-08df2f59f4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|6049299003|7416014|30052699003|376014|6133799003|4013099003|18002099003|22082099003|4053099003|13003099007|10067099003|3023799007|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	MvHEJVKeo9jGovq2PbVkd89DajyfF25SN+PS2w2ndAk1t75ikh2LzOrfcEY/Ssc4tFwzSZ3lrTWbOvSfHycsO1QD+uXHa3SzWvMQjIEPan+07GywgP3Yfjl9spfhGtUxLApGTfNGjqkftyJ5RZXg7gE7yEnEPsR+GpsXKqiFM77w5nvV3rgDpmT2ApeafQBrPz1zoL9Rh/OLqKkuPQg2biZDPl8no9KiEDb5rfum9V9W6ANSc0yXOMBmLaQvnjXSSLuYNL8NhabGxGcz4iqxlaZRmP9ffPrzMopxgNVf7gMlDxeiJ6+FizxmybJ+BzL41tt/ELQHGuHD7fffIH2EYOGHHhubp8YqBFjdJVyrcKr59TKtYrHNo+VG24lDFIMxTqmNCSY6T6bXYhlgKA0Y7y38VsbpqMjCEMqelAR5D359IOdRtJqhEdQ96aKD32H2lBZENDP4ofPT5K9/XPlMCEk4mKvf9rI2SBqcRxil8kH10G+wC9W6mwPzMqBeZ22wAsPpmYqzY+PqQ7hlNn+hdPxwSo/52zOCzH+InWY7YQTYKNOyGVJfDV1FQZLBaPPNQ56V6ybfZjKJcs+hUcPt8o4cvwRQN516Od2xp0QoUcf3+BgQhXd9yj0LjG4s6Nt/rFf40IwhYEJuX03KQVJraOrwHGDP5Fv1AZxu+BAdWHooEDGILJpKRzkU+dzGbcAKklFvZHFCEuGXHhCelWPcmw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(6049299003)(7416014)(30052699003)(376014)(6133799003)(4013099003)(18002099003)(22082099003)(4053099003)(13003099007)(10067099003)(3023799007)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TdqheZmhhgBQHYgAAG+jV+ZPSWdYGg2OrSFAdnOICwoMZOaqAkgzW62KG44gHMZSq/0zG7DxaGdINamAvLcogL79BEcDPe7RfDjPG2y6Dfe7Xv4NMQQqqC4aTR0Fn4ghm9ZkmhgEDkeozqySYtljZNjXCyRStW4iB4AWh9PRIiFWacV0aJVMsikXjqaVN9uLzH5q8NS/mDw2ms6oNvCJxdALd8JEneWC4XS2CSQNz4KQbJq0azgLXVa3LvnorwDJGbl+az6zaR6BgFRqwo6jqMFNF44190+jiOhbEW8K6jTmft4Ki42x85LhIkI8+wY1FXDnLIICFv0jQHnRSSeHlRotoJamCB7PXkyiGQDQXxGjhPYqQbg80bp37uXQh2VoEYjFMJuZSPX67khbpb1RcbwR4DObUjTg3JURhcN+3/gIg5RKrRVf45nV1HDdMEl6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:59:11.5116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 807424dd-473d-4168-d33b-08df2f59f4c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF916D632A9

--MP_/pC7BZOMMzsltgZ3OCtkXL_j
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 20 Oct 2026 23:36:56 +0200
Thomas Wei=C3=9Fschuh <linux@weissschuh.net> wrote:

> On 2026-10-20 21:25:42+0300, Zhi Wang wrote:
> > On Tue, 20 Oct 2026 19:30:33 +0200
> > Thomas Wei=C3=9Fschuh <linux@weissschuh.net> wrote:
> >=20
> > > +To: Zhi Wang
> > >=20
> >=20
> > Thanks Alex for bridge the threads together!
> >=20
> > Hey Thomas,
> >=20
> > Thanks for the comparison! As a user of this feature, I'm happy to
> > combine the two series and see this making progress.
> >=20
> > The Bounded types, bitfield tests, and module_path!() fallback look
> > like useful additions. One clarification: with CONFIG_JUMP_LABEL,
> > our disabled path already has no FFI call.
> > static_branch_unlikely!() is sufficient for our initially disabled
> > callsites, including enabling them at runtime.
>=20
> Ack. Although adding jump label support as a later step would make the
> patches smaller and easier to review.
>=20
> > For the combined series, I'd like to retain these behaviors:
> >=20
> > - Debug logging is independent of debug_assertions, starts disabled,
> >   and is controlled through dynamic debug. IMHO, fewer distro
> > kernels are compiled with CONFIG_RUST_DEBUG_ASSERTIONS=3Dy nowadays.
> > (At least, Arch and Fedora are compiled with N)
>=20
> Ack. It would still be useful to also support default-enabled
> callsites, like the C version does. What about '--cfg DEBUG'?
>=20

Agree.

> > - Disabled pr_debug!()/dev_dbg!() calls do not evaluate their
> >   arguments. IMHO, it seems the current dev_dbg!() in your patch
> >   evaluates the params before checking the switch on/off.
> > (pr_debug()! looks fine though)
>=20
> As far as I understand, fmt!() itself does not yet evaluate the
> expressions passed as arguments. It only typechecks and
> creates the precompiled Arguments<'_> structure. The parameters'
> Display traits are only executed when the Arguments<'_> is written
> somewhere. IMO the typechecking should be done even if the code is
> going to be compiled out. Similar to no_printk() on the C side.
>=20

I encountered this problem by chance while developing my patches and
testing it on nova-core (unexpected evaluation of a register operation
while dynamic debug is off). IMHO, it seems constructing Arguments
evaluates the expressions immediately even if the resulting arguments
are never formatted.

I made a test on top of your WIP branch, the example is:

pr_debug!("dyndbg repro pr: {}\n", read_status(&reads, &formats));
dev_dbg!(fdev, dyndbg repro dev: {}\n", read_status(&reads, &formats));

reads and formats are two counters.

With dynamic debug disabled, both macros produce:

dyndbg repro pr: args=3D1 fmt=3D0
dyndbg repro dev: args=3D1 fmt=3D0

which shows the params are evaluated unexpectedly.

My solution was moving the fmt!() into dynamic_func_call()!

I attached the testing code as well. Feel free to try it.

> > - The dynamic-debug prefix flags remain supported. (I use the C
> > version of dynamic debug to support e.g. +m, +l and _t)
>=20
> Absolutely, this is a bug in my v1. It is fixed in v2.
>=20
> > Could you share your pending encapsulation/Opaque and static-branch
> > wip patches? We can then work out how they fit together, incorporate
> > Alice's review feedback, and preserve attribution for Andrew's work.
>=20
> Here:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/linux.g=
it/log/?h=3Db4/rust-dyndbg
>=20
> > Thanks,
> > Zhi.
> >=20
> > > Hi Alexandre,
> > >=20
> > > On 2026-10-20 22:14:12+0900, Alexandre Courbot wrote:
> > > > On Sun Oct 11, 2026 at 9:52 PM JST, Thomas Wei=C3=9Fschuh wrote: =20
> > > > > Add the Rust infrastructure to integrate with the dynamic
> > > > > debug infrastructure.
> > > > >
> > > > > Static keys are not used for now, as the full bindings are
> > > > > missing for those. A follow-up series will add that.
> > > > > Also custom classes are not supported yet, but could be added
> > > > > on top.
> > > > >
> > > > > Patches 1-4: Generic Rust preparation patches.
> > > > > Patches 5-7: C dynamic debug preparation patches.
> > > > > Patches 8: Rust Dynamic debug infrastructure.
> > > > > Patches 9-11: Rust Dynamic debug enablement. =20
> > > >=20
> > > > Were you aware of this series [1]? =20
> > >=20
> > > I was was told about the original work from Andrew back at
> > > Kangrejos. However I was unable to find it on LKML and it was not
> > > clear how far along that series has come along. The posting of
> > > Zhi's v3 only happened after I started on my variant, and I did
> > > not see it until you mentioned it. So my development is
> > > completely independent from Andrew's and Zhi's.
> > >=20
> > > > There seems to be quite a bit of overlap. =20
> > >=20
> > > Indeed. I see pros for both serieses:
> > >=20
> > > Mine:
> > > * No FFI in the fastpath.
> > > * No need for RUST_MODNAME.
> > > * Use of Bounded.
> > > * Tests for the flag encoding.
> > > * modname!() as function name.
> > >   (As discussed with Benno and Gary and LPC)
> > > * Better encapsulation of 'struct Descriptor' (partially not yet
> > > posted)
> > > * Use of Opaque<> to wrap bindings::_ddebug (not yet posted).
> > > * Use of !cv() (not yet posted).
> > >=20
> > > Andrew/Zhi:
> > > * Better docs.
> > > * Static branch support.
> > >   * static_branch_likely!() support is missing however.
> > >   * I also have follow-up patches to enable
> > > static_branch_likely!().
> > > * host doctest support.
> > >=20
> > > I am perfectly fine with merging both serieses.
> > >=20
> > >=20
> > > Thomas
> > >=20
> > > > [1]
> > > > https://lore.kernel.org/all/20261001145940.1077801-1-zhiw@nvidia.co=
m/
> > > > =20
> >=20
>=20


--MP_/pC7BZOMMzsltgZ3OCtkXL_j
Content-Type: text/x-patch; name="0001-kernel-repro.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0001-kernel-repro.patch"
Content-Description: 0001-kernel-repro.patch

diff --git a/samples/rust/rust_driver_faux.rs b/samples/rust/rust_driver_faux.rs
index de131fce491a..6db3124ed3a9 100644
--- a/samples/rust/rust_driver_faux.rs
+++ b/samples/rust/rust_driver_faux.rs
@@ -2,8 +2,10 @@
 
 //! Rust faux device sample.
 
+use core::cell::Cell;
 use kernel::{
     faux,
+    fmt,
     prelude::*,
     Module, //
 };
@@ -20,6 +22,20 @@ struct SampleModule {
     _reg: faux::Registration,
 }
 
+struct Status<'a>(&'a Cell<usize>);
+
+impl fmt::Display for Status<'_> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        self.0.set(self.0.get() + 1);
+        f.write_str("ready")
+    }
+}
+
+fn read_status<'a>(reads: &Cell<usize>, formats: &'a Cell<usize>) -> Status<'a> {
+    reads.set(reads.get() + 1);
+    Status(formats)
+}
+
 impl Module for SampleModule {
     fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_info!("Initialising Rust Faux Device Sample\n");
@@ -30,6 +46,28 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
         dev_info!(fdev, "Hello from faux device!\n");
         dev_dbg!(fdev, "foobar\n");
 
+        let reads = Cell::new(0);
+        let formats = Cell::new(0);
+        pr_debug!("dyndbg repro pr: {}\n", read_status(&reads, &formats));
+        pr_info!(
+            "dyndbg repro pr: args={} fmt={}\n",
+            reads.get(),
+            formats.get()
+        );
+
+        reads.set(0);
+        formats.set(0);
+        dev_dbg!(
+            fdev,
+            "dyndbg repro dev: {}\n",
+            read_status(&reads, &formats)
+        );
+        pr_info!(
+            "dyndbg repro dev: args={} fmt={}\n",
+            reads.get(),
+            formats.get()
+        );
+
         Ok(Self { _reg: reg })
     }
 }
-- 
2.53.0


--MP_/pC7BZOMMzsltgZ3OCtkXL_j--
