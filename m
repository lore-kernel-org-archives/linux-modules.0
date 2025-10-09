Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0924A2E7185
	for <linux-modules@vger.kernel.org>; Thu,  9 Oct 2025 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019209; cv=fail; b=UdNpsI5HjK6pB6FGaINayqgo9Z0ZxamYLcD5Lol/xXugeH/h4ftr8wuzTmVur+8pAVE57+AZrv7m1KgfCzgODsrz+RMpkJmrAYo5RLETYrxD2R1UXjmGfn3DTf6ZolRyyYMfHKdjdf7YqO5aoo2+Lfl4jyzaXQSrWkYF3zWSLo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019209; c=relaxed/simple;
	bh=Eb60PpUF1B6/kzYHFExoDRpR4ujX80JeApBj6du4Ids=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CxrbloepR9VBHgz6oQVNK/ZoJa9cGd9tfdsmmC49j7XzgrgIWc4gwHa6zBF840oWQUo3GmqEKHm1j7uORTT/b6qZ2mpSVKagnQOBjePIR1YjjFRT8Y/qvTySOFKYemLENvjqMQQLu+zOpR2EOT/Wb1GtEeUyfv1FJeJ0/miZ6hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMS53geb; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMS53geb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760019208; x=1791555208;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Eb60PpUF1B6/kzYHFExoDRpR4ujX80JeApBj6du4Ids=;
  b=EMS53gebd4t8Z56HNT58lwED59b6RIUR1i7Ss4W5Nep9t4BMtfYGeAv6
   t/9VO/v4ibGCtEwkk/1yRaUpB2OC/rBuZyaAS7DH/nuymLfJwO05Qc0Zx
   qNVdcsjFEkXbqNgtg2IRqH/68ANUrHYCSDuUPN/qTu86YvDPuybTgt7yY
   sWy+tMZNnNnGqpXMoakum1JgZ+xho/Kg4QhrSn5TBQZ1hDncxzcPa1FKx
   GxnPEe/r1X5vZETnxCHdphEBc+0l/3arC57wkiyJxPllg+lRjTyopK6wK
   51iKnTCD6A3xssppn8tbIjyp9jh94OOZN4hzCBsjTqY67g+di9aSGXT4U
   w==;
X-CSE-ConnectionGUID: KYF/ooV9S+KDBzQW8A7dlQ==
X-CSE-MsgGUID: wXzk0f5rQG+L+I15vqA8VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="84849981"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="84849981"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 07:13:27 -0700
X-CSE-ConnectionGUID: TaqP8GfQQ5OFZo5ZS2vTdg==
X-CSE-MsgGUID: gmqFMWtJTlGZh1kQO+GyKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="184753205"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 07:13:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 07:13:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 07:13:26 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 07:13:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSswt2yEeFPd161keHdVpFFFkRlmH2PT8wk3gjy6oVF3GjBsLpBgIsrEwlvTKAfDJe9SXq4cnz859tU2efVxsvrKgcshs+1c+RthzIfiWn987td0XPGkZH264MUUUgc96QaI7+2L3BpZc0gnZPtqqsZe0GRCkOlLjxFZBUU8vWPXnA3p4798TxyLkj1Y4YKqF1YYpRful5zFH6uJ60tridTMIdoh5jsjng16La+15Angc9Tsxk0eyaLcYSGg9Z7g+SKH0ykkl33LzfIQ5inskJzTevzt5hjZ1SUWmSypH1NkW49sWW6CD9B+R1jPKnvEuCD61T3Ztc1i9EN2yPTeAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=369fVrZcO8xh4/wUPpLtqEjTgppwUdhtW5v2hZCTDVM=;
 b=mOyW8O2hSVQ2bjwv7JITxjWRi3cZ+fJpeD5Z94krOa8BLP2dtLqCpHuUgSY+3N6QzAQGKzLMKxR11WtBCqmOAjoW6Lu16nJnSnLDRKUcr5Ozzw2kXmksNNX0HrjifBVj0lXMGpP0bo+nAmxZ6DDW8jX6MrsCRS60JyyTqp5zbVPMLac+QMYANJ3KPOHUfmJCefB3RDZS6grXijxqZ8pdGB+4ulGVZzt9wN3O2y0xllTTHzS060lRAz0IL+2nV3czsb4xhEhsKxtyCv6fRCm1kWOwXa0sH2qfS35SlxLUII1c6VNR0vseMDXMCKClZ7KK2Xir0qnGy9l4Fcr3Ui/pFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA1PR11MB7317.namprd11.prod.outlook.com (2603:10b6:208:427::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 14:13:23 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 14:13:23 +0000
Date: Thu, 9 Oct 2025 09:13:18 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Petr Pavlu <petr.pavlu@suse.com>
CC: Phil Sutter <phil@nwl.cc>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	<linux-modules@vger.kernel.org>, Yi Chen <yiche@redhat.com>
Subject: Re: modprobe returns 0 upon -EEXIST from insmod
Message-ID: <gchhqoq7tnumgxquqzunsu2lvnh5zzscvudbt7wlhkxf6ouf4z@7nbowjxcknl5>
References: <aKEVQhJpRdiZSliu@orbyte.nwl.cc>
 <8a87656d-577a-4d0a-85b1-5fd17d0346fe@csgroup.eu>
 <aKLzsAX14ybEjHfJ@orbyte.nwl.cc>
 <02be4b86-330e-4f93-ba79-8218d05659ba@suse.com>
 <i4ayzta5zgltyubg6bfr4mwqhl6goyh73lyc7j7m3vngvpooi3@boorlngxpi52>
 <hupl3hqym5ru3fr27s3elg6vti4fjtphdwvvyxmuvekc2w5mna@kilmmcgobw6x>
 <ce7f293c-d9f9-4137-bcad-8cc492d34773@suse.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce7f293c-d9f9-4137-bcad-8cc492d34773@suse.com>
X-ClientProxiedBy: BYAPR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::42) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA1PR11MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 7565949b-547b-4509-d7b9-08de073e0174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?i7QX8Ig70iqK7PfP8NxU8bQbe6TaznNypWotqPyUsBKuHWRGBl+xt9au+f?=
 =?iso-8859-1?Q?x65imB6C/zLprpE89Us3lcq+uwJUAQF0wozCGT4IQ49QRe4+l7C4/8XcWk?=
 =?iso-8859-1?Q?JttZh1mh0sAU22QbEd0AC9dI557hWdQZZfa81MyHC9FLTkiDRanoZwNvLD?=
 =?iso-8859-1?Q?A1OInSOPwoE8Gp+SvScmkHB/jZKgQOsjc9Qshu1Pjpw5bKFrkT8/aKCWCP?=
 =?iso-8859-1?Q?qL3SCI9z8jhR50NsqwtG8oMPZxvEu2KhMhdKQ1Qu8B5ilKmGSnfwKphCKe?=
 =?iso-8859-1?Q?+gBvZszeyWKDSym+0qXx24eMLUNiaSUPmFMiNT3PIb07FX7ZuTdYlidMN8?=
 =?iso-8859-1?Q?e4uFqpjy8uw1Pls95p+1RjEaynliXpq53L4u6HZLdz73HqDvPZ9jIOpZL/?=
 =?iso-8859-1?Q?N3LmLWNcVK1XBfIW56X0dzFXTInqj6Ls1xqIcNxZ3lheRoX2OrknwLsr1X?=
 =?iso-8859-1?Q?mkDbITWuPlXIhftASyHaNevjlpepuVKNAxBsV+g+VkjO1gbOCL4oAd3Sbo?=
 =?iso-8859-1?Q?OcnCJpBqQEe4pNgfMsxOr3Agxp7Rt5K9OE6ZlCQaHP4xgglHoBdrdvHpYR?=
 =?iso-8859-1?Q?0ywhvhx2MsFgRgOCJllrHUliKFmW1EY7X97T7dCM/TNl1saGDtPCJKc2pz?=
 =?iso-8859-1?Q?TkWT+4c4cPFVXHo7KIt8sY0BytSm/nm06IMEw/pbszcF39MN5zmeeS7ysa?=
 =?iso-8859-1?Q?Qk7hW8Ec6MNWdQQ/+//UGvtSiHcIob2joyT4ZU7MzSw6oMeF8Q7RFldW62?=
 =?iso-8859-1?Q?VPjp3mNZyKs7NkNbsYUnMxhzje1I0cyrDO4QRGHyySAwYPo8nzatm+EJhW?=
 =?iso-8859-1?Q?hlgt7RCjqh5fX6LH/VaUQ/t6Yb7W0RuKLT60Xe5SdGoVj4y3U+AWjY6Kyv?=
 =?iso-8859-1?Q?OiuVg6+KOsskLIiDOGZ6FHbYcHVKN6AiVwprbmNJEHxbxDpmeRZcxhdtK7?=
 =?iso-8859-1?Q?e2qGyQMcX421XPhwWmh3X0FEGGpMViitYZG+2VVcOloVpG1iZpZ5M89PRe?=
 =?iso-8859-1?Q?+IiYTa8d9vg/KPaQRo1Lc2Flm8ltax+WAPnb3iggGofSWJT8LZSj1WfKMo?=
 =?iso-8859-1?Q?m4wFUd4M5SPF8Cv8NMsxSL+lrzQpMhgpCI4CnCAissAqTjrVPmU5TvJRn/?=
 =?iso-8859-1?Q?hpGHuwIzM1ATIYRp4RjDEz4+ezgxpptqZ0GYFeYjBUQ6cMAvkCnek4aEzY?=
 =?iso-8859-1?Q?JJU9o9FQm+QRkOFUrlDtEKRjwozxs8bhLEJbSWbbGrN2ATqoxDgr2UDfHp?=
 =?iso-8859-1?Q?dwYXreSa9+n3vYwM5QQSGihPmusFLdA171kCfkUImn/ZtSvBTKmpZGC+bu?=
 =?iso-8859-1?Q?OYi/cnKGaHBZU35FvpfD0S2BOyansHxn9mvNAxH+iw8eg5KzTm6bOflQob?=
 =?iso-8859-1?Q?5Rqkd97Dqsp0MDeo4duMsSCdZ7+evxKRXBdO3Rau0dS3HNbZ67Hzi+gaN8?=
 =?iso-8859-1?Q?i1VTvuePS/oZTd3g/WTTOl8wzvuB8Ou9KbNvUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1qPC790r4LLPNaqWt1KEwfyEHZJcUyuHeg6H13rpW87eNWzSXL7wvAfwJ9?=
 =?iso-8859-1?Q?w+zeFJHuEbmjo0OUhSxhDT7RkDU3jtjoqjuC0wwmFmmYpjU/pH14FZYV/0?=
 =?iso-8859-1?Q?yMxev5i5kilUTAf6nurEtFN0561wgx+6QtfoBQuINlr7LX2t9jctyiCdvU?=
 =?iso-8859-1?Q?37A7XXnyx7L2a9Dsrk8WNulDYk4W1soRQVzs8FxO8KO8C3rW65OxIEGkfX?=
 =?iso-8859-1?Q?k4oU6B5mY8KQmzwgSemaj1L9aoJlStSZjPK+PbfaXcSfcw4TfZu4w0QWkV?=
 =?iso-8859-1?Q?0IzXaG+SmhsLWhPd/D48S0aF8QAOgfyX9a1WepMBqAQ8BgT8slBnRSS4gC?=
 =?iso-8859-1?Q?TZKGDoUtyVjFOxNEu/njGqlxuEa1njiZ/NjAWYx/oJZE6aKI7uelZaig67?=
 =?iso-8859-1?Q?ohVor8EXXWT7SrkF4fXD1aoEYFKpRvMA1pcpqyzBpgPVrj0VtKSnkOEA8i?=
 =?iso-8859-1?Q?vPq5lneUxm0IhyNhROUmje5Yz5t7xyRJ/tBhlCpCw9rPgYBlarJ1PU5K7w?=
 =?iso-8859-1?Q?ZENh/ljHwXXzW2vEctUUjgDyQHBTGBMrfzK7w/3SNp2YgnkYYgPep/fRtx?=
 =?iso-8859-1?Q?27oO4YcBUzFG99ZQHlctWcGPryZ7T1+GZC6c01sjoNJNBuag/LcvBca+4N?=
 =?iso-8859-1?Q?LmzsgCviai8i/Ro+pVuclHYIY8uskwrgc6TPuirIP77BG5Y7ZkMcrdROE6?=
 =?iso-8859-1?Q?xY/JyCYIwu8lr5DxaqmqTwXcvRJAeRLvRk94ewN3R/rNsfTSzJx36puGPJ?=
 =?iso-8859-1?Q?5m6/BXp0Y39VrF+EKNeSi3bn0iHpBWc8sdgf25z7gwth4Mhb1H5LtUijws?=
 =?iso-8859-1?Q?pgnZCIT1DVpxK2etQzh1/+JGkyOalWBw2zQc4O8GMTFSqaelLwUK4PpDt+?=
 =?iso-8859-1?Q?qyWzvPODAlVgeLDgwlfcNqLzhST+/wbnH7/2tMbcIjVXvoc0/VsvYLdeVF?=
 =?iso-8859-1?Q?85RFlbvT0NAI6odlNenbbtkcAD24KhiswL8Ipw0rBoWlCDBZlQnim2UFS8?=
 =?iso-8859-1?Q?+lLX1zorNn74GHSWE8gk32aethJft94NeV+96rTQcy56xeCVbaPAPj4QN4?=
 =?iso-8859-1?Q?TZE6+qkeLGl0gyYw70OAxJykuNgY9p+0NV1kblu9gKMal8qSSlyfcGswMW?=
 =?iso-8859-1?Q?424xv2r3CnfakkzvQIx03dNUM8DczIOvSsLnDcVRkIqkPcmskmMFeRlIwB?=
 =?iso-8859-1?Q?NXwbMdkQKJaUN9D6XWjhO1ab6GlHTIK+cVEVQ3A54GgRi98zzmKhHnZCxj?=
 =?iso-8859-1?Q?m1uZ4jsmkfxTTr4OueQvlg/xTtUocEn7IpoLasTUMcoHGzf6Rtf6Nmt6x0?=
 =?iso-8859-1?Q?eFWMZHLLObMta8fcco9cGZpQGo3YVYAz3iko2ol1t1E2eaztV65B9EdIw/?=
 =?iso-8859-1?Q?VyF5e1oDIv92MMfsk09U01suFmTUqM0ILAzYnOqSLJ6/zEqCe3idc4BGZv?=
 =?iso-8859-1?Q?a5elbm3W+zdqDTH2AsHlETOV1bVojzLnxauz58FHtIur0cjzs3beyCfIx8?=
 =?iso-8859-1?Q?5ROPovzU9xJlPun9H//9xxkeljJyX4RLKPhjUGOl3HwrKONuEr0l7/UNfr?=
 =?iso-8859-1?Q?zUnv5+eshMGLJtkcbgDDL336uERWlzOOSCoDGwF5biG1hBFyT03VHvnQcx?=
 =?iso-8859-1?Q?ZmNbYfA9P924ViipNsS/Y9xImZ9KhzfIe6xV5H7G2wyLbinftD41ueHQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7565949b-547b-4509-d7b9-08de073e0174
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 14:13:22.9988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXIDwEZ8I+UsF9ZJzonfbMkOZX14l1AeMHC+oSaA0S9cfZc+eNSOEFKaAwDsV+tv5f6hM1czy+i+PzY5PvE9TKo8eSyoLaN8jYg/IHbKIw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7317
X-OriginatorOrg: intel.com

On Thu, Oct 09, 2025 at 03:47:42PM +0200, Petr Pavlu wrote:
>On 10/8/25 8:41 AM, Lucas De Marchi wrote:
>> On Tue, Aug 19, 2025 at 09:17:50AM -0500, Lucas De Marchi wrote:
>>> On Tue, Aug 19, 2025 at 10:52:16AM +0200, Petr Pavlu wrote:
>>>> On 8/18/25 11:34 AM, Phil Sutter wrote:
>>>>> On Sun, Aug 17, 2025 at 05:54:27PM +0200, Christophe Leroy wrote:
>>>>>> Le 17/08/2025 à 01:33, Phil Sutter a écrit :
>>>>>>> [Vous ne recevez pas souvent de courriers de phil@nwl.cc. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> I admittedly didn't fully analyze the cause, but on my system a call to:
>>>>>>>
>>>>>>> # insmod /lib/module/$(uname -r)/kernel/net/netfilter/nf_conntrack_ftp.ko
>>>>>>>
>>>>>>> fails with -EEXIST (due to a previous call to 'nfct add helper ftp inet
>>>>>>> tcp'). A call to:
>>>>>>>
>>>>>>> # modprobe nf_conntrack_ftp
>>>>>>>
>>>>>>> though returns 0 even though module loading fails. Is there a bug in
>>>>>>> modprobe error status handling?
>>>>>>>
>>>>>>
>>>>>> Read the man page : https://linux.die.net/man/8/modprobe
>>>>>>
>>>>>> In the man page I see:
>>>>>>
>>>>>>            Normally, modprobe will succeed (and do nothing) if told to
>>>>>> insert a module which is already present or to remove a module which
>>>>>> isn't present.
>>>>>
>>>>> This is not a case of already inserted module, it is not loaded before
>>>>> the call to modprobe. It is the module_init callback
>>>>> nf_conntrack_ftp_init() which returns -EEXIST it received from
>>>>> nf_conntrack_helpers_register().
>>>
>>> is this a real failure condition or something benign like "if it's
>>> already registered, there's nothing to do"?
>>>
>>>>>
>>>>> Can't user space distinguish the two causes of -EEXIST? Or in other
>>>>> words, is use of -EEXIST in module_init callbacks problematic?
>>>>
>>>> Unfortunately, error return codes from (f)init_module cannot be reliably
>>>> depended upon. For instance, cpufreq drivers have similar behavior of
>>>> returning -EEXIST when another cpufreq driver is already registered.
>>>> Returning this code unexpectedly can then confuse kmod, as it interprets
>>>> -EEXIST to mean "the module is already loaded" [1].
>>>
>>> well, it's not that it can't be relied on. There's 1 exit code that is
>>> treated specially, EEXISTS, because that error is used by the module
>>> loading part, before the module_init call, to signify the module is
>>> already loaded.
>>>
>>>>
>>>> I have thought about this problem before. We might fix the main
>>>> problematic occurrences, but we can't really audit all the code that
>>>> module init functions can invoke. I then wonder if it would make sense
>>>> for the module loader to warn about any -EEXIST returned by a module's
>>>> init function and translate it to -EBUSY.
>>>
>>> If it's a failure condition then yes, -EBUSY looks appropriate.
>>
>> something like this:
>>
>>
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index c66b261849362..e5fb1a4ef3441 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -3038,6 +3038,11 @@ static noinline int do_init_module(struct module *mod)
>>      if (mod->init != NULL)
>>          ret = do_one_initcall(mod->init);
>>      if (ret < 0) {
>> +        if (ret == -EEXIST) {
>> +            pr_warn("%s: '%s'->init suspiciously returned %d: Overriding with %d\n",
>> +                __func__, mod->name, -EEXIST, -EBUSY);
>> +            ret = -EBUSY;
>> +        }
>>          goto fail_free_freeinit;
>>      }
>>      if (ret > 0) {
>
>Yes, that's what I had in mind. Could you please send this as a proper
>patch to the list?
>
>I only think we should include a hint to explain why this is a problem
>and simplify the message somewhat, something like:
>
>pr_warn("%s: init suspiciously returned -EEXIST (reserved for loaded modules), overriding with -EBUSY\n", mod->name);
>
>I realize you based the message on the later warning about the init
>function returning a >0 value but I think we should rather update that
>message as well. It should follow the usual style of
>"<mod-name>: <error-description>". I suggest simplifying it to:
>
>pr_warn("%s: init suspiciously returned %d, it should follow 0/-E convention\n", mod->name, ret);

will do and actually run some tests to make sure it's not only
build-tested.

Thanks,
Lucas De Marchi

>
>-- 
>Thanks,
>Petr
