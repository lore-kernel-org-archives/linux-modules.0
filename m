Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7041E13D503
	for <linux-modules@vger.kernel.org>; Mon,  1 Dec 2025 03:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764558377; cv=none; b=DscRU8NFQLS2WFjpXKY+X6efOS6FcdEdBct4kAozHP5R6FPRO50pAJWwooV56UQyksR+QHVNo+erIXj4VHYhTyyF4tFqxCOLRQYeQHqEgQdycl8fFSctuBlNL+HsPkl9oBqgfh+emuYIKDbcuvq7z0q/h0Oe3Pnw7g0yFld1rfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764558377; c=relaxed/simple;
	bh=JQob1fIFOHd0zgBafaJjwPrC6CdFgMyJsc+cMbI1z/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZS5nt+rFdgzz9EwevGb6VzSQxWhAxQaSx0MDt+lETACRcbTDZZnUfzBK+vdHZcJr3xup/PZUU6KMDpKvMj0u5XLRC0UMv/5eZEkSBR9wV7Dbs8vfm7Q5XVcPO3kPaskBS8dwzjMbT1OBctfUI6mz7oMfFUnVg5yUqzDqWYYmI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8f6Z5G3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PZ8Jk5A2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8f6Z5G3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZ8Jk5A2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764558373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=38eKCGFDzi9YXaJFlb8wscW8uVUGQfKn9hJMTWM8MvA=;
	b=R8f6Z5G3zBW9oCwRFJNxQKWnFEk6ffcqqwlXyAawjC58Gq9fPLeUDNY7emnov3kEUYozKq
	DkoaP5J892d54ZQR9m/lKXo0Ll3KDSePVW1Xl4qNGxPaBNENJRUAdVq2SBJ3IhGhcLhZCN
	+OpjQs44PopV0vmPaMx5IitASaQ6rFI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-dmJ6Fa_SPS-trJrdrRPjdw-1; Sun, 30 Nov 2025 22:06:12 -0500
X-MC-Unique: dmJ6Fa_SPS-trJrdrRPjdw-1
X-Mimecast-MFC-AGG-ID: dmJ6Fa_SPS-trJrdrRPjdw_1764558371
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297e5a18652so38671555ad.1
        for <linux-modules@vger.kernel.org>; Sun, 30 Nov 2025 19:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764558371; x=1765163171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38eKCGFDzi9YXaJFlb8wscW8uVUGQfKn9hJMTWM8MvA=;
        b=PZ8Jk5A23lBDBritOLYFZ2DGHVe6kzPsedp+pWbcmPSObdvxWeJosPUxGfAlbzQulK
         LvFLY+YgYG/UIrCaS3h3cT/JoktOaIKr6jyg5CW7hxRuqg0QQJWbrHpN08s3soHDpoGV
         IC3kTUBa81Ayyjkv6Xlgvyg605gwx+vxBFZgDxHblYMXTAjn7ANpWFHHFF8bJ3mi187s
         6+9L+W30bU/Sq/sK0wh+1h+F8qMjtZYF9U+A9zytWr8bi2u2MRWkxEPI4lrKttxmXLut
         pQfSdtgtFtTnY7UtPkhwQZHcz+ItqIRzDU4SF0cDWMEJXkU/mNo6+7/PT2dtpFmoJ2H/
         qqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764558371; x=1765163171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=38eKCGFDzi9YXaJFlb8wscW8uVUGQfKn9hJMTWM8MvA=;
        b=tlyWrzugA5Zj2cR2L5t2QY8jDDe5cHrMgRPvRR/VlAuzW2dE4qvCS2KmEDbrqsdCwh
         wsDZqUzHWYKxYUgqW+xdZr5jaXH7D0bTAFi4SVCJITWNOBf76OgOsP/nONKAQlhdVtSE
         5R/6qJH6l+YTVcWURwnbmWBFGRELChhtVg2jP5+qVkaTFbc4i3VbpellP5dgV4CyLT7C
         PZy2PmFY9SJYMIdFtGb9vFo8ITnPEsW1Lg40iefQRVuXVPWb2IBTw8PmNeKHc9cpD9mh
         s/Mrcy1kLaIi8b6EpPCuS/7Fakw1ayf7HlxEqhDIwhDKZOuaLxyTnMxrqa6AoglbuEsf
         lB3A==
X-Gm-Message-State: AOJu0YwPvMQWOikzgjwT6wE2qQ4/cObo1bPNfTpZVMl7M63+XIzgMWzz
	GIEEewGAZ3f31Xr4JtTBy/G5PYtDGOJvbA9RiApGHfR4s8pSvAKdX1bJVCz1dWjFwAaVBpQ1kDj
	HrfNuDYZbflY4mGf4FdD2D/UkX64c+5RuBGziWU9+PAKNcV7l2glxhAkjotmjGJAKyh8LSfJIol
	r4OjBmBBNcnSZdTKrr6YImjS2961nN+BdPpZuvAIImbfKieFKu
X-Gm-Gg: ASbGncui+Zlk4OcsM4AS1jZR4tqeGMsZDhJcBvgA18DC7X46/FNENbgICrtjMaK15Ig
	MoPYniGuStd7DoTSaEAFAlvdOb9FgQip68MxoSKx0ogSN+TSdnLSI6dmO5h5SHXJjOk/oV3IWp/
	XPi3eNnfnDpiH0+slRXo3nfrHiLY0qCCDD/UtLmd0HK9lzO7dSXtmt+al2D4FyGsa2Q+qKiyj7k
	h6f5f1cRrwDraRxYHFtihGN8UZnH/5qS+Thjra6EzWDn4+4OuynbrxEfbmFDvvR/U+UdsTqwEdk
	Hu3qg6d22pRqgPkUnoBc4HokBQ45gC1ckQNuyK814zIyPSCsNXe0z222/GOs+srerav9n5k/pxg
	g
X-Received: by 2002:a17:902:f788:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-29b6c3e5524mr368031135ad.18.1764558370980;
        Sun, 30 Nov 2025 19:06:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb1AfSKXtOAPR9LAt0sVNrvR3EMUitw1jOBkDMrMtNSwVwZgBH54JasyLl3tbolo7V0xtUeA==
X-Received: by 2002:a17:902:f788:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-29b6c3e5524mr368030275ad.18.1764558370055;
        Sun, 30 Nov 2025 19:06:10 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475ff57b47sm9183994a91.5.2025.11.30.19.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 19:06:09 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-modules@vger.kernel.org
Cc: linux-integrity@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org (open list:MODULE SUPPORT)
Subject: [PATCH v2] module: Only declare set_module_sig_enforced when CONFIG_MODULE_SIG=y
Date: Mon,  1 Dec 2025 11:06:05 +0800
Message-ID: <20251201030606.2295399-1-coxu@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251031080949.2001716-1-coxu@redhat.com>
References: <20251031080949.2001716-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if set_module_sig_enforced is called with CONFIG_MODULE_SIG=n
e.g. [1], it can lead to a linking error,

    ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_measurement':
    security/integrity/ima/ima_appraise.c:587:(.text+0xbbb): undefined reference to `set_module_sig_enforced'

This happens because the actual implementation of
set_module_sig_enforced comes from CONFIG_MODULE_SIG but both the
function declaration and the empty stub definition are tied to
CONFIG_MODULES.

So bind set_module_sig_enforced to CONFIG_MODULE_SIG instead. This
allows (future) users to call set_module_sig_enforced directly without
the "if IS_ENABLED(CONFIG_MODULE_SIG)" safeguard.

Note this issue hasn't caused a real problem because all current callers
of set_module_sig_enforced e.g. security/integrity/ima/ima_efi.c
use "if IS_ENABLED(CONFIG_MODULE_SIG)" safeguard.

[1] https://lore.kernel.org/lkml/20250928030358.3873311-1-coxu@redhat.com/

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510030029.VRKgik99-lkp@intel.com/
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
v2
- improve commit message as suggested by Daniel
- add Reviewed-by tags from Aaron and Daniel

 include/linux/module.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index e135cc79acee..fa251958b138 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -769,8 +769,6 @@ static inline bool is_livepatch_module(struct module *mod)
 #endif
 }
 
-void set_module_sig_enforced(void);
-
 void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
 
 #else /* !CONFIG_MODULES... */
@@ -865,10 +863,6 @@ static inline bool module_requested_async_probing(struct module *module)
 }
 
 
-static inline void set_module_sig_enforced(void)
-{
-}
-
 /* Dereference module function descriptor */
 static inline
 void *dereference_module_function_descriptor(struct module *mod, void *ptr)
@@ -924,6 +918,8 @@ static inline bool retpoline_module_ok(bool has_retpoline)
 #ifdef CONFIG_MODULE_SIG
 bool is_module_sig_enforced(void);
 
+void set_module_sig_enforced(void);
+
 static inline bool module_sig_ok(struct module *module)
 {
 	return module->sig_ok;
@@ -934,6 +930,10 @@ static inline bool is_module_sig_enforced(void)
 	return false;
 }
 
+static inline void set_module_sig_enforced(void)
+{
+}
+
 static inline bool module_sig_ok(struct module *module)
 {
 	return true;

base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
-- 
2.52.0

