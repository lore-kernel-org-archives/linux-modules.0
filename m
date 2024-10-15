Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34231FF059
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034241; cv=none; b=uWoZNTi2KIylS93qNhEd4Mzs/sHnnqvAHyLcOIQPx0P4cW3sqksAgWDUzcZmzSmVBuZXHlGe+ErUVyVoNWnTgez4KT27TCLgzhig5XMLNjg51zCDyQaW/MAUm9alMDBZvRRiCnaXMJJVluZ6ZbrJf4ob39QAMtUe2ME05ASB+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034241; c=relaxed/simple;
	bh=kUK8aIbTJLs/ZpUSV/Sgdam8B7A+nd5Jkp5BRGlA5qk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QhDuGIaEjc0ZyzKiYV0QIkIl9J3Rfv90YjpmjarmJVQQmf7qrpZFVM8KfebGVtAeGi663+Gt26BL2WHve84gfLyDZr39X5H7ChIGeXAYEr04QEAoX2aKhm28saxmMsJ8oM5+QGP4MBc/gQzBJ2YaHI3kycxQWjyZONnrdp5HYd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1GZzfYY7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1GZzfYY7"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e389169f92so45615187b3.0
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 16:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034239; x=1729639039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9Tw4bS4pnyP2pGgxAbp4S//c+Yt3zbDzg79HSFcXU4=;
        b=1GZzfYY7Ss7IbH+XlPT8XeOiUDlHH61N0JXfJ0iyS58bfKbqLgbOuZuuSz4qAd1Rxl
         eTQAS5WirPEG8w/yLJJiY8DU1kgdTzytbcPyQd4B6tO26jcrP/b33/hheQ508GWdwJEB
         FLaNx8liAgl0wJ2KJeghoXQKThUy+9zaCLmUMRAMpV1VFUw7RT4I3XS0XShK9IQ6kQ/w
         3RofZkAS1pWxMAN1mCTr1U+wJ7xDshPjATM1jWG70e7Bec7PISl0lsK4ALbAgCQfiOZF
         zZhJInDurOXNyIOuPgsaalk8zcX3RKGZwq6p+MKNteBXyVNQjNiBCZOM4M3fiHtZJ5jn
         Yttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034239; x=1729639039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9Tw4bS4pnyP2pGgxAbp4S//c+Yt3zbDzg79HSFcXU4=;
        b=l7u6wBOKqTRm+kNZUI5Kqho6ST+Ur3kWbTH62HEln8IUZiA2S2hPpp3Tcy/gyL/hFh
         bUvW5vYPcueOi3yeVhTWlBH8LbNvJsfJYwmNJVDzu+YAreSDCwBAZmq5y2jvyKmDrhgu
         lqaBrDLJbJDDQZeG0CepzTV7BMMQ4wgD9U3DI1sl7dkBc2lfb5N4h2QyGkEElLgpWmia
         0SDEL3e61sYgCbJ/6O7RqrhVMKBWkXK+J13Njptv6gVj6QQCaav1heFT4IKpXS6u75EL
         iurCLsm33j19S7SraQMcFraT0ZrEp+nVtX2rCN/HuXntmIhef2to7yAaVZiEokjGPzFv
         BBvg==
X-Forwarded-Encrypted: i=1; AJvYcCVjBYMytE3f1mNFXH0JDMzgto4bG44/9C7FJZ5gnfwxgYNR+eZu8GI78KrhyArVmaYEjCQHSeuKXDgl95Er@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXl13nP45yu1dcCcy2AZLUnOp7YalON3hfOL5MIZ5NNa1sIV5
	U2HCs/Lu2ROn7iIRVncO+gaGvVF3VIQzaPGtogajshUtrlz8kRjrgk+Sl86AqlevNVYyNyvSqCQ
	usIcxhg==
X-Google-Smtp-Source: AGHT+IHxHydqVygYJSAlM1hXzYrW1tI+LxpAid3o6T70JQYXfz7gH/go6iSJb2G3Op8awUnbncbIAIXUGVU+
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:6703:b0:6e2:1713:bdb5 with SMTP
 id 00721157ae682-6e3d41e6748mr30417b3.5.1729034238606; Tue, 15 Oct 2024
 16:17:18 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:16:44 +0000
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231651.3851138-11-mmaurer@google.com>
Subject: [PATCH 10/12] module: Factor out elf_validity_cache_strtab
From: Matthew Maurer <mmaurer@google.com>
To: mcgrof@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	samitolvanen@google.com, Matthew Maurer <mmaurer@google.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"

This patch only moves the existing strtab population to a function.
Validation comes in a following patch, this is split out to make the new
validation checks more clearly separated.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index f352c73b6f40..22aa5eb4e4f4 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2122,6 +2122,23 @@ static int elf_validity_cache_index(struct load_info *info, int flags)
 	return 0;
 }
 
+/**
+ * elf_validity_cache_strtab() - Cache symbol string table
+ * @info: Load info to read from and update.
+ *        Must have &load_info->sechdrs and &load_info->secstrings populated.
+ *        Must have &load_info->index populated.
+ *
+ * Return: 0 on success, negative error code if a check failed.
+ */
+static int elf_validity_cache_strtab(struct load_info *info)
+{
+	Elf_Shdr *str_shdr = &info->sechdrs[info->index.str];
+	char *strtab = (char *)info->hdr + str_shdr->sh_offset;
+
+	info->strtab = strtab;
+	return 0;
+}
+
 /*
  * Check userspace passed ELF module against our expectations, and cache
  * useful variables for further processing as we go.
@@ -2155,9 +2172,9 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	err = elf_validity_cache_index(info, flags);
 	if (err < 0)
 		return err;
-
-	/* Sets internal strings. */
-	info->strtab = (char *)info->hdr + info->sechdrs[info->index.str].sh_offset;
+	err = elf_validity_cache_strtab(info);
+	if (err < 0)
+		return err;
 
 	/* This is temporary: point mod into copy of data. */
 	info->mod = (void *)info->hdr + info->sechdrs[info->index.mod].sh_offset;
-- 
2.47.0.rc1.288.g06298d1525-goog

