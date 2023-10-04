Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1C7F1
	for <linux-modules@vger.kernel.org>; Wed,  4 Oct 2023 02:44:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A04AD
	for <linux-modules@vger.kernel.org>; Tue,  3 Oct 2023 19:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696387471; x=1727923471;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=n0oZ09IA/JYoU/TASuDse5t01ZRqyYVQ7ILCrXiHlLs=;
  b=KwhiSBk83V3Ja3kEuND3MhbclkZQjEaxclVTeh2lSGZyfCAKBCNGIjN9
   YBVriZeUZzsnBPR5JXHegwm3T0e+uU9Q/osLEGHenZAoBICJE0krFls9D
   /XzSFQED1f41UcWDp5XLUnfbtaQGbry6QfXFxaz8zSef7aEDF4xdVmLz7
   Z3uciG23hOBAxSq2/WO2hXoYdB+Rok3aT3vluuaqRzqen533NcKi2oPp1
   w0kMlkZX361DPffIn8PcgLy07zXEzYm9cVUh+2Jq8ip20mAPDUM7x6VyZ
   eno24fFxOJp4Zd82abTc63VrAYy/CHGZujOGeEphw+KHRQVodoR4UsMbx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1633652"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1633652"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 19:44:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="751121918"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="751121918"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 19:44:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 19:44:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 19:44:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 19:44:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 19:44:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdcQyO0ymREk62reZeFLNfG9vUIykh7LPXF/ap7zJkv8qTlo+0rUAXVaPrVw9LqWyxpLvg6BUY/4LLz07nfs3podRy6+sYqqnczK8nkWOht9U7a4VvkKODhGiLdSR5i6d9+2JyDMlf8suMxrihb00yWYl1+FtyG61BY363N801lYwVAzfCRYXuREl3Zn+IM4VM+EW0P0dHgAlae/pITcI4yhCHFeZCyJN+GLsrwEoqxM1mw0aKK8f7xqJNZvP6S3mjsb6pxrGlgNSMiQr0qzCx7ste3PzirxdU9o03mXP52mwEN6VyoUuTwfqbbT9+ixi3OOo9gZvngnw2gFY5DHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6GdSwAKX4yieE12c2DfuskqQdNEAHGChfXEf/iLlJs=;
 b=Au8G3MLFW+OnU6Och/9XdfXeFCwqUVUbDbGMJFPTwj/S4d5+lufW26PrlwGIFGD5E3CHI2+PNRziCBA7UShkkUMeiWoCU/TDgDHsEB/P9OkXUo8o21AvtokqiR5UTEoG2RtZkOXGHZ0DLabOqo1bCOM6CCYmCJWxVIW475SxmYhe5JIuUprlFEN4l6COFl57R1fO8IkYMKdUQw6zujjNb5aafR7r9yLt/sfHUOksJFSl3abdzFd8g2SzY7XzJJbtjZdxWV9MikvwuDIp3DsoDOnHGLbPhCMJzgvhYOKsS0Fq8QazukRGoJyd+6XR+nFg3+wtwFoDVwxzVEF0MGVzww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA0PR11MB4768.namprd11.prod.outlook.com (2603:10b6:806:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 02:44:27 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::f345:2318:9a82:51b5]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::f345:2318:9a82:51b5%7]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 02:44:27 +0000
Date: Tue, 3 Oct 2023 21:44:12 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: Unbootable system with kmod-31
Message-ID: <chhb5t2jtkzvl2monrwhcer6pbapzf74fks3petqtub5d7yuo4@t4httnfns7ao>
References: <acf37f00-cea3-4f77-9c05-3c0301221d2a@moonlit-rail.com>
 <ZRyCzQ67pAlbNOYa@bongo.bofh.it>
 <mmsrsxnmplo7zvh2rmp3zvymaprxj73mrskdjwngfnawkoh5ur@xx5dclgmv6bg>
 <df84e672-81f2-4f48-a5cf-65eb05ecc242@moonlit-rail.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df84e672-81f2-4f48-a5cf-65eb05ecc242@moonlit-rail.com>
X-ClientProxiedBy: SJ0PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::14) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA0PR11MB4768:EE_
X-MS-Office365-Filtering-Correlation-Id: b4fc5103-fa7d-4baa-533c-08dbc483d387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99wGOhMKkDdG3z5RZ5HmnvhrgenELUEFuGLnXvt5NrVEmhmt/EB79Kg/dDZpTh2M7cKGKYILZLG9fh0g2arAlyzyecOXtCMth/E5lMBlhS4DWkRf9DFhISNPBuJmx2CDMH9dfzaKnG53zpwnUcz1M/hLexzV4NVYd6QeTE+K40HEwj16MPeqTvsyNlmbnAoywD9rmMLG3fn/x5C9JYyljKbj/GTJLmyev7UDJSDrpUiIlZ/Bv/6vPv9F2BNMN1JGkCYWUJeAK0W20tsnIgxDcN9rJxvkO+y5PvXH0y8/4/g6MBj254hEgJKI0HPu3FfndTJmLE959Xhj10pUKE0QQ/TVzIILzKRykwsOgFYO9u8VORwnr1PLh4pURm1quyusuCgFwZgd4LXzdcpuh7zWSpyvG6YcKINDt5VnVv48lmiZfLRtdZSuNEttE0JYcTAUyuUCukDgWpACEL8Ix1GbXTvzXv09iE4V/u+XhUdP+uo1KgmWTtO3Y1TJQcDFYPgk1YzxaB4WnbN454Vn3/E9QUH9rXc6sI89cNB+982nHAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(396003)(39860400002)(376002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(83380400001)(5660300002)(8676002)(4326008)(8936002)(66556008)(66476007)(33716001)(66946007)(966005)(6486002)(478600001)(6506007)(26005)(41300700001)(316002)(6512007)(6666004)(2906002)(86362001)(6916009)(38100700002)(9686003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1eKhPpSWa+GY6CGQWS28aKQf8LL6D9eLjcdZopn2JFv0hWxwlneDJMrgPh?=
 =?iso-8859-1?Q?H92Rj9qKbWUbB8J76rGCq/pALQpgNbRYwM4yxBI52vU9nMEtoUP6Pv7I8q?=
 =?iso-8859-1?Q?aFOMavY83JaHaVvZhjR4gvctvvce+S7e7gnt9uKHUpUooPoU+U7g0DcUd5?=
 =?iso-8859-1?Q?Y1e/ZNCnxTicxTRPc5i3zUwopa/clm5H1LBPvTgewivlxQCPoy8kH7ECDe?=
 =?iso-8859-1?Q?KFl5FW5vuH9C7WxagOY6ELnuU2SmHfUQIn/G5VB7ttYlia2+ezBVggOBvX?=
 =?iso-8859-1?Q?oGqmtdU/qHWbBYQXlRVu4j4ICYwc0/wFUgu6Q9EYu+CLCJ+JwiWn7RUtxe?=
 =?iso-8859-1?Q?24HR+/t5c7OklsALjVtGMzmeQ3YfLK7B4isDPb0W9OQ3schwl2r2PNHf2h?=
 =?iso-8859-1?Q?YtoRXFqgvOCHeTPqBIeMtu+5Ut+yJf+M3TsoLLadPzG2lWeojywruvBbex?=
 =?iso-8859-1?Q?DVaHstW9+zLjdBH9kuZ4iNnxWCOtIZ0PuAR8dFNVDlemVh694Djt16DClK?=
 =?iso-8859-1?Q?T9jEVmBkcdLEeoOIGLno1hb4FkjxWAxeEfYUWbxxRxPS803yr8LIBNbDS+?=
 =?iso-8859-1?Q?gEAl6/nQjmiZg6xAPgOyO2ikiEsYQcsQcKesxW+WaNh4jLo4WledoR0Lxs?=
 =?iso-8859-1?Q?sZjre0tSzNO+uTsucmuuIMAxr7zfVMqZgjL+JjgS6vZsd3qgNOinkV4GpH?=
 =?iso-8859-1?Q?KO1zSmMTqoBYBRpFKB6Q0gaG4ALwlr7v5RcyF6ptZ1/MZhR2M5tCSkkbgH?=
 =?iso-8859-1?Q?sRZUjcVmkyebUkZVpmu2f+YyyhLDS11Iaee5/NWQoUxbHBWfUKL0hhQsWI?=
 =?iso-8859-1?Q?a6yvrvxIEfgQiWGoaYjOeMyMRGqZzriUHUdh049S3Obh6c4V7yS11zQoyE?=
 =?iso-8859-1?Q?emq2tOnvYNnObemFwfXHbMSBPxnpeRRy+Y8vi0rc1oa3ua+L79gzGnT50L?=
 =?iso-8859-1?Q?EIkCYqPQ0s2BRLIFHWtJH2JZ6BjZvPBNIYYLSRNQJrDC1W1MQtosEEeD3T?=
 =?iso-8859-1?Q?yZoxnpHU1YF4o6pLWBVloHOAv+QgNoHXRQTM3BFL3ZbIQji227fLKZe+cx?=
 =?iso-8859-1?Q?2wxNDRaPB5JMbgTpyw86K7pwaNKnD0V2y4zY24gFRSQ7O5P5HgMq4VZmXI?=
 =?iso-8859-1?Q?S3Oow3b/6qCP2yfH7MVi61kjyp3rw2pQhzow2BLx+zvAfmRlWJ7kQSo0aQ?=
 =?iso-8859-1?Q?Li54pFI7yqwnpT/Z9kMj7adiD3CHvD8Ej+yuY4pTPRDsWXItONL6rc+bzf?=
 =?iso-8859-1?Q?2iVhS+8aRFes0JLG2JKwbjWKsxDVlagMZtOIsvIyIc74jKTVqwtJ9lGuIR?=
 =?iso-8859-1?Q?R0fcIwd2Vy7BlIiARxWasnIyp6/kmukjEUbP0mUF58F7qxJ2DsB4K/AzzW?=
 =?iso-8859-1?Q?APzJAyE6liV7fQqODunud20f1E+9+pvAhwjv/7YvtDsegkt6eWI3gVBI7s?=
 =?iso-8859-1?Q?yq2GlLLKsyF4uq+sUcYNAAfglEzJ0J/zlb9vlddrdDBuHteIOcKkcOtpsR?=
 =?iso-8859-1?Q?0tOmlwrbvgKHvpIUyo2lcaJKoQ4YSNRqrT1DeO6Rue4HHMJduSZ2Wh3zDO?=
 =?iso-8859-1?Q?CFhkXFG5iwYFfsXiLk5enLuC+L2JFc9jCovToTlMh/i6Mt4sOkdePKvBKI?=
 =?iso-8859-1?Q?Gk3qGo+2JGE2eHeEpcvb4o8BkOp7dlPSpEsqkfPu5fcVnZv32/6CTS9Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fc5103-fa7d-4baa-533c-08dbc483d387
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 02:44:27.3666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYVAZ8gO0p5Jl8rVngeWpt3dx63K5nc1z3ZIRRZDIbvLDzSaD+eYLIMiRcq+0zRwtXUxonwNvTNu9I95YgHJqRbOhhIomxy66ra0WGGWEFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4768
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 09:02:32PM -0400, Kris Karas (Bug Reporting) wrote:
>Lucas De Marchi wrote:
>>On Tue, Oct 03, 2023 at 11:08:29PM +0200, Marco d'Itri wrote:
>>>https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1050586
>>
>>duplicate of https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1050582 ?
>
>Ah, that does seem the better bug report, as it triages it down to the 
>dictionary size.
>
>>Maybe that patch needs to propagate back to 6.5?
>
>If you mean that modules_install doesn't pass the right parameters to 
>/bin/xz, then definitely.  I've reported on bugzilla variously over 
>the years about things "fixed in Linus's tree" that never got queued 
>into Greg KH's tree.

well.. it's bug reports like this that trigger an "oops, we didn't think
it would affect a stable released kernel, we really should".

>
>Perhaps kmod should be updated to only call finit_module() when the 
>kernel_version is >= known good, or when not using xz compression, and 
>use init_module() elsewhere?

checking by version is never ever correct as fixes are backported and
even features if you think about "corporate" distros. We do check by
"does the kernel support decompression and is it the same algo than what
we are expecting?" If the answer is no, then we fallback to
init_module().  But if the kernel tells us it supports something that it
doesn't really, then it's a kernel bug to be fixed, not to be
workarounded by kmod.

thanks
Lucas De Marchi

>
>In any case, I didn't see the Debian bug report earlier.  Using 
>Slackware here with custom-config mainline kernels.
>
>Kris
>
