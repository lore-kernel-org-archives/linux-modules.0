Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A66C433EF
	for <linux-modules@archiver.kernel.org>; Sun, 12 Jun 2022 10:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiFLKRq (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 12 Jun 2022 06:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbiFLKRp (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 12 Jun 2022 06:17:45 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF613E84;
        Sun, 12 Jun 2022 03:17:41 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LLVxw3l7Xz9tDN;
        Sun, 12 Jun 2022 12:17:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XTndmNYRrRMU; Sun, 12 Jun 2022 12:17:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LLVxw2dQPz9t9d;
        Sun, 12 Jun 2022 12:17:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 427B78B76D;
        Sun, 12 Jun 2022 12:17:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zw5tKwdR51RN; Sun, 12 Jun 2022 12:17:40 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.193])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 06EA68B767;
        Sun, 12 Jun 2022 12:17:39 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 25CAHUYV048681
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 12 Jun 2022 12:17:30 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 25CAHT59048680;
        Sun, 12 Jun 2022 12:17:29 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] module: Fix selfAssignment cppcheck warning
Date:   Sun, 12 Jun 2022 12:17:25 +0200
Message-Id: <023c3097576650c1af77344be9937833bb303a6c.1655028735.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1655029044; l=2346; s=20211009; h=from:subject:message-id; bh=Cnody7fZ4v0eN7AnNtz5ncbw0xjUREFAKECK08Dh6Qc=; b=DiutiPtOwrPMsKZnyuojtmuBNjpId1BXFWTwR7weS4E+bLl1q+rvj7g3z1dUjIizcLZw8ZrzdCgv bu1qJ9+ABS6Py5C0PxwKUEulmxMe244Cc8J5sOO/DGgjps0ZQmc4
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

cppcheck reports the following warnings:

kernel/module/main.c:1455:26: warning: Redundant assignment of 'mod->core_layout.size' to itself. [selfAssignment]
   mod->core_layout.size = strict_align(mod->core_layout.size);
                         ^
kernel/module/main.c:1489:26: warning: Redundant assignment of 'mod->init_layout.size' to itself. [selfAssignment]
   mod->init_layout.size = strict_align(mod->init_layout.size);
                         ^
kernel/module/main.c:1493:26: warning: Redundant assignment of 'mod->init_layout.size' to itself. [selfAssignment]
   mod->init_layout.size = strict_align(mod->init_layout.size);
                         ^
kernel/module/main.c:1504:26: warning: Redundant assignment of 'mod->init_layout.size' to itself. [selfAssignment]
   mod->init_layout.size = strict_align(mod->init_layout.size);
                         ^
kernel/module/main.c:1459:26: warning: Redundant assignment of 'mod->data_layout.size' to itself. [selfAssignment]
   mod->data_layout.size = strict_align(mod->data_layout.size);
                         ^
kernel/module/main.c:1463:26: warning: Redundant assignment of 'mod->data_layout.size' to itself. [selfAssignment]
   mod->data_layout.size = strict_align(mod->data_layout.size);
                         ^
kernel/module/main.c:1467:26: warning: Redundant assignment of 'mod->data_layout.size' to itself. [selfAssignment]
   mod->data_layout.size = strict_align(mod->data_layout.size);
                         ^

This is due to strict_align() being a no-op when
CONFIG_STRICT_MODULE_RWX is not selected.

Change strict_align() to a bitwise OR with 0 in order to feint cppcheck.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/internal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index bc5507ab8450..8396d5f5daa0 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -33,7 +33,8 @@
 #ifdef CONFIG_STRICT_MODULE_RWX
 # define strict_align(X) PAGE_ALIGN(X)
 #else
-# define strict_align(X) (X)
+/* OR with zero to avoid cppcheck selfAssignment warning */
+# define strict_align(X) ((X) | 0)
 #endif
 
 extern struct mutex module_mutex;
-- 
2.35.3

