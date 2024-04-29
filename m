Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB13317BCA
	for <linux-modules@vger.kernel.org>; Mon, 29 Apr 2024 23:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433256; cv=fail; b=oxymhJhQUj6dRbT4OopjNhT/9R3l75jZ/sXVlnQ/dZDZc9+HAlFlNl0wzEV2cGLkT8nsaxtkfGTJhkdQaQTC5MXq8fpAy19FMi0G+iLx+iENSNTsexcjV9w3p5GS2lJxWD074mzd5ejyz/Wpe8oC05Eak6Gl9o3nfnWuSEgdTxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433256; c=relaxed/simple;
	bh=WsILW/G+S2VjlR/ayiQL3He2ktrMjMI2G3KAm77LswI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qvJTA4kxxewJo0NITGDki5B2SFyAQkt1uamgYyBxhZFDBELFTuAtVeoXPrv0xv81pS4zgC8B7RJMqabECri8LZeCREmwW6Wak+vpa54qBXuDSNRIpNqOmcB6vHmIEYsyxgSWKM2LY+LCX7XCEEnbgr3I8FE8zVxXpoLK54fnQrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvRnDjsE; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvRnDjsE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714433255; x=1745969255;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WsILW/G+S2VjlR/ayiQL3He2ktrMjMI2G3KAm77LswI=;
  b=YvRnDjsEh5+cmbIdGXGHdxLWto8c8eG5W3suc57CBfQZaRvqF9+QJUHL
   YLkbur//bKo8wEttvRD1i+CIjkxMlvIV5EnmS0N4nK1RLuvTnS/iI0YZn
   jK86gkw7CtyGHgUQsH7NYVWufDBJBucuElMhoKJkKrrm66/JMdeL/KX4S
   XcGhLNVOSFE7lDlTpoObOlgis7dXy2+rVNKsPgo3ONlVI8q6KI5IaX239
   QafcAGYv+fWQBjNVyLSp2tJuJp2qt5FRo+IZp5IL7Z+9lfEC9m0RlhVZd
   Y9v03PKtEXJ+SR8HyWEnGQjF1HpGRJI2xoxIwqGwqdNosurt+CMY5SZVN
   Q==;
X-CSE-ConnectionGUID: q8HHTy/JTqCDnX5bBtuTtg==
X-CSE-MsgGUID: X96/95LvQIawH1bln/FpCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10334796"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="10334796"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:27:34 -0700
X-CSE-ConnectionGUID: OZsBdcU8SpKhmdOKdufidQ==
X-CSE-MsgGUID: j+lwnUZhSOS8dCgOAl8aAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="57133644"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 16:27:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 16:27:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 16:27:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 16:27:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxWKFxsWwBXi5QeWPP1IvkyFYN/ucA+J5OmecPkD5mxUAsGqREMfOeMeym2yL66/9pw1ZdZNB16RYEFp/1q5RPs6HgBXFSSKItUCAMgzBlgthTuYi321rM8f0ZOw8SYUWw+tttVEDEL1DbtM3L1rUlsVHplVNHR0vZycLZi8jRtj7dmBZF3Wa3Bn/tPydnSqlibDJDPYY/ojyUpIZBSRq0wVZMVWWMI6IlDvxpVcYHYkdlCmDPMe385lBvR/VnCpqH/EhH4kGz8WYAmu3WdgFtJIp8Gztg8kOvy1Z7Ldg1I3pz3qRxNV4tZzxO24mUOejx0UFKVgNY0h+gAZVzRooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5JZ2WFHH9EzzHxmIUqbgy/2WXYc7IkzGodZzoxWgFE=;
 b=e0eujuCM5XGahM6t91SwP3Rwfdwzso06yvGsTfeOaDjKR4WrOsuwGlk4E/PgthQT+N3MIzW+xIJIPpbEsojpx63rtsYokPiTTxEgGpdC7fyVs/gWNxqbrOOAc1YnbMOO2FOMeqoFZbuFia5UChQF+NRfAPxAJ/liUbtSaUZVzgnrAmGeajKhGCB4fVT9hoWbV58v6J7XFouF8ejOE4ULLIhUTeavdvPqMW3Re4JuXfTRYgnDpnYuOKt2gw2B+ASxTLoj1qexafij5KYr2PPOjUWx+bBIzv3kIYCC68pjvrpBv0W0Pwb1q1kAXYDRQjP+r+EYhUEJw4Kq7BT6+aYYqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CH3PR11MB7896.namprd11.prod.outlook.com (2603:10b6:610:131::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 23:27:26 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 23:27:26 +0000
Date: Mon, 29 Apr 2024 18:25:33 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 10/13] libkmod: tidy-up kmod_file_open()
Message-ID: <kdgdycdt5s756w6rakp76qgb5a2mdyt3rdemboxywpe2whdcx7@dzswvao4o3hr>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-10-06f92ad07985@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240212-decompression-fixes-v1-10-06f92ad07985@gmail.com>
X-ClientProxiedBy: MW2PR16CA0064.namprd16.prod.outlook.com
 (2603:10b6:907:1::41) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CH3PR11MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2c7cf8-9eed-4437-dfde-08dc68a3ed88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cl/gLjh2iYJoo2KMITz8iNuSOz0F4NlYWmy93e4nO/4TntL/IOQ1G8OFFoCN?=
 =?us-ascii?Q?Ddmx+iGYcVPG2tiME2MQ7jwQE/nPaA/CUG9NO80SD355iK1uU2/1AqA2qgWK?=
 =?us-ascii?Q?F9lAiCfI9p0D4sbCF2V2mbWCV6QyTcr9HLSqmR7J3Siz85t7+u0mqigtBtCy?=
 =?us-ascii?Q?Esv5VX2cmrk165U4jUy84160ga1Kk0oNDfL7wocusuKbSXI15Ke27PSkZYOT?=
 =?us-ascii?Q?9opDadzfP+oKXCciFH8jKkwsEB0/oN9ZiQXvn1gF8q2+OTBoe4isD/RouQmw?=
 =?us-ascii?Q?twMoe7tAbTyupjdzvKWdY6rZCVuZWAim0v7XRKql79xNmutJ3MMO3AjJWvjw?=
 =?us-ascii?Q?y/LLRr4dzWR6M+bHh74xNF+Of8UXPM18ZpaE76Whlx1LfOy8em+XLyAlWvnj?=
 =?us-ascii?Q?ugE8Zqv3cF1DnTTkFlMbXiLJxbJQKxEz9J6CM+whg5o4RSqAZJpfhe19qPQl?=
 =?us-ascii?Q?+tPodJDM+au0QaNXAToVaUDDU6tnX6qMdB21HiB5DePfVPiR0MP7eFnaD5fh?=
 =?us-ascii?Q?h12ulXRd5L4ycKKHqr4cXEbs6NxK9U4OyPqQiNmSsNlfSP8yc8TZHhGgSTY9?=
 =?us-ascii?Q?j038Ne65U1f6JeVKlvjouSOdWWPOSXKlSMe8qFhXo8lDh3SyWuOES7aNeHId?=
 =?us-ascii?Q?hlKB9xLuHft8MO7G3pdBingj2cBPel8+BgM82JQNshmQlm5nnZzMfMTz7F4q?=
 =?us-ascii?Q?WnvEbYV4U3zIiAB2mNDZSieIv0OYnqGamUTmJnTq8CtBDAsMGrrG1V+Aew2D?=
 =?us-ascii?Q?+PaG0DT3tR+xhTVlZKdB+mSr0Z2BOLX8BZ2+AeiuAQUHTmsiSPtTOdF/Hv48?=
 =?us-ascii?Q?nLrkIzScCqg/of066MSbolRvXfI2Jey8efUZOGoW7HHNy+hEOqV5wpe+bD+A?=
 =?us-ascii?Q?5A+PRC9KePUm7IzJmELM/kGR6bjsQNrUl7FwNt6TwaZSePTFow8/g6rUH8ya?=
 =?us-ascii?Q?fwn+04x2XoPyv87t8pFxch/wbd/r27NmaUvZCw8EpeOHmM59XkCMYog76XR2?=
 =?us-ascii?Q?EOshxo78SUPNNm6VaAxaXx+Ud7aa/RSj/p5QjyMJrjfwI8aej8wKHUrTYQy3?=
 =?us-ascii?Q?TsxPOFnDKDbOUVs8XIegN76gpkZMJfNvWqDCbeO2v2o67k9PvJEwcuafPF+f?=
 =?us-ascii?Q?JIBDDKOE/JzXvwq9j+7fGusyM3LbV3WoCp1wy7pLAPqNPeMBuQ0MIGbgRQp5?=
 =?us-ascii?Q?x9FSYj66dCK7KSYb8UmZGQ7lQt7V/TsVSSG+RixP1LMm4+1Bdnu/JR4Y+Iaq?=
 =?us-ascii?Q?YqOpOUlVuhNeEjxRmGHSRWs7mtz55DS7UnH4T315KA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1FfyQ2hSx7Wgb5+/6fPjP1wBgigfBheYk9J+GLOhr136kHP/LLA/Bwlb3hBZ?=
 =?us-ascii?Q?uu9uSsgoG2kGeNQpS+kjTdySGWoUTFqcnFEWYutpJNICbpcehAv5HrLLYCdg?=
 =?us-ascii?Q?IwXKd9dxn9+gcQCYJ2WkQXYs8xPkrXofsZ6dFjQhqCB4L4D6J+wg2IRtKCv9?=
 =?us-ascii?Q?HzO0U5pwd1qDiw0CBPxIHDG3qO8JpLWXSwFBED5QOszodu9+tr492z3EaVNe?=
 =?us-ascii?Q?I+3arqLYjjRhicEwHyH559KkeHssG+LcaWq4yWGpSvbLg3CpLkRa/w4dHfqt?=
 =?us-ascii?Q?QutpQZNA0+nwdzEqgXbER03FrJruvbrhrpiWHNQ/s5RsQvTCSD6XCg+hb7VJ?=
 =?us-ascii?Q?baUok8uMPz13WTkWDDQf78N7dGGtdkLBHZogDniCuYaAbDj0k7naEIyHsbiV?=
 =?us-ascii?Q?Onilc7X+64oItQ/ukULT9hv5OBCAK/GvShyD5AxZvS0cAKqdA8/MX3is7pCd?=
 =?us-ascii?Q?a2L2sZmDDE1V8nK6h03IvsFE3c4oOzEeMGeGutVGmrsvJwrdwa125U7VTVmL?=
 =?us-ascii?Q?POUoHUHBQofkdxEQ6BXdvdcQ3XV3E9mVaeLTUapXhY7yIYO6YLKxymrakbbO?=
 =?us-ascii?Q?LeTlSyiAWLa/hUXgps1dZZ0ZyJ2QH7dbLrUG05fUEz3rGiEsXym6Cbn6NGk1?=
 =?us-ascii?Q?vO+1H1oyoGMR8LF5yxvCyoH8iFGzr3GTlyKybzwbos+c5+5gVvsayGTnos1g?=
 =?us-ascii?Q?xaHYk4Ek77sgc3S+b3PzoDmkbvUicyrmlWjhRPITVVN37LTFxBJOEiFHrTuf?=
 =?us-ascii?Q?jXyxfoqS4EOp7fVGhluY4EAU84q4GZkf1Xy6p96sn78JLDNeJuMdprdhBhFu?=
 =?us-ascii?Q?eHRsVwJ6cUTTClQrJOKszDHis3YlWytfNbDrS8iwWaijK7lQzkU4pIclpNyx?=
 =?us-ascii?Q?lzSTYvAW2mSSId7oediyx+wDhahUR/PN0YizO4xp3r/kAPy+/j5OupGu25kf?=
 =?us-ascii?Q?LfbFlSVqZOG/8cJ5QkEGwvXXhCyjCVM6qhAPAM6vQao7L5HXqESSfUqC1S1y?=
 =?us-ascii?Q?3oBRYD9pmnYFCZlms25Ah9fNsi+Zu5VkKC8IEV8YgOcy5IvNKqizuTaBO0Zi?=
 =?us-ascii?Q?5ZbmoT8tOUlMxP56+4ZtvbDVk7Qf/dWboMuA/aafH9+FpLFH0FrUHXu9Q16x?=
 =?us-ascii?Q?/8+M7abzVGGBGuPUuJfzuDkYXE2bUt4krcquS9VK2FiELBHdvBOdByIGNK6G?=
 =?us-ascii?Q?NU+yhNlwher0WwYWF6yTFAjWZuE34/4gAnpuqwum7VI5PU5bk9oRMhElSuRl?=
 =?us-ascii?Q?+ddY3rHZDMQqNPNyU9GWVv7avz85ZiNOhgm+OGGG596Mad9FFlzVZ5FSFm0i?=
 =?us-ascii?Q?uyqOZPW+0ra3GX+BsM2wy9J4qGK71nK5f4jVNI9bo+5CvGN5+Qqu0BVXQUe6?=
 =?us-ascii?Q?1TR5VIL/8nOjzSy0ezL90WGBLKzZT6D5hRwUQ41OyqHVp179i+Ds3K0YqALT?=
 =?us-ascii?Q?RaL6BdQFEZ6eObgGtWqwh5dBA5Cm90dV/js4KNF+LJBGPW4LzylBPe4QJ27N?=
 =?us-ascii?Q?5pCcCEJDLekWqO2pmlkA787lD6z/1kH115S3i7hSPOu9jPTCjuq5t+htpdBe?=
 =?us-ascii?Q?YzzTVkuglbhzlyr19DyxNSBDwgg1TfMo27JKdOIEMF8YXCdvdPway4JyNAs3?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2c7cf8-9eed-4437-dfde-08dc68a3ed88
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 23:27:26.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0QB6LVjg3Rq2VTK7O+lRUFinyPRwpaMlBGKebJPk+cqZtKsx79/K7nXp3gmWKLFkbiJmJhOZ0xJdU1xqzDfJMxW//ZsnnVdyUuzOfK/iKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7896
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 05:23:11PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>This commit cleans up the indentation and the error path of the
>function. It bears no functional changes.
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

>---
> libkmod/libkmod-file.c | 60 +++++++++++++++++++++-----------------------------
> 1 file changed, 25 insertions(+), 35 deletions(-)
>
>diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
>index 5b88d6c..c4893fd 100644
>--- a/libkmod/libkmod-file.c
>+++ b/libkmod/libkmod-file.c
>@@ -410,41 +410,40 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
> {
> 	struct kmod_file *file = calloc(1, sizeof(struct kmod_file));
> 	const struct comp_type *itr;
>-	int err = 0;
>+	char buf[7];
>+	ssize_t sz;
>
> 	if (file == NULL)
> 		return NULL;
>
> 	file->fd = open(filename, O_RDONLY|O_CLOEXEC);
> 	if (file->fd < 0) {
>-		err = -errno;
>-		goto error;
>+		free(file);
>+		return NULL;
> 	}
>
>-	{
>-		char buf[7];
>-		ssize_t sz;
>-
>-		assert_cc(sizeof(magic_zstd) < sizeof(buf));
>-		assert_cc(sizeof(magic_xz) < sizeof(buf));
>-		assert_cc(sizeof(magic_zlib) < sizeof(buf));
>-
>-		sz = read_str_safe(file->fd, buf, sizeof(buf));
>-		lseek(file->fd, 0, SEEK_SET);
>-		if (sz != (sizeof(buf) - 1)) {
>-			if (sz < 0)
>-				err = sz;
>-			else
>-				err = -EINVAL;
>-			goto error;
>-		}
>+	assert_cc(sizeof(magic_zstd) < sizeof(buf));
>+	assert_cc(sizeof(magic_xz) < sizeof(buf));
>+	assert_cc(sizeof(magic_zlib) < sizeof(buf));
>
>-		for (itr = comp_types; itr->load != NULL; itr++) {
>-			if (memcmp(buf, itr->magic_bytes, itr->magic_size) == 0) {
>-				file->load = itr->load;
>-				file->compression = itr->compression;
>-				break;
>-			}
>+	sz = read_str_safe(file->fd, buf, sizeof(buf));
>+	lseek(file->fd, 0, SEEK_SET);
>+	if (sz != (sizeof(buf) - 1)) {
>+		if (sz < 0)
>+			errno = -sz;
>+		else
>+			errno = EINVAL;
>+
>+		close(file->fd);
>+		free(file);
>+		return NULL;
>+	}
>+
>+	for (itr = comp_types; itr->load != NULL; itr++) {
>+		if (memcmp(buf, itr->magic_bytes, itr->magic_size) == 0) {
>+			file->load = itr->load;
>+			file->compression = itr->compression;
>+			break;
> 		}
> 	}
>
>@@ -455,15 +454,6 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
>
> 	file->ctx = ctx;
>
>-error:
>-	if (err < 0) {
>-		if (file->fd >= 0)
>-			close(file->fd);
>-		free(file);
>-		errno = -err;
>-		return NULL;
>-	}
>-
> 	return file;
> }
>
>
>-- 
>2.43.0
>
