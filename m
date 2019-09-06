Return-Path: <SRS0=554M=XB=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F314C00307
	for <linux-modules@archiver.kernel.org>; Fri,  6 Sep 2019 10:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A84020854
	for <linux-modules@archiver.kernel.org>; Fri,  6 Sep 2019 10:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eumQm+2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393040AbfIFKc6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:32:58 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:54299 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393033AbfIFKc5 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 6 Sep 2019 06:32:57 -0400
Received: by mail-vk1-f201.google.com with SMTP id t200so1358232vkd.21
        for <linux-modules@vger.kernel.org>; Fri, 06 Sep 2019 03:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e5Xa0/L265hDWGkY0PbNgVQnJTuuZu+3daZLqyOdxeE=;
        b=eumQm+2ShmE6TgmjDoQd70bGY+oEgSHXOgSVuudFicpxW/RDxNJk8L5C5n0pLoBTqq
         MOS+b7mgoDg81jVC8kPWJcSj7KDWoHO87q7brpNe2y6jxBcsqAygJRs2JrZEBlGYkxcw
         Sqczlgln5v+sMvmW/nVr88B9Ugj3AVRwHWTbxesfVsjCi7V1hszeX5Pqhp7gJc0P6Krh
         Alz4XhaTVA4pnQN4RSap6Pd6zRAxGXB+C3aieLKS/o7NzbI/7stKMaAsSA68LqS6Zl21
         SQPjciuVuvZ/LEU75ueCN+tVExCC83LrHw4Fn4ttV+QRm0gZ2GtMGNmjMIGX4f3ruzQH
         SX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e5Xa0/L265hDWGkY0PbNgVQnJTuuZu+3daZLqyOdxeE=;
        b=rpcDTiqNmRQIAWrh3S3U1tLcqMf+YYWzcfQxYkX+OdJqf+TCioN726XVfWD7um75zb
         v8NnFrIfCq79P1XaGxAyD0n3EFpj/L135A3FzEDgXCgnMRxM3TetsTbEl23BqiXJacBf
         m0HoX1trerOHnnNddS1JbHCpBdi5L7IDv0JGjbJrUtstL+MZo9Hc/uH4hHmxaUvkbU31
         D9EjMi/JMRRSIponOV6KKd5NVgzFDJa9W+JdFNX6ju2sNhv7HwnfOdIWUQnvu3wb/cX8
         2CBOIQMlIjPERxX137wnUfWvNkcC5CRor+skefvvrAo7O+fLmZpiTmje4PezFsNukpUL
         1SAA==
X-Gm-Message-State: APjAAAWXXh4FJwImn8/DztpZWWI2cOwNug4pFgmkgx9qTNkgNCefnKkb
        TWGT/liRdWm+l/Zh2jcz7ffHMF9xOlgo/Q==
X-Google-Smtp-Source: APXvYqxjXsNlXF+L5ZbGi+Wu1IG6HFQZJoO2Y3m1xP1bdEMBnoX14uYKZBkKRRUjoh0pfSfp4RUChRg6DxlP9w==
X-Received: by 2002:ab0:a83:: with SMTP id d3mr3929083uak.7.1567765976576;
 Fri, 06 Sep 2019 03:32:56 -0700 (PDT)
Date:   Fri,  6 Sep 2019 11:32:29 +0100
In-Reply-To: <20190906103235.197072-1-maennich@google.com>
Message-Id: <20190906103235.197072-6-maennich@google.com>
Mime-Version: 1.0
References: <20180716122125.175792-1-maco@android.com> <20190906103235.197072-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v5 05/11] module: add config option MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        joel@joelfernandes.org, lucas.de.marchi@gmail.com,
        maco@android.com, sspatil@google.com, will@kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
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
index 6bb9b938f9c7..f76efcf2043e 100644
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
2.23.0.187.g17f5b7556c-goog

