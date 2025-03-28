Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EEE2AEE0
	for <linux-modules@vger.kernel.org>; Fri, 28 Mar 2025 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175981; cv=fail; b=FGPweQjyvLLBaJccazCpvJ2fqGutU7nvCguDRoELad7Q51Bg4JbGgm56qvLKNXY8CvfCBT2b7lv7y3zjcC1UI6OJBGh6Zni0C9kOK/1EkApOl5uX+KAS7xCqeOh9yBaJS7FNdXSkul89QdqDSkpI/pZdFQqHRqvuVshm4BfH8gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175981; c=relaxed/simple;
	bh=V0enjId/xgIavTTvY0dJLXevCZo2RAnlgVFQWCu6Eh0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=szy8aH8cL2E9C/4rjwM9RdcEThzOGbuut+OvIhZHxkVCi2PEzBLW3icm8V+3qbg7/g5y+JbWem+wYkBIhHK1/3ZAjDIvhaa7x0KxCkxaTk/W4AugBKKM6l1cIIRlOdqE1M7UTyI5DLD9z4YxKw5kmiRPyhRnhFuTSCdWaurcrpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AvhOZC+f; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AvhOZC+f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743175979; x=1774711979;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=V0enjId/xgIavTTvY0dJLXevCZo2RAnlgVFQWCu6Eh0=;
  b=AvhOZC+f9ENBJWXwWkS9+veozmAGHoAlksnPH0xdfNlvjY6lq+aFNqJy
   YmyZIPEbMH5I9GVkvhlu73U6XxyWqkUQ4dNJ2e42/K0vXImmCPFlMKN5T
   TDPGlpBZbFT27kMBnMCtYistjV8LVFsfw6rSLRLu+DYxvaozR+KH/e/MJ
   BxQkem7tyBbzF+dllsHTk20rGmAe4H4Ffos/AAfSabxfymNYjU+PeeQLm
   W0Ee1JJKAG111kpTY/4RRG1YY6tIvS8mUPy9jijpVkqa1hvPysHDbdCeN
   EuzDTmmKM831DWBOYu7Q+EHGEHdmhjpkyOfyYyQwa/vR/Ox6HP+RmsLpO
   A==;
X-CSE-ConnectionGUID: JuaTN9ewTuexvsgsABBTOg==
X-CSE-MsgGUID: 2eZgcclPS3+6vNjeevCXoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="44426723"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; 
   d="scan'208";a="44426723"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 08:32:58 -0700
X-CSE-ConnectionGUID: UTHXcC/rTb2lX8YgHCHn3g==
X-CSE-MsgGUID: +spIjclXQyuIhjG+QaNgAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; 
   d="scan'208";a="125480335"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 08:32:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Mar 2025 08:32:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 08:32:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 08:32:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0tJH8jG6jCL7NlOsgaKf+CrbD8zuPceGMmrDVFpyXzHMFrHROg1hDObbrFAgZh+ONBh76gtY5o+8HDbgNKhBX+quznvKFFrqyOd2bDdmAj5mcMDklnXrCWNUJlTFNzonn3LOZnL39cQEHBV/p8ihSatji7j2u6KTFDnL7Y2dgMFrC1zCKOLDQ/wfbPMyPa7mHtlPYJ/Ax/LOLGGCycWwmt08DGWLsj1ZsRApd1DFGC4FalKFfmZ31g8a56O1Mrip1GbPc2l8IzrVclxFyz8iHpRNSs4ye4Lv/Z1mUqwpJ5E7Oy60eZkMbTWymEzUa6evHrfaQZWXOTad66z4zOIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yTg/OZrtMb66PkUYhCCHBrq97Tkwvx8WDRXDiXf71I=;
 b=OfIsTTcn/sgux+97D5gJJd9vi4lTw4G0d7JcvvznRiWGnsUKXvQOqfcNmrzlnxWHJXpFcSmM1FDS2ZPCMLsfyptZ5nCa8EVg5jp5qaf8odp2ODTh9kfI3/BcQMJ8L7Aopk0lD7O6yaP0oY7XmEvAzeax9EbDXMZHRdrOkO4Dj0QO789Gj6RsECbK5XiMT6VoIcZdUq+FuI9SNcgaISQUkfHT/orn7CgNhLxyc/YaNHBnoDBX0voffo0A9evN53gIV9pI5O8M/GzJo+LxM3FK7rkc0MX9nFScIf/FlndaMahMs+2PRfxLIrOvBIdHZ8np/5fGf4G8gymnfRD2QU7w+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by LV1PR11MB8841.namprd11.prod.outlook.com (2603:10b6:408:2b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 15:32:25 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%3]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 15:32:25 +0000
Date: Fri, 28 Mar 2025 10:32:22 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Yannick Le Pennec <yannick.lepennec@live.fr>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod] tools/rmmod: fix garbled error message
Message-ID: <4nid4wkwcz64u24coqh3tpxr3krfsi25stdojaa3klaqkhpr7w@7zmqmds6w53s>
References: <VI1PR02MB48291E3BDB7E764ED67154949BA42@VI1PR02MB4829.eurprd02.prod.outlook.com>
 <igg6ghsjjn7ciboakccpavw3vbjssk23mhab5nbe7qpaqap7kk@6btizzrn26y3>
 <PR1PR02MB482622FAC838EFA69D566F549BA02@PR1PR02MB4826.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <PR1PR02MB482622FAC838EFA69D566F549BA02@PR1PR02MB4826.eurprd02.prod.outlook.com>
X-ClientProxiedBy: MW4PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:303:83::6) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|LV1PR11MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: b2952184-d0d7-4375-3bf4-08dd6e0dbd70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yE5LIvFZ2HXEjoEB9g5mWQ2jOLgGZd6KFVN8RYtDo5nlbLMLxqUqtJEtdjdR?=
 =?us-ascii?Q?TI0XReiplNkwYAKfJLvxTYy4gdMrWf+G5PhswhTBm1c27iCZQaLXMcLbpJbf?=
 =?us-ascii?Q?+rFFYxcUuEQp+Qu+rmcCiZ7bP4yhahrw/KSnG8mdamIrZ+fTm3nm8Uv850Lo?=
 =?us-ascii?Q?LH1mRP+gwA6wBJlQ7IKncXWDSj8hN95P03j87FPbBRwFiu3y4ZMqUOSjpBAw?=
 =?us-ascii?Q?zqZcGOulX++aR0S9/nA3I98TvWftqFxfLDzBe2cOiw6h6vKEJHoThhNeJdXV?=
 =?us-ascii?Q?ILNP3q0C77mTG1TKuNTjtUrGERXNgb/6GzFKYvBdl+MU6GpRv4NpMTHWGjnF?=
 =?us-ascii?Q?lGYfFjh4sDMo2kIGEV73dgmQpcEaQckeFpeFQHikACieMtJ0fzhfOoghSSec?=
 =?us-ascii?Q?G3yPzJF1I585Dizj0I9Y+M6WjjyKFOy9e+5e6p8XjTZACyWFrfXm6T0p9WrV?=
 =?us-ascii?Q?Oot5nLJ1key2GcOivtOsmzJo3cx5UyamhPDP0ZzAIxkTS8NKTkTYw17bsC5K?=
 =?us-ascii?Q?l5eTVCXKhoIUEA5WbQKVj8nd/EDg/yZ3GViGll3laemEUUQA0IzhrjgWaekd?=
 =?us-ascii?Q?kDPrNw2eO1GonDYb5cEg/S/EWrKI5VigVybBSIxYFIt0DXXJI1HFj2P6KYgq?=
 =?us-ascii?Q?ebZCXhJ41rgTE85LnWX/RJ7Y/9Ea+PSXqXx/vxoLauSFZbO3r3etHLXIHtke?=
 =?us-ascii?Q?cQRjsmXOiw6HfuoWfAVlIM4YY2ua8ObNBJGjBmyLzL3Z7bqBnjhCnuNgYD61?=
 =?us-ascii?Q?U8+d6eEVThBKPlOUo5v2YU36CjjuRM2RUZsxPVfCSExGxeQcYnYaAwKBydO2?=
 =?us-ascii?Q?cgQzB3nPTMZqBG2KSkkKZa4L1BT333qmFIGMpH1poFzLDwE9+iQp9ISrjAz7?=
 =?us-ascii?Q?tSrbvhC0rk/XCnGm4hqZGjqsSjhtVb60BUvGncXBnj0ZH/HRT9Yaxt9tY9oA?=
 =?us-ascii?Q?jp2O/RgmPcme6KoTIM6vZZkhbQfaL7YbewHOF5CVjvjRuoWEzZC2G4LQMHCg?=
 =?us-ascii?Q?uvRlGfyhaGuy7O9BVO/RXGeQcs09j0ZyWPV8ArkcKCgAXWLYuDW0BsX0vuq8?=
 =?us-ascii?Q?fi17ROznBvvSO1Y92ZSH2FSBrFLhcwk0NahNbTRqYQMrGNjrV22g72TAp9Pq?=
 =?us-ascii?Q?bnc1qVwIxIpUrSAuh9PAbbxozagJ2EOzW+ZkLvg98od5eSEfmGP2zBah7feD?=
 =?us-ascii?Q?CiAM9ncLmFz+8DWUpON5vLt1UrVLoyGgnoU69HyjH9aDN4HDNhSYNAoDNECG?=
 =?us-ascii?Q?SVsgL4MD5CnMjLLbQj1SrrWMhA8SHwdLFy2qDPK9KshX5Rah9rl6ssiO0sr9?=
 =?us-ascii?Q?7jnwizdXh1RgrMdkKi5zZGKWespZZ9zgHgo+I+z/7B0Ckxuc0hyBfwMDCKkg?=
 =?us-ascii?Q?tzeE85XIQTUkH/f8xh6aOKpp3SND?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?72Q1wrAXax1FGHLVorg2OCeRsXXjmU8RQareBI+n5UoeHAatDiB2YNn8pBoP?=
 =?us-ascii?Q?DyfXIMeAYXBd7P1JOnVy4rcBolvMn7f4gKqoh+YqrMH1hpO+IU4INyZnte8+?=
 =?us-ascii?Q?rgIGtrd3gVZzZWs3bKQZiKcjV1a6qeZ/3oB/42XZFkbJhxrZGjo62R2ISEGV?=
 =?us-ascii?Q?OMZ7rqsSU5nZUexiJgN0x2BoFLPF5lkXxYpMx3vWjiMbSslzXCfEExOelW6m?=
 =?us-ascii?Q?bKFcu3vl4cUXZ2Hzw5IsaDJ48geYnbsyCsWZytp3wgEsXHd28z757r+6wMKN?=
 =?us-ascii?Q?lldqODD5M79ZoqkrfXknLqWBlk6BSvKiJrQUiZ9aUAZtZbwd2LU0tZowI8mE?=
 =?us-ascii?Q?O0QUsy8/t0tuPXjRyCyVxFMTky1yM6YLFwIZy/ngarRXkPgvEftKDusomr17?=
 =?us-ascii?Q?2UV+9G+cP8zU26xdqBniCJx4gIu5RRwf8tXRzPfgz9SpExxS0g/FwCfIJxlX?=
 =?us-ascii?Q?kwyBzGNL/giH+ZvmpI8tp2nnteXZsi08gOQQd3bmynpapNkA+FIBCJgynGD6?=
 =?us-ascii?Q?FSM8qgILEKoLIz9qObcgZlWfrVvb1V+M/ap5pWE/X6z2V3wqoI0iJahBNKO7?=
 =?us-ascii?Q?V1xC7f/9RUlFlO7/6ATLj4E7CZ7Ts3fMWQrvQojAcKbVLo2Rrly4LVnpaTqh?=
 =?us-ascii?Q?Q0zaJIaDSnbxRnIcaOcgFrzaaeklsOrugmZIXGm2nw7vocoo0g6CWNbzLC1A?=
 =?us-ascii?Q?BlInNUd82gl0anW6Lb29FoW5BlPE5UdgfwasDa9gICNGoW5gAUFrl5w8EuEM?=
 =?us-ascii?Q?K9Kdrgi1Q3Z0NHfg31XM5knoupfCS8j6Lfo3IbhjADbRztA3GpUdpNNuWp7R?=
 =?us-ascii?Q?rUPZOZsWArCsvxCC2BK5XAPcbR8aQ8ZPgAHQ/NwO/xDbstUXGX1ywgmzy42D?=
 =?us-ascii?Q?6OsYKgnHpetrV9t81M7Hi9tJDrqm7m6T6lJflte+RnYAncNEdPnKSci0mic7?=
 =?us-ascii?Q?mbi4YlEydGl7rRmRzOaWRdSgpo7DBDx2AcDvWgaPc1u0QW3Dfz/VP31gYr5m?=
 =?us-ascii?Q?CYiJy543gBdt0her3mYUVm5cX7xVuZRvryIQQKQJcNj2o3ONBnxgqqbgfRYX?=
 =?us-ascii?Q?3GJqF6sUllEVIilUFiXXYsVJWPK2cDXKd9D75QJfvwOQkVcjsQmep8SKNdcn?=
 =?us-ascii?Q?1MixO3sbR9fDpvlI/C5maYGiR6Fn3zdX4OtkxcrsKfmotI4EravCtay6Plj+?=
 =?us-ascii?Q?P/Jd74WvZ3kmaP9pJezYJneSXdYJayyn/u7UhKQRy24GWzVodommOvnn6gUS?=
 =?us-ascii?Q?OEakh6UTjyhrbg5gKbOXx2tzF9NidvNxeSldFTdO7/HT9uCcSc9XQ3i1v+Gr?=
 =?us-ascii?Q?gGqivfvPr7b3VCbKbgZA3ROnGM0qQDnp4Pz3tA6y+FCuV/NHC/MVv4BNLF5u?=
 =?us-ascii?Q?EmfiH0/4MIEWq0hvyBsWP9k+KZjENxOtkwzA57Yr81nnS49ajnubKNrj8SI/?=
 =?us-ascii?Q?FgXlOlvtI4jAy9T3XsEtK9bLr8uxXWJVH4VqYXzpsAEJzcUSpfcio2i7p6dS?=
 =?us-ascii?Q?8Ya70P0K32SrFjdZ44eLb7BMq8aMgFEjtQeTUDDSpfWxA3vsTvYwhvsf/iTC?=
 =?us-ascii?Q?b92J9xrzOMlMr6HrYU/QVpAVL3qAZRzBersQijLf++VPyfaEOXvVS4HniV/P?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2952184-d0d7-4375-3bf4-08dd6e0dbd70
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 15:32:25.0035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1DBMzoO+iSYtbj/Av6FuPTjYAHsDh0+Cmb6egQqZxzOy50x+ozgoWuDm/zSvgAygmJNKPWztfVSCgNqpef8CYSAJ9XuwOqdm6is49Lo7NE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8841
X-OriginatorOrg: intel.com

On Fri, Mar 28, 2025 at 12:36:25PM +0100, Yannick Le Pennec wrote:
>On Thu, 2025-03-27 at 23:13 -0500, Lucas De Marchi wrote:
>> On Mon, Mar 24, 2025 at 06:35:53PM +0100, Yannick Le Pennec wrote:
>> > a6f9cd0 ("tools/rmmod: consistently use ERR logging facility") fixed
>> > the split between syslog and stderr of various error message substrings
>> > by calling the ERR macro instead of writing directly to stderr, but in
>> > doing so also completely mangled the output because the ERR macro
>> > decorates its arguments:
>> >
>> >    $ rmmod iwlwifi
>> >    rmmod: ERROR: Module iwlwifi is in use by:rmmod: ERROR:  iwlmvmrmmod: ERROR:
>> >
>> > And in syslog:
>> >
>> >    $ rmmod -s iwlwifi
>> >    2025-03-24T17:22:34.878318+01:00 mangolassi rmmod: ERROR: Module iwlwifi is in use by:
>> >    2025-03-24T17:22:34.889145+01:00 mangolassi rmmod: ERROR:  iwlmvm
>> >    2025-03-24T17:22:34.889224+01:00 mangolassi rmmod: ERROR:
>> >
>> > This commit fixes that by building the holder names list with a strbuf
>> > and then passes the whole thing at once to ERR.
>>
>> doesn't that mean the syslog version will only have 1 ERROR now?
>
>Yes indeed but I think that's the right behaviour. Prior to a6f9cd0 there was
>only 1 error going to syslog (because the rest of the line was sent to stderr
>erroneously). With a6f9cd0 N + 2 (with N = number of holders) error lines go to
>syslog, which I don't think is what was intended? After all the stderr message
>itself was always one line, and furthermore the lone ERR("\n") was odd.

oh... ok. I missed the fact that you dropped the newline and just added
a space as sep.

Applied, thanks.

Lucas De Marchi

>
>>
>> anyway, queued for CI at https://github.com/kmod-project/kmod/pull/328
>>
>> thanks
>> Lucas De Marchi
>>
>> >
>> > Fixes: a6f9cd0 ("tools/rmmod: consistently use ERR logging facility")
>> > Signed-off-by: Yannick Le Pennec <yannick.lepennec@live.fr>
>> > ---
>> > tools/rmmod.c | 11 +++++++----
>> > 1 file changed, 7 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/tools/rmmod.c b/tools/rmmod.c
>> > index 962d850..61f2e00 100644
>> > --- a/tools/rmmod.c
>> > +++ b/tools/rmmod.c
>> > @@ -15,6 +15,7 @@
>> > #include <sys/types.h>
>> >
>> > #include <shared/macro.h>
>> > +#include <shared/strbuf.h>
>> >
>> > #include <libkmod/libkmod.h>
>> >
>> > @@ -63,16 +64,18 @@ static int check_module_inuse(struct kmod_module *mod)
>> >
>> > 	holders = kmod_module_get_holders(mod);
>> > 	if (holders != NULL) {
>> > +		DECLARE_STRBUF_WITH_STACK(buf, 128);
>> > 		struct kmod_list *itr;
>> >
>> > -		ERR("Module %s is in use by:", kmod_module_get_name(mod));
>> > -
>> > 		kmod_list_foreach(itr, holders) {
>> > 			struct kmod_module *hm = kmod_module_get_module(itr);
>> > -			ERR(" %s", kmod_module_get_name(hm));
>> > +			strbuf_pushchar(&buf, ' ');
>> > +			strbuf_pushchars(&buf, kmod_module_get_name(hm));
>> > 			kmod_module_unref(hm);
>> > 		}
>> > -		ERR("\n");
>> > +
>> > +		ERR("Module %s is in use by:%s\n", kmod_module_get_name(mod),
>> > +		    strbuf_str(&buf));
>> >
>> > 		kmod_module_unref_list(holders);
>> > 		return -EBUSY;
>> > --
>> > 2.49.0
