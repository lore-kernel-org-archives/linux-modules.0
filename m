Return-Path: <SRS0=DpRu=2N=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B46FC2D0C0
	for <linux-modules@archiver.kernel.org>; Mon, 23 Dec 2019 17:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524C620663
	for <linux-modules@archiver.kernel.org>; Mon, 23 Dec 2019 17:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umVz1CeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfLWRGm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 23 Dec 2019 12:06:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37957 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfLWRGm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 23 Dec 2019 12:06:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id k8so18375961ljh.5
        for <linux-modules@vger.kernel.org>; Mon, 23 Dec 2019 09:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version;
        bh=9cGh+SWuAnnWASzFOqwCBuq5K6JveZ+I7YskJwrK7q0=;
        b=umVz1CeGCfH9AnmAqVoM5/vzGQMSXCXOZeCTYsi1QuNSpGFZoPzOsG1nIepD60sgnF
         nOaIju2MTnz2JEFzkHznHoG/Q3vBZyrb5VTsnrzXs92KkMPSTTsPpibks+iSiMVHtdMW
         AGC8wAp9hjNyBi4EODxu2SW8ZDhH6OooMP1fxgD1zAa2wXpNvIhQku6gevuYyv2I2hHK
         +JIGEjRSLQ2R+Ah6TPFtQ/2Rh2vo8pVabRdTdfDNf0n/dA51Bw/81y1kceSw9Zb2xdEw
         uUrHbUjA6AIoDSiaj9dfLkQW6Rv2iy+masatZ1lnN1yuV0AMGF5218KBnCDabgf91Oi/
         92jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version;
        bh=9cGh+SWuAnnWASzFOqwCBuq5K6JveZ+I7YskJwrK7q0=;
        b=Qqnm3DVkCt7GakYQi9pIq8C0UOaBubpkJpQWDKb7fGESCF8CWqHaZh620c0EuE1oEi
         kebytx9NntGatNztpplnSD2yuqcRD5h80NMG4xAPUVaa4Z75mhIJSetFR53vguR9uYQd
         FtiOkkzGTzBL9KukkApPqzC6KvJEfbkjv75sJ9BYGKgVK6R4QNxvMYJ9ZKcCUupHG37A
         NYQgY/Ge8+ZDyR92XGx2dQaLJykPcxDMwXkcK5WjUG2qEzuuweUotFJzWDIFM8TVQ/PM
         yaYSEioHpq+U3f7GMg54XhjY1UK2dFXXV9KwNuZ3rotfQe7KD2IV6UeN23Bt8GhokcZ4
         zQTQ==
X-Gm-Message-State: APjAAAVg9L0McQH3NWynQ6FjSKyqT0tn8v2kd14xkQkmn1+rUHuuUd/s
        KC5ZSuS7aWk+K+haMHi4n1UgUxm1
X-Google-Smtp-Source: APXvYqwJPuljMP53Eox4VElED5fW5XhJcFucKPTEStjVCdG3z5mY6pcFclLGNPX5sU1Dr4KPSiKspA==
X-Received: by 2002:a05:651c:327:: with SMTP id b7mr17969114ljp.22.1577120800177;
        Mon, 23 Dec 2019 09:06:40 -0800 (PST)
Received: from [192.168.1.36] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id t81sm8617110lff.25.2019.12.23.09.06.39
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 09:06:39 -0800 (PST)
To:     linux-modules@vger.kernel.org
From:   Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] libkmod-module: convert return value from system() to errno
Message-ID: <f8c64aed-b4a1-e43f-ed4b-f99236932477@gmail.com>
Date:   Mon, 23 Dec 2019 19:06:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------621963F65A72DD7056967A32"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This is a multi-part message in MIME format.
--------------621963F65A72DD7056967A32
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Don't use exit status of a command directly as errno code, callers
will be confused.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
  libkmod/libkmod-module.c | 8 +++++---
  1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 8044a8f..6031d80 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -983,11 +983,13 @@ static int command_do(struct kmod_module *mod, 
const char *type,
         if (err == -1 || WEXITSTATUS(err)) {
                 ERR(mod->ctx, "Error running %s command for %s\n",
                                                                 type, 
modname);
-               if (err != -1)
-                       err = -WEXITSTATUS(err);
+               if (err != -1) /* nonzero exit status: something bad 
happened */
+                       return -EINVAL;
+               else /* child process could not be created */
+                       return -errno;
         }

-       return err;
+       return 0;
  }

  struct probe_insert_cb {
-- 
2.24.0

--------------621963F65A72DD7056967A32
Content-Type: text/x-diff;
 name="0001-libkmod-module-convert-return-value-from-system-to-e.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-libkmod-module-convert-return-value-from-system-to-e.pa";
 filename*1="tch"

From f560864a4a8fd61c2881cfefb970db27c2418690 Mon Sep 17 00:00:00 2001
From: Topi Miettinen <toiwoton@gmail.com>
Date: Mon, 23 Dec 2019 18:58:13 +0200
Subject: [PATCH] libkmod-module: convert return value from system() to errno

Don't use exit status of a command directly as errno code, callers
will be confused.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 libkmod/libkmod-module.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 8044a8f..6031d80 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -983,11 +983,13 @@ static int command_do(struct kmod_module *mod, const char *type,
 	if (err == -1 || WEXITSTATUS(err)) {
 		ERR(mod->ctx, "Error running %s command for %s\n",
 								type, modname);
-		if (err != -1)
-			err = -WEXITSTATUS(err);
+		if (err != -1) /* nonzero exit status: something bad happened */
+			return -EINVAL;
+		else /* child process could not be created */
+			return -errno;
 	}
 
-	return err;
+	return 0;
 }
 
 struct probe_insert_cb {
-- 
2.24.0


--------------621963F65A72DD7056967A32--
