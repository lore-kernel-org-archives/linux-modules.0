Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9551AC8AC
	for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307584; cv=none; b=R4KtyfcafKQPhRlbSU5KvteG++Y89gjbk8o0oDV5mMswLbCXDL+bFCNyVbSV5dcbUVBHEdvIgWkM3JiMYTUCkB17H3fJMO2sGVoB0lZt7VLEkHBuVDVaCGpxV961s+Rr3GfPsDL1wD+DmPzfNOG7+BWfej91mEQK7itsMzL4ucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307584; c=relaxed/simple;
	bh=uwfaf/NAzm+40ipxYEoBkkFYyfKzhKmnZzjM3YJU8lE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ByBUyeWxdFnPegb5qS/btQner/G+MAu1UTjTbHLYRVXjNPJJWhH/xwAGPQ8HDdA/6X07r+oRqRCbMhPNXMfqt9bPR8jbXLNJ0KSRPddxjfigVhSht4VLVT2Yy630N/gYB6oo09Dc5RH+FRXZt2t8m/eckL96wP9O0ugKa9AwK2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dnn4lcx6; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dnn4lcx6"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159fb161fso624223276.1
        for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 16:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307582; x=1727912382; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tc4NXPfplG38lAGlz62WMnJTBJMM1sboCG51BTx1YyI=;
        b=Dnn4lcx6ETC3b56/fMVL5Sowje5BnLypRNCI6y7V/UppV+ykNC/QI9yXrPLZa4MZDt
         IiHnuatUNziMF/+SokFMxI0gK60XEbhHCBIUJk6S/fo1t/1cq++ylzYyVRuLE9Nh1qfU
         v2AibX5noO2NCGTeCsNF7VFL8XgWV4/+kWp8VSXbVFom43FlVRqHkSHr9uKSyEh5DFL5
         y2dhTc823caiGsStgcaR3298Pw1aegvPXvVBHk+4CYlTHMqbdoyv1fwD3aIFipfMDUcU
         5o31nY4/exqQ5P3Bpj7AO0SDYu6DhamliBw7OMpApYnlI43yFEggoO8VVNhZP9eWf7kJ
         9XjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307582; x=1727912382;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tc4NXPfplG38lAGlz62WMnJTBJMM1sboCG51BTx1YyI=;
        b=veNG9DB47agRD4cY2ra7zza+JBRX1gB9XoxCori3Rk893gF1I/mRTL8us/mad5ziyO
         BQYXBtpbR2lKlebyH2O04L86ZNrYBknplZw4vBOhNXYYoiKw6/SZ8rS6x0FfjYftvi1Z
         ATaffbQU6Pi3yEc7eUwt4RoPvTgQpyApZGyiZk8XTHJOQJiAvP7CLvvFwaTiT0dvSBoC
         I9tpHTy+GNGddm6fXp+HDCJ6abIFpuayhJQiOyjloY3AktTpOfq5U5uJLybj/KXcHGBE
         dd25c4VsbeodX38dKkhhJiSDMkWNcrwcFvT6/wWOQGYxQdNWiqrz/b+pySgoLf8Yj3iX
         UEYw==
X-Forwarded-Encrypted: i=1; AJvYcCXFJN2no6/utvirVbCSsUl9Iz6kIgZQjl92KVB6JMBZ3iSowc8uj2kKnip0bOSJV2YM7cezIMpI7f10/6r+@vger.kernel.org
X-Gm-Message-State: AOJu0YyU1rZ91KlI9sZOQyVlsUrQPATxZv+xoP3+1s2yuiNrP+rZdTND
	0ef7A7lgwiYbOCLtyqJyEkLy4/O4vbTRU3KhcCSGUm92xOUgZpin9bhk4TqPr5PEkNzNIS1cRAA
	66fwwhQ==
X-Google-Smtp-Source: AGHT+IF+swNEdiAvpBogXsgKrBiSvXnXm1t/O+Acxf832i2L6CrfB3YUi3r7S2mXXta4Ea8IRO3aupfjGYBp
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:1367:b0:e1a:22d5:d9eb with SMTP
 id 3f1490d57ef6-e24d716247fmr3341276.1.1727307582039; Wed, 25 Sep 2024
 16:39:42 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:38:24 +0000
In-Reply-To: <20240925233854.90072-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240925233854.90072-10-mmaurer@google.com>
Subject: [PATCH v5 09/16] module: Group section index calculations together
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, linux-modules@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"

Group all the index detection together to make the parent function
easier to read.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 68 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 43140475aac0..e04a228c694a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2039,6 +2039,56 @@ static int elf_validity_cache_index_str(struct load_info *info)
 	return 0;
 }
 
+/**
+ * elf_validity_cache_index() - Resolve, validate, cache section indices
+ * @info:  Load info to read from and update.
+ *         &load_info->sechdrs and &load_info->secstrings must be populated.
+ * @flags: Load flags, relevant to suppress version loading, see
+ *         uapi/linux/module.h
+ *
+ * Populates &load_info->index, validating as it goes.
+ * See child functions for per-field validation:
+ *
+ * * elf_validity_cache_index_info()
+ * * elf_validity_cache_index_mod()
+ * * elf_validity_cache_index_sym()
+ * * elf_validity_cache_index_str()
+ *
+ * If versioning is not suppressed via flags, load the version index from
+ * a section called "__versions" with no validation.
+ *
+ * If CONFIG_SMP is enabled, load the percpu section by name with no
+ * validation.
+ *
+ * Return: 0 on success, negative error code if an index failed validation.
+ */
+static int elf_validity_cache_index(struct load_info *info, int flags)
+{
+	int err;
+
+	err = elf_validity_cache_index_info(info);
+	if (err < 0)
+		return err;
+	err = elf_validity_cache_index_mod(info);
+	if (err < 0)
+		return err;
+	err = elf_validity_cache_index_sym(info);
+	if (err < 0)
+		return err;
+	err = elf_validity_cache_index_str(info);
+	if (err < 0)
+		return err;
+
+	if (flags & MODULE_INIT_IGNORE_MODVERSIONS)
+		info->index.vers = 0; /* Pretend no __versions section! */
+	else
+		info->index.vers = find_sec(info, "__versions");
+
+	info->index.pcpu = find_pcpusec(info);
+
+	return 0;
+}
+
 /*
  * Check userspace passed ELF module against our expectations, and cache
  * useful variables for further processing as we go.
@@ -2069,16 +2119,7 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	err = elf_validity_cache_secstrings(info);
 	if (err < 0)
 		return err;
-	err = elf_validity_cache_index_info(info);
-	if (err < 0)
-		return err;
-	err = elf_validity_cache_index_mod(info);
-	if (err < 0)
-		return err;
-	err = elf_validity_cache_index_sym(info);
-	if (err < 0)
-		return err;
-	err = elf_validity_cache_index_str(info);
+	err = elf_validity_cache_index(info, flags);
 	if (err < 0)
 		return err;
 
@@ -2095,13 +2136,6 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	if (!info->name)
 		info->name = info->mod->name;
 
-	if (flags & MODULE_INIT_IGNORE_MODVERSIONS)
-		info->index.vers = 0; /* Pretend no __versions section! */
-	else
-		info->index.vers = find_sec(info, "__versions");
-
-	info->index.pcpu = find_pcpusec(info);
-
 	return 0;
 }
 
-- 
2.46.1.824.gd892dcdcdd-goog

