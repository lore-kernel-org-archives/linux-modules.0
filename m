Return-Path: <SRS0=PaVa=ZK=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF6CC432C0
	for <linux-modules@archiver.kernel.org>; Mon, 18 Nov 2019 21:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7602230D
	for <linux-modules@archiver.kernel.org>; Mon, 18 Nov 2019 21:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bspvoBQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfKRVz4 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:55:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44526 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfKRVzz (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 18 Nov 2019 16:55:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id f2so21365205wrs.11
        for <linux-modules@vger.kernel.org>; Mon, 18 Nov 2019 13:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jj/ScSv23SVc3RHEAUJfQSUjQi27jUOITpuew9WFmio=;
        b=bspvoBQOFaAQmso4M3pPfJOq4E/Tt/QDKBXTw/9YKrU/5djn1hL1qMd1rIKaNKhOlX
         2nP19VPkpz8UXW2y+U/PWKzbI+oF9dqIXNkDym7MMpRfGPtRSondcKfkZ8NG5JyMiTwX
         6ZulMOf5bLTu1byd7Q00y71OG600lyFqOOTmDu8NcUsTCuuBCCiAYuwDs5meTqyfwG2p
         KxpoAHpTyqYKJDNon1LlyqQJVX/ERptuXjXUJ4cqH+7ht3UT9LpfxCXkHz0YNKCIPhzK
         4kgIOSRgIGHEB0qw6GSBlv4f5YxPsfmuBSLieF17bphK0dTDkJCxHKYlgBk6mMD1QDnn
         vLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jj/ScSv23SVc3RHEAUJfQSUjQi27jUOITpuew9WFmio=;
        b=NpWwFiKoAQkF+OcMTvbZtwMO6arOsVM3zpFkyHW49S8nEjJ3iOGV+8fLWWSxAwyAos
         lG329MBAAiY6WzbWts8SHclMtGPeU+oZsLf6QSD3ZkpT5Bli+ZIWwtp9HHe5p9uLdSBe
         hqGyUzG+hBCMtA7zRx+4oS/Pqim7QKwWwmIdyhMkQnT2Jx78W8WrErmfyyAQDw0KlidT
         xCstwj/9wF/gx1XXXG9XQaNdtVtCP+9VzPNy5DWj+CzT5T65aouq67c34HraAdgieD/i
         abhgWv2LZSnF1s6YXPC9Hl+G9h+FbQpoSf8aaZweclxtj3mLxnXmLpvL67MiRvI2oTNo
         L6XA==
X-Gm-Message-State: APjAAAVrGyxpgSOtqIsEDgpftAyvVF5BZCDhrTdlHV77DTNIxIdBoPuI
        xLW7Zh1f+HMn59/ZnczPVOGbP0py
X-Google-Smtp-Source: APXvYqwtpx+kgfoblKyr0G52aYW3VY8+Qz7A6Ewp40b60kcbPwIS3AEx2xy6MOax0+MetMO6FH4tzA==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr2783606wrn.225.1574114153803;
        Mon, 18 Nov 2019 13:55:53 -0800 (PST)
Received: from kali.home (lfbn-1-3732-187.w86-229.abo.wanadoo.fr. [86.229.230.187])
        by smtp.gmail.com with ESMTPSA id t185sm810798wmf.45.2019.11.18.13.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 13:55:52 -0800 (PST)
From:   Fabrice Fontaine <fontaine.fabrice@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] Makefile.am: filter -Wl,--no-undefined
Date:   Mon, 18 Nov 2019 22:56:17 +0100
Message-Id: <20191118215617.395319-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Commit 1d14ef82f4a3be741bcdf6b1c6d51ce9dce43567 does not completely fix
the build with python 3.8 as we still get link failure due to
'-z undefs' being ignored by some versions of ld.

Indeed, -z undefs was added by commit
97a232d7335f3bd0231fd9cd39455bde1d563922 in upstream binutils, and this
commit was first present in binutils 2.30.
So any toolchain using binutils version older than that won't have
-z undefs and will build fail on:

/home/buildroot/autobuild/instance-0/output-1/host/opt/ext-toolchain/bin/../lib/gcc/mips-linux-gnu/5.3.0/../../../../mips-linux-gnu/bin/ld: warning: -z undefs ignored.

/home/naourr/work/instance-1/output-1/host/opt/ext-toolchain/bin/../lib/gcc/aarch64_be-linux-gnu/7.3.1/../../../../aarch64_be-linux-gnu/bin/ld: warning: -z undefs ignored.

So filter -Wl,--no-undefined to fix the issue

Fixes:
 - http://autobuild.buildroot.org/results/e9645d9969481b09f507f6e0d0b35faaa283eb60
 - http://autobuild.buildroot.org/results/06a6d865b6b7d8ebd793bde214f4a4c40e0962e1

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 Makefile.am | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 8e9c90d..47505c1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -173,7 +173,10 @@ CPYTHON_MODULE_CFLAGS = \
 	$(AM_CFLAGS) -DCPYTHON_COMPILING_IN_PYPY=0 \
 	$(PYTHON_NOWARN) $(PYTHON_CFLAGS) \
 	-fvisibility=default
-CPYTHON_MODULE_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version -shared -Wl,-z,undefs
+# Filter -Wl,--no-undefined to fix build with python 3.8
+comma = ,
+CPYTHON_MODULE_LDFLAGS = $(subst -Wl$(comma)--no-undefined,,$(AM_LDFLAGS))
+CPYTHON_MODULE_LDFLAGS += -module -avoid-version -shared
 
 if BUILD_PYTHON
 pkgpyexec_LTLIBRARIES = \
-- 
2.24.0

