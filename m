Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEC0C6379F
	for <linux-modules@archiver.kernel.org>; Tue, 21 Feb 2023 13:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjBUNTj (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 21 Feb 2023 08:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjBUNTi (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 21 Feb 2023 08:19:38 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217C54690
        for <linux-modules@vger.kernel.org>; Tue, 21 Feb 2023 05:19:37 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so1177063wmq.2
        for <linux-modules@vger.kernel.org>; Tue, 21 Feb 2023 05:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71h8EqTR38D1vU1Ns7pR/Fzm/P/c2WawQeO6hO0xei8=;
        b=iVilA8RTW6Ro/2mdnTeQ39UFTavVkNB6L0KcJuo7dO5RAVUYIeRNItIy8UP4ewRxSF
         lRNUnyt3LTGBBpIhIIGSF9+dovxWjD6NDN3c9KKXpXav7r5T7dTEGzoz9yDXeq5cAChe
         75/oJP7DJUuwfq+s6et+JO+Hgv2gdKWHUMxM7Rt2FGzpD9WuCpRSRLIhYeV391sZsyPh
         FoFAB+QYH8XcY3KZDod1QVHl8oEu9Q2SbR4ZFcnnaIamr+7xcpVECttTlqEMLpy3AAYS
         08ZZgM3sNnmDb3whWe4qEC3m66gxiMXreNF+bUjnov1VQvfmap7XWMpkoyz7ewv3Jar/
         xiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71h8EqTR38D1vU1Ns7pR/Fzm/P/c2WawQeO6hO0xei8=;
        b=DcS7P3xfoienC6a7H5fvfKM0SAi2qyQa3QgfttK7XuFrzBHs3wyxV1Aq2+8vbi0mEf
         6a7fyj+MFlIqIgkE8FrHliDN8kx8zRochPD+6vMSUTYmzCAhmv/5Gannu/odz3/CPVYc
         CiN/sDfpHQsLkVlbswPUX2KDGhYTIeuVpTEa7xA7a/g5U1Nd/WeHMGoH+Jep7WSvdKpl
         nbfwNSWRCEN853OH06PwxK/6YxTNwfj5vLS4HAHjAeZBjjFjIHSt3LI9MLuAHH28mtx1
         Etm5MS7U7GIFcsE9QJ7epqvVW/rHdtU+MXMRbuE0YTTYmpzy3LCsyta2QM+s+kG99ZPo
         IaoQ==
X-Gm-Message-State: AO0yUKW3GzM9+r+KSwMD7aGSEhqLnO9RDrKdqocINvXWKl9l683b7ZdX
        GiwwC1qP5Eq4dOG8RXaByVD14aH+0YI=
X-Google-Smtp-Source: AK7set+UF9G1qiAaEj546724MKGrU6rH6gbv2SmWLJ1c1z2N0fxGjRmGmdePUIErse/EeWZxoQsdfQ==
X-Received: by 2002:a05:600c:2ac8:b0:3e0:114:62ee with SMTP id t8-20020a05600c2ac800b003e0011462eemr3277645wme.8.1676985575197;
        Tue, 21 Feb 2023 05:19:35 -0800 (PST)
Received: from localhost (cpc92308-cmbg19-2-0-cust99.5-4.cable.virginm.net. [82.24.248.100])
        by smtp.gmail.com with UTF8SMTPSA id k17-20020a7bc411000000b003dfee43863fsm3963613wmi.26.2023.02.21.05.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 05:19:34 -0800 (PST)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     emil.l.velikov@gmail.com
Subject: [PATCH 3/4] shared: annotate local API as static
Date:   Tue, 21 Feb 2023 13:19:28 +0000
Message-Id: <20230221131929.106951-4-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221131929.106951-1-emil.l.velikov@gmail.com>
References: <20230221131929.106951-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Emil Velikov <emil.velikov@collabora.com>

None of the API is used outside of the compilation unit.

Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
---
 shared/util.c | 6 +++---
 shared/util.h | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/shared/util.c b/shared/util.c
index 4b547ff..e2bab83 100644
--- a/shared/util.c
+++ b/shared/util.c
@@ -354,7 +354,7 @@ char *freadline_wrapped(FILE *fp, unsigned int *linenum)
 /* path handling functions                                                  */
 /* ************************************************************************ */
 
-bool path_is_absolute(const char *p)
+static bool path_is_absolute(const char *p)
 {
 	assert(p != NULL);
 
@@ -460,13 +460,13 @@ int mkdir_parents(const char *path, mode_t mode)
 	return mkdir_p(path, end - path, mode);
 }
 
-unsigned long long ts_usec(const struct timespec *ts)
+static unsigned long long ts_usec(const struct timespec *ts)
 {
 	return (unsigned long long) ts->tv_sec * USEC_PER_SEC +
 	       (unsigned long long) ts->tv_nsec / NSEC_PER_USEC;
 }
 
-unsigned long long ts_msec(const struct timespec *ts)
+static unsigned long long ts_msec(const struct timespec *ts)
 {
 	return (unsigned long long) ts->tv_sec * MSEC_PER_SEC +
 	       (unsigned long long) ts->tv_nsec / NSEC_PER_MSEC;
diff --git a/shared/util.h b/shared/util.h
index 7030653..c4a3916 100644
--- a/shared/util.h
+++ b/shared/util.h
@@ -38,7 +38,6 @@ char *freadline_wrapped(FILE *fp, unsigned int *linenum) __attribute__((nonnull(
 
 /* path handling functions                                                  */
 /* ************************************************************************ */
-bool path_is_absolute(const char *p) _must_check_ __attribute__((nonnull(1)));
 char *path_make_absolute_cwd(const char *p) _must_check_ __attribute__((nonnull(1)));
 int mkdir_p(const char *path, int len, mode_t mode);
 int mkdir_parents(const char *path, mode_t mode);
@@ -51,8 +50,6 @@ unsigned long long stat_mstamp(const struct stat *st);
 #define MSEC_PER_SEC	1000ULL
 #define NSEC_PER_MSEC	1000000ULL
 
-unsigned long long ts_usec(const struct timespec *ts);
-unsigned long long ts_msec(const struct timespec *ts);
 unsigned long long now_usec(void);
 unsigned long long now_msec(void);
 int sleep_until_msec(unsigned long long msec);
-- 
2.39.2

