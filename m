Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A5E2E9EAB
	for <linux-modules@vger.kernel.org>; Wed, 18 Jun 2025 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249690; cv=none; b=dLSdk1IkGvlmh+ZBQLx4VRf6cAVT9PITgKAWBKpuQS14HJvChgLz/eiHIG4CiNN5LK2Grjwtp5AAkUQ5tRaA/+8q3Y5xA4FgRcENEmwL9K/lk/siAUhhkyzU2p+E1iaetsN4YiX+Ek2Ta7lcJouiFjpAgDZ4mBzD54WjInXS5vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249690; c=relaxed/simple;
	bh=U8U0hNHT3QH0f69IVy2wknKdqTX3ZKFcKNly9nulzEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQMZ4QPLutRuxiru6P0tGXa8w3Qys8CXZzoyGrdBRTpdztYq5Khf9kAq/OXYXTWBDRAnx1QbgyCQyz744voJ0bxAhlzSk9Sr4W5YonG2nD2zInFJYl3sFYtxSdffSnyaoVg43Arx6v0Igc9nixsC1+4ujstjqH/ZVYXeyofKZOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EfgsISaV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EfgsISaV"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45348bff79fso43468555e9.2
        for <linux-modules@vger.kernel.org>; Wed, 18 Jun 2025 05:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750249683; x=1750854483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q92YfRBQEU1POkirja/ISaBqRuTyl3kSPT8DksJEY5Y=;
        b=EfgsISaVotTIsC1+kkD0pcLs5ldiYnHjAZ6j3W+Rw8n77LTXcQMoBJa5NVXCPVs9RZ
         nVVnPA/pQbsyICJZUANn/ZmfbMpseFYal5dyBPSO+68ePTeKn8XIEhmkZS6ZX730f7n3
         p6+lDItOHiCbWoLTad+FZz0RDwyQnC4Dm2d7vsn8hWuUB7cS0yOsH4WbkwIX41vCcExp
         ynJDvgZqb6ToE8M6SYJWw4AeJh60Ux5Rh6MkWKh6lpZnvuSsh/ltoyKmsp+/yMqaQknp
         0emtGnZmWNG2l7Qyrc8Z7qVU75L5J+4KyUvg6CJKNpFCZeyWtcnOKZiKds/b+X8GW0OX
         Xfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750249683; x=1750854483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q92YfRBQEU1POkirja/ISaBqRuTyl3kSPT8DksJEY5Y=;
        b=fImWl/TwUZ8/nd4i2zl0MAMNMFtxHUPTanDH20nVdjojHJpZ1QNZqnfQ1g7TxoVAem
         cGEz7akvkW3BlzH5gZVgZVVEsiiEJ+OPeSW1/m6p+8yz0giwZIAfrA+1e7sp7ADhpxVh
         ZlOXQlA2ZqKhQH9M8mZYIfin6nzKFAjhXBNpQikTHP+38nGcmIxGUqbAfREU6BRhylUh
         Sp0eFsxkgw160xkFsd0wkYYnTbqlj//Ct6KLlGdcSiti2lzlylbjiTy27PJTLhyz7447
         dn4KTtmgcicnWhL9PM0i6albq56S0pDmTA/F1YrNPG7d6tc6vNGDalkWyZOyPZa3VadK
         xcJg==
X-Gm-Message-State: AOJu0YwaG6EWQ11BxpTKleS2OUmxM7COGTLd0ATDX2cRt2deGUOYRElU
	odegVbZ1jRFVcYPpT48quad8YL3t519ggUozfreCou7HnFSz1eZODn+Gh0RGFrLLiZw=
X-Gm-Gg: ASbGncuvHyuCkQUgAOGrDkIUpE2WWQNScL1V9oOkFCsFNgXmSRB43zTS/s/aCnmS/OQ
	cvT3qx0zaBxbB1h1IfOsgvzsQTmDn9Ta/hC4MESY3UKPkmaHdT9hDkIOX41/+/Zx3Ps4zODLrCN
	RaR+uG16oPpstQsZGE39nSP3HAV7JE83AczkbBhFr8AekBzVDxt44dpEkcV6WwaPyXNIjcz7VwR
	+ioATv8oudcYXURhQzeQrYGNBQDCArT68Ykz0w/e+kDp6skCrg9T6dlrjsMyCnUM2GmITzBUDpX
	rlXomRVZI8uwgnXTDmrUjYELvs8g7jCvfmh2frNflSNkPHogeMgU8I5XqipFpA==
X-Google-Smtp-Source: AGHT+IHAY43bGXTcfbb74SIoOCl5KnBfYsgeA8erQ2AwmXjLU96NDulChk0hUzZggqfaz89QgdOSFA==
X-Received: by 2002:a05:6000:400c:b0:3a5:2e9c:edb with SMTP id ffacd0b85a97d-3a572e7969dmr13405814f8f.47.1750249683450;
        Wed, 18 Jun 2025 05:28:03 -0700 (PDT)
Received: from zovi.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2449f1sm211215125e9.23.2025.06.18.05.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 05:28:03 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] module: Fix memory deallocation on error path in move_module()
Date: Wed, 18 Jun 2025 14:26:26 +0200
Message-ID: <20250618122730.51324-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618122730.51324-1-petr.pavlu@suse.com>
References: <20250618122730.51324-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function move_module() uses the variable t to track how many memory
types it has allocated and consequently how many should be freed if an
error occurs.

The variable is initially set to 0 and is updated when a call to
module_memory_alloc() fails. However, move_module() can fail for other
reasons as well, in which case t remains set to 0 and no memory is freed.

Fix the problem by initializing t to MOD_MEM_NUM_TYPES. Additionally, make
the deallocation loop more robust by not relying on the mod_mem_type_t enum
having a signed integer as its underlying type.

Fixes: c7ee8aebf6c0 ("module: add stop-grap sanity check on module memcpy()")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/module/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 413ac6ea3702..9ac994b2f354 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2697,7 +2697,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 static int move_module(struct module *mod, struct load_info *info)
 {
 	int i;
-	enum mod_mem_type t = 0;
+	enum mod_mem_type t = MOD_MEM_NUM_TYPES;
 	int ret = -ENOMEM;
 	bool codetag_section_found = false;
 
@@ -2776,7 +2776,7 @@ static int move_module(struct module *mod, struct load_info *info)
 	return 0;
 out_err:
 	module_memory_restore_rox(mod);
-	for (t--; t >= 0; t--)
+	while (t--)
 		module_memory_free(mod, t);
 	if (codetag_section_found)
 		codetag_free_module_sections(mod);
-- 
2.49.0

