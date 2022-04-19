Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E024C433EF
	for <linux-modules@archiver.kernel.org>; Tue, 19 Apr 2022 15:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351313AbiDSPG0 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 19 Apr 2022 11:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350687AbiDSPGZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 19 Apr 2022 11:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0EFA387BA
        for <linux-modules@vger.kernel.org>; Tue, 19 Apr 2022 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650380621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wdgc8+Jlkud2HKsKZGyCgaHz11AGlGgnG09+kOT/gAQ=;
        b=ZkFmRkCHwkSjiNy9BSLMsJN4Xo63DKEUyxXh0mUhR/sKZHivZT/vEQeK9PtKzQavEdnS6O
        pUWosNvRSkQsFteZ1NIUFC1E8gOmzZ50ycZTkAIfSRCmMRmzeb0Zjh8rrbRosbKDFtcrCE
        03omAvGelN1pE3hfq4BBHy6u3wqNLmo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-bdCTD4nqP5Kx1fgtYkuF2g-1; Tue, 19 Apr 2022 11:03:38 -0400
X-MC-Unique: bdCTD4nqP5Kx1fgtYkuF2g-1
Received: by mail-wm1-f69.google.com with SMTP id bh11-20020a05600c3d0b00b003928fe7ba07so1344534wmb.6
        for <linux-modules@vger.kernel.org>; Tue, 19 Apr 2022 08:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wdgc8+Jlkud2HKsKZGyCgaHz11AGlGgnG09+kOT/gAQ=;
        b=xQ9QAL+r6hs0tV5ClWdClXzCrl/xiwQS9qoO4M4Wk9dW7m3Zy1k9ZjfCpjwKHh6KT0
         eVHGyTnEsrxWFT0wBg5v2wj/7AdawiN14quvEvSzp+pdKVHACMW8djODv3QwfAFXLe3K
         CIF23DnTXpfW7OjoSZThMyqKK6hlfVz3qqnQq+3C78YN0I2awzqZVVNW/uE6koUTHtwQ
         E3zgBdgzd2+lJcyiOpn5/LovoFqUuOUu+Uewtoy6jQYmXKt5FBQ2ptbGt+RUN7Inbu52
         7TLXWmwe/6xmiY4ZlfoysKiBfQCAkZ7rBWtWElMyDBbK/2BVS3Nhn61isr1x+donSz25
         PzkQ==
X-Gm-Message-State: AOAM5320JxyKbyHd3x7JCCnb7SJLzRjYxhdNjKH43JATLhT8r/WMy8tK
        051/b5L/aOGKBZWxPT/DBkHUp+X2kfTrKrwPnnZK8Ol3IO1CRYw7+pui2dHHrRh3UBl6BtfZeJp
        BiXou2WRLhU1AHMRJfN1Td52B
X-Received: by 2002:a05:600c:1509:b0:38e:d707:90cb with SMTP id b9-20020a05600c150900b0038ed70790cbmr20523222wmg.120.1650380617408;
        Tue, 19 Apr 2022 08:03:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2ziGx3Lw6HBDHRjm2DJbZkMnC5LWN/djK8YHVTkTUf2U4LXgEFhnvzk761V3e1ivfpgFJgg==
X-Received: by 2002:a05:600c:1509:b0:38e:d707:90cb with SMTP id b9-20020a05600c150900b0038ed70790cbmr20523192wmg.120.1650380617153;
        Tue, 19 Apr 2022 08:03:37 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c024700b0038ec0c4a2e7sm19052973wmj.11.2022.04.19.08.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 08:03:35 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH v2 0/2] module: Introduce module unload taint tracking
Date:   Tue, 19 Apr 2022 16:03:32 +0100
Message-Id: <20220419150334.3395019-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi Luis,

This is based on the latest mcgrof/modules-next branch.  I have decided
still to use RCU even though no entry is ever removed from the unloaded
tainted modules list. That being said, if I understand correctly, it is not
safe in some instances to use 'module_mutex' in print_modules(). So instead
we disable preemption to ensure list traversal with concurrent list
manipulation e.g. list_add_rcu(), is safe too.

Please let me know your thoughts.

Aaron Tomlin (2):
  module: Make module_flags_taint() accept a module's taints bitmap
    directly
  module: Introduce module unload taint tracking

 init/Kconfig         | 11 +++++++
 kernel/module/main.c | 76 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 83 insertions(+), 4 deletions(-)


base-commit: eeaec7801c421e17edda6e45a32d4a5596b633da
-- 
2.34.1

