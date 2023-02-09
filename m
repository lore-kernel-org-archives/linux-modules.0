Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BE6C636D6
	for <linux-modules@archiver.kernel.org>; Thu,  9 Feb 2023 15:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjBIPNg (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 9 Feb 2023 10:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjBIPNf (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 9 Feb 2023 10:13:35 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA8234C35
        for <linux-modules@vger.kernel.org>; Thu,  9 Feb 2023 07:13:30 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id hx15so7238878ejc.11
        for <linux-modules@vger.kernel.org>; Thu, 09 Feb 2023 07:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BETDKZUqe+L/QAU65L5M0JtYQEkiY21pfBeyVQHp43Q=;
        b=RnmKvty04lxqF9jHZPCGkpM0M3LJvJLHSUi3cP8zb5EJl6jL3O+nwHhIrkKzJiJYmP
         RH5o9sUJj5z94VXESj7or6Yk4jfd7aBN/vKfbBC+xnQYo2fzaWQR7Ku/jfRNo7EhhDfg
         7av2tABZmH1Kdfz7zR8N/tHann7U4nISQaSTQhmO8KylVBybuDD/w4rlwQBBZIvNJywY
         F2cComwiL2ZmhPaZD3C1SBtnHWLM+eiHkYZcvhiDRFPg35Om43lA6k/WlvW5mQVSFYTY
         Ntm389uGo75kJtzZVMTkGPjcEWU7Twf8rxpWfPSM0L8LMu38EAYx1Ubi5OezvzFIroGA
         jcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BETDKZUqe+L/QAU65L5M0JtYQEkiY21pfBeyVQHp43Q=;
        b=Dpr4vxh0t/OBqwBSYyjADGexlelJYGS244ZVe7wm8adGwI3dDklntEW5jKgxTg/K3u
         3Bdn0dcW6MUTKU59PQOXBrm92x8qjnKmHdbFzG9/RYmqNCeGYUA/COd4cjYyoplkeuip
         +w3DfXS9p6nNynGMixu59bUHUpZLbbskj2pW9o4NAK117ibV/wR2jUKtzdzftmhA7vGO
         7wc48+844eV5Jbog1v5aKWBGT0J5J7/qgFlWVzo+l681RTErlsML0nqo1isCZj7j+zJq
         y3sYvmAY/4srvvLa98szliZjv5Jk7hnp4amN/IFNilSmlAwMnKZjx81eXhRzLDSBVV1c
         1Xbw==
X-Gm-Message-State: AO0yUKXBEtuGkenfdeaTS4TlTwLtnKJNY9zRW89YtPD3DK/LvMgDppCu
        AI2wn4XoXugBQv0wPWEhSr+LR5Hd5L8=
X-Google-Smtp-Source: AK7set9xh2uOsbFwUQOUbVMy8wSdS5o8+kfeNksiHIEeU/WB7144b7KFew3cnARbuqttH+gOzri3RA==
X-Received: by 2002:a17:907:9714:b0:8aa:b866:af5a with SMTP id jg20-20020a170907971400b008aab866af5amr13580978ejc.36.1675955607815;
        Thu, 09 Feb 2023 07:13:27 -0800 (PST)
Received: from ldmartin-desk2.lan ([134.134.139.84])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906c08d00b00878003adeeesm996890ejz.23.2023.02.09.07.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:13:26 -0800 (PST)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org,
        Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH v2] depmod: Introduce outdir option
Date:   Thu,  9 Feb 2023 07:13:21 -0800
Message-Id: <167595549871.112642.4477751898911189108.b4-ty@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206131834.559229-1-emil.l.velikov@gmail.com>
References: <20230206131834.559229-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


On Mon, 06 Feb 2023 13:18:34 +0000, Emil Velikov wrote:
> This option is equivalent to basedir, with the small difference being
> that's where the meta-data files are generated. In other words, this
> allows us to have read-only input modules and modules.dep, while still
> being able to generate the meta-data files.
> 
> 

I amended the commit with the additional diff as I shared and applied. Thanks!

[1/1] depmod: Introduce outdir option
      commit: 1712a1548eeaad61143f303b09afcb4215943203

Best regards,
-- 
Lucas De Marchi <lucas.de.marchi@gmail.com>
