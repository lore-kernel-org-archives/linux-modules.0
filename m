Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0ED1CD19
	for <linux-modules@vger.kernel.org>; Wed,  7 Feb 2024 05:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707282497; cv=fail; b=jeEbMvPqsyV8CAF4A6dgDfErdjxM36HgnPBp+AIQbcrMe6fZDrck+CEuilydNDXN6CyZrgKOjPJYQszOKqK7VcJHgcrUJ9pfKU4TgXuphRCiRucLlJdBz3PKv/C3IEA9UtNKpim0vp5niSpvoJDdtdhhwcp2IjbCgC5Jgg1YSrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707282497; c=relaxed/simple;
	bh=RZDjj/Gy7j61zEPvg69c1NshhJZb/LSXLIFKgMRsjZ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i2dXXb9DNJzlzbQARzHT9E7QMzGw5cuWSH1j62t6+CECdUj3nRGF+pcmqIoQTeUiR6AXpFc9BWQwdcJKZLrJCNHJqxyAEcXBmSKz4biUf9IPa/qAFqS8VuyTwuK6WalUqgwgU0eElHbSCpEzPG38Hl4acKl7IU4lJb1QSZaOghI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QShhHxd6; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QShhHxd6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707282496; x=1738818496;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RZDjj/Gy7j61zEPvg69c1NshhJZb/LSXLIFKgMRsjZ8=;
  b=QShhHxd6AW20UaZ9VewK7VX4bsRZbQxxj7pP6EikWWJfVHrloer1U+NM
   hg4V9ZfJyBjAUwgkSjGkj9kPDX7W9dA8B4+/IqcqQLMxlcMcgFSN11/Y/
   zkQv7tbGTNzUUiVLAD6zxDLZF5x9RWBeQFBvTaje2JK3oW6KbO1N4pfNp
   kN7ueHC5EHtzirhWZ/OlrVyDgJOEPq5A7oa5asjxhlppAl5WVX1/GtLJL
   J6KF68+QE5ETli+2d58pcEbLV0UlIgKnkAFS59phuTYf70B8q77TD2430
   N39nNVaLO1weDc2aJIGHBujJMPHaUWk96dWAUCQoZz50vEf6pZp/sVzt2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="3879876"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="3879876"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 21:08:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="5853189"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 21:08:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 21:08:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 21:08:13 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 21:08:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhbKR2ZisVa0WEA15cvgISV6aG5fbfE1zy5ZjWBjjlMlEJXwAh2S3Ec0zi7FdASfGFFvl5UDVk4Hti0mdI7n0ojuLN4wAneXgqsTcuMaqUofqfm4hfad039QGjtCB9J13qim01pqQKCxoNr4gyBF0Gv8ffLjUskpx1GCKZvBzzMTkVayk1AQVnWdmiMCbtY3koUR1gB44hWT6Exfd3SkOjUdRl83Ug1NI8VGiYVs6E2OpENLEPp0NsfmzIHPFMynw95wzmSR9qmgod51m4B3eDfR/KKr6ip92nyRiZR1Uk22HXW8bokM9EUGUet6XkVluJJK8Bt4YKHFmcJzlxLbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXMoYRKBXk7RSVVR/Qp+UXpOfWMPn+zMDM/fmW8nQjI=;
 b=FHMVfM2aPooOJk4vTCDf6GwoSeYhdOz+ZmapMsO6zl38Fz3JSe0QW25L6v/FuyoIRC/9OJRYjz+FQfqsCyFW+3fc0CnClHoTiOCpijlv2d03SrSHaZZVW3TQKEF+4N4+hrNGUC/lxq2PX7oXTXmL3H81PoSKVmUfEHLq9xDUPHEVckw02hRINptHQc4uxOsBqVewAlYZyweNVBfRMt0X0+kn9MfVogc45/cluYSyhftL6dtsM2ptwVrNP9hOat4KKuHubZuVrz8MlKx8Ei2uWpUf9fxPm6RTMKDMVrVoLDJ4YqufwPrgg81paMmvB+ibXnjxsUoRYFdH2iafmfvvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DS0PR11MB7927.namprd11.prod.outlook.com (2603:10b6:8:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 05:08:06 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954%7]) with mapi id 15.20.7249.037; Wed, 7 Feb 2024
 05:08:06 +0000
Date: Tue, 6 Feb 2024 23:08:04 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	<linux-modules@vger.kernel.org>
Subject: Re: Re: [PATCH 2/4] ci: drop travis config
Message-ID: <zkmfb7rioqib6slx2hlgpt32znipwu6h5vmq2t3ybphkbfl4r4@67yamewrrxml>
References: <20240202190823.418148-1-lucas.de.marchi@gmail.com>
 <20240202190823.418148-3-lucas.de.marchi@gmail.com>
 <ZcJzOy26gvs4vs_r@bombadil.infradead.org>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZcJzOy26gvs4vs_r@bombadil.infradead.org>
X-ClientProxiedBy: BY3PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:217::29) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DS0PR11MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2f0bd8-fdf0-4155-ac2e-08dc279ac526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLTP1n8WO0YsKQPCxhSgt7vFLZYTsMTClKeekQwMFZzT1FiS1JX9Hr5hoWibC/zPZ1x6okpmulbcWawS1hXA+hsSdx3wCHsETzmef+ucChGeuFpmr6PW0W+LM2ZhTx3fY8BIJDFPZXmW1W1arzNhnN4pJvqWW4US9MW3XIyYBHAZiBaNHRNme1Qx/3yJCz1SdmuuIy8jbo8hP2wqt8aiR6Qd0JodmeWeKl11aU7YKQFFO5eywmUqWWrpt9mRTLHYEcaCzFf7t/J4ok1e/xNFKEZL1qry9f+Ne6ATq/fyH+Eziy0cF12Z2X2SbxGNMpMLkmqrksgJwHFCUazxk6S5iWEYhWBkP3ONXOmPTNaxV2vEZ1k5NZodlxHKHAN9Wm3ZdtRrhJnQ0k39lQk1B1lfjlfb9h3vNUdhmhPdGoDSAxHnOGqNVGRx9RaMDbbx2Hsmn558noNgWBapPScM0t1K9sW31j+1FQr7qiRdL8CxlyLIwdwF7R1ExexX//D0oRxW/ioHYYJ6L2fqMTLwUWlGa7k51mzlVdIxxZFkXWwvcEpctMZ4Jd7HGIUAmWTwKG73
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(366004)(346002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(38100700002)(82960400001)(33716001)(41300700001)(26005)(66946007)(66476007)(6916009)(66556008)(316002)(4744005)(86362001)(8676002)(8936002)(4326008)(6506007)(9686003)(5660300002)(6512007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AJZMmXcD/QAf881NNpIjGjmgrHYXtPHjSVqcZRcrpA0iXTHmjidZUuwbKRSO?=
 =?us-ascii?Q?grRy/4qha6qIafW6A74LAqhIV6dKbI6AhKJyP9nDf0r418ZkL0lbx4G+9Q0e?=
 =?us-ascii?Q?t82o91c2ifAR8C4Sk0ztoZZJpP7o3eTtcYPhY7cbKIUK5cSvpqaQ0yABMX9J?=
 =?us-ascii?Q?XozyTBDfyqhBpggTcl9453q8MJPLffV0I4KzKK552ZmI64JV94AOWjmoqFAf?=
 =?us-ascii?Q?3dLy8f7piCL2D7jyG76zheM1QmDrLUpgi7nXfzDY98fmukYFl2OQecQM5b2n?=
 =?us-ascii?Q?K+b56mADzK49OiJPDDrB0NejVvDMzFfL+T9giA3Yi6dKH451bwqfNZr3DG3s?=
 =?us-ascii?Q?sGZUmaEY0sCkDbS3VVRjkRA9gbqwDAPtjiCZhqQFY5ahDaOZT+50MZ0JznVn?=
 =?us-ascii?Q?GSNFriGR9Hs53S2RWqIrRwMWgfiDsfO4D0XPFcYeKu6D1yo3r7FMxnUCwKhH?=
 =?us-ascii?Q?5qysI4ozP/BKpuZ0cYTIp1CjXqPmGh0MxoG6noD4842PFOrW3ezNIgHNc0mP?=
 =?us-ascii?Q?OTcCH0qu9+GnsvmBPcaaMlQrgk5nnpKw8KAtSviT4+d3YhcKAmbDZdOLfwG8?=
 =?us-ascii?Q?ERjBqnZOAuRX90QlXl/Qg8Lv6CNWJKxGTZbb/Z7BbeG0DZup8lRwftHw8dt6?=
 =?us-ascii?Q?QhYBLjHmuV6olpWr0RkyjUMtReeVJQf6APLMmavpSyfv7u3Z7Z71q8Ur3KKy?=
 =?us-ascii?Q?5O7npKNmay7tyislUhXPTmWCVTy3ZkRdCi/pHWhbaDebHqIEHNVegJOWYoxn?=
 =?us-ascii?Q?BGd2R2YHwiy24Nh7KMxRrAz0Vlt4C1jWZ3c7i1CQ14TnfbOgUpmkCJsuHJon?=
 =?us-ascii?Q?Fdy5UDn0pr8E7G6InN2Y27ElbC1g3sP2T+wp+fLvmcJUX29smoNhUAe++w7b?=
 =?us-ascii?Q?X3aiVUmWzzijhUkBnfI10fSO/kOkbxAIRR3ZPA2BQ3Ca9VO71vZK7bm6I9GQ?=
 =?us-ascii?Q?PQoaka3U3viBm0UnnP0T0nP5v62tjQrS9/FEB9rt29Lsy7Im4Q4m4BFhi/EP?=
 =?us-ascii?Q?5QbTdKUJ0A7ntrYjEo7WxcbdSCiirkQcE1cNku6lz/F+8eeNPbrHXfwAMOjX?=
 =?us-ascii?Q?4ZcciZShRGMlQoIPndDGl9lNnRrGriwJB7oA1Ilv/DC1L6iw/4kj+4gqZ529?=
 =?us-ascii?Q?r9zk1fYX2C0+2IwQykpDT0FxLyT0U+DvmDjNMDPFjl9ftz2CDarxkVRpMwiP?=
 =?us-ascii?Q?hLHUMza9gJ63XeotgQVeiistUjE1Mr5zXOx5DCHctndf65keuIP2NM4os4Sm?=
 =?us-ascii?Q?r/2AEXEmJBio2Cw6dVWy3jwgibeelecCd5EvsPO8WvCTGxsiSEmoTGZ5be1P?=
 =?us-ascii?Q?tveKIxOJgwkfVAvyVMN0OTucMECTNwzNiCltX0HBNLgyf2iX0qzBG8cod/1t?=
 =?us-ascii?Q?bwVFBb0C5gJPzstwEdFcnsSAWuTJpKlmg1SnPp/hA2FmXWFMuUygYBj4V18J?=
 =?us-ascii?Q?QFx/07QBmmBWVOE2u1Q2NVLIEOBsRw6fnEGn6QFPQxXDNN1BCOE90gl/psyi?=
 =?us-ascii?Q?z6XhS0bNAqVTkfcFLSU+oGEGt0Qfx0tlxGgYKAle8cNX27+ezfpeIy/LuLQM?=
 =?us-ascii?Q?uhu4O7+4eUKiZxAxu1eCgFeH/4hKbaKPqOezCN378xaIV6qadtEO8STNXu9A?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2f0bd8-fdf0-4155-ac2e-08dc279ac526
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 05:08:06.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omHJRpSkbtmYv882IbT8aL7ddCx9W2/brQK8644kq8Cq0UUaatD4fBCOKgSz2Pzc2Ax+7olXgGdp2owkaQ6HL7OKyJtQhtchwFdyfH12/qY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7927
X-OriginatorOrg: intel.com

On Tue, Feb 06, 2024 at 09:58:19AM -0800, Luis Chamberlain wrote:
>On Fri, Feb 02, 2024 at 01:08:21PM -0600, Lucas De Marchi wrote:
>> We are not using travis anymore for CI. Drop its configuration.
>>
>> Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
>
>What is being used to CI testing for userspace?

currently it's basically the testsuite being executed manually.
I had it using github-actions some time ago and may add it back.

Lucas De Marchi

>
>  Luis
