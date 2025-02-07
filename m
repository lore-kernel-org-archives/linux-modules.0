Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7630314A4DF;
	Fri,  7 Feb 2025 05:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738907163; cv=none; b=VYa3T1Q5RN/UxIq29ynu3dF9LYQ5X3CoRF487ICIInM+e56Kx1CHgpOmwsQCr58/WAiQQiCzF61dYAC9A1kJCF8ORRHWXSaOtFuDE/0MVv8cN2GJeVwma9Xq6NVp9CBrkGl7ZNPT436ch32Uxsr6jb9Kwtty3eIR6wSAcTm6m0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738907163; c=relaxed/simple;
	bh=Ce9vWwmiFrlIWFsCynohx0HFbegVoUmAJ89Hp2WtoEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K/cNuvy/l1f7cJ503MvpuCny27y+p9ecrwI5OzCukU0/UnhTCHYsdGu5+nuU6T3an/zZrjThf2yRS804upFJG2EgWuIryEb7tK4Qv4905G6ljnpjZi+UbCHGUo/cUqA9dwLs/ZcEtiiiQG4FeqpI0Xq3WqplplNVsVuv+vzG0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FFuVDdSR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FFuVDdSR"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id B973E205491D;
	Thu,  6 Feb 2025 21:46:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B973E205491D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738907162;
	bh=RMhow8fUYnh1ATWD4UzotF1XAeN7AtePSKNn+hDqQCQ=;
	h=From:To:Cc:Subject:Date:From;
	b=FFuVDdSRq/1bGoMCGCFpwN20nh0BEBDLLM9oC5E36bYkeUCszjjHBAkhS9phO5f6d
	 NTAmSLChltiuePOAlg710rnj3EzpvFVJQkaM+dwGeuvVfGPAHgYv9X8D/Ptduupn5f
	 qVwc09Z48NGoCjY4w/IT4kttAs//9e5pkYFTuNDU=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Cc: code@tyhicks.com,
	linux@rasmusvillemoes.dk,
	christophe.leroy@csgroup.eu,
	hch@infradead.org,
	mcgrof@kernel.org,
	frkaya@linux.microsoft.com,
	vijayb@linux.microsoft.com,
	petr.pavlu@suse.com,
	linux@weissschuh.net,
	samitolvanen@google.com,
	da.gomez@samsung.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Subject: [v2 0/3] Properly handle module_kobject creation
Date: Thu,  6 Feb 2025 21:45:35 -0800
Message-Id: <20250207054538.1110340-1-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Everyone,

This patch series fixes handling of module_kobject creation.
A driver expect module_kset list populated with its corresponding
module_kobject to create its /sys/module/<built-in-module>/drivers
directory.

Since,
[1] commit 96a1a2412acb ("kernel/params.c: defer most of param_sysfs_init() to late_initcall time")
Call to populate module_kset list is deferred to save init time so that
external watchdog doesn't fireup on some boards and Linux can take
responsibility of feeding watchdog before it spuriously resets the
system. However, [1] this fix caused another issue i.e, consumers
of module_kset can't get related module_kobject during driver
initialisation and hence can't create their
/sys/module/<built-in-module>/drivers directory.

Consequently, [1] breaks user-space applications for eg: DPDK, which
expects /sys/module/vfio_pci/drivers/pci:vfio-pci/new_id to be present.

The second issue was reported and the [2] revert of [1] was
proposed. However, [2] the Revert doesn't address original issue
reported in [1].

This patch series addresses both issues reported in [1] and [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96a1a2412acb
[2] https://lore.kernel.org/lkml/20250130225803.321004-1-shyamsaini@linux.microsoft.com/

Thanks,
Shyam

---
Changes in v2:
- Undo moving of to_module* and lookup_or_create_module_kobject() to module.h
- Refactor and globalize lookup_or_create_module_kobject()
- move __modinit macro construct to module.h
- Fix commit message typos

Changes in v1: 
- Rename locate_module_kobject() to lookup_or_create_module_kobject() to accurately
  describe its operations.
- Moves lookup_or_create_module_kobject() and to_module* macros to module.h, so
  that driver code can use these.
- Handle module_kobject creation and population of module_kset list to fix [1]
  and [2] issues.
- Link: https://lore.kernel.org/lkml/20250204052222.1611510-1-shyamsaini@linux.microsoft.com/

Changes in RFC:
         Reverts commit 96a1a2412acb ("kernel/params.c: defer most of param_sysfs_init() to late_initcall time")
---

Shyam Saini (3):
  kernel: param: rename locate_module_kobject
  kernel: refactor and globalize lookup_or_create_module_kobject()
  drivers: base: handle module_kobject creation

 drivers/base/module.c  | 13 ++++-------
 include/linux/module.h |  8 +++++++
 kernel/params.c        | 53 ++++++++++++++++++------------------------
 3 files changed, 36 insertions(+), 38 deletions(-)

-- 
2.34.1

