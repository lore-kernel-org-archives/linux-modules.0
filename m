Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B8A19A286
	for <linux-modules@vger.kernel.org>; Mon, 17 Jun 2024 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647133; cv=none; b=pnSQ6S2v5JsqBDhYozQVzvM95VELjPRPiAhBsvG8qwX6qFvJDdNDQ+b2kj93TCHMuV987FccmBqxdhp9wpeDFQ9BY/XyMNZ1ZTE5CEStEXog4GIyFpMVvac3wPOq0dCXxjroAwfhjnkak+RQ0ovBtR7xe8cWdq7jzleul76tDes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647133; c=relaxed/simple;
	bh=qxjnDPhbkT2bqk3JUgXG+OMT2L0q9TuqyeH9xgQXlZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fuSDumGWKOcMD9GkoRFX15fIgQNqeF8ZSV5UHPzVG6wcj+eukr/EWtN9GEyrdzWZQIWUfKEH0+PlPcLcStrtam8syRwm6ZSWhWd7tNnt725PeQ3XrISpdVNvqjzx5j1mtmqLi99vfgK4V1RIOTkYiITNhX12s03W/oSAWd4VIfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ntve6mM6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ntve6mM6"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-631b498f981so66798037b3.0
        for <linux-modules@vger.kernel.org>; Mon, 17 Jun 2024 10:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718647130; x=1719251930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FepdhZeTk2P/UGpz1yHjDkWXnUR5Ic7EpV5t8vA3VJ8=;
        b=Ntve6mM6DKbaoATCL/7rMMqKbS9RdvB9UiL/y3A3x3g0guz27tUYPP8v5pFjwjQ0Le
         X2SfN8OMi80AMvct+25h3aXEXiNgkl49ZzSBD5zMWU5tef8xdOxr7E82rWpOTGj90of+
         uSD6IaLzoa9In3pCqBjrYBPldTfG3+FEHgArJ8dk3NzpRtQZGnqHl0CyVvNXDzoi93tL
         zXerhRSEUfiaO2aEtmsntV7ZEXdUiQ77hTjOvKvYFBH1VW0vzMHnV5444J3A928kzmmU
         p7qltGWrgmjeR77D4Yc/MqPP3CGGM9WOHZgB4uu8SiR78Xl11lHDTaWCql62P91C8Kbn
         fKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647130; x=1719251930;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FepdhZeTk2P/UGpz1yHjDkWXnUR5Ic7EpV5t8vA3VJ8=;
        b=R/L/e64DS0y0DTqhIQgB1q5oz3mSDA5Mip8cGWGmYjLkh1mrDBr/2TtK03U4UAOdle
         qfIzC/yi1eg0xLLojzbuT3bUDJeevkwnW4s7EVi2j/ukGL0NEGdrCs+bi46lqv0oLRVs
         WrR8zthpsRvcPObQcIi3amMdrfpi1yjf5HeqEOW9UuWxJHK/AqErNOVUzrzw9H0XZks9
         MjbaDaZT2QDwOtXtoIGMxBVoZ2o4UR1Izz9FySPiPkZ23o2nwa1DkSrXVycvG1ArwMHe
         EPq3Yo2WZ0veeV8TYjQ7ruoqcyUa4eAUzuujUpfT6+I+FW6IvlOFmsa/c2pZ+NL+SnZy
         fnSw==
X-Forwarded-Encrypted: i=1; AJvYcCXtL1VJSWphO5WME6Q+/89hhFoYmFfraSJ2tlS6PTW6fg3ZB1/2VC5xahJeWcGfykQ8Lzrc7pfW+4kyH1oe3u2NK1+JGnBxZ850bZClZQ==
X-Gm-Message-State: AOJu0Yy+w6yir8UVpKiS+RW3VHQCCpKzpS4ekwu3PXIBNxTFPz0ZgtiS
	l1TsoqEfL1rQUGo0BWwW8y9RuyNtLIIA7CpJeC7GIQ6h07/par7KmX2fVNsqVfk3Zwos1xGVszz
	VmT7x2ZjgHDUTHqeWmk44dqUzLg==
X-Google-Smtp-Source: AGHT+IEKWMn41cQguv0qNaedPOXvzvvCPGUBW2Ai4IEXCZr+AQfjcwobN3pE2EUdIwaI2VHKh5POsClBLW5Uwl1z0o0=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a05:690c:4a0f:b0:62c:de05:5a78 with
 SMTP id 00721157ae682-6322402cc6cmr27980207b3.6.1718647130513; Mon, 17 Jun
 2024 10:58:50 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:58:33 +0000
In-Reply-To: <20240617175818.58219-17-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240617175818.58219-17-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2620; i=samitolvanen@google.com;
 h=from:subject; bh=qxjnDPhbkT2bqk3JUgXG+OMT2L0q9TuqyeH9xgQXlZY=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBmcHk8BkgxPBOcTFd109aXG7GZv2GPe3nQuIQTV
 +Ps+2NQwXmJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZnB5PAAKCRBMtfaEi7xW
 7jz9C/4irEUBFYs+I2aOmFliiJGDZqYDERdlWQJY/S2Kbp2uY4rgt0ooq54+mWm/RT29dZRw1qu
 wzZiFq3yJ5kfWTI7Em5p8rOwLLsAlr8cATc+M//wemnhZOM4pYjVxleLdFdht0Smp1bVohtkM2Y
 6x+zf+KwjcDE2nYxWr8hqpjFF6idGlQnuBq47MhzEJaSmyy1WJjtqddvn3gxNCaBcwcBv4Vnp4Q
 fyDZHNKoqZGdfiwqWKvgOynjGMAotjb3BvoI9d9AkP/qR3F1pN7IFWM6xgqCDeGCaDl9Eu68/rQ
 kbPtux6ew2Ox0cVDiVjQOLDnxLOHyDgFsK2a9JCSJaJzMxyugaZIRPpv7fyLYrsK/hCI/y0q+GM
 uKT5ReLVoA31RS7SnoKjUGgYi0DOUw+OIuPcX5qP11TCp4+Y8hrnzAXxNy6zByYL3wJujL5fTCV 7m+q7O8nwVMrXXoKTpARpZ4LqG+8Ui3OUm+s92JY1f3ZicqYMkl4sJUtTMrAc9Q799oLY=
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240617175818.58219-31-samitolvanen@google.com>
Subject: [PATCH 14/15] module: Support hashed symbol names when checking modversions
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

When checking modversions for symbol names longer than MODULE_NAME_LEN,
look for the hashed symbol name instead. This is needed for Rust modules,
which frequently use symbol names longer than the maximum length
supported by struct modversion_info.

Suggested-by: Matthew Maurer <mmaurer@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/module/version.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/kernel/module/version.c b/kernel/module/version.c
index 53f43ac5a73e..0b33ca085138 100644
--- a/kernel/module/version.c
+++ b/kernel/module/version.c
@@ -8,8 +8,36 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/printk.h>
+#include <crypto/sha2.h>
 #include "internal.h"
 
+/*
+ * For symbol names longer than MODULE_NAME_LEN, the version table includes
+ * a hash of the symbol name in the following format:
+ *
+ * <hash name>\0<binary hash of the symbol name>
+ */
+#define SYMHASH_PREFIX		"sha256"
+#define SYMHASH_PREFIX_LEN	sizeof(SYMHASH_PREFIX) /* includes \0 */
+#define SYMHASH_LEN		(SYMHASH_PREFIX_LEN + SHA256_DIGEST_SIZE)
+
+static void symhash(const char *name, size_t len, u8 hash[SYMHASH_LEN])
+{
+	memcpy(hash, SYMHASH_PREFIX, SYMHASH_PREFIX_LEN);
+	sha256(name, len, &hash[SYMHASH_PREFIX_LEN]);
+}
+
+static int symcmp(const char *version_name, const char *name, size_t len,
+		  const u8 *hash)
+{
+	BUILD_BUG_ON(SYMHASH_LEN > MODULE_NAME_LEN);
+
+	if (len >= MODULE_NAME_LEN)
+		return memcmp(version_name, hash, SYMHASH_LEN);
+
+	return strcmp(version_name, name);
+}
+
 int check_version(const struct load_info *info,
 		  const char *symname,
 			 struct module *mod,
@@ -19,6 +47,8 @@ int check_version(const struct load_info *info,
 	unsigned int versindex = info->index.vers;
 	unsigned int i, num_versions;
 	struct modversion_info *versions;
+	u8 hash[SYMHASH_LEN];
+	size_t len;
 
 	/* Exporting module didn't supply crcs?  OK, we're already tainted. */
 	if (!crc)
@@ -32,10 +62,16 @@ int check_version(const struct load_info *info,
 	num_versions = sechdrs[versindex].sh_size
 		/ sizeof(struct modversion_info);
 
+	len = strlen(symname);
+
+	/* For symbols with a long name, use the hash format. */
+	if (len >= MODULE_NAME_LEN)
+		symhash(symname, len, hash);
+
 	for (i = 0; i < num_versions; i++) {
 		u32 crcval;
 
-		if (strcmp(versions[i].name, symname) != 0)
+		if (symcmp(versions[i].name, symname, len, hash) != 0)
 			continue;
 
 		crcval = *crc;
-- 
2.45.2.627.g7a2c4fd464-goog

