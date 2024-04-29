Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4BD1E886
	for <linux-modules@vger.kernel.org>; Mon, 29 Apr 2024 23:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432445; cv=fail; b=E4ki6E9EQy9Bc5hBYnX2qDjtK4MJ1BfFqpm9vs2XijwEFVfioknW4VjuJWJvOzkZfPh4hxxU+bbma9xlWw4j75dGg6hgST3Fvob2iLcwMZekZ38ii3iRKKKavGlxX0AIF17B//ZzXrEzENltMwYvfpBzzB1pqsx/w1MJ0VVphDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432445; c=relaxed/simple;
	bh=ez0RD7yOZ0ge1p+WddU3vI7R/xXCWMLXtqRzucC1cGA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SZc5nkMwlJrcwbOJcnNBZqbvwZSl0M0VwDQOuZF8ct/Wzt5flNCrzRJ3sR1BzYgrK4V8R3ykQXA7ydG+fNA0WkM6Mq2fbyVdGDwTzY+tn1yrCw8u+5+mdFWIXNf7Ba37Q7eADjh0UgoVzEgvpte/00XSpLAE5sELiszF+Vlb6VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSpPKQgD; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSpPKQgD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714432444; x=1745968444;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ez0RD7yOZ0ge1p+WddU3vI7R/xXCWMLXtqRzucC1cGA=;
  b=JSpPKQgD11xcl7XZscF2ME+/CLLogbgWLepxhEXXyRB/lBZ+t6VxsSje
   Dbry9LP+hvE/iOzxK0HisZTu+4IBp/OofLSh2G1jmreinOPYUbG6HsMxo
   deIPTzBoBe+nNby4+XKSgK/ShvsH27EeY0XEnQ64t0XFWtytSHHQ9FpJ6
   Asa7iJm6x7FX8p8Fc/27dDF44ciQ3myUEQCe/lXxA+HWDUhgWunMDK3XJ
   7Lqy7/AW4lT8d0ZkHi1aSdY+YKZjsiva6m38NH7xGOTOC0QSx02N4fkwk
   pUmupK7X5q2X6HbkPn7Oxc8nT7q8BYBgKt7uaFog9llIKZXkupar6ySVB
   w==;
X-CSE-ConnectionGUID: kANGQZ76R+KIxHQkAjPSgg==
X-CSE-MsgGUID: 7YMqcMqqTwiph5fofkADgA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13907855"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="13907855"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:14:03 -0700
X-CSE-ConnectionGUID: md2OfdpNTmKr793+6PHDPg==
X-CSE-MsgGUID: MwtlXO0wQCemxKP2+Tlpdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26339091"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 16:14:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 16:14:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 16:14:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 16:14:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WweIbP4GYAwrcoo24Ygy0YBbMZUyDcrsgLaNmz66wAnxuTcybOwaxIih8DTM0qOh0chGM+f37Q7s8ZShtuvXHm5wiB4VPX0+PgcNs3878lz3gnDeiuklwXij9Ghz/8d1nkXmetxpODHsROWbu8YsZP843YmbwzuKqrJHjGmQY/4YwGM8kLz5XOQtZEUkWyULYGPtJCXHA4BWRbu+2uHsGC522cYZ+yU442l0EeuaeI1dkOfV0YU8u8wy7Pa+KCgk6iBiS7/qo4Td9hNOTmIgqZxr4r2ZybAv1fiAjP7coOOOJM6QuCiwO18UtxSI6zMi4lS/mPO5yAqzCb7lXyLayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6fBR0ipQGeY51we3+2MOsxpUSB248j46UYshKp3sHU=;
 b=fpyu5rBB+YFhTq2ok8PirHKuSO+Q3xulfkJ05V0b2l/Nf3ArwtSy2/bNHBzaG4LetT3gSAY14J+7tNBrc2IFmwKJNay69YCEJh+9NkarSrSwz/GedJ5bwqiysGgMicqg+hzEMq/w0lzqttlC17OO+9Bo4ok+wKvekgeB05HWq0QXJsbPeWgyD4o2Xz3B90g95kfptnVvpDMBmgFJwy46v9cu2Sc6UIBL5siZwMr43BYlKorlc4lhf1KVXclbO8YmyHkpCjZQ3dOc3j83TeMpjFal/SUcYOf9iFhSeiNIqvbwN+PTC/KCG8MU3qDDadyQac5WQxWBCanewzjtL1RMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB8089.namprd11.prod.outlook.com (2603:10b6:8:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 23:14:01 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 23:14:01 +0000
Date: Mon, 29 Apr 2024 18:13:56 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 08/13] libkmod: always detect the module compression
Message-ID: <jdkkaqahdvpdzpvjrhm3kz2bl43yvzkvjvoeq3hj54fg4wtwn7@gsvh62webj6f>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-8-06f92ad07985@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240212-decompression-fixes-v1-8-06f92ad07985@gmail.com>
X-ClientProxiedBy: MW2PR2101CA0018.namprd21.prod.outlook.com
 (2603:10b6:302:1::31) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM4PR11MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 544af353-d978-48b9-753d-08dc68a20dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qiK7gKxQvmAl7ElzWfRM8nEsrQkvD2wEq3FUPGTCcs2SrECkBTghHsvCLNiD?=
 =?us-ascii?Q?Wa6c6LyIM+RkAL7qzU8RSz0XrYkLIsaMmaojwl6hk9DMgjjYEVmQxFYcHVKR?=
 =?us-ascii?Q?jxnSahm1TPXUrfAAfU4s8Mhc5SZcIUx9i5m92tWUqF4pkF7ih08Qp3cgxggc?=
 =?us-ascii?Q?dDpt10jq43owxyduMOqprJ4xXKujjAbO2hZ2SJRVLOJfl4YsidDjDT4PBGgL?=
 =?us-ascii?Q?fFvDOno+1Ylm7IPpbSunOJCZcVTrWxC+2mfwXtaslzaMmmmKQlsAP8DkPhzo?=
 =?us-ascii?Q?3ZVM58tCw4XAgrZwkQwPwSAxF2IXFNhQZ/E0wpKe/+hRccLGcezGhjtIqoKW?=
 =?us-ascii?Q?EEQiWF/0gom8TFU6MQ5RRApocCPr24+OKuZamBWqV/9hjHuSM/noYowuvj2B?=
 =?us-ascii?Q?WKO7ahn0QvTuzph5Zr0ejR0RmvmxPtwiOqsPmrZKR2nw+k9HtS1sxLdo1ou2?=
 =?us-ascii?Q?H5eIlaldN1ofnBysLEDls43g5ze/f/BHcaoGYRl8qrKheYJD3GfR9Atabt8w?=
 =?us-ascii?Q?v9IkzfZmS5NAzMOzOtrFzvzy3yE66KOgK4PPjbn/zGqbDTeKOZxTZUhs1NrJ?=
 =?us-ascii?Q?a1V/V0BPePm96kT5h6oqd4i7rNDLjwLE2L82Ml8fEhnflIAh9P4MVYJLv7Cw?=
 =?us-ascii?Q?M/hM5VnlBzWQDO0pS6QbKg3nuJMP9roEXrJTiX2BhW4dS2mVmK6ZZ77zshWd?=
 =?us-ascii?Q?HZsmTFT3nnxUSDc1ep0V4pX8sWsAzGw8Obv6YrmwrmTn4vG26eEWaQoTRaDQ?=
 =?us-ascii?Q?UAeATbJxuymPzTwbP+guNWCNEjt2eL6xejsakyHvKHfCMHSZGNMLCnWYMxQ/?=
 =?us-ascii?Q?8Bgt0qoFKtgoJtL2fXPcNqUxIMpQ+4oHyb9r6GX7h274+slRR++K8dtex6Qn?=
 =?us-ascii?Q?uATn1+K0952BXqtdIpgLrTKVJZ++S4UiEAbi35JElEmi8mv7Srg3uGSv534I?=
 =?us-ascii?Q?tBTPPvakcjIz1WE+TMbHvkz3pQmjPWLouei/sXDnNGQYZMjKxVU1Cj/4VRpE?=
 =?us-ascii?Q?QHT+9NZ4+IF1A9FWX1gPW6h2Vdxu36rLpvo5DSAP69ruZXWiHNfOE6N0kpM8?=
 =?us-ascii?Q?AkHyGmqXgB7qH5Agp7y3aBhNnJqRmw4V0e9V1rRM1Y57HW8o/uH8fvky0wiL?=
 =?us-ascii?Q?U68A0BooFawvo006W9HHPfQL6L/CTtWWRz1WfkbjHlD/cNGbqW1/ZOBHPuXK?=
 =?us-ascii?Q?i31c3jynm5XXPu+E7/4QcgxqQo1wp9AamXgJl8xIw0ZlLaO4vLMrQtY3eq5+?=
 =?us-ascii?Q?kwOmY4+0y7tyoc7Z5fDzS2QsYk9OQ/KIMBMWrz6txg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dzg62ctZpK222lmw2+YbkQ/xNetzYDNf9Ck5jk/GQ2AgHsavNxaMSZ53hInr?=
 =?us-ascii?Q?OjWDy4y++CX4nsGW0Zi2wmjv8uVwYp2wUSAnYLBkXGAW5CoWht0V10Upen3s?=
 =?us-ascii?Q?wLDFLeUAFdQf+IDpWz+W3pJB9gdmUEm3fRTJk6BVN04TRnOEdeFgEnH14wts?=
 =?us-ascii?Q?8ij8oPFUzciow7r68GCFlEU0Uli92j++kRhUqp5qgznI9S4SfzPqMQEBtZan?=
 =?us-ascii?Q?zSSBordYNrD3DHAooTNC10jAY1VeYwqQbN4lGRpM8bk9M0nPViT6P5fgcynF?=
 =?us-ascii?Q?ECclBdJS366PiqPY/3+j7uYJkTVpS650IuydVm1u/CIzOl2X7xH2RaYZK3fr?=
 =?us-ascii?Q?voD05H625eN7DKlsRtBf/Z0LtfkikWpY0QBu8OYXVjLKyFuwp29sPPQAr57F?=
 =?us-ascii?Q?TSvrTwtcQ7f+AJo5v/F+FwA8B6ceSxY7OVXdn3NqYjDm25fIUNkdZAlicuyS?=
 =?us-ascii?Q?TFSBkhxhsG+4Y5zq/15L5XlmRIRqvoeqcwKTd3WBBEo+6nWgtz/qPwBoINpq?=
 =?us-ascii?Q?qGDQIBztDDSHe4KOR7P9mW0eJjjoJ71IQk3LtF+a3iDM5VIdmHjW7JFPG/PR?=
 =?us-ascii?Q?d61/PnjkeOe5q7bNaM/1EWNBAfTynxNN4Uc9eRVEyGdnPkgIrGWxa7HCm4HF?=
 =?us-ascii?Q?h0mtSQOc2IR10+cLADG2UJjsS5ZxgU7/duMSBRs8/tDYSkV2S3Dcha4ckcIW?=
 =?us-ascii?Q?cCt9lkXALCm/uoWToOvJaV5AXkvaVFGowQstYvBzcn2uyza4bbHQ8l5zxLTN?=
 =?us-ascii?Q?vtJk5fR0eirEUn9pcDE64v68+/qR1nsrf2QDST8RQR0cNtIyRy+ruSs2wnXA?=
 =?us-ascii?Q?dFDd8WgSNhG+cF9UHTVq4MAG+5bKthPJovr/2jnsK5h4hIE5FFn3y56sJ7QY?=
 =?us-ascii?Q?IZnA+DatlGMGWikuC0xvZiNA3jQfj4koGQVQ7B7+6O0n9KECcPB+8Fm+sc1Z?=
 =?us-ascii?Q?IolkFc/VTGXgTlBznAeATultR9EpIYLlVKbKNAVUbmAVEOXhRSKDV05b4wHK?=
 =?us-ascii?Q?Qe48QKiWSKNBb0mZ+yD5afIH880dJTkLZKS/xu2HMKces6QfLmKWIb8RaAlQ?=
 =?us-ascii?Q?ag7gifRxFhP+jOOA/mS2rgjiZu44YChWrmpG5we0Z7qB5RRT8oSnV6RzC9jP?=
 =?us-ascii?Q?UrhW48LgS62CNZpE55MPtU6A7ADWKwDVL9uBOkceKIECuB9W5XTGNM6XKno4?=
 =?us-ascii?Q?TuIl0JffTWQId176EVRYBHhn6jQMICDita71iU2JxyLkzpUqVB30uxgVcyoJ?=
 =?us-ascii?Q?XfraiK449aEiBeeKzjtr4EVpJ/OGCmAj1Vh3HcD8NRkDHBSbz6csO9YF2207?=
 =?us-ascii?Q?4xXCcJdEQQA3r6wDPFE70SS6Zy2YPUg86NbrJcldhJ44XbhcOXRMf7uT4p4e?=
 =?us-ascii?Q?kG0d4K3oAQ2H1ZpyAlL2m9/1UWxvLUcp1RJP+YZynqkrxwH4zDnTwOHhu2Iq?=
 =?us-ascii?Q?Llhu2rPDCrpPnqalmJ481UxUqqOlnLyGXYQQZo3Sshs/opKWAbcx8QZ3EMEY?=
 =?us-ascii?Q?gOO1xYfVP4yIEbecgax3EvNEjlAPalucWdeKUxMxoufO0KCggQLI+xVsUG2E?=
 =?us-ascii?Q?pdLif+11Rdqliyfdd3hUv68Z11dgXAWRruyKp+c22FEV4Vmf2bxEa5NIjgny?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 544af353-d978-48b9-753d-08dc68a20dec
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 23:14:01.1211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEvmNVSu5GMGvhVrG0FCiULMGaubdsRV0diYimSVEYzOIM4tOzZEABvmQ6lA0eFzZCAbh6Suro6hYEsGvL3yQ6cUNfhDGbmu/zOSi3tcfHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8089
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 05:23:09PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>Currently, when built w/o given compression we'll incorrectly report a
>"compression_none".
>
>As we reach do_finit_module(), we'll naively assume that the kernel can
>handle the compressed module, yet omit the MODULE_INIT_COMPRESSED_FILE
>flag.
>
>As result the kernel will barf at us, do_finit_module will fail with non
>-ENOSYS and we won't end in the do_init_module codepath (which will also
>fail).
>
>In other words: with this change, you can build kmod without zstd, xz
>and zlib support and the kernel will load the modules, assuming it
>supports the format \o/
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>

nice.


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

Lucas De Marchi

>---
> libkmod/libkmod-file.c | 27 ++++++++++++++++++---------
> 1 file changed, 18 insertions(+), 9 deletions(-)
>
>diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
>index 3a79464..b69f1ef 100644
>--- a/libkmod/libkmod-file.c
>+++ b/libkmod/libkmod-file.c
>@@ -174,9 +174,14 @@ out:
> 	free((void *)zst_outb.dst);
> 	return ret;
> }
>+#else
>+static int load_zstd(struct kmod_file *file)
>+{
>+	return -ENOSYS;
>+}
>+#endif
>
> static const char magic_zstd[] = {0x28, 0xB5, 0x2F, 0xFD};
>-#endif
>
> #ifdef ENABLE_XZ
> static void xz_uncompress_belch(struct kmod_file *file, lzma_ret ret)
>@@ -275,9 +280,14 @@ static int load_xz(struct kmod_file *file)
> 	lzma_end(&strm);
> 	return ret;
> }
>+#else
>+static int load_xz(struct kmod_file *file)
>+{
>+	return -ENOSYS;
>+}
>+#endif
>
> static const char magic_xz[] = {0xfd, '7', 'z', 'X', 'Z', 0};
>-#endif
>
> #ifdef ENABLE_ZLIB
> #define READ_STEP (4 * 1024 * 1024)
>@@ -339,9 +349,14 @@ error:
> 	gzclose(gzf); /* closes the gzfd */
> 	return err;
> }
>+#else
>+static int load_zlib(struct kmod_file *file)
>+{
>+	return -ENOSYS;
>+}
>+#endif
>
> static const char magic_zlib[] = {0x1f, 0x8b};
>-#endif
>
> static const struct comp_type {
> 	size_t magic_size;
>@@ -349,15 +364,9 @@ static const struct comp_type {
> 	const char *magic_bytes;
> 	int (*load)(struct kmod_file *file);
> } comp_types[] = {
>-#ifdef ENABLE_ZSTD
> 	{sizeof(magic_zstd),	KMOD_FILE_COMPRESSION_ZSTD, magic_zstd, load_zstd},
>-#endif
>-#ifdef ENABLE_XZ
> 	{sizeof(magic_xz),	KMOD_FILE_COMPRESSION_XZ, magic_xz, load_xz},
>-#endif
>-#ifdef ENABLE_ZLIB
> 	{sizeof(magic_zlib),	KMOD_FILE_COMPRESSION_ZLIB, magic_zlib, load_zlib},
>-#endif
> 	{0,			KMOD_FILE_COMPRESSION_NONE, NULL, NULL}
> };
>
>
>-- 
>2.43.0
>
