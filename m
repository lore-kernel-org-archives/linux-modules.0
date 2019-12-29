Return-Path: <SRS0=AcLT=2T=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C04C2D0C6
	for <linux-modules@archiver.kernel.org>; Sun, 29 Dec 2019 11:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A149F20748
	for <linux-modules@archiver.kernel.org>; Sun, 29 Dec 2019 11:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLJCIpri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfL2LEV (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 29 Dec 2019 06:04:21 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41832 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfL2LEU (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 29 Dec 2019 06:04:20 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so23548832lfp.8
        for <linux-modules@vger.kernel.org>; Sun, 29 Dec 2019 03:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/7USyJGjqZ38QUCAStt9Nvgu3zrbJ+XlYiQDqOrIj9A=;
        b=RLJCIprip4aIKBy5+s9Xa5LZsl3tgF3dZs1SyF5ZK7CGVgDrMR+0bQ7Idu45nORfPX
         ZUqG2cp+eTrc6QbRVkIHUl9HWKEHJ+8vWA7PDC32NzNvO2OU7YjR+0N0KHsLEftGlP25
         1SfdHGuagtsb3cyAoaRLy54ixbxX6Y6/Hhjed2I/x719lgCWfp6ay9ePBPSetns5YOvV
         tB96OjjfbLiEINpu5wwsGWsLpsf0lYCNfQpvhM0VmkFnreHoUWtpxEo/H3YlskuGK/M2
         CpqFb5q0KOuHeq08j3g3y+MBrAethXqwyDNhHr9Fe6gC93MciCWPgQf0NU7PP7EJ/7RP
         b0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/7USyJGjqZ38QUCAStt9Nvgu3zrbJ+XlYiQDqOrIj9A=;
        b=a984P/F8VxjIKFOHTlqoSh5i9tW81E3eps/L0Pd+3S/dFw6tppkFb03H9FwjTtpjuc
         xXbGfPHy7Q4vGzg+nX2tVXQ7F+uuO9HAbPbjTihKEEiXwYrondmOzSUt5jBph8LlU9tn
         2+RJQAcAG1txASbwDHESSbSvOTNWSxHgqo8uGR4he/vysgjvObIezHYJlm5gSB38TUMg
         jsnDJW1i0VOdPIcBm2pZDOwxJja0s6xVNmwyyNKBCGJo50VdhSRH2Db1seFeAVtDiZDO
         00wVie/1gfmtoZh88VIckWKvXuEubuekoxeMPdR4A8vjW8Zsl7qSVhecTmfNnhdkTlXs
         0Bmg==
X-Gm-Message-State: APjAAAWIGJaTy26xzfd+mTJeTGzz/z8eCCWI25srpuOMrammh56RqnSU
        t9lUYfC7hJO242moQOs+upLx49Ky
X-Google-Smtp-Source: APXvYqzRr1WJH6WbDirEeE3ntY5+MxuZQq0RRkZS7nKLM7/MWP5P/kHICE0DPJpmwaZtCw+U6u52Sw==
X-Received: by 2002:ac2:5dfa:: with SMTP id z26mr34511692lfq.103.1577617457890;
        Sun, 29 Dec 2019 03:04:17 -0800 (PST)
Received: from [192.168.1.36] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id b63sm17222239lfg.79.2019.12.29.03.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2019 03:04:17 -0800 (PST)
Subject: Re: [PATCH] libkmod-module: convert return value from system() to
 errno
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-modules <linux-modules@vger.kernel.org>
References: <f8c64aed-b4a1-e43f-ed4b-f99236932477@gmail.com>
 <CAKi4VAK3pGJt8qA6CVrkwJOa5JLGtc63hWM0UZngp_qJb40jcw@mail.gmail.com>
 <8b27685f-138f-2a5e-3247-2ed2a855b7db@gmail.com>
 <20191228225951.q6g4nyjobpbsfjao@ldmartin-desk1>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <ddf50755-25b9-3919-1b04-4201241f058f@gmail.com>
Date:   Sun, 29 Dec 2019 13:04:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191228225951.q6g4nyjobpbsfjao@ldmartin-desk1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 29.12.2019 0.59, Lucas De Marchi wrote:
> On Tue, Dec 24, 2019 at 11:54:58AM +0200, Topi Miettinen wrote:
>> On 24.12.2019 4.54, Lucas De Marchi wrote:
>>> On Mon, Dec 23, 2019 at 9:07 AM Topi Miettinen <toiwoton@gmail.com> 
>>> wrote:
>>>>
>>>> Don't use exit status of a command directly as errno code, callers
>>>> will be confused.
>>>>
>>>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>>>> ---
>>>>   libkmod/libkmod-module.c | 8 +++++---
>>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
>>>> index 8044a8f..6031d80 100644
>>>> --- a/libkmod/libkmod-module.c
>>>> +++ b/libkmod/libkmod-module.c
>>>> @@ -983,11 +983,13 @@ static int command_do(struct kmod_module *mod,
>>>> const char *type,
>>>>          if (err == -1 || WEXITSTATUS(err)) {
>>>>                  ERR(mod->ctx, "Error running %s command for %s\n",
>>>>                                                                  type,
>>>> modname);
>>>> -               if (err != -1)
>>>> -                       err = -WEXITSTATUS(err);
>>>
>>> I don't think we actually care about differentiating them. So just a 
>>> plain
>>> return -EINVAL;  here would suffice, makes sense?
>>
>> I think it would lose potentially valuable information. For example 
>> EPERM could tell the system administrator of a problem with MAC 
>> configuration preventing execution of the shell, ENOENT could show 
>> that the shell or shared libraries are missing and so forth.
> 
> makes sense, but we take decisions on the callers depending on the
> return value. I don't want to mix that with return values from the
> commands executed. E.g. if the command returned EEXIST the caller would
> treat a fail differently.
> 
> I think it would be good here to give different error messages and
> always return -EINVAL. I'm thinking on squashing the following diff,
> what do you think?

OK, maybe that's better.

-Topi

> 
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 6031d80..714ee21 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -980,13 +980,16 @@ static int command_do(struct kmod_module *mod, 
> const char *type,
>       err = system(cmd);
>       unsetenv("MODPROBE_MODULE");
> 
> -    if (err == -1 || WEXITSTATUS(err)) {
> -        ERR(mod->ctx, "Error running %s command for %s\n",
> -                                type, modname);
> -        if (err != -1) /* nonzero exit status: something bad happened */
> -            return -EINVAL;
> -        else /* child process could not be created */
> -            return -errno;
> +    if (err == -1) {
> +        ERR(mod->ctx, "Could not run %s command '%s' for module %s: %m\n",
> +            type, cmd, modname);
> +        return -EINVAL;
> +    }
> +
> +    if (WEXITSTATUS(err)) {
> +        ERR(mod->ctx, "Error running %s command '%s' for module %s: 
> retcode %d\n",
> +            type, cmd, modname, WEXITSTATUS(err));
> +        return -EINVAL;
>       }
> 
>       return 0;
> 
> 
> thanks
> Lucas De Marchi

