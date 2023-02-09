Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A344C61DA4
	for <linux-modules@archiver.kernel.org>; Thu,  9 Feb 2023 20:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjBIUJo (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 9 Feb 2023 15:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBIUJm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 9 Feb 2023 15:09:42 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDA8A249
        for <linux-modules@vger.kernel.org>; Thu,  9 Feb 2023 12:09:40 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id lu11so9928792ejb.3
        for <linux-modules@vger.kernel.org>; Thu, 09 Feb 2023 12:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ip6L+qQVXyBhRllZKrnxdy6nSfDF2X82DSzoYcCRHI=;
        b=i5wKdqf/XJZKQxCVTDDbZXACXRXVyo7/t+br9GLHjgebkpiNPkKLzwwXNyL9HNVzF9
         q9bd12vaolFbwR0NiuV9Hfu8xIJbV3hkbkSbkGLQBfO8/AtrGz+jWoAelQVjgCkAX/3R
         BRD1Uj68xYJ54CDr9EndExFC8T4Mz9xQwVy0o9zlqvCeMx2DLWnDR2i9u/Ecv/FJJYfs
         hjkBqlmkWMd4R4cX17ENHiT358yK+9sp02pvJk5BkWNo1H9y2PhlVlPMKpjRUkRMUhvq
         ADxZXNCOwhbPdkHRWIko+zAD9E6Mv3CzvvRWTdAnONSvfaVQctlOiLBbTFcjp/IWSWYp
         xlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ip6L+qQVXyBhRllZKrnxdy6nSfDF2X82DSzoYcCRHI=;
        b=p/TdtH5ulruiJFyV0SONCZUbGJREe9F0kvI/43uiq5yUl3AVq+gmvG54x2FlkZtmUC
         9h31fLhqmi7CeX+F0U5HMFNr9bgSZX2VYFItlSh5Vb8/H4t63b1nMh7SPDUURnuDKnwH
         Hs6qptgd+hB51cHwUDMq/S7aj3ltyMcCQm+eAe0o6ndySqhAYgs4mmyUZ01U3U3v59YB
         iQsV1Cb2OVDaW7O8e0pAiwSJpnzmSBsSCUvD4KlIuEkQQYtY1JxZ0OqwDWqCsFzYe1M8
         u6XE+7Q2nOU8s2p8eYuoJMW6hOSbnI4ciz3gN9UCS/4NXQu5qxuwGEDgRsRsztaD8big
         b7LA==
X-Gm-Message-State: AO0yUKU8iGFQdtMiPr/xqEupzM/ioROaYuqOYtWp981Bs+8TP9dkMOwo
        f0c+CsaAMM6YnSKZ6EwcBKTK1quRza8=
X-Google-Smtp-Source: AK7set9ULH7KV9zAN8Wk+URpWflbBZR5zHaYyrbKD7/lb2qjuiZqHkBqxVqWx0NRosUgfOAHzF0BDw==
X-Received: by 2002:a17:906:6a04:b0:8af:12d9:a4ac with SMTP id qw4-20020a1709066a0400b008af12d9a4acmr8519011ejc.25.1675973378455;
        Thu, 09 Feb 2023 12:09:38 -0800 (PST)
Received: from ldmartin-desk2.lan ([134.134.137.81])
        by smtp.gmail.com with ESMTPSA id d4-20020a170906040400b008448d273670sm1283467eja.49.2023.02.09.12.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 12:09:37 -0800 (PST)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org,
        Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH] libkmod: error out on unknown hash algorithm
Date:   Thu,  9 Feb 2023 12:09:25 -0800
Message-Id: <167597334950.254404.3400783049160514258.b4-ty@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206143259.585180-1-emil.l.velikov@gmail.com>
References: <20230206143259.585180-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


On Mon, 06 Feb 2023 14:32:59 +0000, Emil Velikov wrote:
> Currently if we see unknown algorithm, we'll do an OOB read in
> pkey_hash_algo. This can happen for example if OPENSSL_NO_SM3 is set and
> the kernel module uses a SM3 hash.
> 
> 

Applied, thanks!

[1/1] libkmod: error out on unknown hash algorithm
      commit: b9605c63b859adfffc0b4b9420d720aa323b90e9

Best regards,
-- 
Lucas De Marchi <lucas.de.marchi@gmail.com>
