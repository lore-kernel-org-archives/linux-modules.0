Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4D391849
	for <linux-modules@vger.kernel.org>; Thu, 23 Jul 2026 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784795207; cv=none; b=QzOtwCj6FYu+m9pMykFjYTmthChJPgHi8StT17CToNgBDoY6bqjCJL4AuFEq/vZxJpu07DsIrQrh2x7lbWVlrZ1uhN+eYW/UU0yvgURoRRaFqDY0OINM1SAwr+5zetgg1Cq1OZBhGKxNkKl+laiIEe0RGTxGAl1qJtwHcuSynVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784795207; c=relaxed/simple;
	bh=hLT73xbfSk62esfvnw6GvwdF5YVZpfjTwohB9aspol4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YS15ERECLC7x4KGFjgmRSDPaAzi6cUINKBERfLeIS4ZYtgOGSN0br8VrWXpDkGhWQZm3DQs60mv2fVhKfIGqsGsrNEF5ztz1YRKOY81vdJpl2Bp2CW9QEGvJDtf8KnvSwT6kSjZ5CHq8lM1Pi1G9K60KMnsj00kiGiLpGYbrIxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MWG41fq2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MWG41fq2"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so2731275e9.3
        for <linux-modules@vger.kernel.org>; Thu, 23 Jul 2026 01:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784795202; x=1785400002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0LP6SRmtvPpKp+hB3DWKFFGnbVrOAHbyMKn00zrHg58=;
        b=MWG41fq21Vq3l2FiNXbsoCRpXYQsjjEAcx2jm20Ew0kru7vpascDXZUENg0uV+Bocm
         onYiE9OqwcnyZbkjEB6PXQX0Qm4R3IYkOG6Xy6z8eKUgkNUF8u2Kkp5fA/aY/frawbhu
         zBBp6EL2pXOycKJkVlSGzgxBXpDZ9H6B7cLm0QHEqBBdedcCeJwWwTKBAfB4887Vw73+
         p+o994K+XnNUK02AnuEDYuyIbrww7qgVpuWz3M8YLv33LflHRM2UmQMo5zI/YQf+16O9
         KApMkHw83fnH+byYjh/HAqybmq8Ar7/4FCJ9xyfK1mUZQ+a65es9wCO2wn5JTj6ST2ks
         mPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784795202; x=1785400002;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0LP6SRmtvPpKp+hB3DWKFFGnbVrOAHbyMKn00zrHg58=;
        b=AdIRAX0saZepBtLklJrbKbVc0Sw4cBmqZSL+UqMLY407ybtNfwG5ngua+Bs0g10FvQ
         iJUBmVkyG0QqvYN1dF1uCEj6Ceuo/X6V0fkBYz3sUimHbZbjFQXKHIAJC4IO9wwteepY
         brXppUC9Cl0N1FX9rxrypfF8rAccmRPjG/557aT+/rd22EpV/lLGE7tiseMOtNKMpUCw
         JpK31BSwdfX1jXjQ8yFPaMkQRBJRnHI27IET2iljFDI1n04P3fiKt3bmMLb/lsZ6kvK8
         HzxEGYOhJG5RyVxsbNyOgHUYC7dnFsYpUIQG+oj+WxwAOX0y3et7zXBi32DeQRl1eB6O
         favA==
X-Forwarded-Encrypted: i=1; AHgh+RqJD67DNkp70O6FlUGBMO+vtlIjxugqXsgj5RjiYMlr7mrbAqXkRXFzq7aFPvrxeNLguAqwiFfOfchg2mlo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc6nTbcnPKjDtd1h1YZDh15/ny7aI/ngpdFsSZkvRMWeobciYN
	7+SWErNjAJdHIHReHVETkYdMVqv2T6mrb8ovzSXFi3jnhdjUH480vYQlBy99hbM3Jd0=
X-Gm-Gg: AR+sD11CWkKJXEnY4j7oSh9s5LAZj81e+DFSYqhJ+FRIKGDi3M3ECfMSSq3aSL3dQay
	TY8KvhGjoBb8nw0hFz41SNH2b8SdPc48bIj/unHuy9OwMB1lHGKCR1i8k+me7ssPiMuGTCPc0yA
	kCBljl1breDhtsKDSGOYqWM4NWaQGDeb5YeCVCKts8kGgruQL2FA37eJv3aYp/7yTCp1IsYue+/
	4JYjIMPcuFR7nOa0RWf5tU+++i92y2fpnbgdz16BV8tAohX0kYWyQEwkM6tQy5tRij3cYUMon/V
	IiFMlwl8UlIvUwd5ypf+QDw8/2a2Rxp3KYezg28k+11BPmtSMWy55eiMQVOS335rfWwQTM65F2f
	vQDv46GUfdZ5Uo8Y/482/ZyxS0MjBlgR+L68Am03TKsIwVqRC3fktD2yNjpk4Yed84A0C4/uO3w
	==
X-Received: by 2002:a05:600c:474e:b0:493:ee2b:c876 with SMTP id 5b1f17b1804b1-49573d22ee7mr26112725e9.35.1784795201619;
        Thu, 23 Jul 2026 01:26:41 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4f9a1csm124831645e9.5.2026.07.23.01.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 01:26:41 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] module/dups: Inform duplicate requests about the result directly
Date: Thu, 23 Jul 2026 10:25:51 +0200
Message-ID: <20260723-module-stats-rcu-v2-1-bd582261fae3@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723-module-stats-rcu-v2-0-bd582261fae3@suse.com>
References: <20260723-module-stats-rcu-v2-0-bd582261fae3@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When kmod_dup_request_announce() announces the completion of
a request_module() call to duplicate waiters, it queues a work item to
invoke kmod_dup_request_complete(), and only that function calls
complete_all().

This adds an arbitrary delay that is unnecessary and provides little
benefit. Call complete_all() directly from kmod_dup_request_announce()
instead.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/dups.c | 43 +++++++++----------------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index 1d720a5311ba..b063bc423aa8 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -48,7 +48,6 @@ struct kmod_dup_req {
 	struct list_head list;
 	char name[MODULE_NAME_LEN];
 	struct completion first_req_done;
-	struct work_struct complete_work;
 	struct delayed_work delete_work;
 	int dup_ret;
 };
@@ -93,29 +92,6 @@ static void kmod_dup_request_delete(struct work_struct *work)
 	kfree(kmod_req);
 }
 
-static void kmod_dup_request_complete(struct work_struct *work)
-{
-	struct kmod_dup_req *kmod_req;
-
-	kmod_req = container_of(work, struct kmod_dup_req, complete_work);
-
-	/*
-	 * This will ensure that the kernel will let all the waiters get
-	 * informed its time to check the return value. It's time to
-	 * go home.
-	 */
-	complete_all(&kmod_req->first_req_done);
-
-	/*
-	 * Now that we have allowed prior request_module() calls to go on
-	 * with life, let's schedule deleting this entry. We don't have
-	 * to do it right away, but we *eventually* want to do it so to not
-	 * let this linger forever as this is just a boot optimization for
-	 * possible abuses of vmalloc() incurred by finit_module() thrashing.
-	 */
-	queue_delayed_work(system_dfl_wq, &kmod_req->delete_work, 60 * HZ);
-}
-
 bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 {
 	struct kmod_dup_req *kmod_req, *new_kmod_req;
@@ -130,7 +106,6 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 		return false;
 
 	memcpy(new_kmod_req->name, module_name, strlen(module_name));
-	INIT_WORK(&new_kmod_req->complete_work, kmod_dup_request_complete);
 	INIT_DELAYED_WORK(&new_kmod_req->delete_work, kmod_dup_request_delete);
 	init_completion(&new_kmod_req->first_req_done);
 
@@ -230,17 +205,17 @@ void kmod_dup_request_announce(char *module_name, int ret)
 
 	kmod_req->dup_ret = ret;
 
+	/* Inform all duplicate waiters to check the return value. */
+	complete_all(&kmod_req->first_req_done);
+
 	/*
-	 * If we complete() here we may allow duplicate threads
-	 * to continue before the first one that submitted the
-	 * request. We're in no rush also, given that each and
-	 * every bounce back to userspace is slow we avoid that
-	 * with a slight delay here. So queueue up the completion
-	 * and let duplicates suffer, just wait a tad bit longer.
-	 * There is no rush. But we also don't want to hold the
-	 * caller up forever or introduce any boot delays.
+	 * Now that we have allowed prior request_module() calls to go on
+	 * with life, let's schedule deleting this entry. We don't have
+	 * to do it right away, but we *eventually* want to do it so to not
+	 * let this linger forever as this is just a boot optimization for
+	 * possible abuses of vmalloc() incurred by finit_module() thrashing.
 	 */
-	queue_work(system_dfl_wq, &kmod_req->complete_work);
+	queue_delayed_work(system_dfl_wq, &kmod_req->delete_work, 60 * HZ);
 
 out:
 	mutex_unlock(&kmod_dup_mutex);

-- 
2.54.0
