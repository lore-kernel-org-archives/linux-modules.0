Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710A8C761A6
	for <linux-modules@archiver.kernel.org>; Tue,  4 Apr 2023 17:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbjDDRW5 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 4 Apr 2023 13:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbjDDRWn (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 4 Apr 2023 13:22:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A561BCE
        for <linux-modules@vger.kernel.org>; Tue,  4 Apr 2023 10:22:26 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t10so133431181edd.12
        for <linux-modules@vger.kernel.org>; Tue, 04 Apr 2023 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HO2ovPp2g8BY9KhfdMQrBMTwegDXLLj5jKc/ptyrY30=;
        b=tjhO1KpfHhc+1lR2iyt1Hk/rwcxama/wjJ7OZ99SJ9iE5PvvnClZooJL0nqUXPFW4w
         8PzRygBzo62hR6aADvLBLh5zaUc9K6iHxsjI8GhSstvvF0Lj0mjG16K1nLIAgvpe3lCO
         IfvpySSB2i8q6tkhKqZxiq+I1G7MxQ6gEgFpY8mVOIr605DfgxdCPoHlgKjdf+DkmH7q
         m79NFghwh84Eqf8YGE3vMjyxAXLo15cRhi2jqwO8XbxtMGQwFbaEvZyF60IAZAT2Uukn
         Xy3tyVnLskveOBXY8K6of7oF+MzTS1kEAy6H9E5JdXU9fI0rQ5mTzNQBPzovDarbqu1z
         whUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HO2ovPp2g8BY9KhfdMQrBMTwegDXLLj5jKc/ptyrY30=;
        b=QqyhWO7gnwjPo7oOWebXdH5YmFBt25H0JXIwIOnBYRMe/Wc1yGmR3V8t01Dipu1JhC
         AVppkI8fE4JFDpqYyDGqtpELKS9Ij55MYGpmKmig2jbK9b6VJEkvaQIenyQoMHYTYJeD
         bdJHxvXy7KCl6RLDebhEQ1mINn/tESVytPcuRJcbuzdxMzEfsZhx/cg7bi9Jw6Kuvpjo
         GIYjB+FEliEfOVvx9eqnbGR2wJA2X7bM13tS4yzNvkUYIxiOk/G0GOMGDTJ61dcEI5S/
         +fKn5Hq67+yCkOc5oO5M7pUAoWrj9XZkqpar/i8RzU4oEBAyBh/NLZbzzFx4EiRwG9NZ
         6UHA==
X-Gm-Message-State: AAQBX9ct7VHJMAyT9qolispRGBtt4s+N3WZsV2eqMVP/Tm6AwqvtEAli
        b1Gq5Q2KpMR+GfJ6PtMmFqzE7g==
X-Google-Smtp-Source: AKy350Y26vq43+a2Aqrtc3D+K5XSDWstIaaK2jDuDL/irBvuLfTWCLG7XAeAr7fcVbJqkjEUOP1U2w==
X-Received: by 2002:a17:906:f1d5:b0:870:d9a:9ebb with SMTP id gx21-20020a170906f1d500b008700d9a9ebbmr302300ejb.38.1680628944564;
        Tue, 04 Apr 2023 10:22:24 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Nick Alcock <nick.alcock@oracle.com>,
        Michal Simek <michal.simek@amd.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/40] nvmem: xilinx: zynqmp: make modular
Date:   Tue,  4 Apr 2023 18:21:11 +0100
Message-Id: <20230404172148.82422-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Nick Alcock <nick.alcock@oracle.com>

This driver has a MODULE_LICENSE but is not tristate so cannot be
built as a module, unlike all its peers: make it modular to match.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Michal Simek <michal.simek@amd.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 6dec38805041..3b3832f4dfad 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -368,7 +368,7 @@ config NVMEM_VF610_OCOTP
 	  be called nvmem-vf610-ocotp.
 
 config NVMEM_ZYNQMP
-	bool "Xilinx ZYNQMP SoC nvmem firmware support"
+	tristate "Xilinx ZYNQMP SoC nvmem firmware support"
 	depends on ARCH_ZYNQMP
 	help
 	  This is a driver to access hardware related data like
-- 
2.25.1

