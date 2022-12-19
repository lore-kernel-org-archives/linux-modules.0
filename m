Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311DCC4332F
	for <linux-modules@archiver.kernel.org>; Mon, 19 Dec 2022 19:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiLSTTM (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Dec 2022 14:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiLSTTD (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Dec 2022 14:19:03 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF4F12D2E
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 11:19:02 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id i7-20020a056e021b0700b003033a763270so7111413ilv.19
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 11:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OWNuZYCaMdD0VqCL395Kor3n/H1hGaRkxYaUC/R9e30=;
        b=RevcIhrqWVnTCyAyG1KYmPiklVQWXA6oi8x63005w1ZE4ju2L/vacA4mHJ3tzsUG9w
         tm5E52DZ1yKiQv8pr++SD+Rs/mldhfd1d6nlHjOudWQnSdRCzhgib95wcTln9tJ3kCOV
         nGeUsUR+5Jpjs+vcGTPCLqGeHyTnuYy6ssOnebtfbiqypMz1LCoi/zuDJNTwvpDetH7v
         hiZapLh9uGgpwQz708WoD8g3H+Bd3jbX2yfQIs2qyjU2B9q8K63mGE5vwX/1b1TWKFAD
         ggRTtY0Rvl9k6GEbhiURa3jZBTCeNq4aOO+ob4U7EhG7P4rK1sOpl9qhG2jmBzOoGN0R
         /ZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWNuZYCaMdD0VqCL395Kor3n/H1hGaRkxYaUC/R9e30=;
        b=0sscyR9NH5BqhK1xftp+5sr/I0NO3FQNo2i5NzT3uFopLrm+RUaZard3lpdAq41iRq
         nBZz9z3n12sWsc5eCyE7IVz5NG/V0YODbv7UOnkmseGNsIDzU+uSs8xjmtso1+3njH++
         EALkZHzzSzL+S1DaYN0Jlb/19O6SHOXcpMRlR1DLDJZDCwEWYglcfpvlB1Kt9+cpTGkm
         3wn94YDYNQCQCzKEA8i0fKAEenyI2lTZ9ov8sU+3BkVXdvQKgRwR3L/hZpBiTtaGUZqn
         4v5oIzMoTJKpJj5ifcAaEomdvfkcU+zky36bIsctdm67r839+xB+cjuF+X7EuJtsaGHL
         DU3w==
X-Gm-Message-State: ANoB5pmOd5PFmUcUjO6HnBGUadQ4vTTleyRg4RmXUODJ356ld8LskTnb
        QFdlPz5O7EqX6cAtZ2bNhIX2O+/2uLRH7cq2C1oZDjkNaX4ziSn5teslBHs9X5QsnamcDc8gLUU
        czE5xG460MpfJ0GtX8IDvmcovg7AlhQ9+IpsT11nNYMppiVfK/SKsNcCzkwpFPpvxaUd5pWF/A9
        oUimU=
X-Google-Smtp-Source: AA0mqf6anYld01mlT0bgsEUW2E614uK1xY0nfYX11Z7gH5gt8Lz/huRlMVEEPaCK3ttoKX4XoKeMyd/3padWXCE=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a5d:9158:0:b0:6df:b406:273c with SMTP id
 y24-20020a5d9158000000b006dfb406273cmr21977487ioq.110.1671477542105; Mon, 19
 Dec 2022 11:19:02 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:18:49 -0600
In-Reply-To: <20221219191855.2010466-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221216221703.294683-1-allenwebb@google.com> <20221219191855.2010466-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219191855.2010466-4-allenwebb@google.com>
Subject: [PATCH v8 3/9] scsi/BusLogic: Always include device id table
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

A future patch makes use of the device table for built-in modules, so
do not ifdef out the match id table.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Allen Webb <allenwebb@google.com>
---
 drivers/scsi/BusLogic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index f2abffce26599..0c60867c9e7c0 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -3715,7 +3715,6 @@ static void __exit blogic_exit(void)
 
 __setup("BusLogic=", blogic_setup);
 
-#ifdef MODULE
 /*static struct pci_device_id blogic_pci_tbl[] = {
 	{ PCI_VENDOR_ID_BUSLOGIC, PCI_DEVICE_ID_BUSLOGIC_MULTIMASTER,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
@@ -3731,7 +3730,6 @@ static const struct pci_device_id blogic_pci_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_BUSLOGIC, PCI_DEVICE_ID_BUSLOGIC_FLASHPOINT)},
 	{0, },
 };
-#endif
 MODULE_DEVICE_TABLE(pci, blogic_pci_tbl);
 
 module_init(blogic_init);
-- 
2.37.3

