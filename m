Return-Path: <SRS0=6exi=Y7=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD45C5DF61
	for <linux-modules@archiver.kernel.org>; Thu,  7 Nov 2019 07:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECBD21D79
	for <linux-modules@archiver.kernel.org>; Thu,  7 Nov 2019 07:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfKGHgn (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:36:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:4483 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfKGHgn (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 7 Nov 2019 02:36:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 23:36:42 -0800
X-IronPort-AV: E=Sophos;i="5.68,277,1569308400"; 
   d="scan'208";a="192740513"
Received: from grosner-mobl2.amr.corp.intel.com (HELO ldmartin-desk1) ([10.254.108.231])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 23:36:42 -0800
Date:   Wed, 6 Nov 2019 23:36:36 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH] modprobe: ignore builtin module on recursive removing
Message-ID: <20191107073636.jruf3y6g4jm5bsoo@ldmartin-desk1>
References: <20191031181253.18162-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191031181253.18162-1-yauheni.kaliuta@redhat.com>
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Oct 31, 2019 at 08:12:53PM +0200, Yauheni Kaliuta wrote:
>If there are built-in dependencies and any of them is built-in in
>the kernel, modprobe -r fails with
>
>modprobe: FATAL: Module module_name is builtin.
>
>It makes sense to ignore such dependencies for the case when
>removing is called for non-top level module.
>
>Example: cifs module, it declares bunch of softdeps and the first
>one fails on some kernel configs:
>
>modprobe: FATAL: Module gcm is builtin.
>
>Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>

makes sense.

thanks, applied.

Lucas De Marchi

>---
> tools/modprobe.c | 18 ++++++++++++------
> 1 file changed, 12 insertions(+), 6 deletions(-)
>
>diff --git a/tools/modprobe.c b/tools/modprobe.c
>index a9e2331567af..44cd15c2bf57 100644
>--- a/tools/modprobe.c
>+++ b/tools/modprobe.c
>@@ -353,7 +353,8 @@ static int rmmod_do_remove_module(struct kmod_module *mod)
> 	return err;
> }
>
>-static int rmmod_do_module(struct kmod_module *mod, bool do_dependencies);
>+static int rmmod_do_module(struct kmod_module *mod, bool do_dependencies,
>+			   bool ignore_builtin);
>
> static int rmmod_do_deps_list(struct kmod_list *list, bool stop_on_errors)
> {
>@@ -361,7 +362,7 @@ static int rmmod_do_deps_list(struct kmod_list *list, bool stop_on_errors)
>
> 	kmod_list_foreach_reverse(l, list) {
> 		struct kmod_module *m = kmod_module_get_module(l);
>-		int r = rmmod_do_module(m, false);
>+		int r = rmmod_do_module(m, false, true);
> 		kmod_module_unref(m);
>
> 		if (r < 0 && stop_on_errors)
>@@ -371,7 +372,8 @@ static int rmmod_do_deps_list(struct kmod_list *list, bool stop_on_errors)
> 	return 0;
> }
>
>-static int rmmod_do_module(struct kmod_module *mod, bool do_dependencies)
>+static int rmmod_do_module(struct kmod_module *mod, bool do_dependencies,
>+			   bool ignore_builtin)
> {
> 	const char *modname = kmod_module_get_name(mod);
> 	struct kmod_list *pre = NULL, *post = NULL;
>@@ -401,8 +403,12 @@ static int rmmod_do_module(struct kmod_module *mod, bool do_dependencies)
> 			}
> 			goto error;
> 		} else if (state == KMOD_MODULE_BUILTIN) {
>-			LOG("Module %s is builtin.\n", modname);
>-			err = -ENOENT;
>+			if (ignore_builtin) {
>+				err = 0;
>+			} else {
>+				LOG("Module %s is builtin.\n", modname);
>+				err = -ENOENT;
>+			}
> 			goto error;
> 		}
> 	}
>@@ -462,7 +468,7 @@ static int rmmod(struct kmod_ctx *ctx, const char *alias)
>
> 	kmod_list_foreach(l, list) {
> 		struct kmod_module *mod = kmod_module_get_module(l);
>-		err = rmmod_do_module(mod, true);
>+		err = rmmod_do_module(mod, true, false);
> 		kmod_module_unref(mod);
> 		if (err < 0)
> 			break;
>-- 
>2.23.0
>
