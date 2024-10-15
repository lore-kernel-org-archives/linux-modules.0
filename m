Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7991F9ED7
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034229; cv=none; b=Sma2JK6Kli5FsERT/r95CbpM+g9BbP+IpNIhuWgD0KDa7A4sb2Vz/4s78oxkbWgk9+iuIu4JNKVpalGVy++C7eCARNjXFDTwEqXgLPKX0BIe1/ca3XW6j1xrKMJGdPKlhJ5ewV1Ri1vwWL29in+FVinMfctmYhltdqsORPVxW5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034229; c=relaxed/simple;
	bh=YE/oK9ZOhdsHNUDoCLONYihU16c/izMFQR3EpE6qWgg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bn9ENkoscAAHM17S2zq4VQtGM5qWizQaPDoZ+q3T9mRlPM9MPFYMDgVN7SoIvVhPDS4+lYqhU1bU4liIqhh6zOmmOVaR4W4XnGFPkM14USyu8+gzzzYeA2rPlr5Vmbc8zvSnJP0XgVHCTd1I1tUgj/uHSw+h/SHjEWPSu+1aDQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TwwwPg+Z; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwwwPg+Z"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e292a6bdd72so6629027276.0
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 16:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034227; x=1729639027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpXqqJ7mhE4OTX7mw0ZIHnsdobY/QXMTdFshJ+hNzmc=;
        b=TwwwPg+ZV1lFiBZt4WXhSYohJ4VKuSEvF31Vx47EuMkHa+FwmCcvjhXZFfeTxm4o0c
         EnMvqT3CZDLSPv8vY9g6CP296PScmCdWPOdCuDZg67a07jmbjdI42Eus4UoUJMWs2mcS
         BS50jFuSGHhphKfHguQ+YRphsVkhW6fQSomgCCBqiLpUpuGy4G+PG1smnbvmiR7XS22b
         hgyBo/QLC+1XnVRFjwg8kLQdVR1oxHH2kwer0FOYdzk75fjOp4uUzVZBYYyg3Y58yWvN
         +CTHmvR5YJ1dSWBrpOrAP5GITbOKPBNOvt3sHM+Q6ZKajPIEuHSq7iH81o9/NWHrD3Bp
         WeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034227; x=1729639027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpXqqJ7mhE4OTX7mw0ZIHnsdobY/QXMTdFshJ+hNzmc=;
        b=CK2hLeFPPo7WxCegO76PJX4ulp9lRzm9JrHuvWNzOL50tqOgVTpEW6UvKh4/Z8czor
         pVQCu0OqYBp760Ogz8sHkewyPkgk8eGTapkOGOgjbiMUP4x3LEmATNPh9JMC5gHzl02E
         23iCErJHyMWKoW+LC9AiJCl99oUYjcz1S5lmM/Yu92WL1NNOCqK0iaXmf2GLmKD1hw3w
         Je7MjKzCR5ioeQXF+nW2FQ7fSJHCYE21SkpEYt+RDBb0NVziF2U9ICnZ7vWkY6ZQ+5Aq
         +/a8VfuZ1QoIx4JU+YxQlDxjG5Lb9SYesY00PH7n/MyCn0bVutpISIFw8pVwoj+xmPqb
         N+OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS8M12m4tKgP3QaxbVOJaa0POYcSCRs6fRsi6Ct8TeqUOawZrfP6PcM1eq/wz7vvTO8EY7Su3qvN57TAsV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3/U4/Dv9FWtz1LbaDAOEqx7QICi0QmgDWKbWqU41eB9RZ8csF
	tz4DKtbucilphGgUOcthx5xbJ24P84feAdDOL7Q3CHbTRrHg5JyhMRw5rS2sVra/R+/TYARq6S4
	/y0Ofzw==
X-Google-Smtp-Source: AGHT+IHizGOPKT5xbBjYB4IekU0DU2Mgds5ptzsICNd3lT/qy4QxEafJXfV6FVd+c7tsCcxLBv+gbqraWgah
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:947:0:b0:e29:76b7:ed37 with SMTP id
 3f1490d57ef6-e2978585cc5mr1523276.9.1729034226849; Tue, 15 Oct 2024 16:17:06
 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:38 +0000
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-5-mmaurer@google.com>
Subject: [PATCH 04/12] module: Factor out elf_validity_cache_secstrings
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
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
index 467e35f0232a..473f1fb25de2 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1822,6 +1822,71 @@ static int elf_validity_cache_sechdrs(struct load_info *info)
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
@@ -1845,7 +1910,7 @@ static int elf_validity_cache_sechdrs(struct load_info *info)
 static int elf_validity_cache_copy(struct load_info *info, int flags)
 {
 	unsigned int i;
-	Elf_Shdr *shdr, *strhdr;
+	Elf_Shdr *shdr;
 	int err;
 	unsigned int num_mod_secs = 0, mod_idx;
 	unsigned int num_info_secs = 0, info_idx;
@@ -1854,34 +1919,9 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
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
@@ -1910,14 +1950,6 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
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
2.47.0.rc1.288.g06298d1525-goog

