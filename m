Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62320C433EF
	for <linux-modules@archiver.kernel.org>; Fri, 22 Jul 2022 02:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiGVCYl (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 21 Jul 2022 22:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiGVCYc (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 21 Jul 2022 22:24:32 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4B297A15
        for <linux-modules@vger.kernel.org>; Thu, 21 Jul 2022 19:24:30 -0700 (PDT)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 611C63F128
        for <linux-modules@vger.kernel.org>; Fri, 22 Jul 2022 02:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658456669;
        bh=3ZWy6oO045NhmDZUgGUtDdbm4GX85RgD6xaLJzXc/eE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=cPquqsw+mci3kEp9X8003BpJ5hYUZU6NV1CbxqbI4PpPHywPxej7vwynWFFdNqqiv
         V1debT4RPDgIi9OuWO4Ltnb/AShM+nZrs6USiOrANbZuBHjVBdO3V0YY/jw9XJp3my
         LrsLMRqS2rxxzgfMs/KpUXwQZCeg6QIYGHvNbJPSkVMsPll6T3NEaXBZinItD0Bm+F
         cv8RUJnnKXovO4gQHxwD6e9uJ4uG+/fiQzSCFvOcpVgrjAlqckFjDtwTyG7IenfQjy
         W6Slo6QBSOaSXYgEXfjQG/snE97OVkrryfYroY0drRDqz1qDv7LZ8u4PnN0ya2B8yI
         Pi6frmNrRPbgw==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-10d91acff93so1774795fac.12
        for <linux-modules@vger.kernel.org>; Thu, 21 Jul 2022 19:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ZWy6oO045NhmDZUgGUtDdbm4GX85RgD6xaLJzXc/eE=;
        b=RAMOVXXkxkWAg+l8ubkx0oOaufd9l5h5UXrrwI8DXle8kSvyg4Wu6lhKDk9Qmxni/P
         zKsOxhtQ4DafjSgvhUCAhQXTyVLwZb8Nv9QqZqDqXiktwmjvEbgV3gxPnpxGmzB4yusI
         /VSVG/4h61F1h5pb9SuIhaHTkqr86IUQGrxcUvV7V8KAwsBfcU4bkvbPhrz/Lc2wwyZR
         afzWx82tSSC4KzSXuekbjUWXodYb3iBgtEeMWEwda+aM6CCdrbEFHiFS8bFcsfrKSqo9
         dAPV3FjaiqO5goUGD996be6KPNEr/4iGDJmqnczAiiAB/pCIuyzFQuKmH/anppdafzuo
         Mw1Q==
X-Gm-Message-State: AJIora+enavjoCmnq5ZZidPmt3jnxbZ6jsTNYZdWuCulsLO+SvDKxtrm
        WmtvVsSZvRCuPF3bs8PJlB/4ew7MiQTM/kt2t3aJrXnK8EayfXAhhdEImbDTFKomSPvpM+4O2dy
        rlYx3BBBLpzRp2ilKkI6eyvN8Sf7E3PwFwj+rbIy2Rjo=
X-Received: by 2002:a05:6870:a54b:b0:10d:bd45:8acf with SMTP id p11-20020a056870a54b00b0010dbd458acfmr97021oal.137.1658456669036;
        Thu, 21 Jul 2022 19:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uXOJFfZ5xySXu/jnZXD4d8EwntbgED2XgYvhxCSIhrCPaTNG1IxGQOP+0DjE3kT8h+fPFKDg==
X-Received: by 2002:a05:6870:a54b:b0:10d:bd45:8acf with SMTP id p11-20020a056870a54b00b0010dbd458acfmr97007oal.137.1658456668819;
        Thu, 21 Jul 2022 19:24:28 -0700 (PDT)
Received: from mfo-t470.. ([2804:14c:4e1:8732:c479:1206:16fb:ce1f])
        by smtp.gmail.com with ESMTPSA id k23-20020a056870959700b000f5f4ad194bsm1814528oao.25.2022.07.21.19.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 19:24:28 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: [RFC PATCH 2/6] modpost: deduplicate section_rel[a]()
Date:   Thu, 21 Jul 2022 23:24:12 -0300
Message-Id: <20220722022416.137548-3-mfo@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220722022416.137548-1-mfo@canonical.com>
References: <20220722022416.137548-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Now both functions are almost identical, and we can again generalize
the relocation types Elf_Rela/Elf_Rel with Elf_Rela, and handle some
differences with conditionals on section header type (SHT_RELA/REL).

The important bit is to make sure the loop increment uses the right
size for pointer arithmethic.

The original reason for split functions to make program logic easier
to follow; commit 5b24c0715fc4 ("kbuild: code refactoring in modpost").

Hopefully these 2 commits may help improving that, without an impact
in understanding the code due to generalization of relocation types.

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 scripts/mod/modpost.c | 61 ++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 4c1038dccae0..d1ed67fa290b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1794,63 +1794,49 @@ static int get_relx_sym(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *rela,
 	return 0;
 }
 
-static void section_rela(const char *modname, struct elf_info *elf,
+/* The caller must ensure sechdr->sh_type == SHT_RELA or SHT_REL. */
+static void section_relx(const char *modname, struct elf_info *elf,
 			 Elf_Shdr *sechdr)
 {
 	Elf_Sym  *sym;
-	Elf_Rela *rela;
+	Elf_Rela *relx; /* access .r_addend in SHT_RELA _only_! */
 	Elf_Rela r;
+	size_t relx_size;
 	const char *fromsec;
 
 	Elf_Rela *start = (void *)elf->hdr + sechdr->sh_offset;
 	Elf_Rela *stop  = (void *)start + sechdr->sh_size;
 
 	fromsec = sech_name(elf, sechdr);
-	fromsec += strlen(".rela");
+	if (sechdr->sh_type == SHT_RELA) {
+		relx_size = sizeof(Elf_Rela);
+		fromsec += strlen(".rela");
+	} else if (sechdr->sh_type == SHT_REL) {
+		relx_size = sizeof(Elf_Rel);
+		fromsec += strlen(".rel");
+	} else {
+		error("%s: [%s.ko] not relocation section\n", fromsec, modname);
+		return;
+	}
+
 	/* if from section (name) is know good then skip it */
 	if (match(fromsec, section_white_list))
 		return;
 
-	for (rela = start; rela < stop; rela++) {
-		if (get_relx_sym(elf, sechdr, rela, &r, &sym))
+	for (relx = start; relx < stop; relx = (void *)relx + relx_size) {
+		if (get_relx_sym(elf, sechdr, relx, &r, &sym))
 			continue;
 
 		switch (elf->hdr->e_machine) {
 		case EM_RISCV:
-			if (!strcmp("__ex_table", fromsec) &&
+			if (sechdr->sh_type == SHT_RELA &&
+			    !strcmp("__ex_table", fromsec) &&
 			    ELF_R_TYPE(r.r_info) == R_RISCV_SUB32)
 				continue;
 			break;
 		}
 
-		if (is_second_extable_reloc(start, rela, fromsec))
-			find_extable_entry_size(fromsec, &r);
-		check_section_mismatch(modname, elf, &r, sym, fromsec);
-	}
-}
-
-static void section_rel(const char *modname, struct elf_info *elf,
-			Elf_Shdr *sechdr)
-{
-	Elf_Sym *sym;
-	Elf_Rel *rel;
-	Elf_Rela r;
-	const char *fromsec;
-
-	Elf_Rel *start = (void *)elf->hdr + sechdr->sh_offset;
-	Elf_Rel *stop  = (void *)start + sechdr->sh_size;
-
-	fromsec = sech_name(elf, sechdr);
-	fromsec += strlen(".rel");
-	/* if from section (name) is know good then skip it */
-	if (match(fromsec, section_white_list))
-		return;
-
-	for (rel = start; rel < stop; rel++) {
-		if (get_relx_sym(elf, sechdr, (Elf_Rela *)rel, &r, &sym)
-			continue;
-
-		if (is_second_extable_reloc(start, rel, fromsec))
+		if (is_second_extable_reloc(start, relx, fromsec))
 			find_extable_entry_size(fromsec, &r);
 		check_section_mismatch(modname, elf, &r, sym, fromsec);
 	}
@@ -1877,10 +1863,9 @@ static void check_sec_ref(const char *modname, struct elf_info *elf)
 	for (i = 0; i < elf->num_sections; i++) {
 		check_section(modname, elf, &elf->sechdrs[i]);
 		/* We want to process only relocation sections and not .init */
-		if (sechdrs[i].sh_type == SHT_RELA)
-			section_rela(modname, elf, &elf->sechdrs[i]);
-		else if (sechdrs[i].sh_type == SHT_REL)
-			section_rel(modname, elf, &elf->sechdrs[i]);
+		if (sechdrs[i].sh_type == SHT_RELA ||
+		    sechdrs[i].sh_type == SHT_REL)
+			section_relx(modname, elf, &elf->sechdrs[i]);
 	}
 }
 
-- 
2.25.1

