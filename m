Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:44633 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab3IFF7K (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 6 Sep 2013 01:59:10 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r865x7Fl020114
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-modules@vger.kernel.org>; Thu, 5 Sep 2013 22:59:07 -0700 (PDT)
From: Randy MacLeod <Randy.MacLeod@windriver.com>
To: <linux-modules@vger.kernel.org>
CC: <randy.macleod@windriver.com>
Subject: [PATCH] kmod-native: Add back-up implementation of be32toh().
Date: Fri, 6 Sep 2013 01:59:01 -0400
Message-ID: <1378447141-11568-2-git-send-email-Randy.MacLeod@windriver.com>
In-Reply-To: <1378447141-11568-1-git-send-email-Randy.MacLeod@windriver.com>
References: <1378447141-11568-1-git-send-email-Randy.MacLeod@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Older hosts may not have the be32toh function defined. Check for this and
fall back to checking the endianness and calling bswap_32 directly if needed.
This works on both old and new hosts.

Signed-off-by: Randy MacLeod <Randy.MacLeod@windriver.com>
---
 configure.ac                |  1 +
 libkmod/libkmod-signature.c | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 40e54cf..de2ee49 100644
--- a/configure.ac
+++ b/configure.ac
@@ -45,6 +45,7 @@ PKG_PROG_PKG_CONFIG
 AC_CHECK_FUNCS_ONCE(__xstat)
 AC_CHECK_FUNCS_ONCE([__secure_getenv secure_getenv])
 AC_CHECK_FUNCS_ONCE([finit_module])
+AC_CHECK_FUNCS_ONCE([be32toh])
 
 # dietlibc doesn't have st.st_mtim struct member
 AC_CHECK_MEMBERS([struct stat.st_mtim], [], [], [#include <sys/stat.h>])
diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
index 6237ab7..791d092 100644
--- a/libkmod/libkmod-signature.c
+++ b/libkmod/libkmod-signature.c
@@ -18,7 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <endian.h>
+#include <byteswap.h>
 #include <stdint.h>
 #include <stdlib.h>
 #include <string.h>
@@ -26,6 +26,18 @@
 
 #include "libkmod-internal.h"
 
+/* be32toh is usually a macro definend in <endian.h>, but it might be
+ * a function in some system so check both, and if neither is defined
+ * then define be32toh (for RHEL 5).
+ */
+#if !defined(HAVE_BE32TOH) && !defined(be32toh)
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+#define be32toh(x) __bswap_32 (x)
+#else
+#define be32toh(x) (x)
+#endif
+#endif
+
 /* These types and tables were copied from the 3.7 kernel sources.
  * As this is just description of the signature format, it should not be
  * considered derived work (so libkmod can use the LGPL license).
-- 
1.8.2.1

