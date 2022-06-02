Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D17FC433EF
	for <linux-modules@archiver.kernel.org>; Thu,  2 Jun 2022 03:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiFBDlS (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 1 Jun 2022 23:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFBDlR (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 1 Jun 2022 23:41:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86BE10EA5B
        for <linux-modules@vger.kernel.org>; Wed,  1 Jun 2022 20:41:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y139-20020a253291000000b0065cff9ce37aso3073286yby.23
        for <linux-modules@vger.kernel.org>; Wed, 01 Jun 2022 20:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=0TP45ri2Rm0IThufZmYq3gqP6Oy9O8gtuE5Zzf1fHAI=;
        b=og8WzEFivR8Aec/KX7BrbGLQQPelHY3Yy/jjiXxB2vK6lARri6hHWfheQdsdX6Hy6+
         UHkebTYJ0qp18z95eOavjJWjeFd9wrgOTICLUx08bZLN4T+Nw7DayipbRPSPqLonsZIy
         LfyKCq5QkurwvGpFQ68jTCsxSbKHJ83VfcI4cTYeO/IDIro7YAbm7oWThRUJVI6Ol91e
         Nil3SjjT2fa8WsD30Yhyv+1YPMmAwgbv/biePE5kQRa9arJJz4TR+O6IOXN5ZCXK1+CV
         MfeQ8Pb9IO+WR1iAhApAHbXrerk5zm5EWLFIH5vePQiROln4wZmFC3sq7pndZ7dxbjof
         lt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=0TP45ri2Rm0IThufZmYq3gqP6Oy9O8gtuE5Zzf1fHAI=;
        b=DVjFlAo9Wgzn6PThhjyhATwSzpDB27SzjNEwgSySOfztssL1UQX3CIQ/sxqqm5Fh5i
         V8ubUYq/M5SccKs/volahv4yWxuDCNnzUW5lMCyDbdbJNRBq3ExkhyZOV8EX/NWwbFwk
         f2Px7e2+0iZn2Ftiw0xww1tdU5wZWlhXqaCln4b23h/vhG8+vqnQz+ACx/7WFFYtxefo
         uxC+LAF5Dp/fNPxjgOqD5tkCGhNdo103fnlmvX9oJIFeK2Gh4T3LQT+Wh+jDfdBTyWhg
         vgdnmJIycF6Cd+Se7fhUXDW8h3Dhsev4Nx3hdA9xOLT8ALxERZtk9G8k22SIHHTIGahp
         04vg==
X-Gm-Message-State: AOAM532jIZYsp8JOHUkjvhhsj72qb5C7OD2oqUOdFTgXZutFcxR1Wtws
        3h084W74rRMMv+eStRvuO23KlsY3fvS9qds=
X-Google-Smtp-Source: ABdhPJyMQ1uPP0a6d0b+oQI3447LUskffZDUTKA0VTs1kzreaAXTeiomm5PVbRJ1j6J5zQ+3c6k/pZutNDYYZO0=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f3aa:cafe:c20a:e136])
 (user=saravanak job=sendgmr) by 2002:a81:5512:0:b0:30c:398d:61d4 with SMTP id
 j18-20020a815512000000b0030c398d61d4mr3350296ywb.58.1654141274869; Wed, 01
 Jun 2022 20:41:14 -0700 (PDT)
Date:   Wed,  1 Jun 2022 20:41:11 -0700
In-Reply-To: <20220322140344.556474-2-atomlin@redhat.com>
Message-Id: <20220602034111.4163292-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: Re: [PATCH v12 01/14] module: Move all into module/
From:   Saravana Kannan <saravanak@google.com>
To:     Aaron Tomlin <atomlin@redhat.com>, mcgrof@kernel.org,
        christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Aaron Tomlin <atomlin@redhat.com> wrote:
> No functional changes.

I could be mistaken, but I think this has a functional change and could
break module signature enforcement in some cases.

> 
> This patch moves all module related code into a separate directory,
> modifies each file name and creates a new Makefile. Note: this effort
> is in preparation to refactor core module code.
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  MAINTAINERS                                         |  2 +-
>  kernel/Makefile                                     |  5 +----
>  kernel/module/Makefile                              | 12 ++++++++++++
>  kernel/{module_decompress.c => module/decompress.c} |  2 +-
>  kernel/{module-internal.h => module/internal.h}     |  0
>  kernel/{module.c => module/main.c}                  |  2 +-
>  kernel/{module_signing.c => module/signing.c}       |  2 +-

I spent at least an hour trying to figure out how the code below in
module/signing.c (was moved from module/main.c in a later patch in this
series) managed to have a "module" prefix for "module.sig_enforce" kernel
cmdline param and for the /sys/module/module/parameters/sig_enforce file.

static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
module_param(sig_enforce, bool_enable_only, 0644);

I thought I was missing something until I realized this was a very recent
change and might actually be a bug. If I'm not mistaken, the prefix will
now become "signing". So the kernel cmdline param would get ignore and any
userspace writes to /sys/module/module/parameters/sig_enforce will start
failing.

I don't have a device to boot 5.19-rcX in, but I think I'm right. Can
someone confirm?

If my code analysis is right, then the fix seems to be adding this code
before the module_param() line.

diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index 85c8999dfecf..6b0672e4417b 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -16,6 +16,11 @@
 #include <uapi/linux/module.h>
 #include "internal.h"
 
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "module."
+
 static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
 module_param(sig_enforce, bool_enable_only, 0644);

-Saravana
