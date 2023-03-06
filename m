Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67389C6FA99
	for <linux-modules@archiver.kernel.org>; Mon,  6 Mar 2023 14:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCFOag (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 6 Mar 2023 09:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjCFO37 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 6 Mar 2023 09:29:59 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E549F6
        for <linux-modules@vger.kernel.org>; Mon,  6 Mar 2023 06:29:19 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id i34so39301616eda.7
        for <linux-modules@vger.kernel.org>; Mon, 06 Mar 2023 06:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678112892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xK40+IrvuLAaGEzw1vO71ZMnvX089nmXSE+KdSBZGxI=;
        b=PMj0wDfVD3fuRV5c5SQfgpEQ61hMhePsdaketVQ7cgAAg5JZpRObdy/JgOFOWzAzwv
         j6BxaLeNAHLhFObDDSK6tR/Gwdsw03CCSRAVD5tTsRKbVXSZyZxP3gSv1iHhtQQTJDEp
         8MRU5IOdPn0yeOi+Ba8AcL0SXsRjh47+2TjSRpHaUKVM/rkLNCKbIxbAYr+YIj1QYv11
         48pSy/iUSTWmyB30nqYxltQSPMfnnBQ8vcjYZmZxZzP5kCruWdFO8IfUHIoNF6vwazHz
         RTDlsY/KoD6TS5+nrWL2VyQw3u7FOSMiwDM+CdOzuNCrFPoHxy6lN3dZbMgqCsOuwcYo
         XtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678112892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xK40+IrvuLAaGEzw1vO71ZMnvX089nmXSE+KdSBZGxI=;
        b=rhO7T6Dk2Pmo86ndka6I1J0ECQ7v9rtqiGRrKt3ohbZw9Bvuv/LO9uZLKVeYnGcWV3
         1QkZS501rQMfl7YG6LlXb63UsqpNaqVRspAUDJlhw+dg0vIt09td/I6C5cVkXl3DzW7Z
         kPzlEOTn2ELjC+WgbZEQU1fCtKMZaV9Dl5dUqgT25K7ZnlvA6U286Z6t/DusL+qTeotk
         /zbKn0pm4tir+41VE6b1UJ6y75OgiNhaH9C3GPDzQ+WAIOJlPJJiPuUX7SA/uidHX3rt
         ji8qqa9/2HST8irJZ1WLpAOFpIncM8avQvDjpNRKQKeypWyn5gzZAOUB2+yVHv0OUvzR
         rnSQ==
X-Gm-Message-State: AO0yUKXx8HgEdz32QKb7bSiJQKpr0WNfl1Q3XciK+4gPpHnY1CNpoLjJ
        a4vMGZMt8RPzJK8axpaUSTvHeg==
X-Google-Smtp-Source: AK7set9tagM4MvfxFASDbgv+ClynFHyi2+EfGVgbjvu5S9HDWrjjA77I6x2FIorpAtxNw/VW+IojBA==
X-Received: by 2002:a17:906:5e0c:b0:872:82d3:4162 with SMTP id n12-20020a1709065e0c00b0087282d34162mr10260275eju.44.1678112891814;
        Mon, 06 Mar 2023 06:28:11 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c1e7:5006:98ac:f57])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906a38e00b008b8ae79a72bsm4636763ejz.135.2023.03.06.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:28:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     mcgrof@kernel.org, Nick Alcock <nick.alcock@oracle.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: (subset) [PATCH 16/27] memory: tegra: remove MODULE_LICENSE in non-modules
Date:   Mon,  6 Mar 2023 15:28:08 +0100
Message-Id: <167811288496.11610.7328079575847216501.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230224150811.80316-17-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com> <20230224150811.80316-17-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, 24 Feb 2023 15:08:00 +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> [...]

Applied, thanks!

[16/27] memory: tegra: remove MODULE_LICENSE in non-modules
        https://git.kernel.org/krzk/linux-mem-ctrl/c/ee5ca07b2041dba178e11f33c79d4bfc20227f09

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
