Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5E7C433EF
	for <linux-modules@archiver.kernel.org>; Thu, 10 Feb 2022 14:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243126AbiBJOqD (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 10 Feb 2022 09:46:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiBJOqB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 10 Feb 2022 09:46:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3257C4C
        for <linux-modules@vger.kernel.org>; Thu, 10 Feb 2022 06:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644504360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M8Xicx5cO6JYsvcdxnszvP7E4kb3rIjZyILIbpstvnc=;
        b=IjdZzy0sCk8vcx74SAtaoU17sbrykmFss24loNUlRjdzeZwZV+oIttb4kPBHVmz191MrmE
        mp2wksgjwOzwT9Kx93APmCG06xmVWP8RTxBLChA6Vh+Gtwm8Oup7VOFmt5WHJbyVV4PF71
        idC5A5PTRmT6zUVd1otC10UOBEpEHzM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-z3pjoHF4PJa0CKMt-Gbc8A-1; Thu, 10 Feb 2022 09:45:57 -0500
X-MC-Unique: z3pjoHF4PJa0CKMt-Gbc8A-1
Received: by mail-lj1-f197.google.com with SMTP id k22-20020a2e8896000000b0023f97d5d855so2664348lji.12
        for <linux-modules@vger.kernel.org>; Thu, 10 Feb 2022 06:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8Xicx5cO6JYsvcdxnszvP7E4kb3rIjZyILIbpstvnc=;
        b=YWIKGrEPviQfUolS5oghdoDdFNOAH67AlqyVfgAGgql+Qy5kds3kK8MsNrIJH8OpEx
         61GzpkhDEhjaPbmgzrOjM0+Dwc2/SruYbZhHODsyIvFfFDrXOo8slcvc+XodIDxcj1N5
         +JcZDsr3xwxwXctbZkek82LDFhAhChD9jwy/q0ptcxxviwfh/XmokHuR8LWQeA/qMvzz
         QqUTMkj++kLg7aRlSBKKY0zo4sHAIBb/ox7mr0rGSyEdIyBQFmpraJyEqjh3kX3kyhqK
         oF3ONWfrf2upj+qVU7K6leORqNHnZH4+7E8lgaV3kWBhHeYs/BISZ6y+dVOuL9nJFA6J
         daIg==
X-Gm-Message-State: AOAM532cwEp6Y2xaZxBcN4Q/yMxKa7WUWiYjbgLBT9hycjSlRoleYpWh
        2Qor0f48MdN2Pa1CmC+CSCkwH8CdclAH61MHcgHdBNa3L93juXbyJxjYBvj+1LgPm7A5nl7xjB+
        EoB/Jb66NfG52XK4uNL7bhP2AYX2vtglRUxmGdinO
X-Received: by 2002:a05:6512:3f84:: with SMTP id x4mr4204728lfa.484.1644504355577;
        Thu, 10 Feb 2022 06:45:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwC9RjysectHKxeUKPhvllfxiSlrCWq8mr3WeL2XaNx5vQvpP7mOwVzJtA4X3KJF4uBtDLcN6dn9phCAV4+rt4=
X-Received: by 2002:a05:6512:3f84:: with SMTP id x4mr4204722lfa.484.1644504355403;
 Thu, 10 Feb 2022 06:45:55 -0800 (PST)
MIME-Version: 1.0
References: <20220209170358.3266629-1-atomlin@redhat.com> <20220209170358.3266629-2-atomlin@redhat.com>
 <a22eb1b0-3fb5-a70e-cf6f-022571538efb@csgroup.eu>
In-Reply-To: <a22eb1b0-3fb5-a70e-cf6f-022571538efb@csgroup.eu>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Thu, 10 Feb 2022 14:45:44 +0000
Message-ID: <CANfR36jh3yg9nqXkpCUWPeHV+sSD6yne9j1=uA5vyUpYOC8t9g@mail.gmail.com>
Subject: Re: [PATCH v5 01/13] module: Move all into module/
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
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu 2022-02-10 11:11 +0000, Christophe Leroy wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3e461db9cd91..7e6232bd15f5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13001,7 +13001,7 @@ L:    linux-kernel@vger.kernel.org
> >   S:    Maintained
> >   T:    git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
> >   F:    include/linux/module.h
> > -F:    kernel/module.c
> > +F:    kernel/module/main.c
>
> Shouldn't it be the entire directory ?

Firstly, thank you for your feedback Christophe.

Indeed it should. Moving forward: kernel/module/*

> > @@ -44,6 +44,7 @@ static inline int module_decompress(struct load_info *info,
> >   {
> >       return -EOPNOTSUPP;
> >   }
> > +
>
> This new line should be in patch 3 instead.

Fair enough. Given that the purpose of this particular patch is a simple
migration, style violations e.g. "Please use a blank line after
function/struct/union/enum declarations", can be resolved at a later stage.


Kind regards,

-- 
Aaron Tomlin

