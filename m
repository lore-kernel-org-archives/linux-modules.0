Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4341D9669
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 23:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034225; cv=none; b=SA4V4rZk6WaAq+Fz01p6cWwo1Wx1fBb6NZCJ3wvhuAK4FLmlA3Pa3bPkvemDfrPrIJHALUITORITpi7h0KMQq0g9mQje2iMfmvFs4fBzQ2u3LqHMj4ydxBD8FWvXU6Sp5tUASZ5Kfsxk9F07AugfG79QDhNeDeqxts7XyYLTta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034225; c=relaxed/simple;
	bh=mDYkZeYGnRE3sQhCcF+uoxl/1TxGRA4ekAMIMeBAB4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PnrjIfQllto0H6Ece1VuQDPR/VfFMThiZK2O/J6iybR7q8iE1KFmAI6b8T6jyON9wnW3f+39H7Q6jkKZQIHRetgHsX226VQW2YQ8lai8eh9Glz2233pqllljxIts45O2dX5DultjrCgawRuwGcxbNyssZWPJFzdAIJAutff7Rhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=daeXy4L9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="daeXy4L9"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e32b43e053so75154817b3.1
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 16:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034223; x=1729639023; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GaOp4Let+iTa8j/z2TDGbKzwODexvMJh2E3PsytoWq8=;
        b=daeXy4L9nRtc6nArHS91VmuufFuGsrMwJxht0PqJCpgA1loiBrY2PA/YKEXOuu6yjk
         hrTjapcmDP00tlk4n/RUDidPpNoYJXv9BHqTcW75PWA/jdyVEC0mU02rV7hXdf4RE8vI
         kqJALoLd5BHmRpGVW8Mk0moqWB+iF9wzKpVPU2dtZsZ+rtVugT55WBCHwDYfM73gcSuT
         WYfw2FxVqjEjWt8wjlevu6BilnOEKEaIp2NUk264SF8TLxE1SMpZbynZTS/X+eVXPttr
         NuEDUO3sGPq1S+7zriGr0hI078g+jSBQQy7FZCZ2XrBr3T1+AkKzp+wH9xuZtYTzuW8h
         YfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034223; x=1729639023;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaOp4Let+iTa8j/z2TDGbKzwODexvMJh2E3PsytoWq8=;
        b=J8XhktsNLpNmrGXa4AyjFNm5zZfqEl40OtUfe9tcFhvXVPmEtnYrQ/HYIkpCTSaYx4
         P1FqCaJod7FpOZQUkLjoFPr/zKiLCM+wREapYEAEYa2HYSEXABpgXQW2EWT4n+2XqJ2w
         rr/n51urQN6gHOtdOoleRf312Rtdwbw1gQW1ysbndRgXQAS2pWp+5r+0lM2eflkpN5q6
         dvwTpMaVeEBzBdhPKcLRAD5/f0u0hKvjrR5pLxQG6CjeZBDtE5e4bSEb2qXWOOrmMmQP
         gLrg6NABJxblqLXxVrxKXzcVLTYP/s9G2FZeitRpC+DDtlRHfU9MoXF5xE7bSE/XShuq
         5puA==
X-Forwarded-Encrypted: i=1; AJvYcCUIvWSFjdO4Q37TZKSQfHp4Ehr4UIhgeZv1m/iftTS81Ka0KlTbSCeaqYb/Wl2oCfweZOuEYZXr30fQIdZQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxwJzlqWShQeSakrp9W4mJDXeYEyO+LlMWyy3ZN31tFjphVDLUe
	u4+DUAfGM2mPsBLV/Y1TpqGIZyIYZGsyujSefFphtZciXcp7rSbY1my1DAjzmhC6vk3+fibxyPj
	E0tV8kQ==
X-Google-Smtp-Source: AGHT+IFZZ+EiwW/n3OCbtia15roWRedKzxQbPaS+sWOvG4bizXkUKDFwjIvX7+XcR/hn6q6oyOTxd8iYrUp2
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:74c7:b0:6e3:39e5:f0e8 with SMTP
 id 00721157ae682-6e3d41c6eacmr556067b3.6.1729034222868; Tue, 15 Oct 2024
 16:17:02 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:36 +0000
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-3-mmaurer@google.com>
Subject: [PATCH 02/12] module: Factor out elf_validity_ehdr
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Factor out verification of the ELF header and document what is checked.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 70 +++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1ed1d1bf1416..c836354928f0 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1697,6 +1697,50 @@ static int validate_section_offset(const struct load_info *info, Elf_Shdr *shdr)
 	return 0;
 }
 
+/**
+ * elf_validity_ehdr() - Checks an ELF header for module validity
+ * @info: Load info containing the ELF header to check
+ *
+ * Checks whether an ELF header could belong to a valid module. Checks:
+ *
+ * * ELF header is within the data the user provided
+ * * ELF magic is present
+ * * It is relocatable (not final linked, not core file, etc.)
+ * * The header's machine type matches what the architecture expects.
+ * * Optional arch-specific hook for other properties
+ *   - module_elf_check_arch() is currently only used by PPC to check
+ *   ELF ABI version, but may be used by others in the future.
+ *
+ * Return: %0 if valid, %-ENOEXEC on failure.
+ */
+static int elf_validity_ehdr(const struct load_info *info)
+{
+	if (info->len < sizeof(*(info->hdr))) {
+		pr_err("Invalid ELF header len %lu\n", info->len);
+		return -ENOEXEC;
+	}
+	if (memcmp(info->hdr->e_ident, ELFMAG, SELFMAG) != 0) {
+		pr_err("Invalid ELF header magic: != %s\n", ELFMAG);
+		return -ENOEXEC;
+	}
+	if (info->hdr->e_type != ET_REL) {
+		pr_err("Invalid ELF header type: %u != %u\n",
+		       info->hdr->e_type, ET_REL);
+		return -ENOEXEC;
+	}
+	if (!elf_check_arch(info->hdr)) {
+		pr_err("Invalid architecture in ELF header: %u\n",
+		       info->hdr->e_machine);
+		return -ENOEXEC;
+	}
+	if (!module_elf_check_arch(info->hdr)) {
+		pr_err("Invalid module architecture in ELF header: %u\n",
+		       info->hdr->e_machine);
+		return -ENOEXEC;
+	}
+	return 0;
+}
+
 /*
  * Check userspace passed ELF module against our expectations, and cache
  * useful variables for further processing as we go.
@@ -1726,30 +1770,10 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	unsigned int num_info_secs = 0, info_idx;
 	unsigned int num_sym_secs = 0, sym_idx;
 
-	if (info->len < sizeof(*(info->hdr))) {
-		pr_err("Invalid ELF header len %lu\n", info->len);
-		goto no_exec;
-	}
+	err = elf_validity_ehdr(info);
+	if (err < 0)
+		return err;
 
-	if (memcmp(info->hdr->e_ident, ELFMAG, SELFMAG) != 0) {
-		pr_err("Invalid ELF header magic: != %s\n", ELFMAG);
-		goto no_exec;
-	}
-	if (info->hdr->e_type != ET_REL) {
-		pr_err("Invalid ELF header type: %u != %u\n",
-		       info->hdr->e_type, ET_REL);
-		goto no_exec;
-	}
-	if (!elf_check_arch(info->hdr)) {
-		pr_err("Invalid architecture in ELF header: %u\n",
-		       info->hdr->e_machine);
-		goto no_exec;
-	}
-	if (!module_elf_check_arch(info->hdr)) {
-		pr_err("Invalid module architecture in ELF header: %u\n",
-		       info->hdr->e_machine);
-		goto no_exec;
-	}
 	if (info->hdr->e_shentsize != sizeof(Elf_Shdr)) {
 		pr_err("Invalid ELF section header size\n");
 		goto no_exec;
-- 
2.47.0.rc1.288.g06298d1525-goog

