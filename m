Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6121EB23
	for <linux-modules@vger.kernel.org>; Wed, 20 Mar 2024 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710919007; cv=fail; b=OdVsFFRePVt4W5PebgxATPpp5oj4xdm19oX+c0bX/AChrCtv8Rf0ATv1/Xt8FDjlvgP9T0LPEbBH90dX82PcB2O4b2DO3fGCRNsyvGqF+zp1Lb/FV8pwjIzHIIU15D16SBaSV2Oi3DcaP/26D2r6GtX4iOBLsQaKHaitgHhuzRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710919007; c=relaxed/simple;
	bh=fesRaWz2j4t2sCgbBbKPXpipFNTQFaCU8BlbmP5jCbY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l3m2HSwxFUIloWjPOXHZHLrcy4cB4E5wvwpgT8YuqKz3Ct0YSGEZkRlS7mU7rWCkW/Db6KQBGipaOYZFW+r/Otq5dpqa8rKye1XYdDYYohOF5OIq3oO0X8wq1SlN+pw1AfCcNsaVDStz4ek7UTLP1oO75rQSMDESLj86QZ6K08s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqW2fV+O; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqW2fV+O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710919006; x=1742455006;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=fesRaWz2j4t2sCgbBbKPXpipFNTQFaCU8BlbmP5jCbY=;
  b=CqW2fV+Ou+85rJpFN5OpqxqLFlb/GHEk0mTFNa1XTu6NiOJq+vbaKGuT
   aYnd/G4KeZt3BdaeyLRolMxU2AV3Z+bk6x27PzUU1uaUmc7RsscGmbsgJ
   Gz/s0xSDbv6Rf26kxj2J4aqu0anbDB71FQFas2zSjWSwoXXjU3ROImCkF
   vGL3j/ofrMUsrlJd9d7VY1G5fr1zMHvteVYE0X5P5AXAdXOmYvXC6Xsua
   XwW6IKegIQo42FeYUpCDRHdZbIWSAhwZb+X1EfcjezageyEduO1p16Dww
   HBoUjj+WgrrjdUZLrxCZh6knVTUhOevI2z+u0Zs6HA1v8MmsTHYonAM4E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="6436971"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="6436971"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 00:16:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="14070268"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 00:16:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 00:16:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 00:16:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 00:16:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtXOgQ/rmosgsK/FnCeIKM/xLW6MAkQpMjDmgaK0QglbJINpsLFjLJ/5pcN3GvIx3H8Eu5WAet43j57Buftzu9iyWO1knKllS+CC6GZXUwYJUTAqOWBCBFmq5hDaA63TPfHlYajQeei2GjqPA2vG4jk5QypVYe1AGo4WiQ9E88DGTpYFn3nNKJqon1iHR0UYUBi/Itp6TtPGsRqEDNGRQ+3cyeHpHF67MwYuBZiIMumgj70QiV/w9R97bjZsXRXOqrhmEfrER7VAD9g62pB2dphJlfhiGLxdXbzWO5wdyoOTpzS6DlS4KmOa7VOhfBntBrmSb6p4qieW8GfHBkrqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bFdtS6SA14ArI/pyQwTwvvWyvlPkxNxVTK32vCfINs=;
 b=Mm6sasYJCaxqk10fYSAUMAcCmZHl/nKlMWOyE79IE+TzSn7P6y4frAvusKCOsJ2h5l78GGu/prkW+TFsu8GlusO785oXKGRC9bkOxlD2aP8ArQ+FJn77F7NjVyPUFJd9kMfq3VlMTqumicPRnrMSzRFghqUxnF5ltB9mWkB4LBrFKJQ+sbdHMKoWAIt/DpdTDMTA0zZ2+e8yuOMhiTnLsWznl9A0j9ErTOVh9xLVSZbdEwhh/9X3Xec0zYMQMc93pUWVCsmK2yf+Wh1h5n/faDalDiCgKAZbDXQAG2tkRmV7hjPTB+pQUqx6+/jhc6N/JI2Uk+cEV6rPyMUPvnNqkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DS0PR11MB7650.namprd11.prod.outlook.com (2603:10b6:8:151::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Wed, 20 Mar
 2024 07:16:35 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::e9dd:320:976f:e257%4]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 07:16:35 +0000
Date: Wed, 20 Mar 2024 02:16:28 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: <linux-modules@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Emil Velikov <emil.velikov@collabora.com>, Marco d'Itri <md@linux.it>,
	Gustavo Sousa <gustavo.sousa@intel.com>
Subject: Re: [PATCH kmod] libkmod: add user soft dependecies
Message-ID: <wleo3wydlkqka5x276w6kl3g4jqii3ddpsjrp2cypmraxuyuc4@g6tn45owkssw>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240318161517.58550-1-jtornosm@redhat.com>
X-ClientProxiedBy: SJ0PR05CA0119.namprd05.prod.outlook.com
 (2603:10b6:a03:334::34) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DS0PR11MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8ed707-56d0-48e9-ce94-08dc48adad3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtiwHUcQHEo8o4x3mHwGvEWSxST0RVdDhwUFAXhI44aGOoYAhOs9if7H/lzsqqqOq++oVnE6IbT4NswLwkjvQnjHZFwrBcSZR1RXGNs4dmQa9bkmxHzleRIuesA2bf2z7ajfJnop15tEnC3gnlgGsYz7b10es6SombrPL/ZP+cuo2T69EngprKrsnAYbm1XU4n3AsH0HepRqF8TfdbZ1ob8fizCVRutDadOe1k9ibdvUc+2ZwuEqpDXqmFkegxLhwiYDx4CG8t8AXtg2Y0vFATjrynWCbfr4cvfaqRlUcm3uL+VTHe3Kh3ectckos4i7Rus0xqeeSl3JyGsFAtoWap0bZj2jU09Vtkxry8ijWenmQSg/NZ1fz4xYqhVlm9S4obBjPU8QJuu64cuMARvpqi+abrp2uPXgRYXlweCvzj4BELHKHx6S5BEZiUB8fRV6SQ9R7W2TyT1V0hhENNZI9eu8e9Wed1hrtMfgxwYqpRiYHYmpwqgg9dHXjBDAhmXGMGBsmpDBHhFzJD2JvVe+XHk1K98kbSfR2wnkIhN7WtdATQtt3/cQUq47KQMlF2r4pUO0pyognrYT4YcoD0bxsZuduIcIWZEoloWJUPve0bVulH1PjKblMzTA9oOMQx3uR4UKXp02W1Cc4P25hzZpESssxM/eU+Bat4Lhq717x5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5yCPW+JFDwnWJP2QGBz5NSjmCABjIgDoMiIDo8Uv65a2gt0r/wE1e0y4i/R5?=
 =?us-ascii?Q?fkOHk7np+WY+20NGonjqmBa8itRbr4tR3qlxV/bYTZ65vkxQD1j8TQPEz2JU?=
 =?us-ascii?Q?GhfFgQxy2U6PTZ2Era7uSErt4pOKbdYQGxbA3itqLoyLF60PjnNfBNttxD0v?=
 =?us-ascii?Q?2rIqJN5Ypaaj+6mplfcY45IZXhh4LrhXnj5UAbkWWbiE3s9VHPCrARfOOGpv?=
 =?us-ascii?Q?0CFwzrGhkty9Za39R8Jb1upfYmELnjICtEVHeDpRAtNyaX+qkpxFp5KCBNVz?=
 =?us-ascii?Q?SJySq6vWhJpiCqHqlNZ672G8RqQhSA7G1E2Hta+zbNiYpqvyaqXTjF1BxwRM?=
 =?us-ascii?Q?bBZWMjFGyIHKBBo0LMgRnQLUdxLwicannUfDMp8HbSfhegX3G4bK9RGVSxCF?=
 =?us-ascii?Q?kz0X/Y+RCGlj1DiHLziz3dbFuTtgpIWSE1PJZOYwEISv10nDF0FFS5AMYM/v?=
 =?us-ascii?Q?eIcpNwkXUm3qHrYcvjjkz0M/26a7RP7UPf+P3Dl37JsTn+NBejqr9ERrg0J5?=
 =?us-ascii?Q?mLa4+NoqgBREfK897DYV7x9ZJ4j4IWVEvr/4p7THq9oMB3O8NCEEtTzVM7hf?=
 =?us-ascii?Q?XAqayFfnChYjAqiD0aOlr3B0Rgr3J767r6vA7JBinStEQBjQ8sUOwiZXDYZW?=
 =?us-ascii?Q?8eyWrSFp6fIAu18O7HShBvfV4Nvogk6pukMc+0B9b4faQLXcHXvDRedXfM1k?=
 =?us-ascii?Q?xnwm6L5g+CYsJJzvoVCdQ2oKqXC08b77DXBKlIQBUo5it2TUyU0Z9OQFOYrb?=
 =?us-ascii?Q?0XUHeBFXyDqv+LcXD+tjXfQqgrcuZn/gjiLbGYpe0WbRo0WvLaZrZ6UQYmbB?=
 =?us-ascii?Q?X5zA88RRCPqpwWGWTQZXoa9QJcnmms9V41LNDdHh1BH6WdFW8xRjuv3Wam1A?=
 =?us-ascii?Q?cdw867RvqBrK6mMgqBRPZ/kXYPUzOgbloWoEgzMSTaJiVN2+1VrkHCeUJJ3e?=
 =?us-ascii?Q?TwckwWjacckhQ+4XOk7C73YWJRmej4IWeAWq0VzKDdn8APLaMMaIFx+E3cvz?=
 =?us-ascii?Q?bRhu8VT5WtXBNTVxg2LfKdg25hYeJv8rZWIhgUW0WtVdvQPu8OkE0Z5eTxml?=
 =?us-ascii?Q?ErChjeIRPEwCmsK0/jX1FjEbEbClXhIyhDLzXYmP8kxcvJRbsivAG54Z8E9J?=
 =?us-ascii?Q?OlAbvhcJsk4Ff9NXJuXVy53HWV0nfRBkpTfd/g4scNkjNu0UVLgTgQY0eNMx?=
 =?us-ascii?Q?z8tDE38wL5rKrGKw3nMCLoiRw0OrYHgn1DViPirg0ZFnjDGQO5kcSYGi33Ny?=
 =?us-ascii?Q?/ysKkvLlcrcLd5xs/0F1j3lsvThyoI/ENvzlV+wi9Q5Wd+gKTNdMAMjteGl0?=
 =?us-ascii?Q?4k1oQ/dNVVxwGO6GTEzVddcPIK/RqgOU4YRlv7V+KKwJxqRmEQDPhoiZIalo?=
 =?us-ascii?Q?hfkeaJJZIKPAAtqoT57zz4fn0KNDIdq+35EAuv1gT7xPslwry9xXJ36dI/Or?=
 =?us-ascii?Q?qzQBvBArwAB64IkB4pV7hrjhRsyNqPxuvRPvnxKJtop+rv7hl5U0Pn26W6bN?=
 =?us-ascii?Q?PaJhKBHRWTIb5uPp9NFXVNcTN4mkb87Y2VMyoFp9J/rMvK0m0D7USwGdABoj?=
 =?us-ascii?Q?0MNmSMtNSJqkJlLWeYxe8xrPGfQyTP00wnb0dMPqmiLTPgP0YhGCxlAgNhT/?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8ed707-56d0-48e9-ce94-08dc48adad3a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 07:16:35.4325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBTs6itKCMqw8IN0A8EK8YgQ52KlDiUIu6cFy1E/cIu7B6EETFkwk8qlagrQBrbdkJENwfwF6uLA+J0lcxZHLN7YJfVKvkRfMeexW/4WVr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7650
X-OriginatorOrg: intel.com

On Mon, Mar 18, 2024 at 05:15:14PM +0100, Jose Ignacio Tornos Martinez wrote:
>It has been seen that for some network mac drivers (i.e. lan78xx) the
>related module for the phy is loaded dynamically depending on the current
>hardware. In this case, the associated phy is read using mdio bus and then
>the associated phy module is loaded during runtime (kernel function
>phy_request_driver_module). However, no software dependency is defined, so
>the user tools will no be able to get this dependency. For example, if
>dracut is used and the hardware is present, lan78xx will be included but no
>phy module will be added, and in the next restart the device will not work
>from boot because no related phy will be found during initramfs stage.
>
>In order to solve this, we could define a normal 'pre' software dependency
>in lan78xx module with all the possible phy modules (there may be some),
>but proceeding in that way, all the possible phy modules would be loaded
>while only one is necessary.
>
>The idea is to add a new attribute when the software dependency is defined,
>apart from the normal ones 'pre' and 'post', I have called it 'user', to be
>used only by the user tools that need to detect this situation. In that
>way, for example, dracut could check the 'user' attribute of the modules in
>order to install these software dependencies in initramfs too. That is, for
>the  commented lan78xx module, defining the 'user' attribute to the
>software dependency with the possible phy modules list, only the necessary
>phy would be loaded on demand keeping the same behavior but all the
>possible phy modules would be available from initramfs.
>
>A new function 'kmod_module_get_user_softdeps' in libkmod will be added for
>this to avoid breaking the API and maintain backward compatibility. This
>general procedure could be useful for other similar cases (not only for
>dynamic phy loading).

so it's basically a pre softdep, but without libkmod (userspace) trying
to load it before the module requested. So, it's "softer than soft" or
even "something before pre".

Thinking this way I find the name chosen odd, as the *user*space side of
module loading will actually *not* look into those deps.

Cc'ing some more people for suggestions, as I only know I don't like
"user", but my suggestions may considered equally bad too:

	dull / still / early / runtime_request / maybe

Anyway, we will need to explain exactly what this is about in
modprobe.d(5).  Other than the use case of creating a initramfs and not
missing any module, I don't think there would be any, right?


Lucas De Marchi

>
>Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
>---
> libkmod/docs/libkmod-sections.txt |  1 +
> libkmod/libkmod-config.c          | 66 +++++++++++++++++++++++++++----
> libkmod/libkmod-internal.h        |  1 +
> libkmod/libkmod-module.c          | 50 +++++++++++++++++++++++
> libkmod/libkmod.h                 |  2 +
> libkmod/libkmod.sym               |  1 +
> 6 files changed, 114 insertions(+), 7 deletions(-)
>
>diff --git a/libkmod/docs/libkmod-sections.txt b/libkmod/docs/libkmod-sections.txt
>index 33d9eec..04743e4 100644
>--- a/libkmod/docs/libkmod-sections.txt
>+++ b/libkmod/docs/libkmod-sections.txt
>@@ -62,6 +62,7 @@ kmod_module_remove_module
> kmod_module_get_module
> kmod_module_get_dependencies
> kmod_module_get_softdeps
>+kmod_module_get_user_softdeps
> kmod_module_apply_filter
> kmod_module_get_filtered_blacklist
> kmod_module_get_install_commands
>diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
>index e83621b..c0e15be 100644
>--- a/libkmod/libkmod-config.c
>+++ b/libkmod/libkmod-config.c
>@@ -54,8 +54,10 @@ struct kmod_softdep {
> 	char *name;
> 	const char **pre;
> 	const char **post;
>+	const char **user;
> 	unsigned int n_pre;
> 	unsigned int n_post;
>+	unsigned int n_user;
> };
>
> const char *kmod_blacklist_get_modname(const struct kmod_list *l)
>@@ -110,6 +112,12 @@ const char * const *kmod_softdep_get_post(const struct kmod_list *l, unsigned in
> 	return dep->post;
> }
>
>+const char * const *kmod_softdep_get_user(const struct kmod_list *l, unsigned int *count) {
>+	const struct kmod_softdep *dep = l->data;
>+	*count = dep->n_user;
>+	return dep->user;
>+}
>+
> static int kmod_config_add_command(struct kmod_config *config,
> 						const char *modname,
> 						const char *command,
>@@ -263,11 +271,11 @@ static int kmod_config_add_softdep(struct kmod_config *config,
> 	struct kmod_softdep *dep;
> 	const char *s, *p;
> 	char *itr;
>-	unsigned int n_pre = 0, n_post = 0;
>+	unsigned int n_pre = 0, n_post = 0, n_user = 0;
> 	size_t modnamelen = strlen(modname) + 1;
> 	size_t buflen = 0;
> 	bool was_space = false;
>-	enum { S_NONE, S_PRE, S_POST } mode = S_NONE;
>+	enum { S_NONE, S_PRE, S_POST, S_USER } mode = S_NONE;
>
> 	DBG(config->ctx, "modname=%s\n", modname);
>
>@@ -298,6 +306,9 @@ static int kmod_config_add_softdep(struct kmod_config *config,
> 		else if (plen == sizeof("post:") - 1 &&
> 				memcmp(p, "post:", sizeof("post:") - 1) == 0)
> 			mode = S_POST;
>+		else if (plen == sizeof("user:") - 1 &&
>+				memcmp(p, "user:", sizeof("user:") - 1) == 0)
>+			mode = S_USER;
> 		else if (*s != '\0' || (*s == '\0' && !was_space)) {
> 			if (mode == S_PRE) {
> 				buflen += plen + 1;
>@@ -305,6 +316,9 @@ static int kmod_config_add_softdep(struct kmod_config *config,
> 			} else if (mode == S_POST) {
> 				buflen += plen + 1;
> 				n_post++;
>+			} else if (mode == S_USER) {
>+				buflen += plen + 1;
>+				n_user++;
> 			}
> 		}
> 		p = s + 1;
>@@ -312,11 +326,12 @@ static int kmod_config_add_softdep(struct kmod_config *config,
> 			break;
> 	}
>
>-	DBG(config->ctx, "%u pre, %u post\n", n_pre, n_post);
>+	DBG(config->ctx, "%u pre, %u post, %u user\n", n_pre, n_post, n_user);
>
> 	dep = malloc(sizeof(struct kmod_softdep) + modnamelen +
> 		     n_pre * sizeof(const char *) +
> 		     n_post * sizeof(const char *) +
>+		     n_user * sizeof(const char *) +
> 		     buflen);
> 	if (dep == NULL) {
> 		ERR(config->ctx, "out-of-memory modname=%s\n", modname);
>@@ -324,9 +339,11 @@ static int kmod_config_add_softdep(struct kmod_config *config,
> 	}
> 	dep->n_pre = n_pre;
> 	dep->n_post = n_post;
>+	dep->n_user = n_user;
> 	dep->pre = (const char **)((char *)dep + sizeof(struct kmod_softdep));
> 	dep->post = dep->pre + n_pre;
>-	dep->name = (char *)(dep->post + n_post);
>+	dep->user = dep->post + n_post;
>+	dep->name = (char *)(dep->user + n_user);
>
> 	memcpy(dep->name, modname, modnamelen);
>
>@@ -334,6 +351,7 @@ static int kmod_config_add_softdep(struct kmod_config *config,
> 	itr = dep->name + modnamelen;
> 	n_pre = 0;
> 	n_post = 0;
>+	n_user = 0;
> 	mode = S_NONE;
> 	was_space = false;
> 	for (p = s = line; ; s++) {
>@@ -362,6 +380,9 @@ static int kmod_config_add_softdep(struct kmod_config *config,
> 		else if (plen == sizeof("post:") - 1 &&
> 				memcmp(p, "post:", sizeof("post:") - 1) == 0)
> 			mode = S_POST;
>+		else if (plen == sizeof("user:") - 1 &&
>+				memcmp(p, "user:", sizeof("user:") - 1) == 0)
>+			mode = S_USER;
> 		else if (*s != '\0' || (*s == '\0' && !was_space)) {
> 			if (mode == S_PRE) {
> 				dep->pre[n_pre] = itr;
>@@ -375,6 +396,12 @@ static int kmod_config_add_softdep(struct kmod_config *config,
> 				itr[plen] = '\0';
> 				itr += plen + 1;
> 				n_post++;
>+			} else if (mode == S_USER) {
>+				dep->user[n_user] = itr;
>+				memcpy(itr, p, plen);
>+				itr[plen] = '\0';
>+				itr += plen + 1;
>+				n_user++;
> 			}
> 		}
> 		p = s + 1;
>@@ -395,14 +422,15 @@ static int kmod_config_add_softdep(struct kmod_config *config,
> static char *softdep_to_char(struct kmod_softdep *dep) {
> 	const size_t sz_preprefix = sizeof("pre: ") - 1;
> 	const size_t sz_postprefix = sizeof("post: ") - 1;
>+	const size_t sz_userprefix = sizeof("user: ") - 1;
> 	size_t sz = 1; /* at least '\0' */
>-	size_t sz_pre, sz_post;
>+	size_t sz_pre, sz_post, sz_user;
> 	const char *start, *end;
> 	char *s, *itr;
>
> 	/*
>-	 * Rely on the fact that dep->pre[] and dep->post[] are strv's that
>-	 * point to a contiguous buffer
>+	 * Rely on the fact that dep->pre[] dep->post[] and dep->user[]
>+	 * are strv's that point to a contiguous buffer
> 	 */
> 	if (dep->n_pre > 0) {
> 		start = dep->pre[0];
>@@ -422,6 +450,15 @@ static char *softdep_to_char(struct kmod_softdep *dep) {
> 	} else
> 		sz_post = 0;
>
>+	if (dep->n_user > 0) {
>+		start = dep->user[0];
>+		end = dep->user[dep->n_user - 1]
>+					+ strlen(dep->user[dep->n_user - 1]);
>+		sz_user = end - start;
>+		sz += sz_user + sz_userprefix;
>+	} else
>+		sz_user = 0;
>+
> 	itr = s = malloc(sz);
> 	if (s == NULL)
> 		return NULL;
>@@ -456,6 +493,21 @@ static char *softdep_to_char(struct kmod_softdep *dep) {
> 		itr = p;
> 	}
>
>+	if (sz_user) {
>+		char *p;
>+
>+		memcpy(itr, "user: ", sz_userprefix);
>+		itr += sz_userprefix;
>+
>+		/* include last '\0' */
>+		memcpy(itr, dep->user[0], sz_user + 1);
>+		for (p = itr; p < itr + sz_user; p++) {
>+			if (*p == '\0')
>+				*p = ' ';
>+		}
>+		itr = p;
>+	}
>+
> 	*itr = '\0';
>
> 	return s;
>diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
>index 26a7e28..8e4f112 100644
>--- a/libkmod/libkmod-internal.h
>+++ b/libkmod/libkmod-internal.h
>@@ -145,6 +145,7 @@ const char *kmod_command_get_modname(const struct kmod_list *l) __attribute__((n
> const char *kmod_softdep_get_name(const struct kmod_list *l) __attribute__((nonnull(1)));
> const char * const *kmod_softdep_get_pre(const struct kmod_list *l, unsigned int *count) __attribute__((nonnull(1, 2)));
> const char * const *kmod_softdep_get_post(const struct kmod_list *l, unsigned int *count);
>+const char * const *kmod_softdep_get_user(const struct kmod_list *l, unsigned int *count);
>
>
> /* libkmod-module.c */
>diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
>index 585da41..dbe676c 100644
>--- a/libkmod/libkmod-module.c
>+++ b/libkmod/libkmod-module.c
>@@ -1664,6 +1664,56 @@ KMOD_EXPORT int kmod_module_get_softdeps(const struct kmod_module *mod,
> 	return 0;
> }
>
>+/**
>+ * kmod_module_get_user_softdeps:
>+ * @mod: kmod module
>+ * @user: where to save the list of user soft dependencies.
>+ *
>+ * Get user dependencies for this kmod module. Soft dependencies come
>+ * from configuration file and are not cached in @mod because it may include
>+ * dependency cycles that would make we leak kmod_module. Any call
>+ * to this function will search for this module in configuration, allocate a
>+ * list and return the result.
>+ *
>+ * @user is newly created list of kmod_module and
>+ * should be unreferenced with kmod_module_unref_list().
>+ *
>+ * Returns: 0 on success or < 0 otherwise.
>+ */
>+KMOD_EXPORT int kmod_module_get_user_softdeps(const struct kmod_module *mod,
>+						struct kmod_list **user)
>+{
>+	const struct kmod_list *l;
>+	const struct kmod_config *config;
>+
>+	if (mod == NULL || user == NULL)
>+		return -ENOENT;
>+
>+	assert(*user == NULL);
>+
>+	config = kmod_get_config(mod->ctx);
>+
>+	kmod_list_foreach(l, config->softdeps) {
>+		const char *modname = kmod_softdep_get_name(l);
>+		const char * const *array;
>+		unsigned count;
>+
>+		if (fnmatch(modname, mod->name, 0) != 0)
>+			continue;
>+
>+		array = kmod_softdep_get_user(l, &count);
>+		*user = lookup_softdep(mod->ctx, array, count);
>+
>+		/*
>+		 * find only the first command, as modprobe from
>+		 * module-init-tools does
>+		 */
>+		break;
>+	}
>+
>+	return 0;
>+}
>+
> /**
>  * kmod_module_get_remove_commands:
>  * @mod: kmod module
>diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
>index 7251aa7..ec6d270 100644
>--- a/libkmod/libkmod.h
>+++ b/libkmod/libkmod.h
>@@ -196,6 +196,8 @@ const char *kmod_module_get_remove_commands(const struct kmod_module *mod);
> struct kmod_list *kmod_module_get_dependencies(const struct kmod_module *mod);
> int kmod_module_get_softdeps(const struct kmod_module *mod,
> 				struct kmod_list **pre, struct kmod_list **post);
>+int kmod_module_get_user_softdeps(const struct kmod_module *mod,
>+					struct kmod_list **user);
> int kmod_module_get_filtered_blacklist(const struct kmod_ctx *ctx,
> 					const struct kmod_list *input,
> 					struct kmod_list **output) __attribute__ ((deprecated));
>diff --git a/libkmod/libkmod.sym b/libkmod/libkmod.sym
>index 0c04fda..26c3eef 100644
>--- a/libkmod/libkmod.sym
>+++ b/libkmod/libkmod.sym
>@@ -42,6 +42,7 @@ global:
>
> 	kmod_module_get_dependencies;
> 	kmod_module_get_softdeps;
>+	kmod_module_get_user_softdeps;
> 	kmod_module_get_filtered_blacklist;
>
> 	kmod_module_get_name;
>-- 
>2.44.0
>
