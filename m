Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C262ECAAD3
	for <linux-modules@archiver.kernel.org>; Thu,  1 Sep 2022 15:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiIAP0P (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIAP0O (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 1 Sep 2022 11:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2C424BD5
        for <linux-modules@vger.kernel.org>; Thu,  1 Sep 2022 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662045902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gkJGKge+6uIm46PgUxrIJL/kWjX9EjAB7hcnEhK4b9A=;
        b=f4MRXWcjOnf/sPRzmQDY2F0qh9Kwbn1/gdsyYxHtAFf+KBucfHCYHVAP1Uq/0/VvLcrykj
        9vSKYoNhWGupWiXrkdH2w1DpQiL3W1YYauAG5MNw2LmLjqC9nUeNfHrDImrsM593FP89PX
        g2BueVSGflDWlMH58OWLIRUmuJfIMcw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-605-R82VdR0JOmuutC3fkWnp7w-1; Thu, 01 Sep 2022 11:25:00 -0400
X-MC-Unique: R82VdR0JOmuutC3fkWnp7w-1
Received: by mail-wm1-f72.google.com with SMTP id q10-20020a1ce90a000000b003a60123678aso929277wmc.6
        for <linux-modules@vger.kernel.org>; Thu, 01 Sep 2022 08:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=gkJGKge+6uIm46PgUxrIJL/kWjX9EjAB7hcnEhK4b9A=;
        b=Xu7f3Cp3XPevX0/0Zj4ehU9rLm0cZgrmsQSByvHMsTkQShzkck7VjiPUuosuivgUxG
         Q5KdBI76IYlJQ9DxzvJ/BaukiBvZVueDSJpOg2djw+fT9WEAk7eLJqO+yw/Xao2QlItl
         UxdcdUOF7ewcdfBMkyWmiUltfpfou7pdZ7ZBzNpnzVlqckABBQHlXyBaqVRO80d+vVts
         GOIh6OSTFKlXcTiJEu9HfhB9DQUF/zuRWynQt6GrIabkBzhcy3E2CMRuYeMbN7aSvz19
         s3rjzmlN6apdSX79sPkLiS5Kd0IoZBfYklRbr5Hyh5mst0/LT8lCYUdThFWri97xag2K
         zzXg==
X-Gm-Message-State: ACgBeo0ttCVKWpKJet1lsvXSBEv2A1te34zJb1m8gj3nam0rpuO2V3pP
        cW/6DSD8RIA9K+jgXhG2QgjBPeNTjo57BuMUEXgJ3Co3Wkd3dQgrllHvUJLiw26l9bvzaK4SSwg
        LF3KDLS+BJErM3R3iiyoBbbNK
X-Received: by 2002:a05:6000:100b:b0:226:d51d:8a76 with SMTP id a11-20020a056000100b00b00226d51d8a76mr13300037wrx.257.1662045899744;
        Thu, 01 Sep 2022 08:24:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7D2pBQa6pfEp9i4xzRkLxHK53YKbsNFHMdsRHn9fb5ph5CjPweWQ+Tg0xAgynsLsK19y/A6w==
X-Received: by 2002:a05:6000:100b:b0:226:d51d:8a76 with SMTP id a11-20020a056000100b00b00226d51d8a76mr13300029wrx.257.1662045899488;
        Thu, 01 Sep 2022 08:24:59 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id bd17-20020a05600c1f1100b003a540fef440sm6203845wmb.1.2022.09.01.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:24:55 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     petr.pavlu@suse.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com
Subject: [PATCH v2 modules-next 0/1] module: Add debugfs interface to view unloaded tainted modules
Date:   Thu,  1 Sep 2022 16:24:53 +0100
Message-Id: <20220901152454.2394228-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi Luis,

Changes since v1 [1]:

  - Replaced the use of module_mutex to instead mark
    a RCU read-side critical section (Petr Pavlu)
  - Added __acquires() and __releases() to support
    sparse context checking

[1]: https://lore.kernel.org/lkml/20220823193225.2072649-1-atomlin@redhat.com/


Aaron Tomlin (1):
  module: Add debugfs interface to view unloaded tainted modules

 kernel/module/tracking.c | 68 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)


base-commit: 554694ba120b87e39cf732ed632e6a0c52fafb7c
-- 
2.37.1

