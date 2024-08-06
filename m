Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A651779A4
	for <linux-modules@vger.kernel.org>; Tue,  6 Aug 2024 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979292; cv=none; b=QUDFZkWVUKpmb1pFEWUWu+r/X9nNwbnBQKujHuPy8aZctLrNC2h8IRLaMBqtQgaC16utJaVhhD9yT2WJMIKdIv2QOcJKMhUMJUmw+GSf0L7iOolxuVl/Clwdt7/YuMA4MIGAOFYNxubVu6lZ8sTj8Q9KeJh7n6eaY7BC+lA/tk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979292; c=relaxed/simple;
	bh=dIiU0Tc3uXRBqO8BxbcpDjMxRQlEqkdGqVYtVRXQfa4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MqoaKQEOOY1DEdRx8r//9DgCMtGLpPh+TwRJzoAt2iJZvEjNp89Tu26m7d2PE6F9D7YUiuZWnfpbzBopa9DPpx14XqSyzRgdXAvmrtSXHuQ/rbRTKV2Ucv9sJ2VJGnwYbYBrAjvHq2p7TuELvJkXvyIu6ed+9I7GN/Ls20cL59w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YoSQTAzB; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YoSQTAzB"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035f7b5976so746069276.0
        for <linux-modules@vger.kernel.org>; Tue, 06 Aug 2024 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722979289; x=1723584089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gUIJSmYAueDMQwZOmqrMFJ3C80+DhAWejM34XgmrZE0=;
        b=YoSQTAzBlqBCl67gkvZV2vzY++Mq2djV1Ps44zoqDB7HkKhJUfFbtM+TJv6Ts7azbf
         S6idUvg03wLJKctSagydLQVQ1uXBXGdjjMY0VgJsPK+K/S7kBjRb+m1BH9XdHf68NduD
         hfmq0YP9RvrhT3bVFWjXrh8ReVKT3KABx/4d0Khz2o/SCYJUcM13EVh79zsMFKwnKh4A
         K8s42VBxkRWjwXwWN6ID1qe0fL/S6hb3E0YnR+100KDR5il7uyhsSU+Zk8CwcXSyk+yk
         VkfEBJp+E4FJsLPHV3KxN8Ax/jivvtozSnmeee1fzhPFAnBBIzY8z4U3Tc3xDIiKrXIP
         nJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979289; x=1723584089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUIJSmYAueDMQwZOmqrMFJ3C80+DhAWejM34XgmrZE0=;
        b=Zkqw9Te7GwhE/3fyiskr4gYrkstwvYR2XTYBS96mlIWzNGOPRqpg5/uZ8MzXpLJyX8
         wfxgxbd4RtDC0udZK46xHJT2tyRQ3QGhCv95CLkkRU8qZDx0dGnlteHq8laMoNg7qoOr
         5Ey3bSvTY9apoFtaiji6htXsGQb/QAbkQRTb8G6RCMkAnl68K9ituvbci6dRQOBNcK+k
         934LM2KUTR9rgYS3DNoAAnFORhae81R+9sIfSduR5xxHkrEh/IesvEkrUU0FTmMBXuGx
         HDGuNQi+eyh9Z+hd/CTR3y7lB7ojEODKAqooTv5ExAQaz4s1AhD60vimlzKhC+zpAvCy
         fjVA==
X-Forwarded-Encrypted: i=1; AJvYcCWUaTSJyObmb0H4k9/F1vampZDcZ5KPetL4ZCL8hq83lAgsMOows20AYPZ3zWoW0RKBDAQR48hLCSDWULgfm0y0X6CVwy0bu4XHy5w6Mw==
X-Gm-Message-State: AOJu0YxcwMQx1VkecoSOyO9tX+Km7wdsujqw+m1ZCWkif177cNEm4Lq6
	Ymh8vZR6CoVjb6ZC4t1eIWasRSYKyufP59ETDFsDEl57/QHALhlWN91fQjrBGc2untdwQgpERF5
	ws8ERJg==
X-Google-Smtp-Source: AGHT+IHnyhCIE7p7z2n6WnnXCPCeFudWDehmyraniu3E/okfCSEKUYauypMKOFooBVtSeqVPlFvlg3iYazYc
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:2207:b0:e0b:bc42:53be with SMTP
 id 3f1490d57ef6-e0e87799e3cmr180276.2.1722979288711; Tue, 06 Aug 2024
 14:21:28 -0700 (PDT)
Date: Tue,  6 Aug 2024 21:20:35 +0000
In-Reply-To: <20240806212106.617164-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806212106.617164-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806212106.617164-10-mmaurer@google.com>
Subject: [PATCH v3 09/16] module: Group section index calculations together
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

Group all the index detection together to make the parent function
easier to read.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 68 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index dec733989ad6..a3a4acdcd647 100644
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
2.46.0.rc2.264.g509ed76dc8-goog

