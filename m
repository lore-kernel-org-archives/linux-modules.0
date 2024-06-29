Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1758208C4
	for <linux-modules@vger.kernel.org>; Sat, 29 Jun 2024 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719681196; cv=fail; b=nWcA5R+Tb2i0nmw7GACFgP0dIFyzhIr+VU1hsZ65iUGLilSyHT5KCdW5It9aWuHM9SuiS8nYerRB+FyfkAxs9utICoNDxu/4gcGOZntoXId4ivLIdlPpet85GfPMPxfbwHCK3x4qyeXGtl+cRbGtgO5AqkQ0FrWLmeIQqqTEbjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719681196; c=relaxed/simple;
	bh=GOkxrL9U1G8WJyCzNb9vEeQL8v6E/3oAuVqU9VvUAuU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sxnSePLf3aHuHbGPHV4RhqWIfe4FfWzNVKRPP7xKDVi5xFhlNb3HgT26mmakLW2gWTJvHhUIkUTKLbUM0hyHkaVkBRa9VtfitJJnbgUbR08rp+GgCb8JE0ykfyPXI/gSwYcyuhec9UOPnyv4Vg8jXKnq8BK2cKDRqw60e6HrH7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTrFQl0o; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTrFQl0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719681194; x=1751217194;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GOkxrL9U1G8WJyCzNb9vEeQL8v6E/3oAuVqU9VvUAuU=;
  b=cTrFQl0of4sWP0jUcGCZi84L2cs154WzWAvuvK+WISQC7BpTJIdB9CRM
   4aoGBgKZYvc/GDR6j7gLZxAdyC/73oT+AH6NOsxL/k+bZOi3MKSOZbwv8
   9be/zcAkKfa9qdwTqKf0n8Ou4koQ0cUiN2afoxxM+EURal+lv/yLpoRdM
   5OnSkyryyN/chHzl/l5WkB5lknJb+Q2EYUUyYx73vNbgIN4ws5ijK3tYf
   cjW1OS1T+zLsYLl4hPo0zwOMewX/oR6GZmh+zVQkVi86AL8gA3+ouQwDY
   aXmSQGrLxzN2QuPYbDZC/ePUVWcSIRwxHZ33Rxp7VyynPsldDLfgizQkI
   g==;
X-CSE-ConnectionGUID: kVsHN9otTkytX2NpuoTfjw==
X-CSE-MsgGUID: bj2LJrEnQq2JSDG50aNXQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11118"; a="12316857"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="12316857"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 10:13:13 -0700
X-CSE-ConnectionGUID: ocRmHC0eQzCdOlk5TiXBMg==
X-CSE-MsgGUID: ettY2O+EQ2ubUEHRiw5CHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="49390741"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jun 2024 10:13:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 29 Jun 2024 10:13:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 29 Jun 2024 10:13:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 29 Jun 2024 10:13:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 29 Jun 2024 10:13:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyAM7fKAljW1TLnP12tB47kLL1TN9cHwp3DncZLCPdJZdJML5eIf+A1XcyP3jQ6g0jgwUGiH0/fUl6IQ6JX38KoutX1fL7aWtEvkoLH5ufuqc3+o1ourbSlPci/foD7s0ys3UCcYbi6+ZogDVoAk081i78c35Q49yoQ+TxwCToze44l5Q3LbejIoe/InjQLSZCDxfol7pqQPT9u/xWF+t43wqWVyaT6g5JI6r38RAG7qNx6zxpJc+LORtcRUBF6v+am3AovtbDiFQSr+xnmmKY6l+tZbRxiQRj2m2O/1Zgch7TdhvNleoaw9OjcGMthLuWLMe2t+k+62Z056vsR9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1HcLJkjuU/reuT0zs872UxMcCCGjDgQN49NeQPMwD0=;
 b=AcZ87u8CKJFnLmULJm2B01iS48wWRbFzQJfR4bUh8s0CXXb/veTXAzQTht9TAuzM95ol+IOkTAw7Na3V0vIMeaK489UoiJ0NWIP395WKzhB63g6prWljg794AQ5fuZmiU8yZlP58PC8bz4GoQR4hUkDlITOzZoiOFkd3aPIascllCjOBmMy6Cr6ZpzT8bwPjrJ/qj68DdbCDkuADFi8hwOgx4Fh12mVIVwBQEVF3Akq3edaMlMC17Vr+VK6DkLf3aum7P+P9FAgW1eSdpKoWxArxWbtkr8mTCuNye5mOacXBrFB5FrFDFmqTcUsy95naDonHqqI2Q6tei3BxBPd79g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH0PR11MB4902.namprd11.prod.outlook.com (2603:10b6:510:37::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Sat, 29 Jun
 2024 17:13:10 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7698.025; Sat, 29 Jun 2024
 17:13:10 +0000
Date: Sat, 29 Jun 2024 12:13:07 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 17/20] man: modprobe.d: mention about
 MODPROBE_OPTIONS
Message-ID: <dqruyoqfce7cycl2fm5e3yxnfoumaihmvvpnoipvttx6xu5px3@szi4grony77j>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
 <20240611-man-v1-17-bd6864d49639@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240611-man-v1-17-bd6864d49639@gmail.com>
X-ClientProxiedBy: MW2PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:907:1::22) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH0PR11MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e2ebd6-f4f5-4301-8c93-08dc985ec018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AFn+bAtSv2bsdEobPtobqYf+Rxsjod6UQ36UuQc1XtdBDn52PaUyDHemFAbO?=
 =?us-ascii?Q?Pbac0OLoTIyq/UezIaXhddPNPRFPg6SiV8+/i+qIUvVRiAFBPc/3IviPpj9H?=
 =?us-ascii?Q?iS1UhK/6fBoPyD0d6wbKW0HwCZC+73GjQf9A2PbgJ0n8G7zJS0lp4pCw0Uu9?=
 =?us-ascii?Q?3ODM3Xrfb1Ly6EN7QTz5rUEH2Q9cRFxACZtDY6MbIwXPZ3gONdxezKaaBorA?=
 =?us-ascii?Q?9ycFACwIjmQ+QfCXRp/SzdHmOPGNV0HTZ+mhhW7g9V3H+9q/NLqYzuAadK68?=
 =?us-ascii?Q?5ONMg7qNHnzhAmfG+pW6Yp/bIWYf4YRl86FQ5M6E7YlkJRF1TPJy4QpCidjW?=
 =?us-ascii?Q?caBNngwprtLNRotOWzDfoe7LdH86klllv0a/52zbQ1m1UWpF6AsjHzaNljgL?=
 =?us-ascii?Q?JXuel1lpSPgcUqRhGk7dO8Y7Nfg7icCqScvHjbyyaj/FaJhkwDSk8EQKY+Oy?=
 =?us-ascii?Q?igf0SasFnhrmyCSpUJWNA22ul71YYxniE7vfdc/t3YzCWHZAcEE932ClJt7x?=
 =?us-ascii?Q?eOQJbdJS662HI0upxKPNRSLVWEROFffiOECe1WB3MPcDyuAPZolTFoUaGnjs?=
 =?us-ascii?Q?jnOYVyOI3LB7Ag/N89F8AUGi+uLxMI9ifOEpefwuwFzXQNQAPISzX3m+62UA?=
 =?us-ascii?Q?VWJaV6QFxrfxt9Mo+LormwY59ikyzZuHTk+zS1Iu01EuzAeS5Vmi9K7BqPwq?=
 =?us-ascii?Q?GHyQLo2yIB2iu514Reyt2LVorhCh82MyHhfNsL7jO9HrJZUyyyatXkZNONAe?=
 =?us-ascii?Q?/F7Vkap8YgY0w1AAbhDwwLxxMz2DewcJ1ZS/QnGlsgKwCg04TL3wCKxThGq4?=
 =?us-ascii?Q?m2iRgozL4Lbh8qCTBCRuHYIabTy4MBqQC6tBVq2DhgIdcSLIqCeuCfKxMtvC?=
 =?us-ascii?Q?6DLtV9qP2e4KOJd3snFzRHaah52wo8rzf5Z8LVfgtliMSo1t5hhhk24LR4eF?=
 =?us-ascii?Q?cKEqffdX5jC0Ruve1RRnI9vr3Rtti4RnFmwDPT2j+ccniEddQZuDJfAPiaUK?=
 =?us-ascii?Q?cNIHd22MI4dK9/G3TZMg3Ev1TKx6uGMUbLPp9dYOD5TOYN0PDPi7/0qx6dtG?=
 =?us-ascii?Q?d+5w8RFXkXePMRbxGJYHToUFeJErO2fZUS+U+YPQpvdev7zfKAR2iDZTxm7L?=
 =?us-ascii?Q?+ju5F1p7IOrQbjwQ1WnYn/+7es43KlyG4Tm64Rc2CYP79UOHwWf6F2Fhj2w6?=
 =?us-ascii?Q?w4ThNvl7XGr/f9EsDcWK/Kgo0dbtf0WnscQpmuwIc3nhNajz888547jSMlwF?=
 =?us-ascii?Q?Jen4JCeUjk/+fFuzcKmtv8Z1mS1xn4vf5JimQxUvyFmPu8I8oBQC4qwETLeb?=
 =?us-ascii?Q?VZBh0KPifcWotMgIzID+XaOocFTvCOlCFLW3BIC0kMJB+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ut+nsb/KpYm59/EMEqgwwDxP/sTB0UKXwegRao3IPFLl4OhA8L7oXHpLAUDM?=
 =?us-ascii?Q?qnAq76E36vC9qRwfkEaa9vLANv0Ac3Dy42+oaGJZ6t9jhpU2I8gj2ODNg/us?=
 =?us-ascii?Q?wZ1KBsO3bmmkAd5a60jXBO5go/4MCOIY/y/lMcmRSHi+W4Lu+wBAV/vCTY36?=
 =?us-ascii?Q?zJtcTh3iDbDGOFDpaAia2yE7aH15BdrZVpdyaUY+Gam6uD7wfXuPuxROSso7?=
 =?us-ascii?Q?w5uGtI6iDLqgoTCtiU0MSV9myyZAfIPclQN/6jCysXoLvpAlIYlVdR9MwciS?=
 =?us-ascii?Q?dkI4oLAsZLHCiV7B9PQtcTzpgE2sG7eJqiFysGqUTUUHXPbYHIJUYmTD0D16?=
 =?us-ascii?Q?F7hZtx5JGxrqu6N0Eqs2+UJI70TyMv+nLI3VMK+L6pzWYU6a1vhmEM1DYidA?=
 =?us-ascii?Q?NCc1XqSrwoyKNE50+jIlZjaSmlYw9z6yqtAyhoHaFAkcEOqxQauFCqrrV9uH?=
 =?us-ascii?Q?SqPPd+wnO+MeBMQa/x7FiBbkkboYO4VuxnMk/gt+v1Z33Y0qhf/ejpy+xbgc?=
 =?us-ascii?Q?sib1bGVFH1x0TIhIlVxzPZguHScgHJ3+3w3EL5fMRvdFY+8WlRmdcqUlrmAN?=
 =?us-ascii?Q?B5937MjerCUj7wrSdgCHhgZKZ850S4h4yEjepCnfB0jmDu8qbFDo66Et5Gi9?=
 =?us-ascii?Q?/DlagMULOQ9fKPXDYNdwAgBRIKQSxqvsFHOtNVXICyqlbUovtaBAG9LxBm36?=
 =?us-ascii?Q?kq9jtE49H8cnIwpvEVhz5nyiWXwU5SHNFeOag0YVaNqMAwtofjjC0sYCd3TN?=
 =?us-ascii?Q?5vRAvg0DmvoW5zSQurL1+VXpOYHOPU1wvNOiqG2KGGZYiJgbwLoUSmdd9jDq?=
 =?us-ascii?Q?Z5QrtIddEZ9YOHh26sD9ZnZdJI3m9jABs6wBJhXQjKGaBv9oKZ+aswM4jRuJ?=
 =?us-ascii?Q?UXDfqNfr+dVUFosXybessiAePZdPZ+VCVvNGNaJGCyxq6uvkfOFLtBXhIN/2?=
 =?us-ascii?Q?+56XQSfxs/ZBisvC0c7FUQTQveI6OGVdgmRWwd3zmmm5CrLBuvPyQ1xDkcvc?=
 =?us-ascii?Q?jsHHnbHBvySz2T61NFqMpicQOOlgbjDGLoa5bn6+jaLEBPh29fBYPnwgXx1U?=
 =?us-ascii?Q?8peM8B0dr92t/uOE+ty+s4JVaUAxan3oT+QRj/BMIPNqcjeJi6gvTritsl/j?=
 =?us-ascii?Q?MaUWP4m9To5w+Ube5Kit8PGoXzemjVlG/Fpujy5+swa1Aht5RXPOwBuFo0V7?=
 =?us-ascii?Q?fDvgJoZBle2kP7df5p1x9OWisw2mg98Yi714sjPHl+RSF8c0zkfNtn2yv4x4?=
 =?us-ascii?Q?wMAq+C9btO/Rhj4k9ZkFgXerg1oamJRApsLaXk5v5SdA35nhX9J46VEALBRP?=
 =?us-ascii?Q?tHcRJy2tVaTSUYQXgBffg8B6NKcEaRVONNUv4s/cuPyvQjMtntixmtLdbl8+?=
 =?us-ascii?Q?SfZXZckQ3P+IMZHua5ZI0T7PhaIBszME//V6Ty/EgQR7Xk/Si8/trIuV6bKT?=
 =?us-ascii?Q?V7dbmc2JxwNpW3a9KIZOsCBkSOQxoYssyVbknUHxOcDW1+ISOroFBDmKlaev?=
 =?us-ascii?Q?Ie3pJtZeJdDHMAhRSA9ZJuASpSrjNe+yo0vM29kBwE8DBODycwhCOtR4lIRD?=
 =?us-ascii?Q?xdrB+dMV8kV/bTEkzkuMMMlENFkEyEzJhPR0me2+mnvgOASTCQ6gmjZU9TJA?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e2ebd6-f4f5-4301-8c93-08dc985ec018
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 17:13:09.9988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yfjK0WoGc0Ct+zsg0DR8oyEhEaN6ozazVFJlhmvD9lmCRBsGIe2EboSoRQciNSuzrdD0z+Lxix3slrchzs+rm5dgSyid6h/vRNOC+bi2dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4902
X-OriginatorOrg: intel.com

On Tue, Jun 11, 2024 at 04:05:17PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>The environment variable alters the config file ordering, so mention it

nops, it's not about config.

>in the man page.
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>---
>Hi Lucas,
>
>Looking at modprobe(8), while the variable is mentioned there is no
>details about:
> - the format and it's stability across versions - is it ABI

yes

> - is the same option (say config) allowed multiple times

this is not about config. This is about command line options.

	MODPROBE_OPTIONS="-R" modprobe ext4

is equivalent to:

	modprobe -R ext4

the format is as if you gave it as command line options, with a minimal
of shlex parsing to allow quotes.

>   - if so, does the latest(?) instance override the previous ones, or
>   - all instances are in effect, with the latest(?) having the highest
>     priority

it depends on what arg you are passing. It's exactly the same as if you
did:

	modprobe $MODPROBE_OPTIONS --foo --bar -x -y -z

we will preprend MODPROBE_OPTIONS and expand it.

>
>Can you shed some light? I'd be happy to put that in patch form :-)

yeah, it would be great to document it, although its use is kind of
discouraged, together with the reason for it to exist, install rules.
AFAIR the reason for it to exist is that when we have install rules, we
will call system(install_rule).  Once upon a time distros would do
something like in their config:

install foo modprobe bar || modprobe foo

... or to simulate pre/post softdep.

Lucas De Marchi

>
>Thanks
>Emil
>---
> man/modprobe.d.5.scd | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/man/modprobe.d.5.scd b/man/modprobe.d.5.scd
>index b300758..9d03c49 100644
>--- a/man/modprobe.d.5.scd
>+++ b/man/modprobe.d.5.scd
>@@ -46,6 +46,10 @@ the SYNOPSIS section above. Files must have the ".conf" extension. Files in
> @DISTCONFDIR@/, and /lib/. Files in /run/ override files with the same name
> under /usr/, @DISTCONFDIR@/ and /lib/.
>
>+NOTE: Any configuration directories set via the MODPROBE_OPTIONS environment
>+variable are added with the top-most priority. See the ENVIRONMENT section in
>+*modprobe*(8).
>+
> All configuration files are sorted by their filename in lexicographic order,
> regardless of which of the directories they reside in. If multiple files specify
> the same option, the entry in the file with the lexicographically latest name
>
>-- 
>2.45.0
>
>
