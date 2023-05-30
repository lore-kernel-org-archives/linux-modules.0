Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844C3C77B7A
	for <linux-modules@archiver.kernel.org>; Tue, 30 May 2023 22:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjE3WSC (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 30 May 2023 18:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbjE3WR6 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 30 May 2023 18:17:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B74124
        for <linux-modules@vger.kernel.org>; Tue, 30 May 2023 15:17:51 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51492ae66a4so5400064a12.1
        for <linux-modules@vger.kernel.org>; Tue, 30 May 2023 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685485069; x=1688077069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5DUvOnBbNjICLS8rqmJBzZV+nxJEkq4dfwQCNKJREU=;
        b=gdD7q13ylhzuSbc0tCp1jSoF/6dL9hu6fuwYW5IS6CCSnPbj+DTylJJ9jPMTJYu6+P
         9ldS4agVpZW1INit18f+fR/Pp3hW5TluxhK47FrTysvO2kMRRW0GSVIjrNje5jKUp9Rn
         CQr8PQoWSSLfXDJZAyV6sbibr8H6ajzuAQh4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685485069; x=1688077069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5DUvOnBbNjICLS8rqmJBzZV+nxJEkq4dfwQCNKJREU=;
        b=K5TqA7G2q0EJZ9SzenArPS0+8Mni6dIGKLu8P4I/tbqBTiPBk8rzbHeC+uQWHxkY4r
         Hz/2fihfc79rEny1orE1MNNJretvqWy0TxOxUvdaTReWxKEwk+52QYqdDMWsGqGyUhmq
         ueU/3azdmL3RtPw/4vo3ThG/SjnXN/VjktYRrjwDGJC4tLVWPHXnzWMcAOkj/NG8NF9W
         ReRmnGcuJYGWkz0lRPvoJThQGolRHQwF9Yo0vm+60ZPgMyyepVBno9KU+lXTCy2kM1N6
         3u5AQP/boIVpg+SIpVuXAmI7BV239R2RhqvvMH7fkYj79VY7kYQoO0DE0rqf3znMnSH3
         9g6w==
X-Gm-Message-State: AC+VfDxlBSUhS6xtXWEwphZAHcGCcJQS38bDn6+173SAvndVt5vmc6N+
        UGPbKiXvLW0zjnAFjIHSzvY3kUyddlZyBYCHXodysEMx
X-Google-Smtp-Source: ACHHUZ7Mt4mPKlfHyzXeypvC1AESOJdwVJIJctDmf3PZ8mbKupwOchilGon3U0mBhqXfsIjkMFuYSw==
X-Received: by 2002:a17:907:7246:b0:92b:6b6d:2daf with SMTP id ds6-20020a170907724600b0092b6b6d2dafmr3399984ejc.77.1685485069674;
        Tue, 30 May 2023 15:17:49 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id gg26-20020a170906e29a00b00973a9d66f56sm7768495ejb.206.2023.05.30.15.17.49
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 15:17:49 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-30ae95c4e75so3199775f8f.2
        for <linux-modules@vger.kernel.org>; Tue, 30 May 2023 15:17:49 -0700 (PDT)
X-Received: by 2002:a17:906:7945:b0:965:6d21:48bc with SMTP id
 l5-20020a170906794500b009656d2148bcmr3770717ejo.75.1685485048586; Tue, 30 May
 2023 15:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
 <ZG/a+nrt4/AAUi5z@bombadil.infradead.org> <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com> <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
 <ZHSeOUpKtyc8VKx5@hovoldconsulting.com> <ZHTCK2_1pF61yWIr@hovoldconsulting.com>
 <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org> <bav73qu5khl2dxkwpvy2hq34lyi56jn6yp7h5qlennka65kre3@zwwmrr55d2by>
 <ZHZRaFWvLEvkoCMA@bombadil.infradead.org>
In-Reply-To: <ZHZRaFWvLEvkoCMA@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 May 2023 18:17:11 -0400
X-Gmail-Original-Message-ID: <CAHk-=wicgDftP9ogSagxiRNvVTm7+YfQpEBuEsoRbkWzsw=EZw@mail.gmail.com>
Message-ID: <CAHk-=wicgDftP9ogSagxiRNvVTm7+YfQpEBuEsoRbkWzsw=EZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Johan Hovold <johan@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, May 30, 2023 at 3:41=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> OK thanks! So just to confirm, it seems fine to return the same error
> code if duplicates wait, or do you prefer for some reason for there to
> be an exception and return -EEXIST if the module did succeed in the
> duplicate case?

I think either should be fine, since either was possible before.

By definition, these are module loads being done in parallel, and so
any of them "could" have been the first, and returned success before.

And by extension, any of them could have been not first, and returned
-EEXIST if somebody else loaded the same module first.

So that "somebody else did a load" code:

        if (idempotent(&idem, file_inode(f))) {
                wait_for_completion(&idem.complete);
                return idem.ret;
        }

could certainly have made the return value be something like

        return idem.ret ? : -EEXIST;

instead of that "return idem.ret".

But it does seem simpler - and more in line with the conceptual
"loading the same module is an idempotent operation" of the patch -
to just always return the success value to all of them.

After all, they all did in some sense succeed to get that module
loaded, even if it was a communal effort, and some threads did more
than others...

As mentioned, I don't think it can matter either way, since any of the
callers might as well have been the successful one, and they would
basically have to act the same way regardless (ie "somebody else
succeeded" and "you succeeded" are basically equivalent return
values). If the module was a prerequisite for another module being
loaded, either -EEXIST or 0 _is_ a success case.

             Linus
