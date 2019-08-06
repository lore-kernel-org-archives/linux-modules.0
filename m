Return-Path: <SRS0=OtDb=WC=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3ECC31E40
	for <linux-modules@archiver.kernel.org>; Tue,  6 Aug 2019 22:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7FF20717
	for <linux-modules@archiver.kernel.org>; Tue,  6 Aug 2019 22:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs7ZZZjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfHFWxp (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 6 Aug 2019 18:53:45 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:40233 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfHFWxo (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 6 Aug 2019 18:53:44 -0400
Received: by mail-wm1-f46.google.com with SMTP id v19so78045409wmj.5
        for <linux-modules@vger.kernel.org>; Tue, 06 Aug 2019 15:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N7ffvKTWNYXy2bbs8yVQhnWiTh5yQ3bgv6JgDyR/ESk=;
        b=bs7ZZZjBFTOOTbh+sKdGLYDUtQpxCZqMmN1wLUQE5WflXPBaAvHfJ7i7zwpjrVUKTz
         qfsSgsPI272vna3SCNI/hIjSD5D9IQQcN/l0t6jMnauWWr/RKnQtVDpC2oemiaHFUChY
         wDb4OqEB1lqQX185RK/FFNqY++HOFp/Q80Mrvb3wkcegsSIVJBiadgkDVzD0qIcjOARz
         1Sl+KTX7ULGGY6e9cIl7E/EcdMO62k2ZwFN2bAHfJuTNMbzfa90p0V945AEQU+cZ/AH7
         ya2FMSIVQwZDeBmaCVSxKS06cO8vDQ6qFWkm/iY/26kKhZmO0JvwGHkZbE0Y6lzf39FW
         DVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7ffvKTWNYXy2bbs8yVQhnWiTh5yQ3bgv6JgDyR/ESk=;
        b=BYZBYHpEOr9xn/boNAWzT/HlgWxW3T7wFahGzisYfGEV4RD3mTYhsjD6UKdVT1wE/M
         gssO6xdzNmPt9DhwQYtd1f1Y6c7Tv98jfMPXKuOoZGGtK2aYOItdDp7kHdsJXZzHqx4g
         RznTQh3TVW22zZYNmluQ0qf1zQkGHsRZSJXOJBU9LL+YxjEPzslpa90A2klETTW48Qhd
         1aDJWtk2W1CwTqBIpM/cQIhe1Lw0aW9urfR7TyrK/N/2gp4VH5Eqd3bK45uFXNg8fAh0
         lN4uP0zxAOYMuZ4ViTqLMPM9JwOPfielD0RY89W0CbiLursbCNEmFyQYXI4iKn72ff74
         tHjA==
X-Gm-Message-State: APjAAAVwV3ykuAv8bAj7QTPk6SnSy5mI+03za/zexPg8XURpF0QpKVEA
        snFWWHue8GumgDPmPK2eCEW+T/zl4JNfQvKCOP0=
X-Google-Smtp-Source: APXvYqyaVCM8+CXwre+7okDtNcRn+Qz2pPIytGCj9tb9Vjq8nNmUfpaVamRs4T08bd1VKLWPxKCnuqWlVr+ROCa1PqE=
X-Received: by 2002:a05:600c:23cd:: with SMTP id p13mr6004540wmb.86.1565132022562;
 Tue, 06 Aug 2019 15:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190731222209.GA101140@chromium.org> <20190802183243.GA246294@chromium.org>
In-Reply-To: <20190802183243.GA246294@chromium.org>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 6 Aug 2019 15:53:28 -0700
Message-ID: <CAKi4VA+5YBaKHoEy819MBDoCTPY9Wsu=DzXPFaibAjL91GjhzA@mail.gmail.com>
Subject: Re: Module compression & loadpin
To:     Jack Rosenthal <jrosenth@chromium.org>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

+Jessica

On Sat, Aug 3, 2019 at 9:50 AM Jack Rosenthal <jrosenth@chromium.org> wrote:
>
> Has anyone looked into what it may take to support both module
> compression and loadpin (ensures modules come from trusted filesystem)?
>
> From my understanding, this is not supported as kmod currently does the
> decompression of modules, and loadpin prefers fload_module as it can
> tell where the module came from. (https://crbug.com/777204)
>
> In a gist, I am thinking supporting this scenario would require the
> module decompression to happen on the kernel side. Wondering if anyone
> has looked into this before I go making a solution...

That's my thought as well. In order to use finit_module() with
compressed modules we need to teach the kernel how to open it. It
should not be difficult since kernel already has the decompression
libraries. This also gives us access to another
compression/decompression algorithms - but would be nice to have a
correspondent implementation for modinfo.

I planned to do that some years ago, but never implemented it. Nobody
that I know of is currently working on that. It would be a very
welcome contribution.

Jessica, any comment on having this on the kernel side?

Thanks
Lucas De Marchi


>
> Thanks,
>
> Jack




--
Lucas De Marchi
