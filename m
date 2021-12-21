Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91B1C433F5
	for <linux-modules@archiver.kernel.org>; Tue, 21 Dec 2021 11:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbhLUL6d (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 21 Dec 2021 06:58:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55847 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233913AbhLUL6c (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 21 Dec 2021 06:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640087911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7lYrU1K2CMwMBqu1I8UYlhY98XiUZOOoKEZAWN+V6pw=;
        b=GbEyQJYS2hIb9W5ZRwYFhNll9Ahlg20Afby6poz++ZYVXFAV3g+T7Deus3Ae+xmicSC+TF
        EPNSLmjMxAsw2IB8H6vhs61C8ZsXOHXKo6DL11xWQvOJpeafpEDyUL2JUl+cM2Ym9m0csg
        /36r9J4ZHeU+48TPnFCEiiUXrdXe+SI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-fKPS3uPFN-SiAsdjckgZIw-1; Tue, 21 Dec 2021 06:58:30 -0500
X-MC-Unique: fKPS3uPFN-SiAsdjckgZIw-1
Received: by mail-wr1-f69.google.com with SMTP id r9-20020adfb1c9000000b001a2981d9356so828145wra.20
        for <linux-modules@vger.kernel.org>; Tue, 21 Dec 2021 03:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7lYrU1K2CMwMBqu1I8UYlhY98XiUZOOoKEZAWN+V6pw=;
        b=s4lo+CUXo6hT2Kc9jW4swURUN8uP8tCG498HAoEnv2RsOzdQ3vK5Fh4TwMbS9RZEyO
         xe6gLrLqIkr8Du2ZUXkQnXylqtcvyC3gHN5VHujB2FHFbMPMfb1EtT7OitfFS2xDV+d0
         eE9ZCJT59DIRdY93I3NR+37eJq67F3xFoL7dnZs9iaQazFIXTKeEwPyPh7jFBzzQoHLq
         5CbUMMYSnkOFOtwt84BumMOe6KhKjwGRhpEMbjuYEuQ0qyoEw7qvxiqKTpk5ugJmvm45
         wc94OsvM6cniGY6aCm0xZGf47hfBti6ulZ+0bJwhUg2LKvJUv8+JdEZ6XruJpAxpAQuk
         PiTA==
X-Gm-Message-State: AOAM532w7iVCcniYr5zMxGWw0CeEJp4td9rOWjnYNbilI8EeFEXfBcv/
        Cpdfg/VAcweHUtWT9wUk8SUThYFc42+rscI3bhM31qVXoFC51xizaf7sFvLbMdY5G4Hp3tmiASZ
        lrBmd0dd5JVKyuXJ6NgdWR91/
X-Received: by 2002:a1c:721a:: with SMTP id n26mr2367346wmc.39.1640087909482;
        Tue, 21 Dec 2021 03:58:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxO75Z3tWfiJRwbhR1Ae2esgoCvkNBWJYDgw7Gh8Rm+9+pyY5hVxVf8ZXo8JIjLxfTbvGX4A==
X-Received: by 2002:a1c:721a:: with SMTP id n26mr2367328wmc.39.1640087909340;
        Tue, 21 Dec 2021 03:58:29 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id s1sm10035421wrr.8.2021.12.21.03.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 03:58:28 -0800 (PST)
Date:   Tue, 21 Dec 2021 11:58:28 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: Re: [RFC PATCH] module: Introduce module unload taint tracking
Message-ID: <20211221115828.cnuazprjdgfpebag@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20211124173327.3878177-1-atomlin@redhat.com>
 <YbEZ4HgSYQEPuRmS@bombadil.infradead.org>
 <20211209153131.a54fdfbci4qnyy6h@ava.usersys.com>
 <YbKUUJUtjBk/n913@bombadil.infradead.org>
 <YbMlVFwBiRujKdEX@alley>
 <20211210160931.ftvxpulno73a2l7c@ava.usersys.com>
 <Ybdj1EDnMSl2NLab@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ybdj1EDnMSl2NLab@alley>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon 2021-12-13 16:16 +0100, Petr Mladek wrote:
> > I'm not so sure about this. We could gather such details already via Ftrace
> > (e.g. see load_module()). Personally, I'd prefer to maintain a simple list.
> 
> Fair enough. It was just an idea. Simple list is a good start. We
> could always add more details if people find it useful.

Indeed we could.

> Also we should keep in mind that the default panic() message should
> be reasonably short. Only the last lines might be visible on screen.
> Serial consoles might be really slow.

Absolutely, I agree. This feature should be entirely optional. In fact, it
is likely only useful while reviewing the data via /proc/vmcore given the
potential amount of data generated, in addition to that seen in
panic_print_sys_info(), when explicitly enabled.


Kind regards,

-- 
Aaron Tomlin

