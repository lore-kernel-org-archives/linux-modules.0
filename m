Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF492C433FE
	for <linux-modules@archiver.kernel.org>; Sun, 13 Feb 2022 18:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbiBMSD6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 13 Feb 2022 13:03:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbiBMSD5 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 13 Feb 2022 13:03:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D5705A5AB
        for <linux-modules@vger.kernel.org>; Sun, 13 Feb 2022 10:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644775430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MzMGv99OCi8+2Db1ZNZFSg9ybIYsKPglxX6rxpaRY6Y=;
        b=XIncsxXzvZ2aQfZK9acvXzIcOfcnC7bSdazE/8dsYtoy3PuI07QrO2WURRMGmmBv5BjrN3
        Txm5z05RCxqWYtouyDizwN8mpU8BcJ9P6QM0ilTbvleNOiKnKFl958w3eXgqql9j7SsDVN
        ZE4uR5+Ipf/3EHGSPBKQMIn+eYGUIz8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-yeKa-S-8P8CDnxxSqmEtjQ-1; Sun, 13 Feb 2022 13:03:49 -0500
X-MC-Unique: yeKa-S-8P8CDnxxSqmEtjQ-1
Received: by mail-lj1-f197.google.com with SMTP id by12-20020a05651c1a0c00b00244bf726482so246840ljb.0
        for <linux-modules@vger.kernel.org>; Sun, 13 Feb 2022 10:03:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MzMGv99OCi8+2Db1ZNZFSg9ybIYsKPglxX6rxpaRY6Y=;
        b=m8a4ui3LO0xtNeDhbzBkQP355XMmbRBaAlGv98wJDtteKU27AxHOfhKKAX95TvCiGv
         24gSL8G5YSAR7HwJnvJpR6OXvkkovDdBqszuIlOkSF1Eeit9mth9GGT9qf+tcky4moPg
         u7UQ6SyCr7eSVCLSFILMsb2L0D3wWrq5FWjkqE7NvMXLrLBHWy/tbyBHo57aLwVXnXNs
         sh4xobRli6F2RZg6WHkz90KQjR1w4jXDmEBvKmcHkCSoOOyqa6JGsiOImJQqUd5hgUU9
         h1rq8nZDYkqI2k8JVAHAOnNea/uELxhefLro3uswvzjEXXOWOHXLkbD2T4lXFl9vhJP9
         WEnw==
X-Gm-Message-State: AOAM531g1mIJ1059xT9d4xMZANygx1zJYhwhRsOqdrImG3J0JjmcIpN2
        RiI7PpSYd1RUaCbQgzpYecYK/uJA23fo8CBGL+iXEYoHMDImesJXDv9Tnjq0jJM9TQinYaDFgxv
        FTBCBoCQEvHLLsKMT1pqNEjiHTn9+nVOzhT3SvxVW
X-Received: by 2002:a05:6512:1032:: with SMTP id r18mr8185986lfr.678.1644775427510;
        Sun, 13 Feb 2022 10:03:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwes2q5xf22MJdPcoboBes53363gO606y9zz8jO7gp+BzN+lD6OSPykVWJAaQM7JqN5TGO7fgvFg8JwEeveI28=
X-Received: by 2002:a05:6512:1032:: with SMTP id r18mr8185979lfr.678.1644775427325;
 Sun, 13 Feb 2022 10:03:47 -0800 (PST)
MIME-Version: 1.0
References: <20220209171118.3269581-1-atomlin@redhat.com> <20220209171118.3269581-3-atomlin@redhat.com>
 <14a1678f-0c56-1237-c5c7-4ca1bac4b42a@csgroup.eu>
In-Reply-To: <14a1678f-0c56-1237-c5c7-4ca1bac4b42a@csgroup.eu>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Sun, 13 Feb 2022 18:03:36 +0000
Message-ID: <CANfR36gVY+1k7YJy0fn1z+mGv-LqEmZJSvSHXn_BFR4WC+oJrQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] module: Move version support into a separate file
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "void@manifault.com" <void@manifault.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu 2022-02-10 14:28 +0000, Christophe Leroy wrote:
>
>
> Le 09/02/2022 =C3=A0 18:11, Aaron Tomlin a =C3=A9crit :
> > No functional change.
> >
> > This patch migrates module version support out of core code into
> > kernel/module/version.c. In addition simple code refactoring to
> > make this possible.
> >
> > Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> > ---
> >   kernel/module/Makefile   |   1 +
> >   kernel/module/internal.h |  50 +++++++++++++
> >   kernel/module/main.c     | 150 +-------------------------------------=
-
> >   kernel/module/version.c  | 110 ++++++++++++++++++++++++++++
> >   4 files changed, 163 insertions(+), 148 deletions(-)
> >   create mode 100644 kernel/module/version.c
>
> Sparse reports:
>
>    CHECK   kernel/module/version.c
> kernel/module/version.c:103:6: warning: symbol 'module_layout' was not
> declared. Should it be static?

The function module_layout() does not appear to be used. So, I've decided
to remove it.

> Checkpatch:
>
>     total: 0 errors, 2 warnings, 3 checks, 337 lines checked

Ok.

> > +struct symsearch {
> > +    const struct kernel_symbol *start, *stop;
> > +    const s32 *crcs;
> > +    enum mod_license {
> > +        NOT_GPL_ONLY,
> > +        GPL_ONLY,
> > +    } license;
> > +};
>
> Why don't leave this in main.c ?

Yes, struct 'symsearch' is not used outside of kernel/module/main.c.

> > +inline int check_modstruct_version(const struct load_info *info,
> > +                      struct module *mod)
>
> inline is pointless for a non static function

This was an unfortunate oversight.

> > +inline int same_magic(const char *amagic, const char *bmagic,
> > +                 bool has_crcs)
>
> Same, not point for inline keyword here.

Agreed.


Kind regards,

--=20
Aaron Tomlin

