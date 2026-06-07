Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269A14071F9
	for <linux-modules@vger.kernel.org>; Sun,  7 Jun 2026 04:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780805943; cv=none; b=eTsKH1C0Gg6nye1tEXk9AKQXDvOh//7CZKH3M0SZ9O+NuV33mk+I+/PcjOy3WQ1PDx0Dl/9Oxh7H9wEov88/gjRdhqhuTK7kaHqwIr8djlVvQVNyEMpc2nUmaQug3YewjNdvGrWcwxn7IrHFoA8bnbaxlnFcuhfU5rSNf6TsRLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780805943; c=relaxed/simple;
	bh=SJIq0UNVPwq+FyP7CpJ/V4a00RrMYJPYSkID21jGemU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XG2hfdf2pMUpcUqLUfDnBtLInjmy+L15/NEHiDT5Kl12aUz3g14MW+veVuRkvwJUjZq/waFUQRTcHjc9jVyrgiSSEIENTsSqSzjwNyzfSdWDbeZfTkrcinxfnWr2PRZcKga7cma12eOe1oyvvYqKHR9a8bKGomECojoU0rtI/WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTB/zK9C; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTB/zK9C"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-842848fd613so2638774b3a.3
        for <linux-modules@vger.kernel.org>; Sat, 06 Jun 2026 21:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780805941; x=1781410741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZhA8YBRuVhigmbhEnTJkM5IBeCulaKot9/Kni5FEt0=;
        b=hTB/zK9Cqk+a61+WoIEnum0dGXnmAZ3auUGDvom3rNHqcgEag6HEU7wVwQjnGkcRjm
         frYWNPIgTWyiItIfaxOZ8kt/xik5lCCs9PzRiwJg4zj1UU7UIZQZwNEI8SbcdKAdk80t
         pkRC2LpJwPQ1LIjXVuNiMqYD0IHgJWb2ZSUYRX5PFfUPvSgEGVagnVbfYMSoLzGFvgTc
         taZ5yc3Qi/Q7vtLRJBGkSuhTyQMyTYEbkzSeENdJBm+6I+JVy9kk5TehCdYlxhLmhzN8
         OJvj8QuAuFUyUuS3tDhynr3TPQWILhv9Vz+G6ybfoWsX/5RtMRAYUCdCuxQxdLj/JAVS
         NlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780805941; x=1781410741;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZhA8YBRuVhigmbhEnTJkM5IBeCulaKot9/Kni5FEt0=;
        b=PnyMt/2o105U9oezeafYtVP3tiqw6wbAoodsWxRGLMZfB+sSINw1/Jcwvkgp0j4bmr
         7rdsZQWfOH7sQK+lQk9J/soCuZYzdJUsei4/wk0YnEZB5kwEAOHftNk9xsQAczN6m0zF
         4Sp23XkKSX1HvEdhwKkvzt9jS23+s/4cQsZhlgoHlIJpqHauyGVsMhMaFX9Nnj+A/ji6
         JYolz8gP4jSyWtC37GGj6kdRY7YhOlcRKFXIdL1fvkXOoQSlrg/vbZF16sCUcoprnLRb
         5S5xTludk65ouWQcINe+zMn3ycLBaIkNjKJxSd+KTaVWHI9LJHpAIktRS7970U+KVTxr
         kGVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dnQM8K1bM2iVDYtBoThLCpqGO0QKjze73pj0itMv/wDHkqKQrp3koeOvLTxf++Ob15BJKAk+1HBqngzwg@vger.kernel.org
X-Gm-Message-State: AOJu0YxfLlfQlwLF/+YNN0LwG4X7qMVjOOeBFLgeTIiB4/Xro1xQiBSo
	td9L9Y0qGxImDCFIPKSkz9Ik0QGc/Ga2vn6DepvqJwy2/Pnn34h01c3G
X-Gm-Gg: Acq92OG2Rex/4QHu4DzHAIHgwRi21TN8BnXsITU6I/5UuuqnHuf9QWg681KrXp6Vpy+
	Tpn9etNwjXN+ItgXZw6GZFeEh9t6aUaYBCbgrdn61BuBFSP1hXDyApo3rRvfEAY2VkBZoUBhUFz
	82oGKNdn+gMmj7eCbTRO8IE4ig5cSumxyRSBN2GKiC5UHkQdsg8nmkKRRP3EGrw7Yvifh2yzEZB
	o+dieEdj3wqcqgG149VDULjYCzp90B+NA9o4s17GBCL5OIsuW58caf0T3PMywCbTdth9n59130R
	kxszSKIVJF7jDop2oXxObY1CeibszZg6XMInqv7eJPBpGmNOoAl3ka+jobe5P3dMFRS6tJYoFTI
	rGBGSGIteVVEIXh2SZwcT0vyOfBJz5DO9WZeaRJLSnX5mePzZ00v20j4lnzIn8J0dIQs1wg1zWx
	6uEU7amdbhW+vzcDYOc8GUSg6wdaOeqFZ7kPs=
X-Received: by 2002:a05:6a00:9086:b0:842:650c:153e with SMTP id d2e1a72fcca58-842b0f3521cmr10666205b3a.20.1780805941031;
        Sat, 06 Jun 2026 21:19:01 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428235006dsm14322521b3a.13.2026.06.06.21.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 21:19:00 -0700 (PDT)
Date: Sun, 7 Jun 2026 09:48:58 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: samitolvanen@google.com
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	atomlin@atomlin.com, linux-modules@vger.kernel.org
Subject: [PATCH v2] module: procfs: fix signed integer overflow in
 module_total_size()
Message-ID: <bl63xtwmzo42pw4636lr75u7duhuejp5tariokl27x3wnvdu24@3xf5cupsskka>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605205215.GA3054112@google.com>

module_total_size() returns unsigned int but uses a signed int
accumulator. While the result is numerically correct, the type
mismatch is misleading.

Change the accumulator to unsigned int to match the return type.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
Changes in v2:
    - Modify the commit message

Thanks Sami for the catch. I have corrected the commit message.

Regards,
Naveen

 kernel/module/procfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/procfs.c b/kernel/module/procfs.c
index 0a4841e88adb..90712aa9dd13 100644
--- a/kernel/module/procfs.c
+++ b/kernel/module/procfs.c
@@ -64,7 +64,7 @@ static void m_stop(struct seq_file *m, void *p)
 
 static unsigned int module_total_size(struct module *mod)
 {
-	int size = 0;
+	unsigned int size = 0;
 
 	for_each_mod_mem_type(type)
 		size += mod->mem[type].size;
-- 
2.43.0

