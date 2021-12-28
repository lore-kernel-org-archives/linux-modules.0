Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DD8C43217
	for <linux-modules@archiver.kernel.org>; Tue, 28 Dec 2021 21:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbhL1Vat (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:30:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237469AbhL1Var (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 28 Dec 2021 16:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640727046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TmPHzOmiJGVn1hY9fDWt3sR60NPPlr53zTWB5QI+n2c=;
        b=U6MtJ/jYHjj5yIZ56Yuv02kSr16VgsIztMRqHt3bLpuVjSv3mNmi8/rrWxdnsqC6GqO8Yu
        PgrWdrVQ2+HyKnSfoNvMik6Rh5fh8kMjIHoY1mmgQAn8PnuiNOHH3owDYW4AtLwYR9zEh4
        XOYCIiZN8RDJeuYHmk+75mWta0HxuVQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-R-1QLqsdPJyc9guEtPbVbQ-1; Tue, 28 Dec 2021 16:30:43 -0500
X-MC-Unique: R-1QLqsdPJyc9guEtPbVbQ-1
Received: by mail-wr1-f71.google.com with SMTP id h12-20020adfa4cc000000b001a22dceda69so4293812wrb.16
        for <linux-modules@vger.kernel.org>; Tue, 28 Dec 2021 13:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmPHzOmiJGVn1hY9fDWt3sR60NPPlr53zTWB5QI+n2c=;
        b=ie/1nG2ckeMJi97QWSnNQwD4TGTBsEE+/ace4vGXqz6yhtBxeKIs+y3iJMGcteb/mR
         wetWVEUuQwXcDLJ8ZMXrJ36JfPoDJse02dgsP60oyB8AzjrTlJuUcch0jwYCFps8eDBf
         WB07nu3lm0EVnj//BqjVPzS+I6IqhXbHnef0TrylYmuNshwI4/Ksl1aYVtgglT+hoHFQ
         ZZiloNhUz6tQnff6MLPJILi50BOHqFRJowh1FHBNdx4ez6bL7qBDB/afMxixOPomKu4j
         qeaQz2CT6Zwgg2J5nQtF/lx3ANWn/HMZ4hkR7dMWFjImMxiSW9lp6Vzwe1j7mYgq5ySr
         NAWg==
X-Gm-Message-State: AOAM531YBdoKt4VZuIZ2Nh4Douap8Wy7qJORHTROus2PTa/uuY8cazfc
        R+cffA9L+SOPiM8T8saPp11WkAhay9USoYajVLmlzQodrpmALonj/95vzCnQ9y6vUmaxGEFsv/m
        b8XAp/IWN0K+m430ijObj1sqV
X-Received: by 2002:a05:600c:1c9f:: with SMTP id k31mr18947008wms.159.1640727042283;
        Tue, 28 Dec 2021 13:30:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/sBfzQCmEJF1DFkeaNfOzI/ZDHKguyW+zTfeINumJYsB9/PKw21OUwgIAYdhdX64aJ8zwuA==
X-Received: by 2002:a05:600c:1c9f:: with SMTP id k31mr18947000wms.159.1640727042133;
        Tue, 28 Dec 2021 13:30:42 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id az15sm18319172wmb.47.2021.12.28.13.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:30:41 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH 00/12] module: core code clean up
Date:   Tue, 28 Dec 2021 21:30:29 +0000
Message-Id: <20211228213041.1356334-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YbKUUJUtjBk/n913@bombadil.infradead.org>
References: <YbKUUJUtjBk/n913@bombadil.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi Luis, Allen,

I had some free time so decided to make a quick start.
There is more outstanding; albeit, I wanted to share what
was accomplished thus far. Unfortunately, nothing has been
thoroughly tested yet. Please let me know your thoughts.


Aaron Tomlin (12):
  module: Move all into module/
  module: Simple refactor in preparation for split
  module: Move livepatch support to a separate file
  module: Move latched RB-tree support to a separate file
  module: Move arch strict rwx support to a separate file
  module: Move strict rwx support to a separate file
  module: Move extra signature support out of core code
  module: Move kmemleak support to a separate file
  module: Move kallsyms support into a separate file
  module: Move procfs support into a separate file
  module: Move sysfs support into a separate file
  module: Move kdb_modules list out of core code

 include/linux/module.h                        |   76 +-
 kernel/Makefile                               |    4 +-
 kernel/debug/kdb/kdb_main.c                   |    5 +
 kernel/module-internal.h                      |   31 -
 kernel/module/Makefile                        |   16 +
 kernel/module/arch_strict_rwx.c               |   44 +
 kernel/module/debug_kmemleak.c                |   30 +
 kernel/module/internal.h                      |  121 ++
 kernel/module/kallsyms.c                      |  506 ++++++
 kernel/module/livepatch.c                     |   75 +
 kernel/{module.c => module/main.c}            | 1616 +----------------
 kernel/module/procfs.c                        |  111 ++
 .../signature.c}                              |    0
 kernel/module/signing.c                       |  120 ++
 kernel/module/strict_rwx.c                    |   83 +
 kernel/module/sysfs.c                         |  426 +++++
 kernel/module/tree_lookup.c                   |  108 ++
 kernel/module_signing.c                       |   45 -
 18 files changed, 1751 insertions(+), 1666 deletions(-)
 delete mode 100644 kernel/module-internal.h
 create mode 100644 kernel/module/Makefile
 create mode 100644 kernel/module/arch_strict_rwx.c
 create mode 100644 kernel/module/debug_kmemleak.c
 create mode 100644 kernel/module/internal.h
 create mode 100644 kernel/module/kallsyms.c
 create mode 100644 kernel/module/livepatch.c
 rename kernel/{module.c => module/main.c} (66%)
 create mode 100644 kernel/module/procfs.c
 rename kernel/{module_signature.c => module/signature.c} (100%)
 create mode 100644 kernel/module/signing.c
 create mode 100644 kernel/module/strict_rwx.c
 create mode 100644 kernel/module/sysfs.c
 create mode 100644 kernel/module/tree_lookup.c
 delete mode 100644 kernel/module_signing.c

-- 
2.31.1

