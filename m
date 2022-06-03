Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54673C43334
	for <linux-modules@archiver.kernel.org>; Fri,  3 Jun 2022 21:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245049AbiFCVvO (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245040AbiFCVvO (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 3 Jun 2022 17:51:14 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C17157B3E
        for <linux-modules@vger.kernel.org>; Fri,  3 Jun 2022 14:51:13 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n8so7714834plh.1
        for <linux-modules@vger.kernel.org>; Fri, 03 Jun 2022 14:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MuXYjyvxmuYHSA0H9SSYDWp7qkYOi7EReji9GmluLr4=;
        b=Mp5sejyf8yViNMskSfje7HPk35FvUpxxeo2L8EnrLH7BdVkI5KHvw7G5T09qurhwRt
         EtGoy578BbkbKtppz+/hUnFAjrLsNuar+YFVNjWrgNomP+XV5G81q95x2hWnB4vEOfFE
         R5iRgq9opDry2PPCzPTAET0hgVt6pZX9j298GsoV04Ul3NGYrQ/6dSGXRqiImPnKyTxu
         +yDjjb37nF8Jl4QpLzmMXCXBJh7ZbeiONt0j747+84ew+6PxeUF9CBs+rSWZFAtZiHhQ
         yqisyyPFx/Hwhkpskxj/WtPl6P4+vhv7LWvgIgdCsozdm2nt7vX7gsP4u5isNBGAXFy6
         9JpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MuXYjyvxmuYHSA0H9SSYDWp7qkYOi7EReji9GmluLr4=;
        b=S6G1/WjFqA/OZR/ekFa+0DKL7wx68n8mj0tX+WKmuLdPBA91YQM5nsFpagV4byvd1V
         7SUcW02hlifJPQT3nAvMPjXyl4cBhjnGU6RwIQ4c/5KPRE9+1ITUnEvLjp1oBClXLy4o
         sU1/8jVfsVuOkKqHVSx8wvk3NrFkRRKwQCLJdc8+HYWZ20o1nIEj6wH9KJPo8dw1HwSJ
         uoyARg+B3w7D4D72cQtQ7f/xQDzyyv3WcgH92yCg0xJ1BNzEAlzA1MRRBBl1rvHHdBL9
         37l4bTr8DPajKOsM+hwb0bZgQws56FpRSkvpPPGFawlTOyJ59PYfJCB5arM0NTuEAfJL
         o65Q==
X-Gm-Message-State: AOAM531NwSOiNvcJ/VzJ7jaREP7ZejgRk+doV68JtrYwj/gOkkougSso
        B2v8KTNi2A4B4zodzuf2vHKhHMAvlfA=
X-Google-Smtp-Source: ABdhPJzOWuBua87I5fRU8Py9QcnIv1B+AF930zt4GvmONdaPZAx9/DBbAxJuvuJ+Hoj5CFmH4aW8Ag==
X-Received: by 2002:a17:90b:1c87:b0:1ca:f4e:4fbe with SMTP id oo7-20020a17090b1c8700b001ca0f4e4fbemr47738682pjb.159.1654293072362;
        Fri, 03 Jun 2022 14:51:12 -0700 (PDT)
Received: from ldmartin-desk2.. ([50.45.187.67])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b00163ffe73300sm6032866plg.137.2022.06.03.14.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 14:51:11 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 7/8] testsuite: Add tests for sleep calculation
Date:   Fri,  3 Jun 2022 14:50:46 -0700
Message-Id: <20220603215047.9607-8-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
References: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 testsuite/test-util.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/testsuite/test-util.c b/testsuite/test-util.c
index 621446b..fb8c9ef 100644
--- a/testsuite/test-util.c
+++ b/testsuite/test-util.c
@@ -229,4 +229,45 @@ DEFINE_TEST(test_addu64_overflow,
 	);
 
 
+static int test_backoff_time(const struct test *t)
+{
+	unsigned long long delta;
+
+	/* Check exponential increments */
+	get_backoff_delta_msec(now_msec(), now_msec() + 10, &delta);
+	assert_return(delta == 1, EXIT_FAILURE);
+	get_backoff_delta_msec(now_msec(), now_msec() + 10, &delta);
+	assert_return(delta == 2, EXIT_FAILURE);
+	get_backoff_delta_msec(now_msec(), now_msec() + 10, &delta);
+	assert_return(delta == 4, EXIT_FAILURE);
+	get_backoff_delta_msec(now_msec(), now_msec() + 10, &delta);
+	assert_return(delta == 8, EXIT_FAILURE);
+
+	{
+		unsigned long long t0, tend;
+
+		/* Check tail */
+		delta = 4;
+		tend = now_msec() + 3;
+		t0 = tend - 10;
+		get_backoff_delta_msec(t0, tend, &delta);
+		assert_return(delta == 2, EXIT_FAILURE);
+		tend = now_msec() + 1;
+		t0 = tend - 9;
+		get_backoff_delta_msec(t0, tend, &delta);
+		assert_return(delta == 1, EXIT_FAILURE);
+		tend = now_msec();
+		t0 = tend - 10;
+		get_backoff_delta_msec(t0, tend, &delta);
+		assert_return(delta == 0, EXIT_FAILURE);
+	}
+
+	return EXIT_SUCCESS;
+}
+DEFINE_TEST(test_backoff_time,
+	.description = "check implementation of get_backoff_delta_msec()",
+	.need_spawn = false,
+	);
+
+
 TESTSUITE_MAIN();
-- 
2.36.1

