Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57606 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436AbaDDLS5 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Fri, 4 Apr 2014 07:18:57 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id F23C8ABE4
	for <linux-modules@vger.kernel.org>; Fri,  4 Apr 2014 11:18:55 +0000 (UTC)
From: Michal Marek <mmarek@suse.cz>
To: linux-modules@vger.kernel.org
Subject: [PATCH v3 0/3] Fix testsuite without zlib support
Date: Fri,  4 Apr 2014 13:18:47 +0200
Message-Id: <1396610330-16034-1-git-send-email-mmarek@suse.cz>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi,

here is the updated series. To avoid sending too big patch 1/3, I pushed
the branch got git.kernel.org:

The following changes since commit 8240333b257e96e7dc2ac2522f8bb7fb2158fafc:

  config: also parse softdeps from modules (2014-04-01 08:13:54 -0300)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kmod.git testsuite-nocompression3

for you to fetch changes up to 9324bb52f30cb6d0ff2828e1a63056d9c78960a1:

  testsuite: Warn if sysconfdir is not /etc (2014-04-04 13:06:05 +0200)


Michal Marek (3):
  testsuite: Uncompress most modules
  testsuite: Do not run tests with *.ko.gz if zlib is not enabled
  testsuite: Warn if sysconfdir is not /etc

 Makefile.am                                            |   9 ++++++++-
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
 testsuite/test-depmod.c                                |   2 ++
 24 files changed, 15 insertions(+), 7 deletions(-)
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

-- 
1.8.4.5

