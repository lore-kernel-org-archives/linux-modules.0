Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B494D47252C
	for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667458; cv=none; b=ogEwOgnsX4s3PGWHnBBP0VnfSQxLnZIlmH2tzxf8YqdStwRx/ZaZkNY6W+b9x7QFZeTk/kdZh8ZYhIE2jXfy6EyRht2j8P+h6LLyD3wjAOTBJpNku6Tk3eLe5MyE/KYu2cjjzVFL5Dwpnaqw+KZP9AegscS5LUe3UEiZ0j7XZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667458; c=relaxed/simple;
	bh=cOvO6sx3YqLFd3U+lr49fTx42/CUMz8iaG20o06tc/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0zS8Uc0Cb86/Az9X5UH6XjLJZsF7emphwN+uDL34t0da4gWNEYa+pNeAMENGuGNtgJWKfe5A/VF9cdmFTtg1WxoNLX854t04Ta7GynxUPR/Z8uQP8NEM1Ldcj7N0w31JraocOTZff7ehGTiFvO679PIlZ11lwXOzq0dT0a7ftM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsOTIsDz; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsOTIsDz"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7ee125ec926so743258a34.2
        for <linux-modules@vger.kernel.org>; Tue, 21 Jul 2026 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667453; x=1785272253; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l/mBb0fGCUwSIYa5j0WOJP7wxrKLNvtiy/Z40bYPFTI=;
        b=OsOTIsDzgFVMM5MqVTmk9HPasb3PyfSYNnqanDBkL4qfoKrhGngxSvWK6IX+2jcFHc
         g6h1OZR7mXcHDXXU3ouQ+I82JF4XmQFFrVQop4aabWI0JD81GGGgbRxf8VVtesfiRPFr
         XcbP0NLvY23G+ilF+HEDVJ/I1J576yk69RFSSOmE0JXRt0PvX2x6Ex90fQi4gipR5BST
         mkmMuGrtbLXIlS86u4JHCzqqcZBFrBLHR6lhauSh/o186TYtNMzs6MxcXotWbNbwt/MV
         gqMhSIT0lTuh6aZFKRwJnW7iA9jac7MCQ3tCSj72PxuF6iD407ntfH4gZ+z3Kxy28hxP
         GUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667453; x=1785272253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/mBb0fGCUwSIYa5j0WOJP7wxrKLNvtiy/Z40bYPFTI=;
        b=cWfX580R71tAfpocj+6quqzl5+gj7ZSjQfz49V3lsRM0MmdwWOiLuqZ9Ka3d54NP/W
         S6Ys03WcwfCuL2J9jFRkyUwhL3bzgqTBsYjxdSPYnKwa3GYU6RW4h8jFHC/kSaiuBxB/
         fcedbjP6OsCVsyKk24FNT9KblwyqtSUMl9gTWfefN/Y1GyUinSk/+128/2HJVLO5DnzW
         BEX42kc8Y7hl/4GIr6L+jCpp+sMl0lFTLUs9DaaL/7MHwszAc86SPzuUq9vYIZTiE7in
         dWK2J+QYzFuJYoFcvTQONkc7KcVRAW8JWF2k2jvm/2PzyhyqpTm9BhvWBqE9CUScc1cg
         ukkg==
X-Forwarded-Encrypted: i=1; AHgh+RqrQ1/LUsCsEdy3IzHpak31yvXS2VkujryWBlmUFU4ce7hd4TVT9AwREqBIQ1Wck0F8/PN2lDD13WtSfrfg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy46DkOoEEshFgRRvNzk7sU4ppVfTgpIc/JQlLwmPLvlkbVVwOH
	JQsvb6JT+Q1/wDxkHtFTlLbKS7akrtVV4wilU7kTTBhN4A6P1ztsUiN4Ua9JZQ==
X-Gm-Gg: AfdE7clN1SbVAvp8dJK+uNXHLrz+n8SdZHPJ6T4xI8K+8sWhlFCEeGsIy+/XYHp0nqp
	/ZxKUBJZ8lum5lev5xKi5mffPjPeU0H64C5P629+JBowgXUA2h+ceaUzEmoucM30now9YicRVo4
	JYBR/otTVMlYvrV10n4xdD4BtpY0lxsd3QX+PeITJTU+5WH03LJz2MayTdaXylvXqeDPvnMN7sb
	nLzk2vgWlsL7x5q2NLKGMC2jXb40KUZVWxHskXfcEK08uqDL71zOTzlhzq1egbKcnalHnSWpHae
	EdKhXKIsU+EZG62f0p75aTRXS3Rl+Toa0h9DN/MXQyJSdIn6zCe9RlTb1KzmqnXqnN0KB27ppzx
	MXJCvVRzQiJM9a+eE5KjDfEXQUlavdEM0ZZSOx+NjxI/5N6zy1h6E5LQlQQvG3TDSnCJWb+mZFN
	YTxr/eHb7o5tsHmb240Sm4o3YdQVHJ+W1az8HclLz4T+zBbkVBJb0lQrVAHqygGJy6h+q2ycawn
	XHsJYDFW4K1obhER8AwHErJJQ==
X-Received: by 2002:a05:6830:7002:b0:7e9:e82e:e683 with SMTP id 46e09a7af769-7eda08ab141mr11477690a34.7.1784667453210;
        Tue, 21 Jul 2026 13:57:33 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:32 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:07 -0600
Subject: [PATCH v7 18/29] lib/parser: add match_wildcard_hyphen() for
 agnostic matching
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-18-010fbe73b311@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=4222;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=cOvO6sx3YqLFd3U+lr49fTx42/CUMz8iaG20o06tc/Q=;
 b=omQ27F1Lj0I+8IXmB8JTu88Ef5LiDN+J0UVCbq+/MPKcMkHoSyEhHezbJpnSU+hYg3ip/fEgR
 mO3/oDXWNBOCjLYtJlHFX2MGwd1O38pZNZduH0FaAyqjqod07vIJjkT
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

This commit introduces match_wildcard_hyphen() as a variant of the
existing match_wildcard() function. It treats hyphens and underscores
as identical characters during the matching process.

This is necessary for subsystems like dynamic_debug that need to match
module names provided by users (who often use underscores) against
names stored in the kernel (which may use hyphens, especially when
using KBUILD_MODFILE for built-ins).

To avoid code duplication, the core logic is refactored into a private
__match_wildcard() function marked as __always_inline. This allows the
compiler to generate optimized versions for both the strict and agnostic
callsites with zero runtime overhead.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v5: move ahead of array-slice patch to silence sashiko complaint about it
v4: initial version
---
 include/linux/parser.h |  1 +
 lib/parser.c           | 58 +++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/include/linux/parser.h b/include/linux/parser.h
index dd79f45a37b8..a3cc7bc5fb93 100644
--- a/include/linux/parser.h
+++ b/include/linux/parser.h
@@ -34,6 +34,7 @@ int match_u64(substring_t *, u64 *result);
 int match_octal(substring_t *, int *result);
 int match_hex(substring_t *, int *result);
 bool match_wildcard(const char *pattern, const char *str);
+bool match_wildcard_hyphen(const char *pattern, const char *str);
 size_t match_strlcpy(char *, const substring_t *, size_t);
 char *match_strdup(const substring_t *);
 
diff --git a/lib/parser.c b/lib/parser.c
index 62da0ac0d438..d5be01fa9adf 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -268,20 +268,13 @@ int match_hex(substring_t *s, int *result)
 }
 EXPORT_SYMBOL(match_hex);
 
-/**
- * match_wildcard - parse if a string matches given wildcard pattern
- * @pattern: wildcard pattern
- * @str: the string to be parsed
- *
- * Description: Parse the string @str to check if matches wildcard
- * pattern @pattern. The pattern may contain two types of wildcards:
- *
- * * '*' - matches zero or more characters
- * * '?' - matches one character
- *
- * Return: If the @str matches the @pattern, return true, else return false.
- */
-bool match_wildcard(const char *pattern, const char *str)
+static inline char dash2underscore(char c)
+{
+	return (c == '-') ? '_' : c;
+}
+
+static __always_inline bool __match_wildcard(const char *pattern, const char *str,
+					     bool hyphen_agnostic)
 {
 	const char *s = str;
 	const char *p = pattern;
@@ -301,7 +294,9 @@ bool match_wildcard(const char *pattern, const char *str)
 			pattern = p;
 			break;
 		default:
-			if (*s == *p) {
+			if (hyphen_agnostic ?
+			    (dash2underscore(*s) == dash2underscore(*p)) :
+			    (*s == *p)) {
 				s++;
 				p++;
 			} else {
@@ -319,8 +314,41 @@ bool match_wildcard(const char *pattern, const char *str)
 		++p;
 	return !*p;
 }
+
+/**
+ * match_wildcard - parse if a string matches given wildcard pattern
+ * @pattern: wildcard pattern
+ * @str: the string to be parsed
+ *
+ * Description: Parse the string @str to check if matches wildcard
+ * pattern @pattern. The pattern may contain two types of wildcards:
+ *
+ * * '*' - matches zero or more characters
+ * * '?' - matches one character
+ *
+ * Return: If the @str matches the @pattern, return true, else return false.
+ */
+bool match_wildcard(const char *pattern, const char *str)
+{
+	return __match_wildcard(pattern, str, false);
+}
 EXPORT_SYMBOL(match_wildcard);
 
+/**
+ * match_wildcard_hyphen - parse if a string matches given wildcard pattern
+ * @pattern: wildcard pattern
+ * @str: the string to be parsed
+ *
+ * Description: Same as match_wildcard, but treats '-' and '_' as identical.
+ *
+ * Return: If the @str matches the @pattern, return true, else return false.
+ */
+bool match_wildcard_hyphen(const char *pattern, const char *str)
+{
+	return __match_wildcard(pattern, str, true);
+}
+EXPORT_SYMBOL(match_wildcard_hyphen);
+
 /**
  * match_strlcpy - Copy the characters from a substring_t to a sized buffer
  * @dest: where to copy to

-- 
2.55.0

