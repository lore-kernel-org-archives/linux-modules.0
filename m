Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: [PATCH 1/2] testsuite: depmod: add override test
Date: Thu,  7 Dec 2017 21:16:07 +0200
Message-Id: <20171207191608.14293-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20171207191608.14293-1-yauheni.kaliuta@redhat.com>
References: <20171207191608.14293-1-yauheni.kaliuta@redhat.com>
List-ID: <linux-modules.vger.kernel.org>

Simple test to check if depmod honors override keyword. Uses
mod-simple.ko for foo/ and override/ directories, search.conf to
search in foo and built-in and simple override configuration:

override mod-simple 4.4.4 override

The resulting modules.dep should point to the override directory.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 testsuite/populate-modules.sh                      |  2 ++
 .../etc/depmod.d/override.conf                     |  1 +
 .../search-order-override/etc/depmod.d/search.conf |  1 +
 .../lib/modules/4.4.4/correct-modules.dep          |  1 +
 testsuite/test-depmod.c                            | 26 ++++++++++++++++++++++
 5 files changed, 31 insertions(+)
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-override/etc/depmod.d/override.conf
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-override/etc/depmod.d/search.conf
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-override/lib/modules/4.4.4/correct-modules.dep

diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.sh
index 3ac92ee8030d..b77e71edf0a4 100755
--- a/testsuite/populate-modules.sh
+++ b/testsuite/populate-modules.sh
@@ -28,6 +28,8 @@ map=(
     ["test-depmod/search-order-external-last/lib/modules/4.4.4/foo/"]="mod-simple.ko"
     ["test-depmod/search-order-external-last/lib/modules/4.4.4/foobar/"]="mod-simple.ko"
     ["test-depmod/search-order-external-last/lib/modules/external/"]="mod-simple.ko"
+    ["test-depmod/search-order-override/lib/modules/4.4.4/foo/"]="mod-simple.ko"
+    ["test-depmod/search-order-override/lib/modules/4.4.4/override/"]="mod-simple.ko"
     ["test-dependencies/lib/modules/4.0.20-kmod/kernel/fs/foo/"]="mod-foo-b.ko"
     ["test-dependencies/lib/modules/4.0.20-kmod/kernel/"]="mod-foo-c.ko"
     ["test-dependencies/lib/modules/4.0.20-kmod/kernel/lib/"]="mod-foo-a.ko"
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-override/etc/depmod.d/override.conf b/testsuite/rootfs-pristine/test-depmod/search-order-override/etc/depmod.d/override.conf
new file mode 100644
index 000000000000..fadf8112c26a
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-depmod/search-order-override/etc/depmod.d/override.conf
@@ -0,0 +1 @@
+override mod-simple 4.4.4 override
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-override/etc/depmod.d/search.conf b/testsuite/rootfs-pristine/test-depmod/search-order-override/etc/depmod.d/search.conf
new file mode 100644
index 000000000000..289ddcdd4152
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-depmod/search-order-override/etc/depmod.d/search.conf
@@ -0,0 +1 @@
+search foo built-in
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-override/lib/modules/4.4.4/correct-modules.dep b/testsuite/rootfs-pristine/test-depmod/search-order-override/lib/modules/4.4.4/correct-modules.dep
new file mode 100644
index 000000000000..4c7ea8e08c8e
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-depmod/search-order-override/lib/modules/4.4.4/correct-modules.dep
@@ -0,0 +1 @@
+override/mod-simple.ko:
diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index e249c61515dc..47dafb4dd618 100644
--- a/testsuite/test-depmod.c
+++ b/testsuite/test-depmod.c
@@ -183,4 +183,30 @@ DEFINE_TEST(depmod_search_order_external_last,
 		},
 	});
 
+#define SEARCH_ORDER_OVERRIDE_ROOTFS TESTSUITE_ROOTFS "test-depmod/search-order-override"
+static noreturn int depmod_search_order_override(const struct test *t)
+{
+	const char *progname = ABS_TOP_BUILDDIR "/tools/depmod";
+	const char *const args[] = {
+		progname,
+		NULL,
+	};
+
+	test_spawn_prog(progname, args);
+	exit(EXIT_FAILURE);
+}
+DEFINE_TEST(depmod_search_order_override,
+	.description = "check if depmod honor override keyword",
+	.config = {
+		[TC_UNAME_R] = "4.4.4",
+		[TC_ROOTFS] = SEARCH_ORDER_OVERRIDE_ROOTFS,
+	},
+	.output = {
+		.files = (const struct keyval[]) {
+			{ SEARCH_ORDER_OVERRIDE_ROOTFS "/lib/modules/4.4.4/correct-modules.dep",
+			  SEARCH_ORDER_OVERRIDE_ROOTFS "/lib/modules/4.4.4/modules.dep" },
+			{ }
+		},
+	});
+
 TESTSUITE_MAIN();
-- 
2.15.1
