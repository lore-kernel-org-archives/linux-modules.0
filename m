Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3946C76196
	for <linux-modules@archiver.kernel.org>; Thu,  6 Apr 2023 19:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240552AbjDFTCB (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 6 Apr 2023 15:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240448AbjDFTBc (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 6 Apr 2023 15:01:32 -0400
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD7CAD38
        for <linux-modules@vger.kernel.org>; Thu,  6 Apr 2023 12:01:09 -0700 (PDT)
Received: by mail-io1-xd4a.google.com with SMTP id p128-20020a6b8d86000000b007583ebb18fdso24450053iod.19
        for <linux-modules@vger.kernel.org>; Thu, 06 Apr 2023 12:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680807668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lXaHngygoOShOtLfr1dWwTlpzanuSNfDsA9/IVCyMM4=;
        b=A1qC/ZvuARpF4aifJXh0p0le494sYKU2NUrJtNd2o8ZvihCjDaf3+R7KzU/ysrpbl6
         l4vRFYVToK0UOMs0pZfZJ7KBI+Rl41ceZohihh9yw628OH8pKSweYgOGEyjX53rN+MH3
         u2r5VzZepyIuhRLZEHGDRHYR4Yryg2rfMG46aAd7Jca5I7jedUgP1ewH8NgnLcVyakEp
         F4H5kVYuwj8RvLh0MhgIVykT7rtStfd74mo/DgYwCZTwVY2UqPmjoOLrZ57Eg7pCyh03
         BpB549iKmEZJpj+E0ENtaR6aAv1+3vU3S/3z9qiLV4svNL23ganVPoSrhWkMrbQjfGbE
         QLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXaHngygoOShOtLfr1dWwTlpzanuSNfDsA9/IVCyMM4=;
        b=uhgLxK4CSE66wupwVrAxHBRdYwWc8BY5UPfzZJ6PwMzsrPpv5N8PLrVrUDpZZ5qpeU
         RqEw0y/bDnhnabClNNXTA/WMzaAXojSH+VCD3S/R0JqPcshh0FZUFbumkd0fxV+dnjCC
         YXUCsKKo1b1IOVR9rO5ZR2vz2KC3sZO2Eq4JM2QjtTP3ezJk06FMha36WxRWX+ISQM91
         DPxxtiDBNGJvEt75MBzplxn7KPjqyQGxveCRe5kgaLPi922PucyUiL88hpbyF9aJKZoh
         /H+EIxKpnAzzQLyw4D7AaZmaKYALIPw0khVUT9CBgr6NzJIunYaxZFeNVuP3negmHPG5
         cUZw==
X-Gm-Message-State: AAQBX9cmB7k+Aw8HuGBDN4EVj76omldXBBP3343t+Nr0jZEmiv//70ea
        GUg18JOUVIktELi0a8X9nwpLhx4nbjdC2atU5gLm80a4JN6xV2Z/6c7ltjfsn2lzoOfbKvIXIvB
        gPjKQCd8hv6GNlS8ifkIjZx+a/zx7j7JcZ0lMxvEjQ8teWp4bxk8beDokpQ4BN1cBrSea8P6386
        GEEVg=
X-Google-Smtp-Source: AKy350Y3vePEPTjTofpsZaUJlnNunFT2KZcMeGuMTuCI/IqR0X3Td2aohNhIvplwI6YzX9YZIveMg5tfNSLS/1k=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6e02:d44:b0:326:315:f3d with SMTP id
 h4-20020a056e020d4400b0032603150f3dmr6023365ilj.1.1680807668678; Thu, 06 Apr
 2023 12:01:08 -0700 (PDT)
Date:   Thu,  6 Apr 2023 14:00:30 -0500
In-Reply-To: <20230406190030.968972-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219204619.2205248-1-allenwebb@google.com> <20230406190030.968972-1-allenwebb@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406190030.968972-12-allenwebb@google.com>
Subject: [PATCH v10 11/11] Documentation: add USB authorization document to driver-api
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

There is a user-facing USB authorization document, but it is midding
details a driver should have developer, so add them in a new document.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 .../driver-api/usb/authorization.rst          | 71 +++++++++++++++++++
 Documentation/driver-api/usb/index.rst        |  1 +
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/driver-api/usb/authorization.rst

diff --git a/Documentation/driver-api/usb/authorization.rst b/Documentation/driver-api/usb/authorization.rst
new file mode 100644
index 000000000000..383dcc037a15
--- /dev/null
+++ b/Documentation/driver-api/usb/authorization.rst
@@ -0,0 +1,71 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+Device Authorization
+====================
+
+This document is intended for driver developers. See
+Documentation/usb/authorization.rst if you are looking for how to use
+USB authorization.
+
+Authorization provides userspace a way to allow or block configuring
+devices early during enumeration before any modules are probed for the
+device. While it is possible to block a device by not loading the
+required modules, this also prevents other devices from using the
+module as well. For example someone might have an unattended computer
+downloading installation media to a USB drive. Presumably this computer
+would be locked to make it more difficult for a bad actor to access the
+computer. Since USB storage devices are not needed to interact with the
+lock screen, the authorized_default sysfs attribute can be set to not
+authorize new USB devices by default. A userspace tool like USBGuard
+can then vet the devices. Mice, keyboards, etc can be allowed by
+writing to their authorized sysfs attribute so that the lock screen can
+still be used (this important in cases like suspend+resume or docks)
+while other devices can be blocked as long as the lock screen is shown.
+
+Sysfs Attributes
+================
+
+Userspace can control USB device authorization through the
+authorized_default and authorized sysfs attributes.
+
+authorized_default
+------------------
+
+Defined in ``drivers/usb/core/hcd.c``
+
+The authorized_default sysfs attribute is only present for host
+controllers. It determines the initial state of the authorized sysfs
+attribute of USB devices newly connected to the corresponding host
+controller. It can take on the following values:
+
++---------------------------------------------------+
+| Value | Behavior                                  |
++=======+===========================================+
+|    -1 | Authorize all devices except wireless USB |
++-------+-------------------------------------------+
+|     0 | Do not authorize new devices              |
++-------+-------------------------------------------+
+|     1 | Authorize new devices                     |
++-------+-------------------------------------------+
+|     2 | Authorize new internal devices only       |
++---------------------------------------------------+
+
+Note that firmware platform code determines if a device is internal or
+not and this is reported as the connect_type sysfs attribute of the USB
+port. This is currently supported by ACPI, but device tree still needs
+an implementation. Authorizing new internal devices only can be useful
+to work around issues with devices that misbehave if there are delays
+in probing their module.
+
+authorized
+----------
+
+Defined in ``drivers/usb/core/sysfs.c``
+
+Every USB device has an authorized sysfs attribute which can take the
+values 0 and 1. When authorized is 0, the device still is present in
+sysfs, but none of its interfaces can be associated with drivers and
+modules will not be probed. When authorized is 1 (or set to one) a
+configuration is chosen for the device and its interfaces are
+registered allowing drivers to bind to them.
diff --git a/Documentation/driver-api/usb/index.rst b/Documentation/driver-api/usb/index.rst
index cfa8797ea614..ffe37916f99f 100644
--- a/Documentation/driver-api/usb/index.rst
+++ b/Documentation/driver-api/usb/index.rst
@@ -7,6 +7,7 @@ Linux USB API
    usb
    gadget
    anchors
+   authorization
    bulk-streams
    callbacks
    dma
-- 
2.39.2

