Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57607 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539AbaDDLS5 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Fri, 4 Apr 2014 07:18:57 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 024FDACDE
	for <linux-modules@vger.kernel.org>; Fri,  4 Apr 2014 11:18:56 +0000 (UTC)
From: Michal Marek <mmarek@suse.cz>
To: linux-modules@vger.kernel.org
Subject: [PATCH v3 1/3] testsuite: Uncompress most modules
Date: Fri,  4 Apr 2014 13:18:48 +0200
Message-Id: <1396610330-16034-2-git-send-email-mmarek@suse.cz>
In-Reply-To: <1396610330-16034-1-git-send-email-mmarek@suse.cz>
References: <1396610330-16034-1-git-send-email-mmarek@suse.cz>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Only keep test-depmod/modules-order-compressed to test compressed module
support.
---
 .../lib/modules/4.4.4/correct-modules.dep              |   2 +-
 .../lib/modules/4.4.4/foo/md5.ko                       | Bin 0 -> 6391 bytes
 .../lib/modules/4.4.4/foo/md5.ko.gz                    | Bin 1918 -> 0 bytes
 .../lib/modules/4.4.4/foobar/md5.ko                    | Bin 0 -> 6391 bytes
 .../lib/modules/4.4.4/foobar/md5.ko.gz                 | Bin 1918 -> 0 bytes
 .../lib/modules/4.4.4/correct-modules.dep              |   2 +-
 .../lib/modules/4.4.4/foo/md5.ko                       | Bin 0 -> 6391 bytes
 .../lib/modules/4.4.4/foo/md5.ko.gz                    | Bin 1918 -> 0 bytes
 .../lib/modules/4.4.4/foobar/md5.ko                    | Bin 0 -> 6391 bytes
 .../lib/modules/4.4.4/foobar/md5.ko.gz                 | Bin 1918 -> 0 bytes
 .../lib/modules/4.4.4/correct-modules.dep              |   2 +-
 .../lib/modules/4.4.4/kernel/crypto/md5.ko             | Bin 0 -> 6391 bytes
 .../lib/modules/4.4.4/kernel/crypto/md5.ko.gz          | Bin 1918 -> 0 bytes
 .../lib/modules/4.4.4/updates/md5.ko                   | Bin 0 -> 6391 bytes
 .../lib/modules/4.4.4/updates/md5.ko.gz                | Bin 1918 -> 0 bytes
 .../lib/modules/4.4.4/kernel/sound/core/snd-pcm.ko     | Bin 0 -> 155346 bytes
 .../lib/modules/4.4.4/kernel/sound/core/snd-pcm.ko.gz  | Bin 46263 -> 0 bytes
 .../lib/modules/4.4.4/kernel/sound/core/snd.ko         | Bin 0 -> 131125 bytes
 .../lib/modules/4.4.4/kernel/sound/core/snd.ko.gz      | Bin 38351 -> 0 bytes
 .../install-cmd-loop/lib/modules/4.4.4/modules.dep     |   4 ++--
 .../install-cmd-loop/lib/modules/4.4.4/modules.dep.bin | Bin 137 -> 128 bytes
 .../install-cmd-loop/lib/modules/4.4.4/modules.softdep |   1 -
 22 files changed, 5 insertions(+), 6 deletions(-)
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/foo/md5.ko
 delete mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/foo/md5.ko.gz
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/foobar/md5.ko
 delete mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/foobar/md5.ko.gz
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/foo/md5.ko
 delete mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/foo/md5.ko.gz
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/foobar/md5.ko
 delete mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/foobar/md5.ko.gz
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/kernel/crypto/md5.ko
 delete mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/kernel/crypto/md5.ko.gz
 create mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/updates/md5.ko
 delete mode 100644 testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/updates/md5.ko.gz
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/sound/core/snd-pcm.ko
 delete mode 100644 testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/sound/core/snd-pcm.ko.gz
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/sound/core/snd.ko
 delete mode 100644 testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/sound/core/snd.ko.gz

diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/correct-modules.dep b/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/correct-modules.dep
index 7cac981..a2f216d 100644
--- a/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/correct-modules.dep
+++ b/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/correct-modules.dep
@@ -1 +1 @@
-foobar/md5.ko.gz:
+foobar/md5.ko:
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/foo/md5.ko b/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/foo/md5.ko
new file mode 100644
index 0000000..b568f47
Binary files /dev/null and b/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/foo/md5.ko differ
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/foo/md5.ko.gz b/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/foo/md5.ko.gz
deleted file mode 100644
index cf5ab6d..0000000
Binary files a/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/foo/md5.ko.gz and /dev/null differ
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/foobar/md5.ko b/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/foobar/md5.ko
new file mode 100644
index 0000000..b568f47
Binary files /dev/null and b/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/foobar/md5.ko differ
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/foobar/md5.ko.gz b/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/foobar/md5.ko.gz
deleted file mode 100644
index cf5ab6d..0000000
Binary files a/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix/lib/modules/4.4.4/foobar/md5.ko.gz and /dev/null differ
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/correct-modules.dep b/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/correct-modules.dep
index 346a257..32f0d2a 100644
--- a/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/correct-modules.dep
+++ b/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/correct-modules.dep
@@ -1 +1 @@
-foo/md5.ko.gz:
+foo/md5.ko:
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/foo/md5.ko b/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/foo/md5.ko
new file mode 100644
index 0000000..b568f47
Binary files /dev/null and b/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/foo/md5.ko differ
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/foo/md5.ko.gz b/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/foo/md5.ko.gz
deleted file mode 100644
index cf5ab6d..0000000
Binary files a/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/foo/md5.ko.gz and /dev/null differ
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/foobar/md5.ko b/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/foobar/md5.ko
new file mode 100644
index 0000000..b568f47
Binary files /dev/null and b/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/foobar/md5.ko differ
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/foobar/md5.ko.gz b/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/foobar/md5.ko.gz
deleted file mode 100644
index cf5ab6d..0000000
Binary files a/testsuite/rootfs-pristine/test-depmod/search-order-same-prefix2/lib/modules/4.4.4/foobar/md5.ko.gz and /dev/null differ
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/correct-modules.dep b/testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/correct-modules.dep
index d099dd0..3386e87 100644
--- a/testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/correct-modules.dep
+++ b/testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/correct-modules.dep
@@ -1 +1 @@
-updates/md5.ko.gz:
+updates/md5.ko:
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/kernel/crypto/md5.ko b/testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/kernel/crypto/md5.ko
new file mode 100644
index 0000000..b568f47
Binary files /dev/null and b/testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/kernel/crypto/md5.ko differ
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/kernel/crypto/md5.ko.gz b/testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/kernel/crypto/md5.ko.gz
deleted file mode 100644
index cf5ab6d..0000000
Binary files a/testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/kernel/crypto/md5.ko.gz and /dev/null differ
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/updates/md5.ko b/testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/updates/md5.ko
new file mode 100644
index 0000000..b568f47
Binary files /dev/null and b/testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/updates/md5.ko differ
diff --git a/testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/updates/md5.ko.gz b/testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/updates/md5.ko.gz
deleted file mode 100644
index cf5ab6d..0000000
Binary files a/testsuite/rootfs-pristine/test-depmod/search-order-simple/lib/modules/4.4.4/updates/md5.ko.gz and /dev/null differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/sound/core/snd-pcm.ko b/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/sound/core/snd-pcm.ko
new file mode 100644
index 0000000..4a1dfd1
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/sound/core/snd-pcm.ko differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/sound/core/snd-pcm.ko.gz b/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/sound/core/snd-pcm.ko.gz
deleted file mode 100644
index b149c6a..0000000
Binary files a/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/sound/core/snd-pcm.ko.gz and /dev/null differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/sound/core/snd.ko b/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/sound/core/snd.ko
new file mode 100644
index 0000000..cde0e7f
Binary files /dev/null and b/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/sound/core/snd.ko differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/sound/core/snd.ko.gz b/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/sound/core/snd.ko.gz
deleted file mode 100644
index c7c671d..0000000
Binary files a/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/kernel/sound/core/snd.ko.gz and /dev/null differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/modules.dep b/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/modules.dep
index 518aa59..9203858 100644
--- a/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/modules.dep
+++ b/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/modules.dep
@@ -1,2 +1,2 @@
-kernel/sound/core/snd.ko.gz:
-kernel/sound/core/snd-pcm.ko.gz: kernel/sound/core/snd.ko.gz
+kernel/sound/core/snd.ko:
+kernel/sound/core/snd-pcm.ko: kernel/sound/core/snd.ko
diff --git a/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/modules.dep.bin b/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/modules.dep.bin
index 877ae7b..5a4270a 100644
Binary files a/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/modules.dep.bin and b/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/modules.dep.bin differ
diff --git a/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/modules.softdep b/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/modules.softdep
index 3cc0512..5554ccc 100644
--- a/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/modules.softdep
+++ b/testsuite/rootfs-pristine/test-modprobe/install-cmd-loop/lib/modules/4.4.4/modules.softdep
@@ -1,2 +1 @@
 # Soft dependencies extracted from modules themselves.
-# Copy, with a .conf extension, to /etc/modprobe.d to use it with modprobe.
-- 
1.8.4.5

