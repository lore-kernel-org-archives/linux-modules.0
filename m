Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB38CEB64DA
	for <linux-modules@archiver.kernel.org>; Tue,  4 Jul 2023 17:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGDRKh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 4 Jul 2023 13:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjGDRKg (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 4 Jul 2023 13:10:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1F5E72
        for <linux-modules@vger.kernel.org>; Tue,  4 Jul 2023 10:10:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so3775442e87.1
        for <linux-modules@vger.kernel.org>; Tue, 04 Jul 2023 10:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688490633; x=1691082633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NInIoTXHnfyzm6QF9CbEiMuJrtrExLNeYRgH/orq6kw=;
        b=akjDXgUAKFymHvwP62XXmHCA9GMcfWmrZ7wrQwCXE7ec9cT/uge4aFmaVG80tkwh7H
         gdl/Fc7P/X/JBAFiE/vBIn2yVZ6V2XSrfNT7Oyqplj80hKKduNO8AxHOCoII2p+c8aRp
         3WBWiHLKukFXhIPKkA3IHFbj40PRnNhhHvb9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688490633; x=1691082633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NInIoTXHnfyzm6QF9CbEiMuJrtrExLNeYRgH/orq6kw=;
        b=SmfRwFi5GEe19XfLgZa/LKo+681XjrEoFz+flDZqNVKc3uXEk1YeLJ6NA2oLUkv521
         K6wOSpKnEJ4bTGKIBjge6PiPGfU4Cctwi0ifx/ZlsCwirzwPIiidM+ZAfdakJIeuF/R9
         CWPIG+5WprS/fjOZrCSAaYrJDGQMR8i4NJ9Kg946uHvQDf9yti7PeQ2CwtJikKTi6MPw
         ppziIhan2EVLZKvtXclMoUTE5n5Hv7HrM1lTnfU2Pqs+s53JrimEkwCbR32RIO0mSKJX
         W0LL7xGc+gF1NrEiEe5SMK3oIqLntupER33S2WvaNGd789DrYRqIbeyVaHIdP7DgPcYv
         AKig==
X-Gm-Message-State: ABy/qLZzV2bx7TNIb+hgQHNfRiNj5R6UgXklVySKpol7Uq+AtO/ude7r
        YvVJYn4E3w7L428/LvIXRpqX3AlzmkHhdIbbFSTBqfAa
X-Google-Smtp-Source: APBJJlEDLCyEVeBoKVNDknPprDiY2HGJwnOyvW0F1lsa2Uey+xZ5vVvQ1o1Bf+pdH1TbLOnzo0ubWA==
X-Received: by 2002:ac2:5f52:0:b0:4fb:8574:a9c6 with SMTP id 18-20020ac25f52000000b004fb8574a9c6mr9322248lfz.10.1688490632769;
        Tue, 04 Jul 2023 10:10:32 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id n9-20020a056402060900b0051e05cd6181sm4013637edv.78.2023.07.04.10.10.32
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 10:10:32 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51d9124e1baso6833436a12.2
        for <linux-modules@vger.kernel.org>; Tue, 04 Jul 2023 10:10:32 -0700 (PDT)
X-Received: by 2002:aa7:d9d6:0:b0:51e:527:3c64 with SMTP id
 v22-20020aa7d9d6000000b0051e05273c64mr7824520eds.16.1688490631850; Tue, 04
 Jul 2023 10:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230704092309.22669-1-vegard.nossum@oracle.com>
 <20230704100852.23452-1-vegard.nossum@oracle.com> <CAHk-=wgy2q9viwq-bAqaq8X_WQHNqDsu1AzfeYXAcDQRZmCoAw@mail.gmail.com>
 <7cf14d1b-1a3a-fea7-0d2c-409ab828569b@oracle.com>
In-Reply-To: <7cf14d1b-1a3a-fea7-0d2c-409ab828569b@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jul 2023 10:10:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg70vQAKPOqo-Ym6n47KSpm09kc-dmKME9Sd1HUcdZ-sg@mail.gmail.com>
Message-ID: <CAHk-=wg70vQAKPOqo-Ym6n47KSpm09kc-dmKME9Sd1HUcdZ-sg@mail.gmail.com>
Subject: Re: [PATCH] module: always complete idempotent loads
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Rudi Heitbaum <rudi@heitbaum.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, 4 Jul 2023 at 08:12, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> Maybe just do the f_mode check in finit_module()? Or... new helper,
> fdget_mode()??

I actually wanted to do a fdget_read/write() helper long ago: we
already basically pass in a "this mode is not ok" flag for the
FMODE_PATH case, and it's sad how many extra "do we have
FMODE_READ/WRITE" tests we have when it would actually make tons of
sense to just check it at fdget() time.

But I created the patch, and then decided it was just churn for
something that didn't matter a lot.

The existing "mode" argument to __fget_light() and __fget() would end
up split into "error if these bits are set" (existing) and "error if
these bits are _not_ set" (new) arguments.

It was straightforward, but I looked at the patch, and then looked at
all the existing users that currently check the error separately, and
went "bah", and threw it all away.

Which is not to say it's not the right thing to do. Maybe we should at
some point. But doing it right (ie doing it in that helper before we
even bother with reference counting etc) is just a bit too much work.

The alternative is, of course, to just have a *truly* stupid wrapper
that does the error checking and does the "fdput()" if FMODE_READ
wasn't set. But that's just disgusting.

Anyway, for this module case, I just moved it out to the caller.

> Apart from this, there is another bit that looks a bit weird:
>
> len = kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_MODULE);
> if (len < 0) {
>      mod_stat_inc(&failed_kreads);
>      mod_stat_add_long(len, &invalid_kread_bytes);
>
> I don't think we should be adding error codes to byte counts.

Ack. I fixed that at the same time as a "multiple problems with the
error paths".

                 Linus
