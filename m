Return-Path: <SRS0=Km5E=3J=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A108C32771
	for <linux-modules@archiver.kernel.org>; Mon, 20 Jan 2020 19:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF31222314
	for <linux-modules@archiver.kernel.org>; Mon, 20 Jan 2020 19:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDHzF7jx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgATTW0 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 20 Jan 2020 14:22:26 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39249 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgATTW0 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 20 Jan 2020 14:22:26 -0500
Received: by mail-qk1-f193.google.com with SMTP id c16so321573qko.6
        for <linux-modules@vger.kernel.org>; Mon, 20 Jan 2020 11:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2hyfBJIsf8iGkmUtOl1MUV3qDn9bpVMVGq6c9KGgjYc=;
        b=cDHzF7jxdIGOlsz0f8xHm9lE7T5nW2sw9joCb0y+/8ibueYiRAJVuwpKPW5RFGbxUr
         igso2dgGIzJaofW5d+eBRV0jrdrNyzhV8ACm+I0U+YlV6FBaSAy38g+E12P4vxq/rfuu
         yww1xgx2GqnaGZy780yn2Kbp3y95mZ0X//PVZ5goNeLHKIV3N+tI2PazpSzK0SCPvmEN
         bT/CLjIuGaI9tk9wnLmGhddJY4mhqCZkbmixlWscdqAF9GiU51tiEhh5D04FAuqxM1Hy
         f97tlh6gO0FAYVmG8ZVeWUv8n2qXoXzeQi3pyRzvExBSHiPpS36xUYkSe5U20pkGXI56
         A2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2hyfBJIsf8iGkmUtOl1MUV3qDn9bpVMVGq6c9KGgjYc=;
        b=rtRJc7Z9ejNswykI2pLxdraDktwdtXNLTNh+r1BlU9aCpgarVR3TFaVjOKVoeVEV7q
         +lqhrENIyi7fUwkYUP7GnKqHM2oMSKsVgB81FsE1+iQkIUyQYz+FFChx4KkbH6dkSSSe
         EQcw/A9la7TJVxNbDytC/6hhaqRwGozcSjG3yD5kmchhEe6J1hfPc6ATvO3nWKFWC5e1
         zvXGkHQd3zB13rqIRm62CiNJae9iPlRWMmvARSxoEcTkJx2L82ieH9eVZR2DDq+p7jdw
         2/bowPdOwAwn6WqD8ygAfTiHVFDGv0qT6XHnlpT7v0hkyB+hVnqeIinLnXntXHHfIbsN
         2fEg==
X-Gm-Message-State: APjAAAV7jcvhBoq7IQeKbPZKe4f2HtPakqfwS3zIxm8hGmrTRm1JaCzW
        nfIb5snZZ09EbV3HgCmvU3Ud9pJJBNEVrQ==
X-Google-Smtp-Source: APXvYqyJbIcSBeDQhN4+NePHdzKVvUgmp8ms5qywT2oBpqHwakRFPK8UTMbJpRZAjl6Sbt4U9FdmBA==
X-Received: by 2002:a05:620a:1666:: with SMTP id d6mr1065935qko.379.1579548145031;
        Mon, 20 Jan 2020 11:22:25 -0800 (PST)
Received: from localhost.localdomain ([179.225.168.228])
        by smtp.gmail.com with ESMTPSA id e3sm17793371qtj.30.2020.01.20.11.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 11:22:23 -0800 (PST)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Jorge Lucangeli Obes <jorgelo@google.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH] libkmod: reset was_space on second pass
Date:   Mon, 20 Jan 2020 16:22:10 -0300
Message-Id: <20200120192210.6370-1-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

The softdep config parser uses a 2-pass approach to use a single
allocation for all the softdep struct. However "was_space" variable
isn't reset between them. This can lead to a buffer overflow.

Reported-by: Jorge Lucangeli Obes <jorgelo@google.com>
Link: https://lore.kernel.org/linux-modules/CAKYuF5QhGCPCazHQjN-=kFc5kHs7Ok8WqmmGLo31CiOEN8TYdA@mail.gmail.com
---
 libkmod/libkmod-config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index aaac0a1..7b62367 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -335,6 +335,7 @@ static int kmod_config_add_softdep(struct kmod_config *config,
 	n_pre = 0;
 	n_post = 0;
 	mode = S_NONE;
+	was_space = false;
 	for (p = s = line; ; s++) {
 		size_t plen;
 
-- 
2.24.1

