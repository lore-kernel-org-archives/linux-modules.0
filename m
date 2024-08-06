Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B711717334E
	for <linux-modules@vger.kernel.org>; Tue,  6 Aug 2024 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979281; cv=none; b=GFUnNYMFEJGZOrXdJU8vQbUo4UiIbaf5bZGXAcYy5degFLkCOGUaX9OUqhwDgRkbnJmx6Ro5amuwCScz4CGbSV9BTfjrVzyOwPNcrx/K9L47zw8eRxxxqNRD1Wfd2Xb/g/B13un3z1DX+PsAzNnfiuWd7y/aWfMryt32Zjcdp00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979281; c=relaxed/simple;
	bh=4E3+yqfPZ/EBjg1eFYj7cU9eN58K80vEwUneq+XxFn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KNDG5HT+g4dhaSi9QS/Y5jogZQU1P0lEJzJC4Z6xTZQl2zxBVBdVz7cabMC2rsucj4qs2Kx0JbMcOMSY1seAIalHC9UeM5sSQNZ2yXMPcOycp0MuTpMF/LwbUkkL75AqirUNMX7qInpNAVZjgTqH3o94TKte0wTaqlmKGUHIClA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=abKFV/KQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="abKFV/KQ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66628e9ec89so25176847b3.1
        for <linux-modules@vger.kernel.org>; Tue, 06 Aug 2024 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722979279; x=1723584079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LHlE/ML+MCLjX3kG65evZzMkMroBjJFNmRaVRMV6Lgg=;
        b=abKFV/KQGWyKxuN54FnqHVJS2pMIzFrZq/tZaeESQkrEgRKULp6UHccJS82T1SA62t
         6wifCSSJhB0VFDIGjgRCxBE1S+qhdrb2YeH+W5JzKxeT1s2aHPp4zMDdkU8RYD3L19zx
         QvWUDmMp57nL8vMPIF/CTl8eUqotLz8v+h3zKdvlbVVLsbaxVCvooFqx2/Rk/6mvuMP1
         JbvGPXesxUIYIN4ZI+Yatyr5qVmG27dFmOzp/YjUu8zVk188pjyia56Cw2W6gsCmWv1j
         DulAt9wosw7xqq4UOGNwl8YdjttrFMRCZdgyfzQPDCcSp4YRcw0D6Mj/fbavqsuhKMrf
         7HSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979279; x=1723584079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHlE/ML+MCLjX3kG65evZzMkMroBjJFNmRaVRMV6Lgg=;
        b=dlNo1jTqR5hi43adCXloYu+jREwZDdJ1o1h82je9QTGUzjtjzhr9QzGQWgqaoA8vvu
         WfzOSeMYcR9gi1c8T9azRiTV8otsnLtedhRWiPYcjGKaB5oHifOWY79T8svSw87s+2gP
         yHSyoKkSJmvxro58+pnTTPJ8grrWOm/WLyWQxGGSTiwDdKmVVRqiuJu/tgdybSeNl2Mb
         4ixCQ889QppxGhdwOG1vZntxBu8VMZzqpdHy4WkmZnAMSTTdwOmj/flusGJT5SaQDXSD
         lsGyTeehloVk5Eoy0XHq9DASZ/32i67AaN2WJ/zHsKE7jD6PB/+Xcuc5D61j7v0HfU7E
         h8EA==
X-Forwarded-Encrypted: i=1; AJvYcCX5rwg+GYdp/WdQdlZQ5RbxoxxvXRI+76mX3BtFj2VeO2IJILiGdU5bZ/CqsOL1Q1iShMIA5dFL4OJOq86hWgczGLzS5e1v8xlAwnSCpw==
X-Gm-Message-State: AOJu0YyTLQzNKXbX33Q6cIcAK4vOprDkpS3Zlp34shViCj620f/TBo0V
	8axLv875H2rZhfOkyQZGxMTxhQRZtlpSVQNh2MMpF+ckNU1HQu0BPbj58Nh/b3Zyee2/2l5TqDq
	SOX+GeQ==
X-Google-Smtp-Source: AGHT+IHs8BjEFP03/hjkSlIFZUQ8Ej9UCuITL4bX8GerqO4z8Xhbdq0f/kQGsTvhAsALlLcsV8i31UDjpw7A
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:289:b0:681:8b2d:81ae with SMTP id
 00721157ae682-68964d4d4cemr6090117b3.9.1722979278870; Tue, 06 Aug 2024
 14:21:18 -0700 (PDT)
Date: Tue,  6 Aug 2024 21:20:30 +0000
In-Reply-To: <20240806212106.617164-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806212106.617164-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806212106.617164-5-mmaurer@google.com>
Subject: [PATCH v3 04/16] module: Factor out elf_validity_cache_secstrings
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, neal@gompa.dev, 
	marcan@marcan.st, j@jannau.net, asahi@lists.linux.dev, 
	Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Factor out the validation of section names.

There are two behavioral changes:

1. Previously, we did not validate non-SHF_ALLOC sections.
   This may have once been safe, as find_sec skips non-SHF_ALLOC
   sections, but find_any_sec, which will be used to load BTF if that is
   enabled, ignores the SHF_ALLOC flag. Since there's no need to support
   invalid section names, validate all of them, not just SHF_ALLOC
   sections.
2. Section names were validated *after* accessing them for the purposes
   of detecting ".modinfo" and ".gnu.linkonce.this_module". They are now
   checked prior to the access, which could avoid bad accesses with
   malformed modules.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 106 ++++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 37 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index c480fd33861a..252cfa9eee67 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1789,6 +1789,71 @@ static int elf_validity_cache_sechdrs(struct load_info *info)
 	return 0;
 }
 
+/**
+ * elf_validity_cache_secstrings() - Caches section names if valid
+ * @info: Load info to cache section names from. Must have valid sechdrs.
+ *
+ * Specifically checks:
+ *
+ * * Section name table index is inbounds of section headers
+ * * Section name table is not empty
+ * * Section name table is NUL terminated
+ * * All section name offsets are inbounds of the section
+ *
+ * Then updates @info with a &load_info->secstrings pointer if valid.
+ *
+ * Return: %0 if valid, negative error code if validation failed.
+ */
+static int elf_validity_cache_secstrings(struct load_info *info)
+{
+	Elf_Shdr *strhdr, *shdr;
+	char *secstrings;
+	int i;
+
+	/*
+	 * Verify if the section name table index is valid.
+	 */
+	if (info->hdr->e_shstrndx == SHN_UNDEF
+	    || info->hdr->e_shstrndx >= info->hdr->e_shnum) {
+		pr_err("Invalid ELF section name index: %d || e_shstrndx (%d) >= e_shnum (%d)\n",
+		       info->hdr->e_shstrndx, info->hdr->e_shstrndx,
+		       info->hdr->e_shnum);
+		return -ENOEXEC;
+	}
+
+	strhdr = &info->sechdrs[info->hdr->e_shstrndx];
+
+	/*
+	 * The section name table must be NUL-terminated, as required
+	 * by the spec. This makes strcmp and pr_* calls that access
+	 * strings in the section safe.
+	 */
+	secstrings = (void *)info->hdr + strhdr->sh_offset;
+	if (strhdr->sh_size == 0) {
+		pr_err("empty section name table\n");
+		return -ENOEXEC;
+	}
+	if (secstrings[strhdr->sh_size - 1] != '\0') {
+		pr_err("ELF Spec violation: section name table isn't null terminated\n");
+		return -ENOEXEC;
+	}
+
+	for (i = 0; i < info->hdr->e_shnum; i++) {
+		shdr = &info->sechdrs[i];
+		/* SHT_NULL means sh_name has an undefined value */
+		if (shdr->sh_type == SHT_NULL)
+			continue;
+		if (shdr->sh_name >= strhdr->sh_size) {
+			pr_err("Invalid ELF section name in module (section %u type %u)\n",
+			       i, shdr->sh_type);
+			return -ENOEXEC;
+		}
+	}
+
+	info->secstrings = secstrings;
+	return 0;
+}
+
 /*
  * Check userspace passed ELF module against our expectations, and cache
  * useful variables for further processing as we go.
@@ -1812,7 +1877,7 @@ static int elf_validity_cache_sechdrs(struct load_info *info)
 static int elf_validity_cache_copy(struct load_info *info, int flags)
 {
 	unsigned int i;
-	Elf_Shdr *shdr, *strhdr;
+	Elf_Shdr *shdr;
 	int err;
 	unsigned int num_mod_secs = 0, mod_idx;
 	unsigned int num_info_secs = 0, info_idx;
@@ -1821,34 +1886,9 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	err = elf_validity_cache_sechdrs(info);
 	if (err < 0)
 		return err;
-
-	/*
-	 * Verify if the section name table index is valid.
-	 */
-	if (info->hdr->e_shstrndx == SHN_UNDEF
-	    || info->hdr->e_shstrndx >= info->hdr->e_shnum) {
-		pr_err("Invalid ELF section name index: %d || e_shstrndx (%d) >= e_shnum (%d)\n",
-		       info->hdr->e_shstrndx, info->hdr->e_shstrndx,
-		       info->hdr->e_shnum);
-		goto no_exec;
-	}
-
-	strhdr = &info->sechdrs[info->hdr->e_shstrndx];
-
-	/*
-	 * The section name table must be NUL-terminated, as required
-	 * by the spec. This makes strcmp and pr_* calls that access
-	 * strings in the section safe.
-	 */
-	info->secstrings = (void *)info->hdr + strhdr->sh_offset;
-	if (strhdr->sh_size == 0) {
-		pr_err("empty section name table\n");
-		goto no_exec;
-	}
-	if (info->secstrings[strhdr->sh_size - 1] != '\0') {
-		pr_err("ELF Spec violation: section name table isn't null terminated\n");
-		goto no_exec;
-	}
+	err = elf_validity_cache_secstrings(info);
+	if (err < 0)
+		return err;
 
 	for (i = 1; i < info->hdr->e_shnum; i++) {
 		shdr = &info->sechdrs[i];
@@ -1877,14 +1917,6 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 				num_info_secs++;
 				info_idx = i;
 			}
-
-			if (shdr->sh_flags & SHF_ALLOC) {
-				if (shdr->sh_name >= strhdr->sh_size) {
-					pr_err("Invalid ELF section name in module (section %u type %u)\n",
-					       i, shdr->sh_type);
-					return -ENOEXEC;
-				}
-			}
 			break;
 		}
 	}
-- 
2.46.0.rc2.264.g509ed76dc8-goog

