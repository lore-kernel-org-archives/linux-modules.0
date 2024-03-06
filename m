Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF8EDDA8
	for <linux-modules@vger.kernel.org>; Wed,  6 Mar 2024 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696424; cv=fail; b=LYp7o0wZvWGzZ+OM32SOi0o5gfmk2Ho9x6hz0ePHE7r3ieWB40qoGrcHSFwjKRRiFf/McF7tp3IcxZJpyrcxS9ji6SocNoh9NY2y43a6LnLVsborsMPVec8xjrvx/B3Ka40uoPbfokFIJkopLcIkGRj8hJru5FSw4kdVUd9jAVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696424; c=relaxed/simple;
	bh=bjXzo4rPYsPMHrRWAJFIyVE0WcskQouTA5m6HPjufZQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=sS/jp3QoVgWJ5sQql61SPW7rqha8qgnHaPuKwgyL/nHYuiXrmBKGV6gke0lPhvF1pg3FvYM62W3EPSIlmXtXfi/ztfoBnvk8AL6bkLJPysGv8kD7aUb8nBuJe+SQteJNDZW4oBaaDF1mtT19L0JvzNjlSzs2oiY/J1JJnVbF5pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9spxtKf; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9spxtKf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709696423; x=1741232423;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bjXzo4rPYsPMHrRWAJFIyVE0WcskQouTA5m6HPjufZQ=;
  b=h9spxtKfS0RF4fnuqeafZU9sapjVp8HkINUzhAWZfqNWySQ15f+k2ZeL
   xsvR2U98xkKaqDt+ewzmJxGfye4mdi7p6QmQ5uVFuVWHFhUs6XVR+oJRF
   4OcC6U1/3so6y+imUMsnhoD5tuhH+eAru5+sUdPye3F12bfQvK+FqD551
   O2ElhvBBQYveBoa37J/EeI8Glarp5vmLtemSl4m+cLLiqH3Pir1k/3Cx9
   oqfB49SuM4t2EQ6F1SKm5xqkITTbrlo9OUpEHdrvzuafnzH2SOMoeVCVc
   T/NNDWhlHExCYjz3IfdkSV9dfGtA/JfFp2U0BxYNR5sMEI1V5N5xTzAmU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4405339"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="4405339"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 19:40:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="40490649"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 19:40:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 19:40:15 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 19:40:15 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 19:40:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyRZyGTC2a0SCfR3LHkS4zJZN7Hu/r9jR62XgdBqHnh8UljDRUup51+YclvCZtXO55Bvt0tjnut6JtxCoic8fI7JhHMdaXjiKqFLn87NfiVac8zg3fTgmnr6v/TFQD5JpxZpd3pI2Nka9Z3AkvifFHLieAtoyWyhOaAYFlx8gXslCxLylLa2lLzZM4/YPk0NLPxTj4n9P8dO+iFa6P5ioPZTJGCI1nXNBDLkz8zJp4TmIU9WKUUcOIUeWj7XGp4fy6b3R3SsN/OvGABznAqOXW/Up38E1OBcyEIO45Vy9M6s/nZUKTRBQYuu94jxMIOeLuWqphDzSjQ15LFDKrAPeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0krigWonIuWqnZGQ0NoOzl3w759pbOA1AXtNDIV3to=;
 b=HPq0RdMwY03Pbuv3DmHZ52vd40i3q+0j0MIcsfQZzMIbqnSPQbHGyXIYij1U2qk1G6NMQvpd9VFJzdiUHFwNi4zLak8TRiyyXDF3T0HZE/QD3SWBudpz8Wo9H//wPV8O8CLLGzoYW7WgYdsjRezKft4fNa0NXwwWCp6CDc9bNGLfAOtGWX//UFR+7NapfgrC+Y7RQd5c1+vLwPhTR/u7WdDHIDEclTLyg85Of0ZOh0smxnsQ+8pKjDHSs3GJIIyD+A40SgXQRLQzsySfd1h1LupKOCLcb96OdTFwXwUxBk3aSH3tfm+dyahDT/E8W+bhTbyhHk69Eqn8J2uFHPYmyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CH3PR11MB7842.namprd11.prod.outlook.com (2603:10b6:610:128::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Wed, 6 Mar
 2024 03:40:12 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 03:40:11 +0000
Date: Tue, 5 Mar 2024 21:40:09 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-modules <linux-modules@vger.kernel.org>
CC: Michal Suchanek <msuchanek@suse.de>, Emil Velikov
	<emil.l.velikov@gmail.com>, Emil Velikov <emil.velikov@collabora.com>,
	Dimitri John Ledkov <dimitri.ledkov@canonical.com>, Sam James
	<sam@gentoo.org>
Subject: [ANNOUNCE] kmod 32
Message-ID: <lsycc6ghy3vniv5c72c2jwms2yclyy7hkvez7twqk3sh6j2ufu@uhvvggs27tcj>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::9) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CH3PR11MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe2ec25-ab22-4e14-76c7-08dc3d8f20a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Si0JxUaTjatA0Bjd5b+dvs3bSIUgTzsut4MLxPSM+YhC4Tht2HDqd4mKmr9q+rYYBxE8vqV/YBmwzhkTxJBKd4F6MbM19ZIU1Fbyo08/aywltL5ZW/eho50gGYdbo+4fk/LVQwYdpfOkNURvKcy4UHPRwqZ5POMsp/hD+FYqGlp4iwiDemPE5fPcTMX89m/OkOKRSO2LQubPXtpnuJIKQdcwTQv3vtTcHWQB0NIn+pAQlKsBGveKEUm1QbEfHgXs0YzE2tfZ6crq7xgDkLFnXHWaavF2DRHdKf2PbQZ79qU2l3taNQEgqzvK4PVIJGWUpfr48d7UaOnZvtKHewXByW8K1tAcMrUnLDVWtbmEucNv2Ij/VIOsfr/7dI3jVQzphrh43C72BJl+qwLMi6dF1UKzYNdV8J+eLOwM6yQLil+NcnUFpdk2lQamIHApAAMBpVykzlwYL15XUeWpwmT8pEjYnbjekEn8qtmIuAeahaD4usH+JtZ2By2nkg9vyw56d8z3dZbs9Y3S2ybY8vjNvMITikjaVxpem0hoAJcABXurM3qH5DpT52/CutEQE/Rh1BXV7i7l3wuJ5f8Ob6BRTC9O3uhFTug1ECPSCZKdCU7uZMnTYPSkbIXFgLvGvfMT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lvhE2EQDbBl5n4mUWdoJFgHr/rIPYm69Xvvea2Mi/GvIBFkyuxaANc93sz07?=
 =?us-ascii?Q?ne8nPYSV5Ne6U56oVOuAq7tKHe2XZMiH9jL8wInYW2Lm17/+8obDNoVkuPhY?=
 =?us-ascii?Q?QZiH9t16y1gdQz5egBB8WsgPsHg9F1SpuKMJOoLlVm/xerAPBQ8jhGE+J5fq?=
 =?us-ascii?Q?pzxXfdG2DqP/C8oKPDp4g9X9zuwFpW4GsXiHFgT4gA+sFlEAlLfu/E1slbVA?=
 =?us-ascii?Q?cDxCg1x/pfAP8XYlhWRghC6TpOWG86audx2Y3Dgxw8E/mBOeyfCJK9t/NDNq?=
 =?us-ascii?Q?Yo2LbrotnTANtlnP5vGE9C5SEdXLJOM1kEty0D/GbOmqXS+xg1KFTFEJjqAT?=
 =?us-ascii?Q?NGBGjxJAXdluHOH0QOJ2FdwlPP+JimMe6rlpLq2O2XkhWvcjQD3ez9aGRmNI?=
 =?us-ascii?Q?W49EYEw1xomCiaWq5kEBP6VzJfe4HkQQhA+X73DgcU5iD92HMyDXTyQ8oB5t?=
 =?us-ascii?Q?DqsA+ZiuXf60V2Y0fAqpwW67GMlqTutHij5bmK4Qo+OjubEvgHOgaRcTTLz5?=
 =?us-ascii?Q?2pQJHFBbU9Y5uy25RLXD0XyVu7JkfFw2uCOMjrhR9eR4aSWidqKNgUaxT2jw?=
 =?us-ascii?Q?3uNd947AmGQwdmUCeZOsynqzevrRSB9Pmt1STD5FO0sIZej3Ek/vf0dFIye5?=
 =?us-ascii?Q?55T6TqIyLJmWNsW7RVV8Fr9MDRb3fl+fulf0zWynK0Im4zlhtxsZtes0kd5l?=
 =?us-ascii?Q?uEvGFHd0KYmtF86uAkGpykEQIpbRPU6QHA4o/c0raRdA1Qrdh5X7w7lQ/k5S?=
 =?us-ascii?Q?GS/SjyaNyk5vfMTCKwPPZs6gFA3P06a1s7PYm5arExxQbOdCneKsMnpYN0Tc?=
 =?us-ascii?Q?f7H0JF73eVUHVBfIcb7pM4lJ0NSPth1mGH7sDVAM7AZ0KQabD+t4BRctCk5m?=
 =?us-ascii?Q?3YSRTjrZK0t/PB5/M5yYwVcchyinPWdg3MwXZHhzWLirNSGA0SI+d+/h5nPH?=
 =?us-ascii?Q?0G2tcGgBTHlxoFN1sAHwe4qCsTTBCL+uNJyloqB4uTtK6w6rxjhZHAV4ZzAX?=
 =?us-ascii?Q?NSNDQmV6pGQOHGrKzVZxnJXDvCoL90FvlnQpaUU9ePNOSmKTRWca81tBJE9E?=
 =?us-ascii?Q?JcwYhpcFs8/sRHqfKZ+jHrKRhK4nf/1arxn5tR10rJL5EYYnecHkBUtzJePV?=
 =?us-ascii?Q?3rei/KUZoeCfrmWqPeVlV+zOOiG4wEHz2lwlJbROdbOQJU+QFpUCZOgz+3xz?=
 =?us-ascii?Q?HEj2LxUuU5/S/oOjcwsjNj+xMO+QNYKzQUzddY1ifqV/pPt2+yT7xeXZOB8P?=
 =?us-ascii?Q?rxfiUTmGV6JWyGJGU1mUoxbhdL3wB6sZEoC+TH7BaYrGYB2DeThRLuhxO85A?=
 =?us-ascii?Q?C05U5zFSS+O8+tLhDOBLgVwRP63gPtVbd2LJuH0cQAM0DYIHw5WvDjjx5mU0?=
 =?us-ascii?Q?iVV/ntAAp5YwYk0d88qxP5pCySI7VphC0II05wLV5HzenVFScsLxVczkx4Sw?=
 =?us-ascii?Q?gW3cngkNMTiUHeoq5H512iYxkQp6rgtEDJP8TIkSKDdUj5JWDsGzJUqHeqzu?=
 =?us-ascii?Q?zBkI5NSTqdOIhOVGCHb6e/baOg3sN2qRVc/17UNHdBVvsY3KqCA+W1sLa/QD?=
 =?us-ascii?Q?CUQ0ax07h5Gok8dqRYgFOc9tGcP1lmi4khfVK/zZOyAxZIFIGeSzTPiwLJav?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe2ec25-ab22-4e14-76c7-08dc3d8f20a2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 03:40:11.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLkfpfpFDsjyxRLIjYNQGXq5QbZmO+ZY5IWoG+alh3f1APyr9RdS4wV3tp9RPRwaeK/tCN3k0krUO3G31gdwnexER3ZjfI9lV+vZWsnqR44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7842
X-OriginatorOrg: intel.com

kmod 32 is out:

          https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-32.tar.xz
          https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-32.tar.sign

- Improvements

         - Use any hash algo known by kernel/openssl instead of keep needing
           to update the mapping

         - Teach kmod to load modprobe.d/depmod.d configuration from ${prefix}/lib
           and allow it to be overriden during build with --with-distconfdir=DIR

         - Make kernel modules directory configurable. This allows distro to
           make kmod use only files from /usr regardless of having a compat
           symlink in place.

         - Install kmod.pc containing the features selected at build time.

         - Install all tools and symlinks by default. Previously kmod relied on
           distro packaging to set up the symlinks in place like modprobe,
           depmod, lsmod, etc. Now those symlinks are created by kmod itself
           and they are always placed in $bindir.

- Bug Fixes

         - Fix warnings due to -Walloc-size

- Others

         - Drop python bindings. Those were not update in ages and not compatible
           with latest python releases.

         - Cleanup test infra, dropping what was not used anymore

         - Drop experimental tools `kmod insert` / `kmod remove`. Building those
           was protected by a configure option never set by distros. They also
           didn't gain enough traction to replace the older interfaces via
           modprobe/insmod/rmmod.

Shortlog is below:

Dimitri John Ledkov (1):
       libkmod: remove pkcs7 obj_to_hash_algo()

Emil Velikov (4):
       configure: tweak the module_directory help string
       make: install/uninstall tools symlinks to kmod
       man: silence autoconf warnings
       Remove unmaintained experimental tools

Lucas De Marchi (5):
       Drop python bindings
       ci: drop travis config
       testsuite: drop mkosi
       gitignore: Ignore *.pc files
       kmod 32

Michal Suchanek (6):
       configure: Detect openssl sm3 support
       man/depmod.d: Fix incorrect /usr/lib search path
       libkmod, depmod: Load modprobe.d, depmod.d from ${prefix}/lib.
       kmod: Add pkgconfig file with kmod compile time configuration
       libkmod, depmod, modprobe: Make directory for kernel modules configurable
       configure: Check that provided paths are absolute

Sam James (1):
       tools: depmod: fix -Walloc-size


Thank y'all for the contributions,

Lucas De Marchi
