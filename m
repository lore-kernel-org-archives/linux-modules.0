Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90971C6FD18
	for <linux-modules@archiver.kernel.org>; Wed, 29 Mar 2023 13:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjC2NwB (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 29 Mar 2023 09:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjC2NwA (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 29 Mar 2023 09:52:00 -0400
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7D510F2
        for <linux-modules@vger.kernel.org>; Wed, 29 Mar 2023 06:51:55 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Wed, 29 Mar 2023 15:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1680097912; bh=aUVktVLlZuNjkalQBGoaKu3i5mHZVbN3KOwOFUsKkIY=;
        h=From:Subject:Date:To:Cc:From;
        b=q2e2j4UOD5RLevQyo0PhwQdDaofrDhSOvzAvtnE5qI1lS6DDhrgcXu2mX8Hic1MCJ
         GtmwTMPu2wCI/TAolp18afpIjUjmoY7AdcG4mkqVsBYIfLQNQ9OSP7Z6rgj6mpQXg1
         26qUB1+x89vKNnW1doVjRUXWolwwDi7aGWKmJhPE=
Received: from island.ads.avm.de (unknown [172.17.88.185])
        by mail-auth.avm.de (Postfix) with ESMTPA id 6CF3E81ECB;
        Wed, 29 Mar 2023 15:51:51 +0200 (CEST)
Received: from island.fjasle.eu (localhost [IPv6:::1])
        by island.ads.avm.de (Postfix) with ESMTP id 65167520027;
        Wed, 29 Mar 2023 15:51:51 +0200 (CEST)
From:   Nicolas Schier <n.schier@avm.de>
Subject: [PATCH v2 0/3] kmod: modprobe: Extend holders removal to
 multi-level dependencies
Date:   Wed, 29 Mar 2023 15:51:34 +0200
Message-Id: <20230309-remove-holders-recursively-v2-0-8a8120269cc1@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGZCJGQC/42NQQqDMBBFryKz7hQTQWlXvUfpYpKMTUANzNiAi
 Hdv7Am6+jw+vLeDsiRWuDc7CJekKS8V7KUBH2l5M6ZQGWxru7Zrbyg858IY8xRYtKL/iKbC04Z
 j3w9jZ9nSEKAKHCmjE1p8PBUz6cpyHjHpmmX7RYup8/zLXwwa9HbwwZHh4MYHlfkaGF7HcXwB2
 4uvu8oAAAA=
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Nicolas Schier <nicolas@fjasle.eu>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=10383; i=n.schier@avm.de;
 h=from:subject:message-id; bh=aUVktVLlZuNjkalQBGoaKu3i5mHZVbN3KOwOFUsKkIY=;
 b=owEBbQKS/ZANAwAIAYjGvJyImm24AcsmYgBkJEJ2ItqVorT3TVRmJjo7kw9t1YRw5e3z5z+bP
 dXSvLpUWmKJAjMEAAEIAB0WIQQO/4WJ63TpgecLpGmIxryciJptuAUCZCRCdgAKCRCIxryciJpt
 uCzGD/9zBpPYzW/2QUmYNWZ+ji0+wqGUDT/9PvuKXHa0IbpXWzMcylyXai1towyUBPsD8oTZTH2
 bRsxeFJeMVrq7xCvCGNKkrs+2UEqLPvv1kSWcrzBQ0LX78LyRUholqFPaos+gh3hmpNMPSCnb/Z
 4B+KQu4e/O5730aoVy3TTFEHJy7+kkT5mg+MEyfct+lB2Y2lnVpwqmHxxdstDGdWS76IBvX7U0D
 jI7JUSo9U8GzVfc0u83jsNYmSV/UCQ2rVexXb7vGV8eyHzN/cTrpcgy09t/l9MuuZlIojWI2xIS
 a34kOIec6NfT4us+m4sdXw9XSQyRsNBT8ZXs/n2G7S2d23KZPbSfvyeyeTJSJbfjkOn/zUEgjR7
 ULmqWydFrQ5VyJWma9eAwN6d8slYgVkXfel/vJUsko+yebCsZsTNJ3KzVCfA5ktu4Ey2yxcp8Ii
 1P5DItL/hrvT2pR2YijDU9WKM7LxwN1HDA+vJ6UbxBPzAoxNSEM68AVuaX+hwfBe94nMIHZJIDI
 J9A83rqk8dsBYOcAi6R9FxiCKyLo6PtpU2CkG5smybb1AJvLqCeuT00Ja0H3k1ujiJ8BzZw47fq
 5GnQpuBo96H6gfWYFbgeCQ7HRB8WLiltW/yqCTebwfu2crYohABDDmDyENWl7T2bmu1w+y1j/wZ
 CRzJJqqOiZdo+Uw==
X-Developer-Key: i=n.schier@avm.de; a=openpgp;
 fpr=7CF67EF8868721AFE53D73FDBDE3A6CC4E333CC8
X-purgate-ID: 149429::1680097912-C2C37ED2-58B11651/0/0
X-purgate-type: clean
X-purgate-size: 10385
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

While commit 42b32d30c38e ("modprobe: Fix holders removal", 2022-03-29) already
implements removing first-level holders, indirect holders were not evaluated.
In a simple module dependency chain like

      module3 depends on module2
      module2 depends on module1

'modprobe -r --remove-holders module1' was only considering module2 and module1
and thus had to fail as module3 was still loaded and blocking removal of
module2.

By doing recursive depth-first removal this can be fixed for such simple
dependency.

(modprobe.8 man page is not touched as it does not yet have anything
about --remove-holders.)

Signed-off-by: Nicolas Schier <n.schier@avm.de>
---
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>

---
Changes in v2:
 * Several fixes (memleak, attempt to remove modules that were just
   removed, --dry-run support)
 * new patch: Add rudimentary implementation of sysfs tree modification
   to delete_module()
 * new patch: Add two tests regarding --remove-holders to
   testsuite/test-modprobe.c
 * Link to v1: https://lore.kernel.org/r/20230309-remove-holders-recursively-v1-1-c27cdba1edbf@avm.de

---
Nicolas Schier (3):
      kmod: modprobe: Remove holders recursively
      testsuite: delete_module: Roughly implement fake-removal in sysfs tree
      testsuite: modprobe: Add test for --remove-holders

 Makefile.am                                        |   1 +
 testsuite/delete_module.c                          | 262 ++++++++++++++++++++-
 testsuite/module-playground/Makefile               |   6 +
 testsuite/module-playground/mod-dep-chain-a.c      |  21 ++
 testsuite/module-playground/mod-dep-chain-b.c      |  22 ++
 testsuite/module-playground/mod-dep-chain-c.c      |  22 ++
 testsuite/module-playground/mod-dep-chain.h        |   8 +
 .../remove-holders/lib/modules/6.2/modules.alias   |   1 +
 .../lib/modules/6.2/modules.alias.bin              | Bin 0 -> 12 bytes
 .../lib/modules/6.2/modules.builtin.alias.bin      |   0
 .../lib/modules/6.2/modules.builtin.bin            |   0
 .../remove-holders/lib/modules/6.2/modules.dep     |   3 +
 .../remove-holders/lib/modules/6.2/modules.dep.bin | Bin 0 -> 229 bytes
 .../remove-holders/lib/modules/6.2/modules.devname |   0
 .../remove-holders/lib/modules/6.2/modules.softdep |   1 +
 .../remove-holders/lib/modules/6.2/modules.symbols |   4 +
 .../lib/modules/6.2/modules.symbols.bin            | Bin 0 -> 143 bytes
 .../test-modprobe/remove-holders/proc/modules      |   3 +
 .../sys/module/mod_dep_chain_a/coresize            |   1 +
 .../module/mod_dep_chain_a/holders/mod_dep_chain_b |   1 +
 .../sys/module/mod_dep_chain_a/initsize            |   1 +
 .../sys/module/mod_dep_chain_a/initstate           |   1 +
 .../sys/module/mod_dep_chain_a/notes/.note.Linux   | Bin 0 -> 60 bytes
 .../mod_dep_chain_a/notes/.note.gnu.build-id       | Bin 0 -> 36 bytes
 .../sys/module/mod_dep_chain_a/refcnt              |   1 +
 .../sections/.gnu.linkonce.this_module             |   1 +
 .../sys/module/mod_dep_chain_a/sections/.init.data |   1 +
 .../module/mod_dep_chain_a/sections/.note.Linux    |   1 +
 .../mod_dep_chain_a/sections/.note.gnu.build-id    |   1 +
 .../module/mod_dep_chain_a/sections/.orc_unwind    |   1 +
 .../module/mod_dep_chain_a/sections/.orc_unwind_ip |   1 +
 .../module/mod_dep_chain_a/sections/.return_sites  |   1 +
 .../module/mod_dep_chain_a/sections/.rodata.str1.1 |   1 +
 .../sys/module/mod_dep_chain_a/sections/.strtab    |   1 +
 .../sys/module/mod_dep_chain_a/sections/.symtab    |   1 +
 .../module/mod_dep_chain_a/sections/.text.unlikely |   1 +
 .../sys/module/mod_dep_chain_a/sections/__kcrctab  |   1 +
 .../sys/module/mod_dep_chain_a/sections/__ksymtab  |   1 +
 .../mod_dep_chain_a/sections/__ksymtab_strings     |   1 +
 .../module/mod_dep_chain_a/sections/__mcount_loc   |   1 +
 .../sys/module/mod_dep_chain_a/taint               |   1 +
 .../sys/module/mod_dep_chain_b/coresize            |   1 +
 .../module/mod_dep_chain_b/holders/mod_dep_chain_c |   1 +
 .../sys/module/mod_dep_chain_b/initsize            |   1 +
 .../sys/module/mod_dep_chain_b/initstate           |   1 +
 .../sys/module/mod_dep_chain_b/notes/.note.Linux   | Bin 0 -> 60 bytes
 .../mod_dep_chain_b/notes/.note.gnu.build-id       | Bin 0 -> 36 bytes
 .../sys/module/mod_dep_chain_b/refcnt              |   1 +
 .../sections/.gnu.linkonce.this_module             |   1 +
 .../sys/module/mod_dep_chain_b/sections/.init.data |   1 +
 .../module/mod_dep_chain_b/sections/.note.Linux    |   1 +
 .../mod_dep_chain_b/sections/.note.gnu.build-id    |   1 +
 .../module/mod_dep_chain_b/sections/.orc_unwind    |   1 +
 .../module/mod_dep_chain_b/sections/.orc_unwind_ip |   1 +
 .../module/mod_dep_chain_b/sections/.return_sites  |   1 +
 .../module/mod_dep_chain_b/sections/.rodata.str1.8 |   1 +
 .../sys/module/mod_dep_chain_b/sections/.strtab    |   1 +
 .../sys/module/mod_dep_chain_b/sections/.symtab    |   1 +
 .../module/mod_dep_chain_b/sections/.text.unlikely |   1 +
 .../sys/module/mod_dep_chain_b/sections/__kcrctab  |   1 +
 .../sys/module/mod_dep_chain_b/sections/__ksymtab  |   1 +
 .../mod_dep_chain_b/sections/__ksymtab_strings     |   1 +
 .../module/mod_dep_chain_b/sections/__mcount_loc   |   1 +
 .../sys/module/mod_dep_chain_b/taint               |   1 +
 .../sys/module/mod_dep_chain_c/coresize            |   1 +
 .../sys/module/mod_dep_chain_c/holders/.gitignore  |   0
 .../sys/module/mod_dep_chain_c/initsize            |   1 +
 .../sys/module/mod_dep_chain_c/initstate           |   1 +
 .../sys/module/mod_dep_chain_c/notes/.note.Linux   | Bin 0 -> 60 bytes
 .../mod_dep_chain_c/notes/.note.gnu.build-id       | Bin 0 -> 36 bytes
 .../sys/module/mod_dep_chain_c/refcnt              |   1 +
 .../sys/module/mod_dep_chain_c/taint               |   1 +
 .../remove-single/lib/modules/6.2/modules.alias    |   1 +
 .../lib/modules/6.2/modules.alias.bin              | Bin 0 -> 12 bytes
 .../lib/modules/6.2/modules.builtin.alias.bin      |   0
 .../lib/modules/6.2/modules.builtin.bin            |   0
 .../remove-single/lib/modules/6.2/modules.dep      |   3 +
 .../remove-single/lib/modules/6.2/modules.dep.bin  | Bin 0 -> 229 bytes
 .../remove-single/lib/modules/6.2/modules.devname  |   0
 .../remove-single/lib/modules/6.2/modules.softdep  |   1 +
 .../remove-single/lib/modules/6.2/modules.symbols  |   4 +
 .../lib/modules/6.2/modules.symbols.bin            | Bin 0 -> 143 bytes
 .../test-modprobe/remove-single/proc/modules       |   3 +
 .../sys/module/mod_dep_chain_a/coresize            |   1 +
 .../module/mod_dep_chain_a/holders/mod_dep_chain_b |   1 +
 .../sys/module/mod_dep_chain_a/initsize            |   1 +
 .../sys/module/mod_dep_chain_a/initstate           |   1 +
 .../sys/module/mod_dep_chain_a/notes/.note.Linux   | Bin 0 -> 60 bytes
 .../mod_dep_chain_a/notes/.note.gnu.build-id       | Bin 0 -> 36 bytes
 .../sys/module/mod_dep_chain_a/refcnt              |   1 +
 .../sections/.gnu.linkonce.this_module             |   1 +
 .../sys/module/mod_dep_chain_a/sections/.init.data |   1 +
 .../module/mod_dep_chain_a/sections/.note.Linux    |   1 +
 .../mod_dep_chain_a/sections/.note.gnu.build-id    |   1 +
 .../module/mod_dep_chain_a/sections/.orc_unwind    |   1 +
 .../module/mod_dep_chain_a/sections/.orc_unwind_ip |   1 +
 .../module/mod_dep_chain_a/sections/.return_sites  |   1 +
 .../module/mod_dep_chain_a/sections/.rodata.str1.1 |   1 +
 .../sys/module/mod_dep_chain_a/sections/.strtab    |   1 +
 .../sys/module/mod_dep_chain_a/sections/.symtab    |   1 +
 .../module/mod_dep_chain_a/sections/.text.unlikely |   1 +
 .../sys/module/mod_dep_chain_a/sections/__kcrctab  |   1 +
 .../sys/module/mod_dep_chain_a/sections/__ksymtab  |   1 +
 .../mod_dep_chain_a/sections/__ksymtab_strings     |   1 +
 .../module/mod_dep_chain_a/sections/__mcount_loc   |   1 +
 .../remove-single/sys/module/mod_dep_chain_a/taint |   1 +
 .../sys/module/mod_dep_chain_b/coresize            |   1 +
 .../module/mod_dep_chain_b/holders/mod_dep_chain_c |   1 +
 .../sys/module/mod_dep_chain_b/initsize            |   1 +
 .../sys/module/mod_dep_chain_b/initstate           |   1 +
 .../sys/module/mod_dep_chain_b/notes/.note.Linux   | Bin 0 -> 60 bytes
 .../mod_dep_chain_b/notes/.note.gnu.build-id       | Bin 0 -> 36 bytes
 .../sys/module/mod_dep_chain_b/refcnt              |   1 +
 .../sections/.gnu.linkonce.this_module             |   1 +
 .../sys/module/mod_dep_chain_b/sections/.init.data |   1 +
 .../module/mod_dep_chain_b/sections/.note.Linux    |   1 +
 .../mod_dep_chain_b/sections/.note.gnu.build-id    |   1 +
 .../module/mod_dep_chain_b/sections/.orc_unwind    |   1 +
 .../module/mod_dep_chain_b/sections/.orc_unwind_ip |   1 +
 .../module/mod_dep_chain_b/sections/.return_sites  |   1 +
 .../module/mod_dep_chain_b/sections/.rodata.str1.8 |   1 +
 .../sys/module/mod_dep_chain_b/sections/.strtab    |   1 +
 .../sys/module/mod_dep_chain_b/sections/.symtab    |   1 +
 .../module/mod_dep_chain_b/sections/.text.unlikely |   1 +
 .../sys/module/mod_dep_chain_b/sections/__kcrctab  |   1 +
 .../sys/module/mod_dep_chain_b/sections/__ksymtab  |   1 +
 .../mod_dep_chain_b/sections/__ksymtab_strings     |   1 +
 .../module/mod_dep_chain_b/sections/__mcount_loc   |   1 +
 .../remove-single/sys/module/mod_dep_chain_b/taint |   1 +
 .../sys/module/mod_dep_chain_c/coresize            |   1 +
 .../sys/module/mod_dep_chain_c/holders/.gitignore  |   0
 .../sys/module/mod_dep_chain_c/initsize            |   1 +
 .../sys/module/mod_dep_chain_c/initstate           |   1 +
 .../sys/module/mod_dep_chain_c/notes/.note.Linux   | Bin 0 -> 60 bytes
 .../mod_dep_chain_c/notes/.note.gnu.build-id       | Bin 0 -> 36 bytes
 .../sys/module/mod_dep_chain_c/refcnt              |   1 +
 .../remove-single/sys/module/mod_dep_chain_c/taint |   1 +
 testsuite/setup-rootfs.sh                          |   3 +
 testsuite/test-modprobe.c                          |  55 +++++
 tools/modprobe.c                                   |  44 +++-
 140 files changed, 551 insertions(+), 11 deletions(-)
---
base-commit: 3d1bd339ab942ea47e60f053f4b11b0c47ff082b
change-id: 20230309-remove-holders-recursively-f667f32e2a7d

Best regards,
-- 
Nicolas Schier

