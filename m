Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A563C77B7A
	for <linux-modules@archiver.kernel.org>; Fri, 19 May 2023 08:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjESIzI (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 19 May 2023 04:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjESIzB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 19 May 2023 04:55:01 -0400
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9117AE73
        for <linux-modules@vger.kernel.org>; Fri, 19 May 2023 01:54:36 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c2a:210:0:640:45a:0])
        by forward101a.mail.yandex.net (Yandex) with ESMTP id AAB4146C83
        for <linux-modules@vger.kernel.org>; Fri, 19 May 2023 11:54:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id PsZ1QgaDTmI0-Kg6ZKYOT;
        Fri, 19 May 2023 11:54:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1684486474;
        bh=pvL0mya1gswoH/g8sLTIbzdA3/AwDz2+jdCQWq0Ajgw=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=TrlIeCWuq7eFPRp8wFbJPeRXDvSg4+aBN9yZwt+NwaSIMMH13Cb3GFYdE4ORQPR8N
         5q+IEz2+CjQCNlKY4pHq1ZGiRpX2L8sSRJY2kUv4twa6cRoMirZi/iCGZtOBApwcn0
         +b/+RdsGEgvHk1NHgTCXZ3u6j2M137+dIrsuziSo=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     linux-modules@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] shared, tools: introduce and use array iterator
Date:   Fri, 19 May 2023 11:54:23 +0300
Message-Id: <20230519085423.429239-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Introduce the convenient kernel-style array iterator and use it where
appropriate. Note this also fixes the following warnings reported by UBSan:

shared/array.c:67:23: runtime error: applying zero offset to null pointer
tools/depmod.c:1983:25: runtime error: applying zero offset to null pointer

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 shared/array.c | 11 ++++++-----
 shared/array.h |  5 +++++
 tools/depmod.c | 24 +++++++++++++-----------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/shared/array.c b/shared/array.c
index c2e2e14..bc314c6 100644
--- a/shared/array.c
+++ b/shared/array.c
@@ -63,11 +63,12 @@ int array_append(struct array *array, const void *element)
 
 int array_append_unique(struct array *array, const void *element)
 {
-	void **itr = array->array;
-	void **itr_end = itr + array->count;
-	for (; itr < itr_end; itr++)
-		if (*itr == element)
-			return -EEXIST;
+	if (array->array) {
+		void **itr, **end;
+		array_for_each(array, itr, end)
+			if (*itr == element)
+				return -EEXIST;
+	}
 	return array_append(array, element);
 }
 
diff --git a/shared/array.h b/shared/array.h
index b88482f..7172a66 100644
--- a/shared/array.h
+++ b/shared/array.h
@@ -20,3 +20,8 @@ void array_pop(struct array *array);
 void array_free_array(struct array *array);
 void array_sort(struct array *array, int (*cmp)(const void *a, const void *b));
 int array_remove_at(struct array *array, unsigned int pos);
+
+/* Convenient kernel-style array iterator */
+#define array_for_each(_array, _itr, _end) \
+	for (_itr = _array->array, _end = _itr + _array->count; \
+	     _itr < _end; _itr++)
diff --git a/tools/depmod.c b/tools/depmod.c
index a2c39b3..ade33ae 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1970,7 +1970,6 @@ static int depmod_calculate_dependencies(struct depmod *depmod)
 
 	/* topological sort (outputs modules without users first) */
 	while (n_roots > 0) {
-		const struct mod **itr_dst, **itr_dst_end;
 		struct mod *src;
 		uint16_t src_idx = roots[--n_roots];
 
@@ -1979,16 +1978,19 @@ static int depmod_calculate_dependencies(struct depmod *depmod)
 		sorted[n_sorted] = src_idx;
 		n_sorted++;
 
-		itr_dst = (const struct mod **)src->deps.array;
-		itr_dst_end = itr_dst + src->deps.count;
-		for (; itr_dst < itr_dst_end; itr_dst++) {
-			const struct mod *dst = *itr_dst;
-			uint16_t dst_idx = dst->idx;
-			assert(users[dst_idx] > 0);
-			users[dst_idx]--;
-			if (users[dst_idx] == 0) {
-				roots[n_roots] = dst_idx;
-				n_roots++;
+		if (src->deps.array) {
+			void **itr, **end;
+			struct array *base = &src->deps;
+
+			array_for_each(base, itr, end) {
+				const struct mod *dst = *itr;
+				uint16_t dst_idx = dst->idx;
+				assert(users[dst_idx] > 0);
+				users[dst_idx]--;
+				if (users[dst_idx] == 0) {
+					roots[n_roots] = dst_idx;
+					n_roots++;
+				}
 			}
 		}
 	}
-- 
2.40.1

