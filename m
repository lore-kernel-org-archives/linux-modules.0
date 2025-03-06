Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA220E03A
	for <linux-modules@vger.kernel.org>; Thu,  6 Mar 2025 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266933; cv=none; b=gdkF698oGIOB9fW4C732DNTIFBkxBw6raiQkvmnuAt5FamTyyXUFbmBnDzhsBEo/+lKTRIyUMHsyydBRDzdXLyo8JAnGPMPpNPU/6qyfOA587RYtlpH951UmjLfFkF62RdFhBCC1NZUHhnjHLhrtStIn4B3VEma3wv4wyo4sgFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266933; c=relaxed/simple;
	bh=BvSlaG3rLjNuw2XDjvoJaB0XtiXWFz6skWwh3t2ohzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tk3H5nCCTuO8igp6tErj+DmcpWLXenVreuTAGPfHUUV8a+Y5gqwoEAE7D0bM7BQBQnWnSYt+i5C7SSzXfHH0Rnr2hlEX+yq/EFlbaGj9C2zQhIG/s4gi9bhzoDSpyjjjOLHoPZ8Uyb4LslIVwrNGYWZjovVjReL+QefjpSyPJhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OvORDHt+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OvORDHt+"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so3976495e9.3
        for <linux-modules@vger.kernel.org>; Thu, 06 Mar 2025 05:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741266930; x=1741871730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pj78PG0pp5n8PTZUVZot4fU7c++ftFca2ezsst8qrio=;
        b=OvORDHt+NMLiOA+Iolz2wGqz+F4SlpHLd88MJytIqHdLfYYUzFL1FHQEnbdfe0DR+T
         aJYDJcZq5Xu3a31EuLHW/TsVz0VxJzF3tOveXIL4x7hnIZgy6XoY1bKH4kEJ+0fyTwrL
         q0P54ei19rJkc5tZgg5W2Th822C1/TjXoZf+u37ASa1D9LZRZTETzFUygTxNOPtrnnvF
         yL9+9mTT36rPDToP6e9ryvC/Smk2OZ0erN1SauT5WY560NSp5dcHMUzlDGGmUx8EUNlo
         ydszgzldoB7Z1CBjlaRbo3ltfkkGplru1mdc2Y4Aof+/925O+VRuLvQENco4dT4MZKd2
         elqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741266930; x=1741871730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pj78PG0pp5n8PTZUVZot4fU7c++ftFca2ezsst8qrio=;
        b=afi3pcWQCZT70n5hxPT4O1RnSW9jKBmXvCzbFM09+nssWD9os0ufqg7lNO39bF8BFv
         oqOiLN1r4pD8Nn8oacL+hcmaUv+2nntwKnlegYP4AQ0rDIFSuyRFLCBNol9fYC3BD2sY
         YZk+QH6Vij7sFQiRNn0AUTMh2jhvYgC2P9PpWvorc7hvMDRMvn/+tzFlNQ29/V+kdKo3
         jKdu7K5fxZ4CAN6h3VPBwkJi+zSBX9YsX9qUkse/w/BOmgMk9QQBsMH4f8ywVgCWS/fr
         +vRxbLlAi4OzucLHTlS4vFBZa6Qn0zd8yG9RSTG3vrxhLiW1mOleI8ltsIJnwNeKFMTs
         rREQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnBFEuzUvjQKge2RMXTBtlMrlPTePbr/gkPo35pWBCk/nEmuvlFGiFWDO1/wHH617ij0G5Fgwfui+wFmtE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7+3fDA3EbLF3+SwWP0ZBvB7bMwcVlaw87kyNNXNXKXfU5/Ma
	T91mLQcIspNDvo2GoR/ZvBfNXH6x/axXsxIQcif0qoYM6pzl+Mec5bwvXVQHlb8=
X-Gm-Gg: ASbGncvU+mX8VqFE6r9sqRNm5AIKAOX7TQa95SLGz9SvzSd7L6fv4CJkIGpeTmxRHf/
	e1P4votDVUvuhtAWSBpiM7AgNXvOhPeGvrFTl8kR44qPQ+shlpj47KabzWnIQbWHgGxZ5q6tfS/
	0r9WFZ9IxhEyW3GZSaJ9CRnWCcRrjka+VWRWU9IBvBh6HhtvDF4lIEmBvSoe/9F3IxXvprB/VSP
	Kj02tS8lNvmokFSFcvpHUeT4zA/nDPLgG4aMVcfo3AQvxdeqeHiMqz8qZAjr2g4D3NbRV/wjJzO
	/+24O7LqUT0/KYsnVPqMVjqRGydwAftr94+gUsgGwyhNm8sH
X-Google-Smtp-Source: AGHT+IFr54SyRcHfD64GHzzREo8VdfNOB246KLkodyLGDvF849R5Dk9GM2hPiS0mwZXhRJQCfmy98g==
X-Received: by 2002:a05:600c:1d02:b0:439:91dd:cfa3 with SMTP id 5b1f17b1804b1-43bd29d8db3mr54480605e9.29.1741266929975;
        Thu, 06 Mar 2025 05:15:29 -0800 (PST)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8c327fsm19704485e9.13.2025.03.06.05.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 05:15:29 -0800 (PST)
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
Subject: [PATCH v2 1/3] module: Constify parameters of module_enforce_rwx_sections()
Date: Thu,  6 Mar 2025 14:13:52 +0100
Message-ID: <20250306131430.7016-2-petr.pavlu@suse.com>
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

Minor cleanup, this is a non-functional change.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/internal.h   | 5 +++--
 kernel/module/strict_rwx.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index d09b46ef032f..18f32e791db0 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -333,8 +333,9 @@ int module_enable_rodata_ro(const struct module *mod);
 int module_enable_rodata_ro_after_init(const struct module *mod);
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
index 74834ba15615..81278e687055 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -86,8 +86,9 @@ int module_enable_data_nx(const struct module *mod)
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

