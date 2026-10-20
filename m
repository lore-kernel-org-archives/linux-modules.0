Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792520796;
	b=dnGQl8tHDju3l919pupRSwFzYEKAvIEH0MA851uotnC/tH1deXwM970vUQWOCf+Bq5Lg
	 te6gvRO2asUS1XHEaPVR4lYWXgXg1D8f4p7fEyC5A6MfTq17t5yjcq0EDRV+oLX9is4Rj
	 sK61dV5XhRvopaEe5IFpe+N9F9xn0pJ4+w7oLZ2iNIKWfqFMQO30DZFqyppAXcOKAZVep
	 Rzit8qJYcN5Abb6MbYahwHrXvZa1PjqLTHQvowCwl8dvOoBJ5x6VM1suuYut2lAdNRupF
	 4xQhN2A6x+ZzVaCD13SXaTsd5/y86g3c8hXlO7S1IIm3MAaatyCjNmMSKX+d5tPkp5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520796;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=SfM6Bgo1piRcZRi9hIh9huMp2WsCCYR2G1TXaLlsSec=;
	b=3OvrmShXT0LqUUQ1ipb2n05JZNaq6TGbu+3Reh7O93VMLp9+HuF4Djnvmzz/mCMQg70q
	 ltjK69pVmtFqCodLvDGPys4adtHQbOYSlKY76rq7lZbBHGJswaoPA6mvNbFRCjyuhEiYD
	 U8n5Fo5u/OV0U4e1ENRA/g7bOj0FkoBHZAR1XKwHMupO66WPOk0vbAg9QYYZEoSFlZ64y
	 vCAObjoVwWZTI0ssNicDBIrDMnlwPU9rkZOFQkS6VVWqFzuI5FauAeyVescFTNruO2yWh
	 e3/6HsBWxKARnXkSRs9rACs6c4vcC5JO30Ko5ECly14bNkvb8BRGSYx2zAncnuN1GHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XCQ1DpdG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.67
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D444606A319;
	Tue, 20 Oct 2026 18:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D444606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XCQ1DpdG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2Fj5m7+FMAcwuQQ/KhS1KgcbiQXZbBjrzuZKPa3KcNl9fmVXe8sPxCAzVaE9p95F7eJOjp639hgozHmu8MJEmvlHybH+I9Z7UFkIt3xJDmi343fXah+MXy2gUvqn2EqmQJ32e+HwNwkm+pi1ws+MnWLDPhXAdI0H1azI/Fzb1fTi8flR/HSsogdpeWcRCQvMLXsfYGqdbhnxDhpoV+L0bVhVrVEGbxGqit93dPUR6kY1XTRxKwEBo6uCPg8zntyFlOtBhYquckROR9+TAAPBUsBR2G835vmhzH5C0AFzD0/1hXBS238JaO/f3WZ+jYY5RWtUVATW0bXp4+SetuVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfM6Bgo1piRcZRi9hIh9huMp2WsCCYR2G1TXaLlsSec=;
 b=oNYntcrmkoXblgdf06LOgflHfnf13KaTc0b6u0fTJwTIz0smgCa3P6XOb6O+j3qHPzXCm3ipz2jZobbjmYZH7lsgFeJwT6Io0GQxBzx6xpH3TtyECFckLyNubGbLbMOiyXVIm1TZ9KdTntj7MQozxEzMpG6E4S+VAs6DcdyxrAo9/vjUqmvbGwOVqMau/KeE4DJ7c6RppwWFAbPKDoDCjRwQQFLbVzJw5la8jGy8UbQbNqbyjE7drSeszkVjn/9B3Boze/2qLuD5yPLJtyJoziZ+TJQFLb8MoOM1CrkA36+e2mjqc5Eo+Zr6+bN+SFgYqAvtQcL5UMV8ySQytKhmVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=weissschuh.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfM6Bgo1piRcZRi9hIh9huMp2WsCCYR2G1TXaLlsSec=;
 b=XCQ1DpdGANj9gS2TIKOO3LrpDOJP4wEOkQL1QW9vVfB03E4Pac2Q8tdQbQAlGPZ6vbLtk7xPRvYNbWTqJt8QBgQKzDVZH12CrHLbEt2rLRuN8m1YsN1JuhNizy6F00zUqpCf6ppWLsaG3TBWJMk8XZ/HnOGwxwh4BoUWZHG/xSoIEBkjM2C7tnyqy1QNUBbCjUZOsLIkhbfddm5PbDxJ3dcAit+e0oa5qnz9+fGX6KA2rvaUaqK93aHGwm3dwMZXdHNT/X7Td+aZKgCpXuE2kYJb7FVuhEfUeHVrNdJsHXVrj2+pq3FXxhFE983iGSJxuElYZDGksCxjeOd6FvZRQA==
Received: from CH0P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::18)
 by SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 18:26:28 +0000
Received: from DS4PEPF000001BF.namprd21.prod.outlook.com
 (2603:10b6:610:116:cafe::95) by CH0P223CA0014.outlook.office365.com
 (2603:10b6:610:116::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 18:26:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS4PEPF000001BF.mail.protection.outlook.com (10.167.23.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Tue, 20 Oct 2026 18:26:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 11:26:02 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 20 Oct
 2026 11:26:01 -0700
Received: from inno-dell (10.127.8.11) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 20 Oct 2026 11:25:51 -0700
Date: Tue, 20 Oct 2026 21:25:42 +0300
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
Message-ID: <20261020212542.2e3331c4@inno-dell>
In-Reply-To: <310ae622-20e8-42ac-b501-4315c4cd4d14@t-8ch.de>
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
	<DM9OY2QIU84D.2T3QX6SJJI6VH@nvidia.com>
	<310ae622-20e8-42ac-b501-4315c4cd4d14@t-8ch.de>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001BF:EE_|SJ2PR12MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b985a24-c18a-4dc1-c025-08df2ed7a51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|7416014|376014|22082099003|18002099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	KP1W+pmv7eg/IzzRT/smeSM75g8n8dHits2NpwguEu0cqTl1t629K1eVMa5Y+8cnTTOo/fhs8ZHSpxDxEVSgl6S0KGT9P3V7MGtxkGb3EHIcR4Ro/ZfTUofCbXBT5zA2phOqiMqRflJMOBaRsQ4tzIOAcW4x37jotJEp9eNn0218qcSBfb1t6YBK3Q1UiZpcroHM5WHgECBWzR87fO2sTGDI+3X917Y0ffSwqqQdLDJw/ZsOVkZ3eXYCdH/8u1RM+deXdLeRSpeytPblmpNK5pUQpoRTXQuhGPto/YEwzKZkEHSlGXIyYBl/SnYkoBhphM6fkL3P3swwn1JW31eZ6Al2CGvNxYmofVaRah/So6UqRtuXhA4Wal/80O8PAZeECzPmZjktptMBengTbTBdfWtCe1+pv8ObzWi7iH5djNd7fKAqBdCgTlx/cg1JL4sUwYA3Mf7WLaLNenIS3RCoRfXh4vUXCTLZAQVZUxYSKsLlmuPzvKB54XbadHh4kgf9byfuWUfQiGCGXUPjv9eeMY3o3NBS39fSaHxj177Hes1vIE6Sziuq1sUeA33Ce7qtFRfcdLqat8x/iyZwySVvuMFnHsZ/oSeS5/IPTkQFna8v3/lMQ8BaD92STG24Karw3ai4sZbsKfBBvKs8xib/K4OrKGRamxSLYX3BFHyUsZijS4/HOOBg7XVRiEwjVFyoapcN3cd6ivyKyw+UFkaACQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RkWpumCQxpYML1raMcdXYG/8RmM6gwqEucVZzazom8XAzy8NGTFWrz3OotPLtjHda+l0l/dmRKVssVQc78fc2fphmEzuIee94Qf3OWY8UsG3lBOrDbTBeQQSAE+nrpnBGxzJ/twDbuMmAfr8p/yHElDjscWuW6CDbaz9gc5icEMhUJCYy8r0YCCUyZZmVHxV8x1iFGlf22ClHoOhdaxafLkYbE87lHe54CL3cFF5JNzXY/r38m24QEPLKikwmVNySLgZZMzx5eZPmzhk2p+Ztv12+P6qbt8kww4YlHOOuW3cA6CMwV7zfsBWXywQ91iQ4wxntskHhAn1LtKm4oewiknDEwhYVRrqpt7doX8Wg6vZqs2uvh3TJz9WhqXPqzBNCdGCBSXWEDl2vbwr7zHwzQY5SIheNB1EwwGNAYfnTcKGZhMUzMsyb4ivC814zAKe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 18:26:23.1866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b985a24-c18a-4dc1-c025-08df2ed7a51e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS4PEPF000001BF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848

On Tue, 20 Oct 2026 19:30:33 +0200
Thomas Wei=C3=9Fschuh <linux@weissschuh.net> wrote:

> +To: Zhi Wang
>=20

Thanks Alex for bridge the threads together!

Hey Thomas,

Thanks for the comparison! As a user of this feature, I'm happy to
combine the two series and see this making progress.

The Bounded types, bitfield tests, and module_path!() fallback look
like useful additions. One clarification: with CONFIG_JUMP_LABEL, our
disabled path already has no FFI call. static_branch_unlikely!() is
sufficient for our initially disabled callsites, including enabling
them at runtime.

For the combined series, I'd like to retain these behaviors:

- Debug logging is independent of debug_assertions, starts disabled,
  and is controlled through dynamic debug. IMHO, fewer distro kernels
  are compiled with CONFIG_RUST_DEBUG_ASSERTIONS=3Dy nowadays. (At least,
  Arch and Fedora are compiled with N)

- Disabled pr_debug!()/dev_dbg!() calls do not evaluate their
  arguments. IMHO, it seems the current dev_dbg!() in your patch
  evaluates the params before checking the switch on/off. (pr_debug()!
  looks fine though)

- The dynamic-debug prefix flags remain supported. (I use the C version
  of dynamic debug to support e.g. +m, +l and _t)

Could you share your pending encapsulation/Opaque and static-branch
wip patches? We can then work out how they fit together, incorporate
Alice's review feedback, and preserve attribution for Andrew's work.

Thanks,
Zhi.

> Hi Alexandre,
>=20
> On 2026-10-20 22:14:12+0900, Alexandre Courbot wrote:
> > On Sun Oct 11, 2026 at 9:52 PM JST, Thomas Wei=C3=9Fschuh wrote: =20
> > > Add the Rust infrastructure to integrate with the dynamic debug
> > > infrastructure.
> > >
> > > Static keys are not used for now, as the full bindings are missing
> > > for those. A follow-up series will add that.
> > > Also custom classes are not supported yet, but could be added on
> > > top.
> > >
> > > Patches 1-4: Generic Rust preparation patches.
> > > Patches 5-7: C dynamic debug preparation patches.
> > > Patches 8: Rust Dynamic debug infrastructure.
> > > Patches 9-11: Rust Dynamic debug enablement. =20
> >=20
> > Were you aware of this series [1]? =20
>=20
> I was was told about the original work from Andrew back at Kangrejos.
> However I was unable to find it on LKML and it was not clear how far
> along that series has come along. The posting of Zhi's v3 only
> happened after I started on my variant, and I did not see it until
> you mentioned it. So my development is completely independent from
> Andrew's and Zhi's.
>=20
> > There seems to be quite a bit of overlap. =20
>=20
> Indeed. I see pros for both serieses:
>=20
> Mine:
> * No FFI in the fastpath.
> * No need for RUST_MODNAME.
> * Use of Bounded.
> * Tests for the flag encoding.
> * modname!() as function name.
>   (As discussed with Benno and Gary and LPC)
> * Better encapsulation of 'struct Descriptor' (partially not yet
> posted)
> * Use of Opaque<> to wrap bindings::_ddebug (not yet posted).
> * Use of !cv() (not yet posted).
>=20
> Andrew/Zhi:
> * Better docs.
> * Static branch support.
>   * static_branch_likely!() support is missing however.
>   * I also have follow-up patches to enable static_branch_likely!().
> * host doctest support.
>=20
> I am perfectly fine with merging both serieses.
>=20
>=20
> Thomas
>=20
> > [1]
> > https://lore.kernel.org/all/20261001145940.1077801-1-zhiw@nvidia.com/
> > =20

