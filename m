Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABB3C4338F
	for <linux-modules@archiver.kernel.org>; Wed, 18 Aug 2021 11:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A178F60524
	for <linux-modules@archiver.kernel.org>; Wed, 18 Aug 2021 11:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhHRLWr (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 18 Aug 2021 07:22:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59090 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbhHRLWr (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 18 Aug 2021 07:22:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D9894218EF
        for <linux-modules@vger.kernel.org>; Wed, 18 Aug 2021 11:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629285731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=97WYgRQ+J3f7A53JHUlfjhbW2MbmuoNIXVFmGJVcFqc=;
        b=sWQV4oDR0Jq4mfRQxItPB6cNV32ye39cpmrrcTt8XO4HvqhyraO28EJHhJ1eGUoXY15IfR
        hmALrTmRXWM2/HjlSuLaLf3axRrawZx5w9HFb25AZlEE2lAj17y+oCJ6RipbpR4ROmLBAt
        nJVWLoOHagItCMrsTwxMziZ4SR1pWPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629285731;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=97WYgRQ+J3f7A53JHUlfjhbW2MbmuoNIXVFmGJVcFqc=;
        b=5DXx7CqpDUq61Smspe8rkR9jhx5tsMQy94TMWzyE9RyYh2Mv6l+aggrYJqFokmnkYUhExf
        dsZ2w+ZR87AiRbDQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id D359BA3B91;
        Wed, 18 Aug 2021 11:22:11 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.cz>
Subject: [PATCH] modinfo: don't parse built-in for explicitly given module files
Date:   Wed, 18 Aug 2021 13:22:03 +0200
Message-Id: <20210818112203.24863-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

A recent bug report showed that modinfo doesn't give the signature
information for certain modules, and it turned out to happen only on
the modules that are built-in on the running kernel; then modinfo
skips the signature check, as if the target module file never exists.
The behavior is, however, inconsistent when modinfo is performed for
external modules (no matter which kernel version is) and the module
file path is explicitly given by a command-line argument, which
guarantees the presence of the module file itself.

This patch addresses the regression by checking the presence of the
module path at first before checking the built-in module.

Fixes: e7e2cb61fa9f ("modinfo: Show information about built-in modules")
BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1189537
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 libkmod/libkmod-module.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 6e0ff1a99604..9e878a5345a1 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2292,7 +2292,8 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 	assert(*list == NULL);
 
 	/* remove const: this can only change internal state */
-	if (kmod_module_is_builtin((struct kmod_module *)mod)) {
+	if (!kmod_module_get_path(mod) &&
+	    kmod_module_is_builtin((struct kmod_module *)mod)) {
 		count = kmod_builtin_get_modinfo(mod->ctx,
 						kmod_module_get_name(mod),
 						&strings);
-- 
2.26.2

