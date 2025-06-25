Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89E31DEFE7
	for <linux-modules@vger.kernel.org>; Wed, 25 Jun 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845160; cv=none; b=gzxwNPaqZMjeb75Hcen2xLqrHi3F/P4wihpr+BbhRgbi6nCUKJ531peTtUF0oJoRlf63PnNQvz6zTSOTW1lv7TYRB2IhTbXRuXEcfC03FnMLQ/CX9S8gkFjhVcKirfp3zKhD+cMOcKYXOiQ2selOcmlWkeVBtbUQQc0fopRED74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845160; c=relaxed/simple;
	bh=1Y8QJ+oRfOtSdRhQbvBmTw9lQq+2E+h8tGLHlYsZDv4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QLkOJNjh7XT4Bilw6of0+Dsw2CFz8Tg5mfWtpY7NFsdeM4yI94q1EyOfNN0WDEeHL6R6eMtWS/tOlizEoRlJ7H3UUqM95O5NpYcbhiwE6m7Vptl8bc3bj2tCgecnxU4Dp8XWgTYPRmiBKhVxOikkEWvKrcK+yc5u1r7Btyd523E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WyKyMbmw; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WyKyMbmw"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4535ad64d30so50388385e9.3
        for <linux-modules@vger.kernel.org>; Wed, 25 Jun 2025 02:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750845156; x=1751449956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FPaFg8skY6SjMOJvVYfiFB9uK0FraGFCMhdVa+qk2JA=;
        b=WyKyMbmwIXF3ash5OeLSACPYQ/WJ89qeH0r52vZ3uL+xxHhEXTkN4y6nwa0o3EX5k+
         G/2/bV0pUNQOxnc459Qr10gtGzFTNO8i68e3OEABtUkt3i8mcX1wEUEu6TOWrPpkXynm
         1jBAvcuIjdvWPK2AoCEtSy9oK3FMdiVY6SnW1FtsaY9EsHidjJHhMit4qcDsGhURHLgG
         w+myr3NeThC45QWvXJa4jX4k3NMbDezXN0a1NO/6SQPZHIRCr6wXaNKCIW61+l+FfCqc
         QQ6fH8gIrC7TDhnuuDZeOC1DNE+5uMbKY/N21ePMnOQJ1AIN3Vya2akPm15TEKXQRn37
         MT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845156; x=1751449956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPaFg8skY6SjMOJvVYfiFB9uK0FraGFCMhdVa+qk2JA=;
        b=e0Xjm1wDg2sJke7UksuKjW3Oflbp20sokc0JlgcjwKMvSkZZ0hBWbf3fS2zo3fD8MK
         8rMuEwonCBrBbR7dg3GzQ8GEqpo36Ki/P4Lga3coe/QGwewoYl8U8E8+fpJ3ueWyfBhu
         rpepWup/+4mqTMg32vQTHp3QfCZwmFgdcv4SqLOvQ/9BZpUVvdAumsUXMtHX4CcVM1o0
         fz23PR6btZQXTErvJZqAxT+WkxWYhL1vGsawMEOCy0gGoQQgX/jHg2R7ugcDnyF2OOQZ
         7BDoWScL3GIDWstNLeCmryg0PA2+Q+O3yiS87SuBI3gk1+HhQhL5OlqwJKu40QRH1/Lm
         Z19g==
X-Forwarded-Encrypted: i=1; AJvYcCVxoJvKxmMO3p8AdFSwv5my3WwTqB+L5MbaveakZhACc3dr8rrWXoJz5qOyovSDILBGSZKdquJoxVt8ApVf@vger.kernel.org
X-Gm-Message-State: AOJu0YwTRB67MwR8nmTBMIc4w/pqd1pJw+MaiaqbVEk1XdLIEc4kf7+7
	NYefZKwJ98aFWeaunTHtMJ1uBktrI8LgFE4WLcbRZT+kHTbUkEssJbq7DFiSQSMzeXdj9hZ/3nU
	HovwMqVzvjmKiHA==
X-Google-Smtp-Source: AGHT+IH9NSYt2O7TMUJiMIjZArM9uvyETHRaUeq8opq8u7NG97Qu9jaiO6QvaVXjIAI5VY4zW+Mj5w0AJLfVFw==
X-Received: from wmbfa15.prod.google.com ([2002:a05:600c:518f:b0:43d:5828:13ee])
 (user=gprocida job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e11:b0:450:d61f:dd45 with SMTP id 5b1f17b1804b1-45381aa54ecmr21075505e9.4.1750845156283;
 Wed, 25 Jun 2025 02:52:36 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:52:08 +0100
In-Reply-To: <20250623092350.3261118-2-gprocida@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250623092350.3261118-2-gprocida@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250625095215.4027938-1-gprocida@google.com>
Subject: [PATCH] gendwarfksyms: order -T symtypes output by name
From: Giuliano Procida <gprocida@google.com>
To: Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Giuliano Procida <gprocida@google.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When writing symtypes information, we iterate through the entire hash
table containing type expansions. The key order varies unpredictably
as new entries are added, making it harder to compare symtypes between
builds.

Resolve this by sorting the type expansions by name before output.

Signed-off-by: Giuliano Procida <gprocida@google.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/gendwarfksyms/types.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

[Adjusted the first line of the description. Added reviewer tags.
 Added missing CC to linux-modules.]

diff --git a/scripts/gendwarfksyms/types.c b/scripts/gendwarfksyms/types.c
index 7bd459ea6c59..51c1471e8684 100644
--- a/scripts/gendwarfksyms/types.c
+++ b/scripts/gendwarfksyms/types.c
@@ -6,6 +6,8 @@
 #define _GNU_SOURCE
 #include <inttypes.h>
 #include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 #include <zlib.h>
 
 #include "gendwarfksyms.h"
@@ -179,20 +181,41 @@ static int type_map_get(const char *name, struct type_expansion **res)
 	return -1;
 }
 
+static int cmp_expansion_name(const void *p1, const void *p2)
+{
+	struct type_expansion *const *e1 = p1;
+	struct type_expansion *const *e2 = p2;
+
+	return strcmp((*e1)->name, (*e2)->name);
+}
+
 static void type_map_write(FILE *file)
 {
 	struct type_expansion *e;
 	struct hlist_node *tmp;
+	struct type_expansion **es;
+	size_t count = 0;
+	size_t i = 0;
 
 	if (!file)
 		return;
 
-	hash_for_each_safe(type_map, e, tmp, hash) {
-		checkp(fputs(e->name, file));
+	hash_for_each_safe(type_map, e, tmp, hash)
+		++count;
+	es = xmalloc(count * sizeof(struct type_expansion *));
+	hash_for_each_safe(type_map, e, tmp, hash)
+		es[i++] = e;
+
+	qsort(es, count, sizeof(struct type_expansion *), cmp_expansion_name);
+
+	for (i = 0; i < count; ++i) {
+		checkp(fputs(es[i]->name, file));
 		checkp(fputs(" ", file));
-		type_list_write(&e->expanded, file);
+		type_list_write(&es[i]->expanded, file);
 		checkp(fputs("\n", file));
 	}
+
+	free(es);
 }
 
 static void type_map_free(void)
-- 
2.50.0.714.g196bf9f422-goog

