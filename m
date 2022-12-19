Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA1BC3DA71
	for <linux-modules@archiver.kernel.org>; Mon, 19 Dec 2022 19:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiLSTTJ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Dec 2022 14:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiLSTTB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Dec 2022 14:19:01 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEBB1260E
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 11:19:00 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id e9-20020a056e020b2900b003036757d5caso7109102ilu.10
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 11:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPHDmjOz4kw82vudyh2gpNSeY/P1g0Ll1cHkuMKd04M=;
        b=Hl9NxWeWRbBMNIcYbJvo9h4lOhGhAZEsdPi5MbDF9oJxtlLgXY3/mwkDZQWTaIwfkQ
         uRsDLcZ4I/U1gY4gCmXSISAxWk/Q+4bC9AjBLvXBDAGpdcTe6ZvPzE244kYMz+eA42M7
         wUWTlTn5N9Ycs5PdWjiOwiuS4D24OyLvoF1F0RZuvYaBBxdnihvlB8yySBabO1K/gMER
         IlHNuvhH7i1NM5Zkqc62EZrJphOMVnPQVdcgqbAIpZbhRekeIOeieN7xMd/0cZm4sCYW
         wHN2yrmAvyiCOSq4m09u35HFC2IdBGxzUUkasE0xaZ33SnBQTRz5fBVfqCSpGlQ3qR0I
         8geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPHDmjOz4kw82vudyh2gpNSeY/P1g0Ll1cHkuMKd04M=;
        b=sYb1EvmEeXI+OpNG/WeWfSAVfgIKexwBLM3OInSNW9+Ma5pEF4HxNPxjtd2o+JNtqY
         sPdwyWZIabjlJVhMXhNLW3e22Vvgb83UT5txoKJS4kAFMTzklydqNsJNY2ZvTO7VD8o+
         0SikeAdIyZh6ycYFbLSTZ6RsfGEJN2szLm4DSzcAM5YxNr40V9tZtE78uJ8J472gC5wU
         u/dnK/gpibCQDZ+VuMfpdGh/SUUimdhYX1HsYoWyEGNaTahZyG+WqW2tVrZ+79qjEjpW
         FHaBNj0MuFyig0UdsNKDOwahHm2QtnPnz7epPpZzyYSznPSjs/uBgG8Zi1egtCSEUuFD
         hGpg==
X-Gm-Message-State: ANoB5pkY5LVM+SsL7y7gaO/qDfjI6OjXHrdd3niLOZb/OLN990HBUdr+
        baRxUAQGDWZH4dAZrAUvN8l9NcYuNgFMYCHZStBfTKJeXcvjG9qcs24SqUFWjns8hfwBIQQOjJM
        9/k18y5nGDhcGVPh5GkMKqWAL/MBJSfDxglCYRZ5byANiTpANKPRNztkDhN2AfvUcxcb0aFIgFb
        ovIu8=
X-Google-Smtp-Source: AA0mqf7amPioeMnlA+AUyAIaYb0aW6unNmd1qq3ubnJMOsmcaI05zjSC6BLtBwo3k1pZCRKGf3aTO/JDpU7ONFw=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a02:a117:0:b0:38a:7675:fd26 with SMTP id
 f23-20020a02a117000000b0038a7675fd26mr5696278jag.300.1671477540032; Mon, 19
 Dec 2022 11:19:00 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:18:47 -0600
In-Reply-To: <20221219191855.2010466-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221216221703.294683-1-allenwebb@google.com> <20221219191855.2010466-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219191855.2010466-2-allenwebb@google.com>
Subject: [PATCH v8 1/9] imx: Fix typo
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

A one character difference in the name supplied to MODULE_DEVICE_TABLE
breaks a future patch set, so fix the typo.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Allen Webb <allenwebb@google.com>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 0e3b6ba22f943..344a0a71df14a 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -743,7 +743,7 @@ static const struct of_device_id imx8mp_blk_ctrl_of_match[] = {
 		/* Sentinel */
 	}
 };
-MODULE_DEVICE_TABLE(of, imx8m_blk_ctrl_of_match);
+MODULE_DEVICE_TABLE(of, imx8mp_blk_ctrl_of_match);
 
 static struct platform_driver imx8mp_blk_ctrl_driver = {
 	.probe = imx8mp_blk_ctrl_probe,
-- 
2.37.3

