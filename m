Return-Path: <SRS0=ZSrg=2O=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EA8C2D0CF
	for <linux-modules@archiver.kernel.org>; Tue, 24 Dec 2019 09:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F27A206B7
	for <linux-modules@archiver.kernel.org>; Tue, 24 Dec 2019 09:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mwym5Dz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfLXJzJ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 24 Dec 2019 04:55:09 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36481 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfLXJzJ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 24 Dec 2019 04:55:09 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so20356817ljg.3
        for <linux-modules@vger.kernel.org>; Tue, 24 Dec 2019 01:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=VVoRwkc53RWAIdvceBsZvyVLaj+pNW7Lgc15okUyeEI=;
        b=Mwym5Dz96twUKsN+TU2duJfxmIIkur0wrlqa6NpBpOYlI8Iy7/D1Wiz1tGLBl+4VWv
         ftWTkO8z5YnbHJ0ozBTFTFqZWnYejSrgGOmzZMU0Qiiv6EEpn7IasxlNWvukKhinX3YR
         NRZoRuM5IyBv314VoTlLZrNFjB2eQKaLxUN7pSTsj4Jxf6haM/QebCWjol1ruqOvJ5qm
         hiyzVu1znhfq/nEcjApRgk04Rx4GQL5n68JiY4GA6glnVu68uT+VGDHnqXHFOXJmtSpp
         Cp8wq4OTwfyNB2ffDoV51RvSpQ9HWXIEkmZ+a8HcobagDMjkmzmhNMDQ2WwSp3xQTqFh
         oYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=VVoRwkc53RWAIdvceBsZvyVLaj+pNW7Lgc15okUyeEI=;
        b=IkwVt9j3XCY0isKedjxcqO2Hv07YfaTmXYvWPZP3Mowpm6SF4lUgoTlXFCntezmgyZ
         jAuTGG9Cago2uEzfWROKjokbCXvBdbygcV44oARcRJj2S8JsCSt/Xyknriv5fOsvULrf
         qPnAOA9bWGcIxfDdmMkRMdjDLep7Xk0XpgN7ZztAWkog1iR+jrciiOm0Rzyz1AMh8Oy5
         mlNgXyTLznm/8762qhvPr03yskWX4VgpRdfyclKCuEb3ZFNlSpgX4xamJ1bQ7ZF7wVba
         dG7yzxv/nTfhBvkG+rxT9hBobJPnoN2JdMl/GrgjfLqJQX7WpC8F8oHSn8Mll3YNzlQK
         UtJQ==
X-Gm-Message-State: APjAAAVafScrC1LqLES8br0fhdfB2IoEKZOsH4yGZuOs3W4UuZZsE2Rb
        rL5kiOWt9s6mYIoZu9/JxgxDk4XZ
X-Google-Smtp-Source: APXvYqxYUBUhlSVtIPTR8ow07PIomawLrU/FgtH9p5w3iHBCnHDpuPQpBXEW+9vEWLZKjarqaeRb0A==
X-Received: by 2002:a2e:9843:: with SMTP id e3mr20622895ljj.45.1577181307423;
        Tue, 24 Dec 2019 01:55:07 -0800 (PST)
Received: from [192.168.1.36] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id k25sm9606587lji.42.2019.12.24.01.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2019 01:55:06 -0800 (PST)
Subject: Re: [PATCH] libkmod-module: convert return value from system() to
 errno
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>
References: <f8c64aed-b4a1-e43f-ed4b-f99236932477@gmail.com>
 <CAKi4VAK3pGJt8qA6CVrkwJOa5JLGtc63hWM0UZngp_qJb40jcw@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <8b27685f-138f-2a5e-3247-2ed2a855b7db@gmail.com>
Date:   Tue, 24 Dec 2019 11:54:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKi4VAK3pGJt8qA6CVrkwJOa5JLGtc63hWM0UZngp_qJb40jcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 24.12.2019 4.54, Lucas De Marchi wrote:
> On Mon, Dec 23, 2019 at 9:07 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>>
>> Don't use exit status of a command directly as errno code, callers
>> will be confused.
>>
>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>> ---
>>    libkmod/libkmod-module.c | 8 +++++---
>>    1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
>> index 8044a8f..6031d80 100644
>> --- a/libkmod/libkmod-module.c
>> +++ b/libkmod/libkmod-module.c
>> @@ -983,11 +983,13 @@ static int command_do(struct kmod_module *mod,
>> const char *type,
>>           if (err == -1 || WEXITSTATUS(err)) {
>>                   ERR(mod->ctx, "Error running %s command for %s\n",
>>                                                                   type,
>> modname);
>> -               if (err != -1)
>> -                       err = -WEXITSTATUS(err);
> 
> I don't think we actually care about differentiating them. So just a plain
> return -EINVAL;  here would suffice, makes sense?

I think it would lose potentially valuable information. For example 
EPERM could tell the system administrator of a problem with MAC 
configuration preventing execution of the shell, ENOENT could show that 
the shell or shared libraries are missing and so forth.

-Topi
