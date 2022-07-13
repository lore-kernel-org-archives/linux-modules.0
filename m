Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883BCC433EF
	for <linux-modules@archiver.kernel.org>; Wed, 13 Jul 2022 08:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiGMIEk (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 13 Jul 2022 04:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiGMIEf (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 13 Jul 2022 04:04:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9ACF1E1904
        for <linux-modules@vger.kernel.org>; Wed, 13 Jul 2022 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657699473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NOytE1OpwEr9XiR8fNK3GgWZvLZYvbznSGDQ7mcwWyY=;
        b=ZyCzKbGxr3G5ca/GnnTZrOTvODa6JOD7A/KAJpqZskJVjjJt9X7YDGHFs8H5eoxCrUod5T
        HgDCkoMxusiqQFM1u78ZWc7M0S1hy1X5V6oQ//A9n0Ae59PqR2JCDdr603RccxN3Df7kog
        a0QIj+ud5YOebFoHwar38KT6XAKu5CQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-sKwMgi4cMlK-SwVyz_Lecg-1; Wed, 13 Jul 2022 04:04:32 -0400
X-MC-Unique: sKwMgi4cMlK-SwVyz_Lecg-1
Received: by mail-wm1-f71.google.com with SMTP id 23-20020a05600c229700b003a2eda0c59cso630018wmf.7
        for <linux-modules@vger.kernel.org>; Wed, 13 Jul 2022 01:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NOytE1OpwEr9XiR8fNK3GgWZvLZYvbznSGDQ7mcwWyY=;
        b=YgagUy+WofTLtXVO/HZzVky6TDPga1291o81u00CXhFiqFu7VPyf4/iteixr2ZmB5R
         m6R6e8EZUTUiEG2DvtHVWARPRxgmNf52sppys8zpVoK/sx2RE4dpEILcKHFQpYMPwdsf
         xmsR4sLkPyg4w2/b4wVKy12Z6Vf+dIUzi5VV5Q0cJxZrwmsQya7gdmLBW+W/80ZHLjFH
         PjAOmpj1u90ZEty1mtJe7N76kAZXJNfLmq0Fexy+NNG5tgEORnuOtxN15AhOFQv2FQzJ
         81rPbmpeZ6E4rnHzyBM49IbvR3IJzfRpr8K97+jnVNffXUR85TEEuFIYIKPi3ovNklRX
         lqHw==
X-Gm-Message-State: AJIora92K5ELVcgF/BZ7DDodj6/whDJ11Jz89vDiJDl1gnaNTJ2yWqq2
        19FI/kcByxHbbuSDh/RJc9ilpHmAZt2PHebF903vMj/kVNGAIMFe3Pp8q0Y7FVKngEvaUoBFdMj
        GjKETugeBqEFy9N8x4OoHPI49
X-Received: by 2002:a5d:6a09:0:b0:21d:7a73:c48a with SMTP id m9-20020a5d6a09000000b0021d7a73c48amr1905401wru.366.1657699470991;
        Wed, 13 Jul 2022 01:04:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vqbSTaA6ud72cVb/lQc2F1Aucex9l4ksWc+z8bOYyYLxbP+MGfqfsA5Iy9lPmmsNnjexlwhw==
X-Received: by 2002:a5d:6a09:0:b0:21d:7a73:c48a with SMTP id m9-20020a5d6a09000000b0021d7a73c48amr1905389wru.366.1657699470793;
        Wed, 13 Jul 2022 01:04:30 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id q13-20020adff94d000000b0020e6ce4dabdsm10156872wrr.103.2022.07.13.01.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:04:29 -0700 (PDT)
Date:   Wed, 13 Jul 2022 09:04:29 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: Move module's Kconfig items in kernel/module/
Message-ID: <20220713080429.7r2xcpumnynhnyhe@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <fdc6016e2414a26f17a17024d287087627052ea6.1657605146.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fdc6016e2414a26f17a17024d287087627052ea6.1657605146.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue 2022-07-12 07:52 +0200, Christophe Leroy wrote:
> In init/Kconfig, the part dedicated to modules is quite large.
> 
> Move it into a dedicated Kconfig in kernel/module/
> 
> MODULES_TREE_LOOKUP was outside of the 'if MODULES', but as it is
> only used when MODULES are set, move it in with everything else to
> avoid confusion.
> 
> MODULE_SIG_FORMAT is left in init/Kconfig because this configuration
> item is not used in kernel/modules/ but in kernel/ and can be
> selected independently from CONFIG_MODULES. It is for instance
> selected from security/integrity/ima/Kconfig.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  init/Kconfig          | 293 +-----------------------------------------
>  kernel/module/Kconfig | 293 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 294 insertions(+), 292 deletions(-)
>  create mode 100644 kernel/module/Kconfig

Thanks Christophe!

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>

-- 
Aaron Tomlin

