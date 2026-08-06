Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C656042A174
	for <linux-modules@vger.kernel.org>; Thu,  6 Aug 2026 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007501; cv=none; b=OYcmyhuDobyOdliPnKw3SCOOXs3MZEZKI+Un+gTBgZyS7/ceixyA+SvMDMPsc9tN7vFnuzjernfBsCPesEdM192lMJBwY5YDnlds6Rkw0tPJk/ByKiMI9RvLLcr4a+gNH8LI3oyrbVLRxSrYLzYUBzRd/+0JdIUNwnb6Vm8AfXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007501; c=relaxed/simple;
	bh=NNlWVhX6UHTWMt1ZUwumPlXUWe3hnI6iCyPh4FiaA7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUUv6sANP44QWyUyUMpqq61CRFWFtwLRV2l4MYR1SP2m/RsUTeOSGmfIolMMMokb3ab7U3RqpGXUunbkxcAn9hdDP06rpDRm64rktJuMSug08sRyhr+35TJ/Bfv8hf6j8qJzG0h9mhz0BrsEEFNXtfOAFzKRyQVDxPq1FA/rqk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GtzzSVKB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GtzzSVKB"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso14155255e9.0
        for <linux-modules@vger.kernel.org>; Thu, 06 Aug 2026 02:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786007497; x=1786612297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WuNiIa3LGK4xoLnPFwM4puJSPHXpLQhSt0boOdOltIw=;
        b=GtzzSVKBMq5xyWWH5TJuzT3SQ/3Mxy74yxRtraXougfkzEajl7JqwB6rmHofoQtq4y
         5+roQOG3OZZMtHDMKpj2eccmQaotiSLneKLtHCuvJFKVHpz9je6/4Gypp7bO7bLtBSRx
         mQMxgT183m4SgQL2HCImLxZuwi1hpuGQ+zpP95Iaqkf7U1CubX9B5VxcjQBeyCcuOuKu
         UOs2s7K/jzRuR3eeu5kuH6tKbNYjNrQxnSOpxf7W4lmkHN71KzP4RuCy5OXn/gGG36AV
         uzUcBb1yUdIr+gSSMeKAqZZbDOFBbZWaRzf1td6HF+kCvlA6pGwf58G8uJu8AxAESR8+
         vMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786007497; x=1786612297;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WuNiIa3LGK4xoLnPFwM4puJSPHXpLQhSt0boOdOltIw=;
        b=PjiGDj1u5lSZiyZ7FfM2V1O/7JnMRkmrubVZ+sOtjlGdaUVc9emvKe7ZXEdCP6nm0S
         HcZ/1SrBENbF4WtLtTcsxL+KO8/WyzvS1dqhQ+gpmdE5iUk/biXVgIzH3olfSz1X6fVF
         n4qcDmO1u3kG/Axj1OEEOnG61Vw8v64zMbg28iTG4agk2MWybo5TpghaNz5PlRr26imH
         EgLu3ulE7j9x62SEVxxfz9qiKKn5lFKVsblX8R8I7iyvLL+DQcialp8mWDXTzM/rY4Jd
         Jk+1U+0YGQlmGHkRmJwb2ibXv3typEk3BUOgMyDCswUvDMEWqO+Pe+tcXmgpmjaAQ5X+
         2fNg==
X-Forwarded-Encrypted: i=1; AHgh+RqdOLwMuM9CK/cyxmAWvKV2iB7C3BQf3TbnEWbBsEDDC1pn7hhca2vncO06yOrmmLvUXPMSsBnFAbb9GReQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfj7HPyDtbOaEreaJkxF9KeMzGC5eLUu3T9Uyy/uKu6Xd0303R
	6PxIIYVfzCM0p4fLm1SDQ0dwh/hE2/9y6B0mExCuScnQo3prXFiytdZG13o9QvFgIK8=
X-Gm-Gg: AR+sD11ElpttKOGlV4AggIH2ESNfY1/j5Z4qIUkNxDD8ghlyECYH+LUehM8Q3XxaeLh
	2AYtNs+Fn1Fj7yJe5ZJ3YdkoM9HEcDmXdAeepdbwdMeHyevnucvI2yrU7dX59aZHtFfVQMBiuAi
	E0CTCYAHDfTfU68SMb4Xvcu6a7pIxsK1zpx+nxMwe1Pmwuf0u25yMd84sBNl/E1m2vFLdQ0UEEr
	k7C0uCXbdiIoU/oaeSc7e0ihQ1PCCqhBB76B5rZkY/4Rv4yS0ynYPcvCCn6PAnel/LsfYVxQEAT
	+C1ZkBekKjQTQuveHRlYlsA5zHFe22DdltIm6SfUDt9x0QjPzrmCisQlbojmtnr7w7yn+MQ3Phk
	lbJC6OO6KMb6FJv0HIHu9GaBEhpUG12JTvs75iJRCcmqY+H2gJZWFslEVH7ZZfyRnbIUjdd5Z3d
	myiqS3Qv5frovSlHD27cJFJ9z1fJmbIYhJF3uurBTfNG76TIR9tmBy/at5
X-Received: by 2002:a05:600c:8b55:b0:495:3de8:33a6 with SMTP id 5b1f17b1804b1-4994e7cdd39mr196760165e9.16.1786007497149;
        Thu, 06 Aug 2026 02:11:37 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4c32e0sm93157095e9.0.2026.08.06.02.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:11:36 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] module/dups: Fix use-after-free in kmod_dup_req lifetime handling
Date: Thu,  6 Aug 2026 11:10:16 +0200
Message-ID: <20260806-module-stats-rcu-v3-2-2b0331106f00@suse.com>
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

The kmod dups code uses RCU to ensure that a kmod_dup_req instance is freed
only after it is no longer referenced. When releasing an instance, the
kmod_dup_request_delete() function removes the kmod_dup_req from the
dup_kmod_reqs list, waits via synchronize_rcu() and finally frees it.
However, this doesn't work correctly because parallel users referencing the
instance in kmod_dup_request_exists_wait() don't enter an RCU read-side
critical section. This can result in a use-after-free.

The kmod_dup_request_exists_wait() function may need to hold a valid
reference to a kmod_dup_req instance across a blocking wait until the
corresponding modprobe command completes. This makes it unsuitable for RCU.

Fix the issue by changing the lifecycle management of kmod_dup_req to use
reference counting.

Fixes: 8660484ed1cf ("module: add debugging auto-load duplicate module support")
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/dups.c | 56 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index 45080f451e5c..db7377229703 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -30,6 +30,7 @@
 #include <linux/ptrace.h>
 #include <linux/async.h>
 #include <linux/uaccess.h>
+#include <linux/refcount.h>
 
 #include "internal.h"
 
@@ -38,13 +39,12 @@
 static bool enable_dups_trace = IS_ENABLED(CONFIG_MODULE_DEBUG_AUTOLOAD_DUPS_TRACE);
 module_param(enable_dups_trace, bool_enable_only, 0644);
 
-/*
- * Protects dup_kmod_reqs list, adds / removals with RCU.
- */
+/* A mutex-protected list of active kmod requests. */
 static DEFINE_MUTEX(kmod_dup_mutex);
 static LIST_HEAD(dup_kmod_reqs);
 
 struct kmod_dup_req {
+	refcount_t refcount;
 	struct list_head list;
 	char name[MODULE_NAME_LEN];
 	struct completion first_req_done;
@@ -52,12 +52,24 @@ struct kmod_dup_req {
 	int dup_ret;
 };
 
+static void get_kmod_req(struct kmod_dup_req *kmod_req)
+{
+	refcount_inc(&kmod_req->refcount);
+}
+
+static void put_kmod_req(struct kmod_dup_req *kmod_req)
+{
+	if (refcount_dec_and_test(&kmod_req->refcount))
+		kfree(kmod_req);
+}
+
 static struct kmod_dup_req *kmod_dup_request_lookup(char *module_name)
 {
 	struct kmod_dup_req *kmod_req;
 
-	list_for_each_entry_rcu(kmod_req, &dup_kmod_reqs, list,
-				lockdep_is_held(&kmod_dup_mutex)) {
+	lockdep_assert_held(&kmod_dup_mutex);
+
+	list_for_each_entry(kmod_req, &dup_kmod_reqs, list) {
 		if (strlen(kmod_req->name) == strlen(module_name) &&
 		    !memcmp(kmod_req->name, module_name, strlen(module_name))) {
 			return kmod_req;
@@ -86,10 +98,10 @@ static void kmod_dup_request_delete(struct work_struct *work)
 	 * just returning 0.
 	 */
 	mutex_lock(&kmod_dup_mutex);
-	list_del_rcu(&kmod_req->list);
-	synchronize_rcu();
+	list_del(&kmod_req->list);
 	mutex_unlock(&kmod_dup_mutex);
-	kfree(kmod_req);
+
+	put_kmod_req(kmod_req);
 }
 
 bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
@@ -105,6 +117,7 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 	if (!new_kmod_req)
 		return false;
 
+	refcount_set(&new_kmod_req->refcount, 1);
 	strscpy(new_kmod_req->name, module_name);
 	INIT_DELAYED_WORK(&new_kmod_req->delete_work, kmod_dup_request_delete);
 	init_completion(&new_kmod_req->first_req_done);
@@ -136,10 +149,12 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 		 * keep tab on duplicates later.
 		 */
 		pr_debug("New request_module() for %s\n", module_name);
-		list_add_rcu(&new_kmod_req->list, &dup_kmod_reqs);
+		list_add(&new_kmod_req->list, &dup_kmod_reqs);
 		mutex_unlock(&kmod_dup_mutex);
 		return false;
 	}
+
+	get_kmod_req(kmod_req);
 	mutex_unlock(&kmod_dup_mutex);
 
 	/* We are dealing with a duplicate request now */
@@ -169,7 +184,7 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 		 * calls bail out right away.
 		 */
 		*dup_ret = 0;
-		return true;
+		goto out;
 	}
 
 	/*
@@ -184,12 +199,14 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 					TASK_KILLABLE);
 	if (ret) {
 		*dup_ret = ret;
-		return true;
+		goto out;
 	}
 
 	/* Now the duplicate request has the same exact return value as the first request */
 	*dup_ret = kmod_req->dup_ret;
 
+out:
+	put_kmod_req(kmod_req);
 	return true;
 }
 
@@ -199,15 +216,25 @@ void kmod_dup_request_announce(char *module_name, int ret)
 
 	mutex_lock(&kmod_dup_mutex);
 
+	/*
+	 * Look for a kmod_dup_req previously added in
+	 * kmod_dup_request_exists_wait(). Note that a request_module_nowait()
+	 * without its own kmod_dup_req entry can announce a result of
+	 * a concurrent request_module() call.
+	 */
 	kmod_req = kmod_dup_request_lookup(module_name);
-	if (!kmod_req)
-		goto out;
+	if (!kmod_req || completion_done(&kmod_req->first_req_done)) {
+		mutex_unlock(&kmod_dup_mutex);
+		return;
+	}
 
 	kmod_req->dup_ret = ret;
 
 	/* Inform all duplicate waiters to check the return value. */
 	complete_all(&kmod_req->first_req_done);
 
+	mutex_unlock(&kmod_dup_mutex);
+
 	/*
 	 * Now that we have allowed prior request_module() calls to go on
 	 * with life, let's schedule deleting this entry. We don't have
@@ -216,7 +243,4 @@ void kmod_dup_request_announce(char *module_name, int ret)
 	 * possible abuses of vmalloc() incurred by finit_module() thrashing.
 	 */
 	queue_delayed_work(system_dfl_wq, &kmod_req->delete_work, 60 * HZ);
-
-out:
-	mutex_unlock(&kmod_dup_mutex);
 }

-- 
2.55.0
