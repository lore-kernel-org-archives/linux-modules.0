Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73E2C77B60
	for <linux-modules@archiver.kernel.org>; Sun, 19 Mar 2023 21:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCSVtt (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 19 Mar 2023 17:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCSVtb (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 19 Mar 2023 17:49:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A6712862;
        Sun, 19 Mar 2023 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=T1LQ0uGx/wzovMrrATWhqTlL4fpNlSzd8BTXmfhLms0=; b=wweFuraI7yI2EoSo2+nvarPd1c
        vD55fpRAYB9qdho9OwP4d5sjw8lhcYwAjpL3IyoIXYGb/6ZHCB+qsYw8mW6mfVkVnMVUN6kjos0SA
        RcfXHEFndNBBUa5ISv6tONWsvltQCeiTSEg7/nwggFYHdcb9Vk7qml5tIvP1Sx/R+aW6+r8aW+Wq+
        6fHjR9m7zwpoHqDpUdUqnlQZNUPQJti3itDxZhvXZDyE0Rnu509NHAsRoXGG2jp0aBSObN/MMq5Ia
        DUnKZ+yFhL6Ix6HfJshwy38DwjHbmYwqP/A1YsXmXviRPXSn4WdvAUK3nZFwpwqTWn4wb8Taw2Ksw
        n6WKXRpg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0u8-007WjW-0b;
        Sun, 19 Mar 2023 21:49:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [RFT 4/5] module: use list_add_tail_rcu() when adding module
Date:   Sun, 19 Mar 2023 14:49:25 -0700
Message-Id: <20230319214926.1794108-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230319214926.1794108-1-mcgrof@kernel.org>
References: <20230319214926.1794108-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Put a new module at the end of the list intead of making
new modules at the top of the list. find_module_all() start
the hunt using the first entry on the list, if we assume
that the modules which are first loaded are the most
frequently looked for modules this should provide a tiny
optimization.

With a 8vcpu 8 GiB RAM kvm guest with kdevops with kdevops
this saves about 4 MiB of RAM max use during the kmod tests
0008 which loops and runs loading a module in a loop through
kthreads while not affecting the time to test.

There could be some minor savings for systems that have repeated
module requests for subsystems that are not yet optimized (ACPI
frequency drivers come to mind) so in theory this could help there
but that is just pure speculation.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 0ad26455def2..32955b7819b3 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2682,7 +2682,7 @@ static int add_unformed_module(struct module *mod)
 		goto out;
 
 	mod_update_bounds(mod);
-	list_add_rcu(&mod->list, &modules);
+	list_add_tail_rcu(&mod->list, &modules);
 	mod_tree_insert(mod);
 	err = 0;
 
-- 
2.39.1

