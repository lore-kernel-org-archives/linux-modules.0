Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48236 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbaB0Ww0 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 27 Feb 2014 17:52:26 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id EDD5275014
	for <linux-modules@vger.kernel.org>; Thu, 27 Feb 2014 22:52:24 +0000 (UTC)
From: Michal Marek <mmarek@suse.cz>
To: linux-modules@vger.kernel.org
Subject: [PATCH 0/5] kmod_module_insert_module() cleanup and test coverage
Date: Thu, 27 Feb 2014 23:52:08 +0100
Message-Id: <1393541533-14719-1-git-send-email-mmarek@suse.cz>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

I only wanted to send the kmod_module_insert_module() patch after passing
the testsuite, but then I noticed the testsuite is hardly testing it :).

Michal

Michal Marek (5):
  testsuite: Check the list of loaded modules after a test
  testsuite: Add test for modprobe --force
  testsuite: Do not provide finit_module(2) on older kernels
  Add some tests for kernels without finit_module(2)
  libkmod-module: Simplify kmod_module_insert_module()

 libkmod/libkmod-module.c                           |   27 ++--
 testsuite/init_module.c                            |   25 +++
 .../4.4.4/kernel/drivers/input/mouse/psmouse.ko    |  Bin 0 -> 95649 bytes
 .../force/lib/modules/4.4.4/modules.alias          |    3 +
 .../force/lib/modules/4.4.4/modules.alias.bin      |  Bin 0 -> 101 bytes
 .../force/lib/modules/4.4.4/modules.dep            |    1 +
 .../force/lib/modules/4.4.4/modules.dep.bin        |  Bin 0 -> 72 bytes
 .../force/lib/modules/4.4.4/modules.devname        |    1 +
 .../force/lib/modules/4.4.4/modules.softdep        |    2 +
 .../force/lib/modules/4.4.4/modules.symbols        |    1 +
 .../force/lib/modules/4.4.4/modules.symbols.bin    |  Bin 0 -> 12 bytes
 .../3.3.3/kernel/drivers/input/mouse/psmouse.ko    |  Bin 0 -> 95649 bytes
 .../lib/modules/3.3.3/modules.alias                |    3 +
 .../lib/modules/3.3.3/modules.alias.bin            |  Bin 0 -> 101 bytes
 .../oldkernel-force/lib/modules/3.3.3/modules.dep  |    1 +
 .../lib/modules/3.3.3/modules.dep.bin              |  Bin 0 -> 72 bytes
 .../lib/modules/3.3.3/modules.devname              |    1 +
 .../lib/modules/3.3.3/modules.softdep              |    2 +
 .../lib/modules/3.3.3/modules.symbols              |    1 +
 .../lib/modules/3.3.3/modules.symbols.bin          |  Bin 0 -> 12 bytes
 .../3.3.3/kernel/drivers/input/mouse/psmouse.ko    |  Bin 0 -> 95649 bytes
 .../oldkernel/lib/modules/3.3.3/modules.alias      |    3 +
 .../oldkernel/lib/modules/3.3.3/modules.alias.bin  |  Bin 0 -> 101 bytes
 .../oldkernel/lib/modules/3.3.3/modules.dep        |    1 +
 .../oldkernel/lib/modules/3.3.3/modules.dep.bin    |  Bin 0 -> 72 bytes
 .../oldkernel/lib/modules/3.3.3/modules.devname    |    1 +
 .../oldkernel/lib/modules/3.3.3/modules.softdep    |    2 +
 .../oldkernel/lib/modules/3.3.3/modules.symbols    |    1 +
 .../lib/modules/3.3.3/modules.symbols.bin          |  Bin 0 -> 12 bytes
 testsuite/test-init.c                              |    1 +
 testsuite/test-modprobe.c                          |   82 ++++++++++-
 testsuite/testsuite.c                              |  158 +++++++++++++++++++-
 testsuite/testsuite.h                              |    2 +
 33 files changed, 296 insertions(+), 23 deletions(-)
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/force/lib/modules/4.4.4/kernel/drivers/input/mouse/psmouse.ko
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/force/lib/modules/4.4.4/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/force/lib/modules/4.4.4/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/force/lib/modules/4.4.4/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/force/lib/modules/4.4.4/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/force/lib/modules/4.4.4/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/force/lib/modules/4.4.4/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/force/lib/modules/4.4.4/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/force/lib/modules/4.4.4/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/force/lib/modules/4.4.4/modules.symbols.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/force/proc/modules
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel-force/lib/modules/3.3.3/kernel/drivers/input/mouse/psmouse.ko
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel-force/lib/modules/3.3.3/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel-force/lib/modules/3.3.3/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel-force/lib/modules/3.3.3/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel-force/lib/modules/3.3.3/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel-force/lib/modules/3.3.3/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel-force/lib/modules/3.3.3/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel-force/lib/modules/3.3.3/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel-force/lib/modules/3.3.3/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel-force/lib/modules/3.3.3/modules.symbols.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel-force/proc/modules
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel/lib/modules/3.3.3/kernel/drivers/input/mouse/psmouse.ko
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel/lib/modules/3.3.3/modules.alias
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel/lib/modules/3.3.3/modules.alias.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel/lib/modules/3.3.3/modules.builtin.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel/lib/modules/3.3.3/modules.dep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel/lib/modules/3.3.3/modules.dep.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel/lib/modules/3.3.3/modules.devname
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel/lib/modules/3.3.3/modules.softdep
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel/lib/modules/3.3.3/modules.symbols
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel/lib/modules/3.3.3/modules.symbols.bin
 create mode 100644 testsuite/rootfs-pristine/test-modprobe/oldkernel/proc/modules

-- 
1.7.3.1

