Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F117C61DA3
	for <linux-modules@archiver.kernel.org>; Tue, 21 Feb 2023 13:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjBUNTf (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 21 Feb 2023 08:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjBUNTe (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 21 Feb 2023 08:19:34 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A834690
        for <linux-modules@vger.kernel.org>; Tue, 21 Feb 2023 05:19:32 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v3so4326631wrp.2
        for <linux-modules@vger.kernel.org>; Tue, 21 Feb 2023 05:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WDGM6WYCa8vmuROeOh4IMBfBrmiF10MWhaezPThqG9E=;
        b=LrudY0TMHF2mF0HF8Y6ZLYC3mdse49WAwNOv2NAQe+EBKMU2vyr6Csa8EkjZ/ye8bF
         PQO7FNbG2B7+XNN6EdY3DSOXUDROAQj82jWIkbjih0hw/1nb1AGUUXbAPLY1DDa1DsrF
         Ro22G5RZubJiEZUJy0K+rcN6myfQdWAT76ItzjSE2j2q6Y4u6qQCcjPEoDPj5K8kYLZj
         xVfV5k3i+DmXT5wbpoUYsMkGf6na9FbEUHXOIoYdy1NA7q2Zn0iXbcTH971XmkdpyfGR
         mciOYyZknl9sQuzuF3bVgtgIypB1iVEt9Z0yuBaS8r+w75Bd04zvFOhi1+3YQehVVPWJ
         ORBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDGM6WYCa8vmuROeOh4IMBfBrmiF10MWhaezPThqG9E=;
        b=uq06xFHHCshiroIb8IsgtbWUwpyayi1RVNqJgMLeoiIrdsYFPh6+hHtJpzC2p4cQFk
         7g8i4K4cDQo0Mq9JTCWlULOy25OazugIi1AUhTI2uXb5kwKvNWKWnYuQx+bcsrTjXROB
         e5DjFG1leftZA0WpQq0On4vkJYRFoogoEWSrZNpwdETe+lnlNtzHVEtDq6fUKSR2rizt
         DQv30WGtbyEOuDOYJlYdCe2Gh3YX6GW6SuaOpDYjiH6UUz6VzDIrS+Qct1kfME7nqOYR
         R9jBspl7dzbn0bkwiHFR4zjTlv/8ktgEFpV2AayQF0rFBoQWVXbRYH+wAw1f7CdKv8P1
         6qqQ==
X-Gm-Message-State: AO0yUKVBE90KXpchqrMcS9va2A32x+6kMWp0n8T32qkDuPZuXVj7rpRs
        J7Uy5y2gUmb9Xvbn3bIrYhA2tNfsNoY=
X-Google-Smtp-Source: AK7set8DBcnG8R3/2O60rpeauTdZ5BqUpicMmWiP3O2mxOm+Fl/VxswtDVeIeUxAMRbPnRR8mxl7Ag==
X-Received: by 2002:a5d:4ccf:0:b0:2c6:5972:cd13 with SMTP id c15-20020a5d4ccf000000b002c65972cd13mr4973774wrt.26.1676985570940;
        Tue, 21 Feb 2023 05:19:30 -0800 (PST)
Received: from localhost (cpc92308-cmbg19-2-0-cust99.5-4.cable.virginm.net. [82.24.248.100])
        by smtp.gmail.com with UTF8SMTPSA id o18-20020a5d4752000000b002c3f9404c45sm3468267wrs.7.2023.02.21.05.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 05:19:30 -0800 (PST)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     emil.l.velikov@gmail.com
Subject: [PATCH 0/4] kmod: Paper cuts - dead code removal, don't SED manually
Date:   Tue, 21 Feb 2023 13:19:25 +0000
Message-Id: <20230221131929.106951-1-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Greetings everyone,

Here's another, final, round of paper cuts while browsing through the project.

Note that despite the enabled linker garbage collector, the first few cleanup
patches result in detectable improvement in the final binaries.

The last patch, removes the open-coded replacement and by doing so fixes a
genuine bug - albeit one that is uncommon to hit.

As always, feel free to pick any bits that seem suitable.

Thanks
Emil

Emil Velikov (4):
  libkmod: remove unused kmod_module_get_builtin
  libkmod: annotate kmod_builtin_iter API as static
  shared: annotate local API as static
  configure: manage libkmod.pc.in and version.py.in via AC_CONFIG_FILES

 Makefile.am                | 25 ----------------------
 configure.ac               |  2 ++
 libkmod/libkmod-builtin.c  |  8 +++----
 libkmod/libkmod-internal.h |  6 ------
 libkmod/libkmod-module.c   | 43 --------------------------------------
 shared/util.c              |  6 +++---
 shared/util.h              |  3 ---
 7 files changed, 9 insertions(+), 84 deletions(-)

-- 
2.39.2

