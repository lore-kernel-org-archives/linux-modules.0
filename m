Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E7369D50
	for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549810; cv=none; b=FZRq8xnhRW4ySSIBHY/hgwUf5cYzJxBq5rd7ENL7pg8EAMcq94rmDZVt/0jtm9iOzuOexQW+2uHzdrLrYBieYMwbDCqGj5oKS/nh/S0bvAzvLsByPSZR9SNrZz+mnclXu/CeysM5uqH7SYuKsNCrriIqBdThos5JXfiqXL3mlmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549810; c=relaxed/simple;
	bh=I27ZSoF/OSRvlq21arNznTNvwbY86IMVngIZDjHTjxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNuh7PpvDyqSaqzkJipn7dJ4NmzWxR6NJplasGvCGaz6dFGaaB2tuseBRouySR72zUbdRHEzi2sK7EqcuCstU5nbpkA3DPPyNOA1ThRf2Z8pwrcto7P22URLAiqIK6bRtI2Bid4FYTHVxXSSi+pxHl3ANuEhs5fEsXP3kPaUp14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MAtnohK7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MAtnohK7"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so18275275e9.3
        for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 05:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784549802; x=1785154602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZWDVnnTRs9ulUtHM6zxZ6aVf5x++4G1ngbdh0GBn31o=;
        b=MAtnohK7vAtv0l7JxtVdU/rQBMALWosUrSzCEQJ6UwwVauQ0iGeT1hOFw+gjEpK2Jh
         b+iwC6xa87N8auXSXbP1DEBJ89fbWRr+g8e31RFaBF6vthhIT/o3tvU3siTsdMKqkexs
         eV1mkauK4+d0o8pgqiX0dHk6dY8gNOBJQbsDlEnbtRYaqBIHKQUpIar6/fT8uJQclvJr
         19b0PZy77XQJVQNVv6SJPOyLHfL4IWOdSPuvSlomWalLx/7kdCvNqT0A4aRhwTGW/cVF
         oTgnMXx+8CV1bwKPFEvK97nkTer8dFczAgZXWwg9oPswNheWBHtp1zQAXYU2xkW3jqxn
         C33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784549802; x=1785154602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZWDVnnTRs9ulUtHM6zxZ6aVf5x++4G1ngbdh0GBn31o=;
        b=kl63yZ6/Wy8/+hKZ8UeEbF1BTlmbg73RQzGN4lR3ycOBlpx5UcS2aM6/9vgM/gETO2
         s0GLa2bqiKeCGoWsWvxIUqgIyESq5U4zP+WkoGJ5Kf81EL7c3snsE+5/vVh+tfaE7vti
         r29lj/chUjj5IcsoP7ma55tgAwnvJTL1Bm/anHWCSSqKW6ERAFgQwhxs7seV7WpZ0r5f
         ECT5KJSUoYkF9W2swhCP3jkM1cD55YSSAmRGTysD6UGOyX+jrsuq124j3eXOjj0qNd1M
         BojckCcNTV8N85qnmGJPXVewy6iRDBDkEwplm7Qpvd+q8ZsupCQkvFSeZ/lbnWlWa2eg
         P+CA==
X-Forwarded-Encrypted: i=1; AHgh+RrcO2kK5mTOVad+tIyf5t7Q2R3YHMzRHhHNdu116uQHUfGwoZkQwKeCAQXdjccg4URV2oCHIM0Cx4YMHnn/@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ3+Yhc/A9NNWGzZ1Heg89FSMa+s7LK6dMF/auLitTAP+TOaaA
	/LEM8Zze3bu+CPmpmGwsvpGBmggH+BQFE6LAZZLrcmxTdST1xpkev/Q7LBuknWch0u0+bjsp8tj
	DzAgt+Tw=
X-Gm-Gg: AfdE7ckz/ozdIcTcUqU28BLWAzX6ceJRmkwTDg7qa2cNtKyu7lfKYg5I4EPuQpomi1G
	LvYV54oM2cqC93Gv+zwngTD+vKKTZS/1Tm7NpkMn6Ej5Y6s9OiHaRSgizyL0JYCqIKdLbLMem/D
	oAK1e4QHpXIYWw55Wzaly+lZNauCo8anfCr556Vz0E73+ZkYY/eH9x0DftCfRVqC9dCj2rRuPyv
	xV8rAYfG8NQ22G9eNHB7eTkSkiSFdnXkJJOAeQVTSP3YETyh2+DpmghY9L+I0gJUTi2h66+uMhJ
	gY4b6viaMytcBUjA816xgIUoOaTa9RKob6AuNvNB98ql8KnuUiBju43/UPFlHRszJHUsGcBL7D/
	jtq++xrKVgQA6NfOy8cCCKIP0MSilnYzWhbEsMq3BQzLU1z6BUzdeCHSWHFyJmA83mi/33q88HA
	==
X-Received: by 2002:a05:600c:b85:b0:495:5365:c0d1 with SMTP id 5b1f17b1804b1-49553d85ea0mr100454075e9.14.1784549802399;
        Mon, 20 Jul 2026 05:16:42 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ed1911sm31424338f8f.22.2026.07.20.05.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 05:16:42 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] module/dups: Inform duplicate requests about the result directly
Date: Mon, 20 Jul 2026 14:15:27 +0200
Message-ID: <20260720121621.750661-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720121621.750661-1-petr.pavlu@suse.com>
References: <20260720121621.750661-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
 kernel/module/dups.c | 50 +++++++++++---------------------------------
 1 file changed, 12 insertions(+), 38 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index e1828e865edd..f0bdd7560d7e 100644
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
@@ -105,29 +104,6 @@ static void kmod_dup_request_delete(struct work_struct *work)
 	put_kmod_req(kmod_req);
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
@@ -143,7 +119,6 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 
 	refcount_set(&new_kmod_req->refcount, 1);
 	memcpy(new_kmod_req->name, module_name, strlen(module_name));
-	INIT_WORK(&new_kmod_req->complete_work, kmod_dup_request_complete);
 	INIT_DELAYED_WORK(&new_kmod_req->delete_work, kmod_dup_request_delete);
 	init_completion(&new_kmod_req->first_req_done);
 
@@ -246,23 +221,22 @@ void kmod_dup_request_announce(char *module_name, int ret)
 	 * that is owned by the current task.
 	 */
 	kmod_req = kmod_dup_request_lookup(module_name);
+	mutex_unlock(&kmod_dup_mutex);
+
 	if (!kmod_req)
-		goto out;
+		return;
 
 	kmod_req->dup_ret = ret;
 
+	/* Inform all the duplicate waiters to check the return value. */
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
-
-out:
-	mutex_unlock(&kmod_dup_mutex);
+	queue_delayed_work(system_dfl_wq, &kmod_req->delete_work, 60 * HZ);
 }
-- 
2.54.0

