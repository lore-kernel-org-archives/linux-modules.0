Return-Path: <SRS0=UVK8=X5=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51AAC4360C
	for <linux-modules@archiver.kernel.org>; Fri,  4 Oct 2019 09:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971AE215EA
	for <linux-modules@archiver.kernel.org>; Fri,  4 Oct 2019 09:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ptLBrV44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388323AbfJDJmA (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 4 Oct 2019 05:42:00 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:53619 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388266AbfJDJmA (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 4 Oct 2019 05:42:00 -0400
Received: by mail-ua1-f74.google.com with SMTP id m21so957014uao.20
        for <linux-modules@vger.kernel.org>; Fri, 04 Oct 2019 02:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kKKWAAdpQIU9viozfq4zTaTDBtkcO/Oat0zkC+EsjgQ=;
        b=ptLBrV44rVKIePGZUUpqsgJ2zgbaIoSlf8igp/ocX9wiBi4Enor9AmI2aOP48acMiu
         MThbBJGP4bwqQKpGPhDRdaujZbTLhy6pUmSvltbLZTQPhXM083AxnrqmhpmGAzCkyuyR
         2TyTTHeEVluQ51weivsHjBRhvF4mKXZUFQYzrz+xsYFr8/WKS5FFRp0ru6prtWJ4d5Dv
         XklsVaYdyxI7Ev7A6aX1wi+AEvSpfJiUTQXEZj9GUO+d9rtrxBML5o45bwF2F1/sZRSl
         S+tzcYllsosJPoZwQ7j46qcwdizSVyLJrQtmEuoprF8wVTyh0mGtvJF7FIshT85Iv0KV
         Rvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kKKWAAdpQIU9viozfq4zTaTDBtkcO/Oat0zkC+EsjgQ=;
        b=oXawpB60Miwww2OHx4THe/nAsJo/DapfAlRkZQTgQIGEnt2YJRz+lcFHPguoUrrXmE
         nxZbrq0eRZAhR0e76KPoExQAI9qOpxcqnkm5bNYeFN6Jx8DQs0g3+jFKdGMU2UsmSi+/
         lNg9+uhjGtFiYordZXCDRF09frdYn59BvBEgmxeQtCq8rcgrfFG4l/Ii8HttGNkQ3lZW
         sYxgMDGW89+8V9omHakZLU9S8+ojbr2N4fnKY8Btd4bL6/8i8lSlj9ZZ2gjdcT04Qc5T
         6aIyLxU9axqsKWEASFm40kZBtbfxgDYy0eT8dJXZgTyQlDFGtmj0GbLQpEffKxPiMjM3
         hfxw==
X-Gm-Message-State: APjAAAUM0Uzl8BRvP7wkZB6Un5adMMFdzIrTwAYizX4xRSuL0PQFElHI
        K4GbXV27J9SascJ5w519fd9lErUD8hO1hG2npWaSAmC6REFzuLq3woOvzX0eQ5DXs7JawyaedvR
        l1d/zgqKFFAP8R2uMwyj6EYwx9DSoZqy7bF5ta7Jxop+Ltr+UFyw4iNq57YQzv/jAPdmWgRYBp/
        Ui
X-Google-Smtp-Source: APXvYqy54MdF35moRKNvVAv4ATaMHMla5tNGp1sm0zln2lS5kAiYtX9wOqc3hE5R7NBcRmL/UVw38boe/vLboQ==
X-Received: by 2002:a1f:9992:: with SMTP id b140mr2504955vke.94.1570182118764;
 Fri, 04 Oct 2019 02:41:58 -0700 (PDT)
Date:   Fri,  4 Oct 2019 10:41:36 +0100
Message-Id: <20191004094136.166621-1-maennich@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH] depmod: add support for symbol namespaces
From:   Matthias Maennich <maennich@google.com>
To:     linux-modules@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Linux v5.4 introduces symbol namespaces [1], [2].
They appear in the ksymtab as entries with the scheme

   __ksymtab_NAMESPACE.symbol_name

In order to support these at depmod time, strip out namespaces when
loading the System.map.

[1] https://lore.kernel.org/lkml/20190906103235.197072-1-maennich@google.com/
[2] https://lore.kernel.org/lkml/20191003075826.7478-1-yamada.masahiro@socionext.com/

Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Martijn Coenen <maco@android.com>
Cc: linux-modules@vger.kernel.org
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 tools/depmod.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 391afe9fe0a0..723f4c7be88c 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2576,7 +2576,7 @@ static int depmod_load_system_map(struct depmod *depmod, const char *filename)
 
 	/* eg. c0294200 R __ksymtab_devfs_alloc_devnum */
 	while (fgets(line, sizeof(line), fp) != NULL) {
-		char *p, *end;
+		char *p, *end, *delim;
 
 		linenum++;
 
@@ -2601,7 +2601,13 @@ static int depmod_load_system_map(struct depmod *depmod, const char *filename)
 		if (end != NULL)
 			*end = '\0';
 
-		depmod_symbol_add(depmod, p + ksymstr_len, true, 0, NULL);
+		/* Support for namespaced symbols: __ksymtab_NAMESPACE.symbol */
+		delim = strrchr(p + ksymstr_len, '.');
+		if (delim != NULL)
+			depmod_symbol_add(depmod, delim + 1, true, 0, NULL);
+		else
+			depmod_symbol_add(depmod, p + ksymstr_len, true, 0, NULL);
+
 		continue;
 
 	invalid_syntax:
-- 
2.23.0.581.g78d2f28ef7-goog

