Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D921184122
	for <linux-modules@vger.kernel.org>; Tue, 30 Apr 2024 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502624; cv=fail; b=fKxyTfnwkFw6QH1rYE6DahfeMBEFUVEFbNR9A52P7jh0jYDTPjv726bcZmD++qiULFAJ8UAIlxzNKiid6alSXAorvUuE4EB8uiMG1IGnAGZNLDec+WrrdaAp7gB3QHu+rknsoRB+Ka4x8Ge1hbvpJh/LpUupeo9DUEUvuIa4TSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502624; c=relaxed/simple;
	bh=n5m3EN0Fy7hvNC65o4pE1vJo03TVn/FwAPozbOpzFnM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NqHCi7+9NQAvPuyp6YRUvKU6g4Na1hm5BJr3QuZQA1Bi1whZCE6hV6sLXQLKJHLfXqXCLRzaNp40oENeFdbjYjpT3tUzAj/2W+hgse6UsLZAQloV7KRLNVfrPAEHKBnjyO31mWRhchN4APPnXh8Ck+X/c5xYq45kMh5IfG8emis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tgi01zhq; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tgi01zhq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714502623; x=1746038623;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n5m3EN0Fy7hvNC65o4pE1vJo03TVn/FwAPozbOpzFnM=;
  b=Tgi01zhqJM8P3WSPauD39yvKHC407+H/kECvhslspbRrjrOZXjpRjkg+
   xG0JPTm6BAG7QF/0Z5s6ofO5Pi5UDDQOEBHzJtNGap8HkJaxNVvz94KXo
   q7Tzg6Qo9AxCvwmOXBdJWZVlJLpbn9FYJKyqBRBz8MczdnNRwU+HaQ0mK
   h8n5fEolrphbofba5ENgZoY+troSXdZcJlxBdainBas/Zkc6zYm1W56Ph
   PicIprR5Cjh9TmZsvnT4UflhF1CkTbAjHO95y9A668g7RxTMuNaJMHsF2
   Uj6jHBugPN/Ux6tk/4DvfdA+KW2axOnEdQmI7ll0sedA59CBALQl1cjTc
   A==;
X-CSE-ConnectionGUID: NocCioUhSSaCIPgPzgDSDQ==
X-CSE-MsgGUID: 348Pjt+5S5yZMKiAV3GrWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="35614569"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="35614569"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 11:43:39 -0700
X-CSE-ConnectionGUID: umSERxUFTtmgbwZcz/SZVw==
X-CSE-MsgGUID: XflDVuk0TgK1welY+D9EzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31001000"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 11:43:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 11:43:34 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 11:43:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 11:43:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 11:43:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQda+zB7WT9wXAk3/EtbwWCQIadt+BCF1AaDStozGGVPcl7ar9r1327+k85B6dm/Bywqhr6e5P/jm1GPgT6X3NNKelO/rl7lFv4Rq17zRtlz/xZPQHFA9q19m7GqoD2CXP7v2sXABSmFugqAJd8fRLNb4TZGn5Tt0EfdE9UOFeeb95BN3YdQC6Ja/aAmqLoNaST5jd5+LvvXu9SCvcUNwdaxphTwNMCDhWvCUSEwDK1xceUGma+ixsQJIBpOKZ1p2wfRUvtuDJjj6bFurBMFgCknJA4UndudE02GGOLmqByJKHLXBVRC7AXXVUvDy//ps8kLEjUWmMZzaVo5M2MYaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6o0f6YR2NOxqOyMSbaFUusr2Z7CNbk1/bi7GucFlPE0=;
 b=XhWZRF1HloBc/loYofealZI8ktP8ieA7WKYrDB0ncUPd+3+sVnCVeC0sMflBP4iwbNUyKlWeJoaTb8VxhurHDYFd0p6IwCCcUPqZ/5CDlxCwQufO40hzJQqbz81M/dcGTAp4AqtgrLzIMZV/L2XDT47Tpvq6wccEr+ia/LaTAxauRHo1qdLSLBm+q8y8D9AJViqdQNdaR4B/BBlwFDjxLZFk1Uvs58Tv62STSjwJAMQdXQTI92Lor9K37ySRymd8OzTnPRBIuq7nSSbzCpeEzdqgiZG22+tz5qIcvBg0cXgEY39LDB6oq14UJSxn6LJ8RwnQOGp7TO59v8A8/hN3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA0PR11MB4575.namprd11.prod.outlook.com (2603:10b6:806:9b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 18:43:31 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 18:43:31 +0000
Date: Tue, 30 Apr 2024 13:43:27 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Emil Velikov <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 09/13] libkmod: swap alloca usage for a few assert_cc
Message-ID: <fy4a43i62oo42sukpmodrejhglibxbkzom3sgdow4rxsg6j3cj@6l3h466hxsjs>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-9-06f92ad07985@gmail.com>
 <37jvg2krroliuncyposassjhznjcgrxmvdre4mesl23npukbpn@jz7ntjkcpd7o>
 <CACvgo52PTWuDcv-P0Ls1oESo-cOsygUpD-rbK9oUTHy30HpS6w@mail.gmail.com>
 <evfd7gytzrrtmvj5tjuxpwy5k463xeoe5rc2y5nrisgv7soqpg@veupfudya45x>
 <CACvgo50mEAQkDSJxqF2=QKNGbnBZ7QbdKZDgy9adDy68rLbP5g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <CACvgo50mEAQkDSJxqF2=QKNGbnBZ7QbdKZDgy9adDy68rLbP5g@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0270.namprd04.prod.outlook.com
 (2603:10b6:303:88::35) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA0PR11MB4575:EE_
X-MS-Office365-Filtering-Correlation-Id: c29e59af-0299-4274-6f45-08dc69456ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DTKmtmPFFIH/LuomFBXKfpLQuoNfJiXkIDbcum9puPu5y2ut3HSzcXT/yNuV?=
 =?us-ascii?Q?d0SWprKxXIWITiZtlfROZ5KV0G/XB8ko0mvvS0WGjiDIY4ucqYMuqFhgQ63D?=
 =?us-ascii?Q?eCKYBW+MPopew3ggPELSjv4ysHOXmKzWgmo+EmHLiMoUJtEPyMkBsRDWGXtr?=
 =?us-ascii?Q?Ilo/6EA+HbvqT4vVlmx5sk/u2bQbNZBAg9uK+rUfPqlupa2wLt3bznciJp+L?=
 =?us-ascii?Q?k6T0wJc0jdblLu6rg9BHmB76AHFAVxnsQUvt+fb5lzN8p935r75+r44YvTy7?=
 =?us-ascii?Q?wIV8zxUFMw1YBv3W64853H3YgPmb1zyTwLxYVZd/0siMnLwAN9fJLEzDCSfD?=
 =?us-ascii?Q?DFWy8MutYKgIZz8KyethcYDe/abY1M7vcmSi7QCkoeCT55q4AQ8xigakNTnW?=
 =?us-ascii?Q?ku9zYRqNKhCHVnjJu/5tSIThRO4MbCmyfKQfNYkQELjnAOvW9Vk01JW7cjzd?=
 =?us-ascii?Q?58GRfw/z2k0s5cVPeEg3pPybTgFVrzuwt910wSHGRr4yVqn4VzYCw2L5F+oU?=
 =?us-ascii?Q?gSrCPVmxuQwdci2LDDmKf6fJcQ+6Xm7TGH7m+FnZo6Dd+4ZqGDxOtMEt179C?=
 =?us-ascii?Q?z5rJa0IpXTmskHwKypZJohidDJYmYgYLVTX+tL5nl5z3n4gZduIbwvJArGvD?=
 =?us-ascii?Q?J2DIRrx2DeAWe7jfJD1oeMGK/VMQOds//fadzTooo8OxF0qsHtttD40d6tDc?=
 =?us-ascii?Q?hyfiQN97QAKAFLGFlls/4cw3a29Eds9d3LXw+CYfe4ZvvonKbyiX9Uh5X1XZ?=
 =?us-ascii?Q?6OujUg34E5TXqH7mqqSzJ+rIiDVtXvs36PwocbRCcCU7LfWWi6ZA+uMD0f1+?=
 =?us-ascii?Q?WssCZ7ByP43fbwnn2alh1x5yUnYjXsX6LvTA0u6BzCAjiRv0zZB1ldZwBWn/?=
 =?us-ascii?Q?rIXRygyt4HOOBcKm4T0tPmJ65iOdFmRwwO4xeEK7tO32+qpJzYBS4pK+dip6?=
 =?us-ascii?Q?pfHpmtVmTDNgM8XrTAAc7Lt6sqp1bCFKOuirG5ci/ltQaYvEXRK6XqF3RJs6?=
 =?us-ascii?Q?0vknccuh3zR5UNs4bEhU9TtsKnGGStJns75lMr0wO1oQs8NL8xU2w06Lhp2r?=
 =?us-ascii?Q?6flqIKSVENu3Ot/auaB4f8pHhoELQ/PtuCyPoK8JfL1WdFxi7ViGhDh/VpGQ?=
 =?us-ascii?Q?UcQLs17XzI0gRiPuM/HrXyp2Vf2I0yKURN9Bg0kyAmwONdD8QKW8xpEgt7W5?=
 =?us-ascii?Q?ATHxDoYc/Ha+9y/2aYiY/4DZ1dVxFOy9NN4jsAuQMOpOdDF6JFqK1dV5chFL?=
 =?us-ascii?Q?fEPwwdT3lmfjwDEprvold69VPKw9ZDdTDwVEAfqZaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xsu+iB7F+Q82Sl9s2hDSm9BOCJyhrmNGIXYKUITl/YyS6oERtlW7jnZQOWb5?=
 =?us-ascii?Q?TR5plMRsmwcDtY+trI1sUVfd1kba+vVZPtEQQ6LNQnOG4rBBc4DBbW0U5sdt?=
 =?us-ascii?Q?sp2RIWRutObRllrDYIa+X/4f/vXsclD784Q8Y1YGVpCtvvnylYxllb2hM630?=
 =?us-ascii?Q?xakSAaj/Gd7C1wW3ighTtMwUg8AdSe+CevscpARibBzjAA6fpkQ+HXyCBm5i?=
 =?us-ascii?Q?WXuE58NvSSQCni0Pu+i2Th8ghF8+MWMAhiSIRTiIe3Dc1jlNFEBOPJiSTXFM?=
 =?us-ascii?Q?WeY8New8SMKvJDRlGXmLbo//PHqIiiAXrlZsU0Qk9bQVFlDd8BnrLWRD9G03?=
 =?us-ascii?Q?yhYBhwcZE+/rMX7pLRZx1jfQ5uZJspSntr6mV9uAMaFBmlAt0r6XgEVTN5h6?=
 =?us-ascii?Q?kkFqdAcZZmuTRqoXLQyA4nh4zFqALY35j134ww6C+WlTX/ollr82s+6bYwXN?=
 =?us-ascii?Q?E1CleF4QVFjVRjWZxmjX5D51WNfcleFX8hFNiBjF7TpBEX05LG9Tmod93lEa?=
 =?us-ascii?Q?AJvJVVLNINRIUgtow2uH24NiY/P5g+ECRg46K2Tn9Mom/QBR02xbvaCm0OZJ?=
 =?us-ascii?Q?YyH3mB5tjxo5Ca3XZN9IRNqHgyJiQKjailnmNZC9osMtRJ4uA5R3LBsMcHdM?=
 =?us-ascii?Q?YJtC9vk+j8PGTxsmq0XW0468Teekyv0xaHspnTZFwSZwSpf5gsBGRWsWA2e/?=
 =?us-ascii?Q?URl610ITYEjKygILqPY6QfaWUxjf05QhNVeFvFFJxCgGGXOIXRV48GASJMqa?=
 =?us-ascii?Q?p/WvSMpEhepmYkZOkJ7Oob1St2FSDTL/4SquKyXVoMghVkJNDvrLrHZ7Fstw?=
 =?us-ascii?Q?JTp0TBDjswPvMtrPom79Tk98zg02BSOdy5OtmvHbe2+PUq3GrETGrejYkyIv?=
 =?us-ascii?Q?brXAMOxFDSDegx99TPMY7JnB7BnvC4VAd4iLAgx6ow1s8DXbMsfPYezDdc6o?=
 =?us-ascii?Q?iW4qal/Mrh+04R/QBlmyMDAjlpd9oAxrTciFcLtzvhnmFxRxIgWErYoF3vDv?=
 =?us-ascii?Q?dbIRxN3xgnRyG+8p5Hm+kYhsV8n4pFcYGL2cUAaxWvO5jXJRPA8stxIVQBAv?=
 =?us-ascii?Q?eZ3GjxCgRdzBLIT0bg1t0ZlgiLF9mx/4nC4hSl/+gUVb7stxrf2ciGEWPDbB?=
 =?us-ascii?Q?5KqiTn1EkQVw5sgCGG2xtbNaXSYIPacbNyXXgtrI1wOj5Zxq+4c+d/ATdK5f?=
 =?us-ascii?Q?9dUVLkTgjP4O1+EyM2oPdUxWfOyPCobzVusS676IuqdCKJptWLIsiNA989QQ?=
 =?us-ascii?Q?cM12aqTPNqcZRvimvx7X1X5rxNXFDW223KC5j6ol95MBh5xJCFwpkZyxOfMQ?=
 =?us-ascii?Q?cYBOcW8Z3D4YPLA6X5iPvly+vH0/dqpxSQM4MHoVv+5BegQhappHxVIdhlB4?=
 =?us-ascii?Q?2W4UmwqP0mn7Nb5SzlCD/6imlX34n9+mdTvfSCatQsyO/zfoZu76vopFQHiE?=
 =?us-ascii?Q?pqUqOBw1mt229/IrZuuihDvwh/TqMwjhIm7Aj8VwCH4t8PmKo4csMBvRt/Yt?=
 =?us-ascii?Q?jdgtzrEYDpy6OKs6e78px5axwhEXUI4TMfqpMsxZJi402lAKbsk2Ste74TYE?=
 =?us-ascii?Q?76dNJgGJ3GbhXGVNkFkEA8DpeqwEFdiFFwtNsmuuec/HI66MZNzTjIloVUU3?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c29e59af-0299-4274-6f45-08dc69456ed9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 18:43:31.5241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/8cemkO1iKiRyLUT2CfApBNKMmjg0VuPoIKhTb3BQiI/9PvDgp1SOkWj8IfeFsrZ5P6U7gscYCRB9ab5S9GiNlw1q3HN68pz/tTv8Lot0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4575
X-OriginatorOrg: intel.com

On Tue, Apr 30, 2024 at 07:27:00PM GMT, Emil Velikov wrote:
>On Tue, 30 Apr 2024 at 19:18, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>>
>> On Tue, Apr 30, 2024 at 06:54:00PM GMT, Emil Velikov wrote:
>> >On Tue, 30 Apr 2024 at 18:39, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>> >>
>> >> On Mon, Feb 12, 2024 at 05:23:10PM GMT, Emil Velikov via B4 Relay wrote:
>> >> >From: Emil Velikov <emil.l.velikov@gmail.com>
>> >> >
>> >> >Since all the compression magic is always available now, we don't need
>> >> >to loop at runtime nor use alloca - latter of which comes with a handful
>> >> >of caveats.
>> >> >
>> >> >Simply throw in a few assert_cc(), which will trigger at build-time.
>> >> >
>> >> >Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>> >> >---
>> >> > libkmod/libkmod-file.c | 22 ++++++++--------------
>> >> > 1 file changed, 8 insertions(+), 14 deletions(-)
>> >> >
>> >> >diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
>> >> >index b69f1ef..5b88d6c 100644
>> >> >--- a/libkmod/libkmod-file.c
>> >> >+++ b/libkmod/libkmod-file.c
>> >> >@@ -410,7 +410,6 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
>> >> > {
>> >> >       struct kmod_file *file = calloc(1, sizeof(struct kmod_file));
>> >> >       const struct comp_type *itr;
>> >> >-      size_t magic_size_max = 0;
>> >> >       int err = 0;
>> >> >
>> >> >       if (file == NULL)
>> >> >@@ -422,22 +421,17 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
>> >> >               goto error;
>> >> >       }
>> >> >
>> >> >-      for (itr = comp_types; itr->load != NULL; itr++) {
>> >> >-              if (magic_size_max < itr->magic_size)
>> >> >-                      magic_size_max = itr->magic_size;
>> >> >-      }
>> >> >-
>> >> >-      if (magic_size_max > 0) {
>> >> >-              char *buf = alloca(magic_size_max + 1);
>> >> >+      {
>> >> >+              char buf[7];
>> >> >               ssize_t sz;
>> >> >
>> >> >-              if (buf == NULL) {
>> >> >-                      err = -errno;
>> >> >-                      goto error;
>> >> >-              }
>> >> >-              sz = read_str_safe(file->fd, buf, magic_size_max + 1);
>> >> >+              assert_cc(sizeof(magic_zstd) < sizeof(buf));
>> >> >+              assert_cc(sizeof(magic_xz) < sizeof(buf));
>> >> >+              assert_cc(sizeof(magic_zlib) < sizeof(buf));
>> >>
>> >> ../libkmod/libkmod-file.c: In function 'kmod_file_open':
>> >> ../shared/macro.h:25:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>> >
>> >Is there a particular use-case for explicitly forcing C90?
>>
>> not forcing C90, but forcing -Wdeclaration-after-statement as per
>> flag passed in configure.ac. I think the message given by gcc is
>> misleading here.
>>
>
>Indeed thanks. Seems like I should add `export CFLAGS+=-Werror" to my dev box.

so, are you ok that I just squash this?

Lucas De Marchi

>
>-Emil
