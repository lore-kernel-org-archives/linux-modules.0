Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591BE144D0B;
	Tue, 14 May 2024 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696767; cv=fail; b=ogfFLo81EkOjCjyPcyNoiKcBhpdXk3FBtOgz4rkshM0EZb5GRtNcamZaYwFuz2aBOJ80Lkf/4Suyi0Rcz6BRjePITNENRYoKNjVxbR0jGfGdsAF1zuChFZKBV95jfYenVZmUzJNK/M1TJ9PFyZjHO7S7shwV8YXfAc0Xq65/QMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696767; c=relaxed/simple;
	bh=yCbJMG+rItny0+1Qogp67PlK+RRDihhhYT35+oDoHwM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CD5wxQQMCafIBvXr2qAhJODLFWweieliSJNQvO00OEn6PAWgmL80OFhtvHSEePSFqN2riMPXi4PypDBtU9KgKFeSE8BsBQvelhtYp64vyDddjExgSUziOf5cjcN3fvwBtdXrc4SfKfs8CzS4/4PL8t6NhyDO7leiLFhvoCIFWL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ao/PUCT5; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ao/PUCT5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715696766; x=1747232766;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yCbJMG+rItny0+1Qogp67PlK+RRDihhhYT35+oDoHwM=;
  b=Ao/PUCT5f0g2O9Kwxb5DmsQdXU35YdDFi3iO+WA3GWoeUbrZmt4419+n
   hVT87sUca086SgfS5RW6W4v24vTEErEX9hhHQcuSTuFx3Jzu78rpwT6yy
   ReNzqEIwgRVmQ8X9DQEbOe/EdxTytYAdtcq76vlH+4eyyr9u70RBDgFQF
   MzhZ/AhgI2RQJ0uSJDypBh0oPsnKOYZ6aYJ/YD7LpVeVX0uWAwjMXJ6YZ
   T6YnuDjbVr7tPOcWDFYYeimcFJuT7WVsRV9guFvaizy9TcOZKA4KiKykm
   sY5J+jcQLhDS9siY/KHrQv+mNgV3BmQxesM6p5ciuHYuBATGP7aRlOodq
   A==;
X-CSE-ConnectionGUID: MvYOqhqnSSqgGA/Md03JcA==
X-CSE-MsgGUID: kg7tEg+tQNiHgdgMr16qSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11539138"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11539138"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 07:26:05 -0700
X-CSE-ConnectionGUID: ZJWhVpwmR4ic4cUzAqb9TQ==
X-CSE-MsgGUID: vxBNhJtkQP2IgWamGbd+BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35224588"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 07:26:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 07:26:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 07:26:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 07:26:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjEWPOkgFO4WU7gOp+ISj+kIKQN3vbbnt5rbyrZCFjgMwcE4AHahI/zn0nksU0rlyba54L3vyk6vixcPaDx+wIYUF1sqA1KW4Jr3/90sUKEig829lX3rGYnRf9N5vk4x069f6RifGbAW2QkaaE+5pyAUwAKwPLM/U4j/OhoVk4c4CBKbQ53zYPPxP/tbPClWk4xlR1XtCN2LiVgqPVpJ/qRfzE++goAyRgv4G8PmoKvT9BRZxRDVyAZEx6bH9eJgfVXGQfhyfw4Rzme89amLnkO+bNmxW0fVPaFLcL/37YGBvsSVm6zJqP4aCR8djhlmc21EMQvNR1h9FlWOtF9jig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXqxWHg14qV01kdPq5ssI7W2ZoM/uS3P8yeLQs/B3X0=;
 b=kZhytQB0FkFO2621WTMCAE5hvWc3XJyJTA9Jb2xLzDLd556VL4doKjIHpRoGcKf1VdiovdOp42oIVK+l3fwTclbJj4K2feZgLLXJgiycEaREcHgkNEe70kBVjU2f9eE/ZeUmajhRsXGlWEBULcjLzWpL1v8O09q+O7TllRrWAkLLOrEWddF5AvZjHHUiXYzHPUWhNc+T+V4o6b9b717v11+5g/+OdlK9wXP/ym5G4DrEFAOizB3XA188ugUcDTGRvjpYYwcyWXYgS1kKinly2qrlfqpA3oRMWENx0vnPUTLNeFuz9Gg2hS09IZhrtpJzgvYsvIMPQ6RbGZ0m8dosZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CH3PR11MB8442.namprd11.prod.outlook.com (2603:10b6:610:1ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 14:26:00 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 14:26:00 +0000
Date: Tue, 14 May 2024 09:25:55 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: <mcgrof@kernel.org>, <linux-modules@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] module: create weak dependecies
Message-ID: <4rfixlve7indkkudtsgyl7bfp5xykzlh3sf2xzlesjbo7xrh44@b4tdzwxxribv>
References: <20240510085726.327831-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240510085726.327831-1-jtornosm@redhat.com>
X-ClientProxiedBy: MW4PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:303:b9::6) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CH3PR11MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 0173bced-e1f4-4b3c-8073-08dc7421c748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UTIocNZp3odTARaOJC+f3Wy/YdJcFWANKv/qoMl+Z2k23rS5Ww9YuXAX0JVz?=
 =?us-ascii?Q?SZUbbsmsnMLC9K3zvpqpGNzV40pPSxA0XjxQ+BmNvXc0u3ZDEy1BnJBaknss?=
 =?us-ascii?Q?m9V4TWoAS7Qiu4U+KOzlBtbUrbnVFeGgaEDrw+C761hZHrl4VvhSS+lwsQbC?=
 =?us-ascii?Q?baEoQEPy6Ez7i6oa/zopEuD7A4gwALrj6r/FzWUcpC/GsQq7jbuIMM3Tq/fN?=
 =?us-ascii?Q?xnmsd6xKOiDTLMY1vsaKfVWhQO0iloZh4FE9wwKYGv622IZJGQL2WNCEmMMu?=
 =?us-ascii?Q?Hl3Fqn/jcCIcaXMORigjpQTa8D+dxGj3xTzOiuMJAcpWPrqGBQdV4/6bR1KV?=
 =?us-ascii?Q?33epp412NYXXDEabI7PFyuOZ6yiSZc6LyHRoIx396yzL9/WBlOPdMUmkwkPH?=
 =?us-ascii?Q?EugcZJNc4lRFYUKAQE63vbkx0kE6KjOme+zfCA9/hPPdUMyimFUEErZeuYq5?=
 =?us-ascii?Q?jOU126JSLzHqN5L+zu0Wd+4q5Lp7zXVzrTShywTc/4jrYn77sTIP0uVCmxTs?=
 =?us-ascii?Q?EoBbsTqkbWDUH7FeP6RKGkVQ8jmTAHReaAcmsoZmB1M8GfMg4EAXpiBz5cKG?=
 =?us-ascii?Q?uSq6ogWjHZb4EpnXxgM/hTiULYEQdM6oKkj8PQu5fsiL3NzGzItfALUJ9ESB?=
 =?us-ascii?Q?EAxwmgI8RTVEJ9dOi1N2GUop7d8e8CKMi72HXJ0Wz7N8rIdAGIUvhnfpOr/4?=
 =?us-ascii?Q?qqr/GOfZCorU95kSzDgTA5n9c6incOWdkprofC8RX+BhmdTA5LSXPQeMJl25?=
 =?us-ascii?Q?u1KmX2Ic0yJvokzZ+x/4coOZNVMIWHJyYR4YfTYjw5lDkhxPFZCJIO05xHcS?=
 =?us-ascii?Q?HD4k4J2yk/kwML4o/V0+QsFqyLLq3oDp3FcwuEO9pwMPrJPMPzFPMS31dof0?=
 =?us-ascii?Q?3kadY5ocFuj7f4DOJ95/PmpNF7nslwpDi69JsuT4ZWgQi6Z/DBdmxK6rSY8v?=
 =?us-ascii?Q?lrgvgSyLBR+uUQr2hQSPFB6ALEE/6ZWYG8SK8KYK8hRL+KnYW+f+2s33an17?=
 =?us-ascii?Q?hnzXMDWcPyAVzalwyReHtRc948B197bNXk2Spz1XbUSSYPernpFFsJYJF9/6?=
 =?us-ascii?Q?6+H4rqrXNRmgpog5lBPHp+w3SfOtJiWvU+Dcg6CXVXKak+gZ/0ryiKW9YZes?=
 =?us-ascii?Q?lbNbQdfcqitIwmUzxy8luJP4sj9iUUuRzMed7hH7JCtv8hxI03Qg4x5cMI+y?=
 =?us-ascii?Q?qv8c0IYnJObWCTklOfWVvVKSO1C6kbDMuRMWV68FOxKbpDlBMdDd9PGv/Rk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SIuXqjebDS2O7HeDwRlVE3CWkJC6ccd/s2ziTslZMFmjGyy+B+zOgA/X+hCJ?=
 =?us-ascii?Q?iwFhsrURjsYO8qFfQzt3A1K3CC3tDlPu87I+8ZlsR5jEKzJAwmwL/wLayq7X?=
 =?us-ascii?Q?XdL8DdSbJcLZ0qwCntA6r477wJ6WFK7YJ5ZulJJNX+CKXkT78Y7U+G+ecxBv?=
 =?us-ascii?Q?YrchQPdrQigoxLkrgE4jmKQkZst3NRTOiwf5z7SW4Uh9Fa3Od2QAaae7qEsN?=
 =?us-ascii?Q?fLxmgSIYXqWW5sJuKynNQL9v8E16pN90WXHeLhjsgo/KNFJOLp/FyVE50vVh?=
 =?us-ascii?Q?1i1GzG491pI9nm+K6lgGgJADVT3yybaz/7fE1uqJCDDFFra388SENHIa08hy?=
 =?us-ascii?Q?ktyWZW+wku7UJxHJM0QCKEDJbj8heQU137zDBQWP8Tbk3dCDNdQMIt9Jaj1U?=
 =?us-ascii?Q?Cltlrj0gu1t9TsjZFakHdTou9+5DRomOunO6GLAmjlQP34cdxscrSz4Zi2r7?=
 =?us-ascii?Q?BUUHXb8S/zl0GHsOcxhRmw6ixEQU+ysAZyPWLQDL3qlRZS3TS0GaX4lXq7me?=
 =?us-ascii?Q?Bsaxpce6+TSW8+dO+Cu5Jy3lYAExPXhVUNozzMLYQfqOGkEjt0tvIxGSc/m/?=
 =?us-ascii?Q?+4Be/efLAgRsJZAEPCp9aejVDzFgzvG51ydmDtnXmMbOPKks3HSqrLC0QKLS?=
 =?us-ascii?Q?NrhXA74xQ2FVxQXVJgY8ySW9ZAsDRgOfhpgXQUJXpdqo/q91xpI7cl93JOWe?=
 =?us-ascii?Q?wFhPhETH6acTKKBem2AezNZZs9EXKYvN7PgFXd2DPdzblRH7CikCxEii8tMg?=
 =?us-ascii?Q?2KZWVwextHoQOoG9b0o0wtS3xALm+2NrW6V/+t8myPZlbSOKRmOPe04EFBvi?=
 =?us-ascii?Q?hLkzlYZmRhjab8VVOtnTImQXldrCagmDbqAzsT/F5Cl2YtmoX+fPAOZxy8A4?=
 =?us-ascii?Q?QPlFm5GyuRU1EgZdKooRSXCKtGN8zLJlrXG7CW+2ptNp4m/TfCgYlFr83DM9?=
 =?us-ascii?Q?27lzjpFCKkUNW8v3iwggmEgfunapy0pIjXxGEpu+zNuWyK8W3dCXdLzfra5+?=
 =?us-ascii?Q?3GCoYat55liT9ohhXKXaBEtKW+0Sb/M5fPkodWoj+7l315PJcUDSzcYPWkIn?=
 =?us-ascii?Q?U5nH16/y+pqH7MhtA/TmJ/3UnDPXZP9qTngStG0jFz50Q9jFzhK3HIlF5Esi?=
 =?us-ascii?Q?yoXJ8gs6F8ft9+4cPNEEL2RKgdB5W2H3KvrXVZJqrU03l2hrgO8ZIjKPTcux?=
 =?us-ascii?Q?beQlZb/r5JkGyo/MPYCc3wVvRUrgyMj1WFT+1DI3q2g0oorZQJVTG3aVopOW?=
 =?us-ascii?Q?chAnk3IAfCBtf8Wg9Mp6z3PGRz9xkLJUJOpcMBTQs1YT2dRrgB+RLo9GvOZf?=
 =?us-ascii?Q?UHNoBsO0lx7sE3zXBct64nozoajHL6r7hEK/6YIuQDqNWuoYAAaZlHFfrJJC?=
 =?us-ascii?Q?m/BDqxRNviKMvPNTs4xiQxUX/+WAp/UNmiNL+GRIOAca0nWkK4vz2WnJjtkF?=
 =?us-ascii?Q?eKt5LUSaYQohZcI4OFCdWLQGiwLtoEpKTMqR9//Tyei1w8Ia7/0wMaz7Q5UW?=
 =?us-ascii?Q?rCN6TvLPHa4Z4tUnrzJc5iknL6mYgKK84zrBNsfrH8gQuUgzlk2ExdyTEwo+?=
 =?us-ascii?Q?Iig2Tkn/hsfaoAON3y15HvTG+xJqAQKpdBuiguDPOv4DGiybFU+y4ig2NwrY?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0173bced-e1f4-4b3c-8073-08dc7421c748
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 14:26:00.7937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSpOBpNbwrC8Esu/QKtJllXKY4wVS8Ks93kXLG/h6QPaM7QvUfusiCLCvUWkzx3ojjPIwaU1EPDd97y354gi8tVZ9TIAtROtfkocBkiLXwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8442
X-OriginatorOrg: intel.com

On Fri, May 10, 2024 at 10:57:22AM GMT, Jose Ignacio Tornos Martinez wrote:
>It has been seen that for some network mac drivers (i.e. lan78xx) the
>related module for the phy is loaded dynamically depending on the current
>hardware. In this case, the associated phy is read using mdio bus and then
>the associated phy module is loaded during runtime (kernel function
>phy_request_driver_module). However, no software dependency is defined, so
>the user tools will no be able to get this dependency. For example, if
>dracut is used and the hardware is present, lan78xx will be included but no
>phy module will be added, and in the next restart the device will not work
>from boot because no related phy will be found during initramfs stage.
>
>In order to solve this, we could define a normal 'pre' software dependency
>in lan78xx module with all the possible phy modules (there may be some),
>but proceeding in that way, all the possible phy modules would be loaded
>while only one is necessary.
>
>The idea is to create a new type of dependency, that we are going to call
>'weak' to be used only by the user tools that need to detect this situation.
>In that way, for example, dracut could check the 'weak' dependency of the
>modules involved in order to install these dependencies in initramfs too.
>That is, for the commented lan78xx module, defining the 'weak' dependency
>with the possible phy modules list, only the necessary phy would be loaded
>on demand keeping the same behavior, but all the possible phy modules would
>be available from initramfs.
>
>The 'weak' dependency support has been included in kmod:
>https://github.com/kmod-project/kmod/commit/05828b4a6e9327a63ef94df544a042b5e9ce4fe7
>But, take into account that this can only be used if depmod is new enough.
>If it isn't, depmod will have the same behavior as always (keeping backward
>compatibility) and the information for the 'weak' dependency will not be
>provided.
>
>Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

>---
>V2 -> V3:
>- Include note about backward compatibility.
>- Balance the /* and */.
>V1 -> V2:
>- Include reference to 'weak' dependency support in kmod.
>
> include/linux/module.h | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/include/linux/module.h b/include/linux/module.h
>index 1153b0d99a80..2a056017df5b 100644
>--- a/include/linux/module.h
>+++ b/include/linux/module.h
>@@ -173,6 +173,12 @@ extern void cleanup_module(void);
>  */
> #define MODULE_SOFTDEP(_softdep) MODULE_INFO(softdep, _softdep)
>
>+/*
>+ * Weak module dependencies. See man modprobe.d for details.
>+ * Example: MODULE_WEAKDEP("module-foo")
>+ */
>+#define MODULE_WEAKDEP(_weakdep) MODULE_INFO(weakdep, _weakdep)
>+
> /*
>  * MODULE_FILE is used for generating modules.builtin
>  * So, make it no-op when this is being built as a module
>-- 
>2.44.0
>
