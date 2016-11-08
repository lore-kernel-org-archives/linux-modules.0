Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752135AbcKHU4d (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 8 Nov 2016 15:56:33 -0500
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
        Jessica Yu <jeyu@redhat.com>
Subject: [PATCH] testsuite: fix test_array_sort pointers inderection
Date: Tue,  8 Nov 2016 22:57:26 +0200
Message-Id: <1478638646-5933-1-git-send-email-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

The array elements in the tests are strings, what means "char *"
in С. The comparation funtion takes pointers to the elements, so
the arguments become "char **". It means, that strcmp() cannot be
used directrly.

The patch creates a wrapper on strcmp() which perfoms
dereferencing of the "char **" to supply the actual strings to
strcmp(), and uses the wrapper as a comparation function for the
qsort() call.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 testsuite/test-array.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testsuite/test-array.c b/testsuite/test-array.c
index 3c72a8a109c5..ef1e1e9922c9 100644
--- a/testsuite/test-array.c
+++ b/testsuite/test-array.c
@@ -90,6 +90,13 @@ static int test_array_append_unique(const struct test *t)
 DEFINE_TEST(test_array_append_unique,
 		.description = "test array append unique");
 
+static int strptrcmp(const void *pa, const void *pb) {
+	const char *a = *(const char **)pa;
+	const char *b = *(const char **)pb;
+
+	return strcmp(a, b);
+}
+
 static int test_array_sort(const struct test *t)
 {
 	struct array array;
@@ -104,7 +111,7 @@ static int test_array_sort(const struct test *t)
 	array_append(&array, c2);
 	array_append(&array, c3);
 	array_append(&array, c1);
-	array_sort(&array, (int (*)(const void *a, const void *b)) strcmp);
+	array_sort(&array, strptrcmp);
 	assert_return(array.count == 6, EXIT_FAILURE);
 	assert_return(array.array[0] == c1, EXIT_FAILURE);
 	assert_return(array.array[1] == c1, EXIT_FAILURE);
-- 
2.7.4

