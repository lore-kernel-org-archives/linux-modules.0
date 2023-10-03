Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE231405CF
	for <linux-modules@vger.kernel.org>; Tue,  3 Oct 2023 23:38:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6576CBB
	for <linux-modules@vger.kernel.org>; Tue,  3 Oct 2023 16:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696376316; x=1727912316;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=AJ0BtJWFWQo2aRJSKPP0PvxNhZlbXztf7RuIg9M0cJc=;
  b=hWirQeDMikUb7mnPMpOEXjGaj95aE5xMV4llg/0TCvL1lU3yJcxQmuEj
   cpmT6L9WwMg9OJ39Er4XXlDiDu+1TQca1EpLAtCZXlsxe9feUVWWCA8XL
   6V1QXidu2Rh672fKbtIvLNpsuEdIWYMs+zAGulIlV4YoJaT7UG4A8365+
   w/4vbWKUC10nXD8YBcK2nEAnDCpOukEE3HzU6sCR1tOtW47PAF6XDiMvK
   43RaJwsNUISZ1V4OE4sEfv/XCrZtiIQ1VRoKD8t44/dHVCsfEHvzx5hAJ
   N9lBJIFBhYvW0R09so1DxjmLxA7w6ut4PwoY0JGGKAJCYnvf4rMl5R19B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="385821450"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="385821450"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 16:38:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="700898367"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="700898367"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 16:38:35 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 16:38:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 16:38:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 16:38:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlWX7VR4WG616D4rzT/nxJHDem9mDY4YRJp4NjHUGtJPTYU0AXIxR807MPPxQ+eIVjrzWeIFLQtND1janUWDciZhTT4h8X/hPSd0//Ww88llomaMPQNXVyH+aE4xWh8i4FoLiRRRuC+sOopSnT00mQkeSyZgvmYiLwaGnUgipgXq+j9OX7DCECZBUci2Iouja096QGjH3dCnN2xwlxzdcNWOqkyLqW4W0GkhBWB/QcV9ZTdv1Krk1wTXBadw9eaaghcVSjveICXphezZ+N2k71DCct1rkghK237SCBEEu0EuBmUZZ9Lxsj8iI+59pgyIcpC+mBWAHkqyEEyLInkfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3o4+lxWuZuyeSVZ+TdLRTlUUJ39Q3m8/Ka0T8PT01SQ=;
 b=AplXoR81uQDeBNpZ7i3AybA6b+c35tdUlMqP/z+OHYeWFiMZEDwp+u2s5nO9FAc7QwS+rAVaZJFbtIr0hkIDuDpfJ9UADLBSo6p2giuqd1AcQDW0nQuCtteQb+qXUzco3NhhWxfNMWTgyqINBFiEqxsK/PjR6mNscSPhudig1o2XwYmBDnihheSJ+Pl6ozdzQ7W5WuyeAW1TtuykAQYec3aTaMFLL+EaiRxO/xislR8LLoTih+ZHPm9RG6p9Qa2zbQbRlGYkSauM8THMPO/+aMP2OWKAv87I5OyXtPYwxRgR3kRu+wwTULPzHNaeK2PWu8Mr9qo8ycs74n0iyxsquA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6135.namprd11.prod.outlook.com (2603:10b6:208:3c9::9)
 by CO6PR11MB5668.namprd11.prod.outlook.com (2603:10b6:5:355::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 23:38:33 +0000
Received: from MN0PR11MB6135.namprd11.prod.outlook.com
 ([fe80::cf65:94e6:cdd3:cfe]) by MN0PR11MB6135.namprd11.prod.outlook.com
 ([fe80::cf65:94e6:cdd3:cfe%7]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 23:38:31 +0000
Date: Tue, 3 Oct 2023 18:37:45 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>,
	<linux-modules@vger.kernel.org>
Subject: Re: Unbootable system with kmod-31
Message-ID: <mmsrsxnmplo7zvh2rmp3zvymaprxj73mrskdjwngfnawkoh5ur@xx5dclgmv6bg>
References: <acf37f00-cea3-4f77-9c05-3c0301221d2a@moonlit-rail.com>
 <ZRyCzQ67pAlbNOYa@bongo.bofh.it>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZRyCzQ67pAlbNOYa@bongo.bofh.it>
X-ClientProxiedBy: BY5PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::40) To MN0PR11MB6135.namprd11.prod.outlook.com
 (2603:10b6:208:3c9::9)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6135:EE_|CO6PR11MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 85260a41-350e-4edd-1c74-08dbc469c4a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7vmUhkX7zWTnidKaLcLsG7cE65zwXLUzkeYtvbv+pi8s7QFkw7xm3WyeDBPYoF7aZt7Vrqiw4His1pqH9p6H8M62EfH+KKhV1Gu6rj5VbTJltDWQe4xFzN5QVZIK9gEhSqYNz1iP4IxIUUBGj4UYtV0S5vxY5+HRcq0bNyHJWH3isOPQUQA2ubtuDd15t46LdmvmOuwQ2DUGqIU1U/AE9CkUFeaSAwhdRo6fmSwpmENlbB8Sih8PL+b9EJ43oFxC2e6NEAXzmqA0kszz2UUf6+GecFio0LtniqKbF6s7FGJ0srFetMqTD4j1mC561sOLYvlBE6T3c3+weak7ojHnyLmKTE7LilImGtcS8mcBtlZmVIgWe8Zq9m4RCeggXOLOIBCAnY6R/5oh8kPqhdlsgqdRzNKQ95bdaAfylxy6tG3j8dDRZ8tnnSg05t/tasYBu5B7oT4CfR6mEC/9BegbA/iDXmVN55KplBtC0RyO4UqRIM7f6OIrmbKyeddmdcK4CDTjODjx4gz0kSeAvGVIuxsQvuKhCbJP9PDco86Sfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6135.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(4744005)(2906002)(5660300002)(8936002)(8676002)(41300700001)(26005)(66946007)(66476007)(66556008)(33716001)(6486002)(316002)(478600001)(966005)(9686003)(6666004)(83380400001)(6506007)(6512007)(38100700002)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mf79orXkI9kW4uc5azbfJhtBk2RG83bFoYwsdWXTHcFeBOwbUxSWU6goJ4h9?=
 =?us-ascii?Q?rbvXbOGM1bt+80U0FVQT2It7213lz1JiYKWml5TwyYR24DRCTUcIFOKiGs8h?=
 =?us-ascii?Q?j2jlFrg8iE6M4c5BHsSYcfu3NL935wkcrkX7I8wrJLoSCDUFq0F+Iyxg2Wgt?=
 =?us-ascii?Q?Qm0tUMTEyqJfnK5/O5OZttHT85eBhdsHXxReySwcGsUKoB31kMdm6k0JgK0X?=
 =?us-ascii?Q?ADWIkNV19rCg8a6APgTFLB5eDmYDK9uSXbybFnDhAQcUverrDIcJMQp/7TjO?=
 =?us-ascii?Q?IDe9LBB37w3KL8KbnS7hKywe9Y8/6AvAlcoiHlJ5FCRJ3EkLxtlstxg/g8Im?=
 =?us-ascii?Q?w1AirTcfgdfWhReMhwaNivoNe/BcUk5KbLajBMAkWNXL7c1mIWRzRe4JE7aK?=
 =?us-ascii?Q?AjCZw0JtoIvoVxL0CoyYZsT7IGkIeH9jkdfZAE6mqRr0R6DPhtzSaD1qdDC9?=
 =?us-ascii?Q?dbZtmDdIJfczoB9xLcYBX5U8NlJ+qO0vGwE1xf5NJ6wtVcwKe671FYH79Lab?=
 =?us-ascii?Q?/fkSXGl7gixygxLEuUe/eKTHNQc5BVHiptrvR1SNBhi+70sL24xJRD+tXvZL?=
 =?us-ascii?Q?rXVEf4l45kAiDkOrTPWkqpYu0VSZdXyQs2giJba1KG5sowrWHS3XK6OWZb0d?=
 =?us-ascii?Q?L/xIp1wHcpOZbSD0Cya+QbtyW7HpiPsCgmFQHUL1T3VmlNynyj6dzmB4ybCE?=
 =?us-ascii?Q?O+z+xFS4bvc2Oyic0U0bwlLVMEto4e9UY7uGsR70EzKgupn0YoKVAOXlBZcy?=
 =?us-ascii?Q?j+DCBaLztceCbalpHYREOMEB0N1cwseky42rO48vfmvRxj1dTWDW0cfdexbV?=
 =?us-ascii?Q?gefF44jc2ntUBJoRHjAtmBu+ZtKx+qL/cljA70oNKkipmdb2Xy9YwnXNjP02?=
 =?us-ascii?Q?thiWIcyfb5ItJjUcS/t/Wa3QoFqvkP+HnGJGQd0LPqnf+cpXigXPbUzO9OxG?=
 =?us-ascii?Q?BkBtGfxZcpZvrkDuQ4CeWsRQb8pj31Bq2pDlpH8l0S1ySN8b9HYiQ0R5ETD+?=
 =?us-ascii?Q?1SRfpsIG19/jonCgqUdAC2VG4rfB5FVOtV2L9zEw+D07wJHi16XKrdF6ucHO?=
 =?us-ascii?Q?qX/Y+AOUeGrksain+DL0IxWWGdhXHGyRyMGL4viS1BrDeHVhTJGT0sJ2nvRT?=
 =?us-ascii?Q?aNlszEY2FR7VXCc1wWYt/OFdfHCRr1NcAsYbjGJ2+fbcGS8bmiS36eZt9bIS?=
 =?us-ascii?Q?juaJvh97mAg6upyjR9G78Ec8gn61o1FoNx5EnxD9jpJo+v9fgR2hc0d1EZwo?=
 =?us-ascii?Q?sSaQf3E818Ujhmw3y4giNN3nOXmomlgSF9eaP138knFdT0i30e7LoISN0sVX?=
 =?us-ascii?Q?vpCoWg1Ss5l/YKjqrzE/Nr/n3v0Bl+8vvZaTN2PNWyqHqbDWNxkubb1vHmaO?=
 =?us-ascii?Q?lfA07jQO8OJvF/ZmfhZMSaAmz/rV/ton8ZiDPd4JYelngdA5w6v/G2mVvvVM?=
 =?us-ascii?Q?AYxL9uUL8wIJy1B4hfhX0RIk2Vif1c8BnnAAxsFeUu1C3VUm/7nWw4d9cxb2?=
 =?us-ascii?Q?KHnluzor/XLCANB2jDbiMK86y2GxbItyJa2Alsvg8zJvJh5N8Mq2fUIM5WN6?=
 =?us-ascii?Q?q51eFgJ3n7OlFATxv8qhPNnYSxablNkMpPt6vXX20JxxVbck6lHrNcZ9qzmJ?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85260a41-350e-4edd-1c74-08dbc469c4a4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6135.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:38:30.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bGEz531+w7HTfQ8CA/ZDZTAdKBlGqfQOAii6w5qI84Au/rIB3ZRKkXU16FLQgirMwxWNjxgxlPe3N0RcPBWROGEGyBEoOii2j6LW4MJlJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5668
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 11:08:29PM +0200, Marco d'Itri wrote:
>On Oct 03, "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com> wrote:
>
>> I upgraded from kmod-30 to kmod-31, and could not boot due to an
>> inability to load any module.  Any invocation of insmod bombs with,
>> "decompression failed with status 6".  I strace'd the issue to the
>https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1050586

duplicate of https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1050582 ?

Maybe that patch needs to propagate back to 6.5?

Lucas De Marchi

>
>-- 
>ciao,
>Marco
>
