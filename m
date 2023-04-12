Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F75C7619A
	for <linux-modules@archiver.kernel.org>; Wed, 12 Apr 2023 20:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDLUNm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 12 Apr 2023 16:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDLUNh (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 12 Apr 2023 16:13:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13958448B
        for <linux-modules@vger.kernel.org>; Wed, 12 Apr 2023 13:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681330416; x=1712866416;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NJRr6DZ3r3Q4ZyJxWHaufaZvvzjghzK4aOfTf9kz4uw=;
  b=a3Ep5zB6vSCQOlAB4GFXrgplhgIgxh0R+kvDKcdgw3KhhO7swRKm1qQg
   WNp8LpYXy2fKq9jStziAJSyYm86jaQRVmF3RJZ5TiFFSs/HEcawGiJbH7
   PVdYktYzlUeARh/lfpBLYlGjKvi2PYIJAZlO3cDeXIFsHsoaiHoSjre5S
   TVuFtBCaUyiRbf50Fo3v5toFjpRvbXrGpttZb1LkqEd4PMPetxn+5wvq+
   qhdbB3kaXRM5BzA3/KZzH01UgpqrKMeqhx8RES5n8LSCTYOY5OrTd3Yb0
   BwTo9Ixzr+QyTyCFcsn0SpTesqPnyDaj3W3+n6YEDKKQpUPU2SAQzvq+Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="341504169"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="341504169"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 13:13:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="719532689"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="719532689"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 12 Apr 2023 13:13:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 13:13:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 13:13:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 13:13:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 13:13:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JI53PVsORlYB2lLcdXsHoc0mFs+nhiafWA6fRrFYWPgS0aU77m1BiFlUrhDce0dgj20XqochmoKonU7dm2gE6ght9Kglgl7N72BHxlFcGGjL9NUYjZJyA8hpILcmN38Uh6epaoSTt4S+/Sq9uwy1O5Z1qyr/hbrWdNuWLfC6X1QNmsAj1ZPYtbMN1gs0BFw71FvEMEDOUjUJIvKVR+kd+xfJgoFY7088TmOjj1iXUWIxw0pV++m2q7kIV0mpchvBVJhwfsgJ8pZWBZfmE4lALFP62Q77/nB50VTudBw7FepjZFI2JEHmWumjNxovIdIcrfmz4pEE9IqcovU6i0I5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWickso8GSQWhR4pXW4/tVbGW38P7/47k2gkHYTE+7s=;
 b=U5bXwD1e4G8lmGUNhlVJjVomFdK1YaT+EN5e80bPNCEtmDNb9kq08XjPe5/HV+BsI5oOhBOUFJxXqlBfBsZhzf0rhsizhGK3O9eNF7Kj4c1bW5bPUyy/2vAgEQH32wzeXT87dykicV/zhJWu3HswOSokQsWun542jiBH5+/2jrBPsMKIneT1CSNsrSdQ+NOOUtUIK5NDpFJXp4wYyWMhuDc8nEOZTbpGhhBaVF63nI1/jUoHvnHuZi89QOhkq4pYqGUoEjpC5z+VZXyL998rjnxy8eTuDODRL40Dc6Rkj7AuTtQXk302CodxZUs58elGDsOsKyMvJa5G7ctZjwscMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 20:13:31 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4%3]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 20:13:31 +0000
Date:   Wed, 12 Apr 2023 13:13:28 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Nicolas Schier <n.schier@avm.de>
CC:     <linux-modules@vger.kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v2 2/3] testsuite: delete_module: Roughly implement
 fake-removal in sysfs tree
Message-ID: <20230412201328.3mns7kv5yplnpvtr@ldmartin-desk2.lan>
X-Patchwork-Hint: comment
References: <20230309-remove-holders-recursively-v2-0-8a8120269cc1@avm.de>
 <20230309-remove-holders-recursively-v2-2-8a8120269cc1@avm.de>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230309-remove-holders-recursively-v2-2-8a8120269cc1@avm.de>
X-ClientProxiedBy: SJ0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::15) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e95a4a-fcda-49ab-2be8-08db3b9262d9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YOdt6Eypp0z6KFTd0CrM6m7q4VPW6c2wFy+/HmYWjDQE5sx1/NXzk1U7HLPGxxWsygrGaY8O0FxUXx8shOkv61vSTL0TT5Pgt0NLg34nZ/k3lmqMmKBuSSB6uRMGWFDM9xatyF1+q5POi6WY+qRmFSouPHF+tpTJP1PwrSkxoVZcfv05t1XEHo/Zw96obUo/ArIvgzPllA5RLuuq3Be7QKuSd58OXV6GI1Zr0U0uT/QyUKEUy+2ECJdjT3cRjw1+a/KCDr3luGXMjGgc44vWqaNOKGZolYlAgqMPs6ILp2jtJQu3mvuiyYfrmtNAtqu3G996Dxo4LWTgCgjO9QHXpH4X3QFECLc94xIWSjkUlYKjMCVr/eF3BueEz+8KvTEIwMHkxMKHaoP1b5o5pnRHuRcvco2SqxADB5pFRG3GoQfFzoGlAA6zyiIOfMkRj+1p4WBhEIM/weZKwz/GQVcJUJP7t3sYKmbEXNTxfNG9T348K8MzsDKyEpXtNFPWusL5AmLs8sG6FBN/DMNv8uavEAyWU8XYJl84E1DDsA6qwHChEEnqc/YpkRiV0xzxwOsg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199021)(316002)(41300700001)(6506007)(6512007)(1076003)(9686003)(26005)(186003)(6486002)(86362001)(6666004)(38100700002)(66556008)(83380400001)(66476007)(82960400001)(66946007)(6916009)(4326008)(54906003)(36756003)(8676002)(8936002)(5660300002)(2906002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?oF5e0av/JWB02AcFOF4yYB19MaHQFrj2Un7RccJ7dRRr3DpNHuzVaE7uBy?=
 =?iso-8859-1?Q?FDKhjs965SHVb1ikGjLlDVzz0vtnRpEhxrEjNyjn974VQeuNtDgOliILu9?=
 =?iso-8859-1?Q?zOzfkRdEU/xBp7xpDTSzxXw8CUvkCWrWv+oEiBL2s6mvo5PUQ9OBwKj4Sa?=
 =?iso-8859-1?Q?+IgTaJzbixcxeoC76FgEt4RgCGOanHl4zBPDWQFHNkka/DKgPEy2k6NM9E?=
 =?iso-8859-1?Q?G3hXjOL9jaaeT57FQwJBNX996WjrXEh15naYNG7GnxYG2Qkad8NXNyRJgw?=
 =?iso-8859-1?Q?ixmtQuLQaUftR5ZxT+sNcH9phGTBj/HrfJ7ltsv4XXStzmYe59CnMXgDce?=
 =?iso-8859-1?Q?T70OYqTVV0MxAL3ad8FXTI5qIfKKlPLte7zEzzoKr5LVx3LnDbC5IrTElr?=
 =?iso-8859-1?Q?74VeopBXL7hJCGUxcZYoPAao1arz0v/azWHEBAO2bbwIrBOcBRujNyXorA?=
 =?iso-8859-1?Q?zGLAELtT4QnAbzpvplmO1NDqHG6djkJu9OhAz29SsJHZbgzM1lM4fQ/IqC?=
 =?iso-8859-1?Q?PQzYdckcTP/xFqvmIambkaVv1D1qC2MOoka4XH1CHas2ga7eKpVCn7bsJL?=
 =?iso-8859-1?Q?Uhfx49VeaDTYDngLnMCboj6el5G8EIaJO3rjduN8GeEmWZUvnXZ9K1HdCV?=
 =?iso-8859-1?Q?zwrWI2CpRISFo4gHS+EhdBR8QalyTArEzmwRKzEC7lQ2nCFyawaNOf7Gaj?=
 =?iso-8859-1?Q?lSIckPS+wyAdrFqvfee/8qmygmF7dmfIDKQAi1Vpmn2WcBqRFQ1hBghwBE?=
 =?iso-8859-1?Q?imetLNQIIkw6mTK81asHEdNArj4jx5ueZzgd8J/jwGVUsX/HVTyGYEeOgq?=
 =?iso-8859-1?Q?vKz+OG4VI16Ch3nKZq9PMP8CFgxA0MZj/lfKVNbL/D4H/gLs+HF3250/Hk?=
 =?iso-8859-1?Q?VTj4/Z9kBc+Jf+paLIHQTlJ61iIKCInk0qW6dk/ta4XazFt4sr9HNmbp+w?=
 =?iso-8859-1?Q?i6JW1nOvM6aoqCJEMoINzcKCxsh1O9PCl0PA0Q3lnW1vfjA4ehbqOMOkEe?=
 =?iso-8859-1?Q?ZIAj98unVYEr8M+hAcaQp6C1W6b9OCW86k/b0fdrA+GsrL4Mz+GxOnA0Ce?=
 =?iso-8859-1?Q?fQljQdtEOPTEaqFjcD2i594FhoNxoKPEC5dnUSgsfrZI37cyFmVUlQ9lqP?=
 =?iso-8859-1?Q?IBWGGoD7SzKnIwgayP8+nUkygqZ1bb05O02NuqQsfvU31E6hfbTfsfAkWt?=
 =?iso-8859-1?Q?DvDDFQMV4jTSUhekB73LlO0ToPO2cylxgf2ZxC9k2ICraZjipH6rjRPM/O?=
 =?iso-8859-1?Q?Zc5QuAiTTQBt9emse5vQyDZUwJgrIOKSQ8xhkDhVSZEWNa6kdWQVqezAUl?=
 =?iso-8859-1?Q?+I8VMKzNWjBKqoqZjeMdD2+Qy0IljvuueZAyShTa7g1Hl5LWSYfPljbAKW?=
 =?iso-8859-1?Q?9tT0stHdROY3QsdSuzaAxdDuF9Wfk1gmAzeQuf/AlnvjRiKhNuja2//zWy?=
 =?iso-8859-1?Q?CX+fPSBdRZMBt7ngNUA4OU/tPJRtFacPvIK68UJK3z4KRduq66rZplE9Bn?=
 =?iso-8859-1?Q?70jmaSRoDaLd4Al/4+EGQTfGaJGXnhrQxmP5hZBadqP1CP7w/Zdc+KR9Tp?=
 =?iso-8859-1?Q?cGkiPcd2Nndihr3DSLCOB7DEJnLUw4otiMxWEG6JKxsvONHnYsCVe5NN+6?=
 =?iso-8859-1?Q?nyltl3t8TFOb5OWa+s6I1ek07N6/+bslvaW7hI3aLLnAY2YzFOEto0fA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e95a4a-fcda-49ab-2be8-08db3b9262d9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 20:13:31.6185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26FMvnPt3whBsIyD3E4jYUzEWuJe8g2qwwx8ldAWY3ibgGyX01bmbcSaOUTfsGHlJnt2ppcabKw/dNl74LHmXwXgTEaW5tGuZ6vjuVjEvGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6005
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Mar 29, 2023 at 03:51:36PM +0200, Nicolas Schier wrote:
>Extend delete_module() to simulate module removal in the testsuite's
>sysfs representation.  During fake-removal, decrement refcnts on all
>modules that have the to-be-removed module as holder, and unlink the
>sysfs sub tree of the module itself.
>
>Signed-off-by: Nicolas Schier <n.schier@avm.de>
>---
>Changes in v2:
>  * new patch
>---
> Makefile.am               |   1 +
> testsuite/delete_module.c | 262 +++++++++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 261 insertions(+), 2 deletions(-)
>
>diff --git a/Makefile.am b/Makefile.am
>index 8ba85c9..9a87824 100644
>--- a/Makefile.am
>+++ b/Makefile.am
>@@ -293,6 +293,7 @@ testsuite_path_la_CPPFLAGS = $(AM_CPPFLAGS) \
> testsuite_path_la_LDFLAGS = $(TESTSUITE_OVERRIDE_LIBS_LDFLAGS)
>
> testsuite_delete_module_la_LDFLAGS = $(TESTSUITE_OVERRIDE_LIBS_LDFLAGS)
>+testsuite_delete_module_la_LIBADD = libkmod/libkmod-internal.la

I skimmed through this and it looks good. One thing that we may need to
rethink in future is if we want to keep delete_module.so linking to
libkmod. We may hit a situation that we are are overriding stuff to test
libkmod but for that we also use libkmod.

I think that hardcoding here the kernel behavior would be ok instead of
depending on what libkmod thinks it should do.

if we keep libkmod, then it´d be better to get just 1 ctx:

static void init_ctx(void)
{
	... kmod_ctx - kmod_new(NULL, NULL);
}

static void init_retcodes(void)
{
}

static void init(void)
{
	if (!need_init)
		return;

	need_init = false;
	init_ctx();
	init_retcodes();
}

but I like the additional coverage that you added here, so it's ok
to keep it like this and improve in future.


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

Lucas De Marchi

> testsuite_init_module_la_LDFLAGS = $(TESTSUITE_OVERRIDE_LIBS_LDFLAGS)
> testsuite_init_module_la_SOURCES = testsuite/init_module.c \
> 				   testsuite/stripped-module.h
>diff --git a/testsuite/delete_module.c b/testsuite/delete_module.c
>index f3ae20b..73fc71a 100644
>--- a/testsuite/delete_module.c
>+++ b/testsuite/delete_module.c
>@@ -31,6 +31,7 @@
> #include <unistd.h>
>
> #include <shared/util.h>
>+#include <libkmod/libkmod.h>
>
> #include "testsuite.h"
>
>@@ -135,11 +136,252 @@ static void init_retcodes(void)
> 	}
> }
>
>+static bool lstat_is_dir(const char *dir)
>+{
>+	struct stat st;
>+
>+	if (!lstat(dir, &st))
>+		return S_ISDIR(st.st_mode);
>+
>+	ERR("TRAP delete_module(): %s: lstat: %s\n", dir, strerror(errno));
>+	return false;
>+}
>+
>+static int unlink_tree(const char *dir)
>+{
>+	struct dirent *dent;
>+	char *new_path;
>+	bool is_dir;
>+	DIR *dirp;
>+	int ret;
>+
>+	dirp = opendir(dir);
>+	if (!dirp) {
>+		ERR("TRAP delete_module(): %s: opendir: %s\n", dir,
>+		    strerror(errno));
>+		return errno;
>+	}
>+
>+	errno = ret = 0;
>+	while (!ret && (dent = readdir(dirp))) {
>+		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
>+			continue;
>+
>+		if (asprintf(&new_path, "%s/%s", dir, dent->d_name) < 0) {
>+			ERR("TRAP delete_module(): unlink_tree: out-of-memory\n");
>+			return ENOMEM;
>+		}
>+
>+		if (dent->d_type == DT_UNKNOWN)
>+			is_dir = lstat_is_dir(new_path);
>+		else
>+			is_dir = dent->d_type == DT_DIR;
>+
>+		if (is_dir)
>+			ret = unlink_tree(new_path);
>+		else {
>+			if (unlink(new_path)) {
>+				ret = errno;
>+				ERR("TRAP delete_module(): %s: unlink: %s\n", new_path, strerror(errno));
>+			}
>+		}
>+
>+		free(new_path);
>+	}
>+
>+	if (errno) {
>+		if (!ret)
>+			ret = errno;
>+		ERR("TRAP delete_module(): %s: readdir: %s\n", dir, strerror(errno));
>+	}
>+
>+	if (closedir(dirp)) {
>+		if (!ret)
>+			ret = errno;
>+		ERR("TRAP delete_module(): %s: closedir: %s\n", dir, strerror(errno));
>+	}
>+
>+	if (rmdir(dir)) {
>+		if (ret)
>+			ret = errno;
>+		ERR("TRAP delete_module(): %s: rmdir: %s\n", dir, strerror(errno));
>+	}
>+
>+	return ret;
>+}
>+
>+static const char *rootfs_path(void)
>+{
>+	char *rootfs;
>+
>+	rootfs = getenv(S_TC_ROOTFS);
>+	if (rootfs)
>+		return rootfs;
>+
>+	ERR("TRAP delete_module(): missing export %s?\n",
>+	    S_TC_ROOTFS);
>+	return NULL;
>+}
>+
>+static char *sysfs_module_path_get(const char *module, const char *subpath)
>+{
>+	const char *rootfs = rootfs_path();
>+	char *sysfs_path;
>+	int ret;
>+
>+	if (!rootfs)
>+		return NULL;
>+
>+	ret = asprintf(&sysfs_path, "%s/sys/module/%s%s",
>+		       rootfs, module, subpath ? subpath : "");
>+	if (ret >= 0)
>+		return sysfs_path;
>+
>+	ERR("TRAP delete_module(): %s: out-of-memory\n", subpath);
>+	return NULL;
>+}
>+
>+static int unlink_sysfs_module_tree(struct mod *mod)
>+{
>+	char *sysfs_path;
>+	int ret;
>+
>+	if (!(sysfs_path = sysfs_module_path_get(mod->name, NULL)))
>+		return EFAULT;
>+
>+	ret = unlink_tree(sysfs_path);
>+	free(sysfs_path);
>+
>+	return ret;
>+}
>+
>+static int sysfs_kmod_remove_holder(const struct kmod_module *kmod,
>+				    const char *holder)
>+{
>+	const char *name = kmod_module_get_name(kmod);
>+	char *sysfs_mod_holders;
>+	char *sysfs_mod_refcnt;
>+	char refcnt_str[34];
>+	char *sysfs_mod;
>+	int holders_fd;
>+	int refcnt;
>+	int ret;
>+	int fd;
>+
>+	if (!(sysfs_mod = sysfs_module_path_get(name, NULL)) ||
>+	    !(sysfs_mod_refcnt = sysfs_module_path_get(name, "/refcnt")) ||
>+	    !(sysfs_mod_holders = sysfs_module_path_get(name, "/holders"))) {
>+		ERR("TRAP delete_module(): %s: out-of-memory\n", name);
>+		return ENOMEM;
>+	}
>+
>+	holders_fd = open(sysfs_mod_holders, O_RDONLY|O_CLOEXEC);
>+	if (holders_fd < 0) {
>+		ret = errno;
>+		ERR("TRAP delete_module(): %s: open: %s\n", sysfs_mod_holders,
>+		    strerror(errno));
>+		goto fail_free_pathnames;
>+	}
>+
>+	if (unlinkat(holders_fd, holder, 0)) {
>+		ret = errno;
>+		ERR("TRAP delete_module(): %s/%s: unlink: %s\n",
>+		    sysfs_mod_holders, holder, strerror(ret));
>+		goto fail_close_holders_fd;
>+	}
>+
>+	refcnt = kmod_module_get_refcnt(kmod);
>+	if (refcnt < 0) {
>+		ret = errno;
>+		ERR("TRAP delete_module(): %s: Invalid refcnt or error: %d\n",
>+		    name, refcnt);
>+		return ret;
>+	}
>+
>+	if (refcnt == 0) {
>+		ERR("TRAP delete_module(): %s: refcnt already dropped to 0, refusing decrement\n",
>+		    name);
>+		return EINVAL;
>+	}
>+
>+	refcnt--;
>+	snprintf(refcnt_str, sizeof(refcnt_str), "%d\n", refcnt);
>+
>+	fd = open(sysfs_mod_refcnt, O_WRONLY|O_TRUNC|O_CLOEXEC);
>+	if (fd < 0) {
>+		ret = errno;
>+		ERR("TRAP delete_module(): %s: open: %s\n", sysfs_mod_refcnt,
>+		    strerror(ret));
>+		goto fail_free_pathnames;
>+	}
>+
>+	ret = write(fd, refcnt_str, strlen(refcnt_str));
>+	if (ret <= 0) {
>+		ret = errno;
>+		ERR("TRAP delete_module(): %s: write: %s\n", sysfs_mod_refcnt,
>+		    strerror(ret));
>+	}
>+
>+	close(fd);
>+
>+fail_close_holders_fd:
>+	close(holders_fd);
>+
>+fail_free_pathnames:
>+	free(sysfs_mod_holders);
>+	free(sysfs_mod_refcnt);
>+	free(sysfs_mod);
>+
>+	return ret;
>+}
>+
>+static int decrement_holders_refcnt(struct mod *removed_mod)
>+{
>+	struct kmod_list *list, *itr;
>+	struct kmod_ctx *ctx;
>+	int err;
>+
>+	ctx = kmod_new(NULL, NULL);
>+	if (ctx == NULL) {
>+		ERR("TRAP delete_module(): Unable to get kmod ctx\n");
>+		return EFAULT;
>+	}
>+
>+	err = kmod_module_new_from_loaded(ctx, &list);
>+	if (err < 0) {
>+		ERR("TRAP delete_module(): Unable to get list of loaded modules: %s\n",
>+		    strerror(-err));
>+		goto fail_free_ctx;
>+	}
>+
>+	kmod_list_foreach(itr, list) {
>+		struct kmod_module *kmod = kmod_module_get_module(itr);
>+		struct kmod_list *holders, *hitr;
>+
>+		holders = kmod_module_get_holders(kmod);
>+		kmod_list_foreach(hitr, holders) {
>+			struct kmod_module *hm = kmod_module_get_module(hitr);
>+			const char *holder_name = kmod_module_get_name(hm);
>+
>+			if (!strcmp(holder_name, removed_mod->name))
>+				sysfs_kmod_remove_holder(kmod, holder_name);
>+
>+			kmod_module_unref(hm);
>+		}
>+		kmod_module_unref_list(holders);
>+		kmod_module_unref(kmod);
>+	}
>+	kmod_module_unref_list(list);
>+
>+fail_free_ctx:
>+	kmod_unref(ctx);
>+
>+	return -err;
>+}
>+
> TS_EXPORT long delete_module(const char *name, unsigned int flags);
>
> /*
>- * FIXME: change /sys/module/<modname> to fake-remove a module
>- *
>  * Default behavior is to exit successfully. If this is not the intended
>  * behavior, set TESTSUITE_DELETE_MODULE_RETCODES env var.
>  */
>@@ -152,6 +394,22 @@ long delete_module(const char *modname, unsigned int flags)
> 	if (mod == NULL)
> 		return 0;
>
>+	if (!mod->ret) {
>+		/* Adjust sysfs tree after successful removal */
>+
>+		errno = decrement_holders_refcnt(mod);
>+		if (errno) {
>+			ERR("TRAP delete_module(): unable to decrement sysfs holders\n");
>+			return EFAULT;
>+		}
>+
>+		errno = unlink_sysfs_module_tree(mod);
>+		if (errno) {
>+			ERR("TRAP delete_module(): unable to adjust sysfs tree\n");
>+			return EFAULT;
>+		}
>+	}
>+
> 	errno = mod->errcode;
> 	return mod->ret;
> }
>
>-- 
>2.40.0
>
