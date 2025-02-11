Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFBA2676D0;
	Tue, 11 Feb 2025 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310588; cv=none; b=Hql4iqe5jXCk8UjNLLOp89DcJSOdiUeVoxipZA+R4xVx2qkNi9I8al1R362O669kbT1BJuVWxWyt/qrIMkqKXqrGJPlIzjcRMkn8yCbwcOfcyx6bJexqSne5fEAxbvGx3AxCZJEEqR0T1Rc8RzGgPOio3wCin6pTTQiFD1joObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310588; c=relaxed/simple;
	bh=8aOOSnimxn8p/5k5Jds4OPiuu+rWOAGzXi1vvMG8xOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qX/tjquPQzZiAmEkoRG4qsPYTEJJVHjRapn86F9xQzTCd/w7XMgu8+zIkI0ANEJG44UQC7ghqkyIz+tuzKH7ae7Zo2vu6WtYEdr65K8dGkl03xaMQGWY6TsVWmbfwxU0qA9wET4cy3nbGR7OMoHs1fSSVb88o/dbLZmmakwoGbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=W6lfrsBq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="W6lfrsBq"
Received: from thinkpad-p16sg1.. (d66-183-104-158.bchsia.telus.net [66.183.104.158])
	by linux.microsoft.com (Postfix) with ESMTPSA id 929E52107AB1;
	Tue, 11 Feb 2025 13:49:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 929E52107AB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739310586;
	bh=qcLGWzBNg70V0c6r3FQzFtO4ZnihoB96lAcR2RljZiY=;
	h=From:To:Cc:Subject:Date:From;
	b=W6lfrsBq8jhCBQQ50U9GBdFWvcTiFiLk3MFvnmCI04LT75VtNPvxolcnLrGZl9CeI
	 g4ghqujOKo31tN/GErCy3wz08wveT6TzojxFp7w3YHw48kCIITz78GpBPV5XKM0Tsi
	 Isy+RBxfPXvTNF50M4k+Fd9pydon+U8fIaGcG6GA=
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
Subject: [PATCH v3 0/4] Properly handle module_kobject creation
Date: Tue, 11 Feb 2025 13:48:38 -0800
Message-Id: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
proposed. However, [2] the Revert doesn't address the original issue
reported in [1].

This patch series addresses both issues reported in [1] and [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96a1a2412acb
[2] https://lore.kernel.org/lkml/20250130225803.321004-1-shyamsaini@linux.microsoft.com/

Thanks,
Shyam

---
- Changes in v3:
  - Split refactoring and globalisation of lookup_or_create_module_kobject() into two patches
  - Fix commit message to better describe the change.
  - Use IS_ENABLED instead of #ifdef macro construct
  - Undo the moving of __modinit macro construct into module.h
  - drop __modinit from lookup_or_create_module_kobject() declaration

Changes in v2:
- Undo the moving of to_module* and lookup_or_create_module_kobject() into module.h
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

Shyam Saini (4):
  kernel: param: rename locate_module_kobject
  kernel: refactor lookup_or_create_module_kobject()
  kernel: globalize lookup_or_create_module_kobject()
  drivers: base: handle module_kobject creation

 drivers/base/module.c  | 13 +++++------
 include/linux/module.h |  2 ++
 kernel/params.c        | 49 ++++++++++++++++++++----------------------
 3 files changed, 30 insertions(+), 34 deletions(-)

-- 
2.34.1

