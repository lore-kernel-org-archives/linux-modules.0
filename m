Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBECC85945
	for <linux-modules@vger.kernel.org>; Mon, 29 Apr 2024 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433984; cv=fail; b=fBIurOVOqFrvg2+qpYD83lhzvukFUBW5KoaSb2L6G+DmQagVB+TjufZk2oVFF7MAzOMmTZRjrOp6kX/Jy/UgDdEawgSgfcgU9paaoFj7XRHnV8VOqbN0zCJKInVNpIWvjcuKBg4oEdJNuYHqB4ieKnz+qGqdcNtrhSYDM+YBC6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433984; c=relaxed/simple;
	bh=yjQIjj3U3O8O6N7vXZs9mP5cMfhUb/miVPu+mmKuV4M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ku8/miliZ1sFHt74ixR24Yp0YQr/U6RwFbBuWtifEYmnWSebpEmG5rquTLtexxkBqAHv9gqKg76eApkixQP315w+aV+ff0nnPj0H7U3aZeVUKxE/0BK1n0Y/6IVD8x6NoVgdtGYGlNk9osF15TlYqhl4DBhzVf3WhmfxJEtYaYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eEWEPJs6; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eEWEPJs6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714433983; x=1745969983;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yjQIjj3U3O8O6N7vXZs9mP5cMfhUb/miVPu+mmKuV4M=;
  b=eEWEPJs6fXIQbapkwHikypH0arXFWcUoiY7AakpbkjPK0y8n9VdCe/Vb
   D8OYah6YbwO93lVXfjoUfALr/7V2Kg+tf70GFdOclJDm3YozsThCFGmFt
   ee+A2n0xDhcTJseGZte044zeVNNtJMtXvqq8EP6ipcx91eys+1h2IBTPC
   SfoZnrJHggYEN6X+MP9M4c4oYTcuoToprhnEZCQK78nUGSezvZMHjWqxw
   JezuM4BBT/txjF32h46OuChw6TvYTM2tEmXI23OzhDGqUrfuZpJnPWksd
   woQbBDndE/E+MlK61iVs/kRxHHn6LjabPpBjEIA8OVCI7Pda0if8iAvnR
   Q==;
X-CSE-ConnectionGUID: vQmFtKg3Qx66/bH1PVtMdw==
X-CSE-MsgGUID: ZFVK5MjmQyCDTsFU0yZcqQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="9965030"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="9965030"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:39:42 -0700
X-CSE-ConnectionGUID: NK4Cc5aTQSG31wwdyVxHDA==
X-CSE-MsgGUID: N3egfRxZQd2lSXUrLfId6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26347652"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 16:39:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 16:39:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 16:39:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 16:39:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bh1lKGX+MlMm2ARj0pc523udsQp1jNQnzJeUai4lCnzGLiJHh3pHvDz+xUweOPo9Wj5TRB6qykqcO1ji8ddQU1m/6a005ArMwz1ki/2P6EUDMDrfrZyZRu7QbZlHfsWwcy0D9BHolQv5F3gatM3pvcdNCZe/qcffJjVRLFm3lV+1aj67IPaDmMrcYEt/L4R/xPxEVbgnONPEdpfZJTAMD4fMWJbp1wg+SindiFyKUHDMre60f9UzslK5qubk05hEAgbBcJIdjyXXzkQ9XHR5IiKgK0zOk+IqKxMBa+Ued9SnugBr+YXuO91P3pRQyd51fhRnqM7df5qbvLpSop0cow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeosG0hI719BjRqA0h6ecC2Fu+FSRsSB97WW4QaeHS4=;
 b=J5hhaequd+leCDzSibsGi7ew/Qrk9+eUUs3aO4dGj04AvFnAnAMqPlu9MM3uc38nM996qrkaxP/nZqP2Ql6JvRTxMXPvW75V5UsMV9oOmG+6NttTFu7KzqsObo3IXAoYhhHAg9LJkmewA0sPJYC8rMeqCqb7rAhdrYe+W77/GKwjfd7Xxbj91+7Uy88n8yUjyEHJ0wOJr5sG7PYsBMvLK0VBuWuGQI6k0V0lb34jsiieQ/zGEfzrf5495DtaqDuVAKro9dP2/3A3hm9qxD4ecFCUFS/n1/PyNXRLAmB7iIXzEuXALhvDQkyMuRUpQGNJOheVe4I+DZbqk7iygEd7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA2PR11MB5035.namprd11.prod.outlook.com (2603:10b6:806:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 23:39:38 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 23:39:38 +0000
Date: Mon, 29 Apr 2024 18:39:32 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>, <mcgrof@kernel.org>
Subject: Re: [PATCH kmod 13/13] libkmod: always fallback to do_init_module()
Message-ID: <4gbaobiwemc4y6ztn7zxbn3ztxc4jydqjnpsbcfp2ejhaanu2u@cjernf4wylda>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-13-06f92ad07985@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240212-decompression-fixes-v1-13-06f92ad07985@gmail.com>
X-ClientProxiedBy: MW4PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:303:87::21) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA2PR11MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8a9b72-a5e5-4d90-d59a-08dc68a5a27d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5hddhn94S+F53lic7+oSIchHP5M4E108UKdiGyFldrb2Y/s4yr6BAl3TwO6m?=
 =?us-ascii?Q?ZQgRcIRcVb3GenG7h+WLXIV+hxFZebQqp9LquMxE95uCkaRukqyQwiE3A+8a?=
 =?us-ascii?Q?eQZQac/rH9r4mDtaqttTqlVH7q4c1ficWgMXGgt82rwHFNOOeRRtSjZZe5a/?=
 =?us-ascii?Q?3Uea7M9n5CxN44k/FshXYOs0Vs8MRehROvxEuMSRix+SE0dUDAhc/5eAgghp?=
 =?us-ascii?Q?UaBQ6785vpnltWWvQSjqdigmxbVCyjrVp0o0GXB+HtYk+tL+CDoy5Gntyp3Q?=
 =?us-ascii?Q?DUIAwwrlxPe41ETFbtiiV19Uj1e3oVH+ni+3ZqdRpWo23swSkG15dDb8ev02?=
 =?us-ascii?Q?xMzIIxRw5TG7IRqo/ur/GCAoTCpKdXxDvFNN3pQyS5zMFCIfiiN8Zd7lA9ly?=
 =?us-ascii?Q?+Jg6oHzqnR/hCAk886GbgSJvTrXKwYHQjVRs9rV/f1R2b9Whywbhfbafj92v?=
 =?us-ascii?Q?6vWLxLQTvBIVYLi5ZLEx+DsNbMaF2oApz+Nv1AEBjlzC+iL6EJ5EDiK3pq81?=
 =?us-ascii?Q?Y9b4AU2mIUWQwshcVnlngXZE8Eb6IwWOpNr8u+e5OIrmLyBRbx+ChcqCj50g?=
 =?us-ascii?Q?73zGQNXJqH6iBbicU7ovqb2w8uwtQM7mXnZGYC+1Ul4rS6qU7vHxkGdxTI8I?=
 =?us-ascii?Q?Igvs8gK0hoeFnNnU143i23zp9mozimYkYUPeW/8ILuqfl54EeCs3j6i0ABXn?=
 =?us-ascii?Q?ATTl/Vcu/5134rS/cw2ftwtnhV8ibH+X6RE0CnfaRchAToQmJjqSGnLt9dPK?=
 =?us-ascii?Q?cfad5mdBeQ8cMsTxihpaiOkOHOlgU8veUSCWK0UTiDL78kfYtMYSGJg+QNrI?=
 =?us-ascii?Q?JDPdRGIsqX+lFDm4FlnZM4kDxFQjH/P3ko+93hydn956E+pyItvzJmEB1hLd?=
 =?us-ascii?Q?cMT6lGfWvsNG2uDmEwgSyX/wmV/mEsXWEfQVEPkRmI3KHaMD9qIl8AbCsz1U?=
 =?us-ascii?Q?H/nHBmWxvgyyCvj6Yf3Y67f/DZv4OBIv369MDf57npFvoDuWrUuOvLDz7cWL?=
 =?us-ascii?Q?qsp6r4NUrj5G0RdK65TUUzGTvlPca/LOi9q+eH013jpNBrYi8GYp5estAtwE?=
 =?us-ascii?Q?L2oy5haC2XqzG59DK/XP0TcXu7yK3pOvt9Okn8fL2FfH6yMTMoslSlSeFyLZ?=
 =?us-ascii?Q?QMrs1IdacpOGN2UAcIobHN2+K1Sw0QP7kdPAiG2YknF/uWfojHo76W4hgyTI?=
 =?us-ascii?Q?hh3N3U2Qx9Y6AQoTFwPJd+6Oc1GTOqN6+noSmZBLwWIf1BVWpEKy7Wb8rsGa?=
 =?us-ascii?Q?JXO1qlEjTirVNszVBUqAvaKm4I7Q68c8B66VWjjWTQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d/oC3eDMuoOHsril5RonMmUnzwAv+YHFjojqH9ixgWvyrd14IIROze4ndoIZ?=
 =?us-ascii?Q?7VRe8yPKVRHfe+pYfXcy2qqr7ZJKV9zSyaOvu3lvBU1VNty2HAs+DQyt7Hf4?=
 =?us-ascii?Q?w/YB9Dz4cqyYDtmDUKM6lNpxA0W1BM2Yn4vqLY2DfWq2pIwWNSc9r2+vryU1?=
 =?us-ascii?Q?csISqiRCBf9ne0BEwc11V9tWJtz8zValb4Cd5eeWa0maYNocS1M2Zhd4zjDf?=
 =?us-ascii?Q?/miJrrVy1zFRGJpcgV43avTtEK73rEOMuBEgcOAy6qMvjDBqRdDatEkSpKCC?=
 =?us-ascii?Q?4w1M0pCIxXtdKbcfpxaAk7DujsAyrGQXmwpPICUuMOWLWQ3PbsttaDmvRrOh?=
 =?us-ascii?Q?EWCxlCAI9+E83JTY++0St1RlUxF4WwOU2R0LLPgpHR9EetpaijYB99iyC5hm?=
 =?us-ascii?Q?OXK8jJ4S8+SR7bVYe7MS3lRc0Gw+unu+LBg66LyCpUEQO6mhawWMh+9IJj67?=
 =?us-ascii?Q?YgD7GVE1U8ub710EDuhpCrX7Gv3W0gx+SAg/9BBXD6z+TS2ZMFm40oAdW0Um?=
 =?us-ascii?Q?+rfbvo6KU957bdlQyD7DkpY+p4xqXjViugDU+m1PiMEM4tQpP44hVPe2ih+F?=
 =?us-ascii?Q?JmXJXZfC3TkECtTOss2GLnqPCkn6Dqu96DAhXc3l8Y4cgfMHblOBYAKfzOzd?=
 =?us-ascii?Q?7AMGOrtaIlvVz5xz6viUIGyQv3UZep2l8m7Ujsk05B192jdo+1V568ryN/wf?=
 =?us-ascii?Q?Gsg6IWNh/VN+iEqIINxpEXClCZtVwlGSI8o5Fykblw+Ih4Y+sC95FyEcvHwT?=
 =?us-ascii?Q?UMDMtswuJM/f9Zbt3+QL4bDoHkLYdSZtd8g1cKEdr8vugCekWNHisCsdU0cb?=
 =?us-ascii?Q?tBdlksmhmA4bp1RDLP8TOenTofEbCBqb5OZrBfURq2JPDXGw4DbGULtW9Bug?=
 =?us-ascii?Q?1eaLdZN6w28TpJOkBJGcKYefLUiQ1tt7xlYmG9pJIxazZlE0yp/YZSzgbJHZ?=
 =?us-ascii?Q?HWtkHwOPq3HSEoH1qS/KWYuYxRLDn3rMwMyVPdcHxRbVyA4jqLAfm07woleC?=
 =?us-ascii?Q?Wua5N9wsOZQWIr3n5ONLblROUlSFkkZZroejGdI3L4a/D03UtEmJj2hwv5mn?=
 =?us-ascii?Q?oXQMWt6lJq3iMQcdEIaOWuVBpSFbqjEH6yKSifdNVabd07mhIEd3++UkawN4?=
 =?us-ascii?Q?N2gOChCcJiskUpZ+kZl6mOurUCGk2ADYnqyoX8+OBmas0VppGCeSa96+KQLl?=
 =?us-ascii?Q?r/ngDBNHt7qhaaxtue7R9DqcZ6OsZa/JLXfZKTNaIJ63Ql8AxLbjDZxd/iD3?=
 =?us-ascii?Q?+zNhnwNr3mZdAsX3pn+2YhY58PptBObyZ2+Br+9wop9prCmwYkt/Ltr/NeDx?=
 =?us-ascii?Q?j4k/pILYX5KaHovnD5KmlkMQeIJmwUp2Mv1OJqbSvxOPXqaH3AIaDHDPlTvL?=
 =?us-ascii?Q?QJ6r9aCnB8Wu9b5dkALdreQ7nETmXVDjH53zyuFJy3d+KAYpe61rD7CdRZ5v?=
 =?us-ascii?Q?WjJ0QfHN9t2ejkdQZDkNyZOLa0a38ojhMna3oNn9FmXu71FCJCr5NN3oVB61?=
 =?us-ascii?Q?vyi90cW5ljCD6RT69qx+EaIwTf8/o2ZGlKXQilJ38xu1oAr2nyWKiRuDtmjX?=
 =?us-ascii?Q?vldtgOEJMD2kI3MJqGumSMOdAFprD3L1qk3BuqxC6XFLNhbK3R5CwPNSbFbM?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8a9b72-a5e5-4d90-d59a-08dc68a5a27d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 23:39:38.7745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlDOwPbgR2DztYaJXrjozewOiF2HAuTEDmC4vU3xdkGx1RYdQjXFMbwY/COER2ru/MvbKSGv0WfTV3C7u8i0y/OXRqKNnYOft087PqEJV5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5035
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 05:23:14PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>Since the direct loading was introduced a few bugs became obvious that
>the compression args used were off - both in-kernel and dkms.
>
>While both of those are fixed already, not all of those have reached all
>users. For example: for dkms I'm aiming to do a release just as kmod has
>theirs (to align /lib/modules <> /usr/lib/modules support).
>
>Although I am wondering if we can indiscriminatingly callback to the old
>do_init_module() in all the cases. This means that we'll catch any
>in-kernel decompression issues - invalid args, ENOMEM, other....
>Although for others (wrong magic, perm, etc) we will end up doing the
>exact kernel work twice.

I'm not sure I like to repeat this for any error. Example: if we get an
EAGAIN we go and try again?  When thinking about the recent in-kernel
optimizations to stop loading the same file again over and over, just
doing it again seems like a wrong approach.

>
>Overall the trade-off seems worth it, so flip this.


I'm not sure. I will keep this out for now and apply the rest.
+Luis too.


Lucas De Marchi


>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>---
> libkmod/libkmod-module.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
>index d309948..2c0d46d 100644
>--- a/libkmod/libkmod-module.c
>+++ b/libkmod/libkmod-module.c
>@@ -980,7 +980,7 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
> 	}
>
> 	err = do_finit_module(mod, flags, args);
>-	if (err == -ENOSYS)
>+	if (err)
> 		err = do_init_module(mod, flags, args);
>
> 	if (err < 0)
>
>-- 
>2.43.0
>
