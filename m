Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF091FDFBF
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034235; cv=none; b=XXHn8IcvRkqvsudD0QFzAwzxnoDn7L4pFwEszxssEbNKdzsl5FQSAPr+AnLqKhOwepWkwRQM/giKNBputQp8Q6n1lKcf1jcp0zfl1XEekfol2DVcRFb2Bezag+zodq3idKNPMBIA5ULZMMxSsfwcJ3nRVXRD4OmczkCIcYWinSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034235; c=relaxed/simple;
	bh=IoH7pzgf0vRG81KSc64PH526sZjBPee8CO7MjeLtc0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nfKg5x2z1v8v7JM2O34jlI6/ne5k6ZlFd91pL5IMdLoOVae8F91fpM1nSj0oAyaVyH8brbKetII9P8tSob2LDjBYYR+Y+ii+HgtKBrmghMsQMSvxB7yC564ZSfLw33KwfUKtCR+OIH0QZkYeviI5NJuWylnG2YWRKzwesStaDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z69UuG6m; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z69UuG6m"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e000d68bb1so4263297b3.1
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 16:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034233; x=1729639033; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=719H0QwRK260v2OWeLynQ1hn1vTZVWJ8dOTdLhhDG88=;
        b=Z69UuG6m70uqmnEcK9+h3Z4w+uXySDKybz7231PjCfbLDIlK3Xx7KBr0l94VQzwNVz
         02Q+lIN2oWS4wQZQhqFLt53+q3+Tr2FM4yQERh7+1YlweF+4s48AH7kNfvKs4ga0Vr6T
         E5uwNIRHPQsvTmKrhIwQ0lSGgsRtPVD38yYlSSSpMz2g6xsP86y3egkVJiqXrUahyojb
         U4aNitZ+Bub0t7bmNrZtTGKt3wi+bOvysI2ErQ21QgmGhM0UHsn+MAP9HZUP16EadHnE
         7NIB8JjxA5H614BXxm5EatDEEgt6f74OrhYFYorKfb1VXZ56Df5YlxEEojRWoI1vZoyC
         47Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034233; x=1729639033;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=719H0QwRK260v2OWeLynQ1hn1vTZVWJ8dOTdLhhDG88=;
        b=ef6cvGzXHS9FXBP0YSq4Y4wMYQS9WOFn/aonHL2n83NyEJnH9k308JMDBSmWz60zb2
         gulVmfJToXJ2mcqHMN78HI0pnuvgP57rB9yrzdYgd4H+joOt3AiUyPBStp5UgJ6of/W/
         +C6Kz1hn3RXN1s4x+3jA2ZpAP8hY8t2etC/T4ErfsGaNst8j6V2pCEK0K2Ze8xGjrgQ5
         0wEd0mXHULsuducNuvog1UkXs2EA6Ysf4zLA5yodjKYmI4MFLCqyl88Jf1hdKAhAeolq
         RLVtrmZO0aqg3m/50upvTjv5+P15nhTwtxGCOc6GCh8c7CMUMFDmPH3Lkot+U+5NL9fQ
         +U4g==
X-Forwarded-Encrypted: i=1; AJvYcCURtF2pR4E6BvZgiT2JhGUWXwTIhPM/VShjcSnH4X2sWfdUn45Y/PAAEegCxTheaLTYbCUWziV8U+HHEs/u@vger.kernel.org
X-Gm-Message-State: AOJu0YwSLmyj2uRd6Jy2cFTc2lGAbcaAvshuZJ2Uu9eS/jdaDJkyYSP2
	6PNS8yd1e2cTYcplRR5qq0DH0aRSwwGCEKVLD4KQ7DzinVkQr0IYzVxLndhwthSBEjecd0BeITu
	urLRJ3g==
X-Google-Smtp-Source: AGHT+IFVoc/78thbQxUF8y16OnSrdHo3E4CbWYdabzTsfLPOZQvqyCxP9i6oAH1nir8Og6g/hirEotZrgmAw
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:ad42:0:b0:e28:fdd7:bb27 with SMTP id
 3f1490d57ef6-e2977517616mr11736276.3.1729034232869; Tue, 15 Oct 2024 16:17:12
 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:41 +0000
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-8-mmaurer@google.com>
Subject: [PATCH 07/12] module: Factor out elf_validity_cache_index_sym
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Centralize symbol table detection and property validation.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 73 ++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index b633347d5d98..955746649f37 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2013,6 +2013,39 @@ static int elf_validity_cache_index_mod(struct load_info *info)
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
@@ -2036,10 +2069,8 @@ static int elf_validity_cache_index_mod(struct load_info *info)
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
@@ -2051,34 +2082,21 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
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
@@ -2099,9 +2117,6 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	info->index.pcpu = find_pcpusec(info);
 
 	return 0;
-
-no_exec:
-	return -ENOEXEC;
 }
 
 #define COPY_CHUNK_SIZE (16*PAGE_SIZE)
-- 
2.47.0.rc1.288.g06298d1525-goog

