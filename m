Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57762 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbaB1MFo (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Fri, 28 Feb 2014 07:05:44 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 823B475016
	for <linux-modules@vger.kernel.org>; Fri, 28 Feb 2014 12:05:43 +0000 (UTC)
From: Michal Marek <mmarek@suse.cz>
To: linux-modules@vger.kernel.org
Subject: [PATCH v2 0/5] kmod_module_insert_module() cleanup and test coverage
Date: Fri, 28 Feb 2014 13:05:27 +0100
Message-Id: <1393589132-16467-1-git-send-email-mmarek@suse.cz>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Changes since v1
1/5: whitespace fixes
     simplify allocations
     report which modules are missing or excess
3/5: removed stray stat() marker

Michal Marek (5):
  testsuite: Check the list of loaded modules after a test
  testsuite: Add test for modprobe --force
  testsuite: Do not provide finit_module(2) on older kernels
  Add some tests for kernels without finit_module(2)
  libkmod-module: Simplify kmod_module_insert_module()

 libkmod/libkmod-module.c                           |  27 ++-
 testsuite/init_module.c                            |  24 +++
 .../4.4.4/kernel/drivers/input/mouse/psmouse.ko    | Bin 0 -> 95649 bytes
 .../force/lib/modules/4.4.4/modules.alias          |   3 +
 .../force/lib/modules/4.4.4/modules.alias.bin      | Bin 0 -> 101 bytes
 .../force/lib/modules/4.4.4/modules.builtin.bin    |   0
 .../force/lib/modules/4.4.4/modules.dep            |   1 +
 .../force/lib/modules/4.4.4/modules.dep.bin        | Bin 0 -> 72 bytes
 .../force/lib/modules/4.4.4/modules.devname        |   1 +
 .../force/lib/modules/4.4.4/modules.softdep        |   2 +
 .../force/lib/modules/4.4.4/modules.symbols        |   1 +
 .../force/lib/modules/4.4.4/modules.symbols.bin    | Bin 0 -> 12 bytes
 .../test-modprobe/force/proc/modules               |   0
 .../3.3.3/kernel/drivers/input/mouse/psmouse.ko    | Bin 0 -> 95649 bytes
 .../lib/modules/3.3.3/modules.alias                |   3 +
 .../lib/modules/3.3.3/modules.alias.bin            | Bin 0 -> 101 bytes
 .../lib/modules/3.3.3/modules.builtin.bin          |   0
 .../oldkernel-force/lib/modules/3.3.3/modules.dep  |   1 +
 .../lib/modules/3.3.3/modules.dep.bin              | Bin 0 -> 72 bytes
 .../lib/modules/3.3.3/modules.devname              |   1 +
 .../lib/modules/3.3.3/modules.softdep              |   2 +
 .../lib/modules/3.3.3/modules.symbols              |   1 +
 .../lib/modules/3.3.3/modules.symbols.bin          | Bin 0 -> 12 bytes
 .../test-modprobe/oldkernel-force/proc/modules     |   0
 .../3.3.3/kernel/drivers/input/mouse/psmouse.ko    | Bin 0 -> 95649 bytes
 .../oldkernel/lib/modules/3.3.3/modules.alias      |   3 +
 .../oldkernel/lib/modules/3.3.3/modules.alias.bin  | Bin 0 -> 101 bytes
 .../lib/modules/3.3.3/modules.builtin.bin          |   0
 .../oldkernel/lib/modules/3.3.3/modules.dep        |   1 +
 .../oldkernel/lib/modules/3.3.3/modules.dep.bin    | Bin 0 -> 72 bytes
 .../oldkernel/lib/modules/3.3.3/modules.devname    |   1 +
 .../oldkernel/lib/modules/3.3.3/modules.softdep    |   2 +
 .../oldkernel/lib/modules/3.3.3/modules.symbols    |   1 +
 .../lib/modules/3.3.3/modules.symbols.bin          | Bin 0 -> 12 bytes
 .../test-modprobe/oldkernel/proc/modules           |   0
 testsuite/test-init.c                              |   1 +
 testsuite/test-modprobe.c                          |  82 ++++++++-
 testsuite/testsuite.c                              | 189 ++++++++++++++++++++-
 testsuite/testsuite.h                              |   2 +
 39 files changed, 326 insertions(+), 23 deletions(-)
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
1.8.4.5

