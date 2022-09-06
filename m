Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3975FECAAA1
	for <linux-modules@archiver.kernel.org>; Tue,  6 Sep 2022 08:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238775AbiIFIJ7 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 6 Sep 2022 04:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiIFIJa (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 6 Sep 2022 04:09:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926542AC4
        for <linux-modules@vger.kernel.org>; Tue,  6 Sep 2022 01:09:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E2CA91F9A9;
        Tue,  6 Sep 2022 08:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662451765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ewZ342HoqKNRvhFXzPbAvTSVrG07X44H1BKPTjO09/0=;
        b=lLKpjCsEN9BZKJ2TTaz2aZE5zgxY4F+PXWg0tNzUM7EM3lB2YAjiMVWzqjIm1NrBl7LIKd
        kJ0GeIEzm8UM+iegCoiUXj2h5M8SUxBxOrkWQXKHEu7JtpPilhdRYrImx8UAq3vZFSmU91
        2c3fr2v0HyhvQ5k/226zXA/OAsZJ7tE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662451765;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ewZ342HoqKNRvhFXzPbAvTSVrG07X44H1BKPTjO09/0=;
        b=3NV5/khysXmRAY/yXT9ZeitXR7MzuX9gseBXzmXtEiAUALfvsZ17Lt0uN27G0ymdA0p5gv
        87pIhsGWD+tBxMCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8E8413A7A;
        Tue,  6 Sep 2022 08:09:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id odusKzUAF2PJRwAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 06 Sep 2022 08:09:25 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     dmitry.torokhov@gmail.com, mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH resend] module/decompress: generate sysfs string at compile time
Date:   Tue,  6 Sep 2022 10:03:18 +0200
Message-Id: <20220906080317.15426-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

compression_show() before (with noinline):
   0xffffffff810b5ff0 <+0>:     mov    %rdx,%rdi
   0xffffffff810b5ff3 <+3>:     mov    $0xffffffff81b55629,%rsi
   0xffffffff810b5ffa <+10>:    mov    $0xffffffff81b0cde2,%rdx
   0xffffffff810b6001 <+17>:    call   0xffffffff811b8fd0 <sysfs_emit>
   0xffffffff810b6006 <+22>:    cltq
   0xffffffff810b6008 <+24>:    ret

After:
   0xffffffff810b5ff0 <+0>:     mov    $0xffffffff81b0cde2,%rsi
   0xffffffff810b5ff7 <+7>:     mov    %rdx,%rdi
   0xffffffff810b5ffa <+10>:    call   0xffffffff811b8fd0 <sysfs_emit>
   0xffffffff810b5fff <+15>:    cltq
   0xffffffff810b6001 <+17>:    ret

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 kernel/module/decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Resend: Maintainer addresses added.

Feel free to drop the to-be-expected commit message body if desired.

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index 4d0bcb3d9e449..c033572d83f0e 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -256,7 +256,7 @@ void module_decompress_cleanup(struct load_info *info)
 static ssize_t compression_show(struct kobject *kobj,
 				struct kobj_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%s\n", __stringify(MODULE_COMPRESSION));
+	return sysfs_emit(buf, __stringify(MODULE_COMPRESSION) "\n");
 }
 
 static struct kobj_attribute module_compression_attr = __ATTR_RO(compression);
-- 
2.35.3

