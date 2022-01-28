Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB06C433EF
	for <linux-modules@archiver.kernel.org>; Fri, 28 Jan 2022 07:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346817AbiA1Hjd (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 28 Jan 2022 02:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346892AbiA1Hjc (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 28 Jan 2022 02:39:32 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B2CC061714
        for <linux-modules@vger.kernel.org>; Thu, 27 Jan 2022 23:39:31 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ka4so13025075ejc.11
        for <linux-modules@vger.kernel.org>; Thu, 27 Jan 2022 23:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEcWsKqE5uYcNoVNkHmdsauLrUNyJ5ygZ3/BoJdf+E4=;
        b=Y40QCpfOeH6Aopx4c8hAvMEdk/M0A8zJpVVLmEsHKftkXSlelUuP1OWByO4mwfVtSN
         1hq/hh1gr/oeldhwCHxyuizYrRiu4msKg6qzqIgT7xtQKfjWgFO9AK9R5vYACW7xcXJq
         lsNEEBfaLWcp1No1QVnd1H9XOjW0/KgzoO6ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEcWsKqE5uYcNoVNkHmdsauLrUNyJ5ygZ3/BoJdf+E4=;
        b=Fe/Dh6ADKMKMACkF1l9YXz7JcnNRzaQZM6gxh7pbCwrzZaakFiwT3d8Dw4uF6ZZIfP
         6h2LxETfvahoRv/prfvAoXjblrRBHs1ixWCAbFhnw6mlCrfTQrDLUAUR9cSlgX2H1v1u
         8xmNSBE0cvAiFiT9UfNmBbUpllFXNM5bonK3RY+3uttU28JOCQB6nH8ibxuiTwXfJcSW
         yRztyRSCdiZj1K47QxbmPHyQbvbEGw+LxQAI9KpAtjWjpQx0Hb4Uw/54V22mnDXye+aC
         GvpqARoyweiMgyiltZwTH55mD0kff3JnOwg1YwnzCtwIKlO+2ayr37kQZZ1+z+5AMouR
         fuyw==
X-Gm-Message-State: AOAM530wF7TnaPo06au7TzPuu/khFkojp/t+pLXkxL93n7Wtqfq9TBjc
        EtSlOtkHi0LWIrxxlO2g7X2ERac6oIIXQewu
X-Google-Smtp-Source: ABdhPJzoq8U0dFg+jqPYN6SZWCwhrgc6aCw8x1b19+K0f/o6lkEWfVktZKldXmDWZ0krf+fvUskfUA==
X-Received: by 2002:a17:907:6290:: with SMTP id nd16mr5566673ejc.33.1643355569846;
        Thu, 27 Jan 2022 23:39:29 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id w8sm9624448ejq.220.2022.01.27.23.39.28
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 23:39:28 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id m26so1239661wms.0
        for <linux-modules@vger.kernel.org>; Thu, 27 Jan 2022 23:39:28 -0800 (PST)
X-Received: by 2002:a05:600c:1912:: with SMTP id j18mr14480558wmq.155.1643355568648;
 Thu, 27 Jan 2022 23:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20220127233953.2185045-1-ipylypiv@google.com>
In-Reply-To: <20220127233953.2185045-1-ipylypiv@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Jan 2022 09:39:12 +0200
X-Gmail-Original-Message-ID: <CAHk-=whM5sHbOboEnPSfBZPQrLB-KCtzE+JXFxFRNgT95i37bw@mail.gmail.com>
Message-ID: <CAHk-=whM5sHbOboEnPSfBZPQrLB-KCtzE+JXFxFRNgT95i37bw@mail.gmail.com>
Subject: Re: [PATCH] Revert "module, async: async_synchronize_full() on module
 init iff async is used"
To:     Igor Pylypiv <ipylypiv@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-modules@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Jan 28, 2022 at 1:40 AM Igor Pylypiv <ipylypiv@google.com> wrote:
>
> This reverts commit 774a1221e862b343388347bac9b318767336b20b.

Whee. That's from early 2013, more than 9 years ago.

> This works when modprobe thread is calling async_schedule(), but it
> does not work if module dispatches init code to a worker thread which
> then calls async_schedule().

Hmm.

You make a good argument:

> Commit 21c3c5d28007 ("block: don't request module during elevator init")
> fixed the deadlock issue which the reverted commit 774a1221e862 ("module,
> async: async_synchronize_full() on module init iff async is used") tried
> to fix.
>
> Since commit 0fdff3ec6d87 ("async, kmod: warn on synchronous
> request_module() from async workers") synchronous module loading
> from async is not allowed.

This does seem to imply that limiting it to PF_USED_ASYNC is largely
pointless, at least for the originally stated reason of deadlocks with
other module loading.

However, we've done this for *so* long that I wonder if there might be
situations that have ended up depending on the lack of synchronization
for pure performance reasons.

If *this* module loading process started the async work, then we'd
wait for it, but what if there's other async work that was started by
others? This revert would now make us wait for that async work too,
and that might be a big deal slowing things down at boot time.

Looking at it, this is all under the 'module_mutex', so I guess we are
already single-threaded at least wrt loading other modules, so the
amount of unrelated async work going on is presumably fairly low and
that isn't an issue.

Anyway, I think this patch is the right thing to do, but just the fact
that we've avoided that async wait for so long makes me a bit nervous
about fallout from the revert.

Comments? Maybe this is a "just apply it, see if somebody screams" situation?

                   Linus
