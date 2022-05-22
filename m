Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592AEC433F5
	for <linux-modules@archiver.kernel.org>; Sun, 22 May 2022 16:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbiEVQEj (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 22 May 2022 12:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiEVQEg (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 22 May 2022 12:04:36 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F1C167EA;
        Sun, 22 May 2022 09:04:33 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 24MG222A005058;
        Mon, 23 May 2022 01:02:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 24MG222A005058
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653235323;
        bh=SzF5mYVMdGjHhfCv/rltheskX/0l5HwxsKRJxdjGT/4=;
        h=From:To:Cc:Subject:Date:From;
        b=E11fmN0qTEJgixluB454aUu8UN2EUaQLN8HJlDpVWLReICVr+Y7vxvM2CBFphWjay
         REt3XNJHvqTFJpOz5FRdyXtmFQm5yBqJNhcFsBpCsK/tdMVH87AdJ0/K9AtnMvGagf
         vvTK4oV62IyNVbJrwbAtbQEO1+YVDf71nQ1j5vJD+S/9nZtLyq191JXwX9DCArAFnq
         BBDvVEEZDmrkCbW4RSC9XjhrhI4z8rpIjG8JDniJ4GPQBvaxCQ23eeX37DDfqRtSh5
         r5M/HpGz3B9rsJY/OiHeUPpiYkJ4QoW0xy/0KMHfOg9SFIXySudLDsN/dU7ZVqnf76
         tmDsxsaQTi79w==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] fixup! kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
Date:   Mon, 23 May 2022 01:01:17 +0900
Message-Id: <20220522160117.599023-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

I will squash this into

  https://patchwork.kernel.org/project/linux-kbuild/patch/20220513113930.10488-3-masahiroy@kernel.org/

Sedat Reported an error:

  https://lore.kernel.org/linux-kbuild/CA+icZUWttwjhDNPO1VuVyiMoReH5e83nsYDd0rEoY8-Uwv6pHw@mail.gmail.com/T/#md82f561e348b7959b7270c33ac86fa3edb0d773a

__used is needed to make the combination of
CONFIG_MODVERSIONS and CONFIG_LTO_CLANG working.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/linux/export-internal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index 77175d561058..c2b1d4fd5987 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -10,7 +10,8 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 
+/* __used is needed to keep __crc_* for LTO */
 #define SYMBOL_CRC(sym, crc, sec)   \
-	u32 __section("___kcrctab" sec "+" #sym) __crc_##sym = crc
+	u32 __section("___kcrctab" sec "+" #sym) __used __crc_##sym = crc
 
 #endif /* __LINUX_EXPORT_INTERNAL_H__ */
-- 
2.32.0

