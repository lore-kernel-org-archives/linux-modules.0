Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AE92003AF
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034243; cv=none; b=krLGT6pIIM7Dra3KFjuNGwi2bzNvpSR4A5peRX3wT9xRC/6sV6u6sJx59B5o+VbZPL++ut969Gg7sbzyx9LwFOgbqbxPMd3XLofek0zoXzB84AshDXxITPJfTC0S2WaLmoJLNq5vfyJ+/N4q3O6jHhm1F5YM6kJUR152k3e0GFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034243; c=relaxed/simple;
	bh=GPb1TpKFNjVVCpW2qIAL8wvN9CirdjY1ZpdtVrcA0Wo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SmwUOvadEmdj8OVy9qE5L6EHoCgyIV8j5Im4cuXlnswxN6j4NX6HK7by3OHkAC5xEQB+R/ctp35rKubrl5VjXyOibblukg7evd39jEAOb5Hhz5B3dWNVAh2y4p/WMF+qG6nS/sMb7WvZyhEPSo2ej93RLzk2k/ziwV7F19NmLJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UVeqJ2LV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVeqJ2LV"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e290a9a294fso8488552276.2
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 16:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034241; x=1729639041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MnoeOJ9yqvZhu5BOCvDTuTGU7w1wCrt97NAeyTTyfDc=;
        b=UVeqJ2LVWz1wTIuAVy+fx69TM7ZWqALtDu2AuE2B9dpm3VkBB/Wh4xl7+TUTOA7FcZ
         Nj0aUdFuo+z5dD+JqCt+4mupbMymOtDzkvjMutytSEXu1WhGy47doAD4tZRCmh3rBKKm
         JgjwuDvgohtnhvkysml0PCpGF8UzkM4FKI/I4cMm1oDO4jfOmr4fhWG8Rabcr7sCRqt5
         d6RYUyfpRCJXTPEo0Ru4UiAaV8WdiKDbJIHuN8HIHZC3Vt853Jlr/OqYVPbAHkm7WVxL
         IKaDk3Ti0ZgnB7XaXjCC0K6++HkGkDP4lK1afdQmrWM5P7nKHR/PrxZBso2rHrgihCmp
         u+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034241; x=1729639041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnoeOJ9yqvZhu5BOCvDTuTGU7w1wCrt97NAeyTTyfDc=;
        b=guEUo/x3ppf+eBfZjiJ1kTK09arAAgm3VjJryicivYu6bwD4Rg/aXwy1ZkQhHSENck
         xXvJSUS587SlHqXZ7fHPff/wIKJRDj8rfpOBYAx8aUZbqGMJVhHZCexJroaCoXdn+Yea
         FkLrpo6iBmEk1Ovvf/xbASATO+U5be1EhwbhJ4U/bh6uteiclnRidPm0AhbKUj8TNn8Z
         j799SP+TgEzpumXzTH1WLmOYFPCxovLr8BN15Y8zFx7b/HmXn49zxs29MRfpq6ZemsO1
         noxI57Fg2FjZYq3KbT+MwBfIuXB8S4qTNAwZicvRF9lXxfxoO6QXqzU3yluKPsCmFWin
         rOYw==
X-Forwarded-Encrypted: i=1; AJvYcCVjShgJIMMXQ/xvnHkgbsXz6n0KEYc6bDjNah40VVHaYbKf/pdYMeWupvGNynfmn9yemiYousL5mNobAdct@vger.kernel.org
X-Gm-Message-State: AOJu0YyevkdA9Ht4deB/tFFz2qMdI0PW74IoRN3sJcTHTBcAuJUnv2El
	TcIyfkdDGX89JTHOB46F0v23lwdZrf8Ptm24OFTqSvDetPNSiQII4FneeMA1ypOV1Swppa4SM3P
	2AGQeLA==
X-Google-Smtp-Source: AGHT+IGHz6HPifKuNrMT95HK5iMWP8yOrgiK3ZaaQuMaSy1FjZCKCjGsfCmky7q8W2xsP6eERZaKJdG2Y8g2
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a5b:80e:0:b0:e28:f6f6:81a5 with SMTP id
 3f1490d57ef6-e29780d7669mr1444276.0.1729034240688; Tue, 15 Oct 2024 16:17:20
 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:45 +0000
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-12-mmaurer@google.com>
Subject: [PATCH 11/12] module: Additional validation in elf_validity_cache_strtab
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Validate properties of the strtab that are depended on elsewhere, but
were previously unchecked:
* String table nonempty (offset 0 is valid)
* String table has a leading NUL (offset 0 corresponds to "")
* String table is NUL terminated (strfoo functions won't run out of the
  table while reading).
* All symbols names are inbounds of the string table.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 22aa5eb4e4f4..3db9ff544c09 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2123,17 +2123,53 @@ static int elf_validity_cache_index(struct load_info *info, int flags)
 }
 
 /**
- * elf_validity_cache_strtab() - Cache symbol string table
+ * elf_validity_cache_strtab() - Validate and cache symbol string table
  * @info: Load info to read from and update.
  *        Must have &load_info->sechdrs and &load_info->secstrings populated.
  *        Must have &load_info->index populated.
  *
+ * Checks:
+ *
+ * * The string table is not empty.
+ * * The string table starts and ends with NUL (required by ELF spec).
+ * * Every &Elf_Sym->st_name offset in the symbol table is inbounds of the
+ *   string table.
+ *
+ * And caches the pointer as &load_info->strtab in @info.
+ *
  * Return: 0 on success, negative error code if a check failed.
  */
 static int elf_validity_cache_strtab(struct load_info *info)
 {
 	Elf_Shdr *str_shdr = &info->sechdrs[info->index.str];
+	Elf_Shdr *sym_shdr = &info->sechdrs[info->index.sym];
 	char *strtab = (char *)info->hdr + str_shdr->sh_offset;
+	Elf_Sym *syms = (void *)info->hdr + sym_shdr->sh_offset;
+	int i;
+
+	if (str_shdr->sh_size == 0) {
+		pr_err("empty symbol string table\n");
+		return -ENOEXEC;
+	}
+	if (strtab[0] != '\0') {
+		pr_err("symbol string table missing leading NUL\n");
+		return -ENOEXEC;
+	}
+	if (strtab[str_shdr->sh_size - 1] != '\0') {
+		pr_err("symbol string table isn't NUL terminated\n");
+		return -ENOEXEC;
+	}
+
+	/*
+	 * Now that we know strtab is correctly structured, check symbol
+	 * starts are inbounds before they're used later.
+	 */
+	for (i = 0; i < sym_shdr->sh_size / sizeof(*syms); i++) {
+		if (syms[i].st_name >= str_shdr->sh_size) {
+			pr_err("symbol name out of bounds in string table");
+			return -ENOEXEC;
+		}
+	}
 
 	info->strtab = strtab;
 	return 0;
-- 
2.47.0.rc1.288.g06298d1525-goog

