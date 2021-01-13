Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD74C433E0
	for <linux-modules@archiver.kernel.org>; Wed, 13 Jan 2021 14:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 016AC233F8
	for <linux-modules@archiver.kernel.org>; Wed, 13 Jan 2021 14:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbhAMOJg (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbhAMOJg (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 13 Jan 2021 09:09:36 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC95C061786
        for <linux-modules@vger.kernel.org>; Wed, 13 Jan 2021 06:08:55 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 23so2918478lfg.10
        for <linux-modules@vger.kernel.org>; Wed, 13 Jan 2021 06:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WAyZhcPo4DWmoEYzWZ6Q7QoYCs4Hkf75F+Ge95yhUgA=;
        b=vQwizjTnk+UrQwU9EAvwRasMqNLWuHMPBNaw+SO/Mvz2ad7kkazxnsI6aoCLalkKXd
         PVrlfxDLV+JK/scHtSMcc8DUL66y9t8OTZzkZJfpIgKnIVZ6dA0P9jXzEqxg2SGnYkaq
         ufM4+tZtLqqLyi8nF49jo/k1Oa+GTKl9ADHR2tJQ72+XRVZuMflSTW5FBwB90ePIoqXb
         fhJkUtXdZsHr6VOmUmiBBP36XM9T+l7Vt8/I+jF7sZ4g3yYpIgx+J7d+BEqlRWv3/67+
         TCwQEfSd4ebHBn77HIJyQhRo6H2XF6AnbB7HM1ZTbPN38pS3nPdqkS8hWQnkPNQOTVGg
         R7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WAyZhcPo4DWmoEYzWZ6Q7QoYCs4Hkf75F+Ge95yhUgA=;
        b=gaZIVK6E6RlInbI4+J4cNeyH+7OQDTd4GAYxI8GTtDCGkP0bnmsUre1J+8ill/ymdk
         1WQjz190CEgGY2kGOkOh9/eU73e78ZX4sZna5IIlk3SQfpVKBTc9BfZUqBf9b2ZJg4QQ
         b+wfurWR4nCJxaftxOylZM4pLOv3JtAK+K+qQL1z3CdSE7FM2UjmE9WJAiOMenXo77eC
         HhQZAQxhbjwdnODVz1ktSj+vHQqjg8xrJ+HFqoximy22oF+4wDPx5vcbSKh5fa6aXeUO
         +R7135H10l+7+qcHd9PhMoy5emVFUEhVDIPtOLliaRlQCfuJQtnXn0xbgP4XJRChJETn
         7oaw==
X-Gm-Message-State: AOAM532M/rL3lGplTk4n/OlMcy0dn2GilI88BS1U9qKoArt0waIwL4Fp
        sy8cNl2vh90HD+YURu676vmdowQAV0MVecFF2Pw=
X-Google-Smtp-Source: ABdhPJxv1jryCjxw6c//rbWVJAeGZGoRP74ahgCqNFT+CBZYV11KxlIkBU9HVsyf3XxSdNZ1yg1yru9Q4b6L7DG2rIs=
X-Received: by 2002:a19:6447:: with SMTP id b7mr961552lfj.206.1610546934227;
 Wed, 13 Jan 2021 06:08:54 -0800 (PST)
MIME-Version: 1.0
References: <20210112160211.5614-1-msuchanek@suse.de> <CAKi4VAJKxUVtqFGkCkeL5hc+Uuyh94Nzt+c1zLpSEdbvzjjwaQ@mail.gmail.com>
 <20210112222226.GA31541@altlinux.org>
In-Reply-To: <20210112222226.GA31541@altlinux.org>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Wed, 13 Jan 2021 06:08:41 -0800
Message-ID: <CAKi4VALOXOqrb34gZMqa29+=5MF8n7VnGPuEWbeu3JpZCJ1F=g@mail.gmail.com>
Subject: Re: [PATCH] modprobe.d: load from /usr/lib.
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        linux-modules <linux-modules@vger.kernel.org>,
        =?UTF-8?Q?Marcus_R=C3=BCckert?= <mrueckert@suse.com>,
        Takashi Iwai <tiwai@suse.com>,
        Dominique Leuenberger <dimstar@opensuse.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jan 12, 2021 at 2:22 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> On Tue, Jan 12, 2021 at 12:56:05PM -0800, Lucas De Marchi wrote:
> > On Tue, Jan 12, 2021 at 8:06 AM Michal Suchanek <msuchanek@suse.de> wrote:
> > >
> > > There is an ongoing effort to limit use of files outside of /usr (or
> > > $prefix on general). Currently all modprobe.d paths are hardcoded to
> > > outside of $prefix. Teach kmod to load modprobe.d from $prefix/lib.
> >
> > /lib came from module-init-tools and we kept it for compatibility. It
> > became a non-issue when distros
> > decided to just merge them and do a symlink /lib -> /usr/lib following
> > https://www.freedesktop.org/wiki/Software/systemd/TheCaseForTheUsrMerge/
> >
> > what distros didn't do that?
>
> FWiW, we decided not to do TheUsrMerge at all.

It looks like we will need to put this behind a compilation option
then: --enable-split-usr.
Then we only add the additional dir if split-usr is being used.

If it's not used, we may actually change the path and corresponding
docs to move it to /usr,
but that is another separate change.

thanks
Lucas De Marchi

>
>
> --
> ldv
