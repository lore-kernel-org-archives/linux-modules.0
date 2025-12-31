Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C5523278D
	for <linux-modules@vger.kernel.org>; Wed, 31 Dec 2025 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767174022; cv=none; b=RJiie0uUYdvEw3LbR2TTss4m2Eao4ajdnD96ZDL9NlNbFSiNcmTZds/hskzt1RkJtS50IE9vZr1hJJGuPNRFcADnfLPb74vCEAmDerZ/yUk9l4d7Z5FAuMNEvpmtTS65bic4hfXNTgJbugNZGL/vo2yaDY+LsIvhp5OQZE3UjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767174022; c=relaxed/simple;
	bh=gmm6NWGxypJYJf5vLWVdbtxQiU/ceK4+aFds9BBJ8wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XmZXSt3HpB64UMGFKJcdb8RWlebirHFm1JBEkYW6recnKzXurMNalv8tld6cJohwBgmTvI/3SClVFvOrS6SLX2OIUOUaUdygTyhA7tnxld2Gcx/JSuJJPVUyKlpdHvEVsAMEt3iarNK+esUYcrMzgGnSWJPbDg2n9gjOwQVT5xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9gQzr4b; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9gQzr4b"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso8837528b3a.2
        for <linux-modules@vger.kernel.org>; Wed, 31 Dec 2025 01:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767174021; x=1767778821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aPqbE9JXbwYMIAurx7IZrU/QF8HBNMOU/70cT7hhYXU=;
        b=O9gQzr4bo60imVcPpRDZWLXeB7m6/dxwKNMcRYhwY02XduIfQ/tirY0haR/syqCVRX
         NqZQgxluOqU0h2dbJXRkTeJjj7spqoBR4cXfbZjwsBr2EgQ1Po1hBIEb3A3mWA4qIlEF
         xvTXjMgiKsQ13fSQqv5YFoykIpfeA4fLQxAshowObfZSnBGDbbLfTp1fR+0QkHMFRplv
         DWWyFm1W21kalpHch83kMcO7tjDkVKriWL8ALGJtxHmgEmbb+LyFqCRuOj9vzvui94as
         eaM4Jpp4Q2M5Dmq7XXfvc0Ot+MsT5jKv1EafEgzMm8uCKtHh4ssweoNc35PhHkc2pCsL
         sx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767174021; x=1767778821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPqbE9JXbwYMIAurx7IZrU/QF8HBNMOU/70cT7hhYXU=;
        b=XZzIVCy6rXzljwc6TRhc/FgL5KtJLYmWgFK9c22Tj1ueoXSTy2bKLcbhPfX7BM9H96
         tW2X9aPsUaRMXG5Fx/kT0czfW1JmZ7CuuUl1tP68zZ1T0kTa9GsWXSF+SX9VGXqtipAg
         FkjyXXDyQ2HyKZUjdVe4Hx1f8rVFKtx9O/cmdLFJvm26hGusKzSG1iithSx6GZeocwDD
         uBim01odXOg6CvisxnkWNsbxXe1lMaRvdckOyby8L5Pz7/ADezuNf8oS9+JD48MF9QdB
         TjDJmU/GJaIyGuu+3ktfvGT7qAcIrxfKz5pu2ino5hhLdOGT686sTF6FzlIKjeI5boep
         gG3g==
X-Gm-Message-State: AOJu0YwB8EnR/WbR+iI8IyZM1DlW/YT1Nu1hRTwQY1tTq7bPiFPiUuzi
	ShX19pGXWO+n9dxSAWl2iEWk1tCDTvJGWqIkk8UR9KQKJr9z/t2gW6Tb
X-Gm-Gg: AY/fxX7zgIy8RO+RDeo5HjZp1gLmdXwlP0qTSgeevst+uHBJYqr5iYwqGP70WX28llT
	khneOI/jWfQQPzqUgTmvFHsmiGhyTYhNi9cVlPxfdtnBOzZfiYANAIkg4kbyboZQpIPSkqvGkG1
	k/egSsHAoN3zCzaf149Jf9aiIhNxNYTF31jqto5AqhZIUjNp8BCXU+/QPOHEGomq8oT6hloTes4
	LtrsfUtpo/dxMhZr2/b7cIAI7/AXkzYxRfLHgNZ9APXydzTvhjcT3ORKd1EmJoO2BIgJMQlUu4h
	hUmMZIBXMX9k7qSTW8LiAhXhdoPemkN6GD4ZDtj02gjDQZUEpfJOYrqzGoyKEFqiKWfOtbbiFtk
	MZ3nSUY+TukHwrUb/FIqJAXhjGRHG9/m08o/orUTz38JpJ/TKMtm5X2Zxvg4d617lWoEWtHp91G
	rNmzk9SOUO9BWQ6gIRJqVot7st7Xj2H0RZ3AycpQyfQf5YqtA/
X-Google-Smtp-Source: AGHT+IH1OgfOCQ++6YoGWLe3z7I4z73peUSuXlX2JSaaii/Q28mvy0SB7AG2/Db+JIbPrwNaS2ycdw==
X-Received: by 2002:a05:6a21:7002:b0:384:d0be:9f8e with SMTP id adf61e73a8af0-384d0be9fffmr4352398637.79.1767174020572;
        Wed, 31 Dec 2025 01:40:20 -0800 (PST)
Received: from localhost.localdomain ([2409:891f:1c62:72:289d:e95e:4395:a7d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e76d1be4bsm30270486a12.0.2025.12.31.01.40.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 31 Dec 2025 01:40:19 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	atomlin@atomlin.com
Cc: linux-modules@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2] module: print version for external modules in print_modules()
Date: Wed, 31 Dec 2025 17:40:04 +0800
Message-ID: <20251231094004.37851-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We maintain a vmcore analysis script on each server that automatically
parses /var/crash/XXXX/vmcore-dmesg.txt to categorize vmcores. This helps
us save considerable effort by avoiding analysis of known bugs.

For vmcores triggered by a driver bug, the system calls print_modules() to
list the loaded modules. However, print_modules() does not output module
version information. Across a large fleet of servers, there are often many
different module versions running simultaneously, and we need to know which
driver version caused a given vmcore.

Currently, the only reliable way to obtain the module version associated
with a vmcore is to analyze the /var/crash/XXXX/vmcore file itself—an
operation that is resource-intensive. Therefore, we propose printing the
driver version directly in the log, which is far more efficient.

The motivation behind this change is that the external NVIDIA driver
[0] frequently causes kernel panics across our server fleet.
While we continuously upgrade to newer NVIDIA driver versions,
upgrading the entire fleet is time-consuming. Therefore, we need to
identify which driver version is responsible for each panic.

In-tree modules are tied to the specific kernel version already, so
printing their versions is redundant. However, for external drivers (like
proprietary networking or GPU stacks), the version is the single most
critical piece of metadata for triage. Therefore, to avoid bloating the
information about loaded modules, we only print the version for external
modules.

- Before this patch

  Modules linked in: mlx5_core(O) nvidia(PO) nvme_core

- After this patch

  Modules linked in: mlx5_core-5.8-2.0.3(O) nvidia-535.274.02(PO) nvme_core
                              ^^^^^^^^^^          ^^^^^^^^^^^

  Note: nvme_core is a in-tree module[1], so its version isn't printed.

Link: https://github.com/NVIDIA/open-gpu-kernel-modules/tags [0]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/core.c?h=v6.19-rc3#n5448 [1]
Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/module/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

---
v1->v2: 
- print it for external module only (Petr, Aaron)
- add comment for it (Aaron)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 710ee30b3bea..16263ce23e92 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3901,7 +3901,11 @@ void print_modules(void)
 	list_for_each_entry_rcu(mod, &modules, list) {
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
-		pr_cont(" %s%s", mod->name, module_flags(mod, buf, true));
+		pr_cont(" %s", mod->name);
+		/* Only append version for out-of-tree modules */
+		if (mod->version && test_bit(TAINT_OOT_MODULE, &mod->taints))
+			pr_cont("-%s", mod->version);
+		pr_cont("%s", module_flags(mod, buf, true));
 	}
 
 	print_unloaded_tainted_modules();
-- 
2.43.5

