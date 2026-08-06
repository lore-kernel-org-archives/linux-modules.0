Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4551E42BEA5
	for <linux-modules@vger.kernel.org>; Thu,  6 Aug 2026 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007502; cv=none; b=KFVqoKRiIaNIybqki2nBXsLUjPD9Iwp3md04achgyQuUwNe+yRVZxpxoDxYwBhQKUJDSsFoJhwcUmw9W/gbQvp72Yui7hZS0otsxW/QmmOHJeVO4MAn/kAboG0Ts/XXbcA97opBjN0C3bXz9YscplEFD9+aFNF++YvC1BXGObtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007502; c=relaxed/simple;
	bh=Ly3WGL0NRbv56WJAVHhtg4aP/+9+drkqV8QUgw2N0Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaANpmpMSo4W4SPzBxPzqKnZqxz4SxywAsN17TExjbF5qY50rjb4LH+6o91pL387nKAjwJlNbWKWHc39gzGlJL3Tp4+xgdytsrmnFzrFiJv2UmXBY17p2CForLRlfwI3yNENgHqzPSKheb2oFhzrPepHq7IiFVympjwxpnmnGlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G73Xd4id; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G73Xd4id"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954aff6088so19520755e9.3
        for <linux-modules@vger.kernel.org>; Thu, 06 Aug 2026 02:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786007498; x=1786612298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=32xW9g5rJC+CATbvSQw32IJJxOMsB4uIKy11LiTDmdY=;
        b=G73Xd4idz/v5aSoAin/9RCCBs+2hwxBDbgs2uikyqPBk1Ath8DQjcGp4chdoshiA4s
         HNZynUWrhmm+83dSwPI5fZgdxGmzZyLCTWvzR1eru5bTGTP5HMnppU9TFOAv5yROrXqs
         ndMZUH2UW2bx4UCfopWzzo4rNIYMdVtqVH4ih6rPNmNtw8kqt0Eanx0vIQ3naIGABEFU
         o6NDHIWn8QbuOvWeYPffsq5xijnryJuAAiHMKlJrCwWz6/rEl7LzZ6fFEfteRc70X6u6
         F8F73mmJ3VEExYd1sPG3GCTd+V1ch0ezizjCli1J0ZURhBUUnc5eHbg4UA/ca4A3mUaZ
         ojdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786007498; x=1786612298;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=32xW9g5rJC+CATbvSQw32IJJxOMsB4uIKy11LiTDmdY=;
        b=LSdU6waUbtNXeOkCzVMaghWUjdon7iV/UAqjIpBCD6xcI/rW16YVnoMNEd6c0t0cFe
         R8F6ticRtmmhNSmJ81HwkvUYUWlbwmyjy4HIlafn8xZQLZNqP8PNByelETFXCyRRXtg5
         m+ye4KD/Kx0MmCHe9t6wpuzxcBCA06D3KPFf8Y4Su2byo5XnayZfMDAQrgMt0H88Ioln
         j9Oyw01pKbsc+Ico2TrJv5fBBP1so9VjrrjVMIN4zfePnCKvqgPUrzFL1DhUt3KTw0tB
         hxsovPT/MqaGpAUH1nrcgJ9eadcs317K8f7LOXnLeuTl/TLrEbb4sCDbpDMXN+Jczli4
         a9PQ==
X-Forwarded-Encrypted: i=1; AHgh+RpIRNIeg/VkbR8ArVO5Jt3tzNRkbg9jM4CehriCvG7ent62cCG7W2Tk257GdNRIvDasfCHmmsOLL5U/3H0+@vger.kernel.org
X-Gm-Message-State: AOJu0YxEvbTWs1lyf/ORtjboW6kYU6HEDnp2062H9KDHu1988sBeGUNt
	SrjqXcXIiXIPgG6vyMMR1PQ3MbBisXqfVCp+bRPWL92ef9VS/F93PTl1DbUpdfk3ksE=
X-Gm-Gg: AR+sD11PrV82DGP55T4JQjzWQw0QOwpIoB5fT05J5n+03ZPqpES96QWoC0VCNjJtyVc
	Xc2WSZzlDcfSXUtVGLxGabeQzBrZQ/1npm1wfQT5gVfL0rKXfoDQ+eVKl9PdBvVA2fbScfK1sUH
	XZ+D2hVIBV2jAod8J8QKGfwMl0b/yDv79JNXChaPmmhrUGmHCrje9+V1k8NHdZD9YS011wQfEoQ
	356/dVFqZ+YgdoiL1+Fgm0VXmppjLpRJrn+Fy7EWrG8LsPc/+vDVtneVQaLUaO4zY6JyUHctzJ9
	tEVGhH6JjICA5iK5dvU7iXNPe/UqXpNPm8xYTNRO65ve3nVxiSz/RE12uEHmGxT4XI+1Fo0JA+3
	VSQ+23XL4ea2CbuqT7ePQ9I9fVUjWgdd4iOgNm7ND6tcvqi+LDWkE/yw/lxtYjZ4niaY6a4Oib2
	x48RtD++jSAJA6RS4a4ZMYYXuRXeyKxBkS1aqkH6ur2mo6FJmeaB9SGrBBnAIbmfUIBA09
X-Received: by 2002:a05:600c:840f:b0:496:bffb:fb7b with SMTP id 5b1f17b1804b1-4994e7c0446mr161352615e9.10.1786007498371;
        Thu, 06 Aug 2026 02:11:38 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4c32e0sm93157095e9.0.2026.08.06.02.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:11:38 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] module/dups: Use scope-based cleanup helpers
Date: Thu,  6 Aug 2026 11:10:18 +0200
Message-ID: <20260806-module-stats-rcu-v3-4-2b0331106f00@suse.com>
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

Use scope-based cleanup helpers for kmod_dup_mutex and kmod_req to shorten
the code and to clarify where the lock is taken in
kmod_dup_request_exists_wait().

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/dups.c | 56 +++++++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index 276016051ad2..201a7f4c151f 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -63,6 +63,8 @@ static void put_kmod_req(struct kmod_dup_req *kmod_req)
 		kfree(kmod_req);
 }
 
+DEFINE_FREE(put_kmod_req, struct kmod_dup_req *, if (_T) put_kmod_req(_T))
+
 static struct kmod_dup_req *kmod_dup_request_lookup(char *module_name)
 {
 	struct kmod_dup_req *kmod_req;
@@ -97,9 +99,8 @@ static void kmod_dup_request_delete(struct work_struct *work)
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
@@ -120,15 +121,18 @@ static struct kmod_dup_req *alloc_kmod_req(const char *module_name)
 
 bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 {
-	struct kmod_dup_req *kmod_req;
+	struct kmod_dup_req *kmod_req __free(put_kmod_req) = NULL;
 	int ret;
 
-	mutex_lock(&kmod_dup_mutex);
-
-	kmod_req = kmod_dup_request_lookup(module_name);
-	if (!kmod_req) {
+	scoped_guard(mutex, &kmod_dup_mutex) {
 		struct kmod_dup_req *new_kmod_req;
 
+		kmod_req = kmod_dup_request_lookup(module_name);
+		if (kmod_req) {
+			get_kmod_req(kmod_req);
+			break;
+		}
+
 		/*
 		 * If the first request that came through for a module
 		 * was with request_module_nowait() we cannot wait for it
@@ -142,7 +146,6 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 		 */
 		if (!wait) {
 			pr_debug("New request_module_nowait() for %s -- cannot track duplicates for this request\n", module_name);
-			mutex_unlock(&kmod_dup_mutex);
 			return false;
 		}
 
@@ -152,18 +155,12 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 		 */
 		pr_debug("New request_module() for %s\n", module_name);
 		new_kmod_req = alloc_kmod_req(module_name);
-		if (!new_kmod_req) {
-			mutex_unlock(&kmod_dup_mutex);
+		if (!new_kmod_req)
 			return false;
-		}
 		list_add(&new_kmod_req->list, &dup_kmod_reqs);
-		mutex_unlock(&kmod_dup_mutex);
 		return false;
 	}
 
-	get_kmod_req(kmod_req);
-	mutex_unlock(&kmod_dup_mutex);
-
 	/* We are dealing with a duplicate request now */
 
 	/*
@@ -190,7 +187,7 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 		 * calls bail out right away.
 		 */
 		*dup_ret = 0;
-		goto out;
+		return true;
 	}
 
 	/*
@@ -205,14 +202,11 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 					TASK_KILLABLE);
 	if (ret) {
 		*dup_ret = ret;
-		goto out;
+		return true;
 	}
 
 	/* Now the duplicate request has the same exact return value as the first request */
 	*dup_ret = kmod_req->dup_ret;
-
-out:
-	put_kmod_req(kmod_req);
 	return true;
 }
 
@@ -220,26 +214,22 @@ void kmod_dup_request_announce(char *module_name, int ret)
 {
 	struct kmod_dup_req *kmod_req;
 
-	mutex_lock(&kmod_dup_mutex);
-
 	/*
 	 * Look for a kmod_dup_req previously added in
 	 * kmod_dup_request_exists_wait(). Note that a request_module_nowait()
 	 * without its own kmod_dup_req entry can announce a result of
 	 * a concurrent request_module() call.
 	 */
-	kmod_req = kmod_dup_request_lookup(module_name);
-	if (!kmod_req || completion_done(&kmod_req->first_req_done)) {
-		mutex_unlock(&kmod_dup_mutex);
-		return;
-	}
-
-	kmod_req->dup_ret = ret;
+	scoped_guard(mutex, &kmod_dup_mutex) {
+		kmod_req = kmod_dup_request_lookup(module_name);
+		if (!kmod_req || completion_done(&kmod_req->first_req_done))
+			return;
 
-	/* Inform all duplicate waiters to check the return value. */
-	complete_all(&kmod_req->first_req_done);
+		kmod_req->dup_ret = ret;
 
-	mutex_unlock(&kmod_dup_mutex);
+		/* Inform all duplicate waiters to check the return value. */
+		complete_all(&kmod_req->first_req_done);
+	}
 
 	/*
 	 * Now that we have allowed prior request_module() calls to go on

-- 
2.55.0
