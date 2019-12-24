Return-Path: <SRS0=ZSrg=2O=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7703FC2D0C0
	for <linux-modules@archiver.kernel.org>; Tue, 24 Dec 2019 02:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F53720709
	for <linux-modules@archiver.kernel.org>; Tue, 24 Dec 2019 02:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly0q5hTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfLXCzI (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 23 Dec 2019 21:55:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46538 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfLXCzH (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 23 Dec 2019 21:55:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so18599810wrl.13
        for <linux-modules@vger.kernel.org>; Mon, 23 Dec 2019 18:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZFlmbYP8bFwL8ZcM2eQXX/A+swTQ8X86mEytK+mqwI=;
        b=ly0q5hTOA3A/Dm4WUEA7wSQTIumef8KhIV59vI3xoY/3IDCN1hOaJlr7BrTdSicuEA
         s28t5gMec8AJMCMXNfWAJKnkA4t1YGnoq3NOAGF+0KyjNBakizdIY0fGdmywXlcYJIpH
         VxwShvW/kdYmUcbtPv0m811i5g1NACXObzz3q8YRSFAioIiVbyfD0QOpHF1WvORVpXy8
         nwfok4U6f5mVOKGUTpNNiODhEEYaUAlf9tw9/P8dubB9Yan31iv/vaQfNeI+Gr8MDwY9
         Dc9Jmq4PeEaRJneviDSYxUoa3uCxfU6XSUNWriSjv7XBBR/rBiU/4nwx2tf5ere2ck/C
         8xUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZFlmbYP8bFwL8ZcM2eQXX/A+swTQ8X86mEytK+mqwI=;
        b=CizuGMRK3lJ3rzjWK5//ZhG930Vd+5z+QsQBKhAbPsrG7qQHbXhthKi+OAwaEpADWL
         R4AI/IxOFt8UIuDt/bibkvY6H2J1iNXiGl0DAIKuiihjdpuxIxNHrUpmCOVO03q1qFn8
         rpGPsvFc8w8LBrnQeHhf3kL62OQwyr7cE/0dvtTcbBjftPf1HcphlYpNUotz4O6ziCFw
         TcQSAXuHPaNO23iHh0tXrrPri9w5r6u6DJMSePhJaJc8W4mVUyAflXtGiFUkNBlvbixT
         vv25NDGRpG7ipapKL6YdZBYN6o+86pEYRfVmfNSKacg0ge22xJfzfLQd6QC0S1D3Lu8k
         5FdA==
X-Gm-Message-State: APjAAAV/RD6eqF0VRMf2GebOMA3++/zeWL9L5GkTEhqg6hMlQdTj27Ag
        e4YNfzqZLB86399o8xObgHIZdm8akteE9vqSUJ8=
X-Google-Smtp-Source: APXvYqwTfCV7kQVZZ6sSC9x/fhsMzukev9S1guJ4yVC7GDH7bYhbH2/BGGDwp5WRfsDmPS3IvA66RXYQCHu/dZFVZ04=
X-Received: by 2002:adf:fc08:: with SMTP id i8mr34507077wrr.82.1577156105704;
 Mon, 23 Dec 2019 18:55:05 -0800 (PST)
MIME-Version: 1.0
References: <f8c64aed-b4a1-e43f-ed4b-f99236932477@gmail.com>
In-Reply-To: <f8c64aed-b4a1-e43f-ed4b-f99236932477@gmail.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Mon, 23 Dec 2019 18:54:53 -0800
Message-ID: <CAKi4VAK3pGJt8qA6CVrkwJOa5JLGtc63hWM0UZngp_qJb40jcw@mail.gmail.com>
Subject: Re: [PATCH] libkmod-module: convert return value from system() to errno
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Dec 23, 2019 at 9:07 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> Don't use exit status of a command directly as errno code, callers
> will be confused.
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>   libkmod/libkmod-module.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 8044a8f..6031d80 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -983,11 +983,13 @@ static int command_do(struct kmod_module *mod,
> const char *type,
>          if (err == -1 || WEXITSTATUS(err)) {
>                  ERR(mod->ctx, "Error running %s command for %s\n",
>                                                                  type,
> modname);
> -               if (err != -1)
> -                       err = -WEXITSTATUS(err);

I don't think we actually care about differentiating them. So just a plain
return -EINVAL;  here would suffice, makes sense?

Lucas De Marchi

> +               if (err != -1) /* nonzero exit status: something bad
> happened */
> +                       return -EINVAL;
> +               else /* child process could not be created */
> +                       return -errno;
>          }
>
> -       return err;
> +       return 0;
>   }
>
>   struct probe_insert_cb {
> --
> 2.24.0



-- 
Lucas De Marchi
