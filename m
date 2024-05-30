Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F24D8A6
	for <linux-modules@vger.kernel.org>; Thu, 30 May 2024 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717052931; cv=none; b=oGkIq4zxf8t9osd/x1BI1KYoQqDiwovZlgk+8ZZIPveXBOEGJz1mqi/Zs5n+jNqYbuaV43DSH51tuEb/dG4oB3S2iKys/0hlx5vG1Yhs5OO2kcW86rX62lYIPGO04rA0tQPSlATSoDDcGY+TpcC690piBS6zGQi9IGqyDiPNGDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717052931; c=relaxed/simple;
	bh=e4WBkhibSluUozOkpPxBQZjBbT5YAJh7uelR0N2txlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5aGkm8JtfA5bgoacZS2+xQroKkL1Y+KvkQpAkZvpE7CVDFVekNQEzA3vdLYTH+2O0kuYlFf+o9jJShGL9RrHfJCPAHKRQiQldlNEIW4mIuCxikskbr7Q7sw7OvqYBblZEnMGNFPKETYFJBrw7P4IwLlLOEiIgtv/YGq5EphM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwU8QdMc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwU8QdMc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717052927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fGNhuUSS7LIKuF+FNEmbKSn39tHiuZzRBqBHYL5efBU=;
	b=YwU8QdMc52vDLG8sito8qmH8oScpN4nVpgm+2UvhhqXnqyVFoxJEMcQ0MUK7iKb3P2ivnq
	PvUp5K2giKAahmV+UtsyPson9y354rvvrzAfelOTA/L7TpjVptwjX4B5rKGEKrq4lByPy1
	Ubu2JMOu+wJg9cDSQF5IzpAy80M7oso=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-lFtEHWjfNbK957atrBOqQw-1; Thu,
 30 May 2024 03:08:46 -0400
X-MC-Unique: lFtEHWjfNbK957atrBOqQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B95991C05122;
	Thu, 30 May 2024 07:08:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4C754105480A;
	Thu, 30 May 2024 07:08:44 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: lucas.demarchi@intel.com,
	linux-modules@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH kmod] testsuite: add tests for weak dependencies
Date: Thu, 30 May 2024 09:08:27 +0200
Message-ID: <20240530070836.9438-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The following tests to verify weak dependencies have been implemented:
1) modprobe test to check that related weakdep modules are not loaded
   due to being a weakdep.
2) depmod test to check weakdep output.
3) user test to check that configuration files with weakdep are parsed
   correctly and related weakdep modules can be read correctly from user
   applications.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 Makefile.am                                   |   4 +-
 testsuite/.gitignore                          |   3 +
 testsuite/module-playground/Makefile          |   2 +
 testsuite/module-playground/mod-weakdep.c     |  15 +++
 .../lib/modules/4.4.4/correct-modules.weakdep |   2 +
 .../etc/modprobe.d/dumb-weakdep.conf          |   1 +
 .../lib/modules/4.4.4/modules.alias           |   1 +
 .../lib/modules/4.4.4/modules.alias.bin       | Bin 0 -> 12 bytes
 .../modules/4.4.4/modules.builtin.alias.bin   |   0
 .../lib/modules/4.4.4/modules.builtin.bin     |   0
 .../lib/modules/4.4.4/modules.dep             |   3 +
 .../lib/modules/4.4.4/modules.dep.bin         | Bin 0 -> 188 bytes
 .../lib/modules/4.4.4/modules.devname         |   1 +
 .../lib/modules/4.4.4/modules.softdep         |   1 +
 .../lib/modules/4.4.4/modules.symbols         |   3 +
 .../lib/modules/4.4.4/modules.symbols.bin     | Bin 0 -> 78 bytes
 .../lib/modules/4.4.4/modules.weakdep         |   1 +
 .../test-user/correct-weakdep.txt             |   2 +
 .../etc/modprobe.d/dumb-weakdep.conf          |   1 +
 .../test-user/lib/modules/4.4.4/modules.alias |   1 +
 .../lib/modules/4.4.4/modules.alias.bin       | Bin 0 -> 12 bytes
 .../modules/4.4.4/modules.builtin.alias.bin   |   0
 .../lib/modules/4.4.4/modules.builtin.bin     |   0
 .../test-user/lib/modules/4.4.4/modules.dep   |   4 +
 .../lib/modules/4.4.4/modules.dep.bin         | Bin 0 -> 242 bytes
 .../lib/modules/4.4.4/modules.devname         |   0
 .../lib/modules/4.4.4/modules.softdep         |   1 +
 .../lib/modules/4.4.4/modules.symbols         |   3 +
 .../lib/modules/4.4.4/modules.symbols.bin     | Bin 0 -> 78 bytes
 .../lib/modules/4.4.4/modules.weakdep         |   2 +
 testsuite/setup-rootfs.sh                     |   9 ++
 testsuite/test-depmod.c                       |  27 +++++
 testsuite/test-modprobe.c                     |  23 ++++
 testsuite/test-user.c                         | 110 ++++++++++++++++++
 testsuite/testsuite.c                         |  94 +++++++++++++--
 testsuite/testsuite.h                         |   1 +
 36 files changed, 305 insertions(+), 10 deletions(-)
 create mode 100644 testsuite/module-playground/mod-weakdep.c
 create mode 100644 testsuite/rootfs-pristine/test-depmod/check-weakdep/lib/modules/4.4.4/correct-modules.weakdep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/weakdep-loop/etc/modprobe.d/dumb-weakdep.conf
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.builtin.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.symbols.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.weakdep
 create mode 100644 testsuite/rootfs-pristine/test-user/correct-weakdep.txt
 create mode 100644 testsuite/rootfs-pristine/test-user/etc/modprobe.d/dumb-weakdep.conf
 create mode 100644 testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.builtin.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.symbols.bin
 create mode 100644 testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.weakdep
 create mode 100644 testsuite/test-user.c

diff --git a/Makefile.am b/Makefile.am
index e2e2411..4b67ee2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -262,7 +262,7 @@ TESTSUITE = \
 	testsuite/test-modinfo testsuite/test-util testsuite/test-new-module \
 	testsuite/test-modprobe testsuite/test-blacklist \
 	testsuite/test-dependencies testsuite/test-depmod \
-	testsuite/test-list
+	testsuite/test-list testsuite/test-user
 
 check_PROGRAMS = $(TESTSUITE)
 TESTS = $(TESTSUITE)
@@ -305,6 +305,8 @@ testsuite_test_depmod_LDADD = $(TESTSUITE_LDADD)
 testsuite_test_depmod_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
 testsuite_test_list_LDADD = $(TESTSUITE_LDADD)
 testsuite_test_list_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
+testsuite_test_user_LDADD = $(TESTSUITE_LDADD)
+testsuite_test_user_CPPFLAGS = $(TESTSUITE_CPPFLAGS)
 
 testsuite-distclean:
 	$(RM) -r $(ROOTFS)
diff --git a/testsuite/.gitignore b/testsuite/.gitignore
index 5465b1a..56d628e 100644
--- a/testsuite/.gitignore
+++ b/testsuite/.gitignore
@@ -18,6 +18,7 @@
 /test-modprobe
 /test-hash
 /test-list
+/test-user
 /rootfs
 /stamp-rootfs
 /test-scratchbuf.log
@@ -52,3 +53,5 @@
 /test-testsuite.trs
 /test-list.log
 /test-list.trs
+/test-user.log
+/test-user.trs
diff --git a/testsuite/module-playground/Makefile b/testsuite/module-playground/Makefile
index a7ab09b..42c750b 100644
--- a/testsuite/module-playground/Makefile
+++ b/testsuite/module-playground/Makefile
@@ -37,6 +37,8 @@ obj-m += mod-fake-hpsa.o
 obj-m += mod-fake-scsi-mod.o
 obj-m += mod-fake-cciss.o
 
+obj-m += mod-weakdep.o
+
 else
 # only build ARCH-specific module
 ifeq ($(ARCH),)
diff --git a/testsuite/module-playground/mod-weakdep.c b/testsuite/module-playground/mod-weakdep.c
new file mode 100644
index 0000000..d8a9d48
--- /dev/null
+++ b/testsuite/module-playground/mod-weakdep.c
@@ -0,0 +1,15 @@
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+
+static int __init weakdep_init(void)
+{
+	return 0;
+}
+
+module_init(weakdep_init);
+
+MODULE_AUTHOR("Jose Ignacio Tornos Martinez <jtornosm@redhat.com>");
+MODULE_LICENSE("LGPL");
+MODULE_WEAKDEP("mod-simple");
diff --git a/testsuite/rootfs-pristine/test-depmod/check-weakdep/lib/modules/4.4.4/correct-modules.weakdep b/testsuite/rootfs-pristine/test-depmod/check-weakdep/lib/modules/4.4.4/correct-modules.weakdep
new file mode 100644
index 0000000..00777b8
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-depmod/check-weakdep/lib/modules/4.4.4/correct-modules.weakdep
@@ -0,0 +1,2 @@
+# Weak dependencies extracted from modules themselves.
+weakdep mod_weakdep mod-simple
diff --git a/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/etc/modprobe.d/dumb-weakdep.conf b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/etc/modprobe.d/dumb-weakdep.conf
new file mode 100644
index 0000000..181714a
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/etc/modprobe.d/dumb-weakdep.conf
@@ -0,0 +1 @@
+weakdep mod-loop-b mod-loop-a mod-simple
diff --git a/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.alias b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.alias
new file mode 100644
index 0000000..ba76e18
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.alias
@@ -0,0 +1 @@
+# Aliases extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.alias.bin b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.alias.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.builtin.alias.bin b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.builtin.alias.bin
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.builtin.bin b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.builtin.bin
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.dep b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.dep
new file mode 100644
index 0000000..9207182
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.dep
@@ -0,0 +1,3 @@
+kernel/mod-loop-b.ko:
+kernel/mod-loop-a.ko:
+kernel/mod-simple.ko:
diff --git a/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.dep.bin b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.dep.bin
new file mode 100644
index 0000000000000000000000000000000000000000..418d5839a88c95cb08ed24e128ffdb8717ca1504
GIT binary patch
literal 188
zcmdnM{w17&iGfjpfngg10|O%vGi9e1<)!B6=jNyA=H%xW=qBoA=UXYDizWd@fvUk;
z7_muOF#t8kGbAQCFfi}{v3+K4K~5@A2UrUOl9pny49FIS{FHcxoZ<xx46z`E*uVh>
MhMe5o1q=)m03nerJ^%m!

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.devname b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.devname
new file mode 100644
index 0000000..58f6d6d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.devname
@@ -0,0 +1 @@
+# Device nodes to trigger on-demand module loading.
diff --git a/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.softdep b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.softdep
new file mode 100644
index 0000000..5554ccc
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.softdep
@@ -0,0 +1 @@
+# Soft dependencies extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.symbols b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.symbols
new file mode 100644
index 0000000..6c53580
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.symbols
@@ -0,0 +1,3 @@
+# Aliases for symbols, used by symbol_request().
+alias symbol:printB mod_loop_b
+alias symbol:printA mod_loop_a
diff --git a/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.symbols.bin b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.symbols.bin
new file mode 100644
index 0000000000000000000000000000000000000000..27c5f4330c93722f6bab5c7a91601ab58fdda577
GIT binary patch
literal 78
zcmdnM{w17&iGfjpfx&};fq@Z-nR4?};&bxz3*r-jJg^WWTqud5GB+td$Eu(xGp~ff
T(aC{<fd`1?i;EX9Fc<*<pZgLP

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.weakdep b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.weakdep
new file mode 100644
index 0000000..569696d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-modprobe/weakdep-loop/lib/modules/4.4.4/modules.weakdep
@@ -0,0 +1 @@
+# Weak dependencies extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-user/correct-weakdep.txt b/testsuite/rootfs-pristine/test-user/correct-weakdep.txt
new file mode 100644
index 0000000..ac09f8d
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-user/correct-weakdep.txt
@@ -0,0 +1,2 @@
+mod-loop-b: mod_loop_a mod_simple
+mod-weakdep: mod_simple
diff --git a/testsuite/rootfs-pristine/test-user/etc/modprobe.d/dumb-weakdep.conf b/testsuite/rootfs-pristine/test-user/etc/modprobe.d/dumb-weakdep.conf
new file mode 100644
index 0000000..181714a
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-user/etc/modprobe.d/dumb-weakdep.conf
@@ -0,0 +1 @@
+weakdep mod-loop-b mod-loop-a mod-simple
diff --git a/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.alias b/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.alias
new file mode 100644
index 0000000..ba76e18
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.alias
@@ -0,0 +1 @@
+# Aliases extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.alias.bin b/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.alias.bin
new file mode 100644
index 0000000000000000000000000000000000000000..7075435f6268c4d815aec093d61e26647666ba76
GIT binary patch
literal 12
TcmdnM{w17&iGh)Ufq@4A6;A>Z

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.builtin.alias.bin b/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.builtin.alias.bin
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.builtin.bin b/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.builtin.bin
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.dep b/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.dep
new file mode 100644
index 0000000..3ffbd6b
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.dep
@@ -0,0 +1,4 @@
+kernel/mod-weakdep.ko:
+kernel/mod-simple.ko:
+kernel/mod-loop-b.ko:
+kernel/mod-loop-a.ko: kernel/mod-loop-b.ko
diff --git a/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.dep.bin b/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.dep.bin
new file mode 100644
index 0000000000000000000000000000000000000000..70a6e76b79f9a74037dcb00b69fe2555cf022a51
GIT binary patch
literal 242
zcmdnM{w17&iGfjpf#D4U0|O%vGiRq3<)!B6=jNyA=H%xW=qBoA=UXYDizWd@fvUk;
zn6OD&F#t8kGbAQCFfi}{v3+K4K~5@A2UrUul9pny49FIS)WqzR)B>0y1|&u05Gk;#
h{FHcxobm+>46z`U*uVh>h8$#ZAb&z`?g9peZ2%o<Ih+6h

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.devname b/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.devname
new file mode 100644
index 0000000..e69de29
diff --git a/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.softdep b/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.softdep
new file mode 100644
index 0000000..5554ccc
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.softdep
@@ -0,0 +1 @@
+# Soft dependencies extracted from modules themselves.
diff --git a/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.symbols b/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.symbols
new file mode 100644
index 0000000..6c53580
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.symbols
@@ -0,0 +1,3 @@
+# Aliases for symbols, used by symbol_request().
+alias symbol:printB mod_loop_b
+alias symbol:printA mod_loop_a
diff --git a/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.symbols.bin b/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.symbols.bin
new file mode 100644
index 0000000000000000000000000000000000000000..8683b6cb7f60e035be224d97cd560a822e269b1f
GIT binary patch
literal 78
zcmdnM{w17&iGfjpfx&};fq@Z-nRD|~;&bxz3*r-jJg^WGTqud5GB+td$Eu(xGp~ff
T(aC{<fd`1?i;EX9Fc<*<pk5Lf

literal 0
HcmV?d00001

diff --git a/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.weakdep b/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.weakdep
new file mode 100644
index 0000000..00777b8
--- /dev/null
+++ b/testsuite/rootfs-pristine/test-user/lib/modules/4.4.4/modules.weakdep
@@ -0,0 +1,2 @@
+# Weak dependencies extracted from modules themselves.
+weakdep mod_weakdep mod-simple
diff --git a/testsuite/setup-rootfs.sh b/testsuite/setup-rootfs.sh
index 5477c69..f57ef19 100755
--- a/testsuite/setup-rootfs.sh
+++ b/testsuite/setup-rootfs.sh
@@ -68,6 +68,8 @@ map=(
     ["test-depmod/search-order-external-last/lib/modules/external/"]="mod-simple.ko"
     ["test-depmod/search-order-override$MODULE_DIRECTORY/4.4.4/foo/"]="mod-simple.ko"
     ["test-depmod/search-order-override$MODULE_DIRECTORY/4.4.4/override/"]="mod-simple.ko"
+    ["test-depmod/check-weakdep$MODULE_DIRECTORY/4.4.4/kernel/mod-weakdep.ko"]="mod-weakdep.ko"
+    ["test-depmod/check-weakdep$MODULE_DIRECTORY/4.4.4/kernel/mod-simple.ko"]="mod-simple.ko"
     ["test-dependencies$MODULE_DIRECTORY/4.0.20-kmod/kernel/fs/foo/"]="mod-foo-b.ko"
     ["test-dependencies$MODULE_DIRECTORY/4.0.20-kmod/kernel/"]="mod-foo-c.ko"
     ["test-dependencies$MODULE_DIRECTORY/4.0.20-kmod/kernel/lib/"]="mod-foo-a.ko"
@@ -80,6 +82,9 @@ map=(
     ["test-modprobe/show-exports/mod-loop-a.ko"]="mod-loop-a.ko"
     ["test-modprobe/softdep-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-a.ko"]="mod-loop-a.ko"
     ["test-modprobe/softdep-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-b.ko"]="mod-loop-b.ko"
+    ["test-modprobe/weakdep-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-a.ko"]="mod-loop-a.ko"
+    ["test-modprobe/weakdep-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-b.ko"]="mod-loop-b.ko"
+    ["test-modprobe/weakdep-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-simple.ko"]="mod-simple.ko"
     ["test-modprobe/install-cmd-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-a.ko"]="mod-loop-a.ko"
     ["test-modprobe/install-cmd-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-b.ko"]="mod-loop-b.ko"
     ["test-modprobe/force$MODULE_DIRECTORY/4.4.4/kernel/"]="mod-simple.ko"
@@ -103,6 +108,10 @@ map=(
     ["test-modinfo/mod-simple-sha256.ko"]="mod-simple.ko"
     ["test-modinfo/mod-simple-pkcs7.ko"]="mod-simple.ko"
     ["test-modinfo/external/lib/modules/external/mod-simple.ko"]="mod-simple.ko"
+    ["test-user$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-a.ko"]="mod-loop-a.ko"
+    ["test-user$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-b.ko"]="mod-loop-b.ko"
+    ["test-user$MODULE_DIRECTORY/4.4.4/kernel/mod-simple.ko"]="mod-simple.ko"
+    ["test-user$MODULE_DIRECTORY/4.4.4/kernel/mod-weakdep.ko"]="mod-weakdep.ko"
 )
 
 gzip_array=(
diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
index c96dbf0..eaa5b1a 100644
--- a/testsuite/test-depmod.c
+++ b/testsuite/test-depmod.c
@@ -244,4 +244,31 @@ DEFINE_TEST(depmod_search_order_override,
 		},
 	});
 
+#define CHECK_WEAKDEP_ROOTFS TESTSUITE_ROOTFS "test-depmod/check-weakdep"
+#define CHECK_WEAKDEP_LIB_MODULES CHECK_WEAKDEP_ROOTFS MODULE_DIRECTORY "/" MODULES_UNAME
+static noreturn int depmod_check_weakdep(const struct test *t)
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
+DEFINE_TEST(depmod_check_weakdep,
+	.description = "check weakdep output",
+	.config = {
+		[TC_UNAME_R] = MODULES_UNAME,
+		[TC_ROOTFS] = CHECK_WEAKDEP_ROOTFS,
+	},
+	.output = {
+		.files = (const struct keyval[]) {
+			{ CHECK_WEAKDEP_LIB_MODULES "/correct-modules.weakdep",
+			  CHECK_WEAKDEP_LIB_MODULES "/modules.weakdep" },
+			{ }
+		},
+	});
+
 TESTSUITE_MAIN();
diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
index 309f3e3..6a824c9 100644
--- a/testsuite/test-modprobe.c
+++ b/testsuite/test-modprobe.c
@@ -181,6 +181,29 @@ DEFINE_TEST(modprobe_softdep_loop,
 	.modules_loaded = "mod-loop-a,mod-loop-b",
 	);
 
+static noreturn int modprobe_weakdep_loop(const struct test *t)
+{
+	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
+	const char *const args[] = {
+		progname,
+		"mod-loop-b",
+		NULL,
+	};
+
+	test_spawn_prog(progname, args);
+	exit(EXIT_FAILURE);
+}
+DEFINE_TEST(modprobe_weakdep_loop,
+	.description = "check if modprobe breaks weakdep loop",
+	.config = {
+		[TC_UNAME_R] = "4.4.4",
+		[TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/weakdep-loop",
+		[TC_INIT_MODULE_RETCODES] = "",
+	},
+	.modules_loaded = "mod-loop-b",
+	.modules_not_loaded = "mod-loop-a,mod-simple-c",
+	);
+
 static noreturn int modprobe_install_cmd_loop(const struct test *t)
 {
 	const char *progname = ABS_TOP_BUILDDIR "/tools/modprobe";
diff --git a/testsuite/test-user.c b/testsuite/test-user.c
new file mode 100644
index 0000000..f2b789a
--- /dev/null
+++ b/testsuite/test-user.c
@@ -0,0 +1,110 @@
+/*
+ * Copyright Red Hat
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
+#include <inttypes.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <libkmod/libkmod.h>
+
+#include "testsuite.h"
+
+#define TEST_USER_ROOTFS TESTSUITE_ROOTFS "test-user/"
+#define TEST_USER_KERNEL_DIR TEST_USER_ROOTFS "lib/modules/4.4.4/"
+
+static const char *const test_user_config_paths[] = {
+        TEST_USER_ROOTFS "etc/modprobe.d",
+        NULL
+};
+
+static const char *const mod_name[] = {
+	"mod-loop-b",
+	"mod-weakdep",
+	NULL
+};
+
+static int test_user_weakdep(const struct test *t)
+{
+	struct kmod_ctx *ctx;
+	int mod_name_index = 0;
+	int err;
+
+	ctx = kmod_new(TEST_USER_KERNEL_DIR, test_user_config_paths);
+	if (ctx == NULL)
+		exit(EXIT_FAILURE);
+
+	while(mod_name[mod_name_index]) {
+		struct kmod_list *list = NULL;
+		struct kmod_module *mod = NULL;
+		struct kmod_list *mod_list = NULL;
+		struct kmod_list *itr = NULL;
+
+		printf("%s:", mod_name[mod_name_index]);
+		err = kmod_module_new_from_lookup(ctx, mod_name[mod_name_index], &list);
+		if (list == NULL || err < 0) {
+			fprintf(stderr, "module %s not found in directory %s\n",
+				mod_name[mod_name_index],
+				ctx ? kmod_get_dirname(ctx) : "(missing)");
+			exit(EXIT_FAILURE);
+		}
+
+		mod = kmod_module_get_module(list);
+
+		err = kmod_module_get_weakdeps(mod, &mod_list);
+		if (err) {
+			fprintf(stderr, "weak dependencies can not be read for %s (%d)\n",
+				mod_name[mod_name_index], err);
+			exit(EXIT_FAILURE);
+		}
+
+		kmod_list_foreach(itr, mod_list) {
+			struct kmod_module *weakdep_mod = kmod_module_get_module(itr);
+			const char *weakdep_name = kmod_module_get_name(weakdep_mod);
+
+			printf(" %s", weakdep_name);
+			kmod_module_unref(weakdep_mod);
+		}
+		printf("\n");
+
+		kmod_module_unref_list(mod_list);
+		kmod_module_unref(mod);
+		kmod_module_unref_list(list);
+
+		mod_name_index++;
+	}
+
+	kmod_unref(ctx);
+
+        return EXIT_SUCCESS;
+}
+DEFINE_TEST(test_user_weakdep,
+        .description = "check if modprobe breaks weakdep2",
+        .config = {
+                [TC_UNAME_R] = "4.4.4",
+                [TC_ROOTFS] = TESTSUITE_ROOTFS "test-user",
+                [TC_INIT_MODULE_RETCODES] = "",
+        },
+	.need_spawn = true,
+	.output = {
+		.out = TESTSUITE_ROOTFS "test-user/correct-weakdep.txt",
+	});
+
+TESTSUITE_MAIN();
diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
index 318343a..3198524 100644
--- a/testsuite/testsuite.c
+++ b/testsuite/testsuite.c
@@ -772,10 +772,10 @@ static int cmp_modnames(const void *m1, const void *m2)
 }
 
 /*
- * Store the expected module names in buf and return a list of pointers to
- * them.
+ * Auxiliary function to store the module names in buf and return a list
+ * of pointers to them.
  */
-static const char **read_expected_modules(const struct test *t,
+static const char **read_modules(const char* modules,
 		char **buf, int *count)
 {
 	const char **res;
@@ -783,12 +783,8 @@ static const char **read_expected_modules(const struct test *t,
 	int i;
 	char *p;
 
-	if (t->modules_loaded[0] == '\0') {
-		*count = 0;
-		*buf = NULL;
-		return NULL;
-	}
-	*buf = strdup(t->modules_loaded);
+
+	*buf = strdup(modules);
 	if (!*buf) {
 		*count = -1;
 		return NULL;
@@ -816,6 +812,36 @@ static const char **read_expected_modules(const struct test *t,
 	return res;
 }
 
+/*
+ * Store the expected module names in buf and return a list of pointers to
+ * them.
+ */
+static const char **read_expected_modules(const struct test *t,
+		char **buf, int *count)
+{
+	if (t->modules_loaded[0] == '\0') {
+		*count = 0;
+		*buf = NULL;
+		return NULL;
+	}
+	return read_modules(t->modules_loaded, buf, count);
+}
+
+/*
+ * Store the unexpected module names in buf and return a list of pointers to
+ * them.
+ */
+static const char **read_unexpected_modules(const struct test *t,
+		char **buf, int *count)
+{
+	if (t->modules_not_loaded[0] == '\0') {
+		*count = 0;
+		*buf = NULL;
+		return NULL;
+	}
+	return read_modules(t->modules_not_loaded, buf, count);
+}
+
 static char **read_loaded_modules(const struct test *t, char **buf, int *count)
 {
 	char dirname[PATH_MAX];
@@ -930,6 +956,54 @@ out_a1:
 	return err;
 }
 
+static int check_not_loaded_modules(const struct test *t)
+{
+	int l1, l2, i1, i2;
+	const char **a1;
+	char **a2;
+	char *buf1, *buf2;
+	int err = false;
+
+	a1 = read_unexpected_modules(t, &buf1, &l1);
+	if (l1 < 0)
+		return err;
+	a2 = read_loaded_modules(t, &buf2, &l2);
+	if (l2 < 0)
+		goto out_a1;
+	qsort(a1, l1, sizeof(char *), cmp_modnames);
+	qsort(a2, l2, sizeof(char *), cmp_modnames);
+	i1 = i2 = 0;
+	err = true;
+	while (i1 < l1 || i2 < l2) {
+		int cmp;
+
+		if (i1 >= l1)
+			cmp = 1;
+		else if (i2 >= l2)
+			cmp = -1;
+		else
+			cmp = cmp_modnames(&a1[i1], &a2[i2]);
+		if (cmp == 0) {
+			err = false;
+			ERR("module %s loaded\n", a1[i1]);
+			i1++;
+		} else if (cmp < 0) {
+			i1++;
+			i2++;
+		} else  {
+			err = false;
+			ERR("module %s is loaded but should not be\n", a2[i2]);
+			i2++;
+		}
+	}
+	free(a2);
+	free(buf2);
+out_a1:
+	free(a1);
+	free(buf1);
+	return err;
+}
+
 static inline int test_run_parent(const struct test *t, int fdout[2],
 				int fderr[2], int fdmonitor[2], pid_t child)
 {
@@ -994,6 +1068,8 @@ static inline int test_run_parent(const struct test *t, int fdout[2],
 		match_modules = check_loaded_modules(t);
 	else
 		match_modules = true;
+	if (match_modules && t->modules_not_loaded)
+		match_modules = check_not_loaded_modules(t);
 
 	if (t->expected_fail == false) {
 		if (err == 0) {
diff --git a/testsuite/testsuite.h b/testsuite/testsuite.h
index 44d1730..4b2565c 100644
--- a/testsuite/testsuite.h
+++ b/testsuite/testsuite.h
@@ -103,6 +103,7 @@ struct test {
 	} output;
 	/* comma-separated list of loaded modules at the end of the test */
 	const char *modules_loaded;
+	const char *modules_not_loaded;
 	testfunc func;
 	const char *config[_TC_LAST];
 	const char *path;
-- 
2.45.1

