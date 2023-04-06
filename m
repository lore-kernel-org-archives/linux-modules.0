Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D6FC7618D
	for <linux-modules@archiver.kernel.org>; Thu,  6 Apr 2023 19:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbjDFTBJ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 6 Apr 2023 15:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240067AbjDFTBF (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 6 Apr 2023 15:01:05 -0400
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA89F93D3
        for <linux-modules@vger.kernel.org>; Thu,  6 Apr 2023 12:01:01 -0700 (PDT)
Received: by mail-il1-x149.google.com with SMTP id d5-20020a923605000000b003232594207dso26428275ila.8
        for <linux-modules@vger.kernel.org>; Thu, 06 Apr 2023 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680807661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIaNzDoEfkQUCUs5a1+ah5UqZ1hq5cACYGIKF90PLWA=;
        b=G+FTw3D1oOQIjnAKB1cpn9CiPMPKCCFM4zdri/XtQJGkhM8ftL306NfOcRuhgBJwAT
         +mqD0LOE5YJzkUY6ePsFoGVjZiuuVZ9E2USexjk/EUU97k0/6RzsAAanDkVOThd1NSb/
         UHy8zFuNtffS3eWlDckeeAT9oCY7xDJSH2ttDYfw5Ys4YqfON7UCSPfniEHkJXIicK5X
         pym1+Tk0FtNI+3SFj6R7I0VHLqY1yU3s7SCpVrnruhY/CbD+oW8s5P5fV208J/K1wmOr
         VQqc6oZ6PtBD6O5hhHqZblnYB84HAIivUECRQzO7E8yY+rSsgFhBq+ttRv64b/8RpqGV
         7E3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIaNzDoEfkQUCUs5a1+ah5UqZ1hq5cACYGIKF90PLWA=;
        b=pUDrNGfmu7SJdNiiJkNbVQ3WsENkIxDMeq1JFwVPNAlBbmXpsAkQZ3fK5RqS5mmVmt
         x2OBs5VS3tSD5n+r1r3+O0tRPk0+n1rSx6WHwODLQEPwBWZBAR6hFlrhb+2bpZ5rgwx4
         Y8cOiPstDAuxSnHrtJt2snPU2VThwkCDpKIt3E70dbYg3lBQ7fZCxKbR1ORmJZlZqs3A
         zyAGGEAoGzKMdLHYyx9LARBkB4WdrmTNcCJnislyegddO3NT7RsnfQuKM43eGRytFVDw
         NBvl5BNGVLCpQ/a4VrhhAzlrbVlwrHZNELkPWj9/b3VvEmA+QmhbwRAZ11sgbe0FcSnP
         WVHg==
X-Gm-Message-State: AAQBX9ftYJAjeg6pm0DBjsDrspVCmC/Iy8rmptvBAwO0zDiYYXBgwKql
        MrLXHBVi1s8oma1zlKXBjHXDKsM77kDM+L4lAOfzAgMZ2+M5zvAqXamgz0kNHptk2j5Ai8ACU9J
        OzkfXqfFac83/cuuq/zb9ep2bsYnCAzQIcgFCBY5UjaUTQ0eV0glzt8usfVJJHJV6F8kCXc+zu6
        qwJ2M=
X-Google-Smtp-Source: AKy350Z+5g/pbGkfqFeQV7zALWCzNXPo9m7bN766vJbNtaAOGFM9jzMpqoRBx0ByEqTie31Zw2uJvsgSxEzqmLQ=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a02:a10c:0:b0:405:8be:eaaa with SMTP id
 f12-20020a02a10c000000b0040508beeaaamr6056313jag.5.1680807660861; Thu, 06 Apr
 2023 12:01:00 -0700 (PDT)
Date:   Thu,  6 Apr 2023 14:00:22 -0500
In-Reply-To: <20230406190030.968972-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219204619.2205248-1-allenwebb@google.com> <20230406190030.968972-1-allenwebb@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406190030.968972-4-allenwebb@google.com>
Subject: [PATCH v10 03/11] stmpe-spi: Fix MODULE_DEVICE_TABLE entries
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

A one character difference in the name supplied to MODULE_DEVICE_TABLE
breaks compilation for STMPE_SPI after built-in modules can generate
match-id based module aliases. Since this wasn't being used before and
builtin aliases aren't needed in this case, remove it.

This was not caught earlier because STMPE_SPI can not be built as a
module and MODULE_DEVICE_TABLE is a no-op for built-in modules.

Fixes: e789995d5c61 ("mfd: Add support for STMPE SPI interface")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202212171140.NB93eVvI-lkp@intel.com/
Signed-off-by: Allen Webb <allenwebb@google.com>
---
 drivers/mfd/stmpe-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index e9cbf33502b3..e9cb6a635472 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -129,7 +129,6 @@ static const struct spi_device_id stmpe_spi_id[] = {
 	{ "stmpe2403", STMPE2403 },
 	{ }
 };
-MODULE_DEVICE_TABLE(spi, stmpe_id);
 
 static struct spi_driver stmpe_spi_driver = {
 	.driver = {
-- 
2.39.2

