Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3D3C43334
	for <linux-modules@archiver.kernel.org>; Fri,  3 Jun 2022 21:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbiFCVvN (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242876AbiFCVvL (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 3 Jun 2022 17:51:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F1C57B3E
        for <linux-modules@vger.kernel.org>; Fri,  3 Jun 2022 14:51:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso13050052pjl.3
        for <linux-modules@vger.kernel.org>; Fri, 03 Jun 2022 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iP6+MHi7sHxKscnvV/NWmNg2xqGqAE4GKnrgY09vfTo=;
        b=o5F1Sb4IkaJQ4UCZpihfeFqXHhlHeQyqjU6r4jSYW1aXN2iU9ei+zNfm8rnWHoQ6qI
         mxTgvqgdU77+/WdaSRnsNlhmARw8MnnPJtTaJo4DchrOMq1e3bBIf0YwNbQlCzpz9lxq
         eswdcrrn2o/WCOUcCCw9K3PZsGtYgmKvwjuxOLxRL7yv8ell/FRnsHyR/bBCeMfcKecK
         /+VBV3VI17OWywTwTPG59o9UnlUXQJqoK2axwNYNbwi1wesKYGbWcnGaZpQ6ZISKKv5q
         B0W4Aq9o3MHuRqo18ZMXpBKMUxUjyLi+IAcwHFj/EMAYDMzUDPJWlwMtZIWGq27x+fKg
         6pUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iP6+MHi7sHxKscnvV/NWmNg2xqGqAE4GKnrgY09vfTo=;
        b=ay3useCRZsGkF3xDMriRlmr90OUPd95xqPRGdb1f18SkqtaujnjT0cvtJjwmXvsUF/
         C2iQVk7SKNzrnLL1L0zSdXJMK+bcvaBIClaChpmAWRjMF9CYUP9NvjYGcYW2VLec9nKM
         NwMfedOFX8DxA6TZ8JX5xLTLTCf4ym4gR44XkwWIsEKqhunIVmJO1wZWmVYmMK4aonUM
         DoYB0/8J2QJS062YYqxPFNL+bfoQj41hphkR+cor03OLb1qic44lQWP1wfVmQzkuHO9c
         6gdJ2n8mHrX3Y0Wln+cFia+zmrV2ZWY1TBdAXo9keM4JXsI9qLl/aOyabwtZCd0gUiiJ
         0gGg==
X-Gm-Message-State: AOAM530qRkJ22yav0gc+qzesMw0R0COIXFb5opTOdD1at2ZgikqMGAFZ
        O9yuUJch+i8jVt3Cm7XhfeAqigVevq4=
X-Google-Smtp-Source: ABdhPJxQgRUsDw3gc7EgRfWZvSFWZ91g4uav1g0wvc8stFt7rQZR+kJf/9XuuOVAthln15bCkzSVaQ==
X-Received: by 2002:a17:902:e5cb:b0:166:3622:a7e4 with SMTP id u11-20020a170902e5cb00b001663622a7e4mr12038285plf.32.1654293069803;
        Fri, 03 Jun 2022 14:51:09 -0700 (PDT)
Received: from ldmartin-desk2.. ([50.45.187.67])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b00163ffe73300sm6032866plg.137.2022.06.03.14.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 14:51:08 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 5/8] util: Add msec variants for time-related functions
Date:   Fri,  3 Jun 2022 14:50:44 -0700
Message-Id: <20220603215047.9607-6-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
References: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 shared/util.c | 16 ++++++++++++++++
 shared/util.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/shared/util.c b/shared/util.c
index aeb171f..d4452eb 100644
--- a/shared/util.c
+++ b/shared/util.c
@@ -466,6 +466,12 @@ unsigned long long ts_usec(const struct timespec *ts)
 	       (unsigned long long) ts->tv_nsec / NSEC_PER_USEC;
 }
 
+unsigned long long ts_msec(const struct timespec *ts)
+{
+	return (unsigned long long) ts->tv_sec * MSEC_PER_SEC +
+	       (unsigned long long) ts->tv_nsec / NSEC_PER_MSEC;
+}
+
 unsigned long long now_usec(void)
 {
 	struct timespec ts;
@@ -476,6 +482,16 @@ unsigned long long now_usec(void)
 	return ts_usec(&ts);
 }
 
+unsigned long long now_msec(void)
+{
+	struct timespec ts;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &ts) != 0)
+		return 0;
+
+	return ts_msec(&ts);
+}
+
 unsigned long long stat_mstamp(const struct stat *st)
 {
 #ifdef HAVE_STRUCT_STAT_ST_MTIM
diff --git a/shared/util.h b/shared/util.h
index 734a523..bedafa3 100644
--- a/shared/util.h
+++ b/shared/util.h
@@ -48,9 +48,13 @@ unsigned long long stat_mstamp(const struct stat *st);
  * ************************************************************************ */
 #define USEC_PER_SEC	1000000ULL
 #define USEC_PER_MSEC	1000ULL
+#define MSEC_PER_SEC	1000ULL
+#define NSEC_PER_MSEC	1000000ULL
 
 unsigned long long ts_usec(const struct timespec *ts);
+unsigned long long ts_msec(const struct timespec *ts);
 unsigned long long now_usec(void);
+unsigned long long now_msec(void);
 
 /* endianess and alignments                                                 */
 /* ************************************************************************ */
-- 
2.36.1

