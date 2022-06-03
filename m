Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C53BC43334
	for <linux-modules@archiver.kernel.org>; Fri,  3 Jun 2022 21:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiFCVvG (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiFCVvG (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 3 Jun 2022 17:51:06 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEA857B3E
        for <linux-modules@vger.kernel.org>; Fri,  3 Jun 2022 14:51:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id u4so5224183pgk.11
        for <linux-modules@vger.kernel.org>; Fri, 03 Jun 2022 14:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gm9XbV/gJtsw9Tl6ajMKZcoYQj9zosnQiodHDV8FeRg=;
        b=bgOLCS5x0w37LS0FZnWlgt2/dK8xa7BsgVHVal6kd/iipj3/ZqGngGEdg5XkxoUVkV
         Rvi0l/WcIklCvwCpZ7owPu3cZUTaiyqmXa8plXAeqlJhaIy8wxiYvh5ef0EdWOmr7cgb
         WOsvNBVAqdjRhOlogvZFLKxbFDByofKO6yoiUc82zLuxUx7lPf52WAGaWNrVRSDtEhuG
         hcRJJ3a4LsOUgdHhlrtiqSa/aJPn0aRzpyGyKKz9a3ppgOlCF+7DKjWCSCuJzerpo3eU
         VT+MBvFmCvsk1Y4VDfEKGQMhYjmmwMSV+z9DwtzPQ547XGVyjIIGh8ga/NAOHR6nun97
         PAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gm9XbV/gJtsw9Tl6ajMKZcoYQj9zosnQiodHDV8FeRg=;
        b=sN8BmtwXU07awsV8gUw2vdjFhXZQrrb4NYPGR7L1b66hpJ0z5RkZLdzaopahYFVqQZ
         Tdql0DHzI/4RRVR8XhvYWw0IYkzLFucwOX+eW3Khj01b0BW/WvrqVU7cXvPvlgrIW5fw
         CWMkhCz/vB6IRysGH5ZC/LepXmOgp4O/PEPXY8VqmU7VuRxFarbhUrkmojc6rA//2e1W
         n0XjL1YoaZ2r/t2yhrvh0nWL89ZRT27IGqoJNfuOcM3Qwj4gNEwWPqPGE+5MHUeD5Dyx
         AsXFEZIbtiGhBqlyJqPoWYuLB3jcEGogH/jw67JGO6A3UWzartKNLrfmLbHTVo5etuGt
         oK0Q==
X-Gm-Message-State: AOAM530LBSPPaWikdn9r1BaKq/sDv8BHh1RRe/HOQU0WCdnxsjndnqJn
        4XrGIAzIJxD+ElflMvlHBWr5Nq579vk=
X-Google-Smtp-Source: ABdhPJzc8wVGUuOfeZDjB8on77HeR2BEezj3CICReBbyTf/w3exNG0aHpfWmEexrKXGBfM+xXM+QqQ==
X-Received: by 2002:a63:4f15:0:b0:3fb:fa13:9209 with SMTP id d21-20020a634f15000000b003fbfa139209mr10564920pgb.290.1654293060588;
        Fri, 03 Jun 2022 14:51:00 -0700 (PDT)
Received: from ldmartin-desk2.. ([50.45.187.67])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b00163ffe73300sm6032866plg.137.2022.06.03.14.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 14:51:00 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 0/8] Add --wait to modprobe -r
Date:   Fri,  3 Jun 2022 14:50:39 -0700
Message-Id: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Keep trying to remove the module if it's failing with EAGAIN. This is an
alternative to

v1: https://lore.kernel.org/linux-modules/20210803202417.462197-1-mcgrof@kernel.org/
v2: https://lore.kernel.org/linux-modules/20210810051602.3067384-1-mcgrof@kernel.org/

The v2 above or variand thereof would be probably a better way, but
unfortunately we can't poll the refcnt file in sysfs to get notified
when it reaches 0. The alternative in v1, with sleep(), uses an arbitrary
interval/maximum. It's not something I'm very  confortable to add to the
library side. So, add a quick implementation in modprobe to allow it
to remove the module and wait up until a maximum timeout. Intention is
to later migrate part of the logic in modprobe to libkmod, including for
example the holders removal recently fixed.

Lucas De Marchi (8):
  modprobe: Move -R to "Query options"
  libkmod: Allow to ignore log message on module removal
  module-playground: Add debugfs entry in mod-simple
  util: Add time-related functions from testsuite
  util: Add msec variants for time-related functions
  util: Add exponential backoff sleep
  testsuite: Add tests for sleep calculation
  modprobe: Add --wait

 libkmod/libkmod-module.c                 | 13 ++--
 libkmod/libkmod.h                        |  2 +
 man/modprobe.xml                         | 17 ++++++
 shared/util.c                            | 72 ++++++++++++++++++++++
 shared/util.h                            | 17 ++++++
 testsuite/module-playground/mod-simple.c | 18 +++++-
 testsuite/test-util.c                    | 41 +++++++++++++
 testsuite/testsuite.c                    | 14 +----
 tools/modprobe.c                         | 76 ++++++++++++++++++++----
 9 files changed, 240 insertions(+), 30 deletions(-)

-- 
2.36.1

