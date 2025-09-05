Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5142D213237
	for <linux-modules@vger.kernel.org>; Fri,  5 Sep 2025 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062901; cv=none; b=hU5HIVEFBUMsTeUSErpspHEpCtVlNuY7OTwNr9pyyHMwudz1p+zXSo+vzbAgVfsyhclNgt0ESTc0Pd+QE9m1dSu1SvabLpxsZ3a1BsmavQy1r9AyuzpvQmjHgRLhTsS0vGMynnIaBKiFy0yFhBnyGZUt1HBbnDAGxNmqabobEpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062901; c=relaxed/simple;
	bh=qvqSjoO/mRLjIPV/1wtDFk60TiCvaNH/heT36hH/Qq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdbV38s2GPZqIlnI/GwLtY95DhRnkRwhYHXFLTmBsXm3aXgrCgFdZ0BPv4LxAXkQHCn2q+PPB3cn7K6ZRW4eQLGuM43JKRjDVDuYtf2ZZs0beOCjm3mLVMyxROnCJY29d/s5NxUOAQt3ncqsAbcauo4cljAUQ5uquAbBK2YWZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qr+/XM3Y; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qr+/XM3Y"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3dcce361897so1299343f8f.3
        for <linux-modules@vger.kernel.org>; Fri, 05 Sep 2025 02:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062898; x=1757667698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5KHWEqaXSiQRHQD3PSK3TviVXz938qrA11SI1DLfq0=;
        b=Qr+/XM3YIRot+XEKx6VXfPVY1M9qTnHPED3PapGgMMjexiJkYzp1xMptTZPAL00Bsy
         1XkybDnqWauSnnnA0RMBM7rhsaJ/mqNHO47RfF4YUdYcOr/h+vyw4AMN8SUeW+Cws/hu
         YsHorwa/ZOQwpewcc8Jk8Lqg4YAW3O1Av1MWNb9jolDRTGqNUo5ZKDGHv9DnTvqYEDam
         AOKs0EWI0LZW6wNp2qrTFqGgCh2SFWQonkbxnQNIKd/JotNgFPQ11y31h1+69BquahRL
         +nHQB3kCHGC4xUBTpuEWlF4Qk67yYOW0Eu5vCjfQ73oywrdwEe3Y4YbikFzve66Gg1wv
         TmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062898; x=1757667698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5KHWEqaXSiQRHQD3PSK3TviVXz938qrA11SI1DLfq0=;
        b=cbbssWuRjjuVrFmdRJBcspmbcZXzcO1GFJHD6z2nhRg5b06txq2exOfN9mz6BA5bxV
         C/fHtDUfa/JIetV5TCK1RmBeyPIQ32Vam0OZBXWd6zzbIZkXDMeiLRssR2MNMCTJDRUR
         2sWnzG9WTNO1I1i555hDXgmYn8hKpCJusTPzmLwrG+ZQk53R/jU8an176gwWO1ROLs42
         1/gg4jGjKXXXsmTJu0uNq84yD1GD32xPuOl5SKBR06aqzeB7gy0LMa5wFeDdW6M84hD0
         /yrT+XPs4As4mBkNIelrv7Txw+/nfyODu4EVZERlEXMrWglQg0pizkv1mg/vRjAT/A7D
         HHpw==
X-Forwarded-Encrypted: i=1; AJvYcCUVAIUISscXC1tBzns5uNpLNaT+eGRnzRo9sikgqZXHWOw+momQpnJ5CBCn1V3FzmqfWUYr+i1o8ZxF3pqU@vger.kernel.org
X-Gm-Message-State: AOJu0YwzY3rHjxk4jRyjG8xKdUPnrTk5fxCl7Y3JK6wuoCDPWBPStB2C
	KnEwWOAYA0phA6nKHGuXW3LATHW37LCqWReOTM6fhg7qq45SPBsvl4FXNyLrZ2jmdPI=
X-Gm-Gg: ASbGncuwk1qmlF2pin86IAWBV/IEBRO5kR+CfNQNJg/mNlksAASOe3lcp6TFhOKLPaZ
	7PgG1DGcFYX0eZxabumDe0OKa5wO9M6XIUz7rILaxsleBelBD/ZDzGnHeDAVRT+mkRtOycegdQf
	1LC4n1Qb0p3nr8G32OCxWqAxDTG9+2XBJBlPFA3FikScSJeJcfElU1rHCq2CiW/+7UtLRu80sQ3
	LYy1pKYugdXkAohLrI9y69c+jA0mpoWpeL2N34oZvHbgoUVufugOxtmrj2bucK0lKY17gqE+GBV
	mAWraRMWUquNsS8LiAhsB6vhxIGipeOajA07AsGuA/v5Xl/blf1vw6zuxlC84PrDHXxgtT87NiX
	J366baQ/bfL5a9tbeUdg8idwHo9lxP18feHPwt58CrZ+OKPdtsNg/hJIIlA==
X-Google-Smtp-Source: AGHT+IEauwqdmqEn4hr445iqcOmm/sJaiG6o1U1wFAlO1tWFtAfZ1VjOWTJlAJ6GuL9SVs/bjIcxfA==
X-Received: by 2002:a05:6000:22c8:b0:3e2:bbd1:e914 with SMTP id ffacd0b85a97d-3e2bbd1eb93mr2650150f8f.51.1757062897600;
        Fri, 05 Sep 2025 02:01:37 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e411219ddfsm1317713f8f.57.2025.09.05.02.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:01:37 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 1/1] module: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 11:01:30 +0200
Message-ID: <20250905090130.101724-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090130.101724-1-marco.crivellari@suse.com>
References: <20250905090130.101724-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users. Make
it clear by adding a system_percpu_wq.

queue_work() / queue_delayed_work() mod_delayed_work() will now use the
new per-cpu wq: whether the user still stick on the old name a warn will
be printed along a wq redirect to the new one.

This patch add the new system_percpu_wq except for mm, fs and net
subsystem, whom are handled in separated patches.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/module/dups.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index bd2149fbe117..e72fa393a2ec 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -113,7 +113,7 @@ static void kmod_dup_request_complete(struct work_struct *work)
 	 * let this linger forever as this is just a boot optimization for
 	 * possible abuses of vmalloc() incurred by finit_module() thrashing.
 	 */
-	queue_delayed_work(system_wq, &kmod_req->delete_work, 60 * HZ);
+	queue_delayed_work(system_percpu_wq, &kmod_req->delete_work, 60 * HZ);
 }
 
 bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
@@ -240,7 +240,7 @@ void kmod_dup_request_announce(char *module_name, int ret)
 	 * There is no rush. But we also don't want to hold the
 	 * caller up forever or introduce any boot delays.
 	 */
-	queue_work(system_wq, &kmod_req->complete_work);
+	queue_work(system_percpu_wq, &kmod_req->complete_work);
 
 out:
 	mutex_unlock(&kmod_dup_mutex);
-- 
2.51.0

