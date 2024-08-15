Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CFA7174F
	for <linux-modules@vger.kernel.org>; Thu, 15 Aug 2024 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743588; cv=none; b=u+n/MKFvXDiBU1CB2C1T9/F/sASGfTonmitRVMBGwNrW0ZCWV6tIWMOODslfj1S3Po7wsnc/HKzEjgDH8SmB1n2Gc1rChPxZVVfhzDIFd5/ayeDyzOaxVLyIc9v9ULpJxaKK5Dwq9Z+K3gdtYvEipU+HOeRQNULXlEqMWV7Nc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743588; c=relaxed/simple;
	bh=JdHnM47y3DGHzd+8iOwDpRmp/jKwcxYBnVNDUzIM1Ts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FEQTRkg6DA4ki4dbdz7q6xHxFO2W2P/lxLS1Grq5qNXdC1IGtMUjO2QiSD9NfrkLEM9iVOyNDFmWckDX1iEopsUPfGCmyelTBgs3Zn3bPMYSZGZQtr09GmrKoT7PVO1yvMEPulRmavDYWXPvlKsYXDNn25Dx2R/WM9TIazG+o6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZM1lGGhX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZM1lGGhX"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0e8826e03bso2038301276.3
        for <linux-modules@vger.kernel.org>; Thu, 15 Aug 2024 10:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723743586; x=1724348386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nzfrcr5/2Jg+dBktFb/j3BHPnQVbNwPzVAym41fmhTI=;
        b=ZM1lGGhXjiDPhgK4at+h2mr3e1tDaZuDEHY6ZxxARgVSpnrHK1cTG+x9yd2V+ANGD/
         1U3IZfMP720YfOFQRWr6cButoOk765Ba/O23/T+KeTyJHVxH+yM5M2o1cbB60AqwZLsU
         uk2FRvf2K7HzzOlcK3RQSu02JfWftOCqkX/IVCQN/UDEPprGRzc+C1wFk96bonWWls6r
         0dAvuVwg0io3YD0RvI1WBaL70Oi2AF/FC2Gvu59u/OFBHXgsZBfWALkXzhZoIahf52pc
         h/+7/KfBaJyE+s5mgVygIieH/TOg9ORrVqUEQ5XKn3QP6ksR4nGJiieUCJpXgmI1ceVN
         MACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743586; x=1724348386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nzfrcr5/2Jg+dBktFb/j3BHPnQVbNwPzVAym41fmhTI=;
        b=I812FWGkhv1Jp6utDwrpH32fkH5jCMlGu7/Z5/AXIJQpUfU4Stp2LJDQ8lHgzuBNbi
         SeAZZwnq8Wf77x60NhpnDlOq3Esd7EYRu6I7xhTWXhddvHmpVcxg7e9aA8kmB7CGBxJr
         JZjp5r0YyN+/RGPy3fV/EyRODPRzZCjDuDQdefQnNm7oMa9ccB+6E4Cl+XSZ8k6RJjNy
         +7qVr840k5mIH2LFqKKMw4f9KabuL0+sRb+pxeylRdM3YPr7Qip7FeHeF2g1615Q1k9j
         dCj55o2zjHCjGNgphYv5TozGgPW0n3QqTGyrQFckdVDqAW3OenKEW3ZpT9e6pHDBKtsn
         pMiA==
X-Forwarded-Encrypted: i=1; AJvYcCU5AZKraq1rgQ7RFq28qfq52Wmp89fWMOu0Rp34DUa1mcR2ZYeshccl78WJ1DDLwzTuw3sigzPHWtfvaHkUe4dzroVqqNB+mTMjddWZcA==
X-Gm-Message-State: AOJu0Yw+7Q60yLQO2RwPfD+kBZ4arKVMVXHw3diX/8hP7lJI3d8ESwyY
	mz5WUunaOtxrq7gw290GptFRTBc8ysTLwXRmcibjXvcLA6NP7dHScWkmZD8UL8LN41lnpoT5Yu+
	zPaC9/yhaPpnofiV88vQTZMptuA==
X-Google-Smtp-Source: AGHT+IEyPYGVIGctM8flGqu9QR91NaZgOu+gmaEjFyDcEPukNhfYOFghBSH/3RMkvc9pPV1ROu/JBf6StL4PXETlzNk=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a25:aad0:0:b0:e0b:ab63:b9c8 with SMTP
 id 3f1490d57ef6-e1180fa06d5mr496276.11.1723743585775; Thu, 15 Aug 2024
 10:39:45 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:39:22 +0000
In-Reply-To: <20240815173903.4172139-21-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=635; i=samitolvanen@google.com;
 h=from:subject; bh=JdHnM47y3DGHzd+8iOwDpRmp/jKwcxYBnVNDUzIM1Ts=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBmvj06AdeqULMg79EuNtCXP+0M0mvzmV7eGmEL1
 TuO+ezyrdOJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZr49OgAKCRBMtfaEi7xW
 7lvXC/9FcJ2/EUgwUrKKscdKY50Al5IkUmE5/+LjfwqoQUfzZ3RY4s6dV6KbAcj4/Bhr2Xb4dt/
 2e9OMOyAkxPtsaxq2meNZWjTCOs5B1S9dt4YHoHFuFH7zcjd6gWIMJI8k1mlaXiZlcaS4yy3/fU
 3JI5uzSOu/9bidigVxQV1rgTfC5cAw8PKaMpTuiZ1mgPWAUrADAZMBpdO8sSULOKFzef1yk32ya
 89z7CW/fL0vwVz+9RZktwxObxSFIvAgmq5UkMp/Q0PS/lsj6kCbKsje6YaKlpgZys5otmjCXA47
 cwLMLAhG/Yr79l5URg1O0tiij11q9zeoKn+2tGUH/qOls7UpOgHzoGaqcBaQBhLm7heKDc4DG+Y
 ZT0AQdp9myWj0erPLfH9Slv3EbXdbYBX1fN1lQvOb2LGm0vExdj1vlXX2J5PPetMZ9f9eSKN21G bKZcAaEPBGqMik8HlMXvCBOIAs2VM0OkWTxp3tQE5pgq0BPWeb8KEp9M9H3mEzX8UeiQs=
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240815173903.4172139-39-samitolvanen@google.com>
Subject: [PATCH v2 18/19] x86/asm-prototypes: Include <asm/ptrace.h>
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

<asm/ftrace.h> refers to struct pt_regs, make sure it's visible.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/include/asm/asm-prototypes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 25466c4d2134..c82e68c8b7c2 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/ptrace.h>
 #include <asm/ftrace.h>
 #include <linux/uaccess.h>
 #include <linux/pgtable.h>
-- 
2.46.0.184.g6999bdac58-goog

