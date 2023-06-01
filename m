Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C37C77B7A
	for <linux-modules@archiver.kernel.org>; Thu,  1 Jun 2023 22:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjFAWkS (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 1 Jun 2023 18:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjFAWkR (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 1 Jun 2023 18:40:17 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8C412C
        for <linux-modules@vger.kernel.org>; Thu,  1 Jun 2023 15:40:13 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51458187be1so2057504a12.2
        for <linux-modules@vger.kernel.org>; Thu, 01 Jun 2023 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685659211; x=1688251211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rhzebm59EgdBjx+cIsKHCLHGWVLe6lRccxnT0mFxm4A=;
        b=RySMFwY0IbGDSuO7vr69L1MbAI3n9G8+DCsBIf/NjFDh843rwkTuSR5+w3LXJzOpu9
         ZWh+F9CnFucMSqI9Y2E0oNwnZsrA7oDp1q5I1WNM7pKofU+gHGOqbIhIebhTJMX83b+R
         26pWZmNnn+UkMiVAk2W7lQqQ+BaJftzXJ7AlWBzavgMiuNnSvlyWSCIPjOJ8DAhWL+DF
         dQd/Ht+waJIVWkqjZAJuyihfIvdVrx9TFvYtD/P5CZR/dYh8DY2wcEB0U64ithA9UaJY
         Ktxv/e5663AVfvAbgRKwfO1G6u5YndyrXSAOTYm/BOT7TtmZQS3qLNVGcgLbIOD4eZ43
         U3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685659211; x=1688251211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhzebm59EgdBjx+cIsKHCLHGWVLe6lRccxnT0mFxm4A=;
        b=coAhYVd/NIxfwczJWls/8HfBSj+/Pv6sBgKYAud/KFC4VSdYoNcE/zu10SfMhc6L0r
         8sjxqQd9G4A2mTfOeYM8BoEFXfdncq3WhCD5exSuG9IG4cmG+WgeTWJRRYYlmT//wJ4S
         NHAHC7ent5c08dqcqVXrf/rpfifzcIl+TbZ5GJNTCyt+eX8sCgo3gB67ljd5I0kKI1UO
         O6gGv0d6/UmELWWYTwTGuCogcd6k+tvHom8uhNUnp8YZ0wFKJ8FOT0iLgYh3THZYQuzr
         mNrm6ve+7DKD3UIXoxMV6anl0cwabOWdOt9r6Rl/UMFZB1MeTi2NC/KllxPymigLZly6
         Q1kA==
X-Gm-Message-State: AC+VfDxaFxScW6UT0KKuzMB92d8K3jbB9v5sKIJQqdIgYksb1MjmDhrk
        vHwatvo+4hJl8OfzApgfB24YFZT9UnE=
X-Google-Smtp-Source: ACHHUZ5gtvel15CTMDyZCyHQa930Qun5xSbTVEm/8ySp81k6eTLs0f1ZbX3wI1fwIJIhS+QrFtwzVg==
X-Received: by 2002:a17:907:60cd:b0:974:216f:dc36 with SMTP id hv13-20020a17090760cd00b00974216fdc36mr8459762ejc.17.1685659210705;
        Thu, 01 Jun 2023 15:40:10 -0700 (PDT)
Received: from ldmartin-desk2.jf.intel.com ([134.134.137.83])
        by smtp.gmail.com with ESMTPSA id se24-20020a170906ce5800b009662b4230cesm11253318ejb.148.2023.06.01.15.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 15:40:10 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 0/5] libkmod: Use kernel decompression support
Date:   Thu,  1 Jun 2023 15:39:56 -0700
Message-Id: <20230601224001.23397-1-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

When kernel is built with CONFIG_MODULE_DECOMPRESS=y, it can handle 1
algorithm for module decompression with finit_module(). When that
algorithm matches the one used in the module we are trying to load,
prefer using the in-kernel decompression.  This way the kernel can also
apply any additional security measures based on where the module is
coming from.

In future, if the kernel supports more algorithms at a time, libkmod
could even be compiled without them and just let the kernel handle it.
Since it's likely a distro kernel supports all of them, that would
seem a good thing to do (on the other hand, tools like modinfo and
depmod wouldn't be able read the module information).

For zstd, this needs the following fix on the kernel side:
https://lore.kernel.org/linux-modules/ZHkQNQK5zrzo4Cq2@bombadil.infradead.org/

Lucas De Marchi (5):
  libkmod: Do not inititialize file->memory on open
  libkmod: Extract finit_module vs init_module paths
  libkmod: Keep track of compression type
  libkmod: Keep track of in-kernel compression support
  libkmod: Use kernel decompression when available

 libkmod/libkmod-elf.c      |   5 ++
 libkmod/libkmod-file.c     |  46 +++++++++-----
 libkmod/libkmod-internal.h |  13 +++-
 libkmod/libkmod-module.c   | 127 ++++++++++++++++++++++++-------------
 libkmod/libkmod.c          |  42 ++++++++++++
 5 files changed, 170 insertions(+), 63 deletions(-)

-- 
2.40.1

