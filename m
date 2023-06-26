Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81963EB64D7
	for <linux-modules@archiver.kernel.org>; Mon, 26 Jun 2023 10:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjFZKdc (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 26 Jun 2023 06:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFZKdb (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 26 Jun 2023 06:33:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B48172A;
        Mon, 26 Jun 2023 03:32:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 237891F74B;
        Mon, 26 Jun 2023 10:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687775574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=z+HSLECNibzVOo7kYE3yRqNP3uGJcAQpmYEuFSJm/OI=;
        b=eWDLaoiIC8nY2Eyf9HoiKnryKS7ZVt9r0tcTunuPJbaiAa53ryeZM0uuc0tMiA3fYq8YR3
        rCi4zO0qHieNqI9B1kbnY14hPP2PfRavqTV8yhnJ+jFqCF1RwwFlE4YsqXtFz5zLqEOq8g
        WLb25zUXSR3mxFJjc1AEWeAllF54qN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687775574;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=z+HSLECNibzVOo7kYE3yRqNP3uGJcAQpmYEuFSJm/OI=;
        b=bMbbCan38BmV4BchYOSRSYuGzmBcYrHYluBk3qG41KG/GATFQDYN7GtQx5vV2VWd6v6W1c
        vg2XM2ROl8rR2RBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE9F513905;
        Mon, 26 Jun 2023 10:32:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VFO4NFVpmWTYDwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 26 Jun 2023 10:32:53 +0000
Date:   Mon, 26 Jun 2023 12:32:52 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] module: print module name on refcount error
Message-ID: <20230626123252.73dbc139@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

If module_put() triggers a refcount error, include the culprit
module name in the warning message, to easy further investigation of
the issue.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Suggested-by: Michal Hocko <mhocko@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-6.3.orig/kernel/module/main.c
+++ linux-6.3/kernel/module/main.c
@@ -850,7 +850,9 @@ void module_put(struct module *module)
 	if (module) {
 		preempt_disable();
 		ret = atomic_dec_if_positive(&module->refcnt);
-		WARN_ON(ret < 0);	/* Failed to put refcount */
+		WARN(ret < 0,
+		     KERN_WARNING "Failed to put refcount for module %s\n",
+		     module->name);
 		trace_module_put(module, _RET_IP_);
 		preempt_enable();
 	}


-- 
Jean Delvare
SUSE L3 Support
