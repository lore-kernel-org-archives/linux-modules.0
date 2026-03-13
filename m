Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE2137F8C8
	for <linux-modules@vger.kernel.org>; Fri, 13 Mar 2026 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409789; cv=none; b=ESllQOFD8VPiTSiH/gK/U2Y6RbFqICiC8g/QLcIHUAo14CKaNCJKMDalPWxQKzUWvXiPNMHmD44qCkm4n/wQs55X2dWmBLzSVTyCWjabNUL7zu71kUAwIZjI03Am/tZnnZT0Zjwd+Yw+XmX4tUxVLJnKh8JbNEn43vVVEmgYgb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409789; c=relaxed/simple;
	bh=Nsioy69ENiyic8NlC9zA1Y5+vGS4n4oQxZyAscxrrBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukacXBiIFZ/IkksRr1KNWUQ6DqZ7lklQiwiAlCaH1FE3AyQMduhef37NEA2cRbPtToTHG1sXbY5lNF0wa1skWWSkfyHAegJ4QP0RmLhF4La5j/LUuvOd+mQHz9nhomVBPUvz6PCoX3YSzsjWtSKtFO09WRLCgLpOQFUa4j3KWy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TXVDeauq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TXVDeauq"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-485392de558so14092135e9.1
        for <linux-modules@vger.kernel.org>; Fri, 13 Mar 2026 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773409786; x=1774014586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/U2+H20h/nJ9Ad48rWk+9dOJeC/jWCnSXA0zRNJUBE=;
        b=TXVDeauqu2kJMAJQgJDGpU+EJDsYa6TZPOxk8OEXYB3bMhT0Xeu1IXeq0bWyzv2mi0
         A9g1XEeS4NSPRcS3L1nDN1L9XuutbGh0Na2yp+ap3BVLWyHzXbOgjio1+LdAUN5KwL5D
         P+kgT7WwHNO/uIBcRKAnDPiyocofBkWxdYvHoagT9TN0E984S3njOhDdPFofkGbbjk2H
         iSIX64pAfj0dT6LRQBhkLzXWmchjRMbRwiH6Lcv4Hc962YaG/QZrc6ua/2a8w4kpxKCn
         v77YoN6YpIXuzJJnU+7nn2GCdMPftXTlmyH2V5dUj5w5YLYwFTPLidQGlRh0/AizBtex
         Z6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773409786; x=1774014586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E/U2+H20h/nJ9Ad48rWk+9dOJeC/jWCnSXA0zRNJUBE=;
        b=CH1tT8uAOTa1sb5/xf0nSwifScBkWu5/D9/Y9tQLRSVYEf8eW6Xqw2F18dGbLO88UU
         KrqOeQx8DLaP6OVPjI1csNwowePBnu6PrqPwFdFKRKAdimMF4XhtIqUguJ29YtN3WSAj
         YzVILIauNeiuCBcQKt9Dsyri/zqXflzNPtjH6ICiD4G10VoPERh6YL5i/x0RLh4TQ0wP
         qn0HcMj11tA0d8cg+t5LRJyE5OZ1q/KW27UFnOJOX757ADvsMGqZX7cT0asR8ufak0RC
         BV5Ag4WoSEGxnMgiNAJLyZ58i1RERKkC2gLH9kTm98dt0SIGZ4oEiFelzq9V9YV59S7R
         7unA==
X-Forwarded-Encrypted: i=1; AJvYcCVD4I2dBt5lCXhOHI9J/0KMwaXuzJhHzxYznGIaR/lkO9UvXPvV76kFK1/HmG+leyrceatjCKGJQuLJsAX1@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhPvFqTsXwVhMElmWiNq22gvR5pLRAnPJFLfHQq+RVVeqS0Zl
	khq8q7zSiW9NUJHeLVjLQir8E8yz6/MK8jRzwugbV2IuMgn2lCnCgpVio0s4j3B6uY4=
X-Gm-Gg: ATEYQzwm/a4U3CtahoxkPNGg+2mPmUS+edo3BltqeddEtFGeNsjzs8+BJHMclg3y37L
	w88QIVKlP0PfuYfF8t/WCL+rr9BseeIE/u8bpjevX0lWpgF2rdd0v8paR2iNLJVkVnPPFUleXxT
	vU8I4+gehL9BcFfxjmBR/Rxwofl19tSXA2Qndw3HhGyg1IM5NA2XEHFfr5pnH+fIFuaAaSQHcAk
	DsIosqZrPGAYgdVUR+BQ73t8Ggskf4uI+55ZUbB1FPKhAKde/cu+l3MxvjiZ9D2IUeUC3JW590W
	YuKdO1o9mruBiplKqRQZY0dEhXS61GGkW8tToQ/03k+N6J+5mXjiJDMyJl6pXv0pTZKtjGfGPhg
	5/RuyHUF9+7Gub2QzZGQx4n+gUgQSWno0sJlVXndrTQwaU5rq/MAIo6Vwx2lLl8bnEbNI4euBq8
	hZz9WuQFtf07BC9FrUYjltz6CW1HLkcZzjyNwhWP66
X-Received: by 2002:a05:600c:4f8b:b0:485:3e6c:aa84 with SMTP id 5b1f17b1804b1-4855670f7d3mr50278125e9.33.1773409785931;
        Fri, 13 Mar 2026 06:49:45 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66e3f8sm206491865e9.14.2026.03.13.06.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:49:45 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] module: Fix freeing of charp module parameters when CONFIG_SYSFS=n
Date: Fri, 13 Mar 2026 14:48:02 +0100
Message-ID: <20260313134932.335275-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313134932.335275-1-petr.pavlu@suse.com>
References: <20260313134932.335275-1-petr.pavlu@suse.com>
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
 include/linux/moduleparam.h | 11 +++--------
 kernel/module/main.c        |  4 ++--
 kernel/params.c             | 27 ++++++++++++++++++---------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 7d22d4c4ea2e..8667f72503d9 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -426,14 +426,9 @@ extern char *parse_args(const char *name,
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
+void module_destroy_params(const struct kernel_param *params, unsigned int num);
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
index 7188a12dbe86..c6a354d54213 100644
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
+void module_destroy_params(const struct kernel_param *params, unsigned int num)
+{
+	unsigned int i;
+
+	for (i = 0; i < num; i++)
+		if (params[i].ops->free)
+			params[i].ops->free(params[i].arg);
+}
+
+#endif /* CONFIG_MODULES */
-- 
2.53.0

