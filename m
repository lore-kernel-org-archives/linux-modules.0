Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F589279DA6
	for <linux-modules@vger.kernel.org>; Tue,  1 Jul 2025 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383231; cv=none; b=BiP6dsilBNDtH04KGi5PpaDXKBq85aOErTJXs4zMPF4RexaVGN+2neWgjkWvvE8xnAfj1IOlhXJtsaTNxIDOM+v4S858YCQwPBww/ObMyix4bRylkCbnMSvpU6oRcK231NL7zAA81YkFaD54EutuhO2+x9dDqMYrCklp9G6EYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383231; c=relaxed/simple;
	bh=0LZPlTOzhDgN4M2JFCpvyuUvtX08QaSuKLicDKE1N5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F9LyN7L5fTwvaoABYqGW5vKVscurDGidrOeoqX19JO7eEToUDPCQ4oUIN1mABMzrXDQZ20zSa9Jx5t6vJQ8qImg8YCNNeydAxFYlSk8KPCeOc1U+vjxpfbq4J8dfwXgSkaGzbzfFlLI0zSWlXLDzc/h5bS+pTSyLNyCr/c2XuJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aPwe4tPY; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPwe4tPY"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-450d290d542so37248655e9.1
        for <linux-modules@vger.kernel.org>; Tue, 01 Jul 2025 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751383228; x=1751988028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQj2YyKGGYHlLV8Kxk75PVsyeBZE5VokyKievIbbY3k=;
        b=aPwe4tPYb+sNoUnlRggdhJTYu+HaWZ+bC4Pfe9ufJbdjneviNvrQ/gJYWRJsGoiYUN
         velH5B2s2JcmE/5aiP/e3m3DhoCNnuEgqqM6P0Ctywz65b3QRuEWSf+GeWf0zDF3vRCv
         khvJez74+gRM4E/cD3rPwyxuyWYD7epxT+ZStHaZDENMMsFvX3Tz2wdUmTwGq34wloCp
         PxMvaN5MhMrXe+nFwEkF38jHx96jKUAJoyBqdQxhvxDlwvQjq54jBHXUDoqgodHSx+QN
         8ZAYnfz3XfCTthXvLxVEJFfFFdE+FFv/vfgp4rj1Cx7e77g2bDHgdk/0hiDyMJX/aWDO
         Csyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751383228; x=1751988028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQj2YyKGGYHlLV8Kxk75PVsyeBZE5VokyKievIbbY3k=;
        b=DIJD9Ez+h3KAIE0AXj9PwemOiJ+AoD+CKNIeMemP2WMVGCGGpc0QHkKMopUQw/7qxm
         gVCLBT0WNJt4U7ngk/QpShkqZ+Ch4IwVUMM8KZOR0ctJLpTWgCbKuI3IHfcUgn6Ib8U8
         rwgueNsg64X43b8CmJxs8qLX4UP/1S7BNJAgipGlLRG9fhgmZSGYanchcebQ/JJl+QrI
         LdSusoTwEbS/iKwU7aswdvkQU2v68W80XskyiWl8owtMJGMdAYNvo7SmxcszYk1Irvki
         iChPufjTxObNXcsWmUPHbFaBUL0yF736uHUU+lDZUG8PoBXyjj0j6qzfDXrc94Jj4in3
         AgfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuc9a53SehWNpsgYtZanbqMZ3Kh6YOSjrJmOktCJjw4gm9aaZof6yDZyA0txgxMNyysBWES9rfPGumDdSm@vger.kernel.org
X-Gm-Message-State: AOJu0Yytm4CCcH54rzQ1HZiRG5hOFPEENd5OwJ4up3aw/Ry+/Pv4Nt+J
	jfDVsw8oW9hVmLf4kGXGoy1Rvl3SeG5SPz3D3vci5WrFVs/D1VZqi0Jx59BIhE/MBm9NG2T7ay/
	SxKgmVHhUOCzesg==
X-Google-Smtp-Source: AGHT+IElh3PYpbuoTAc35/xRfrNx9S2QQcNvE6QJPF2din6i4y4W48x8gXxZ/sqDfxdlN+vEmIzdSckX/yxw2w==
X-Received: from wmte15.prod.google.com ([2002:a05:600c:8b2f:b0:44f:f406:f4f2])
 (user=gprocida job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ba6:b0:442:d5dd:5b4b with SMTP id 5b1f17b1804b1-4538eeac21fmr192770235e9.31.1751383227988;
 Tue, 01 Jul 2025 08:20:27 -0700 (PDT)
Date: Tue,  1 Jul 2025 16:19:11 +0100
In-Reply-To: <20250701152000.2477659-1-gprocida@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAK7LNASzE1CtRo9T4byPXJtB-HtuWsGe=OLba+8JU9fB28Chow@mail.gmail.com>
 <20250701152000.2477659-1-gprocida@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250701152000.2477659-3-gprocida@google.com>
Subject: [PATCH v2 2/2] gendwarfksyms: order -T symtypes output by name
From: Giuliano Procida <gprocida@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
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

diff --git a/scripts/gendwarfksyms/types.c b/scripts/gendwarfksyms/types.c
index 5344c7b9a9ce..9c3b053bf061 100644
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
+	es = xmalloc(count * sizeof(*es));
+	hash_for_each_safe(type_map, e, tmp, hash)
+		es[i++] = e;
+
+	qsort(es, count, sizeof(*es), cmp_expansion_name);
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
2.50.0.727.gbf7dc18ff4-goog

