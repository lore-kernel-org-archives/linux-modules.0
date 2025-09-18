Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6405731B810
	for <linux-modules@vger.kernel.org>; Thu, 18 Sep 2025 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226326; cv=none; b=H4CGZtOBT8qkqFL3BuuB4BZxU5pU1SA05dfjn5k4Ozt1Hhu25Vzr2xNbvJ7nwRE3/8SHkk5mlpNc/NZsh2wgWp63cB2SsMw6ydloNUm6bIj5UzyYyk1McPZ61mRimMg3k9cRHLoI3tNEMGwx3dZhQ12vV5HJVhq67syMuWZ+TuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226326; c=relaxed/simple;
	bh=PvPtlt1c4VJyn8dLTiCc0gxKvb+VLZbvk3Y+VTRwjo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKZcofevM7Lf7d/PPNxZIpH9OWHyhmMqB8kIxBlRq64QTsQtjdj8dxPde9iVhfLgfaCiXIVfgIblFafM2yr6KU8NNlvhbeoEfWPJ6ifbOzVHfJ7lxPxl9eKBR7PraYi3i/YyBQBlhtWXmWhEiISt4WIpf64E9NwNJHSW7/rYmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq9oZLJY; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq9oZLJY"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-81076e81aabso133633385a.3
        for <linux-modules@vger.kernel.org>; Thu, 18 Sep 2025 13:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758226323; x=1758831123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LP02yHuvyiZWCyd9gSrmQ/IvvtpIZejTIOWn2O6TonY=;
        b=Oq9oZLJYyNyStlrlLeRCxVQ1FZyaM0MADesNu91TMEzQ3UKsC8hPVl0eEH/v6GTn7w
         gaLm3GrsJLHnYKnON7W1R18cqsMyYYFLa24vOMnXI972208ZNQWG6cu07GDs8Aln51V1
         QSi+MkP0r7Yv8+yY6qbx2xD9pDp8gTtp8lpGBMTG2g519BqCtO2pzxMEXzc7/qYifSlc
         hWVGmmZVFPmFiekxZ6fRzfVOnvgkS8jah15O9nJulhZy8hDzGUeP9zzDFOiLmly0ifMI
         BpTOXmLo7tSuC2jNoRgksHPvbQ3QEWPjw8whyxDxlDSGJ5XBHkl97GhgbEwl1krKKHzi
         8MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758226323; x=1758831123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LP02yHuvyiZWCyd9gSrmQ/IvvtpIZejTIOWn2O6TonY=;
        b=RD4r56PpA2MKYUA3Hdi/7Xuz+TE4F3hoFqDbmlSi+v6WUwbxQoWC/ae+rfzZ9aJJLc
         t9SjeI4IA5xtvtXCv6CddDlubhQrkyefXR2cQSTGA+bVtgjNY+Vcub02J2OHCWxoDewD
         H/9TD8MjxKTGko8gfnXhR5dw3UkTaxUR9AoH3NNHMwJRAUzsaB8b2VTaHBkD9ELbrW/s
         q9D2TxloCaw27+RHNns2PGM4oMm1PosqAFg9U8Fv+evceMIref1s+iYKacjt6anjb9iT
         DRB6bofCWENiYq+kpEc8U9l3qsAGE/TfLs0DQOCSALJhl+dL+zJHtkSk58D9h8BubjFK
         Dl2w==
X-Forwarded-Encrypted: i=1; AJvYcCVHGQxrWv06QGum/MPcc+mHdMdsU3fI0NdgFyrIB0sEF3Uh5n4Q9x+APg1+j22efwUj9Yw1/IVn5N7GCj4p@vger.kernel.org
X-Gm-Message-State: AOJu0YwAs5O+rLAtyuj/xhSVjuBbj5mRbZgyDjTzeuyxLTA1NvOgIzrU
	cFDe+oMLaq3stt5Cy9CZdFVO9r+qB1xvP1vYtgqR1M1Tbe03kakEqZs99ow8a3vF
X-Gm-Gg: ASbGncuoWrYkmqlLklHyzb0fle7AxF0g/Fs2l26KwnnRPIGYiH7B/fzJqWWUiFDdO79
	o44QVkKLyJIGHp4yebzrbdqIWZcrzIDnASfA7sSthkWZWL0sxNKVdhnw23U+JmLkto/dIpGF/4V
	VN0tiL7oeVlj9+HujcZ8cGgBWVMta5dt/VGpaMoaETq45Va4dlfm6mff6X675NLf2iEVaYLIZCa
	FAOM0v0SFzCdusZPMuFbJUjSCCEMBqMR3h1s5Y0vKeWBZG6rDiFWXNc2WeUdiK3WDzKxVZd0aZQ
	YxpgPcFhQIr3OPpn46hl7OOVrG5ihQgDalZoYQq7hvuaZ/ZD0quYFnlwj1LDuZGKTHBCP/Xw06R
	Ln7I9KgiAQQq2sF6VM0zPDsEBye+rUBE573OevcwuLe4r
X-Google-Smtp-Source: AGHT+IHYupFZHDTKkw+QZ4v0Cz2P4eNnX3kBd8iRs0HvVEup+i6PcnJJH0MCFFeUfABRPeGNsKeS5Q==
X-Received: by 2002:a05:620a:1a8c:b0:80d:a8d5:9857 with SMTP id af79cd13be357-83bab74d395mr104333885a.43.1758226322335;
        Thu, 18 Sep 2025 13:12:02 -0700 (PDT)
Received: from jl.umd.edu ([129.2.89.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83630299579sm222392985a.41.2025.09.18.13.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:12:01 -0700 (PDT)
From: julian-lagattuta <julian.lagattuta@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julian-lagattuta <julian.lagattuta@gmail.com>
Subject: [PATCH 5/6] module: store and complete idempotent upon force unloading
Date: Thu, 18 Sep 2025 16:11:14 -0400
Message-ID: <20250918201109.24620-12-julian.lagattuta@gmail.com>
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

Move idempotent definition up and add idempotent_complete declaration.

Add idempotent to struct load_info which gets passed into load_module
and then stored in the struct module.

run idempotent_complete after module is unloaded and give EBUSY
to any process waiting for the module to finish initializing
via finit_module.

Signed-off-by: julian-lagattuta <julian.lagattuta@gmail.com>
---
 kernel/module/internal.h |  3 +++
 kernel/module/main.c     | 29 +++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 8d74b0a21c82..43f537475859 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -89,6 +89,9 @@ struct load_info {
 		unsigned int vers_ext_crc;
 		unsigned int vers_ext_name;
 	} index;
+#ifdef CONFIG_MODULE_FORCE_UNLOAD
+	struct idempotent* idempotent;
+#endif
 };
 
 enum mod_license {
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 217185dbc3c1..256e30259bcf 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -80,6 +80,17 @@ static void do_free_init(struct work_struct *w);
 static DECLARE_WORK(init_free_wq, do_free_init);
 static LLIST_HEAD(init_free_list);
 
+
+struct idempotent {
+	const void *cookie;
+	struct hlist_node entry;
+	struct completion complete;
+	int ret;
+};
+
+static int idempotent_complete(struct idempotent *u, int ret);
+
+
 struct mod_tree_root mod_tree __cacheline_aligned = {
 	.addr_min = -1UL,
 };
@@ -784,7 +795,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 		!IS_ENABLED(CONFIG_MODULE_FORCE_UNLOAD))
 	) {
 		if (mod->state == MODULE_STATE_GOING)
-		pr_debug("%s already dying\n", mod->name);
+			pr_debug("%s already dying\n", mod->name);
 		ret = -EBUSY;
 		goto out;
 	}
@@ -833,6 +844,11 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	strscpy(last_unloaded_module.name, mod->name);
 	strscpy(last_unloaded_module.taints, module_flags(mod, buf, false));
 
+#ifdef CONFIG_MODULE_FORCE_UNLOAD
+	if (did_init_crash && mod->idempotent)
+		idempotent_complete(mod->idempotent, -EBUSY);
+#endif
+
 	free_module(mod);
 	/* someone could wait for the module in add_unformed_module() */
 	wake_up_all(&module_wq);
@@ -3591,12 +3607,6 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
 	return load_module(&info, uargs, 0);
 }
 
-struct idempotent {
-	const void *cookie;
-	struct hlist_node entry;
-	struct completion complete;
-	int ret;
-};
 
 #define IDEM_HASH_BITS 8
 static struct hlist_head idem_hash[1 << IDEM_HASH_BITS];
@@ -3683,7 +3693,7 @@ static int idempotent_wait_for_completion(struct idempotent *u)
 	return ret;
 }
 
-static int init_module_from_file(struct file *f, const char __user * uargs, int flags)
+static int init_module_from_file(struct file *f, const char __user * uargs, int flags, struct idempotent *idempotent __maybe_unused)
 {
 	struct load_info info = { };
 	void *buf = NULL;
@@ -3707,6 +3717,9 @@ static int init_module_from_file(struct file *f, const char __user * uargs, int
 		info.hdr = buf;
 		info.len = len;
 	}
+#ifdef CONFIG_MODULE_FORCE_UNLOAD
+	info.idempotent = idempotent;
+#endif
 
 	return load_module(&info, uargs, flags);
 }
-- 
2.45.2

