Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718FDC433EF
	for <linux-modules@archiver.kernel.org>; Fri,  3 Jun 2022 21:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242876AbiFCVvN (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245040AbiFCVvN (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 3 Jun 2022 17:51:13 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285B2580C3
        for <linux-modules@vger.kernel.org>; Fri,  3 Jun 2022 14:51:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n8so7714809plh.1
        for <linux-modules@vger.kernel.org>; Fri, 03 Jun 2022 14:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4dfS+aVx0bMyj+vGaxCHuJwOGGxQuq6BokCwq/GVf94=;
        b=kC7wfyayjutXk5l8dPUfunikhIOCc7extY0ibMnFmqxeaQAloq0Y5RAFqPDYUN9kCG
         Jwsk86qOFTAM1bBYK1aznQxmCrMcFYwyDY8c3rbjOi8+M5HY3LGT4rZVD2bzchOik+Pv
         QgA+PjxfBoJG4eRdlngs8okwRzSRB+nhxkUreWQFeVXH+v8mhFxcHsqc5VUjoI2agXLd
         3QjWjXRVj4MdGeRSqYtk8FGta6sSQQHEDDBIKiUEZH/7era9oAq9LT6PzYNvoKTZGXOc
         EqZJpYr6dxWIWMxdR7J/twQLhJBdFPIaBVPnzM9/djqIhHFfmOM1WAr6Wz3ql4M7EZh1
         R+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4dfS+aVx0bMyj+vGaxCHuJwOGGxQuq6BokCwq/GVf94=;
        b=ednEX/6xrQE1Ah1H6BuL9QYbjIkInzrTzYkTvWwvQCji1REI2yskkJOxhOZMgU/tWx
         YOBz7raR8k4orF2IyHckDnsDStmsYq9AdefaTLbYATCngMcWz3wHf+DrEB2Q6i/bPZWt
         ECjgfOm12hcqSlcicMuvZ09hyaip73Nw/7+LjawJuKK43ZEtJ1ib0IP5DBb0i2YDNA4n
         HNPxiBLOIIJBgpEnpzwXk0qeyeSdu8ILMykMgJCjH0W114BixUB6Epk4cbKyDH4wQeUf
         bn0IiQKa+t2eWwdDOW1ognewV7DBQyroxtGKA1Q4Jy8a9G4+ubsuBwsL7ETY6djnNDxo
         v8cw==
X-Gm-Message-State: AOAM533F7Ywf//0znZc/36zk3oyZDP3mZ0mG7tP7EqWGoK4A4FDBDYl6
        Kutl2esBzkKNNP0ssrhxkghHtsOjtvg=
X-Google-Smtp-Source: ABdhPJzmC/4JEtYaOn9bsDOGtAUBvmkb/9QQN7dnRhoRRB+gwn6PWXY65NOviKNpRTqa1zNKy8ToCw==
X-Received: by 2002:a17:90b:1a88:b0:1dc:8e84:9133 with SMTP id ng8-20020a17090b1a8800b001dc8e849133mr12891206pjb.231.1654293071247;
        Fri, 03 Jun 2022 14:51:11 -0700 (PDT)
Received: from ldmartin-desk2.. ([50.45.187.67])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b00163ffe73300sm6032866plg.137.2022.06.03.14.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 14:51:10 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 6/8] util: Add exponential backoff sleep
Date:   Fri,  3 Jun 2022 14:50:45 -0700
Message-Id: <20220603215047.9607-7-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
References: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Add simple functions to put the current thread to sleep using
exponential backoff to split the interval in smaller pieces.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 shared/util.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 shared/util.h |  5 +++++
 2 files changed, 51 insertions(+)

diff --git a/shared/util.c b/shared/util.c
index d4452eb..4b547ff 100644
--- a/shared/util.c
+++ b/shared/util.c
@@ -472,6 +472,52 @@ unsigned long long ts_msec(const struct timespec *ts)
 	       (unsigned long long) ts->tv_nsec / NSEC_PER_MSEC;
 }
 
+static struct timespec msec_ts(unsigned long long msec)
+{
+	struct timespec ts = {
+		.tv_sec = msec / MSEC_PER_SEC,
+		.tv_nsec = (msec % MSEC_PER_SEC) * NSEC_PER_MSEC,
+	};
+
+	return ts;
+}
+
+int sleep_until_msec(unsigned long long msec)
+{
+	struct timespec ts = msec_ts(msec);
+
+	if (clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &ts, NULL) < 0 &&
+	    errno != EINTR)
+		return -errno;
+
+	return 0;
+}
+
+/*
+ * Exponential retry backoff with tail
+ */
+unsigned long long get_backoff_delta_msec(unsigned long long t0,
+					  unsigned long long tend,
+					  unsigned long long *delta)
+{
+	unsigned long long t;
+
+	t = now_msec();
+
+	if (!*delta)
+		*delta = 1;
+	else
+		*delta <<= 1;
+
+	while (t + *delta > tend)
+		*delta >>= 1;
+
+	if (!*delta && tend > t)
+		*delta = tend - t;
+
+	return t + *delta;
+}
+
 unsigned long long now_usec(void)
 {
 	struct timespec ts;
diff --git a/shared/util.h b/shared/util.h
index bedafa3..7030653 100644
--- a/shared/util.h
+++ b/shared/util.h
@@ -55,6 +55,11 @@ unsigned long long ts_usec(const struct timespec *ts);
 unsigned long long ts_msec(const struct timespec *ts);
 unsigned long long now_usec(void);
 unsigned long long now_msec(void);
+int sleep_until_msec(unsigned long long msec);
+unsigned long long get_backoff_delta_msec(unsigned long long t0,
+					  unsigned long long tend,
+					  unsigned long long *delta);
+
 
 /* endianess and alignments                                                 */
 /* ************************************************************************ */
-- 
2.36.1

