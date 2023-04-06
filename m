Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D216C77B6C
	for <linux-modules@archiver.kernel.org>; Thu,  6 Apr 2023 19:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbjDFTBE (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 6 Apr 2023 15:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240067AbjDFTBD (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 6 Apr 2023 15:01:03 -0400
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23134C01
        for <linux-modules@vger.kernel.org>; Thu,  6 Apr 2023 12:00:59 -0700 (PDT)
Received: by mail-io1-xd4a.google.com with SMTP id b2-20020a6bcb02000000b0075e09ef5a2eso10771265iog.13
        for <linux-modules@vger.kernel.org>; Thu, 06 Apr 2023 12:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680807659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eGQLnr57manA7/d3sSj7CWvU90h1ejgPAAwZbA4W80Y=;
        b=E1XOP1CaY8koFy3ME6her9rJ9Nke8XHAoAVsqLpY3lPsNoEYGcrpUF5PF5gHdN47bK
         NGSiShp2xcYg0DXa0KIabY1O37FSpfutYwWTjtRVrU9oHpeB9FGTYAd99a4F1/6Y8FZn
         AbnD5SAV+TZ0GjZP3RdKVI6rqFp6OB//JibKTs1ZBw4TBgjK4lD7u+6bQxjHMtj/gsBd
         BKNR9Uz/lHv1iRy4b6qhPk1HwfMVdk/ucdXhOaul/MyfX6WSdjJGRwtYds3NlIxOeBAy
         hYI94iBkFDpAsYZMS2B43djCX50lmE22kkHDNV9FYiOmAE1uw+MDpJDDPPsBmoU8NICk
         6/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGQLnr57manA7/d3sSj7CWvU90h1ejgPAAwZbA4W80Y=;
        b=MozvE1aIrEoslUzPnVNNo8cz7wYyeOondfdsFYzFrs+to2iFGhQrmNREz6Vxue7hSC
         xNpIh8wMGyqihxE2qfHkDmbHuvklFmamKLxSHAeuWGdwI3DUtCpJjrv0Pb6Da8oFHFJ3
         rERZ9NviHRER4aPraUlBEz8pW1TrKMyAUWobFU6pukjx0ovd7fHzW/Qg+GBgfHqRV994
         JcvNdT3UeAY1ZdhU4WYRy1V3RN4gNv9MEd88faoRo/fPJ5Bzqv7hdXaoe8oimwlyEAGh
         syu9ROXRPNhD+4g8129wHIq5ECk50XFW4pwdo4HmF5YUnzMw/dBZWAjsCiodN0s2X0c1
         eCiQ==
X-Gm-Message-State: AAQBX9dKpPTkvRb6dyzCzjy8qaBmuCE6jE9KuJmIK/Mu+f0fJS53iSwc
        G7E96R0W186vWE4GEEvWFmTWZcFwO1XEKEr3OMQeTLcIUrpdfjSU4Yi1e8bhLLPlcMv28biNLW1
        hRKcJq9KMKBVVuuJ3R719MjK2gfUiBqn7ShMvwJJP/jgWWS8V80V5CHE41hDNraCHOIIlY6T3ni
        jP3r8=
X-Google-Smtp-Source: AKy350bXUyOdQnwpKnTh5pwn2Z58BJIiX3qb6NKTnyLlDlV/PWR/2NVrpWvh92/1KkRXzxoRshzXEZc+XwdEVcY=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a92:1a49:0:b0:315:8f6c:50a6 with SMTP id
 z9-20020a921a49000000b003158f6c50a6mr6481064ill.1.1680807658940; Thu, 06 Apr
 2023 12:00:58 -0700 (PDT)
Date:   Thu,  6 Apr 2023 14:00:20 -0500
In-Reply-To: <20230406190030.968972-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219204619.2205248-1-allenwebb@google.com> <20230406190030.968972-1-allenwebb@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406190030.968972-2-allenwebb@google.com>
Subject: [PATCH v10 01/11] rockchip-mailbox: Remove unneeded MODULE_DEVICE_TABLE
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
breaks compilation for ROCKCHIP_MBOX after built-in modules can
generate match-id based module aliases. Since this wasn't being used
before and builtin aliases aren't needed in this case, remove it.

This was not caught earlier because ROCKCHIP_MBOX can not be built as a
module and MODULE_DEVICE_TABLE is a no-op for built-in modules.

Fixes: f70ed3b5dc8b ("mailbox: rockchip: Add Rockchip mailbox driver")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202212171140.NB93eVvI-lkp@intel.com/
Signed-off-by: Allen Webb <allenwebb@google.com>
---
 drivers/mailbox/rockchip-mailbox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
index e02d3c9e3693..1f0adc283d1b 100644
--- a/drivers/mailbox/rockchip-mailbox.c
+++ b/drivers/mailbox/rockchip-mailbox.c
@@ -159,7 +159,6 @@ static const struct of_device_id rockchip_mbox_of_match[] = {
 	{ .compatible = "rockchip,rk3368-mailbox", .data = &rk3368_drv_data},
 	{ },
 };
-MODULE_DEVICE_TABLE(of, rockchp_mbox_of_match);
 
 static int rockchip_mbox_probe(struct platform_device *pdev)
 {
-- 
2.39.2

