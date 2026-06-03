Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A38E3EEAC4
	for <linux-modules@vger.kernel.org>; Wed,  3 Jun 2026 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503995; cv=none; b=sJM8uQmFoTpM+2G4vMHD2n8huJ5hm8IJtby5s0HIz5LB/+9zrC3mJ5CfcLFgv6M0p15xP6heg+f+uZQvnqUTJKOJsmPWL/aVbL9OcV1G597K5l6sVGXnPRWxc7fbxjarIaxr4W3rw/Ex/X9jNtq4sj2vZMtttLT2WaNNdZRKINw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503995; c=relaxed/simple;
	bh=qGenFoylJV66LbGsmsumCYEudxMB3PzzVDerNZQ714o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GvNyVBDoG1WC8FP51gGkSosdc7j6kL4l3sUymHUCZUjHUcb0O2MVXQ/7RLNP1ie0Tdb3ft1mMAilP7zjyktxOVnu2K7mRW99u0cL+BJ3fS6bfWaJRf/ITlR7PY1an2AKXH2WyMo3qE/lR+3RTlHgeqWym4Ys7dVk2oBJa43ShE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhE33sBt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhE33sBt"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso38911755ad.0
        for <linux-modules@vger.kernel.org>; Wed, 03 Jun 2026 09:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780503993; x=1781108793; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmTn+OsjpTOYZ6r16QcX+2FZCk8ofoJdYq2HApRJAyg=;
        b=jhE33sBt5ADWjaP4+4L72/sq+40YoktVfO0Im5ZQaNoJfbuwv7WB0dfQ2crkhQ96Un
         bCLn47OW/YeeyM6evf933RLxW7zoCPXCy2OqLdAdg1Q3q8AgFMkRM4X0KLaiVJJoWATf
         h9UzV+TvZGYfJ+Ksf9VoLpy12/NIF2FOETvY/H9rPRqCBpCtB/0VWX8a3ZmeMLNo6cma
         6cP9ZFP4CvPkJzK8v0aimLS6QITiFyvcqX5A8qbvQpQvJpXsfVIoaiZQXzRCGG56SkRf
         phvwxiJCjRKYkOxCpU1SThUhg4+HS1PA95yqPiS3CLLdzKP/W+gewtN1Un5AK3I6gm56
         bLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780503993; x=1781108793;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmTn+OsjpTOYZ6r16QcX+2FZCk8ofoJdYq2HApRJAyg=;
        b=LNd3aG/M6fUFueuZmTMQ6ctkU5UOTaYKNSKa7+XfkkLZoStEyrysn1QEH2ybmFEZT7
         kploYiWnnkvtNFLPjsj8wElB66DRxFzcboQQuy5LYMoZN5ZC49EzHqxbYOEOxvi3qmNL
         Sb/G4Gioo50yrq6hYUSjINFBfmZaKBV8H/nTs7W+ZQKOcWUesqWQvs1Oq6ncaQJqMpu1
         uW7k4gBlhOjOU2wVJZ0A5qtUPJv6Kg9fh2rqWJR7TwSYcnajj5XvPWNyyzeFYowvVSdU
         ACbufEaYFe0ssxuLQHjoLyzWmx+DjFDPeBg49v9EgI4Dbpfne0ma1GqDGTh3FflaZj1u
         Y4Dg==
X-Forwarded-Encrypted: i=1; AFNElJ8rD1RShE5FJuM7NN92S6WLAIcGhmvaePGaBXZeY7op4AXi/hui/WnauJhFw2CNoneQq3P+6UAKf/r82dxU@vger.kernel.org
X-Gm-Message-State: AOJu0YzlTWeDRdxeFYMLw9nex4+icuLOBMvTeA44M3zbwGvyGO4iGwK+
	opEj2vhZtu0+7Q8Dc+YE1g3vhD69BGbOGEPE6/uglnx4iATvxN81Dguw
X-Gm-Gg: Acq92OF/34ySq78ad6UF4plkCZVWa/oOQ7IerPVPsWKVknWdrjZt65U9Uh3w83gDDuN
	XeGfYKAHyXxHQsS95v4nyu1+k/NPtJngUA1UwesYOoO0yiKArHQihZU7ckZ5UsYa8eEXP5oicg7
	957vW0OTs0E3kpmzFcBUTGejSUO/qC68NZRuiU1EokkfpAElHa1vD4fB8PrZgURJlxQD4LjIXQ5
	Uo1G9fMC1WEW+2KCpIy+2GHxmCKOguv64u1hTaQxnraSEHhiC+vQqG4HB0AI7mw7AB5titGjIoy
	29Ey2u+Xt/UOliPX/FcoUBoOBPdCSxqb7QkSplNPblI3Jc267EvfJEEuEMjhZXJVyQglHSo4Brn
	4CmiC08O70Yl+sCK2XfW1KOphR3NeTjAYGaOQxwKN+AAyU0G9yCnyW6TuJpwxvY21IK48knoTI5
	tdeGNq0UEvP2WCpKMpPDNeW1CUdbXevWmzcT0=
X-Received: by 2002:a17:902:e5ce:b0:2c1:5135:39f3 with SMTP id d9443c01a7336-2c163a43ff3mr45661725ad.11.1780503993515;
        Wed, 03 Jun 2026 09:26:33 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664a67b0sm30613855ad.80.2026.06.03.09.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 09:26:33 -0700 (PDT)
Date: Wed, 3 Jun 2026 21:56:31 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com
Cc: atomlin@atomlin.com, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: stats: use strscpy() to copy failed module name
Message-ID: <jmm7r4r3k3qt767tl7lojglosgc3umhc63cdp2fckdkgb3fzki@3fgvxgvzo5ex>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

try_add_failed_module() uses memcpy() with strlen(name) as the length to
copy a module name into mod_fail->name, a fixed-size buffer of
MODULE_NAME_LEN bytes. This is an issue as it does no bounds check.

Current callers always pass names originating from mod->name
(char[MODULE_NAME_LEN]), so this is not exploitable today. However the
function accepts a plain const char * with no documented length contract,
making it a latent buffer overflow if a future caller passes a longer
string.

Replace memcpy() with strscpy(), which bounds the copy to
MODULE_NAME_LEN and always NUL-terminates.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 kernel/module/stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/stats.c b/kernel/module/stats.c
index 3a9672f93a8e..08724baca773 100644
--- a/kernel/module/stats.c
+++ b/kernel/module/stats.c
@@ -253,7 +253,7 @@ int try_add_failed_module(const char *name, enum fail_dup_mod_reason reason)
 	mod_fail = kzalloc_obj(*mod_fail);
 	if (!mod_fail)
 		return -ENOMEM;
-	memcpy(mod_fail->name, name, strlen(name));
+	strscpy(mod_fail->name, name, MODULE_NAME_LEN);
 	__set_bit(reason, &mod_fail->dup_fail_mask);
 	atomic_long_inc(&mod_fail->count);
 	list_add_rcu(&mod_fail->list, &dup_failed_modules);
-- 
2.43.0

