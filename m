Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505247;
	b=mDmWYKjP3g5xouIrSK2rQbHiZcW+r18l3sNv6Knw+awW/sXBPTIk2EFRXFjqgklyMcGQ
	 nSAUMjVfI8pJlVPrpg5wAeGBdCJCK8Mtyujy/KwbLku8Lsj0xULfmB6mh/9ey1ODURMmL
	 gFWbH0q6NXCFzScuePaC1kEsA3PnwY1/UgUEMgP3sN6nBwCrgXyjQzeKSRn0j6OMOrj+u
	 p3v05S5c+c9gmfl0QXChH3qP7w/FQHXgV38e+nxtKtpzpJOJNRkI8D/Y34I1wZrQwi3ZI
	 bk2eGTKmLIexLdbIYCifCmGmGR9gvlgXNt8Q4t5j+2Eh/WAOPb1oihWksmq9UMkf/Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0MP30nw0IIRx244dAjoQ+sXac7dSmGXhgCJfSLXreiw=;
	b=4qZvB2I4jGXwbpp5w7O5NxxrzXF7T2lI8bjwJMhJ0iqr8Euz/EF4MBDHwJAYwepOeSqQ
	 Lm8D7IdP2BtwLl+hisnL7TsSLehJuoCuUwU6DYPwhDKBVyHoz7c6YYXeBgG4AN7N4/oXC
	 2zKE+AceWZ112x0+x69/D3bV8DO+2m76wLNV1suO1NDxtDPYaETN4geEs+C7AKZ4FIdmU
	 /88iBVc8tUF4/yfdWctZ5LMCdAqWlRvdSk6FKZxwP76WvQV2IGxPMAHW7KpKcjiKoOUm6
	 NDb8bK73E8aXRnOqFDE8f8uGOEX722F8ytjzZ34XYBVMsze05iYOUYfLz4oyAbgzQWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=PiJ9AoaR;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D6F60A261A
	for <linux-modules@vger.kernel.org>; Tue, 20 Oct 2026 14:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0D6F60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=PiJ9AoaR
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso38749585e9.2
        for <linux-modules@vger.kernel.org>; Tue, 20 Oct 2026 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792505245; x=1793110045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0MP30nw0IIRx244dAjoQ+sXac7dSmGXhgCJfSLXreiw=;
        b=PiJ9AoaR0HMKHeEwK7TitYoY6Y56ApwuluhWcQFtkEo5nw6XDL21eZZN0/FDaSB6E+
         12p+bA6tosrGoWErSa3cj61/lAhieh0fPU4o4SgBo/84qERPd8kaAPxL5knJ2fmZF3vQ
         3rC58BdOSWB2KptW7YBKVVeEheZUH0FgVPL3Rg2Uq+etDWfwXl1bqXq9VmiheLezVAUQ
         7VlohMz818x8uAWgJtuD4q8kgfP4ejcFmEpP+fDznL+JVlLUvdp9Zo3MCzjLltfie1ei
         gYbUs1MWe27/bpOHuzTnw7yVPdJ9O28r3LS3CToTnwBmi+ahokdJo9Pu+F922jXfX1Oi
         6yhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505245; x=1793110045;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0MP30nw0IIRx244dAjoQ+sXac7dSmGXhgCJfSLXreiw=;
        b=uKHWI3SM2xRMbUBZxgZFmZcA52kGgJFHj0uXehT2+Ase5LByjZwzcAhFAA+gx9Gvir
         +R/Zwi+KjNf9MvCzvndAa2LJBXuRUFxPlEPY5JkBYIOkVcyM/5IdvPuaQJTJEE96BKWc
         JHBBVmKoQsxfYTc2QapHOQrUBKVwqoNINqZqtWQ03aXwSJNXx5sst1EpLRI2vB1if8Lp
         UhViPnKNjI+4K2LZ+sn4TWyRD2erzGo6jYrU0nmDZ3CE713bcD2YnsmOz11u4IAWJk4O
         6PPZYvimYgB2le9NPloT3AQx3HueMfXQcAU3YOSem/qru+Wri534iHzMdGe5HAVTPJrJ
         zQcA==
X-Forwarded-Encrypted: i=1; AKwUvBxzdBjmK9KMxKcXxWe57MDT6LysBffJYOJ/m6eX93CqmV1jR8c1rdqZHHEG1uIfvRDagwtra1tiMdXbVuUG@vger.kernel.org
X-Gm-Message-State: AFq9FYLhyPkeAS/iLxnSWf86EcUwQCClAwqui2+kfvRKoKWBzk8glehe
	UPKpMhIJnoWV7FihdCANr59Y5PLr1y/a85hReVlZY5s1+NHd75KLCMnPK+xsi+jfrgk=
X-Gm-Gg: AYBFou1+fWk7AEavz3vOCgmSRQeTadbtQUHVuoo9dxwS6zWc0R83qM87VVxmc4QDXtg
	XlnZCMC37NQoTRvO1vmQaKvNtpc9r9jZbc3yQOYB444To5UO3uGj/PmOiKlP+Q4WuzAGf8CeZYe
	c3CdpWm8VXrbB8/OHHL/JjtOeqQbhrwvtRc+44ymKsjPehLvFeMD75uNl8eIkX+EzEYgsNuTug3
	wOMN3Zp5U6bxTNWwLHaQ7chj42+n6+y93pcOrdDvse5D04RF0u17aDJ1xZ60fXdoH86NRE0xpZo
	dnopDUsYrYXFQdPGSGuzor+AvpB3ubpVUx1vXiSAAN9xsN3pjKXgIgI5B3DKKneNlJDcuneORQs
	EsJtUZSyubP9AFvte1rtKl6P6hNk16V7xMcjro0RRoR64+2m/Av0Uc7t1d75GXo2NlnD8Yy7sR5
	pdFtxAXO3Rfi57sUomLwlk5L64PXhSUtS7YK6Jr0ULLkX6Ifc/XCOERRl02mPVFtZmBu3W24Y1e
	DaHaQ==
X-Received: by 2002:a05:600c:c16f:b0:4a1:b29e:f72d with SMTP id 5b1f17b1804b1-4a1d7466674mr249825155e9.0.1792505244986;
        Tue, 20 Oct 2026 07:07:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2ce1479sm75602805e9.14.2026.10.20.07.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:07:24 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] module: Move mod_unload_taint to tracking.c
Date: Tue, 20 Oct 2026 16:05:21 +0200
Message-ID: <20261020-taint-unload-v1-3-d1c764889afc@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020-taint-unload-v1-0-d1c764889afc@suse.com>
References: <20261020-taint-unload-v1-0-d1c764889afc@suse.com>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Move the definition of mod_unload_taint from internal.h to tracking.c, as
it doesn't need to be exposed to other module code, and remove the
redundant declaration of mod_debugfs_root from tracking.c, as it is already
declared in internal.h.

This is a non-functional change.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/internal.h | 13 -------------
 kernel/module/tracking.c | 14 +++++++++++++-
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 70ef20b97c84..3aca22253296 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -253,19 +253,6 @@ static inline void kmod_dup_request_announce(char *module_name, int ret)
 #endif
 
 #ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
-struct mod_unload_taint {
-	struct list_head list;
-	char name[MODULE_NAME_LEN];
-	unsigned long taints;
-
-	/*
-	 * Number of times a module with this name and taint combination has
-	 * been unloaded. Updates are serialized by module_mutex and use
-	 * WRITE_ONCE(). Readers that may run concurrently use READ_ONCE().
-	 */
-	unsigned int count;
-};
-
 int try_add_tainted_module(struct module *mod);
 void print_unloaded_tainted_modules(void);
 #else /* !CONFIG_MODULE_UNLOAD_TAINT_TRACKING */
diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 873fceb30526..46840dc22dcb 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -14,8 +14,20 @@
 #include <linux/rculist.h>
 #include "internal.h"
 
+struct mod_unload_taint {
+	struct list_head list;
+	char name[MODULE_NAME_LEN];
+	unsigned long taints;
+
+	/*
+	 * Number of times a module with this name and taint combination has
+	 * been unloaded. Updates are serialized by module_mutex and use
+	 * WRITE_ONCE(). Readers that may run concurrently use READ_ONCE().
+	 */
+	unsigned int count;
+};
+
 static LIST_HEAD(unloaded_tainted_modules);
-extern struct dentry *mod_debugfs_root;
 
 int try_add_tainted_module(struct module *mod)
 {

-- 
2.55.0
