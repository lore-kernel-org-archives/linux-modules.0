Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16C1C4167B
	for <linux-modules@archiver.kernel.org>; Mon, 19 Dec 2022 20:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiLSUq2 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Dec 2022 15:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiLSUq0 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Dec 2022 15:46:26 -0500
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9655712630
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:46:25 -0800 (PST)
Received: by mail-io1-xd49.google.com with SMTP id s22-20020a6bdc16000000b006e2d7c78010so4619680ioc.21
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UfA/1MB8RCHraPM1ZZUmCBSUNYuUoVh3fP3DF148QbI=;
        b=QMFV2eSAxUPCmTJI+06ooZ3vGoXfoKx9XX7IFkpYAWPmeSDxtIfwAsBfcWJN3ni5CY
         25IOWkIGivPYJA0uHFNBUp35c/G0iYTakt4DY1MuCHflFGzugguEePHY+Vu2CKxLAjFp
         J3ZmBGY6/+5Z4rEPgWVdX1UEwAkvBCZ1G1zuAQu0z+SJiGnK7fTmMyLdgdDm8wi6UGne
         Cdh4YEx0jvHcPTK9u4UIUZmhQzMFoZSwy+SG4IkGOKvNoNrQRrj3FbfeQD7SyJJujU/M
         T9HJPmiiYpy3SNigeHCTqpnQ6orCvOXBTd8k+sG4aeEYDIpL5//nDkDulHNYEviaf3FE
         AUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfA/1MB8RCHraPM1ZZUmCBSUNYuUoVh3fP3DF148QbI=;
        b=S9JpL43o7RpfUcokGYwPaBQzPyh9fTaSXDOaBYjBM8F6tXLShlKQNotreceEQlKb8T
         8WuDSxuPi0dGKbCVT5cOkPPYz7nkImdFy/BKf086KGSdGjyChYLJJStkd7PVMaA3WXZe
         n4cEP5mAjo0nraZ4hcy4O6Q/DYXQ6DxAYtFudqM000p1Z1o92AqTHkiM+r0ewXWOPIFK
         wfPK1phu1XS70BPJ1iu808l1dfQWqfVST40j+J5Q//xQm9fmKYmkFusksVgNCTM/g2UO
         coirlNcjQduq6feviekhskJNppduJiF1UAVKo/zfuB4db+Ll2jYeUvRR9UDMI6pjJU6j
         lQYw==
X-Gm-Message-State: ANoB5pm5fwNUR0Zu5FXF+Ij2u9T7mWDWvjZxMtZINuCcRZ04hWVGQiMN
        +guXq6hw97XvYJA2ffl8fJ7JgWnj/w4wgrVeHGtZ6ak/X+HkjYHmXdQBpBom7oj6Tyhy4/Qa0um
        JRDnLiTuOGAM/1ZGNzMnvyUvxhEdTElahEo3YzuEYzCiGXahJwX029Bkpsn5FhqLh6R8nMFJAml
        E5b70=
X-Google-Smtp-Source: AA0mqf42brmElZpSWauXQ+iaomUsERDxLYbZCYOb5hC0qb/ABxbLEAqvt0k0H8xCEJxKX02bTeR1ahkNBsBOJbU=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a6b:e719:0:b0:6e0:38cf:f538 with SMTP id
 b25-20020a6be719000000b006e038cff538mr6718031ioh.108.1671482784948; Mon, 19
 Dec 2022 12:46:24 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:46:11 -0600
In-Reply-To: <20221219204619.2205248-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com> <20221219204619.2205248-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219204619.2205248-4-allenwebb@google.com>
Subject: [PATCH v9 03/10] scsi/BusLogic: Always include device id table
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
index f2abffce2659..0c60867c9e7c 100644
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

