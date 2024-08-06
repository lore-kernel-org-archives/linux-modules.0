Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD4B179202
	for <linux-modules@vger.kernel.org>; Tue,  6 Aug 2024 21:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979293; cv=none; b=qh6NfZ3W7CQXobth+S9ft3fCuqY3Ge+Ebgb5ZLUySEHCIrSKyhKPOMUz+m8CInR+Ebp9/qF0t4V90jgeKejNr/vSaHc/xF5AusXB8d+hbgkuXlbK+/mZiy6cxjcNlPEaJBr+c37iU5gCTPt2NfHgJs0YTja18CaRh4bECkAspXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979293; c=relaxed/simple;
	bh=eZqSlIaoWM4WfSbfbvyZzWv8g4Xdrp3U8leU2Zoxrnc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ofTsTRwOPy315Q0go8ltgcWBKsEVv+05/w+LmCotYFhFcQ2dJxBGW0yZKWr5YGrPVlvREZ2gqY7txS8K7W7ToMTK3e4D1cbWhgW7kQUeuCcMI+TvdcoRnMnrQxuGh/Az0TQVZnOFG47OjKjUZh2vBAwmmjtkL13Vo47jWZxaDv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vxPC/edP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vxPC/edP"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-68dcbd6135dso23560057b3.3
        for <linux-modules@vger.kernel.org>; Tue, 06 Aug 2024 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722979290; x=1723584090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hw8pe/f7IoV2WGVsVTnz/cmhjcosc9mitK3vA0Vr4gE=;
        b=vxPC/edPVG9Dq3/FENh4yehDRZG4vGdY0gyUFzCUxOR0FNtvOD+y5onZI0u+CFGX2u
         obXSWxw4dcyJ31+d2hqAAPZSb80BRyer8SH6CBf7pbWjoL21Zrt8gcD4xfZKbg8NCKAT
         W1mNf1DpNwHtUF+y0bDgHXhFv+zMxMzbwq0AtBn9MOXNET5SL8jfvyDbTed448d8TUaT
         ERoyQm2E4VarNDLC68Frh+m6a8ZpaHwiFb/3JXiRZELrlqGNjS1kH8/OrtpbFkBsL+Z5
         7rPaFijcw+RlfW02RcdDrXBquS2AS2ptjP3Cr5jDSC6ppihYuPk90/3ZztYsNCCs6aWh
         IE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979290; x=1723584090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hw8pe/f7IoV2WGVsVTnz/cmhjcosc9mitK3vA0Vr4gE=;
        b=hk0PfSzDTClefP5ZnFA9EdHDYzXQQBchKKJkxsGBp6Bt/fDGOjSgbvK//1d8xjhXqH
         UwamPqubmAhsTc881uqxSmJZ0bXGcT8EpkHiVYNcOvrfN2kjwkVkiauf96pvdjGtQK4k
         g73EfOTlvC2mbmYn95RiFQcD1uFwx/qMGgO038hgEg1nkXIErszCkJRLFseFh22J8FhG
         G27558bNoi5kZNyynwLnRar41nNCpBJc4ralhPOkvHpNNFH46Dtlh17lRc86D+f6u/bD
         G+PlLoVvF2+CrZ96rxDatYYsY13vs+OyqRQDNpT69kbIkZu1J72MlQEEpEaTs4LwT+Lg
         Uvuw==
X-Forwarded-Encrypted: i=1; AJvYcCVmptYXWm8qg5LlsETsE9tGB1Dhby3obBr+lExpzxuHmGjd4gUHIaIe3MNiGjDHDW2iAz9ZCmXtOvJQ3gnYyftHMhZMK5foctoiKn7HhA==
X-Gm-Message-State: AOJu0Yx+W0cCbV1cfo0nt/0xDazNS/5w0Ch7VxH6sJ5h14W7ECPvJElB
	S36Aj/IK0M8yTIXbLuXxhihpXMFNJM7GI4/mzeGwAy4/omc9hIy3N+4TWHt9cJhj9oLJAePz9uC
	ZDIQPfg==
X-Google-Smtp-Source: AGHT+IF5wsgdTm2gCul2NqvSzln5bWqJN3fKvtypjNCS0MoVrnS+AxrHcsaPzCqJFh4r2PB0Xp3Zwok4SnEx
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:f12:b0:648:3f93:68e0 with SMTP id
 00721157ae682-6896313e32emr5643397b3.6.1722979290510; Tue, 06 Aug 2024
 14:21:30 -0700 (PDT)
Date: Tue,  6 Aug 2024 21:20:36 +0000
In-Reply-To: <20240806212106.617164-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806212106.617164-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806212106.617164-11-mmaurer@google.com>
Subject: [PATCH v3 10/16] module: Factor out elf_validity_cache_strtab
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

This patch only moves the existing strtab population to a function.
Validation comes in a following patch, this is split out to make the new
validation checks more clearly separated.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index a3a4acdcd647..d70d829b5ab9 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2089,6 +2089,23 @@ static int elf_validity_cache_index(struct load_info *info, int flags)
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
@@ -2122,9 +2139,9 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
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
2.46.0.rc2.264.g509ed76dc8-goog

