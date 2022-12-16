Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70402C4167B
	for <linux-modules@archiver.kernel.org>; Fri, 16 Dec 2022 22:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiLPWRj (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 16 Dec 2022 17:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiLPWRd (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 16 Dec 2022 17:17:33 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7112F28704
        for <linux-modules@vger.kernel.org>; Fri, 16 Dec 2022 14:17:25 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id n15-20020a056e021baf00b0030387c2e1d3so2475091ili.5
        for <linux-modules@vger.kernel.org>; Fri, 16 Dec 2022 14:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLvu9YuJyEq4PpXLboWGHlPW5BtXq8Iaz4s/vCpOC+c=;
        b=e3ljpji6ioK1JmswqGeMT59i8kwd6MfvqxyKihoCalO46QZMcp+qNJ22Sa/dWGHS61
         hQt7Dcyt5iYvhfhIxS1m6bBXl92EiA703yaQJ6fsCkkgwyVN8osyFtrUyR75cY1ZUBA9
         krWROrvfwpL/5grEcfPSXdqmcM6dLMUIEz9IZngi0SPq+C6F/bm6m4UDENUlS2E+UW89
         HiSgi2UX07+CfWBK1m25AL8+Q+DKbt6diCGA6Yp0haO7lrWhf5tptnK3ipFVWLh448Gr
         ED8NdLMYqYqRdSeDeVmHP83G0e6eHTb+aniw1W2rC2ClRLHS3O47uYwiwaLCj8BxeZq1
         s4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLvu9YuJyEq4PpXLboWGHlPW5BtXq8Iaz4s/vCpOC+c=;
        b=FHgCgU+t1qzGb9zn+Rhr5pwsjDDXloOJewoBeBz99t3uEYhYt69JqYoWE7moGnmn16
         El0lruPz9C9jwbgfUzHjfOA/YduK8CWXsbrfGu9lHR+o0zGpmGh6RIhg2kAdC72ASdrs
         XPSPymSq2s0/Q2HJQD9LkWqLNY5NYajPol7gO2ziYHFSVhAjNXYS783r4GtsRK4FuLqs
         tFm6cCwGRTrr1Ct6JCI02b8JW1/xE+WQ90/CgROqAKT1FBvYYT31f41swt5YjDtZs1Wh
         Toy6+Y4ZOoVdm/hUJZOJiCbrStN6YKGbah2NY79mZPo64BgkxgtPQR8aLB/qHAkxsaUw
         Y64w==
X-Gm-Message-State: ANoB5pkPblxejRZlV6pCJJK+lH4EfPxV9zuv2+Jyx0/MrCEwXHKGx5EK
        9szOE6glyrYvb0m8V2OR1+xcz5QlBhgjk4IdfcZveo0NvW5q+/Jjdf+ZB/tqHXU4oUi91STZj1S
        xctK9FD+vw3AltN5L4KOKxUeubKnragTF07qCKXRgRJyFpyt741n+5yip9DimtYTwiJUzZAjOWA
        3umIw=
X-Google-Smtp-Source: AA0mqf4gCzt7wLDqWtd7vb4p1P/T/LZD/uBz6gdqr23QFQNqjiefKT1o/c05gLYraaBcQacntRWFHfpND37EPes=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a5e:8c10:0:b0:6e3:102d:4826 with SMTP id
 n16-20020a5e8c10000000b006e3102d4826mr1519940ioj.123.1671229044644; Fri, 16
 Dec 2022 14:17:24 -0800 (PST)
Date:   Fri, 16 Dec 2022 16:17:02 -0600
In-Reply-To: <20221216221703.294683-1-allenwebb@google.com>
Mime-Version: 1.0
References: <Y5IA2NYE5IaAzNby@kroah.com> <20221216221703.294683-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221216221703.294683-5-allenwebb@google.com>
Subject: [PATCH v7 4/5] file2alias.c: Implement builtin.alias generation
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

This populates the mod->modalias_buf with aliases for built-in modules
when modpost is run against vmlinuz.o.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 scripts/mod/file2alias.c | 55 +++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 458e41ae0f5f1..8ed08154b3d81 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -232,6 +232,8 @@ static void do_usb_entry(void *symval,
 	add_wildcard(alias);
 	buf_printf(&mod->dev_table_buf,
 		   "MODULE_ALIAS(\"%s\");\n", alias);
+	if (mod->builtin_name)
+		buf_printf(&mod->modalias_buf, "alias %s %s\n", alias, mod->builtin_name);
 }
 
 /* Handles increment/decrement of BCD formatted integers */
@@ -376,9 +378,13 @@ static void do_of_entry_multi(void *symval, struct module *mod)
 			*tmp = '_';
 
 	buf_printf(&mod->dev_table_buf, "MODULE_ALIAS(\"%s\");\n", alias);
+	if (mod->builtin_name)
+		buf_printf(&mod->modalias_buf, "alias %s %s\n", alias, mod->builtin_name);
 	strcat(alias, "C");
 	add_wildcard(alias);
 	buf_printf(&mod->dev_table_buf, "MODULE_ALIAS(\"%s\");\n", alias);
+	if (mod->builtin_name)
+		buf_printf(&mod->modalias_buf, "alias %s %s\n", alias, mod->builtin_name);
 }
 
 static void do_of_table(void *symval, unsigned long size,
@@ -610,12 +616,18 @@ static void do_pnp_device_entry(void *symval, unsigned long size,
 
 		buf_printf(&mod->dev_table_buf,
 			   "MODULE_ALIAS(\"pnp:d%s*\");\n", *id);
+		if (mod->builtin_name)
+			buf_printf(&mod->modalias_buf, "alias pnp:d%s* %s\n",
+				   *id, mod->builtin_name);
 
 		/* fix broken pnp bus lowercasing */
 		for (j = 0; j < sizeof(acpi_id); j++)
 			acpi_id[j] = toupper((*id)[j]);
 		buf_printf(&mod->dev_table_buf,
 			   "MODULE_ALIAS(\"acpi*:%s:*\");\n", acpi_id);
+		if (mod->builtin_name)
+			buf_printf(&mod->modalias_buf, "alias acpi*:%s:* %s\n",
+				   acpi_id, mod->builtin_name);
 	}
 }
 
@@ -662,19 +674,25 @@ static void do_pnp_card_entries(void *symval, unsigned long size,
 			}
 
 			/* add an individual alias for every device entry */
-			if (!dup) {
-				char acpi_id[PNP_ID_LEN];
-				int k;
-
-				buf_printf(&mod->dev_table_buf,
-					   "MODULE_ALIAS(\"pnp:d%s*\");\n", id);
-
-				/* fix broken pnp bus lowercasing */
-				for (k = 0; k < sizeof(acpi_id); k++)
-					acpi_id[k] = toupper(id[k]);
-				buf_printf(&mod->dev_table_buf,
-					   "MODULE_ALIAS(\"acpi*:%s:*\");\n", acpi_id);
-			}
+			if (dup)
+				continue;
+			char acpi_id[PNP_ID_LEN];
+			int k;
+
+			buf_printf(&mod->dev_table_buf,
+				   "MODULE_ALIAS(\"pnp:d%s*\");\n", id);
+			if (mod->builtin_name)
+				buf_printf(&mod->modalias_buf, "alias pnp:d%s* %s\n",
+					   id, mod->builtin_name);
+
+			/* fix broken pnp bus lowercasing */
+			for (k = 0; k < sizeof(acpi_id); k++)
+				acpi_id[k] = toupper(id[k]);
+			buf_printf(&mod->dev_table_buf,
+				   "MODULE_ALIAS(\"acpi*:%s:*\");\n", acpi_id);
+			if (mod->builtin_name)
+				buf_printf(&mod->modalias_buf, "alias acpi*:%s:* %s\n",
+					   acpi_id, mod->builtin_name);
 		}
 	}
 }
@@ -1476,10 +1494,13 @@ static void do_table(void *symval, unsigned long size,
 	size -= id_size;
 
 	for (i = 0; i < size; i += id_size) {
-		if (do_entry(mod->name, symval+i, alias)) {
-			buf_printf(&mod->dev_table_buf,
-				   "MODULE_ALIAS(\"%s\");\n", alias);
-		}
+		if (!do_entry(mod->name, symval + i, alias))
+			continue;
+		buf_printf(&mod->dev_table_buf, "MODULE_ALIAS(\"%s\");\n", alias);
+		if (!mod->builtin_name)
+			continue;
+		buf_printf(&mod->modalias_buf, "alias %s %s\n", alias,
+			   mod->builtin_name);
 	}
 }
 
-- 
2.37.3

