Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E553D393
	for <linux-modules@vger.kernel.org>; Wed,  3 Jul 2024 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720044368; cv=fail; b=Km6nbS0WzhI+hdx4/LAAz5AfeMQwthotO2+3fo5Oelbhb+xl+1gSYpQROPoCMtXD3DRJiwlVXtTzLHRE8Fo59Xh1CvzcEjDYNwxEbBvP5w7awL9YXeYnamNk3YVCuiD+OF7OGeoTfKra113VM7XDiZQtbkbtDNHSb+EGD4P0ulQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720044368; c=relaxed/simple;
	bh=a9VfoWywLfGJG0DT5akziDNOo8NsqjBNQj2toDsUylc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g2GAWsF9uo8DQEux6mybHmxE+q+QEAgfzdQR9RfHBG0nbTOjQIo9zw0u+Dax1Y0j9vrgyRkmw3gwwEW9nOnHeCxMeIIDEdIICI35P6voBdi5/5rNumnZm+xl+/ThJJL11tXGfwTU6j1+Go6wKCSmScOKEokz7LDxteBI2rDI2y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8X4GwDO; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8X4GwDO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720044366; x=1751580366;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a9VfoWywLfGJG0DT5akziDNOo8NsqjBNQj2toDsUylc=;
  b=Y8X4GwDOH/Zt1DZTJqDOB8s2NJfK8iwPoCrBDNR4e35mJHExX+ygF1Pi
   iEjh8hCY9AQi27Iz9gvEHVe1tIGr/3o05L4A/2laKgGKfTNfW4tzfnVoh
   PqZaiK/WT8lpC9WzAX903V9p7mhFvol5s5l1OBpnm11c6o+LlC4/Zhjzj
   1zVpXRXxMIU9mO9tjX1jFFHYg+0diD/ZLSdzsA7G6Wrm0ZWq+oogwcLuf
   bGmHGxX05BbvH+zRGEI+lSHExs3eNhbHsmN37SqS4QTqBi+wTAP6Ateo6
   ScAavj94Mv3zhxhzAg/+eiM7e9S5oP903piYY2+A6NA7HvWI5lhBeYZDJ
   w==;
X-CSE-ConnectionGUID: jg2R64EISKm7VXon8/Bfvg==
X-CSE-MsgGUID: hAUQQwgoRdaJOJx/jRG1Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17513497"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17513497"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 15:06:05 -0700
X-CSE-ConnectionGUID: /XGfR8FVRs6i/OkvImGu4Q==
X-CSE-MsgGUID: /TXMAeL9SJO7Pt8WOxxTmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51248484"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 15:06:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 15:06:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 15:06:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 15:06:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 15:06:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTYVx3029HJc7jyYNOs93VP2aZWRtT6X3/49FABabcVxS3ekFYTc0KWhY5L9qL4bSxTg7PloOyDtOWyj1bJibOmsvnYvFu3SpcUFDLG+X2F/tn3IP0jEPGQLbqoVDoH7FYSxhRJ9QarOdDi8QPwc4IuD+jkrgufiDeGhLJ0eBv1AfcLvY5MT9GVWA3wNig1ZxRvMcQ4SkQ0u4HuYvSuz/ROEztOjRyS6h3O2oVKl1Dw2pp3HzGiLjrYqHLb77ORbVmZq2iLlTcXXGWovp+MvTdZlzRDqkQaXYRg5OTuqkb48AGSBgU5YH3scgR3J4DminJdXPk5SHAf2tjnPx/MfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKWJH4QMKgP10gFGJOzZ9e6Q8B8apOxshWbvjVW8AI4=;
 b=TlvSoDJV9sNWSYmA+b5TS3V9e2kUYtFcyHEWFoc3zeVl/ACZSkWG8KJnViGjpVT2s3fQ8eZT1MKBnU2hbF3zdvQVMhw3+YNwBFKQRrjAC3FWHdmlXNeBagrJXIyEX0J9xUfFU2kbNAc7QosrO0eNTFFXCh+1afWslRX4LoZHE0tdmqssdXK+ZW+8axjHsPOTONmE8xZAgx+FU8XvM9LjHpMZmlnsHQ7qIeA8AoLMmjsFxuqflOKdyiIdklJm1i58DiwbZzqf4miWts0b+u7JzQJ8gd6ZSdXjVJNFRwebFp/H6DYjV8jBrtuJTleTNGINklvxMgOkFUAAwNk0pqbgow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Wed, 3 Jul
 2024 22:06:02 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 22:06:02 +0000
Date: Wed, 3 Jul 2024 17:05:58 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 03/20] man: build the scdoc based man pages
Message-ID: <ucdectrvyxvyeghts3dqu6igo7jldydxnfivvwli6nmub262mq@w3hd3i5bwcko>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
 <20240611-man-v1-3-bd6864d49639@gmail.com>
 <zttjd2hjwkbtdy7zkuixypqbo3t2l2brsaf3tx3jkdjfctxjj5@v22knirawsfe>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <zttjd2hjwkbtdy7zkuixypqbo3t2l2brsaf3tx3jkdjfctxjj5@v22knirawsfe>
X-ClientProxiedBy: MW4PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:303:8d::27) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce2a650-5cb7-4ac1-3bc9-08dc9bac5394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QPhHHMtRniLIbNNco4AIJRVijvQUZJI1BJ2/Uh11K0qcdnujHI/ftf8rxZaL?=
 =?us-ascii?Q?PMxMQe6n2kYqBVfBqw5PUL97O3PEyJjhL3o5iUkb/Je8jP/DlcSkh3mO/w5a?=
 =?us-ascii?Q?62Y5C9T4WgSgFS4YeYCjVdyrEXbuQMm5bMgjZu8k/yZWKTYKV4lJrC1NZ25s?=
 =?us-ascii?Q?FfSlWC66aWifQRZXExZpzeMjyUivGYch7qUIMt+lBimXJDbpEAQa4rfJJ8Dp?=
 =?us-ascii?Q?YjTwWVSp7k58lbxQZtzLkKH0lYGpma/r1i4mYUemt/IIINLgbtHDlZ+vl/lU?=
 =?us-ascii?Q?JB+Rpqg5fB8xY2U2Q3GJg27afg4X96VZ93HMpVLWp/rUhkny4ZKdX65DPnSK?=
 =?us-ascii?Q?ncWljKhSO7uydmy1pVMIcAWcF63E2VkcL960fAKag04bL5CmexF+x+0M7Tdh?=
 =?us-ascii?Q?hwdk+FvEaV3aCqUs338S0ZaaVhGOwCOqanxCCiJBoNfQNHgzpYAhBgq8Xegx?=
 =?us-ascii?Q?w/Apvfr/v6alAEOCjwRcaGktw8TwyHGymn+dGuj/oca2bcy6qUauCvrx/spK?=
 =?us-ascii?Q?l1ocjsMN9ySmTOPqzLjzwe/jbpwmIq/aznOk34fLwJVoDvqm8oT55zUM/FiG?=
 =?us-ascii?Q?jeJSioXnnuizlnQt8xycdu7H9vslpOZimjEDZt5Ut0dCeOgnEfhPljsgtWvZ?=
 =?us-ascii?Q?6YOUcMKilYlmkeu3DHi/I/o4HFeSXdPeebbt8+1Bg4Al6Bu7K3XCilSwRwAa?=
 =?us-ascii?Q?ynHVm0KDWOhMetAy33CdcITuIuPpVdBeuBbSu+dbWrd+nnREzWsd1UZUK1l2?=
 =?us-ascii?Q?ZA0i4z9mNqo5OKHgTLyFF1mDNbxl/yIDr4HU2IYmK9HzBgjURVNTSi3vIimy?=
 =?us-ascii?Q?9XCkbtRMU/18hJJQiZeabhBSJXwNAa2/rpb4u2jvl/faniloBiT92YNdBimq?=
 =?us-ascii?Q?QY455NuoLeV7clzRSi4V8Ik0j6aC31fj5Peqncg2eL3bi3ddzqRR2tVLHXPX?=
 =?us-ascii?Q?w/MakqQVxDZAZJke51AL1x115VHr+R3LOXBKdU4WP5K2EZDbmN5xMawiZWux?=
 =?us-ascii?Q?/b/sxVrVzUu1elFvZ6p6omJW6da0xNYLKD/wPnPrTc+WnX5EP+mQgoSk1sbD?=
 =?us-ascii?Q?HRQQmVdcxPiCVbADp3s7vZNMwV+ZdxAOG/mtylnH+SiD7iLF+Yn2NOqbPDuA?=
 =?us-ascii?Q?B36Rqakc5m5BRV3MReZQ91CwtRcoZTXwGN5XLrzP5S1Wl+eWP0H+NOmD32fY?=
 =?us-ascii?Q?aZ/vMK8gyYZGrcls2+0oCzXyqhMyayYF62RaJKyq3wbzCbJDQR392ptWpii5?=
 =?us-ascii?Q?+dL+2zsY+7KE/cp3MxE5FJkX1lrqihVgipsm+orI+v/OVJo7HRvAw6WXCTis?=
 =?us-ascii?Q?9Ru+JvDoLpq4VFTKNh6XUV8EmnksbvyeNDwYt3W/CVcU9Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fs76gjYyKd2PdjPj/UvSN96l8zrPi3oPSKmOmT4uvtrdBGx3olD17mms513i?=
 =?us-ascii?Q?5lnwgvCRK/un7hqa8ya5ovDDpjUXH6roGRkUOamVhJmA8xSy8mPiQ2k8XXXN?=
 =?us-ascii?Q?16VscVM3FsNE3hu1Ce/+Oybu3hq6toP1jTjpY65Wm1U6d/xT23A7ok4kYw59?=
 =?us-ascii?Q?Ak5pi+v/M9t837Rc5RE6TQVUtfShpke6atxW/efa1C+TS7djUqFzu78NFUrQ?=
 =?us-ascii?Q?1raDqyu0djJSWi6moXRit7+v0wW7Az4ZwM8vdIOimVN8e1dyl4QhhoaMFS3d?=
 =?us-ascii?Q?Ppy5zcdMZHnssHu7Y4h3dhugG4aw36CQrIV8AsA8fmeTiz72zKt2i+hBdLT2?=
 =?us-ascii?Q?rJfYbpmGw4igx+A8i01WQU04PiseJmNOZmKOzdxoW8VkRFTrO5YzypzS1bW1?=
 =?us-ascii?Q?aq8whHgs77bOn2A24QaYNkRVWXbPl+REyOAJhEZ6t6Lw0zCp9Eu4PqWnwrJr?=
 =?us-ascii?Q?ce0cN473HLzCrzF3msbO5J0R8jVvFN9bLwjaDWC9/fB7qFQl8B31DI0Pen0i?=
 =?us-ascii?Q?/1rrY+ZYcvGGqv+uWEQBnGBAt5oPyCi2xN0QpyqaVmdfw1AdEMIAoUG1a1gc?=
 =?us-ascii?Q?Lo0IS+HeG9BDfJsCTdUBEfAb6dRetzD8XD39DWnmByGR+Ghn1PYvTuGUm2b8?=
 =?us-ascii?Q?JW9/7XDZQ7kvldlO6M6QAcGbbVC8dkWUNSjL7E/02m6I2VylMmKyxTC9OzbI?=
 =?us-ascii?Q?rehaCxLFb5VWsQ9CFp5b/vCHrv9dLlfzG3oafgaYVUzTjLBK7pS8SHDJeKDR?=
 =?us-ascii?Q?TSIuQwwibFUQ7MfIGbCLmPyLeh9uzc7L6UroSwrFSSSPnluQMTIQbpJudmTD?=
 =?us-ascii?Q?qp4Dz0EW+GpLq+uVXcCOn9NIoJp7vGdevYZjxsm0EeNBAhDYwx+n+7jeSBOQ?=
 =?us-ascii?Q?jRitIk8vqWQXPwRSO9MTT3jSNlfVubqW0Pe/cBSbgfB2lgcYfdKHig0QyjXt?=
 =?us-ascii?Q?6nIq6SH/RHvZ9h4y7DBpIShgofWMQslZPL36W+CqagTpkrTz56lgebwkJwE8?=
 =?us-ascii?Q?3+tDj5XkQgYSKQ/aIDIj8IV532dMyIO3zQvV4v0s+jjWniUIDuhCDf0NcY7v?=
 =?us-ascii?Q?D/FDDrobArBjIoGizPhbTehDS6Z7YlqG3aRExOO/0DOw2JzM5Yfi27HcKpKD?=
 =?us-ascii?Q?VX3Cm570kW5W96gbLCDuCofqegFqRIdUwCw3rL9idWPEitfpg+XRKvnGsoQm?=
 =?us-ascii?Q?hDkZmZL4IUMBzA/IDSO3f7xMimL3Bz25Bz5ZTeMmjPveL3/dy3ahD6aESAWu?=
 =?us-ascii?Q?pvtqjagRtwmdN9qXCStfKmrxNF++2QDtu2c2nVYMlJ5bp5sTtgtfWqnbZATo?=
 =?us-ascii?Q?w9h0S84S7B2ZSqXimNb+SUC6PG+hRZ4BKHOgo8MzwuQ+RONPg2zv46m9nZld?=
 =?us-ascii?Q?lGXvNiydlNsWwzWA0n51+f5hBBz85kRFflXCAoEW7qMhjreyfmEazFC865Ta?=
 =?us-ascii?Q?7+DDpOYJbrB8BilS6P43Lt+8zGySzlJqKNlwpVy1nuD63HRc9fSVVhHaN9a9?=
 =?us-ascii?Q?UBXkxrC/Zl5oDfKyawhfgFoeX7mZzzS/7Q/3FrTJ9zFJXHqO33dsshY7C+Oe?=
 =?us-ascii?Q?u5DrxtGbjKweGEFxrl73NMJrYk6Omtc3cnQRq/qT9xpY8/yJWhQwKi5Dvkwn?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce2a650-5cb7-4ac1-3bc9-08dc9bac5394
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 22:06:02.1232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cer508nlIG4VrU1Saaz7nVvy+zmEbVyXzz7zQYppIhss3ZIgGBHQDGuDdfoMnf9NKqnG2/5bgvffkyhw/4IkecwB/QWJ7Xx+I9iZ+hA4Zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7964
X-OriginatorOrg: intel.com

On Sat, Jun 29, 2024 at 01:04:52PM GMT, Lucas De Marchi wrote:
>On Tue, Jun 11, 2024 at 04:05:03PM GMT, Emil Velikov via B4 Relay wrote:
>>From: Emil Velikov <emil.l.velikov@gmail.com>
>>
>>Note that scdoc does not handle natively handle the dummy
>>modules.dep.bin.5 entry, so we need to create one manually.
>>
>>Not a big deal, since it's single static line anyway.
>>
>>Also: pkg-config --variable=scdoc scdoc, produces the full executable
>>and path, although for now we stick with the AC_PATH_PROG approach.
>>
>>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>>---
>>configure.ac          |  2 +-
>>man/Makefile.am       | 24 ++++++++----------------
>>man/modules.dep.bin.5 |  1 +
>>3 files changed, 10 insertions(+), 17 deletions(-)
>>
>>diff --git a/configure.ac b/configure.ac
>>index 9527aa2..dcf7479 100644
>>--- a/configure.ac
>>+++ b/configure.ac
>>@@ -32,7 +32,7 @@ AC_PROG_SED
>>AC_PROG_MKDIR_P
>>AC_PROG_LN_S
>>PKG_PROG_PKG_CONFIG
>>-AC_PATH_PROG([XSLTPROC], [xsltproc])
>>+AC_PATH_PROG([SCDOC], [scdoc])
>
>we should fail it if scdoc is not found and --disable-manpages

I added a patch on top to make it a required tool

>>+AM_V_SCDOC_ = $(AM_V_SCDOR_$(AM_DEFAULT_VERBOSITY))
>
>			   ^ typo here,

and squashed this fix in your patch.

Applied patches 2, 3 and 4 for now.

Lucas De Marchi
