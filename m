Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11804C433F5
	for <linux-modules@archiver.kernel.org>; Wed, 29 Sep 2021 23:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DADC3615E5
	for <linux-modules@archiver.kernel.org>; Wed, 29 Sep 2021 23:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347288AbhI2XgX (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 29 Sep 2021 19:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245276AbhI2XgX (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 29 Sep 2021 19:36:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A582DC061768
        for <linux-modules@vger.kernel.org>; Wed, 29 Sep 2021 16:34:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c4so2663287pls.6
        for <linux-modules@vger.kernel.org>; Wed, 29 Sep 2021 16:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s50PiUE0GZ0ZQQyDE7urYqyC+XXAehvlB01y0urqqec=;
        b=jHod2IEAOYSVMk4eJ9KFe66IDNul71zOAQnH7GZhxrEAYN54b/WprrgAWaMqj8wppk
         8PVbfnmuUnkaOZzQI2ceK0mpoApel9aQ8+U6aXrn+KimynTOOm9yJbupVhbBtY7U9mE3
         ir91XMap1ANGFfr6e5w+czRSC3G48rSuncKp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s50PiUE0GZ0ZQQyDE7urYqyC+XXAehvlB01y0urqqec=;
        b=1L7CfmzMZGLlSJFifs/gfEnAMEhf7HKZzyCY0tIhUcZ3YbXqmy4RY0w2X3QBTwDrlX
         epBA9n37KEx2Qtb4YgrJ7MQ6tPcgj1OcFe7FntLX5nFmPeMG8+KZPjaYgvCIZW6jKN6D
         ZOMpZkcL4MPSPlwMNgAXlOqse2V69N2vclDMLhL97ZiQFTq+nsGx0N5GHSmi/xmxi63O
         w+Lfffz/jWLaA2U/ZhR/ItAK5G8As1mkZ/sP39TNgg66I/e199hFLkxWmaJ3spvCgOBM
         YjrDhQ1YwTFqOM9XRzgRApMnYsd8joezEUGPw0v4Lk3aGttjepnpnEP+z5XM8dt84y9G
         JW4Q==
X-Gm-Message-State: AOAM530Bur800Attp4zL7TxwJupfVLJsFzt1KT2EJMMtVXLLKpL9irDc
        7kA5+1tyJI7xZ1NJJiR6EL+ytg==
X-Google-Smtp-Source: ABdhPJxe5v97/gfWltea1abaN/1MdcuCha0nNqWTUiqPt0CdOhwDAm3vef6xuKBgecmbNsijHEo/ow==
X-Received: by 2002:a17:90a:a78f:: with SMTP id f15mr2783279pjq.106.1632958481050;
        Wed, 29 Sep 2021 16:34:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v12sm631373pgt.94.2021.09.29.16.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 16:34:40 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:34:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     jeyu@kernel.org, masahiroy@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: Re: [PATCH v5] kallsyms: new /proc/kallmodsyms with builtin modules
Message-ID: <202109291629.81106C83D@keescook>
References: <20210929215154.300692-1-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929215154.300692-1-nick.alcock@oracle.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Sep 29, 2021 at 10:51:47PM +0100, Nick Alcock wrote:
> It would be useful if there were a mapping between kernel symbol and module
> name that only changed when the kernel source code is changed.  This mapping
> should not change simply because a module becomes built into the kernel.
> 
> It might also be useful if there were reliable symbol size information to
> determine whether an address is within a symbol or outside it, especially
> given that there could be huge gaps between symbols.

This is a pretty cool series, but I'm left wondering "for what reason?" :)
Perhaps I missed the specific rationale; there was a lot to run. ;)

It would be useful, sure, but is there something that does, in fact,
need this, or would like this if it were available? Since this provides
a userspace API, what would be consuming that API? For example, when
Syscall User Dispatch was added, it was clear it was for Wine[1].

-Kees

[1] https://lore.kernel.org/lkml/160690190770.3364.5119373826178425644.tip-bot2@tip-bot2/

-- 
Kees Cook
