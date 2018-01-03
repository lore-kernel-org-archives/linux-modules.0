Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:63083 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751244AbeACW3f (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 3 Jan 2018 17:29:35 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-modules@vger.kernel.org
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 5/6] testsuite: add missing error handling
Date: Wed,  3 Jan 2018 14:29:23 -0800
Message-Id: <20180103222924.26347-6-lucas.demarchi@intel.com>
In-Reply-To: <20180103222924.26347-1-lucas.demarchi@intel.com>
References: <20180103222924.26347-1-lucas.demarchi@intel.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

If we passed an invalid argument to a test it would segfault rather than
returning an error code.
---
 testsuite/testsuite.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testsuite/testsuite.h b/testsuite/testsuite.h
index bb0eb50..2b31483 100644
--- a/testsuite/testsuite.h
+++ b/testsuite/testsuite.h
@@ -151,6 +151,8 @@ int test_run(const struct test *t);
 		arg = test_init(__start_kmod_tests, __stop_kmod_tests, argc, argv);		\
 		if (arg == 0)									\
 			return 0;								\
+		if (arg < 0)									\
+			return EXIT_FAILURE;							\
 												\
 		if (arg < argc) {								\
 			t = test_find(__start_kmod_tests, __stop_kmod_tests, argv[arg]);	\
-- 
2.14.3

