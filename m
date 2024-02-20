Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1AB612D7
	for <linux-modules@vger.kernel.org>; Tue, 20 Feb 2024 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708466209; cv=fail; b=JhNfbVuwbf2wnZW3yfzdJFT1uYCRp+zh4V4oTrHRz0arMypl7MeKD3AnI2UrAphyLkehPvFmdt29OS9QJbJr0MIUdkGsRm1gXOqrb6Nm/n5fwk6hGEX0VOfi+Xn7QJCJ5CmolbaI49G+GTJU9mKGbeAexD4ihUNXFmSQlpy9GhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708466209; c=relaxed/simple;
	bh=EINY7GpB3peMCwyfMY17171EaYmaJrUlVidhFRvL3l0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dny8fjWLx92C9Mshij/ZIykdVWbv1GfCX+GZBAJwq3hyomO8lrZNnTj0QdLy2qPkAeIGTNtRNiGw0n2F5qVHXj3o+j1g36vQdhpCtGdn3AdnzZDYAWObLOFzv1lpz985ZNt1rJLo5oU+mEu2xRVFVAm9ylttKDBpCj0ChX6U4Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPgGvthW; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPgGvthW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708466207; x=1740002207;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EINY7GpB3peMCwyfMY17171EaYmaJrUlVidhFRvL3l0=;
  b=YPgGvthWsI8HkJ8yyND4lrFnetDyKU+sMCizKTWAy3LyRDYwSZv3vY1N
   ZttmQETO/oT9r+/bYZv2L5sZn0fOSfC4l/6ZNg2hJIKm6WAjIkk6ydcev
   yOgti3Ai/HmAuBdVaE+dbtuOmalB8q7Uid8ZZPCdSFOkq9eCCGAuvWfl1
   RysOE4IBtqu0fQZFsfR3M3HGXuAVO1R4c02ywmzM5VDHXvzBZjLXGVbdw
   IjG2AtUnV8nmho2bqhmuV8Vjm+IT+jMqYXlCYf/WjqPF08kadOzOndO2Q
   9kjYLV9RY4uYgR17rbMgITHoEJwF6H1HfJO9yVMwBZOeBxkofPFtTGLHI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2481597"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2481597"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 13:56:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="35951442"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 13:56:44 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 13:56:44 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 13:56:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 13:56:43 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 13:56:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTG47BkJUgNx6lrCSOfpJOPiYZy8uo504hm8KlTVDdXiRw9OBZb7YAfsCRo415+trwh0VHTAt3jgyA5qVgs6bSZyGk2k7qJX4bqlKHysv1YTm/YzDioxFejQGfoSrHWkL6F0iKiIIk7H/lvukpoPvr00BpW8rRXoHHqu7Vs/vrFtFRBzXY4s+uH6IBOExMEimOPbhEVfnVeWAVAHfJStaqbJcxEN0OA4RR3NvWeAkhZSUo33zdt3joqH2Wbzmc0Q7hu7wZ2rfajQQLy6TWTtGfZy7Y/nVDJ13ZwusMa1Rx5z8pyEVfFjsCNI44hgSoeKBNvme13PO7BG5qJlxY4w8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnllvpYFtEUNMmEFyTY0ACutW8Ns1sw5g4IQmghVbKU=;
 b=N/PK3T2CV8+k1FqxVwAWESwkS01rg65l0XDuIR7x86HSK9iO06nQJGA45e5Zpz2D0LsVdbVR+iw27qvHoxxOFLg3MWJuaxqi8UyRCjQg2QPhiNpCXXlhFu74s+Dw/6HTPiYIAmY1vXHgSH3++pOnl08d5JFqe9NECfif7P4HW7j1b5d0giVyGfS4SRMXbaGEZ5x7L6HCWoQCO+0lJA8eruN4poLioDXZ6ex1NkLl+gRzo0PpJvqE/qIOXYZ/fuLn8AowLKOluRbI9C2JyOvNm28VgYQxaEcZnSM8H6gZP8Lqd51acIEe+d4p/TzZEfNZldAw0sJ0jh8nzdMt4yh8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CH3PR11MB7769.namprd11.prod.outlook.com (2603:10b6:610:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 21:56:41 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954%7]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 21:56:41 +0000
Date: Tue, 20 Feb 2024 15:56:38 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod] man: silence autoconf warnings
Message-ID: <63an63knqvcxyxh5ejx64bsxgpooikbba5inrd2kzbxuhuuenc@nk644hvv5j2p>
References: <20240217-autoconf-manpage-warns-v1-1-e1570cfc286e@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240217-autoconf-manpage-warns-v1-1-e1570cfc286e@gmail.com>
X-ClientProxiedBy: BYAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::14) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CH3PR11MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf0ae81-1d79-49b9-7ab0-08dc325ed1de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xm55TgWqWRiFpIycQhJJ+BX82ejzuztpIugZ1k9I9oDuwHfuLW7PWB9OHeXEms6ygEXwmZSSzWHXgocCpV813Few1PcT4xYyfZXrVNzQYpnkUjAsI6YVUjymY2udGXI5ngSDvWIFrZiexlBVu3KNPXNGCNi5v0aOYhmwE20InJTRXAPrBtse5bf2l9PklND/ONWROdrdl3rDK2tzwHXPra2Q20wuOBCxRD8DSqYMI5ePgCRhuv9TJ2mm2VhiD6QqhE+ijSqEQtHqyyIKlAOEyaiaHf0Z4Q9+h4V2WxFtqo8k4hIcMJnp+cpDcpYa152WEppJvuOxBB2UMUyJ4brEr8Aq+BRwLbZGPGMFqzNLeKvHofGpnl5ssWnMHHteCWjTJ0eywg6yrZfrjP7Zux3NoSoBMFUXQLei85qSMNuUi1b8Ot31YGfiMx1rzqlSN0X6VsgDdPUyGYun9A5iEz4gZDUlrFoIWx4ZQVYwAZGOXIMIxts3lavj5XIDz4O16nChAe86KaMCudxE+z8hbz6nBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NQe23OPwWDZ3Bx8YEsJCCC4F1fvTe7Bt9GGug6Ho3gYA3DAMi1i92b7EqI6P?=
 =?us-ascii?Q?hSywRIBbWE6IRhWIGT61141Zc8paixL4igV7LeT3NOrTZ96lj9hVWE92Sf1a?=
 =?us-ascii?Q?K4VbqnuJ1+ndKVwL6ESPCop9PopCncJn7KJTN8KBsalKUguFxjJyNYhGywMM?=
 =?us-ascii?Q?cw2475geN6RUWSDrMr56UQ9wB+jy2zTvAgK8/u/W0S6aArUdDeWq1id0TUa7?=
 =?us-ascii?Q?T5FOjs9lMzNV53q1oj8+dRtA27ADnwBCSC6imozfMKEUkV6oY+t1ICzrGkQh?=
 =?us-ascii?Q?Pfz7LVa6q9YuMa074ApsNkZL+iE/V6DBa3XGrE9/U0l/V4YM5DAVM/cJfmeL?=
 =?us-ascii?Q?hIHC1Bd8mcCpx39OYsmvVM2whPhDqv7XJog0cRH8urv5hgqfvj1Ty0Jnr5Pc?=
 =?us-ascii?Q?G1DweOWJ4IFycRaWEFrH4D9+3jpoepZNViDGtQ47yiZTzkSN2huQoOD5FTGn?=
 =?us-ascii?Q?2ZZ12djbN2LU17RnM758DsWann8f/hCNelG7lDWmcHsLh4bl4irvYZW1WJ+b?=
 =?us-ascii?Q?CdEW7SyN7KZZiblrZEmFz2vCGfv4o3/wplzBQZN/k/fM2ygu3zC1T4Z7msw9?=
 =?us-ascii?Q?CWAOUqWhHaYGvz2REDJWmvChwiz9dsgClGJOxiY8oTUL6aD/xezOOw4MhHfQ?=
 =?us-ascii?Q?Ih5b+j3McHaV0E2TAYD+ALNXBQeNBS7nJF6rvT8q9GCC4sXkGgHW9I7Xda/1?=
 =?us-ascii?Q?Ek95dlP+W6Syb6FPxTbbyEoyAqDUbQHznqO+6/ejyKCX6bIikYSNn7qy6co9?=
 =?us-ascii?Q?J7Udi6Tf/Kd0AohbgjJfXLCAB3Ts1CT5KTk0CjiJZnthMRkoFRzNxl6/zrXH?=
 =?us-ascii?Q?j8gd2fsZe/gqyyo+/WdY5uj5l01yOqITSqoCv0mHFSERek6guKhouPsVUBFt?=
 =?us-ascii?Q?78gJj/w0O1cPbasa2cqb4QQsg/Dtr+hLVyaWgntehX9FzdAXvLRhNwZ837RH?=
 =?us-ascii?Q?gOpWWvdv/EJMic/OAMMfRo3kpV39/BZwq+VXSrfLdDSyxEyVYChBzb/mko2z?=
 =?us-ascii?Q?vxfT7RFEXAsZcT6pKa+ZDE/JO5x8jFT71Zu1Zz1bU5KLGSWDN3lx0CeQNwP5?=
 =?us-ascii?Q?vrF+wQzYVh2o6aLDraZsONFwtMja4pTBSRLCXXTtjCTkVFM8pt+TLvfIRlOs?=
 =?us-ascii?Q?/5p3gBt49/V2Jm+r1peVObKNzbPmTWXCXkvUvDO9Bm/+j4+Cg80UPR1j76wm?=
 =?us-ascii?Q?bQzpUGXlnS8wIjY+UZeoEcIOVjkrq8mZRANgcqhPY4mQMTCLh3dcpT42vUpW?=
 =?us-ascii?Q?D/A6OInZ29C5ZDGd8BHRKKAlbmKIoP7KNMWuAT+COQPEIB3xaBMHITtxagHy?=
 =?us-ascii?Q?S2Fhkwt3UkZExZHq2gw14jEkQiBniTzXt8wZqfts4rJQg4+vGpyCX1mEfsUo?=
 =?us-ascii?Q?9BTzJ6cXEo77USuS6RkC5PsKK+HWkapMb2qSgR9EiZODtm4s8UIs8kqBG6gg?=
 =?us-ascii?Q?s4OC8bmPuF2qfXlup7oZPrhvxibHRQYiYzvo2q83Cly4N3WNVhxeolbU28nL?=
 =?us-ascii?Q?obY/NttQPAtDG069gg0dhgjHN2pYgrrhIay/Dj5XwgW+NpP76+QKLxMwk9Ps?=
 =?us-ascii?Q?hIjYsyoLFZUl5x9KcYgOgm3E9Jd9+IQZWePXRhfhe8NV5UKRWzPf8jraxxBj?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf0ae81-1d79-49b9-7ab0-08dc325ed1de
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 21:56:41.1170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LAna1JSTg0JW537C4OI1GzwycODERzj2LCvHzW6/R9NSEs5McG9xhSkxO5/4KyVPJOgiA8tlx6ggcNLW//Abo2aqhGOi56P7bmSjx9pL30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7769
X-OriginatorOrg: intel.com

On Sat, Feb 17, 2024 at 04:01:26PM +0000, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>Currently we have a pattern rule, which effective states that two output
>files are produced - %.5 and %.8. Although that's not the case in
>practise, since each input xml will be generated to a single manual
>page.
>
>Add the manpage section as part of the xml filename and tweak the
>pattern (match) rule, accordingly.
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>---
>Noticed, while wondering if I should add sanitizer support to the
>autoconf build.
>
>A few, random questions:
> - are there any objections to adding sanitizers support?

no

> - would a meson.build be acceptable? Giving us sanitizers, coverage,
>   scan-build, etc out of the box

yes. A few years ago we converted to meson but I think a few things were
not working properly and we never finished that. If you few like adding
that for the next version, feel free to use that as base:

https://github.com/falconindy/kmod.git meson

> - writing xml is fiddly, would people be OK if we convert them to
>   scdoc? here are some examples of the raw file [1] vs the man [2]

first time I hear about scdoc. syntax seems simple, but I do wonder how
common it is in distros compared to e.g. pandoc or other options to
produce manpages.

I know mkosi writes markdown and converts that to a manpage
(https://github.com/systemd/mkosi) and dim uses rst2man
(https://gitlab.freedesktop.org/drm/maintainer-tools.git)

Any of those options seems better than writing xml, so I won't oppose to
scdoc if it's available in multiple distros out of the box in a version
that is sufficient for us.

Lucas De Marchi

>
>[1] https://gitlab.alpinelinux.org/alpine/apk-tools/-/raw/master/doc/apk-add.8.scd?ref_type=heads
>[2] https://man.archlinux.org/man/extra/apk-tools/apk-add.8.en
>---
> man/Makefile.am                            | 11 +++++++++--
> man/{depmod.xml => depmod.8.xml}           |  0
> man/{depmod.d.xml => depmod.d.5.xml}       |  0
> man/{insmod.xml => insmod.8.xml}           |  0
> man/{kmod.xml => kmod.8.xml}               |  0
> man/{modinfo.xml => modinfo.8.xml}         |  0
> man/{modprobe.xml => modprobe.8.xml}       |  0
> man/{modprobe.d.xml => modprobe.d.5.xml}   |  0
> man/{modules.dep.xml => modules.dep.5.xml} |  0
> man/{rmmod.xml => rmmod.8.xml}             |  0
> 10 files changed, 9 insertions(+), 2 deletions(-)

it seems you forgot to rename lsmod.xml so it fails to build.
I fixed that up and pushed.

thanks
Lucas De Marchi

>
>diff --git a/man/Makefile.am b/man/Makefile.am
>index f550091..d62ff21 100644
>--- a/man/Makefile.am
>+++ b/man/Makefile.am
>@@ -13,10 +13,10 @@ dist_man_MANS = $(MAN5) $(MAN8) $(MAN_STUB)
> modules.dep.bin.5: modules.dep.5
> endif
>
>-EXTRA_DIST = $(MAN5:%.5=%.xml) $(MAN8:%.8=%.xml)
>+EXTRA_DIST = $(MAN5:%.5=%.5.xml) $(MAN8:%.8=%.8.xml)
> CLEANFILES = $(dist_man_MANS)
>
>-%.5 %.8: %.xml
>+define generate_manpage
> 	$(AM_V_XSLT)if [ '$(distconfdir)' != '/lib' ] ; then \
> 		sed -e 's|@DISTCONFDIR@|$(distconfdir)|g' $< ; \
> 	else \
>@@ -29,3 +29,10 @@ CLEANFILES = $(dist_man_MANS)
> 		--stringparam man.output.quietly 1 \
> 		--param funcsynopsis.style "'ansi'" \
> 		http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl -
>+endef
>+
>+%.5: %.5.xml
>+	$(generate_manpage)
>+
>+%.8: %.8.xml
>+	$(generate_manpage)
>diff --git a/man/depmod.xml b/man/depmod.8.xml
>similarity index 100%
>rename from man/depmod.xml
>rename to man/depmod.8.xml
>diff --git a/man/depmod.d.xml b/man/depmod.d.5.xml
>similarity index 100%
>rename from man/depmod.d.xml
>rename to man/depmod.d.5.xml
>diff --git a/man/insmod.xml b/man/insmod.8.xml
>similarity index 100%
>rename from man/insmod.xml
>rename to man/insmod.8.xml
>diff --git a/man/kmod.xml b/man/kmod.8.xml
>similarity index 100%
>rename from man/kmod.xml
>rename to man/kmod.8.xml
>diff --git a/man/modinfo.xml b/man/modinfo.8.xml
>similarity index 100%
>rename from man/modinfo.xml
>rename to man/modinfo.8.xml
>diff --git a/man/modprobe.xml b/man/modprobe.8.xml
>similarity index 100%
>rename from man/modprobe.xml
>rename to man/modprobe.8.xml
>diff --git a/man/modprobe.d.xml b/man/modprobe.d.5.xml
>similarity index 100%
>rename from man/modprobe.d.xml
>rename to man/modprobe.d.5.xml
>diff --git a/man/modules.dep.xml b/man/modules.dep.5.xml
>similarity index 100%
>rename from man/modules.dep.xml
>rename to man/modules.dep.5.xml
>diff --git a/man/rmmod.xml b/man/rmmod.8.xml
>similarity index 100%
>rename from man/rmmod.xml
>rename to man/rmmod.8.xml
>
>---
>base-commit: b29704cd448aaa455dba4e656fc0f0d3c686df3f
>change-id: 20240217-autoconf-manpage-warns-0eeb0fa627cf
>
>Best regards,
>-- 
>Emil Velikov <emil.l.velikov@gmail.com>
>
