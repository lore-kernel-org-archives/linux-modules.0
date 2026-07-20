Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C517407576
	for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549808; cv=none; b=iKY0WtBdVUHoTzYjjvUY13BvojWAfVwHDTawqeAPy5QwtQ6i4Vvxvap1wdssgHadxGthImldnJGoSvpI0sU1LrePruO8qK2NXlvHDKH4gr8Zi9Udw6tyyMyBPU137uKQrX8ukksznbEQfPM89RX+MF0uDXVq2RQl4axlutP5Ejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549808; c=relaxed/simple;
	bh=3HGOA6VhjvGyvWPdk6WGIWbxQtwwbNPJzqlF2eKCGOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tH53sbw0GUyA2XMuzx2lC6gW+BCh060ytgtNPyWIkGiA65XI64Z7GH4XKM2LX33Wqo2hixkUHZbvGLTgoLNIU5GVxnsWXwomJKC2HK76bNj4nJ51nND27ik6H6TvUtU6TXLeAqM26XJnk+SilW5K3g8Fa7rkazTSz2xuKCq6luA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SM1E6Z6i; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SM1E6Z6i"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso9253065e9.1
        for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 05:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784549802; x=1785154602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=84k5w20exl8o68gfzi1gN+O6EaVyG4b1i1ghtEpI+Ys=;
        b=SM1E6Z6iB0xwE5NojYP3o/hlzzkCzpR/7fo1oYffq2yvuLI1l7VmOkv/heW1UtPv1U
         HdAj+H81qLMA05CWA21BV//JYWZU5yLRAfWvTjL1GaGwlAx+Q2N8vjYmXhkAvYbFxdpH
         uFRCGha53aKbXlzGVVsbQ0SUQeoPFcthqMeCfFUebp8YPg8UePyYt+GrTEdXQYlfFLKr
         g5RdTK/gLYNwzexhT1QTVCUPFfJwJvvvbMPbzyFTG1hODmd3DMbEbJIxxi8aU7NxJDEz
         sCl1z1ZL+dIok4CbyuUwDb8eUSbCi6xbLbkST4C/+xdCrEKsPwH9w5iP0ulfkUTVWY/8
         KNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784549802; x=1785154602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=84k5w20exl8o68gfzi1gN+O6EaVyG4b1i1ghtEpI+Ys=;
        b=ElkCofkCdC+dhKCrXLwhd9Ul4b3CuMi2putFQACimJGCepAL0W3CAkEGt/7bVzOsNA
         Oi3Rp6LpWBI1IM0jrvUMviu2jp5IBG5fS1B9izWq2A8bN+4WmJ/eVQpIC1Kj3ky5/vbc
         opv3tm2vbGIZ4KV/1ACuOsftG++V6v5Wr16AYDkM7IEZznfLCTgC3O72dC5gDsrfFPQR
         6T09SaPRKyPuYWAgeAdwoeCoqldmwMgJCq+eUTX3j/1L2TzWDPWQxHzYG5eLUwRSGDiH
         6NT5WLXZnNM/C5nsdFu+usvl/FXt7kh1BwSOLt6XSEna3NURUZoJzERPvvwDWWihNMCL
         Hl3Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro24Xzo4nyXPjQ7OpanqmeberiMN2vTFg6PRJU1D0vMvRF7ehfi+R59LzB2NgYqcrhn5/JwwTHC+9kyjybG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh0OLrGY0LIzAEscoFJ3prpfSorKJPMg05T0F0F6tUcWd1Kh7k
	ph2emXPxmWGoKf7cY//T8je+hCTcjxspR2077KylDUhDvifDJna+R9Kpb2VTIg3HB4g=
X-Gm-Gg: AfdE7cn0J4sfCi6MD639TYwqd3VISfq4rN9CqtCAlCzL0t4bZ+pD4jLzY+5x/FxtUES
	JNuNWEEzyRKvys+TzRcgCZZCU8o7usqy5C08IW/5DIoqVMEHo5RfGk9apIbFrV1/7lyT7looerD
	gdUAIaL+eJDlpDa8GSBtlCHZgAFW/Te/k4eXdXalTmu3c4/InbEFXG5yl4CcUt0soD4fxNhmkJA
	bMHedrojK2JXBVOM98dqNCVbY5hKl8dYquBPsksvgXH+GPqbtk0IqKRxNgLGZJWjIPMb32jZx+F
	/Vjc8pKJcwMkX7YI9wtpuBWXGS4zQNzKh+9Q8WbuMfMjUhL24ScM1DzxRzzPPsTrL9JsMnPmZ9U
	piKLjObKe2g8W2ALZDoh0iDTAvFRnVkdT8cvf2eHNMKag9vO99TlaT+q+8ybFt+y6sKBUjpElkE
	lsiZsbyhMJ
X-Received: by 2002:a05:600c:19cd:b0:493:f764:1f69 with SMTP id 5b1f17b1804b1-4954a3d0889mr169559705e9.8.1784549801848;
        Mon, 20 Jul 2026 05:16:41 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ed1911sm31424338f8f.22.2026.07.20.05.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 05:16:41 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] module/dups: Fix use-after-free in kmod_dup_req lifetime handling
Date: Mon, 20 Jul 2026 14:15:26 +0200
Message-ID: <20260720121621.750661-2-petr.pavlu@suse.com>
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
 kernel/module/dups.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index 1d720a5311ba..e1828e865edd 100644
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
@@ -53,12 +53,24 @@ struct kmod_dup_req {
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
@@ -87,10 +99,10 @@ static void kmod_dup_request_delete(struct work_struct *work)
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
 
 static void kmod_dup_request_complete(struct work_struct *work)
@@ -129,6 +141,7 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 	if (!new_kmod_req)
 		return false;
 
+	refcount_set(&new_kmod_req->refcount, 1);
 	memcpy(new_kmod_req->name, module_name, strlen(module_name));
 	INIT_WORK(&new_kmod_req->complete_work, kmod_dup_request_complete);
 	INIT_DELAYED_WORK(&new_kmod_req->delete_work, kmod_dup_request_delete);
@@ -161,10 +174,12 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
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
@@ -194,7 +209,7 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 		 * calls bail out right away.
 		 */
 		*dup_ret = 0;
-		return true;
+		goto out;
 	}
 
 	/*
@@ -209,12 +224,14 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
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
 
@@ -224,6 +241,10 @@ void kmod_dup_request_announce(char *module_name, int ret)
 
 	mutex_lock(&kmod_dup_mutex);
 
+	/*
+	 * Find the entry previously added in kmod_dup_request_exists_wait()
+	 * that is owned by the current task.
+	 */
 	kmod_req = kmod_dup_request_lookup(module_name);
 	if (!kmod_req)
 		goto out;
-- 
2.54.0

