Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66331C4332F
	for <linux-modules@archiver.kernel.org>; Mon, 19 Dec 2022 19:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiLSTTV (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Dec 2022 14:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiLSTTI (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Dec 2022 14:19:08 -0500
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEBB11C08
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 11:19:07 -0800 (PST)
Received: by mail-io1-xd4a.google.com with SMTP id e15-20020a056602158f00b006e01d8fa493so4502500iow.3
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 11:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cjGe6fxSS7cTt3mra7vAbJD0wH3tbfNYD/FCvl4NRMk=;
        b=FwO+EN0GRH6yMNy3i+aRaQi4k6ltrzQBDq0j2HgKcM4M/i0+GG/Tmh4ilo2ihykEDy
         Z3DOBVb7Hmq/tEN1Fv7roWQ+ePXHhHxxxbUSha5Tue3vGD0YSCIw5CdxZJ10vUa7j4sz
         /DDGenrw2NvJi/Pse/FoKztr5v6NXg/S7iy9zlEKswHs50EeHpMw/wCmWIvNVAAl/sJQ
         nVcs8jSLbqOYsGA7sZaPExqgzl0/OLlwn7nJM5YDweKk2lSBKB2VNh6AdN/9jDCPPRDt
         k8HINHwwMp2JVSAhC7XTE1zZqkTsd+OcFG5w7tdcU20hhKaWWMZrWhIcKMp2nvsSChQ9
         4WzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjGe6fxSS7cTt3mra7vAbJD0wH3tbfNYD/FCvl4NRMk=;
        b=7WHm/Ew2EKDOFZ/V7I8eFl9f1UdUO6r+4NCPUVSbilprmR+eG57FcLfi8i5EUbz/yU
         8C+TRz5AODicScMXShMNS3jSh2jB9aLrrDK24O5fK4bYxCMTEIpaunD6e2XXdRT6jSDp
         taVaNVBqG/bTJSmlUhQJ7o4YtnzNxH8d9dLnmMtyRR3rJ47lcLVyazz82XDfDaQ37/sj
         jPz/BByssTJeQqrWgjEu0rguJKqHt92c/Lo+YQ1EfFElXFW08aanAIL7FjtMPbaL9r97
         7idM12EU4ZSMMeKhICCWg6tRlVy5GntYAQ27onWF4gvDOaudBVjwLsaZMc3sm3HHjNP2
         Hk5A==
X-Gm-Message-State: AFqh2kpDgqWN1dBPrvYwe5eAUDq/6E3GHW+x3ZQLl1FvsNqT3jz6CaBw
        LCSJX/PRfD/vL1ll4xLmZ9Awjt0fxyLvROP0ML+85RI6eCAFuWfevi372WISrpNgyY9UBoh6R+T
        6M4S2WIoAxhsmE9kn6xwqe3K5cOZALV32NjVfgSfSc/72hbqqfufzaRe3U9G0ssmeix3Lo/R5oX
        M3+G0=
X-Google-Smtp-Source: AMrXdXtEWFR5m+TguTy7DMteh2YUscW21cjm7GoJQqd4O805GlSojiqfl7ZGAJOibTR3VFOZRn9mfAPK7+rMVYU=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6e02:2207:b0:30b:c336:8a83 with SMTP
 id j7-20020a056e02220700b0030bc3368a83mr61889ilf.92.1671477547452; Mon, 19
 Dec 2022 11:19:07 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:18:54 -0600
In-Reply-To: <20221219191855.2010466-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221216221703.294683-1-allenwebb@google.com> <20221219191855.2010466-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219191855.2010466-9-allenwebb@google.com>
Subject: [PATCH v8 8/9] file2alias.c: Implement builtin.alias generation
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
index e41ff8de7a876..e840cb51281a4 100644
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
 
@@ -637,6 +649,8 @@ static void do_pnp_card_entries(void *symval, unsigned long size,
 			const char *id = (char *)(*devs)[j].id;
 			int i2, j2;
 			int dup = 0;
+			char acpi_id[PNP_ID_LEN];
+			int k;
 
 			if (!id[0])
 				break;
@@ -662,19 +676,23 @@ static void do_pnp_card_entries(void *symval, unsigned long size,
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

