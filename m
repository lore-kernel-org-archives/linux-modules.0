Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C68C001B2
	for <linux-modules@archiver.kernel.org>; Mon, 19 Dec 2022 20:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiLSUrQ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Dec 2022 15:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiLSUqx (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Dec 2022 15:46:53 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3C913E3C
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:46:34 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id n15-20020a056e021baf00b0030387c2e1d3so7215441ili.5
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffbS/pv8mbkzwi7BuDuXxKBVWgm3Q+ZGzVMRzNeN5+Y=;
        b=nqnUkMASlYpMM28opAhWoAU1NBwY2jEzGkvUjYSnlp7J3g7LFTrfsGOZtIYLEdhmdi
         Nj0kimdtanY+nZdYkSCLG8zQFU5mpiAGqiQ4/RBijOk2L3W2nziZqNXJ7WrHg4TDWzPF
         Y0zsYFU7krvm141/cij+TsvNPr2hxM4hsLciLy3/m5euyiexb3HtGhjQNqBmCnmJGwXf
         MUTgJu5AHfzQ8ShP60lUShV3R5HQAHQcXeXnv2LFkXe7fsBt5cb+gev18+KhxKGr+5kI
         0qXU+ShjEnxk5+V2OJLaQRiEdaCMpClzWMTB2XVgCtuA+SnMmfOOqMTcMe80vuJOW7MK
         SLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffbS/pv8mbkzwi7BuDuXxKBVWgm3Q+ZGzVMRzNeN5+Y=;
        b=IHFphzC3q7CYViwL5qmjyif2MmeZea65rXi6q+sBCwADjE7ndVfv1clQfIqkd70maw
         Dz7BnqSxh+9zz4QercmqhfzJgau9PCW7O75/hRbRIn3cRJiPZiay7l53gMxg5FThJHyZ
         nP5UTgk1Q31a7ZM5yHrFnl4YMNPWpIM1Hicus6w4PqGW7fvFJ9pfmnVv62zYQ6vctGRi
         do85afcXF5wrpFYYX8IQ1Vnv3/qt5VirRkNWm/+cvTZuC1e9W9RSaw1WPhVQCa11AEqY
         dzfb2h1uvS4hwb+LSGcUhAlQzLyzHHYePrhVb+Q+tPUmjjBVdIb4a1Zv0EdiGSnvlLWR
         qFig==
X-Gm-Message-State: ANoB5pmwwpFBXzOscC4iaMSTUPg+nM+0PVcRwav47/YuDk6WEXDxebSI
        BRkIWY7qHb2zDL2RXw6Kbq7sANALrd2pza0lM/VRlVEIPo9/2gSpGUWxw+Bd27xjN5qGMwUiOUC
        oRb/VmRyImMgWkhET3Y2eHl8ayBw99URGfcs1SrF4j6Pv6cFyHs6/pRttNbbj2O77r1MX4JeRA1
        bQutI=
X-Google-Smtp-Source: AA0mqf6QFQzi7P5j2zCWig0dCG28/HaaTm4atHzN0jrf21gACRfqp7XweVAXGEEiRc1oG+wRFR/a6fqA6RDLewo=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a02:2a4c:0:b0:374:3cc9:2b37 with SMTP id
 w73-20020a022a4c000000b003743cc92b37mr44057930jaw.294.1671482793424; Mon, 19
 Dec 2022 12:46:33 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:46:19 -0600
In-Reply-To: <20221219204619.2205248-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com> <20221219204619.2205248-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219204619.2205248-12-allenwebb@google.com>
Subject: [PATCH v9 10/10] Documentation: Include modules.builtin.alias
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

Update the documentation to include the presense and use case of
modules.builtin.alias.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 Documentation/kbuild/kbuild.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 08f575e6236c..1c7c02040a54 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -17,6 +17,12 @@ modules.builtin
 This file lists all modules that are built into the kernel. This is used
 by modprobe to not fail when trying to load something builtin.
 
+modules.builtin.alias
+---------------------
+This file lists all match-id based aliases for modules built into the kernel.
+These are intended to enable userspace to make authorization decisions based
+on which modules are likely to be bound to a device after it is authorized.
+
 modules.builtin.modinfo
 -----------------------
 This file contains modinfo from all modules that are built into the kernel.
-- 
2.37.3

