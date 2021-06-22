Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED08C2B9F4
	for <linux-modules@archiver.kernel.org>; Tue, 22 Jun 2021 06:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC7C611AF
	for <linux-modules@archiver.kernel.org>; Tue, 22 Jun 2021 06:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhFVGd4 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 22 Jun 2021 02:33:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229490AbhFVGdz (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 22 Jun 2021 02:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624343500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6dchryxcfneZ59jWYyYd4UlmCSnmuRKz2fcRoNpKD+k=;
        b=KvGPtqEfiruYWQiO6ufcFZepdCin6Q3GCfJBL/tgjHHfvqerqGmPL19/LZOZnkjBfn5HCW
        GttQsQ3Z7uboiTcnpFmrN3vW/jsY4io9FZfPf4sPcAZy56FictcLxj3gTq058dWuchcIaL
        JisNPcCo9e+CiisOFwKFL42Z9atOoTs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-HvKXmrwcNmCP4BcaJRq83A-1; Tue, 22 Jun 2021 02:31:38 -0400
X-MC-Unique: HvKXmrwcNmCP4BcaJRq83A-1
Received: by mail-wr1-f69.google.com with SMTP id q15-20020adfc50f0000b0290111f48b865cso9296620wrf.4
        for <linux-modules@vger.kernel.org>; Mon, 21 Jun 2021 23:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dchryxcfneZ59jWYyYd4UlmCSnmuRKz2fcRoNpKD+k=;
        b=t3IOVfGgZURvuuKMah1wKwUW8DjoIvqjw9Bu5ZqKym1VWd9bDvteLEb+ROuWHILF6l
         J9cIUp8EyVWtJchQx7MCUXzspihKSIbNqRj0Y3mHu32c2v9qyU6vdrVrRyGGWascclG9
         ap/vqn8C17hoQ5rK/Yl7kqst9eg1SLzf6Bg2kFVWg9x59SB7X00cVoBj5p/XOPPrkeT3
         CKx2b/lkMKXU7PfraObn+Tt9tgtPcxMFjIvzpeDaMUtw4YQwwJSNAYLNExJPW4ojqsXR
         BjY8qKx+p4jzwT+Ge+iDlxFEkhn9qqrTUVOXcszA4zO8z4IBD/UJfh28qoznQtkwHKmh
         rd6A==
X-Gm-Message-State: AOAM531tAczdRc+Q6mwGQXM9AX3tNvb8OfQvvvJiMVlLA68bvx12RVkc
        a5mzKXN0zicwkWdcxfvLAgge6G65dOHoV6vNHk7zayyMVb4gPwxzZAVUzQHOY3S1x3tuwx/EJ9m
        0HV/xt1D2Tn4AI1OXITkhmehpRLxXLNeRAxdG0sqkzg==
X-Received: by 2002:adf:d22b:: with SMTP id k11mr2718040wrh.57.1624343497299;
        Mon, 21 Jun 2021 23:31:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfcxAsGA90YMxUmgFYjjugFkdmkEBGSIGbZ0oXrGesEhuoxCnjJg/6G1AlnDA0V0ZrxP49ERuQvWJZZ9BC8Mg=
X-Received: by 2002:adf:d22b:: with SMTP id k11mr2718027wrh.57.1624343497138;
 Mon, 21 Jun 2021 23:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210608062859.93959-1-ykaliuta@redhat.com> <20210608062923.94017-1-ykaliuta@redhat.com>
 <20210608062923.94017-2-ykaliuta@redhat.com> <20210609171053.c72kzwcdkdrgcwpv@ldmartin-desk2>
 <20210609171849.xvbgrsvyehxueowd@ldmartin-desk2>
In-Reply-To: <20210609171849.xvbgrsvyehxueowd@ldmartin-desk2>
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
Date:   Tue, 22 Jun 2021 09:31:21 +0300
Message-ID: <CANoWswmHa54VY798aooHroa-3JWq+SC=jf7rV8y-SBwoZARk+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] libkmod-builtin: consider final NIL in name length check
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org, lucas.de.marchi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jun 9, 2021 at 8:19 PM Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> On Wed, Jun 09, 2021 at 10:10:53AM -0700, Lucas De Marchi wrote:
> >On Tue, Jun 08, 2021 at 09:29:23AM +0300, Yauheni Kaliuta wrote:
> >>There is potential buffer overrun in kmod_builtin_iter_get_modname()
> >>for the name of length PATH_MAX. The required buffer size is
> >>PATH_MAX, so `modname[len] = '\0'` with len == PATH_MAX will write
> >>right beyond the buffer.
> >
> >this doesn't look correct. "with len == PATH_MAX" we will actually
> >return an error.
> >
> >What indeed is happening is truncation: since we are not reserving 1
> >char for NUL termination, we will truncate the name. If we update the
> >commit message to state the right reasoning, then we can land this patch.
> >
> >I don't see any buffer overflow here, but I may be missing something.
>
> another thing... what is your git-sendemail setup? This is putting patch
> 2 as a reply to patch 1 and that breaks b4. See:
> https://lore.kernel.org/linux-modules/20210608062923.94017-1-ykaliuta@redhat.com/T/#u

Thanks, yes. I have thread = true, but send it after the cover letter with

git send-email --to linux-modules@vger.kernel.org --cc
lucas.de.marchi@gmail.com
--in-reply-to=20210608062859.93959-1-ykaliuta@redhat.com
0001-libkmod-module-check-new_from_name-return-value-in-g.patch
0002-libkmod-builtin-consider-final-NIL-in-name-length-ch.patch

So, the right way is to send all together, or disable 'thread'.

>
> Lucas De Marchi
>
> >
> >thanks
> >LUcas De Marchi
> >
> >>
> >>Check the length against PATH_MAX - 1.
> >>
> >>Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
> >>---
> >>libkmod/libkmod-builtin.c | 2 +-
> >>1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >>diff --git a/libkmod/libkmod-builtin.c b/libkmod/libkmod-builtin.c
> >>index a002cb5ee2c6..3d4d77ab29b3 100644
> >>--- a/libkmod/libkmod-builtin.c
> >>+++ b/libkmod/libkmod-builtin.c
> >>@@ -246,7 +246,7 @@ bool kmod_builtin_iter_get_modname(struct kmod_builtin_iter *iter,
> >>
> >>      len = dot - line;
> >>
> >>-     if (len >= PATH_MAX) {
> >>+     if (len >= PATH_MAX - 1) {
> >>              sv_errno = ENAMETOOLONG;
> >>              goto fail;
> >>      }
> >>--
> >>2.31.1
> >>
>


-- 
WBR, Yauheni

