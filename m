Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022129.outbound.protection.outlook.com [52.101.101.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6C78F2E;
	Sun, 21 Jun 2026 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782077611; cv=fail; b=Ch3QzXbLD8oN4nhcxved9+3iq8buOTzyRRXtmz8Jcf2zXS4o+WJPPSy+5qbGmoWyGio80/avcAXyVmgoLJQ+FV12HkYSB7sAoQjaqGBaAByougorRDecnYhKbGJiXnmSr/HHaaw8B8fw/65tiffiBUklFzYMtOExpXw79tvCilI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782077611; c=relaxed/simple;
	bh=tdQ9Oc6B2H9rJiKoLCPNaosf3CIIHffBj0u8x7TDvfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J5mA85JmiAvP3+Cr7XDgSFJ4RL1hOl1b09Qr1AKXVYrWnD6iPMd7dvWNCeIcFmL+XOt7AlhejQx4creh6F26GDlhkUKNKFq3PALrNYF49+chEZVKzltDAz3g0uRMRCglsgaPcc8/OMhdyTHzphcCzwC0GAyIAwkiEFL3sBimIwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcEU9wXXGBWCo2VzTcqw1AAxp/Hb8E+ZuTNrn+tP2MOnTc6ZnwaCwz4OLo0/3d3ykUZhWj10GbsMgBrQepJuF99YaXytAXxuiEf+xzLWe+nrOoRUzcEHahpUubA6H8S+NMpP5H52pW3llpAS1MP9qSdA5pSv+N4+xSm8u+j0XXEFbdDYLCfe1pzjm0sPpab2EiOaZJLOTbAuMB/Yvmz0ppOZr/fsH71U4nkDn7Cfior7WT4FwTl7TOV9t6y+F2LYCmoa07Ml1V38x4VXEzVpIYGv+qo0561JIHdSypjM0KrLvsvnO45AfV3S6QY1S1ReDgBMIEvIxPhvInxR4T4DRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=B/pR21x2zFSfd1ITifxTF8Pr5RX6tfE/JShy2AEPwYs=;
 b=XQWQ8WXXzsxP4+kxZA8h97Wbul6zYM7/EF4fYOyvwRwzLgqWk7i/MnR9DgB+UXUMvel0EodtNkTHgRxyTqG8NLGMyLd5b9MhKbtR6f4fmL6ACn4dUDUeuKJ/6HFq5JMPIzE94n4UE5asWSWuuNeni36nS7yqcdH0W3w1vkCl0lSaE3NIUWZItMBgADPDj+CBGTT6/52m1WOtvfDEvtm1SE499T6HzG+pEGrsqq5IuSoLXU3taEAyh+wcOOn3g/grQlaSdoj8dfTlG0wzV84efwbMCJa6jYiMCspkKnkbvYyDPiZP+6hOe50DyEsnQqcew0qIaaLh8yGjALR0HdZWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO6P123MB7254.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:340::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Sun, 21 Jun
 2026 21:33:27 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0139.018; Sun, 21 Jun 2026
 21:33:27 +0000
Date: Sun, 21 Jun 2026 17:33:24 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com, rdunlap@infradead.org
Subject: Re: [PATCH] params: fix path of /sys/module/XYZ/parameters/ in
 comment
Message-ID: <vwplroxy4tpah54eyuhciq6wbkoxqnngfl5bgeixj3cagupbo4@mhmnqbseixx4>
References: <20260621082223.11439-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260621082223.11439-1-zenghui.yu@linux.dev>
X-ClientProxiedBy: BN0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:408:e6::14) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO6P123MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 08720764-f201-489c-a459-08decfdcbb2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	0HxHgC2o+YC4LsBImLGmItUKkizce3NJ9vesMy/fZT7jursrpXrm/Ld+H/K2PHyURvY3tfWUckr8R+gGQZfUoE5q4P8GDlYOQRhGb9lktKjR4RdhGbt0qzGIJbOucI+f8FGKZTtNeMbCABbcAFobe5uZF8+JSFnLc+Odj9iS63MpFtIHfDnkywry5weS4DAoCfQ0SfbBTyxc8onijCZaZpaOFBDnML6zYAed0jWx5CADf7EJeDHEwpqefu0gsC+DlZ349F1LQapMUw6AjzrfaYYUBpHE/VbN69a9fLSFPKORvRn/HPQdLQhONMSRNQRZB2tE+XKgLPHl1irlJwtkYAIPEuzsxz+G8OKpyf4+2cT7hgsCOQ5/9jlqMa9q7bg8NEmw2wRGLxgCgTb4DWIDN/wnUrNwxW79CAdKB0cGQqx1YJ08WfEZB2ZVgrdKbfN57KwxZJlJI0QeXOhCGY4ImHMJkkGMiD4LTsifTD6ImY4n23ASvmaVccmv9tsP3kQIWCEja86K3RiJzqVy11IocK/Fzkp0ALJzk6aZ+nsfBmacFy+Pk1ZfcayksLgXn2x9xxsDQadAMpeHnVf9N68DgX3OM6Sn6ol5+jgwi9cuC7zI5F5TmLwKGoP3Mz2tatILiU4ZXGg5n5wUSo2xotFDYWq59t91WbPPIZC5Rco1P+E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(3023799007)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUJINjh6N1VYMGhyNlZ6blN2cmpuQldDN1lGM2oyY0Y1UWtNT2U0TDBPVXQ4?=
 =?utf-8?B?RWozVVRDc3pYVjV2blo0MTZkR2V0K0t1eVdNL1FyTDVTeUNWWHdDbE5yTFJD?=
 =?utf-8?B?ckRSMGFnT0ZsNzBrSXZKZU1pM0VnL2NVMTY1QkhIZzBFdTNFNzF1MmtEeEZ2?=
 =?utf-8?B?U29zZGJ2NHhTV2l3RHRLMU5obEtlUmw1UDYwWFBCUnlOT0NzOXpwOFJxZXMv?=
 =?utf-8?B?VXlCdGZSMkVJanMrVmJPQU1IcmVpZGpvNmRnNlRxQVU0dnRaRFRrdld3cWpx?=
 =?utf-8?B?aEZoN1ZqMDFzN0Vxb0dBOSs2eERjaXRSa3lpaGFDbUtnRzhrczJhODU2d1FS?=
 =?utf-8?B?OUJtaTcxVnZKK1B2NFNVS3FlcEhzOGZ1YjZmN3BNTEF6RXpyREZnOXkzZHM4?=
 =?utf-8?B?eWFXNGRqVC9Pb0VDZ2w0ZXN2WHhwY2cvWEMrMGtTbkp2TjdSNGJReUJLTGVx?=
 =?utf-8?B?Y3prLzNrWForakhteElNdUZuR3ZIYWc5MjlqamduS1JGZytRaEtJSCs0ZjZx?=
 =?utf-8?B?Q29PSlRidW4wNDhVZGRxdS9jUmZCaTljZ3VuRk05MDhrbFdNTFVmbFljL2w4?=
 =?utf-8?B?dTNIOHEvemY3OWtPTER3MWg5MHpRcnZOV3A0U2lMOVJONDJRODI0Q0pKWGhk?=
 =?utf-8?B?S2pOVklwNVlLMEJwL04vaC9NVXhRd1pUV1ZwdDZBU3R6eUFMMUs2VUNIdmxx?=
 =?utf-8?B?MkdyL3AwcEUxVndKOGhXRkdlWjR4dWpBRkdzanl5Vm42RHdGM1FkdGI4SnBk?=
 =?utf-8?B?K0FUamxVRkN6UW1IK1JZczVvTGExZGh4UTg4VG1YNDdsYnRubU5sL3RTdmtB?=
 =?utf-8?B?U0cyc2s1S3FYRFJxQWFSblIrZjFudlJaMWNDM3BmUnBRa1Vkb1dzZ3F0TTJT?=
 =?utf-8?B?amVnR3RweDFjZFZ2KzJkdjVuRWhLYWM2MEtCZlc5c1pSNUE0WnJhMFQxZUFO?=
 =?utf-8?B?blBmZjZ5NVllTXVkRzJaMVJJczlzMW9BNTRQS1Z1UXBzQ3ZjUlV0VXdPaGcr?=
 =?utf-8?B?RkcxeWtFRTJPaGwvVmVMaE9jbHhUdzF3NnVCV2FvRDExMm1tL0hDOHo0blhM?=
 =?utf-8?B?Z1oxcmxCQ210U0Fwb2dVNldVRURUNG95QXcwSmdjbXcrU0IwM1BOZmU4ZGhi?=
 =?utf-8?B?ajY5bWNoN2t3V2RITW9rL0JMTTBGVWFBemRuTHA3MlVNaVpnV1c0SW5IWVYw?=
 =?utf-8?B?NmVrTVVrK1J3bWdpVWhiMDJVUGs4SWJPY2F6cC9zcGE3d2ZnbUtzb1NWMGhI?=
 =?utf-8?B?STdRVzhUcTFtYndKSGhXRWprTGp0VTg1czNZWUlORzByQkZIZ0h0K1Q3WUQ0?=
 =?utf-8?B?bDRORjhORThWNms3dFNubEkyaEtHYWNKM1JaRTlSUHRFTitwSTFvTlJUaVJW?=
 =?utf-8?B?K01nZll1T1pQODVwUHRhbkxvSFVaRUFWaHZwVWV1Wm9vMGhEK0RoZ3JVREd1?=
 =?utf-8?B?dDhlR2JQZmV4d3lMM3c5NEQyN2VYaXNJemp2MVZKakx0MXdKQU1wdFJGVHB6?=
 =?utf-8?B?aWc4UlFZcFYrV0ZJbUoxZFYvQkZEWVphUlQ0UlRMeTExaGhHUHNBQjgyQUhS?=
 =?utf-8?B?WEx1cFdRZjV4aXhwUFRBSG5DSklJN25maXppcm1FRmpHZ3l0V081KytMc0t1?=
 =?utf-8?B?YkFVZG01R25pN3ZZQVhHUWlldlhVY0Y0Q0dNNzdqbUVUa0FZZkFWK3lrbnFK?=
 =?utf-8?B?UGdTeFNWWlZRWHRvanQrY0hYcGhac3IrQWJ3bS9rbnorSjBoUEpCb01NUHFQ?=
 =?utf-8?B?d0FCSStHbkNybEJZN21FZHAzaXdtTmlUbklMZzBJNVRLMzh2bWU2bnlyd0NS?=
 =?utf-8?B?N01vVVd1SUx3VHVBa3Z5M2g0RTQrbFo0RkJQd3NyV1ZNRFBoc3VRb2o1UjBK?=
 =?utf-8?B?SU0zZnhKQXBHMlRvTGZwbVBsQkhGZnhCM3Rpb2tLRHliNWxkMFM5KzMvK3My?=
 =?utf-8?B?ZHpOeVZVTFVsdWEyMEVjMVBmemRIdmlVRll4Zkp0NHFXUk5xQXlTaE0wN2RP?=
 =?utf-8?B?eFBTVFJYYTRnMkFGVDVvcFVoZXpNSHJSZUx0R2g5THl1SzJUK1hwRTN4R05S?=
 =?utf-8?B?enAyaDZySW96RjBMZ0hmSDJ5RU1VR3lMOHJSSUx2ek5RdnkyczlYeVFkeFZ4?=
 =?utf-8?B?S3NZWjlhRDEvOFJzNGtiV0FYNmpRa1RvdkpuWGZGY2NIWjZudWd2NS96ajhY?=
 =?utf-8?B?MFhReE5oNFZ3Q1BGUnpYdGVsckt5ZDB1RDJQRTM2SXE3eDYreTBoRXdTYjN5?=
 =?utf-8?B?RlY1ZnJXWnVIV1RjZS8ydjZLcjJNRVg2YklQWkw2LzFjOU1sbHlzK0RQSDZD?=
 =?utf-8?B?TWNuWVhBdjBocEtSR1pzTEpFdExROUU5NmJLUFlHM1NaVTRMVWNtdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08720764-f201-489c-a459-08decfdcbb2b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 21:33:27.4075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Apf+0ocxnDwJBHju866sbWuk6ZbP+s5pIpTgpXi3ZxR4es7qX3tTu2ULc0/D2w/I3y7Dn5/VA/IrLlUigeCaDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB7254

On Sun, Jun 21, 2026 at 04:22:23PM +0800, Zenghui Yu wrote:
> The comment wrongly references to /sys/modules/XYZ/parameters/ directory
> instead of /sys/module/XYZ/parameters/. Fix it.
> 
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> ---
> 
> kernel/params.c is not covered by any MAINTAINERS entry. I assume it should
> be a "MODULE SUPPORT" stuff?
> 
>  kernel/params.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index a668863a4bb6..3456b104efc9 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -538,7 +538,7 @@ const struct kernel_param_ops param_ops_string = {
>  };
>  EXPORT_SYMBOL(param_ops_string);
>  
> -/* sysfs output in /sys/modules/XYZ/parameters/ */
> +/* sysfs output in /sys/module/XYZ/parameters/ */
>  #define to_module_attr(n) container_of_const(n, struct module_attribute, attr)
>  #define to_module_kobject(n) container_of(n, struct module_kobject, kobj)
>  
> -- 
> 2.53.0

Thank you.

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
