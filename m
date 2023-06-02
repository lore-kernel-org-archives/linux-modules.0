Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594C2C7EE29
	for <linux-modules@archiver.kernel.org>; Fri,  2 Jun 2023 16:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbjFBQHm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 2 Jun 2023 12:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbjFBQHi (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 2 Jun 2023 12:07:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAEBE62
        for <linux-modules@vger.kernel.org>; Fri,  2 Jun 2023 09:07:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-974638ed5c5so138267466b.1
        for <linux-modules@vger.kernel.org>; Fri, 02 Jun 2023 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685722052; x=1688314052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSyIWuON41xIpPsAfkdJjA0fkmYqrGMTTzJNJtvl1ho=;
        b=XKMjRbVuWt6OTQ1+P0PFSz7etjhOuiu9jbqOp/4MxyKzIEfldX34nc8pNpbN3ZFYdK
         UJKo8oYb7OakkIcanuYA+2Tl57D0UlcpwdTO0eHaCh8g7u8Bi0/7VQ3GwyECQGSxQjf9
         S9Qb9e9YBZQaBaWSONUt9tKhJpkf9Dymt+qvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722052; x=1688314052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSyIWuON41xIpPsAfkdJjA0fkmYqrGMTTzJNJtvl1ho=;
        b=hBYeDK0SLaSPEg5tS5prunm7JawUK/H2LNpYWuz+u4O00ZzWidcGwUpPqaexDjHOhB
         WHWALV2DjisLcst2fqu1rDF8h4pRtDZJeD9kurBWmKwKJH0a1Tg7Db8fq9HI74YSCZ4G
         KBP7TS7/s2vaP8PyY/l4IasIB+gsnPpq2Xxb6dkp//dypetdmP6jmovuGQn1k2m+v0Jd
         Skrs5uPo1z0itsCBnM/mOe8EVCRE2Z9ZGuZPWWspZesHrSRvyi8EnhZTEhMqAkTMdpmv
         psn/dJuGD0k0F0xAVh9US/t988k9YE2GCyC6i/Ae1uMHxiqXuhNpWuQXo8cIwImn2Mhf
         jxLA==
X-Gm-Message-State: AC+VfDxWDtgznD5+6qIV5UZ5Bq6q/h3xT5SWUZmEfYM7/MT4nW2RJklr
        ZFEZ5vd3mnFvBxiNQvpnfMavvPGcnkTvqWXipM2JQGJT
X-Google-Smtp-Source: ACHHUZ7PugBLa4PQqe9O6vcBm9qF/pd8ZJij7D1+gE+fOJRVoLIXhBXAomBAWUGORGgvwXFO/vsmuA==
X-Received: by 2002:a17:907:7289:b0:96f:94f1:b0a5 with SMTP id dt9-20020a170907728900b0096f94f1b0a5mr5760710ejc.8.1685722051904;
        Fri, 02 Jun 2023 09:07:31 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id m19-20020a170906235300b00967a18df1easm901089eja.117.2023.06.02.09.07.31
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 09:07:31 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-96fab30d1e1so482562766b.0
        for <linux-modules@vger.kernel.org>; Fri, 02 Jun 2023 09:07:31 -0700 (PDT)
X-Received: by 2002:aa7:c0ce:0:b0:516:2dcf:d027 with SMTP id
 j14-20020aa7c0ce000000b005162dcfd027mr2836164edp.10.1685722030936; Fri, 02
 Jun 2023 09:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
 <ZG/a+nrt4/AAUi5z@bombadil.infradead.org> <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com> <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
 <ZHSeOUpKtyc8VKx5@hovoldconsulting.com> <ZHTCK2_1pF61yWIr@hovoldconsulting.com>
 <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org> <499e30cc-d015-8353-1364-50d17da58f47@redhat.com>
 <ZHd8bLPY4OQCb/Z5@bombadil.infradead.org> <ba60bca6-b682-4c27-3c54-2512b6f16151@redhat.com>
In-Reply-To: <ba60bca6-b682-4c27-3c54-2512b6f16151@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 12:06:54 -0400
X-Gmail-Original-Message-ID: <CAHk-=whwFoC30zoTfsQAvkDRvgMCovwKGW_R1PPnqiF+YemcOA@mail.gmail.com>
Message-ID: <CAHk-=whwFoC30zoTfsQAvkDRvgMCovwKGW_R1PPnqiF+YemcOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     David Hildenbrand <david@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Jun 2, 2023 at 11:20=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> What concerns me a bit, is that on the patched kernel we seem to hit more=
 cases where
> boot takes much longer (in both kernel configs).

So it potentially serializes the loads to the same file more, but in
the process uses much less memory (since the ones waiting will not
have done any of the "load file contents and uncompress them"). So
it's a bit of a trade-off.

We could complicate things a bit, and let other callers return -EEXIST
a bit earlier, but I'm not convinced it really matters.

Honestly, taking too long because user space does something stupid and
wrong is not a kernel bug. Not booting because we use too much memory
- that's problematic. But booting slowly because udev does several
thousand unnecessary module loads is entirely on udev.

                 Linus
