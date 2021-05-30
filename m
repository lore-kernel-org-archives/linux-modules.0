Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDB4C47089
	for <linux-modules@archiver.kernel.org>; Sun, 30 May 2021 09:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C8356102A
	for <linux-modules@archiver.kernel.org>; Sun, 30 May 2021 09:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhE3JlI (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 30 May 2021 05:41:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45888 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3JlI (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 30 May 2021 05:41:08 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E52C1FD2F;
        Sun, 30 May 2021 09:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622367569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=InkrhLuJu8SdNK3bbaHRBTUcJmGSq8jN0w4pLtsjrEM=;
        b=syRgiSZciFEfVRtlJQMQmd0F6DTbehk6iBHBu5X4LgNQMjAPIAMJGnkAGsjfrKOlQACL8F
        FbFFip4nhA5ZQGbe1ZlAKXC0iwDKhMo3QQj9Q2qfYK5g0RQqGCYKPVTUR/NOsDKNx1VLtE
        XyUbNGpYEEYSS6NVT0demqh2jh9+Wm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622367569;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=InkrhLuJu8SdNK3bbaHRBTUcJmGSq8jN0w4pLtsjrEM=;
        b=TVuR/J+klpWcEKrEkamoS17koQMgMTgll0YxJNDTxyz0aIaryGW34LWEvDGihxcNUTh5NE
        vrA0DExJBGwRPJCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 2685E118DD;
        Sun, 30 May 2021 09:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622367568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=InkrhLuJu8SdNK3bbaHRBTUcJmGSq8jN0w4pLtsjrEM=;
        b=oBQ+PqB59kOi/cbc5n6R6ZqH6wgXNXFsXixqj/20fg4MWP38Rka3Ya5utVFx4VhYrm4nEi
        qhOgq7st7r8uG0n1GJwESEGLCmTew05ZbWYYiCUnOAdBWZyZWNsDgdq38OVLpVGhqqbah/
        JGz2ruYGvdNSNHHLnq6it3ey5R3hDI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622367568;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=InkrhLuJu8SdNK3bbaHRBTUcJmGSq8jN0w4pLtsjrEM=;
        b=4rQdknS1tYfXwBQwn8bvHp3uGVaXS64A+03jjDkyab+SL41uCfXj0v5DjEMKWKLkNe/sbW
        MXGvGENKIvvE4uDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id YsNLCFBds2BfagAALh3uQQ
        (envelope-from <msuchanek@suse.de>); Sun, 30 May 2021 09:39:28 +0000
Date:   Sun, 30 May 2021 11:39:26 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Marcus =?iso-8859-1?Q?R=FCckert?= <mrueckert@suse.com>,
        Takashi Iwai <tiwai@suse.com>,
        Dominique Leuenberger <dimstar@opensuse.org>,
        Jan Engelhardt <jengelh@inai.de>
Subject: Re: [PATCH] modprobe.d: load from /usr/lib.
Message-ID: <20210530093926.GV8544@kitsune.suse.cz>
References: <20210112160211.5614-1-msuchanek@suse.de>
 <CAKi4VAJKxUVtqFGkCkeL5hc+Uuyh94Nzt+c1zLpSEdbvzjjwaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKi4VAJKxUVtqFGkCkeL5hc+Uuyh94Nzt+c1zLpSEdbvzjjwaQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: imap.suse.de;
        none
X-Spamd-Result: default: False [2.06 / 100.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         TO_DN_ALL(0.00)[];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         R_MIXED_CHARSET(0.56)[subject];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jan 12, 2021 at 12:56:05PM -0800, Lucas De Marchi wrote:
> On Tue, Jan 12, 2021 at 8:06 AM Michal Suchanek <msuchanek@suse.de> wrote:
> >
> > There is an ongoing effort to limit use of files outside of /usr (or
> > $prefix on general). Currently all modprobe.d paths are hardcoded to
> > outside of $prefix. Teach kmod to load modprobe.d from $prefix/lib.
> 
> /lib came from module-init-tools and we kept it for compatibility. It
> became a non-issue when distros
> decided to just merge them and do a symlink /lib -> /usr/lib following
> https://www.freedesktop.org/wiki/Software/systemd/TheCaseForTheUsrMerge/
> 
> what distros didn't do that?
> 
> I also fear the solution you want here is not so simple since now the
> configs will be added twice
> if there is the symlink.  And if we just drop /lib and start using
> /usr/lib we break compatibility.

Ins't there already a mechanism in place that loads only one file with
the same name (so that files in /etc can override files in /lib)?

Then even if the same directory is seached twice because of symlinks it
has no effect, right?

Also there is depmod.d which is documented as /lib but is actually
searched in /usr/lib.

Thanks

Michal
> 
> Lucas De Marchi
> 
> >
> > Cc: Marcus Rückert <mrueckert@suse.com>
> > Cc: Takashi Iwai <tiwai@suse.com>
> > Cc: Dominique Leuenberger <dimstar@opensuse.org>
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  Makefile.am        | 1 +
> >  libkmod/libkmod.c  | 1 +
> >  man/modprobe.d.xml | 1 +
> >  3 files changed, 3 insertions(+)
> >
> > diff --git a/Makefile.am b/Makefile.am
> > index b29e943a4d29..702a665f0334 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -19,6 +19,7 @@ AM_CPPFLAGS = \
> >         -include $(top_builddir)/config.h \
> >         -I$(top_srcdir) \
> >         -DSYSCONFDIR=\""$(sysconfdir)"\" \
> > +       -DPREFIX=\""$(prefix)"\" \
> >         ${zlib_CFLAGS}
> >
> >  AM_CFLAGS = $(OUR_CFLAGS)
> > diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
> > index 43423d63a889..9399c6c902f8 100644
> > --- a/libkmod/libkmod.c
> > +++ b/libkmod/libkmod.c
> > @@ -65,6 +65,7 @@ static const char *default_config_paths[] = {
> >         SYSCONFDIR "/modprobe.d",
> >         "/run/modprobe.d",
> >         "/lib/modprobe.d",
> > +       PREFIX "/lib/modprobe.d",
> >         NULL
> >  };
> >
> > diff --git a/man/modprobe.d.xml b/man/modprobe.d.xml
> > index 211af8488abb..ae5a83986a52 100644
> > --- a/man/modprobe.d.xml
> > +++ b/man/modprobe.d.xml
> > @@ -40,6 +40,7 @@
> >    </refnamediv>
> >
> >    <refsynopsisdiv>
> > +    <para><filename>/usr/lib/modprobe.d/*.conf</filename></para>
> >      <para><filename>/lib/modprobe.d/*.conf</filename></para>
> >      <para><filename>/etc/modprobe.d/*.conf</filename></para>
> >      <para><filename>/run/modprobe.d/*.conf</filename></para>
> > --
> > 2.26.2
> >
