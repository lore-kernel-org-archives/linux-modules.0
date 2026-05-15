Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CA4426EDD
	for <linux-modules@vger.kernel.org>; Fri, 15 May 2026 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835510; cv=none; b=jGmEmY9J/9KEdqyczA1xkIHNwkt4407Hv6UIzzkIzURfi+h7bDUmsv/t+wB6FspuPuXRyn7Y66bNPUsD3xXFfa3w1vtachYPjy4YoLzIe1LHq+V1JxkzvkLmRqz4azjC1ulXE5rCVwmhsn17Ka1710JLYl27lxXTHg3OU6pMlVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835510; c=relaxed/simple;
	bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T04VaXHth4IUb/2XOqYEqLHT8vhQQhdO4YAP9Rq3ioRo6r2Rl12Pmb2hpq2X/PXuzp7cuioH+hP0CIq/Q6AyoqZg2PtPZQvsmeoPTJFhLcGykAzLyRrxYNiIc7TtFlrANzCKLQob4GqnA/fX3ySmYC3wRzjn9bxgUIX14oHZOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SE22AeMa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE22AeMa"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48896199cbaso76901435e9.1
        for <linux-modules@vger.kernel.org>; Fri, 15 May 2026 01:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778835507; x=1779440307; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=SE22AeMa4y0p9G2ebtHOBT6PoM5knccgVfQTg/7dbkzFc/MuTKZUUgNeQlq51wMrec
         szh73S1rntMT275Hu1JOh/xokhqmIdr3nxE4Y00nHBI24oMB8hWS6WUk8te5u4sRj13X
         i8NV/Vt1A/D26GBHsQbJz8B/UBj+m2zGj/8PKWEtPzKplS9Ye73xMKBc/Pln5kU2DRrT
         4jGVAaGsx81YzU8IlZSfJmdZTXlsZ6UbjGI/V25Ews/lcjAAN3E7oL3pCrnK1Kv1zfEy
         k/tAzIQFvQhSUDJo6qEqFaOnmitqJTsz2NwFY0gqQpN1eZuDTN7YMLDEFxgywK8Vcror
         VSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835507; x=1779440307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GsoCp+QEhPQqcC7YciJ1pPB6BZ3pQYi3CKXlL70tQeM=;
        b=iz3jbx1S8GS2g4QNLmysV6WhEOngHMAcrA//fWExMXfG6ru+xX5PTUjDy8jXeytrOR
         NhyxnjMCAMhQLOtuCwtDdszk4RYJj0nI7n/xwSDE/gH5M24nLr1oAxdFJpECVGBS5wRO
         Rlm55yZkuHZPCkqqIsclnt+rfWEnArZ8/+DfdPxY0P1mTD2s84KCL2jyq+ksIMZua9si
         2krSNJyeK9UNgfPjeU4ivB6obS/thTb6TWfQqOsM1Hv//Wt+XwYK8cnjwoZefdXohZrD
         Kc+aO2BumcrviuES5GT1Hr3Z3EBWVN30axcddehXzid5CK4z6d/yOKZRAXCcbaYXxLy4
         P70w==
X-Forwarded-Encrypted: i=1; AFNElJ/jU81y8jwc+wWJLwZBfkCw8Dfwa0ge0WtNN8lftwIkV09LAojxXtwHW0NVP50g+364rFJysvRKhn7oL5+Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHnRnbFoFTM6jCb/x7pZQgxxDwdzrvABDglSKpg21P9AABQ0m
	JUEyPed9Wd8CQWq3RnL6zpIL1Z+qAocNXjJk+P5Mbxh/mAkewEET7kra
X-Gm-Gg: Acq92OFFW1P+AxNZKKuhaQ8fvknwXjQtDGmWOygtmoU51qVYY71O4cCHdPttA5AqUac
	GBLM0umV36hlfA1EEWNmG/mBBB+x6vdJxdfSnRRGK7XWBWpokentvFFHvZCIy7yPIoJanX3yIiH
	p0CKQOTBOCnYjd2QT/QwVyzervjLo2uBJHAMlCYQebNJLlmQJWPrRVfU80GIULj9FsfwbHvYp5D
	gna9hcFLoXOUseQD8ena6xdfBy3GLWOW77u1WMTDQY14/FesEz4gpu2q0AnLBasBlAtsmKEBwZT
	ey7z1p5au5/xsUWpFPmbwilx3Qy560/p76w/owF81sznt8dfaaWd/CYawtPs4m5Xc5NDjz/+AP3
	3bFIOUdUO9/vln0OjR2/8mP3F1Oa5/Y0BgA6Itbo6re4f4SCgSH4ACvyxt6wjfAGTKuUNLx5r9m
	HcMOrPck7aPYapqmWmiuNHkJUZgBJqiFqP
X-Received: by 2002:a05:600c:a406:b0:48e:82cc:4d4c with SMTP id 5b1f17b1804b1-48fe6514939mr34162615e9.23.1778835507163;
        Fri, 15 May 2026 01:58:27 -0700 (PDT)
Received: from [192.168.1.210] ([2a00:23c8:33b9:3b01:f7b1:b7a0:6254:c325])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45d9e768c4fsm13142610f8f.8.2026.05.15.01.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:58:26 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Fri, 15 May 2026 02:58:11 -0600
Subject: [PATCH v3 2/5] vmlinux.lds.h: drop unused HEADERED_SECTION* macros
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-asm-generic-1-v3-2-680b273666d4@gmail.com>
References: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
In-Reply-To: <20260515-asm-generic-1-v3-0-680b273666d4@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778835503; l=1428;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=gyhl2dDHOhDRfo2EoLm//e3PBy86xHd/L/qSVe14+FQ=;
 b=L/oP8BWsqawvQgaTIpLI6bJW6/Dgk4EFPfl3GtndwTpLopRn4f5F/IvWmCxuGgLxeV/fs3Zhr
 YrEnU2EC6gxCMJd+euyuTbKN+TDZyBrca3AEmHlpVirwpvcxkl2/JlW
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

These macros are unused, no point in carrying them any more.

NB: these macros were just moved to bounded_sections.lds.h, from
vmlinux.lds.h, which is the known entity, and therefore more
meaningful in the 1-line summary, so thats what I used as the topic.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/bounded_sections.lds.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
index 8c29293ca7fb..268cdc34389b 100644
--- a/include/asm-generic/bounded_sections.lds.h
+++ b/include/asm-generic/bounded_sections.lds.h
@@ -18,19 +18,4 @@
 
 #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
 
-#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_HDR_##_label_	= .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
-	_label_##_HDR_ = .;						\
-	KEEP(*(.gnu.linkonce.##_sec_))					\
-	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
-
-#define HEADERED_SECTION_BY(_sec_, _label_)				\
-	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
-
-#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
-
 #endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */

-- 
2.54.0

