Return-Path: <SRS0=u9gr=YL=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9247DCA9EA0
	for <linux-modules@archiver.kernel.org>; Fri, 18 Oct 2019 09:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608FA222CD
	for <linux-modules@archiver.kernel.org>; Fri, 18 Oct 2019 09:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hp4pTQtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409766AbfJRJcF (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:32:05 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:40428 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409764AbfJRJcF (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 18 Oct 2019 05:32:05 -0400
Received: by mail-vk1-f201.google.com with SMTP id 70so2137256vkc.7
        for <linux-modules@vger.kernel.org>; Fri, 18 Oct 2019 02:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EbDe35gaiTVD4DdjxfTK6/lBi6D37axpnOTT3faN+u8=;
        b=Hp4pTQtB9H4RzTPhCrvqp4ZAYKpXP3AD+MX8LyGiDmbLYtie3H71Obdi2ZdPk48O/9
         IzeOd8HzVA4+00CRvw1BKb+mEycLjYcfYT332AX/eM0g0+XWru9uSvTAg9qSk941PoBM
         jXlrd9JWLr4741yiIyNqAPJleZLYvOJ0VkiNTOWL6Lrkm70aCX5m2NeQhVWWY2YTiBLB
         QDfv9miNQSAuoU2jJSHcnv/10QlUf0PZCLoNrwTIfUQJOb0wpebDe4utZhurY7lcrgXI
         Qlt+/Ef2izmFl5KH2zJqpcTxDf07SNQgsLeqpZ7AZ1QMb7ZnD04agTHs/5oJxFY1Z3D8
         u1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EbDe35gaiTVD4DdjxfTK6/lBi6D37axpnOTT3faN+u8=;
        b=L0WWHzmYyUR7mwMel9oXuq+uSRuMj4EEawQOvLDsEGuqgPhr3XI9vXQYwVkVoLooDl
         IvUF/hmnfQIj1ORVTgOEvTtbWZ1Imc5D0Zc8/pBU4zbcR/WL1yhEL2bzBnFgba3Niiiz
         5VoZXz52d7Pb75BpPYSseGdm8Jd+etwPmpllhESa74oCv6xAghnxElgw2cBssNgelnyJ
         pUU0Vz12DBE0RBGAsXaRVrV4kW1Ny7kNJb2UxJJjNqiT72vfK5xT4nOvXHi2ogxLKQU4
         7RXkKDYYSW5ps9cv6dE/RivKPYMNiNg91ME3YC2lFntLptz0Vtf6WiuzMkJljkJDxUyi
         Xkfg==
X-Gm-Message-State: APjAAAV9c9wwgVupsS7R8zxiCCv8VSyN84l7xQQL/jCLg1rRaiOp6l7V
        eOsFT/IumgZvv0P5topna1xJ7Ev++oChOg==
X-Google-Smtp-Source: APXvYqwm3JAaNGrRLhYAGqlufSc7y18VjyaCGOOtM/NFeuOAcMJCuEDGObXhxBPuIsiRjCfS+atlYIa8HihUPg==
X-Received: by 2002:a05:6122:2bb:: with SMTP id 27mr4754455vkq.66.1571391122450;
 Fri, 18 Oct 2019 02:32:02 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:31:41 +0100
In-Reply-To: <20191018093143.15997-1-maennich@google.com>
Message-Id: <20191018093143.15997-3-maennich@google.com>
Mime-Version: 1.0
References: <20191010151443.7399-1-maennich@google.com> <20191018093143.15997-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 2/4] modpost: make updating the symbol namespace explicit
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Martijn Coenen <maco@android.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Shaun Ruffell <sruffell@sruffell.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Setting the symbol namespace of a symbol within sym_add_exported feels
displaced and lead to issues in the current implementation of symbol
namespaces. This patch makes updating the namespace an explicit call to
decouple it from adding a symbol to the export list.

Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 scripts/mod/modpost.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index dbfa3997136b..95b1eac656aa 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -385,8 +385,8 @@ static void sym_update_namespace(const char *symname, const char *namespace)
  * Add an exported symbol - it may have already been added without a
  * CRC, in this case just update the CRC
  **/
-static struct symbol *sym_add_exported(const char *name, const char *namespace,
-				       struct module *mod, enum export export)
+static struct symbol *sym_add_exported(const char *name, struct module *mod,
+				       enum export export)
 {
 	struct symbol *s = find_symbol(name);
 
@@ -402,7 +402,6 @@ static struct symbol *sym_add_exported(const char *name, const char *namespace,
 			s->module = mod;
 		}
 	}
-	sym_update_namespace(name, namespace);
 	s->preloaded = 0;
 	s->vmlinux   = is_vmlinux(mod->name);
 	s->kernel    = 0;
@@ -764,7 +763,8 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 		if (strstarts(symname, "__ksymtab_")) {
 			name = symname + strlen("__ksymtab_");
 			namespace = sym_extract_namespace(&name);
-			sym_add_exported(name, namespace, mod, export);
+			sym_add_exported(name, mod, export);
+			sym_update_namespace(name, namespace);
 			free(namespace);
 		}
 		if (strcmp(symname, "init_module") == 0)
@@ -2472,12 +2472,12 @@ static void read_dump(const char *fname, unsigned int kernel)
 			mod = new_module(modname);
 			mod->skip = 1;
 		}
-		s = sym_add_exported(symname, namespace, mod,
-				     export_no(export));
+		s = sym_add_exported(symname, mod, export_no(export));
 		s->kernel    = kernel;
 		s->preloaded = 1;
 		s->is_static = 0;
 		sym_update_crc(symname, mod, crc, export_no(export));
+		sym_update_namespace(symname, namespace);
 	}
 	release_file(file, size);
 	return;
-- 
2.23.0.866.gb869b98d4c-goog

