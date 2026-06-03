Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BCB3E317F
	for <linux-modules@vger.kernel.org>; Wed,  3 Jun 2026 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503750; cv=none; b=utDpKz3W8fY2Sioahcws7ZJQXcDeMv87iCdsj2tWxzXeiqPg3PTynKK8YNfVKwRlyRDJKlNlujGikHfq5wo8kkEwrp8Q2lofaqLK5gSeViEBeyVvlgGJSfCakZP0WmCfLnvyknIjNOc3SidPeO3+Bjuf2ySWKa4E6baKBK4Gc3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503750; c=relaxed/simple;
	bh=PeQmi47PXI/zNEiolgBA3UsM4iGAlJyWxcSMnpkYaC8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E0XmrH/i59LhjGn6Tpf1mzIYxdBAJunlsASkDGO1IkqNCWU8M2Oqw9FVGN4r7ggXI/q0NmyYtPdG6reWd0pmSeYl+g/h1jWGdoDadQ+iD08qdyDz3nVD/WYrx90oBiV6x+LSZQY7mHiXF9TjpXOAHgMluM7OQZVD6FT4j61F/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/zakESb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/zakESb"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0c3315c5dso41215445ad.3
        for <linux-modules@vger.kernel.org>; Wed, 03 Jun 2026 09:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780503746; x=1781108546; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrOrgEZ2p049CyLsBnnGi//BfON0bYXn7DEY0et3VpA=;
        b=i/zakESb6dR28dnu1jTIV7ew2aTedQhlydAVoGKnpjpzDfN17ntuFOBGI4JbIpcoNe
         x3ksXgF7jvcbPacIjTT7ZOAjITOXLzbq+BBB4SpwDTXdlu9O17Y08nCN+KN4kaux807g
         pZIw4JOotaFWJyuHK78myhOnWKxbA2Jcvy0YeYYhcQ/HawcW660s/mBfWfrbRpfPOsFP
         OiZHPh5Pa1cCuRq59aDgZVXD4bngAXfgCmVoQ1Jj1e9DVNd5Z/qU6VYv+Lzpc3ZYhWNX
         4hDXfQVMIvpNcYsJLhbW3zrPGzZcuuIZmV7mcxsU1X9wVfki3zVoGyg3KyREE7KtmN5y
         /3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780503746; x=1781108546;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrOrgEZ2p049CyLsBnnGi//BfON0bYXn7DEY0et3VpA=;
        b=E/tnJhnKqp2iTgaSjWU3NtyO0lUhjneqxmBNnRh+Yo3cUDRDXQfuMHaG9it7dfxX3/
         ibNXiqeaclgiy0FWIYP1oYrom2G1mWYve6ivbib1Fi1IbwMTF6/iU9W67H499diWm757
         kheZDT9MY0FY1/Iej600MjZU8xNzeT5WVbveutGBOs3Q60jVOoNE3Z3N75qPmMGRmieh
         PHuAWgUWWkq3lhuUmoebd9bc7DnYT4tC/A4hnS/pqrfH9cEfvjtTyAvjko/OIbkJrWDv
         V+HaHmzVnX+YkCiXp883L9bmE/lfIPJnR+XAbJUJUps0dFbRyxuJv5DgjnAv1ZHuAXoz
         7DhA==
X-Forwarded-Encrypted: i=1; AFNElJ++kCk/lqHzumf9f363bXrihR1vMKRSM+pkEzgYAnD8SM3gqpM+wZXhq9cC9XkSo0x8kMD/Th951UnkiwiF@vger.kernel.org
X-Gm-Message-State: AOJu0YyTZPJxmx6x4C5PDoMs0zAd9IJoYCZQb5R5eIkOySdFDBlPCvgz
	WMAGFRiM81LUeUxPj7XjFEXW6SIpEq6BfD1v61nq32vh9aUJiJzZRdPG
X-Gm-Gg: Acq92OEiOe4vzyITPNn94eX/d89eGWMN0rgM6jBv+A3RzpdXig+SwrA9UAp22oW+UGk
	EV6uAlk01Ag3+uEazfdniusWy4KslwGzk7M+9QeELf51aTOPfjPHRzTZV99cyFOu9aoWCBCDagc
	3zeU4o0E+vE6fUHGJ79xfJtVKmtuqoRJrsMpJJpYoa9CuAXOofW2L3tj/Iv6l20Xg4g08qNLTRA
	27TW6sfBNLGbWQkbDDVsra8PseWdna3VtCI2rEggRokY34Xt4dg6/sEAxI88pqgZPDVT1J6NWt7
	cYI7srzOmd/Xiy9iWp3UgVcHjRCMvPKJKxR9xBDNIql/2KW2PsHRZ/J1jWXmzljzNIm/IUCOeHj
	Z3dmGKL+8QXFS4YNq72epoGtDlX98y/vBORkCU2lesUwTMKD4P4lUQ6TkSRdiGnl59Rz6hcALLa
	HEAStlzRjtAHNJHLNctKrMndFOlTC+JFw6A5qv4IHnfWX3Mw==
X-Received: by 2002:a17:903:b47:b0:2c0:eee2:fc40 with SMTP id d9443c01a7336-2c163a1ffeemr42526045ad.3.1780503745757;
        Wed, 03 Jun 2026 09:22:25 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f85de1sm30328715ad.20.2026.06.03.09.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 09:22:25 -0700 (PDT)
Date: Wed, 3 Jun 2026 21:52:23 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com
Cc: atomlin@atomlin.com, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: stats: add lockdep annotation for dup_failed_modules
 list traversal
Message-ID: <e4za26n3jj3366oqt47hdwfze2rvsyjcujjhjj4jvbtihkleg6@kxasstqoia22>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

read_file_mod_stats() traverses dup_failed_modules with
list_for_each_entry_rcu() while holding module_mutex, but does not pass
the lockdep condition. This triggers a false-positive "RCU-list traversed
in non-reader section" warning with CONFIG_PROVE_RCU_LIST=y.

The warning can be reproduced by:
  1. Racing two loads of the same module to populate dup_failed_modules:
       insmod dummy.ko &
       insmod dummy.ko &
  2. Reading the stats debugfs file:
       cat /sys/kernel/debug/modules/stats

 =============================
 WARNING: suspicious RCU usage
 7.1.0-rc5-gae12a56ba16a #1 Not tainted
 -----------------------------
 kernel/module/stats.c:385 RCU-list traversed in non-reader section!!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 1 lock held by cat/128:
  #0: ffff80008288f7a8 (module_mutex){+.+.}-{4:4}, at: read_file_mod_stats+0x46c/0x5ec

 stack backtrace:
 CPU: 1 UID: 0 PID: 128 Comm: cat Kdump: loaded Not tainted 7.1.0-rc5-gae12a56ba16a #1 PREEMPT
 Hardware name: linux,dummy-virt (DT)
 Call trace:
  show_stack+0x18/0x24 (C)
  __dump_stack+0x28/0x38
  dump_stack_lvl+0x64/0x84
  dump_stack+0x18/0x24
  lockdep_rcu_suspicious+0x134/0x1d4
  read_file_mod_stats+0x554/0x5ec
  full_proxy_read+0xe0/0x1ac
  vfs_read+0xd8/0x2b0
  ksys_read+0x70/0xe4
  __arm64_sys_read+0x1c/0x28
  invoke_syscall+0x48/0xf8
  el0_svc_common+0x8c/0xd8
  do_el0_svc+0x1c/0x28
  el0_svc+0x58/0x1d8
  el0t_64_sync_handler+0x84/0x12c
  el0t_64_sync+0x198/0x19c

The traversal is protected by module_mutex, so pass
lockdep_is_held(&module_mutex) to inform the checker.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 kernel/module/stats.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/module/stats.c b/kernel/module/stats.c
index 3a9672f93a8e..a62961acd8e3 100644
--- a/kernel/module/stats.c
+++ b/kernel/module/stats.c
@@ -382,7 +382,8 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
 	mutex_lock(&module_mutex);
 
 
-	list_for_each_entry_rcu(mod_fail, &dup_failed_modules, list) {
+	list_for_each_entry_rcu(mod_fail, &dup_failed_modules, list,
+				lockdep_is_held(&module_mutex)) {
 		if (WARN_ON_ONCE(++count_failed >= MAX_FAILED_MOD_PRINT))
 			goto out_unlock;
 		len += scnprintf(buf + len, size - len, "%25s\t%15lu\t%25s\n", mod_fail->name,
-- 
2.43.0

