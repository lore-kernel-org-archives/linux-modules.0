Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2905BAF7
	for <linux-modules@vger.kernel.org>; Tue, 20 Feb 2024 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416668; cv=fail; b=VTaxhjAdaSmX45RNS4lMJwm1kdF5J5V9fwqufJxWU2pyIOI3I5PGLbFK0N6LMRfLgHcF3tjV5V2kt66anzk/Z3yzyxNMGYHbgA81v0fnCPXeUL/5jIx7VA+1o3JYmRArB0K8nN0sLn8orVJaSMFvv3eSG6ujEh8q9BobLO8NtSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416668; c=relaxed/simple;
	bh=5KqwquD/5U4vbn41sdtvg+kfVkkEtUfICDKIad1c6lQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MncYw7yLSEiiuV/zzGez8JJNDSgTZR9pQ660L0UE4M5AdQbbOZtAz3tOXoHs31H1O+zPbciH0J9uvjSlMiUowNrMp3LM9DM0Vw8fu0RILpTsZuN6bmVkN8+NLZbqEdod91QBUnzhcGE5xEirCH6hYGJmZ6QzP3erNYjvdFipALU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVLhoNGF; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVLhoNGF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708416667; x=1739952667;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5KqwquD/5U4vbn41sdtvg+kfVkkEtUfICDKIad1c6lQ=;
  b=mVLhoNGF20qXrQuui5/e0sJxFKFKum0PWvNKBItotWMe/pm5+sAiKwGe
   qMv+A3KcWmzWWoFWLaIbtFgpqeLFtQ7kqYSpypRfe0hecdlf9usxSNV/s
   MebSsOOayggRXG2JF29c3nfQZ5axEfKSN1mzTVUAqvrw0RciQ/6O9nQsl
   hnIf7YpU7S0gixuTNT24G5GGLbrZcubrbwkCde+u/R6yKr5VNF08QauIr
   +X07e/cfApFYOqfCwEmdpqcLb5pKF6cot8QHWmwItvoALquO+nwJGuJZ6
   5yYeCTUQ7iN4R/oM//FJHmSCAo6vc+s1BAvFp4OUf/wWQ7UUv2HSq/oov
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="6278949"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="6278949"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 00:11:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="9367206"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 00:11:06 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 00:11:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 00:11:05 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 00:11:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YN3XnCuYr6gCk+9mfBzDxb8+gzSHL6BFhvvhzZSfCDKxWEs4yy0DaMOjtv6jwJ/GjCyqVv6+Ub3eU85RmOmMal8Y0fRMY5YvfSs1LychQ6k7qHJ+TGC6bXUHYq3qu60b9cGhJC8RQHXUDV5MWRMLDXwfECczJvXC5M/6mjry6IkXvB2QVaqiBF8lglQwz+fcMthK2Xb33IfehgVesa8EDJ+XFr4aD7DvtGn/URbZag2gtFp0+g7nmt5xjDjQ4a70A5ZHbMg7KFiZmpftpdc4WPk4CEH1BmvitV57TtbKERkCmLhuY4E6nmVHGV5gjBf7RwAYVXByo36ivwLftzJg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bGiXtPL/hKBIx1+9I93JCOZbgYPq4meohBwTZJZ+28=;
 b=Y1UeCBLeB//OelVb6h1m4eOBdO5kXd1KFN+XGCQVMhtzjHyuQnznpnscO//trX5D/Uy+X97izqS9bwdql+EM+TW39WqB1WndhLnRgdagTiTLsoGmWFrLAJrlIGJCEWCdkpVXGtiOASUmI9OWtwk2EcIp4OgT6zFitlYaZoizu9jeA6yJWshrkk6zQyjUnJwkOcEvoy3A4Z70GhAai4sx9KBsGR4t+crsUwk1bKHJKOxmWXizkd2chM1B/GcwGsew6lg9bG0iXF57lIaXDDslZqUHXsSgESMJRP3MGOzuzy2cpk4l6vpvDx6Hx9/IFcvpYEMNSKTpZ1oPVmfpQWmSIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 08:11:03 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 08:11:02 +0000
Date: Tue, 20 Feb 2024 02:11:00 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Emil Velikov <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>, Emil Velikov <emil.velikov@collabora.com>
Subject: Re: Re: Re: Re: [PATCH 2/2] make: install/uninstall tools symlinks
 to kmod
Message-ID: <ed6fokoatmaussyvjzymgaymeaobieu22t4su4cb6cbni2cfh6@3luwbln63m6a>
References: <20240126-master-v1-0-6257d039a30a@gmail.com>
 <20240126-master-v1-2-6257d039a30a@gmail.com>
 <zeoywwedo4muolir5ietylb6xm2wu66wai77h6rvy2hkmu3u2f@f26b5cb3s6lf>
 <CACvgo51R=2WTcLma1wPSaDMu4QFtgezhGUKXf9k66Zg=6ZZ3=A@mail.gmail.com>
 <72ijqdtswcehmfjgodgg6chauou4vjkyh6ieup7osrcxbfwvua@arh6o2k2yddl>
 <CACvgo50Y1=-+SxLMsHy-Nc66wt1=S7iwjthRU-UVeS_N7o-EGQ@mail.gmail.com>
 <4on5pkpsatbpp75qocejyrgxg5dzccu5sm43tmujccd2wd4cr7@2lercurz46f5>
 <CACvgo53Y+JQA9A6VdwYyHiAvs8HPssotBbfmdPnPxG83Yq9Ztg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <CACvgo53Y+JQA9A6VdwYyHiAvs8HPssotBbfmdPnPxG83Yq9Ztg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ0PR11MB4989:EE_
X-MS-Office365-Filtering-Correlation-Id: 183081e2-9da6-433a-8d71-08dc31eb7aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qmIDnLxhpdLr2elgDAMrQ0G/vN78ZNaec+AZoGTS+M674KtWmxoQCjN4XIDakpXhL8uJ54t2x7VMI2m71jqEryO/YUFN0RyDuNdxy+yTKy5cDMIaElP2JitZUsEHCzySDlyshao3tU+zWTnLaIQC4L21lmwVLgrQp8l0URmWpKr/ERFdK/4DfhdVSxDkK2j0TRfAh6H+rlR6jhPO+4sW9eAX2UTYuQnNgp9Fn6YIoNLMEb7w0u5GuL4v11WizH3cw6mC02tefRO/HqRLwa+WWOUcusadzp//qsgGWfRxYCGQcnzlJIy9EbyO8RQ49XCoihsm8Bfe8p0eCT2WrceNlsE7RJYGqtYewM83ayTyQRHn0sR0c9k9MvpDm/h+QAJVHnyGCAqk05Xob8UNvqG42qNz3PsqDPlPaF0wNQJD4Pkh27aFglRPMx0MFUNRHFuPg7RLsGA/0eakXfeBXjWPoWIOvDZzB6sG2KPqz2K4Ozj/SoATjSGNz3MbzSswf3U8TW94VPAVN8V3/e2nQsyTtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iq06nY/oiP/cAR6rR9JZMJNbfuFS9/nryEo/S5xer7lwo/IIwmbUjNrO6aDr?=
 =?us-ascii?Q?JHrqkLNLaZRBKtQhEoFUP1SwqIADc4gZncnmSzgBoQrVFbzYECFL3ASlSh1R?=
 =?us-ascii?Q?3YBtoh1YSZd9z/RfiTLZ4Bd4nJoyvZraQgidCmFPabtAfJ9lAGxDj8fwtGIt?=
 =?us-ascii?Q?b5tUZD5B670t64G2VB5lk8IuiKl6nzc5uJCexBxOoFhGpvTrPzBWW5DVju5g?=
 =?us-ascii?Q?R8HKuzqhohA5FY0WUx0/o9Lx6J1RbGIzkg9+xVcbAiZ6ag8L4sXcspeJAoc3?=
 =?us-ascii?Q?0rX/atHGlShy+IWVqHcO1tj4DR3AL1hbelGOuX2IKQkKtcECY8QRSWXxMSNr?=
 =?us-ascii?Q?w8KbvYsNHQnm1Te4kIjc+xC6DiyTCmJTxWEwcfN4LKj9SYRfSZetKn57rc+E?=
 =?us-ascii?Q?k30kJJ7Fvp7Rzy3q1OP1iCOsDVRNZu3AVVaiEHtRfNMI/RYl7h8gAV6X7kuA?=
 =?us-ascii?Q?Ng5dd58OTWkBAHfUy/jmISNPd0vjcaRPalnxdM31EObj4hEVdpH/pJVuOjku?=
 =?us-ascii?Q?LxFj5/VBrD9b0C89MjtpaYQXZFaHNvSzV/KtwHbaDHv7n+IOmr5/lsAks+UM?=
 =?us-ascii?Q?/I2XUeCsVgjfZcDazXrriVPLDiRrazGvbnqDx1mt/MpORzsESFleKD8ChgtW?=
 =?us-ascii?Q?rXG6QqdL0HWUB8JyLVleqfj1DMHkkZH8qwLGL7zawIQKjaJOnKOct+fwpJ5V?=
 =?us-ascii?Q?6nss5RxWVyu+bUnBgS+Jddis4azXgvp/jz9Ge8KJ8zz2paHYP+hgpnJuNgBQ?=
 =?us-ascii?Q?75irqfs5GlGle8Kf4eJy/2PVDn6xCsT/J9xmHU+//akkJGy2yuYromfy3mC0?=
 =?us-ascii?Q?8dBD4LGwYCYBjOFFYdnDB5GQBasQ9RGINAdZmjPTyTPnonrxoyECVWNIyM4x?=
 =?us-ascii?Q?KHgbwtfqOakgA79LKiGN39Ej8mvI50Sg8fWjaFNcqOjJ/Bz5J8vIkcr4zHf4?=
 =?us-ascii?Q?H4PrVOlN3DgdjoxEzoV8/5HAs3Tg5KU40bYV6u5tsjNySqMwhBzMbJPyU/3x?=
 =?us-ascii?Q?26w9kFWitMBa3eZdNqdo2JmfUaSnhMCc7jOkjFQTM1MMybX031pdLDVLT4eB?=
 =?us-ascii?Q?q6HbGEvdcc6oKv3x4nN0SEYirAExJ9uqnB3datOEB35Lfc91S0IaLKbj3uYv?=
 =?us-ascii?Q?vGTOEcWLdkNqJ9bFEIsKUduJaj9+pWjsgybtiBu/vaG3SpRfdKYuCQ3jNyQl?=
 =?us-ascii?Q?ntFEP/V+0YNK1HK7Qtedw8uP5wWu9TeggYoIdrYS1sgj4MAPJWDvYt3nGO0g?=
 =?us-ascii?Q?eV+7OBCz7rjg39lYabYZFor4RUnfksXZiL6tT4Yxk26/vdwWoOCjK2N3PswB?=
 =?us-ascii?Q?OgRGORupMI2YiLR4cEjqPtMhPD+cupHjUJJsO1SJRYiySIL/FMONrcYDjMeK?=
 =?us-ascii?Q?u/B9K8WeSRDMMS4ZCh3bAHAKDW+gNDJpy6NoemODq2XDV5ZvW2mXO9I4tIum?=
 =?us-ascii?Q?m/8zBrQnL31N8fEWwy6THPv6Zlkys+mLK6h4Tfcwh7sD8murPdrT+gLiz/ex?=
 =?us-ascii?Q?mnqo8PW2wc12lE7T0saD9S1r570E+yGSDDv3iFcu0ZQ5p3RdWixZYT20LRBc?=
 =?us-ascii?Q?FgeZCel06yLRyKEY3S8mx2ThaogFT44aGHWOMhV2dlaw49ZOUnl/T2tdPW7Q?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 183081e2-9da6-433a-8d71-08dc31eb7aa1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 08:11:02.5787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1H6wc6B5aRPf5hWZeP3mJpKB1XV1N6FQ2Tlmw/x5cvYdF98423CJnOlPPVuqkbUjWQnoI20oT+l0YVIqEOMsnOCIdW3AUaIxwunPB3QQuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4989
X-OriginatorOrg: intel.com

On Wed, Feb 14, 2024 at 04:22:44PM +0000, Emil Velikov wrote:
>On Tue, 6 Feb 2024 at 16:15, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>>
>> On Mon, Feb 05, 2024 at 05:50:54PM +0000, Emil Velikov wrote:
>> >On Mon, 5 Feb 2024 at 14:30, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>> >
>> >[snip]
>> >
>> >> >I'm not a huge fan of using relative symlinks, especially if the tool> >is run as root. In my experience that makes things harder to audit and
>> >> >prevent accidental breakages.
>> >>
>> >> I'm completely in the opposite camp. Relative symlinks actually make
>> >> sure the thing you are running is what you are expecting. Nothing should
>> >> really point outside of $prefix expecting that is mounted on /.
>> >>
>> >
>> >That is true and I fully agree. Yet the contents of DESTDIR are not
>> >meant to be run as-is - it's used for "staging" [1].
>> >
>> >[1] https://www.gnu.org/software/make/manual/html_node/DESTDIR.html
>> >
>> >> Several years back there was also the issue with packaging, which would
>> >> complain when symlinks pointed outside what was being packaged.  It is
>> >> dangerous when using absolute symlinks because if the tool used to copy
>> >> follows the symlinks, it ends up with the wrong binary, copying the host
>> >> bin rather than what was just built.
>> >>
>> >
>> >That sounds like a horrible bug, which can easily break your system
>> >regardless of the project.
>> >
>> >Would you consider dropping the leading `./` aka can we use `$(LN_S)
>> >kmod $(DESTDIR)$(bindir)/$$tool;`?
>> >Seems to be prevailing on my system with over 90% instances.
>>
>> seems good to me. I will squash that and push.

sorry I went on vacations and didn't realize I hadn't pushed.
Now it's in and with the other patches fixing make distcheck
we are clear for a release.  I will prep that this week.

thanks
Lucas De Marchi

>>
>
>Respectful poke?
>
>Thanks
>Emil
