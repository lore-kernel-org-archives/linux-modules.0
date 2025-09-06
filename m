Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185FC8462;
	Sat,  6 Sep 2025 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164594; cv=none; b=I4snofXiT7SlDAABu0DufQvXRgsZ3FJpbNRbueV98A1bTipcCObGAxPlqJRpeKEDwXoPKikWFCW/N5hS1hfQ5rHv53XD2z0VxSo7q4L3gC562t7cUgKTwWC2H8bXi0qNZK5uwW5OrX3nIgxz6f+nenBMzkIDp0Uwb0v8iCdstAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164594; c=relaxed/simple;
	bh=l9nhhVdhm/8vc2KY9Pv8h9N4nKTO8OqtEIo3XHesPzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKUbBHGVMFdTHbL7xvO3SBf0UoxgZyeqECEfGw+XFM0PS1wvuDGl6Q/MQYMt37wqXLYb/vDMHM74wY4kvLUixvwmVrbGRl4sc5KnLnGSSJwIAPL96HUogAWfV8DpW0NbDOrXTCoj9vYolziTznIrlgNP6CTkIa6PcQMM2E33a18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVHPpPQO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVHPpPQO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45cb5492350so19238875e9.1;
        Sat, 06 Sep 2025 06:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757164590; x=1757769390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pHtbX+hoLFhisWXH/6uIM4RzEVWDALofbx9D6dgOqBU=;
        b=UVHPpPQO+govu+fcasPdqmCWZ9+NEYu6a99hWgITSBh1vO66bf7ftV4QXGm+oaawra
         zR8JM8HkNGQjE1hsC6mkTvhN/KxoZeqQ9oaCPTk+TkqUtoObVWUoGzTbM266U0fhgsfM
         JTLiD/seFPOqobY9Xd7kDry6QbBzSnk2OrfQLl4tDb/Q5ZAyzmBrFsUz8PrwPgz4HV1A
         YFu3lH9oAiBL5RoyrUG1N218AuZl4u7m80Wga4vMhn2JP3bjPag+ZHL+/nojHrDFqIt8
         Ms6pglgeSJ3Zc4BE9qTDKvTqgyHp4xrMjvobQG4vbSBEqq84ALsNFh1/jo40uOrAwTJZ
         c81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757164590; x=1757769390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHtbX+hoLFhisWXH/6uIM4RzEVWDALofbx9D6dgOqBU=;
        b=pNlVv/SF6/M94+9BBhKh9gC8OXQoWzxWlK4axLocvZ8AWDuXkkUlqJAVROat+sLTCw
         2pDXsyuVTAmah3u/T5B1Kz6rTeGwW2lvcK12/fb9s5ybPMmoYJmQb1LPxiENIplOFV4M
         xsbvIe/G2eM9WCk95iGV41ApjrIISq2kANYPvC5Tjz77yx3WwHZ4aJu44yyI/86jLBEY
         iWdv23lpQQ/+ysBc0qCzbNjVIwO9wzdz+LE4O0stBAmlTcpy78gZ9+1EcEj2t8Kfg3pN
         L11hbo9M53ClWNSKYs9L8EtRBhnyJIZ+7nq25jVUdWfhvaCfWyV06d5EXhkiwQyhHv7F
         PsWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPvJ98FfKiTIfowOss0GhiZ834JBaYzwg6KJh+aSNrQ0dDyXh1ISLbTueNSy2OlKDhZDiALUb/6olMhr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWBDKTlV7hzG0EI3d07efPDePDxqT18+KsiACuW/C4N954Vv2N
	UCb6+wgyCvqMZP5468kqZnHdSEt2QFGxaQXwdEnXaeGWdnMwbHxoPKw7tvdS2Hfc
X-Gm-Gg: ASbGncupg2vASJuX1q0pzIxtVutSOgsvV4fyR5DhiosMh9qNojuHgraiN7BfFJ5/cXc
	e/DxB+b2kxbQgWuJ4XnIkxN/oMG+8M0Fk/TtNV+NWoXPzabmIJ9FilebkyzHe+vXXInwwRD9RmR
	ew5vAtDLJ6t9IZzNN2TR8KV4clH9dyS/VMGJ022OFh4Gp/gxcnzgp4xUUYplIPbrGTCC/vfvIFh
	OWu6jxOLBdoRTm2NcTx7B7AeU+bdDKFMueh8Rmko7C860U4mWkSXjoE7y+w/SzSN7L2fgulHp5A
	cnYZwO9jQW1nQA6NjSIx7LVKTcbEeRbKN/JG0RTk6VUCP7wCBTrC3Fyd7Px2/DcL+mL/8J0Z767
	3ogUa0kW1wnZYeLLKeK+i4pEA8sNVWXj9eqge7E3p8jFGYxk=
X-Google-Smtp-Source: AGHT+IHzz+rH/aLOFWZBzuo7qJGuEmT1EFIYfugsNbOri64viuMj6Of3U+JLlCxhnbKoEzArPRPENA==
X-Received: by 2002:a05:600c:1c1b:b0:45d:d68c:2a43 with SMTP id 5b1f17b1804b1-45de1f2cc51mr4438825e9.33.1757164589821;
        Sat, 06 Sep 2025 06:16:29 -0700 (PDT)
Received: from Al-Qamar ([87.201.248.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7fec07sm357514175e9.10.2025.09.06.06.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 06:16:29 -0700 (PDT)
From: Fidal Palamparambil <rootuserhere@gmail.com>
To: linux-modules@vger.kernel.org
Cc: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	linux-kernel@vger.kernel.org,
	Fidal palamparambil <rootuserhere@gmail.com>
Subject: [PATCH] kprobe_event_gen_test : Fix error handling and resource cleanup
Date: Sat,  6 Sep 2025 17:15:59 +0400
Message-ID: <20250906131559.200-1-rootuserhere@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fidal palamparambil <rootuserhere@gmail.com>

This commit addresses several issues in the kprobe event generation test module:

1. Fixed NULL pointer management in error paths where trace_event_file pointers
   were not properly set to NULL after errors, potentially causing double-free
   or use-after-free issues.

2. Added comprehensive cleanup for the kprobe event when kretprobe initialization
   fails in kprobe_event_gen_test_init(). Previously, a failed kretprobe creation
   would leave the kprobe event dangling.

3. Enhanced error handling consistency between kprobe and kretprobe test functions,
   ensuring both follow the same pattern for resource cleanup.

4. Fixed the error handling flow in test_gen_kprobe_cmd() and test_gen_kretprobe_cmd()
   to properly set trace_event_file pointers to NULL when errors occur after
   event creation but before successful completion.

The changes ensure proper resource management and prevent potential memory
corruption or leaks during module initialization and cleanup.

Signed-off-by: Fidal palamparambil <rootuserhere@gmail.com>
---
 kernel/trace/kprobe_event_gen_test.c      |  33 ++-
 kernel/trace/kprobe_event_gen_test.c.orig | 276 ++++++++++++++++++++++
 2 files changed, 301 insertions(+), 8 deletions(-)
 create mode 100644 kernel/trace/kprobe_event_gen_test.c.orig

diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
index 5a4b722b5045..c9ab1c9bbf52 100644
--- a/kernel/trace/kprobe_event_gen_test.c
+++ b/kernel/trace/kprobe_event_gen_test.c
@@ -129,6 +129,7 @@ static int __init test_gen_kprobe_cmd(void)
 					       "gen_kprobe_test");
 	if (IS_ERR(gen_kprobe_test)) {
 		ret = PTR_ERR(gen_kprobe_test);
+		gen_kprobe_test = NULL;
 		goto delete;
 	}
 
@@ -137,14 +138,13 @@ static int __init test_gen_kprobe_cmd(void)
 					"kprobes", "gen_kprobe_test", true);
 	if (ret) {
 		trace_put_event_file(gen_kprobe_test);
+		gen_kprobe_test = NULL;
 		goto delete;
 	}
  out:
 	kfree(buf);
 	return ret;
  delete:
-	if (trace_event_file_is_valid(gen_kprobe_test))
-		gen_kprobe_test = NULL;
 	/* We got an error after creating the event, delete it */
 	kprobe_event_delete("gen_kprobe_test");
 	goto out;
@@ -194,6 +194,7 @@ static int __init test_gen_kretprobe_cmd(void)
 						  "gen_kretprobe_test");
 	if (IS_ERR(gen_kretprobe_test)) {
 		ret = PTR_ERR(gen_kretprobe_test);
+		gen_kretprobe_test = NULL;
 		goto delete;
 	}
 
@@ -202,14 +203,13 @@ static int __init test_gen_kretprobe_cmd(void)
 					"kprobes", "gen_kretprobe_test", true);
 	if (ret) {
 		trace_put_event_file(gen_kretprobe_test);
+		gen_kretprobe_test = NULL;
 		goto delete;
 	}
  out:
 	kfree(buf);
 	return ret;
  delete:
-	if (trace_event_file_is_valid(gen_kretprobe_test))
-		gen_kretprobe_test = NULL;
 	/* We got an error after creating the event, delete it */
 	kprobe_event_delete("gen_kretprobe_test");
 	goto out;
@@ -220,11 +220,21 @@ static int __init kprobe_event_gen_test_init(void)
 	int ret;
 
 	ret = test_gen_kprobe_cmd();
-	if (ret)
+	if (ret) {
+		/* Clean up kprobe event if it was partially created */
+		if (trace_event_file_is_valid(gen_kprobe_test)) {
+			WARN_ON(trace_array_set_clr_event(gen_kprobe_test->tr,
+							  "kprobes",
+							  "gen_kprobe_test", false));
+			trace_put_event_file(gen_kprobe_test);
+		}
+		WARN_ON(kprobe_event_delete("gen_kprobe_test"));
 		return ret;
+	}
 
 	ret = test_gen_kretprobe_cmd();
 	if (ret) {
+		/* Clean up kretprobe event if it was partially created */
 		if (trace_event_file_is_valid(gen_kretprobe_test)) {
 			WARN_ON(trace_array_set_clr_event(gen_kretprobe_test->tr,
 							  "kprobes",
@@ -232,6 +242,15 @@ static int __init kprobe_event_gen_test_init(void)
 			trace_put_event_file(gen_kretprobe_test);
 		}
 		WARN_ON(kprobe_event_delete("gen_kretprobe_test"));
+		
+		/* Also clean up the successfully created kprobe event */
+		if (trace_event_file_is_valid(gen_kprobe_test)) {
+			WARN_ON(trace_array_set_clr_event(gen_kprobe_test->tr,
+							  "kprobes",
+							  "gen_kprobe_test", false));
+			trace_put_event_file(gen_kprobe_test);
+		}
+		WARN_ON(kprobe_event_delete("gen_kprobe_test"));
 	}
 
 	return ret;
@@ -249,7 +268,6 @@ static void __exit kprobe_event_gen_test_exit(void)
 		trace_put_event_file(gen_kprobe_test);
 	}
 
-
 	/* Now unregister and free the event */
 	WARN_ON(kprobe_event_delete("gen_kprobe_test"));
 
@@ -263,7 +281,6 @@ static void __exit kprobe_event_gen_test_exit(void)
 		trace_put_event_file(gen_kretprobe_test);
 	}
 
-
 	/* Now unregister and free the event */
 	WARN_ON(kprobe_event_delete("gen_kretprobe_test"));
 }
@@ -273,4 +290,4 @@ module_exit(kprobe_event_gen_test_exit)
 
 MODULE_AUTHOR("Tom Zanussi");
 MODULE_DESCRIPTION("kprobe event generation test");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL v2");
\ No newline at end of file
diff --git a/kernel/trace/kprobe_event_gen_test.c.orig b/kernel/trace/kprobe_event_gen_test.c.orig
new file mode 100644
index 000000000000..5a4b722b5045
--- /dev/null
+++ b/kernel/trace/kprobe_event_gen_test.c.orig
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test module for in-kernel kprobe event creation and generation.
+ *
+ * Copyright (C) 2019 Tom Zanussi <zanussi@kernel.org>
+ */
+
+#include <linux/module.h>
+#include <linux/trace_events.h>
+
+/*
+ * This module is a simple test of basic functionality for in-kernel
+ * kprobe/kretprobe event creation.  The first test uses
+ * kprobe_event_gen_cmd_start(), kprobe_event_add_fields() and
+ * kprobe_event_gen_cmd_end() to create a kprobe event, which is then
+ * enabled in order to generate trace output.  The second creates a
+ * kretprobe event using kretprobe_event_gen_cmd_start() and
+ * kretprobe_event_gen_cmd_end(), and is also then enabled.
+ *
+ * To test, select CONFIG_KPROBE_EVENT_GEN_TEST and build the module.
+ * Then:
+ *
+ * # insmod kernel/trace/kprobe_event_gen_test.ko
+ * # cat /sys/kernel/tracing/trace
+ *
+ * You should see many instances of the "gen_kprobe_test" and
+ * "gen_kretprobe_test" events in the trace buffer.
+ *
+ * To remove the events, remove the module:
+ *
+ * # rmmod kprobe_event_gen_test
+ *
+ */
+
+static struct trace_event_file *gen_kprobe_test;
+static struct trace_event_file *gen_kretprobe_test;
+
+#define KPROBE_GEN_TEST_FUNC	"do_sys_open"
+
+/* X86 */
+#if defined(CONFIG_X86_64) || defined(CONFIG_X86_32)
+#define KPROBE_GEN_TEST_ARG0	"dfd=%ax"
+#define KPROBE_GEN_TEST_ARG1	"filename=%dx"
+#define KPROBE_GEN_TEST_ARG2	"flags=%cx"
+#define KPROBE_GEN_TEST_ARG3	"mode=+4($stack)"
+
+/* ARM64 */
+#elif defined(CONFIG_ARM64)
+#define KPROBE_GEN_TEST_ARG0	"dfd=%x0"
+#define KPROBE_GEN_TEST_ARG1	"filename=%x1"
+#define KPROBE_GEN_TEST_ARG2	"flags=%x2"
+#define KPROBE_GEN_TEST_ARG3	"mode=%x3"
+
+/* ARM */
+#elif defined(CONFIG_ARM)
+#define KPROBE_GEN_TEST_ARG0	"dfd=%r0"
+#define KPROBE_GEN_TEST_ARG1	"filename=%r1"
+#define KPROBE_GEN_TEST_ARG2	"flags=%r2"
+#define KPROBE_GEN_TEST_ARG3	"mode=%r3"
+
+/* RISCV */
+#elif defined(CONFIG_RISCV)
+#define KPROBE_GEN_TEST_ARG0	"dfd=%a0"
+#define KPROBE_GEN_TEST_ARG1	"filename=%a1"
+#define KPROBE_GEN_TEST_ARG2	"flags=%a2"
+#define KPROBE_GEN_TEST_ARG3	"mode=%a3"
+
+/* others */
+#else
+#define KPROBE_GEN_TEST_ARG0	NULL
+#define KPROBE_GEN_TEST_ARG1	NULL
+#define KPROBE_GEN_TEST_ARG2	NULL
+#define KPROBE_GEN_TEST_ARG3	NULL
+#endif
+
+static bool trace_event_file_is_valid(struct trace_event_file *input)
+{
+	return input && !IS_ERR(input);
+}
+
+/*
+ * Test to make sure we can create a kprobe event, then add more
+ * fields.
+ */
+static int __init test_gen_kprobe_cmd(void)
+{
+	struct dynevent_cmd cmd;
+	char *buf;
+	int ret;
+
+	/* Create a buffer to hold the generated command */
+	buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* Before generating the command, initialize the cmd object */
+	kprobe_event_cmd_init(&cmd, buf, MAX_DYNEVENT_CMD_LEN);
+
+	/*
+	 * Define the gen_kprobe_test event with the first 2 kprobe
+	 * fields.
+	 */
+	ret = kprobe_event_gen_cmd_start(&cmd, "gen_kprobe_test",
+					 KPROBE_GEN_TEST_FUNC,
+					 KPROBE_GEN_TEST_ARG0, KPROBE_GEN_TEST_ARG1);
+	if (ret)
+		goto out;
+
+	/* Use kprobe_event_add_fields to add the rest of the fields */
+
+	ret = kprobe_event_add_fields(&cmd, KPROBE_GEN_TEST_ARG2, KPROBE_GEN_TEST_ARG3);
+	if (ret)
+		goto out;
+
+	/*
+	 * This actually creates the event.
+	 */
+	ret = kprobe_event_gen_cmd_end(&cmd);
+	if (ret)
+		goto out;
+
+	/*
+	 * Now get the gen_kprobe_test event file.  We need to prevent
+	 * the instance and event from disappearing from underneath
+	 * us, which trace_get_event_file() does (though in this case
+	 * we're using the top-level instance which never goes away).
+	 */
+	gen_kprobe_test = trace_get_event_file(NULL, "kprobes",
+					       "gen_kprobe_test");
+	if (IS_ERR(gen_kprobe_test)) {
+		ret = PTR_ERR(gen_kprobe_test);
+		goto delete;
+	}
+
+	/* Enable the event or you won't see anything */
+	ret = trace_array_set_clr_event(gen_kprobe_test->tr,
+					"kprobes", "gen_kprobe_test", true);
+	if (ret) {
+		trace_put_event_file(gen_kprobe_test);
+		goto delete;
+	}
+ out:
+	kfree(buf);
+	return ret;
+ delete:
+	if (trace_event_file_is_valid(gen_kprobe_test))
+		gen_kprobe_test = NULL;
+	/* We got an error after creating the event, delete it */
+	kprobe_event_delete("gen_kprobe_test");
+	goto out;
+}
+
+/*
+ * Test to make sure we can create a kretprobe event.
+ */
+static int __init test_gen_kretprobe_cmd(void)
+{
+	struct dynevent_cmd cmd;
+	char *buf;
+	int ret;
+
+	/* Create a buffer to hold the generated command */
+	buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* Before generating the command, initialize the cmd object */
+	kprobe_event_cmd_init(&cmd, buf, MAX_DYNEVENT_CMD_LEN);
+
+	/*
+	 * Define the kretprobe event.
+	 */
+	ret = kretprobe_event_gen_cmd_start(&cmd, "gen_kretprobe_test",
+					    KPROBE_GEN_TEST_FUNC,
+					    "$retval");
+	if (ret)
+		goto out;
+
+	/*
+	 * This actually creates the event.
+	 */
+	ret = kretprobe_event_gen_cmd_end(&cmd);
+	if (ret)
+		goto out;
+
+	/*
+	 * Now get the gen_kretprobe_test event file.  We need to
+	 * prevent the instance and event from disappearing from
+	 * underneath us, which trace_get_event_file() does (though in
+	 * this case we're using the top-level instance which never
+	 * goes away).
+	 */
+	gen_kretprobe_test = trace_get_event_file(NULL, "kprobes",
+						  "gen_kretprobe_test");
+	if (IS_ERR(gen_kretprobe_test)) {
+		ret = PTR_ERR(gen_kretprobe_test);
+		goto delete;
+	}
+
+	/* Enable the event or you won't see anything */
+	ret = trace_array_set_clr_event(gen_kretprobe_test->tr,
+					"kprobes", "gen_kretprobe_test", true);
+	if (ret) {
+		trace_put_event_file(gen_kretprobe_test);
+		goto delete;
+	}
+ out:
+	kfree(buf);
+	return ret;
+ delete:
+	if (trace_event_file_is_valid(gen_kretprobe_test))
+		gen_kretprobe_test = NULL;
+	/* We got an error after creating the event, delete it */
+	kprobe_event_delete("gen_kretprobe_test");
+	goto out;
+}
+
+static int __init kprobe_event_gen_test_init(void)
+{
+	int ret;
+
+	ret = test_gen_kprobe_cmd();
+	if (ret)
+		return ret;
+
+	ret = test_gen_kretprobe_cmd();
+	if (ret) {
+		if (trace_event_file_is_valid(gen_kretprobe_test)) {
+			WARN_ON(trace_array_set_clr_event(gen_kretprobe_test->tr,
+							  "kprobes",
+							  "gen_kretprobe_test", false));
+			trace_put_event_file(gen_kretprobe_test);
+		}
+		WARN_ON(kprobe_event_delete("gen_kretprobe_test"));
+	}
+
+	return ret;
+}
+
+static void __exit kprobe_event_gen_test_exit(void)
+{
+	if (trace_event_file_is_valid(gen_kprobe_test)) {
+		/* Disable the event or you can't remove it */
+		WARN_ON(trace_array_set_clr_event(gen_kprobe_test->tr,
+						  "kprobes",
+						  "gen_kprobe_test", false));
+
+		/* Now give the file and instance back */
+		trace_put_event_file(gen_kprobe_test);
+	}
+
+
+	/* Now unregister and free the event */
+	WARN_ON(kprobe_event_delete("gen_kprobe_test"));
+
+	if (trace_event_file_is_valid(gen_kretprobe_test)) {
+		/* Disable the event or you can't remove it */
+		WARN_ON(trace_array_set_clr_event(gen_kretprobe_test->tr,
+						  "kprobes",
+						  "gen_kretprobe_test", false));
+
+		/* Now give the file and instance back */
+		trace_put_event_file(gen_kretprobe_test);
+	}
+
+
+	/* Now unregister and free the event */
+	WARN_ON(kprobe_event_delete("gen_kretprobe_test"));
+}
+
+module_init(kprobe_event_gen_test_init)
+module_exit(kprobe_event_gen_test_exit)
+
+MODULE_AUTHOR("Tom Zanussi");
+MODULE_DESCRIPTION("kprobe event generation test");
+MODULE_LICENSE("GPL v2");
-- 
2.50.1.windows.1

