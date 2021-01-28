Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA74C433E6
	for <linux-modules@archiver.kernel.org>; Thu, 28 Jan 2021 20:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E82964DE0
	for <linux-modules@archiver.kernel.org>; Thu, 28 Jan 2021 20:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhA1Uzn (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 28 Jan 2021 15:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhA1Uzg (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 28 Jan 2021 15:55:36 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD08C061574
        for <linux-modules@vger.kernel.org>; Thu, 28 Jan 2021 12:54:56 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a10so9803115ejg.10
        for <linux-modules@vger.kernel.org>; Thu, 28 Jan 2021 12:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=MhZIYNlAs/lqXXyVkX//WZXU/YajM0i9mSpFblVZCPg=;
        b=oD2FVD+MDb4nZ3Wt3fOu5Q2s+xcXkXxYsus19I6h4aitXvkrTPL7MRdJ5hbvmfyxvU
         BHn4i2qzzq8ksHRmLGPy+nQa19/mn/pKOZTIkN+s+v9tRHN2FnHFWcwx3USebvgPSDFf
         AZpI07sNrQi40FgxN3kweUcFs8fpLIMFjixX6ih9Arss89zJ1x7YX4F3rvlUbLLMmGaM
         /0rFsodFuFBpS4NXAM8hQSjUqnmsI2wwqQjgWwCOZ8qcxf/BkU0N5yxNUzyDLADTtQDj
         Zy/uiJoyATLV6IoQ4IzLHiYGu6HSXYDUU6Hw5J/xruZ/aPdCs7t/n9ZmV4HnX1XwK4Kx
         Vgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=MhZIYNlAs/lqXXyVkX//WZXU/YajM0i9mSpFblVZCPg=;
        b=UvimEGB73g9tlQn3Yf0JUfLtIY+j7GG3vmhmfIh27eV/qhQQ6jr8BZYXY6S04h5oHH
         6ND4ATxN1t2kmgE9aTci4M+Z7wOyqYXDH8ZvViv0sfXS2MDFSNWGqqWi0c6hZ31ZY93G
         lxi9MCegkcZWGA9iFKlb6XOponF7gGHXhrathvKQju+zWvMvh3ZaCsno76avtffSaN76
         ubVfv/jJ4TtZ2JqAOo6Iy3DQDAF84N+6+aRbQbuuPzkONuzBFDxBAZYAHhfapzwzdm+i
         7Y8++H+HMJtu9VggJjYytORdR0EIAIHXFFTGk0BEHw83bDkXIBUAMbSBLGpbWiQrhp1d
         +qmg==
X-Gm-Message-State: AOAM5314eHoTYxdXX422cWS4JnpncSC0h1X3YLc+aPqdrLC0mQISMa0V
        NR7+GLoVLpvKRCTd4+S/juU=
X-Google-Smtp-Source: ABdhPJy3qTQaW0opXmwLuCCqmQpI5E/ZQa7V4xUvfAWkAUZ2wWJr6iduIK4kDoTLxpADDNH+XygPSQ==
X-Received: by 2002:a17:906:4bc1:: with SMTP id x1mr1289494ejv.509.1611867295209;
        Thu, 28 Jan 2021 12:54:55 -0800 (PST)
Received: from pevik ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id v20sm3517731edt.3.2021.01.28.12.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 12:54:54 -0800 (PST)
Date:   Thu, 28 Jan 2021 21:54:52 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Michal =?iso-8859-2?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/2] testsuite: move zstd-compressed module to a separate
 test
Message-ID: <20210128205452.GA139886@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20210128144724.102147-1-lucas.demarchi@intel.com>
 <20210128144724.102147-2-lucas.demarchi@intel.com>
 <20210128191000.GI6564@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128191000.GI6564@kitsune.suse.cz>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi Lucas, Michal,

> Hello,

> I think a simpler approach would be to not compress the module list for
> which the decompressor is not configured in populate-modules.sh Then the
> depmod test can run unchanged, and the modules will only be compressed
> when support for the compression is enabled.
+1

> The issue with this is that populate-modules.sh does not have any input
> for these configure settings - they are in config.h but that's not very
> useble for a shell script.
How about grep for them in '#define KMOD_FEATURES ...' line. Everything is
there:
#define KMOD_FEATURES "-ZSTD +XZ -ZLIB -LIBCRYPTO -EXPERIMENTAL"

Kind regards,
Petr

> Thanks

> Michal
