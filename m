Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD2B1E00BE
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034237; cv=none; b=hig6z6vE4aTwWwgntcSuffnBb7G9gCo5GoBfdTpClF3o+/Sfi+xcPvoaOkhQdD/4utV3XR8ggZ5Hc+H0htSEw7kQ1JhVoQB2vukM7Vr5nAUHxng9KL4/W2RoFFhWrSy4RSWAcodRQeVzlmqG22YIncLvtzYsVQRiGWGHWwro9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034237; c=relaxed/simple;
	bh=iMTvib7F3dkpDDwL6WKTDohEIppYFDaWToaRVYH6puY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qcjntUDOkv/jqxikNq8syfmP9SlIkvD+ljDoSeraazrdrdWasWyByMzEPcLZtfcEOzJYqXUhYbuIcXdTK31iBFC3Ha341qo5ZCzRvAZ73eABERP8TwEsOz7vt/oZyQTHAvCF41biKzj4xMnneDu+/36taoItekzWNRJUcjJl9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bgAbtCk8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgAbtCk8"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2605ce4276so10730307276.3
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 16:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034235; x=1729639035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LEQ+ZejxpX7NgK9KNR6MMy0vwkxaNZHr6sUUOlvqX4A=;
        b=bgAbtCk8K+t86CQRTY47TlDkErpaAiflYSmITarBmU/FrZjtLdaQOQ+OgQY4FYKP0y
         KVrjaJF7z0qxSnQkkSggNQvYp2I00oVrIdLRTu87CrNei5EzaKefl+sruN1m4kfPokv5
         xmWsjHlYelWUVfbMZW6aDcVEuSWUcHu3otUFP1rjMr4t2EakPJMnpDP+nNpgixLMrtur
         w5RkDfBao6kABOU66mga3ZHMQhx/1qMJlMx+pmqyINhwEcpmfM/hoi8phyNZS67u7tH5
         cY0IY39LTB4Jm7JNgCgME0a5BaD3FlS/18kK8hvkipHx3vAXLKPF6WAwdmK48OnzWsi4
         mOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034235; x=1729639035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEQ+ZejxpX7NgK9KNR6MMy0vwkxaNZHr6sUUOlvqX4A=;
        b=o3d/4t2rt/dBESSrUzDoghkgDE22JpNXi3kn4A8bhZblO2HACxFgS0v+tqWnXNiNMg
         lcIFpfbU5JJi305ie6zFh39OnPsblMNILn8LOr7fCpZ1ddhlgGyriomKvzhkpixZzwgz
         tQ4jIBHsXn6mfvHm9nQJQEqTQf+Fz8kv3PirC8kzxkuItxFSLHdK4dn2YOS2j1oBDwXs
         MOETVg8sX2glGjo7v02GUcPmI7D7qHQD/XzsZqiWjI6h82n9xqIl8aHJGPDdx5t65Boh
         e6IZFDbYffDu//tbYfSfeZmnEu+zOmUxc/1jAs3Eray0KUywjuCfNxlOcvIS0rCJc1cG
         DZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6n+3nU6RKslNHL/KgGSR0ITWt/weJcZakHEeNfqrlyOgazjbpDpLOR/aHMH7TUIL3MC42StIRqCpai7QA@vger.kernel.org
X-Gm-Message-State: AOJu0YzAdf2EB/EUIXc8GkG88V9UzMfr9jzuh37/5K4VWIqC3iGRWfiA
	FhUrJbw7oH9fnqMmczv5+bR6wo3QwIf4M5S/Qpa+JGVgDN7Eb/Ff1a/BvAv9X0Ks6bapGaDtNKm
	8/cQ2gQ==
X-Google-Smtp-Source: AGHT+IFEb1A4zshho6J3INntrbo6VVyAUQkYlnk9sPxI4pRfxvsDhI95XyVYv09ejjcvutWvtOoxTc0vMwAx
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:a287:0:b0:e28:fdfc:b788 with SMTP id
 3f1490d57ef6-e2978597020mr1157276.9.1729034234867; Tue, 15 Oct 2024 16:17:14
 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:42 +0000
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-9-mmaurer@google.com>
Subject: [PATCH 08/12] module: Factor out elf_validity_cache_index_str
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Pull out index validation for the symbol string section.

Note that this does not validate the *contents* of the string table,
only shape and presence of the section.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 955746649f37..a6bed293d97b 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2047,6 +2047,31 @@ static int elf_validity_cache_index_sym(struct load_info *info)
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
@@ -2070,7 +2095,6 @@ static int elf_validity_cache_index_sym(struct load_info *info)
 static int elf_validity_cache_copy(struct load_info *info, int flags)
 {
 	int err;
-	int str_idx;
 
 	err = elf_validity_cache_sechdrs(info);
 	if (err < 0)
@@ -2087,16 +2111,11 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
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
2.47.0.rc1.288.g06298d1525-goog

