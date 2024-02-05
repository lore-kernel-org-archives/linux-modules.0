Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2E1F602
	for <linux-modules@vger.kernel.org>; Mon,  5 Feb 2024 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143443; cv=fail; b=JcyZRM53TJvNKDcX464QI/GKD4GbYVNSg+8eUXKC89UeLA6w6yTnQBj4dw4AhZ/1CwhcYqjyW3dpnfa8fS6HN2sMmaR24UpObj2fTES/xTBXSawS9q+cNgSoUcHXG39bG49ZNK/5P9lxrEPq3WatvkzyfVL4n81KYAEcnKHygig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143443; c=relaxed/simple;
	bh=Hedqc2fSLNxRF3l1Hxj1GyyyYOKwTcwzVgU+7SmWVTg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gIqJ8SE/uz0Ct2Rbxd2dBl7xueUpDvelnWTJLESKBTgy1GDutTNPRSylDlldnL5dDSNVG/QX+WR97KmF65C6+tdxaj18LhwFeJB18p2WCt8b22jaG/S4nytmrSAbn1GVHUj3nQa8QUGGofkGd02RGLhJeiC9AmzobQ+wc3Q7IfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Luk0lDQK; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Luk0lDQK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707143442; x=1738679442;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Hedqc2fSLNxRF3l1Hxj1GyyyYOKwTcwzVgU+7SmWVTg=;
  b=Luk0lDQKFpT/X6bpsfApMoVMeLy/tLoioNDqGbXHWgqmln2wTD15Hrnp
   mchIfmnPllLMyY94dBfpYOhHh1UEo6IAAyaobOARgaGOaZvIdfv0tSzRM
   oK6n9yX/9LPXQCUF5W2rdbvW6utVYZsX171HXCnyRVh6eLi1uCkYjUEKb
   ybh2eZIg+1nxlUBjRsJGLb0BoUZQfGOc7jOqvsX8esCAuOiUiljdod5VB
   /2GV8fcENVH31M+Ev+kycwu8ILAOCqWZwRigmgjAAtnTTU9jZ4nwESaeC
   lA9igESrMu/pgCg2ii8UfBIcegS1OHn1XmIUOMJ9MZJnO6/E1n0xkcSPS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="788642"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="788642"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 06:30:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5473534"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 06:30:41 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 06:30:40 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 06:30:38 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 06:30:38 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 06:30:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqde9B5stF2e4XKjEHOYhAmzPVdXI1y5oPxkC1O2iB/TG0DIAmz/3ObxA0OoFvRq3XIuUwkrDLPJBF9dHPg0Yv79tqM1c5xahz1eT4xg1Ii82YZCDPvrLsnTDZa5Py0nd4rZ2gzU8LWhM6cNwTKRnZKzdKkocvTasAZ3DoyHJLapIoiDV0P3TQKMJ1urtFnxLugX1tCyejRWjP+fmYl2BnqPAOq/jouCXL6FTuOpMIHzSedS+qDwfWzT/t1ejiGFU0Gta99PCoraRTVLNCa8PMUcX0BDMULjPd/Je0id7zB76cyKLD5nnH23NnSDQZls5Yt8vWlTlcST8lCnwZ1L/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iV7uzaH8RO8lZCiVm4atyewbY7c07LP8wdvt1KMLkCA=;
 b=U6z/8Xr80KDImxZoS7Rn/ElTZmpwcX7sESQh8cacHtf9Oi0tVbRpxH9oTLs9SZDO6/L5G0D23hE+UXtQJ33gXByUdmC0JVUXeAZ+TPICgDhTAHMiSPaOvRuKYwH9fe0PYVGeLhY61eKqQ1VWOXei9IkJw74p4cc1bnga3gTjIt08sQ1l5zGKSoEmJyTIK5pi0L2TuC3oL9NoqP/yADrTMQypl50lscnFvYXcPT7s3E65AXGineoPtlszpS1TopYBE+h9MbGh6Tb8y63KZ3B/qU2TXxxaz/Wy04//sQb+7d2kfXsNgLoYRcImw24DRUqUXiNS/7MCJa55M8tSfusfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by MN2PR11MB4695.namprd11.prod.outlook.com (2603:10b6:208:260::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 14:30:34 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954%7]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 14:30:34 +0000
Date: Mon, 5 Feb 2024 08:30:32 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Emil Velikov <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>, Emil Velikov <emil.velikov@collabora.com>
Subject: Re: Re: [PATCH 2/2] make: install/uninstall tools symlinks to kmod
Message-ID: <72ijqdtswcehmfjgodgg6chauou4vjkyh6ieup7osrcxbfwvua@arh6o2k2yddl>
References: <20240126-master-v1-0-6257d039a30a@gmail.com>
 <20240126-master-v1-2-6257d039a30a@gmail.com>
 <zeoywwedo4muolir5ietylb6xm2wu66wai77h6rvy2hkmu3u2f@f26b5cb3s6lf>
 <CACvgo51R=2WTcLma1wPSaDMu4QFtgezhGUKXf9k66Zg=6ZZ3=A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <CACvgo51R=2WTcLma1wPSaDMu4QFtgezhGUKXf9k66Zg=6ZZ3=A@mail.gmail.com>
X-ClientProxiedBy: BYAPR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:a03:54::18) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|MN2PR11MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d83cfd-f99f-4e46-bb46-08dc265703c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdVrdDBmK3LoijWJMbq+VqK51GctEVKPLlIGeqfMK4/EZyYrk0xumjFleXy56RNeTwnP2RdAKMAqdM3JU5DnTai8gmTXUNuVBAgs41d5mwvZkEGbnkM6ThIwirza7BGSdhDNSRVI1jEoOQr0HB4sV43k4l/CqoBw814L6MuOooSoyFgYr+PYjgHsS65dc6yq9H9i8PUzYIurwtAW9S9dVt3GoSxnUf0ZbECpJ8llm7zPOq/7BbGcvIGeZilTRCjW/41X4nyGwo7t+hX3HpxV/+BdhiOMAyiqx3X5E2QzhYlm4SAY8psIw850U0RtXqqHyM/fBbwGXyOw6uSl1VvZc3S01A8stYXNQ+hd74hXWY3LyDAfsyeL8D6CHmgs87zF+E851coRddChQbVPL4D5PbcN0kYYRvtT/+wdFD76SiuWyKNoy7Gjx9olH65+PdRwiM/OdjpCHlnsCzHTFaDM+K6CYPeyXSro0Qqeq9gXPzPQbTCQDE3jY1M6ep+bfPtlzdqhymi0TDd/WQp904yubuH7bI7DuqJ6ymlSGb5QTJA7V9RpSF23z6E5RNAsHbaG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(136003)(366004)(396003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(6916009)(66946007)(66476007)(66556008)(316002)(5660300002)(33716001)(8676002)(8936002)(4326008)(2906002)(83380400001)(82960400001)(38100700002)(6512007)(9686003)(6506007)(6486002)(86362001)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RUXOx8yPoOK8n98o8bZ8xT9RSkqGsPxClvVipYDTJDYF+uGoTV+Aa5YnIEc0?=
 =?us-ascii?Q?xyoezn/vwXNq7h4rKQKeHxC+vdlnpd9oVS5wpqoR8/ZlngQDZ5aTt/THOM8z?=
 =?us-ascii?Q?Nn+neXXZo1eqTkRWpNsn38LIsqgbAtulvdRcs8S+vFCmWe+KMHaH56N+HbWB?=
 =?us-ascii?Q?Wx9mNXhr+JMV1/zF/AZXJwR/IiV5ZumF7vs9cWWP+FV70aCSzmzIxbQWon3g?=
 =?us-ascii?Q?vXpfeSYodNJVapoYNCmivfIqU0YdtjrhXHVH6f7HmxTA6DymWUYAHdH6O8xc?=
 =?us-ascii?Q?xPyTCljF7dpVzfkA3GWwLY4uyYMzUomFEJiQ/jt8qRaWuSs4+H0xch9SCuUk?=
 =?us-ascii?Q?NGejfAbxroDEZ2mm3fk9oagcorzqWPBpX05SrRMgzVks62QMt6fGdAt2XYKx?=
 =?us-ascii?Q?JBDqwsyBDiG62ET9ZnfG+k5/CXor7hG8FNuizcECiLz92ai0LiHicsB5/4vc?=
 =?us-ascii?Q?sKvrgKJ7XY/4HZDVQZ2HlKmcbVkBn1MKdh6UihVaefPjgtKMCUckXhaVZkov?=
 =?us-ascii?Q?GdaKNZwd/LWzHDk8+1Qbx5wnZi7dbJ9i4vM/Y4pkOLMnjoxq0xUKS0xvIVnw?=
 =?us-ascii?Q?6TfGqfxWEd80/Osj39ExHC+RQzzKBIGndqv87yYC3yujALHPZ01G0TdvVNW9?=
 =?us-ascii?Q?5xDp2uxn9DGigxGNWsQdiIA+DfHuj47jpVl1hkP4bH4/2Ay6UejDSFABL0Qs?=
 =?us-ascii?Q?I0WDHla5lZTlaNSG5fJCsNEl4Urgo/1EIhWdC/M+XGtM6PKq+vM5YBOLJcac?=
 =?us-ascii?Q?z+ofAY3ktUopzoIYnN8FCZ/tmqAw9LFQq69RW5dZO7avv/j16pSGgQsT/OYu?=
 =?us-ascii?Q?3gSa9MEP6s6NclPimW8MAiSq8TOzkr/zyTfodKU3h70qvgSsri3I1J1slLat?=
 =?us-ascii?Q?mLIYAanJ4Ygqj5AmtBF7n4An+zOZx3Yo3n6Eh/lro9hMw6RsAR+2F8fBIwPz?=
 =?us-ascii?Q?bcy1yxYKxXmaEdN1Nk6WB5V2ZMmDbSgLDI6awXfeEQ+FO56GKALUcshv1FuC?=
 =?us-ascii?Q?XSHwPS03V9dRwwsE731YO1PhAr0rUWrGLWzSiPpTZIXUkKNaXN/UhDTC14Y/?=
 =?us-ascii?Q?RqPssWpM8h6W3BQ9EFqGUe2v9VYrCpRGIuDQiTnEqnPwBrh0EsenFqpCvTtg?=
 =?us-ascii?Q?Hdd2kBJ6obchU/9ozU17CyaEOfGX03UmGRF5dWDiFw4ZxuUNb3jOub/FBzRy?=
 =?us-ascii?Q?WIW0mCDHr9OX9hiTpdJC34T7W4j1UC/STrWWJMsQ23Udg7LHsoNKc4OYM70b?=
 =?us-ascii?Q?PdC/a9vO0DegWunXxzlHQaTOZMQCOSJ6/RaSlf/wnyOdnDcROLkG7JVU42Y0?=
 =?us-ascii?Q?shDzz7+cj0tWINc/aPEWC30ieLmWkEhvv3dcxpDho3cdwWbu5lCtKkjMQMia?=
 =?us-ascii?Q?vNn5aCNDJocgQnfT+agNWAoglI0k5SxDFjLmNwwJL0TAZMkhdjuuDnEAuQBA?=
 =?us-ascii?Q?wxnR+rca2wh+XkIZP0ClQLqCLFLvKfL67F3DqKK/iuSmiTBdNRaZV/gtTsn5?=
 =?us-ascii?Q?LQJNp2z2dN8nmrhLl0WY8CvxlYpIxa16NxTfQvZwd1UbhL1fkIUnGLGYvIX6?=
 =?us-ascii?Q?AdnIecGvsAOY0a7xk2nlEhcL+x7giHAGrei6GBc9m2CAPjM4VKa+ybKiJNeH?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d83cfd-f99f-4e46-bb46-08dc265703c5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 14:30:34.8576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6ehXUehXOWScKILpPSsCMWcyLUdczGc/4RZPrPOAobH0WTduc/TAqNungoJ3vADXlJODd9qiHXKmMLBKkuk7gU1w/ZHYGAdtQfyLXpCxX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4695
X-OriginatorOrg: intel.com

On Mon, Feb 05, 2024 at 12:37:42PM +0000, Emil Velikov wrote:
>Hey Lucas,
>
>On Fri, 2 Feb 2024 at 18:53, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>>
>> On Fri, Jan 26, 2024 at 02:43:51PM +0000, Emil Velikov via B4 Relay wrote:
>> >From: Emil Velikov <emil.velikov@collabora.com>
>> >
>> >Currently we create symlinks like modprobe (pointing to kmod), during
>> >the normal `make` build. Although those were never installed.
>> >
>> >Add a few lines in the install-exec-hook, to ensure they're present at
>> >`make install` time. Thus one can actually use those without additional
>> >changes. As an added bonus, distributions can drop the similar hunk from
>> >their packaging.
>> >
>> >Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
>> >---
>> >Out of curiosity: are there any plans about releasing v32? I'm
>> >interested in the recent /usr/lib/modules (module_directory) patches.
>> >
>> >Thanks o/
>> >---
>> > Makefile.am | 10 ++++++++++
>> > 1 file changed, 10 insertions(+)
>> >
>> >diff --git a/Makefile.am b/Makefile.am
>> >index 4062d81..a22d1b1 100644
>> >--- a/Makefile.am
>> >+++ b/Makefile.am
>> >@@ -111,9 +111,19 @@ install-exec-hook:
>> >               ln -sf $$so_img_rel_target_prefix$(rootlibdir)/$$so_img_name $(DESTDIR)$(libdir)/libkmod.so && \
>> >               mv $(DESTDIR)$(libdir)/libkmod.so.* $(DESTDIR)$(rootlibdir); \
>> >       fi
>> >+if BUILD_TOOLS
>> >+      for tool in insmod lsmod rmmod depmod modprobe modinfo; do \
>> >+              $(LN_S) $(bindir)/kmod $(DESTDIR)$(bindir)/$$tool; \
>>
>> I was about to apply this, but then noticed a problem: I think we should
>> use a relative symlink here.
>>
>> $ DESTDIR=/tmp/inst make install
>> $ ls -l /tmp/inst/usr/bin
>> total 700
>> lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 depmod -> /usr/bin/kmod
>> lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 insmod -> /usr/bin/kmod
>> -rwxr-xr-x 1 ldmartin ldmartin 715432 Feb  2 12:44 kmod
>> lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 lsmod -> /usr/bin/kmod
>> lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 modinfo -> /usr/bin/kmod
>> lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 modprobe -> /usr/bin/kmod
>> lrwxrwxrwx 1 ldmartin ldmartin     13 Feb  2 12:44 rmmod -> /usr/bin/kmod
>>
>> should had been e.g. depmod -> ./kmod
>>
>> Simplest fix without resorting to calculating the shortest symlink is to
>> assume: the symlinks should be in the same dir as kmod, just like if
>> they were not symlinks.
>>
>
>I'm not sure I follow, can you elaborate what is the issue?
>
>Are you trying to use/run files installed in DESTDIR directly? If so,
>that won't work for a few reasons:

no, those would usually be done by setting prefix and sysconfdir

> - kmod does not link to the in-DESTDIR libkmod.so, admittedly one can
>workaround it with LD_PRELOAD/LD_LIBRARY_PATH
> - kmod tries to open the depmod config files in the normal
>non-DESTDIR locations
>
>> diff --git a/Makefile.am b/Makefile.am
>> index 39a46f4..6df2f60 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -113,7 +113,7 @@ install-exec-hook:
>>          fi
>>   if BUILD_TOOLS
>>          for tool in insmod lsmod rmmod depmod modprobe modinfo; do \
>> -               $(LN_S) $(bindir)/kmod $(DESTDIR)$(bindir)/$$tool; \
>> +               $(LN_S) ./kmod $(DESTDIR)$(bindir)/$$tool; \
>>          done
>>   endif
>>
>> does that seem ok squashed on your patch?
>>
>
>I'm not a huge fan of using relative symlinks, especially if the tool
>is run as root. In my experience that makes things harder to audit and
>prevent accidental breakages.

I'm completely in the opposite camp. Relative symlinks actually make
sure the thing you are running is what you are expecting. Nothing should
really point outside of $prefix expecting that is mounted on /.

Several years back there was also the issue with packaging, which would
complain when symlinks pointed outside what was being packaged.  It is
dangerous when using absolute symlinks because if the tool used to copy
follows the symlinks, it ends up with the wrong binary, copying the host
bin rather than what was just built.

Lucas De Marchi

>
>As an example, my Arch box has the following:
>
> - /usr/bin/init -> ../lib/systemd/systemd
> - /usr/bin/ld.so -> ../lib/ld-linux-x86-64.so.2
>Hmm should probably see if we can change these and how many things will break
>
> - /usr/bin/lirc-setup -> ../lib/python3.11/site-packages/lirc-setup/lirc-setup
>Modern practises are to have a shim in /usr/bin/
>
> - /usr/bin/slapacl -> ../lib/slapd
> - /usr/bin/slapadd -> ../lib/slapd
> - moar slapd
>Hmm what is openldap doing on this system again
>
>
>In other words - I'd love it if we don't use relative symlinks if
>there are other options.
>
>Thanks,
>Emil
