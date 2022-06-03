Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866EAC433EF
	for <linux-modules@archiver.kernel.org>; Fri,  3 Jun 2022 21:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbiFCVvK (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240444AbiFCVvK (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 3 Jun 2022 17:51:10 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF5757B3E
        for <linux-modules@vger.kernel.org>; Fri,  3 Jun 2022 14:51:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so8062117pjs.1
        for <linux-modules@vger.kernel.org>; Fri, 03 Jun 2022 14:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0XkxNHrXnKt0HQWanf5BDvaDmGmbQtiT0X773VTjlEE=;
        b=WOnp+ZqXIc6PeQ7yxAXuHH0ZJaXI78gP/0pjyAXgwjLqww0fCTuBeU2bvbz+2gkCV4
         GwyV9eTRUqc2pTKNrD3UoUHu+XNi71V/Zeqe5766kzy+ZweOpppkDQHOxm2tj02GqQYd
         ueed4DBZkPL1g1bvDDrAFf/B4Pmu66TycUECtTfDf5qJSW+wfd+x40ARjdiN3x+mRNJw
         y5haRqmZ03NMUG6vo8gsy8FbWsIki0Vn627kwSZ39IZXpYtYvYS+zZdjn/PoqwZt63XR
         7QAbUa3zcT5yB+aNWLz5dPqHMZyvLVlccSLOxLX/2vBUEpE0ci91vYPlrIlH9j49pKv1
         H5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0XkxNHrXnKt0HQWanf5BDvaDmGmbQtiT0X773VTjlEE=;
        b=dg626WLKAMfw05F8C4XZM1lr4lGl08MMmghxzPCh1W/kXL4y+I6hAXMpJuQ4EuQMYq
         dhkcofJU6No+q9Ge1Wgnyie9R6UKZWIkl6tLSfLSpSxg1QwVGWFMJaPr7SbzIiBxUQ1V
         IA7gV2T5RNRcZ9jkZb6Yj6u2MCtYNyWAAkxto1EXVaDETQE2av/KRWO43xbmsX37Aq21
         TtG4Iqi6RmROSGYtnWwm4kJpOVpmenDX1n8bED0yezFcepdbKE8oVj1ojmTpwJRcddD0
         2knIXdbrB+NkBCkAdthQJoCE/ycdhiO17kzKFDZL7XhVp0Lf8sVZZ+bS2/VUWT7fWFQY
         bVBQ==
X-Gm-Message-State: AOAM530F80iMoox00Z5wLxEjgxrBj4e1ktAAvaVF9i+GPvHdCHFlaAX7
        KY0YunqFEUTmYYQM7iZcTtPL4KJk2qk=
X-Google-Smtp-Source: ABdhPJxcD9iS4u1g4N5FYdG68ymNOS0QDT5Dnr/69fBCgxoSGibQiunlVNGMw/IYBMfMjigy0yteOA==
X-Received: by 2002:a17:90a:d3d3:b0:1df:3b6f:d073 with SMTP id d19-20020a17090ad3d300b001df3b6fd073mr46788564pjw.18.1654293068152;
        Fri, 03 Jun 2022 14:51:08 -0700 (PDT)
Received: from ldmartin-desk2.. ([50.45.187.67])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b00163ffe73300sm6032866plg.137.2022.06.03.14.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 14:51:06 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 4/8] util: Add time-related functions from testsuite
Date:   Fri,  3 Jun 2022 14:50:43 -0700
Message-Id: <20220603215047.9607-5-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
References: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This will be useful in future not only to testsuite, but also to tools
and library.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 shared/util.c         | 10 ++++++++++
 shared/util.h         |  8 ++++++++
 testsuite/testsuite.c | 14 +-------------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/shared/util.c b/shared/util.c
index b487b5f..aeb171f 100644
--- a/shared/util.c
+++ b/shared/util.c
@@ -466,6 +466,16 @@ unsigned long long ts_usec(const struct timespec *ts)
 	       (unsigned long long) ts->tv_nsec / NSEC_PER_USEC;
 }
 
+unsigned long long now_usec(void)
+{
+	struct timespec ts;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &ts) != 0)
+		return 0;
+
+	return ts_usec(&ts);
+}
+
 unsigned long long stat_mstamp(const struct stat *st)
 {
 #ifdef HAVE_STRUCT_STAT_ST_MTIM
diff --git a/shared/util.h b/shared/util.h
index c6a31df..734a523 100644
--- a/shared/util.h
+++ b/shared/util.h
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <time.h>
 
 #include <shared/macro.h>
 
@@ -42,7 +43,14 @@ char *path_make_absolute_cwd(const char *p) _must_check_ __attribute__((nonnull(
 int mkdir_p(const char *path, int len, mode_t mode);
 int mkdir_parents(const char *path, mode_t mode);
 unsigned long long stat_mstamp(const struct stat *st);
+
+/* time-related functions
+ * ************************************************************************ */
+#define USEC_PER_SEC	1000000ULL
+#define USEC_PER_MSEC	1000ULL
+
 unsigned long long ts_usec(const struct timespec *ts);
+unsigned long long now_usec(void);
 
 /* endianess and alignments                                                 */
 /* ************************************************************************ */
diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
index 05df553..6a2d296 100644
--- a/testsuite/testsuite.c
+++ b/testsuite/testsuite.c
@@ -51,6 +51,7 @@ static const struct option options[] = {
 };
 
 #define OVERRIDE_LIBDIR ABS_TOP_BUILDDIR "/testsuite/.libs/"
+#define TEST_TIMEOUT_USEC 2 * USEC_PER_SEC
 
 struct _env_config {
 	const char *key;
@@ -62,19 +63,6 @@ struct _env_config {
 	[TC_DELETE_MODULE_RETCODES] = { S_TC_DELETE_MODULE_RETCODES, OVERRIDE_LIBDIR "delete_module.so" },
 };
 
-#define USEC_PER_SEC  1000000ULL
-#define USEC_PER_MSEC  1000ULL
-#define TEST_TIMEOUT_USEC 2 * USEC_PER_SEC
-static unsigned long long now_usec(void)
-{
-	struct timespec ts;
-
-	if (clock_gettime(CLOCK_MONOTONIC, &ts) != 0)
-		return 0;
-
-	return ts_usec(&ts);
-}
-
 static void help(void)
 {
 	const struct option *itr;
-- 
2.36.1

