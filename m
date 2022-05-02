Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC278C433F5
	for <linux-modules@archiver.kernel.org>; Mon,  2 May 2022 20:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387414AbiEBUym (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 2 May 2022 16:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387404AbiEBUyl (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 2 May 2022 16:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EC66BCB3
        for <linux-modules@vger.kernel.org>; Mon,  2 May 2022 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651524670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0wKFUq13zqQdskdZIBn2gF7koYBC+NMc0iylMNjibNc=;
        b=axvLK0DyPSIaLdh5sDg6g5DBr48OZCtEjJRdiewGTfFlPTw+c5SaBRVuZYGJWRIunXgzlX
        lpeFOzvp8LHQ/WMR2Rz1s1WOFGO19GrUjMavfK211jZqsXt9T1CZkIWSMJfskHjzbWOcrG
        gAB0UK5FJjFQiF7BUJz2hMMJmF1J5Nw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-Q8cwV5fEOD27FLtuuAM-CQ-1; Mon, 02 May 2022 16:51:09 -0400
X-MC-Unique: Q8cwV5fEOD27FLtuuAM-CQ-1
Received: by mail-wm1-f71.google.com with SMTP id p32-20020a05600c1da000b00393fbf9ab6eso222711wms.4
        for <linux-modules@vger.kernel.org>; Mon, 02 May 2022 13:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0wKFUq13zqQdskdZIBn2gF7koYBC+NMc0iylMNjibNc=;
        b=46pgqY9mVBrIoKmEPHSI/0PyIAG8L4yxxEen3QM/yCehiDaz3L1BAXoeVJunqrhx6H
         eV9lBoAriPoLiE/Cgb3B4r6EZnkUm/+eCMGJVxnYMrLaoRbdzhBZp3I1a9bKRAEy0Otw
         rIeMn50hTN60LnGU3PEcQ0Uu4hMuQFLpcKeXtb27J2SzVy/DYRLnnlyANUXRLcfisYJl
         JTmEGYSIxWQG+j3r2iA3LcV2dLF5GhAKU3h+sWpVok54pKJ9IJulOsq5nvCdrD8xAy5X
         7iMtgCOFunGjdciP/gtm2SS0Q1fuOAn1jwB2Z6/N/IynMOlc2O/khB9hEuPQb+/x4mSh
         f8ag==
X-Gm-Message-State: AOAM530txYVdN6654N6oVFb1HHn9LuNFd9l2O9PsuXqsDJP3O47hKyia
        6IHjp57RMpY2e3B3rURK3VEeMFUD3vmMyy50cn9pKM+HQeFtkwY8uqrXms2UR4FNr39HqGbSKkV
        cHUUVjc8vY5yc/s0l23esvGnj
X-Received: by 2002:adf:9dce:0:b0:20a:c019:ad4 with SMTP id q14-20020adf9dce000000b0020ac0190ad4mr10460788wre.591.1651524667448;
        Mon, 02 May 2022 13:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfJnjFTq5nRZ3jJoTJR8UjDqs+6NIt+IXGSzebRJ4J3US39T8mwtOsKafatgXf5/RI0zAlLg==
X-Received: by 2002:adf:9dce:0:b0:20a:c019:ad4 with SMTP id q14-20020adf9dce000000b0020ac0190ad4mr10460775wre.591.1651524667255;
        Mon, 02 May 2022 13:51:07 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l3-20020adfa383000000b0020c5253d8bcsm7802314wrb.8.2022.05.02.13.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 13:51:06 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: [PATCH v5 0/3] module: Introduce module unload taint tracking
Date:   Mon,  2 May 2022 21:51:02 +0100
Message-Id: <20220502205105.919523-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi Luis,

This iteration is still based on the latest mcgrof/modules-next branch.

I have decided still to use RCU even though no entry is ever removed from
the unloaded tainted modules list. That being said, if I understand
correctly, it is not safe in some instances to use 'module_mutex' in
print_modules().  So instead we disable preemption to ensure list traversal
with concurrent list manipulation e.g. list_add_rcu(), is safe too.

Changes since v4 [1]
 - Moved code to kernel/module/tracking.c
   (Luis Chamberlain)
 - Used only strcmp() in try_add_tainted_module()
   (Christophe Leroy)

Changes since v3 [2]
 - Fixed kernel build error reported by kernel test robot i.e. moved
   '#endif' outside 'if (!list_empty(&unloaded_tainted_modules))'
   statement in the context of print_modules()
 - Used strncmp() instead of memcmp()
   (Oleksandr Natalenko)
 - Removed the additional strlen()
   (Christoph Lameter)

Changes since v2 [3]
 - Dropped RFC from subject
 - Removed the newline i.e. "\n" in printk()
 - Always include the tainted module's unload count
 - Unconditionally display each unloaded tainted module

Please let me know your thoughts.

[1]: https://lore.kernel.org/all/20220425090841.3958494-1-atomlin@redhat.com/
[2]: https://lore.kernel.org/all/20220420115257.3498300-1-atomlin@redhat.com/
[3]: https://lore.kernel.org/all/20220419150334.3395019-1-atomlin@redhat.com/


Aaron Tomlin (3):
  module: Make module_flags_taint() accept a module's taints bitmap and
    usable outside core code
  module: Move module_assert_mutex_or_preempt() to internal.h
  module: Introduce module unload taint tracking

 init/Kconfig             | 11 ++++++++
 kernel/module/Makefile   |  1 +
 kernel/module/internal.h | 34 ++++++++++++++++++++++
 kernel/module/main.c     | 24 ++++++----------
 kernel/module/tracking.c | 61 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 116 insertions(+), 15 deletions(-)
 create mode 100644 kernel/module/tracking.c


base-commit: eeaec7801c421e17edda6e45a32d4a5596b633da
-- 
2.34.1

