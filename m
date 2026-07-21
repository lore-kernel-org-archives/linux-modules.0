Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22F2442139
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667454; cv=none; b=BEwaphP5xrvWrH+mAXY0hf4rwq1vPjkkJqs2RSDARvKPo62CrlmyamCjPwyGLC8qQ4RbUUwe2PaC8isEjrMFa2YzHLriAxgt6l1lMJ9peVWPehDOhC8Y3qGl9wqmdoi7x0PAfa5/7aKp6mW6hQ+64dTPJo02T2uZMDIjZfsoinE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667454; c=relaxed/simple;
	bh=xMZm/oO0FtfekjkxZIUS9OIoDKqTmliEkK4gwpH/mIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AQ/MKXLjM1s1r6wHeFZtx4tUXWFu5mY2YJymqlDr5CgzP5uhxTOVJFDoAbZ0PDbVvRDkoP+lgJtBympfTG/Z7qRiMSjHLqcfIimjA7GNFFTm0CYSi5/IHHNpid9pQFOIAidy3WF/Wt9PvS5jKyX6GNAk1Jf8un++rV+2WELciV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoGCrNfW; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoGCrNfW"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e9f5637634so5328098a34.3
        for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 13:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667450; x=1785272250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2eu41/ydt/uEYD6twBRH38ATPyPlKojYjlAenMFyI8=;
        b=YoGCrNfWrqDAmmlaGYv7F01W+OJuf9b9QtC3hh3VJ54KpR9/h4CFp6FN0OicFc0Q8D
         LtTodknSbF7U9x5xzVhOeU6oct3P7L1h+VtJ2rzH9LlATlOZ9XCX9Cgee/1iHngH8l3F
         1xcGAll4H4XcyJT8RnfJufF3zVX8EctjJTPP+cSMaLza80yrLmyb8Ul8M6Ve6FwOIivd
         Do2v2xDQb6s51cqeEd0865Noz9yj8g7bxo6QRwpS5USqSNpa+GB1T8C5NubibRLqK/+1
         aESAc79Ws/QOCx5PQxLRMzvADeIoRZs/8PQ6XiE6mOZM80IzRFtjHslo3ivszsqfhLiu
         HLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667450; x=1785272250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2eu41/ydt/uEYD6twBRH38ATPyPlKojYjlAenMFyI8=;
        b=j1Zqi2sCX3GmP+2ruC3/RukOCvxN0Wi8I+7X03aEfhNeBVN7oIU42KD5QJb5zxmNDP
         fg7vtaTXe6u9ZRwaJB/KJhqrmeJ6xrrLeI37GPscEdQlVMgMequKgoNxRkaGej7Jks3L
         X68ie0QwQvnsKxp7MfQBT//rShgDkNY8XXQ6MHA/VQnCUKzvfrXOo1fD3nZnzCOwP149
         SWqfY0IKJzXmAu/i/mQQNWaHITIYJDWzKukGmdY7iuHomnctnGGNGhEcJ8c05bAvwVuB
         dWI62tZ/zG4qsRcgUhTJhsxkGjXW24NFUCi0qUOnwtlkdR2PxWokqZ2cbyNOJAo8aCgF
         LbHg==
X-Forwarded-Encrypted: i=1; AHgh+RqFRPTImsg5n4A1a6QVFqWeVN4I0uj7cshJEwkrOl88IY1mXroP9Z16wmGhA+ewmXE+Kjf/hf1CqNhmeagr@vger.kernel.org
X-Gm-Message-State: AOJu0YzXyrV3j6HbGRXaLt4ynO/I5DWsTed/YKmYhxsIgwMKSunz01NO
	hYSEjyWGPLqhFe+jUbnWJuDk84YwUult1UYmWd7XY+5ZXENKaDKA+sod8MEi+Q==
X-Gm-Gg: AfdE7clWjOBjF4sDlVfxi45Sr2P7uwp2gOX2BqUrO4F+Qpfa/iF6YxE6GNE0UHQYNqZ
	wCGkkUnxuQOX5RwASsUzw/pRV9+LYSG9K540HO9y6uRIGYmJpgxLdGrrbcoWeFq/7xjusH8cXr3
	afp/5gxBKnKnObpBTlPyDkMVWny5LzfNXiMW7j6nCJrA5PSGptjsFXbtsZm0PI+04mDWrx0x+JF
	DemlgdM8ssB0xrmJ4bdykxNxl1jx+R0sg1AWfUUg1ne/j/wBVpHqgfz04NgGhRDNsK9a1YkMCuZ
	XDUIjtButxpkGKRN4wT2Y+sx9p+Jih2PTCgABCp5J0tSusP+/GFXz660LGaPqBmTJT7+ZQUOBEe
	4wB5I2vRus/9wkRCQvUsp4ocQCOQnJecGOI8nTiD1UzvkdNsuSQ3aoI/dxbrgdx43spIbIdEtXq
	Er5ypfdy9qziTwrdQklkjk9A2/33zalUsCbsCNNwrfDsxJnuLnZUH5QKl7JNRun1uDpt9aHY+e4
	LbYG9EM6Sp/qvDpGoNRl9YEXkhgkM677pL+
X-Received: by 2002:a05:6830:349e:b0:7e6:fe3a:b777 with SMTP id 46e09a7af769-7ed9aa23f9bmr12810053a34.13.1784667449716;
        Tue, 21 Jul 2026 13:57:29 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:29 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:04 -0600
Subject: [PATCH v7 15/29] dyndbg: drop NUM_TYPE_ARGS
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-15-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=1542;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=xMZm/oO0FtfekjkxZIUS9OIoDKqTmliEkK4gwpH/mIw=;
 b=N77P9AtjJFwy7FzRMr8In7kiy43wJO+O2C4iqOk47TEdDfFmP812nSRahvaUv1gzRqFViN7n8
 qgDCrRgljrVB76lmYlUQv1NGsjwiR6T6qctOUDgUkjgZ+pHvjsdGWoP
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

ARRAY_SIZE almost works here, since array decl is complete.
But define it locally, named __DDEBUG_ARRAY_SIZE, to avoid
include conflicts with  boot/<something> on some arch.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v7: actually use macro
v5: drop include, it causes redefined probs in /boot/* for some arch.
v2: include linux/array_size.h, correct commit subject, review after sob
---
 include/linux/dynamic_debug.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 9607121c3072..baf5c0853f45 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -8,6 +8,8 @@
 
 #include <linux/build_bug.h>
 
+#define __DDEBUG_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 /*
  * An instance of this structure is created in a special
  * ELF section at every dynamic debug callsite.  At runtime,
@@ -122,11 +124,9 @@ struct ddebug_class_param {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
 		.class_names = _var##_classnames,			\
+		.length = __DDEBUG_ARRAY_SIZE(_var##_classnames),	\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-	(sizeof((eltype[]) {__VA_ARGS__}) / sizeof(eltype))
 
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);

-- 
2.55.0

