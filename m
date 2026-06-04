Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7246F409137
	for <linux-modules@vger.kernel.org>; Thu,  4 Jun 2026 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571126; cv=none; b=bvEUrf0wGXKWUNSH4cFo14pqDH+ygMCNOAg6fmRbuM0tm8TaPUvO6e4wvLVu3pdJGdFA/0gGOzzkWNJNFVezO16dlqrRJ8srXSoCQ+KBQJt0J42SJpOo7oEdersaka9XWWqKgdG7CISInXFyNLj/Xf1s4SRmloiXzIGHch6kSrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571126; c=relaxed/simple;
	bh=1PM0LiHbncg6sP4lLs+mkgq0oy1h7NM8bUpsLT3heEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeAX7GI83CdL6l89gSV7s8gVKaeDeQAwySh2qaM3xHQvNQTk1R/5OIujwdPKXToKMF60TJPV2wPIrMbSdJNOmCaxPqG5tjuT7vbhsYke+wxNfuLWWq59JRsHbDKBfuMrGfhkX4D5WZX6PW7wN0gbM58U22t4jrB23c5lhPqOoQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZJLGhURz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZJLGhURz"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4905529b933so6172195e9.0
        for <linux-modules@vger.kernel.org>; Thu, 04 Jun 2026 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780571123; x=1781175923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mh9nrAO/RTKL701wijSOrz3qd8apdES1vQv9RY9vWk4=;
        b=ZJLGhURziZNZiTM+1U8AHlsibTkqivcmSQQFZBObl6mMv/n5o0ODtQqdlBnzyBIgrG
         +86zqfDTBf39063H9Sq+Hve+XUyChJUAWl2rsD6dNG+CIeuUE2q7gaKehfdS6HAfPkm8
         PqZII57Bea4WlPcY+RcdPKsb4VSDu2hgIC+3m3LJijtTHq/YhNFmoMixpg6622D1MqYQ
         qDa8UcKPQAsvU5ukCfV9DOKCIn5ZjhS8cH8L/m7LpNNtYQA8FAGLQ91L+qHwadtf/Xr1
         gA3pBsfvRxo2YbJqsDJLVycpV3/0YvGu6GUD3ntd+vKpq7dmxCvGdTE6vrezMIkgTzfQ
         Fneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780571123; x=1781175923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mh9nrAO/RTKL701wijSOrz3qd8apdES1vQv9RY9vWk4=;
        b=U2Il4JfdiH0WJibmnLGJX+ndrSYa7kN+S6i8qlrOao0tj5iI7uEMEeaRwyaC41DEBR
         TIP6rSBGCMan0x9Lwy3Bf7f+zaydN02Ir+/tYu+If24zd1l7EEkmJ3h4jkUKpEI3jIaA
         TgBuw4CdJKlHmykim7sEdCoUyFvxiKS5kRQFlyGOKaYK4mmxOcfrNgqjfO0QzF4MQpqJ
         DL8/frTTnac1ExwM5oFWF6tA9rTzNW3tBGD9FWlJt/N9rhHjwMFjmanpdRV1jXF3vpY5
         ObnGPFvOExWFf6BJjaL+y+iYIRZvy0HR5sE5zQqqW9xblMkJ1BCssYKLiirW75gb/wcg
         OHrw==
X-Forwarded-Encrypted: i=1; AFNElJ8qqq5tWwSqUCRnWZJ8Ve+eQ4jU4uG2tY2xuJqSDArHd9WKzULfT+YUcoQIFOGeA3FOOMZS7rPwvPSJd7wr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8XX1t9pCBjxcFFxVd4O7E8lMJNbK9DXsQrYzbr+3raRttvbdE
	mA2GM0CIE+rk1CThOen9Oma07RfHGceEHV1pNA0R/SE33/4ylSbkWZXnkmCf9ziZPU0=
X-Gm-Gg: Acq92OFUI9Ke9a4z5p92GIpqbqLplxXddS7dL1q3V10J/CldNYeBwAQY59hSj+5YTe2
	No2A5RWnUFh+p5me+1BfACTulWOaz5SQgL0cK6R6zKn6YVczKaWf0/yZtp+1IoXe8/Kv8fBmvVE
	xqttiUj9GIiSWJbGQlkX5hc93PU4h82ZdHyBDQUbF3yWCx/DEdEtvsFXKrNg+KNYIX2emSO52i/
	dvi9V6jdDV2I6zpdkuvTnGbfSm9hTqchuhwFpHisc3Sr/tmpJMLRq0LRu4Kax22xlAwq28A/tZv
	IoIRlLwDWMfXBvFUYYvSoRrFvT0fsS/37NKreUYzieQ90EefehQor6OQRKd4jh0ZfPLKdowUuvi
	esfFej/FPtfEzKjzCfsS8dI2XcUizAFVs+57lV83kQXwoz/v8LYpQPUfm1dfx8t5Yt8t8F7qhOP
	36YtfV30o9eUCP0XasCvr0DzpRuxTfm4jQsyLjzn6t7SW3JPtyz8lBB1b8NGNMrwCV05UNKPyVV
	VSzAcH2aUzqo4buWVm34Gc+++CBpyapoHE=
X-Received: by 2002:a05:600c:458d:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490b5e7577dmr126886585e9.12.1780571122853;
        Thu, 04 Jun 2026 04:05:22 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7a273e3sm99648235e9.0.2026.06.04.04.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 04:05:22 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	Matthew Wood <thepacketgeek@gmail.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] module: Remove unnecessary module::args
Date: Thu,  4 Jun 2026 13:04:46 +0200
Message-ID: <20260604110455.1608038-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604110455.1608038-1-petr.pavlu@suse.com>
References: <20260604110455.1608038-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Historically, various parameter-handling code kept pointers into
module::args, most notably the charp support. However, in 2009,
commit e180a6b7759a ("param: fix charp parameters set via sysfs") changed
charp parameters to kstrdup() the input string as well. As a result,
module::args now mostly wastes memory.

The last users that still pointed into module::args have now been cleaned
up, so remove this data.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h |  4 ----
 kernel/module/main.c   | 15 ++++++++-------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..96cc98568eea 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -477,10 +477,6 @@ struct module {
 	struct module_notes_attrs *notes_attrs;
 #endif
 
-	/* The command line arguments (may be mangled).  People like
-	   keeping pointers to this stuff */
-	char *args;
-
 #ifdef CONFIG_SMP
 	/* Per-cpu data. */
 	void __percpu *percpu;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..528690ba160b 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1458,7 +1458,6 @@ static void free_module(struct module *mod)
 
 	/* This may be empty, but that's OK */
 	module_arch_freeing_init(mod);
-	kfree(mod->args);
 	percpu_modfree(mod);
 
 	free_mod_mem(mod);
@@ -3425,7 +3424,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	struct module *mod;
 	bool module_allocated = false;
 	long err = 0;
-	char *after_dashes;
+	char *args = NULL, *after_dashes;
 
 	/*
 	 * Do the signature check (if any) first. All that
@@ -3523,9 +3522,9 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	flush_module_icache(mod);
 
 	/* Now copy in args */
-	mod->args = strndup_user(uargs, ~0UL >> 1);
-	if (IS_ERR(mod->args)) {
-		err = PTR_ERR(mod->args);
+	args = strndup_user(uargs, ~0UL >> 1);
+	if (IS_ERR(args)) {
+		err = PTR_ERR(args);
 		goto free_arch_cleanup;
 	}
 
@@ -3546,7 +3545,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	mod->async_probe_requested = async_probe;
 
 	/* Module is ready to execute: parsing args may do that. */
-	after_dashes = parse_args(mod->name, mod->args, mod->kp, mod->num_kp,
+	after_dashes = parse_args(mod->name, args, mod->kp, mod->num_kp,
 				  -32768, 32767, mod,
 				  unknown_module_param_cb);
 	if (IS_ERR(after_dashes)) {
@@ -3556,6 +3555,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 		pr_warn("%s: parameters '%s' after `--' ignored\n",
 		       mod->name, after_dashes);
 	}
+	kfree(args);
+	args = NULL;
 
 	/* Link in to sysfs. */
 	err = mod_sysfs_setup(mod, info, mod->kp, mod->num_kp);
@@ -3597,7 +3598,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
  ddebug_cleanup:
 	ftrace_release_mod(mod);
 	synchronize_rcu();
-	kfree(mod->args);
+	kfree(args);
  free_arch_cleanup:
 	module_arch_cleanup(mod);
  free_modinfo:
-- 
2.54.0

