Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E12C4338F
	for <linux-modules@archiver.kernel.org>; Wed, 18 Aug 2021 20:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029016108D
	for <linux-modules@archiver.kernel.org>; Wed, 18 Aug 2021 20:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhHRUyN (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 18 Aug 2021 16:54:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33070 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbhHRUyM (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 18 Aug 2021 16:54:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6567822053;
        Wed, 18 Aug 2021 20:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629320015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R5CpQ8DSndLy/xg33ENEAU3ZAv4JAglkD4zbdQ+T6WM=;
        b=1G7Ayq8O29cCra0y2ii44ti7mZ+Wn8SXS1hDEy/TziB2cucq/vJrTe42WAd4YIQvDaDVCg
        rgb7JyZq0pzR+EB+ZZsXAhcXcc6V0fR1Zkt9oAR6whGL3L/k0DGfPagMSnvKAkTp3ENN4Z
        BgoppzpDZS2vmmUESyklMgPpjCi8vvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629320015;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R5CpQ8DSndLy/xg33ENEAU3ZAv4JAglkD4zbdQ+T6WM=;
        b=/sdEZgav2qgNI716wGyUbKCr33YhkS0cu7ZgnGjh8pesHwBnK4soMURCeUWRTqIbzHQKYR
        Vdqdqtyij84GG4AA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 558FFA3B9A;
        Wed, 18 Aug 2021 20:53:35 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-modules <linux-modules@vger.kernel.org>
Cc:     Michal Suchanek <msuchanek@suse.de>, Takashi Iwai <tiwai@suse.de>,
        Petr Vorel <pvorel@suse.cz>
Subject: [PATCH] libkmod: Set builtin to no when module is created from path.
Date:   Wed, 18 Aug 2021 22:52:00 +0200
Message-Id: <20210818205159.6066-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CAKi4VAJVvY3=JdSZm-GD1hJqyCPYaYz-jBJ_REeY5BakVb6_ww@mail.gmail.com>
References: <CAKi4VAJVvY3=JdSZm-GD1hJqyCPYaYz-jBJ_REeY5BakVb6_ww@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Something like this?

Thanks

Michal

--------------------------------------------------------------------

A recent bug report showed that modinfo doesn't give the signature
information for certain modules, and it turned out to happen only on
the modules that are built-in on the running kernel; then modinfo
skips the signature check, as if the target module file never exists.
The behavior is, however, inconsistent when modinfo is performed for
external modules (no matter which kernel version is) and the module
file path is explicitly given by a command-line argument, which
guarantees the presence of the module file itself.

Fixes: e7e2cb61fa9f ("modinfo: Show information about built-in modules")
Link: https://lore.kernel.org/linux-modules/CAKi4VAJVvY3=JdSZm-GD1hJqyCPYaYz-jBJ_REeY5BakVb6_ww@mail.gmail.com/
BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1189537
Suggested-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 libkmod/libkmod-module.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 9e878a5345a1..53b220d492e8 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -432,18 +432,18 @@ KMOD_EXPORT int kmod_module_new_from_path(struct kmod_ctx *ctx,
 		}
 
 		*mod = kmod_module_ref(m);
-		return 0;
-	}
+	} else {
+		err = kmod_module_new(ctx, name, name, namelen, NULL, 0, &m);
+		if (err < 0) {
+			free(abspath);
+			return err;
+		}
 
-	err = kmod_module_new(ctx, name, name, namelen, NULL, 0, &m);
-	if (err < 0) {
-		free(abspath);
-		return err;
+		m->path = abspath;
+		*mod = m;
 	}
 
-	m->path = abspath;
-	*mod = m;
-
+	(*mod)->builtin = KMOD_MODULE_BUILTIN_NO;
 	return 0;
 }
 
-- 
2.31.1

