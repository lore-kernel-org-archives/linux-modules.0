Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2887C4332F
	for <linux-modules@archiver.kernel.org>; Fri, 16 Dec 2022 22:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLPWRe (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 16 Dec 2022 17:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiLPWRY (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 16 Dec 2022 17:17:24 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D1B27DDB
        for <linux-modules@vger.kernel.org>; Fri, 16 Dec 2022 14:17:23 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id w15-20020a056e021a6f00b00303520bff1dso2466545ilv.20
        for <linux-modules@vger.kernel.org>; Fri, 16 Dec 2022 14:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G0/vtfeve/G9ydeke/gLh4oQEre+L13iDXwcfVwzkg8=;
        b=XuNwKmwPpNlfKES3zcBJOF59W0eZv2AMPYDbfitG7Ycy+a7Q8uZ5QCspwLjWD88r4N
         qNEl4O2mUAUamEUPN2f4xsKafyXL5LRghVfKvYYYkihHNyh/fjFCWr4roR2GazK/JIPT
         SD0xAPysuyXz0C/a5JxcHcz76ur05fNnHe53fXhRx15SQ1eGnqGenRPXKcBwY0enWofR
         0fWkGOzlCjCBHavz7gOEclKO4CHaxd3tBdECRyE7nciqto1C2kIiHJfMhdsEv1Do0QJA
         m9iI/5kMYVVHZ8qMSWC4P15VHtu//B+FQXkpMrwUaM80OPXVP/RSbuK8Wyw+OnrTevgz
         4m6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0/vtfeve/G9ydeke/gLh4oQEre+L13iDXwcfVwzkg8=;
        b=WDzZw18FghHHkW1k5VyyKJe2dXdfJQpERK3pzJShUoUdjDUC2K3VLNpPf7DEqUYTy3
         2Bcz/weeCbkdjwuDQuzpR08uOfbQRToD2QsmLcZS/TLDo+IOd2vFF9OwcDFR1nwrUIHf
         loO/K73+5J7rEcev53TqaAHLPIDA3yo+gOHikgyXcwoZ0zNvoQpa+/YNOENM+3olSG0D
         P7eRdssPUcd8KEFEWvS4ZdHp/wRNdYpSyuB1X8JoIU+FB62BJSG7ZBTpO6e4QWTAelm9
         GkNb8H0fAL2ORxKuU1/4kbPbB7rCS5Ioh7KNd1VWc4Cs6VCVCdEVJCxJpOJupPXytHOe
         0YoA==
X-Gm-Message-State: ANoB5pn3dJ0hP+GwQsH8ZBO8Y1ruTSbt09C2VcazKXvNDmmw0CzgWBgw
        v3Yj5SCGP5PyxvHEoDTsPHz3NzTNKKwKY6dzmzJSJFpm/3UFkg47zaD7WYKZalzdF/egJGeJL4/
        X2n/yvFTVtUzD86I7PmOrAizowdSOcQCcYSlmMbbzZKKRJXlsS6quaJn7xX0w63teC4Ouq2YD8Y
        HbL8o=
X-Google-Smtp-Source: AA0mqf4UC/atAEdUb3Vl1JsfM1S7LbbKzn42gA1tVwXLOEl9Tg/CF2eeuhJLDOljn5iQSGJpHZxlAN8xlh4egrw=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6602:2bf0:b0:6e2:c12d:571e with SMTP
 id d16-20020a0566022bf000b006e2c12d571emr4547416ioy.32.1671229042549; Fri, 16
 Dec 2022 14:17:22 -0800 (PST)
Date:   Fri, 16 Dec 2022 16:17:00 -0600
In-Reply-To: <20221216221703.294683-1-allenwebb@google.com>
Mime-Version: 1.0
References: <Y5IA2NYE5IaAzNby@kroah.com> <20221216221703.294683-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221216221703.294683-3-allenwebb@google.com>
Subject: [PATCH v7 2/5] modpost: Track module name for built-in modules
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

Keep track of the module name when processing match table symbols.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 scripts/mod/file2alias.c | 37 +++++++++++++++++++++++++++++++++----
 scripts/mod/modpost.h    |  1 +
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 80d973144fded..458e41ae0f5f1 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -28,6 +28,7 @@ typedef Elf64_Addr	kernel_ulong_t;
 #include <stdint.h>
 #endif
 
+#include <assert.h>
 #include <ctype.h>
 #include <stdbool.h>
 
@@ -1540,9 +1541,9 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 			Elf_Sym *sym, const char *symname)
 {
 	void *symval;
-	char *zeros = NULL;
-	const char *name, *identifier;
-	unsigned int namelen;
+	char *zeros = NULL, *modname_str = NULL;
+	const char *name, *identifier, *modname;
+	unsigned int namelen, modnamelen;
 
 	/* We're looking for a section relative symbol */
 	if (!sym->st_shndx || get_secindex(info, sym) >= info->num_sections)
@@ -1552,7 +1553,11 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 	if (ELF_ST_TYPE(sym->st_info) != STT_OBJECT)
 		return;
 
-	/* All our symbols are of form __mod_<name>__<identifier>_device_table. */
+	/* All our symbols are either of form
+	 *   __mod_<name>__<identifier>_device_table
+	 * or
+	 *   __mod_<name>__<identifier>__kmod_<builtin-name>_device_table
+	 */
 	if (strncmp(symname, "__mod_", strlen("__mod_")))
 		return;
 	name = symname + strlen("__mod_");
@@ -1564,8 +1569,29 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 	identifier = strstr(name, "__");
 	if (!identifier)
 		return;
+	modnamelen = namelen;
 	namelen = identifier - name;
 
+	/* In the vmlinuz.o case we want to handle __kmod_ so aliases from
+	 * builtin modules are attributed correctly.
+	 */
+	modname = strstr(identifier + 2, "__kmod_");
+	if (modname) {
+		modname += strlen("__kmod_");
+		modnamelen -= (modname - name) + strlen("_device_table");
+		modname_str = malloc(modnamelen + 1);
+		/* We don't want to continue if the allocation fails. */
+		assert(modname_str);
+		memcpy(modname_str, modname, modnamelen);
+		modname_str[modnamelen] = '\0';
+	}
+
+	if (modname_str)
+		modname = modname_str;
+	else
+		modname = mod->name;
+	mod->builtin_name = modname;
+
 	/* Handle all-NULL symbols allocated into .bss */
 	if (info->sechdrs[get_secindex(info, sym)].sh_type & SHT_NOBITS) {
 		zeros = calloc(1, sym->st_size);
@@ -1597,6 +1623,9 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 		}
 	}
 	free(zeros);
+	mod->builtin_name = NULL;
+	if (modname_str)
+		free(modname_str);
 }
 
 /* Now add out buffered information to the generated C source */
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 1178f40a73f3d..34fe5fc0b02cb 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -128,6 +128,7 @@ struct module {
 	struct list_head missing_namespaces;
 	// Actual imported namespaces
 	struct list_head imported_namespaces;
+	const char *builtin_name;
 	char name[];
 };
 
-- 
2.37.3

