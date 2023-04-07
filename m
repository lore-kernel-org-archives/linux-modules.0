Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E86EC6FD1D
	for <linux-modules@archiver.kernel.org>; Fri,  7 Apr 2023 21:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjDGVA5 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 7 Apr 2023 17:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjDGVAx (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 7 Apr 2023 17:00:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09701CC2F
        for <linux-modules@vger.kernel.org>; Fri,  7 Apr 2023 14:00:47 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id j22so10868422ejv.1
        for <linux-modules@vger.kernel.org>; Fri, 07 Apr 2023 14:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680901246; x=1683493246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8xM6r6/rOzbRR11rE4PPyc0SA/I8K68bLshe2lzvT4=;
        b=DvNwgJJRCQjPWo5ZkeKlsCaGjqWk+g4KX4qk1GyR6qkVMpmEdLiy6ZbC0fB+N7I7gg
         WeapifDg4odGu8z8t6PA1ZGsx9N8UsgjrbKl7c1ijH2FsypDCvAS6A63VTNcv48TdRM2
         p94p6QPt9X/BxeDe7ICQLdarD5tbFxLAsTr/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680901246; x=1683493246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8xM6r6/rOzbRR11rE4PPyc0SA/I8K68bLshe2lzvT4=;
        b=39tgo/uQnlljQsruSJ3ruZuY0/iQhx02h86PW2iL1eJqZ5iXYe8k/u6k9DeNmwLOKk
         Err9tntBKH7i503etuumoExZjo9wWc8Vl2ULuPHJmkzy9xYtHrcNgh5JJ/B6HoxIVoEb
         k9zVY8hixFtZZ5CwB8OiyQ/n4v45XctSSv6INSJzUDJyJuFZY04mD3uDocKcRBZVsUzL
         PPK3HI0Wxpj/h3FYImLBPhwpJKyItFjmpoRVvOUp45q9elF/TstCHHqN78OkDrXjkVQw
         z8LhIbpQ+nTQf8y5NZIifvDuU6M8BuIPP6THo8m8ERcNzkNWk3SlNrv4usyz5/ejQKBa
         qboA==
X-Gm-Message-State: AAQBX9fee+dvw4/+dXqRc4P8uFT0QXTruyhpnnzqbTatdnYx1lbTPOSf
        OUio4pQfE6v+XV3+hbZKAcvchGOfVKY1A3GQWR300+gA
X-Google-Smtp-Source: AKy350YIOHFwQCoj8pWCGOoo8Y0W3LuE7SYamxiQeEfM5X2AYPcFi0JTz4rPhLX64ekB5tN+uMJRGw==
X-Received: by 2002:a17:906:53d8:b0:8b1:820a:7b60 with SMTP id p24-20020a17090653d800b008b1820a7b60mr615633ejo.6.1680901246122;
        Fri, 07 Apr 2023 14:00:46 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id d23-20020a1709064c5700b009353047c02dsm2390495ejw.167.2023.04.07.14.00.45
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 14:00:45 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id k5so12952wms.1
        for <linux-modules@vger.kernel.org>; Fri, 07 Apr 2023 14:00:45 -0700 (PDT)
X-Received: by 2002:a17:907:b687:b0:947:72cd:9325 with SMTP id
 vm7-20020a170907b68700b0094772cd9325mr310007ejc.15.1680900776633; Fri, 07 Apr
 2023 13:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230405203505.1343562-1-mcgrof@kernel.org> <20230405203505.1343562-2-mcgrof@kernel.org>
 <ZDB+zn3X4sac9DFU@casper.infradead.org>
In-Reply-To: <ZDB+zn3X4sac9DFU@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Apr 2023 13:52:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYFGyy9jBmwEJHtdtdaEbqiyFn7GtMN6jP2ZFw92zYDA@mail.gmail.com>
Message-ID: <CAHk-=wgYFGyy9jBmwEJHtdtdaEbqiyFn7GtMN6jP2ZFw92zYDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Change DEFINE_SEMAPHORE() to take a number argument
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, david@redhat.com,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, colin.i.king@gmail.com,
        jim.cromie@gmail.com, catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Apr 7, 2023 at 1:37=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> I'd like to mention completions as an alternative to semaphores, but
> can't figure out a nice way to fit that in.

I'm personally a bit sorry completions ever became a thing.

There's a real reason for having them, but they have been used and
mis-used in so many confusing ways that I am worried every time I see
a completion. We've had some nasty use of 'init_completion()' in
particular.

There are many obvious uses of completions, and they have nice strict
semantics wrt last-use etc (so that you can put them on the stack and
know that you're the last user when you return, which is not
necessarily true of locking in general).

But there are several less-than-obvious uses too, and any use of
reinit_completion() ends up just making me go "Uhh".  The
serialization needed for that to actually work right often means that
you might as well have used a "wait_event()" with a
"smp_store_release()" variable instead and made the code more obvious.

I dunno. I might have had a few bad experiences and it's just rare
enough to be one of those things that I feel wasn't worth the
abstraction cost.

And I can't even blame anybody else. I think I'm to blame for that horror.

              Linus
