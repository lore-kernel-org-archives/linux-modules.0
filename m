Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4B819067B
	for <linux-modules@vger.kernel.org>; Mon, 29 Apr 2024 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427692; cv=fail; b=f+fu4ePlt8vK+XOQM1AYHvub1rxy3Sh1H9F/YSc6laAoQhSiRvcDFACj388HvmM9/+cJ8GKkJjrE977MCdrmodV5Ys7HWlTj2TkaLkxuuJe24Zua3A+SxQjrTX52JkaIT5Oja8nEi+i9jOnPrxT7qreEC4N+FUwFKihjVKiYhWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427692; c=relaxed/simple;
	bh=PDIx2sNN9/mvGFezwBdUOViuA1blxGifo3VTPaY61Tw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T0VhcdRXHFNww+WeiDmUG4yCqCKHHedoDKz8V1GOa+ZROdlvuJDXaS29ZVWszEAxLm5xtjSeP7aDHZjH8fySm1WYtNPBMQgS6aKpXHsVYuq0iAeft5ZX6zt5ToHev1SmwVJFoRB/0hREkImoFjvh5driW0Zg+rbhBNp2AtxaF14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0Io9ica; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0Io9ica"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714427691; x=1745963691;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PDIx2sNN9/mvGFezwBdUOViuA1blxGifo3VTPaY61Tw=;
  b=d0Io9icaY7mIktWQLsdKLbTwWMhKfkyw+c9uw0Z2vfQRgks5Pdad7pFD
   gUcT4vf38rw6XZ6QT/P1sX+pnG9dga6sddoNb2UIrPCffoogQ1E+5JGF2
   cbncxYdkqICLjkaFhdME9UI4yWO3qqyCChn/LglHZyE0qDFoeqaZ9Lrhf
   SONCLbu8C/dKq3xFp9faSu1/JN8f2ji+fIyoh7sYnzTHCUzgbBNcFKp01
   veOWB4/tOn092P4HxCRtqnNivV/x6UVgRSFmkJ85ReufKgvvVFoOAS39m
   VStuc1I9Ah4cbZ+lMtbL0aQBxpiTSObnILwQAE979T8A/ba+kkyr5COfd
   g==;
X-CSE-ConnectionGUID: VY734Sz+TH+IWQM71rn8EA==
X-CSE-MsgGUID: Te6DdySGRsig4K+6BDPgJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="9986084"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="9986084"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 14:54:47 -0700
X-CSE-ConnectionGUID: wHtOhUEJTgy2MCWT2xD6uw==
X-CSE-MsgGUID: RxfwQZ5PRE26/j2UiY9K+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="30932927"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 14:54:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 14:54:43 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 14:54:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 14:54:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 14:54:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0/mYxfdfBFmGZcdk+WGL3hTSzLJ+ysCPMCrC+Ftfgqg+xlcZcz+jGJ7KhzYMNWvDrb12SG5baAGSu2Is1Ns16Vc4E2aPZHhshi+E6bY+GpNZ/P0OP7EfS6LwaJZV/buQJJ7g1Xzv5okYreDen7G/tiXVZONz5C2AmPDhVr/OUpeDrHXQiI7W+WQQNtV5ODq4u86a1jbjzQ6BL+/epVhijr5hrNTfNQ2c39m13uwOdLEo2/SRKMoM7HuutdNEro1oCQQNSsABam6w7YBRkTcg5YF7zZUoXWvqjrXDkbxsXd2tm5emLCVnns+i3jtym0rMhNnBizm8yJtG5MuIPHAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxTQT8edo5DLfkTEaWgtjjPae0Jg1B1SGyW942tqN5M=;
 b=gKoU976b3X7oiQmQuclK7EREF6dx6nSouSFwPZJTvMS6oNW9Po6nR8M99+jYkXy6MdCkuPCBJJQPTVoZfYKh3t04VAUDytnEznAf+5K7vpAr6ADpmVE7UhAhpEOKZSVFxMvnMb8WVN142hD7KF/OLHVeLq91Xvh47YesLYQYBT1HAKiVETDvAo7sH0pwKW1MmKp72ycyKfFEXPa7izMHQcn/lzla2yg0OBk9lbFLmpui4EaWdXfMnrgFdbJoRHlkFEpesPdwnFx+stnFsX2um1BuQJviEBnxzH6je+TTfDRsK08TWJ92JuZIzfDbuSNi2w3dhEpT31lBQlCZG+I7Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 21:54:39 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 21:54:39 +0000
Date: Mon, 29 Apr 2024 16:54:37 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 03/13] libkmod: remove kmod_file::{zstd,xz}_used
 flags
Message-ID: <ujnldjq3brjame3ok4qr22ex6242pxt45e6xnlndq2ejebdi42@hrz6ppxnkbaw>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-3-06f92ad07985@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240212-decompression-fixes-v1-3-06f92ad07985@gmail.com>
X-ClientProxiedBy: BYAPR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:40::41) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ0PR11MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: a03b9505-6866-4bbd-caa5-08dc6896f817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PkebDahByf+rtyfc06oIlFugGjRIDuvFnAMkUtExpelyW3L6NwrvcuuouRuS?=
 =?us-ascii?Q?5LHac56JTNTeHPfBogjlYaSDbPZrsC7GpJsJCfeG8Cd1xoEZOuEHboPmW23i?=
 =?us-ascii?Q?XC8o3HhTMffpG+RoQlhlAZ9H2SY/MjiBMK8BtlVKSYZ2+xraIZBZeMmLq0yk?=
 =?us-ascii?Q?Mwi1Rh673pNJspfhF+dt0wlYvUv+1Thr7iiwYFy2HDyYyQMB6CBdpkOAmiAm?=
 =?us-ascii?Q?cOHWv1eaNysRxjUYSda31hTFegRNypqb96uv+HKvogun4OSVMuJFNQrnSk5f?=
 =?us-ascii?Q?yOUnIqxfiyLM+yXc3Pmj15zf35+8PTbiBnGz+qH2wd2d7K+qiS+IkGsEGcdo?=
 =?us-ascii?Q?VkxRnluy5u6HCE/VJRL9Tyz+N/Z3qqioWs/TnwPykNI96xaow8EyRYx+LFZm?=
 =?us-ascii?Q?Idrfl2SKKuedUTTCJJNAmU/StlOzc2vpn8u6vqRQRUz5NmMvDPZ21t5D/gyH?=
 =?us-ascii?Q?lvjnLrtlZNNGmz0FxuDfAtEdgovrz0XN3pwNvkPvYkl/dHHf8Mj6flbvrOwS?=
 =?us-ascii?Q?BjZdZmn8Wa+mrMfYxV+oS1xKm7ewkiEplQ91OfmNjJeopIcQWoq4/4U0ooDw?=
 =?us-ascii?Q?b+3e86E957TQztJSwyCzxRk+UjNC4sYGSuV0/+HSQTIjWQMWz+mzpdGclPEn?=
 =?us-ascii?Q?L0O1pSB4I4FovnUxKl1MxBPUmLZIHX2y1pCOlbZ5k7qhIP3fXn9gLgQzy7Z9?=
 =?us-ascii?Q?OfbnxkjFY8GgMO7KXRWRHxLAoWQwk2jlzJMVQawtPfPSKTFNCq9hjL6d4xnC?=
 =?us-ascii?Q?mVBPtyw6ITOBVyBP+iLaSP+WCcJDI3lmsn6brl49iCljNQ+Xe2zKMlpRIBm/?=
 =?us-ascii?Q?AZz6ReRxpGZkNICN7wNCH8bKHuszNC1ALASE2AsEgZWDOIqeypFXvi4rgK9I?=
 =?us-ascii?Q?w/phbRf2nj5R/yCMCq4w6VFd4Stq3lemtCtwK07AvQI6XSKyZI1ZdVj50mwH?=
 =?us-ascii?Q?GaxkiBPxqiTJSirAiLMiiPB8BX1HxVcDvE9IW1pYC9BO3n+buR03LqZCbKAc?=
 =?us-ascii?Q?wqQRTd2gLjvojQ1ah/HUPTJFqO84BiUY22mn8jDaNKNEvoenrsA/skiLbkYg?=
 =?us-ascii?Q?B855aVhEw58FqxM3XdqNAaHBJY/QX2+6ne1eGXnOCxhJ4Y7+kEPblnPlfoM5?=
 =?us-ascii?Q?uZeLBiHDliXJmZ4xuCNkgT1V0wNlq+9nhsIwCjw/I0BJHs5nhNyoLYTdE6Fr?=
 =?us-ascii?Q?kQRfGEJgnMBy+vFweA/inNpH4nfluN6WCFzq7K6cnZ2FXe8Qaib2Z7SypA+2?=
 =?us-ascii?Q?SerrAzP8B+zaB7oIZZqKSepJ0AD9ZMftpZM9HxqVdw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u1/+jA3SUBH2H0pvDBgwPX8YeRPIXiDFSfcCB90mQOpjVYFORrCR0oC0ZAid?=
 =?us-ascii?Q?ELQHVgP34rY6vfLx586XXJvNqzhNjh+MoK3jRZP+frujDGDZU32GyPBR4X33?=
 =?us-ascii?Q?g4hbV9VA21WSgY3v4KQfkuWVaPtHLvoWZ9zMKtEkjm9FGUN6ZGQEKW+FcuKM?=
 =?us-ascii?Q?3zaEImBEWAX8CC9J0MsOqBfQvYCPvcKm1Lz+6axVo4VwFmQJBbrKkIR9LaP4?=
 =?us-ascii?Q?xmIWYULLFDm9PjYzKHOPVyKV2bBqhJNA78Wy5R2UOQngh4/TYgKoXIjq5rRY?=
 =?us-ascii?Q?uu3RxfHTbHj2fqe7RBC4YZLl+BPGUPbIEss51O5JucXKlqbyYcMeFUEuaHSp?=
 =?us-ascii?Q?DjxME+HrzphL3ShDRdbFl9ry2DCaiah+5or7thMsf2BV7zpW8Zw0HAB4ya37?=
 =?us-ascii?Q?/28rmSFf1hT47y9LcauEPRQe3WnSmzGCOKhYN4hd7w7aiIY5VnNYo/hO5tAK?=
 =?us-ascii?Q?x6hWD5Ch3HuiyCLuYWPHDR9in3LMZaCDWA+6xOJH0T2Txy0UMHcMyqSdt/ZE?=
 =?us-ascii?Q?oJlKdoi3uDU9f4OBXmqodPqlYSzjjYOZIn0Bp0ybI8mVZYunYfEw9S+ok6ti?=
 =?us-ascii?Q?PCVkfPIwmSmF/uq6z6mCQpuGUV4Cbl3q75B+Bavgfo8SDkOssnXRRYXuPp9k?=
 =?us-ascii?Q?VLcGhyfGZyGPNejCo+lsUrCTVNmVkYguMx57hs5ePU8BD1JRzVQIehiWc1OZ?=
 =?us-ascii?Q?6DsYoiqCKFz3vvCevUndZ3McXeEbMzMxclviQEVh34PqDCE2ENGzFOZmYmWK?=
 =?us-ascii?Q?YTwQesSG1WalXQJWLXzRbXgR0Ci8WlRwQ3CRa+PyN+CGY2vhIaYGABP1Yss8?=
 =?us-ascii?Q?3n0L1DrLPVzAy/V0YKg2H5Mc1m1w7rrmNvCV315UgbsDEiTTUuKBq9MByKBL?=
 =?us-ascii?Q?QvjWFWbbVILcJOklJX6g/cWe6AtTmmshXN+8kRO5XgLpp4V0HpfXoW+Qhc+u?=
 =?us-ascii?Q?z6MetW7V9iUQ/xKeiBVp7OBWGlUAQXZV1nVG7VTs54uo6K60/3l88xjrafSA?=
 =?us-ascii?Q?YMB2eBJvqnKa1gSt86LBJANOsg5YkpUHf/hNoSaCpgiEt6fYi502HnrNA2k4?=
 =?us-ascii?Q?gtk5Ao8pc0LptXUBw2k+IgDGg671vIfTHpntWfN7yeKpO+38k4zEcXZHlNAb?=
 =?us-ascii?Q?xD4tXuNquPk/I2vAJoMkrRs7LSzG7REMHrkkng7RY7kXpvDINzpjRC0rq9AI?=
 =?us-ascii?Q?zG5j6/zwS9J+yeiAjAX1tRjUGVlO/2vZ4+j/NGcyktXiNRV5KIhfU4nSubkU?=
 =?us-ascii?Q?j92kI3bE3SOnXMR45hm0YjE04QW3S8+8nSplJPE5lgBq5m4Q1PcbgkO7M9je?=
 =?us-ascii?Q?LxFsBarLg12WfOogmTAVVHpNpoodqUCI0a06ZZGXSug657kldr2oi5m/OD71?=
 =?us-ascii?Q?tWfoRXEXR7rUlTZ01H6FO68ns6H973fqZ3WHWfZhuzRYDdybcoABS6zfRKZP?=
 =?us-ascii?Q?duNNC8SN+2gxFG54zY4Zw2IJdp0o3I2uDCoNpI6fV3assBLPFLaLVA0zWMmu?=
 =?us-ascii?Q?b+T8bYLroRaHGxArZSeLDbg4b0ECfuA8k3DZ6FBiA5sjAiZ2M96Fy6iYWzeX?=
 =?us-ascii?Q?+C0UTZ1i4tObRSwMFbOUDhWfziqN4PiBG8pxRDD13OJ2q3DljwiUViZM2EZb?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a03b9505-6866-4bbd-caa5-08dc6896f817
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 21:54:39.8535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pg7HEbBn0V13dG3NKoe2YM7FnWFqfZ9mpYgXUCZT7PRLkcFCFqjqoD7pS17IxEejAVpo0jvy/XtkMvuRBfHNn6aYESb7V0pt0wwDIeknZH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5866
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 05:23:04PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>These are used to protect a free(file->memory), within their respective
>unload functions. Where the sole caller of the unload function already
>does a NULL check prior.
>
>Even so, free(NULL) is guaranteed to be safe by the standard.
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

>---
> libkmod/libkmod-file.c | 12 ------------
> 1 file changed, 12 deletions(-)
>
>diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
>index 9a014ea..abd4723 100644
>--- a/libkmod/libkmod-file.c
>+++ b/libkmod/libkmod-file.c
>@@ -48,12 +48,6 @@ struct file_ops {
> };
>
> struct kmod_file {
>-#ifdef ENABLE_ZSTD
>-	bool zstd_used;
>-#endif
>-#ifdef ENABLE_XZ
>-	bool xz_used;
>-#endif
> 	int fd;
> 	enum kmod_file_compression_type compression;
> 	off_t size;
>@@ -176,7 +170,6 @@ static int load_zstd(struct kmod_file *file)
>
> 	ZSTD_freeDStream(dstr);
> 	free((void *)zst_inb.src);
>-	file->zstd_used = true;
> 	file->memory = zst_outb.dst;
> 	file->size = zst_outb.pos;
> 	return 0;
>@@ -190,8 +183,6 @@ out:
>
> static void unload_zstd(struct kmod_file *file)
> {
>-	if (!file->zstd_used)
>-		return;
> 	free(file->memory);
> }
>
>@@ -269,7 +260,6 @@ static int xz_uncompress(lzma_stream *strm, struct kmod_file *file)
> 			goto out;
> 		}
> 	}
>-	file->xz_used = true;
> 	file->memory = p;
> 	file->size = total;
> 	return 0;
>@@ -299,8 +289,6 @@ static int load_xz(struct kmod_file *file)
>
> static void unload_xz(struct kmod_file *file)
> {
>-	if (!file->xz_used)
>-		return;
> 	free(file->memory);
> }
>
>
>-- 
>2.43.0
>
