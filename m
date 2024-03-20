Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D740863
	for <linux-modules@vger.kernel.org>; Wed, 20 Mar 2024 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943094; cv=fail; b=hqiKDoPwIfi+5wIhj9l6aY5rTHYtlbn7rGwP3oLJMEWnV4zQdJVRyjcMeUvShyDWGTb3NpU45BmA6lz2zci9OX9ITQlg1PX6XL2G7lEEHg1Rm02bLX82O1rEJqEC462LamrIK3sFvV6p7kXn61HXlSDmQD7Ez/Yw8yEG6jPGt54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943094; c=relaxed/simple;
	bh=M1ZGjFWrn8yD2hy6VcR1bDJLHIgQS7QKOJXJJdzOs+8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rYDaCGtP6JB9BKZoLrh7JyjvjdJgwoKaGwrvaV4oFIknEY3txqiTHsnTuiSV4BfgHQ4alw0T8L9CmAsTUIMnJlWT0G1ozmnUuFl5Id0a1/47o0J1yOsiTZM5tI1ezfonqBZe1BPfURUTOAh3ePE7WmGO007fqUHh9WA9Px+k4q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lH+Mpzcr; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lH+Mpzcr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710943093; x=1742479093;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=M1ZGjFWrn8yD2hy6VcR1bDJLHIgQS7QKOJXJJdzOs+8=;
  b=lH+Mpzcrz+3N2wWoVTao41PcdYApUzFQV3xrRVRY0EeVpVzeKjj/winA
   zP5UskfknqmKAthZ3/sreTeILRcte8mFA9EudL7kqnMia8/qrsyJhokEj
   p9LtW4o276/SEEDFBSe6PGB22knNXiVNEEUD3Dxs3fVI5SBSPyzhfyvoF
   do9gi2hD4qhk0NkztpDYKwnEvLwp7Xlm0mr1M+ttz5CRY0fWZjCzxYAQZ
   jwJaO0XcY+HsZrbdUIjgLV6lSqFKr+DcXCJTt8JXnOX/FMm21n6sJ8ijQ
   Ega1bjN6oJ4fePDA/cN+GFUMsN4fgAsTYNKfah3AjLUH0nztCeZhhHTwY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="9662720"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="9662720"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 06:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="51605173"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 06:58:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 06:58:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 06:58:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 06:58:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuwamUp9Y1LhDh23i1D3WYs0FebwPxtZiENFjT7d3dJXeSJeByy7PW2tCHJpJDTkC3hi1YOH+MCv6av3hLhg2h2iIPU9pXhD6ZShzkONB6+Grqq0oJd1BelUYWB5n3CftVXh5ArHMUNGCAsd9kYvCsxrvGjfEsLHpbVpnhw3AK83rRY4Ua3szuriYFCHP5fEj/v7Q55Havl2kKhywmATJg0ugztEkepGSkhygsvPWWJmXFNHr2DgA9w9hH0S3UWFQ71g2b46yWzd2EhFjWNnRIe8qe8YdN9fTDGv8eN+JDHg1DaTIGZkpqX9wJ1wp9585dAxigBx69ZWON2YHS3Jug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/m9CWNqfLU+BzqeDbvc6Rlq7W8RzLQlOawjegelrYE=;
 b=ZChWIWxUIT05y3wsCWlxRTd//1qwN5iH5jaqk+IH8cwBEZlnB/cTzR1BrAj17z0f0I87KLFVGXnLGI9f/CholDBUvswftssWvPf0jP0MvO41lW850q8EzUPHA36K7RTZH27Xha3LNThiBHEhpjgL+eCY5BN5Mn6Z2TLAq4+pcCOUoNnXrMzY0wmLm2S/jqjSqHTPwyPaAldyzGOeJr/rZcrspb0XbOqGXGR5FRRfE3Li/hy1045GaOBIg32ibZZZGtqIWuf61ahCoDqZP4tcGQJjz3xj/59nvxjU3C66qnZZy/ZrvJxMiYIeqGMaohtUyTY0gQCXBZp0mcZfDJxF9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 13:58:02 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257%4]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 13:58:01 +0000
Date: Wed, 20 Mar 2024 08:57:54 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: <emil.velikov@collabora.com>, <gustavo.sousa@intel.com>,
	<linux-modules@vger.kernel.org>, <mcgrof@kernel.org>, <md@linux.it>
Subject: Re: [PATCH kmod] libkmod: add user soft dependecies
Message-ID: <7vowjj4oo64a2vquvqaszmzcdvbrlkntcze2btnogvkwwtuddv@uz72wpi2t55s>
References: <wleo3wydlkqka5x276w6kl3g4jqii3ddpsjrp2cypmraxuyuc4@g6tn45owkssw>
 <20240320090559.8076-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320090559.8076-1-jtornosm@redhat.com>
X-ClientProxiedBy: SJ0PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:332::7) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CH3PR11MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4e3c33-279f-4a4e-fe79-08dc48e5c1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CT7CU8GAgvSOdWKgSc4JI5AQfAM9kwyuFl6zyzLtiPBgVPC2SvFr7xO+K5a0p2E4KzxYvQdQ9IWCrxDPLLMVJY78CwZxHA+0D8x/iI9iUQxh1ylByArD/BfKSj7RTEX1c2Zt+gvq81RiIEcxNoJFXfc64IFcVBFHjwL2jZswYLY8TU1yDLJBTvgp1UqxEsa4JWTBRh5veUorMldxzhFxGYvFPl1MbpAk63yOEwERm+/O8P7L91TdHFpJMI75zDXyPGzSDpmXpja9YzfDQvAIlf/19eV3idvvpXDpqU1MGfHxwmScGJ8ni1B7S/E3/4ek4C8wJp3aShsJYIKbVaYrBpH4CR7T31eWb7DXYssDPYo5QVOM6196FUHMFAEBwzHUHy47Ih7IlNY0s2tnQdqtnAyZr6uVRHk+6dLvN5NHnV6wGhpsiUIUMBlQqGwxwtCK6gLkL9IQVr8S/43bTFOaEuR5nl1japT4dZohcjKgoadovspXIgEqH//ZJ61S5OVMQ/Gq/OhCB1Jbh70eOQROQSvbP9jp8mFmUcZHo+tZIpZf2V0/AeGrwL07yxegdaZ9mE0UejiVdvW5HZBtb4gsqdIhJojQ8/Id/nf7Vzi8ODQ7M2j0FNdR7bkZJYH7XhWJejxYE7bjqHucy2Ull9Zt1lML2V1Nf8DKWK0ktAhazns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bN+wxtMhTJi73zShA0/yLJBUhGzjKdaOUcIn2pmsxtqliP4/jNTW38Qsx6?=
 =?iso-8859-1?Q?OAs88hMX2Vb/TgbsSjcKpOQ68fg7MUEXcuAsi1fXoPeQ7yrLCWT4nIC7kh?=
 =?iso-8859-1?Q?BGAwy0N7UAnSPmkhjZxOcf4E3dSPJ3GcuG+hLeFunSEjz9zIhN17W2k4Yp?=
 =?iso-8859-1?Q?vB++Ayu1DfDquUm67a/gWCre+mjpOW5Ji8eCtYJhhjPogfQbqGqcewesTB?=
 =?iso-8859-1?Q?qTBv1AkB26bFbF6yxY/rQDwbHpq3ovvelkoHk9XauBDAqk1Fc2odeTVPnU?=
 =?iso-8859-1?Q?RoZzZFk6EgBKIOZBagTls7W1dvT5gvGgcDz2tfkyPGNOZDArzcCMQ/x306?=
 =?iso-8859-1?Q?wd+UZfREmQmAwXsF9z8WPt+XSjoR0ZAPqwGhBJH0aEIVh0010J1FdlFq86?=
 =?iso-8859-1?Q?cgsTOhAlKx6W0WItOY/pJ+EBV2s9+nVwBC9LAQRqWOlSWS4mWRa8PliSg7?=
 =?iso-8859-1?Q?hCfKYB0WK4839QQP/1EznfAb/V2efC+fyg3+IB4XGVeP476kjfYvHEtpN4?=
 =?iso-8859-1?Q?RCpRjqXV5eHGwxadeHsy+wjJMrpf7vqMp4KuJcCE01MSozJUEiubpJZt0f?=
 =?iso-8859-1?Q?cGXa/XrdEwx9AZwkB/7bQB7Kl7U4ljQqMN2BOP5ASpUjIkaUHAwGZuUH5l?=
 =?iso-8859-1?Q?pga0l91nSMF5ussay8dcryhROqhGiAPU1dgjPEJAua7lRba8CfqW99ntqS?=
 =?iso-8859-1?Q?uLxjaxgUhlGOtW7s2u0dh8HCjgOXwq5aC+wT3WZD1SxiJrokClccRB4vdT?=
 =?iso-8859-1?Q?zH/8lNOFyU3BW3dO3RcJwWEmwTd3Wl6EG7npV2ICwMPTarLytreXQPky5+?=
 =?iso-8859-1?Q?wQ14z0C9n33CF3X9oFLCvEGYXuckaNnlTIZLhOorcBYNK6Tsr1ldRp+ep3?=
 =?iso-8859-1?Q?Oe/yUCrxYkdwU6s1/I4yybpG3/DxiB01RONWXJgbhFyLaBIDFMYr/REN0k?=
 =?iso-8859-1?Q?Zn7q1CkVpnFMBblZ5O2DJI/IXR17lPYse4Y5PrQO4hu2Tbd35HwBCyMyKB?=
 =?iso-8859-1?Q?LSl51UrhdoOZclmwY6V8nSXCNDQXwXE/kPJO1+3fo/5Rh4X/t97JEXyMfR?=
 =?iso-8859-1?Q?hhdMf7rSxArn2VFxeD+DBDor46HeD9BzskXSg4eNzPX//vig1gQPn2LOkb?=
 =?iso-8859-1?Q?xgSlSB1Ur2zKXQDczHestjDGSEN3uucg53g3PWfPvSbtPgqAh+hz0e5mm1?=
 =?iso-8859-1?Q?QdSkh08peMkskwaXJYkPVhxpUIr/kXZRS8DKcwJweRbu2tVQ6p5dwOS0kT?=
 =?iso-8859-1?Q?ZX75dxbLFI6w0uUTAxoL1oKdIOXhUmiqlPWVfUwIlfhJjidtPXCL5EPacP?=
 =?iso-8859-1?Q?xbAz8NdaAn5skPkbdECNgNWcbinRZ/6bcEGRvjZSRI+vbuq4Gip+j6icQR?=
 =?iso-8859-1?Q?/RLA5VNRFi1toAuWjeQIxIanSCBppTIQxAAUEjfRoDvSRyorOgywtJZttD?=
 =?iso-8859-1?Q?6S3ObQ9vuveYRAcW/PH4S56uIxR6iRHCiKYQ+Ahbg/Qh3BX7ssgqcuqr5h?=
 =?iso-8859-1?Q?CzgU4QdCKc8vv7QuHbvI1bwbJ31Cuo92J1a3sb0X6+HYbOP0ueM4FxiVw6?=
 =?iso-8859-1?Q?rkC663dHr6tNbhKCF5vfGvgCTAmqKau+A1oG8VhvQFBGJDbLTouFYL8zQs?=
 =?iso-8859-1?Q?4JCSrdTLUBa6MtN4Pv70jFMc+5WU2fkMg60dbhwxKuUibNIyVHhXHIGg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4e3c33-279f-4a4e-fe79-08dc48e5c1d4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 13:58:01.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqkhfbNtYZMT/DB5JbKLku8XH1NSf5E2d92TOEJiN4FsU3ksj67roa4EXBlryLOhSr5aqok+qwvTeFN0Qzmgn5Jy2oBQbzjdLE1H8wpsVDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
X-OriginatorOrg: intel.com

On Wed, Mar 20, 2024 at 10:05:56AM +0100, Jose Ignacio Tornos Martinez wrote:
>> so it's basically a pre softdep, but without libkmod (userspace) trying
>> to load it before the module requested. So, it's "softer than soft" or
>> even "something before pre".
>>
>> Thinking this way I find the name chosen odd, as the *user*space side of
>> module loading will actually *not* look into those deps.
>>
>> Cc'ing some more people for suggestions, as I only know I don't like
>> "user", but my suggestions may considered equally bad too:
>>
>>        dull / still / early / runtime_request / maybe
>Ok, I thought of "user" because it was only going to be used by user
>applications but it could have other interpretations.
>Maybe another idea: "internal" to inform that there are dependencies and
>these are going to be solved internally?

a night of sleep and I had a dream in which libkmod had the concept of
"weak dependency". Borrowing the concept from weak symbols, I think it
makes perfect sense... the symbol is there and it may or may not be used
by the linker at the end, but the symbol needs to be there until the
linking phase. At least the parallel makes sense in my head :)

Also, I don't think we should mix them with softdep like is done here
after a quick scan through the patch.

 From man page:

        softdep modulename pre: modules... post: modules...
	   The softdep command allows you to specify soft, or optional,
	   module dependencies.  modulename can be used without these
	   optional modules installed, but usually with some features
	   missing. For example, a driver for a storage HBA might
	   require another module be loaded in order to use management
	   features.

	   pre-deps and post-deps modules are lists of names and/or
	   aliases of other modules that modprobe will attempt to
	   install (or remove) in order before and after the main module
	   given in the modulename argument.

	   Example: Assume "softdep c pre: a b post: d e" is provided in
	   the configuration. Running "modprobe c" is now equivalent to
	   "modprobe a b c d e" without the softdep. Flags such as
	   --use-blacklist are applied to all the specified modules,
	   while module parameters only apply to module c.

	   Note: if there are install or remove commands with the same
	   modulename argument, softdep takes precedence.

	weakdep modulename modules...
	   The weakdep command allows you to specify weak module
	   dependecies. Those are similar to pre softdep, with the
	   difference that userspace doesn't attempt to load that
	   dependency before the specified module. Instead the kernel
	   may request one or multiple of them during module probe,
	   depending on the hardware it's binding to. The purpose of
	   weak module is to allow a driver to specify that a certain
	   dependency may be needed, so it should be present in the
	   filesystem (e.g. in initramfs) when that module is probed.

	   Example: Assume "weakdep c a b". A program creating an
	   initramfs knows it should add a, b, and c to the filesystem
	   since a and b may be required/desired at runtime. When c is
	   loaded and is being probed, it may issue calls to
	   request_module() causing a or b to also be loaded.

Also instead of delegating this to the distros, it'd be good if we start
adding those to the ELF section of the modules with

	MODULE_WEAKDEP("...");

... to be defined in the kernel in a similar way that MODULE_SOFTDEP()
is.

>
>> Anyway, we will need to explain exactly what this is about in
>> modprobe.d(5).
>Ok, I will complete it when the dependency name is decided.
>
>> Other than the use case of creating a initramfs and not
>> missing any module, I don't think there would be any, right?
>Yes, my purpose is only that, I don't have detected any other case.


thanks
Lucas De Marchi

>
>Thanks
>
>Best regards
>José Ignacio
>
