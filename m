Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843D0C6FA8F
	for <linux-modules@archiver.kernel.org>; Tue, 29 Aug 2023 12:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjH2Mii (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Aug 2023 08:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjH2MiP (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Aug 2023 08:38:15 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C7AD7
        for <linux-modules@vger.kernel.org>; Tue, 29 Aug 2023 05:38:12 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 508073F660
        for <linux-modules@vger.kernel.org>; Tue, 29 Aug 2023 12:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693312691;
        bh=FO4rUgwRu/XjN9/W0jh/wMVwOzCkER6BOshs0mf8aHs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=nObP95aAmE6qvtL82Hg3ylTcTYzFfa7FZxIR5+Qyw+P1b/DGpmPBgKNMmQS4R3iru
         xYjvJzcQqPyHMT0fVGpvgu8K8POyd4pINxmendquuvR1FMBCp1uygDpuH1o+53wn03
         V3HuOJ3uCKXwZQpuwjMvh6U8CMSp1ssjucPVMXsmSZ+wOGncZP4R7cMUz3oZECL8tN
         YBttX7zMXHmi6YUUinAQ/NUIyH8PIykLUpnrzL880i4Hk+kF/yVs6FFl+/F2OZBzH0
         NmMsR2ycf0lKMiH9rmIdNbmrES0jnwJzML7SExFJg39rYSYQhArgi5bJ7E5zXFQkwf
         Eb8FvcQ4xZTbA==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99c8bbc902eso339165466b.1
        for <linux-modules@vger.kernel.org>; Tue, 29 Aug 2023 05:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693312691; x=1693917491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FO4rUgwRu/XjN9/W0jh/wMVwOzCkER6BOshs0mf8aHs=;
        b=bTUTnIzFF1bbzYCmmkHRH2KTmhVL8a7YRFuFD2cQNK5JbY+uNc7iH8G6MRJg27eq0q
         9JV7UW2sabhg0AsIZY5kkj5nwfRyjCHdsX6Xx98MmL/PNQxNlmWsN1Mm62UG3dwzEMht
         4XoZmH2I/PLoLJ05VBEPCPHe9SWMdKT09oOfuBCqdvRLtS+pGVG21oVyC/KDxyTj5aKB
         vVMjH0zvFYhqZ4QgChZyC+5+6Pe5izhCPdrbaFa3gjEnKxg2WyfVTpUksE4bIscC0FLA
         6UT1moaTLoBA0FagF2UauoDVlMXZUdbkLItxwKTcFMUHfbuNNaJ+R1hTqXTG/aV6IdZl
         tw/A==
X-Gm-Message-State: AOJu0YxxOEoDKhkgbszhHzbSIfG5w7HN0ye7xq0ofdbuvh8mKexFj2eF
        PNDhCDutg5pI25hV/xSdKrQwbSHZ3LJzrQ1V5okd+0ovdQqow2I0MDfzSiIa+wm+CpmAhvL/iA9
        KwtiBfBcwDGTJcwVUl+kbJF9MENNriOIEjL5KhQXWVltVOvHkti4=
X-Received: by 2002:a17:907:7851:b0:9a1:db2e:9dc0 with SMTP id lb17-20020a170907785100b009a1db2e9dc0mr13700161ejc.44.1693312690826;
        Tue, 29 Aug 2023 05:38:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvDAsLpuqxz5qSMsj5rvUJAAZ1hC78k6letct9iRJRVrDWxKB84Ts4bJW2xlpTnZKaDuFwfg==
X-Received: by 2002:a17:907:7851:b0:9a1:db2e:9dc0 with SMTP id lb17-20020a170907785100b009a1db2e9dc0mr13700153ejc.44.1693312690519;
        Tue, 29 Aug 2023 05:38:10 -0700 (PDT)
Received: from righiandr-XPS-13-7390.homenet.telecomitalia.it (host-95-252-65-153.retail.telecomitalia.it. [95.252.65.153])
        by smtp.gmail.com with ESMTPSA id fx19-20020a1709069e9300b0098e0a937a6asm5870790ejc.69.2023.08.29.05.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 05:38:09 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Subject: [PATCH] libkmod: allow to fallback to user-space decompression
Date:   Tue, 29 Aug 2023 14:38:08 +0200
Message-Id: <20230829123808.325202-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Fallback to user-space decompression when the kernel cannot allocate
enough memory to perform the decompression.

This can happen with large modules, such as xfs on linux 6.5 for
example, an ENOMEM would be returned and the module fails to load.

It seems more reliable to try again with user-space decompression
rather than reporting an error and failing to load the module.

Fixes: 09c9f8c ("libkmod: Use kernel decompression when available")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 libkmod/libkmod-module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 585da41..d2d4815 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -978,7 +978,7 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
 	}
 
 	err = do_finit_module(mod, flags, args);
-	if (err == -ENOSYS)
+	if (err == -ENOSYS || err == -ENOMEM)
 		err = do_init_module(mod, flags, args);
 
 	if (err < 0)
-- 
2.40.1

