Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B68D1ACE0B
	for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 23:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307586; cv=none; b=fpvYqclzhv+rh8AfMeAMwOZ7Srn2UUBoqI3ikbBHwccepDNNGIJW14F3G4h9ebrtkXQs1Bgul7LrFJ+esUgB2lRTnZuwbTO3NOdLoGDAvd+6KRyK/uVva7qYcAxHrdg9Ty1IedZYZ81LdPjQF3DIlhRooEK1MtniCyGoT3evl3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307586; c=relaxed/simple;
	bh=RFwYTaeqemLtmezDNnI4k0C/4IQdB480nO3xNfeeufc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aSIpWGrIEin6q8gJqLc6/dP4aygne4dj0LycG3AmjfrYs60KNV2gfafBsQLkVd7tOiboQ/MCmjxb31Cp0wvlop1BzKIT96mWqJNns1ls+SInmoSVnqy+uoxEU00TjA0QqCvNsJ8PBuoXOEqSFYoXItKUTeTIgan93O/GXXiEdd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZmAsWA3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZmAsWA3"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d54ab222fcso11426437b3.1
        for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 16:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307584; x=1727912384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=extRuG4D1AdoHKvsMv2fLx/d2D/gEpHsXYLRVzC3Sa0=;
        b=MZmAsWA3xomFzJ3UUFSEudjq/FEAUJacydlEI1beul+6uGuE6Dk612LIlvkuQsgQxE
         LKFw1JuiaBXdG1uHQJtonGotcE3vuZBlVdDPI5OlmeijfeydlODQgykSy2MKioYhpxBx
         tpDeVANLnJsAfhxUabBpeAZO2v32QtQ0ZnkCZwOjiQMrKcSKK7qk+g9nJqLz2wWRoIkn
         1thJdq3czEqvSmthv4qaSVD3DLOipzTmOnKwOsYfep36BabfVuSbJIbAk7IsFiWHeb9V
         bLKfqdSTWXI08j85AFD+OBSQAOnaiR4vQbZCgv8iuHqgKqpIcqasuCk+F8w4TSNp76rw
         kF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307584; x=1727912384;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=extRuG4D1AdoHKvsMv2fLx/d2D/gEpHsXYLRVzC3Sa0=;
        b=KFHwoIhxzzalf4dNVSawOjHUVhKeWAijOlBCEC9XQhy1sqHORRMRSk5XgIdWSg5Q9s
         Y43zkeoP35tsa4sMjJhM/l1XCeGpTw6KJdsoveZ8daIoQ8wy/OvSsCdmpCF1n1uUx2/p
         gstomTVxW37EuLXRnVsOeurbkeT1t113bYNcYSIGtY0k2pyiFaZ9dSM5yzn2fjRQDBqQ
         kHYwKCa4sXqYLbYHt9cOcreXuN2t5cwt8fGKWGYB5Az9oomztHBS4s1QuS/vJ8pEQ+Ca
         fCArGRekqOAxTDqb46nNpv+Fj7N97dk7w8SE6xOCdt/wvMx+26i32ziDNlx9QGP+Y+FG
         afgA==
X-Forwarded-Encrypted: i=1; AJvYcCUGzbWlosYv0dFsl3i3/sVL3xNaMgpNSm9tipUQpSnMhNx4PS3eW3PdzhgttRr/l9HrqS1+f+tfsijftpDt@vger.kernel.org
X-Gm-Message-State: AOJu0YwDG6B7UXom1VgXyQn/x6NwZ1cg1wA0YielU5i8puzMiOFFKFen
	0gS2T9tEo/lPWKrN7kDLBriPUijS1t5Vu0sMta/ESIem5ovkSCgqgrINvTGjw0gtkrEeFIH7JIH
	YHifnzA==
X-Google-Smtp-Source: AGHT+IHi0gSVKxF9796sY6n1cVcgNiz/fsNc836mupUZtqmyvJTlnsLOXeqwbXzuTlIf+2iUj78FZGeorFh0
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:2a92:b0:6e2:2600:ed65 with SMTP
 id 00721157ae682-6e22600f35dmr247467b3.1.1727307584197; Wed, 25 Sep 2024
 16:39:44 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:38:25 +0000
In-Reply-To: <20240925233854.90072-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240925233854.90072-11-mmaurer@google.com>
Subject: [PATCH v5 10/16] module: Factor out elf_validity_cache_strtab
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

This patch only moves the existing strtab population to a function.
Validation comes in a following patch, this is split out to make the new
validation checks more clearly separated.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index e04a228c694a..c082d5d41a8d 100644
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
2.46.1.824.gd892dcdcdd-goog

