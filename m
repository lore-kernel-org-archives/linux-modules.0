Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44D0C77B73
	for <linux-modules@archiver.kernel.org>; Tue, 30 May 2023 19:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjE3T4I (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 30 May 2023 15:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjE3T4H (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 30 May 2023 15:56:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D57E8
        for <linux-modules@vger.kernel.org>; Tue, 30 May 2023 12:56:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96f7bf3cf9eso938578466b.0
        for <linux-modules@vger.kernel.org>; Tue, 30 May 2023 12:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685476563; x=1688068563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXbuV/2ZsQefxhemlKCUWmhYBUScNB18jcUVrGBHu40=;
        b=SY6xca8h91N4K0a0N/zYIhzxynP1XDzMBZoR2e++26s8mdDkVock0jKk9xEJArf202
         Sl2rqUv6TKb9VHuxf/swacQ/Jkj/eS3KLOEmx9U50bqdY9DeN3jijHbTRosFuIYHPRp8
         IaJgW2U3KhO2e7lALWW9lKrt0c1sKI1KRl7NPk6hcCBMgj8S5MgtLpXOKh4cfmv/98o7
         Fk1FdjKpci6HPZKfjZ4OJQXrT+9+yTmpRRnJrSITE91Sj2XJZ4EGbCziPQjQ4N+t5PGl
         t9STyUMD7J8/1nX7O2FXk6zkcNTil8zj97ROK3GByY1z3VeZ75jWJRhjTFE3q9bJHbPG
         Jofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685476563; x=1688068563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXbuV/2ZsQefxhemlKCUWmhYBUScNB18jcUVrGBHu40=;
        b=R913RJATzSuVv76tt6zVqAvBFAjlH0rYDl6oL+5HGT3j7vxRhTfjRzYvZecVkyl6K6
         tKTk7OsBYTCKKdre2w2WLVb39ogGvjPtBEoqYrSe/gnHlYgSrxu93N+e3qdTXhkChwfl
         zDPp7+6uxG0oO5HHaiNF4rvdJqn4X6Qff9788Kyjj+xHhXgQfRbC5cuN8SjS8xOCtDdY
         ouJbJFd5Z7HypSe4UVodB9nsGAyQSeHJSumBaJcpUe4G0CE3BZf+LLYHZNTyx9omQSuM
         8khp1iHKYfTcgnGfDjWn6p6hecJMs+ZSloYoFSwfSU/fU0nkTQSiwGnWqK/Qdnc+AUsW
         uahw==
X-Gm-Message-State: AC+VfDy9sxcU+6athveraLVqOLCtjE3IJ5M/o9gPIB5H0tlMKKWYxpE4
        CWAK2nx/QrNpVfjBaqgtJ7YbMqyxvtk=
X-Google-Smtp-Source: ACHHUZ4RJx6QqOfoTRZWiPuKK/eA+DlLbpQFIDitHHthAgqZt8Hlu1JYesIFFToD1CbeC24biOmgbg==
X-Received: by 2002:a17:907:928d:b0:966:217c:b383 with SMTP id bw13-20020a170907928d00b00966217cb383mr3694575ejc.75.1685476563186;
        Tue, 30 May 2023 12:56:03 -0700 (PDT)
Received: from ldmartin-desk2.jf.intel.com ([134.134.139.85])
        by smtp.gmail.com with ESMTPSA id s2-20020aa7cb02000000b005105f002fd1sm4777402edt.66.2023.05.30.12.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 12:56:01 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] libkmod, depmod: prefer -ENODATA over -ENOENT if no section found
Date:   Tue, 30 May 2023 12:55:44 -0700
Message-Id: <168547650089.426113.5608177932648633484.b4-ty@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519093630.474185-1-dmantipov@yandex.ru>
References: <20230519072812.400131-1-dmantipov@yandex.ru> <20230519093630.474185-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


On Fri, 19 May 2023 12:36:30 +0300, Dmitry Antipov wrote:
> When the module is definitely present but CONFIG_MODVERSIONS is
> disabled, the following error message may be somewhat confusing:
> 
> modprobe --dump-modversions /path/to/module.ko.xz
> modprobe: FATAL: could not get modversions of /path/to/module.ko.xz: No such file or directory
> 
> Choosing among the convenient errno values, I would suggest to use
> ENODATA when the module lacks a particular ELF section (and vermagic
> as well). So now it is expected to be:
> 
> [...]

Applied, thanks!

[1/1] libkmod, depmod: prefer -ENODATA over -ENOENT if no section found
      commit: 5c004af29daf38119cc472dc8f1f080f10da6d82

Best regards,
-- 
Lucas De Marchi <lucas.de.marchi@gmail.com>
