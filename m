Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcKTvZvw"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B3FA4;
	Mon, 20 Nov 2023 07:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700493265; x=1732029265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D5Ir1Vj8OLtklsn72GYygYA1+G2UYfWZWZVSidHq6PI=;
  b=kcKTvZvwVGtGylf8gdQDbV6eMPUKloNWG8khdyNa0a2vCPMKl/VR/fcJ
   weRdhwkgBnA/hhMzWTwx4D6sIOHvf/avkufbI3LXmF+q45/r/Te0pf5Wr
   ha61WZfBYjpkrEwVA6OVuZLKR6RKmGBaWXjx9nURxwQQzF7llUPiF3+j3
   AvMfVPLFBlMnGVa9+a1BfC1bB/SLCUnLLusBxGngAratzb4ivnWBJvcR9
   72cu+s/+dLZd1AImLm6I1OP0MA+6FX8hi2TvUWESXZhEV/iHMn/POWOSD
   8U4pXSToIu5teX6CpdGlaYFjxADvuN3FxptSvtq5RXhIifBzknypmqDuk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="422730970"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="422730970"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 07:14:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="1097766557"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="1097766557"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2023 07:14:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6093C12A; Mon, 20 Nov 2023 17:14:21 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 3/5] params: Use size_add() for kmalloc()
Date: Mon, 20 Nov 2023 17:11:44 +0200
Message-ID: <20231120151419.1661807-4-andriy.shevchenko@linux.intel.com>
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

Prevent allocations from integer overflow by using size_add().

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/params.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/params.c b/kernel/params.c
index f8e3c4139854..c3a029fe183d 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -11,6 +11,7 @@
 #include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/security.h>
@@ -48,7 +49,7 @@ static void *kmalloc_parameter(unsigned int size)
 {
 	struct kmalloced_param *p;
 
-	p = kmalloc(sizeof(*p) + size, GFP_KERNEL);
+	p = kmalloc(size_add(sizeof(*p), size), GFP_KERNEL);
 	if (!p)
 		return NULL;
 
-- 
2.43.0.rc1.1.gbec44491f096

