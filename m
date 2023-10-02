Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF584693
	for <linux-modules@vger.kernel.org>; Mon,  2 Oct 2023 12:49:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1CBB0;
	Mon,  2 Oct 2023 05:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696250948; x=1727786948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=St8o8nXaM/Hc1Wx+43CvNqKafBY5/VZjLMJIwNON2J0=;
  b=X23s+LxdUGB/A1TLVJdAbhA6aWfl4H6+NAyqVUCWTOadRqjeMdFyaPSE
   ES87FOqM5/sJeOgeApD7TbjaRZhT3yuDMVYF1Xrzs09jc0e6DI2K5KFtj
   w0C8vI4igVM2YdtFsGRDsnkhbyKvsuu0r/PHlwYoXlkiGGo6rxdCp+5X2
   aihwVRyp6wWY/haMPlLjThXb8Zl/H1zZ7TVCyjsCv/EHwrcU2LtQOLG8z
   r7SIH3kREfREWo2IvQBu5XR6iEyjgSH0xS2YHhHpdgs+OWb8ZllaqKv1O
   X8FfWZPVF4uVQj6bRq3BIUa+WmWelbcBeob/f1PqXr/jnLj2xEQg3hn9h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="362901240"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="362901240"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 05:49:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="840970521"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="840970521"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Oct 2023 05:49:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2CCE415BA; Mon,  2 Oct 2023 15:49:02 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 5/5] params: Fix multi-line comment style
Date: Mon,  2 Oct 2023 15:48:56 +0300
Message-Id: <20231002124856.2455696-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231002124856.2455696-1-andriy.shevchenko@linux.intel.com>
References: <20231002124856.2455696-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The multi-line comment style in the file is rather arbitrary.
Make it follow the standard one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/params.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index eb55b32399b4..2e447f8ae183 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* Helpers for initial module or kernel cmdline parsing
-   Copyright (C) 2001 Rusty Russell.
-
-*/
+/*
+ * Helpers for initial module or kernel cmdline parsing
+ * Copyright (C) 2001 Rusty Russell.
+ */
 #include <linux/ctype.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -271,8 +271,10 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
 
 	maybe_kfree_parameter(*(char **)kp->arg);
 
-	/* This is a hack.  We can't kmalloc in early boot, and we
-	 * don't need to; this mangled commandline is preserved. */
+	/*
+	 * This is a hack. We can't kmalloc() in early boot, and we
+	 * don't need to; this mangled commandline is preserved.
+	 */
 	if (slab_is_available()) {
 		*(char **)kp->arg = kmalloc_parameter(len + 1);
 		if (!*(char **)kp->arg)
@@ -743,8 +745,10 @@ void module_param_sysfs_remove(struct module *mod)
 {
 	if (mod->mkobj.mp) {
 		sysfs_remove_group(&mod->mkobj.kobj, &mod->mkobj.mp->grp);
-		/* We are positive that no one is using any param
-		 * attrs at this point.  Deallocate immediately. */
+		/*
+		 * We are positive that no one is using any param
+		 * attrs at this point. Deallocate immediately.
+		 */
 		free_module_param_attrs(&mod->mkobj);
 	}
 }
-- 
2.40.0.1.gaa8946217a0b

