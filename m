Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3242BE8A
	for <linux-modules@vger.kernel.org>; Thu,  6 Aug 2026 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007502; cv=none; b=KvNax0AafB32QxplJ3TgrSFQ0CX3ZVMxh7CDdXE9Irh9aNDK0enMbGSMEIfveDtadVWUocyn65cnwc0JCcWLKA55RHbFLUU5CIUyzcvdSaTlyPK5+uP8W2SJ8MX1ajlFlSbhWUAO1vxjyi5yi0Oadoq7+KAApGuVKHjfIZADHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007502; c=relaxed/simple;
	bh=gHYpCiquiPuzfw0VdPmWbBvz8c5AF5pIoFf55eZmMD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4tZouPkIzFVSy6X8iyhZbDWQanIy/ortGowzMuQdpv9Em1UoNl8z4SEl7BD0e40k43NbNsfug0qh0xjdn9EI2zH87jdSC2620/+UolYmFgrL1SyNld6/yg0IwcHrMtNCuM1zaNsaN1dsqyoI4D6d3UcCgCxoOHWUU0xb/acXOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NWgxOukE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NWgxOukE"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4956242332dso15292055e9.2
        for <linux-modules@vger.kernel.org>; Thu, 06 Aug 2026 02:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786007498; x=1786612298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3W5Kt8XCRH1ookmt7hLyt3rKd0QiLjUKVXtnwwecrfM=;
        b=NWgxOukEZ1Ejp78fDnNzgkuS7IvVyzwY1PSZuVTGS0tAVP/+TXl4xN4cjsV7MXtDJf
         gnG5fHDYPxtpiu1laAnwUbktOZyb/iJ99cWx+v5cVCBWLGGhopmae6Day+cPTQQmv2Ul
         3k5o9YhqzhHcocLbm3o6sJtf6DZ6DCid4z8U20foho0giNe/6VTP0gRdeSGFd+SmcoO9
         nWHKfok3aM1rzGInHYh+gNfIR+ATQiDqgLt3TfCXcAJx9osKNgr1U+Ng941SLDOe7Tl9
         qVeYb6tmUyWhwKHJitLLsIzta4WVl5o8GrK1f+OFAauPK1qRRLO2BXCMrxGE5QwyWoKk
         Pv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786007498; x=1786612298;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3W5Kt8XCRH1ookmt7hLyt3rKd0QiLjUKVXtnwwecrfM=;
        b=lPG8lNbgv9IyrxpePGGTnMjwbz4srbBm3yl9uxbHUOUOu0i8c2Qc77VrZUPBRRkwaU
         WAumadQFsPDS/MriQ+rA8oeGnuOGQm0fFObwhMfA3FticPYRKN7UMzDTIYDIAszvw1kr
         qulX9H3/cs3OOQiqUqQh6ytyi14e2s+2nWmHi47FALwSa2OLtyaVvfy1/+qqy7irzQnP
         h7P65YQYploxZYm1VtbvWEOM82QVpHtyHTLx1lCaeJEzNp5e3mfrUdg3V8zyJXJlUuNh
         m2tI8Y1pzfnpQ7L4jsyDsMQGSTY4tKsa1fnNWyn+i9FfUdqcfR8aPnYVBqR53TBy3u+D
         DwSQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdX0thFGAKOKK4MRjjKNpM53t4520BBVSJ67dISfLqlEik8MlP/Yy4nFwOyQ6JAITroqgfTxND9IunWB8g@vger.kernel.org
X-Gm-Message-State: AOJu0YwgpIVuLNN2FZ8+TfgykvNAI5bTDsEyZRENcvWMMlhGhTZ0jAtB
	86kD15YSp7bR7S74IBt6wyHtrOJf18bi4SuYTclEuYauL9RMj0OZcQLzlBgE9/fywDU=
X-Gm-Gg: AR+sD10+oHrLEu7rKspGVf7Z7mcXJd4+WhJLhcdZButoiF9J3r7cyp7b5IKq0O1uiPz
	CSRlibLogubaBuHEBJibYGCrrcbDBlST+P5FaIJ21/sYV+tX2cuFKTarrTNBbxxz66qWbpTVK5z
	o/M84xUvPL456ZdWMFguIOEL9j/cfOdyGElWUiHOk19K2NP4hcAlvkbCmSuT2qOYHbJ73vc4ycu
	6mDl0AzvKUyS/lcgTL7Z8leAGmYMns4GUtv3FNGh6O51AIqeVJ013RNm74QMjR9APrJs6c9Mnzr
	w5tgtpnkCUn9a69gPpjLXmC4YGKF5pWzlL6t2w+KONWDHXoOwv0uNHefBH8D7OomyxnWBtg0ShY
	FxeOlWJ1h2yACg3vAlLs991mZcf9M+PK0N+iyanaC6yIhcFDshufrkn/Fs2WdTTUVYp5tNBzE8f
	RtpRSiM/B5MqWoKdw/CIXKiHkELuw3ioj04rnWQyiP9dbtk+Fi5KXV07S4
X-Received: by 2002:a05:600c:354c:b0:499:51cc:4e57 with SMTP id 5b1f17b1804b1-49951cc6d0fmr109929275e9.0.1786007497764;
        Thu, 06 Aug 2026 02:11:37 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4c32e0sm93157095e9.0.2026.08.06.02.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:11:37 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] module/dups: Avoid unnecessary kmod_dup_req allocations
Date: Thu,  6 Aug 2026 11:10:17 +0200
Message-ID: <20260806-module-stats-rcu-v3-3-2b0331106f00@suse.com>
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

The kmod dups code preallocates kmod_dup_req before taking kmod_dup_mutex
to avoid allocating memory while holding the lock. This provides little
benefit, since the allocation is fast and can safely be done under the
lock. On the other hand, it leads to unnecessary allocations when the
request turns out to be a duplicate and slightly complicates the code.

Allocate kmod_dup_req only when needed and introduce a helper function
alloc_kmod_req() to initialize the structure.

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/dups.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index db7377229703..276016051ad2 100644
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
-	strscpy(new_kmod_req->name, module_name);
-	INIT_DELAYED_WORK(&new_kmod_req->delete_work, kmod_dup_request_delete);
-	init_completion(&new_kmod_req->first_req_done);
+	refcount_set(&kmod_req->refcount, 1);
+	strscpy(kmod_req->name, module_name);
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
2.55.0
