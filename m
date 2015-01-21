Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:63715 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730AbbAULhl (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Wed, 21 Jan 2015 06:37:41 -0500
From: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
To: <linux-modules@vger.kernel.org>
Subject: [PATCH 2/4] testsuite: add test for growing then shrinking a hash
Date: Wed, 21 Jan 2015 09:37:21 -0200
Message-ID: <1421840243-26082-2-git-send-email-caio.oliveira@intel.com>
In-Reply-To: <1421840243-26082-1-git-send-email-caio.oliveira@intel.com>
References: <1421840243-26082-1-git-send-email-caio.oliveira@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

---
 testsuite/test-hash.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/testsuite/test-hash.c b/testsuite/test-hash.c
index ea39b80..2e65f86 100644
--- a/testsuite/test-hash.c
+++ b/testsuite/test-hash.c
@@ -246,4 +246,37 @@ static int test_hash_add_unique(const struct test *t)
 DEFINE_TEST(test_hash_add_unique,
 		.description = "test hash_add_unique with different key orders")
 
+
+static int test_hash_massive_add_del(const struct test *t)
+{
+	char buf[1024 * 8];
+	char *k;
+	struct hash *h;
+	unsigned int i, N = 1024;
+
+	h = hash_new(8, NULL);
+
+	k = &buf[0];
+	for (i = 0; i < N; i++) {
+		snprintf(k, 8, "k%d", i);
+		hash_add(h, k, k);
+		k += 8;
+	}
+
+	assert_return(hash_get_count(h) == N, EXIT_FAILURE);
+
+	k = &buf[0];
+	for (i = 0; i < N; i++) {
+		hash_del(h, k);
+		k += 8;
+	}
+
+	assert_return(hash_get_count(h) == 0, EXIT_FAILURE);
+
+	hash_free(h);
+	return 0;
+}
+DEFINE_TEST(test_hash_massive_add_del,
+		.description = "test multiple adds followed by multiple dels")
+
 TESTSUITE_MAIN();
-- 
2.2.2

