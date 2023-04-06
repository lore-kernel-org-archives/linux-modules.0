Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A8BC76196
	for <linux-modules@archiver.kernel.org>; Thu,  6 Apr 2023 19:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbjDFTBz (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 6 Apr 2023 15:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240440AbjDFTBc (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 6 Apr 2023 15:01:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B326AD39
        for <linux-modules@vger.kernel.org>; Thu,  6 Apr 2023 12:01:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a25230b000000b00b6871c296bdso39401277ybj.5
        for <linux-modules@vger.kernel.org>; Thu, 06 Apr 2023 12:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680807668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+j5aQ/96ezpNDW1vgfpLxhNNS1dVHH3UOwyvtk8Itw=;
        b=dzEtqbwSdQhApPhmcdODEKLYN82oHMMRmk8B4PyhxAByUq4XPTOH182HpSho2ATXyq
         KgeYBblH+4J9FVR+YQgyEItKH6SG6HgT4e1NbJYPphg4J4Cdw8PrLc+icd1mFFUI/+Ov
         Tg3XjwSVDvcwufsAomanvHBrZnnqOygpEPAMxmyDk2bBGkrfEta4tR9HGcKL/WDrCRhB
         RrAV2bbfnrcdMoo0feXgPMPjKoMMRjOnzJN+dLUHkpowLc01KF8F9hmWFfLsPJ/wDvlP
         DKXRnwqPahyh7FVswOhLr0I6v2HSy3rD2orKYuluaQ2pG6DeT41sTA/0kLY/zB0POi4f
         28eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+j5aQ/96ezpNDW1vgfpLxhNNS1dVHH3UOwyvtk8Itw=;
        b=U5bq6wav19fmnX+9Ag7DQJyIR9zzk6CQrMEIkL5dYocj+52NurGtftEVZSnFMMBGnd
         Xuo3qR3vNV74cDgGCc9OM1XMwW2/pnOpoTToMlWVFG9/7zPcI7FyNMci9qcoo4AjysI+
         zgD9s5NQ/z8bAbjiF/0ZrKQuImtXYl+gFvjF5lYayaMnK+9FKUBvlyZ7yz16rn7qb4O8
         J3cSrqQFe3nVi2b9t6iCcnc1DDusDr5r9i0ONnLBgGY6tZuhqFERaQI+Muyo34Kqfjks
         7bC+uQUufuaZbiwU9dFKDLZZWSN0dFmtH3272voA5CPwvmAkTYcWh6+cXaz99kTSr/Bf
         iRSA==
X-Gm-Message-State: AAQBX9feg0di8hG04kvZtogpcz9V4MPl2YR3mgNtfssLPgBLsIQn6g9j
        ZJhTDb+ioUi5ldJmgpUpYF9ilKVWzRVrvVfhTX8k5UJD+czvA4+tz4Q8x1DlD1dGvljZ+wdawi8
        fTYn1H386L6g35c+pMCfedyJ8J7IVYFv1C0I3sPNVAFqJJabAzi9TrLO4RiK5Pn/XDG6F/M5Q9r
        S0NRE=
X-Google-Smtp-Source: AKy350ZPBPvYArlTUHfBAIsSIdCLRqDyqZwRoWsoQhyrepd+MVYiDIkO59WJizadi3iwpqKF3i7yQRnRE3QGOEQ=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a25:76c6:0:b0:b8b:ee74:c9d4 with SMTP id
 r189-20020a2576c6000000b00b8bee74c9d4mr251123ybc.12.1680807667734; Thu, 06
 Apr 2023 12:01:07 -0700 (PDT)
Date:   Thu,  6 Apr 2023 14:00:29 -0500
In-Reply-To: <20230406190030.968972-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219204619.2205248-1-allenwebb@google.com> <20230406190030.968972-1-allenwebb@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406190030.968972-11-allenwebb@google.com>
Subject: [PATCH v10 10/11] Documentation: Update writing_usb_driver for
 built-in modules
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     gregkh@linuxfoundation.org, mcgrof@kernel.org,
        christophe.leroy@csgroup.eu, nick.alcock@oracle.com,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Built-in modules that set id_table need to set MODULE_DEVICE_TABLE so
update the documentation accordingly.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 Documentation/driver-api/usb/writing_usb_driver.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 95c4f5d14052..5f38e3bd469a 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -128,6 +128,9 @@ single device with a specific vendor and product ID::
     };
     MODULE_DEVICE_TABLE (usb, skel_table);
 
+The ``MODULE_DEVICE_TABLE`` should also be set for built-in USB drivers
+that provide an id_table, so that tools like USBGuard can properly
+associate devices with your driver.
 
 There are other macros that can be used in describing a struct
 :c:type:`usb_device_id` for drivers that support a whole class of USB
-- 
2.39.2

