Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A81448EE
	for <linux-modules@vger.kernel.org>; Fri, 19 Jul 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721407992; cv=fail; b=jv22vOtE9XSt8WEhy21J2skCY8Sxuxac9bA4mR8Q/XycM2kL0TRy1FWZRT2Qs7DAcZ5yUrXyvl8JdYjKy0WiWv2VwoIyfUpo/nt8RUn6DWDvjUS6K6sLejhAw0Kc/HFtAYLFKwbY7CVzaOwsNqVPvTwTtX+FLPVOn/96hntTlWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721407992; c=relaxed/simple;
	bh=ceNQHM+SMsmqik1Cjiy37bwLuLHUbWPLyoz+3tqH0Ow=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QP0LQoofq83NJ9wksS6WbC3JtmdILuAvx/qRLbw4ilNNWP502SYOBJO9koktZCPgPY7A3VrE9+PlasR+Skg0jfbCWhm3g+gOogYUVqEEvbY9yYefm1QLGV3CYpwTfxLCkozp7J0YeapIMJmjEdribL3TutdL9pYkkXl5PbxayhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jB1BaJ6+; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jB1BaJ6+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721407991; x=1752943991;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ceNQHM+SMsmqik1Cjiy37bwLuLHUbWPLyoz+3tqH0Ow=;
  b=jB1BaJ6+pgm6A6+eRH2PznbIAwF+gX2iyRuVqpawF3CBeAdlpTKs2abN
   tz/vPQZVVS4wJ/bJigY/i+d4BnLdrve0+6QMCN2uO4vvsHhkpTUcZzKv+
   60IyaOqokv19cwxi2pPn8KJUN2FAQOuRKbJTYU92GWcXpPk7xYO6JkB71
   KwXBeWQ+7wMOCACNukG0hQ+U0CMT6JF3EPRPx4Xq12zJpwxD9F9XLE9Y9
   K9cx7gsLie1gM7dt2Vuk5LBVEDQMZF3gHIa754TCezk+T1wyVbbOp2dF8
   uz/LmYbxpKfwxtkqWWxL3rpTwkGmnRJmYsc5W/zHef1J7f21EGhXgGwRL
   Q==;
X-CSE-ConnectionGUID: KaDtL+ZtS8aLrvUTX65KVw==
X-CSE-MsgGUID: mJX5CaayTxG7MUm+YJAeMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="22795141"
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="22795141"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 09:53:11 -0700
X-CSE-ConnectionGUID: RJl6quXITQWRJvWzUx1DLA==
X-CSE-MsgGUID: 9TC527sLQEauyWFxi7vSEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="51788506"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jul 2024 09:53:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 19 Jul 2024 09:53:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 19 Jul 2024 09:53:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 09:53:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2xx5ZcIv/GJlc94vpoGGTXxs8TGQesoUJf9cM3HIz4ubIwNoVqz12xfXGlDqLsQdw7bJINoyhoAJy13KzH1gxsZH0SQ4omrKhSFl6PS+9iZEFXLPa3T44U6V6IOzWwn28rtcV8fTirQ+zNFX7014v2ga8rMh8fqI7VvgrJqX6645uQ/ZkcwXt06PLHP5AAE/lqv9bcHYPpgUjNhCGjKlsQN/eReL8V9HoQqcCyOBIW5nRtMshlGNVUbDUFtt66L3PObjZqbV4GhtkPjREJ5Y4skL76Fi3CrUr1Y18+EefzvJxVh9+56VOoEoxIVIbcxDkKDPWrBWjy76nVbM75BgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceNQHM+SMsmqik1Cjiy37bwLuLHUbWPLyoz+3tqH0Ow=;
 b=d/4UxKgR9olPMo/RXpchhOs0BnAcH5pRE4mLUFtHZs+/lDXNtgv+xuZm+Fh2N5PI2Em6bWZKX8x/8xkzRAKwYrKAOi38dj7A2wl9QcO3SlqP1KvhLW1wwe9MxnM7YO7Z17FZ503hml2P4siVFVkMM0jEvqEjPlZ65KYnWzsG3fKJay+5Hah7ow49mzVkFClG7c/12XWzO/47NRTmqHXmlN0ewZG7qtl3qKhEHJH86JPmCP0zLbuAkV0fAzoqcv5qhAfPYFfULLm+5dxsVW2bYouTM0FpawzfB7zJEHpBuJsIchrpxIOo0qp6mR4eOlL9GiYQ42Y+kpPezwxAv16eLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 16:53:01 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 16:53:01 +0000
Date: Fri, 19 Jul 2024 11:52:56 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>, Marco d'Itri <md@linux.it>, "Eugene
 Syromiatnikov" <esyr@redhat.com>, Josh Boyer <jwboyer@fedoraproject.org>,
	Yauheni Kaliuta <ykaliuta@fedoraproject.org>, Jose Ignacio Tornos Martinez
	<jtornosm@redhat.com>
Subject: Re: [PATCH kmod 3/3] libkmod: move new weak API to separate section
Message-ID: <3xadbv22denjgo3qgezvbhkq6ent2o6w5her2jxbfxuu5cm553@rhadvveggecv>
References: <20240719-abi-fixes-v1-0-1e6d99a2846b@gmail.com>
 <20240719-abi-fixes-v1-3-1e6d99a2846b@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240719-abi-fixes-v1-3-1e6d99a2846b@gmail.com>
X-ClientProxiedBy: MW4PR03CA0313.namprd03.prod.outlook.com
 (2603:10b6:303:dd::18) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|MW3PR11MB4620:EE_
X-MS-Office365-Filtering-Correlation-Id: 21163b73-b3f7-4ae7-aad0-08dca813403d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2zdT/c0OXin031NstSPWYfN3ayWM1abirq440zYqlG45cTXxuuxk1j8y4iqG?=
 =?us-ascii?Q?STVcAZHKbZzvr2uYgucdYVO2H8Fy0a8hEux4/mx1OAtPtg+iBF7lYn92KrDO?=
 =?us-ascii?Q?k2fC7yuywqsHKtywIW+8GOqMhwj2j/dFVVZjYNgISaq7y9/MGUJkDFh6iRrD?=
 =?us-ascii?Q?lJ21JyMmWzXBWKOY/qTN8BI31zfEBxJZvIOfAxfGjUac2LGjDYsYt47K0Ouu?=
 =?us-ascii?Q?njgHKj9eexMfGey7zA1Yrxv5xybcuKIB+7D80YugLybXJsQyW/ud5s9n0JyL?=
 =?us-ascii?Q?Lp8+Xl9ltY7nyLV3yovir2Ah9z66c+jWO9AUnIwJ4iLCD4axxdFU/QWWgfHf?=
 =?us-ascii?Q?A2PZ60DCkXcJbxSYFts6k/HbE6125ktD2QM8hvNFDWtsXrWdsbeeUpAYRsKX?=
 =?us-ascii?Q?Olw3hK8oH+ZebFJsXThp2b6iNWPRN2Aajy16FtRRtahMtJox1qERk52NsCJh?=
 =?us-ascii?Q?TmnKtsNpbS8zSeSdJyoXWo37pps6R/M12mLR2QuBEDzOJRSyTmfjmqmHF5Na?=
 =?us-ascii?Q?6D5kGn9EB4tuyN9ISLIykC5NRRBgCyviDcnMzztfSxZRbilqi6y0r/K89zvY?=
 =?us-ascii?Q?/A12Mm/KBFpPIkcIpwTHeZusaGyd6BtfXGniLnLjgodSM1xa9MF5rgFYMqcC?=
 =?us-ascii?Q?KusYEmYs8r1M1YHPMeIEEcNM22OSOEefCrljxcjHmSdONQTpyVFLrhYpiyGL?=
 =?us-ascii?Q?BLwsgFXstYv9krMpP0oTHUR+xQkad1hlZhgbjzsh+l0SNeIdzwckHTgkALjS?=
 =?us-ascii?Q?wORGlUWgfEkeGQ++Qxn7GRO20OhsCw/nZ7kSiH0wofbM9wHoVI6r7S/pLMSL?=
 =?us-ascii?Q?skPPUHEa7wslmqTvTlTNl2j0CA7htnPhTl0NAS2p7wSAV3SpF9d7b1lH5N6n?=
 =?us-ascii?Q?cWPPGbvmY+xIF86myqVBmE8wsmE5WP5bS81OabzZuCliKr2gGkXWx9Cz4IaO?=
 =?us-ascii?Q?tGaNB/rARSzJBXftOWGsrmt5nMZ1kIP18I8wCS5wXvm+yQf852DiGM9aOAIF?=
 =?us-ascii?Q?Og9DvI71AIep0Mqnae11dc9997wKDauoQI/N0kUTfukW/SXbUeIL+S2oMkMW?=
 =?us-ascii?Q?wRM0DL+O7Nv4C9aB28DWALlr92azIAABVSSQRQgt58Bed9+nGXyiJGOowDGj?=
 =?us-ascii?Q?AyUTGFBz1NotvYgarYyTGlp8qocnYmqb9B443JLWrmIrbkMfU+TvkvBX0M0u?=
 =?us-ascii?Q?NTIRSBrMhu7x0bEZeDnddgdnA33/Db1MpLGEfuyBi0s11VcrNDy3v9aeDkoS?=
 =?us-ascii?Q?RsLsLt+bCJORUB6VDvBE8BQyxWQTE6RvYEYEYD+Ex+/d6cI++iztE5xM9f5S?=
 =?us-ascii?Q?OH3AXWoqC0jOmQBDBSV/Gp4MDSER0GF8BzAyvu95dmJ3sw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6jm9SOx+apubXSJZP4M0BVI7457Py+KL6RfMeG67BrxJeLkziNkrw24vF43S?=
 =?us-ascii?Q?4YJcmKYbKCqt91qqbj9jK4X6oGObwfGR8lDv5chTjhFFgfN/1vgvLp76ipw9?=
 =?us-ascii?Q?WV8b+z6Tw3ysDZo+FmLmB/QkZatJ06l3+1rxafayt9RyGztex/4uHRj/9H1E?=
 =?us-ascii?Q?d1iJzm8AhllZ7yq9R31/KMAVu/DkYQW9XF1pHHYI4s1aogjGRD/9v22uQFI6?=
 =?us-ascii?Q?PxpImq4PzpgbZHPeDtZBiPXiUbn1tCJixkrfVXuuvltsY69fS7899ZUeXZmd?=
 =?us-ascii?Q?xKTBG2XO39fUQaskhaD6neoOuRO7750XHBRdfrDfM/jLKTUnZfwoVR+xUZJU?=
 =?us-ascii?Q?DiytfebxqxTlPjPE7C5bnhJToeiHWVlFgS4IfYSQZovmTS0Ya+YD3l6RxAcU?=
 =?us-ascii?Q?stcMZdoJhNydN76sSNnQ4oFz5lbcOekxp8R4roj3sqr3VmDiZVwRgb+LIYfg?=
 =?us-ascii?Q?WoL/fsz3AQy8gHLokFcKOGggMIiaYcoTuLgDcPySwO57g2Vn0gS9eHGHCjFk?=
 =?us-ascii?Q?Y+OtYJKwAjrnPwTUAICvljNgCTVvLu7Qv9KJETiGsh7u75rhl4fBS32SlDSk?=
 =?us-ascii?Q?fffVpstHR79AyUqpvi6/X3zOx4dJZB5i5UEkVrk67dVzjp4n62H8Ak7Yw7Ci?=
 =?us-ascii?Q?eaI0ms5nR5Kh/e+GHN3k8F0xUsPYMXaUIqaPaMCfq0WVRrFiHeR0UdFhMaVM?=
 =?us-ascii?Q?5leSP83jxSKBLb5pv14R+ebToZbGTxNNEmhe0wnXEwerlFXa4hFBHend0Sva?=
 =?us-ascii?Q?FyfCMVSiNCne64au7L5LxZLlVC9fZg7iNXgFgrwVZMw93jDstfu81c/j2bg9?=
 =?us-ascii?Q?oUnyFey+7fXml/i51cAd8gq9D1TYMfF63PSWSBYcpElwbKTz0U82DG9pdTdA?=
 =?us-ascii?Q?3rlynG68rfHDx0KPIk9//CChx+q7R+lfqVYRihtRikFnqCItBCKJoj+TZ/7T?=
 =?us-ascii?Q?67DepS2UBX+VemaHpGIPqNWK9xPXtSaCQClOjprGC7OUI5MKYiRA0pE6blSk?=
 =?us-ascii?Q?gpmghU9hVj/Lx4pt7/rutdpgKnuQr5eiEMZHck5FdhZ2NXXim7nbmRSMPohz?=
 =?us-ascii?Q?YMO/tC9+pKm4zClUSAvG5c1Z/XwnMYNb43FGNM9cRtRDiNrR4ki3Ul/Rk/YR?=
 =?us-ascii?Q?BDpSrGvSvTyhWJD2017TrwSrD1QkmRm7rLEM4MzjQdJfZcpaKafR+JMQFF2I?=
 =?us-ascii?Q?epgmHzvkMFZS7Dhe+vHMhtrj82NNliJzUjnx3NKwPLkcp49OuUiWFHL0repi?=
 =?us-ascii?Q?EflCd5nbghEcS9MqX09qcKuULvZi4U5KOsa4R6Sqn0skoJce+HYRu5ZC30dN?=
 =?us-ascii?Q?hDxTFOe0UCXXRov+49MgWZNqaRmTOh3TMIvWeKHwKAHsdHVKyuWyMtESzT7j?=
 =?us-ascii?Q?yM6llKGc5V8UW/VtiCILZgvTA3fKnzAsahF3DGhYn53kQdFYam3d1Gm3wK0h?=
 =?us-ascii?Q?vfoP7TIhp3TpSyCN4D5DTbChfWKfE++hMD2PCvb6AyFxeMaYsf66MTr/Ijnt?=
 =?us-ascii?Q?ZAyQDGFCfqkn9wyWxV1cXeFvtQlIAoxvXxigfA8DMwiaga9kIhnMBKGMKsRj?=
 =?us-ascii?Q?aoYFnX8SQ7tmbwdKUoUBrT9GToyjnKhByJ3xzhO/fYYRJu38RilrdCWIfmiD?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21163b73-b3f7-4ae7-aad0-08dca813403d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 16:53:01.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFsDxYfW7eLDHYxWdTUTVkAYJuebUkEk3zpXBbK4exSphC58WipzWPwA975GrB8KJJyoyl+HLjXDWtgNOo0+QJxhI/Oj123TFJcPWiGYSes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com

On Fri, Jul 19, 2024 at 05:12:43PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>Add the new weak API, to a separate section in the version script. These
>will be exposed with the upcoming v33 release and not with v5 as the
>symbol tag implies.
>
>Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
>Fixes: 05828b4 ("libkmod: add weak dependecies")
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>---
>This might be a bit of nuisance for Debian which has a git packages in
>unstable.

FWIW we should really do a release soon... hoping for doing it next
week.

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi
