Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B333BC433FE
	for <linux-modules@archiver.kernel.org>; Wed,  9 Nov 2022 08:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKIIIh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 9 Nov 2022 03:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIIIf (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 9 Nov 2022 03:08:35 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A241D18383
        for <linux-modules@vger.kernel.org>; Wed,  9 Nov 2022 00:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667981314; x=1699517314;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qOiKsLf2FhXMuvaixSCmYQUBrxURgUFaOjrY40JI4aE=;
  b=iNNdfq92voDIVlDwJQ+OvPnHvMeXfcG4P83hc0xuCHn73vIZJgCH2X3c
   B3r1oQEDXjkmb0WeDbQg8DrHQMTT7ETxDzEHtc0YlZ92Vkt8ChtlrXJN1
   nFG2qHfZWAWsDH/QOogsebcALj3Tb3ZyZ982cLojt+M9oUUOlnlgUHDuM
   zdFBbS+XK1XnwNo8sXMVJcbFAXynEcWFRi48V6upX5mddstzMTFwp2PNS
   Ld1tl5fOM5pMP4SVDB7BUhZcUpvP006ClzE8CAnKFN8byExUiJig1UfFo
   qmLFdeW6e6C+QnO4ucqxclCxULHelFJJ9eNsg3ewXT0rU+U2drZsYydUF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="291306887"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="291306887"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 00:08:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="700261597"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="700261597"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 09 Nov 2022 00:08:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 00:08:33 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 00:08:33 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 00:08:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2Jsvz318ob11puvkSLafkIrSguGJAX3xWlOdYLlLN6MRNsHCDIJwVkvn7BOG3lvVSYVR0OnA+1c8kiYn/8w16vWhmkOPBkC2ZyD136YFCYGKJRTxg96WAMyN8x6B5lqG+ejQukuWJVhcGzz2e2FYR5I2c+99LLjAT6OE/i5hAAl20tbMaZOFsB8HpBDjLbwSC4mp5u/q3ZYFiiecwigN/hPdhoEMI7Bnaxcyxp9C3ZNyLJdNgDLe/3HpqS25RNDVjmUNZFAFz8GLNMTNh3D5ijyYoAdedHb20ZOF9JUcYvzqWo81Rt4Pml3SsyxqQ8u1Eo1xaNQok7/Jf7qettsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naSYGCwzedSOBwLz3CsOnPyO9NijD4g+vEucPNoKkj0=;
 b=kU3imqDlmRLAaRTxvOGyWgK4CYUJvCLy5JmxhRvXfY7DmsCJGYIMFt/mE7NeruP1Qq/KjWITyb6yWLvi1qzt7mxU98UDmxn4qVYurF+SaLa+wcGaDfcqK4ZH6bfhFr6TWG376GCncfIuJsfBL95WkkIwJvmEXeLX3kgblVCP6SrOjoaOByM17owBt5qotZ+DhU4JhwfqxfKe5ITzNz2Fuu0azztmt4nvSqRAPg/TYdOIWD1enpr2iwIm+osny6yGHAF+UyHuLpPHJJRzXk7hWyC3RNetXelygJhtOoK207DxmOv9nmmsfj/C8oNC7JZC/Y3+h8ZbtjbWFjD5o//hZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DS0PR11MB7559.namprd11.prod.outlook.com (2603:10b6:8:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 08:08:32 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::22:fdef:cea5:e8f3]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::22:fdef:cea5:e8f3%3]) with mapi id 15.20.5791.025; Wed, 9 Nov 2022
 08:08:32 +0000
Date:   Wed, 9 Nov 2022 00:08:29 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     <linux-modules@vger.kernel.org>
Subject: Re: semantics of --ignore-install
Message-ID: <20221109080759.i4lqmcct4g7gffjz@ldmartin-desk2.lan>
References: <Y1MOq6VZQRFT3Uib@bongo.bofh.it>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1MOq6VZQRFT3Uib@bongo.bofh.it>
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DS0PR11MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 344d9ab4-91c9-4b6b-1a9c-08dac2299781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: weo1UscwK4RNIa8HA/UrPojHqUx0PFwfSpS8R+S3jLSlRjw4r+Lc7rLTRGYs5z9kma1h0IyhxepIfQei10JCjvQW4pouZmwHDKvqs6XThGSoKdOZ0dzrza0zD9PYqM17zbI57F99Yqv7SCsn2GCfnLVXbKQcRRWeTcdzqhQc+/PGbs/19M1PLhsE24m4UgvUJjr+jWuR2Oxh2SBXm6EkdGzS25nV6jjRKDNsVqRgFpRQYjK/iRfZj20sJRPzj5TQuWRwmNQypGMvc7bmadU/TE816Q3I34gYhntw7i9VeUUXpSGJh48c5UvbVy6I+PXXaydIE4TsLu+kOB2AVdvg/mhQQNDo9EKuXogFuYx6iibVyha85jxQjiYkx9V0soPMwsdo5Hual6hh2xcCHVHwuC4KFKpeCffrUYnJziMv3+Uv0FUR2d5OsjpGSCHm1kMMcfFvQ02gpbBQdW/CdXAXnkL785wK207pkb7015W46bjcyF8BS6vGoW4fWgiVXpY/xybgboKSRkfSS2R8z19K/TZxpGivgoHjMia31ax/EJyq/AvB0W+72NW9w4Fod73Mx/cIRblnsIX5hDpJaDS849L6wzs6IfOdtZkJCDozp8qaKZfJ4gCSHZ+9v34KaqvwBhRdYBpbSBVnL9xUuPi5RlGqqJOMLw1O6lVn1gh3oPrS696SJNRjp5Uk0qvOFF4G9PzucRwl+c/NYnUWzTFzVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199015)(6486002)(86362001)(66946007)(6666004)(478600001)(8676002)(41300700001)(6512007)(6916009)(9686003)(316002)(26005)(5660300002)(186003)(1076003)(6506007)(36756003)(83380400001)(66476007)(82960400001)(2906002)(66574015)(66556008)(8936002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ifhwODL3uzPV7Bzz23FV+kzsAngvBzGlzkAiXuHEtoPnkj+eUavwMRcU0+?=
 =?iso-8859-1?Q?M1lyLVicrnZqiUv3PbgMRa+J/gFOEQZjCfIHfYWvs14vB+ENGRjBQIFIm+?=
 =?iso-8859-1?Q?1mEQ4UIS0a3f7bsszBZP8mRZW6C33Amnz5px1jSyLFyufqlQKk3Ctmg3ek?=
 =?iso-8859-1?Q?XLhY5WfnnRrrBGU1N7G1N2ECGTZZgSwcIp0+nZkPu0oJJmBnpOqpcFt0QK?=
 =?iso-8859-1?Q?+b6mg1bmxh3SIKifE63D8DphacEQ6MOgOiIZ9kWIknlK6yTIln2c337XGH?=
 =?iso-8859-1?Q?vAWAPwxWkU98/cv+oQop1T9luVUrfwbCpkaJ6p6ctb1RoY0ABvCAiFzGjs?=
 =?iso-8859-1?Q?v6TE8NHc1DRs9r/HAu0yOnqaFOwRxX5/CvoMJlhTB06FGses466dPUkNZT?=
 =?iso-8859-1?Q?2U5qn1bt9Sf/U0LVcqhYn6HVYPYdYeH1GNDz34B6xRwKiJRx47F/5j+xTf?=
 =?iso-8859-1?Q?69FiWPQ0WDYw3qOXN6d5+RnvHMHRJvL0tIRI4KURADUYkfDG9ylbf/mbef?=
 =?iso-8859-1?Q?rbB2ZjoKareklOrF52LDfWbD5cWHC/2ZfMPCEgSwrn1O0FjiPdkjhpdYeq?=
 =?iso-8859-1?Q?oeXZI51SBij1Fg1PTrVAsf7fzpJ7vagD5d4TZK4/HtSUGcVMSTemB4KDr8?=
 =?iso-8859-1?Q?KSHJOo/f3FdaH7zrS4dUd61vYAll7MINBPEJoYBV3lT2CthSQsuoCgf6X7?=
 =?iso-8859-1?Q?vAQuTp3YpkjWImaM34AYhXDd2w27QZptx2bce85STo0HQEdQ56I419zIkj?=
 =?iso-8859-1?Q?7XwWEC0rCfOzJL5pxZmNVQkkUb+uZRoHuFo6c5ubwle8pL6cgKukyBd5S4?=
 =?iso-8859-1?Q?wzDNe/WkAWtJJdOJa5E7T8zQIOmZ0YmNqm2S1KJExxRDfnQ1oYsgUz/YC+?=
 =?iso-8859-1?Q?iwjcf4JcYlNvic3xbXXR1KYs4CditYPc2kCQuco8MkN1BPFq/Q5LcTm+6j?=
 =?iso-8859-1?Q?91XPE3ifLC0hj4fnC+fcMhQtG5s772AeHR8cYN/sH/JiB3TZ6GKGcCLN/S?=
 =?iso-8859-1?Q?+pc/qz8VSKBGc+i8Uow+NLy5gZVIY1hMol75Jph7houDP3va7a1is7lKUI?=
 =?iso-8859-1?Q?45T666DrswHWYkvheZ8o8BInM51mgOmHnz636NhPWWNUwTHLO35vDk+2he?=
 =?iso-8859-1?Q?EzrOXdHAoNc4E96PwWx0okfoXN0O807h4Y3FnkGrflhwbyypC4oB80GTO0?=
 =?iso-8859-1?Q?uOYlHj0Pjm2R/7ni3N2HUcJEBgidBhM/4x7cpi9qfAwGBuHonLNOcQ3b4f?=
 =?iso-8859-1?Q?peJ8UK77Ftgii4IqrvHqzWfhH4iCBzUNb0LsBlOVyRD2UCxBNMH830ju9t?=
 =?iso-8859-1?Q?FvFcjNQVzxlz72tYdjTWL2vUPu+rAn0vos2nLXQVhuT1jnEvkBqmfKW/a1?=
 =?iso-8859-1?Q?cVuq3CqqBRMNx8YbDzdLGLnfYIkG8krk2NO4ZqcbqBoA6d6oSzsxK6IZcT?=
 =?iso-8859-1?Q?XQQ3wT05KkSo2Gm/S3XB7s4ROsXN7jPnFQFgR1JdqjoKTKxl83D2644qG8?=
 =?iso-8859-1?Q?X05BFW7HKklJQEOnUexo+mdBFZN5GdsKhAdqAZ5kfaJEYBPAf6dL6mpVej?=
 =?iso-8859-1?Q?TFrVK4OMv0tsFl9npg4+mQDO81tqum2XVR1Wda/XVndRuBf2bGDtnKxSZ1?=
 =?iso-8859-1?Q?bOjEGXvWKdbHCFjRs5P2tCpXrJurmgNbRAIHaVmnaTssvqEv90N1522w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 344d9ab4-91c9-4b6b-1a9c-08dac2299781
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 08:08:31.9801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYIMxTNaF8JFVsiDXZwniVXm9fpQsfJhM5WyDu3ACwZ0HmO3K7Mx2pVdxUgWJrl98+wNzQiGdyygL3VwkF5ruUkURT24sHIKeg0Bv5WggWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7559
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Oct 21, 2022 at 11:27:07PM +0200, Marco d'Itri wrote:
>Bug or feature?
>
>diff -U 0 \
>  <(modprobe -q --show-depends nfs) \
>  <(modprobe -q --show-depends nfs --ignore-install)

--ignore-install only applies to the module you are passing in the
command line, not its dependencies. From MODPROBE(8):

        -i, --ignore-install, --ignore-remove
	   This option causes modprobe to ignore install and remove
	   commands in the configuration file (if any) for the module
	   specified on the command line (any dependent modules are
	   still subject to commands set for them in the configuration
	   file). Both install and remove commands will currently be
	   ignored when this option is used regardless of whether the
	   request was more specifically made with only one or other
	   (and not both) of --ignore-install or --ignore-remove. See
	   modprobe.d(5).

There is also a warning in modprobe.d man page:

COMPATIBILITY
        A future version of kmod will come with a strong warning to avoid
        use of the install as explained above. This will happen once
        support for soft dependencies in the kernel is complete. That
        support will complement the existing softdep support within this
        utility by providing such dependencies directly within the
        modules.

At some point I stopped trying to remove it though as distros ship
these kind of tweaks 

Lucas De Marchi

>
>----- Forwarded message from Andras Korn <korn-debbugs@elan.rulez.org> -----
>
>From: Andras Korn <korn-debbugs@elan.rulez.org>
>To: Debian Bug Tracking System <submit@bugs.debian.org>
>Subject: Bug#1022172: /lib/modprobe.d/50-nfs.conf causes initramfs-tools to
>	stop including sunrpc module for nfs
>
>Package: kmod
>Version: 30+20220905-1
>Severity: important
>
>Hi,
>
>I noticed that the sunrpc module was strangely absent from my initramfs, which resulted in a failure to netboot (which is my justification for the severity).
>
>Upon examination, it turns out that the way module dependencies are worked out for initramfs generation depend on the output of this command:
>
># /sbin/modprobe --all --set-version="6.0.0-1-amd64" --ignore-install --quiet --show-depends nfs
>insmod /lib/modules/6.0.0-1-amd64/kernel/fs/netfs/netfs.ko
>insmod /lib/modules/6.0.0-1-amd64/kernel/fs/fscache/fscache.ko
>insmod /lib/modules/6.0.0-1-amd64/kernel/net/sunrpc/sunrpc.ko
>insmod /lib/modules/6.0.0-1-amd64/kernel/fs/nfs_common/grace.ko
>insmod /lib/modules/6.0.0-1-amd64/kernel/fs/lockd/lockd.ko
>insmod /lib/modules/6.0.0-1-amd64/kernel/fs/nfs/nfs.ko
>
>This, above, is what the output looked like with versions of nfs-kernel-server before 1:2.6.2-1+b1, which didn't ship /lib/modprobe.d/50-nfs.conf.
>
>With the new version of nfs-kernel-server, the output becomes:
>
># /sbin/modprobe --all --set-version="6.0.0-1-amd64" --ignore-install --quiet --show-depends nfs
>insmod /lib/modules/6.0.0-1-amd64/kernel/fs/netfs/netfs.ko
>insmod /lib/modules/6.0.0-1-amd64/kernel/fs/fscache/fscache.ko
>install /sbin/modprobe --ignore-install sunrpc $CMDLINE_OPTS && { /sbin/sysctl -q --pattern sunrpc --system; exit 0; }
>insmod /lib/modules/6.0.0-1-amd64/kernel/fs/nfs_common/grace.ko
>install /sbin/modprobe --ignore-install lockd $CMDLINE_OPTS && { /sbin/sysctl -q --pattern fs.nfs.n[sl]m --system; exit 0; }
>insmod /lib/modules/6.0.0-1-amd64/kernel/fs/nfs/nfs.ko
>
>This confuses manual_add_modules() from /usr/share/initramfs-tools/hook-functions, which expects to only see insmod lines, not install lines here.
>
>I thought --ignore-install was completely broken, but no, because without it, the output contains *more* "install" lines:
>
># /sbin/modprobe --all --set-version="6.0.0-1-amd64" --quiet --show-depends nfs
>insmod /lib/modules/6.0.0-1-amd64/kernel/fs/netfs/netfs.ko
>insmod /lib/modules/6.0.0-1-amd64/kernel/fs/fscache/fscache.ko
>install /sbin/modprobe --ignore-install sunrpc $CMDLINE_OPTS && { /sbin/sysctl -q --pattern sunrpc --system; exit 0; }
>insmod /lib/modules/6.0.0-1-amd64/kernel/fs/nfs_common/grace.ko
>install /sbin/modprobe --ignore-install lockd $CMDLINE_OPTS && { /sbin/sysctl -q --pattern fs.nfs.n[sl]m --system; exit 0; }
>install /sbin/modprobe --ignore-install nfs $CMDLINE_OPTS && { /sbin/sysctl -q --pattern fs.nfs --system; exit 0; }
>
>If the /lib/modprobe.d/50-nfs.conf shipped by nfs-kernel-server is valid, then modprobe --ignore-install doesn't handle it correctly; if it's invalid, then I suppose modprobe should print an error. There seems to be a problem with modprobe either way, unless initramfs-tools misunderstands the purpose of --ignore-install.
>
>Best regards,
>
>András
>
>-- System Information:
>Debian Release: bookworm/sid
>  APT prefers stable-security
>  APT policy: (500, 'stable-security'), (350, 'unstable'), (1, 'experimental')
>merged-usr: no
>Architecture: amd64 (x86_64)
>Foreign Architectures: i386
>
>Kernel: Linux 5.17.15-caeeng (SMP w/8 CPU threads; PREEMPT)
>Kernel taint flags: TAINT_PROPRIETARY_MODULE, TAINT_OOT_MODULE, TAINT_UNSIGNED_MODULE
>Locale: LANG=en_US.UTF-8, LC_CTYPE=hu_HU.UTF-8 (charmap=UTF-8), LANGUAGE=en_US.UTF-8
>Shell: /bin/sh linked to /bin/dash
>Init: runit (via /run/runit.stopit)
>LSM: AppArmor: enabled
>
>-- 
> Perl: The only language that looks the same before and after RSA encryption.
>
>----- End forwarded message -----
>----- Forwarded message from Marco d'Itri <md@Linux.IT> -----
>
>From: Marco d'Itri <md@Linux.IT>
>To: Andras Korn <korn-debbugs@elan.rulez.org>, 1022172@bugs.debian.org,
>	initramfs-tools@packages.debian.org, nfs-utils@packages.debian.org
>Subject: Bug#1022172: /lib/modprobe.d/50-nfs.conf causes initramfs-tools to
>	stop including sunrpc module for nfs
>
>On Oct 21, Andras Korn <korn-debbugs@elan.rulez.org> wrote:
>
>> I thought --ignore-install was completely broken, but no, because without it, the output contains *more* "install" lines:
>What you are actually seeing is that --ignore-install is applied only to
>the nfs module (the one which you have requested to load) but not to its
>own dependencies:
>
>diff -U 0 <(modprobe --all --set-version="6.0.0-1-amd64" --ignore-install --quiet --show-depends nfs) <(modprobe --all --set-version="6.0.0-1-amd64" --quiet --show-depends nfs)
>
>I am not sure if this is a bug or a feature, so this should be discussed
>with the upstream maintainer.
>
>So the possible solutions are:
>- the semantics of --ignore-install are changed upstream (this may take
>  some time)
>- initramfs-tools learns to parse the install directives
>- nfs-kernel-server uses a different design
>
>No matter what happens to --ignore-install I suggest that
>nfs-kernel-server will replace the modprobe configuration with some udev
>rules like this one (untested):
>
>ACTION=="add", SUBSYSTEM=="module", KERNEL=="sunrpc", \
>  RUN+="/sbin/sysctl -q --pattern sunrpc --system"
>
>-- 
>ciao,
>Marco
>
>
>
>----- End forwarded message -----
>
>-- 
>ciao,
>Marco


