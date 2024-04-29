Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B037E7441F
	for <linux-modules@vger.kernel.org>; Mon, 29 Apr 2024 23:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432447; cv=fail; b=aJrxKEPH8SB0C8qMfqmWvw7tgNZhRspMXQzpqf+7ZULclahqXHHkZs5xXCnBvHP3VoW827I5AyRrbERfqVTREasi51wxht44RF9AS7JiVsnu/BoDcx8caafZyrbmbcG1HUz/IoIzHYSxgoxW4PLxFOoY+6xZ3ALdrFbowkcDH5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432447; c=relaxed/simple;
	bh=5oEefHapB5JlTIFSKu0L95PNpKiWDmqtesKkX3H8Im8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gPDngpBTkdjvt05CeNGMRMKii8NFM9Mn1t3J9ECspkJRYP8hyj6XIsjfRPRP9UYzdP9GmICocRgZWOuWkC9H+OODIKV8rMJ2RGL58sXYuaYx8YAxH50+ZOBRThBzqvzrDkGQplK7B5XnR9pYE21LXmbKU5i072+3fdzXthm4Uxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9kakMgd; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9kakMgd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714432446; x=1745968446;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5oEefHapB5JlTIFSKu0L95PNpKiWDmqtesKkX3H8Im8=;
  b=e9kakMgdJGZvw/0uXaJVJmZPzz9WgNvTbwkbkfUOum6SePs0YA643P0j
   muXlmU7vQbqkmXSgxAuvfXZdpZk71Qa9DH7J+I7FHfDCA09A5NAB/q8+S
   VRVrcCcJbZ83GjOCGyg4PrsxOjqYnObha7IcD/kaC8NFiJu0AP9PyhuR2
   NpiV3hCmySl22GHRC8VdyCFPawnvbx41SWQn/7UYAaYIzZb+OH9V8l865
   AbSkDPWQhAxBJU/LvQSCB+fXTHcjoTK3KQVjCNghfqfWRuPKVW1D9gYRf
   oRrnpdDSz2aREFQsmpyMlZUEzG70JsCkywE5OUQ4u8nRpagqElyatpzKu
   A==;
X-CSE-ConnectionGUID: fShn+b4ISj+grqb8M9qvVg==
X-CSE-MsgGUID: waenSyiwRNaaYC5fVcuCCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="20668343"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="20668343"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:13:39 -0700
X-CSE-ConnectionGUID: VDdQprHNT3aw95HpNW2y4Q==
X-CSE-MsgGUID: pOWpqS+BRIW8tFNXB0AwrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="57461282"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 16:13:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 16:13:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 16:13:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 16:13:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLkL793swncbz391VOPA5/CdD81mfb1dNouhKXS7qJUVBJs8HN1mR67f5MtwMPIrySbAZf6RtMtSWKs+LhrNaj72Z6JjB4hSRcGjck2JsLiXT0m++NPoJ8m53xoeHoFDi6Ap5p9hR/75DN2jgrGcq1F8k6bFHWmQWEj6bbre1+/RSFUWzqsvOJdAey1unFw38rNavniGCm0TjKfFaHGPHMzbdWdK0VMbiorUJaJXE1ktWOidot9ynNg2f7Za6ztkkgnzyn2rG5i5GF6aTo/09QguDZXPbIpCG/7/jGWsxuV1E3sSTS+3yNyxM23QzX19pw5fSjcR7qgxlr9QVyMOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGvLtbYvwljR4cXRI7/lrH2kssbsuUbd3YKiiAXYR50=;
 b=QkZiFoc3JZRp8kGdr2hTGvgWePYtKrhoZcpGtImcgNmEqDd6DerRfogsL4IAgauPx/smIxJPv7Dl09/xZCM2+tWDCx62q0a0iZtCbaoxtWp/2IzIDXq6NYf5DDnz+4FyyrRTmnDK0okZVt+rKQk0V56H7VrrX38aAch2zNo9T1Wvl+L/g5mbtDIrixdb3sf0DuBtUhElqH/wInTyryLkExI6grfjRvJOcwgjXEcHXaJmPGg8zRqkoR95eeV7WO1ziUpDvgGcEdNNO+w7zrv7Vk1sYyhs8hey9uT54KketIy/xVGql8KFW4D2OK9rH4qzWzoXsuORTmWpp8HtXnUYHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB8089.namprd11.prod.outlook.com (2603:10b6:8:17f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 23:13:36 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9365:d8e6:4e8d:8711%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 23:13:36 +0000
Date: Mon, 29 Apr 2024 18:13:31 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 04/13] libkmod: clear file->memory if map fails
Message-ID: <dqayzwd635hfjtxaiiy3ad76o3cs2kzyabh3j4ldfzn4lavslp@xpsnjpupu4l3>
References: <20240212-decompression-fixes-v1-0-06f92ad07985@gmail.com>
 <20240212-decompression-fixes-v1-4-06f92ad07985@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240212-decompression-fixes-v1-4-06f92ad07985@gmail.com>
X-ClientProxiedBy: MW4PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:303:b8::15) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM4PR11MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a089876-f713-49a6-8875-08dc68a1ff3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BHRWU8vDmldcMnGopKdQYOWDwSdYgpu4LpSQ4x98g6ZsS+QmSz+hdtU50odb?=
 =?us-ascii?Q?obPP2BUudyEFmo0Q7NpIreBSeyMJ4XsyvNVYlLh2aySasx+H7iDR9vOkOAmb?=
 =?us-ascii?Q?ppz2sXXqS42un85wGhRUx54JtjobJhZNFkBAt6OIX3/MyXsj9F5S2ie4DVEI?=
 =?us-ascii?Q?5MInR01QeHlAqqCPZ8i8aGVIleqqFUuytw6eMCI39af9jr3Usx/A79kx8kmU?=
 =?us-ascii?Q?lvdskcgfx/gKIkF6gY84NTxDoksCqts5ZQXsJmhI94gXSJLM10+ftzXIHMT5?=
 =?us-ascii?Q?cOUHj7mRu6vSVHTw0CiuffDRAvmWkl2PY6XWOYDH2kjUQVz//Ws2qsmpxdGE?=
 =?us-ascii?Q?wNP7CR/CttKkOhpeEd+jRB5G03DSQuhObR6Fc7ut/X+j8dA/NAhWbDcaV/BE?=
 =?us-ascii?Q?yyNg+GajRBs3hfHnq0TJVBAN7Ppvyod2wL2VhZALLHkp03lZkNgv6b4iT6re?=
 =?us-ascii?Q?od8wsXfsGAVJzZFkHKxkX4GLLZhixoyX2Jq3rP29mc/OSDllJDA2ODKvezrx?=
 =?us-ascii?Q?06b0ZaElFskJrB05xv+8s8Pu1M3QJW9Lh2kc3UmGHAzn5aJ1cmb/K9V37v5Q?=
 =?us-ascii?Q?U6uZX5KhjJz1f2cl12Jmbg5y2f3IM4vKZZ6/H0tPJl34+admh4cK43G/xOIO?=
 =?us-ascii?Q?02M6kGEKx7nACwGp5/VkhgyS96gg6afTbey9leMVtWnasFEJaBLya+979qZ/?=
 =?us-ascii?Q?KA1mOh07kvP3s2ugRBcBvoIz+6iZP6GO3luhYhNDh67o7CquOm75Ny9hV4QG?=
 =?us-ascii?Q?hAL8VFTs/Z7nw/FgcPV/k/cvMbft7mJ32tSSzez9sTs07Bg3mSg++cDFc2PB?=
 =?us-ascii?Q?T4tIHadtSSbwi4MBLYQkHjuw7pH47WSPwvfHIB6drjkWDjT6KvyPLDsteSeS?=
 =?us-ascii?Q?cRuDcbrftgPJTuzZmYGBgOS+u06qyFH5yT8EuIn+RHVeHecH13wO3ENSrIf0?=
 =?us-ascii?Q?S+l8C9J+lRdYF7YusadsN9uMBjCyXzvI9QUqMlOZCtH7LT6UgtfUQl+wreTS?=
 =?us-ascii?Q?X4MBLv3HPVqZU7u9KGbiZCIUXs1NExzw+5+GQyLi/vAPVwD0PLxW8lbk0KpS?=
 =?us-ascii?Q?qapm7F/PrL4oPUc1ifrzmSqq/ApaoQPONa9aDolw2k3pknU9epnQat5HheiZ?=
 =?us-ascii?Q?yc5gD28oys8n8Z5r67XRUWUwcb5gbzoCmf9hchzeWJ+hvc63qo10p+rSwIfj?=
 =?us-ascii?Q?0OfBzL8Vz+jRzbf2pyjE2JsNz3P0luMIeh5DE/KbSlM03YFsaHUXAvVEIUsO?=
 =?us-ascii?Q?yu0LBfw+ahcPKDvudc10FJAIQGOaPTlrXMGUDdbHkA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WujG9A2RMIkhh8JDvm8LpKYpxzqu2lF7L7SGB0EiVIXR40DX27BfXHQbUwcQ?=
 =?us-ascii?Q?kZ/GEGvkDrrhP2OuS6u3N9bnsoqhVBG2KPBS4Jqq8pT37xopX2bGw5d9izTj?=
 =?us-ascii?Q?Hm4Thw53drPMWKXb94OypqfXR+MTIPqfDeXTJvxliqPE1Hep1bKqF6vgBBhF?=
 =?us-ascii?Q?U3dM463vfraKdTDRkwYFEfZHnA8lRnt6A1b8JeHZPo+M/ZpbMhRlg33gwON4?=
 =?us-ascii?Q?XFAxLYyAsNoQzY8GSnyOb5F/f2Q30ve7TmHQmL72cff0pGvOXX5mR3k43W1q?=
 =?us-ascii?Q?93dJyoga3we3St9Q6K4l0CbFnZ15+/s0wm+tm1DIm5HLuVhxS1F8hfC5j7wh?=
 =?us-ascii?Q?CqSCxFa3w0cFwYzypma/9Efbeus1T5Cpwv6VQt7WOqAkIzkgLJ9e63P8pHcG?=
 =?us-ascii?Q?tJ3FfkYRuUuP0VDRCHV7ruBcQbBlQrnpv/VcMh5rScEWk+APHGVYn6tKB4ny?=
 =?us-ascii?Q?Sds9N6qgx7U6AoXUn1glU0Pw/t99bPd23g/wIhpbqv8qDE/h6DJZAkejuDgn?=
 =?us-ascii?Q?0MougtdCa5WiiJsu4zCvykoEBa89OSqZ6ag4b5nz9dqQMiOWC2hDdG8m+vmf?=
 =?us-ascii?Q?bzSEfrMpTkNVqDkATzpntgDeClvnwqTn/hU+MIJQYMj8/Ak2PXbHRGZFrkrB?=
 =?us-ascii?Q?cIKX2pzj1ybBXot6X6GMwdmkGt323r9GKlor9r0hXuP5gRUej7qvZpUUOFH6?=
 =?us-ascii?Q?zPZUuJ3gMl1T0NfPK+gzw/r/4Y+PX49NYFaBCeYOKTaPkyzGb/C1IirdrRwB?=
 =?us-ascii?Q?WjcL2aLz/FzQeOcPKt0Y4n2FDH/FvLV9VSjhBLeB2GRGN7sMQZqmBncRRewq?=
 =?us-ascii?Q?KQVwdubxSOqTXYXtqjY9VpqA+zdhebiohnIBqFK1RusQLALT8lIoEu5WPqbS?=
 =?us-ascii?Q?m6dUQRR/oW2IA7xFxXV5yuOwvGjqol9o18zZ+/ljFwTl6ww60h42+DxQS86T?=
 =?us-ascii?Q?7Ygdv2pslWC+Wr1bej5nas9nkxcA0AtucvTa28cLRJSixLqBx1ZQrhs3XxOK?=
 =?us-ascii?Q?GC2NrsaO/D4JAp7yh1q3+no8L8+fzihYSdidVWezCEo3SY47jQNSE+VKDvxX?=
 =?us-ascii?Q?8WGRB5iXPremzzfYPp+qt3io0bsMbly7SVGNigAKaDrTKS7YbMOt2GVkNR/J?=
 =?us-ascii?Q?Qbty0GhjqQhc/RpoNTo9nDzI/tNgz6Se7PF5JRuIiSfL5xUWiiglY+53Og8t?=
 =?us-ascii?Q?wDZe8EBGtYchxkXuelP1x7OoWMJPe6Myn6OxYCAZniIgwTItCYOhn+rnGSDb?=
 =?us-ascii?Q?UbbwVe76tjef+EgMRGIMJgd//bPQXSq9nM0eYERNHZ22pV2/P9XuQOFr7tCr?=
 =?us-ascii?Q?l4CPNFEuycaFTMGQhCIctykQv3p5D8ovPRLQRFjKHa2rgp91ppy6EI9hl/hz?=
 =?us-ascii?Q?RcjNjSbW9mmDkXQk7gGsaNxQx9/DcFMQAAG4gcXHv3QF1odWN1TtXEZB+HLf?=
 =?us-ascii?Q?VVGEyfIARikiv5FTvYdoYepHO8xxOvIT03KYfa/RnGiIs/iF9vwRQr5BiygJ?=
 =?us-ascii?Q?eSyJpfAztCXLLhlgwFNxyU5N+IrvEhzLa4UMSNzcJzrSqk7MIwJ9zIeFT5/Y?=
 =?us-ascii?Q?qctuP5x+Kxzfa+uFHCdY43qf11dWKTOHT4VHlJ4KUsLSdCDDW06w3+nC4Nz7?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a089876-f713-49a6-8875-08dc68a1ff3d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 23:13:36.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1+Fl81HzL6SV6OikFWf5D4zTIrstDGjG3UwRHJB2sm2gXiCllzabaN4+eOFt/6itgQEhzH2/fFuImsNseG4Q/ZA8iK+AvPRityVVCsqAgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8089
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 05:23:05PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>On mmap failure file->memory is set to -1, which we'll happily pass down
>to munmap later on.
>
>More importantly, since we do a NULL check in kmod_file_load_contents()
>we will exit the function without (re)attempting the load again.
>
>Since we ignore the return code for the load function(s), one can end up
>calling kmod_elf_get_memory() and feed that -1 into init_module.
>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

Lucas De Marchi

>---
> libkmod/libkmod-file.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
>index abd4723..b408aed 100644
>--- a/libkmod/libkmod-file.c
>+++ b/libkmod/libkmod-file.c
>@@ -392,8 +392,10 @@ static int load_reg(struct kmod_file *file)
> 	file->size = st.st_size;
> 	file->memory = mmap(NULL, file->size, PROT_READ, MAP_PRIVATE,
> 			    file->fd, 0);
>-	if (file->memory == MAP_FAILED)
>+	if (file->memory == MAP_FAILED) {
>+		file->memory = NULL;
> 		return -errno;
>+	}
>
> 	return 0;
> }
>
>-- 
>2.43.0
>
