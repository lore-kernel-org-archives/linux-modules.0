Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4E392C37
	for <linux-modules@vger.kernel.org>; Fri,  6 Mar 2026 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801836; cv=none; b=c/r22RsLerV3k9WobY08S+rpP8+b9ePu91skq1FHJU7X9sESbfhg8ZJDN7zDOTtEbVTnP15zXHeNihmvDnIycqK1UIIlBhzotf0D2yYpE0dsvE8mqxYGzBcb3N4zUjQOSl2UjjoAG919Xj2KYNZ6nMDxroaRLqYo+GTqWev2nbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801836; c=relaxed/simple;
	bh=OV5otnRgS/S+0kH9qEdyT/f7wV5xTxdVSISYKq4ifD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZVCd4AmN2Ka6VrdiUOk47Hv0UsCH9ZgvICqPp84IPeNUXxur4tZrFZG/8jxvvqA/gExnKX8dh/bSYJu3aG4J2HehV6q4O4Nq9LmEu4M4pu9RO2/oUUqncJxUyX9L0Dsl5yAAE/kI0NKheN5xxnTGBZiMfaRrDMBqjQHpSaRhYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VIp3AoLm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VIp3AoLm"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483bd7354efso120412815e9.2
        for <linux-modules@vger.kernel.org>; Fri, 06 Mar 2026 04:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772801831; x=1773406631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=umr5xt4p3qMVQx4ufWCasqFVTfl1J7n+hKybDwFVeVA=;
        b=VIp3AoLmLtwrvzBWBiosFqWEw3+yNbzDL4GXyKc635ZZDs1omjVfyZTOkPEpiTrfEH
         tFDZqoVXSowP/yx1BPBrYEeUl/At0S3gmDACKgOdxz22M6Nszcosv9i8Zf53wxrI4fY8
         PymwH//SAriJTBP7WYNNKUdVphOgBiLmH8twEWa0zWczVjCEahoGnEdEu1ckA3RNuFnA
         pVHUuyF+VOH3psRWGA+Ezom+edGN6oHvn/uSx1JyrxwaWkrwtt7xFLA+E8zQK8Mp3FGF
         0uIjFD5pWPsaj4RA7RJKI4fVEpyNPzipWz1p9TCYtB/ZkackqN5UW97iPSOUrRgU7ESw
         q5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772801831; x=1773406631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umr5xt4p3qMVQx4ufWCasqFVTfl1J7n+hKybDwFVeVA=;
        b=VlYiObln0jD52Fr4rpbOB+hJWzNyenwpKM4hRqhcIuwTidzv5wv7q1g1enQ2EXAYY4
         cSMj/j7sDp8Yw4G/Bn8Yz0gT70cEbG7kLy7W3yZfa3Ns2SYBU9ZaNXeiXR9RBtHIDvBS
         8F+xiGC2yIfP8gV5UnR8IlBdauQdAchDg9DuZvvMtj/nJBpFfCDO4sSxCD/l6hDaQZlY
         CwU6Z2fhItwQ+AMO5izVWxWWk1rPo2FeCHx5cH1LQko7J7UqoIiVn+rRHOBfufsHQhr/
         49pOlHHlGAf3kMLvBbM1RxMp+9p93hZvc0eEu8nxUr1MMuoch4uBTPHDI2ZESThfk36k
         Akjg==
X-Forwarded-Encrypted: i=1; AJvYcCXAzTBts2pk7n97qojnIVQhdwmCkwDQWKN0vgL2cXBvsZJ9qmwg/mTWVMEt5L2n61+sNgzMDgyDWhwfN5fA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtor/Cmm+qUwrWvrRtw83Aeyb1vb4KhI648QIYIcYPouDPhFd2
	KttfTt1428++wFH9boGRu7iXXT5lDUhvonorubMcZLGvi6wAb2gMoP2OSzhFIJPTOr4=
X-Gm-Gg: ATEYQzzhaE4s1VK8kuVS2L6xaa8Ez6Qs9hg9wDXnZI/xT8041SYiVBeNAwNb0I0eGxV
	08Gw9dgoHElrumI5zbOucE8VtDJHxBqyH0QrRcQqfN+WLjTpYTtfmUUL4R3DJluhOV8R5sMRgvb
	e+2kQUxz3YxWxhbpup/Mz307T5Xfo8l3p5BTgyB2cGDUwwHz+tXxK8SL/DplMXU2IDkWgTkcGcO
	PK1iaM5ayjZCv36VzDl8lWqUlnJIrvDicveO5WDnlbJp9hWniXn0sF4QkjAopZn1RbJrL5nmG28
	dKCUtcNgBhBgXEUM4j1IjrqzB7UmWrVrmHjL85DNYK0qbOqwdi6P49HBtXq6gmTlxgxij3fxm2O
	VJDpYAuSMrHH4ftt1hfeRYB4VKW3VwKdspaRxK+Do02SC0AuSNzHwOipFoE2MLPtsi5S167+p/9
	JDj1IXiJZfak48JQYmfLJEGH95wAXkRahWkwZEZP3L
X-Received: by 2002:a05:600c:8b8b:b0:47e:e20e:bbb2 with SMTP id 5b1f17b1804b1-4852691884fmr35674595e9.7.1772801831558;
        Fri, 06 Mar 2026 04:57:11 -0800 (PST)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fb4257csm181381215e9.15.2026.03.06.04.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:57:11 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: Fix freeing of charp module parameters when CONFIG_SYSFS=n
Date: Fri,  6 Mar 2026 12:10:52 +0100
Message-ID: <20260306125457.1377402-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting a charp module parameter, the param_set_charp() function
allocates memory to store a copy of the input value. Later, when the module
is potentially unloaded, the destroy_params() function is called to free
this allocated memory.

However, destroy_params() is available only when CONFIG_SYSFS=y, otherwise
only a dummy variant is present. In the unlikely case that the kernel is
configured with CONFIG_MODULES=y and CONFIG_SYSFS=n, this results in
a memory leak of charp values when a module is unloaded.

Fix this issue by making destroy_params() always available when
CONFIG_MODULES=y. Rename the function to module_destroy_params() to clarify
that it is intended for use by the module loader.

Fixes: e180a6b7759a ("param: fix charp parameters set via sysfs")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/moduleparam.h | 12 ++++--------
 kernel/module/main.c        |  4 ++--
 kernel/params.c             | 27 ++++++++++++++++++---------
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 7d22d4c4ea2e..6283665ec614 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -426,14 +426,10 @@ extern char *parse_args(const char *name,
 		      void *arg, parse_unknown_fn unknown);
 
 /* Called by module remove. */
-#ifdef CONFIG_SYSFS
-extern void destroy_params(const struct kernel_param *params, unsigned num);
-#else
-static inline void destroy_params(const struct kernel_param *params,
-				  unsigned num)
-{
-}
-#endif /* !CONFIG_SYSFS */
+#ifdef CONFIG_MODULES
+extern void module_destroy_params(const struct kernel_param *params,
+				  unsigned num);
+#endif
 
 /* All the helper functions */
 /* The macros to do compile-time type checking stolen from Jakub
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c3ce106c70af..ef2e2130972f 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1408,7 +1408,7 @@ static void free_module(struct module *mod)
 	module_unload_free(mod);
 
 	/* Free any allocated parameters. */
-	destroy_params(mod->kp, mod->num_kp);
+	module_destroy_params(mod->kp, mod->num_kp);
 
 	if (is_livepatch_module(mod))
 		free_module_elf(mod);
@@ -3519,7 +3519,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	mod_sysfs_teardown(mod);
  coming_cleanup:
 	mod->state = MODULE_STATE_GOING;
-	destroy_params(mod->kp, mod->num_kp);
+	module_destroy_params(mod->kp, mod->num_kp);
 	blocking_notifier_call_chain(&module_notify_list,
 				     MODULE_STATE_GOING, mod);
 	klp_module_going(mod);
diff --git a/kernel/params.c b/kernel/params.c
index 7188a12dbe86..1a436c9d6140 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -745,15 +745,6 @@ void module_param_sysfs_remove(struct module *mod)
 }
 #endif
 
-void destroy_params(const struct kernel_param *params, unsigned num)
-{
-	unsigned int i;
-
-	for (i = 0; i < num; i++)
-		if (params[i].ops->free)
-			params[i].ops->free(params[i].arg);
-}
-
 struct module_kobject * __init_or_module
 lookup_or_create_module_kobject(const char *name)
 {
@@ -985,3 +976,21 @@ static int __init param_sysfs_builtin_init(void)
 late_initcall(param_sysfs_builtin_init);
 
 #endif /* CONFIG_SYSFS */
+
+#ifdef CONFIG_MODULES
+
+/*
+ * module_destroy_params - free all parameters for one module
+ * @params: module parameters (array)
+ * @num: number of module parameters
+ */
+void module_destroy_params(const struct kernel_param *params, unsigned num)
+{
+	unsigned int i;
+
+	for (i = 0; i < num; i++)
+		if (params[i].ops->free)
+			params[i].ops->free(params[i].arg);
+}
+
+#endif /* CONFIG_MODULES */

base-commit: c107785c7e8dbabd1c18301a1c362544b5786282
-- 
2.53.0

