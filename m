Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D6F3F3282
	for <linux-modules@vger.kernel.org>; Thu, 23 Jul 2026 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784795211; cv=none; b=BNVVjLH+rmlzYyzKbLyCVv6Gk/YAxvw+xB9QdFz7oiSxkYvEHDXLnH6+Ja2mn97Nex3awd9PFw2D5ZPlxqeA8WXu1ATk33ZbHjsrKXWDmljKWA93+eiOpu6vfbK99P5BHdBoFpl1suj0gl+Pb/DH1Stgk30kaeHvpUrD9zCKpco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784795211; c=relaxed/simple;
	bh=M3w/NX8EtAs4Vp3CPWjzqrrqNViRwAZKhFJyEdDma0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bK/Ao9Tk40Qp3LN3Foq/LfrImAvnTie26xc51gaLa0vsifSg0Syq52739CdMZOtjh609WKvEKaBikollP1EuW1J0HLFan9B+7i3J5UGusKfpJA3ps2aBNNxkze9thN+EFbRwcRgCbncOWK0XGa3Ux5JQbdxXgA0vPWNbc57Aq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AZQ9kxEF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AZQ9kxEF"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so2731445e9.3
        for <linux-modules@vger.kernel.org>; Thu, 23 Jul 2026 01:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784795203; x=1785400003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8CrImD1PV1oAhd0eWI5Z44JgRoeHcEfNsqmH16WcFSY=;
        b=AZQ9kxEFUchQYlt+brTREg1eZVH20Bjyb3LL0QxyL6XyEOMonuC6MBmI2sztmuxM/U
         wixwjN3A7/d6UwesdF5F6ZJ9CFZXzQdjVpV9ajV0R/2QrZetNOm2wmmJTW/I+UZ/Czbu
         jBArDZblt3ic382vyDmxTP96k5G/8s3Wra0ETo89GvSAF5YWcyin81mgmJz4H8KzalYf
         eNw3HZgXfEq+RGfXyVBXWGvZnA9hf8dHbl2Ox2lnG03WCZullM1EmkYS0nT19Vz/u4yg
         PuK6DTghZjBK9jID2H4tMlXQIbiHd6iwlxzsi6E0zvhAgR/76jKyq+eQbBJShLSpm7qX
         7zyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784795203; x=1785400003;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8CrImD1PV1oAhd0eWI5Z44JgRoeHcEfNsqmH16WcFSY=;
        b=SJ1QkYBB6Zn8TQi3qT7AwmY6gro/zQ5u8vw22HgeJD6j52jC8go0dBrGHDFDZyC8cu
         rKnoc8lH44rCwzqR70gDOiZ9+lG8IowSn+HPQHiYBBDsvanbRHZWn4BMVveizac9s/N3
         FMTCysibIebSOPHDsnJ8if8M4RbjDnm1MnbuBz8ftNhBN/YeHHXSLpNJBkZ5hLlrzRO4
         ulA+M9fSKFQ25+hgHP7mRGiIKMdtkZe0bCWcL2gLiT3111DlOaltzvOWEnvS5LuMGnlT
         4xwxu6vn83XhUnS74GXitDdYz4rZQM9gGTJ82zwirqAgbI6Dm9yElO4QVIO7Bgvo4xNC
         /xrw==
X-Forwarded-Encrypted: i=1; AHgh+Rqzg4aE9XbzPXDPQ+ySns2ytPShMk25c4cGYIKjCeDS/lzMkPZSy67EMT0gE9Rl8jAh4Bks5SNhh2540bQA@vger.kernel.org
X-Gm-Message-State: AOJu0YwG4t4UdoY+nz/YFVloaOYYckRR3YKd7Ds5lGyrFPNduIE6yug4
	SxrnrxF7E/5uRfHxRvw+b3LnpSUlSLyRty7nfBeBpdzfzW7uJnvxUKocdqFl6wk2V5Q=
X-Gm-Gg: AR+sD11HaIRRoweRNYwyvbHJO8oBaDud+UTYagYVBGV73NYwDp2IpY8/UarEPc2siuz
	OzZ8R/Zeb5mDJSFbqwlR/TjJQ7gCtZkbSS7z1CAeO4YFg0fF5uvcJcMAct75CBjpjf7A9KXadwZ
	xTsjb+H0H6/xrxj8IbIjg3Ba9gj4FceFSSssCmf2/owL93hZX5YoP7x/l57glEqXiQdIK0vVfB+
	E7L0NhwOLMFKBUN6JRCvgdXksuqQ9Gni0MNgURsBJmxaN0C6Eia7MuPzrYNfNZisC5Q9BzhEZ9P
	jEq+Yr/MOi8q0wdO1TlTsX/LV1reOzqDtc3mSM/4EzNhL7ZPmDqL0cIfrpp0d0zPgEBL1pQVaO0
	OvQz4b6hlsKgqeWG72p3aslecKwKQHdUXGOI0gIwEtwOCmjnn/Ns0ccjnFcJ/BssU7fdD/T1yVQ
	==
X-Received: by 2002:a05:600c:548a:b0:493:eb71:5cc6 with SMTP id 5b1f17b1804b1-49573d0eac1mr21539715e9.27.1784795203484;
        Thu, 23 Jul 2026 01:26:43 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4f9a1csm124831645e9.5.2026.07.23.01.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 01:26:43 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] module/dups: Use scope-based cleanup helpers
Date: Thu, 23 Jul 2026 10:25:54 +0200
Message-ID: <20260723-module-stats-rcu-v2-4-bd582261fae3@suse.com>
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

Use scope-based cleanup helpers for kmod_dup_mutex and kmod_req to shorten
the code and to clarify where the lock is taken in
kmod_dup_request_exists_wait().

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/dups.c | 56 +++++++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index 0f6bb05b2d81..56d659f049c5 100644
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
2.54.0
