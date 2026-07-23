Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68493E929C
	for <linux-modules@vger.kernel.org>; Thu, 23 Jul 2026 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784795210; cv=none; b=ObBkSWRUSr09SKMpedU/rNJBTIeA+3vID7v+0I+fBFe13xv9jc2BbaZqveTB9FHJviTH1h2OzWKqNka9YQatwY4q9+J+TN2RLXRzDMYguIQFk4myrTSEW3H36Osqc4eI/lNprgaQX9luw8bw8HRkIlCsaFjcaF6vc9fHeM3TOKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784795210; c=relaxed/simple;
	bh=tDp73uogEBcFI46+BNueLF1WmFv4AJinc2gyugciW0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLrFfZiEBQdh3O8SGoaw2Z55HF5/s8+wDuCvZFKQJwBAPwt5NmGw4TBDl47/VCs702qac282gasqsO3YZ14aK4TXhbXJGXnV3j7F2S0bxPdpg723lQ+mAlhx97cL02I4sFBQ1G9L3idEoiCbF6XtvXvsj5Pj2/PGHCgrCgTMsjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fSP4cjW7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fSP4cjW7"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4955de8797cso1657155e9.3
        for <linux-modules@vger.kernel.org>; Thu, 23 Jul 2026 01:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784795203; x=1785400003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7/fxpbVarwxZfvJOM0Jcqy1IhF862sfboRy7HWs6RnY=;
        b=fSP4cjW7ubQ/YQIyqJaD5DamYsM2LfApxIZuszousiN78C6VrbE6SrLIG7eqN6w7Vh
         3wCUXoNy/nTpRz8g7iFCKVDCcsHaTm+IK4eschInPgCzyd68iatjM0MVY2QDMN7gBVn8
         U4QoMRjjoLuJsIhQwbQG0AGlOrJqZpQBS14zADLmpOgP7mcBZhOBlkERMWBq4OLFwMDS
         Crbl4gu2ok8g9LJQmVOp9wSO/SUnneHvGtFQBrUH+lmSApM2Xh+l8tJEmzlXvDdV32gX
         OzTG99Xtbpx3KWs2AiXcwKxW5KNpA7IEm/BnmDvAzzugkQQGVqjxUxQuwaEMpGV+Sa0M
         kaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784795203; x=1785400003;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7/fxpbVarwxZfvJOM0Jcqy1IhF862sfboRy7HWs6RnY=;
        b=P7ham7a8sQdB5yiVYkvGa6tufXonBMjH8KFCsQ25sJwBUzMHPFsPCl5pX/xTdGZmxn
         4Sml2i9EIKk5y9nAWnqEOzZ2WDPSBq0LS71LKSlXCF4DcctxLXdxZ537vN5PS+Z/vwTK
         2oXkvCnbctEJTVMvj7foheIsiBKLD2KZt+XEVROhPO4sfAsD+0kn3/yx7DeIq6Nb/yc3
         7/QrZ5mpK2OkhmEotFmY1CqnUe42/UhhQQW2iPuSOP3NoBoBHuUzqqqTR4BVOAqfMsri
         H96PWkpgem5SUpofHGPa1wUOQQDmz7Vb2FJgTtboe9QvKe0hDkEnO89Lj6Eo4sPsqToU
         RKFQ==
X-Forwarded-Encrypted: i=1; AHgh+RrNFOJlThsYhVYiAoLgCOCZ3WKWEfqzBNqe/TiApSgr2XDoN55BqmmZ8V3G1qtQHsRJpQwHK16GPIgsnm7X@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCR1PuR5/eYYvdekLe4veZN0I/OVLWlQdESrkAOxPDGP87jk1
	47ZRFgdQngki09D+YNNZ5smMuW3nYEUE9Eob62qyO5TRgrODrZMl3kg853bduYU18XM=
X-Gm-Gg: AR+sD10OH1knFP10ITaapF8cL/pQMfl/6cAF7PLuVBh826c2oWTMW2SHOWMBEG7mqLz
	YakoHE57GvtG6a9fkUeFBjiSklkz6YhHxLo7wIM+Y3MrgIKHAA5Z8/t7OBaU4B6Pd+tFfk9n+wq
	pLCi7n2q5xYWf2hxG2Y881WZ10YYz0TNARjdzgrSinozbm1iqDFpEMVAVn+Y17AW8iWwbZQ3nBp
	jRv4GlejBPSqRH09HsUiHjm9nL2iiYMQmM87pc90XJ4utdUg2j51hWqTvsK1g1cczS7i9tI46h3
	WL89SdDG6vGotKMNZYTx0fsohWdX3tOAUSD3QIxJJhZY7JTAVhV+RP4jue0eoZGI+UuEzs7Dptl
	iEp0V+U9g3tX4WvZTFdiOsIenNTziuPDyvFfOlI3Uh3O4rr9BCK4sbpgEee3YrmxmXBqA38Ateg
	==
X-Received: by 2002:a05:600c:4ec8:b0:495:3da3:beb with SMTP id 5b1f17b1804b1-49573c9b559mr21221745e9.10.1784795202878;
        Thu, 23 Jul 2026 01:26:42 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4f9a1csm124831645e9.5.2026.07.23.01.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 01:26:42 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] module/dups: Avoid unnecessary kmod_dup_req allocations
Date: Thu, 23 Jul 2026 10:25:53 +0200
Message-ID: <20260723-module-stats-rcu-v2-3-bd582261fae3@suse.com>
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

The kmod dups code preallocates kmod_dup_req before taking kmod_dup_mutex
to avoid allocating memory while holding the lock. This provides little
benefit, since the allocation is fast and can safely be done under the
lock. On the other hand, it leads to unnecessary allocations when the
request turns out to be a duplicate and slightly complicates the code.

Allocate kmod_dup_req only when needed and introduce a helper function
alloc_kmod_req() to initialize the structure.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/dups.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index 99661236490a..0f6bb05b2d81 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -104,28 +104,31 @@ static void kmod_dup_request_delete(struct work_struct *work)
 	put_kmod_req(kmod_req);
 }
 
-bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
+static struct kmod_dup_req *alloc_kmod_req(const char *module_name)
 {
-	struct kmod_dup_req *kmod_req, *new_kmod_req;
-	int ret;
+	struct kmod_dup_req *kmod_req = kzalloc_obj(*kmod_req);
 
-	/*
-	 * Pre-allocate the entry in case we have to use it later
-	 * to avoid contention with the mutex.
-	 */
-	new_kmod_req = kzalloc_obj(*new_kmod_req);
-	if (!new_kmod_req)
-		return false;
+	if (!kmod_req)
+		return NULL;
 
-	refcount_set(&new_kmod_req->refcount, 1);
-	memcpy(new_kmod_req->name, module_name, strlen(module_name));
-	INIT_DELAYED_WORK(&new_kmod_req->delete_work, kmod_dup_request_delete);
-	init_completion(&new_kmod_req->first_req_done);
+	refcount_set(&kmod_req->refcount, 1);
+	memcpy(kmod_req->name, module_name, strlen(module_name));
+	INIT_DELAYED_WORK(&kmod_req->delete_work, kmod_dup_request_delete);
+	init_completion(&kmod_req->first_req_done);
+	return kmod_req;
+}
+
+bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
+{
+	struct kmod_dup_req *kmod_req;
+	int ret;
 
 	mutex_lock(&kmod_dup_mutex);
 
 	kmod_req = kmod_dup_request_lookup(module_name);
 	if (!kmod_req) {
+		struct kmod_dup_req *new_kmod_req;
+
 		/*
 		 * If the first request that came through for a module
 		 * was with request_module_nowait() we cannot wait for it
@@ -138,7 +141,6 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 		 * would benefit from duplicate detection.
 		 */
 		if (!wait) {
-			kfree(new_kmod_req);
 			pr_debug("New request_module_nowait() for %s -- cannot track duplicates for this request\n", module_name);
 			mutex_unlock(&kmod_dup_mutex);
 			return false;
@@ -149,6 +151,11 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 		 * keep tab on duplicates later.
 		 */
 		pr_debug("New request_module() for %s\n", module_name);
+		new_kmod_req = alloc_kmod_req(module_name);
+		if (!new_kmod_req) {
+			mutex_unlock(&kmod_dup_mutex);
+			return false;
+		}
 		list_add(&new_kmod_req->list, &dup_kmod_reqs);
 		mutex_unlock(&kmod_dup_mutex);
 		return false;
@@ -158,7 +165,6 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 	mutex_unlock(&kmod_dup_mutex);
 
 	/* We are dealing with a duplicate request now */
-	kfree(new_kmod_req);
 
 	/*
 	 * To fix these try to use try_then_request_module() instead as that

-- 
2.54.0
