Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CDE31AF34
	for <linux-modules@vger.kernel.org>; Thu, 18 Sep 2025 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226316; cv=none; b=f6F6AVykis18toB4/Kg/m75xy1VSBsz9ChwfB0XmfqC3BODJBDtQFpgtn/n2EPx+6iuOWMfzVjlxCFWckTSQiqDP1WJ2hfLf4hVJdJVp+Y3UpIjVYGH8iaj6NQWLaJnIec0VACyH572lB45Cvpy0pdKU0+d2ujGKLue1AJZ3PEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226316; c=relaxed/simple;
	bh=siBuLk9zH13tO8g4aEZ+ghf0JyGMCIvgX+eqmUGKzyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEFVVUIt7b4phme73NnrKX1bEbHH+ZaRu6ouXyUns8PIYfZienSa0V+N1frDSnpqsl5XIyHlkQBrxkMEdyuQFieZQsisVkG+H9uQa06XogLW/ll9v4aI5jkNRO6Ct8CzTzJGIL7Sd3iNSpUODERhU9XD0kPZVGPbJ2ebvaJo65E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hz6ACzkx; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz6ACzkx"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-80e4cb9d7ceso182688585a.1
        for <linux-modules@vger.kernel.org>; Thu, 18 Sep 2025 13:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758226313; x=1758831113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkokmLK2YiSj3gWXRJKv9HJ55buXfb9b0NJavRjgMIM=;
        b=hz6ACzkx4smi0DRDlJTI7dRtumrJDaeUm7Vbiix4KsvYmQQ8Dw9oLqUS7vg2r8HZhy
         h1AnxnADb9AaM6TYPQUq1WHeqBfpcJtDZiKeTPRif9MTUB92opADdp4g8itlk2g2chgr
         LAvFRT/C7lS0d2uirYtZhj+xDMmMshWcmua9tL6Z2ZpXyY0KA5iwMvajI1jYDxsx/TPm
         53+cJYlXqLE8aSwmDelCWlqdFZecTdWd7oktQBYz28pwKJcHteHcN1/J0INQhMdUXLXV
         zqKjonYUmszPHzz4Yjo9wL9TLdBURTFY+LjTiTzHgj1WZfW4Ga8b3pRLifRBTcm4csQC
         BhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758226313; x=1758831113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkokmLK2YiSj3gWXRJKv9HJ55buXfb9b0NJavRjgMIM=;
        b=M3VwGScJJgbKnwWM5GfxNAJjBsu9YzrqaGNfpyxaNMbbkdpOvo4YqChASkSSG/R2kl
         yMGoUVFopwjKgXWAaT8Uyzl0XhTkweGdc8UtEYcCQChjpbdQD/RM8++tKIzxzAfITKRI
         5H7dkTZmPbvVxoPIBADK1ODBOYy9u6UmGjl+4VCkEUI1L7gNLCMAYQnlac07izeD9WkW
         fmQP/Ohp23HFqicFuyTHLs8MyLzXyXk1X5ylS+vPvL90d7w9tDU0r2CFkYpFHIL/umDY
         Na0Sl8T+2P7+A3SCg78EEr4KeE7Ea5lb/yVhq8IkILkVy+Aam+eF+4YBy0lob9fvYN5d
         kbRg==
X-Forwarded-Encrypted: i=1; AJvYcCWSANMQ8+icfikRm60UzfCFsM6MUM7dv2Q7SdKEYnk0mwCiDK8wNHdjD5UCc0UXH6VBJTHH17GBVeOGo+Ac@vger.kernel.org
X-Gm-Message-State: AOJu0Yw012YHKqIEGsVXIl9NSzIQi9BtTVRqDEOpfZ4VXz4+YF3QtNek
	4be7uX7O2a4NwfhWlDBbhmI/CJyxn3eAnZYKkgjT+Z4h0LNAED8fS3BK
X-Gm-Gg: ASbGncsvFfVWLGbchb8xNkUHHJZQ0rC/m2YI/s1oUudi/0Kc4I9q6Ly/+CTjTm2Tu35
	GpXywDcflQiujQGWLQXOpdHXu0W4vHWgzLpCVJ5wfFalH/5Pjf/YCCxhYTZk+tTLMKRKwLxuJvc
	sFbeXE4hDdEKY61Z5S2EI91E2Gf6d3uCIimUapuLoiubFosvIu65fZlw9ZwM3fnEGbxUwL9knd3
	0fjD4i+kLcVthOElmCNI8tTZag3rUskfjI/MVLHEocj1yGbTVuxahU1ZeeZF67TaKd5gUDnJVnI
	TAaII2nkiMd7ziyz+wkeiQLklLmh/2EH3FEIX9bAP5cAdKoemkpXkZySYSg1jfpt+tyesnW4PDS
	pEmjMOwXnvrz3gMuaS7UVwAZviwUcIRFPraJEYuBQCi6H
X-Google-Smtp-Source: AGHT+IFiZ8Cmf7lfrKrgivPhlQMvgZpgNrmFHwpmbuo6oJXmpmGCmmDQeFJT+qUdMU9Hw5uXjfq0ng==
X-Received: by 2002:a05:620a:4d52:b0:801:eb0:c0d9 with SMTP id af79cd13be357-83ba371e8cemr92937585a.32.1758226313542;
        Thu, 18 Sep 2025 13:11:53 -0700 (PDT)
Received: from jl.umd.edu ([129.2.89.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83630299579sm222392985a.41.2025.09.18.13.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:11:52 -0700 (PDT)
From: julian-lagattuta <julian.lagattuta@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julian-lagattuta <julian.lagattuta@gmail.com>
Subject: [PATCH 3/6] module: move freeinit allocation to avoid memory leak
Date: Thu, 18 Sep 2025 16:11:10 -0400
Message-ID: <20250918201109.24620-8-julian.lagattuta@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918201109.24620-2-julian.lagattuta@gmail.com>
References: <20250918201109.24620-2-julian.lagattuta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

move freeinit allocation after do_one_initcall in case do_one_initcall crashes.
Otherwise, freeinit would leak memory after every initalization of a crashed module.
I could not find a reason for why freeinit allocation happened before do_one_initcall.

Signed-off-by: julian-lagattuta <julian.lagattuta@gmail.com>
---
 kernel/module/main.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 2277c53aef2e..2825ac177c62 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3021,21 +3021,13 @@ static noinline int do_init_module(struct module *mod)
 	}
 #endif
 
-	freeinit = kmalloc(sizeof(*freeinit), GFP_KERNEL);
-	if (!freeinit) {
-		ret = -ENOMEM;
-		goto fail;
-	}
-	freeinit->init_text = mod->mem[MOD_INIT_TEXT].base;
-	freeinit->init_data = mod->mem[MOD_INIT_DATA].base;
-	freeinit->init_rodata = mod->mem[MOD_INIT_RODATA].base;
 
 	do_mod_ctors(mod);
 	/* Start the module */
 	if (mod->init != NULL)
 		ret = do_one_initcall(mod->init);
 	if (ret < 0) {
-		goto fail_free_freeinit;
+		goto fail;
 	}
 	if (ret > 0) {
 		pr_warn("%s: '%s'->init suspiciously returned %d, it should "
@@ -3045,6 +3037,14 @@ static noinline int do_init_module(struct module *mod)
 		dump_stack();
 	}
 
+	freeinit = kmalloc(sizeof(*freeinit), GFP_KERNEL);
+	if (!freeinit) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+	freeinit->init_text = mod->mem[MOD_INIT_TEXT].base;
+	freeinit->init_data = mod->mem[MOD_INIT_DATA].base;
+	freeinit->init_rodata = mod->mem[MOD_INIT_RODATA].base;
 	/* Now it's a first class citizen! */
 	mod->state = MODULE_STATE_LIVE;
 	blocking_notifier_call_chain(&module_notify_list,
@@ -3123,8 +3123,6 @@ static noinline int do_init_module(struct module *mod)
 
 	return 0;
 
-fail_free_freeinit:
-	kfree(freeinit);
 fail:
 	/* Try to protect us from buggy refcounters. */
 	mod->state = MODULE_STATE_GOING;
-- 
2.45.2

