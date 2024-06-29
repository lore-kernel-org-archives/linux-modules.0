Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149A486255
	for <linux-modules@vger.kernel.org>; Sat, 29 Jun 2024 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719683480; cv=fail; b=prFuhNJRR0O81+w+6+srXiJ2T4MJvSKrzjkb7aMWuEb+tWOdjdfDxfZBRywN4/Jg64QxfShg2nKF2BUW5NbuqTnEGTTpDXA2kszpxEPVajGZnUaTZBOXdShz+R8PAayqDUbCBmi/xnabT3oUFMjR8/tGipsPVew2Cs0I6xAqHgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719683480; c=relaxed/simple;
	bh=WmN3kX04WcVO8T52ZSTFzpmAEcmwEPNFPdw3iSCN59k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j94r3K9cCp+1dqq/fjWL8Y461CXkLd65inZ2glWJL66dkaYAmasCZEtBAJbRqzWHkw3ipwXy5UzFIalBS3ybOpwFwvV/lNA7RRL4ng2zqA6LNjrJ0BsVG9ISLEpf/rjFEWClWja4Ln5Qbfa4viFNCLQ5OpDUuy/TvToYRZBBP0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdWIeGkd; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdWIeGkd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719683478; x=1751219478;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WmN3kX04WcVO8T52ZSTFzpmAEcmwEPNFPdw3iSCN59k=;
  b=gdWIeGkdzwkzY16pE9L8d3VJeaNJE/QkPG8uc8DsGFQWZTEX44n3JIdm
   XRTtEyJv+AFKoK7PBsfmF+FVSb9k75pjVMZFHKoh85bM+ef4buAPmpiOm
   uwlIZO29lPu1lRsYoxl5Rk2VxqvtSU3JmEs8E0AcCYGGEpDoFkS3eJ6Ne
   enNGv0LvOlZ60PYGNM2ylU2pkmXcrbMcwJdT3c0+aFTgKxG+Se2zxs4aV
   6RrR8ouPw+V3MD2I0D4qbQOslQGeO8+dzHxxgUj/r+cGcqQhtJAA/Xs3C
   0ky/aQsZwmpd2SvNS5o8znpGSK7lL6I12+JFFbEP1QkgkcmSOWnoopB9w
   A==;
X-CSE-ConnectionGUID: kqAuSZJ+TmqplKRgz8e/tQ==
X-CSE-MsgGUID: GeRefkz5RQypYLgHYSpVGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11118"; a="12317292"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="12317292"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 10:51:17 -0700
X-CSE-ConnectionGUID: PGHeQ4UxQxKONfv5Rr5DjA==
X-CSE-MsgGUID: sArNTD44SY6FOZnrUcfCDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="50243401"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jun 2024 10:51:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 29 Jun 2024 10:51:16 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 29 Jun 2024 10:51:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 29 Jun 2024 10:51:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 29 Jun 2024 10:51:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqPvLMTiB5EWVh/6vjDVVkIy6IRJpgRJS64COSMMyQWVY5VnAmgMYRJsyqB8A+u68/3ElHbjMNxPZ+GMPWuRXKmALVAy1on5nL2JkFGFuXT4mdrGgCOTCwmOt8H1I8J0zkxIoog2x2Oo2kl784swqADT0cSApxfeFGwyP8wq4Z+oeibsXb058r7S7r8BFZci3Ztpvs/cReG6qSGex7S39UOejUXRpyjSgakg9BlpibehMCZFIi1NaQtxICYPErmIWRi2zu8mbh/G0X1TP2OanskeXURtwF0BGgY0SRYMciRWa/+woF6cQEt1jcFfv0Gqv7D9a+QgZONWpplg5ooLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmfX+qOrt0pGPPSCg5tg0CIO0g8U0PSAjImwII4yAAg=;
 b=Hwvam7PMs/DOID8VtcwtfA5PEw2RMDQpwdhdNES8DgGeX2D0MVLnO7nKm3t+Feh5zc7Wt1Zn/Nb1Lfc4FBnB3xHmhCo9H6W/3qeQQGJTip2ZmE9ucHtwgpshmSazIcfM7WWztZzEnDdgnnzU2ZCkgn0UsAYWLMCTdPGx4+aZfUS3yfGdJu2uFE3SasiFY4cJ0xBYpiqB7mb1zLHjuzyvFh7PiBBj/IaXqmRJJnGaujDAz+rD2IFgOTjdDy47Mb5pqSM2daUO//mu9urG3NC9fMdwgyyqqSCIXZc4l6aTtp3d8vVeXHrp2Wp36ROXv/nBPro69bPVne8B5luPCr4dVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CYYPR11MB8405.namprd11.prod.outlook.com (2603:10b6:930:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Sat, 29 Jun
 2024 17:51:11 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7698.025; Sat, 29 Jun 2024
 17:51:11 +0000
Date: Sat, 29 Jun 2024 12:51:08 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <emil.l.velikov@gmail.com>
CC: <linux-modules@vger.kernel.org>
Subject: Re: [PATCH kmod 19/20] man: remove the "Maintained by" references
Message-ID: <lvy5sy5kthttcvm2iextckgttlunvegyq7d737vgzlqxp5a4of@65fhjttrycmx>
References: <20240611-man-v1-0-bd6864d49639@gmail.com>
 <20240611-man-v1-19-bd6864d49639@gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240611-man-v1-19-bd6864d49639@gmail.com>
X-ClientProxiedBy: MW3PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:303:2a::21) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CYYPR11MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: b0173269-3200-4bcf-4784-08dc98640ffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iIXMb6Gc7L/1kSDupLimxMDFYWc1nus3H2I4h9xsZDv8tLv88CAOF1FcQZF1?=
 =?us-ascii?Q?2noxMoYCvGWrMV7R5r4Yjq+hVonBaJBUItA8DOnmYefm8Iru+PBMg1WN8puV?=
 =?us-ascii?Q?Bf+0jV9Z7zMqOoRy/r/xvKBsdReC+H4oVTMAORhBfihG3U0UP/H0vuoXUB9F?=
 =?us-ascii?Q?/xS/Df7r5xSuiaFGfF/nqVjy26d60gzl9Ir2pJ9J0/9QCmay9mzWpJEd+HD6?=
 =?us-ascii?Q?A20OYDj0C3YY/nj+qtX0nZBoxVVkNij6ypOwCKLTs++PW6JoR97ETS++vAjW?=
 =?us-ascii?Q?a0t3C84uPWWFmIPdZIBrl/cixmq0byXdouYtg9C9ICzCyY443VZGwzsOt2Ik?=
 =?us-ascii?Q?oC9DCrWBJGhXpUzRR9TUamchlYBG2NlgUSBhz95xuTzQnpsl6Bld7pdnK8Li?=
 =?us-ascii?Q?1qUB+ZIw9zddys5GOB736MZCSnAXDfxGjVrZwhrUwuJQcJ6zrHo8kowHjz0L?=
 =?us-ascii?Q?EPYAxVWgv+ks4w9aSXHmyzZe3PqMxzJcqGsEUYETI97rZnbF4hsBvb/T1oBC?=
 =?us-ascii?Q?tzauFVpXWTgKM+TtTmtXFQxkXxU8mTxRs9EdglEETC3RuSEleHlzqF8j+hhk?=
 =?us-ascii?Q?FeOKuSrd8TcXgPujYHFokieCyDGFSNNp4sq8ZFtSJp0OyMrnVZc/MunbuQdI?=
 =?us-ascii?Q?fENqQvjzbxP/oJTRTzWl0IKV/z6dLdp1KJ6b+6QTipoDC1rg6rVJGPXkCzKQ?=
 =?us-ascii?Q?kXdyA5B17LBSqUFczW2m6bgGzsG/Iu7aOTqy6Qc+baSjlQ5FkxbgHufi+dJs?=
 =?us-ascii?Q?qNDvOKPEqIamSwhciDNALhXdzkVp4VTcStFjLk9hqV97Y5rDjiR1lGPxSB8h?=
 =?us-ascii?Q?LtivOIrc5/EpKTjZEA5VGbtXOjS4gk4H8Gk/Ter+umiUTw+jeWFfFndiZNH2?=
 =?us-ascii?Q?G6wPFM0+biGz985x22355Qje46YSuhLyUXvf/76KvoUBCu80BMtlebTXVUJt?=
 =?us-ascii?Q?hQ+LSQat4RO++E7CpEqNBJDun96ROvaxmYVShz3Dq+0KenW+ULuXZybLMDC9?=
 =?us-ascii?Q?Gs+eLXrLo3fxOSv4geQu2M+XEmr38VZOAJDzwB4KoAuecB31WrnRIZZapQEr?=
 =?us-ascii?Q?jgkcvp0YkdjH7uOsXjCra24/lnLUZbOO/A1URrtm3z3bmi1OOc6z62+W+lYd?=
 =?us-ascii?Q?FjyFfJVqHJZKmgUNotY89r6FyY9OXFWeml2l6ztcNwITSRKIzoYrWb6Yn1O4?=
 =?us-ascii?Q?ukDMG8d66qyuxwjAuligFSQp9i19LNfaz/PoOk8ilLaiXuNMRJ+/bJBR7Byo?=
 =?us-ascii?Q?fUri24V+uA+mJt15fOwjGXIadj1BAywz7ViyBDj2Pw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5t/L6UT2KvN9b2sHN01sQnJyHKUjSIJkIJWUdNdp50IvUGtvA66AKSAsULyC?=
 =?us-ascii?Q?hkfkh+imv3lHh/fqZDgI+Uz1/OqTFTQJiY5Kut0GIBG4egoYIDS5t8bEcF/K?=
 =?us-ascii?Q?yOx1YYv473z7l90lJQAF78hukquGyMdlFdKYa3IpKRp+wr3GPQ4doLcLE9/P?=
 =?us-ascii?Q?1MnumihAJeFuPR02AyBBRZBW1QXLavCQ6Myq6EJjOdWHHIu/M5Pt18pNFfoC?=
 =?us-ascii?Q?3WeG0UoO06Pn1Sh3lKID+LfSk2QOiKijB/yslCRcTO00b6G+aP/fuUq7F7gD?=
 =?us-ascii?Q?/y+Yv7g08mACzYuSiWxRJ3pqV56XhSTmC2GddIcJxcf65q1/yNvnMs+8euWH?=
 =?us-ascii?Q?dQwJ4bVVH0R5rWQ1QZitOrwg39hTMoV9U7oGP8KYC+LL+SAU6WuyKcXEbZ7F?=
 =?us-ascii?Q?CZQ3Jq53Aj8T7AbIvd5QclLEr4gmTFMQvBQJD7lrpLEKzYe+xGLcr3AxhVr5?=
 =?us-ascii?Q?13/QT8TTCWR78ZE1BthMUe1MXNuCHKEFIdt8+C+wnedNDS4hHgkHPaeKmQ2/?=
 =?us-ascii?Q?8RlQGQhXzpEpTZCt2N/gpAqvuce//QxKH8xpU5JW0gwsRu8MDJ/geQg4w1HA?=
 =?us-ascii?Q?6x/E+VH3rIhSTw9hbdVTET7MKoSSxVwJ1cMADMgncZyO0/lh/U5tDCNgfUxM?=
 =?us-ascii?Q?isiAqM02ySVzko4tl02IxeByffBKowuj/rbb7Z8MpvzW26g0sHOBvtv5W4KG?=
 =?us-ascii?Q?Zs6Y4ch7+zF3by/+4eIEikd7yvviE8r95krhAJQnPQISOMhbAGDQFe6BpAM+?=
 =?us-ascii?Q?8aj4116vERE6GbpvWu3W1RJ1fI1m8J9ZQbMvKjcrtFWDw6LEbL3WHJ3s4FPz?=
 =?us-ascii?Q?ZUljxKwXnFmzO8+3Cl2rvBjQB9Zih5JcU9ahRuEesBYyLeeq9iji5My7KRYP?=
 =?us-ascii?Q?pE1HuRRsjROlUD3z1yh9N2ZvIERkOEYockfnlUU828nIxwMDOzfm660SboNO?=
 =?us-ascii?Q?ystMusfyh5HtGfTEctF1MBsX5BCCImQB3CcquDNkXBum2Ndx3pbKqRgeMXPV?=
 =?us-ascii?Q?/BuGx2FUF5Gy5YxJ1mjB79y19Gk1ZXcMkfzMOfJsO+y3j3Ig9p10HP4wnMBR?=
 =?us-ascii?Q?mq0jM71PGJ/S1WIzsIOHckn8q897974+LxQtO1GY/fu9P3S1+JO9yEiDkSe7?=
 =?us-ascii?Q?uIHQPZdFrIzgkApKRPBVpyC4bnouhHkrleUuQr7u5znihMfJKPQ2UWWim9Va?=
 =?us-ascii?Q?nUzFxdAUBT+ZnsAsVbKwU4QYbIl/ZM02wmslVEyqpLp6OvPNKOlVMh2QK23t?=
 =?us-ascii?Q?MK10uM+bFLIyJFrtru6IbmTTiXEeKsHqM1G2ceQ+4vWq6CqBnUuoJonMzU+D?=
 =?us-ascii?Q?fD6LTcW2q3LW6JmAzPUbJyM/993xJyzCdPVwOu21r45AihsqD8sHPq2v5E8n?=
 =?us-ascii?Q?FIfnGLn+6CrygA3OD9gH2tte8RZGJTT6pAtwTvBy7WFyyqzabf9gRLS7xBEA?=
 =?us-ascii?Q?PO/CDYQcndp4V6C+eInKWmCCmRsaO2fazLkGnCj4iT+Vk5ABRXCVp7phUzaX?=
 =?us-ascii?Q?0f7/36DxDXDM8amswK6bq6I6soo3vlxBEdmEFo0gWotdRYEQg+JRsbnk+1TA?=
 =?us-ascii?Q?mnfLvARaCINGkfnuEnKruznUOedKTew7/Od6CHcafy0yQlV7ioaGMxwfEPKA?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0173269-3200-4bcf-4784-08dc98640ffd
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 17:51:11.3764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRX24ayeoJeCrSEbd7s7P2EBXcmd6ViAnKTF1GggNcBbPxhzdMyZj4XN/FsTGdwsU0O3bHWyjAS4m+1uN59KbciLq8d5/zHjzm1ekmzxAQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8405
X-OriginatorOrg: intel.com

On Tue, Jun 11, 2024 at 04:05:19PM GMT, Emil Velikov via B4 Relay wrote:
>From: Emil Velikov <emil.l.velikov@gmail.com>
>
>At a glance through my system, around 2% of the man pages include such
>statement.
>
>Looking through git log, Jon has been active in a while and presumably
>have moved on.

Jon was the author and maintainer of module-init-tools, that got replaced
by kmod:

https://lwn.net/Articles/472354/
my blog: https://politreco.com/2011/12/announce-kmod-1/
Jon's blog: http://www.jonmasters.org/blog/2011/12/20/libkmod-replaces-module-init-tools/  

>
>Most importantly the Copyright section isn't the best place to reference
>the maintainer/contact person.

agreed

>
>Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
>---
>Instead we can add a note in the authors section, pointing people to the
>ML/kernel.org/Github repo for when seeking contact.
>
>Also should probably s/Developer/Maintainer/ for Lucas, who's been
>keeping the project afloat the last few decades ;-)
>
>Lucas, what do you think?

I like the format used by git:

AUTHORS
        Git was started by Linus Torvalds, and is currently maintained by
        Junio C Hamano. Numerous contributions have come from the Git
        mailing list <git@vger.kernel.org[6]>.
        https://openhub.net/p/git/contributors/summary gives you a more
        complete list of contributors.

        If you have a clone of git.git itself, the output of
        git-shortlog(1) and git-blame(1) can show you the authors for
        specific parts of the project.

Can we get inspiration from there, remove the COPYRIGHT section and add
a new AUTHORS section?  A brief history mentioning that kmod replaced
module-init-tools can be added in kmod(8). Something like this?

KMOD(8)
...
AUTHORS
        kmod project was started by Lucas De Marchi as a drop-in
        replacement to module-init-tools that was maintained by Jon
        Masters, adding a library (libkmod) and additional features.

        Numerous contributions have come from the linux-modules mailing
        list <linux-modules@vger.kernel.org> and Github. If you have a
        clone of kmod.git itself, the output of git-shortlog(1) and
        git-blame(1) can show you the authors for specific parts of the
        project.

        Lucas De Marchi <lucas.de.marchi@gmail.com> is the current
        maintainer of the project.

The other man pages can omit the first paragraph.

thanks
Lucas De Marchi

>---
> man/insmod.8.scd      | 1 -
> man/kmod.8.scd        | 3 +--
> man/lsmod.8.scd       | 1 -
> man/modinfo.8.scd     | 1 -
> man/modprobe.8.scd    | 1 -
> man/modprobe.d.5.scd  | 1 -
> man/modules.dep.5.scd | 1 -
> man/rmmod.8.scd       | 1 -
> 8 files changed, 1 insertion(+), 9 deletions(-)
>
>diff --git a/man/insmod.8.scd b/man/insmod.8.scd
>index b6f8654..27d4409 100644
>--- a/man/insmod.8.scd
>+++ b/man/insmod.8.scd
>@@ -21,7 +21,6 @@ information about errors.
> # COPYRIGHT
>
> This manual page originally Copyright 2002, Rusty Russell, IBM Corporation.
>-Maintained by Jon Masters and others.
>
> # SEE ALSO
>
>diff --git a/man/kmod.8.scd b/man/kmod.8.scd
>index 2007a2d..6bd9432 100644
>--- a/man/kmod.8.scd
>+++ b/man/kmod.8.scd
>@@ -35,8 +35,7 @@ Linux Kernel modules. Most users will only run it using its other names.
>
> # COPYRIGHT
>
>-This manual page originally Copyright 2014, Marco d'Itri. Maintained by Lucas De
>-Marchi and others.
>+This manual page originally Copyright 2014, Marco d'Itri.
>
> # SEE ALSO
>
>diff --git a/man/lsmod.8.scd b/man/lsmod.8.scd
>index eb2f2e8..ded619e 100644
>--- a/man/lsmod.8.scd
>+++ b/man/lsmod.8.scd
>@@ -15,7 +15,6 @@ lsmod - Show the status of modules in the Linux Kernel
> # COPYRIGHT
>
> This manual page originally Copyright 2002, Rusty Russell, IBM Corporation.
>-Maintained by Jon Masters and others.
>
> # SEE ALSO
>
>diff --git a/man/modinfo.8.scd b/man/modinfo.8.scd
>index 9545257..d088c7e 100644
>--- a/man/modinfo.8.scd
>+++ b/man/modinfo.8.scd
>@@ -63,7 +63,6 @@ architecture.
> # COPYRIGHT
>
> This manual page originally Copyright 2003, Rusty Russell, IBM Corporation.
>-Maintained by Jon Masters and others.
>
> # SEE ALSO
>
>diff --git a/man/modprobe.8.scd b/man/modprobe.8.scd
>index 8354765..657d172 100644
>--- a/man/modprobe.8.scd
>+++ b/man/modprobe.8.scd
>@@ -197,7 +197,6 @@ The MODPROBE_OPTIONS environment variable can also be used to pass arguments to
> # COPYRIGHT
>
> This manual page originally Copyright 2002, Rusty Russell, IBM Corporation.
>-Maintained by Jon Masters and others.
>
> # SEE ALSO
>
>diff --git a/man/modprobe.d.5.scd b/man/modprobe.d.5.scd
>index 9d03c49..41d2e78 100644
>--- a/man/modprobe.d.5.scd
>+++ b/man/modprobe.d.5.scd
>@@ -170,7 +170,6 @@ directly within the modules.
> # COPYRIGHT
>
> This manual page originally Copyright 2004, Rusty Russell, IBM Corporation.
>-Maintained by Jon Masters and others.
>
> # SEE ALSO
>
>diff --git a/man/modules.dep.5.scd b/man/modules.dep.5.scd
>index c4e7653..7723a16 100644
>--- a/man/modules.dep.5.scd
>+++ b/man/modules.dep.5.scd
>@@ -29,7 +29,6 @@ fashion rather than touching these files.
> # COPYRIGHT
>
> This manual page originally Copyright 2002, Rusty Russell, IBM Corporation.
>-Maintained by Jon Masters and others.
>
> # SEE ALSO
>
>diff --git a/man/rmmod.8.scd b/man/rmmod.8.scd
>index e1f656f..c4dcc3e 100644
>--- a/man/rmmod.8.scd
>+++ b/man/rmmod.8.scd
>@@ -35,7 +35,6 @@ is provided) from the kernel. Most users will want to use *modprobe*(8) with the
> # COPYRIGHT
>
> This manual page originally Copyright 2002, Rusty Russell, IBM Corporation.
>-Maintained by Jon Masters and others.
>
> # SEE ALSO
>
>
>-- 
>2.45.0
>
>
