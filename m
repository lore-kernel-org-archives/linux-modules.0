Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F013C9891
	for <linux-modules@vger.kernel.org>; Sat, 22 Aug 2026 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406849; cv=none; b=DtNyOu/I4C4QN8NOsrDguOuDwWiyIZ1g4hC+k8Fe2Ryjw29QEsj4h2WfUoFS04aTA6qexFp4egN0CwDsnUhE9rqN8vJ/qgvIe6as6u4gOZKWBTFm6K9x0sgV0sIelxInWBLitw9W8XkZPkDfYiMFlJ9K0orBD8eNAsbTYbDqhPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406849; c=relaxed/simple;
	bh=eyMdQms5h38vSRYfAWR0WcETsyXaqJ5IJyvglyGQo3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CsnihfCLOyqrvBZDU+pbEb1f9ThKsdpCe+t2KICIuPMA+QR8cMunbbnKxEqpXE5WqSlYml3rG1y+7Xo3hGigd6R2dXGPHhWPWPeFLHZBpWVDGYVtfYJATFY1LUyzf5+pI8EqCCDvQ6suLj8dfIF8/n6mryE14iCl7BEJvijFgTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y5lsYzjc; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5lsYzjc"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767b782so11841495e9.2
        for <linux-modules@vger.kernel.org>; Sat, 22 Aug 2026 06:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787406845; x=1788011645; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hkCM63s99i91p1PpHDumOCyyQdfuhx7OwD6Jd3t1Lq4=;
        b=Y5lsYzjcfdqLMLXLcZZQUwStHswCMeFGu02DpVcS1iXPH1gVnDy2xzSgULZF8sxmk3
         n8XGkg4CPwyB51MEmBvZ2H+clgoEF/X9hnSa/SX8iyZRQ/UR4mtQb5qW7T0F8YUJZvZZ
         BBOFL365Ua/UQkip4KtvXdAYSgA8G6LF1uPOrz9RmVVO6IoURnc8DTuFMOqnkd+onjhx
         ZC03DV1kEbefpEgKoGujQD1KOFClhkJJTbdhIltayq8QWfw+bIAxcjROXmf5fiNeVJYj
         CaXjPGjVKOvOvTSYNmcmPwbeTDdhdZUjVoCb76tgyULYwBePR7wRws0v7Sb6wIEHGKQy
         dvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787406845; x=1788011645;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hkCM63s99i91p1PpHDumOCyyQdfuhx7OwD6Jd3t1Lq4=;
        b=Q/0Bm5cE/8Ma6OSdlMwCpLo01GnsfeCoSZ8/RnGYxiAmOWKtr1yH81GS5Hv80Zfijs
         jzz+Skqfp0m51EEbBcIhoTcjvCBNG6/fIDsDqThqe8oGx5nm1OCWLYQahnaF7rb7aqjW
         9+P4dLFqsmnNfp51R8JNXcWsKfy/C2xoUO5fyd8LG8qD2ouYdBPAmIxCnp0kcjQ/bvnW
         vsZ+Z2sXA3SYllMTDyYkLb7SACGiQEPV9IkcVaHexP6g8McXv+7ph1Cv60b3qLTApUq3
         DX7rRBA4J7PYmZMPDSbzAFeu2SsDn7RlRhZ5Rx4MN3NFIkOFkh2J2wdIj8G9gvMAsdvE
         HxRg==
X-Forwarded-Encrypted: i=1; AHgh+RqmH33EVT4xVInvCtjHfVYC0nzjzajPZsNTz8KyaBNKNlcTOdJ+GPDnzXFlXkA113/rTC4JJSvkhGmUNWUj@vger.kernel.org
X-Gm-Message-State: AFuF++neFCvADgJH4WJi+M7zV6yYd5A7v2smQjFX9CZ7zvJbSEEjFBxn
	7pJQnV3rsUxXzpB5Yg5YMZEBIATpJp/r5hEf04seeDXSVsXUr9rim3bqRg1n3k2evdsx7Eza1Q=
	=
X-Received: from wmsk20-n1.prod.google.com ([2002:a05:600d:8494:10b0:495:5b3d:ed8e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f87:b0:499:5a50:b022
 with SMTP id 5b1f17b1804b1-499b830d220mr157713495e9.3.1787406845321; Sat, 22
 Aug 2026 06:54:05 -0700 (PDT)
Date: Sat, 22 Aug 2026 15:53:24 +0200
In-Reply-To: <20260822135323.795946-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260822135323.795946-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; i=ardb@kernel.org;
 h=from:subject; bh=P7ZGJgEcYK0LKyyPgb8fkUAxKeezm6n7kbgZPbKu2yU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIatz5TWxr2KyTbZTbOpLO1+U67/Xi9h1eWvb4iPcl4w+S
 bRJZ7V0lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIms3cbwv5ahahdT+LH2cO82
 t1yDecoKnrvaJgjtU5h+/th0FT1bD4Z/Wub5/n96de+wmHSaPL+t1b4gf0nC0eXNz1JN5Yqla1c yAgA=
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260822135323.795946-13-ardb+git@google.com>
Subject: [RFC PATCH 2/9] mm: execmem: Allow huge vmappings to be avoided for
 execmem caches
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

Only recent arm64 systems are guaranteed to be able to manipulate the
permissions on live kernel mappings that may use huge mappings. Older
ones can only do so on live mappings that are mapped down to pages.

In order to make execmem caches work on arm64 despite this distinction,
allow huge vmappings to be omitted when allocating the caches.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/execmem.h | 2 ++
 mm/execmem.c            | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index 59bd862cb061..b04926f3fff2 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -48,10 +48,12 @@ enum execmem_type {
  * enum execmem_range_flags - options for executable memory allocations
  * @EXECMEM_KASAN_SHADOW:	allocate kasan shadow
  * @EXECMEM_ROX_CACHE:		allocations should use ROX cache of huge pages
+ * @EXECMEM_NO_HUGE_VMAP:	cache allocations must avoid huge vmappings
  */
 enum execmem_range_flags {
 	EXECMEM_KASAN_SHADOW	= (1 << 0),
 	EXECMEM_ROX_CACHE	= (1 << 1),
+	EXECMEM_NO_HUGE_VMAP	= (1 << 2),
 };
 
 #ifdef CONFIG_ARCH_HAS_EXECMEM_ROX
diff --git a/mm/execmem.c b/mm/execmem.c
index 6db0c1d82a9d..5790d4a8532a 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -276,7 +276,8 @@ static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
 
 static void *execmem_cache_populate_alloc(struct execmem_range *range, size_t size)
 {
-	unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
+	unsigned long vm_flags = (range->flags & EXECMEM_NO_HUGE_VMAP)
+						? 0 : VM_ALLOW_HUGE_VMAP;
 	struct mutex *mutex = &execmem_cache.mutex;
 	struct vm_struct *vm;
 	size_t alloc_size;
-- 
2.55.0.860.g4b6b3295ed-goog

