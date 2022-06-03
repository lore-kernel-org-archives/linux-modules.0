Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75668C43334
	for <linux-modules@archiver.kernel.org>; Fri,  3 Jun 2022 20:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbiFCUtS (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 3 Jun 2022 16:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242796AbiFCUtS (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 3 Jun 2022 16:49:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B939326D4
        for <linux-modules@vger.kernel.org>; Fri,  3 Jun 2022 13:49:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so12982101pju.1
        for <linux-modules@vger.kernel.org>; Fri, 03 Jun 2022 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dhZfbM6xzM2iQ1+vFZPDuN/V3m1neL9YE+AD0Cp3isU=;
        b=XacbLOrzEuAVzrRGfGigPbo1d4Gmf+0/GhnN+a7W5mpCQW4iqXgAbm7Eezc41VPUc+
         QPudBECB69Ky5V9lp5B4FnX3pTjkSvTOqdLsUg0CWDNtEKsii98XFsm9JWF/oFaJMSGU
         bfF5SyNEwctR0kJYLlpfYh6juQHQRql50NGEYXfX+FPg9/TOkePrX+xar4curl2mIfgz
         i+h7jnx4SmIQ+WP+ob2/8VYyynBI4mYUwL0WQGgMzoY2DLI+09YvM37UiY1/pYwFEvIO
         YXM5UgVmdBFZaykwou3PMTGvy+s9OzJnB9PRHpUAOioY/9JVsLt9XYjIiHb3ABFdxcyi
         n3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dhZfbM6xzM2iQ1+vFZPDuN/V3m1neL9YE+AD0Cp3isU=;
        b=tnhMX1gHn5Il9O3dK50mDyWcJsDzJxIGnIUzPw2SANdMnGDaZl8si3b3bur2pt6gOc
         p+SZYOnv2TT+ocNs8fXrHZ2zxVHeI2aCx9/WLQCG+gMoHypk0ZjSoelXjWESndPDBED4
         zeZ9/aRJec9snobiBWMNKz7jToMtFwbGd3+wWx9jJS/gpLsTdg3HHfcF+YiDNw9TmUDo
         zPb9N2n+mYhvy9NNy1mkr5DL0ahRH89ZmkYnB62sMD9yeubvYdLpp3w+pEL5IHWbiujg
         XyHS4ljbC72Enwq4fZUywNQs9SAFcuxNOpPLDlth2rj2mde3sw8Wl73wB3KTxPTwxN1z
         17Mw==
X-Gm-Message-State: AOAM53242EiSF6a9IaB4lM36C3NTP6yhtx18MjXvND+S7wdf++D+fwJB
        bqJzdqw6+VNsSreUb0CYNTq8kAFT6Ks=
X-Google-Smtp-Source: ABdhPJwOvGDe54P2l3DaR1sJq6hZgxUv18yfyphAGT2Jg7vPV6QHYIXxntr6+6xWmivhhVgxkTuiOg==
X-Received: by 2002:a17:90b:38c4:b0:1e6:89f9:73da with SMTP id nn4-20020a17090b38c400b001e689f973damr10386763pjb.220.1654289356312;
        Fri, 03 Jun 2022 13:49:16 -0700 (PDT)
Received: from ldmartin-desk2.. ([50.45.187.67])
        by smtp.gmail.com with ESMTPSA id s16-20020aa78bd0000000b0051bbd79fc9csm4703754pfd.57.2022.06.03.13.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 13:49:15 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 1/2] depmod: Fix writing over array length
Date:   Fri,  3 Jun 2022 13:49:01 -0700
Message-Id: <20220603204902.4295-1-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Make sure return value in flush_stream_to() is the length written
if the value didn't the size. Fix warning on gcc 12.1:

	tools/depmod.c: In function ‘output_builtin_alias_bin’:
	tools/depmod.c:2465:24: warning: array subscript 4096 is above array bounds of ‘char[4096]’ [-Warray-bounds]
	 2465 |                 modname[len] = '\0';
	      |                 ~~~~~~~^~~~~
	tools/depmod.c:2460:22: note: while referencing ‘modname’
	 2460 |                 char modname[PATH_MAX];
	      |                      ^~~~~~~
	tools/depmod.c:2477:22: warning: array subscript 4096 is above array bounds of ‘char[4096]’ [-Warray-bounds]
	 2477 |                 value[len] = '\0';
	      |                 ~~~~~^~~~~
	tools/depmod.c:2461:22: note: while referencing ‘value’
	 2461 |                 char value[PATH_MAX];
	      |                      ^~~~~

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 tools/depmod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/depmod.c b/tools/depmod.c
index 4117dd1..364b7d4 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2430,6 +2430,7 @@ static int flush_stream_to(FILE *in, int endchar, char *dst, size_t dst_sz)
 	if (i == dst_sz) {
 		WRN("Could not flush stream: %d. Partial content: %.*s\n",
 		    ENOSPC, (int) dst_sz, dst);
+		i--;
 	}
 
 	return c == endchar ? i : 0;
-- 
2.36.1

