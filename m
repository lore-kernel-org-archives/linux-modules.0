Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E890C4332F
	for <linux-modules@archiver.kernel.org>; Mon, 19 Dec 2022 20:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbiLSUql (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Dec 2022 15:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiLSUq2 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Dec 2022 15:46:28 -0500
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C99120AD
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:46:27 -0800 (PST)
Received: by mail-io1-xd49.google.com with SMTP id s22-20020a6bdc16000000b006e2d7c78010so4619719ioc.21
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8H+688P7vbFiGJ1BQ5c1Gn7u2rmje2kOlAqfxbXizp0=;
        b=hlLpYyCAQfl+MIvWNIXiPjtfE2Ac9W/jMEeedSCc9xOWKwW8B4pnGdF4IrFSo4ZBbv
         E0gMdAmwR7I2MkjyCMWTmbVPWclTfr6tnZ8k8i2JtR5E6sFpnzv4ALxFqm/Yg//ALMBj
         VA2NhNpbG+MNilIgP8azk/Y+U+Eg39zrLR35qwyKASquB12Lzlmt1kYibif8x3X8XD09
         Cx0sWfwFTnuv15KXRd6ZlkspXo67DUuXIIrosUuK6Qq0MvNccg12PFiaAQ8yk7eYipN3
         NHcCXdo5BCJM7j/CPt0n37dnA8/jrNrV+D0ULQjUKpNQGwqpb+kmo0RyJWJvqhA3Qrmb
         v8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8H+688P7vbFiGJ1BQ5c1Gn7u2rmje2kOlAqfxbXizp0=;
        b=lElrlSSecASAK3/RQiB8ow2ht5Pk1lIZMtbe/wdfSUQ1IfTn0xdz7LR2Q9gIwNKMfU
         Yy7EL388TzY/ta426+8bSNA/dMl6l2bm1zfcX5XLcRt1Fxt+Vruni7uA0xRlvSI4cnxf
         CSwjED8BlZVuZ8uv6rZlGdb6FLWuqSaoQbxHFzQ/4GzgnNiT73ew8Zmk6UPnWMugNAwg
         efS1c1GUKrDFSBv3sARF8rBwT2L75fwpLuxwEbqchg5VgA9EGgXesO1bP/V6J93ecezb
         r4xE4fHokSWJIAluejjnhbVJnEeS/KkOSsSzXllKVQPqVBehZ62o+Mr4JwcgqtDPza9O
         xJBw==
X-Gm-Message-State: ANoB5plllYAL9fxvmFOonB5SHzbqoQWkEJTreKjlR9CXUI10k8U+U6aC
        wRNk3eT2BIscXMtJOiAO47v5HUPFafidZL+u7XZhDUqXOVMk64Xxmp2GnQIE8tsQKhk7J8dNUf4
        3o4cPKQ+gQac04s/t/vNMURwVvvT1yNAsG2w7uJoofR0MBxCEOGgvUGq4eCNeA5Yq8oIIv2s4RE
        OrQHw=
X-Google-Smtp-Source: AA0mqf6T5dV8Yz0FXxbcdkxhpq283/ELJ0rlIwQCuUAeNfuNYlBGlC1OqEC85ctKhtBm+Yx8EW1rs5EKhZc0my8=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a6b:db1a:0:b0:6e2:f383:f68d with SMTP id
 t26-20020a6bdb1a000000b006e2f383f68dmr2494390ioc.75.1671482787431; Mon, 19
 Dec 2022 12:46:27 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:46:13 -0600
In-Reply-To: <20221219204619.2205248-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com> <20221219204619.2205248-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219204619.2205248-6-allenwebb@google.com>
Subject: [PATCH v9 05/10] module.h: MODULE_DEVICE_TABLE for built-in modules
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Implement MODULE_DEVICE_TABLE for build-in modules to make it possible
to generate a builtin.alias file to complement modules.alias.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 include/linux/module.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index ec61fb53979a..3d1b04ca6350 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -243,7 +243,20 @@ extern void cleanup_module(void);
 extern typeof(name) __mod_##type##__##name##_device_table		\
   __attribute__ ((unused, alias(__stringify(name))))
 #else  /* !MODULE */
-#define MODULE_DEVICE_TABLE(type, name)
+/*
+ * The names may not be unique for built-in modules, so include the module name
+ * to guarantee uniqueness.
+ *
+ * Note that extern is needed because modpost reads these symbols to generate
+ * modalias entries for each match id in each device table. They are not used
+ * at runtime.
+ */
+#define MODULE_DEVICE_TABLE(type, name)					\
+extern void *CONCATENATE(						\
+	CONCATENATE(__mod_##type##__##name##__,				\
+		__KBUILD_MODNAME),					\
+	_device_table)							\
+	__attribute__ ((unused, alias(__stringify(name))))
 #endif
 
 /* Version of form [<epoch>:]<version>[-<extra-version>].
-- 
2.37.3

