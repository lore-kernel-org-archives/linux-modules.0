Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from furnace.wzff.de ([176.9.216.40]:48810 "EHLO furnace.wzff.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345Ab3HZTCu (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 26 Aug 2013 15:02:50 -0400
From: John Spencer <maillist-kmod@barfooze.de>
To: linux-modules@vger.kernel.org
Cc: John Spencer <maillist-kmod@barfooze.de>
Subject: [PATCH 3/3] testsuite: fix usage of reserved names
Date: Mon, 26 Aug 2013 20:20:50 +0200
Message-Id: <1377541250-10193-3-git-send-email-maillist-kmod@barfooze.de>
In-Reply-To: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de>
References: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

stdout and stderr are names reserved for the implementation
and musl uses them rightfully as macro - and the expansion
causes (of course) unexpected results.

renaming the struct members stdout to std_out and stderr
to std_err, to be 1) compliant 2) cause compilation to
succeed.

fixes build with musl libc.

Signed-off-by: John Spencer <maillist-kmod@barfooze.de>

---
 testsuite/test-alias.c      |    2 +-
 testsuite/test-loaded.c     |    2 +-
 testsuite/test-modinfo.c    |    2 +-
 testsuite/test-modprobe.c   |    8 ++++----
 testsuite/test-new-module.c |    4 ++--
 testsuite/testsuite.c       |   30 +++++++++++++++---------------
 testsuite/testsuite.h       |    4 ++--
 7 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/testsuite/test-alias.c b/testsuite/test-alias.c
index 5e21573..a4b4c14 100644
--- a/testsuite/test-alias.c
+++ b/testsuite/test-alias.c
@@ -64,7 +64,7 @@ static DEFINE_TEST(alias_1,
 	},
 	.need_spawn = true,
 	.output = {
-		.stdout = TESTSUITE_ROOTFS "test-alias/correct.txt",
+		.std_out = TESTSUITE_ROOTFS "test-alias/correct.txt",
 	});
 
 static const struct test *tests[] = {
diff --git a/testsuite/test-loaded.c b/testsuite/test-loaded.c
index 33865cb..734a0a8 100644
--- a/testsuite/test-loaded.c
+++ b/testsuite/test-loaded.c
@@ -85,7 +85,7 @@ static DEFINE_TEST(loaded_1,
 	},
 	.need_spawn = true,
 	.output = {
-		.stdout = TESTSUITE_ROOTFS "test-loaded/correct.txt",
+		.std_out = TESTSUITE_ROOTFS "test-loaded/correct.txt",
 	});
 
 static const struct test *tests[] = {
diff --git a/testsuite/test-modinfo.c b/testsuite/test-modinfo.c
index c5934ea..c387633 100644
--- a/testsuite/test-modinfo.c
+++ b/testsuite/test-modinfo.c
@@ -46,7 +46,7 @@ static DEFINE_TEST(modinfo_jonsmodules,
 		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modinfo/",
 	},
 	.output = {
-		.stdout = TESTSUITE_ROOTFS "test-modinfo/correct.txt",
+		.std_out = TESTSUITE_ROOTFS "test-modinfo/correct.txt",
 	});
 
 static const struct test *tests[] = {
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index f0131e3..5dfbe22 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -45,7 +45,7 @@ static DEFINE_TEST(modprobe_show_depends,
 		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/show-depends",
 	},
 	.output = {
-		.stdout = TESTSUITE_ROOTFS "test-modprobe/show-depends/correct.txt",
+		.std_out = TESTSUITE_ROOTFS "test-modprobe/show-depends/correct.txt",
 	});
 
 static __noreturn int modprobe_show_depends2(const struct test *t)
@@ -67,7 +67,7 @@ static DEFINE_TEST(modprobe_show_depends2,
 		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/show-depends",
 	},
 	.output = {
-		.stdout = TESTSUITE_ROOTFS "test-modprobe/show-depends/correct-psmouse.txt",
+		.std_out = TESTSUITE_ROOTFS "test-modprobe/show-depends/correct-psmouse.txt",
 	});
 
 
@@ -90,7 +90,7 @@ static DEFINE_TEST(modprobe_show_alias_to_none,
 		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/alias-to-none",
 	},
 	.output = {
-		.stdout = TESTSUITE_ROOTFS "test-modprobe/show-depends/correct-psmouse.txt",
+		.std_out = TESTSUITE_ROOTFS "test-modprobe/show-depends/correct-psmouse.txt",
 	});
 
 
@@ -177,7 +177,7 @@ static DEFINE_TEST(modprobe_param_kcmdline,
 		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/module-param-kcmdline",
 	},
 	.output = {
-		.stdout = TESTSUITE_ROOTFS "test-modprobe/module-param-kcmdline/correct.txt",
+		.std_out = TESTSUITE_ROOTFS "test-modprobe/module-param-kcmdline/correct.txt",
 	});
 
 
diff --git a/testsuite/test-new-module.c b/testsuite/test-new-module.c
index 240480e..cb603d4 100644
--- a/testsuite/test-new-module.c
+++ b/testsuite/test-new-module.c
@@ -67,7 +67,7 @@ static DEFINE_TEST(from_name,
 	},
 	.need_spawn = true,
 	.output = {
-		.stdout = TESTSUITE_ROOTFS "test-new-module/from_name/correct.txt",
+		.std_out = TESTSUITE_ROOTFS "test-new-module/from_name/correct.txt",
 	});
 
 static int from_alias(const struct test *t)
@@ -112,7 +112,7 @@ static DEFINE_TEST(from_alias,
 	},
 	.need_spawn = true,
 	.output = {
-		.stdout = TESTSUITE_ROOTFS "test-new-module/from_alias/correct.txt",
+		.std_out = TESTSUITE_ROOTFS "test-new-module/from_alias/correct.txt",
 	});
 
 static const struct test *tests[] = {
diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
index 6d85d7f..0b66cb9 100644
--- a/testsuite/testsuite.c
+++ b/testsuite/testsuite.c
@@ -223,7 +223,7 @@ static inline int test_run_child(const struct test *t, int fdout[2],
 	test_export_environ(t);
 
 	/* Close read-fds and redirect std{out,err} to the write-fds */
-	if (t->output.stdout != NULL) {
+	if (t->output.std_out != NULL) {
 		close(fdout[0]);
 		if (dup2(fdout[1], STDOUT_FILENO) < 0) {
 			ERR("could not redirect stdout to pipe: %m\n");
@@ -231,10 +231,10 @@ static inline int test_run_child(const struct test *t, int fdout[2],
 		}
 	}
 
-	if (t->output.stderr != NULL) {
+	if (t->output.std_err != NULL) {
 		close(fderr[0]);
 		if (dup2(fderr[1], STDERR_FILENO) < 0) {
-			ERR("could not redirect stdout to pipe: %m\n");
+			ERR("could not redirect stderr to pipe: %m\n");
 			exit(EXIT_FAILURE);
 		}
 	}
@@ -282,12 +282,12 @@ static inline bool test_run_parent_check_outputs(const struct test *t,
 		return false;
 	}
 
-	if (t->output.stdout != NULL) {
-		fd_matchout = open(t->output.stdout, O_RDONLY);
+	if (t->output.std_out != NULL) {
+		fd_matchout = open(t->output.std_out, O_RDONLY);
 		if (fd_matchout < 0) {
 			err = -errno;
 			ERR("could not open %s for read: %m\n",
-							t->output.stdout);
+							t->output.std_out);
 			goto out;
 		}
 		memset(&ep_outpipe, 0, sizeof(struct epoll_event));
@@ -301,12 +301,12 @@ static inline bool test_run_parent_check_outputs(const struct test *t,
 	} else
 		fdout = -1;
 
-	if (t->output.stderr != NULL) {
-		fd_matcherr = open(t->output.stderr, O_RDONLY);
+	if (t->output.std_err != NULL) {
+		fd_matcherr = open(t->output.std_err, O_RDONLY);
 		if (fd_matcherr < 0) {
 			err = -errno;
 			ERR("could not open %s for read: %m\n",
-					t->output.stderr);
+					t->output.std_err);
 			goto out;
 
 		}
@@ -536,9 +536,9 @@ static inline int test_run_parent(const struct test *t, int fdout[2],
 	bool matchout;
 
 	/* Close write-fds */
-	if (t->output.stdout != NULL)
+	if (t->output.std_out != NULL)
 		close(fdout[1]);
-	if (t->output.stderr != NULL)
+	if (t->output.std_err != NULL)
 		close(fderr[1]);
 	close(fdmonitor[1]);
 
@@ -549,9 +549,9 @@ static inline int test_run_parent(const struct test *t, int fdout[2],
 	 * break pipe on the other end: either child already closed or we want
 	 * to stop it
 	 */
-	if (t->output.stdout != NULL)
+	if (t->output.std_out != NULL)
 		close(fdout[0]);
-	if (t->output.stderr != NULL)
+	if (t->output.std_err != NULL)
 		close(fderr[0]);
 	close(fdmonitor[0]);
 
@@ -650,14 +650,14 @@ int test_run(const struct test *t)
 	if (t->need_spawn && oneshot)
 		test_run_spawned(t);
 
-	if (t->output.stdout != NULL) {
+	if (t->output.std_out != NULL) {
 		if (pipe(fdout) != 0) {
 			ERR("could not create out pipe for %s\n", t->name);
 			return EXIT_FAILURE;
 		}
 	}
 
-	if (t->output.stderr != NULL) {
+	if (t->output.std_err != NULL) {
 		if (pipe(fderr) != 0) {
 			ERR("could not create err pipe for %s\n", t->name);
 			return EXIT_FAILURE;
diff --git a/testsuite/testsuite.h b/testsuite/testsuite.h
index 329d4a1..f8085a7 100644
--- a/testsuite/testsuite.h
+++ b/testsuite/testsuite.h
@@ -82,9 +82,9 @@ struct test {
 	const char *description;
 	struct {
 		/* File with correct stdout */
-		const char *stdout;
+		const char *std_out;
 		/* File with correct stderr */
-		const char *stderr;
+		const char *std_err;
 
 		/*
 		 * Vector with pair of files
-- 
1.7.3.4

