Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679791662FE;
	Mon, 12 Aug 2024 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723449629; cv=none; b=KoqAoJKcCq7d+Ekfdq4nldp/PENZpy6hUUoxFzCpnEWQoobR+FIYfne5pwOSURUQEcRXzzgGSmU2H6jZ1crDAOyCH0C46DyPPg/b8HcUYSiUMJaxaXZWc08XLvINw6TctlUU3NDJUYuHyum4S4L28VUlIG4QYOnxxfR67CXMtuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723449629; c=relaxed/simple;
	bh=eHo6ZbEwA5kpHQeeMYJmSvhriv2ycj1r+X+HkOTZrJE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mpe01w9SMetgJVnOW9yrMJEIXsRRmmjuBHl8Z0lemufD7iaTwKBcopZYGOp6hHf1qa98zmIxQ2cXoQFZoRfIM9KEva75GhVrgY20G6Y1PVyf1z+2pPsnC8XxjaMsL4pyOxpyr3wS68aApAsiVz6JjlneVTz2AZoO8WgIBkzH1M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wj6NS2fJkzpTRm;
	Mon, 12 Aug 2024 15:59:04 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id DBE5614037E;
	Mon, 12 Aug 2024 16:00:21 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 12 Aug
 2024 16:00:21 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <arnd@arndb.de>,
	<mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-modules@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] driver core: Fix a null-ptr-deref in module_add_driver()
Date: Mon, 12 Aug 2024 16:06:58 +0800
Message-ID: <20240812080658.2791982-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Inject fault while probing of-fpga-region, if kasprintf() fails in
module_add_driver(), the second sysfs_remove_link() in exit path will cause
null-ptr-deref as below because kernfs_name_hash() will call strlen() with
NULL driver_name.

Fix it by releasing resources based on the exit path sequence.

	 KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
	 Mem abort info:
	   ESR = 0x0000000096000005
	   EC = 0x25: DABT (current EL), IL = 32 bits
	   SET = 0, FnV = 0
	   EA = 0, S1PTW = 0
	   FSC = 0x05: level 1 translation fault
	 Data abort info:
	   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
	   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
	   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
	 [dfffffc000000000] address between user and kernel address ranges
	 Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
	 Dumping ftrace buffer:
	    (ftrace buffer empty)
	 Modules linked in: of_fpga_region(+) fpga_region fpga_bridge cfg80211 rfkill 8021q garp mrp stp llc ipv6 [last unloaded: of_fpga_region]
	 CPU: 2 UID: 0 PID: 2036 Comm: modprobe Not tainted 6.11.0-rc2-g6a0e38264012 #295
	 Hardware name: linux,dummy-virt (DT)
	 pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
	 pc : strlen+0x24/0xb0
	 lr : kernfs_name_hash+0x1c/0xc4
	 sp : ffffffc081f97380
	 x29: ffffffc081f97380 x28: ffffffc081f97b90 x27: ffffff80c821c2a0
	 x26: ffffffedac0be418 x25: 0000000000000000 x24: ffffff80c09d2000
	 x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
	 x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000001840
	 x17: 0000000000000000 x16: 0000000000000000 x15: 1ffffff8103f2e42
	 x14: 00000000f1f1f1f1 x13: 0000000000000004 x12: ffffffb01812d61d
	 x11: 1ffffff01812d61c x10: ffffffb01812d61c x9 : dfffffc000000000
	 x8 : 0000004fe7ed29e4 x7 : ffffff80c096b0e7 x6 : 0000000000000001
	 x5 : ffffff80c096b0e0 x4 : 1ffffffdb990efa2 x3 : 0000000000000000
	 x2 : 0000000000000000 x1 : dfffffc000000000 x0 : 0000000000000000
	 Call trace:
	  strlen+0x24/0xb0
	  kernfs_name_hash+0x1c/0xc4
	  kernfs_find_ns+0x118/0x2e8
	  kernfs_remove_by_name_ns+0x80/0x100
	  sysfs_remove_link+0x74/0xa8
	  module_add_driver+0x278/0x394
	  bus_add_driver+0x1f0/0x43c
	  driver_register+0xf4/0x3c0
	  __platform_driver_register+0x60/0x88
	  of_fpga_region_init+0x20/0x1000 [of_fpga_region]
	  do_one_initcall+0x110/0x788
	  do_init_module+0x1dc/0x5c8
	  load_module+0x3c38/0x4cac
	  init_module_from_file+0xd4/0x128
	  idempotent_init_module+0x2cc/0x528
	  __arm64_sys_finit_module+0xac/0x100
	  invoke_syscall+0x6c/0x258
	  el0_svc_common.constprop.0+0x160/0x22c
	  do_el0_svc+0x44/0x5c
	  el0_svc+0x48/0xb8
	  el0t_64_sync_handler+0x13c/0x158
	  el0t_64_sync+0x190/0x194
	 Code: f2fbffe1 a90157f4 12000802 aa0003f5 (38e16861)
	 ---[ end trace 0000000000000000 ]---
	 Kernel panic - not syncing: Oops: Fatal exception

Fixes: 85d2b0aa1703 ("module: don't ignore sysfs_create_link() failures")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/base/module.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/base/module.c b/drivers/base/module.c
index f742ad2a21da..c4eaa1158d54 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -66,27 +66,31 @@ int module_add_driver(struct module *mod, const struct device_driver *drv)
 	driver_name = make_driver_name(drv);
 	if (!driver_name) {
 		ret = -ENOMEM;
-		goto out;
+		goto out_remove_kobj;
 	}
 
 	module_create_drivers_dir(mk);
 	if (!mk->drivers_dir) {
 		ret = -EINVAL;
-		goto out;
+		goto out_free_driver_name;
 	}
 
 	ret = sysfs_create_link(mk->drivers_dir, &drv->p->kobj, driver_name);
 	if (ret)
-		goto out;
+		goto out_remove_drivers_dir;
 
 	kfree(driver_name);
 
 	return 0;
-out:
-	sysfs_remove_link(&drv->p->kobj, "module");
+
+out_remove_drivers_dir:
 	sysfs_remove_link(mk->drivers_dir, driver_name);
+
+out_free_driver_name:
 	kfree(driver_name);
 
+out_remove_kobj:
+	sysfs_remove_link(&drv->p->kobj, "module");
 	return ret;
 }
 
-- 
2.34.1

