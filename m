Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC58D1836E9
	for <linux-modules@vger.kernel.org>; Mon, 29 Apr 2024 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427109; cv=fail; b=UxnHxgBSKZhdiUIfjXvENihbDqHQrGR/GZYu/r07yK7cJE+T6SJf8jJ9dqYbdx5xeDDqOWc+GmeyXsB6vMY9bMugGvOjLcB5UKcLv87CgK+9pnuWITf6elSfX1E+tNNXCsYB8MxzFF5+Qe8BTRAmq51SJKTfM2yg5fafJFaZ0A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427109; c=relaxed/simple;
	bh=NguPhq5Yjv2T/DDrG1cvqXag+bxpmNhoX/nMJzzJlfE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mVYijEtQFSlwE/VN6cNIkkc86b3toBAcg242hdZK2JH/2fi/Q2IIy2ex+8BjzCoWFyX0mdUGIelZKXUdldjlqsZrPhhobN0g2QdNCwBT4d15U+x909QIL+RrEzKoNvKqJ/7VjGs3r4gY4f7bNfigB1JYlCeW7bth+NcCX/bK6Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+32Em01; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+32Em01"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714427108; x=1745963108;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NguPhq5Yjv2T/DDrG1cvqXag+bxpmNhoX/nMJzzJlfE=;
  b=F+32Em01BMbICe8qXHU/D0KDpj01O13CD7h43ATboZ0iggQ6kfEwzPnw
   CUON/d2Ucr68Eq7pyz4PC3TFwE6tLqM1kxNvpWiu61jO15EoIb41xdqeO
   iDunYpHgfRhPnTvJyz+8ywxsN5fkOMQgoHpvfeRa+CfJJN5uocj4CBgMB
   53YinJ9HFtE/kQE28NZ8Z+tHLyYDSYjyv1e6zVK+hATnPW5kXMBF35G3k
   H1GmxGUqR6R9m3hGNP+jmEtMwRuNpyfNDpBaJp8w+EQ/vCtoNFcRr8a/P
   pYfMahsQZd6ccMZVb1uWjIZLj8eKI8ksvpQ36nbTS6Q/gzJDC7Znx/rRL
   Q==;
X-CSE-ConnectionGUID: KLlBc9C1T2iLYnFL6QaQ1w==
X-CSE-MsgGUID: zdd1TDcnTQKxNcljFFaXzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="9971055"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="9971055"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 14:45:07 -0700
X-CSE-ConnectionGUID: VoLFyhs/Q0et6CDtbwziJg==
X-CSE-MsgGUID: aucZY9KOTa2IepKj4nhDcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26323838"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 14:45:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 14:45:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 14:45:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 14:45:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S02GZe55Ki4aC1aWKPDuLbQnyhIh7L5ceQ6aExwACqCVgxjgMDh4UEDj1NZRogl4BLbIU3xEHjmLI69OHXj6PCoqLygMTdO840P1xuq2IgM9wIJqDdHpfdeKW3GUIxRcnPE7edNf4DPkj3+NPN4FVNs3GSkxqP+nEuheBWaK8MIhCw5CRy6eQcnhIXAZBMlzgf4QpaVU/cb0lVr4NofkHme0Kk1Jtp0iu3y4Gljs43Y3D+WXuSmpWA6MjjtCmDIhLfl2INBCY0hEWicQIRL4Tq+b8WLttRWfa6SUTzmCzoH8fnjdbSCe3adRt+QNnvu1LKnaiNfoeoDEvWePlMRw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+VK7qlELPUW78B0U97VhTRlhP9QO+WkHxnlaOooDo0=;
 b=RxvkLPNbMcHzbd0fJ8gGX0ei69qlQ02ab9bEyGtXbGqNk3pYQNtJ5CxeypZ6Cl7O2gTfS8PIHOc0s56zGU2G9gMZB7/GTWvwDSvHxLkXD3DexR22oUXa6UW5yw9FmwQzldks+JRpJiZjG65OEFwmFqQ+eByJK0LgiB7s04i0PMVpTW2Lp8vDLa3ZbE4YaUYF33EH6LZF2RQMdWjfGCxW64zliHbyACiByC5s4CpgLCy2rWGPdwq5+KRjo5BiopPv5B6xcYmeLTT/draFsOLT3PdslmTX+rK5S6b5ypaXr5+g+5tzZ+TLpSWFm7+xRrVfKx31XMGij1Zoweeb4tb73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DS7PR11MB6063.namprd11.prod.outlook.com (2603:10b6:8:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 21:45:03 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 21:45:03 +0000
Date: Mon, 29 Apr 2024 16:45:00 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Emil Velikov <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod] man: silence autoconf warnings
Message-ID: <ngw3fdsrhrggciujgposlrimsoe5a4opbr6d32smr7ebx6gj6z@jxryfcashci4>
References: <20240217-autoconf-manpage-warns-v1-1-e1570cfc286e@gmail.com>
 <63an63knqvcxyxh5ejx64bsxgpooikbba5inrd2kzbxuhuuenc@nk644hvv5j2p>
 <CACvgo53NkaRHbgBkWbiDwSKfUXGRDqV48-zD_NyakjqxUjF8Yg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <CACvgo53NkaRHbgBkWbiDwSKfUXGRDqV48-zD_NyakjqxUjF8Yg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0165.namprd03.prod.outlook.com
 (2603:10b6:a03:338::20) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DS7PR11MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f4d70a-ef78-40b1-4091-08dc6895a0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kYgmGwxW0aK5xNquY+CoFy0rUasQOjZnSK5ick9jOdI2pl4QuNTa9v/qMYFs?=
 =?us-ascii?Q?f9cTopTShfb3n+6BQ7QoKOLJc+K9wORNH6mARAhSx1gAz6EyDDQl/LZ0NGBW?=
 =?us-ascii?Q?kq5KMbyEjAbMBCMen7QSkmDsVp/BLveiBk5+O79C5NeDxqy38vrtESh+4YFb?=
 =?us-ascii?Q?3Et7jX6/73nd0fo58yaj1dmOS0yVskyG4/ac4N4EfjOXxLXPyuPvFClZGB08?=
 =?us-ascii?Q?nHCIQvT1uyoiOHQ8zUV/XbFygtQwEvBNmJd+rN1a0cWVXWgnvAOwHqF4pDVM?=
 =?us-ascii?Q?PLEXXde+RVNwQvQeRC4xYJ6pI3Qcx73p0sI0frm3KaWMsPXsFEU2OF0+0ZEz?=
 =?us-ascii?Q?WhSZJmcDWcc99Dj8koou25qLfx79queqcuPPb7AMk7pCX5PVmknWFo11rYY0?=
 =?us-ascii?Q?fi6f3waGyHVp63ueXElvHBrrC7ekV84ec5fqf0IVdH6xd9kKF/nvQ+pf8pTs?=
 =?us-ascii?Q?6COexSSAuhDLDxqxnvTDvnY9dPLpykMuwutT1BingihlN/Mq7X3KQFCvdbmt?=
 =?us-ascii?Q?qgNCxZGwCQaZ5jEHB0Pm/K+Qdq2fzqOBuod2Zv7zhM5TTd8nBK9UtbmrjxCO?=
 =?us-ascii?Q?2uOdFqsQAq5ug3h8ybDmpeoMsqwyGKWK2bLZ1ktIRcDdjdv0Hke/2fMJfPwR?=
 =?us-ascii?Q?DpSzWyQHy5dP5Fvf1gcSlsQ66+gifd9G3bf4AaYJBqPMEn9WgBqfn3L/XJxD?=
 =?us-ascii?Q?U75a/QsRhZVg/mR1/VgZJ8ew4IY82u+gAhnXPU2eb7vXddFlaVPrM+GOE92b?=
 =?us-ascii?Q?JxJ9//vSL2GW3y+Tr37s6BUsR/8VfnpjpqSYi8zYnmf97W7dnwb47C3nmhYI?=
 =?us-ascii?Q?bgBidOKoasQxttj9+7Q6OvoOasOnfNp5TEgfqx+1TBG4rYCMg6wosvrr8qd3?=
 =?us-ascii?Q?IIYnjr1eAhUPQ7CAzKd13YTrPFhwaCbHpo4zWz+gLXw33K0SqEeOgexDzDYl?=
 =?us-ascii?Q?JZ5rWoAd3i5i6n2U5lc+phAw8AQurapMcEbof0btZfO77d0T48HrtC6JPOM2?=
 =?us-ascii?Q?v7UOyiGfcqvj+gmoMytrbIli6zUEKzcZvXCfQza21WEG2gHzl+tnOyWwN4PF?=
 =?us-ascii?Q?hKl6jZPGQo0PfWGMT9mHsJrzsWFJQiG33capaBWuFVtGBtt1ME2zAu5qFWFF?=
 =?us-ascii?Q?Jl4mtQjgXGjplhajD3Q45X4MfmVJd75KVMdu64qXG4JEjUdST93hjnqYh08A?=
 =?us-ascii?Q?BYzDzBr12/0G8ZmmnhvwcjTSM7yCheuIWuCovGUu4/Px8mCRxUY8cqxRLHg?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aaJajU2K+2EmdWptzo05VPRWg84mE/uHZRypqTcQVEfpF7Wdq+Q1s5FppXh2?=
 =?us-ascii?Q?vGWaLM9QI8oMvBEbbPVrJk735bSueA8BLPmFumNwL6KLH+P/Qn477TCDA8Nh?=
 =?us-ascii?Q?CMGTL9T/Wqyw6nMEwx2sCAiJ1gTNK56nIBK3fQsLXC+wePXtB8is/FnImeTc?=
 =?us-ascii?Q?67d8fr57bDepZIPLxbUt91daM3ZpGvP1ylmoSfZMfOium78pb/B3so7x3dzq?=
 =?us-ascii?Q?7livk98F5Pg0Mu1ZSVFNVBwElkEUQgzTFwslTkD6HlVZVg10p5Wi0COzcvrv?=
 =?us-ascii?Q?Tefzw/J6FT4oHDoxHnRYS1KFRF5EUWa/cNrqk3GvWjCUuHGeyjSfHmazY5kf?=
 =?us-ascii?Q?Iqln9fCBf13vBO3NsYtVMrSDzO+S7icXluiV2zic4eZ8LTu9W3GvB3WNT8jl?=
 =?us-ascii?Q?Q7BmVTfcLY3J9vOf5EVogJpSVQFitwJvAA66VmhioKD+1yydR8JEkt/Ucdw+?=
 =?us-ascii?Q?a8Bj34Xjg5/s8jOw4KIzUmBDTpX6L1UKa3iVfxVgrGivpJ7Ta46iqkL5J9jL?=
 =?us-ascii?Q?aUW7oM3wnGI8l9G/EGG3+gRMJmWF6SVbLE0chBTHpgtL9Z4yAyEdJLZyxRZ4?=
 =?us-ascii?Q?4l91S2VUxhnz1zH736cfjshtCFH60t34FX3rzfFJu5HZitMJbmg8jTUGLHGL?=
 =?us-ascii?Q?mq7ie8Xh6A8L9Dwx6E+1LKYRA0qls5B58An1boXxFsx99G0z4GMX5M9iFoFl?=
 =?us-ascii?Q?ht602mr+LSqiGFmbpadTQpltqO1lpEsMX0uxIU0ZZfmZU4/kkcRaTxDsCZlx?=
 =?us-ascii?Q?e+7jrVKYhJTDYAIYZO0xggcnoy8/cSDfhcIPclMtuANjg9k7Qrsp+Oy73cLj?=
 =?us-ascii?Q?wZWqTupDMcfsaI9lfHAF1jO8TEj5rEYJXQd8Kn8J2K0QkYCRTTh8wzrKQd7w?=
 =?us-ascii?Q?6PJrk6VMHRP1mPy3hYWa7+twQnFhENMrYMRnBlc3Z2jUc5jDGb11q+Na9dwm?=
 =?us-ascii?Q?KIZ063KI8JNyYliXg6y54UxsAFhl2t2uC0aiVbUTI4FxIXNWpTtbV/pFzUJx?=
 =?us-ascii?Q?PTYduVrpCrnpi3MSOkpgYXwvd6kGISU7QM+21lR2vYfXmn79nv8KxIsjuRjL?=
 =?us-ascii?Q?xCR8PbZ/C80xj7Zk1TtAXT8ixYHHub/Bzmd9weGrNj4/B3EX/0R60BexubtH?=
 =?us-ascii?Q?alQe25Oh6rYFdQj7swDSGkkTnb3PcfKjeJnreCeCdpaQMGt8fAcgqK2lP+TI?=
 =?us-ascii?Q?ZnszGfiotTIyyN7cqZp1RqEJaDRhkyMQoiS0BXR5DMRtNF2a+E8VnBDdfz+S?=
 =?us-ascii?Q?Sf5b9cWDyDFk9F1xlhfNb6Pb6/Nbax/3o18+419TCveJbmnjgIJEvsK+b3je?=
 =?us-ascii?Q?zzTcBkzj0AYsRAfqlYehBoyUS81czXxR2CgLWZ56vL7Pz0D3SyO/+zOyGKxO?=
 =?us-ascii?Q?EJNBdJ0Y92tZSnyUNywt+p5b7mAtf/cg5zLaKWjQ2JAKOiXb0l8537liaclh?=
 =?us-ascii?Q?e4KrO8ro18miLJlG9bVJZEgJsBuuz1jUmggQQyLc/YdTBy5JX6bBBPZ3AnL8?=
 =?us-ascii?Q?CdnOlrIAHW19/lGtKXiBtz5XPVfzSEB/IJK6FfH2SatQbaAglArJPNxoqsGC?=
 =?us-ascii?Q?rSVkekXnFRVpdSr05aPmunRTtsH6x9Uc0g7VaO8NLTmcHxlm/D2DS1CZRd8w?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f4d70a-ef78-40b1-4091-08dc6895a0a5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 21:45:03.5986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJ66in6Wvrs78LXM5zUENjyO4iaOjmhY+TulRq5p1SoWm9sgjDkEK3PGBU3eNivyEhnmK89kFEJt9tksW5yZT8pfkikPfWYceMVLbKMoImg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6063
X-OriginatorOrg: intel.com

On Fri, Feb 23, 2024 at 11:05:24AM GMT, Emil Velikov wrote:
>On Tue, 20 Feb 2024 at 21:56, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>>
>> On Sat, Feb 17, 2024 at 04:01:26PM +0000, Emil Velikov via B4 Relay wrote:
>> >From: Emil Velikov <emil.l.velikov@gmail.com>
>> >
>> >Currently we have a pattern rule, which effective states that two output
>> >files are produced - %.5 and %.8. Although that's not the case in
>> >practise, since each input xml will be generated to a single manual
>> >page.
>> >
>> >Add the manpage section as part of the xml filename and tweak the
>> >pattern (match) rule, accordingly.
>> >
>> >Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>> >---
>> >Noticed, while wondering if I should add sanitizer support to the
>> >autoconf build.
>> >
>> >A few, random questions:
>> > - are there any objections to adding sanitizers support?
>>
>> no
>>
>> > - would a meson.build be acceptable? Giving us sanitizers, coverage,
>> >   scan-build, etc out of the box
>>
>> yes. A few years ago we converted to meson but I think a few things were
>> not working properly and we never finished that. If you few like adding
>> that for the next version, feel free to use that as base:
>>
>> https://github.com/falconindy/kmod.git meson
>>
>> > - writing xml is fiddly, would people be OK if we convert them to
>> >   scdoc? here are some examples of the raw file [1] vs the man [2]
>>
>> first time I hear about scdoc. syntax seems simple, but I do wonder how
>> common it is in distros compared to e.g. pandoc or other options to
>> produce manpages.
>>
>> I know mkosi writes markdown and converts that to a manpage
>> (https://github.com/systemd/mkosi) and dim uses rst2man
>> (https://gitlab.freedesktop.org/drm/maintainer-tools.git)
>>
>> Any of those options seems better than writing xml, so I won't oppose to
>> scdoc if it's available in multiple distros out of the box in a version
>> that is sufficient for us.
>>
>
>Neat, thanks for the input and pointers. Will do some digging and
>provide a summary wrt scdoc/rst2man

did you get a chance to try those? TIL igt also uses rst2man for its
tools
(https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/tree/master/man?ref_type=heads)

so I think it would be the preferred one.

thanks
Lucas De Marchi

>
>-Emil
