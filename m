Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3F71CD13
	for <linux-modules@vger.kernel.org>; Wed,  7 Feb 2024 06:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707285976; cv=fail; b=efuwhAaCugnNy4reVhv4Yhr18956Zwpsgtx4mWDKDl9k9pBac0cJPG1+cs/k3QGVnLtMmmTCsvCGh2cXND/isCz+a71ZaH+XQLEJU8nEwlIV3jE2d5EAEoWiOpnH27SKi2PV00k29ugivayOLC4AT7rGdc8J2jVsg7H4FykSme4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707285976; c=relaxed/simple;
	bh=TYTYb0UTpObtiZZ0e5s4PHa703f8ujyHiKeyHzXUIe8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d3U/IG50On+KPpA4/fTc5ofOdDlksS6P+uO4IztBnMSqONNxVcwNv4tzViLZ+jMwF2cjYHUGkyo8xorSJkCrIdVC2FTid85mBBSCTlCVBD3Tsdg1ffXIC7+b88ICqZ8csTZ06txQ2LdSyzBshNcQMqKmP/N5JnTZXecJiNJDnD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNb4/1zG; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNb4/1zG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707285974; x=1738821974;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TYTYb0UTpObtiZZ0e5s4PHa703f8ujyHiKeyHzXUIe8=;
  b=hNb4/1zG5vF3LFHgnw6deQUAIGcUr0MnzRBWlt9/iyCe5go39xjeJ06O
   IEDXXv5l4B6vwnAr0yL/PbTWMQPjAQ9qDh2CxlP1aSiQ+zx6RAI5BCO78
   I3G6xFJTdwpvJRtiaKyCG5GeoPjmwJ9zqvNur+WM/NzxfG+k9VPHKsJlv
   mAFYXqI5f6Qke0TqjX9dirVm1frmE8BfMsj8V9k8YOmuknsdGGaX3h4fZ
   Etbd+DzYzN5eon1arzP4p4w1J1SoYXDq1v0UtMwwFUFj1TkPZ/ToI0QhJ
   O9G9YEcBaZD22QfBDq3UwFr0YrUz+5f1emBBl54oEQKPxMtd7LRd9WldJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="1072345"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1072345"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 22:06:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="32058343"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 22:06:13 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 22:06:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 22:06:13 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 22:06:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4x1eRSWH1v6UYAm7lX3PyguAbCkSrX6JdguP/5PAd0m9QbO12B0QhFG+IjDRnX/2GN4hLWYa5f6CVzUH3jC6ZFIXdaz8nhdAd5+xGaMnI+QCPp6tfB7FvRJNSiReZn9FkvgPGgvDC2V7wa/5VogOjWgVQxXt++4+zIlAwmReOs8rFTQ1ip5c0SzhkMA4EtUYZec0aFzTBnzqvzx/mhG/bGeP6AoqE2TWpFHu1cFVSvVx6GbXoOhoYytVz1zL8bhhYUQP+fg+MqVADgjMnRORll9oDhi8eYMNFDkFnujRLPH/S3Jr4StHDIhBF0sDy2DVsGB3ZSNmhxCjxULsMz0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKRZB2PpJGl5utdCqvj0jmAw4M3LxRbjKnBBFzySf/U=;
 b=GCAaHqTqdf5zbtFMwzHV12kNfeQ0uUxWX8DSDAb7ROo98EZexj0g7nD68SmsU8kjhlDtHk1MwWp2J83ClYoGo78u6RfX3RxwQDHTIXe48M5T49rxz9FH28C34JY3PzPZsgu9XJUl3pvKdeOQ6ewViAIhfqx3TcDuHr+cThIVTWxMMmnebrz6723JrWqDKw4fa4riw39cw3ZQtxsXHoBgByR4SFm3+ClXed83eyerwTp62dAzVnJe5cvUtcy4kM17C1aJfs/MPNzdyer7gyO2B9gk+2LLcNcrfJv1nxwUenxUGWoPo3GfIu9wHKdhfTosMKKB9g+7z72+3CjY86wEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH0PR11MB4949.namprd11.prod.outlook.com (2603:10b6:510:31::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Wed, 7 Feb
 2024 06:06:10 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954%7]) with mapi id 15.20.7249.037; Wed, 7 Feb 2024
 06:06:10 +0000
Date: Wed, 7 Feb 2024 00:06:08 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
CC: <linux-modules@vger.kernel.org>
Subject: Re: Re: [PATCH kmod 2/3] Add KMOD_NEW_IGNORE_CMDLINE
Message-ID: <khn6wo2mbrdl6jebvx3opfgjcpsqn22pq2ekui6356uqto2jut@gij3s7zgjdu7>
References: <d15ca533d7f50ffd27a11fc2fdbec8aa07659b70.1701791668.git.nabijaczleweli@nabijaczleweli.xyz>
 <b666b75fa732407e7e390ba27ebacaf663e93f7d.1701791668.git.nabijaczleweli@nabijaczleweli.xyz>
 <sotwbaob52hnasqhtcz7nkezh3n3t4tnt3fmbllfmsjgi6nqvj@xva63byuafir>
 <z3lxzhymtgvvri2uhwylgazzlvg25junsdu4jjtxfhvfwksm3j@tarta.nabijaczleweli.xyz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <z3lxzhymtgvvri2uhwylgazzlvg25junsdu4jjtxfhvfwksm3j@tarta.nabijaczleweli.xyz>
X-ClientProxiedBy: BYAPR01CA0065.prod.exchangelabs.com (2603:10b6:a03:94::42)
 To CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH0PR11MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef1a7c1-9dfb-4781-7699-08dc27a2e1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fnDOl5Z9pTBse2k2y5Yn2YPQ+ldJk28EefIGI2jvFWSeVx9+WWau788Iz9qF+iB1JfmkVO1wk3uKOy/23YGMnjYutvb1l3hhkFJULKCLKfhb53KroWa8YpQZkciGzZq69gbAzQVhzA2sMI+4vPoo82x/zOrACTbwdE62cbP3ACRydEv5dB/6twvDptNSPnCXKI+rPTDTaB8x2i8YDcGI4w7vn6uKghmgN2BhVYFAi8I21uDY67c5KYjgwne9SmZMcKaDJSGNKpOU6bfGT3mbI98rmuFo+Ut0BHYLnxMAZnw+QutSti/SXqGVfcLxOVcuiFDsLejJEfgAKvP4L8PZSQWKHA5q+G9VRbr+98TJqgvn4Qysn8fAZo7YjByLs46rrNoOWv5+OwzkxlJ1lt+d8SMq70htueNxTMI5orkZhe8b3qzeicmW4bQmFQ6dW8B3Iv/qme/G2ZbwdtD7sK0hYaDby50zYjK9RCKxG/tVmukiVFjlaFtMmMqIyyk8qKo4R8licygXX6zK6N9Tmkzy8eId3arfDR5zSOoJDTKKfGGm1tH20AazTC1QBDkhNuI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(136003)(366004)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(33716001)(66946007)(316002)(66556008)(66476007)(6916009)(5660300002)(6486002)(8676002)(4326008)(478600001)(8936002)(82960400001)(86362001)(66574015)(38100700002)(2906002)(6506007)(83380400001)(26005)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3RiMi8ycjU3QXA3WkMzSDBYMFU0UmRlMnVDd3c4NGFBeFYyVy8yVDNmeTl1?=
 =?utf-8?B?T1dLTW5JbEN5Y3ZXQUNBUWw1OTVUcG10Q0xjT2ZON1IraVRxZnNtNFNVaHVX?=
 =?utf-8?B?aCtpbXF4Y1RPb0J5clFqRmp5bUs5ZkdkOUtjbFVlaVZYcFkvL1dMRUxRRWpw?=
 =?utf-8?B?SDZhSTlXbyt1enZYTnAzbTdnQUFvNWN1NytIMlpya0xRQW1IK3dSOStVY1Uz?=
 =?utf-8?B?QVB5L050anRQL1BOaU1qbDdEek9HVkFrL3BnQ1Fxd1VwNDc2K3krTXZpYzhG?=
 =?utf-8?B?WFZTUjNsNEJEOUlHbWl3RXhVYUpJdy9zTDF4bFFTT0l3NnM3WVllR2hzem1n?=
 =?utf-8?B?UnBIVTg4c0ZUbThBUjczaGt2MlJUVVRRUHRsZ1hTK3JOM3hSbUJIYVJad28w?=
 =?utf-8?B?V2VDWEVxQy9pbHRNS2dRN3FLTGZRbWdmTjFUQ2dVUGt0bkd2SEZiMzVwZDNP?=
 =?utf-8?B?KytPMVN2YTBXcng1WkpjdlhhNkkxVW95RjlYTEJVc1JISXVwSFdoZmpmdE5y?=
 =?utf-8?B?Z2xqbElpdUZpS3lvSjNFNWo4c1FENGNHWkM5NVB0a0w4NlFZZklaTzN0NkFu?=
 =?utf-8?B?eXhmSmJnZlYrUk1XTFNJekNRdytwWFdPTTMwUy9uUUNNLys2QUY3UTNKZlYr?=
 =?utf-8?B?VzlMUVlUZGZqWEQ0Yk42bzgrQTE2Sk5iNHZlVnNKMlRQVjBacmlMOTJiYnpr?=
 =?utf-8?B?a2h4VVUzcTBIQ3pSaDg5ZDNKbGhXUERsLzZna3lTVGhlRVNJOTNTdEpYemt0?=
 =?utf-8?B?cDNyVitQYWMwTVFhdGlEZW00OHk0UmRPY0lTQlBmYnVmVU91UE9mUWhScnYw?=
 =?utf-8?B?anludlg1RWw3a20yRTB6QXo3OS9KbG85a3p5UFVudml0UWpTMmxKYkZERzZV?=
 =?utf-8?B?SEhQVlliQldLdWprY2ZOMEhPQUprNW5HZTlmNjRNalFoSzdaOEtzWkY5WExz?=
 =?utf-8?B?dGk3R244VVU5aVo5QkpabDJXcUFlQnM1eklSRmpLTit0bjJUN2NkbU1SUEs3?=
 =?utf-8?B?NHRjdFMyRi9LOFk0c3pDbFJ0bEZYS0paU29SdERrblhycXlpMVUrbVNOUm1y?=
 =?utf-8?B?WHJxK3ZRRGxKRGNPUlBoNFVQRGJ5R0hoSktYVXJReDRFVjQ4NDIxRmgwSDAv?=
 =?utf-8?B?UFd5OFQ0MTZnalFwU21vY25rS3N4Ym5kck9mcVF4QWxtNlhDN1FYbUtZdFZm?=
 =?utf-8?B?NzVIMFZ2bCtRbGdESjlEWXJNcXhFczFidlU0MFZJdFpxalZrN2FrYjZET3Ba?=
 =?utf-8?B?S2duSTAwUTJrRjZaMC80KzdORFNNRmJiTlZrajY0ci9BenYvejY0YzBpV3JQ?=
 =?utf-8?B?T0Q3RVpadGlxRkdSaTl5NlBCRnhvRXZpNGdZTjMyNS9IOE9hZGcvUHcwQkQ2?=
 =?utf-8?B?U2J1UXR6R3pqeENEQ3hBN1ozUHNCNUZTN1J6QS84cm1sdytiQ01vOUcrdWli?=
 =?utf-8?B?eHFsTGRVVFpRVVZVKzFmd2IzVDNTZzJLcC9NOTdiaW1DQ0ZLU0Y3M2didVlY?=
 =?utf-8?B?eEs3dkt4WnpVVEh2eFEwaTErQWo5a0hJQ2FPblNQNUtRcG9SY050b0JTVWNL?=
 =?utf-8?B?eHJBYXR4MzRydmdFQWlpQi85bWFSS1BDeHlCU3BvSEMycDBPMFpJVmJobGdG?=
 =?utf-8?B?TnZoUlpJZitvamhsMFhTaW5GbFFuYUtYOHZyR2UzSVNtelV3R0JMSFFlcC9h?=
 =?utf-8?B?N0RldUlDUEg4U25FRjlrb2N5d3J0YlgyaGVlTyswa2RERU1LZDFKcXpCYWRW?=
 =?utf-8?B?OGJ2MFU3aWJ4aHhvaGk4OTQvUzZYbi8xc2VWbUNlZEswbDVLTHNaZXUzRnBT?=
 =?utf-8?B?VDJsYnUzaEJUVDk2WXFwTXRlZDJxNWZTdXVoSDJWODRTSTJUMHIwb3R5RS9q?=
 =?utf-8?B?ck5iWTRRbkpVSXRjM3VkRFdVTDZLV010bGVYMjJyOFduVE93Vm9tQnJ2NUI1?=
 =?utf-8?B?MXZxQVBaSGF6c2Ruc0JtR0Z3Q2dhMG91MElYNlA1RXg2elQwNmQvQ29hYy9S?=
 =?utf-8?B?cjBJNlFGSDFkbDAxcFN5YWZDcnUzUUk1UWhORlRkUTVieEFmU1lndWo2T1FD?=
 =?utf-8?B?Wm1jUmVqY3ROUE1WT3JKVTU1dk9RczBzUmMxbUdEMXB3MmdjNDM5VHBXY1B6?=
 =?utf-8?B?UzlBS3N3TGNoSFNXWTR4R3JnN3EzUmpRMmRKOVluMkVCOWdTRUYyUlE1eGxK?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef1a7c1-9dfb-4781-7699-08dc27a2e1c6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 06:06:10.8072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FrqUrL4W1zTRhbljwjuJ785C75UJarJmR9QMtM9P+D0RSZLMbKVooIbPZZalsusn6kHXGhm4c18EZmWzdCNm8d6q7nZEqc/OJRzI2vJjLeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4949
X-OriginatorOrg: intel.com

On Wed, Dec 06, 2023 at 09:37:21PM +0100, Ahelenia Ziemiańska wrote:
>On Wed, Dec 06, 2023 at 09:14:55AM -0600, Lucas De Marchi wrote:
>> On Tue, Dec 05, 2023 at 04:55:22PM +0100, Ahelenia Ziemiańska wrote:
>> 	touch foo
>> 	sudo mount --bind foo /proc/cmdline
>> This has been what I always used for local/test scenarios.
>This is also what I came up with post factum, but it's clearly not obvious,
>since the responding user did resort to rebooting.
>
>> I wonder if
>> this really needs a more "official" way like your are doing to be
>> added to the library rather than just the tools.
>I don't disagree; below is a scissor-patch that effectivaly
>canonicalises modprobe -I ... to be
>"unshare -rm sh -c 'mount --bind /dev/null /proc/cmdline; modprobe ...'"
>(the -r is removed if you're already root).
>
>I've used this approach (exactly this snippet in various arrangements)
>extensively in various test suites to string up fake procfses,
>and it ought to work in all environments you'd be validly running modprobe
>(it won't work if you're non-root in a chroot: unlikely).
>
>Best,
>-- >8 --
>Subject: [PATCH v2] Add modprobe -I/--ignore-cmdline
>
>Previously, if you'd misconfigured the cmdline your system would be
>completely poisoned.

I as mentioning that as a way for people/sysadmins to workaround that
and get out of the situation "now my system is completely poisoned".

>
>In this real scenario, ixgbe.allow_supported_sfp=1,1,1,1 was set.
>This yielded
>  [ 3852.901900] ixgbe: `1,1,1,1' invalid for parameter `allow_unsupported_sfp'
>  [ 3852.904595] ixgbe: unknown parameter 'allow_supported_sfp' ignored
>and
>  # modprobe -r ixgbe
>  # modprobe ixgbe allow_supported_sfp=1
>since, indeed,
>  # modprobe -nv ixgbe
>  insmod /lib/modules/5.16.0-1-amd64/kernel/drivers/net/ethernet/intel/ixgbe/ixgbe.ko allow_unsupported_sfp=1,1,1,1
>  # modprobe -nv ixgbe allow_supported_sfp=1
>  insmod /lib/modules/5.16.0-1-amd64/kernel/drivers/net/ethernet/intel/ixgbe/ixgbe.ko allow_unsupported_sfp=1,1,1,1 allow_supported_sfp=1
>this leaves you with a tens-of-minutes-long reboot
>(or with an explicit insmod, which no-one came up with at the time,
> and which requires manual dependency-chasing).
>
>With -I, the module can be correctly loaded since the cmdline-derived
>parameter no longer stops the module loading:
>  # modprobe -nvI ixgbe allow_supported_sfp=1
>  insmod /lib/modules/5.16.0-1-amd64/kernel/drivers/net/ethernet/intel/ixgbe/ixgbe.ko allow_supported_sfp=1
>  # modprobe -I ixgbe allow_supported_sfp=1
>  [ 4497.032342] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
>  [ 4497.034624] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
>
>This in many ways mirrors -C /dev/null and -i.

yeah... but if we are indeed adding it to modprobe, then the solution
with libkmod change is probably better.  I will think a bit after the
next version that should be released this week.

thanks and sorry for the delay on replying.

Lucas De Marchi

>
>Yes, you could do this manually with
>  unshare -m; mount --bind /dev/null /proc/cmdline
>but if you aren't primed to look for it,
>or aren't familiar with the mechanism in the first place,
>you can't
>
>Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
>---
> man/modprobe.xml | 16 ++++++++++++++++
> tools/modprobe.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 58 insertions(+), 1 deletion(-)
>
>diff --git a/man/modprobe.xml b/man/modprobe.xml
>index 91f9e27..ab9dbb0 100644
>--- a/man/modprobe.xml
>+++ b/man/modprobe.xml
>@@ -47,6 +47,7 @@
>       <arg><option>-C <replaceable>config-file</replaceable></option></arg>
>       <arg><option>-n</option></arg>
>       <arg><option>-i</option></arg>
>+      <arg><option>-I</option></arg>
>       <arg><option>-q</option></arg>
>       <arg><option>-b</option></arg>
>       <arg><replaceable>modulename</replaceable></arg>
>@@ -58,6 +59,7 @@
>       <arg><option>-v</option></arg>
>       <arg><option>-n</option></arg>
>       <arg><option>-i</option></arg>
>+      <arg><option>-I</option></arg>
>       <arg rep='repeat'><option><replaceable>modulename</replaceable></option></arg>
>     </cmdsynopsis>
>     <cmdsynopsis>
>@@ -318,6 +320,20 @@
>           </para>
>         </listitem>
>       </varlistentry>
>+      <varlistentry>
>+        <term>
>+          <option>-I</option>
>+        </term>
>+        <term>
>+          <option>--ignore-cmdline</option>
>+        </term>
>+        <listitem>
>+          <para>
>+            This option causes <command>modprobe</command> to ignore
>+            any configuration specified via the kernel command line.
>+          </para>
>+        </listitem>
>+      </varlistentry>
>       <varlistentry>
>         <term>
>           <option>-n</option>
>diff --git a/tools/modprobe.c b/tools/modprobe.c
>index e891028..de013b1 100644
>--- a/tools/modprobe.c
>+++ b/tools/modprobe.c
>@@ -21,11 +21,13 @@
> #include <errno.h>
> #include <getopt.h>
> #include <limits.h>
>+#include <sched.h>
> #include <stdbool.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
>+#include <sys/mount.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> #include <sys/utsname.h>
>@@ -59,7 +61,7 @@ static int remove_holders = 0;
> static unsigned long long wait_msec = 0;
> static int quiet_inuse = 0;
>
>-static const char cmdopts_s[] = "arw:RibfDcnC:d:S:sqvVh";
>+static const char cmdopts_s[] = "arw:RiIbfDcnC:d:S:sqvVh";
> static const struct option cmdopts[] = {
> 	{"all", no_argument, 0, 'a'},
>
>@@ -72,6 +74,7 @@ static const struct option cmdopts[] = {
> 	{"first-time", no_argument, 0, 3},
> 	{"ignore-install", no_argument, 0, 'i'},
> 	{"ignore-remove", no_argument, 0, 'i'},
>+	{"ignore-cmdline", no_argument, 0, 'I'},
> 	{"use-blacklist", no_argument, 0, 'b'},
> 	{"force", no_argument, 0, 'f'},
> 	{"force-modversion", no_argument, 0, 2},
>@@ -825,6 +828,32 @@ static char **prepend_options_from_env(int *p_argc, char **orig_argv)
> 	return new_argv;
> }
>
>+#define UNSHARE_REQ(...) if(!(__VA_ARGS__)) return false;
>+#define UNSHARE_FILE(path, ...)   \
>+	{                               \
>+		FILE * f = fopen(path, "we"); \
>+		UNSHARE_REQ(f);               \
>+		fprintf(f, __VA_ARGS__);      \
>+		fclose(f);                    \
>+	}
>+static bool clear_cmdline(void)
>+{
>+	int uid = geteuid();
>+	if(uid) {
>+		int gid = getegid();
>+		UNSHARE_REQ(!unshare(CLONE_NEWUSER));
>+		UNSHARE_FILE("/proc/self/setgroups", "deny");
>+		UNSHARE_FILE("/proc/self/uid_map", "0 %d 1", uid);
>+		UNSHARE_FILE("/proc/self/gid_map", "0 %d 1", gid);
>+	}
>+
>+	UNSHARE_REQ(!unshare(CLONE_NEWNS));
>+	UNSHARE_REQ(!mount("none", "/", NULL, MS_REC | MS_PRIVATE, NULL));
>+
>+	UNSHARE_REQ(!mount("/dev/null", "/proc/cmdline", NULL, MS_BIND, NULL));
>+	return true;
>+}
>+
> static int do_modprobe(int argc, char **orig_argv)
> {
> 	struct kmod_ctx *ctx;
>@@ -835,6 +864,7 @@ static int do_modprobe(int argc, char **orig_argv)
> 	const char *dirname = NULL;
> 	const char *root = NULL;
> 	const char *kversion = NULL;
>+	int ignore_cmdline = 0;
> 	int use_all = 0;
> 	int do_remove = 0;
> 	int do_show_config = 0;
>@@ -881,6 +911,9 @@ static int do_modprobe(int argc, char **orig_argv)
> 		case 'i':
> 			ignore_commands = 1;
> 			break;
>+		case 'I':
>+			ignore_cmdline = 1;
>+			break;
> 		case 'b':
> 			use_blacklist = 1;
> 			break;
>@@ -1004,6 +1037,14 @@ static int do_modprobe(int argc, char **orig_argv)
> 		dirname = dirname_buf;
> 	}
>
>+	if (ignore_cmdline) {
>+		if (!clear_cmdline()) {
>+			ERR("clear_cmdline() failed!\n");
>+			err = -1;
>+			goto done;
>+		}
>+	}
>+
> 	ctx = kmod_new(dirname, config_paths);
> 	if (!ctx) {
> 		ERR("kmod_new() failed!\n");
>-- 
>2.39.2
>


