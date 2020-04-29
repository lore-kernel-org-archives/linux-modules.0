Return-Path: <SRS0=EbFF=6N=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958E5C83003
	for <linux-modules@archiver.kernel.org>; Wed, 29 Apr 2020 06:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66567206D6
	for <linux-modules@archiver.kernel.org>; Wed, 29 Apr 2020 06:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byjHd5nQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgD2GoU (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 29 Apr 2020 02:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgD2GoT (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 29 Apr 2020 02:44:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43168C03C1AD
        for <linux-modules@vger.kernel.org>; Tue, 28 Apr 2020 23:44:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id x25so686622wmc.0
        for <linux-modules@vger.kernel.org>; Tue, 28 Apr 2020 23:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UIR0y4NAocuQg3aZGk6ZW1Yik694Kw7WVMVANEJ6ljE=;
        b=byjHd5nQV1Eppi079SRNvgdvRk7LH33wOtyfhN6toFxKzuvKzooxttGhxEMTWqdAtQ
         0YV/OctcSsVsbUaO8Og53NtDF0uxKyLseCHQ2I394aLKwI0wAtJwE7RTWJlg4pJyhLBl
         TtZJH7X/j5Bt37ekOiSZyKVnEZZaEY3xloDKKk7R+Snzf8Hbk8hFRsAbkNuJ87ELiiWI
         c64yYEI963sAy30p9oMoCO3a5iBDXQuwQU7EwO0kFaFYHwJoLZS1T/utMwi5DtYDtfJf
         ywa85wI2DFEjOtDaGAj1AQEpdFUgSaSz1zs/sYKi1AojL8TyN/3zQaGZFmD7n2WejMKo
         icLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIR0y4NAocuQg3aZGk6ZW1Yik694Kw7WVMVANEJ6ljE=;
        b=fIaEJMhSoVeAVRq9A3jHBpjkH6MG2VYegyoZeoZwI/ORSPqIZvfo2bk13St0et+oCJ
         6W0K8p7vM6O8xGiJ9F146GEn+08XKiunQrzYgYzYbD87//4gKnfcTXmY+FEnel1K045a
         3ZqxGf131YPiMFj4yTyZUUcBlVGEQ8BgP8eCRVpE8O0GOqcLLxoyHoB4UI+C1Ct+JP1B
         S4d2KnialWD6AIF2/iQGKg0tzCKed8Kcu2HJG9caVjrBK4zp5/EX9/hjrug6T9efT6s7
         LsM61X84ItoPVlYWMTsa+lxU19dtWr2Kqe8R6WDNbDN3MUvCPo8FuSvZd5iYMliOvA7l
         34Fg==
X-Gm-Message-State: AGi0PubT38dPjHYGMvkiIDl4NjjncgU5fTOtqYPK323m9ral1LeUQRM0
        9Hqrqwt1Jti8yz0e6FbV5CBqHmeLSQPRlxD4T4EfHg==
X-Google-Smtp-Source: APiQypJbeUebKmA+VRid0RbGF93Rzv3KShJ70cGrSGZMatdMiuYn0A7FdRkeWVF8onrui1XV2XbIMxfM9RqkSjuV94A=
X-Received: by 2002:a05:600c:c9:: with SMTP id u9mr1402610wmm.15.1588142655569;
 Tue, 28 Apr 2020 23:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <xuny7dy1glgs.fsf@redhat.com>
In-Reply-To: <xuny7dy1glgs.fsf@redhat.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 28 Apr 2020 23:44:03 -0700
Message-ID: <CAKi4VALCzXJdZY-ABC-tZ=wpyfM0m-CE02FdZ3nDD2q-AE8kog@mail.gmail.com>
Subject: Re: exit from log_printf()
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Apr 27, 2020 at 5:31 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi, Lucas!
>
> I have a question about exit call from tools/log.c:log_printf()
> (https://github.com/lucasdemarchi/kmod/blob/master/tools/log.c#L140)
>
> What is the reasoning behind that?
>
> At the first glance it looks a bit incorrect (pretty surprising
> to have exit in print()).

If we log a critical error, there's nothing we can do except exit.
Note that this is only
used by the binaries, not the library.

There's potential for abuse, but it's pretty common to have something
with that behavior.

Lucas De Marchi

>
> Discovered while trying to remove several modules when one of
> them cannod be removed:
>
> $ modprobe -r libata pcspkr
> modprobe: FATAL: Module libata is in use.
>
> $ lsmod | grep pcsp
> pcspkr                 16384  0
>
>
> --
> WBR,
> Yauheni Kaliuta
>


-- 
Lucas De Marchi
