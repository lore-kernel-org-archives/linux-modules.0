Return-Path: <SRS0=rFgV=WR=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4F1C3A59E
	for <linux-modules@archiver.kernel.org>; Wed, 21 Aug 2019 11:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DC92339E
	for <linux-modules@archiver.kernel.org>; Wed, 21 Aug 2019 11:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="abTPfEJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfHULy2 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:54:28 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:44960 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfHULy1 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 21 Aug 2019 07:54:27 -0400
Received: by mail-yb1-f201.google.com with SMTP id e69so1335006ybc.11
        for <linux-modules@vger.kernel.org>; Wed, 21 Aug 2019 04:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PMfgpvV4p29AlBNiXlEti/BQa916MI0li39A4AvOT8o=;
        b=abTPfEJhVwI/gTUYBSiD3/lNZoCFClIsVlF/S1LUw2hkn62URKuAwYcGeZTiMgflCE
         RH0FW4rwVygHz/irYwGK+2B8izibJphUwGkIg3MYKMiB94z2GaNprg8wrKbnbJxDAh7w
         LTTCqXeFZuXpWKiLLsFInxfjxXoQv05Woq/GeUH88OP6wdtiNh03LDNHrPVh/UmzbhTD
         D8DEHJnTdvf2WWeNotbNP3DawUqMAATGqe8bVNhGnamyNxb6t+fbpbmbuQWHhl09D6yh
         OyOPUn6H0uBx7epA7HzZ5sWn4sT8XEHjpqM1tqCiVYjla+4Wbs8sCnh0+SDMTc1QpD71
         uuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PMfgpvV4p29AlBNiXlEti/BQa916MI0li39A4AvOT8o=;
        b=Ci2Xo6oeFcY/7R42/KTID48hlanpbrLx7PINUyF/XAm+REvjp0q6g4jMZVuNqZxEQy
         N1dggSKvg4YVw6gNpE2I612mCSiLh/uvIPw3IBKnJEeLSJOW0WrLl20z1wDYOZgF56Nl
         LbGNiRe6UtjhxOyGfwlWwly+DxUaUQ7gI1Xys2Zj9aXq/HJ9nzedWpqrTGsh+12JletK
         9vv5/5Axg+OmoCXXhlUj2V4ZCW95e3OaLiX5W7OauQ2XEyO2KKaVgleNeDvwLHbCqdfo
         ANzT9EgtcUQgqaUQS5n12ldQYabUO04k0Ieip8ymZsliXf8tF5pli3MYGDjrlmRm8aTc
         7uKw==
X-Gm-Message-State: APjAAAXC7cSC5uR3dFF/3qss5NTRXvBUfp0X7NOerHZ75YE9xl2ceV+Y
        9368LwfE5ADE5LJIvuxUBeznELtMtkL4sg==
X-Google-Smtp-Source: APXvYqxGjPF+kvZobt3ndd57e0J8cIy5FA7wdFldKnvqADf0nQHm5Fy15Hii56pIWC3eVZOoy4fG6NGLJXG+CQ==
X-Received: by 2002:a0d:e14d:: with SMTP id k74mr23507585ywe.364.1566388466112;
 Wed, 21 Aug 2019 04:54:26 -0700 (PDT)
Date:   Wed, 21 Aug 2019 12:49:20 +0100
In-Reply-To: <20190821114955.12788-1-maennich@google.com>
Message-Id: <20190821114955.12788-6-maennich@google.com>
Mime-Version: 1.0
References: <20190813121733.52480-1-maennich@google.com> <20190821114955.12788-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v3 05/11] module: add config option MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, arnd@arndb.de,
        geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        jeyu@kernel.org, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@android.com, maco@google.com, michal.lkml@markovi.net,
        mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com,
        sam@ravnborg.org, sspatil@google.com, stern@rowland.harvard.edu,
        tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net,
        x86@kernel.org, yamada.masahiro@socionext.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

If MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is enabled (default=n), the
requirement for modules to import all namespaces that are used by
the module is relaxed.

Enabling this option effectively allows (invalid) modules to be loaded
while only a warning is emitted.

Disabling this option keeps the enforcement at module loading time and
loading is denied if the module's imports are not satisfactory.

Reviewed-by: Martijn Coenen <maco@android.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 init/Kconfig    | 13 +++++++++++++
 kernel/module.c | 11 +++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index bd7d650d4a99..cc28561288a7 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2119,6 +2119,19 @@ config MODULE_COMPRESS_XZ
 
 endchoice
 
+config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
+	bool "Allow loading of modules with missing namespace imports"
+	help
+	  Symbols exported with EXPORT_SYMBOL_NS*() are considered exported in
+	  a namespace. A module that makes use of a symbol exported with such a
+	  namespace is required to import the namespace via MODULE_IMPORT_NS().
+	  There is no technical reason to enforce correct namespace imports,
+	  but it creates consistency between symbols defining namespaces and
+	  users importing namespaces they make use of. This option relaxes this
+	  requirement and lifts the enforcement when loading a module.
+
+	  If unsure, say N.
+
 config TRIM_UNUSED_KSYMS
 	bool "Trim unused exported kernel symbols"
 	depends on MODULES && !UNUSED_SYMBOLS
diff --git a/kernel/module.c b/kernel/module.c
index 57e8253f2251..7c934aaae2d3 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1408,9 +1408,16 @@ static int verify_namespace_is_imported(const struct load_info *info,
 			imported_namespace = get_next_modinfo(
 				info, "import_ns", imported_namespace);
 		}
-		pr_err("%s: module uses symbol (%s) from namespace %s, but does not import it.\n",
-		       mod->name, kernel_symbol_name(sym), namespace);
+#ifdef CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
+		pr_warn(
+#else
+		pr_err(
+#endif
+			"%s: module uses symbol (%s) from namespace %s, but does not import it.\n",
+			mod->name, kernel_symbol_name(sym), namespace);
+#ifndef CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
 		return -EINVAL;
+#endif
 	}
 	return 0;
 }
-- 
2.23.0.rc1.153.gdeed80330f-goog

