Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2E38D6B6
	for <linux-modules@vger.kernel.org>; Fri, 27 Mar 2026 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774598465; cv=none; b=Ynku87WH7tkdUZOlf4hIl2njxZscwmLc38+of0+zWNyLSaVtSQ3/mIGdxCK1oD/O2gJJiqkOIppKkRfisEBk4fbXPSERubjYAPzC4Dfo+zKGMF3bazpzJ24m7oe/6UR8SCMTc4fLCaj5ZHvXBX+Ejk0J1gEW8AAJt/D7w/01BEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774598465; c=relaxed/simple;
	bh=JWfjR/RTCXmZyEk+4Tx2iEnYpR1e4qTFsejI1js9qmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGuY5aqXfFGe4lc3A3QCLfrJ/kHz4Lmz2pcPiWXw0PQS0GgJOSC+a3h3BiVd1vfvAzG319b/PmqBBJ9825aa7mUri0IB6WkrqNqesJnvX/SwcGRNqlCKXt3COV29nwgzdUyLYQEROBs2XB9nkvaMk2GQMOF5vTkDhfVpneGRLyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=asSHicuA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="asSHicuA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486b9675d36so15983345e9.0
        for <linux-modules@vger.kernel.org>; Fri, 27 Mar 2026 01:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774598458; x=1775203258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4moBxHVs6SiILsKE/Pxveo5RaXduWTr95oeVQa3H18=;
        b=asSHicuAgkTGUEaBuYI1pK/H2Fzu1ZZdsIgrBp4rkN+fykqRLJox6DOtm7rqPOui4K
         f4R7iwzB+Sb7oTg9FM5p6Nt4BtV4R8nFWPShDqmAgm7ZHgNpiyTfZegUTu/g6IXRqUEF
         QHh7cpEeRQLPdY8X/JW0UkALoGYwYtw5KIO3u+5lksUV0hlO7NB0w1myMglA36nOmX+S
         19b3EDc3fPpEt5zSYQyVb6l/VORM0sO9w1AkhKuoxCqBm66MOgIU+iJ8w6RK2HDDdq0+
         2GCoJ0oekPr3LtYIlHGBALb4O5nwS7Ja8RfLfbCipwJsqBvR0JlAqJhmZB8qUqtQEH4R
         axqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774598458; x=1775203258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K4moBxHVs6SiILsKE/Pxveo5RaXduWTr95oeVQa3H18=;
        b=QjWRQF8zkRtw4fGoFzSJg010u7ojMI542AUDhCqPrhZ3XVpD1ihUhn2aCjFFSZPmDk
         NN2JXATB0tcbYUs16GdXL6J+pW2f80OFxis2OCYUJQy55hgGzdZNF6L6+HMwNOuMo1Sp
         rtdnXxr3Kwu7Jw/H7VwDTqFJ4tC03zah/vzX67VDj78QS4AOv7ZLj6K+yjQbgntMTweG
         TtuW4FwXbD95682Yf2YseipeOWR8eM7BgOCkplSisV48DRYtsETwjVr7nw5lQQ9g1835
         ViDYBBq/B8bqQSDBG4Hk0hEzxe4RX6w2yExWYBFudkIYdURerHTiiyAUyFXRd4/nverr
         oQww==
X-Forwarded-Encrypted: i=1; AJvYcCWcG1CzQ+9ORlToQMonUhXdmRc3Dh+e49UoSPzMF+dJMR2naEotRmG3j4KLt9etHWkddx9h2r8aJEUI4uHe@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl1o7qPgDiNZ51X/8wx3xbcrs0hoZCmSyBwWuGWV6yNAbZ0xKZ
	usVZCs4/E5kmkIebB4zNPuj9ugPsxhy4i0R9rYWq5MANCaDxViDqAshjSg8fzIR1soQ=
X-Gm-Gg: ATEYQzyxxpoCP+IARU7l04zm9Z/AYmhpZch/olKjjjKU7ia8zivLG5nHcBDmBeOxMpU
	QSXbx//NmyHxc6Y8xZ+5y1fTBjomVEbOtYR4g1BQK6pzlO+tSiBtZazgky6qwUQ1kFh/S+lYJfk
	5zFIZ6x4nlBEdirRD/zLjgER0TC6IStVsfT+0g7RylANj05/ZipDvMLPmsh1XN/D/vwrapEVy58
	mfluSORAxGeSw7BdeUyziSp9GpHkBFMcYRrxuo63249K+IpulcEF7jz11y7w3oIL9622Fg5s1eh
	OMA1qP5DpH4fIVhjQI9FaVU1p+9Ee2Lhp9cx2dqs6CisFqse8awbXOh5MVgfGN4CleRNZu23+Ay
	4k5k808/Spn+Lbs/v1LdkBspXxUoSknifZ7womuZVXQnCD5c5o5dI1Qql8ZOrNpj165YtEFCFrs
	tL2sb7p093oZKpvcuNQEbydOywcO4OH4/Cl4jokrpP
X-Received: by 2002:a05:600c:19cf:b0:487:1108:48bc with SMTP id 5b1f17b1804b1-48727ec7695mr24399785e9.17.1774598458048;
        Fri, 27 Mar 2026 01:00:58 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725fc4827sm12089735e9.11.2026.03.27.01.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 01:00:57 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org,
	linux-riscv@lists.infradead.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] module, m68k: force sh_addr=0 for arch-specific sections
Date: Fri, 27 Mar 2026 08:59:02 +0100
Message-ID: <20260327080023.861105-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327080023.861105-1-petr.pavlu@suse.com>
References: <20260327080023.861105-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When linking modules with 'ld.bfd -r', sections defined without an address
inherit the location counter, resulting in non-zero sh_addr values in the
resulting .ko files. Relocatable objects are expected to have sh_addr=0 for
all sections. Non-zero addresses are confusing in this context, typically
worse compressible, and may cause tools to misbehave [1].

Force sh_addr=0 for all m68k-specific module sections.

Link: https://sourceware.org/bugzilla/show_bug.cgi?id=33958 [1]
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/m68k/include/asm/module.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/module.lds.h b/arch/m68k/include/asm/module.lds.h
index fda94fa38243..fcd08689b282 100644
--- a/arch/m68k/include/asm/module.lds.h
+++ b/arch/m68k/include/asm/module.lds.h
@@ -1,5 +1,5 @@
 SECTIONS {
-	.m68k_fixup : {
+	.m68k_fixup 0 : {
 		__start_fixup = .;
 		*(.m68k_fixup)
 		__stop_fixup = .;
-- 
2.53.0

