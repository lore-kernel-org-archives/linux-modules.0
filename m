Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59AE17C72
	for <linux-modules@vger.kernel.org>; Fri, 14 Jun 2024 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718392654; cv=fail; b=FQPPcPA+gcZqObcuV5IFRtON70XFPPo1rG2NOSOiXfmPnkQ4RLz23f13fODKO+X3FzfF3kay5Us+kBGJG5IdgYHK2KimXzy/2SzY9MF7LadwG//f3Yk6vc4G8rt3ev9nqj0w+ipCeKWtTUyXH3+66lWjnVplBzSQO8VZcoMqwME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718392654; c=relaxed/simple;
	bh=kQVVIS8sfRAa0Ee+JFa1sMjvNHa8ZeoscpsFA6OIqEQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J7quTDkvO0LzXWeOq9U/bU5w3HjplH9R6MpOTyA1jLDa+12PWPOTM2vCJN1X0dxj5pQk+gBYg6bWr5ufJsArMJAMzKLF7HoeFUoX/kD35Qr1qD6Ea7axDg4HRtBzmlSmi5M85K6CvUqkEQuWLdzeToE7JWcjnbfVaf11egkjl+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJtVSvQP; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJtVSvQP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718392653; x=1749928653;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kQVVIS8sfRAa0Ee+JFa1sMjvNHa8ZeoscpsFA6OIqEQ=;
  b=GJtVSvQPiS0JYIZtZYJ/fXxfsiQRWG3TG+Xa+iHRA2DIFW4DP9cCyIMP
   NDDYKsqzscGWiF/tdwpJAkXsFue6ilYjsh24Nyupg59WGfoQfY6UaVCS8
   +iO7toLgivAexJ4G4KLnZ4yKNPiRZ9JuarsJRXVlg1/DftoEvDEfnp9LA
   qWQu9NuTb6pabS+xNI1flHNJRjCROmJcpoB6mpBsaKGbtm97ofhXs2egD
   IyKSXaSy6Q/h9jqv5SyUpIFiaPV9cKwVYia1pI84T+ugX3+xtLNE8BAv0
   ImqIJenFOtwpwT5oXjAnuRjT7UaKeI0oNVSZiEUtT/Xp+hUGSMNWULf8Q
   w==;
X-CSE-ConnectionGUID: i1ysNoJ+SL+4ycsQcPsUpA==
X-CSE-MsgGUID: tJRPprZ7RLepEa17IXwzKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="18218848"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="18218848"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 12:17:31 -0700
X-CSE-ConnectionGUID: ZyxKYhe5Qcet7xlJMoDG1A==
X-CSE-MsgGUID: B40xlaM2TEq3iECnUpSZ/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="40444407"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 12:17:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 12:17:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 12:17:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 12:17:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 12:17:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4LbKvmAkEiMBHTjEgLXMCwS3ijeqm2IBmcG915Lw2qbNUugCRFhOT0yngfy+fjYt20/XzGaPKXW2cYdloXW5fNBVFR31KuqEuA8ZDYmUzPIDVEraQ4wjSh2YZ9h101SdK7S0eOFN2KhhKaAjF1FHzx7UjL0x+Hc4YDY46EXhYMK2u87a3bLVy3IglCf7lS64OClp7IH49aWxh9iZjUbSk9p9hpB5hZlz2Ence0r7uiZ32qvvg0TxeQrIlHmvNoBpR35UR3NnTFqSyAUBfgIGa1yDt7wlgttWD9TuzQKmcBLSJ4CEpmyRmmCDSGN9LHvGhpnkhjLw94NIh/zyIDcTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62FhPRNyF5WXqLVy49oouylvfke/Yk0KLFG2x9xRJHk=;
 b=FnllVzZhstiY59yuh+Dunb0ujbm4bP6YuBNaPjD1Qxenj6cEEwOnQXo6N8Szfbrgxdfkzu4I2Pgcs4YsQOwBvIsB8FRtIVXurUau3XsdAdUSPXpmEetGBjYJjuT+6Fsny/i1ovqTsW0UYnoKBH5JURIgRLARmlVbHvZEJ/U6Lot1OvGir6e+/PuaUI5x8r9JGiBp7d5z0LPPgF5GNvj+PAMdi6HvEvMoD9FQSBVPMBQLQs4SvYimJkA7APLNqiai67p2WdG95mLA0ynhBg+0M0BLNY6W71JvmaBdXcf5pibn7Xs6RvHwKft0L0rXLantC1KlHybHyf7tVgmkThG+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CY8PR11MB6841.namprd11.prod.outlook.com (2603:10b6:930:62::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 19:17:17 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 19:17:17 +0000
Date: Fri, 14 Jun 2024 14:17:12 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod] testsuite: add tests for weak dependencies
Message-ID: <kxx6xe3xn43om7zdmcbto2bdmmcbdseqlne5kt44nziozbirxp@6q2rtkjp5djh>
References: <20240530070836.9438-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240530070836.9438-1-jtornosm@redhat.com>
X-ClientProxiedBy: MW4PR04CA0273.namprd04.prod.outlook.com
 (2603:10b6:303:89::8) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CY8PR11MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 26acaa6f-819c-49d0-949b-08dc8ca69b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zGocg3tyOB7JTvy4MSwYTRdXtX69Aq+b9LeQe3SBVGxgDlqYxEz3NKbNJGwB?=
 =?us-ascii?Q?ZavcE1xc/9+qDVx1WunMPE8ax9o1mvXykH6juS07n1uBih1BQjNVk9c50eTg?=
 =?us-ascii?Q?yZBfFMMPdHtjxtz83CRT/XPPtsYH4czTZCbPJ53AsxkxuggzsLeKIYECtVO8?=
 =?us-ascii?Q?6yT5G73hShmy0yXDm9oH+jAHefLElxRwvC6V0IPLriM1lSxnMJloKKD6IPUD?=
 =?us-ascii?Q?RP2BG8jpe2+/Cu+blB1XpvsMxUi8H2Xo/T47KQJw7s2GYiHE5cQddZBJMsEr?=
 =?us-ascii?Q?+kI4srLLzp9SFq3pAoK/Gf09NzMbTJ7WMBWvgQYTpK3xmO/5xPsEwo2EXmmk?=
 =?us-ascii?Q?mgQp36WDhCv5wQL+UCmHMRYLS+jRzVp2dIvnNePc0FHdIz4sG4PTujBOp7ty?=
 =?us-ascii?Q?hn2gWL7y1VtdIcyK2wxuF6ctnv36OGUW1fw0MxiEFemHwPwAwU7jlws6p4jd?=
 =?us-ascii?Q?BZ5V4VSzeChUwYrbq2nzKmSPAkF+UY+KBDlMx0gELNq5gIXzeJ2sCunB8wAT?=
 =?us-ascii?Q?0MQSjSk0SBTUQjxJbjBQektkD2O1c5Svtkj3kO23gl0Z32fD7FKvrP3HVW7Z?=
 =?us-ascii?Q?UuAUoc6jQcfMXJnUl+1stET371UdNKJGYrCfgDuTBOFWwCqruOAeMnlqUHfU?=
 =?us-ascii?Q?zRfl0SDKqS8D6ST4cb895lewEjD6XMWBAEQfemugo97KKwWS52KTFoBG47N5?=
 =?us-ascii?Q?gvkn7m2wEAmLRYvVhWtF4phrP33WIngYaKTpTO+uRPZIl+G3VRN6YaURQYc2?=
 =?us-ascii?Q?7S6EEYiy5O5fdrBA4DeJR+Nz19Ab2SKhfVo2RzgKJyva0XZEJR5po8fLmVCK?=
 =?us-ascii?Q?2QUS4wZ2rA9yXCJWvO8Rdv5c3NqPs4wDK1sgkykX3AFeyoiaNT+Tom0nQlxd?=
 =?us-ascii?Q?vpMRR0ySofgGpXrTltLcOJhp82g8q1adjeG7P+MoKW/U6b0bqu8TGTaYp1g8?=
 =?us-ascii?Q?K7iTFvT05s+luUcbAOJbMGZ95QSz+ZgSTMQiwhDw0eezhiFSDxVEG2xnnDK+?=
 =?us-ascii?Q?CNbLYz43L+AiPZGAxkOrdPI1KVihLqbi4bK+Hk+i1yaWFY4fmWfBaqwXznuT?=
 =?us-ascii?Q?JTt2jXtqb4lLGwXZc++HTrdYpuoY4hyJyqpOVauKlRiNPv+4YO15+MSYcgNG?=
 =?us-ascii?Q?zyMOVfa+ceHuf7CcVRWAJKJBxk7hada7z/T5c2FWgS+3TwfayR8+MZjsaCDM?=
 =?us-ascii?Q?mT9GJx8XTqVjEJhEhyV57AMUagrbeYZjNh4xjeo4LG3oRJXRsTJF8EyKFj2E?=
 =?us-ascii?Q?9zKVbmNuSe/NXJ/xQSGtic2kO1eZ2fiww2Lw2W+sEvkjw+4tZlRAResk7Qfl?=
 =?us-ascii?Q?jkk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tndXj43Rfs+3xjtHDZg3J+rhut0bZoGQbDu6q/mFglV2KtanhkVHR40+JpIh?=
 =?us-ascii?Q?sC21JNdTx5Onfi1Fl3ikB+SXf/XwEvlZNH+Z+hQ5qK0cf9nj7MEDsogB3chs?=
 =?us-ascii?Q?TZz0nfsFBdhRdKpc8ci66IYpKMO7+U/iFXxvWflrTBjePOl1PU+LrzTUcLZY?=
 =?us-ascii?Q?SoAQFrDnBj62nq/u2Qmcp0GW6XPIZyGrCPEoSIr26nmEl/i49ll1RgKfwMBA?=
 =?us-ascii?Q?me+WfAEUYd1iuKkT0Ns7Ul0yuZBdzJie4wvFft43F2/wVKlhv8UUUZQ4nax7?=
 =?us-ascii?Q?VUvwi+nRy46XcuKnnIb1Pw3GrZ3b6xro68xPuabc1085QvT29l9EUDrY+90c?=
 =?us-ascii?Q?s4mGXO+WsqRe1q8KGLI9RlfN+fuygH87FgQZNIdJaI7fhDoYHwX9xe9KUGDG?=
 =?us-ascii?Q?1yztby/GSmky59PIbdBXGrf9tGxqTRuKaCY6yIqdsACft//UFo+JrS7jQ99C?=
 =?us-ascii?Q?N4jDdL4+NtC5SLZTfbPWz4B4aDtTZp5aZK/FZ+UsUgDDtUCrNO7bKDzIEFRG?=
 =?us-ascii?Q?lu0h8zNhL/PuS8FJKDl403lic0X+FqqXKe6271RsHKMS+10tg7pCdbsBVLa5?=
 =?us-ascii?Q?qxlJH7SJbcwnQ9EAhwTb1UgtqZ7AHw7KFyaZc/PXbfTOn2r331ecYSajHGWz?=
 =?us-ascii?Q?XYF4vzyNwJmUyz4RiODiE+loVC4eQp1dCdjJzQiXQ5kJiS8w7my25VvCKhxG?=
 =?us-ascii?Q?1SEzOs4B0P/NvymkT3Tv5opNIeCsjCTTPwLMhLOpBa50klcCV7fghYEaYYzW?=
 =?us-ascii?Q?zi21z/RdyNdoXJgkDh/l+Z/E3TrB9CZq1rjAGotJ9VGiKlNBHglkxvNAOoZT?=
 =?us-ascii?Q?mTepiU0QhEo1GwAXpQ/kHZbBnSE9O9MwpS6M3FN8INgejwGE67uaH+uUu9zg?=
 =?us-ascii?Q?w1KSJ4O5SM0xZ6M0OOAi/9djBuOleghbHPRBRDf6ejftnoAA61VXv45KvC8R?=
 =?us-ascii?Q?0xRMuDeyV8Q+JYLbXhRr00d1fCFuzSY5c/cyy+7WTsfPW3M7Rl5Io9N5xpNm?=
 =?us-ascii?Q?snkNQvivQ/vM2ngRwJmc4LC+s2sHn/7BU5jCxAISwIpgH9++T1klgdLFI8Jq?=
 =?us-ascii?Q?+0yeppGIjTr/RggdbznABISoZm+cQfWTE7H2yA/rXtsoR5d+E//DCwtKkm6O?=
 =?us-ascii?Q?xHuwlKC7N57iVTzBRKZFnRQs/FqOu58QCTZc7369nga99C77GFO1nXNgTdek?=
 =?us-ascii?Q?Ne8boQVTrq3RSrQUCLaOTciZUVb/rhEFJcAJ89h3qjZpNtxaG1qgnd/s6IhH?=
 =?us-ascii?Q?x5QZsbEvvqrFBZSlIf7vI1SheICuWOyqHl049XWrfPqzGlS8WZPtItktKF79?=
 =?us-ascii?Q?Fz4tRWHk85p5XgAbHNMdrO98KRrcIuDldLSnfiGjDcZZ7DZtD+5j7NicDuVo?=
 =?us-ascii?Q?W90aPCrvV6ay7eCFIJIThf67AAgnir2jkI3u/ryKsiC8rf4UAllFLUEb/UfJ?=
 =?us-ascii?Q?MMKSj80OXPCNZ78BQLKU6u7gGMhTSrCDxRbQg9Jxjl7lO117pii1JGcgApyf?=
 =?us-ascii?Q?VPHZKAPBIVwrfNV/UbuWbuvS8D77/4AjdHeoOCA6vNq1Crw+MmV4GqkEVV+X?=
 =?us-ascii?Q?yaO5RFekO/JOT+L00G+/KKRpRuMeXxw2soWdBoHBq5xrz7UUSHFuLgbzj9j5?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26acaa6f-819c-49d0-949b-08dc8ca69b47
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 19:17:17.8054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EH1ZPX7qjRD6BqoKolXoOgTiLIXNo9bF2RZSraM5X67Y9sEOyJ8TTXFqzCv1SpAJM2lGm4ORQWdZDzKlOGnhY8tqYuBfMGBcaAquFevd/As=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6841
X-OriginatorOrg: intel.com

On Thu, May 30, 2024 at 09:08:27AM GMT, Jose Ignacio Tornos Martinez wrote:
>The following tests to verify weak dependencies have been implemented:
>1) modprobe test to check that related weakdep modules are not loaded
>   due to being a weakdep.
>2) depmod test to check weakdep output.
>3) user test to check that configuration files with weakdep are parsed
>   correctly and related weakdep modules can be read correctly from user
>   applications.
>
>Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

A few whitespace issues below in testsuite/test-user.c
Also we need to define MODULE_WEAKDEP for the mod-weakdep.ko otherwise
we break the build without that defined by kernel-headers.

I fixed those, squashed, and pushed.

Thanks
Lucas De Marchi
