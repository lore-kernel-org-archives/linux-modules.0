Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1F3033DE
	for <linux-modules@vger.kernel.org>; Thu,  4 Jun 2026 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595107; cv=none; b=lGfu7FKrc+5fXeGOTwysCmX5dyNBMonE1JroLMOI1j6wTIqlGESvEPRKcm2/n9RY5ewx2k4diaf2TI4csXYQ8u7Kl8dgIrcGDjksd3LEkTgstT02CHGwIkJrbJVqJ4Q/s6UBVUqnzKWaqjD8zaB5HMQOTCwLNzvxLTw1+kU9G1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595107; c=relaxed/simple;
	bh=0r8NYy85CrQQR+hjDwHLOfJGX/SgqYi0DXuWYG6HXMI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SsAljkntlehBWYKVD+75a9wtp62RRkLDUxqjvY+iIGDL2uVfZZdhlH5SY0a/7QCrF0LVHiP49qacruGqCIbBIvBcDYNxNSECLMFU2RXZ97aGGWkO/l2BqrwQaZemhG15kLb+t0rRiH/eK4XFnWnbwYFIt4aD+yCfR2dddGOdeWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffKQNkKW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffKQNkKW"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-842288702fbso499621b3a.1
        for <linux-modules@vger.kernel.org>; Thu, 04 Jun 2026 10:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780595105; x=1781199905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PblVEIKf50wvt3DcN+d8+jT6Sc6K4D/U2mrPqQvJr/M=;
        b=ffKQNkKWSQBswdhIZyPYDZ9+IDKAEjtWrJ4NBwnfdbkmSJZD8D5onBlvu5U566ApW5
         If87HJ3+xwmyCMTxyYGYHstEoFjOj9DVWyo7negqpllxe/ApOHd6EbB7yfaDV11uvAqU
         mWJ6qBsrFY+emgNiuFAe4P88HjObkAjnlx+89TXeq+IroapY8p38bTAL/4nAly7QumIm
         q9BdKbAs348wu4EeCAMktxbT2JBoXwiS+0NwuWsFaMzV4cqK3jbE6SAPHpsi89BpwYO5
         a5zWyKUzZdFWsuFowjgh9q3uh9RpZwRpxs5Yg6z1vQ5xnyPFQqEy96pvZK87oljJeCVK
         7yUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780595105; x=1781199905;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PblVEIKf50wvt3DcN+d8+jT6Sc6K4D/U2mrPqQvJr/M=;
        b=niIoUBCJLsRsaYVs/Ag3w6zGmW6GXcGzHqN3hbJouTIAvjjz+CVC7J7FxKQFpA/VUF
         k1mp1wQgyCsYSK7GTKAhfD9N4p+c1ATa5MIA1qPPqNK3mW4/AStUOWKM3kYijfFh0bgv
         D6vUSXYb5wwAwyqTO2h/X78l2LbmVBzM9Jw8dqRF1NiVBYajPraxtleAUrkYwPxJM4Bc
         ZKl/Xy6+MZdPMj+SvmoNTfKXpWZ6OxRP71jBM/37Xak972QOCeyplcHhjSij8eYVTLAW
         hhPDACVNMZT4Lg7ym7iQsdSGKpzBBKh7/LTg7TNcinb0yYv0VPgJIFanNpnMxGR8zl8b
         PvAA==
X-Forwarded-Encrypted: i=1; AFNElJ8WE6tAZYdwVObCiF2hPBpzbTBHQXkuxTauZPsFwrwxUXU0J5PCpzEDSMXliGz2bdVB2HxQTYIpCEQ/iq9U@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4N4fckuzd2wug/YKSKPezARZG0bBMwwct7YD9IRxBpY/tzQbq
	j1dpMtMbu1k1kdz+DNsFnjrBHHCZDlvwlyPAJ+N9XP1Xncioa2n+L8vNMa6+4w==
X-Gm-Gg: Acq92OEpfMMtZuy9RM1Svr1LmK/B/ezdrcRHMBTUyxfluMmZFd/yUXMimxRKIeuwFiJ
	UjmHpoRpPQxoBmtf1+J0PNcY1xjXJW7w82PAncQsgDnJrWEQ7gmv2biIav3Or7DWCTuzYPQfGQ5
	0ytyNDmnRzNNHUu8AnBLbW+I49EBRnD42XqQapxUqZbmkQDVsMj6YUkoXM2WwKICzazleBFuTpV
	UzrwMfEBQN+d+8ZKhVJ9XbFPXx2SK5rn/0rhNGANlJ/ZBstdfA06uC7iKHh/VAeFkaF+OlQ6Kqq
	/kluXQQeZz3ybGYzUTWVwHrYIsrrZws/Q7ZC3turkEV6baoclHK701IDtC/iusDUs+1ecXHTWc/
	3dpNbqAqW0J5p/pCtfAnhk6WIjUE5dM+xLXGlkb4zHWixejCynFvXhIJwTsJ98jB/7aLzomx6O6
	mQ4FBIiUpfXD3sg6fo8uVKiLE9TydqhpHNhp6dL0GwjUJRXg==
X-Received: by 2002:a05:6a00:17a7:b0:842:7436:657a with SMTP id d2e1a72fcca58-84284ecf42bmr8464156b3a.32.1780595105030;
        Thu, 04 Jun 2026 10:45:05 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282904889sm6755729b3a.55.2026.06.04.10.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:45:04 -0700 (PDT)
Date: Thu, 4 Jun 2026 23:15:02 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: petr.pavlu@suse.com
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com, 
	atomlin@atomlin.com, linux-modules@vger.kernel.org
Subject: [PATCH v2] module: use strscpy() to copy module names in stats and
 dup tracking
Message-ID: <slebbzn7p6c4ybokolvey2sgvrooit66zjewwggqac2755ujgp@ptanmtdclmw5>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59c7b5d1-643b-4ca5-94ad-eaf82a66fc9e@suse.com>

Both try_add_failed_module() and kmod_dup_request_exists_wait() use
memcpy() with strlen() to copy module names into fixed-size
char[MODULE_NAME_LEN] buffers. Neither performs a bounds check on the
copy. Current callers always pass names originating from
mod->name (itself char[MODULE_NAME_LEN]), so this is not exploitable
today. However both functions accept a plain const char * with no
documented length contract, making them latent buffer overflows if a
future caller passes a longer string.

Replace memcpy() with strscpy() in both sites, which bounds the copy
to MODULE_NAME_LEN and always NUL-terminates.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---

v1 -> v2:
	- Dropped third argument to strscpy
	- Merged the other patch https://lore.kernel.org/linux-modules/jmm7r4r3k3qt767tl7lojglosgc3umhc63cdp2fckdkgb3fzki@3fgvxgvzo5ex/

Thanks Petr for the reviews. Taken care of the suggestions.

Regards,
Naveen

 kernel/module/dups.c  | 2 +-
 kernel/module/stats.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index 1d720a5311ba..33bddfb57317 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -129,7 +129,7 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 	if (!new_kmod_req)
 		return false;
 
-	memcpy(new_kmod_req->name, module_name, strlen(module_name));
+	strscpy(new_kmod_req->name, module_name);
 	INIT_WORK(&new_kmod_req->complete_work, kmod_dup_request_complete);
 	INIT_DELAYED_WORK(&new_kmod_req->delete_work, kmod_dup_request_delete);
 	init_completion(&new_kmod_req->first_req_done);
diff --git a/kernel/module/stats.c b/kernel/module/stats.c
index 3a9672f93a8e..08724baca773 100644
--- a/kernel/module/stats.c
+++ b/kernel/module/stats.c
@@ -253,7 +253,7 @@ int try_add_failed_module(const char *name, enum fail_dup_mod_reason reason)
 	mod_fail = kzalloc_obj(*mod_fail);
 	if (!mod_fail)
 		return -ENOMEM;
-	memcpy(mod_fail->name, name, strlen(name));
+	strscpy(mod_fail->name, name);
 	__set_bit(reason, &mod_fail->dup_fail_mask);
 	atomic_long_inc(&mod_fail->count);
 	list_add_rcu(&mod_fail->list, &dup_failed_modules);
-- 
2.43.0

