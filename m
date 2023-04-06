Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA9CC76196
	for <linux-modules@archiver.kernel.org>; Thu,  6 Apr 2023 19:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240067AbjDFTBK (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 6 Apr 2023 15:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240347AbjDFTBE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 6 Apr 2023 15:01:04 -0400
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F2C901C
        for <linux-modules@vger.kernel.org>; Thu,  6 Apr 2023 12:01:00 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id i4-20020a6b5404000000b0075ff3fb6f4cso9375416iob.9
        for <linux-modules@vger.kernel.org>; Thu, 06 Apr 2023 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680807660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=caRdwk2BRQJWlUMku9R1oT1hxRVhqY9kuoHjJ2qZO3g=;
        b=HuY+LMV/FW4ZqSzq5yDbeAtOqVe3PbLdJaq++8RHO6OXQDsm/6mnCfRNuEDUX8rnRu
         LzHICsVuWjfcys0wQIe0hSf7kC/k2Q2GLP+lbAa6rW9vGYZR1HC/9X2OIbnSqopcgcxt
         szfP1syYaS19WUCtCMVmcvO8vcOvnj9DsAgZrsa/BOqVnoK0R4N+YrJcQ9GxnGtju1v9
         N/ddst62vdTXCMn+ZIAe+MCGUwB66nGomYBEICkYLFdOJbLsEApYyZT+t++qABtYxv7s
         0GjANLTFns1opniPJvRxtcQsblzPbgiZg6IX8kdW0O3MVkxywZ0q8kLKSL2Y1/RyfVun
         PKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=caRdwk2BRQJWlUMku9R1oT1hxRVhqY9kuoHjJ2qZO3g=;
        b=ZRVG6VFRZ/SBevXvLoKLj8PBR/06650H8idgDd2l+n6wtehCgiZ3YApZFtvIey8ipc
         ec56HjEork2Sye8oLXBOfA5rDJlzsIyidK46Mrau1KN81ypmx7awwJ507BRtkJvouL3A
         ZxkxH17f/382yBd+xPhFsYJMh2UKRtxDqPnSeWCWbVWCRQVcHAY3rAQfigqzQTbmcY7v
         DdjjXHJcj7fr0wG6jqd47Tx7YcvnCseRO2Vas59oF1b7dJl8I4Gzsd8R9Fk5o/xVg3GM
         YfxVPUHgry11Cl1T4AIDRL2WhRVX3cCTOD49+XIS5cYWKKr2ly/2J4Kg/M/l/4juSG7g
         /ftw==
X-Gm-Message-State: AAQBX9cbQ2/OFcZ0z8Sw/9/ILuQH5XsT0AW2BmUY/CKWE1xB3zUCSdQP
        zsNywqtDZgZGycZL5F8DQRKOdsaRDEbIBHueFlSsVBCCRpV8GLWEXFrgLVDXE5LwFq6NgcTRaA6
        Gci2feIltr8/2ViPnZM+qnK6lgzWoz/ZV/yTaUyVPgW7oPapN/fWe6KI7dSXsO2cKv448DEoywB
        kkgTs=
X-Google-Smtp-Source: AKy350YZuifQDcAImF7FIJpdSl4uI0utqVn+lwF5XQxv4tsCuonBlHCBbuxU7Zq6L46KIXeGCiA3IUpgdFEzMO8=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a02:b181:0:b0:3c5:14ca:58c6 with SMTP id
 t1-20020a02b181000000b003c514ca58c6mr6033175jah.4.1680807659752; Thu, 06 Apr
 2023 12:00:59 -0700 (PDT)
Date:   Thu,  6 Apr 2023 14:00:21 -0500
In-Reply-To: <20230406190030.968972-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219204619.2205248-1-allenwebb@google.com> <20230406190030.968972-1-allenwebb@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406190030.968972-3-allenwebb@google.com>
Subject: [PATCH v10 02/11] scsi/BusLogic: Always include device id table
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     gregkh@linuxfoundation.org, mcgrof@kernel.org,
        christophe.leroy@csgroup.eu, nick.alcock@oracle.com,
        Allen Webb <allenwebb@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

A future patch makes use of the device table for built-in modules, so
do not ifdef out the match id table.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202212171257.0oLypyYS-lkp@intel.com/
Signed-off-by: Allen Webb <allenwebb@google.com>
---
 drivers/scsi/BusLogic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index f7b7ffda1161..79fc8a24e614 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -3713,7 +3713,6 @@ static void __exit blogic_exit(void)
 
 __setup("BusLogic=", blogic_setup);
 
-#ifdef MODULE
 /*static struct pci_device_id blogic_pci_tbl[] = {
 	{ PCI_VENDOR_ID_BUSLOGIC, PCI_DEVICE_ID_BUSLOGIC_MULTIMASTER,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
@@ -3729,7 +3728,6 @@ static const struct pci_device_id blogic_pci_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_BUSLOGIC, PCI_DEVICE_ID_BUSLOGIC_FLASHPOINT)},
 	{0, },
 };
-#endif
 MODULE_DEVICE_TABLE(pci, blogic_pci_tbl);
 
 module_init(blogic_init);
-- 
2.39.2

