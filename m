Return-Path: <SRS0=Fs8F=5I=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C4FC4332E
	for <linux-modules@archiver.kernel.org>; Mon, 23 Mar 2020 19:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB902051A
	for <linux-modules@archiver.kernel.org>; Mon, 23 Mar 2020 19:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgCWT3o (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:29:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:26135 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbgCWT3o (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 23 Mar 2020 15:29:44 -0400
IronPort-SDR: UD4cd3R4OlsJntiff0Dabnd+yMJVowphQZ++S50AAsB3hgfQbcu1wH/FthgCMemptBzBpoGErP
 9Av7tteUD0fQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 12:29:43 -0700
IronPort-SDR: PeN8ylxX3aZuQo/828AQU2N2ihdUc9M8N8wzIM1BbJNjPpk7mZnOgfGMgxi3T+kjN8V/i3oXKy
 kvL902XF+K0Q==
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; 
   d="scan'208";a="237991326"
Received: from sganes3-mobl1.amr.corp.intel.com (HELO ldmartin-desk1) ([10.134.73.79])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 12:29:42 -0700
Date:   Mon, 23 Mar 2020 12:29:42 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     joao.moreira@intel.com, leandro.maciel.dorileo@intel.com
Subject: Re: [PATCH 1/2] libkmod: ignore kcmdline option if we fail to parse
 modname
Message-ID: <20200323192942.xkbz7hzi2mir7tqn@ldmartin-desk1>
X-Patchwork-Hint: ignore
References: <20200310082308.14318-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200310082308.14318-1-lucas.demarchi@intel.com>
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Both patches applied.

Lucas De Marchi

On Tue, Mar 10, 2020 at 01:23:07AM -0700, Lucas De Marchi wrote:
>The error message is saying we are ignoring the option on the kernel
>command line, so just do it.
>---
> libkmod/libkmod-config.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
>index 7b62367..971f20b 100644
>--- a/libkmod/libkmod-config.c
>+++ b/libkmod/libkmod-config.c
>@@ -488,8 +488,9 @@ static void kcmdline_parse_result(struct kmod_config *config, char *modname,
> 		if (underscores(modname) < 0) {
> 			ERR(config->ctx, "Ignoring bad option on kernel command line while parsing module name: '%s'\n",
> 			    modname);
>+		} else {
>+			kmod_config_add_options(config, modname, param);
> 		}
>-		kmod_config_add_options(config, modname, param);
> 	}
> }
>
>-- 
>2.25.1
>
