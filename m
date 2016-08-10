Return-Path: <lucas.de.marchi@gmail.com>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 2/3] Add scratchbuf implementation
Date: Wed, 10 Aug 2016 15:37:12 -0300
Message-Id: <1470854233-19810-2-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1470854233-19810-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1470854233-19810-1-git-send-email-lucas.de.marchi@gmail.com>
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

This should fill the requirements for "we need to loop over a lot of
strings that usually are small enough to remain on stack, but we want to
protect ourselves against huge strings not fitting in the static
buffer we estimated as sufficient"
---
 Makefile.am                 |  5 +++
 shared/scratchbuf.c         | 60 ++++++++++++++++++++++++++++++
 shared/scratchbuf.h         | 23 ++++++++++++
 testsuite/.gitignore        |  3 ++
 testsuite/test-scratchbuf.c | 89 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 180 insertions(+)
 create mode 100644 shared/scratchbuf.c
 create mode 100644 shared/scratchbuf.h
 create mode 100644 testsuite/test-scratchbuf.c

diff --git a/Makefile.am b/Makefile.am
index 390628a..d4eeb7e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -52,6 +52,7 @@ shared_libshared_la_SOURCES = \
 	shared/array.h \
 	shared/hash.c \
 	shared/hash.h \
+	shared/scratchbuf.c \
 	shared/strbuf.c \
 	shared/strbuf.h \
 	shared/util.c \
@@ -322,6 +323,7 @@ testsuite_libtestsuite_la_LIBADD = -lrt
 TESTSUITE = \
 	testsuite/test-hash \
 	testsuite/test-array \
+	testsuite/test-scratchbuf \
 	testsuite/test-strbuf \
 	testsuite/test-init \
 	testsuite/test-initstate \
@@ -349,6 +351,9 @@ testsuite_test_hash_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
 testsuite_test_array_LDADD = $(TESTSUITE_LDADD)
 testsuite_test_array_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
 
+testsuite_test_scratchbuf_LDADD = $(TESTSUITE_LDADD)
+testsuite_test_scratchbuf_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
+
 testsuite_test_strbuf_LDADD = $(TESTSUITE_LDADD)
 testsuite_test_strbuf_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
 
diff --git a/shared/scratchbuf.c b/shared/scratchbuf.c
new file mode 100644
index 0000000..8d9eb83
--- /dev/null
+++ b/shared/scratchbuf.c
@@ -0,0 +1,60 @@
+/*
+ * kmod - interface to kernel module operations
+ *
+ * Copyright (C) 2016  Intel Corporation. All rights reserved.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "scratchbuf.h"
+
+#include <errno.h>
+#include <string.h>
+
+void scratchbuf_init(struct scratchbuf *buf, char *stackbuf, size_t size)
+{
+	buf->bytes = stackbuf;
+	buf->size = size;
+	buf->need_free = false;
+}
+
+int scratchbuf_alloc(struct scratchbuf *buf, size_t size)
+{
+	char *tmp;
+
+	if (size <= buf->size)
+		return 0;
+
+	if (buf->need_free) {
+		tmp = realloc(buf->bytes, size);
+		if (tmp == NULL)
+			return -ENOMEM;
+	} else {
+		tmp = malloc(size);
+		if (tmp == NULL)
+			return -ENOMEM;
+		memcpy(tmp, buf->bytes, buf->size);
+	}
+
+	buf->size = size;
+	buf->bytes = tmp;
+	buf->need_free = true;
+
+	return 0;
+}
+
+void scratchbuf_release(struct scratchbuf *buf)
+{
+	if (buf->need_free)
+		free(buf->bytes);
+}
diff --git a/shared/scratchbuf.h b/shared/scratchbuf.h
new file mode 100644
index 0000000..d14fd14
--- /dev/null
+++ b/shared/scratchbuf.h
@@ -0,0 +1,23 @@
+#pragma once
+
+#include <stdbool.h>
+#include <stdlib.h>
+
+/*
+ * Buffer abstract data type
+ */
+struct scratchbuf {
+	char *bytes;
+	size_t size;
+	bool need_free;
+};
+
+void scratchbuf_init(struct scratchbuf *buf, char *stackbuf, size_t size);
+int scratchbuf_alloc(struct scratchbuf *buf, size_t sz);
+void scratchbuf_release(struct scratchbuf *buf);
+
+/* Return a C string */
+inline char *scratchbuf_str(struct scratchbuf *buf)
+{
+	return buf->bytes;
+}
diff --git a/testsuite/.gitignore b/testsuite/.gitignore
index 2b71a47..9d26b88 100644
--- a/testsuite/.gitignore
+++ b/testsuite/.gitignore
@@ -2,6 +2,7 @@
 *.la
 *.so
 /.dirstamp
+/test-scratchbuf
 /test-strbuf
 /test-array
 /test-util
@@ -20,6 +21,8 @@
 /test-tools
 /rootfs
 /stamp-rootfs
+/test-scratchbuf.log
+/test-scratchbuf.trs
 /test-strbuf.log
 /test-strbuf.trs
 /test-array.log
diff --git a/testsuite/test-scratchbuf.c b/testsuite/test-scratchbuf.c
new file mode 100644
index 0000000..6d86957
--- /dev/null
+++ b/testsuite/test-scratchbuf.c
@@ -0,0 +1,89 @@
+/*
+ * Copyright (C)  2016 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <shared/scratchbuf.h>
+
+#include "testsuite.h"
+
+static int test_scratchbuf_onlystack(const struct test *t)
+{
+	struct scratchbuf sbuf;
+	const char *smallstr = "xyz";
+	char buf[3 + 2];
+	char buf2[3 + 1];
+
+	scratchbuf_init(&sbuf, buf, sizeof(buf));
+	assert_return(scratchbuf_alloc(&sbuf, strlen(smallstr) + 1) == 0, EXIT_FAILURE);
+	assert_return(sbuf.need_free == false, EXIT_FAILURE);
+	scratchbuf_release(&sbuf);
+
+	scratchbuf_init(&sbuf, buf2, sizeof(buf2));
+	assert_return(scratchbuf_alloc(&sbuf, strlen(smallstr) + 1) == 0, EXIT_FAILURE);
+	assert_return(sbuf.need_free == false, EXIT_FAILURE);
+	scratchbuf_release(&sbuf);
+
+	memcpy(scratchbuf_str(&sbuf), smallstr, strlen(smallstr) + 1);
+	assert_return(strcmp(scratchbuf_str(&sbuf), smallstr) == 0, EXIT_FAILURE);
+
+	return 0;
+}
+DEFINE_TEST(test_scratchbuf_onlystack,
+		.description = "test scratchbuf for buffer on stack only");
+
+
+static int test_scratchbuf_heap(const struct test *t)
+{
+	struct scratchbuf sbuf;
+	const char *smallstr = "xyz";
+	const char *largestr = "xyzxyzxyz";
+	const char *largestr2 = "xyzxyzxyzxyzxyz";
+	char buf[3 + 1];
+
+	scratchbuf_init(&sbuf, buf, sizeof(buf));
+
+	/* Initially only on stack */
+	assert_return(scratchbuf_alloc(&sbuf, strlen(smallstr) + 1) == 0, EXIT_FAILURE);
+	assert_return(sbuf.need_free == false, EXIT_FAILURE);
+	memcpy(scratchbuf_str(&sbuf), smallstr, strlen(smallstr) + 1);
+
+	/* Grow once to heap */
+	assert_return(scratchbuf_alloc(&sbuf, strlen(largestr) + 1) == 0, EXIT_FAILURE);
+	assert_return(sbuf.need_free == true, EXIT_FAILURE);
+	assert_return(sbuf.size == strlen(largestr) + 1, EXIT_FAILURE);
+	assert_return(strcmp(scratchbuf_str(&sbuf), smallstr) == 0, EXIT_FAILURE);
+	memcpy(scratchbuf_str(&sbuf), largestr, strlen(largestr) + 1);
+	assert_return(strcmp(scratchbuf_str(&sbuf), largestr) == 0, EXIT_FAILURE);
+
+	/* Grow again - realloc should take place */
+	assert_return(scratchbuf_alloc(&sbuf, strlen(largestr2) + 1) == 0, EXIT_FAILURE);
+	assert_return(sbuf.need_free == true, EXIT_FAILURE);
+	assert_return(sbuf.size == strlen(largestr2) + 1, EXIT_FAILURE);
+	memcpy(scratchbuf_str(&sbuf), largestr2, strlen(largestr2) + 1);
+	assert_return(strcmp(scratchbuf_str(&sbuf), largestr2) == 0, EXIT_FAILURE);
+
+	scratchbuf_release(&sbuf);
+
+	return 0;
+}
+DEFINE_TEST(test_scratchbuf_heap,
+		.description = "test scratchbuf for buffer on that grows to heap");
+
+TESTSUITE_MAIN();
-- 
2.7.4
