Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B468168D0
	for <linux-modules@vger.kernel.org>; Wed, 10 Apr 2024 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775127; cv=fail; b=XwHcB30iIKrLCLQOvqcnoMRVMsNdz86XHhcLEZSwrUGi6Dyrp/97XuD8GSM06oj0H3z8ZKaEsaGFBtrnHp2uw6Nf3a7Bvtg5mNmzi2cqqb50szPVlUEENvnXqsC8NmAZrBu+/3xeYVjnvHwrLcaFbYscjnPvLuXyiNTOifum/wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775127; c=relaxed/simple;
	bh=X4zbnLGBZ5jjWVf1S1p6GCnCEOcSnMmrqcY93V6wU44=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kdS9/W9sS0l1N27D3y3I0eYEu7EsdY8q31wWYJ6Ltld/Klox4TirbGCdJhKvcfEqZONWNDuVuvu4UkdJoXSPTcX8GGn2857GGnxR9atoS1aIkm+UtrH92z5F7ExIQMIBZDvS5oeWb6TbIh24N+qu2f3QIJBWiicClogPstcK3bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DaK5jrt+; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DaK5jrt+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712775125; x=1744311125;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X4zbnLGBZ5jjWVf1S1p6GCnCEOcSnMmrqcY93V6wU44=;
  b=DaK5jrt+NaTDH/JSzkwMj/VKxgRJVHcTMwD9O/ZgMwvqlY/FVM2TvSQc
   AH7Qc6oSuphFkm7tHHxf6VvI7aE4OwUmEHfOJM68PwVEgdDw3qlLmjKRe
   lO6WpN5MWrE2KYoU/1ikROWiX7QrOsz7ExYAg7/O6N+juGsaggBldQgwH
   2JcFM2SFCyiE402KWOhbmrz3YOqXZ44QKgX0jR47cD7p5h4Ou1mivCHkU
   PETiZO79E13qqL4NCX5e1pW2U6ojna7P+FaFPwgqGXHqtrRJzRkjOKV80
   GlunB11WDa7u/VgomqkyU670XSW/fPJZwMoPYFzJDDK1cxGyNTz6VaiAT
   g==;
X-CSE-ConnectionGUID: 2OXVxdaYSR67UhNDSxVTqg==
X-CSE-MsgGUID: CW1MledDSCulXrDj8QvD8Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8013901"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8013901"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 11:52:05 -0700
X-CSE-ConnectionGUID: t8fQ3Vu/Q9KlIJDJVQu0ng==
X-CSE-MsgGUID: xDicT52hSLGfDhJ3iv9e5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="51624709"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 11:52:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 11:52:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 11:52:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 11:52:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 11:52:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhvtcsTyLZrGH8Bj2rBtWQHxf8qVq4QZ5VxlYBKk1YXQLNMC3TPRQE9OJJbAsj511Mzy6RcmSwiMI+i4NzV3SAOP6UnlVoGr2i/h0j9I0+8QWK6fltyZm5FUlD9F5QAjKgMTBsqDjta57hG2dTv8vrdqspNFFwOdMyV4S+U3qtOwdXKNlwU3LpCOAsBngv0OKB9t1TPHRUj0QKeUoY9xhDf/Vs9S8KFzrU476Sl1k8kwPL+67m6fLxGXTV19rzFZnEotH381SDd2Kw7DM/sMZG0fm4RzH6jcDuzZC6nJHKoVhiQA5UIs8Z5bMj2d3LQ5It6ZemanEbK4b6T2DPgKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCQRWhhUh+W1nWs/ZirnpKhMw7ADas1TgoU3Z89AH1Q=;
 b=Rlar3zEFqBsDJZht936jTtNQ4p1obaefrR4JljkLfdZGitfjv5TrLFqyN2pPtmldp++fULT7UFDVOZGFf/nF2z/SVZ3IIXoznkeXx3WTK/lWDfIQ1OXUTLIKbsdaPrIoXISTeqb4VkorI0P72q4D/kyJ5sV8TzgJ2UAPtldbvQMJyZCDz1XB/6B+frTHkillaSxCbC3OTgUf723qxAF5jSgrupz8/gV+zl1xdJJqFEGloMGKHVy+q7CymZXXQt7hd1hyK5VQ2s3yhQ/f0rZyhlrTRpbNudQLwjSFQT9b/bx6FuY/kVTZv5nr9xxl45LPSrJiRa+5S1pw6hwTeeoeug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CO1PR11MB5204.namprd11.prod.outlook.com (2603:10b6:303:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 18:52:01 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257%4]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 18:52:01 +0000
Date: Wed, 10 Apr 2024 13:51:59 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Laurent Bercot <ska-devel@skarnet.org>
CC: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] kmod/depmod: explicitly include the header for basename()
Message-ID: <vkwgadz2wbs7xhzrlzhrnzqtsnsygcc37roww6372jvvzrqwvt@bhgobpwwhvy6>
References: <embe01a23a-c839-406f-b9f0-9b9dbd4bc5c2@e0f6f3eb.com>
 <kqveepedg22645bfy77qkx6kd5peticn2qptbnewr2cx4uwi2r@vz5jui7rjysx>
 <ema794c470-aab7-40a9-979d-7b69050622e8@77b27b13.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ema794c470-aab7-40a9-979d-7b69050622e8@77b27b13.com>
X-ClientProxiedBy: BY3PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:217::33) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CO1PR11MB5204:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQFZCvuOXSHwfKWel8u4EmHfcOpQs7dWSF+etD3TElNdDqQA6bI9FdA7y/yT2DEMXMJrKoexBxfI0u4QsMu9teDadcoDpfSYKDp7Vhee/i4zh6i1ZE49zZdSkrtJTLhEoZDZS5XLn4lHdpR9H9akd0iSWy/zuAx9DobEbJuHs5SI1k2Pq6VrlynOqZN8ncNf7ia6OPb6Eb3xwY7fvMITGq/TPDAxoOVz4r6w+XzxjXRVTJRvkY3o3ne5biepuA+M8qum2DXPrV1YcBNGYQS/GzolzkE4Z/mIcXjFif+HKtGAe27pXYaqBLr+Gi/gWy+DiDkUVjTZHk2IWyB2QfHic9F5HUXnHhm+AUTI6M+b6Q7eFzYyLsTbqvfgAiSE/3r4AZmm73MrlbjxaoWWTfwLQizeFWmkwD63w0bgeHzkxRzvIAo350I6aPe2gohPQOfSu2CG1qd0779RwMaSTGEXeqq1Rgi22jzWJdDgwMS5gxnOQc9EiSnPoe1dIsRnmLB+9Qu6S/T/6MWakdcmJap/KudsBrihZFabK8xSZkG405TsPzVOfGR1GJjfIVK6HoRDBluqVe23LkAHMQn2h5aX3CjKqhgUDfq5bnSP1nVdgyAWBbD4e+GJ46v8pKux4jJjYRp2CwMqh0CuyNqLtuJUc8VgZlWFZECbyJvtbPLiOlk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?amJ/bri6ilcEq7v4Ri9jdh51Q+jmYtv38Kt3rWXkEiZrG5zkTtzGUnDLU7iY?=
 =?us-ascii?Q?kwwijy/vm7A9Tp0wMdJ+0FMVkQmFhL8BivPVPjetKY6eRVyyTj/xQGMDEgsL?=
 =?us-ascii?Q?FiVHDGRsoov5qRnXGZEZbd1rqOZPaOambuhB65d+bqY9nCPE8hJaYvBnEApg?=
 =?us-ascii?Q?5JXQL+dEL8jOqx2BPXrcAHigVAMPfMGR1ulDZx5gjCiUvhEATO1liDw2aVcP?=
 =?us-ascii?Q?HUmyoFXGMaAPQxXJzPKTR6annvQ8I0aGt9OngMO9++dXbZ+qqaxlOx3KaaRj?=
 =?us-ascii?Q?Hb4It+s7tzQtYOaUmkYZpY/DRa2RTlay2jFIFQdqI+I6/1PdhPYQT20sfv46?=
 =?us-ascii?Q?VKS4WGZhMpSLbsXrD4DunGrbYJhwFSA3lSiVcBcV+RtZLGg+Y7Tmh9q3R6g0?=
 =?us-ascii?Q?tUg9u6ozMl4rLjx/F6SNH4ANf7h8QlOd1i3JLNLuDGmgrhoXl9MUtAESjx69?=
 =?us-ascii?Q?ui+oeWUepaETOPp5RaPqi7ZxvE4o1kPBVYQCZYagkP80itNZLPMIWs3dF+4N?=
 =?us-ascii?Q?/d/Dy/swt4dhZLJ5SpRkw6Ll/rQ5Y/8AG9m7kX+2z3vnhgk71opJxVbsrBDm?=
 =?us-ascii?Q?Tzp/tvRyPHxxdyjHRB5STP6wOpxEEie91SqX/jTSxyns0SFkktCAXfPNzl9g?=
 =?us-ascii?Q?TjU1FLK6QHP2G/QyEEZ8+2Lgs6YR6NNHWqStSMoFb0Y43/+2EwTVoePbCo8T?=
 =?us-ascii?Q?sHM7g9sYyVWvx09a/tjbXkCHr/hYkq6Et6Pel3rrlQKEj6UjPYojJE3YQctL?=
 =?us-ascii?Q?+nQSblusg6nxHXlSaXDCUiO4K8L/kXTEbDBCP2OPSi87o+D30ZHwsDfqF05L?=
 =?us-ascii?Q?8FtRPG1oAndj0ZoMv7lLHXpVtV+/bfMHQYgat3gqHcwD//RwnC+qG5tOjb0d?=
 =?us-ascii?Q?Y+aqfvVWfqOIy1U92UOaa/RulN7ajLdZB+attY5XmZt2tKVzHNCZoULFHlmo?=
 =?us-ascii?Q?cM+t/5RyDrdsGORE3VgsOBwHXT/jDEgai0g+yHxYf/HslXAC9dgzc1IuRE+Q?=
 =?us-ascii?Q?q9d/UBeFfE0IYe2x1vpAEXx3GkiX65Ftr57pLh3PgbPGvqZpsNyr5xzorOBo?=
 =?us-ascii?Q?/cVDKMf8KQlCpR+/vohevNgiqXTqXdJQ6rB6GwqE/rgy1l/ogJ9TFr5p7bI3?=
 =?us-ascii?Q?lMq5GCzHJqXClyE9zR405/zPtBcg3gmLnTE0I3aaRhoo7KN81vuDPQbjbQ5X?=
 =?us-ascii?Q?SHYBVaGNtR2/KZKdfTFYAojPGBbhA7Lnep+ri4eyLQdUXhduVgcy9Bh/9E66?=
 =?us-ascii?Q?V5WOAwz1IVsv5ZJfLZQr4wxIhG3TZAHP7SqnxvEv5J+0j/EdEjKK/Obit8JF?=
 =?us-ascii?Q?7fRO0EjWjU36BTd9hvKJH0OUqqnDYXE+Yr2JfoxiN2XNNejOf4FwF5ZShuMa?=
 =?us-ascii?Q?AmLF1+pnxCelQX6TCVh2QAfYqXCHELiy+oUTezjaJqaCJo2kSKVRx281Onmk?=
 =?us-ascii?Q?GoT+QxzX7/rK1rBnWWyhPv0Lu0Y3oRZokfQNni714erjaQjyiLMK7qiLJ9c/?=
 =?us-ascii?Q?7ZEZo1lq0DBbGzLC+Lbu96yABQ0kgDDGc3S7sZs7rxYyD+0Ezut+kCcVvno1?=
 =?us-ascii?Q?AYsZ4YOzg+iY2OXxDRVq6kJ8jYSEOmcKJc1tgY6lCWRsyD8YH1UJBsLTMTtv?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed8181f-3449-479b-5ca5-08dc598f4e71
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 18:52:01.4828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlpKMFqKFAa3gcMXVNnB5z/nOZYVgldDNC3DizG7OSbSelTtDDhCSSrtrRtvyoTtAw0hNnN5wFq/19fzfdzeQu3S2h4CEnRpEp/A8qYVaXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5204
X-OriginatorOrg: intel.com

On Tue, Apr 09, 2024 at 04:16:48PM +0000, Laurent Bercot wrote:
> GNU should have named its own (admittedly better) version

agreed

>differently; it's just less error-prone to have different symbols for
>different things, and I don't think it's a good idea to tie a project to
>this particular GNU bit of carelessness.

agreed, but that's not really up to each project. POSIX/libc should have
provided the better alternative, because the current one from libgen.h
makes no sense for what the function does. I understand why an
implementation of dirname() could modify the buffer passed in, but not
basename().

If musl provided a better one with a different name, I'd be happy to
alias basename to it.

If I cared enough, I'd request a "sane_basename() /
basename_dont_be_evil()" to be included in POSIX. I don't care enough,
but as I said it's surprising libc developers don't care neither and
instead we keep patching all code on earth to duplicate what should
really be the normal behavior of such a function from libc.

My problem with s/basename/gnu_basename/ is that eventually we will
forget and just use basename in future. And break musl again. And it may
even be just a silent error, modifying a buffer that shouldn't really be
modified.

given that so far we never needed dirname() from libgen.h, we could just
ban it. Something like:

diff --git a/Makefile.am b/Makefile.am
index e2e2411..6ca787a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -17,6 +17,7 @@ export GCC_COLORS
  
  AM_CPPFLAGS = \
         -include $(top_builddir)/config.h \
+       -I$(top_srcdir)/shared/missing \
         -I$(top_srcdir) \
         -DSYSCONFDIR=\""$(sysconfdir)"\" \
         -DDISTCONFDIR=\""$(distconfdir)"\" \
@@ -47,6 +48,7 @@ noinst_LTLIBRARIES = shared/libshared.la
  shared_libshared_la_SOURCES = \
         shared/macro.h \
         shared/missing.h \
+       shared/missing/libgen.h \
         shared/array.c \
         shared/array.h \
         shared/hash.c \
diff --git a/shared/missing/libgen.h b/shared/missing/libgen.h
new file mode 100644
index 0000000..3c78586
--- /dev/null
+++ b/shared/missing/libgen.h
@@ -0,0 +1 @@
+#error "libgen.h can't be included in this project. Did you mean to use string.h?"

at least on my system it seems libgen.h is never implicitely included.

Lucas De Marchi

>
>
>>There's a pending patch I need to review:
>>https://github.com/kmod-project/kmod/pull/32
>>
>>does that fix it for you?
>
> Absolutely, this patch is way better than mine and I should have 
>thought
>of looking for something similar before submitting mine. Please merge
>Khem's patch. :)
>
>--
> Laurent
>
