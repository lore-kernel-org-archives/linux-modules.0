Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2AF28C84D
	for <linux-modules@vger.kernel.org>; Wed,  8 Oct 2025 06:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759905685; cv=fail; b=uomGXptiL8ctzh+SYRUd8IlvSSGnkA2EJKQBe1CgHMT8lZpPMOTJP5TvF+7eCGthEFe8FRgLbyI1rul0wpT7bd51UePAehH7edPEhKe1ntnhhx4dqpAE7gmS0oiounN0sOk3GnSZopW6nncP6JZPxOHyvul2s3n5OHNaK4EmWhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759905685; c=relaxed/simple;
	bh=9d8o48IWhxx+9sdFggGSgYivAKzsUnaTn+eUxNmr6gg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k41VGq8BQqliviSlx7T6sbG8RQ2Xks0B2Gb8Z/Qj0VP6hm17iwHxVuyl1cYzCuH7Em/DtYdpm6ls77uNG5LFFqmnKvSm4ftsedHJSsU6KHdaIuFabYKCn+ktdYe4kBhlZUR7uIFd1oUqGhKn/PV+6dYFo3H5IrdWokkmdSKYMtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIuEXU82; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIuEXU82"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759905683; x=1791441683;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=9d8o48IWhxx+9sdFggGSgYivAKzsUnaTn+eUxNmr6gg=;
  b=nIuEXU82eonNjfdnU2a5AaxHTCxVFmJhMlhpUxMOFymPyB2F6Ggklrrc
   UtPBcA6/ieJjVT4YohF7WgubUqHWEAGEqrL0csIDYznxdiYSLfirO9FLB
   4kSIfgBVf/I3RdkGPrFfs1j5f8yfnrHmeBEiKR6yf0b7g/vUiRWqTaH40
   Zvvq2wdVX3lQOR0w6fsB9dJyLVNy9WYtdzvGqSOzK2239w4uXHt3SypYg
   f6xRTWwA4IckTwOZdwcRWFDpOri2KJdkRJt6YowihCdJU5cipRe7dsZYp
   9X6Sbdmt6pwTsmx0/oBwuylKbqUTw3uwrKk5/b3CGi9L8vuF/9+dCLZoK
   Q==;
X-CSE-ConnectionGUID: hjRzp5bdR7W660PaW8ekbg==
X-CSE-MsgGUID: zMxktMfWS260LVwRpB2aGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="72770137"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; 
   d="scan'208";a="72770137"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 23:41:22 -0700
X-CSE-ConnectionGUID: XuAUC+T1QB+8aYr9YnwtQw==
X-CSE-MsgGUID: kOi7Dz/AQmOzL7GJrHPYYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; 
   d="scan'208";a="180181451"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 23:41:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 23:41:21 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 23:41:21 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 23:41:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F58QopqvxAI4Eg7vRweI3Lt6gJ4nhxTGBCgeJ7eLJ4/9RcAR6xXm79JtjiBv2fpTi2d8j0xgnxBUROHC5ObstI+xbreRQCeFmYfbChr94OfGB94iQP2wTJtE50/dYXHO3k4AqecDLkaYt1PVWJ8fI7YKnFtFUvVrTnbQmAgIrXz4vF26ar+l73zCtN6u2S6vRnag+4qKxjkkv2c2iouy9LW3dz2svyXuYX8UQBWPZOoM7Hjep6LaCWMemKH74p8ZMTBa9d/E/yS8mzsQ7RpgphXOC0kNj3Fp4n4gb54217fM7dBOE/GRVPchvdHwLQqF5CMaVaf5+zALimrlRRRzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCv7pUwUCAWQWNVz4C4ELCuaJoudth6gTG2zbookV+w=;
 b=sLJvLDWJ13jFeYaSHInfXjWAw1VCTR1pjKJTEUrvVZMdH6Hs3NLsbOsIJg+Pw6UATQChrJkN8Rx4Nj8ZqBIGJud5kUZ+grHtMwAABID4BN5YjJcbNfmxYcMAGaTfYnz2MVPlDch+klujrbVVFdejTbaefP3pBOQesxwzRAkUCBbfVwzXLrlSp9RaOMOktN/k8n2YyU3j9ljaV97wPc5DkzCgdwEWEiVDrrbRwGwmzrcrNSAXE8axlwuKWShfdDAC6PYUGsE2iXDothqX6jOlMPb9LsxIGUXQchFI+7OWWsfojkLP+3xgXJXvkTaeM9i/4t4e/OIRgqf9DuNff4JlIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by MN2PR11MB4663.namprd11.prod.outlook.com (2603:10b6:208:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 06:41:14 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 06:41:14 +0000
Date: Wed, 8 Oct 2025 01:41:08 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Petr Pavlu <petr.pavlu@suse.com>
CC: Phil Sutter <phil@nwl.cc>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	<linux-modules@vger.kernel.org>, Yi Chen <yiche@redhat.com>
Subject: Re: modprobe returns 0 upon -EEXIST from insmod
Message-ID: <hupl3hqym5ru3fr27s3elg6vti4fjtphdwvvyxmuvekc2w5mna@kilmmcgobw6x>
References: <aKEVQhJpRdiZSliu@orbyte.nwl.cc>
 <8a87656d-577a-4d0a-85b1-5fd17d0346fe@csgroup.eu>
 <aKLzsAX14ybEjHfJ@orbyte.nwl.cc>
 <02be4b86-330e-4f93-ba79-8218d05659ba@suse.com>
 <i4ayzta5zgltyubg6bfr4mwqhl6goyh73lyc7j7m3vngvpooi3@boorlngxpi52>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <i4ayzta5zgltyubg6bfr4mwqhl6goyh73lyc7j7m3vngvpooi3@boorlngxpi52>
X-ClientProxiedBy: BY3PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::12) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|MN2PR11MB4663:EE_
X-MS-Office365-Filtering-Correlation-Id: c369e561-904f-4f32-c45e-08de0635ad17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?1Pq50P2HY9DkJb+yDE4BcTl9kl84R3/HwEvVdQ3zNIDrOr7jzPC3DgeAsz?=
 =?iso-8859-1?Q?xP2BuRkpRwpSuaajN9X3afIPHL3iV3CxlfKRslznjwtGBVJ0/s1x+gIZ24?=
 =?iso-8859-1?Q?BB5p+zT9XK9qoWJsxXavYyVZuiGhXyof+vIvAniQD9MFFtDETLCQCnCjCd?=
 =?iso-8859-1?Q?dvHybqjeBzFhoojnYEknSvaInHaGu6qn1Kf+hmeerJYfdW7vyvByDgi6/V?=
 =?iso-8859-1?Q?F0uwqmFBPob3YWfSSd+jMV4byPKVwmotfOVLxy2NcZlJEEtKmA3yccV8An?=
 =?iso-8859-1?Q?yAgMmvMImbcZSZmCM7yZ3c5FNZhQQeKmQPTfNKiHZFUob/KjIzb84383Jh?=
 =?iso-8859-1?Q?rwdy/zV3t0R+RPWoir9EjL7lAnrkub5oySAS+QsBx9Ma0mU2sSoIb+8GWk?=
 =?iso-8859-1?Q?Gs2rbdfeNJayAf4SmCw6lQ8aTGjrMXRGB9y/KIb8HbmMgCUv/+4pCIF8VW?=
 =?iso-8859-1?Q?xP521wY+rwFveCUuDn1QepPyTPr4JcQZcgndAJ3wBYJFpRu4PiUjmt+K5X?=
 =?iso-8859-1?Q?aE0N8XtkJu/K0YRu9Mgl5mruqVAzTlC2Sbb9J/3bhrKzvgF1xwJT0aHn6U?=
 =?iso-8859-1?Q?lWSLDM4tAkmUrW25dYaCoMoFEmj/DLIFjBR7dLuCx8H4ED6PVSObi0ppJ6?=
 =?iso-8859-1?Q?WA2RMheePusTBiXQoKi5bqhXVQ5BoQ9zbfE7jBeAEsUh9/LNx5cO0Bfk8G?=
 =?iso-8859-1?Q?1P+CTKPvCDSEllwUpNnXDaElA6mk2bgCy/DxYfFCsIoSrDGq3Tkk9Y1kD0?=
 =?iso-8859-1?Q?HGtaViyuCsLG1QOUXauZApHDsn+prr5AlQuxYASBE5boh4OW1p1oySNcez?=
 =?iso-8859-1?Q?OiLOrsCFOG5HDfL5sSZCM2fLDd0U8r+ibqahE2CZ7+AWZkydR/T2rJa+3n?=
 =?iso-8859-1?Q?9KSfF9A6k0PzcwlLJV7QVHMdhUPXTSygAG+ZyGfO2aXcd26mePopqAH3jr?=
 =?iso-8859-1?Q?q2FASyLupZUBQLkD9IxQw9hGqvAnYMvxq7SRVELjRWnsjLdUJV2XM4F6os?=
 =?iso-8859-1?Q?Z4H53dLzmVekyztR8l6fhW6puXVxKK0MCacXobdHX5k2+nT65j7AcraFeV?=
 =?iso-8859-1?Q?mWjUzwMZDk5YeaA+MN4KLBcHzvfkaf61YqscuyD0UrGf9HhxLqkj05ZLgg?=
 =?iso-8859-1?Q?oRLPBNVLc8LbOay1VvvpwFqqw9jgUpZJk6aBUQfkgSI8/Kk4qMtaTStqW8?=
 =?iso-8859-1?Q?XnMm26+kwR2znS+ixmH3bgk20qq+ZMtOG0y+y51OZBbCs2HoO7ko6U+cOf?=
 =?iso-8859-1?Q?lahXBQ8bZmtMdysMaBK4ISLXmZ6n5GXMvl4rwMxhNW3tJOcNkWBbw6X6kp?=
 =?iso-8859-1?Q?NEuG1rbyIdC+1vzOppXFOeNw/U24g6DCdyU54qJLpm9jQQ4owzCOWTtQdg?=
 =?iso-8859-1?Q?F/7Vz3DC6JYmt/eVThdsZ4mKZEPlTIVr66OAjGJxmIHfO4F3394E934tVF?=
 =?iso-8859-1?Q?31ed4G3nVoP+L7evgtgB2MxUn9z6MrwTkSWmrQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gGR9AS/YtrUiPjOG0DzmRF3Mham1BaPfytAF6LHzicP86WPeJIdz3QwQCI?=
 =?iso-8859-1?Q?hbTAF7sdkYmrZeGiBuUCPBtfnJmuJdeApi/WzYCJPbHJwxRgGYDZOhFT+3?=
 =?iso-8859-1?Q?5R1L8+u2DPyk4sgSCtBGYXDETbsUQWbzzb9FQrhjh4wO6ECW2O9PYbRVql?=
 =?iso-8859-1?Q?trEuIN2VPeT71ddHXDA2OwIWhShylnCaXtL70hJ4Q98Nm6wJ04NRhOKjj6?=
 =?iso-8859-1?Q?YpL/Qm5awQ/sQnKez/G8mdLkrJH0XlKDqQyH5nhdgqXd1ZE35wJ87mHoxp?=
 =?iso-8859-1?Q?xvQAn64e883EPfd0koMEAii2khSKqE0kDJfwolR4zfgA4eOGIMi+yx3Q62?=
 =?iso-8859-1?Q?YTlR9QjhbmVPB46L08HwKabAN7odC2gx6+pqOcBYOdS8n8ybZPfjPcLO9+?=
 =?iso-8859-1?Q?puHQiJ74DqqMQVXy36yLozsn0DrPRcIfaqXSTbSMfLA23x37ddVHmELdJQ?=
 =?iso-8859-1?Q?f7PCk4NKADRdxSMApmH0nhb3De44MWoEjD4LSTeRNrc61iO7LJO2J3Gtop?=
 =?iso-8859-1?Q?YyHxKWWf0Wnp6MVoSxD6f+s82zB6cNuBKDSg1dULjMQ4AIdGzfCEjrH9hI?=
 =?iso-8859-1?Q?Hz4gyGmz3CFh2i2VY0+oBs82+GUhh4S79RjD+OOk3rgaCMc8CQvx+qqFUW?=
 =?iso-8859-1?Q?ux27YorpQKnuvu7DbkYW89TxooVfxEeLAcAPB1lQhN2W/THpiOzRzz6Z1+?=
 =?iso-8859-1?Q?eQl3jOxh8PT//ireLY/cHYliu+FDug42u1NJ2B6fSa8f7SOcRWmx0piMY3?=
 =?iso-8859-1?Q?zzHLjxH+b4k0rN9n3I22YxPRJPdDnHo6awSd/G4cCUfHQMZo97LXFf77tF?=
 =?iso-8859-1?Q?8m8NZmsRw4a94L36huiHlr24bkHBl7+EcFukTIQ3csdfzuo4vP5xRgVPm0?=
 =?iso-8859-1?Q?ZEI6LMaupxmZB6MegaR0uvqJGkm+hR3IVCf2MNSSTb+BIsZinHxGgXvusH?=
 =?iso-8859-1?Q?8N+s+Yo/mVYdN/y+Wl9hzPUqqbsxY7u8gakDU63M91E8+xqKH51Ay2sPuj?=
 =?iso-8859-1?Q?C855XvxryjT6BDima3c9u2lS3qQzKjZOUvy6FMLS2tTogeXNi0qoS5jvt/?=
 =?iso-8859-1?Q?WD3Lllnyv4txx3XGNxvJiXcBZ8bURdha0TmC963pePNDdXvd/j/5Kv10vv?=
 =?iso-8859-1?Q?2VUBKfeSgfolTY1ZSVhqQtFm2vYHPo/Ymc4hT6kUZnWNfNkG8A4IQYp7cP?=
 =?iso-8859-1?Q?t4sXwfXY7Y/0Qc2kfTbHtQfkSNrTjcveRjTmqQ8J49JQFRNEY09W7myXz4?=
 =?iso-8859-1?Q?ys1IKne+nZF0ayWpERwJ7gCd/AVHKBzxTfmjK8ljiMYrPbEvVLclPa3yIB?=
 =?iso-8859-1?Q?mAjT3zLTcHyVgqdk2vMbSSzv1RGvzpETPphASLi/taD65Uyn8VkUoOLMKw?=
 =?iso-8859-1?Q?JhsoQ27VBg1LutuCcLz/grbTpvS1nn0lLNeVaTbvkxPI7KEgoZDl3iUmxl?=
 =?iso-8859-1?Q?+e25OyklyvtqMIUr/l1lhAHCDKv5CUscSsccvUeDMDzV7iZBTRpaAnot+d?=
 =?iso-8859-1?Q?in3P5oDjMbtgL7jSSP7OjJsnm7x/bWHoqsv/JNeU+wDICP+Q47G+kkRW2h?=
 =?iso-8859-1?Q?Al1Ty0dwGGzGYDwPDE8AAu72a0DG7d1s7Q62omB1Y3iEWpwrwUmt2NXepw?=
 =?iso-8859-1?Q?bMIJNyRMwRRR7msPVK4L+OME3+bE8S7Nzfc3RlRVQQ/7gdeE+xY2Bxig?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c369e561-904f-4f32-c45e-08de0635ad17
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 06:41:14.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2ZERlRq9KmtQ0GsXTGmnWQBsKRNbI5SU1RKQYzy3LTiSuTTKNl06brB9r69gVwMla3fMlBorWklA6dI1P24RcxVTIYe2kja2d8kNZvIuPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4663
X-OriginatorOrg: intel.com

On Tue, Aug 19, 2025 at 09:17:50AM -0500, Lucas De Marchi wrote:
>On Tue, Aug 19, 2025 at 10:52:16AM +0200, Petr Pavlu wrote:
>>On 8/18/25 11:34 AM, Phil Sutter wrote:
>>>On Sun, Aug 17, 2025 at 05:54:27PM +0200, Christophe Leroy wrote:
>>>>Le 17/08/2025 à 01:33, Phil Sutter a écrit :
>>>>>[Vous ne recevez pas souvent de courriers de phil@nwl.cc. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
>>>>>
>>>>>Hi,
>>>>>
>>>>>I admittedly didn't fully analyze the cause, but on my system a call to:
>>>>>
>>>>># insmod /lib/module/$(uname -r)/kernel/net/netfilter/nf_conntrack_ftp.ko
>>>>>
>>>>>fails with -EEXIST (due to a previous call to 'nfct add helper ftp inet
>>>>>tcp'). A call to:
>>>>>
>>>>># modprobe nf_conntrack_ftp
>>>>>
>>>>>though returns 0 even though module loading fails. Is there a bug in
>>>>>modprobe error status handling?
>>>>>
>>>>
>>>>Read the man page : https://linux.die.net/man/8/modprobe
>>>>
>>>>In the man page I see:
>>>>
>>>>            Normally, modprobe will succeed (and do nothing) if told to
>>>>insert a module which is already present or to remove a module which
>>>>isn't present.
>>>
>>>This is not a case of already inserted module, it is not loaded before
>>>the call to modprobe. It is the module_init callback
>>>nf_conntrack_ftp_init() which returns -EEXIST it received from
>>>nf_conntrack_helpers_register().
>
>is this a real failure condition or something benign like "if it's
>already registered, there's nothing to do"?
>
>>>
>>>Can't user space distinguish the two causes of -EEXIST? Or in other
>>>words, is use of -EEXIST in module_init callbacks problematic?
>>
>>Unfortunately, error return codes from (f)init_module cannot be reliably
>>depended upon. For instance, cpufreq drivers have similar behavior of
>>returning -EEXIST when another cpufreq driver is already registered.
>>Returning this code unexpectedly can then confuse kmod, as it interprets
>>-EEXIST to mean "the module is already loaded" [1].
>
>well, it's not that it can't be relied on. There's 1 exit code that is
>treated specially, EEXISTS, because that error is used by the module
>loading part, before the module_init call, to signify the module is
>already loaded.
>
>>
>>I have thought about this problem before. We might fix the main
>>problematic occurrences, but we can't really audit all the code that
>>module init functions can invoke. I then wonder if it would make sense
>>for the module loader to warn about any -EEXIST returned by a module's
>>init function and translate it to -EBUSY.
>
>If it's a failure condition then yes, -EBUSY looks appropriate.

something like this:


diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b261849362..e5fb1a4ef3441 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3038,6 +3038,11 @@ static noinline int do_init_module(struct module *mod)
  	if (mod->init != NULL)
  		ret = do_one_initcall(mod->init);
  	if (ret < 0) {
+		if (ret == -EEXIST) {
+			pr_warn("%s: '%s'->init suspiciously returned %d: Overriding with %d\n",
+				__func__, mod->name, -EEXIST, -EBUSY);
+			ret = -EBUSY;
+		}
  		goto fail_free_freeinit;
  	}
  	if (ret > 0) {

Lucas De Marchi

>
>Lucas De Marchi
>
>>
>>Ensuring the reliability of the 0 and -EEXIST return codes from
>>(f)init_module should help user space.
>>
>>[1] https://github.com/kmod-project/kmod/blob/695fd084a727cf76f51b129b67d5a4be1d6db32e/libkmod/libkmod-module.c#L1087
>>
>>-- Petr
