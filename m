Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CED3A9002
	for <linux-modules@vger.kernel.org>; Thu, 26 Mar 2026 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560103; cv=none; b=XzXwi+T6i4GF2QZ10jmqn6HbnHT/54WWpq9xIgxxCRtxn0loHhtXFMgEElQHfrbPqow0gGpXnC3jrS1tKRcNePXtOBOSBu3QQjBxI/A1EmjWjqInRnHJ4ixhN5VrVhUG/DecCBbmSOBYR1W6LQoNYY37y16EQhGojpwJdEy/rOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560103; c=relaxed/simple;
	bh=YJ12M66JVdOPpUyl/ZnRqsezMQxQSFmDChR9hjNAYhg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RfTz7o8pzCCJQgVmLjgOBa8iE6T75KqSDWbd2ZJOl57xU8wx8uJuPPw8yRk7FoPWaaqK1tSm4wbfYFufL/qolvxtAmxbou3MJgaEZIoI8jmb7VdMyMjWA276PWUf+j7Q3jZMqO7x6v+uPdmyB0a/hajmbNoqnYGWfRUv9VBs/jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A66LlWSn; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A66LlWSn"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b9399d68111so175552666b.0
        for <linux-modules@vger.kernel.org>; Thu, 26 Mar 2026 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774560100; x=1775164900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aGYiW8Rqw4kRzbw632ADCfNRFJHG+c2ihwrVrUq2DSI=;
        b=A66LlWSnTmXuhiNodjP1e0XL9V+0cM3AjT/FGZ1x6y1rc7R2YdvFKisvEF6seR+Qhh
         8gn7ZGeYWattf87yAWHl7vBPdJP8w7dcmzDrPU7F7BQWAaO++QNMtAz1z3TWBe7WZsUO
         n18KBfH1Pbf6rYj9iKRFfR653P2D0nPoa/Nqr3OCabhUQDtjMvb8dQPUB7Et0WWFDYZb
         BDs9HGxUiClz7kTC+JS7CcrOdYzk+YIIkzwFgM5pSO8tDO31uu5H3p3Ify6ppNwTUSjc
         wxy5MBGUTwQotH4vDU6NBjXpDNo1TEHAMuKgE279zdN4zzXU/STqmm7Cs63N5mt0GZFV
         Phlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774560100; x=1775164900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGYiW8Rqw4kRzbw632ADCfNRFJHG+c2ihwrVrUq2DSI=;
        b=GObd4DgcItdq7eXxeA7O2Ft7mSFNIvcxQMT0uI7W3FPUWtlFvOoqtktrPyWn6PBnYn
         jhtGEhCEwqGFrv/X9e6L+GcUmLJfz4EykLCmGD/ZOOByEjHQmBSBcY+ZllW1eX1fY96Q
         vV0lNETOhRSeOEOkX+kyd2JO22e3l9cFx890c8PnC7KWYY3cv/+fXlNqmB6qPvfSawEr
         hqzleaPn9pUAwfDKk54CNAPUn08nhBADzU7ZP45in2AnLAP7nMsrBvcPCj4751UlDB+s
         MPuEZByZl5SW3Rxsm+TIoh1d9BSoMTO3TotrwXaCayIXJD4SWVoJxt6EI6pzTfvwXW/m
         6bcQ==
X-Gm-Message-State: AOJu0Yw1SEvqhiZ9t60LdR2WORAeARYuqf8uXKzOEkvNDItqQZ1Jxa+w
	BRU874HWlkzQafGe9f8isSJ1SQcii6CQQVZAH7UbEXVrHSnJSry6qefge7wpd7PAauevAaD8+SV
	cE8uWH4/DRA8L1mP/sw==
X-Received: from ejdao21.prod.google.com ([2002:a17:907:f495:b0:b94:2007:4d01])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c1e:b0:b9b:38d4:2cea with SMTP id a640c23a62f3a-b9b5036d57dmr1187466b.23.1774560099877;
 Thu, 26 Mar 2026 14:21:39 -0700 (PDT)
Date: Thu, 26 Mar 2026 21:21:34 +0000
In-Reply-To: <20260326-kflagstab-v5-0-455cd723dddf@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-kflagstab-v5-0-455cd723dddf@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260326-kflagstab-v5-6-455cd723dddf@google.com>
Subject: [PATCH v5 6/7] module: remove *_gpl sections from vmlinux and modules
From: Siddharth Nayyar <sidnayyar@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-doc@vger.kernel.org, Siddharth Nayyar <sidnayyar@google.com>, gprocida@google.com
Content-Type: text/plain; charset="utf-8"

These sections are not used anymore and can be removed from vmlinux and
modules during linking.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/asm-generic/vmlinux.lds.h | 18 ++----------------
 scripts/module.lds.S              |  2 --
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d64a475c468a..6f47c4c56574 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -508,34 +508,20 @@
 									\
 	PRINTK_INDEX							\
 									\
-	/* Kernel symbol table: Normal symbols */			\
+	/* Kernel symbol table */					\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		__start___ksymtab = .;					\
 		KEEP(*(SORT(___ksymtab+*)))				\
 		__stop___ksymtab = .;					\
 	}								\
 									\
-	/* Kernel symbol table: GPL-only symbols */			\
-	__ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {	\
-		__start___ksymtab_gpl = .;				\
-		KEEP(*(SORT(___ksymtab_gpl+*)))				\
-		__stop___ksymtab_gpl = .;				\
-	}								\
-									\
-	/* Kernel symbol table: Normal symbols */			\
+	/* Kernel symbol CRC table */					\
 	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
 		__start___kcrctab = .;					\
 		KEEP(*(SORT(___kcrctab+*)))				\
 		__stop___kcrctab = .;					\
 	}								\
 									\
-	/* Kernel symbol table: GPL-only symbols */			\
-	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
-		__start___kcrctab_gpl = .;				\
-		KEEP(*(SORT(___kcrctab_gpl+*)))				\
-		__stop___kcrctab_gpl = .;				\
-	}								\
-									\
 	/* Kernel symbol flags table */					\
 	__kflagstab       : AT(ADDR(__kflagstab) - LOAD_OFFSET) {	\
 		__start___kflagstab = .;				\
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index d7a8ba278dfc..23fa452eb16d 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -20,9 +20,7 @@ SECTIONS {
 	}
 
 	__ksymtab		0 : ALIGN(8) { *(SORT(___ksymtab+*)) }
-	__ksymtab_gpl		0 : ALIGN(8) { *(SORT(___ksymtab_gpl+*)) }
 	__kcrctab		0 : ALIGN(4) { *(SORT(___kcrctab+*)) }
-	__kcrctab_gpl		0 : ALIGN(4) { *(SORT(___kcrctab_gpl+*)) }
 	__kflagstab		0 : ALIGN(1) { *(SORT(___kflagstab+*)) }
 
 	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }

-- 
2.53.0.1018.g2bb0e51243-goog

