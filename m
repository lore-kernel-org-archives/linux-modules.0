Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5721913D898
	for <linux-modules@vger.kernel.org>; Tue, 23 Jul 2024 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721761180; cv=none; b=Ul/zxzd1mrJOKiai0UysWe/OX9YE06zoAuBbKFR4rFpyP0/DWAfy6m0w1FCjt0GKw+QzbMOKwwNWNwV41K8y1MkG/aYSKen6hO/XMeUaJTbhgM7C2zyD8wS1WkS0aQC2slSFT+P/ghQAOakVSaHRyIDeolpKOr1yWtmm9Oi9Sks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721761180; c=relaxed/simple;
	bh=YXY4CInA9ySfj/m8nmIS+jbE4BvQlhdxoUr8y+bZtT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwWwUOrsAlql0g3kOMmnJFsIdTs4eYaMT/k4fdXoGRFOwx1nSGjGYSTK0NJbtL4ts8QsNCzJm9kD1NF5jC3g1VCUn8ItAAGnGvUW/TFY7gAopsK1mRnUz1A8zm4hjzVyIRmIgxdKlJCLYGSrUhcfSpJT1F6ZkBGvQ6FT+jDK8jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcLI9Mpt; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcLI9Mpt"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79f1828ed64so397983785a.1
        for <linux-modules@vger.kernel.org>; Tue, 23 Jul 2024 11:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721761178; x=1722365978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joFMq8LNTkTdKeA1nH6pQLPSXZB8m4PzV8yJVIm/q68=;
        b=kcLI9MptnL/4n8CGEiTgghVjOQCuRnNoc/bMGL0DEGYPRhy7jNMIsMQtf4znfIrVdm
         U9LxZnvrj+n20HN+tzXIeF6VGgerS/cpg+jNj8XiZ+CEdjmqlXHUKNnXMIqHvJMjSv12
         +P8TogIgfMVYwuvK0mzbV9SS4TF2NiAheMPDjrFJaqdx5as27CFqBnsUGcdu1zlJ21cS
         MhsDswz9BcPLVgCmGMe/0IbI6bR34fXJqBvFmslWKRN2qcRjLRRPyTHCE4+u6lHtv26P
         vi7YzbHot5y6SJkzCifegibJyWbmd03+DO5E47HVthY3WSNJ05KMxpvCJPAd+YNqpKxa
         WjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721761178; x=1722365978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joFMq8LNTkTdKeA1nH6pQLPSXZB8m4PzV8yJVIm/q68=;
        b=YKLUO2tXQBtwKm9Wj7EiTEqX3Xwj423MXEtrHLpWY46gPlwVtC5FMq7gWtJ2M5teZw
         IXtq5za7mXQY2DfGddfT155OkxMGKIRgSqZKMf9sfsn3L3owe5gD/YVpxfJQi12VvlXp
         udG7hyLrvya7KfWth+qOwhMVjkQjlAuNyxNRK+8l1SzntbES7NQfwTVakpjwLFpqhkgt
         JVWXCzdDJOf7WcRgUohh1gw/73UQbzkDxPNSLujp0SWt4HWekbD9kivboqAwCHSbsfjf
         GAUVFclZG1B4PhGz5cGNQsYzamD9rMkrQk8r5cICzEX/k0He5wY9Gko3muL8P/IeOHp4
         nRlA==
X-Gm-Message-State: AOJu0Yzx0HGsu+l5w5UtKrOISzKw9Ug9QdYxdCFJp4VgubGGHYwPTeRh
	5oQ1sNjNB83nzoBh88q8OUdQCWDZ/FMcvtfpygr0DxpqOAd1n/IUnxoREQ==
X-Google-Smtp-Source: AGHT+IGdwgnqN6UypJHaCnxEq7Cn4YzBm2XcaZNH3/4u+KXFgyErSYA8WizZOTep3zQUSAMmtMaOdA==
X-Received: by 2002:a05:620a:2910:b0:79d:945c:8d5e with SMTP id af79cd13be357-7a1ca19e5dcmr91539985a.49.1721761177688;
        Tue, 23 Jul 2024 11:59:37 -0700 (PDT)
Received: from ldmartin-desk2.lan ([134.134.137.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1990792a0sm504967685a.109.2024.07.23.11.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 11:59:36 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: emil.l.velikov@gmail.com,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH v2 3/3] depmod: Remove license/copyright from the middle
Date: Tue, 23 Jul 2024 13:59:21 -0500
Message-ID: <20240723185921.1005569-4-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723185921.1005569-1-lucas.de.marchi@gmail.com>
References: <20240723185921.1005569-1-lucas.de.marchi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The top license is enough as it's the same. Just move the copyright to
the top and remove notice about code that was copied and modified: that
comment doesn't age well as source is updated.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 tools/depmod.c | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 661cfc4..8b0a428 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (C) 2008  Alan Jenkins <alan-jenkins@tuffmail.co.uk>.
  * Copyright (C) 2011-2013  ProFUSION embedded systems
  */
 
+#include <arpa/inet.h>
 #include <assert.h>
 #include <ctype.h>
 #include <dirent.h>
@@ -116,30 +118,7 @@ static inline void _show(const char *fmt, ...)
 #define SHOW(...) _show(__VA_ARGS__)
 
 
-/* binary index write *************************************************/
-#include <arpa/inet.h>
-/* BEGIN: code from module-init-tools/index.c just modified to compile here.
- *
- * Original copyright:
- *   index.c: module index file shared functions for modprobe and depmod
- *   Copyright (C) 2008  Alan Jenkins <alan-jenkins@tuffmail.co.uk>.
- *
- *   These programs are free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with these programs.  If not, see <http://www.gnu.org/licenses/>.
- */
-
 /* see documentation in libkmod/libkmod-index.c */
-
 #define INDEX_MAGIC 0xB007F457
 #define INDEX_VERSION_MAJOR 0x0002
 #define INDEX_VERSION_MINOR 0x0001
@@ -418,9 +397,6 @@ static void index_write(const struct index_node *node, FILE *out)
 	(void)fseek(out, final_offset, SEEK_SET);
 }
 
-/* END: code from module-init-tools/index.c just modified to compile here.
- */
-
 /* configuration parsing **********************************************/
 struct cfg_override {
 	struct cfg_override *next;
-- 
2.45.2

