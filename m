Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4362D20F08E
	for <linux-modules@vger.kernel.org>; Thu,  6 Mar 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266936; cv=none; b=GIEAO3aK3BTBGjaZV0smzWSR12HByDkeWDJ/Ne9rd9YHlO5682iPSUAwp7wz0ZLy9NtdeV0tqy0mA2OeD6kRdFkGg/7G2YKEFokRFEthNlhVN/EgNz+4GnYMItNbXxuL6ye16fEeZKsdfP0qc+M61V37DHi6MB/rO+b0pc0u324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266936; c=relaxed/simple;
	bh=0tGSJ2zcfBUxZkyVy6Lyn8LU+JSKx/WFyTwadsmy5nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwHmH2zimtf0c/oOoTg4QSzKlKdJsnEy76vAwlrYrvrEF4YwLNtKJXdicZRwICY9pJ5gjCdQ6xfSlNLnFIygkywCsU4X+jRsSLs3TclmnO5+sKJe/bWES+a3zEWanCOtRofxtaK1hSD6dlhk2/x/mpgPHrnG22rQftluFDwihwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PLO2JKdQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PLO2JKdQ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-390e6ac844fso560987f8f.3
        for <linux-modules@vger.kernel.org>; Thu, 06 Mar 2025 05:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741266932; x=1741871732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qz4XRTq2wHtyfxO9Iu3bx9YuJ/6rqBX5vJIg6Ki8YEc=;
        b=PLO2JKdQv8xHHNAxPqDJZ1qOmIsmGdiKTFD10pGaXcG77RCl/DkLJNZcCimed9BO6c
         HbYLWTyBF2N0bJXKPWLvmbuz0Zxx2qoTbGXItMyCJhxQr0hhVCygk0TemIY3v3d20gwk
         AwV/Y1QdDLYXElT6EnwCwZD6y1vB/s7wJta/WNOniEV4uomcytWlYtCLNx06Pj7u1gZa
         nFUtIhSrnBgDUpejuasxw14UOgRpiR1FedJ1i+DQ4bhpScWjpYrDwAwRi8k+f7ltWAt5
         nm0s4mMmN3IsRYP6SeXMPimVb+YD0MgL6HJgLV6KSIyd94fNJaWN5wDAnSeDXqny/Mi9
         385Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741266932; x=1741871732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qz4XRTq2wHtyfxO9Iu3bx9YuJ/6rqBX5vJIg6Ki8YEc=;
        b=QzusBrzQSBWRvWSZbzEBLUJ6b25JPHXeIt2u2DvsfiuUCE44acIPiCb2s2fEgVFWuT
         iziDPFlXnsEz7vfxC9T75dP69BEkQCMzfDRHucNlGv0nVPwVAOS9XarOnGXimUDZVfyk
         cNC+/TSfE4CjQIV2LbbIUqSXPKjXylsMfd2pg4YvR3PKAw4VYX3E8c16+xQEN8p94qMO
         Iby06SB6Mw0DLSP7DHhZNNswldHqaFSQxiWFocd30eBZH45EDmm9lmEqQkPUankbsirF
         j3RQkByw2vZ+CddszQPGJb3wUYHLg2FXIxCnglWRP9hL2MNVE0NxE7LoiDqp7DEafO1s
         S/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXZXBvJl3JbuD0g1LJZBODWv7KauQ1SBii3DLOVfgN96MdpM3oX5Y8MuOxZeqK/LSwl2fVK1YiSE7rdW5Lh@vger.kernel.org
X-Gm-Message-State: AOJu0YwaYK7DUdRV6kBhfeGjDUuo5QG6gda5txPgFkNzk6Du72085++A
	WGwRKrgA0CSKOp0IgrpAiKFu2LfnqU7S583KUp0WqhQpmhRyT25rkZVYkccDFzE=
X-Gm-Gg: ASbGnctgGWc/bO5EcMLh/QXr7U2mNUYfdfEvXf09pKn0r+MXLDhWOx4t/Ci+UCTxE3y
	VCKWosWolysj4VQB67Mbvd9Rjjb5aDBgHDM9UY+7FrFel/AP+Et2JDSA4bvx0JVxaiuJkre7waT
	bGElb732BuRJvKvrcr+JRMo+fiItVf463vmYRWgVCl8HZppoNFN7FpQij5PL3ns9lJqdcUVYFB3
	WVbiH/s0in9yxOj84FRVFoCh8D75EOI6NQJ9uOWwnlcw8xtFvh3h0tU0U2Ys8UBg/mgyKb9zKsH
	hz+aq9uZS6Ayg8woQPqWT6ZQlSw06nowWJMn6+WFfBsKMv0g
X-Google-Smtp-Source: AGHT+IHqVig/PZTsgpubptGowxDPhYadgbR/BUVqM7eADw/KYZQQ9lMGwoFbn+PLE/hr3mMmnwG7GQ==
X-Received: by 2002:a5d:6d07:0:b0:38f:3224:660b with SMTP id ffacd0b85a97d-3911f7377fdmr5718510f8f.22.1741266932519;
        Thu, 06 Mar 2025 05:15:32 -0800 (PST)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8c327fsm19704485e9.13.2025.03.06.05.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:15:30 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] module: Add a separate function to mark sections as read-only after init
Date: Thu,  6 Mar 2025 14:13:53 +0100
Message-ID: <20250306131430.7016-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306131430.7016-1-petr.pavlu@suse.com>
References: <20250306131430.7016-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the logic to mark special sections as read-only after module
initialization into a separate function, along other related code in
strict_rwx.c. Use a table with names of such sections to make it easier to
add more.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/internal.h   |  2 ++
 kernel/module/main.c       | 18 +++---------------
 kernel/module/strict_rwx.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 18f32e791db0..7cd250ad1b51 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -336,6 +336,8 @@ int module_enable_text_rox(const struct module *mod);
 int module_enforce_rwx_sections(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
 				const char *secstrings,
 				const struct module *mod);
+void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
+			       const char *secstrings);
 
 #ifdef CONFIG_MODULE_SIG
 int module_sig_check(struct load_info *info, int flags);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1fb9ad289a6f..e66d501d1209 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2791,7 +2791,6 @@ core_param(module_blacklist, module_blacklist, charp, 0400);
 static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
 	struct module *mod;
-	unsigned int ndx;
 	int err;
 
 	/* Allow arches to frob section contents and sizes.  */
@@ -2809,22 +2808,11 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
 
 	/*
-	 * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
-	 * layout_sections() can put it in the right place.
+	 * Mark relevant sections as SHF_RO_AFTER_INIT so layout_sections() can
+	 * put them in the right place.
 	 * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
 	 */
-	ndx = find_sec(info, ".data..ro_after_init");
-	if (ndx)
-		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
-	/*
-	 * Mark the __jump_table section as ro_after_init as well: these data
-	 * structures are never modified, with the exception of entries that
-	 * refer to code in the __init section, which are annotated as such
-	 * at module load time.
-	 */
-	ndx = find_sec(info, "__jump_table");
-	if (ndx)
-		info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
+	module_mark_ro_after_init(info->hdr, info->sechdrs, info->secstrings);
 
 	/*
 	 * Determine total sizes, and put offsets in sh_entsize.  For now
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index 81278e687055..fa701dad4ed1 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -106,3 +106,36 @@ int module_enforce_rwx_sections(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
 
 	return 0;
 }
+
+static const char *const ro_after_init[] = {
+	/*
+	 * Section .data..ro_after_init holds data explicitly annotated by
+	 * __ro_after_init.
+	 */
+	".data..ro_after_init",
+
+	/*
+	 * Section __jump_table holds data structures that are never modified,
+	 * with the exception of entries that refer to code in the __init
+	 * section, which are marked as such at module load time.
+	 */
+	"__jump_table",
+};
+
+void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
+			       const char *secstrings)
+{
+	int i, j;
+
+	for (i = 1; i < hdr->e_shnum; i++) {
+		Elf_Shdr *shdr = &sechdrs[i];
+
+		for (j = 0; j < ARRAY_SIZE(ro_after_init); j++) {
+			if (strcmp(secstrings + shdr->sh_name,
+				   ro_after_init[j]) == 0) {
+				shdr->sh_flags |= SHF_RO_AFTER_INIT;
+				break;
+			}
+		}
+	}
+}
-- 
2.43.0

