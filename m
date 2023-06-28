Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD22EB64D7
	for <linux-modules@archiver.kernel.org>; Wed, 28 Jun 2023 20:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjF1UPG (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjF1UOr (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 28 Jun 2023 16:14:47 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8C21FEF
        for <linux-modules@vger.kernel.org>; Wed, 28 Jun 2023 13:14:43 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f8775126d3so69918e87.1
        for <linux-modules@vger.kernel.org>; Wed, 28 Jun 2023 13:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687983282; x=1690575282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hbAy1A4hg8jKYhqwi5Dl7jA23U6AKUJrNF/g/KP9ftA=;
        b=SZgjdpk14oTFV1va1hxUQzM0gi4I0D8KcoyQtm3mh0LhZczx8c5LEaydLlRaoUIuCV
         +ytkAFRSH8ZrUDUMs093Y1ggCaliQn4k1QQw7ecszEAEmiq6z4IXvDgqMXxNLkxKLTql
         soYOORLu7B0pQwOEnWj5f5gTFtoccnD7IM17c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687983282; x=1690575282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbAy1A4hg8jKYhqwi5Dl7jA23U6AKUJrNF/g/KP9ftA=;
        b=IwA6PGo+tWGDlnSO+GzmG2RiY8pXqQAzglGGDGBNabiVi6b2/KXi3djhVeZcm9uJ49
         LzmQ8iKRm2qxymZWeC989sFvx9bgDDO5v/Ql1+zICQQyQlGR9Y2d/KykaVNm2hAhZAg4
         ZEmSIy5oK1phHD+BYf03lnD+I9E+h6T2uGk80CuQ1Q1/g9DmrYep3zONj0p2neba2Mfo
         YMJggI3v6pJV4LBbE8AAwyFKg4fvTh2fljmzwQpNPvKLNCGD+bkM6rA+OSRzmN1eA4Fh
         ntCv62e0F7SZcoepA5r9mLsQrlpFQWLi7cW8K0v/CAE/dt1gsUFWvdDwBjC+DoNz5y3B
         yXfQ==
X-Gm-Message-State: AC+VfDwmLJ0cu88TtH32sJx5XphqhYMA5jaTaaSlvKMemyC0Wf3JcGMv
        W3yiZ9Q0UqcMr5Ub9br51p52JIZ5pVJjGxnD/a32IuIf
X-Google-Smtp-Source: ACHHUZ7zrINOHGbzMOCRN7aP9z6KRuFDGU+AFimPQVHgw9TVFOm+YQOojoAebiOSCc16v6cTUOoYfw==
X-Received: by 2002:a19:ca01:0:b0:4f8:76ba:ad3c with SMTP id a1-20020a19ca01000000b004f876baad3cmr16656807lfg.55.1687983281968;
        Wed, 28 Jun 2023 13:14:41 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id p17-20020a05651238d100b004fb99acbbe7sm30782lft.231.2023.06.28.13.14.41
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 13:14:41 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b6a675743dso3465971fa.2
        for <linux-modules@vger.kernel.org>; Wed, 28 Jun 2023 13:14:41 -0700 (PDT)
X-Received: by 2002:aa7:de11:0:b0:51b:ea1d:bc31 with SMTP id
 h17-20020aa7de11000000b0051bea1dbc31mr12411899edv.26.1687983261040; Wed, 28
 Jun 2023 13:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <ZHTCK2_1pF61yWIr@hovoldconsulting.com> <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org> <499e30cc-d015-8353-1364-50d17da58f47@redhat.com>
 <ZHd8bLPY4OQCb/Z5@bombadil.infradead.org> <ba60bca6-b682-4c27-3c54-2512b6f16151@redhat.com>
 <ZHoTFDkPIgglW0sU@bombadil.infradead.org> <fa3f1a1f-edc6-f13b-cc84-f3264b03b0b1@redhat.com>
 <ZH38lpTHZ/RISC1v@bombadil.infradead.org> <ZH3/KVCHhX4D4yh9@bombadil.infradead.org>
 <ZJyBhv6yrAfYvMh5@bombadil.infradead.org>
In-Reply-To: <ZJyBhv6yrAfYvMh5@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jun 2023 13:14:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSRTEOgiDA5qUTPGcw=Fbk9Ou2i97kfSBcj3pey3X=fQ@mail.gmail.com>
Message-ID: <CAHk-=wiSRTEOgiDA5qUTPGcw=Fbk9Ou2i97kfSBcj3pey3X=fQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, song@kernel.org,
        Johan Hovold <johan@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, lucas.de.marchi@gmail.com,
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
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, 28 Jun 2023 at 11:52, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Linus, were you thinking of including these patches in for v6.5-rc1?

Heh, I don't even have them in my tree any more, I was assuming that
if they were good they'd be sent back to me...

I guess I can go fish them out from my old emails, but I actually was
expecting to just get them from you.

I do actually maintain my own branches for *some* things, and merge
them myself, but they tend to be for areas that I feel I'm
co-maintaining (ie notably vfs and mm that I still feel I'm involved
in).

In other areas, I may send out patches, but I don't feel like I'm a
maintainer, so I then think that "the real maintainer can decide if
these patches are good or not".

And I would very much hope that people don't take said patches _just_
because they come from me. They should be judged on their own merits,
and then occasionally people can mutter "Christ, what drugs is Linus
on _today_?" and just throw my patches in the garbage.

             Linus
