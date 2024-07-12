Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24E68F58
	for <linux-modules@vger.kernel.org>; Fri, 12 Jul 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788934; cv=fail; b=s/6iapMQ2EzA9iiCauI/25u2rYesbiv2O7a7oW+6pXCKX4iQ3zTcB1xu+OOnvOPcKux+W9K/2vNho0OhD+OS3S3PVUuNQe4M+dE+zV+4gW9lElzuFyFrUL6cMJdkcm2wznTo7zztSBRYmbYHdck/nz36MRtWhJ/344ZFrvmnDYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788934; c=relaxed/simple;
	bh=FcKYJZ5xmuk4nV/nM7mFecl9GCTLlM1eOSPgbWplukM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QeCYqm4KYPB8CpDF06WMRfiU1zIjDWBINGdgt6q7Fz/UvbquTB+oGzzizvyG6xxFCUXkVfqCQI5R1bKQR1e/+TCryuA4bO/PytT520oayk6ERDx9NmxN4o+j+EkZHZ54uUCk+jG+Cgx9BK6DeaAJlQFurabA5VbYkbf6sSo1nfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPQaq0jy; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPQaq0jy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720788933; x=1752324933;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FcKYJZ5xmuk4nV/nM7mFecl9GCTLlM1eOSPgbWplukM=;
  b=ZPQaq0jytUZ4tOpwfkpFm8y3fbN/ZoBxQn6u/Xf0OzMxUsoT1acnMLRX
   nDNvu6M9/eHDfrzkvS7VbAU93hfK54tR+yiCJeVWzgci7OlWVsJwb68Og
   p85wrEAsIaw2Tx7DN2uIPAXIv9R6vk/0+AzgLnpI/UScFh2w0UxzKYhwg
   Byq26J3m86463ia4Rv3xzH9OLpaYUhwfZ3tVbsQt/mmbVoabuB3OSnDUZ
   m+do/VSUxRT+x5c5NronZ326FsNqYJclTofjy6fqnrMcHuBxF5GEUyinJ
   Rekdv57sHhQxyLqT1wWDUqdYbg9f18k6za7Ef78vk3MvKBJNJe2ydxvid
   w==;
X-CSE-ConnectionGUID: qxZ2f12gRXa8S9vNrMv1/Q==
X-CSE-MsgGUID: zcChqJenTsO6fVFrcWV/cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="18359812"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18359812"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 05:55:32 -0700
X-CSE-ConnectionGUID: SfUPwXHeTOu8xZI1Zqz1lQ==
X-CSE-MsgGUID: szfnK4rXTTWsoJSmYsVETw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="48911154"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 05:55:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 05:55:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 05:55:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 05:55:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 05:55:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiYIeZg1JNOsOKFrPq1qoPbwA4/3qFTOWClqwjEhJYRxdCH2kWtuXV0FAVwCUNFcW8ulce2i+13nsyGegOKeKkmBq9MT2EQ6vIFZ0VUFUZ/wbAY4iTRvtDxzUWT2cY58j1viD5NqGyNcnAAEdX7pipqGDN6h1gCJ+/Y1NLYFj3BZwz++C8WPECsitG0e46O66TriXzDVMexxsmzSusTA8GcEYuByAQGn+ABeBrNCuKtBzDgYn0Q1Yn4vcHMLmrYj197WF0ngySmjcbkroErxu1QDBSOG36Pg5AWENeoaUxs/1zm3MH3zbrtDvJS+fXl00N1tBFOfvlbmDAbrfm2GfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcKYJZ5xmuk4nV/nM7mFecl9GCTLlM1eOSPgbWplukM=;
 b=bNiNmxALQ0V+A0ZihUTKWYCNEX7fdM2tqwMK/cdfTgP2pHTZmLXQBo5sx7V991yZQlT77pFmwazHYYSMzSFm1Uwg7YmjnS8QNdzm6hIFy8JQD3k5rBoKq9g2JuL1uOHcMow4siJUGQDNuP8QZmBR3I89X//kusyYqfVb1h4ushO2XaHdqNRHAWv4bk2eBJwKc6pNvwVqoBYw+qtyLJV4YDJNMbriAMUJxMpouynC8lvj7hAglrIoF3iDIfAHVcp7DBwNwH7w+dUHz755hdb8/4/a6PDbXmWce+LYu2fab92QqWlSSNRw5x1FZtHwMCuo9DZ9jadGQ25/sdi27aeJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ0PR11MB6768.namprd11.prod.outlook.com (2603:10b6:a03:47f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 12:55:29 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 12:55:29 +0000
Date: Fri, 12 Jul 2024 07:55:25 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] ci: Add github workflow
Message-ID: <fi3c33thrdafwqbsvdbtbw3tu2yxtm7a74jp5yu4ltb2fy5gxh@uv5laezzbwzf>
References: <20240709135007.104325-1-lucas.de.marchi@gmail.com>
 <20240709135007.104325-2-lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240709135007.104325-2-lucas.de.marchi@gmail.com>
X-ClientProxiedBy: MW4PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:303:b7::22) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ0PR11MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: b2386e25-0e77-47fd-9a17-08dca271e820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QFmB69G5iL+GCMLG1nzBtLxRZ9D+uG+taEezJKN+k4GAtb/r4FMHd3JY4XFw?=
 =?us-ascii?Q?468yesbPGFWTefSx8l8yUH1b2V0gdeqQVl7yyi01uU40awDqmTIHDp4KXSK1?=
 =?us-ascii?Q?HvZEmUILUmkHK18pSjkLrz0iKGvj6AUfcvJAMEYPPQchRun0RUNyYbajrXx0?=
 =?us-ascii?Q?EkVdBiOQ9qjhtKJLpLf07QpVm4haqTyarlMEdELRl1CgiY4eC0lRGZYk2pLT?=
 =?us-ascii?Q?ul0pUpjqO0796ILax9mZBpUyOasPGdwLqZ/X1OQ0H43IoivLHRiJ1olWP0nn?=
 =?us-ascii?Q?CuG9mqi3T/PISdtm82Aj4SFCr2kW/2n6ywN9dwPM3UhhyV+DvKGZMovjpjjz?=
 =?us-ascii?Q?uVNAoITPwR786BWwxKHszqgN/DknKwOmYVMFL7hbu0nUyohA+oUbg9ubVdMY?=
 =?us-ascii?Q?IBwaYX/gMswIL6T/RHt/kmRtPsb3BBchyZX4z1H4LRKay/wGWFqBIzOMC9W/?=
 =?us-ascii?Q?zIbQyJsDFAS5MxOccdh0mpYcFa6dVTa5gMmd1CdzH+kPldI9gs29eiNZTJAl?=
 =?us-ascii?Q?KrwvnQeHQpzYD6leGTdklEvzEwQaOnn1T9sZINA3IANKiwupX6QIKXzO4DNC?=
 =?us-ascii?Q?ZOdaQX1+/lE9L9eyxbmRenZO7GEk5ESpro1MNN6gRqdgPhWeSibW6Qw2x+rX?=
 =?us-ascii?Q?9YR9CxNucqU+u25b2Yeprleqmpplu0+4pfHkaR5g+mmQNGv1ii0VMfdzKK9t?=
 =?us-ascii?Q?J/AXI2mTX3HCW9+Yzg+1vfp0py5YPVHkfjhnytQnHQLKjlai8fQ8MSdzD+Zr?=
 =?us-ascii?Q?UMExBNNPa2QuMPcoBJBEWFsLfU7lPyWkHyb4q10Xrl/iT1KBifLWGs/mF/Lo?=
 =?us-ascii?Q?Q5wYarLXHyuOJ4oUuhsKIpsnnjHctJOsoHZ65IXSW4p1rLF4KRIkVpCp4SCL?=
 =?us-ascii?Q?BIGHYhhIJ8Vx3NVqL1ugWUSWHCSEi0sh4Gk4zSX7nYGXutLMVQLftH77xZIg?=
 =?us-ascii?Q?cK0BfF+d1C8qkSEvdvW+NFQs3D1aOpz+MW8H14t3I8bpUiBrX4lEiDjdoAJG?=
 =?us-ascii?Q?p/sQxJU+jwa8Ua1tVj6rU8at9vqnm6bd5+3CzoZ5rfms1iUDZUJ/l0ceqZ3r?=
 =?us-ascii?Q?yc1CS/jtXPXVshld5cCxcnMiCiDw1jYEp7ebd+HKerpmchBgLluryAvIuuMF?=
 =?us-ascii?Q?Sb/kqfUBaTE1pQHjvidx6tr/YMvClfuvwgHpx2PqHPDU2ZP4bLIfwMjOsuIZ?=
 =?us-ascii?Q?oLAlZ4xp7Z2MGSZTs0mrqI+h89FBEbG6QSLbSurHbPXrrIgXu3/+qDku1riG?=
 =?us-ascii?Q?FFuNV3fxGkP/zRlxMKL8Hf+dk10XlqZBC5b9024gStS9vEsSyjdrWG8uDcjc?=
 =?us-ascii?Q?hyw3KlMhS2BzxgpoPMvhDs6o0qvME20TtJevcI9u+isBpw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z/5mZHZMV4ClK0TnTnPk1dCE6x/NRXnb+BbaEIlrii8TNEXo5GCtYN9evAUu?=
 =?us-ascii?Q?imKQfdV89vIDRabk13ywicELbhie194Nvghi3VZzmnE7zMa3KDR4SHjIfVZH?=
 =?us-ascii?Q?Y7pblJXHlCGxW8YGSbbaCGHpk0itY+6Yu+b2PNccOiJmWuZgljsHVc/V1G5z?=
 =?us-ascii?Q?gRZzR1PFAZLS+8FjscWooeIKwkkjNOQKaJaflPX/FTOpnYApN1NVx5IEYKug?=
 =?us-ascii?Q?GkgwS20yfG6ObbagJzQyP+q1yFuuz2DDErgrcbSGyBOE9L3go3vCKUbugmKs?=
 =?us-ascii?Q?kk0Ob+G83LBOaq3TlZ4fDqPogF9Es3gTYkOr8aYMiCTk1S+t88anNeexzcJM?=
 =?us-ascii?Q?hjXUyhuVbk5XDsNMjixB8hMXXlrVd9IPD/ORcQihgFJGZG05wtuMR6TaLyCl?=
 =?us-ascii?Q?Ff+VI2E26PdFW3jVwfwsMWS9GkAUP/+ui+zG9MTwpqpYFq5oFBPI8izxVzM/?=
 =?us-ascii?Q?l9XaZgkZW0KUQCiktJvFMEzYDXOEKvKDJrqHqwuamp7z/vRklnPUZ5KQ6RaW?=
 =?us-ascii?Q?aFNoeKBvZbM5b3N3hby55jZQCERzSRv4qn5dbv0C1mUmwrDuempsyKzEHBQg?=
 =?us-ascii?Q?2WjHzkAZNFtobrLz2Az0MbLJZQsUA1hBX0gnbaB6/P3SE1wjR975FTu2fDCP?=
 =?us-ascii?Q?slCY3Ivu4bSKDhKC+kawe9naYKMT7icQv7rW4L/V7JkcDEOS1/1VGkZ7do78?=
 =?us-ascii?Q?AhZq49Umq3j5XZY9OX7xOL+4vXAjms/yao29CFosW+oluv7UkT0Tvu0MFAoA?=
 =?us-ascii?Q?6K+tCQFWR116qZ3vfuB72uuE4MkGtOFZ5uUU81WWkx+rwwvME5RTsUXJrkkV?=
 =?us-ascii?Q?4Xr+4pBdYVPRumjS7x8ulyS9qQsbO/jkyinaF6kZYQqyQpu3PPG+yVdY9fTx?=
 =?us-ascii?Q?eduVXJxgs+eCjOfpfAXc0s9YWBzGw5+YaCDV+bpEXxDCHoiCwBkv/lsvtfR6?=
 =?us-ascii?Q?F02YVkqIrRbF94cdgdVF+kPQxTm3iEEwXG6Hl3/Rxhlcq0xseihOgipXdWLV?=
 =?us-ascii?Q?DJSWb9L0YcX6TOXZVZPhk2FiFBuLuRmxzkgxjxr3gFvDBHFi4TPMKsKKB2zM?=
 =?us-ascii?Q?+BlOtY5lAyVj36AnDk5sMV6c+RRKhr58R6o2dTmiGgOeuVBISCqW919mZWAO?=
 =?us-ascii?Q?XzYIMe6r8NP9P0C00ksyb8TsyXQ1gXXqTm9ECdJZkzuGnx2ioxfiXBZNqIct?=
 =?us-ascii?Q?q75m9ACGn4qeJMDc7FesZTW3NZlkjsknEioCZPFWFo3YEO57aBT0DT8ToSp1?=
 =?us-ascii?Q?C+9n2keHppcRT9T0l2KFYMr2/H2nlY6CYq1fYJ8wVJZwKCbwITlI8ljr/Epn?=
 =?us-ascii?Q?sLK7gqVRh7RLCjVCrp2MWVQDtgVpJaH05uMBdyn5lyFWObBq6aE0g/atV2jb?=
 =?us-ascii?Q?3j1WunrlM+tiyXn6O5N0vzApnEtbKfXORHlmF4xSA8f4VVXX3drojYAHqny7?=
 =?us-ascii?Q?5aWb46NKMl+DwnMMnKW5yB9/acbjbs2dC7FOIvlw49gA7hpjuYFpcX5nHOUs?=
 =?us-ascii?Q?ETfKmbVdrJEpy7xglU7ezUii2So+Sxs2jJpSwcdk+u7U5mhs0LiCTiJsXu5N?=
 =?us-ascii?Q?guzok+ybufNMN9YO2ODUZY4tymfYFBJf+kWWH6Y+1GZezsQKLygyrN8iyudY?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2386e25-0e77-47fd-9a17-08dca271e820
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 12:55:29.0727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFRSPHL3mTsl+zciuDwrjsY63HIKtY4A7TowhHUPXbswRT/xhnnNfaQ8KHIvZnb2ls3zT38Z4UJCQfkZkY+XbbVA5TNSIt6XugtOHstt4/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6768
X-OriginatorOrg: intel.com

On Tue, Jul 09, 2024 at 08:50:07AM GMT, Lucas De Marchi wrote:
>Add a minimal github workflow to test kmod. This can be incremented in
>future to test more distros, compilers and libc.
>
>Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>

applied,

Lucas De Marchi
