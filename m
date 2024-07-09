Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA4E1E898
	for <linux-modules@vger.kernel.org>; Tue,  9 Jul 2024 05:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720501652; cv=fail; b=b9ykKB5/BJlj4ycnOBGNESNs3kIPF+SCcJ/c0O0Xa5VYK10y8k2kJ/d5LmLU4i8QV4OVq6HjRd6zobQ7FImgFP5bLaZrmGQAR50GJ+IB0JN/VfIL2aPRXTSkZnCb8ksTSC4wZUEKNpd3dYBgFIkB9aoNa47f/7Q6kE1afrvXUls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720501652; c=relaxed/simple;
	bh=/vz6AYmZkB2xcwbEDTuvIx6nV24BOcZOz3WlpUMaAnE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ppOZoXDOQO63TBwGpN2Gie70Y9T6JQQns/GFVUhqyMACLdvJaTt5stbKN/RCSLlN6fGihmnH1AZJKaIla59JmMV0GB4bvBBJVmpmLFp0SaQWIVY9aKA6x1Y8ZFugtWgAOp1CZJXOOUg0ZhXYZ7qQDZzi2dN1LcDzckwKnOC0Egs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9VM5AJf; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9VM5AJf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720501650; x=1752037650;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/vz6AYmZkB2xcwbEDTuvIx6nV24BOcZOz3WlpUMaAnE=;
  b=H9VM5AJfVS/YiuNhjkdL9xjAl8fQgfYxs7VF36MPz7x1b0NaiXUCpYr6
   AAQ1MftP+6L8JNkYpEpJQdZoysh7Uc3Rtp1x9Y2RJN7aAeJUIjRcyxrDm
   ALA2blpoOtNfQOLZLEwiOjVAMxi1DtpTlHypPrg67mNroy2iHiQN/FaDP
   +t6ymywC1P9fVv5OOcmOAvMffM6v6JM030A/MUjYcMVE/4Lk9Gy44Ydb3
   h58wl12qAAXxQEVK79PbSSVMGP4uM7iPGiYkaUtYFs2prJ8n3/+3A6krP
   wyD3EJ8OyuQRIQ67njgDAy5/MoOP90QQHnPnWQjDp4YnBH9CBIKlu8ir8
   w==;
X-CSE-ConnectionGUID: hbNAuCrBQouKWNLaxLdnNQ==
X-CSE-MsgGUID: I911+tgkQaO67rI7hZCcpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="29122377"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="29122377"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 22:07:30 -0700
X-CSE-ConnectionGUID: ZeLOug4sRKeGF9zjYmobPw==
X-CSE-MsgGUID: PwQCCXchSC66/rosKTtq/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="70922312"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 22:07:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 22:07:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 22:07:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 22:07:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 22:07:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9ZHCCUBSbWEC+k1r1m3wM1eTa81ajT5zm6vnFxIlq+WCz9krD+ow8NYNxlQHe6Ur9RCZG2IyYSC3AW8d30neiazEAwx7hM9cTGwfuJpNk5njnAcMtSC76Km5EOS7eY9dd2GNQLu3Hd7O9cw+bNEZb/GHhTd6sr4YbqcDoQwMCoQnyelPyfkGBfjNRQhVF25h5okFxtCiCsVC1N2Q8PS87AFgiWGemOWD9cp+2yBeq98jxxbTPuRtQNgyg4d8QWDtuZ4y4mzNzsLBejy+8q66EkOj+8y3w8iIvMH3FL5RLNaDPNTHvPXHRfTJLJB8PPrt6MhKtiVfSIbFOneuVuNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acWRMYrHVs6izgz5fPMYmCRbkH3oGMoyg5EgPtLYEpw=;
 b=X3QdJLLiVKxjy+Zml7s2HPaL9VP1IxG1HdVVBbOjl+sJG4bZ3cUG4hBuDvdpF6MFFdwOuTdyNAefqdRELlQKLUAkZ8ISVjS6G2wz/dA4UKNk9wU2AK2zChCOlH/Vq1qF1qGKM2Nv+o2tFVjt5MMDWCeXFmrYrf+Uwg54A49Q3nb1ylWP0nBqVqlVDApNfTIMt9V3cu52SmCP22uZ8g+iAv3fCZM4YQgZwoBwll5CWHh0AiB+rxcgv65PIZUYGNq7mkrtdEcs1BfADz8xqkPUZCFJGoh6BmLK3m/opKd52yC4o9eX8woX8BiCR+iACAU3OwVr+MupsTZ3AGRs/ianRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB6978.namprd11.prod.outlook.com (2603:10b6:510:206::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Tue, 9 Jul
 2024 05:07:26 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 05:07:26 +0000
Date: Tue, 9 Jul 2024 00:07:24 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 1/3] ci: Add github workflow
Message-ID: <k4yayosqlpdoonilq4zgo6zwnigxw4q5gjvg2yaatgzrugu2ya@vhyjxs5k4j7f>
References: <20240709044758.67725-1-lucas.de.marchi@gmail.com>
 <20240709044758.67725-2-lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240709044758.67725-2-lucas.de.marchi@gmail.com>
X-ClientProxiedBy: MW4PR04CA0309.namprd04.prod.outlook.com
 (2603:10b6:303:82::14) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 98fba212-08e1-4d49-1afa-08dc9fd50684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CcFifvUV6FcgSXO30DgWtmKErUvsllXlb3LF2ozKjwzODZP0HwYkNnZF4qrq?=
 =?us-ascii?Q?0kMMSx6giPlxj9zwZ0xEmHKcL0gJPT0BAPlzwq1lcQCC2/QXqRgp6RgwMlpD?=
 =?us-ascii?Q?vwJzua4CgSYpPvyhDWtcLiXZEOqbD9F8qyl130smTOmBaeuEidn14PeWycKt?=
 =?us-ascii?Q?RsmwdaMRf7jUeHfttnpE1ypWq3jpAf8pYnU+nfG5jKHAi8MamdUFyR/Qjai1?=
 =?us-ascii?Q?haoEt0taWXEIdOFbUU82UOM+b8vacVrkQjJtxRpn/BFN+64uufDluVACCTF2?=
 =?us-ascii?Q?NOjp8wkGmW6wD7P2+/LTIZzAjJE6MCiYvDG7ZRsSQK9Bka4WVGH4H1UoqOcD?=
 =?us-ascii?Q?UFSDlO0PBoy7ivodx11of58/ZX4x/PJGB3wPVi947Q1PCxDrODW0QWtdmlhC?=
 =?us-ascii?Q?XYqqpyfZHXQh0nTG1zPH7BzYwSMZPbxMBuv/OjNAUjhLta+Rl2r+2YqNTLQP?=
 =?us-ascii?Q?VJJ+mAaCt2LAZtxDFxUlrY6J/weCLzjpKUS7FAlvMKoNZqRvk7gYeNho50UZ?=
 =?us-ascii?Q?yslz2bFGlddi0Z4o9dm/68jCqY+wK9WZGtktXpqIsVhS80Aa7JOAjOjtjR6V?=
 =?us-ascii?Q?/XxGTUV6Jc45YPvkzXKmL7kJN9o2OATAC3tQxKMhh+wC8CXm50vzxLbainlx?=
 =?us-ascii?Q?Ceox0WdNmzKeQaN+QtNtPNIZUrkRVp3SKRwEklxfp5HKXuilN803Wl/vHxBj?=
 =?us-ascii?Q?I4kbr1gg8e8rJzGDhVohY8M5NgLoNrneWivicrTK5en/OhSDWcJpSf3Tla8i?=
 =?us-ascii?Q?nqHvA3tEP/DU3ydodvs2YKl4ZsEEf8Cg5j/hZgqHVhUtJdUtIj4sHZBm3fWf?=
 =?us-ascii?Q?XuFjByi4mtlmDo1nC4W/H+PCOV6E/RpO0sMiXPDc/Vf66+sGlO/r3NphKGzK?=
 =?us-ascii?Q?TwZYEe30SOpOGrY/IOWpCtvHz52sMSdbKbpimzF46K4xQlBoPTJwVDYRFTiG?=
 =?us-ascii?Q?ddA7pPQGfiT0Bi9bp5VqG6WX7E6SzHwkii12acnnYGWj5ZWxawHvv31nRbhE?=
 =?us-ascii?Q?PQkeNoc0NM+xxkt7ca2hkeKWNNArd6x5W+eZbJ69UTe8LmGKyPUAd3m4/b+l?=
 =?us-ascii?Q?omYY7Z6wNNdODjjlGobA2YjOUcbPpPd1HK/edmKu944yfCdMwFa9CJhI/E2Q?=
 =?us-ascii?Q?5NkCFuTfuCB02/KFlqNWz73cc/PabQ/8u+RsHtbbpPyoThitniQwXnM/85nb?=
 =?us-ascii?Q?c/1U15mpnFecj6Pm+Kk65TsWgBssXtSTpbzUAeY71nnDN9patoT5puXhXpX6?=
 =?us-ascii?Q?SEW11mnhWoUfe8+hXhgV/xwv6DTL+TAd8yHUr3+Y5mc6pcy1NSD6CEv75SIG?=
 =?us-ascii?Q?ffaat1USL3OqJqbLcemlp46XizIcuQMSuTn1wOo971N5KQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xRD/qnMIDlQ7uBy05fop2iKDGBnzhzAH2wzhg85y4iRSP17l8ACKA8O8lbMy?=
 =?us-ascii?Q?NGbdKFYqAzegmYcDsMjvClZV9wDkcU3vqkrp4qI1RDDeAgYUXdNVJjBSGSTU?=
 =?us-ascii?Q?UIbw7GMahtV4aiJkwDFQGvr91/5Vx/S9CfBjWZoyCFfnugaLyFRbPmtToEJI?=
 =?us-ascii?Q?RKooGwwdZ2shG4GhK4RPLsd4RF3KymucL3dTwddOa4HIvIkVNg/OO6e+8YWf?=
 =?us-ascii?Q?uNWChD2Pf4y2mB4KxlEuJhVJUFhySELqF6QPSZsUTK2jERi+1yNEEHc4vFmS?=
 =?us-ascii?Q?LKJfELSNA0ebfBUZob6+sDgxPtz90XB43i2JVbFSzOZ7oNmVxye2g2DbD1cT?=
 =?us-ascii?Q?1B9P6XHYnS670YI+HsoJfXsmQq2JcY4SZmHsFTVsHoc0n4jtXqlcnMl/RfWx?=
 =?us-ascii?Q?P17UPs6H24o96ODAP5DN4nykTgmGZesoJjwhtok1gh7VpkxfWjWXKnVLDb0o?=
 =?us-ascii?Q?cFQgBcxjqQ6VEmwI48oSZphx+wZMtZnxXfJtfGzYoH2sxURWQygN9NYywFDo?=
 =?us-ascii?Q?oE2uQB+CTQl2X2x88snt1SkNk60WYDm1XNLaR1X110Mi5IuLpuhYTHwAjjIg?=
 =?us-ascii?Q?E3wtvbVFY9+dro/AjMPNsbSr0W06J5LWxDqi1G6Q2/MIWOrrlSOHRY05jj3P?=
 =?us-ascii?Q?hZ8u4lZIX/+1yTuJXSNtiR15+0Qu40fd5bF+3cfbcF+FfIwfyb7jSBUKfSOF?=
 =?us-ascii?Q?1UNVqJ5cbqC3BF6rhaqXL7I1kyUhcAjBKtSO6vSv5BxPfg1QY8ubscNPf2Hf?=
 =?us-ascii?Q?OoqsLiphAZr3OoFl2UqMsnNdEKQLlcI6DbwP5uasJ3oLoyeOuxoxuZKaY4HV?=
 =?us-ascii?Q?mpcoaw4oVtvJYbVwOnH+WozNkxn9z1IwRY4BZoibBVcxPxv0dM1B8eg3Pk4B?=
 =?us-ascii?Q?F8LGqWDGFQose6233TBLG+1o/MCgqQVCaYSnQi958t+Q9mVVV9FNAFtk/HXC?=
 =?us-ascii?Q?NYS4Bhu9hqQQfOGpB6A2cQWNXpBfOzBugaFTblxG/hoFBRj5ryeYdXw9gGfw?=
 =?us-ascii?Q?g3qSTQIeSX4SWxRcNsaV4cvqD4+UP/6mzeK6qDYSODSBpyUJPNIuLhKYb3qU?=
 =?us-ascii?Q?9zSby72m697+ykmAlafEUNUKJmw5eNCC0o5XKNywWIp5Nbb6IcSF7Cva0pwT?=
 =?us-ascii?Q?YF+R5+NW2mEhXDjgtGq9UZoXJ4q3aQclV9PfOzLwmH+Hr+z0DU8Oxumofra8?=
 =?us-ascii?Q?0QZl5/K1KhgdrV+8GTpGX/i7q/Y5QIXykPg8noWOKkMZa4CtGDdA76L2e0eU?=
 =?us-ascii?Q?lLQiDd5bn8rNC5+BbQ4N5oYDiCYwQ9B8QpeF+mNGbtN2MNcJ8ViXBdLzrth/?=
 =?us-ascii?Q?40g9RvpBMlf7czLbOHLksK+efzlTgnsfMx1X5bK1maWzQ0zUa2nOf959eMCQ?=
 =?us-ascii?Q?LrB8r3ThZjPnWesudbYWpRP3HTuCAyIrBWy37Gist2LN8+mVvGiSERZLxSf9?=
 =?us-ascii?Q?x23aVkEnJaTeKC4RVrOgRMX6y6IfnJ+IrGvRD35dR15hSJSelXlYpAepm8qT?=
 =?us-ascii?Q?81sU/uOzrhszPPTlcgNBTvI03RP3JUpmwUvQfayuGrEAP7AOXzsoAinbVy18?=
 =?us-ascii?Q?lUNiujO/80xmCuwSPLgQDtDe06s+p+fEQvSbzo5PHd+IfqsocbpuvRREwYW7?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fba212-08e1-4d49-1afa-08dc9fd50684
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 05:07:26.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NqrYllwkgCqTsIB9Jb8od5qSF9K8yTLT/UDp9gCsM0hvUS/T8DNyebYIdMXn/V1z6M2rU2PcasrLisycalRdzEUpWSDiiM994UiM6xIe7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6978
X-OriginatorOrg: intel.com

On Mon, Jul 08, 2024 at 11:47:56PM GMT, Lucas De Marchi wrote:
>Add a minimal github workflow to test kmod. This can be incremented in
>future to test more distros, compilers and libc.
>
>Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
>---
> .github/workflows/main.yml | 49 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 49 insertions(+)
> create mode 100644 .github/workflows/main.yml
>
>diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
>new file mode 100644
>index 0000000..f366846
>--- /dev/null
>+++ b/.github/workflows/main.yml
>@@ -0,0 +1,49 @@
>+name: Build and Test
>+
>+on:
>+  push:
>+    branches: [ci-test]

oops, I was using this for testing... need to replace with [master]

Lucas De Marchi
