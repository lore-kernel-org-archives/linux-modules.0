Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52461FF02B
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034239; cv=none; b=KjUP4gKKnrjYivmVaJfEeLaXfOlLBTB3SKGOYTQ3drBbH45hBf2Dng2fH9C6dGDjO8Ne3hxb85XPK2rHvO8DyjtS4Sh7j6pnkgdwXAXACHsfxq0AZXQzHBVXUHxH1TjpSOmTp0wv3KrNAB0rF1ATMWbATn2WiDLmzRaRm+PUDQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034239; c=relaxed/simple;
	bh=hjDQXeiUX95J1QXpCz5oPWaRB52qH/la5DEMemSKDsg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kjSiiQ75CEOtV7STFT2fJpoEBgqoBEhhBZN6VuGZ/d+OnRDYTXG4ftYQVL+HgfhNOg2dikVLnAyL+ITeYLxyOGXNgI1tMRXsnnfMjVUHPPJuLWCsn0TDQgz7SKBbGzydmOwavUE36iOxggn+K30r5pE8UBoRnJitg531ITs9N/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qR0cowVi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qR0cowVi"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2954ada861so3835208276.3
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 16:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034237; x=1729639037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1uwZjjsLk0MIG36tHEbuTh0oExV8i1gjaEov3sAmvfo=;
        b=qR0cowVijVl+7tBWjBpajUVhFgopifQqX9m1kqLycTJqCQyQawkaMg0jtnctU9ty1Z
         HcOI8dcLZEePBlV49ah2rKzypqySz8pNB7f+N8GKsccnR34YEhSyts9ULrPG3TluY9FZ
         fJVcRm3NPI4/dDMfFO0nK2azMBpbLuhwQZ0PiKASjPWHkzHSXn04GMdHpP49aCrD3One
         l5y7NBnpXQqtAcTxTXM2pNNzRQZy8t8+sFLjWARoTWHpjOusiUaCZ+0IBMGc712/dTGx
         zbIW7buXcfWBVgkC0Xwb43F6tGiZcfjd0nyeQcUE6YW5M+zFdg04X5ngd8rKTDcIZnrg
         s5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034237; x=1729639037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1uwZjjsLk0MIG36tHEbuTh0oExV8i1gjaEov3sAmvfo=;
        b=eg604DURL925/idy5BTXOc1XTwe0/ND1clLAiCx7vKzcLj5NevmuJthG47WoeicF0+
         iEgI4fgMvGWS2fhtehsoTDxP+7+Giy8b9+CRFssx4GTASRsnSZL4MWUswqcqIyt5KB/0
         t/EBrLZoFHjPERnZKHOZDwKh1Uz2WpXd+H0O1WLh5E96LS+nwRUTRD9wUs4PVEicihih
         VgY3SUve1D/NHyz36PyMSbR06C1v1ABg7/XGJHIC/CYmuMhrJffXTTIcesshxJ91BV0M
         qWe7M/rbJeZY3YEQNttVsVqHeepI/RuDMcJ+f8hgQTXKTeKZK3KC6Mu/ywpWYqFY66cV
         i64w==
X-Forwarded-Encrypted: i=1; AJvYcCW6/MiHD4Yz5i15rV+NbVatUOrVHBjrmYBIqzA+IVNCK3rK1yioLX6ca/b5Q/Jjo9wx2FM2yp+W76Y4bj0r@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf4qamAhkBSOhcUUB+TvqszGOh0k8PSCMTWojRDC9i4BOw13Yz
	v60uy8J+7W3dN//45e++jjSwL9Q+3aqhtrX23qezWfkPqgX9+quOtgZfj+lq+xZmIVDhbvlMtL9
	quezUzA==
X-Google-Smtp-Source: AGHT+IFgckrRNMXFF24rFhgTtnbQoAnZBnt81LEcyNJagNruc4+MU3SMi75f9nEJkDNi/O4B6WflF8vc2KSQ
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:112:b0:e29:7587:66db with SMTP id
 3f1490d57ef6-e29782b20edmr2157276.2.1729034236773; Tue, 15 Oct 2024 16:17:16
 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:43 +0000
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-10-mmaurer@google.com>
Subject: [PATCH 09/12] module: Group section index calculations together
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Group all the index detection together to make the parent function
easier to read.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 68 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index a6bed293d97b..f352c73b6f40 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2072,6 +2072,56 @@ static int elf_validity_cache_index_str(struct load_info *info)
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
@@ -2102,16 +2152,7 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
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
 
@@ -2128,13 +2169,6 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
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
2.47.0.rc1.288.g06298d1525-goog

