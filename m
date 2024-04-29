Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9401E886
	for <linux-modules@vger.kernel.org>; Mon, 29 Apr 2024 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432406; cv=fail; b=SPFlWO8b7XFoXA6XGcpcPV+hpdbVh3ZR7MGz/tcTzSFJNslNefLaBZcNFNE8kkpBpAXMESlKAEvhpjlXwa5q1xTHu6cja14hC5/dyI3Rr/A7LYy7HHJmnGK6ssvze7BdzrsLa9HdJakox5ls0tVBXYV+1wXu3AWiajH+mGT7rrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432406; c=relaxed/simple;
	bh=jbhWFGNt9T2dEGDTApip0BKdzguIQMo4KeLyT5CFWuo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QhtNvklVv6L1DqQ7fKIyiwWlmqKS0T+0MI29BpKI88SwDfMCUK6bTM5NjrsS++R3xRyCCzKQSzXPaqPC4Uz4vyH7zK6kCd1+cugISR+8fApp6zSSraMXK04hIkm9pGYBqPUMdilOhc3/IpZmyugXe8jvFKEIioAgdjeIvKGE4XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WY68TjOp; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WY68TjOp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714432405; x=1745968405;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jbhWFGNt9T2dEGDTApip0BKdzguIQMo4KeLyT5CFWuo=;
  b=WY68TjOpOKam3U44CWp0dUVv4hsmXmYbnnqNXkddL7DyswzxX9ZpPOh1
   l1MoX2kS4M6rsasDCpKJZhEZanXv0bqQj9cr1ZjqAzMWWdp0K5IYtESFd
   HDY3hWmkXdaEoLT7jgeQEn4MXEWdDVHlrtrD4lJ7JPP+SvmcYCHSftJX2
   sI0OR3XHb9A3hOE2+RTfRQtq2tEZxxy1hZxlIVGzoU/ghm1dqUocDrBAT
   l+BPgW2zwLk3ASO9DA3cSgZBwxI2a1ECmB2cqztcVuQzafxxyGd137nbU
   WJq4eOmYNCUYIdzWoeAWA+AvCcsnxJ3Npg4FkmmCHo0b4SM38fyYfgBO0
   A==;
X-CSE-ConnectionGUID: A4lFqrwpSmCe+HbKpZxBSA==
X-CSE-MsgGUID: H+vrvCIAS4eQZWRPKxeuJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13907813"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="13907813"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:13:24 -0700
X-CSE-ConnectionGUID: AUzhdMbCQPW6klf9Vpv6+Q==
X-CSE-MsgGUID: YuuJ3WEGSY+b7oUrBz59Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26338726"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 16:13:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 16:13:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 16:13:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 16:13:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4Fwmzv6XjmExPNzYrR8cZMqtKf+/pabXmcXha44tnGCmBxq8vQEtDyMQLrCjnVcP/grRgO7KrCBvhe2jHTsaq3IvbXWDuQh7mmWqp3oF/WrcPPU1zIgq8kXdJl7GuHN0bF7wNvRg2G7sWh5t3bolCSS8FKGN6kwEZWMlRKTkOKCDcn+DjtUdPTI0Yjhh6INPr8sF2M9OSCEeMBwvKqgnukFil0j6IOKz0FsO8Sa3+TIonVQ9nYZcR9jC9F9oi+J28faIHjpJZosfH/oD3803G2YLb7EUosJnkhdYH4W4mdfqARcoou5crKyLufvGGNlogpPSppMQJUB24eRMICmqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijcjU6KMIOiDoQS16EBF9/k9X4hCX0ThPrbqRqnHAsg=;
 b=l++zINDrH4dTNCu3iRLjW5iOFx7M5Cs1WaKvSF6VPUlC7Iy/OP7PrbJig4BOeFzLdgIasQMwj450asdoo3iODZsq5MTkusR3ztk9PuQ9umazCvdKWe+wPMgEPrRM0hRbvwa6F31CUaI79PhiZiMLE59uXYwn+pUTkl7pBAJpOHj7ZEfVeI32RYtmUxEeOgKaAvbI6gjSOhahCVoBNF7iyFssoTq8IYSsGzQqnr4Vp6acmTSHZNG73FHxHtnCoPUpXkivtzje57XvZ8csHrMbTWlwrB03j8hPSquSYZPXoxMqeAYAG6EARe1c5x9klkIHd575QDviYrWfFSbYjIJ2Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB8089.namprd11.prod.outlook.com (2603:10b6:8:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 23:13:21 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 23:13:21 +0000
Date: Mon, 29 Apr 2024 18:13:16 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 01/13] libkmod: use a dup()'d fd for zlib
Message-ID: <hwqlrleneiaikmrungxsrc567n5rjbbjbfclth5hvcktepkb2p@bi6zmbzfc3de>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-1-06f92ad07985@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240212-decompression-fixes-v1-1-06f92ad07985@gmail.com>
X-ClientProxiedBy: MW4P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::9) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM4PR11MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ebdc95-fc89-4885-53e3-08dc68a1f64c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qfA30dy+Te6eTtArtAz9hfOeAewDWhEdhhtdTamFB/PWactsTAzOBKgj4Mt4?=
 =?us-ascii?Q?nD6/tMQKicpz4wl+IrwZZ5ikHKND+6J/0JsF1LIK0gUBBgBmrZrohpiZ/utI?=
 =?us-ascii?Q?Z/8gyxtzb0bHz+9GZXievI6j4VbkFk+BD2iILoQCtB4vYj1HsLbAG+OUpyu5?=
 =?us-ascii?Q?1n5vDnf0DXXvbhfwvKUWSdgblXDf4CwKOrfX1BqG3O0q4KCfvw+naRkSv6qY?=
 =?us-ascii?Q?o1HLlOPDRJtuyu0IESIvlQ2DpUP2DbqIUANyZvQ3UTEZ2KCCrQgm+E0XCC9+?=
 =?us-ascii?Q?3A0QaII8Dg8g4GEUOwH2rAExLVmd8hwFZKJLd0emeohqKDi9BweEqaw99LYJ?=
 =?us-ascii?Q?QjLmmNKto+teEKbKas2nkrwk1kZqMrZr8mfdJLfoPQDCK0SwUL0nHp2szv3C?=
 =?us-ascii?Q?u7T2FM+hVFukurdHHuqbKaD0IwrjoqeTenah/sPzCDL2i6LaNbThB0q2/BY8?=
 =?us-ascii?Q?3Eo3vHS1yP5G+JHkPbQn86cAdg0NRoNVrtiqqWXKXR2Hldxl4+MrHpWbXQfB?=
 =?us-ascii?Q?I9mHxKc2tBeSLFUglkm+9Zehvu7CGCl8XjhfjIhLEoV9XVXoXsrtUpjZo4MP?=
 =?us-ascii?Q?AH90RF+SvPySCAzmrCqTHFMr8qz8L/6HPUOgisbKFQS6MM+Hh8u9E9tXUbc/?=
 =?us-ascii?Q?ZKCyPSUBGCisWovBRN9/XGWaXI1Ov9bu/R55p96amCvipicvT1neI/Z9CM6E?=
 =?us-ascii?Q?qOZrsFDElmmB4eJ3HRpcGJGOkKOB+mMpV/zq23YxhLm2Z7xHJprWrUCMOxYL?=
 =?us-ascii?Q?i+vjmmjpDhqiHLX9dZwkng9WiPGVU6DaFgk1oJi+rl0MEFyA1O+JuLHCdMGK?=
 =?us-ascii?Q?RWYXGlXo1gH+tQavhuloMKoakqCE3ERS8GQXqaA2v2lw8fAbNb1ndWhl9IWk?=
 =?us-ascii?Q?vd1nGSKK/QH2eEZXqPFxTVWdI1cl2q5D9PyX3B/Nyq1akP+bqQEmMNqT6Hvo?=
 =?us-ascii?Q?zyEmNo9fIrqHSnUmm2GP5BzCvWNGx2WoOZAUlXeTOrU9XCGP+E/fP1HGveBj?=
 =?us-ascii?Q?23+RwY6bcO/UG3KPZluMh1PQG6vg/vx6Hoeck6mw9+1IpVUF1DVzeLP2D/g5?=
 =?us-ascii?Q?/AIB06+RnJPIHWzOIW3a8KTs2KTXcetdF1fwbMfSI4NCVF+XHZxAuvUmHY0Z?=
 =?us-ascii?Q?evOtywFaVThRXaTgTThEj4VsBABUlzjNSJXqJzDtgPgC/aqdPAcfx4Lkp+oZ?=
 =?us-ascii?Q?mX1KlwbK2cw+dNe8/lckIEXR15jzfAmz9x/g0p3F8/AoXs3LDsxQEBLMDJGx?=
 =?us-ascii?Q?HaRJ58VmoFgdC707W88pjHzNtM+5dmCUskA/ycpXLg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?13R9uM8x3rzSrpT8pjcxMm5Xk2ogQTpeAmZzpZdOvCZ9XtIjQohlepHW2fHD?=
 =?us-ascii?Q?rdH6eWbDcJCCxe8qXJH8KF7tI4uTL9iaiDoT80Y6iE3CHvo4YEK3ZK7bGfmv?=
 =?us-ascii?Q?qrbTc3xOyyHr8FL+dJ8KkStadssaAFM5+VteFYjjQtvkOcPhUJPmmnpzyhGx?=
 =?us-ascii?Q?5LC/dNo45qoQhhtErzqWeky3q/Ep6XuNVWhg4hNrszsxZ3UHxX8vMNr8sgJB?=
 =?us-ascii?Q?Lx0PHA82tCDV3jsb64JLQ1x5Irx6nwdYtGOCcX5vqdajsbYNl3joH6KGZ9bj?=
 =?us-ascii?Q?4mRbVr3Jwk1E0QtIYsr2kfpBj6LWyWpqI6jfRpNQ3srioHyt3Zxnc2gUT4xV?=
 =?us-ascii?Q?SphtoodinhsliGAWKxU5zjPo2x+2Y8/GsyZnWoL5q+oOcwuSpse31XHMjd92?=
 =?us-ascii?Q?yTqtqoHNedj6ZV859S6ODEMFkn9lV5W/WgZfW2KIq6l8deGsglVFQ1+/vG7H?=
 =?us-ascii?Q?jhtjvwNDHlAV4m6//DB33TCFMH/yWLQ0atW7ZKnaI6A90VTL55BWFqZYwQW5?=
 =?us-ascii?Q?oggN38uVvDC15Upx/cIL4MobJclxSo7Io+J34RMPYabJK9YGAtgoK+A2TkMm?=
 =?us-ascii?Q?tije6laj8GsL4A55+nb8+KtxgMuDE/XvscbA9R8G/UPoipbMZ2Mix0K8nSa6?=
 =?us-ascii?Q?Fgt+i/wGHUTIGtmG9F45L9WEi9RZ4aed7SGxKECa9XwoK+WdAG2okkozbWFZ?=
 =?us-ascii?Q?eo5C3Alb8+yB8om5r9WnnPohxPV4Vm0c+9BfQ39e/w42wOPDeTgrEudU+A++?=
 =?us-ascii?Q?tFTQFfpZgMaM8NWftcdWbh5GnCZt/BjuN7icsXxV2waCSV0yhNKNZzPjPIKI?=
 =?us-ascii?Q?bkq3mEc9A7L3HX3ajG/TKmI2/uC0XOS3m3/1j2XBYjV2yT1j3n464VLddUNS?=
 =?us-ascii?Q?EycQ094MRGGz6xeN/9v3ck0lbQKVyqRi2ALrJ0noOv2l2j0+f43GcIY7ERt9?=
 =?us-ascii?Q?mEb+hdJq26HjAW0Tj79jXl0BLwOHzhnpnnhwAjLQZfTQ1Q1uX0OrJr+rf/xa?=
 =?us-ascii?Q?pCkLYXMqRT4J3k77GrF+tBpGpT77k9CVQEaBkPUl1qOh8emMxOhBpkK0YF8p?=
 =?us-ascii?Q?8LaDdr7Wopq+JdZSzRs+98rIaxFZ0eY8IuGpynQN5N6f4sI1MnWjPmMU8gkE?=
 =?us-ascii?Q?nHSpCT6zzN4AL25KNWhnp21ZfxXK2gvN+y3ik9UfpGLixMzoT+byKLKoqNWE?=
 =?us-ascii?Q?yghuRLyjzOt0GJ907YAEKgyu3oZSLlvbjnWZMPKn23GvypxfbjxtBuMm4Ni5?=
 =?us-ascii?Q?pQSq+FRNd0o7HRlMYyA9UfVUi/lvbbBzqtKT88ptIdF6vYARb5zciQ5EDBut?=
 =?us-ascii?Q?gbETS+Xupozg3dvVJrVu7tRKxSCaVXbeEF+zvbgj93WPy7JJOx1pufdOLBda?=
 =?us-ascii?Q?7VfMx2+Hcb98XJ6rO5blYDVTnMGJiu2G1jrsiVTyhLrsXnuvfso5TGfQSRmu?=
 =?us-ascii?Q?sSdyXGZpnBN98LWWMaozy9C8xiaaVN2jxa+KW4ssK+reZe5Ox7dkr4KLH4qs?=
 =?us-ascii?Q?sgyNJXz1Px4WHZDIQgU0GKg9B1ZY029/3n2gfGf3U+dnWtEUxNg+kTE+2L78?=
 =?us-ascii?Q?5lXhAAzdKU/xB7z8h/N6aus2n/vDnoM176C6gEcCT8ADiHPsbcmCZhyDJ/oo?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ebdc95-fc89-4885-53e3-08dc68a1f64c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 23:13:21.4589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iMh6dvhB9QpY9nnDxeDRfuM/T4y2+jbE+2I53IKPLgSYQV9RfXXP6U7hXYOVY13/NOxqp/CWd3sg518VeZt59NpSEfAz30aYQxz4z5rK5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8089
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 05:23:02PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>The gzdopen() API used, takes ownership of the fd. To make that more
>explicit we clear it (-1) as applicable.
>
>Yet again, kmod has explicit API to return the fd to the user - which
>currently is used solely when uncompressed, so we're safe.
>
>Regardless - simply duplicate the fd locally and use that with zlib.
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>


Lucas De Marchi

>---
> libkmod/libkmod-file.c | 19 ++++++++++++-------
> 1 file changed, 12 insertions(+), 7 deletions(-)
>
>diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
>index b138e7e..b97062b 100644
>--- a/libkmod/libkmod-file.c
>+++ b/libkmod/libkmod-file.c
>@@ -317,12 +317,18 @@ static int load_zlib(struct kmod_file *file)
> 	int err = 0;
> 	off_t did = 0, total = 0;
> 	_cleanup_free_ unsigned char *p = NULL;
>+	int gzfd;
>
> 	errno = 0;
>-	file->gzf = gzdopen(file->fd, "rb");
>-	if (file->gzf == NULL)
>+	gzfd = fcntl(file->fd, F_DUPFD_CLOEXEC, 3);
>+	if (gzfd < 0)
>+		return -errno;
>+
>+	file->gzf = gzdopen(gzfd, "rb"); /* takes ownership of the fd */
>+	if (file->gzf == NULL) {
>+		close(gzfd);
> 		return -errno;
>-	file->fd = -1; /* now owned by gzf due gzdopen() */
>+	}
>
> 	for (;;) {
> 		int r;
>@@ -359,7 +365,7 @@ static int load_zlib(struct kmod_file *file)
> 	return 0;
>
> error:
>-	gzclose(file->gzf);
>+	gzclose(file->gzf); /* closes the gzfd */
> 	return err;
> }
>
>@@ -368,7 +374,7 @@ static void unload_zlib(struct kmod_file *file)
> 	if (file->gzf == NULL)
> 		return;
> 	free(file->memory);
>-	gzclose(file->gzf); /* closes file->fd */
>+	gzclose(file->gzf);
> }
>
> static const char magic_zlib[] = {0x1f, 0x8b};
>@@ -535,7 +541,6 @@ void kmod_file_unref(struct kmod_file *file)
> 	if (file->memory)
> 		file->ops->unload(file);
>
>-	if (file->fd >= 0)
>-		close(file->fd);
>+	close(file->fd);
> 	free(file);
> }
>
>-- 
>2.43.0
>
