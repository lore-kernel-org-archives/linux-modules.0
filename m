Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39729C6FD1C
	for <linux-modules@archiver.kernel.org>; Fri, 24 Mar 2023 23:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjCXXl0 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 24 Mar 2023 19:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjCXXlZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 24 Mar 2023 19:41:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAEE10418
        for <linux-modules@vger.kernel.org>; Fri, 24 Mar 2023 16:41:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t10so13767104edd.12
        for <linux-modules@vger.kernel.org>; Fri, 24 Mar 2023 16:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679701282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blNmP7fzJBK5OFePYsB620CQcO46wrdWBDUrlFUHYQQ=;
        b=UqHwrfg02dC+olMypt934/3zePsBsXN2nDW/vQzaPMUvdiokkPnutN7c4KvMq21kjf
         gaNkP3+PsOVbTnBJ6RqFocRyr8R9XR5OGlcJMpCHV1f5sP4KY/b0/WC0c4q6v7L0LWaL
         3WKyYZM2g5QeJuoSmBSyjc7U7/iVtTRZt9WcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679701282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blNmP7fzJBK5OFePYsB620CQcO46wrdWBDUrlFUHYQQ=;
        b=gnkDnQhWOFMF8FfqlYBgBU1VMgTIAcUh62wykweSeWHuWN9nzeAtv3ibrMdLFlo9on
         htHv/kLjI99wqwOYPJUhOxxn8iDvzXFSXY9wklRQATt5f3Qe1xORQCiMqAZ2AbAHT8yL
         C6syl0/ptXdYSKSRYqVgFLgBB8HCSNhqE/Df0M2iMc22jV1tabycV85oelTD9aeukBmT
         pdi3fiQBLUEVPgEQhTOuOzYFmETaczDRRGQf69AX6SZAt17QBJUj/igJ2NiCrRiLgamA
         6vyJ/qyzSMbbZhQsE1ZFh70j6VP90vqJlfV9oqOoJIlNXTJQwp6EMTTl66ueg2oG/j+t
         brtA==
X-Gm-Message-State: AAQBX9dxRaIJ3K8Gk/nSwTr004LpTdf1kbTOBRMBxao+laaGiwxOnr9B
        8KnYjCPrY9Jrwcl4oigUt2349Sojl5hkmdPA+e9xogZ+
X-Google-Smtp-Source: AKy350Y4KZYFC+2qULwN3q6SKrvQM4WYsivaP+If7Zo8nQMR2HbWVV37mwpsVH1gefIhMjMOviEguw==
X-Received: by 2002:a17:906:7cd2:b0:932:3697:ff32 with SMTP id h18-20020a1709067cd200b009323697ff32mr4795209ejp.64.1679701281865;
        Fri, 24 Mar 2023 16:41:21 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id xf9-20020a17090731c900b0093debb9990esm1886422ejb.212.2023.03.24.16.41.20
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 16:41:21 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id eh3so13763996edb.11
        for <linux-modules@vger.kernel.org>; Fri, 24 Mar 2023 16:41:20 -0700 (PDT)
X-Received: by 2002:a50:a6d1:0:b0:4fa:da46:6f1c with SMTP id
 f17-20020a50a6d1000000b004fada466f1cmr2400386edc.2.1679701280484; Fri, 24 Mar
 2023 16:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org> <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org>
 <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com> <582aa586-e69c-99bb-caf8-eda468c332b6@redhat.com>
 <ZB3j3x4F2ozYX8UI@bombadil.infradead.org> <CAHk-=wij=z-C6puGv+E5gGKgFMam-ucCjyji0-vP1wd=aUpFvQ@mail.gmail.com>
 <ZB4BP0ZgxNirBNOJ@bombadil.infradead.org> <CAHk-=whkj6=wyi201JXkw9iT_eTUTsSx+Yb9d4OgmZFjDJA18g@mail.gmail.com>
 <ZB4SoxgM6vydrxrj@bombadil.infradead.org> <ZB4x6IY/8P1Xam7d@bombadil.infradead.org>
In-Reply-To: <ZB4x6IY/8P1Xam7d@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Mar 2023 16:41:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsBkyD+y_zfif1MXWYEkvPt+TPLdVjP41573oKEOu4qA@mail.gmail.com>
Message-ID: <CAHk-=wjsBkyD+y_zfif1MXWYEkvPt+TPLdVjP41573oKEOu4qA@mail.gmail.com>
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted allocations
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org, dave@stgolabs.net,
        fan.ni@samsung.com, vincent.fu@samsung.com,
        a.manzanares@samsung.com, colin.i.king@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Mar 24, 2023 at 4:27=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> A magic values of 20 is completely empirical.

I suspect a magic value is fine in this context. I do not believe that
"hundreds of concurrent module loads" is a valid real-life load. It
sounds more like a "systemd does horrible things at startup".

20 sounds plenty big enough to me.

But I guess this is one of those "only real life will tell".

              Linus
