Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:63715 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145AbbAULhi (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Wed, 21 Jan 2015 06:37:38 -0500
From: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
To: <linux-modules@vger.kernel.org>
Subject: [PATCH 1/4] testsuite: add test for hash_add_unique
Date: Wed, 21 Jan 2015 09:37:20 -0200
Message-ID: <1421840243-26082-1-git-send-email-caio.oliveira@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

---
 testsuite/test-hash.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/testsuite/test-hash.c b/testsuite/test-hash.c
index 3cf5ba7..ea39b80 100644
--- a/testsuite/test-hash.c
+++ b/testsuite/test-hash.c
@@ -220,4 +220,30 @@ static int test_hash_free(const struct test *t)
 DEFINE_TEST(test_hash_free,
 		.description = "test hash_free calling free function for all values");
 
+
+static int test_hash_add_unique(const struct test *t)
+{
+	const char *k[] = { "k1", "k2", "k3", "k4", "k5" };
+	const char *v[] = { "v1", "v2", "v3", "v4", "v5" };
+	unsigned int i, j, N;
+
+	N = ARRAY_SIZE(k);
+	for (i = 0; i < N; i++) {
+		/* With 4 buckets, there'll be a bucket with more than one key. */
+		struct hash *h = hash_new(4, NULL);
+
+		/* Add the keys in different orders. */
+		for (j = 0; j < N; j++) {
+			unsigned int idx = (j + i) % N;
+			hash_add_unique(h, k[idx], v[idx]);
+		}
+
+		assert_return(hash_get_count(h) == N, EXIT_FAILURE);
+		hash_free(h);
+	}
+	return 0;
+}
+DEFINE_TEST(test_hash_add_unique,
+		.description = "test hash_add_unique with different key orders")
+
 TESTSUITE_MAIN();
-- 
2.2.2

