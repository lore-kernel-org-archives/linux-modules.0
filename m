Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22220426D2B
	for <linux-modules@vger.kernel.org>; Thu,  6 Aug 2026 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007499; cv=none; b=Mcr94zazVj4wswkhT/St+ni9DFzUesW2fe8Cp5Y5rq2Pl0WxIWjDyDZjSE6jfkC+D5MVga/ogXpT9emU08MjMtk1YGYLxNET3+Y9oZBnmGrUpH/KBwGt7jcGdtnw6D3nrcGl2XMbWWUkKLKtVf+0vCFvfosKvu2SIlGy45io69w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007499; c=relaxed/simple;
	bh=382YaSX9VKY57gg5Zc2yIAoHK5TXIXYZe3M5xBZpkn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rru6J3Y7+q1pthtItnuKWyuRLS2FdOqd7yqJ+FT7yvd8ESHt/S/glJUCbwCw4wCpLnXB+gkJWejjLp5t6YGCSkUfMrFaFwjsSGGF9jALyOaPGLyrQHgwSPR2rAxkcSTqLN3tn0Np11I9kE/PvTiFrU9zRtX9ru7BJ4E4bkmsxTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YTiesVAj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YTiesVAj"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954afac04bso21285045e9.0
        for <linux-modules@vger.kernel.org>; Thu, 06 Aug 2026 02:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786007496; x=1786612296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MvPkxu2M1aQJU5khje0h6+xkd+fbHQMlBQ/6GQVZV5w=;
        b=YTiesVAjxHtqmJmQIQFHLRfSiEAg0FhHVFoo5k1W6XJCE7k6yY6+UL1eN8O3BVQcuf
         Q2EIqu28hNYT31uDBj0KPLqBihY2/PjwZ1mi64pda2k08IUFGPoV9k181cMvoQFhc3NS
         SI+q5VpPzgoXCQYHQQ+NIFUv0wTckkxPacjHOBOfMV94sh4vu0c6LFNpyWw016oAy53+
         CJANa1hskwIOWX5JKmekvE+k2J1p4/LTOMLZZsMRF+HNtEhq8/4J4twz9qgZjqdwpnAF
         lUebqI/chX7XBgFrUeIQFNyvqGH2uCdLM+1NQuXvxIlANVUpXwv6O1tEsa8rj281UmmA
         pDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786007496; x=1786612296;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MvPkxu2M1aQJU5khje0h6+xkd+fbHQMlBQ/6GQVZV5w=;
        b=pSPbwJeGbGzIONbFpdRSySduc7+8fGcVG8wGXjOltOMsNrlJk4I+hoc0k1Zo4/FTx3
         7cJiAntmEcKzXMmwPDNG84vQbbGZAK5o7ftcLkDg/l5uTspe2tJSJv6AArFhTD0P/A2J
         SJEhO/DzeNERWE8iooMQgQq3zeEAI5DZZ7te+94Vx6Yxa8rZyPgONhpEBDDfTt42MoNg
         Dvo0AWtoM+TxFv/uvj4PpjErurgiADkUVoJ1QFAtlbwGaLCXlN/iESsNodRGwRbopVXn
         vhSSXEnZjBDTojcfkm0wPKr5rlzKeXP7T4pCnSW79YQnqaCUnvqo94LKCVvh2JhxYtSh
         aHog==
X-Forwarded-Encrypted: i=1; AHgh+Ros1RlXvCAkt316hm2FlG0w0mQBtLwQmcQbxpTStNx2a7uEtfwO4J4vulLj/bTDaSgHoWpl4a1ulibgy3B1@vger.kernel.org
X-Gm-Message-State: AOJu0YxhFqnNJ2Nm5G4Z5Yh/gRaCjT7zogTlNTKV8ENW2Y68nYFrvyKQ
	+OEikvInXRkAsMYcuwnM0Rtk6UWoIw3vGf7DtuqAOYX9YVYg2MyfxH3BWriUpWtIpCw=
X-Gm-Gg: AR+sD108hsqLHwfutRFeQ3mf47d1l4mFrPq8p1RMb4eDrMmDJS7njEAydIhxtzyVSPn
	YNBmGG4IjvsBHKNubMPB/kaMBdTk2544uKIXxhJbRQapeWLyHQaflcNJm8zqa58hxFjUeSC3KeP
	ZFc1/N+waBmegioPypsSL0pvhFpv0YquSJeueGZi+0r5g20jEmfWVdbnjcXQPWHSCFTTTvwVkVP
	pRhb8LYg4VzW81uk06sKmo0lSrTEvWS/avV3xH/bl5nGEy+LdWjXFdLfZDU8ohoOPulN2oCMt8r
	HF9Knat7V+7D0kV3FAVYYrJ3hsaZU6fekVMddqARcHHBrgDALtB+gdP5nWmAkHtNAfg9lMfIeap
	DQOBp2TziAoFMEmNWrJoRbVVGQg4Imqc2QFwa2zxcdkvOH+RUkn4dbK4Z2ct0SmdfG6ZfZXIz4l
	BK29jmfH/+8SdosL3kpH3tRgFGUJRR+7IrN8yNp/uaZCu7Wu7BCaAaxPHuEJurFQydG9c=
X-Received: by 2002:a05:600c:1f86:b0:499:52ab:a50c with SMTP id 5b1f17b1804b1-49952aba5b3mr69266275e9.1.1786007496236;
        Thu, 06 Aug 2026 02:11:36 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4c32e0sm93157095e9.0.2026.08.06.02.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:11:35 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] module/dups: Inform duplicate requests about the result directly
Date: Thu,  6 Aug 2026 11:10:15 +0200
Message-ID: <20260806-module-stats-rcu-v3-1-2b0331106f00@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806-module-stats-rcu-v3-0-2b0331106f00@suse.com>
References: <20260806-module-stats-rcu-v3-0-2b0331106f00@suse.com>
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
index 8b6f8f177de4..45080f451e5c 100644
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
 
 	strscpy(new_kmod_req->name, module_name);
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
2.55.0
