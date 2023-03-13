Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C052C6FD19
	for <linux-modules@archiver.kernel.org>; Mon, 13 Mar 2023 20:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCMUcW (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 13 Mar 2023 16:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCMUcV (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 13 Mar 2023 16:32:21 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EB022022
        for <linux-modules@vger.kernel.org>; Mon, 13 Mar 2023 13:32:19 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EF2FB3F1F2
        for <linux-modules@vger.kernel.org>; Mon, 13 Mar 2023 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678739537;
        bh=1KExiXuZ2mrX5RXNq61mPBXSlFqkJlTHfvOGTBT7ZaY=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=K0ICpnCu1N0qm98HWyWTXaXu7pAF0pDMKTJNT+DgP0qCmY18Hdu0ZFnOZMSGfkFKt
         Lz6ZLkj3yIrUnInKtuivLVxHrqDYfr47u4/8dhFlDekJo1ZQTRwfUVw+wZOt3fOeJp
         k9RUU69FBwh787jO82KvTtfiuQAuOjsMiZtiVBHqSF2/MFGZD/TMf19L2g9u42YPWG
         IKc5Tf9+JPR8nSjdOsdctJUKqGxTTruHVt1vyaFn7P9jGxQjymgF9xfnLxB88QUll3
         GLxihkEqfT8y89AQNO3LUKcqbOo4OHElkJmtoSL9CRFdLLu7YtRkTxLBhtDnbAhRQc
         g/eDTM/qfqSQQ==
Received: by mail-ed1-f71.google.com with SMTP id en6-20020a056402528600b004fa01232e6aso10136950edb.16
        for <linux-modules@vger.kernel.org>; Mon, 13 Mar 2023 13:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678739537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KExiXuZ2mrX5RXNq61mPBXSlFqkJlTHfvOGTBT7ZaY=;
        b=U2P65c0iveNXE+d06+NnFlWu6EJcRXesfIACi4lTc491IaMrpbOfXJuUi+k68dw1jS
         1LGgEnLOPfBTy3Jt7eCBii3lCzWlq8Vzo9CIV51nYt2BHIkM+pvYG7KE280aF6CP0K4w
         2KdBpS0BksEbgx1AVvvSxyGiyQ4W1cUwEB9WUAB5hJ6v2i4hq2nutarRtOHLU8M36uim
         356UMrBnngp21VJM8USOZuRkJd5VNrBupL+GFyFG0dF25W8GlVg3Fa/dMhvkpkUistg2
         QU0jyjPu8g8Buu7R+Eie3pSZD6xGDcmfvjuuOUCHWmhrTNAd25QhmN7ohLzosCjQnS+M
         +Ung==
X-Gm-Message-State: AO0yUKXQjmUb8yloE6P90HiOZ2qJ5avPo4v5HcOl/0eErdRpEGPIWnYc
        +h03n0xc+2unF30g+ZzCO2YdIzJgQe9mfdmyuD9vh7slfKl7dPyQrgSfsZuanlMel17DlQVl3mP
        WWbLf+fu6IiWVkxrLpEmAjApEZXgRryxUjZuGKGfY/Ms=
X-Received: by 2002:a17:907:2d2c:b0:92c:1756:8c4b with SMTP id gs44-20020a1709072d2c00b0092c17568c4bmr85350ejc.3.1678739537658;
        Mon, 13 Mar 2023 13:32:17 -0700 (PDT)
X-Google-Smtp-Source: AK7set8Hz/NflAYKnUyIH0ZlDjBEhCXB+FjCSw+3FgiE4kBEpxbt1v3na1v9YXEAxYpTvm5i83j1pQ==
X-Received: by 2002:a17:907:2d2c:b0:92c:1756:8c4b with SMTP id gs44-20020a1709072d2c00b0092c17568c4bmr85306ejc.3.1678739537315;
        Mon, 13 Mar 2023 13:32:17 -0700 (PDT)
Received: from localhost (host-79-53-23-214.retail.telecomitalia.it. [79.53.23.214])
        by smtp.gmail.com with ESMTPSA id ke4-20020a17090798e400b0092153c6b549sm216886ejc.22.2023.03.13.13.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:32:17 -0700 (PDT)
Date:   Mon, 13 Mar 2023 21:32:16 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Gary Guo <gary@garyguo.net>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] modpost: support arbitrary symbol length in modversion
Message-ID: <ZA+IUIOAgrWH2oZ0@righiandr-XPS-13-7390>
References: <20230111161155.1349375-1-gary@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111161155.1349375-1-gary@garyguo.net>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jan 11, 2023 at 04:11:51PM +0000, Gary Guo wrote:
> Currently modversion uses a fixed size array of size (64 - sizeof(long))
> to store symbol names, thus placing a hard limit on length of symbols.
> Rust symbols (which encodes crate and module names) can be quite a bit
> longer. The length limit in kallsyms is increased to 512 for this reason.
> 
> It's a waste of space to simply expand the fixed array size to 512 in
> modversion info entries. I therefore make it variably sized, with offset
> to the next entry indicated by the initial "next" field.
> 
> In addition to supporting longer-than-56/60 byte symbols, this patch also
> reduce the size for short symbols by getting rid of excessive 0 paddings.
> There are still some zero paddings to ensure "next" and "crc" fields are
> properly aligned.
> 
> This patch does have a tiny drawback that it makes ".mod.c" files generated
> a bit less easy to read, as code like
> 
> 	"\x08\x00\x00\x00\x78\x56\x34\x12"
> 	"symbol\0\0"
> 
> is generated as opposed to
> 
> 	{ 0x12345678, "symbol" },
> 
> because the structure is now variable-length. But hopefully nobody reads
> the generated file :)
> 
> Link: b8a94bfb3395 ("kallsyms: increase maximum kernel symbol length to 512")
> Link: https://github.com/Rust-for-Linux/linux/pull/379
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>

Is there any newer version of this patch?

I'm doing some tests with it, but I'm getting boot failures on ppc64
with this applied (at boot kernel is spitting out lots of oops'es and
unfortunately it's really hard to copy paste or just read them from the
console).

Thanks,
-Andrea
