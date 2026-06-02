Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8908280CE5
	for <linux-modules@vger.kernel.org>; Tue,  2 Jun 2026 04:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780373828; cv=none; b=P1kQMlzMVfZM2ndcNWBiMjt5bL4+kXTilvPEiclpnzMj1EFV3wO0bcA2SjFZ0V1bykEtpYKlKhkwqhF94cmEUtseiC9iOFtHuRto3ZEVa8r+DzWJnC61SRSfbWRcW1IbqNSGxqXhtuXplzXvwd/1V83GnVGBjYZefCTS/hsh9Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780373828; c=relaxed/simple;
	bh=OfaN/BrvbraKUz7MGmEex0ckhLWy95cQi95jCTONxqc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Zr3tQY6QD3RVTJY0W94q72KCo/Hr52b5izEs9j/gw3vqXVNMTHz55EJbbPOWyoRW2b+ZYG1Y43u3CrId3t4LeX1fa2KqXN+5lxkfLnT2+H3lHcgQbwrC4M8QHyV2BGnwx1/YxniCqMHlfxLqqli2bPM3Jw+T2NjLlFmGwuQ0wAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4bloCy0; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4bloCy0"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c858dc05ee3so1580804a12.2
        for <linux-modules@vger.kernel.org>; Mon, 01 Jun 2026 21:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780373826; x=1780978626; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rC83+ymUQBEhgxiiEPLE6pwgHJ4qRRLzuAlCB42x224=;
        b=j4bloCy0/EF57yOr1jh0/vpHSYWQmFexnYJS7vkmPcHrdcoBnehJHptSbnxuC1opUO
         HTDa7RyvW9gZUq3eyy95QzrZBklb3I3hjb666cmRv7ZufG6nO3jxH+nxedN7FFCsHrP2
         2fY7EChJ7igQskR/7B3V2pWyVIMH06vbIWpY0HErGs28vryRnKFO/jezIinHmEQd+3c0
         TWOeRVah5JikiqM7G07o4w/ZsECF0oUJzPU45oWT6Tn2WKawoXqfhxgRoE44RaMI8VE5
         zKfFTUZgWjB8hS0piGE5evjRfKyeXXBCfQf6Cr1/rXfcVjPVkP30OhhVHXY5bNO3+aS+
         Lv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780373826; x=1780978626;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rC83+ymUQBEhgxiiEPLE6pwgHJ4qRRLzuAlCB42x224=;
        b=eZ6FNak4iGFXBFrInY1k9CrfeeDkZaWaphDsVyzyn6MMg6+bzNECZazwZcgTf6gh7e
         bgR5SjpP0SBHwJY7jn2NSwrtsvjtiFtzCq3Kns3IG1lhgkSerFVbEzolJHHqVgWz8732
         yOq/buHFW4vlX3/IMWJcMYcLzdI4+fmg7t25S2I/BHDKIodKBa/6hDmsig/uiyQSlr48
         7nbq7hLRC+Gl6RxnPcM3IMX7sv0fhxEvR5E2T+eoWv3gNkgdl5EdCTTLhB2JU9IyiBch
         X8eJ83tZdUb+4M3ruOdLcp0Mm8EWNV8OkkeArjjSxN1tlPrEVnfAjM1894NjHrRRmmJy
         AUFg==
X-Forwarded-Encrypted: i=1; AFNElJ/NjGVH4/hRxinaO/L6VE1vk5h2ZYr/iSDlIoGFwrtoAX2IUKDHmdS4hDebDugPDv4iceV2UdLOgOzJyQ/Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa/fjn2s+wsWozOESfCBFyokwYcHB7plZ1DO5KQ2TXtn2moTac
	YvujULZdT/c3Az1rBX2fQj7k4ZkWakE/787k8ZTOEikSZHmkazjtm6JR
X-Gm-Gg: Acq92OFW0PXN27ft/n/9hjD7Odot+dj3CTadC8EnkqFydQrX3zoTPTGeJgqaYFQovBL
	w4JcGhh0W+k4KEuR+AbX6Vub8D6lAFSlou29r8rbnGYUlvgik5E7C/ect/LT4lijqNiTub12mgr
	ousCFTn9T8CJugT61Rt3yxxVpoMAHzOQASqsG8Fw3QabEWL2G7V7TACQ1QiYPL7BFCFcbqLaMII
	ubEPfEe5B2snHHYSgfn0sSdGUa4zvav1CeQkls8v7R/YWo4XjGdxKSJEgpfr2AWRJx2QLyuBe3o
	3SlBfSStQ2fiOOIJ8pahAQniB0qpXgYv4AtJC57zCVfgcynmO/8ZQ+IUgFH56vNV9qDYs25yRV1
	T0MqL2iOlfkuCP8FzrPPAl+7Fq2e2UWgj07R8bgu/rgsoqEAqGdnI/8hE6m+9Qd5tZ/OixCG8on
	rbQ767tc11uNZn0bS4eHhWe/oj7UUSdbzv3rftEMlr9fthXQ==
X-Received: by 2002:a05:6a21:a34c:b0:3b2:b1ed:d1df with SMTP id adf61e73a8af0-3b427f2cff8mr16336180637.29.1780373826040;
        Mon, 01 Jun 2026 21:17:06 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8583333e91sm8995841a12.20.2026.06.01.21.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 21:17:05 -0700 (PDT)
Date: Tue, 2 Jun 2026 09:47:03 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com, linux-modules@vger.kernel.org
Subject: [PATCH] module: dups: don't hold mutex across synchronize_rcu()
Message-ID: <ajydyxgaea27rhcopp5eauji24znotu65d2b4uw344yvmwcc6f@7l5re6f2xcuk>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

kmod_dup_request_delete() calls synchronize_rcu() while holding
kmod_dup_mutex. This is unnecessary since list_del_rcu() only needs
the mutex for list manipulation, and the RCU grace period just needs
to complete before kfree(). Holding the mutex across the grace period
blocks all other kmod_dup_mutex users for the duration, causing
unnecessary latency.

Move synchronize_rcu() after the mutex is released.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 kernel/module/dups.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index 1d720a5311ba..46e74c06ed52 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -88,8 +88,8 @@ static void kmod_dup_request_delete(struct work_struct *work)
 	 */
 	mutex_lock(&kmod_dup_mutex);
 	list_del_rcu(&kmod_req->list);
-	synchronize_rcu();
 	mutex_unlock(&kmod_dup_mutex);
+	synchronize_rcu();
 	kfree(kmod_req);
 }
 
-- 
2.43.0

