Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319D0C433EF
	for <linux-modules@archiver.kernel.org>; Thu, 30 Sep 2021 17:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C6561994
	for <linux-modules@archiver.kernel.org>; Thu, 30 Sep 2021 17:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352850AbhI3RzV (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 30 Sep 2021 13:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352847AbhI3RzU (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 30 Sep 2021 13:55:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6657C06176C
        for <linux-modules@vger.kernel.org>; Thu, 30 Sep 2021 10:53:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pg10so4299614pjb.5
        for <linux-modules@vger.kernel.org>; Thu, 30 Sep 2021 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J6VIPDiBHcPnVlaHOu28w6KMKmQgitpe9uIbK84dAaQ=;
        b=PDptof/eTySr76xQi6B/6Uyh3LTGJReNLguHgH+tmgMGtzvk8KnfDqrrtJcxjHSMwr
         QJ6Bg2VuVk70d3B/C6IL2mp4K9YRHci8VLvlzJeSko+B5vwYBpLWs9e0TX5qHbFc36kr
         K9+EUxdJtfkxJyuPbaAwjCod5bYZiEBVs4oBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J6VIPDiBHcPnVlaHOu28w6KMKmQgitpe9uIbK84dAaQ=;
        b=rsWc1zHYo6A7O9IYCT+eJK4VInBRM9+Wdi5hzl1AVJrjqar2qhx5gVGm7+Kth1VvXv
         STchPIokH/AI+64EeGXwnnmJ8YpsCm6314hhCwmyb/q4JpPUzKxWy8yTkQ65xVnzdjIt
         2Lfz5+U5fDbUMrvp8YiiI2WSobsEoBi3y00WW/xfB0ulcms44RoxSDySKVk919cT8LHr
         TF3AlOQXyP4Bf2Gyb6lEAIxBqNm65jxq2hpxkvZOtDBe3gMfbgzx7DrXYvw5u4Ze8B6X
         8cJetGG408+YhqFAdmoMan4tIPf7qUrUSE/hwBo+YcD/j50De5IpYStsSX4GQNKHULT6
         uKkg==
X-Gm-Message-State: AOAM530xge7dODAORGSqU4fRcaM1H3giXJQvRO+/U5gYPn6tur+RV7i1
        6lWYp0/2ch6VHO0tiXvVUwNuwg==
X-Google-Smtp-Source: ABdhPJwZdhveQPGbtdaFQHFIyqhRm+zaWg1TcdnLx+j93ohHMtpl/eCyuMVRVTSPcrq/nvakaNAUlw==
X-Received: by 2002:a17:90a:ead1:: with SMTP id ev17mr14731713pjb.158.1633024417242;
        Thu, 30 Sep 2021 10:53:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a7sm2982557pfn.150.2021.09.30.10.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 10:53:36 -0700 (PDT)
Date:   Thu, 30 Sep 2021 10:53:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     jeyu@kernel.org, masahiroy@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: Re: [PATCH v5] kallsyms: new /proc/kallmodsyms with builtin modules
Message-ID: <202109301051.DDD8B5F27@keescook>
References: <20210929215154.300692-1-nick.alcock@oracle.com>
 <202109291629.81106C83D@keescook>
 <875yui0ymc.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yui0ymc.fsf@esperi.org.uk>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Sep 30, 2021 at 06:19:55PM +0100, Nick Alcock wrote:
> On 30 Sep 2021, Kees Cook said:
> > On Wed, Sep 29, 2021 at 10:51:47PM +0100, Nick Alcock wrote:
> >> It would be useful if there were a mapping between kernel symbol and module
> >> name that only changed when the kernel source code is changed.  This mapping
> >> should not change simply because a module becomes built into the kernel.
> >> 
> >> It might also be useful if there were reliable symbol size information to
> >> determine whether an address is within a symbol or outside it, especially
> >> given that there could be huge gaps between symbols.
> >> [...]
> > [...]
> > It would be useful, sure, but is there something that does, in fact,
> > need this, or would like this if it were available? Since this provides
> > a userspace API, what would be consuming that API? For example, when
> > Syscall User Dispatch was added, it was clear it was for Wine[1].
> 
> We have a long-term consumer in DTrace (e.g.
> <https://github.com/oracle/dtrace-utils/blob/dev/libdtrace/dt_module.c#L1323>).
> (But since we control this consumer we are quite happy to change the
> format of kallmodsyms, integrate it with kallsyms so that kallsyms just
> provides the same information if the file format break were acceptable,
> or whatever you think most sensible. We just want this information
> somehow. :) e.g. the code there doesn't yet handle the
> symbol-in-multiple-modules case: I'll have to add that.)

Ah-ha, excellent. That works for me. :) (If there is a v5, maybe add a
note about DTrace to help show the specific need.)

Thanks!

-Kees

-- 
Kees Cook
