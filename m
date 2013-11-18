Return-Path: <lucas.de.marchi@gmail.com>
Received: from localhost.localdomain (ip-64-134-188-214.public.wayport.net. [64.134.188.214])
        by mx.google.com with ESMTPSA id u52sm27473992yhg.5.2013.11.18.06.05.09
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2013 06:05:11 -0800 (PST)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Subject: [PATCH 5/9] testsuite: add basic test for getline_wrapped
Date: Mon, 18 Nov 2013 12:04:23 -0200
Message-Id: <1384783467-23476-6-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
References: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
List-ID: <linux-modules.vger.kernel.org>

---
 .../test-util/getline_wrapped-correct.txt          |  6 +++++
 .../test-util/getline_wrapped-input.txt            |  6 +++++
 testsuite/test-util.c                              | 31 ++++++++++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 testsuite/rootfs-pristine/test-util/getline_wrapped-correct.txt
 create mode 100644 testsuite/rootfs-pristine/test-util/getline_wrapped-input.txt

diff --git a/testsuite/rootfs-pristine/test-util/getline_wrapped-correct.txt b/testsuite/rootfs-pristine/test-util/getline_wrapped-correct.txt
new file mode 100644
index 0000000..87344ab
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-util/getline_wrapped-correct.txt
@@ -0,0 +1,6 @@
+this is the first line wrapped by one \
+2
+this is a single line
+1
+three line lines in a row
+3
diff --git a/testsuite/rootfs-pristine/test-util/getline_wrapped-input.txt b/testsuite/rootfs-pristine/test-util/getline_wrapped-input.txt
new file mode 100644
index 0000000..f84a852
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-util/getline_wrapped-input.txt
@@ -0,0 +1,6 @@
+this is the first line \
+wrapped by one \\
+this is a single line
+three line \
+lines \
+in a row
diff --git a/testsuite/test-util.c b/testsuite/test-util.c
index db9f134..4fedb24 100644
--- a/testsuite/test-util.c
+++ b/testsuite/test-util.c
@@ -67,8 +67,39 @@ static DEFINE_TEST(alias_1,
 		.out = TESTSUITE_ROOTFS "test-util/alias-correct.txt",
 	});
 
+static int test_getline_wrapped(const struct test *t)
+{
+	FILE *fp = fopen("/getline_wrapped-input.txt", "re");
+
+	if (!fp)
+		return EXIT_FAILURE;
+
+	while (!feof(fp) && !ferror(fp)) {
+		unsigned int num = 0;
+		char *s = getline_wrapped(fp, &num);
+		if (!s)
+			break;
+		puts(s);
+		free(s);
+		printf("%u\n", num);
+	}
+
+	fclose(fp);
+	return EXIT_SUCCESS;
+}
+static DEFINE_TEST(test_getline_wrapped,
+	.description = "check if getline_wrapped() does the right thing",
+	.config = {
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-util/",
+	},
+	.need_spawn = true,
+	.output = {
+		.out = TESTSUITE_ROOTFS "test-util/getline_wrapped-correct.txt",
+	});
+
 static const struct test *tests[] = {
 	&salias_1,
+	&stest_getline_wrapped,
 	NULL,
 };
 
-- 
1.8.4.2
