Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0C9C4332F
	for <linux-modules@archiver.kernel.org>; Mon, 19 Dec 2022 20:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiLSUrM (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Dec 2022 15:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiLSUql (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Dec 2022 15:46:41 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC42A12D29
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:46:30 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id a10-20020a056e02180a00b0030bc09c6b94so900106ilv.6
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ict2nAybZst9hd7blb/mqnDuFXGRQOU9mJnqBemEDUs=;
        b=s2ZrfNQOjBrSWOSByiZCQfYB433BmyIy/j3ly5GPI7q7DQSKjQaGWpR8OpY5yqR4up
         s/oCDPMg27vjwGrwVakCjp4cMNI3bT10VqVyYGG/KXoVAvy3X5gux1hPs+vi4/BDBB3M
         KwDWb6Jhedtm3NReW57ZGysB4WVkkexx2NoF17pNoEVKe1gWeqybIlgRLnARmU/966fe
         bfborkGMEPeQtjsE7fqcXAEvOEBGXFtMu9wq8FhFmfhYwwf529//Ho3A8hM019D3duWx
         jJCLpW3SvyBXZJdHFHUrepQKdzkQiRs1ZiPGq9+tWAKvGfkZODfY5IapcpB2YfBsy2iC
         GbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ict2nAybZst9hd7blb/mqnDuFXGRQOU9mJnqBemEDUs=;
        b=qtVWCqzTEKsyzlzyN2yx33wbbVsLTFD3BhF6YmW28WfV82LB0fgcEuT5IumyplQ6Hc
         JvXMoKwzEiqh18cMS247kPNp2BC4PrZ1dRL+EPdvpdBlqxNxcr+XsDeBo3qkxRPgmiHX
         rRMdlwXwdwGhTAJKp/OaDlCj8SBh9Xe0sT56n/W82ZjkYmpHUtCPtHoinHQ2BTAeBciA
         giTR67ke6EOJUwpGFMCDKOviWo5WBYaqKwM2acvuDPn3Mh6WbXdqg3bMVIhpanyYqXYY
         rWZ+PvkBqVQQjKhC4bIFfWvUjY2/igxpcV8+LmHNMLGtmyHa4npEekACN2DlMGunDpb7
         d2RA==
X-Gm-Message-State: ANoB5pkZZR7YRDth+IG4tlKCq24qerT8MWDQJDzdhTLXLn8R/MOdp8NH
        IRmxXQSDXlQrIQYGk3OMhIXJlmoXxPRnHxt9DtuuGkGh5vJyBPXKAkfg6FGPcjzBjDXUBL25M4C
        VKHIHccYhtevYEs3Iaxv6TO5fZJBAYIJ8UM0FSnw81EkIMHlo+WhMkj0eRWDieez5ki0FsGsPLv
        sUch4=
X-Google-Smtp-Source: AA0mqf4Vg7sPZKoxjDlHwlE7TekSeJ2HLUzyD0Y5TnfKfKOKbyyhiPH5BhZs8OQobjXMnrVrn44Buga/nbkrqDk=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6e02:c08:b0:303:4e51:e5b2 with SMTP
 id d8-20020a056e020c0800b003034e51e5b2mr11864457ile.285.1671482790594; Mon,
 19 Dec 2022 12:46:30 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:46:16 -0600
In-Reply-To: <20221219204619.2205248-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com> <20221219204619.2205248-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219204619.2205248-9-allenwebb@google.com>
Subject: [PATCH v9 08/10] file2alias.c: Implement builtin.alias generation
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
index e41ff8de7a87..e840cb51281a 100644
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

