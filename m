Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B10713472F
	for <linux-modules@vger.kernel.org>; Tue,  6 Feb 2024 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236147; cv=fail; b=p6eoG+aUkV8W0RQBgAdrnkLR9rtaOyJbhGiMIhNfans7C2MouqA/QXEkZQKhtV4WN+CRkAA4mG2tuIscZY/cCZ/o1wMgd0ypz/XSq7Otz60KQ7nUBOKfxXWnIFuumYyPtnDyQo2nTLai4cxgo4QhhFP78ma/VQ6dhd3eEAWaqxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236147; c=relaxed/simple;
	bh=sodMMls16/QPxdevFXi7a3MMIMLR8Q46ceYuPT4oJdU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CV3V+l97tY5LNKuB7934Hw19zLQGvqm7QMpbSUsV1Sw/0rzAo73zB+bxrwPoDNiZOSV3y2mu+BLrsl9u9qEhCU0HHEPBtvEUkzjAk1t8YlnpJwtOUezkZrKOs9IeOMnVGoYeKGMENQ4qNb1b0h8qQ2v4sngGZjWTNZxPodEqjso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IxxzdEpQ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxxzdEpQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707236146; x=1738772146;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sodMMls16/QPxdevFXi7a3MMIMLR8Q46ceYuPT4oJdU=;
  b=IxxzdEpQ1uGTKVUDWpQ8peXqgAiisFYoEZTqXodyOpiUy8Dq1z8hEYEN
   NVLIYm7riAHhWTg7Q10aTMSt50iA9d6/MU9bA/s+4lHr5GBOX9Oj5hBnl
   sVyEnc6gH5Q88Ey0plaWIt3ImPxgOxhKr0qJKpoz37SjLgCSACf1+2as1
   moIVgdRE3S/e4E3nT35x2MjjM+RG6cfT1u/vJWFT7k2nYw9LPMj87cFaP
   quqRhRxIBdXyWVP40KG/4Xop9Hh2Z5UGH6t55DEslhAOmtOK4N478YvpD
   sPr6fUnr9es+52WjzY3IiV+BNLj8Tfjyy9teeEQFI9OKHdok5SFZ+KyUF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="930396"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="930396"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:15:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="5674286"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 08:15:35 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 08:15:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 08:15:34 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 08:15:32 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 08:15:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAYoqi1XnOpCZJPhiQNTks7eCm7JENdYSt1+Q628ienE9dRHb4UiIafUv5zAdENH+xUgLEeIWgs5sxFxh69wbBiH6XntDvoDnDR0aPrQeGEbB48p/suZRxuxNVxJq+cpKiq7Mpnkf2Q8IQOWxKRnMOfw9rRh+wVt5CtkqkCjeCVUNpDeSzNYmlQGe88+wFgLA1awAbFyVnP7fgerCxqrBBbVvskgja7M4PXYZEs5sQcWGfOP/EmrjhOxeo7XV18yPykE//JA4BLBWwyJEfZV5giLPIlbjFOhTollUurVzlVYlpPjOxpUGa8OtYvbXfISzxR3OXu+yALn0RO6B28hRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUPQBOv6eXTzNiVIE6YOUM2gB4wdTaPMAkCdE8nDt40=;
 b=hDRNKmHRn3QsSsxfDAq558GnBIb6YTKhHBI78mShKWreUWs0yTE1N9UTl+nVy+bN01s/40gQICZocOMuYzZPAzvaofdet9IdTmN1te9vH3u0goQ4uuiw/qsqt0hLURaF7KhhAek1J2gLk8C32upIMyFJxo/fPoyILtD70W8nAEjMmVLxrDZqsh7VYe1nrYCplEGhPSHQfJYV048Wh7583dudn01ZDXp9Aun5mb5YIL5LWUGcYLpeYwzYOof1Ip4dvXsH1wLd+tVOYzBB+ux6oJzGHIFyODWacDARzvTPOSTzzNQwaP1F8ZZD7WBGpg9Hgv07HSsvNGEVBarB8qcXSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA0PR11MB7912.namprd11.prod.outlook.com (2603:10b6:208:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 16:15:29 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 16:15:29 +0000
Date: Tue, 6 Feb 2024 10:15:27 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Emil Velikov <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>, Emil Velikov <emil.velikov@collabora.com>
Subject: Re: Re: Re: [PATCH 2/2] make: install/uninstall tools symlinks to
 kmod
Message-ID: <4on5pkpsatbpp75qocejyrgxg5dzccu5sm43tmujccd2wd4cr7@2lercurz46f5>
References: <20240126-master-v1-0-6257d039a30a@gmail.com>
 <20240126-master-v1-2-6257d039a30a@gmail.com>
 <zeoywwedo4muolir5ietylb6xm2wu66wai77h6rvy2hkmu3u2f@f26b5cb3s6lf>
 <CACvgo51R=2WTcLma1wPSaDMu4QFtgezhGUKXf9k66Zg=6ZZ3=A@mail.gmail.com>
 <72ijqdtswcehmfjgodgg6chauou4vjkyh6ieup7osrcxbfwvua@arh6o2k2yddl>
 <CACvgo50Y1=-+SxLMsHy-Nc66wt1=S7iwjthRU-UVeS_N7o-EGQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <CACvgo50Y1=-+SxLMsHy-Nc66wt1=S7iwjthRU-UVeS_N7o-EGQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:a03:331::21) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA0PR11MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 68df18f6-509e-40e6-8722-08dc272ed622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eShQV316TIMv2WplEe1vrsCDvfdgN2s9zqnfoqsnF9PekadMQAmqRsMXTFCZQglHh5j5b3W+HQx9Qb35bdvDweC6CbVnepoD583eSiToKi5zN0bjYwadwAuwSB3O4ljnet+Ig7hef8MUP9YmIhihiuxKOu6cxhrY620WyUBmJZW5HgghcOZD/Vu3FRjGwYsgDBSzo6wTS59J7bSHSgO6g7lK+uNZwLk9RRLGXWLL/ZSKcyuXKlOyPNpx23yju8O5sd0l4KQDB0EEVSsrUU7l7An9B134JU9WjL5RPpN3ZwHYA0hHhCFZg0N/u33+XwvYdEsv6cK5pY40bLgyt8Vl42jR5GJlQ4t6OufnB+sVVSPKDrYrklCAozmPXekAY4S4jl/WjxkHywUGPIEkBqsYWed5VnLH9nMChn3KUoy9mfkiYsxkHECYrRLfCKvH7TN5d2/YLtQjN/J9XdexKH0fIPMuPoof0/pTM0+LswBm/zQx0zR30MwCXy2CgPKZRPsh0fOkZzSjXSeQkH1TiGSz+0ogsi2cXY1ETQw6fM86RdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(33716001)(41300700001)(86362001)(8936002)(8676002)(4326008)(5660300002)(6486002)(478600001)(966005)(9686003)(6506007)(6512007)(26005)(316002)(66946007)(66476007)(6916009)(66556008)(2906002)(38100700002)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5/iIaZ199FxCYs6m1muCVmTEy2XEipO+Zf0S+eZZimEQ9T2XzCnap4aHFBBZ?=
 =?us-ascii?Q?vBjCCZvHt5rrlOVxdahgyWw+OpI+IlJ1VayREqr1YFDEQj24YltDQrsRjyq/?=
 =?us-ascii?Q?95bGEQpYYMkCgEDq8yNPxZKDLrlsfSzB49JR4Cnev5fR1gUnpRMu6h9LhZwR?=
 =?us-ascii?Q?oGgLU+TeCBJ9TMIJz0I49YiqElforZnyeHa+LTa7jk85ja/rStAxsrPWIbMl?=
 =?us-ascii?Q?CuUE+jAz52GJfkCpKFT9A+OFPgCY9zcTUhrw0dtmCxGhf0FVVEffgYvcJ+Jr?=
 =?us-ascii?Q?4/nqvjucwdLqmF2IQ5riOP/uw7WmlNz9HELG/RmTXts57EyqpVeGnTytvRbD?=
 =?us-ascii?Q?2YUSzlGBolm2Fw5Juo0dE9/ne5fJWLEGxzLdHXTb4PCUYaefNd5xSygnGhgy?=
 =?us-ascii?Q?bzSe0UKYKwjUi97CiyJtjuyxIr3JdmpCHvTKVIIKqXw1SIKbQ6MhroO0dvu4?=
 =?us-ascii?Q?Fg0UxpSndZzfLAQWGbi3SU1FZOXcmfr06Hq0pZ85QiLQpYIF7j9aMMsKBs5Q?=
 =?us-ascii?Q?5aiMkMnlcf8I4hVkyDs0BetN6T7vLe/wo9koHzjZvaDTZVyfI8uy5pke8BvF?=
 =?us-ascii?Q?Avw/w4EUXrGLR5YnCE8rMPIRV8mp0QlSDBrsckJFpm4Mu70ksa6Me+Y0/LTw?=
 =?us-ascii?Q?f0C8OyvW9CdS7LRm5afRsbw3Fxcgemaq85DnbvQSef/laKLjUN0tKEkrhyWo?=
 =?us-ascii?Q?8Ijbi1xrAodF070b0ncZa/Sa1e5pB0yRYmYfAdFz/u1aRV64XiABu7EEu967?=
 =?us-ascii?Q?BjSQoFY5yWHa400rl/O3ny2sRB1fM7YVdw7PkoEBG0ydd5XjKX2mGBcZyHWd?=
 =?us-ascii?Q?OIjVUHj6BK3zFR15GYfCDqBTpHTaLlKPKh6JVijzr5YktEEXeiRgL9iYAObJ?=
 =?us-ascii?Q?9pvFVOR4gw3K8Egz6AqqtgnGwSScDJ3yH9RN/jENV1SFXVElEjoRGHfOLP85?=
 =?us-ascii?Q?MxWVCgx4MpHFKGTb6kqiM2LPXdlmVdEnxVS2CodLqPO8mvXyPzoWFQ3kwZRt?=
 =?us-ascii?Q?3wIaE9MNxnlfSLyo0ZlHHVjzS9L7kqPCcxMsqem+PC7OdtQh4SPld8vSL5Jd?=
 =?us-ascii?Q?lMKo9Pawi4qr5CKk1AsrWRHGP9alxU3YHHonAGiQl9MIZfALVOtkBFKIkaTN?=
 =?us-ascii?Q?U+yd1DFKEcBXA0UcKOb+NDaTKUzb84qVhMX3qHx67DSOJSdrHqie5X5x2Vvr?=
 =?us-ascii?Q?4fjLGnhoNDDUzEh4xKkHtsSfZfTK7l9pxZML4Gyo/Fqcrf2PYX23CQBJiDwL?=
 =?us-ascii?Q?mVVnA9KETn8ug8hBZrQMz81te0cuJWUOwQe0BQ9A9pvRV7Q3qQKT+G4a8miT?=
 =?us-ascii?Q?AiZdyLIAcOs/KK5ZLCtYthcTg8SAIgHSciak26/a7wWhCuqNGf+Tjzq97A5M?=
 =?us-ascii?Q?INjyfvtHzeX3S+u+P/mrhDWfOxtCxrAMCZBARGPOi6BSr86nAnARYvpWI1xw?=
 =?us-ascii?Q?bZd5m7cWcyB4jSD+X7evj7hbqkqaBlzoI3Fa4GAUTXQpjluRXsmBRX8B0Env?=
 =?us-ascii?Q?0SHbkIZ7daWwR8tAd4yJwsO5Ct0UFbCQVUv99TcMuV3nDy7KpJkblVe99+oi?=
 =?us-ascii?Q?QqcPUa5JmvosR+s1adNfw4JrTnafC8PIiLh4+VniLp/6GzSrEajNFjoUy+NZ?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68df18f6-509e-40e6-8722-08dc272ed622
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 16:15:29.6048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JjjCOpQK3FOOzWsWkK7KMg1nuzOmhIbOSUYor0Sc66sjcWtupehW1rzONn55at6lwW0diz7vZ97F5+xJL5jR+dGNdGBjoRQbl1FM8ANnL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7912
X-OriginatorOrg: intel.com

On Mon, Feb 05, 2024 at 05:50:54PM +0000, Emil Velikov wrote:
>On Mon, 5 Feb 2024 at 14:30, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
>[snip]
>
>> >I'm not a huge fan of using relative symlinks, especially if the tool> >is run as root. In my experience that makes things harder to audit and
>> >prevent accidental breakages.
>>
>> I'm completely in the opposite camp. Relative symlinks actually make
>> sure the thing you are running is what you are expecting. Nothing should
>> really point outside of $prefix expecting that is mounted on /.
>>
>
>That is true and I fully agree. Yet the contents of DESTDIR are not
>meant to be run as-is - it's used for "staging" [1].
>
>[1] https://www.gnu.org/software/make/manual/html_node/DESTDIR.html
>
>> Several years back there was also the issue with packaging, which would
>> complain when symlinks pointed outside what was being packaged.  It is
>> dangerous when using absolute symlinks because if the tool used to copy
>> follows the symlinks, it ends up with the wrong binary, copying the host
>> bin rather than what was just built.
>>
>
>That sounds like a horrible bug, which can easily break your system
>regardless of the project.
>
>Would you consider dropping the leading `./` aka can we use `$(LN_S)
>kmod $(DESTDIR)$(bindir)/$$tool;`?
>Seems to be prevailing on my system with over 90% instances.

seems good to me. I will squash that and push.

thanks
Lucas De Marchi


>
>Thanks,
>Emil
