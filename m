Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E73179B2
	for <linux-modules@vger.kernel.org>; Tue, 30 Apr 2024 20:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509418; cv=fail; b=YO5kXd/5D+i4PubX9XStVW9SZiVWvT+3e3G3jPs14Ypw06EIIZFxf91w+Re9ZWvD7OcTTsbETDed6W6XjfbuBO6LbikxDA8PIIv/RQLJ0Zk/rBPuNoBHs/VSWbwi+AYO/7zGLPWUZCLlGfGK21wO9T46JJNpTdhRFKxBXwuMZjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509418; c=relaxed/simple;
	bh=uOb+uf4U8z1mt2fkeDUqQ4Eu08nEmGlQ3bZZiBTFASM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gPgrt4y7tWHNtUhGqJYMBpU4MsgHArPkZhRcMnZoN7dhLxkVeo4RV7DXlC+3Oi0yH195LMYMJgIbjh4qGuGborn0FHjZC+JYvSk8mqmIFfqxbTkuJYGXpZXTQXfEsLrVOvpWjTrgucdBBJqrdL8e4XV9AgxvhqBZDWXk1TPj4nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxPQ+KlZ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxPQ+KlZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714509415; x=1746045415;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uOb+uf4U8z1mt2fkeDUqQ4Eu08nEmGlQ3bZZiBTFASM=;
  b=fxPQ+KlZ0iB7//uC8PV6UxlkzMnIw9f4OuAHFBe6GgBdFPttATHlW2gL
   9gHoA1Pwc1UYIcc08wQoOgQiu4YfV4JK1dvr34auarj6v1ip9UK1pcNUz
   Qzm4TDKfAOYUNPqMPLaYl2IcdBBzJ+3WPGzYAbMGgkg9/gA/lUdWQRAAk
   9gruegY0T0ngFijsG1XHoNQitYGamdSFjaXSn7qsScjx/tSkfCszs3bxx
   ppXPIgJMx/j9gc45aHKLMMzEClUD4iv1YhMQVJ7Yt8gYgyS8qxfzUQnQs
   klB5RUlPzDrbwYn7sE+jwclfs0WTrmeCp71J43AnROYc0O17cwwEn3Wwa
   g==;
X-CSE-ConnectionGUID: SGrc1NwYQ1CsvuLVzXENwA==
X-CSE-MsgGUID: Kha/ueOmS56lF/3hju0z2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10087580"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10087580"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 13:36:55 -0700
X-CSE-ConnectionGUID: sLNVGi4JRjOpiDKgpeX4KA==
X-CSE-MsgGUID: 5aeG1xu3TWOG0ne10NvwIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="31059296"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 13:36:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 13:36:55 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 13:36:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 13:36:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 13:36:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epwwAN7SZhLbbxYbwJjxhCvWKgWdxzl3J4R1uepIOIUIO0JrFTeMrCMgM/s0qm7RxjBwT+ZwBfKpag/LGh5rUvz5vKFsYJHbQiTg0oPAPdDFLjqVwYDkFiBhrK5dhX2jsD1OiWpPPwVCwTXMVhIS6dXeJ2v8FKLLJOi65/71ajc2p5xbKh6ZqCznvj6gxY3Vw3xac8GZ3C5PWlH5e8Pbh4NFeYRml5aHzAvicR48x7mUmSvR5aBOd8JQbCKWoP3BtEyQlYE/Q2Si67HvK5UeS0O4dcguLJIjlKWieXES2uIHT9SYlH4dO8b91ER5T7upr7XScPUtgY7SQObZIDoAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atTok3MCLcLxtBlxKApUFrHujhK9FFcdLLgj/JHrEUg=;
 b=XKbKtvZhA9ifgozps7hIwUwD6jsDwv9tnnIzkQf/ITPAhq7VV3XilZkOTO4nKDlpganKg26gGTqYj6Tw2sxtrgxzd3wXHGdcPnjv8MgUP3llOzHHPIcdoXL0XDW4SO839SYZ+Gj7/RAfpwJsu46AVfT8QqFf8QqiprDZgqVevF3S6vM91Vxd6fKNzuubBnkxijmFHPQv8jG6j5jgaZFMPXbIfgdA8NxW7XFSEfiFauPXaXQ88lFgLvKgafpZuwJxXC4oQmG3XdGaw48zhvAsQbpdzsDbfVpn499Jhdn9rCoOMOqiS4pbHFl9fNcqAACmiAjjgY6PPc3ZIckx58XhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA1PR11MB8542.namprd11.prod.outlook.com (2603:10b6:806:3a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 20:36:52 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 20:36:52 +0000
Date: Tue, 30 Apr 2024 15:36:49 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Emil Velikov <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 09/13] libkmod: swap alloca usage for a few assert_cc
Message-ID: <nwx55yhtojz5rzhfjdcvfqq3dmtmpigw3toour7w2x3smuu3yc@nujoed42ihxl>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-9-06f92ad07985@gmail.com>
 <37jvg2krroliuncyposassjhznjcgrxmvdre4mesl23npukbpn@jz7ntjkcpd7o>
 <CACvgo52PTWuDcv-P0Ls1oESo-cOsygUpD-rbK9oUTHy30HpS6w@mail.gmail.com>
 <evfd7gytzrrtmvj5tjuxpwy5k463xeoe5rc2y5nrisgv7soqpg@veupfudya45x>
 <CACvgo50mEAQkDSJxqF2=QKNGbnBZ7QbdKZDgy9adDy68rLbP5g@mail.gmail.com>
 <fy4a43i62oo42sukpmodrejhglibxbkzom3sgdow4rxsg6j3cj@6l3h466hxsjs>
 <CACvgo53TX3EnUA-NJPuBRZKO3mLM3u_KJdBWjnV4kENVagVxMg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <CACvgo53TX3EnUA-NJPuBRZKO3mLM3u_KJdBWjnV4kENVagVxMg@mail.gmail.com>
X-ClientProxiedBy: MW4PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:303:16d::28) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA1PR11MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: f66fb4b4-6b12-4240-5502-08dc69554487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XpazxJaMnD7p4Eszh5PIX4sef+GRRUkIBXjYA5ve9cdtN5IRITXsKm1kQSeE?=
 =?us-ascii?Q?IzQl7wJMPSqt2VsW3nhSypDMR2sdu4dIMbmcEJDADjFbAUuPNCxW7Lvv79qB?=
 =?us-ascii?Q?R8HsKEDcVKkwe6mHvF5HXX0nhS57lO5U4t9i0AimguvVCAumebgt3+lSoTcb?=
 =?us-ascii?Q?4loypEbGbJJ1yPN4q8J0OUBLtL2P9BHvaEQYH/1zX3nZa8WW+AoIbfKwlFdi?=
 =?us-ascii?Q?2LKgemncA4a7siDFN8d1x+Z22Pcm7CjELr9pj/wxIWDiwOA1l0qyHA9tJiRI?=
 =?us-ascii?Q?NK29RG+Kla0Rnb7VfKFdf7+4blMaL+BnS9JPfrpRuGNijwtQUf5PHN6IXalL?=
 =?us-ascii?Q?Yklfr1eWzkwUgjnirRURUK+ifAnWb0MuYm1KtbBf74DbfTZH5PJHiHrs+bgs?=
 =?us-ascii?Q?0jZIU+e+utN2SUr6ptb+1SiCpa4w2HY8b4rjWAMoIikEWJGarW8qph7FLy1n?=
 =?us-ascii?Q?nx8oAsp7ZrAm7wk0ucpezbeUkYWjJ+tpMTa/3UaIi7vq4Y4d63salfztGWvH?=
 =?us-ascii?Q?5IpAuBkADjQCSQKTzVfwxZPj4JqZsd2qfseyCaz5AUEeUI64a5bEZARko9nt?=
 =?us-ascii?Q?SyNXOy2b0RLzCWh4RjffVHjB2mhvwoI6RHn5yOE0NRrRb1vVTVGDXtaviaLh?=
 =?us-ascii?Q?iUFjDxMIvaoTWk9vdPdH9DhHqI0OiZGoImk49qUQYQXrOMgCskeKIMdynhgz?=
 =?us-ascii?Q?PDlJB9HG3KpeXD7T0YTUGya+8d9S3If9lxFGTqBaRktPjXZr2P6D0NoP2Cnd?=
 =?us-ascii?Q?/1oF9Lh/A4KGT5JXbeC7in1+IyV6WO0oG3S/YI5tzTBcPQ0Zr0LWipZIvzQo?=
 =?us-ascii?Q?FMmljmGg4QL+Fscq9h5p9hkLRSBJPM3lPtTEQ6c3IQFQNNm5FWI2B6VjnOGn?=
 =?us-ascii?Q?Lex+E+fNmCO4z/iPnlXu/aJCl7rnmuDKUt2FopfnBS0oVtJJiLpzbaxdQAgx?=
 =?us-ascii?Q?tCz18J4LCQqsqhuxixYFckxELACSujyyXrcKsPp8e/B9FxmrrxZxvYv6Wbr/?=
 =?us-ascii?Q?k/eEQfoaUhBKFrsHGPGtTag5RKSQgq3GbjU/VWKfn1hETqDl8elfJrxyzMRM?=
 =?us-ascii?Q?diuQu3DPR2mQF7MeBBvTkYaq2hB1CCOxvIwaSWSgDGzqgxdd7/c6SpX0pO0K?=
 =?us-ascii?Q?JIEWSYWgpx+gNgNbMLWHMbk1N1JNtkxT1+vywfl1b4+tMCPzmP/uzP3JdRWH?=
 =?us-ascii?Q?bvCD9mZyxdRzMFmQMFpx9oWgO/K+94oFycMGDkUttQ24vBmTbkM9pwaV/yHK?=
 =?us-ascii?Q?5XLyHLgJxyxU4iVumb5CHNNmFQS9YacY8HbUVqvQSg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SWb/tiII7M1qyqpMvQaCSH9LwygRhQBtN2W8VORfulHY4lfxtfvYdL+tmrjG?=
 =?us-ascii?Q?rNxVP2xVU+YP30/FXblSX59eUTfQTGMMcOdmvBFFweE0gr5Gm6omXjY++erW?=
 =?us-ascii?Q?yYdjZJX0xv0PlmE1aXb7JycIo0e69rsTRYtBNuOR1umweT6sYFq7HPGGL8ne?=
 =?us-ascii?Q?2vfiUUE1btJQnHmu0+1bN5fELozWO64SPepyR2Zt3M89RAnEp+AvMvRQZ90F?=
 =?us-ascii?Q?d59JEowh2nZwZBHUy0zCth7hdAzXKKkAHinvImLl/vKLlPMD6gUnbd+SQQJZ?=
 =?us-ascii?Q?7xodXDswVpQrsr+zVz+YyyA/SKpoFQXS10oSHN1KHcj4YztY+x5LSmg3GMSy?=
 =?us-ascii?Q?YjqVrD+WprgsJx2Nq7NZlchn4J3yi16gObjvwrcYOneVqDKGFiHZxDTTgZtV?=
 =?us-ascii?Q?kutYrPrDdv7vD9OZFGg+uCa0IhJt5wp9XDNDAmh3HZgcS+8v0sI6M8Ipz/gZ?=
 =?us-ascii?Q?9OOZGcE7/iLfcFj/TMYXBBo1W0CmgSGf/jQoDv4tAAcvLdzWRwWT0Fv9iNYM?=
 =?us-ascii?Q?s7D3OgIx2PvfiOQH1Dw4UI2vhtGKSUdcj5/yW3hJRjvo+8xbFUo3q2gF4488?=
 =?us-ascii?Q?pJIsA+Wr3ZanEbQmlZsFfTwIsc9BoQ2TwwPpWdxrjQyXsT0z730e6UlJ8wDB?=
 =?us-ascii?Q?UjGjlFZ6VUneJ9YEp5KPZ2SVVgpH1zZ09KzFxz0P8PaD+jqFE6mm82GOYQ2P?=
 =?us-ascii?Q?KY0/2pHrBfEMho3aj59M5IIBg/Js5RBTjO4uY0uBtM8nI58ugX/udcAYA9sM?=
 =?us-ascii?Q?a0ZUj+w+s8Dwyl8TC3ZJQQz7oyzakIHK/apyl39KxmarRtDMb35yFU/dhIGp?=
 =?us-ascii?Q?NLrYyOPlUqECAZD9x9L1HGbvuYc9PPARR4adhbSkNKvEw9zBf418YVlHzwoA?=
 =?us-ascii?Q?2j6rI37uMfnOlFHmGaLtXFJHAvpXfX+E0igYv5eXY9AMbh24thmM1B6U+yih?=
 =?us-ascii?Q?8xFsP/RyQEiMIQ8VSP11voRXYJKZRIsJbHt2V6wLfTckzo8WXI0MkLqfBqXz?=
 =?us-ascii?Q?vfR0+1tUPnea2U9/m1XjXL4fsZgUiu09lB3QJQ0eVpmiBZKPHWs45wNvZedx?=
 =?us-ascii?Q?+Ds37Bj8IP8kfQ4HaflRbBLAv5JXi6+VqB9fP0zLCyzU2s05FIZZ7/9KO2Ge?=
 =?us-ascii?Q?CE8Z9LD9RD7VGeeQZuJYso27oYU45DRoczzAL05NDnmrb/SVBmO9lLcYEXtA?=
 =?us-ascii?Q?Z5q2ZymNp2mFHzAQ9M0pbeGjcCsVnVcFlxxrd/WXuWm4Zfp1qi9bu39Yj6Wh?=
 =?us-ascii?Q?TsrADr1vQBMKKKJlPpkYs0+FjZsL9+0VJxuIMNBFkKBAsNcUg523hOapu14+?=
 =?us-ascii?Q?tNBx4GmmghsfArmei6TDn97FZq4md3joVdfR2v+Oa/3wq7ST3vkRklzcGBEy?=
 =?us-ascii?Q?QmH5u0PAR+WLQgeQWj4h3ho9yCxr2ySkB95RYbWtJAqACrM3qVaMKFHSRxDw?=
 =?us-ascii?Q?tzkklypUZghTrf8mvfckzDwDiAa2l99BXbqbkTLp5b94p3AoWcEe/20CmUi2?=
 =?us-ascii?Q?l+8ka3xhodeEDIzwCvSG81ReHUtiNdwlhWEZg+1Z/KaNbRBnbCY0avVKnTGe?=
 =?us-ascii?Q?98sz30YASYb06zaqdC9UuSu5XIBPq6b4M8yliAeLxyt8EE6EmISUlgzRlJ2X?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f66fb4b4-6b12-4240-5502-08dc69554487
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 20:36:52.4847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhqM7gTFTHWlzcipuBCkel4ovltR/uX5dFOacxYhHr0I+lRVeAhfR0SWU0qQDzOLfMzgORdgejQnCs6cDUJ778h4h/Nu5wiswEYbiBODS7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8542
X-OriginatorOrg: intel.com

On Tue, Apr 30, 2024 at 07:47:46PM GMT, Emil Velikov wrote:
>On Tue, 30 Apr 2024 at 19:43, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>>
>> On Tue, Apr 30, 2024 at 07:27:00PM GMT, Emil Velikov wrote:
>> >On Tue, 30 Apr 2024 at 19:18, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>> >>
>> >> On Tue, Apr 30, 2024 at 06:54:00PM GMT, Emil Velikov wrote:
>> >> >On Tue, 30 Apr 2024 at 18:39, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>> >> >>
>> >> >> On Mon, Feb 12, 2024 at 05:23:10PM GMT, Emil Velikov via B4 Relay wrote:
>> >> >> >From: Emil Velikov <emil.l.velikov@gmail.com>
>> >> >> >
>> >> >> >Since all the compression magic is always available now, we don't need
>> >> >> >to loop at runtime nor use alloca - latter of which comes with a handful
>> >> >> >of caveats.
>> >> >> >
>> >> >> >Simply throw in a few assert_cc(), which will trigger at build-time.
>> >> >> >
>> >> >> >Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>> >> >> >---
>> >> >> > libkmod/libkmod-file.c | 22 ++++++++--------------
>> >> >> > 1 file changed, 8 insertions(+), 14 deletions(-)
>> >> >> >
>> >> >> >diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
>> >> >> >index b69f1ef..5b88d6c 100644
>> >> >> >--- a/libkmod/libkmod-file.c
>> >> >> >+++ b/libkmod/libkmod-file.c
>> >> >> >@@ -410,7 +410,6 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
>> >> >> > {
>> >> >> >       struct kmod_file *file = calloc(1, sizeof(struct kmod_file));
>> >> >> >       const struct comp_type *itr;
>> >> >> >-      size_t magic_size_max = 0;
>> >> >> >       int err = 0;
>> >> >> >
>> >> >> >       if (file == NULL)
>> >> >> >@@ -422,22 +421,17 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
>> >> >> >               goto error;
>> >> >> >       }
>> >> >> >
>> >> >> >-      for (itr = comp_types; itr->load != NULL; itr++) {
>> >> >> >-              if (magic_size_max < itr->magic_size)
>> >> >> >-                      magic_size_max = itr->magic_size;
>> >> >> >-      }
>> >> >> >-
>> >> >> >-      if (magic_size_max > 0) {
>> >> >> >-              char *buf = alloca(magic_size_max + 1);
>> >> >> >+      {
>> >> >> >+              char buf[7];
>> >> >> >               ssize_t sz;
>> >> >> >
>> >> >> >-              if (buf == NULL) {
>> >> >> >-                      err = -errno;
>> >> >> >-                      goto error;
>> >> >> >-              }
>> >> >> >-              sz = read_str_safe(file->fd, buf, magic_size_max + 1);
>> >> >> >+              assert_cc(sizeof(magic_zstd) < sizeof(buf));
>> >> >> >+              assert_cc(sizeof(magic_xz) < sizeof(buf));
>> >> >> >+              assert_cc(sizeof(magic_zlib) < sizeof(buf));
>> >> >>
>> >> >> ../libkmod/libkmod-file.c: In function 'kmod_file_open':
>> >> >> ../shared/macro.h:25:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>> >> >
>> >> >Is there a particular use-case for explicitly forcing C90?
>> >>
>> >> not forcing C90, but forcing -Wdeclaration-after-statement as per
>> >> flag passed in configure.ac. I think the message given by gcc is
>> >> misleading here.
>> >>
>> >
>> >Indeed thanks. Seems like I should add `export CFLAGS+=-Werror" to my dev box.
>>
>> so, are you ok that I just squash this?
>>
>
>Yes, of course.

thanks, pushed everything except the last patch.

Lucas De Marchi

>
>-Emil
