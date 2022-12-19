Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E90CC4332F
	for <linux-modules@archiver.kernel.org>; Mon, 19 Dec 2022 20:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiLSUqb (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Dec 2022 15:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiLSUq2 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Dec 2022 15:46:28 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DBA1277F
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:46:26 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id s2-20020a056e02216200b0030bc3be69e5so280232ilv.20
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S7UrSOUGP+a8SdpdysICkGiHV2UeH0pTpanyW1FANts=;
        b=awanE9lkV2lS1NwSLmOwByOYf9g/kmku46qRrN0Qko+KTOC8NCLFn939E5b1YSq9iE
         e8I9HjrFjaRH0YufjNA1YtUq9cELaJ/9oNQKRTURdsAHf0fZon3vCt85dCE7CkNfgrjC
         GXtBmi0BQRPJPJkYcQi54sqSOrS4J5dF1RyBWcpQyas9hZUtYOs4UVkV/JtfbIWA2egd
         cvWbTIKloG9IS/l1R1KDWneqFiiJf4OOK/QnHPK1LYTUrkxwjGNgcqRHPCMesXO+htkB
         kQtPISQPX62cnn3pPqXepP2ZWMru0HvYxM01YPdFLwKrtpmjVBJsOC3Ox96baIQSNggn
         BdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7UrSOUGP+a8SdpdysICkGiHV2UeH0pTpanyW1FANts=;
        b=PjNwP79cx8A+Yo7snwZjXooeplWup/YI89jgnwr8211aNW6Su7gwibCBqa8scLvVZM
         sgE5wrhHeAIRW19WSRj6GbsOOkTwdLEQfOSk70IOMKfr18HyZ96AB9SjLKTwa9mlCaRD
         RuS/EXM80+tEbCIcBFhCI6jMyvFTGU9LC62DNi+ip8SdMHrviMGollXGwDr2BPmMonwO
         s9ceZlzcqQY69n/V8rHcDNt8j2TgWGOXJ1WZp2HvDw3PsSEVJDLssTS4oJoaz2pUzbt5
         K2D9wwURoHaCdv0noK8LkE5VNkOwGolld/iyziUD46EJfnEuek/TB2SBKD5/l3XNp93h
         FKOA==
X-Gm-Message-State: AFqh2kp1MRKoXleoLkeB1CmbJgl6SWOd9HUOq4lTUyrj7HO48/tsf9TL
        mmXQs8R1EZfBzc3A/535A2OOSVDiX9F/hTOGWn+OZ50yVvVzr2yN2QpK5e6cWWoc9bFtTrUTks9
        uTzzM0QErI/VN8GepgJc2XJeva5fjFeIRx0pkW7FHJ3SY0qHZtNFxMcQoQqbQBpEsGhp06cTUwv
        LQYII=
X-Google-Smtp-Source: AMrXdXvASLX+bEGK9PqHTbJ1D5tdl6EsQ+ZoWrZiL0X8c3M6xdBh7C7vDHsT1vuh3MKDIJ0/3XEWDcW2a90QzlA=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6e02:ec7:b0:30b:b665:fdc4 with SMTP
 id i7-20020a056e020ec700b0030bb665fdc4mr529287ilk.27.1671482786264; Mon, 19
 Dec 2022 12:46:26 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:46:12 -0600
In-Reply-To: <20221219204619.2205248-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com> <20221219204619.2205248-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219204619.2205248-5-allenwebb@google.com>
Subject: [PATCH v9 04/10] stmpe-spi: Fix typo
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

A small difference in the name supplied to MODULE_DEVICE_TABLE
breaks a future patch set, so fix the typo.

Cc: stable@vger.kernel.org
Fixes: e789995d5c61 ("mfd: Add support for STMPE SPI interface")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Allen Webb <allenwebb@google.com>
---
 drivers/mfd/stmpe-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index ad8055a0e286..6791a5368977 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -129,7 +129,7 @@ static const struct spi_device_id stmpe_spi_id[] = {
 	{ "stmpe2403", STMPE2403 },
 	{ }
 };
-MODULE_DEVICE_TABLE(spi, stmpe_id);
+MODULE_DEVICE_TABLE(spi, stmpe_spi_id);
 
 static struct spi_driver stmpe_spi_driver = {
 	.driver = {
-- 
2.37.3

