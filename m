Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4A91922DD
	for <linux-modules@vger.kernel.org>; Mon, 23 Dec 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734946750; cv=none; b=K0oCdKFCzNHuMCx2B9R7JSGP8NdVBVpj2Xl5YuF42sKZYSy2YUsJm/YKdhlkNTcVjeU1QmqKSNKGEujmMEaF3PSsbRt/8gvqQeP6EHgj6nifPkKlzsqQqyVH1Jqs/GsrTEVT20RJtF2Q7B7fkqfZGbzi2T4hoSuTLuf7hxGMrfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734946750; c=relaxed/simple;
	bh=ETP1ymbYo1qfIFjSyhEeHy3LDAuXB162qdikBGe/IQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+NhJ/3XfA6TDZNVMPmjjqQDtoN1QfUES04QxkbNII6cHbFfcM75jtt9CxJsYgCFIQg55025V7NE4OQOsVN5eFsD+eApvD2YAhC5kKdGCi5b13nyyRVTUH7pICmdVqUc1PKmx0sL0+o0zvhTLClHoVb3EJ45d9vRRStmZQxW5zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S/uPR2kL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S/uPR2kL"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso28851215e9.2
        for <linux-modules@vger.kernel.org>; Mon, 23 Dec 2024 01:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734946747; x=1735551547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WQPaGV5b+bcwoSffAZhjDIDuT9+0kfuESUg3le7qes=;
        b=S/uPR2kLF86smPRNNp62sdxWFylsWDsHWYWqW+3KQ5uPAboMJ7IYggifp3LBWvxwH/
         9yh4OYk5oEwIq6sU3pvxfEV+PkbM3vfVYLWf4HpXoDecL7OESzxwTCdt4Y0ucl+QG9UU
         GwGvlFVNNbKzMCGNhWQFqxml6Q+2r2J9cBQ8pN2IixylqGrCikViYn90FQqz1RnBwbKZ
         x1nayG1QWsT3DysiLneGOFsVN04Rs74+0IC9RnPz12dAfpDTN+MAahWTq25MDL5XEcVz
         DEBJsgK8euDi14hX6w5h6cC6gXoICRAdQJ+GJIPzRCUUsWfbwWdq5G5lBgAgGH5mO7lr
         2Upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734946747; x=1735551547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WQPaGV5b+bcwoSffAZhjDIDuT9+0kfuESUg3le7qes=;
        b=i1Kz95TjHP00CsOBzo7I+Ty9PjCJp6lUv2d6GhcuBFt2h7Z0CBEHBAKprt0T8YKBra
         iSjl+V9j9RXCxbBmiCW7ptI+Sm9vhIhqWV0qkY8d6dxGFaw/hwkPLLMWzOfoqoW+JBc0
         rvUG3VTcZffgRkFOcQBqAnJN17toHxTK7eN+2LtsJqWbwOeLH1uRbg8DiOGlWrYQ+/1U
         ut7S22v5fXqF54W0RIkmJEsbRdTTIBdYmge/lkjLZ0hPsPgeNaG+xuxOyThoGXXpDfxa
         IyFC4XCwYXNnxxy7OppEToI7HP/H7gFFvFDAPhDxgFTRg7pgt0uoAC1q9NhffwoyQFq1
         Suwg==
X-Gm-Message-State: AOJu0Yzj55hcHBRRjIf5OMvpk/efMg8G88RXlVoUx5E3TMr/bSl1uyG9
	4OD9/qi/njfXvLtFurhD4SBsGLCivZHKjYIoO58U5tURv6ByBDgDQoe0Hs7GIm8=
X-Gm-Gg: ASbGncse+0IDGfN40ISjHtLL1IrrnRGGFCrKYwclDz+iZj1gTw7Pg+rc49jZa3kUagX
	rVU0Fvk4VXH9tLj8sak6IGCKwnRLCdVRYWtcGDjWRmwqItuNeOClmPHwDom+dM9ZMLZT5Na104W
	JLgzQ7Fgedgp56UWowrESuVKkC/+vQUTYiWxOKcpcb+Pwz3vptjMXyc2tgDJpn9SC4sqjitTYKX
	Y0WUsKgBG0MzU9M/Y5CSpmDYfDmzkSVPDIJPVLQbgG+0KkO7cDTmgAFIllw
X-Google-Smtp-Source: AGHT+IFm5r7Cf+dDlJFPMsarFoOSiqqlJkGJ9HXC2Cwjx2DL/obpCNE4LF9QIF4f2V7W2lIYeSDR9w==
X-Received: by 2002:a05:600c:470a:b0:434:f767:68ea with SMTP id 5b1f17b1804b1-43668548337mr99288815e9.5.1734946747191;
        Mon, 23 Dec 2024 01:39:07 -0800 (PST)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c829235sm10773868f8f.15.2024.12.23.01.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:39:06 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] module: Constify parameters of module_enforce_rwx_sections()
Date: Mon, 23 Dec 2024 10:37:47 +0100
Message-ID: <20241223093840.29417-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241223093840.29417-1-petr.pavlu@suse.com>
References: <20241223093840.29417-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minor cleanup, this is a non-functional change.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/internal.h   | 5 +++--
 kernel/module/strict_rwx.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index daef2be83902..7e78f6a8e85e 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -330,8 +330,9 @@ static inline struct module *mod_find(unsigned long addr, struct mod_tree_root *
 int module_enable_rodata_ro(const struct module *mod, bool after_init);
 int module_enable_data_nx(const struct module *mod);
 int module_enable_text_rox(const struct module *mod);
-int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
-				char *secstrings, struct module *mod);
+int module_enforce_rwx_sections(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
+				const char *secstrings,
+				const struct module *mod);
 
 #ifdef CONFIG_MODULE_SIG
 int module_sig_check(struct load_info *info, int flags);
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index 239e5013359d..d1c43309bb25 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -81,8 +81,9 @@ int module_enable_data_nx(const struct module *mod)
 	return 0;
 }
 
-int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
-				char *secstrings, struct module *mod)
+int module_enforce_rwx_sections(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
+				const char *secstrings,
+				const struct module *mod)
 {
 	const unsigned long shf_wx = SHF_WRITE | SHF_EXECINSTR;
 	int i;
-- 
2.43.0

