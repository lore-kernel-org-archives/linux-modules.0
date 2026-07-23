Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C784335C6AF
	for <linux-modules@vger.kernel.org>; Thu, 23 Jul 2026 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784795208; cv=none; b=NETSQ+vPPvovipcfzIgqIq1+erTZDjT7nYNANHgFtr82bg3bT1o0A+PofZNgnHoK4GFVkAC2TOSbRitxOW2syncybZ2/Q4mqrjzo6QGWtQ1Cn2HErnTrYfciUHdX8Y5P71NITaTLlHAiertTQMudsA677nnAMdCLnfKxuom9nzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784795208; c=relaxed/simple;
	bh=49xIm8JVVxA1IO8RnKUTcUahhuvMP7ZhANoSnO5slgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8wkGMoRotcpxqY9as/TNzwlI2E3xShne41c2qQNjPbFf/57QsKpExccKj29TvelLl6onLQ2gXL/IEJPuedKT/3/pIkCV0lFa8FYLuFNC3i6XKlRtK2nOBc1ZeXVq4Zy2xIAdzyvpINRvHupy11BVmdZX0AEwpGBxHNDodKNios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eLxTLKJV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eLxTLKJV"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4955de8797cso1657075e9.3
        for <linux-modules@vger.kernel.org>; Thu, 23 Jul 2026 01:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784795202; x=1785400002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ejMHszX4krSpU2meGRfcTBBnbHvAJ6f3bfAgNnoNb/s=;
        b=eLxTLKJVjJCqGrGhTDGpCarD1GOJuWMD1R3YmU1GRm0spBdzx9x1a1ax1Y7z5S7P9V
         nV5Bp64PXrBKL6h/1u9IX4vJ/i2ohtqCQ8ILvx0QyKmAegkcruwFUAegADN4n/EMlN3O
         ruTizbYyjD0THON711TAtLhlMRBx70Khce9yW3fubgd0bNs+4h/tPUYNbQvJRn8qWmM3
         4zFfj7X1LJogk+VAmU7nem/nbIz/YUtC/0sn70vEeY5625jUFHBtow69iC8tMwh7sZhq
         rSaqJ56aESqe3Ie5SV+5/AgltH/54rHoCMwqeIw+zd8XpKBlUkrqdjRTo8rXSGrfm6XL
         vb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784795202; x=1785400002;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ejMHszX4krSpU2meGRfcTBBnbHvAJ6f3bfAgNnoNb/s=;
        b=fG+18R4lL4KkmFi57MdIMhmBJNgUb7yBnzRi7+o7NHrzAprP9MtkdROrzuH9ur1+Ip
         ncpgrlZF+ywyB4FAMA8nLL0cK4ovnsyQ2h9FNGafBLzEdSewWT1JO7A5GwOywonvQYxv
         Tkqps1SDM5VoD8eyEXAIN+gyh02f0T1fiW2Ivw0JoWF7PO1B3rtNb5/rjb9tK4cfXLu6
         IZvw8codtVt8MAvk9dx/GnfoehPNS8PV3ans3GCe3WC2pHF2kVySiIzp+krX+FoLFihI
         XfyxbKIDKtNGyFsUabL0x7SzOieHyE4Vuy4e6fTKtde0BupFg7/UrQYAubr2qrm5bYV9
         baYg==
X-Forwarded-Encrypted: i=1; AHgh+Ro91Bn8PHpxOhchVEPowWAr5kcnc9Kbcqq9tosk5UEKENLnqv/VQjDmTemywa1uIpXZtag+d1eSUJDJH3va@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1apdBB/Nn++sFiftqjGsjFeiQXzPBrF6hY2yft24cDlWeH0Wz
	NcIEMRHC6vIP7U2Mof86LNSawpjHVE8z5faybNdw0cqv1g7VH3KBC5bmDDTEle4diEg=
X-Gm-Gg: AR+sD13hiXJeZ0QXmmjmxOzYD2DIhlIW7XvmK/6EXE63AWmPXLG/j2DRVCuOcwC77F6
	4iet/HNcxMURLtXI5Ti6p1VEzfrKkm2f7PGnLoXK656Cs2R3p8gxd1fAryqu9Y9mfTceRwZm5cI
	o9LTA+aT1RSAjhKbfVzI5KIMuyklimpeCZEgsJ7/g5471gtQykVQRNmW+xEKKZivq22qRfnVEls
	d13cSknS/+pcF2Zkj9edLSevcZZzUolPV5c5v09t9MW2kuiwRdr9e3ykD1xIbIDqOJzh1P5N/HD
	uYck0FZEt0xWZqbfe8GD/2qTQ8OvTslgeWKD2p/gzHXo6b372l7IWQCFtXz+BCWfMR+cQMYRgjM
	m/wq4mwfWcWMoQNnnFWzLHxMqPjrBxCaKmaVNX+gxIODHcpGyzDE3wPRfaqH9mT8av9chXpYlJA
	==
X-Received: by 2002:a05:600c:a0a:b0:495:4dea:f7f5 with SMTP id 5b1f17b1804b1-49573ce968emr25120595e9.29.1784795202251;
        Thu, 23 Jul 2026 01:26:42 -0700 (PDT)
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
Subject: [PATCH v2 2/6] module/dups: Fix use-after-free in kmod_dup_req lifetime handling
Date: Thu, 23 Jul 2026 10:25:52 +0200
Message-ID: <20260723-module-stats-rcu-v2-2-bd582261fae3@suse.com>
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
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/dups.c | 56 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index b063bc423aa8..99661236490a 100644
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
 	memcpy(new_kmod_req->name, module_name, strlen(module_name));
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
2.54.0
