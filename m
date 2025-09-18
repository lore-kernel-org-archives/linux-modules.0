Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4B631BC9B
	for <linux-modules@vger.kernel.org>; Thu, 18 Sep 2025 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226310; cv=none; b=iE+eREAYQvU4GL1mUugNhHA44RzCyROJcHXVs8x1BNilNqigvQP4XLbqyr0+ugQIJoNQ87JK34su2zZYNFNCCBPZnXnUU1JO4IdT7tmR+V4bFjH5HljF7U1TpgjDFuRYCZ8W4/9Yh1lKbd/EKbDs1kymW253gNdAFrrnHKuUujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226310; c=relaxed/simple;
	bh=xcR27DgUHeac1UO/LafHZkAbGSP81kY7tVhXIxQM9N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fm+MFRk1ktaxDCAH8Xu0AExcQSnBEa6gq2xklLAeWKywxC3O+3gyO9JY6XeMPaV7ToHGR/VZjvULOHYAl9kKrw/c3WsXAPv7PVp6VdIA7U7T8Dn+XzkylDIK2qPdRKjhEZofdOWG3Cow4/iDHp3Bv9oQt3iMQ6EdrJ64EXnIfxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+Ro4nRO; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+Ro4nRO"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8117aef2476so140920785a.1
        for <linux-modules@vger.kernel.org>; Thu, 18 Sep 2025 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758226308; x=1758831108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVRvfHclUUY1pRn1PMztmNjAxV0w17FZcTRiIRd7CH4=;
        b=e+Ro4nROgqn8gP+xHpmJUX53wN24biU88J0RueJ+zODdgAhEILjcouPuF+awaGawsR
         TRvk1qazjptZqH00KvhOES5EcMBbrVkWCGlHIrpd21fgtKKPp61W3TsbrXyYB1bogfNq
         f97jq8ODQQm+nvzAI8YVEb8teG5CXj8f17nZHI6XxOLqlJWFV/IwLVJqrFj9ycRU/3tm
         FJtlMaYs/zcpXmumLcml4tqINYf/vvqRhBzqIUh68pM4gkwCtTXDyQ/MxflngwGbvL4S
         h6uoOOrQGY+OhBdH5dmjYqo1b3xcpr7kRCDext9sntzGs6a7+EWVm7bCT8l6XiABWqMC
         2dOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758226308; x=1758831108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVRvfHclUUY1pRn1PMztmNjAxV0w17FZcTRiIRd7CH4=;
        b=i7+O6+JjacorVNkZKZuEvWse6kpp56ve1uryi/W4dZexo67zHyaikBYUo9BElQoRON
         Z17wgquiDDB2pGiFO4/8AvAzeomZFJQ1BPa2tfu1Edrv9nNQFTXSmndvit7y+PsYo5J2
         AhJ+/PKnj4k5hx/GvH9JhDYNqQX6OwSbe6zjzE5AcyWR35Rj2o4B5K3uOQbSXI8RlLux
         w15a+09OnHGmCh7XUq701Zov/naGiaGpGDxKDKkG9s2eeTdJklXRZofzH6Ps39PQpHsh
         xYoNh9xONvfQuGjx9Jr2/sLUxgkCeV8+7ye6GS/t4sWo51NZKQ4ApN0Q3W2JNRIawLoQ
         Sdjg==
X-Forwarded-Encrypted: i=1; AJvYcCXgJL8PGBJ7SGgdnTTEsTkQLOLc4rmMY1bAtLdhcqKmarNTt3EECdg+HZyUxZvCaTcpLll5lo+XnUdyRRGN@vger.kernel.org
X-Gm-Message-State: AOJu0YxxGFjjiBeY4AjAhtUPE4dSA0w/lRXNZTekV0Br3Jj4sshM+jbY
	Iup0evGkeTimYAcyDI2ab2+mcIUPxVLBOUXL+YXyuqf1N/woMo92XCvM
X-Gm-Gg: ASbGncuyIE5eEFTMMOJ9/7nnf3LHEg3O+Rent7OTG8rlWaR3yoe3eR7c/0oYKDsbnpK
	nY5IJGksFZ53l0ZhBGncx94t0mZ3hqcQP3igd+6FOq87DNa2HeDhVNjS5rdXLlW7Ty1h8nOC7g2
	aVIK1wgx+Xy8XDkLRtQV+17IS9sJwGDmx+P08diewr5IBBkVuGuJVZKKuiKoB9cTFaW73IAOg7K
	v4hxv6Oggoi3e1+KVl6cn9IMKGlaZBLOp2+6eZ1/rCcunCbf85spluYiFFovJj+TI/4J9amxbY/
	5/qSYo+6BpVdxrCfs+jF0JtVfhU4KRTH0D1q8FSNT/7cLRa5ls6xPIS82M7gj/J+C5Zdl3IXlX9
	pTw0NH/ac0bnFRVhWgavD8EYfKdGL8QIRYVD8y8N9/pBX
X-Google-Smtp-Source: AGHT+IHYC/NSK53/g1XHZ5kdkJoReRJmpekcCbpFeReJoVfuqw51mHVuSFDUMgsBJLVY8HG6rbnB6g==
X-Received: by 2002:a05:620a:28c3:b0:82a:50c5:6138 with SMTP id af79cd13be357-83bab47050fmr111769685a.40.1758226307725;
        Thu, 18 Sep 2025 13:11:47 -0700 (PDT)
Received: from jl.umd.edu ([129.2.89.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83630299579sm222392985a.41.2025.09.18.13.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:11:47 -0700 (PDT)
From: julian-lagattuta <julian.lagattuta@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julian-lagattuta <julian.lagattuta@gmail.com>
Subject: [PATCH 2/6] module: detect if init crashed and unload
Date: Thu, 18 Sep 2025 16:11:08 -0400
Message-ID: <20250918201109.24620-6-julian.lagattuta@gmail.com>
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

Store idempotent and init_pid in struct module.

Signed-off-by: julian-lagattuta <julian.lagattuta@gmail.com>
---
 kernel/module/main.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 413ac6ea3702..2277c53aef2e 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -752,6 +752,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	char name[MODULE_NAME_LEN];
 	char buf[MODULE_FLAGS_BUF_SIZE];
 	int ret, forced = 0;
+	bool did_init_crash __maybe_unused = false;
 
 	if (!capable(CAP_SYS_MODULE) || modules_disabled)
 		return -EPERM;
@@ -778,8 +779,11 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	}
 
 	/* Doing init or already dying? */
-	if (mod->state != MODULE_STATE_LIVE) {
-		/* FIXME: if (force), slam module count damn the torpedoes */
+	if (mod->state == MODULE_STATE_GOING ||
+		(mod->state != MODULE_STATE_LIVE &&
+		!IS_ENABLED(CONFIG_MODULE_FORCE_UNLOAD))
+	) {
+		if (mod->state == MODULE_STATE_GOING)
 		pr_debug("%s already dying\n", mod->name);
 		ret = -EBUSY;
 		goto out;
@@ -795,6 +799,21 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 		}
 	}
 
+#ifdef CONFIG_MODULE_FORCE_UNLOAD
+	if (mod->state == MODULE_STATE_COMING) {
+		struct task_struct *init_process = get_pid_task(mod->init_pid, PIDTYPE_PID);
+
+		/* Did the init process die? */
+		if (init_process) {
+			put_task_struct(init_process);
+			ret = -EBUSY;
+			goto out;
+		} else {
+			did_init_crash = true;
+		}
+	}
+#endif
+
 	ret = try_stop_module(mod, flags, &forced);
 	if (ret != 0)
 		goto out;
@@ -1380,6 +1399,10 @@ static void free_module(struct module *mod)
 	mod->state = MODULE_STATE_UNFORMED;
 	mutex_unlock(&module_mutex);
 
+#ifdef CONFIG_MODULE_FORCE_UNLOAD
+	if (mod->init_pid)
+		put_pid(mod->init_pid);
+#endif
 	/* Arch-specific cleanup. */
 	module_arch_cleanup(mod);
 
@@ -3044,6 +3067,11 @@ static noinline int do_init_module(struct module *mod)
 	ftrace_free_mem(mod, mod->mem[MOD_INIT_TEXT].base,
 			mod->mem[MOD_INIT_TEXT].base + mod->mem[MOD_INIT_TEXT].size);
 	mutex_lock(&module_mutex);
+#ifdef CONFIG_MODULE_FORCE_UNLOAD
+	put_pid(mod->init_pid);
+	mod->init_pid = NULL;
+	mod->idempotent = NULL;
+#endif
 	/* Drop initial reference. */
 	module_put(mod);
 	trim_init_extable(mod);
@@ -3474,6 +3502,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (codetag_load_module(mod))
 		goto sysfs_cleanup;
 
+#ifdef CONFIG_MODULE_FORCE_UNLOAD
+	mod->init_pid = get_pid(task_pid(current));
+	mod->idempotent = info->idempotent;
+#endif
 	/* Get rid of temporary copy. */
 	free_copy(info, flags);
 
-- 
2.45.2

