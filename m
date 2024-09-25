Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A14F1AD409
	for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307589; cv=none; b=O+jMR29Ehg1n3pCKV4qkZ2t20bWaFshUuB7nNUmCKJ2xKn8a3PLsfbzmeEKR+Q9TCX54P3I6V5/A5RLeKI2axhsSw6Bsci6X3qJ3LEjVfRNF9KPaHmvF13MwscbQUQ6FXvcSF2wX2zBxB076WfBYfK28S7dicCR+71XrM08cWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307589; c=relaxed/simple;
	bh=9QDYzeFqtIgpifJubbDxlmlH7eEjUZaH/2YQ84rdY0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GH9haDa2EUeQTrZ2S+BCe291bOvwrIk5w4Qhz4EQhceUi8ibG2E5+nWWvWAkAuj5nzFOekAWt84jxr17gft3XiB3aKY/tKFVxyGyiFSDGvv07CTKDP27p2xeofQaBv17wFtqk3CCWS12KWeU88FA98/sYYc9m6nCiJLHfjusM/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OTdjCMgM; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OTdjCMgM"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d5235d1bcaso8942837b3.2
        for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 16:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307586; x=1727912386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6yXvv/vrTLDrEzmPTfvxgBAIug2sA8OdrjoRUJniL2M=;
        b=OTdjCMgM8YjxDuEHL8ypwKq7l22iOrFWtkQjFufh9dEToAFONT32xfWhlYlYyjYPzh
         I5yjUlBc5jn4Th5d13BoVfmIoA1V0zqYnXOcpw8JE6CfyloFRCLBJEcsnywsNqhoSqSd
         l+MXDGR7HPpopbirbgIsdc7HUZpIOWUK+4UXwxNw+ky3BUrtyITuuUucrkU5oFqjY2pe
         /VvWCgQmo4PptPK5LWwbjMRdZaRDriPq55Ltk721/L1aM9+bL7owhnDXnKTx3/3OnOEn
         eEXBxTZphjfst/D4skhIKnZka6ofbVS2t+NF37pF6X+HDhksD+a8UgUiSGnPZZ9dtavR
         fvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307586; x=1727912386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yXvv/vrTLDrEzmPTfvxgBAIug2sA8OdrjoRUJniL2M=;
        b=NH0kCqQa/QZDX/TlNBF4bLLO2Gy946IkAxYSCh+PK+9M0AiVKaNrYxM7RXb3QfaS0U
         h1Ifu2I4XuqHcjxLLtt1UtkQdtGl4M50F+WkhfJixL7y9DsIzNnXD/d5jjLP1zmDfMQZ
         fE0VYQzBV3WGGlpbDeEZVlKFDnewD/ma8eF3Zs9MkXplAKdP9Am1/wFMOwmXb4qtVmv3
         6oSXGljovwkLsO+fR2tQ45kbCIvSuDhwjGwLN4eqFZLLzwc/SEA9cJgaNzejOh98k6Pz
         7ibgcd7r/dSB/6i7bR1NYSmLpFdLEaWsMhAmH1n/E7AEv/z8F0/Yg7V8Jxs9cGknL8rb
         jzpg==
X-Forwarded-Encrypted: i=1; AJvYcCVWHyOn947N/WwLaXdqACzR9wiZO74p0wi63xBqPSCxKeeUmdepZXCnpttVwboM/KZSyC6h1i5Wc1GJD+kZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7pWJzzrgb5bN67UKrTcsAcL49CNEnDsmjY2HJeApXv3O6w3PC
	t1TMMYRevD+79hpLdAX3uF6jttPNVOoJgPjVMauKxvg39y7warimt/g2267grDyLdOCgTxGp0Dd
	O5nTQGA==
X-Google-Smtp-Source: AGHT+IFOctLtu2fDpWSwtgdrlWQhzeyg6ur9X7N6yKJb4yvjNshlLawCmOC09mIbp13RxLe82I6Qn8MDC9MI
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:6583:b0:6dd:bc47:1ce1 with SMTP
 id 00721157ae682-6e21d0b47e5mr368107b3.0.1727307586448; Wed, 25 Sep 2024
 16:39:46 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:38:26 +0000
In-Reply-To: <20240925233854.90072-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240925233854.90072-12-mmaurer@google.com>
Subject: [PATCH v5 11/16] module: Additional validation in elf_validity_cache_strtab
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
index c082d5d41a8d..b40b632f00a6 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2090,17 +2090,53 @@ static int elf_validity_cache_index(struct load_info *info, int flags)
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
2.46.1.824.gd892dcdcdd-goog

