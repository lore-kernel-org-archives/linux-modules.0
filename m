Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FD0C4332F
	for <linux-modules@archiver.kernel.org>; Fri,  2 Dec 2022 22:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiLBWsM (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 2 Dec 2022 17:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbiLBWsI (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 2 Dec 2022 17:48:08 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD96A6072
        for <linux-modules@vger.kernel.org>; Fri,  2 Dec 2022 14:48:06 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id a11-20020a92c54b000000b003034a80704fso265609ilj.1
        for <linux-modules@vger.kernel.org>; Fri, 02 Dec 2022 14:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0imnhvm+kf10bcAGQciUCVzWuZXXiWmFQ1RsUVVuTw=;
        b=kbarmBE+ReiJB9n4xwMFX3H4tvxZI00hfxXiwLhf0hrlmG2lwDbA8WlcUfypHXN8JJ
         pKIGzmgCvpn4GJpYHfZkUybDRk6PjziKEaJEeWOGiTD5hukxzuNrHEnOhz4BYL1cSmfc
         s7oVuDB3eE/SrF3COCc9IcLXY6Lqd2LcObrC7ANVe1U9JOHadhhqEnNzoNh8DBrR3rpt
         5uOipw2Dbp2B4WqkFoMTrLWl0zvhsSmxwnZK2+s6tKSI4LPU5goCwqmmEYzAc6ala8EK
         e3CPcjBJ7iOAW0Vt7UD+6EiEzQ7vI3kaU/U37HAFbDSy8563dPwaadO26auVwGzPVEMT
         md7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0imnhvm+kf10bcAGQciUCVzWuZXXiWmFQ1RsUVVuTw=;
        b=b26z4kfT5wEveUWTTxatRkfXTRXwCYe8yByO5ntB4hOmIj0QCPyqXIA1bN4oId6ohf
         6zIX2okPq9A8FwB9rA3L8FWmGeoYVccXgi9uJ1LiCJkciIJ3XeFCWr1zYc9IZsbErnL9
         3zTYwNal9mobjRhK2PVzFPmhyBT4uFmz+vq6kjAEnOjPonuICZZwpslkgAKA1SWbK3id
         3RfBX+8tRwNfkbwlZMZ025oAjjZ3JZi5T0Gc9znE1l2XAopsuwp4dMfc606fM4kOp5x6
         0iZ+k6ny0gWiNXO9gnLZJ0J2bcr7xxyruBAH4MhCUlXj26fSGhcZ1g7jzS/DbqQqa6BK
         74yw==
X-Gm-Message-State: ANoB5pkFr1m3jeT9YCoCxsdzank4vpIVZoKIj/05aztpgQU8EtpwbDIE
        DHylQrODMYIE1l1DPaWJKX+KfMIh++PfQjI0+7SkdVKYRE5nX4B0BmSxhne+keeWSlZsHMJWei8
        vtZGRXK3osRhkvJODk+dHb/u+vIroZJEuaUnrGcLscZe0xUNEvKYEenx1h4knVlZbxaTrGcpLJt
        xW3FI=
X-Google-Smtp-Source: AA0mqf6TF+b4GR3uPUIetXie9acj2yjiT18qv25+y5jB+jOCKS4ZBR4GRR5YFcJnHLJASTSAmyHAF+UgGFyjegc=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6638:480a:b0:38a:3357:8a4 with SMTP
 id cp10-20020a056638480a00b0038a335708a4mr18794jab.53.1670021286086; Fri, 02
 Dec 2022 14:48:06 -0800 (PST)
Date:   Fri,  2 Dec 2022 16:47:43 -0600
In-Reply-To: <20221202224744.1447448-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221202224540.1446952-1-allenwebb@google.com> <20221202224744.1447448-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221202224744.1447448-4-allenwebb@google.com>
Subject: [PATCH v6 4/5] docs: Add entry for /sys/module/*/modalias
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Update the documentation to include the modalias sysfs attribute for
modules.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 Documentation/ABI/testing/sysfs-module | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-module b/Documentation/ABI/testing/sysfs-module
index 08886367d0470..1244a0e8d133e 100644
--- a/Documentation/ABI/testing/sysfs-module
+++ b/Documentation/ABI/testing/sysfs-module
@@ -48,6 +48,18 @@ Contact:	Kay Sievers <kay.sievers@vrfy.org>
 Description:	Show the initialization state(live, coming, going) of
 		the module.
 
+What:		/sys/module/*/modalias
+Date:		Nov 2022
+KernelVersion:  6.2
+Contact:	Allen Webb <allenwebb@google.com>
+Description:    Module match-id-based modaliases
+
+                These match against MODALIAS values included in the uevent of
+                devices when they are created. The attribute is implemented for
+                subsystems with the authorized attribute such as USB so
+                userspace can make authorization decisions based on which
+                modules match the device.
+
 What:		/sys/module/*/taint
 Date:		Jan 2012
 KernelVersion:	3.3
-- 
2.37.3

