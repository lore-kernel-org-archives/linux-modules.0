Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A55DC74A5B
	for <linux-modules@archiver.kernel.org>; Fri, 17 Mar 2023 19:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCQTEL (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 17 Mar 2023 15:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCQTEL (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 17 Mar 2023 15:04:11 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F0CA5D6
        for <linux-modules@vger.kernel.org>; Fri, 17 Mar 2023 12:04:08 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b13so6121345ljf.6
        for <linux-modules@vger.kernel.org>; Fri, 17 Mar 2023 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679079847;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxWwhYtYMhTKLT+t03kqT9HvUsxnKyYicVxmtWlKd/U=;
        b=VaLCQLvTCM70AHROG4xz4tfrBF639waWz4KoWP8AzwXYthDGomNGp1T7jkmLSYG6ZL
         sQFvXnCJrqBICSwPvMM6a5OUdp9euuNEyXtvS6swIWpNLZtX+94mUEIdzi0vOzHTeDjh
         3JTXIbCJnfWdIZvosOOvSj9i6QeMcdMqZQro0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679079847;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxWwhYtYMhTKLT+t03kqT9HvUsxnKyYicVxmtWlKd/U=;
        b=DiVPndlg9r2MmX8kOMnK9GmsdAoI1FX1wAEwqMFgNjoD7ukOew+ROn1OdgD46B4jYj
         kvLxWzVjPq7g9KWqB/MkrtU2nqyZsO7yiS3dk1bHAWgQ15WBrdNJ3Y0CYtnJExb28D0T
         Z0i5KBDTB2LfaCFACA4FAH3N8A1hW8a7GVhy8OXiAKy6IBnce3X5QYitXlbxwdn1SQa6
         TnCVqeJ8eY8imKpPYOTJ6Ou4LncyYo7ErL4Px1naoz8u5wMlTmMjrvdhE7KoMt7EE0F6
         sNSjjshxNERMCVhH7kUY1HXhb2XF/NnTKr++KfGokU6puQ2ML4e7tP9uhcUe0aF0wr2B
         UiOQ==
X-Gm-Message-State: AO0yUKWNeDc1l8xPjhbe20TtDrKDMin+PWOZXb1lBGito61gCm4bJj9o
        qnXtGeDQYAa81t/stfDh7VyRb0nuP8V9zcsdvUi9BQ==
X-Google-Smtp-Source: AK7set9HiEa6enkw+O8v0nH+vyluNOZUiaCR0NVYDozZkTby7pa60VguxOSXhQJyn+UdyYOLblrB7egT3k0I/PkyvWw=
X-Received: by 2002:a05:651c:48e:b0:295:95a8:c6a3 with SMTP id
 s14-20020a05651c048e00b0029595a8c6a3mr3635392ljc.10.1679079847107; Fri, 17
 Mar 2023 12:04:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Mar 2023 12:04:06 -0700
MIME-Version: 1.0
In-Reply-To: <20230315125256.22772-1-fmdefrancesco@gmail.com>
References: <20230315125256.22772-1-fmdefrancesco@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 17 Mar 2023 12:04:06 -0700
Message-ID: <CAE-0n50=j=GPQA=wQa5wE=P2T0ipOoOn6ekhPVAJhr5nMkiVnw@mail.gmail.com>
Subject: Re: [PATCH] module/decompress: Never use kunmap() for local un-mappings
To:     Chris Down <chris@chrisdown.name>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>, Petr Mladek <pmladek@suse.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Piotr Gorski <piotrgorski@cachyos.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Quoting Fabio M. De Francesco (2023-03-15 05:52:56)
> Use kunmap_local() to unmap pages locally mapped with kmap_local_page().
>
> kunmap_local() must be called on the kernel virtual address returned by
> kmap_local_page(), differently from how we use kunmap() which instead
> expects the mapped page as its argument.
>
> In module_zstd_decompress() we currently map with kmap_local_page() and
> unmap with kunmap(). This breaks the code and so it should be fixed.
>
> Cc: Piotr Gorski <piotrgorski@cachyos.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Fixes: 169a58ad824d ("module/decompress: Support zstd in-kernel decompression")
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
