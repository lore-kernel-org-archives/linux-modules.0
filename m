Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CA0C48BCF
	for <linux-modules@archiver.kernel.org>; Wed,  9 Jun 2021 17:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF98361040
	for <linux-modules@archiver.kernel.org>; Wed,  9 Jun 2021 17:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhFIRYM (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 9 Jun 2021 13:24:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:64528 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231503AbhFIRYL (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 9 Jun 2021 13:24:11 -0400
IronPort-SDR: fuxSvFBGZv9+1JaQ/PU8tdw6pAGoGv9lokmEZ2KfXkn2mpFC5JYVzQ256q1wNXTkf+pFs2P2+k
 FYOzal30WV4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192436703"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="192436703"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 10:22:16 -0700
IronPort-SDR: /14mYxWIFwJzE30ZpC6Ml+aJeUNgFQLlgtoanGkSDdXDoSMVKbjxba2EMOllBwFkiYOre4w3Yg
 COrVZUrxB4rQ==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="619743920"
Received: from lfbrown-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.254.4.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 10:22:15 -0700
Date:   Wed, 9 Jun 2021 10:22:15 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     linux-modules@vger.kernel.org, lucas.de.marchi@gmail.com
Subject: Re: [PATCH 1/2] libkmod-module: check "new_from_name" return value
 in get_builtin
Message-ID: <20210609172215.4qkrxtkbfjq3cs2u@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20210608062859.93959-1-ykaliuta@redhat.com>
 <20210608062923.94017-1-ykaliuta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210608062923.94017-1-ykaliuta@redhat.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jun 08, 2021 at 09:29:22AM +0300, Yauheni Kaliuta wrote:
>kmod_module_new_from_name() may fail and return error value. It is
>handled properly across the code, but in this particular place the
>check is missing.
>
>Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>

applied, thanks

Lucas De Marchi

>---
> libkmod/libkmod-module.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
>index b6320cc87e80..6e0ff1a99604 100644
>--- a/libkmod/libkmod-module.c
>+++ b/libkmod/libkmod-module.c
>@@ -2912,7 +2912,10 @@ int kmod_module_get_builtin(struct kmod_ctx *ctx, struct kmod_list **list)
> 			goto fail;
> 		}
>
>-		kmod_module_new_from_name(ctx, modname, &mod);
>+		err = kmod_module_new_from_name(ctx, modname, &mod);
>+		if (err < 0)
>+			goto fail;
>+
> 		kmod_module_set_builtin(mod, true);
>
> 		*list = kmod_list_append(*list, mod);
>-- 
>2.31.1
>
