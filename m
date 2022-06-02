Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5437CC43334
	for <linux-modules@archiver.kernel.org>; Thu,  2 Jun 2022 21:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiFBVro (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 2 Jun 2022 17:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237390AbiFBVrm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 2 Jun 2022 17:47:42 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1771DA6C
        for <linux-modules@vger.kernel.org>; Thu,  2 Jun 2022 14:47:41 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id t31so10654855ybi.2
        for <linux-modules@vger.kernel.org>; Thu, 02 Jun 2022 14:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pd1LekGY0cpB3lKyT64rGGQFHBupdHGemhO5JR+nPi0=;
        b=FJXojaZaObe7jR3cqMVF5PSwKT+cwoHHKDI75uBRHVAg/497qEByYBnnrzb2/9yhTa
         kQo6uEGDrnRm25vP79gRadGhkB5GJy0fqmg8AY9bIRojmj1U0tD3CPLYXR+mHv8F2KWY
         I+thDPBDeZJpTi34nM32Lw4f2Pk0OoFaFkSygxLOgA/XE5uWHy9wdGOXXyySNJCrt/Gq
         p6HkD5xTtCS9wEFzJjQ2i1XdJTlpgWv8NnGQIJvIrvs+CVbvIfIWKIp92xgVE1qCIFrh
         Rj487JsZVkUPEfBz8jsW/W4WfgtwrQxuX/e9c8LbObGgei94yAYcswJ6e51n5MZtFAfQ
         6hBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pd1LekGY0cpB3lKyT64rGGQFHBupdHGemhO5JR+nPi0=;
        b=XF3Enzqhgwqtgq9ZHPyMyetMEqmIHCpjOUOnwGS04/7gX5Xoa/JoAY7dim14u8T1kh
         gp7p8cUTGRBezUtnePitxddzc/2bjhsTPcs5dKXhj6T/kSVWIZvKHv8PWysGHbkhRttP
         Qk7hweG9bwFxUfoUso3Z4DdpGaiHQx8Uu05q/S1ww5S7XiDUvn14ImI74FB8ganxOjFn
         3ZAxGPe5bu3jpmCouKiWtAazErklNqfc5+VxdJKyrY/wBgzyLRPMLnMK7u78Yfo3BWYW
         oDZwxGe1/1cNs2hyZ/UM+sSX6eDeONhEqDLcqn7FVLkiX1Q4Gd2ML52qxbPz44g/hlAW
         KYdQ==
X-Gm-Message-State: AOAM53384vCbXwzBTkTkUpcBCmQJ4w77AfdgRXxAnOXk+UUoDCg7bUWz
        p5NHrJaCHikYUsOrlJMoJ3tNOZpzt7DGDmNVGpKlRw==
X-Google-Smtp-Source: ABdhPJwhaVML6bY2sbv22pA3loCooNXtPYM9TGo3kGez3Md1KGwL7qsfflQkSlEjz20MmwDUAMTWcCzyNqTr6jeKvsI=
X-Received: by 2002:a25:cc4c:0:b0:65c:8e83:fd5e with SMTP id
 l73-20020a25cc4c000000b0065c8e83fd5emr8182576ybf.563.1654206460483; Thu, 02
 Jun 2022 14:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220322140344.556474-2-atomlin@redhat.com> <20220602035653.4167316-1-saravanak@google.com>
 <YpkMelZC+E5hKTw6@bombadil.infradead.org> <CAHk-=wit6ttmzdFsbH+YLkMeLucTspYADHnENn4fBXNrit0BUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wit6ttmzdFsbH+YLkMeLucTspYADHnENn4fBXNrit0BUQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 2 Jun 2022 14:47:04 -0700
Message-ID: <CAGETcx9f5BiojqU6wr29eUrYr9s8k+CGj_t-7RvrTSmDm6WwJw@mail.gmail.com>
Subject: Re: [PATCH v1] module: Fix prefix for module.sig_enforce module param
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Aaron Tomlin <atomlin@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, Allen Pais <allen.lkml@gmail.com>,
        Joe Perches <joe@perches.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jason Wessel <jason.wessel@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jun 2, 2022 at 12:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jun 2, 2022 at 12:16 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > Linus want to take this in or should I just queue these up?
>
> I'll take it, and remove the unnecessary #ifdef/#endif. The #undef
> might as well be unconditional - simpler and doesn't hurt.

Sounds good. I just copy-pasted how it was done elsewhere. Luis was
mentioning adding a wrapper to go this cleanly and I needed it in
another instance too. So I'll look into doing that in a future patch.

-Saravana
