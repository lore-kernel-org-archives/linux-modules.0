Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+lQmsP0"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB24DC8;
	Mon, 20 Nov 2023 07:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700493265; x=1732029265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=egBySuvnF1rs3mSn+o1fYvDyEOWxN6cCjTLiLa9cCxU=;
  b=j+lQmsP0OFnU3mXi9p//7Mpo/mOBDSWqI0bI53+keG7c4PzFpGPcqNF2
   BtxOdQ6AGwNUc2A8Yj/wPGRqpDKVdnwLMw8is5ZUfpNyb3p6hZp4UFcOS
   5s6kk9C9kqpJRtsfVeEYMPNsaguogESD0OMBNlR3EiI87V928CctZJlk/
   sM8h87IplghpF4twTOTNR6qpXuuZh6IpL4qrjxBPECnZM7EbXctKmv5IQ
   g6wL5gfPGuFuMNV+502iBKFyr8TE1TxNxYpQsgN7fVdJj2vnF06LOjcHk
   EHbuAYUT8NkHNZ3SUZV3pw1qATMDxth7BYrQ9KOV6BnhCs8+R7bkiFNdw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="422730966"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="422730966"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 07:14:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="1097766556"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="1097766556"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2023 07:14:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 69CAD118; Mon, 20 Nov 2023 17:14:21 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 4/5] params: Sort headers
Date: Mon, 20 Nov 2023 17:11:45 +0200
Message-ID: <20231120151419.1661807-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231120151419.1661807-1-andriy.shevchenko@linux.intel.com>
References: <20231120151419.1661807-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the headers in alphabetic order in order to ease
the maintenance for this part.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/params.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index c3a029fe183d..eb55b32399b4 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -3,18 +3,18 @@
    Copyright (C) 2001 Rusty Russell.
 
 */
-#include <linux/kernel.h>
-#include <linux/kstrtox.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
+#include <linux/ctype.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/overflow.h>
-#include <linux/slab.h>
-#include <linux/ctype.h>
 #include <linux/security.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 
 #ifdef CONFIG_SYSFS
 /* Protects all built-in parameters, modules use their own param_lock */
-- 
2.43.0.rc1.1.gbec44491f096

