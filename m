Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761DA192589
	for <linux-modules@vger.kernel.org>; Mon, 23 Dec 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734946752; cv=none; b=EIihs9hlw3z6nqGblVWGU35LDHeWBv+L3kJieYzPd11ldFzxAP8aoI+U0UiMujvKvL8vUi+fZFmXIXuuTDFNJT/k1o/CfC7pnwSwrDVmAm7IDMh3JZJ1v3uozJE+ve4mF6YRjNGEWLKw10fXHWDjBjt+bviFP51QgoYfmc6NuPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734946752; c=relaxed/simple;
	bh=6tdjyAZQ6cbVp+w0GpB3/BWnpCb4MftVCuh43tzcHRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAUTjM2J6UF72zluvdopuvt/CdaXN+2xi/Gkz21ro2xFOFqNk/cxGbeeJNOrZxDCYi5jHEaFdC5VDuCkTTOPbldO1nsiwMyvThdgvjIpFrQs1fURETPCexl1rBqhujHUtfp9Dg9nYTr+1BB4JuDpTxdS3iZwmQUA70L7cPmqM5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P+2WMAfr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P+2WMAfr"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361815b96cso26194185e9.1
        for <linux-modules@vger.kernel.org>; Mon, 23 Dec 2024 01:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734946748; x=1735551548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NexceldLvPH8eTfckj5Ngxuw5KfU1fsgYnDIWr0Vew8=;
        b=P+2WMAfr+RPh6VW3zUhMMiEmXd7Lj/nhNSOjLuacpvBuRoRnvGlaut/NLpEm/9ITio
         D0cX6b6z2p+LLqA9hq2aYp69aVxeRJODVRS5luOdjbOg5eykvVSo3bQtj+m0CIhGFpuB
         z4Rt23WmBoDOuYn6dPOQJEm0RnpWxxMm5IEYpbNqx675VbVhUkdlmAg1zL7kPGQGOTi7
         YrynVzfythnzmi0un2HD52RdYC7oi+34EHM4jL4nDAHvfMN0tL+O9ZhzASn/luMf0/8K
         Sx6J67tB3DIwY0tZcaoivVpQTh0F0kql5/kKOaoQOXS5+BBy4cABfd3PbHfeA8gGJ9x1
         1GVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734946748; x=1735551548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NexceldLvPH8eTfckj5Ngxuw5KfU1fsgYnDIWr0Vew8=;
        b=KTsCwzw9f34BmAYjCEgbvk05ldFvhE2up1fwc07vXjpXIvQskhxt+gNBlmulC2vWqw
         4bkeHxrZHsTKc33jJdRptFtX1kEkzoQZLEOElX3hYQhsvAQvFwvJpMg65EyotI6DzFQO
         B4yvQNXnfzLj8WAbnDgERiddbMFGltPai2eakVmJZH3EGfxQRmg5/4bEBnXINEFOTVJ5
         LDE19i4pjz6o+CHlDgt/uVIH14LB2Qt3shkll/5gw6CxB2sriZXqFfdsbBdjHEWzjr4W
         ghgh6kBLGYXJLA/znAXQUMig5Gs3o7r+5eKCg0jFVKbEpIlUSzofa47YLhZ+kfkUZuDJ
         lfGA==
X-Gm-Message-State: AOJu0Ywf7UrnaFtuycLIyPc2HWUqCyr56CcOOVxXvAfdjM3TOClhXBlT
	LSmxLmsVWpQjWrf/VJ/UHNOox228WUMJgJzDzNXtB1OU9CtWD7PZXVnwY3HmRKI=
X-Gm-Gg: ASbGncsklmnzq5p2nnnXSmYL/VFoKPywy9hky/pUIj2rLrSqTTvGc+XO3/9ySNeJRY3
	+0Po3kDkblqG788NKip+McNScgR7q10ZFYLY2W9v9ze6ACCymhMY0ZFQpFHcJuir/u4utjpJYDC
	+gsxeyTheUCj9zM0MYEQ9YJqFj4BD7yYPr3kH255s6eZtQD2aQ/KMLJsTeDhKbY9LuiZO6vmIff
	J6RA5+s8gpc6azk56kCBLLP4oQtUh2v3RVP95+Y1SASwBk5kYLcz235j6tu
X-Google-Smtp-Source: AGHT+IEeEsudDKP/+A7DnHtNti9OLkLotRBCvT8iEm73qgWuk5HeUCkRxJarZJy9KksulKFauzJM0A==
X-Received: by 2002:a05:600c:4748:b0:434:a7e7:a1ca with SMTP id 5b1f17b1804b1-43668b5f5b7mr89549795e9.20.1734946747810;
        Mon, 23 Dec 2024 01:39:07 -0800 (PST)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c829235sm10773868f8f.15.2024.12.23.01.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:39:07 -0800 (PST)
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
Subject: [PATCH 2/3] module: Add a separate function to mark sections as read-only after init
Date: Mon, 23 Dec 2024 10:37:48 +0100
Message-ID: <20241223093840.29417-3-petr.pavlu@suse.com>
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
index 7e78f6a8e85e..c4c918d9b65e 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -333,6 +333,8 @@ int module_enable_text_rox(const struct module *mod);
 int module_enforce_rwx_sections(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
 				const char *secstrings,
 				const struct module *mod);
+void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
+			       const char *secstrings);
 
 #ifdef CONFIG_MODULE_SIG
 int module_sig_check(struct load_info *info, int flags);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5399c182b3cb..12ca6c6d7efd 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2710,7 +2710,6 @@ core_param(module_blacklist, module_blacklist, charp, 0400);
 static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
 	struct module *mod;
-	unsigned int ndx;
 	int err;
 
 	/* Allow arches to frob section contents and sizes.  */
@@ -2728,22 +2727,11 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
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
index d1c43309bb25..598f89195336 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -101,3 +101,36 @@ int module_enforce_rwx_sections(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
 
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

