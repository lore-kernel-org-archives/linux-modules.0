Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0770815956B
	for <linux-modules@vger.kernel.org>; Mon, 29 Jan 2024 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566188; cv=fail; b=r6lUHMsFARidn3nTihxD/dH3jcG/jFotQaLtDpdzqadLCP/H2qXJNM0e3sb4/ePSnMjVx/TK+A5OGS4dfuAUfDxfo2yVRUbOObXkNhsmqpFs/3out3RcbGbDelZ4tbC6g1XDmGgfKKoqvEvJbNBvvwEouNrDUZPa87/ZV+Bhks0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566188; c=relaxed/simple;
	bh=ORPKCG3zb5kV8E+oXnoxGjW46Kc14zR3DsIHjCWJriU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XyJYZ0ntN0ieXqWNE3aoClggLg5/5Aq42CcBwTSYE8h5HJj0Gm9NjtfK3TUpkJ/YMWUN2U8B4F8bRqiDb07xbUBfTMOJc+llFGxYeET/u65eqPJ03lIsbVZyYiPoJMYPxqV1OrPqF5yECDz9ywsb/lw/EiIA6kHoiw1y5ELzooc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNCB+Zhm; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNCB+Zhm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706566186; x=1738102186;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ORPKCG3zb5kV8E+oXnoxGjW46Kc14zR3DsIHjCWJriU=;
  b=KNCB+ZhmG8CAkDflZ7oWRqgEB5QE0sbRFoZGVcBeWACeJEPva0IHiA6Y
   sH4wthUgv7MFXnSVzLaaiAhJPKrw1KzNht4HTaUPuA0JbAYfcHJ09rngI
   e5mRNMGf9ykxQKZoeDZEYXBi2PEv9g2+G4Gqisu33X0jZVYAOIP8+mHLw
   pmL+BM7r0kAKxGuMDs2fufvV8G/XCd7ri91D2ACTi1NLSSupSwcgVPpKU
   6dpxwxUdrZCiEbzaDqm8EP6AlPaLo6fWwha6+nKs/Y/R8cneb++LcGk0S
   ScbNezDxc7NFc1pmBN32zx+ti7+bXoNgp2uQJcG8tNmtMyOW6GGlgvP4f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16633306"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="16633306"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 14:09:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="961028786"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="961028786"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 14:09:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 14:09:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 14:09:44 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 14:09:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6iOBcXy0Vr0Ca1Sv3+aF0S5bJ7GfXhCNt8lth1kH20X+hjgTQz2VIO9kmP21Kjmu53pnabzHGIgVqND5EUkP6CvcegPG8uGIBWQtTd/csk3YMWjYzCJUWOt1m0Beglb2LfHeF5EkbXfbNPnbP7Wka3FOh5svVocKrUNrLPhWPU2DWatZZaYFCY+c6rzulBDROseTliHI/bP/7/AazIaCcPD+YN66PlWoArYgHa0cQELk0Tg0GzTlJSBPMogKL41G8xRl71S+uOmOIF9kJ+RP4zsb8WGGwDHLDoxZirUrwzRFmRUL4ob4VO1MqmqFyVGQTI/HZyKWmz4g7cvWXHSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZscAc+NOzaiH8nIo/ki4lDWJzfhqZvlZ75SK5I70Ek=;
 b=SiNSftU9wnMRHnE7RFN5G25eRaDeJYL8PJWNTIhZlCcgHNMq4OqpoNyiOhHegK7ss3yV0rXIvSCOCvKU+dYw5Al5WS5uEWig+mTyR3DX42B2+7b+U/apkX+CcQ8XFAK6Q6SS5qweX6clWXgSp3LvT5tBIAuTm1rFYhdLQhS1EccaPewecWXmEWWeFlGg7ef14qXQfg/vsHtIsBy+fwjuXmoAAYz9fvDoqjkJkbtyf/GwJqh7vKv9hc8OVrvmcab9S5tm/ydy2yOMVp4bEfGM8Y1P+a+fs5BzbcLD9mbbxgT4IzMw2FTFdHzXuwidBgTAiOJ6J3X4Kkb9EmnUMDp7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB5996.namprd11.prod.outlook.com (2603:10b6:8:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 22:09:41 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 22:09:41 +0000
Date: Mon, 29 Jan 2024 16:09:38 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Emil Velikov <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>, Emil Velikov
	<emil.velikov@collabora.com>, Marco d'Itri <md@linux.it>, "Eugene
 Syromiatnikov" <esyr@redhat.com>, Josh Boyer <jwboyer@fedoraproject.org>,
	Yauheni Kaliuta <ykaliuta@fedoraproject.org>
Subject: Re: Re: [PATCH 2/2] make: install/uninstall tools symlinks to kmod
Message-ID: <wqvtxyw6h6mcdnqv3cv4kzorlck3qzcb4p3duq6m3w7lm6isxl@kupxidkj3x3w>
References: <20240126-master-v1-0-6257d039a30a@gmail.com>
 <20240126-master-v1-2-6257d039a30a@gmail.com>
 <tdvymg3uuvkns4uqvivvvkj7sf6pqr45rpbyqmngaf3jmvqije@fsuvyu3kai54>
 <CACvgo52Eb1MV328RPUPLDq8cPO+7NvHn70q3SQdiTr_apnE5dQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <CACvgo52Eb1MV328RPUPLDq8cPO+7NvHn70q3SQdiTr_apnE5dQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:332::6) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM4PR11MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 704259a0-48e3-4fb6-0822-08dc2116fd9b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6g4a4jAeiKwyfIZbKxvkXWPNk8PXKNI17EF8CWhTVSFf6AWZpIgQvMd1ct/l+PWkR3RrGE2AlAw/wlFopL+RSOhJlWxxFq3qMKIG76z4U3T66xZdyIeFpy7tw4PTxwz+AX46DiwgTbqTqWZnrU1EdrX5/RLo0b7P733/szt5dnGGaeP8wyxSBF3PH7n5FBJCs4Ih3fGKKBelRluUltp5P4K32uGmR1KAdhs4g+4vNK0iUDAwACgYVVmjYb0L+byxG+iG94Ytn+yW0eY/ngLdSqOy/pwmE0t0vXox4KUcjr35ieVBiM68bxvo53X++bo1vamnWR1FxqS+0HL5s6zDEPKQRMb4orYvVVuGJLJsfXvgxM/vccvxmgS7Ub+bgZXCO7d8jzZ8RouhCbgpjdBrvxV7hlvexnmwg4wzBO7GZq9xt1RMnqp3imF4kTWreYq+GFt5xu8bGBg8hjLjEpZlAZJq4YlsFhL4jDoX0dvtbGNQydtLeC3+SzGgm3xYDp+QMXYVLmUJv370mPxdqMNE+gbmMDy3EXZohZ+NCAL03s+jpQmAF4tK4g/9WGaLVc6b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(39860400002)(346002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(33716001)(86362001)(38100700002)(66556008)(6486002)(2906002)(5660300002)(82960400001)(66476007)(6666004)(9686003)(8936002)(8676002)(6512007)(478600001)(6506007)(54906003)(316002)(26005)(66946007)(41300700001)(6916009)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tPicmjpGKukAVsykHfVof7LtiUUz6VWROuYiCnfxOFhESuxmamXWwRnES6EI?=
 =?us-ascii?Q?bMmcJr0igZJPRhr+AH4fHyySXstvddkF8MIIXCJKU/ewcq7vPetyJuyjybeY?=
 =?us-ascii?Q?eJLxkPVXSJDsJX8FXzqnpZhAgFmhsxrtDBMcXl7puMwqVbIwJ+Bmp2PcZdVr?=
 =?us-ascii?Q?HP8dPdsfTkhJQ9gDVAI8YumovV1uAh7ctAhkqkUo/cLSWeY8/O4UpKC4NFns?=
 =?us-ascii?Q?CjFwqfABJ4k+lfD75mS/mvNmwqQB54rHgN0XUHw7vb3ICzIkQ3fMYkrYWeod?=
 =?us-ascii?Q?STxjvNAtHc91a6cX1RoNOxq7LVqFoSRL2GwhAQ5aZk1tZxEZRU08gL2fGtqM?=
 =?us-ascii?Q?uDCp5cxLeQQPJ5JZpC+/2E4xcW0olF1AieJdg/JV1NFwbbpkO6+6jPzQGGyJ?=
 =?us-ascii?Q?KwMN7Qm3bxy45PRECggdVsNvmXPpsM3Uk9guXqz5MxqCwn7b/4r5m2CfSQj7?=
 =?us-ascii?Q?RDIhNWsqwShXOxRxTaegoDDaafpsRpDvtlFoAuoqVhk8hxkRcJzZIIz01Otm?=
 =?us-ascii?Q?6KGRvY0ScotZKKoxCXh7QVy5eNf0veWrcFgFDccZGDI0084lxtGPMOUPdSS9?=
 =?us-ascii?Q?dkz44RT9X1Mb8mdYwaaaiKD2Q1EGvoqRMvJvBOH49ifreWStmWv1ekliZoHX?=
 =?us-ascii?Q?xtCWDc2EfMxlYd9f5aJDNMoiqHFR00F30TzxFWflcqrXol97dytlhlEntovC?=
 =?us-ascii?Q?Bd2PWfjynoA17gBos9DOYp/xV0PmksG/wWw8eRMIx4Mi1m4IE31vgl7r0g7D?=
 =?us-ascii?Q?8JWAZcELKeN/+9lclLY0EHz1MgCMdrGxVS5fgVIJDJD0Gbf0uHxg8pSlueBK?=
 =?us-ascii?Q?rrUC8BUt7FMGQeFycI6m313AvvDP2JQiBK9F9I6E5G9OMmus9J+AkBCS5tGU?=
 =?us-ascii?Q?t/h7IQo9WQF85WaTEi1NOv/iAbfqrnIE7dDXCcHVtxEqAOIa6pNcBoRsOr7R?=
 =?us-ascii?Q?U0kUrCqH2gLT4sLkm7kc4LFJQjiw6VFkucWxhS/YRhLbw1yCIiR/J0K9uwct?=
 =?us-ascii?Q?xk9lZM+z7juwNB/638/xkkijBv4Oox9uTayXS02FEKQEEEfrvssrQXEelYF3?=
 =?us-ascii?Q?MbSSJs2H682P9VCMerYXWLbP76hV+rR3WfMa2D65OPR4GO0LATBFZlgwNEJC?=
 =?us-ascii?Q?xT6tm9K396OPnd/c/r/rYdY/jNATqM/tehqGE8t3X9K5Rx/G4loBJWK2frdn?=
 =?us-ascii?Q?R1bUGvAU/lXlB00I1Ah/cSDsQoIH3GRyRFJZlyMnRhjxFRKc43zvluUsf4U3?=
 =?us-ascii?Q?Ow3yNhn1UY/p6eZzJsFMtJxKk5wz9ARapoDLeSS1cdOzCOB6S6saUsOZHvPV?=
 =?us-ascii?Q?d0ozp2neOmmSBMegDaytm/XBjYDcwP0g+XET2ZD2SXJ9+vePCxsY+dkmoXWf?=
 =?us-ascii?Q?GkKF9NP872N8as5fWK9e+V7dTvM67HSj3eoJLkf6fwCbfmuFjprsMudl4+ML?=
 =?us-ascii?Q?zkAumGliD+MWxYZzG+rF8JN2FsT3WTdBxBLNGUrk9KysJPqxMSs+ZKtU5Ny5?=
 =?us-ascii?Q?hosO1UGzJtJqZQ08mOikMuBIkBjSQvcZouSMGE/9qz1q6XCRKbszusAQgm36?=
 =?us-ascii?Q?jWqv0s0cotnee6jvXOgFr0g7XwkA/BwzttRgzXq7Waco3XkjPblaWSKo/sbw?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 704259a0-48e3-4fb6-0822-08dc2116fd9b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 22:09:40.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyUnCxO5E2KrKnBbPh7gAYgfMhkd5HwgpQd74jp6We5AZYWwzYzOKTWL2szrQHPMxCqrtLg0ipzPE1heJEp/4MvD0LAEF6nwMB//NQEUJbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5996
X-OriginatorOrg: intel.com

On Mon, Jan 29, 2024 at 05:23:44PM +0000, Emil Velikov wrote:
>On Mon, 29 Jan 2024 at 16:40, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>>
>> On Fri, Jan 26, 2024 at 02:43:51PM +0000, Emil Velikov via B4 Relay wrote:
>> >From: Emil Velikov <emil.velikov@collabora.com>
>> >
>> >Currently we create symlinks like modprobe (pointing to kmod), during
>> >the normal `make` build. Although those were never installed.
>> >
>> >Add a few lines in the install-exec-hook, to ensure they're present at
>> >`make install` time. Thus one can actually use those without additional
>> >changes. As an added bonus, distributions can drop the similar hunk from
>> >their packaging.
>>
>> It was a long time ago and my memory may be fading, but afair the fact
>> that distros were doing it was what prevented us from adding the
>> symlinks ourselves.... and then we never re-visited this.
>>
>> I'll dig some history before applying to make sure I'm not forgetting
>> something.
>>
>Ack, makes sense. Fwiw I've already opened a MR with the Arch team
>highlighting these changes.

no wonder my memory faded as it was almost 12 years ago and during  kmod 3 ~ 5.


00fc926 build-sys: create symlinks instead of building separate tools

	when we started using symlinks to a single kmod binary

7bbf523 build-sys: create symlinks if we are installing tools
12fd9cd build-sys: forcefully create links

	when we started creating the symlinks

fe8b067 build-sys: do not create symlinks by default

	stop creating the symlinks since it was not working across
	distros and creating more problems than solving

Now that distros configure all the paths through configure options,
we can probably re-attempt this.

Cc'ing some pkg maintainers


Lucas De Marchi

>
>Sadly I don't have contact for other maintainers.
>
>> >
>> >Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
>> >---
>> >Out of curiosity: are there any plans about releasing v32? I'm
>> >interested in the recent /usr/lib/modules (module_directory) patches.
>>
>>
>> yes, I should be releasing that soon, probably this week or the next.
>>
>
>Thanks much appreciated.
>Emil
