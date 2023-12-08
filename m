Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D5B8AC
	for <linux-modules@vger.kernel.org>; Fri,  8 Dec 2023 14:45:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63B42106F;
	Fri,  8 Dec 2023 14:46:01 -0800 (PST)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5946C3F6C4;
	Fri,  8 Dec 2023 14:45:15 -0800 (PST)
From: ross.burton@arm.com
To: linux-modules@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH] configure: set docdir in GTK_DOC_CHECK
Date: Fri,  8 Dec 2023 22:45:10 +0000
Message-Id: <20231208224511.1363066-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ross Burton <ross.burton@arm.com>

By passing --docdir in the GTK_DOC_CHECK arguments (to match
autogen.sh) autoreconf will work out of the box.

Without this autoreconf fails due to the documentation not being in
./docs, the default location.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index de01e08..67696c4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -255,7 +255,7 @@ AS_IF([test "x$enable_coverage" = "xyes"], [
 AM_CONDITIONAL([ENABLE_COVERAGE], [test "x$enable_coverage" = "xyes"])
 
 m4_ifdef([GTK_DOC_CHECK], [
-GTK_DOC_CHECK([1.14],[--flavour no-tmpl-flat])
+GTK_DOC_CHECK([1.14],[--flavour no-tmpl-flat --docdir libkmod/docs])
 ], [
 AM_CONDITIONAL([ENABLE_GTK_DOC], false)])
 
-- 
2.34.1

