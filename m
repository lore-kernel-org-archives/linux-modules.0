Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054E03D812D
	for <linux-modules@vger.kernel.org>; Tue,  2 Jun 2026 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440561; cv=none; b=CFOOxyawjDwwlkWoIWH86mLkpNS+pqB7vTGzihPIuWZvE9CZfwL+H5xpAejIOvVzWxbO9T1hiCKf9RpMzWkmVCBdbWTlGNUu4H2GZ2Odu/QWX8jNdJl5WppnDysxjlhj6kBgypnS+ddHPEfBHZLPurWI6xzarocb14O5ABvXp0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440561; c=relaxed/simple;
	bh=mS8zYCuPveoKc7T4Im/jzVvP1HCLKypYVHp0g2j6Skw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQn2keFmziB97RsDhtMexvHz0pF8nqha/gaiJLE6B5ZY61jwHCwSF738bQbE9I0UKxpXjuNGzPIekqepGU6D5Qd7+aZ7O8wy6gw8WvjUoKeidPOjepg5YqEJUR0qKK+IwlpT/B6Sqn1TPUjjh5mn6fYyKzB9KJAyX6ihQyXF7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFsqdD53; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFsqdD53"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4600ddc4017so2536113f8f.0
        for <linux-modules@vger.kernel.org>; Tue, 02 Jun 2026 15:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440558; x=1781045358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNu2VyRhrQI8zsAEpIkLCzKPvvxJoe9LgPS0NWOwvYU=;
        b=qFsqdD53t5NGf40QWrX0VJm44bJkQvgEQrlqBu6+91KE8LYiZoTL8Yn34JnWaSU4qv
         zeanv5V4qQkF3qQyYXPwmmiN4bHaUkDBxeBQKl/E6npWCLzbOC4ZP+JSj3cEgXLOy/Zx
         XraVuDxKJlCIQ7415hlry2sG9FFqXvdikpdDbeELfUfwWMotTG0nMlDWYARIt+4KWFMt
         qlWYN3VFI2jXusrcncPe5oLwAK0fos9EGax4TBEP5YhlFTAhimLJxQXzDA7Ez06Av8Yf
         kYR/tW0RK94QluNL2LPgSkTrpZ7WyfQ/Cth9hDCpUp/OvLJ+m2lE0W2LxOBkOFf5smyv
         QI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440558; x=1781045358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FNu2VyRhrQI8zsAEpIkLCzKPvvxJoe9LgPS0NWOwvYU=;
        b=oPLsstFsvd0rijfOig13r6yHXHEF08Ni/URmQ1APFQ5vKFeFcUEMkZPwEaAQwQunQt
         2xQFYbvVMq+dRnlSJ7fni/rV3t69N6MrtdjTsQ6YK0FpSPVpspm/CsCXN+OZ9O6PvlyE
         5hBELUtmFCiymLx6mhihB+jSFe+fAKUajEZCg2sfuGClz4iASYioZolVcLebQYA2SPN+
         5q5WxBxhCTRB5VXCOD9U/i66dy1dJ9Xlp6faPd74vp0IIKWDDyVpjeSkc8chFnW0MOwz
         t2IbzbpsQex+ohUrZ5uC2sv+ldZuSfCddGZ28pak7j4VBwZIR6HcBR5BUcC1GiRtJdX/
         eB3g==
X-Forwarded-Encrypted: i=1; AFNElJ+gjuhoWuyrobgntd/Mt11qC+wBQqBkzTFscqAi6frTV36BbRb5VgM5f9KqFCQviuMeZ8pH9guKCHtgiw77@vger.kernel.org
X-Gm-Message-State: AOJu0YzxeujRp7cJOXGn4gii6UoKaPG1G5Qc3a5Wp/enMZaG58DIkksh
	zHC7nQ4LOOAsx1RudJlGadCSkpCL40F6e9eiiXbhzgHkFmSMU2arG2gL
X-Gm-Gg: Acq92OH168+AahYSZ+Rn1fCH6wRgWwbjgT4t/TBsOFl1h6Je50pc9Wx+OciqQAW9wly
	aOJbnEWVuBTCa+VobryyJhF2e7elmlxVok8XPVF/nEBEvAWPGBJ8fmWaLZDD3q0sfKe5fb0wyII
	zY3O7gxRNvpPqwAhndhSeU3Q+Kl1rXT260Q8moyyg0i6A8o7QoXcDkpBewxXLseKASkej6dYd/R
	vNkIUNS/e30xi1CB2bjVhlMOk8B0bt1Sa9Q0TshdB3n6evDIcYAtbOX7G3sFvK/iTJjvJGeIRc/
	TlRTLPIEC6zPz0BcpPGNjfZh99mmwFCn31p+sILIBAF9YCCOG8578Tc3zsDY1iDAimjTwpvsXBu
	d40nkbvtsBz2QIOErNi8hadGCLUppoSjYA4y92i0jji+LieyPwrK4RR3BuarMHVxyaUF/oPNy+0
	Abe0Yyr0UJ8jGWCmE+S06/ecbySvhtfoDNu31lIiCsXg==
X-Received: by 2002:a5d:44d2:0:b0:45e:651c:47bb with SMTP id ffacd0b85a97d-460218513b2mr497138f8f.28.1780440558379;
        Tue, 02 Jun 2026 15:49:18 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:49:17 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:21 +0000
Subject: [PATCH v4 24/25] lib/parser: add match_wildcard_hyphen() for
 agnostic matching
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-24-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=4121;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=mS8zYCuPveoKc7T4Im/jzVvP1HCLKypYVHp0g2j6Skw=;
 b=VXb9s6BILwbRYg9yQV7eipRGBEsG95GCuf6QT72hEVacy+qZBYi7X8O5FuSb5Iz5M4W1FDq67
 p9yjueJ/OsVCVSt5ROCmYhB9K2zwhc/6uV7MVoRWpT2QeQ8U6P+qRVG
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
2.54.0

