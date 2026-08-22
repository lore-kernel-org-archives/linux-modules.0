Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4EA3C819B
	for <linux-modules@vger.kernel.org>; Sat, 22 Aug 2026 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406852; cv=none; b=faV8fFTPf/bYioclotUtPCEPPWC5FSGYvHbLbxpbx91dSus74Vs/bjjcgJcw8CXTM7QJuvNAqzXdSfC9KR7I2txR9xd/Pjqr6ZjoonbPOSwCqC/NArL9AH4uVPEu+lzqY53Ib/QKSr1W3KCPL2C/msEjG2OwonkwI0sS9p1KsEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406852; c=relaxed/simple;
	bh=uiIKWGpvaKJ4qxRkg9sBdwn+FBNvv3fpEqROSd7N37M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KHIDs5PM+UhvgdiASRHScIFPigMyIKJxt5mqCJ09GRFoJIp3Iy0qt8zRSNYiibL46OTRbftWHvWiKXeq0SHA0eAAd/O4YkMdzbsuqZHnXEU2pW8O5YVnjS8aQoTEVDwHEC1kEHwaoG8YEoB1RzUxd04WGT2gJCkzA1huaU5ijnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pOsNMLzk; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pOsNMLzk"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4957287363bso10400275e9.0
        for <linux-modules@vger.kernel.org>; Sat, 22 Aug 2026 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787406849; x=1788011649; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kA/leMB5Bml9VvmxH4fPbAWvPl/SN0OCbc+8KnqiWlg=;
        b=pOsNMLzksKLk/4tYX+baqZH91VmGsWyitbrKqAVGzUFyST0WlK5k8RoAb/hRww6A4k
         cRz/EhzkxEDURp4fE2xP8tOP7V/SSeGwpVc4hslk7Lc6WZA4365qeBvI1jE4oeqvlkp0
         uHyUYb+34NPFJ2nzm7gGRUzxKS05W+KMqaGUCRiLmDrFjTHMYJgYtSDA7wmDRi20w7dW
         lAUnuy+UwjqrnmEad3MnvqAk0SsJVtDmmNfZIDVrK7+EpW8Zu6rhij00HXEHmT68y/Ze
         RhDj4ecj2JVOtGlPWe0tHKBzQY0gMgWJEZ0m+3ufz5WmP2aTOlzbxyYy1p4kLs0JNlys
         zNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787406849; x=1788011649;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kA/leMB5Bml9VvmxH4fPbAWvPl/SN0OCbc+8KnqiWlg=;
        b=AtLG/pMGKNKndI9YOnZULASXwxt8OWAKt8TbqneDVsOejWRK65LyYJh46YQCEg3w7F
         AoI5bUc/ujLUHYCpFijktdsJiOvwa84jXBiBDw5sNq3RQrbgy9Rxpg2C5/CQVix+rXQS
         zRsd8eo1J7YwPD2OTTPZcrilpJImwUE87XV6Nt+sjagz8Sd+GYlr5TFhEBUq6XyxHKLu
         +Wrx1vgDk7vZwBs4kAfEvREPtHAjz1I908MIHRvQcwO/7VQ42+WEA+hTAZLmq4rwXf7g
         edUF/uDCBKbJjgnUiuz6PZdN5Z0uABf0mqlYP3Ho4XAsDZjdrfXjy+WD+elZLapy+QgO
         2TVQ==
X-Forwarded-Encrypted: i=1; AHgh+RoyM51+i+d72L1bW6cHmgWUCEYiRzRnrmTEgrdYcnCSNNHBphrAqYOCyWRdtIpmfGtclgvcyPEKYmFdO+sb@vger.kernel.org
X-Gm-Message-State: AFuF++lybmkRgoI19hOh3m2IAjKgvCfFa4c0heVuGEN2/6Y5vANlOwjt
	cu19uT6cmltCVn6TahyyDeU9RWkIuEUn4j453Esxgl0oHxjziGHBSKdqjPM8Tv+etl6jt7KQbQ=
	=
X-Received: from wmlu19.prod.google.com ([2002:a05:600c:2113:b0:493:ae35:2761])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3584:b0:499:8777:ccba
 with SMTP id 5b1f17b1804b1-499c19f3a09mr55389195e9.12.1787406848610; Sat, 22
 Aug 2026 06:54:08 -0700 (PDT)
Date: Sat, 22 Aug 2026 15:53:27 +0200
In-Reply-To: <20260822135323.795946-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260822135323.795946-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=ardb@kernel.org;
 h=from:subject; bh=plFvUlms3IX09TbA06fuB9Z3i2CHbmXiXP7osp2wqLc=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGqJqduhaXhTLES9U3wa8QeLoLCFbLjTooS/ld4OUN8Ev+zVT
 4h1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmqJqdsACgkQMG4JVi59LVxbUQEAwLd0
 PDSvV2zyQlqIymz5n+L53p/Botvaje9PasDJEM0A+wcjClUJb3hpwyZuyoMYZ/HDrLzn0R7+g1/ X39juar4F
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260822135323.795946-16-ardb+git@google.com>
Subject: [RFC PATCH 5/9] arm64: mm: Permit permissions changes on huge vmappings
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Allow permission changes on huge vmappings in cases where no splitting
is needed (i.e., the region is aligned sufficiently), or when the system
has support for splitting live mappings.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/pageattr.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index bbe98ac9ad8c..20ff9cb273c1 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -169,8 +169,6 @@ static int change_memory_common(unsigned long addr, int numpages,
 	 * we are operating on does not result in such splitting.
 	 *
 	 * Let's restrict ourselves to mappings created by vmalloc (or vmap).
-	 * Disallow VM_ALLOW_HUGE_VMAP mappings to guarantee that only page
-	 * mappings are updated and splitting is never needed.
 	 *
 	 * So check whether the [addr, addr + size) interval is entirely
 	 * covered by precisely one VM area that has the VM_ALLOC flag set.
@@ -179,7 +177,16 @@ static int change_memory_common(unsigned long addr, int numpages,
 	if (!area ||
 	    ((unsigned long)kasan_reset_tag((void *)end) >
 	     (unsigned long)kasan_reset_tag(area->addr) + area->size) ||
-	    ((area->flags & (VM_ALLOC | VM_ALLOW_HUGE_VMAP)) != VM_ALLOC))
+	    !(area->flags & VM_ALLOC))
+               return -EINVAL;
+
+	/*
+	 * Disallow VM_ALLOW_HUGE_VMAP mappings unless the region is PMD
+	 * aligned, or splitting live huge mappings is supported.
+	 */
+	if ((area->flags & VM_ALLOW_HUGE_VMAP) &&
+	   ((start % PMD_SIZE) || (size % PMD_SIZE)) &&
+	   WARN_ON_ONCE(!system_supports_bbml2_noabort()))
 		return -EINVAL;
 
 	if (!numpages)
-- 
2.55.0.860.g4b6b3295ed-goog

