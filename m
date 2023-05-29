Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D71C77B7A
	for <linux-modules@archiver.kernel.org>; Mon, 29 May 2023 11:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjE2LBF (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 29 May 2023 07:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjE2LBE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 29 May 2023 07:01:04 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7028F4
        for <linux-modules@vger.kernel.org>; Mon, 29 May 2023 04:00:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-970028cfb6cso625042166b.1
        for <linux-modules@vger.kernel.org>; Mon, 29 May 2023 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685358044; x=1687950044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83jhJNkWMwv2xEBpts8kpySt/1KhQx2X32FHoz9hyjw=;
        b=OiywrWMOeb+v9DQlE73IRz4YdmiFzkEjsLqXxqF+F9y7IKE4qFJTapiPBXidk5yslL
         AwlISE/uUvhlbnnWkWaB9w4yfQe+J9tNL/c3DmH8Xwt2Oj0VIFswUdpQgvAqDiPRBULI
         5+bREM9vA9B9Ln0sZ8mvpvMKlxqNULZ2XoSWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685358044; x=1687950044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83jhJNkWMwv2xEBpts8kpySt/1KhQx2X32FHoz9hyjw=;
        b=gGHaeXNsvJF+Q8ALad5QqVB+SEJjjjOWpVS2hyBmpZVkJQ2zGF7pJf1O52XRR/wGYt
         SSHZSMtjB7bdO4qw6gk5MIOMzyyiFQxZRK/ZJxckm2L/PyjFHxTl8mNkDH8EsTdS4M8b
         S/uekjiVd1RkSD6l7xw6HNuio2+YY000ENn250UtAQOq7q7TZfTenLht0R2dZNOWahPZ
         UbJGJKElKCzTnXJjD6SCfHgMILxQ84oyQXdfTpLF0AxEgh1YgrPCzEvOLlg82eFZXoV1
         LKF6JUkwhTZwff9rNI9erpFFOYIBvKbkwmW4tULs2IlG7HRJ6r3D/jyV/iQl8BNWjmQe
         zrpg==
X-Gm-Message-State: AC+VfDzuw/XcbdHPWxC0gIYiYYUUU3AMYuhvThDcoxh9RWfrOtFE8Nj2
        Es3myDTI1dkndajSBss6Vvv4/iCfHRze9uBJv1qrrqPn
X-Google-Smtp-Source: ACHHUZ5ZrrIwAs5Y5dn59QmVTFEJ7Sq0aUrAuKM7m5tqDMo9cg5Rtf2D1uqr8gLT8w28njVJVPEhnA==
X-Received: by 2002:a17:907:944a:b0:971:fa86:27e with SMTP id dl10-20020a170907944a00b00971fa86027emr10436984ejc.16.1685358044066;
        Mon, 29 May 2023 04:00:44 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id m19-20020a1709066d1300b0096f0c8beebbsm5783719ejr.79.2023.05.29.04.00.43
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 04:00:43 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso5696221a12.0
        for <linux-modules@vger.kernel.org>; Mon, 29 May 2023 04:00:43 -0700 (PDT)
X-Received: by 2002:a17:907:987:b0:96a:6723:da47 with SMTP id
 bf7-20020a170907098700b0096a6723da47mr9992607ejc.43.1685358023375; Mon, 29
 May 2023 04:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-3-mcgrof@kernel.org>
 <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com> <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
 <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
 <CAHk-=whu8Wh4JP1hrc80ZvGgVW4GV6hw1vwzSiwOo9-1=Y1dWw@mail.gmail.com>
 <ZG/a+nrt4/AAUi5z@bombadil.infradead.org> <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com>
In-Reply-To: <ZHRpH-JXAxA6DnzR@hovoldconsulting.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 May 2023 07:00:05 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
Message-ID: <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     Johan Hovold <johan@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
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

On Mon, May 29, 2023 at 4:58=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> I have not tried to figure out exactly why things break, but it does
> seem like this one should be reverted.

Yes, I have done so.

However, can I ask you to just verify that it was purely the exclusive
open part, and it wasn't that I messed up something else. IOW, can you
replace the

        return exclusive_deny_write_access(file);

in prepare_file_for_module_load() with just a "return 0", and remove the

                allow_write_access(f.file);

line in finit_module()?

That's obviously _instead_ of the revert that I already pushed out,
just to verify that "yup, it's that part, not something silly
elsewhere"

I do wonder what it is that is different in your setup, and maybe you
could also enable the

        pr_debug("finit_module: fd=3D%d, uargs=3D%p, flags=3D%i\n", fd, uar=
gs, flags);

in finit_module() while you are at it? Since you'd be editing that
file anyway for the test, just change the pr_debug() to a printk() and
then do

    dmesg | grep finit_module

to see what it all results in (on a working kernel, of course).

                    Linus
