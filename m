Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97ABC4332F
	for <linux-modules@archiver.kernel.org>; Fri, 16 Dec 2022 22:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiLPWRZ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 16 Dec 2022 17:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiLPWRX (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 16 Dec 2022 17:17:23 -0500
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7EE2A703
        for <linux-modules@vger.kernel.org>; Fri, 16 Dec 2022 14:17:20 -0800 (PST)
Received: by mail-io1-xd4a.google.com with SMTP id j5-20020a5d9d05000000b006e2f0c28177so2008366ioj.17
        for <linux-modules@vger.kernel.org>; Fri, 16 Dec 2022 14:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QIkoHfPVoGJGQCXWyZmF+mudK9y7JC4uGfB+VF9vmAA=;
        b=DPM862br1ksx4WgfZPPdueiIQnI6WvqPmGTG1MgLblwtuOlS7D2+IHQhAHJWXU9iNG
         j4RxkkFEM0HoFL3kqNsdC+IJMWBTwI8W6+Ta5PvZplSXceS8nTDmbx2x+33J5oD92OFT
         g77b5zdEyCeTgxNQQFcZA/XalLB+/1uF5YTqvBjiIxsFzKG/Km8FlFj84+FnuoT0LMow
         HT2aw6HDm83sOt0XTM+xnEBPzPFUkRx+tiHqOWVrRF/4zSEfTDSIW0wZe/YA3+3tJQA8
         F7V6Z8l7ZANhHSadRJglbkKVcT0i88Xi5gRe00KnPx6R6+C1xOoBUsZ+idFieWINkCzf
         aXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIkoHfPVoGJGQCXWyZmF+mudK9y7JC4uGfB+VF9vmAA=;
        b=ZOvJp9U1ph5XR5QSrzyE0PIg/icOFcfrMgC9OLqA9bqbNxqBwAqJvmpVxtjR/ls8WN
         Je8DpWv+6BJAhVFJ6QRcpaExVsv6qIR2+m/7URh356hYgtRB43YXLq2cmRiakzXIM9nF
         ZvLZomuqV0GX4Fe3belNY1AJMiKGK7cQ9TnH7401lWDCZtwpSYiH1cR2dOYY5/TTVueb
         34Z0GJAzf4Zw0jliAQVWFbrDbDdfvO8esDh7QFdxtGjmBSjalEl3M/926kZhV6o2pXjp
         fH5y8JHdXR/OEIcND4sEknbvBaYNhtAoQ1pcDpS68F8tpAMKy0b5wr9wpBGAMAmQ0cQM
         7unw==
X-Gm-Message-State: ANoB5pnZwD8k8nHS9moNRDw26Y5fMNOQIYsUEo9NdIvGpSOhBXAuWGHO
        BlItXTcRCZfxFoc6OjGYV8mZa37go/bWiHktYEUG57kVdJ9zTFm/bU4JkvYwd0FmiuH7FI8RSWL
        bcrEuK1jWbuA4TgXUdke7/o1JRWzw4dYP3dQs4VPV7T42rz+ZxpgcL8V+R96eL6mk/ehAfVbndA
        JIzI4=
X-Google-Smtp-Source: AA0mqf6TfmBK0Mx/g4QE2FH2JCuQ34V+4c+rpIqMat7imN4HKSMjxbOfVMuq9+IWftjxtKMRD5QngzlpEPjmoOk=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a5d:9e4a:0:b0:6de:42ff:d96b with SMTP id
 i10-20020a5d9e4a000000b006de42ffd96bmr34882896ioi.58.1671229040270; Fri, 16
 Dec 2022 14:17:20 -0800 (PST)
Date:   Fri, 16 Dec 2022 16:16:59 -0600
In-Reply-To: <20221216221703.294683-1-allenwebb@google.com>
Mime-Version: 1.0
References: <Y5IA2NYE5IaAzNby@kroah.com> <20221216221703.294683-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221216221703.294683-2-allenwebb@google.com>
Subject: [PATCH v7 1/5] module.h: MODULE_DEVICE_TABLE for built-in modules
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
 include/linux/module.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index ec61fb53979a9..49e4019393127 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -243,7 +243,15 @@ extern void cleanup_module(void);
 extern typeof(name) __mod_##type##__##name##_device_table		\
   __attribute__ ((unused, alias(__stringify(name))))
 #else  /* !MODULE */
-#define MODULE_DEVICE_TABLE(type, name)
+/* The names may not be unique for built-in modules, so include the module name
+ * to guarantee uniqueness.
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

