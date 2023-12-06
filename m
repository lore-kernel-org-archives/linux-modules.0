Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yu4MhHkR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B7B10CC
	for <linux-modules@vger.kernel.org>; Wed,  6 Dec 2023 07:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701875707; x=1733411707;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ccg6o6Kh51mJwPgIUdut/BPvdhAAABDEOVV8HlsneS4=;
  b=Yu4MhHkRyx88cTTitQnD3tI1foHQVPAu+XDjPon5ZAbvNvrFIYIGPZ5i
   CF/BwI86oT7k4wQcIwDBx8+lspSryUTEBDfkkPZx3U04r5hANAhvmPXHZ
   8LJm+8K0VSFk16f7TUtjTARvlaCF/gyqhYjRBZnbJ8Crka24tp9D9iPdt
   V51/3WsDN7IQnDN14/Oa+1ZuiFmreqWgSCUzp8mmVJm5sjpx83jOgpgQk
   q+veKMQgMhwUB6fGsQI88XWNKwsQPtGgIlwRNXDXeTv9ZW7LxCNwacV4O
   VJ3u9TmCKT+20ipSmqtkOO1ZnavLCqS3MAjs04JDnHJ6TqZy4SALLzDqF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1144311"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="1144311"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 07:15:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1018596385"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="1018596385"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 07:15:05 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 07:15:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 07:15:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 07:15:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtyVG8vDIsvfTRH5hGezbkTC8ni9HCScX0Jx2JzEmJPHMKjEcyyulo05naUIgs0qx1ScUfH53q+tNC6tlmJIXbAwMAjzQNqHc2yZzuOsdkToayIfT9aK+nVVZZnoWbul6UJIeqjCzu3wFKmbewgopxrbFPiN2smG2aFcAnscQFxw2w2EPPuMtpoO3f42jhu9Urim5O9LtuUxKngeS3GYbk5U2b8egKkJ5prFHWqglxaESR0LXl7N4MbWBXepEFI/Wk2zT8fF+XgYB4nk3SHAEMQMq617t4oNQ+UN+RzFvujNhMCrlfZB8IfGXfcF9hJTbpyS9hO17VOEpC13aITOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxPTV8cosGVZaSl+aVEtOpRHixDsqfjPz/YW3cERVVU=;
 b=EZZMR1CPoxKNm9fpEJzmi0NnliMVIvpgeyomnS2Dn18QD/8TUPVOXdf3xoxAod6fzV1Jy6I+TRGGUcnU5fXlXGoa0Dgcjwd5b3m9vj6293Yt9koAAXY2Zh2hwOedUQxetKGvwvJgi6HXjNSgGbtssJ3AHPIp8GTo3hhxgpjFPqElwbn5sdNIgLOU0RTJt7LkB+TXyEVZveEMozoRYk62FVBjcLZowb9Yq6OfUz7F7wBgZRzuqDhPwS3JYBF9CWkZeNzK8GZcHSJdFXXQVFjLvPrUnt3Y98uLN2oNNSTaTniUoAfc82Ibma4rqwRS8nERqNapiSsR89lLTRr5axU/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by BY1PR11MB8079.namprd11.prod.outlook.com (2603:10b6:a03:52e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 15:14:59 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b870:a8ae:c4f1:c39b]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b870:a8ae:c4f1:c39b%4]) with mapi id 15.20.7046.033; Wed, 6 Dec 2023
 15:14:59 +0000
Date: Wed, 6 Dec 2023 09:14:55 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 2/3] Add KMOD_NEW_IGNORE_CMDLINE
Message-ID: <sotwbaob52hnasqhtcz7nkezh3n3t4tnt3fmbllfmsjgi6nqvj@xva63byuafir>
References: <d15ca533d7f50ffd27a11fc2fdbec8aa07659b70.1701791668.git.nabijaczleweli@nabijaczleweli.xyz>
 <b666b75fa732407e7e390ba27ebacaf663e93f7d.1701791668.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b666b75fa732407e7e390ba27ebacaf663e93f7d.1701791668.git.nabijaczleweli@nabijaczleweli.xyz>
X-ClientProxiedBy: SJ0PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::24) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|BY1PR11MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ccba3f-39bf-46f2-149e-08dbf66e1c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwvOSqku3Fbkv8ABisA0FQatJgGRurpWzbUGznoQM/RzF4a2UJVFH3hCxp+f8ihmOdVnNd9wda4gacd4DnI2qUaAuLDF6oz1eYCH1c1C0NsHlWuZAuqMmNNirUJPfeyr/mAClO3LKfxZDG9y9io2g1TH4OGrUb8Ou5uznB9uRzOQq86ptL0ZXdvgNMvn4cnGsriDw3oKeF0PVXXYu5ragkBUTk34Rzhvv/i4EfXA3EKHJdcDzTwGp7e0B4sLBvx7EIGpoHV73RcPkZiQiAUhhjXiiwpmUWjCfBmW0HFvQygLjoJw+xUA/U4OamWtZngdZsADax4mtJmZPmPwjeaHdOW5G8mg5urH75/+oB1httfXU3xmYAZ1N1hqc5+yxwFJe+6r8Kad0dSPXq8Q6eBiNF505ahPOWqa7YIByOYNMSU2Rx4L7Z5zf4FQGRNg1y8glq8zsNH2Un6vB02XvqVBf1legVemuosd1fO8yRIoZGuwzCauyaaqrS1whjeohUsIfyKBTW28cpMZW1AdgoYYHaKkv0okjF3OjjPLr+8UXZpmiyjyraB/88Q2XPw0rajo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66476007)(66556008)(6916009)(66946007)(83380400001)(82960400001)(6486002)(478600001)(6666004)(6506007)(33716001)(316002)(9686003)(6512007)(8676002)(8936002)(4326008)(26005)(38100700002)(86362001)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlpoM0l6TEJXbDVmMHpsNVVWeGx3SU5qbDMxNXJTSDBmTmZ0UWZTVHY3THVn?=
 =?utf-8?B?enpmZmV4ZTlPd2huMU5TWlhRc05KRHZoaVdiSHRMTmsyam1MUnVCYnpDR3d6?=
 =?utf-8?B?b3VKblZyWGhmbXNRZjlycVpYbnFKYjFyK3AvV2cyK3E3bFRuNXhGU0wyalor?=
 =?utf-8?B?azV6Y2YxcU9CWXJtakZrUHMrRkNhRnEyVlhwMWI2TkVXZEJHTXBOTE1qUERN?=
 =?utf-8?B?NGpOcUswaTJIMHU2cWxBNVVPVlBtMFV1ZDNNemNrNWNxUU5iYTh5ZWI4WGxs?=
 =?utf-8?B?ZlhRTElhU2lXd0lGd1dxek1LckIzcmRvUFdhK28yYm93WXdURi92ekIwb2cy?=
 =?utf-8?B?a0IrVGR3Zld3WnZxMFlMRzdpa3pvMkxxelZZT2hwaWxhOHF6NDZlN2pMZGFw?=
 =?utf-8?B?cHJObkV1ck5MWitmNUk4S05zOXNZdkV0RUdWSHlIL2xNWVEzWUhJRUQ1elB6?=
 =?utf-8?B?ZU1NZ0FZbzNDTUZZbEZoY3NwYTJ0SGRlYTdoclNXR0J6b2VnWG1razNWRGI5?=
 =?utf-8?B?VkxYdFNVZG9VSlIydndZOEM3QjNaa0ZXNnFYUFBqU3BHelFMaEIwYzlmWjEy?=
 =?utf-8?B?TGR1UWlWTFF4d1hNT01UblR3a0pRSWYvWVdKb1RVVEhMR05BaUJoZzBUbUJq?=
 =?utf-8?B?VTdpSkFXMnVrZXIrbE1QZEJrWWE4TE41L3ZjNlNsZERFdmZqUjAzUHFNQ0Mz?=
 =?utf-8?B?QS9JNjU1cFl1SUFpSVpzL0lPajFxcFRCUmMwaXM5Q2hwT2tyNkdCVDNDWmE2?=
 =?utf-8?B?aG9XamRMeDF1YzZCdks2Mmt5V0RtVVNDUG85a1g0T251dHFoNThERkJxSFli?=
 =?utf-8?B?Tkt1aWZCbW44MjhWdVVXZVpRM211bUl3NDNvK2NsWThGemRZdk9GZFdBY0RP?=
 =?utf-8?B?N051SzRaTUZHY0VGeVB5UWxlMVV4VUMrU0E2OWdwVnlDNExUZ09LV2dTMUUr?=
 =?utf-8?B?ekViL3pZd3cxdVR6amFFWCtYazRpSmN0QmlQSkpsa1hRYmswQXlvSEgvNnFW?=
 =?utf-8?B?dnlHZGVLRTFoek03ZGpOWnpRN0ZtSTEyT1F3UW5lMXB3K0xKb0NUQVFkVTF1?=
 =?utf-8?B?T3B4UC9ScDlIM2Mzdm5FK0UrZlR6T2Yra2Jrc0d1djhvN0hOY1ZISGdnN3hn?=
 =?utf-8?B?amhrZ0xTOGVsUkZiQ0c5NzkrN2tRRnNVWDN1Mmp2aVZqdHdYL3FmZlQ4SHZ5?=
 =?utf-8?B?KzZCRWYyL2hpVVZnb0QrekNKeS96SlN1NTdkOVVGc2FFK1dvcTNxbGd6eTNB?=
 =?utf-8?B?dE5vaHJLNjhXU3JITzVYOWZFNDRMNG40UjE1aXVIcVNJQXl3UlpDNjM0Q2JN?=
 =?utf-8?B?ZStYL0tiRzBzRUV0WVNObzZtY0dXM1p5T3pNTXphemJPTHViMFVhdUNTUks1?=
 =?utf-8?B?T3JxU0ZqbmRVbnlwUVlEdzBIVnRxMFllbkRrZ0FtUlJXc0tRYUtlN3FHUkpD?=
 =?utf-8?B?WjVGVEpEMzRwREhETHB2S2N1Zlo4ZGhXOE5GK01oRkV2bFlyVmM2bUY1UUE3?=
 =?utf-8?B?S1NCQzVrVFBHdGlRRFN1VGNsWXRDNnFydCtpRUJEUk1BZTZ4SUR2bzVMYzJ2?=
 =?utf-8?B?dkhBK004c0V2WW02WTdTbVNQaFhQMkcxNFRiUit2TnpGSW56cXZJZWdtdTJM?=
 =?utf-8?B?UGg4V3VFdHZoN1UrWjdKS3Izd0JwSlh1Z0JvRTN6bVBmSjJiZWdISzdld3Zo?=
 =?utf-8?B?bTBuWEQrUWdscklaN1NScEZxRSs5bGxIZXZkcVh2WDVhdGNHaldoVW55OGxT?=
 =?utf-8?B?dUU1M1FvWXNaZlhUMHBjODcvc0JTZ0VKWVpRbWRnV2dmemlVT240S2RRSW93?=
 =?utf-8?B?eml5dDEzakZsT0owcFJUSzNqZmxrL2xvMnl6L1dXdEJrL25hSGZpWUI1YnVN?=
 =?utf-8?B?WTNGL1hGcmxFWWdGVG5IMTFjbFV6L0pURjBkM0xYbFY4WWJPNkFzT0NxelUz?=
 =?utf-8?B?NmF1aUdpY01MSm5Dell3NnpGbUs4SFdxekswVHdQbGs2bGVrOXJoa0JQeDBz?=
 =?utf-8?B?RmE4OUFUdUJVem1aMW9zZWhzeU5YNmUvdFpuQjB1TitNZFR2OVQ3K1JpVkdu?=
 =?utf-8?B?Y2YrTzk3b1orVUhpbXgvMXQweEd1YXJYcVBjRitnbWF1TmdwTDJiVmh5UlpI?=
 =?utf-8?B?TVdwQm5RS0pES2hkTjBCdTFINkgrMG1MTmlHWlNtWmhaOHJKNFo1SitrRmhC?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ccba3f-39bf-46f2-149e-08dbf66e1c53
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:14:58.7723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7dDjOrhoMXYVcyCCUkycRkEDzINUqXbgkEcbe1k8Tzqi5KOSab2sIMujUhsbaMovXknHipGNgSuUHsQVFeclRanNVaX2jC+fHmvMPZHz4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8079
X-OriginatorOrg: intel.com

On Tue, Dec 05, 2023 at 04:55:22PM +0100, Ahelenia Ziemiańska wrote:
>This can be passed to kmod_new_flags() to disable loading configuration
>from /proc/cmdline

	touch foo
	sudo mount --bind foo /proc/cmdline

This has been what I always used for local/test scenarios. I wonder if
this really needs a more "official" way like your are doing to be
added to the library rather than just the tools.

Lucas De Marchi

>
>Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
>---
> libkmod/libkmod-config.c   | 3 ++-
> libkmod/libkmod-internal.h | 2 +-
> libkmod/libkmod.c          | 2 +-
> libkmod/libkmod.h          | 4 +++-
> 4 files changed, 7 insertions(+), 4 deletions(-)
>
>diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
>index e24dab1..600d666 100644
>--- a/libkmod/libkmod-config.c
>+++ b/libkmod/libkmod-config.c
>@@ -949,7 +949,8 @@ int kmod_config_new(struct kmod_ctx *ctx, struct kmod_config **p_config,
> 		free(cf);
> 	}
>
>-	kmod_config_parse_kcmdline(config);
>+	if (!(options & KMOD_NEW_IGNORE_CMDLINE))
>+		kmod_config_parse_kcmdline(config);
>
> 	return 0;
>
>diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
>index 26a7e28..1d0bd92 100644
>--- a/libkmod/libkmod-internal.h
>+++ b/libkmod/libkmod-internal.h
>@@ -132,7 +132,7 @@ struct kmod_config {
> 	struct kmod_list *paths;
> };
>
>-int kmod_config_new(struct kmod_ctx *ctx, struct kmod_config **config, const char * const *config_paths) __attribute__((nonnull(1, 2,3)));
>+int kmod_config_new(struct kmod_ctx *ctx, struct kmod_config **config, const char * const *config_paths, enum kmod_new_flags options) __attribute__((nonnull(1, 2,3)));
> void kmod_config_free(struct kmod_config *config) __attribute__((nonnull(1)));
> const char *kmod_blacklist_get_modname(const struct kmod_list *l) __attribute__((nonnull(1)));
> const char *kmod_alias_get_name(const struct kmod_list *l) __attribute__((nonnull(1)));
>diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
>index 279b35d..126a66c 100644
>--- a/libkmod/libkmod.c
>+++ b/libkmod/libkmod.c
>@@ -317,7 +317,7 @@ KMOD_EXPORT struct kmod_ctx *kmod_new_flags(const char *dirname,
>
> 	if (config_paths == NULL)
> 		config_paths = default_config_paths;
>-	err = kmod_config_new(ctx, &ctx->config, config_paths);
>+	err = kmod_config_new(ctx, &ctx->config, config_paths, options);
> 	if (err < 0) {
> 		ERR(ctx, "could not create config\n");
> 		goto fail;
>diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
>index 72cd7a2..29637dd 100644
>--- a/libkmod/libkmod.h
>+++ b/libkmod/libkmod.h
>@@ -30,7 +30,9 @@
> extern "C" {
> #endif
>
>-enum kmod_new_flags {};
>+enum kmod_new_flags {
>+	KMOD_NEW_IGNORE_CMDLINE = 0x00001,
>+};
>
> /*
>  * kmod_ctx
>-- 
>2.39.2
>


