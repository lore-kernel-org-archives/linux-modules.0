Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3263FB7C7
	for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549809; cv=none; b=pI8S20IIIS/RV3CcfFPTwi53OFhKsEHGmNRiJ15u45Rmrw3CN93sQ9HoCskaT5dBmQLu7PI6sA8PdYiWZg7o4feaMrmOXTbCKVDbOX6i/+QtXTDlK+8ihLuM+VwaiAlPDKS2Brgjl6Z7Alljvee9qA68arpw9SmiLBuIlbfdv0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549809; c=relaxed/simple;
	bh=y7QvP9K6quV4Gyq9GwqoIKBapnIuTBwzwL8TWMBSwdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htjbVBn21Et9wCyh211Sb16XiGEZbvlIFLME5usnXyuyfPvuBuSLDhhKXUj3caFh3YAMl+MY3q7EaqpOELO2SAMyvuyRcU77UMJ1RtTR3vUP6cZnJN/n/cAGth2kVFXleAFh7UMzyZLFGgE0g01fktrF/EAVJ00e0UwsekP32Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F3ad+SXI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F3ad+SXI"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so18275345e9.3
        for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 05:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784549803; x=1785154603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FP9BawSk4EnMBpCTI/eZ7+cvzr/uqbM9j4RMitQlXio=;
        b=F3ad+SXIHcfhbwT1po3Bti0ZvyAcCegBxB9IewnQNPi9QJ1C0iLK9ile7drvuJWjMz
         nwtDiynEUMuAx0/Nwc131QSmTs4hysdqHkozJN7wPW19c/CdvOt3jsGUVwkQzRHeYj1C
         YSsHDIsVdzK1cbzOzXW3xhp7+ATjwlQOMCBXEZZhs6D9FwC4XGeEcgfVjb+Tku05yCMY
         lI33xcvDN+XEtexz5NMG/gZtobX1wEsP84WuYiQov2OI+j1vo9lBvbLHH/J8nKr5sUX1
         n2OqwhhDE7KGZbftTZ4/QJFZNXdnLlYsaBxm9VjCe2s1LETco1V3Rkjzk5dMVC4Wdu4Q
         RzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784549803; x=1785154603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FP9BawSk4EnMBpCTI/eZ7+cvzr/uqbM9j4RMitQlXio=;
        b=KJ/AxGhaboZTxEHnI946vzdGxaj2QX6YQ+WTrZkyWNWaZOwRyOoOtd0WYY99YAOUAm
         CURHC88zGRuTNboA1hQh3ti8zj3pfHEzQ+YrVBVPWVHkK9TaXfyk4zmLxZDvXWNDRu7F
         k2BPXtu5EPsHMO9sBqwQ16Jqh9DwG+oIfgxs/vLCt8noid48zcnmnxgPS1eCxnXhPTjc
         hUzsQwG4wgyBYX7UcjJ+ZDPTyxQgoFvIne62OS5XrQFdC/IAts4WAo84AggRxRa7W5u8
         d1EWbftyrEZHa180WytEOPu3cItCqpUh1O0IfcCjowBLm5Zn8BCBBWMc9Zm5l7a8gSbW
         FVBg==
X-Forwarded-Encrypted: i=1; AHgh+RojcmMRRhDbpHDrN0vJoANVz+Gom8RsCPymJ8LqFtSmVTiR605VV9ELjkacA3hY94+qL+FA70fer0l4tMnx@vger.kernel.org
X-Gm-Message-State: AOJu0YwanzlS+1Ujqs3M9PpvqgXrZfzC7NtOMye0gJWl9901RC/9zuYS
	6xRHfBVdukjrzH5Xj07WKxFuDKerGHrpI6pp/MUnxxPrgIlBE7yc0cAmMMk7fcQ8z7U=
X-Gm-Gg: AfdE7cmEsUNBuqb/xxY0s87IVfZI8sOxwIYxPWA0YCg5gM5yxyNahVIfBRgMncfTXBa
	S6rDqR0PX1Y25udfpUUZRV80LbWxK/uO76Ixt7LdH9wxwDXLghiygtgI/b5eCRnao7XpYHLTWQd
	MOgsrwCTLWpo60GOlKEZAAycfWrDLjqH1rxI1BdXCnzpbtevihSFvK2dUrEDiQG8yfPbeiNwcRh
	3ocWMzcjq1LxGA4E7YZzkZWOm6/bFyl+xOrH2cYHoqJ4iSU/p0yoHpqhSKsxx3lQ8aFwhx6nZvc
	qKUYBJByD+zlvFpaO2PgbqkVSyDEf5xx4TZdAN4qJhisETupkcC9IWSgO7cmCNI8AjuQ5LM9Zfp
	7HptsKLnPTtIrNSA0G2fQaxbOeNeudgbiNEtAfhbzJ+Chv/prq4u/JmQH+dxf25yCLdTjaJkGre
	C5QSRzjv0m
X-Received: by 2002:a05:600c:6298:b0:493:c182:6b08 with SMTP id 5b1f17b1804b1-4954a5125a0mr159730355e9.36.1784549802964;
        Mon, 20 Jul 2026 05:16:42 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ed1911sm31424338f8f.22.2026.07.20.05.16.42
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
Subject: [PATCH 3/5] module/dups: Use scoped guards for kmod_dup_mutex
Date: Mon, 20 Jul 2026 14:15:28 +0200
Message-ID: <20260720121621.750661-4-petr.pavlu@suse.com>
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

Using scoped guards for kmod_dup_mutex shortens the code and clarifies
where the lock is taken in kmod_dup_request_exists_wait().

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/dups.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index f0bdd7560d7e..a62619ec057e 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -97,9 +97,8 @@ static void kmod_dup_request_delete(struct work_struct *work)
 	 * kmod. The inneficies there are a call to modprobe and modprobe
 	 * just returning 0.
 	 */
-	mutex_lock(&kmod_dup_mutex);
-	list_del(&kmod_req->list);
-	mutex_unlock(&kmod_dup_mutex);
+	scoped_guard(mutex, &kmod_dup_mutex)
+		list_del(&kmod_req->list);
 
 	put_kmod_req(kmod_req);
 }
@@ -122,10 +121,13 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 	INIT_DELAYED_WORK(&new_kmod_req->delete_work, kmod_dup_request_delete);
 	init_completion(&new_kmod_req->first_req_done);
 
-	mutex_lock(&kmod_dup_mutex);
+	scoped_guard(mutex, &kmod_dup_mutex) {
+		kmod_req = kmod_dup_request_lookup(module_name);
+		if (kmod_req) {
+			get_kmod_req(kmod_req);
+			goto dup_req;
+		}
 
-	kmod_req = kmod_dup_request_lookup(module_name);
-	if (!kmod_req) {
 		/*
 		 * If the first request that came through for a module
 		 * was with request_module_nowait() we cannot wait for it
@@ -140,7 +142,6 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 		if (!wait) {
 			kfree(new_kmod_req);
 			pr_debug("New request_module_nowait() for %s -- cannot track duplicates for this request\n", module_name);
-			mutex_unlock(&kmod_dup_mutex);
 			return false;
 		}
 
@@ -150,13 +151,10 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 		 */
 		pr_debug("New request_module() for %s\n", module_name);
 		list_add(&new_kmod_req->list, &dup_kmod_reqs);
-		mutex_unlock(&kmod_dup_mutex);
 		return false;
 	}
 
-	get_kmod_req(kmod_req);
-	mutex_unlock(&kmod_dup_mutex);
-
+dup_req:
 	/* We are dealing with a duplicate request now */
 	kfree(new_kmod_req);
 
@@ -214,14 +212,12 @@ void kmod_dup_request_announce(char *module_name, int ret)
 {
 	struct kmod_dup_req *kmod_req;
 
-	mutex_lock(&kmod_dup_mutex);
-
 	/*
 	 * Find the entry previously added in kmod_dup_request_exists_wait()
 	 * that is owned by the current task.
 	 */
-	kmod_req = kmod_dup_request_lookup(module_name);
-	mutex_unlock(&kmod_dup_mutex);
+	scoped_guard(mutex, &kmod_dup_mutex)
+		kmod_req = kmod_dup_request_lookup(module_name);
 
 	if (!kmod_req)
 		return;
-- 
2.54.0

