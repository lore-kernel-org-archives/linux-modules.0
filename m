Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E510E1A3BDC
	for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 23:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307575; cv=none; b=JQERXYS2y+/tF9LIhcWaKcOfX3Uf8vbdxY6sdgGe6Iny9D0GhG6zmufw3NBgaa6p1Nb9Yeekpg3Kc9TBGdgbScG3KhTnuNl0ZHZbfMCYgMzyAyKv0PCCsRi1lnKIYGgJJ1DQapcpfSoQ0jOk6tc6JoDcdmM70FoLfCLfEbxS+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307575; c=relaxed/simple;
	bh=oOvwo7YW3AUcfbqrf+A9OVLdTk2yYzaOPGripVgZWf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V7TcAjdQhc2XhH/xRhbGzqhB7bC2jI+J/1qXLPYGjdbYB/l9gXKC3nbOJ5hIBW8i5G2iNesgnnCps+uRXyKSz1C+8lGBhkeeeIZed3q7KPmwN+rRFZ4x1zQsrjoTEXuyjdIzKFXHNpsZJgACR9EL0pwK/WSLbC1TsHgsOW+qj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m5Z5tSey; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m5Z5tSey"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02fff66a83so695728276.0
        for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 16:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307573; x=1727912373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKJyYEevVucNlB3/71Ku7Qx+VTTwNT+eh7LmoeHsrUQ=;
        b=m5Z5tSeyRlsxLy1ersJE+UGxQCyLHbFGDz8D/MbyB/kQa7EYcqRvp/f8uPQukKcrCt
         EfJ1Aezcx3fQoA6m0su+FwrkOEJYSSEJ9sjwyh81XN3Y497rH+FbhbDjzOEl5RRxJqcp
         VlypXpgjrZZc7R8C480eVLG4oXVSYm2L+1bi4g0AX+N+4vnBqlNY73Op1ZsJ7ljiUy9q
         ixYagzg4Gdj+FamIYtiuTGhEiXptWpg5DFWUiQc1qygfowqRpMKtS8WnGuyNST4lx3nZ
         oxHSLIjZkt0GL4tiNEHelvV57QkjUxh1raAHGuZMGQxxKpuRoMq3uVZFs+7SK92eC2Vp
         /qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307573; x=1727912373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKJyYEevVucNlB3/71Ku7Qx+VTTwNT+eh7LmoeHsrUQ=;
        b=WMAeNG8MCMpafVKDA9wSotmP8WnA84OuSJM5OILA+hb/WHZsp0G2HjcvUR/W7DWOAp
         zBA1Q6ESg2vR00/zSrplj423ChcurKD5PmIL8xwEFkmZRqdM8ryydX7Y1ib3Yb1lnKAj
         ehhJZwqSDTI4T9awV1SGmFK0C2wfpAM57IzKik5qdKhITz/5F/x5Yk8yU1MB60Drv/zg
         AiNRm2WnqAn6utFKe68Jl4yIB+F7N/WtNMV4sFO/ASkBgxaLffA8OkfpsGv7PnPeyGzw
         6GjZ0g6WBP+9r6W1G+wruLaFso3f0hnw9rTWbCtVA/BvropqK3m7eMrAzEpUOuagOxlA
         qILw==
X-Forwarded-Encrypted: i=1; AJvYcCXP9AcNQBb2q9d2C2l8jIX5Co80iFNVZPIBvFCZau6F1tPsFoi3WFq5FjhN8VXi2/MRqcPh5vOyrQ2gDG6M@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2JzjdP4tIDXsXmkc7YJjcNmPE7ID038f6zoEKLaQKzxNayH/o
	r/FrGbAFwymXKOjRRpK0USzVNrGUXnXHCmzTdVz7z+zT7Sco/HalTx2CgJqgIaB7uwAHlDZU9UJ
	oyyl2wg==
X-Google-Smtp-Source: AGHT+IGx+nve+AoQTJhC0039Mrm5L1Mmot8nzzFqz6EcNfCPXpgrANZ2tGjsmltzJQkDur51XUIFhuHCnZ0h
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:780e:0:b0:e16:6e0a:bb0b with SMTP id
 3f1490d57ef6-e24d44cad51mr4787276.0.1727307572609; Wed, 25 Sep 2024 16:39:32
 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:38:20 +0000
In-Reply-To: <20240925233854.90072-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240925233854.90072-6-mmaurer@google.com>
Subject: [PATCH v5 05/16] module: Factor out elf_validity_cache_index_info
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

Centralize .modinfo detection and property validation.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 82 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 14 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 6a9159afca02..511d645ac577 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -195,6 +195,38 @@ static unsigned int find_sec(const struct load_info *info, const char *name)
 	return 0;
 }
 
+/**
+ * find_any_unique_sec() - Find a unique section index by name
+ * @info: Load info for the module to scan
+ * @name: Name of the section we're looking for
+ *
+ * Locates a unique section by name. Ignores SHF_ALLOC.
+ *
+ * Return: Section index if found uniquely, zero if absent, negative count
+ *         of total instances if multiple were found.
+ */
+static int find_any_unique_sec(const struct load_info *info, const char *name)
+{
+	unsigned int idx;
+	unsigned int count = 0;
+	int i;
+
+	for (i = 1; i < info->hdr->e_shnum; i++) {
+		if (strcmp(info->secstrings + info->sechdrs[i].sh_name,
+			   name) == 0) {
+			count++;
+			idx = i;
+		}
+	}
+	if (count == 1) {
+		return idx;
+	} else if (count == 0) {
+		return 0;
+	} else {
+		return -count;
+	}
+}
+
 /* Find a module section, or NULL. */
 static void *section_addr(const struct load_info *info, const char *name)
 {
@@ -1854,6 +1886,39 @@ static int elf_validity_cache_secstrings(struct load_info *info)
 	return 0;
 }
 
+/**
+ * elf_validity_cache_index_info() - Validate and cache modinfo section
+ * @info: Load info to populate the modinfo index on.
+ *        Must have &load_info->sechdrs and &load_info->secstrings populated
+ *
+ * Checks that if there is a .modinfo section, it is unique.
+ * Then, it caches its index in &load_info->index.info.
+ * Finally, it tries to populate the name to improve error messages.
+ *
+ * Return: %0 if valid, %-ENOEXEC if multiple modinfo sections were found.
+ */
+static int elf_validity_cache_index_info(struct load_info *info)
+{
+	int info_idx;
+
+	info_idx = find_any_unique_sec(info, ".modinfo");
+
+	if (info_idx == 0)
+		/* Early return, no .modinfo */
+		return 0;
+
+	if (info_idx < 0) {
+		pr_err("Only one .modinfo section must exist.\n");
+		return -ENOEXEC;
+	}
+
+	info->index.info = info_idx;
+	/* Try to find a name early so we can log errors with a module name */
+	info->name = get_modinfo(info, "name");
+
+	return 0;
+}
+
 /*
  * Check userspace passed ELF module against our expectations, and cache
  * useful variables for further processing as we go.
@@ -1880,13 +1945,15 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	Elf_Shdr *shdr;
 	int err;
 	unsigned int num_mod_secs = 0, mod_idx;
-	unsigned int num_info_secs = 0, info_idx;
 	unsigned int num_sym_secs = 0, sym_idx;
 
 	err = elf_validity_cache_sechdrs(info);
 	if (err < 0)
 		return err;
 	err = elf_validity_cache_secstrings(info);
+	if (err < 0)
+		return err;
+	err = elf_validity_cache_index_info(info);
 	if (err < 0)
 		return err;
 
@@ -1912,24 +1979,11 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 				   ".gnu.linkonce.this_module") == 0) {
 				num_mod_secs++;
 				mod_idx = i;
-			} else if (strcmp(info->secstrings + shdr->sh_name,
-				   ".modinfo") == 0) {
-				num_info_secs++;
-				info_idx = i;
 			}
 			break;
 		}
 	}
 
-	if (num_info_secs > 1) {
-		pr_err("Only one .modinfo section must exist.\n");
-		goto no_exec;
-	} else if (num_info_secs == 1) {
-		/* Try to find a name early so we can log errors with a module name */
-		info->index.info = info_idx;
-		info->name = get_modinfo(info, "name");
-	}
-
 	if (num_sym_secs != 1) {
 		pr_warn("%s: module has no symbols (stripped?)\n",
 			info->name ?: "(missing .modinfo section or name field)");
-- 
2.46.1.824.gd892dcdcdd-goog

