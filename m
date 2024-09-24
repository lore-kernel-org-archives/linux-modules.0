Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559FC1ACE0B
	for <linux-modules@vger.kernel.org>; Tue, 24 Sep 2024 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212848; cv=none; b=CbR18yYH5Fk1yhpBvNB8gcMaPVSq1CqS3fEmX7ogdIsMlxUE/qn3+Of7fb+NhyCaa53Ujv4SUPykB1PwoUiSSRW7mqn3BMlRjOX2MYO86cVVWaGlOsdemYLXfPytTKAcQ18AzOayqytfqlQO0Xhybv6O/jpTYcDy3uFvS4wh700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212848; c=relaxed/simple;
	bh=hPcayIG4Zzk7TfnQCe5VB/OkeMCLVNaFCb22SLuD7xA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UsjsKhhlhQGb5izbzvXyXOX9C+zmS3B1FzI5JEYeoizi8lfmedlDTq1BrngW+sB/83WUQKHuJltlroiXkFOByUi1+bLSLjveoEQRsRR8iFdOyJ8qnZje7eKRmlsrlDKnlvGJMlVt353E8VJCPaXfaV0aJ/OTrpxvkG6uMsQY38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YFA4vnhG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFA4vnhG"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1da662315aso9022303276.3
        for <linux-modules@vger.kernel.org>; Tue, 24 Sep 2024 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727212846; x=1727817646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0kXAOzmEEQHXzTmLkL/vEUOj2egGiISa865No2odHA=;
        b=YFA4vnhG7v3wBEtJRSWPxljSAzlMN9QnEngViZVnd5PDdLWNLb0TIe1vq+uOBLMt8Z
         kcQ7DwG5Ba47eaBGIw1UZM4yGCOj9NPz30vGbA7kybcrY7ORgrAG+cKVXxTt9f6Dqebh
         bXTzpQTWhjRCqF2t9rBT+Svoe0/FMXIyGwoFI77fUqOKfiMqUrrT3kkuX5gZ8EUuZ3hA
         KF0AmhvkGLN9nxAKwWTdM/1OajsPW5z3fobqzK6IV7ZgUeiGIKlll6wbmTVfT4kTGbQD
         XI0Q0BcbBcryqiuPJRNeH/EY2aBAwoEGIRPuvshu477qzEZAzOf4IjYJe9Gd7hm0kSM2
         c9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727212846; x=1727817646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0kXAOzmEEQHXzTmLkL/vEUOj2egGiISa865No2odHA=;
        b=K3blx3Sn0G62/y+aBdUV9RPiGJ+F29p2RCHFD/I+VLKuWk0sQlKkWlefgS6TodXbSA
         5wucMrPuT4ryvjungabJrElBhzRnzyoWO1isjSQzoMyZya43e1VzCU6BLBmjzDm/zVkA
         Q5FDPwU1oimo9RAX82CanPZnZhPthp4D4V0oR2RJO+S9js9kFPXfEN0dCry1uqZsi/Xu
         uj3T3KtTHcLdGwVh9iJg0/jqGbgmgQ9EcTxuWMeOVZuYzrwc4sGpRw+MVoqs+pcfiEOd
         gawLZSet9UvuTtInrkrM/dpQpYkq6W0r7+jHfVFRX+qrDiWNAJrpabW5sA25y5gtjY2f
         tn3A==
X-Forwarded-Encrypted: i=1; AJvYcCWtxCBUmjedIM6W463+2ZSSIWbgqswoJYwSVbjttiZwTSS3qIhYX9ZU7+rXD4rjjISHYKWWWFw63squThux@vger.kernel.org
X-Gm-Message-State: AOJu0YylPgoTXFsJ1r9SWvYc0acDSISVp74wkuupge7mPb0qoSC0u1tk
	3n+QhoiU5/awN+Ep1iZVseugHoBEDCUYhkivhRpuspWK8BqMkOuBVnuk7SHjpiQ/GxqqyH0r/c4
	0MHMw4g==
X-Google-Smtp-Source: AGHT+IHDISpnfdzBaOTWR8C0ioj3uPYVqLGAlaWzdMvCzf+f+r+0H0cGN2cqc+XvC1wkkQdhXDCIGGe8xEvv
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:d608:0:b0:e0b:ab63:b9c8 with SMTP id
 3f1490d57ef6-e24da399c47mr364276.11.1727212846139; Tue, 24 Sep 2024 14:20:46
 -0700 (PDT)
Date: Tue, 24 Sep 2024 21:19:49 +0000
In-Reply-To: <20240924212024.540574-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924212024.540574-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240924212024.540574-8-mmaurer@google.com>
Subject: [PATCH v4 07/16] module: Factor out elf_validity_cache_index_sym
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Centralize symbol table detection and property validation.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 73 ++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index ec638187ffcf..6be58b0a6468 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1980,6 +1980,39 @@ static int elf_validity_cache_index_mod(struct load_info *info)
 	return 0;
 }
 
+/**
+ * elf_validity_cache_index_sym() - Validate and cache symtab index
+ * @info: Load info to cache symtab index in.
+ *        Must have &load_info->sechdrs and &load_info->secstrings populated.
+ *
+ * Checks that there is exactly one symbol table, then caches its index in
+ * &load_info->index.sym.
+ *
+ * Return: %0 if valid, %-ENOEXEC on failure.
+ */
+static int elf_validity_cache_index_sym(struct load_info *info)
+{
+	unsigned int sym_idx;
+	unsigned int num_sym_secs = 0;
+	int i;
+
+	for (i = 1; i < info->hdr->e_shnum; i++) {
+		if (info->sechdrs[i].sh_type == SHT_SYMTAB) {
+			num_sym_secs++;
+			sym_idx = i;
+		}
+	}
+
+	if (num_sym_secs != 1) {
+		pr_warn("%s: module has no symbols (stripped?)\n",
+			info->name ?: "(missing .modinfo section or name field)");
+		return -ENOEXEC;
+	}
+
+	info->index.sym = sym_idx;
+
+	return 0;
+}
 
 /*
  * Check userspace passed ELF module against our expectations, and cache
@@ -2003,10 +2036,8 @@ static int elf_validity_cache_index_mod(struct load_info *info)
  */
 static int elf_validity_cache_copy(struct load_info *info, int flags)
 {
-	unsigned int i;
-	Elf_Shdr *shdr;
 	int err;
-	unsigned int num_sym_secs = 0, sym_idx;
+	int str_idx;
 
 	err = elf_validity_cache_sechdrs(info);
 	if (err < 0)
@@ -2018,34 +2049,21 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	if (err < 0)
 		return err;
 	err = elf_validity_cache_index_mod(info);
+	if (err < 0)
+		return err;
+	err = elf_validity_cache_index_sym(info);
 	if (err < 0)
 		return err;
 
-	for (i = 1; i < info->hdr->e_shnum; i++) {
-		shdr = &info->sechdrs[i];
-		if (shdr->sh_type == SHT_SYMTAB) {
-			if (shdr->sh_link == SHN_UNDEF
-			    || shdr->sh_link >= info->hdr->e_shnum) {
-				pr_err("Invalid ELF sh_link!=SHN_UNDEF(%d) or (sh_link(%d) >= hdr->e_shnum(%d)\n",
-				       shdr->sh_link, shdr->sh_link,
-				       info->hdr->e_shnum);
-				goto no_exec;
-			}
-			num_sym_secs++;
-			sym_idx = i;
-		}
-	}
-
-	if (num_sym_secs != 1) {
-		pr_warn("%s: module has no symbols (stripped?)\n",
-			info->name ?: "(missing .modinfo section or name field)");
-		goto no_exec;
+	str_idx = info->sechdrs[info->index.sym].sh_link;
+	if (str_idx == SHN_UNDEF || str_idx >= info->hdr->e_shnum) {
+		pr_err("Invalid ELF sh_link!=SHN_UNDEF(%d) or (sh_link(%d) >= hdr->e_shnum(%d)\n",
+				str_idx, str_idx, info->hdr->e_shnum);
+		return -ENOEXEC;
 	}
 
-	/* Sets internal symbols and strings. */
-	info->index.sym = sym_idx;
-	shdr = &info->sechdrs[sym_idx];
-	info->index.str = shdr->sh_link;
+	/* Sets internal strings. */
+	info->index.str = str_idx;
 	info->strtab = (char *)info->hdr + info->sechdrs[info->index.str].sh_offset;
 
 	/* This is temporary: point mod into copy of data. */
@@ -2066,9 +2084,6 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	info->index.pcpu = find_pcpusec(info);
 
 	return 0;
-
-no_exec:
-	return -ENOEXEC;
 }
 
 #define COPY_CHUNK_SIZE (16*PAGE_SIZE)
-- 
2.46.1.824.gd892dcdcdd-goog

