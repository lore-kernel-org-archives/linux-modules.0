Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE841AC446
	for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307583; cv=none; b=hr3FpCx9nYd2DHP5AEIUK9knGlZqK9Zaz++jGlgMzA9xBDyDz3tDNj2pvGsB8zXj+4brwpIDqwAsSxQKEHFcHxyKdErdkyyvEjdBGxtP77dbS2CpIHcPif11NyTO29ahDwlHPUzH7k8Zf2BBv7+dZTlR3/qghVwI5qeV7wVG0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307583; c=relaxed/simple;
	bh=wM975yYhhnJbskoT3Xe/Z8RaXLTIAwoZIK7NoqKeDB8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JUDiBXlIHmDPN2NZk0IpWakVKbEXFwN1QhIXUWjGJTTc/RjrtQyFSskXQYfgPSKYhL4sQ4A3zJ4aZbS0FgeeLG9MrDweDmGj3MqeAPX5ZHx2jPZvIa0AuTQl6JgHZ6pUSm3Ma3FViSslK5tAgfOKQK0sY1cOT00PBSuiKt23QkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ace5t6Cv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ace5t6Cv"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e20993a03dso7455607b3.2
        for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 16:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307580; x=1727912380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fOjsxdYdAkInxupUorws184MmwFGmal1AWb/bAcHrOQ=;
        b=Ace5t6CvyKVH55R5F+8+SFEGTxJt+z7edGdIMLwXZb2veNJnyJiw+inHBKPQefkXcj
         yfj9g09w66ixqXNGIKfYucTJ/eQohq0K1Zw2pRs/eTkiv0VfbbVbxWuoBf/BqOEqslT5
         /ztQBPjaqKWZO0jdXdJa3Wu5L1+NUjStuEM5JR2vT+eTeJuhMuhiklq/b6z3OdsGFcwm
         dEwg8wI3mrLRBO4tM79Mpzhv34Gs4wka9YKLR6aAjcdY5/2JuRczf900R1uv+5+F6+33
         A11AMc3aVg0SeQnHWFLMN4hDviU7z4O6SwauY33tJ1U/86KDOoxW2/k2Gqmtpu/SXwey
         eadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307580; x=1727912380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOjsxdYdAkInxupUorws184MmwFGmal1AWb/bAcHrOQ=;
        b=MRYmtclMqS3ELcExpL0H9+aIq1HJkhX7rSXkUzB9GymbAUXgZIkX10EGxBfPMObkhQ
         tvicXUhrnPN40Qg67C4ID6an6o14hqdSnPy0C1VYDF0MbmRcVoeShVZKxDrc4gv4HkUj
         iQrrYpSIBIebVIZH5lsRV+o/0uMCi95juGTNCmPiHzTtK7atBzg0baHS8OhESdzKiwPp
         w8BrGTRcX/ACeLk43nX59fBPDKpSmC3lo7eFb4F13OWu32KDbrJCsbTwSgbTJg8HYS7O
         pBoe6cCE4y+NrDbb3kyIixUoi/H3CPWMMZrYgxV9yFUCSnlZdwZ6V0edM9w7Gbc2zsKw
         V9gg==
X-Forwarded-Encrypted: i=1; AJvYcCVwlpZ+J7FsmOXZyWGbBgb7xnKQdERXzJmP5d2xizGJ/RURuZhF+2lFwDikUitPAYYmzPho4WVoZyj0dbHO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2C7z095evDoyPacSTE5QLV9YlONqRn1jVULmyCt9BK6lzbBVo
	Exreu7vxkjOCjlfa+KyNwrhgpfoYox47sWvMf140yIM8jQb8OtKYyx3qJtIf1+xXJRzpjWxgRxi
	GAC4TRQ==
X-Google-Smtp-Source: AGHT+IHdWqR9IrD2hZQX0Xo9yhQJzQmApDf52iNmKjMPjmcrCoxOYUdkaSUs0GEug6EnSPPHsMtafWiB8pKN
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a5b:841:0:b0:e24:9af1:43e7 with SMTP id
 3f1490d57ef6-e24d7fdf205mr3591276.5.1727307579861; Wed, 25 Sep 2024 16:39:39
 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:38:23 +0000
In-Reply-To: <20240925233854.90072-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240925233854.90072-9-mmaurer@google.com>
Subject: [PATCH v5 08/16] module: Factor out elf_validity_cache_index_str
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

Pull out index validation for the symbol string section.

Note that this does not validate the *contents* of the string table,
only shape and presence of the section.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 6be58b0a6468..43140475aac0 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2014,6 +2014,31 @@ static int elf_validity_cache_index_sym(struct load_info *info)
 	return 0;
 }
 
+/**
+ * elf_validity_cache_index_str() - Validate and cache strtab index
+ * @info: Load info to cache strtab index in.
+ *        Must have &load_info->sechdrs and &load_info->secstrings populated.
+ *        Must have &load_info->index.sym populated.
+ *
+ * Looks at the symbol table's associated string table, makes sure it is
+ * in-bounds, and caches it.
+ *
+ * Return: %0 if valid, %-ENOEXEC on failure.
+ */
+static int elf_validity_cache_index_str(struct load_info *info)
+{
+	unsigned int str_idx = info->sechdrs[info->index.sym].sh_link;
+
+	if (str_idx == SHN_UNDEF || str_idx >= info->hdr->e_shnum) {
+		pr_err("Invalid ELF sh_link!=SHN_UNDEF(%d) or (sh_link(%d) >= hdr->e_shnum(%d)\n",
+		       str_idx, str_idx, info->hdr->e_shnum);
+		return -ENOEXEC;
+	}
+
+	info->index.str = str_idx;
+	return 0;
+}
+
 /*
  * Check userspace passed ELF module against our expectations, and cache
  * useful variables for further processing as we go.
@@ -2037,7 +2062,6 @@ static int elf_validity_cache_index_sym(struct load_info *info)
 static int elf_validity_cache_copy(struct load_info *info, int flags)
 {
 	int err;
-	int str_idx;
 
 	err = elf_validity_cache_sechdrs(info);
 	if (err < 0)
@@ -2054,16 +2078,11 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	err = elf_validity_cache_index_sym(info);
 	if (err < 0)
 		return err;
-
-	str_idx = info->sechdrs[info->index.sym].sh_link;
-	if (str_idx == SHN_UNDEF || str_idx >= info->hdr->e_shnum) {
-		pr_err("Invalid ELF sh_link!=SHN_UNDEF(%d) or (sh_link(%d) >= hdr->e_shnum(%d)\n",
-				str_idx, str_idx, info->hdr->e_shnum);
-		return -ENOEXEC;
-	}
+	err = elf_validity_cache_index_str(info);
+	if (err < 0)
+		return err;
 
 	/* Sets internal strings. */
-	info->index.str = str_idx;
 	info->strtab = (char *)info->hdr + info->sechdrs[info->index.str].sh_offset;
 
 	/* This is temporary: point mod into copy of data. */
-- 
2.46.1.824.gd892dcdcdd-goog

