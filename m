Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02B4C2B9F4
	for <linux-modules@archiver.kernel.org>; Tue, 22 Jun 2021 06:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE80760FDC
	for <linux-modules@archiver.kernel.org>; Tue, 22 Jun 2021 06:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhFVGZ0 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 22 Jun 2021 02:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229501AbhFVGZ0 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 22 Jun 2021 02:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624342978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uc6FQnuMqMwU81G/FoXbSupO4CtSi2qrEVTYI5+Vk4M=;
        b=dKbnq/r1bRO9qPJY4Se6hI/I9pp68ZKCwvSl6x1oxR6to10klzb/gRWV9tIGJG8MX5osnD
        V3ZXyxpaQKbnHHQuaqEPUay7bNjt/fUabfSJzg//Tkl0rJ94HfWG3jrQPWLHsthVLAEUAS
        4H6QX5WpaLmip5RKusT/NOkh9JNXCak=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-mMDdi_xQO32mX6jC7bizlQ-1; Tue, 22 Jun 2021 02:22:57 -0400
X-MC-Unique: mMDdi_xQO32mX6jC7bizlQ-1
Received: by mail-wr1-f69.google.com with SMTP id x5-20020adff0c50000b029011a7be832b7so6902681wro.18
        for <linux-modules@vger.kernel.org>; Mon, 21 Jun 2021 23:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uc6FQnuMqMwU81G/FoXbSupO4CtSi2qrEVTYI5+Vk4M=;
        b=Umi+nU4ShUa+ekxcZoZnQkHRzoGGtC58X+zBAdQkwExPyZiAX/41COcYCLSTZemNNz
         Xc2OKk+Ux7+2qMc28d1+gNZ/ZuCiiDs/3Cv3T3rOt7e0dul9LKRcW39OFSgkDHLTKLQU
         /kdE12ZhJsCgAHsXjAIgwDqJ4g0ScVngzYtRxHfIPbljQ9DLH+PErZp8idh0IAcrkYH0
         HIFhGCNbbZRBuRH0rEC25saesj7ezV2xa2OM5uJtSHxsi7DW3irf3n91+SUYRdLnlDnE
         v7DC6E7o9HZ3iPixO9//4kd1C5E9xIpnxLIFjtv+b6oF1WAEmR4S49amvl6rK2vEfG4x
         HgwA==
X-Gm-Message-State: AOAM533vIFo/6o8Qg6pY9v/8orcTt8/eaU4mHkSV7m+55T0/NUQDW+xN
        bgkKpfMJnZnj3GxHMRW74OQYHoEIx8BB4DYtB0gwI/kNXCcgHIGsaMhSx04UpGapQAPkqvQK+Gx
        T2pZ3siVF5XMCpPgop6q8WtX22tCI2TMkoZ+X9llIAw==
X-Received: by 2002:a05:600c:3658:: with SMTP id y24mr2583660wmq.6.1624342976028;
        Mon, 21 Jun 2021 23:22:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVzwudfTKY0klAT7HT4kkwA981/6QzzeNLZPQJRUoN9iHt2LW8fMao7y0jzdRU2JVCaQ6AQDRFPg+N4F7Q2hg=
X-Received: by 2002:a05:600c:3658:: with SMTP id y24mr2583647wmq.6.1624342975909;
 Mon, 21 Jun 2021 23:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210608062859.93959-1-ykaliuta@redhat.com> <20210608062923.94017-1-ykaliuta@redhat.com>
 <20210608062923.94017-2-ykaliuta@redhat.com> <20210609171053.c72kzwcdkdrgcwpv@ldmartin-desk2>
In-Reply-To: <20210609171053.c72kzwcdkdrgcwpv@ldmartin-desk2>
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
Date:   Tue, 22 Jun 2021 09:22:40 +0300
Message-ID: <CANoWswki6jcArKf4Q54_acTbR7k9iVHYW8Kv+-ZoRMoZLRaOsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] libkmod-builtin: consider final NIL in name length check
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org, lucas.de.marchi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

My filters missed your replies, sorry :(


On Wed, Jun 9, 2021 at 8:11 PM Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> On Tue, Jun 08, 2021 at 09:29:23AM +0300, Yauheni Kaliuta wrote:
> >There is potential buffer overrun in kmod_builtin_iter_get_modname()
> >for the name of length PATH_MAX. The required buffer size is
> >PATH_MAX, so `modname[len] = '\0'` with len == PATH_MAX will write
> >right beyond the buffer.
>
> this doesn't look correct. "with len == PATH_MAX" we will actually
> return an error.
>
> What indeed is happening is truncation: since we are not reserving 1
> char for NUL termination, we will truncate the name. If we update the
> commit message to state the right reasoning, then we can land this patch.
>
> I don't see any buffer overflow here, but I may be missing something.

Yes, you are right. I see the actual overflow is fixed by
1cab02ecf6ee ("libkmod: fix an overflow with wrong modules.builtin.modinfo")

I should have checked some reports more carefully. Please, ignore the patch.

> thanks
> LUcas De Marchi
>
> >
> >Check the length against PATH_MAX - 1.
> >
> >Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
> >---
> > libkmod/libkmod-builtin.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/libkmod/libkmod-builtin.c b/libkmod/libkmod-builtin.c
> >index a002cb5ee2c6..3d4d77ab29b3 100644
> >--- a/libkmod/libkmod-builtin.c
> >+++ b/libkmod/libkmod-builtin.c
> >@@ -246,7 +246,7 @@ bool kmod_builtin_iter_get_modname(struct kmod_builtin_iter *iter,
> >
> >       len = dot - line;
> >
> >-      if (len >= PATH_MAX) {
> >+      if (len >= PATH_MAX - 1) {
> >               sv_errno = ENAMETOOLONG;
> >               goto fail;
> >       }
> >--
> >2.31.1
> >
>


--
WBR, Yauheni

