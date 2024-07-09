Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D4412DDAE
	for <linux-modules@vger.kernel.org>; Tue,  9 Jul 2024 05:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720501902; cv=fail; b=O/V8SQZ+DGJ4l0KC5KdU3zWZtfxCGYDecZkw4t1B5JE+iwXjV/0jLeBVEU0YZb7IjQTGlrTdIHjsJt+srN7mhUZCABw/ZgWzifKFY9qNyZFmLkZhPSBVSGKJXXp0A5WosV7ijY3VI5X1YoVcUDbWXXNS1aV3j99VgiTl55o5NKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720501902; c=relaxed/simple;
	bh=7CtZrSRQbEGuIh1CfzOeM+Bao2/pBbyFKVr6U6KaflM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rz4BdP9qIaVIFNBmL4hoeJN44pfFlEZPBytp8l8EYhra7avQBI7TqcdmFNwGNoANFHhuBsHH0dyecq674TV/VixMvRonaFyKoWSY3b11HO9q4v7ApQUEiBu40GIgBSGi4rG7XR3Ts+HMf7pVxeYh0qclaAyHgbyzJvbp2f3WrAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UivOotdB; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UivOotdB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720501901; x=1752037901;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7CtZrSRQbEGuIh1CfzOeM+Bao2/pBbyFKVr6U6KaflM=;
  b=UivOotdBNzOF6Q/Kg2TV8/Xp3MIM++Ihqp+wqFFNk7+sHh3hVJScecTE
   QGJ6JFqekhle0dmR4c8XqfwdPO0uiR/Ukj5KuJm+SKI/gjAYkiLSLe0cM
   utE5NJBkYJgIHZ4UQ3yAd977goD5zLxjSOcYbNpG7SWvytyUF51YHOjcb
   WttV1qJWfwbNDpxALx/Mn/6JD6FJ8DtpThjBHhuqJs76BQMHfdw8sq2hU
   uoEuOoD3NhDUkULAPFWAgtGGcPWC9QB4dU8DjU6NxcfA5ntX0pDabkWCE
   t4DQnUJdLQEpBTXjoEtiROUzPKUiRl5Cj5cSKwU9RRZKL7eTWOcnzkuns
   w==;
X-CSE-ConnectionGUID: OVCHgGeITk6pKW8Kb4RsKQ==
X-CSE-MsgGUID: W6nkTm+lRbON3a3YA3xlZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="28336609"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="28336609"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 22:11:40 -0700
X-CSE-ConnectionGUID: RAaGy3FXTOGv1kEWKZY4kg==
X-CSE-MsgGUID: J2Xq3x0RQoCeT0XSvZyNTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="47814601"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 22:11:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 22:11:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 22:11:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 22:11:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+tCrnNSEmVrC4ST5BpwhELQ3FcGXM6qQU6/MD7OG5W7ruvbuVikn8mYpWxu+rnPtQtUHenagmqpvG6jLLgyfpwzTOPj8oJfq49jVRCCRm8puNXxIy1FGPKeclNf1eL+NCznTRUlEZ3upOHzh0e2W1BNLu043fvic+N7ojJVZCRVprU5OX9qhi7Egumx03WvqIRtsgrOCVZAZKn/Jv2iyMiyNCTq/pkuc9itunBZFpCx9F5BdAu9US+B9nXA9+3s4Ds7WuwLggzASiG8WLN6H1NdpHm3LcmYLzM95e41MaqrY2gfc43/YqadCRR+blPFlHKBJ1dNBcEdGNqvnVoAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfKcH/d3wdTtb2eH88PBZsZ6v0nzzWT0O04hZFe8SYY=;
 b=PzW368i9jKXGb5F2vn4a9QLSLGYhe1Bg9dHTxNCZS0BFlgJmRxvA7AHoa4ZIWxDta//k353YCZyj+ClEzA/Ql6FxjsyWXeSbbZmWnSFp1KFTtEuOAfUkgrUmXkcEDFOo3ukM4pOYwBP0Tg5D/MLdLN8li+RHSIDisi2zpyGPmJDtmU44i7bIIylEG1IVSHz7zPWZy446AH9DsZqsRJA4DQeAsDlgNH6izSvHFOCuw52mU26Tdr4bkDkxrzdyUrJDMqElV7vVw5syDJgzyGWjUHUjAdnQlYr3/JAO/2DRBcKSbkqDdFPn+CuAex4c9BTHDt6im3sTFHFxPGnlMEkjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB6930.namprd11.prod.outlook.com (2603:10b6:510:205::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 05:11:32 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 05:11:31 +0000
Date: Tue, 9 Jul 2024 00:11:30 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Emil Velikov <emil.l.velikov@gmail.com>
CC: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	<linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod] testsuite: add tests for weak dependencies
Message-ID: <lozgnoo3vnuzuezii2pdhxzoy5efmxtlwivugoze4hxr2bechc@mr6kegfejniw>
References: <20240530070836.9438-1-jtornosm@redhat.com>
 <Zov-e-a_KQyJb8LI@arch-x395>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <Zov-e-a_KQyJb8LI@arch-x395>
X-ClientProxiedBy: MW4PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:303:8f::19) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: e5628400-0f64-4be5-e9ff-08dc9fd59890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AfO7KFx6orZI6VBBYD3RoMWmYYrhxKTtrHGuMseGUhHC7fzukPJdwjH6TmJG?=
 =?us-ascii?Q?IpxfOpNc5Ph9JU6Y9AymhsiSfiQNVoCSBe6KZPpwlaAgnIxX+Kw2EBBmuWDo?=
 =?us-ascii?Q?Gb4V9SroF2jlUCvTqXhvJzQtiMc3r5tGDZDQ92PcQyVlA1Hkl+r7AWfkUZHc?=
 =?us-ascii?Q?4taIGY5Jns7uUxvBXD5QpWOzlUSOlxYSXtusmDbrKkBmPRC9ECei18NlR84y?=
 =?us-ascii?Q?8GwFLoNgx2VY6dD3U3iMb3U7M0D1q2gm4fyGHDHc8k7ATI4IgjlKXY6UPg+Q?=
 =?us-ascii?Q?nXyyp5HYXZwywR9g3FJfZR5UmlNRcM1txPTrsrXpvt6YjwcykZVN61JTKyQ2?=
 =?us-ascii?Q?XJYIfR2fU+sXtHO4WisXI/elxu+usUfOkhpl5UuYHo1GULn1kueqLLIlmgfH?=
 =?us-ascii?Q?6B6hv1KI4mqPO2MxtqU9YBQXkwWuOF3uTVOvGIjfw8xAZRgDpJ1j4aJXId/v?=
 =?us-ascii?Q?PIzAACsWT35nB5XiotJFcvYSDJk6r7+9VilxJ3BDdvJ9jxvveIm4IHMrn8yC?=
 =?us-ascii?Q?RAEI3Nb/wszTPDw6OTVLc+UruTomBuK034ijLx4b6F1r3Lcg+WQxWdirbLJl?=
 =?us-ascii?Q?tJL4fZl0ShkhB8GBIFGJO/Zk1vnGxHiJ/6B7RZews3PqhBiPXiLZ2zcSjJvz?=
 =?us-ascii?Q?PA/+fPA5TQPxZIMxMZ/7tBFPTjJ//6zlmtq+4gWcEmMKTIJNn3IN7A7MvGzQ?=
 =?us-ascii?Q?qLPOSwn/n2vGuhQRibTy2n/QwjQy7RvBPaIQOcEPc9lSS8FAif6qKmcYzNrN?=
 =?us-ascii?Q?6tDav8YKOT7Um4h4Mnqo/5zB4Dt4+OwBOtrAZbTaB5HS2FUqlvvt47P7PUHN?=
 =?us-ascii?Q?S1IbI3vckOSz/tdk65G7vPmUd1hH8gHQ7axXAhehJqN6GgMhTLEqVXdeCyQL?=
 =?us-ascii?Q?hCvGw7FR19642vTwVQ4iTQzox+8gp/RhQ9Hx84ZmNyDRvqHzAx2MDKbZcGlm?=
 =?us-ascii?Q?nFxkCtXNHBMl/KGD1mJUwtj4ZVTVHLSsHUwVmDhlRi08nekCIFpPqdyO4Tdv?=
 =?us-ascii?Q?pegsmLUwMjpBl5SiDR1pDUJgC5AGBu/10YajtemJFRhORqRycZjYBaoVnVOx?=
 =?us-ascii?Q?8lLfkqUdOR9gTHvGWgQbZgkbJnZVnwXcfC9TAhKt6i6Ih9CNtKeKm/OyHwOV?=
 =?us-ascii?Q?0ml9yFlHH3VNlbjisba82j13wYGZBjv3n1JHue8al+3um7MafDrGHqcnlxf1?=
 =?us-ascii?Q?j+fIgBqma4Li9yNmLSa8ut1L5gXqFC0sfmL9vlsieOuqlTIjbJ9YsFdcK4h+?=
 =?us-ascii?Q?QMztplmU3aAy5iCGrLa6qocSUqgc09+0ZQlNtWBSXh0RenOsTZb4NOE06Dl2?=
 =?us-ascii?Q?HDE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eb4FVrl4igZZWZ5A2EvpR7fTJd1kSupn/PQrxqz2RULlyqMAR33iD+IYi3uw?=
 =?us-ascii?Q?1kYr2LEL4J/Y2ImAB02u3KjgNtK91Kgtf/MqJYYCvgMXNzi/9UtBM7cuaA3N?=
 =?us-ascii?Q?WYZqt6RnbLCzbVPB+2EXGxJQrZ5NCHq2pQJ+RAy2/rPVPOU9kiJfGEhR+YoX?=
 =?us-ascii?Q?Qxy3QuaShe4QUXIendyNF4lp0twGtxdfpPxRA8gVpOXkgDAEsvjuXnIzxBY7?=
 =?us-ascii?Q?bQdN23MWBLfdmSkgTB0i60FQyScgFLTyi+KfOkVNxHJPnazx36LtmeEKFmDC?=
 =?us-ascii?Q?eFJIB/+8z8D8JQeee4CVEfPyn0yFzJc9bgcWsK/sqwd9QA7ddM9Ld/wPGs25?=
 =?us-ascii?Q?TNJao+NGIdF9qTFHx6XqzuqLY79qY8kg1i5s1ntFGN3/2DUH5dwM8orozcQu?=
 =?us-ascii?Q?vt13X5LWvth7sOx9+TwnqFs6vS/4Z06Gu8Q+1xrEWk6KZiYEGLlclNtNH7OE?=
 =?us-ascii?Q?wWJ97REBnxbEmEU9Z1pvIiIuVH5mUUzaHNxaMchaQDkM8tYyYPhNPpygTvzg?=
 =?us-ascii?Q?/4PNB/cKPNKBqq4UV1KLtzj0bUn+W23WOJdltJoEtMvaAJ+f/MiLA95wfkxK?=
 =?us-ascii?Q?DeyP6evsvYPQ0sF4WdaY1llPyj+5bsUrMpvbS9komfn9SnIPS49dtX/GbhPM?=
 =?us-ascii?Q?QBXhgkHxiN467XMEA5KYpRudfyoQeFbbswb8K5ZBBYwWXU8/ZYhdkuKxdRdo?=
 =?us-ascii?Q?gf0ZyqyfeysTg2Neg4cJR1PoPennqCxJo5OtX1zLJzQvJhgGqKjZwo1yBA9w?=
 =?us-ascii?Q?8XXyxEpOc0XLWEsFwt7YIgiOg9YBMbflYUG3SC4SZ81yrUs37Ni7AaUT1+Ba?=
 =?us-ascii?Q?d6gGQV9IMca1EeGW2dZswsve5k5lu0prAOV/a5oTN6DB9vik7sFgCX4/WoeO?=
 =?us-ascii?Q?RsnRIwlIcF+ucgav7xkN+LQIKli80YzGaAbjleKehtMBuJ7rJHhrtRXF2i68?=
 =?us-ascii?Q?Ek7xxtUazvkprv9pDF3rQPlFFjs0+JGCT5spL4ZtMct3EdYqNXIXyjAkCRfF?=
 =?us-ascii?Q?dxeJl+IDe1xwtybivCgVZFobBPMTWXqlrkWPsmBWE8lMKbhFr9ym5/3rol97?=
 =?us-ascii?Q?cSgTxaCEOxsSNzP4icIHFOB97exfg8alU8Dt9DWXMOGYbdCH4q6DxZA1yqEy?=
 =?us-ascii?Q?z2F3P6GR1bTBLjAGPLq5n5Rv3FuIeAJUPkxXKxzMdAsv101D5lbjRFZdzz9x?=
 =?us-ascii?Q?/K+IT6qD0DM4CxHpNfoWDvZVH6BgRJOGeQptU1CSL3g9sKVMHJDwGyxWI4Zi?=
 =?us-ascii?Q?8vJseTRVVo8ZhnyGhtoTA9Wns8iQLLo29jg6q3Vmo8YnKmefpO7YQyV5Cz9F?=
 =?us-ascii?Q?7OFGVXPZ8OXq81v/yUoi+h7yjNa5HnM5hUytSXNQU/avaVafbjkqKTZKIT3p?=
 =?us-ascii?Q?4KvAv5ru+T1Ua014SALvv92txx3gARv2sh3uAbK6J7+rWNvdvgXzwGy59nL2?=
 =?us-ascii?Q?hHlDMCv4mJ6PH6iXy49WnWPDlrDA/Ugp4zUrRWAtgBEwbJ3XrFSujYKnVH9z?=
 =?us-ascii?Q?BKx7qNnC1aLU+3b8UKtqTL/UoQF8Tv5hCV7vMoXB2LhwtktQLBrWZ9ibBWth?=
 =?us-ascii?Q?yDrUFgH/ORpB0Sxdm203DaQMm4D5lwkqKWG92MwpGaqjiSexmquJRjf/eFvK?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5628400-0f64-4be5-e9ff-08dc9fd59890
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 05:11:31.7511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7JvuTzSRVAl0MtUrTP5hNDzKyQHXY5kLMoX7Pqtv74jQhtTV8WTJwGfRkIubPDkyXP1tHAg09/cg2j/mWk8hzWiRQRONSHdWLkXewhFFU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6930
X-OriginatorOrg: intel.com

On Mon, Jul 08, 2024 at 03:58:03PM GMT, Emil Velikov wrote:
>Hello Jose,
>
>On 2024/05/30, Jose Ignacio Tornos Martinez wrote:
>> The following tests to verify weak dependencies have been implemented:
>> 1) modprobe test to check that related weakdep modules are not loaded
>>    due to being a weakdep.
>> 2) depmod test to check weakdep output.
>> 3) user test to check that configuration files with weakdep are parsed
>>    correctly and related weakdep modules can be read correctly from user
>>    applications.
>>
>> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
>> ---
>
>Seems like this commit has regressed make distcheck on my end. Namely
>I'm running the following commands:
>
>git clone ...
>cd kmod
>git clean -fxd
>./autogen.sh c
>make distcheck
>
>Result in:
>
>...
>make[5]: *** No rule to make target '.../kmod-32/_build/sub/testsuite/module-playground/mod-weakdep.o', needed by '.../kmod-32/_build/sub/testsuite/module-playground/mod-weakdep.mod'.  Stop.
>make[4]: *** [Makefile:1903: .../kmod-32/_build/sub/testsuite/module-playground] Error 2

I added a fix in
https://lore.kernel.org/linux-modules/20240709044758.67725-1-lucas.de.marchi@gmail.com/T/#t

and also sketched the new CI hooks using github.

>
>
>Can you reproduce it on your end?
>
>
>While in the area, a couple of question if I may:
>
>- Should we move the new weakdeps API in libkmod/libkmod.sym near the
>  end in a separate LIBKMOD_XX section?

yes

>
>As-is, it looks like we're adding symbols to what should be a frozen set
>(aka LIBKMOD_5, which was released decade+ ago).
>
>Admittedly there was a similar erroneous(?) change not loo long ago -
>9becaae ("libkmod: Add lookup from module name").

yes, my bad

>
>@Lucas can/should we fix the kmod_module_new_from_name_lookup symbol in
>the version script?

yes and this should be something for distros to backport.

>
>
>- Is this work related to the weak-modules used in RHEL/Fedora [1]?
>  Alternatively, would the RedHat team consider having the weak-modules
>  solution in upstream kmod?
>
>... assuming Lucas is OK with the idea. I'm approaching with with my

I was not familiar with that weak-modules and will wait for Jose to
clarify.

thanks
Lucas De Marchi

>dkms co-maintainer hat on, where the fewer "if distro == X" logic we
>have the better.
>
>Thanks in advance,
>Emil
>
>[1] https://src.fedoraproject.org/rpms/kmod/blob/rawhide/f/weak-modules
