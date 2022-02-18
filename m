Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12538C433FE
	for <linux-modules@archiver.kernel.org>; Fri, 18 Feb 2022 21:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239764AbiBRVZf (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:25:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239762AbiBRVZe (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 18 Feb 2022 16:25:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 284EA4CD53
        for <linux-modules@vger.kernel.org>; Fri, 18 Feb 2022 13:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645219515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8QQHiXtKZc6qfiHodKXWQmnnFzlUO+zklxX1NE5LbNM=;
        b=P/fvWkaipidFZ1O8+AMhKDhFVnNKr0IbA4u7vPHP7myaOmycUrTPakgJXDGkgbJy4561nD
        KwHvDHJyk+F2ueK+xu1hXoU09fJcUbhxDUpmeUrGLoZSSV3nUo0Q688dOGuLfKSGt5R0wv
        0hutZ7tVOlzpzjiS4hW2BHxJ0rFSk0I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-1ZQfFn1bNJGJl8BpTCZU5A-1; Fri, 18 Feb 2022 16:25:14 -0500
X-MC-Unique: 1ZQfFn1bNJGJl8BpTCZU5A-1
Received: by mail-wr1-f70.google.com with SMTP id j8-20020adfc688000000b001e3322ced69so4075666wrg.13
        for <linux-modules@vger.kernel.org>; Fri, 18 Feb 2022 13:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8QQHiXtKZc6qfiHodKXWQmnnFzlUO+zklxX1NE5LbNM=;
        b=C/b3ZpD4PfeY5O29tf+4AQfsKqlRLrD2AqrwSq8OOuZ6J8jVhb2iQkfv8k5xFACib1
         1ExdonsNUX88h9gtgRK0x87hfcPdozxvIkrp8sTZ3R5JzL+FgNseH2Bk+VLZmqG9OuZ6
         4M/2qnD6qBugwnFu4HTGpgjTZg0C11J/k5OQ47hswyBLYkONDeLqeL6bQIncFZEknJpc
         hCRmIwT5fkQmgM/simzeKq0pWnjTRVEO586cFM69lpUQKhjbqlexq1LKRc7LfsQ87A2m
         qBBPHO8KnQplwOqtJW//akjLl3wg2l5FkiVoi+C7ZbRJLPCTT4F3+eZOwZcA15IfkLJ4
         XENg==
X-Gm-Message-State: AOAM533xMQ3fQSFl+eln7mg3GGFO8ONTLeoCW1aUPRjW338z34CGuQvJ
        4DYeDdZV85X61fC+w6HNQEemYFDgXBd7gsqF8H5pqfoqES7QLkHv/jnzg+MnLl/5esK37UaHfWP
        RCOdrDdUc+yejC9qfU+yHCLP+
X-Received: by 2002:a5d:47ce:0:b0:1e8:88b7:446a with SMTP id o14-20020a5d47ce000000b001e888b7446amr7462760wrc.459.1645219512500;
        Fri, 18 Feb 2022 13:25:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyT7nM8df1OjFYTQK+axAfa27dhMHOTeBGj+dcP/J66TJhLgCqXtBNsDeUschFutfR2BXSl0g==
X-Received: by 2002:a5d:47ce:0:b0:1e8:88b7:446a with SMTP id o14-20020a5d47ce000000b001e888b7446amr7462743wrc.459.1645219512207;
        Fri, 18 Feb 2022 13:25:12 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id k34sm488228wms.35.2022.02.18.13.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:25:11 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, joe@perches.com,
        christophe.leroy@csgroup.eu, msuchanek@suse.de,
        oleksandr@natalenko.name
Subject: [PATCH v6 00/13] module: core code clean up
Date:   Fri, 18 Feb 2022 21:24:58 +0000
Message-Id: <20220218212511.887059-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi Luis,

As per your suggestion [1], this is an attempt to refactor and split
optional code out of core module support code into separate components.
This version is based on Linus' commit 7993e65fdd0f ("Merge tag
'mtd/fixes-for-5.17-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux").
Please let me know your thoughts.

Changes since v5 [2]:

 - Updated MAINTAINERS to include the entire kernel/module/ directory
   (Christophe Leroy)
 - Reintroduce commit a97ac8cb24a3 ("module: fix signature check failures
   when using in-kernel decompression") (Michal Suchánek)
 - Refactored code to address some (i.e.
   --ignore=MULTIPLE_ASSIGNMENTS,ASSIGN_IN_IF was used) style violations
   e.g. "Alignment should match open parenthesis", reported by
   scripts/checkpatch.pl --strict (Christophe Leroy)
 - Used PAGE_ALIGN() and PAGE_ALIGNED() instead (Christophe Leroy)
 - Removed sig_enforce from include/linux/module.h as it is only
   used in kernel/module/signing.c (Christophe Leroy)
 - Added static keyword for anything not used outside a source file
   (Christophe Leroy)
 - Moved mod_sysfs_teardown() to kernel/module/sysfs.c (Christophe Leroy)
 - Removed kdb_modules from kernel/debug/kdb/kdb_private.h
   (Christophe Leroy)

Changes since v4 [3]:

 - Moved is_livepatch_module() and set_livepatch_module() to
   kernel/module/livepatch.c
 - Addressed minor compiler warning concerning
   kernel/module/internal.h (0-day)
 - Resolved style violations reported by scripts/checkpatch.pl
 - Dropped patch 5 [4] so external patch [5] can be applied at
   a later date post merge into module-next (Christophe Leroy)

Changes since v3 [6]:

 - Refactored both is_livepatch_module() and set_livepatch_module(),
   respectively, to use IS_ENABLED(CONFIG_LIVEPATCH) (Joe Perches)
 - Addressed various compiler warnings e.g., no previous prototype (0-day)

Changes since v2 [7]:

 - Moved module decompress support to a separate file
 - Made check_modinfo_livepatch() generic (Petr Mladek)
 - Removed filename from each newly created file (Luis Chamberlain)
 - Addressed some (i.e. --ignore=ASSIGN_IN_IF,AVOID_BUG was used)
   minor scripts/checkpatch.pl concerns e.g., use strscpy over
   strlcpy and missing a blank line after declarations (Allen)

Changes since v1 [8]:

  - Moved module version support code into a new file

[1]: https://lore.kernel.org/lkml/YbEZ4HgSYQEPuRmS@bombadil.infradead.org/
[2]: https://lore.kernel.org/lkml/20220209170358.3266629-1-atomlin@redhat.com/
[3]: https://lore.kernel.org/lkml/20220130213214.1042497-1-atomlin@redhat.com/
[4]: https://lore.kernel.org/lkml/20220130213214.1042497-6-atomlin@redhat.com/
[5]: https://lore.kernel.org/lkml/203348805c9ac9851d8939d15cb9802ef047b5e2.1643919758.git.christophe.leroy@csgroup.eu/
[6]: https://lore.kernel.org/lkml/20220128203934.600247-1-atomlin@redhat.com/
[7]: https://lore.kernel.org/lkml/20220106234319.2067842-1-atomlin@redhat.com/
[8]: https://lore.kernel.org/lkml/20211228213041.1356334-1-atomlin@redhat.com/


Aaron Tomlin (13):
  module: Move all into module/
  module: Simple refactor in preparation for split
  module: Make internal.h and decompress.c more compliant
  module: Move livepatch support to a separate file
  module: Move latched RB-tree support to a separate file
  module: Move strict rwx support to a separate file
  module: Move extra signature support out of core code
  module: Move kmemleak support to a separate file
  module: Move kallsyms support into a separate file
  module: Move procfs support into a separate file
  module: Move sysfs support into a separate file
  module: Move kdb_modules list out of core code
  module: Move version support into a separate file

 MAINTAINERS                                   |    2 +-
 include/linux/module.h                        |    9 +-
 kernel/Makefile                               |    5 +-
 kernel/debug/kdb/kdb_main.c                   |    5 +
 kernel/debug/kdb/kdb_private.h                |    4 -
 kernel/module-internal.h                      |   50 -
 kernel/module/Makefile                        |   19 +
 kernel/module/debug_kmemleak.c                |   30 +
 .../decompress.c}                             |    5 +-
 kernel/module/internal.h                      |  284 +++
 kernel/module/kallsyms.c                      |  502 +++++
 kernel/module/livepatch.c                     |   74 +
 kernel/{module.c => module/main.c}            | 1856 +----------------
 kernel/module/procfs.c                        |  142 ++
 .../signature.c}                              |    0
 kernel/module/signing.c                       |  122 ++
 kernel/module/strict_rwx.c                    |   84 +
 kernel/module/sysfs.c                         |  436 ++++
 kernel/module/tree_lookup.c                   |  109 +
 kernel/module/version.c                       |  109 +
 kernel/module_signing.c                       |   45 -
 21 files changed, 2010 insertions(+), 1882 deletions(-)
 delete mode 100644 kernel/module-internal.h
 create mode 100644 kernel/module/Makefile
 create mode 100644 kernel/module/debug_kmemleak.c
 rename kernel/{module_decompress.c => module/decompress.c} (99%)
 create mode 100644 kernel/module/internal.h
 create mode 100644 kernel/module/kallsyms.c
 create mode 100644 kernel/module/livepatch.c
 rename kernel/{module.c => module/main.c} (64%)
 create mode 100644 kernel/module/procfs.c
 rename kernel/{module_signature.c => module/signature.c} (100%)
 create mode 100644 kernel/module/signing.c
 create mode 100644 kernel/module/strict_rwx.c
 create mode 100644 kernel/module/sysfs.c
 create mode 100644 kernel/module/tree_lookup.c
 create mode 100644 kernel/module/version.c
 delete mode 100644 kernel/module_signing.c


base-commit: 7993e65fdd0fe07beb9f36f998f9bbef2c0ee391
-- 
2.34.1

