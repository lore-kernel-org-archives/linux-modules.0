Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ABEC6FD18
	for <linux-modules@archiver.kernel.org>; Tue, 18 Apr 2023 22:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjDRWxA (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 18 Apr 2023 18:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDRWw7 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 18 Apr 2023 18:52:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685012D42
        for <linux-modules@vger.kernel.org>; Tue, 18 Apr 2023 15:52:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fw30so24339240ejc.5
        for <linux-modules@vger.kernel.org>; Tue, 18 Apr 2023 15:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681858376; x=1684450376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgcn9PiZNHtoz2F+8PPBL65QLWFvMFhBJ9UvyZcOLlg=;
        b=VVWI3ngCPp/RNgAVDv1gNW41RAvt6W8tHm/BWzyeZCdCfCf+0DK3bhryw0vUM+UMSQ
         /dVaky4jQH93x7YbJLj0pW/wAEaRgj0QRRrhItbXFdeddkvH9EcE8c1O1Xayy669Aft/
         JdvW3HH8cByf7PzZXyXZK27IL2PBwtNENZJ1pbQbL1vfPbwoe+GTX4VTpJkPkM6/Aghr
         ukcorl4nSLisoTD3qRiLB8PTWCMhMzmJy2HrrmtkKGeYQl29bf1mFXPLWohJCx6GBefS
         ZDQOD5Bm896dzMWTW6nA0B90PY2S4BhpZ3UwbZdHmamRZJ+5bgqzuHzJ1OuutmTzBe88
         f0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681858376; x=1684450376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgcn9PiZNHtoz2F+8PPBL65QLWFvMFhBJ9UvyZcOLlg=;
        b=WbnSuvEzscJ0XfvFxToSpJqFK5yjL7EkMT9vFoPwpQyUheS1E0YymMAt2MP0FmYUZb
         BKvnNUxHa+zy8MekRCflPFcD2zEoii4Sr6p66LaPwXCNqawwulinnVQj0CWoOQi6Jlb4
         dPsty4NJc5KHScscMvXJqmkyzCRaCHMhg7IVgftYHobUfGZZwIBDg+vXndX2GbD6VGsd
         vhJfP/VMdlslDDVUijVgh2JDYncuWrkSdkyR1P3b+Lj/cstxKOm1gmWCFDEiY/RTwhhu
         PELGJEhVeLvZAM0zwOKzbWjnZO8sRNgrMtP+FI1FjTpMZ+l2b+9qyZi4m9q3+LFHMkaS
         7P8g==
X-Gm-Message-State: AAQBX9cDdg686ZzCwtIILEJanjwQBMJql951jz+1Rzy1uPmlY83l9Vsl
        3+cIFWv7nNMh3vLuBtg6wAba3yKjzXE=
X-Google-Smtp-Source: AKy350ba8j8gb3lj3xHouew4srMdXWuEWCHt0NbSYEtAGIQVOlSofWwfxAgaB1sv11b80n8XznwNAw==
X-Received: by 2002:a17:906:856:b0:94e:f1b9:e933 with SMTP id f22-20020a170906085600b0094ef1b9e933mr11280128ejd.53.1681858375786;
        Tue, 18 Apr 2023 15:52:55 -0700 (PDT)
Received: from ldmartin-desk2.jf.intel.com ([134.134.139.71])
        by smtp.gmail.com with ESMTPSA id gs8-20020a1709072d0800b0094f694e4ecbsm3989955ejc.146.2023.04.18.15.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:52:54 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org, Nicolas Schier <n.schier@avm.de>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] modprobe: rmmod_do_module: Free kmod list of holders
Date:   Tue, 18 Apr 2023 15:52:41 -0700
Message-Id: <168185830839.163610.15829167203728527957.b4-ty@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418-add-missing-kmod_module_unref_list-v1-1-ab5b554f15ee@avm.de>
References: <20230418-add-missing-kmod_module_unref_list-v1-1-ab5b554f15ee@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


On Tue, 18 Apr 2023 10:52:38 +0200, Nicolas Schier wrote:
> Add a missing kmod_module_unref_list() to fix a memory leak.
> 
> 

Applied, thanks!

[1/1] modprobe: rmmod_do_module: Free kmod list of holders
      commit: 116e7c7fc00e8565caf913399c38852975094a75

Best regards,
-- 
Lucas De Marchi
