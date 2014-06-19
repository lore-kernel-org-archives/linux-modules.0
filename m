Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:45731 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965603AbaFSVpk (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 19 Jun 2014 17:45:40 -0400
Received: by mail-qg0-f41.google.com with SMTP id i50so2701696qgf.14
        for <linux-modules@vger.kernel.org>; Thu, 19 Jun 2014 14:45:40 -0700 (PDT)
Received: from xps9000.cristianrodriguez.net (pc-42-108-74-200.cm.vtr.net. [200.74.108.42])
        by mx.google.com with ESMTPSA id b51sm3973453qgd.49.2014.06.19.14.45.37
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 19 Jun 2014 14:45:38 -0700 (PDT)
Message-ID: <53A359E4.8050906@opensuse.org>
Date: Thu, 19 Jun 2014 17:45:08 -0400
From: =?UTF-8?B?Q3Jpc3RpYW4gUm9kcsOtZ3Vleg==?= <crrodriguez@opensuse.org>
MIME-Version: 1.0
To: linux-modules@vger.kernel.org
CC: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] RESEND: add missing O_CLOEXEC in kmod_module_get_size()
References: <1403139060-147474-1-git-send-email-crrodriguez@opensuse.org> <CAKi4VAKh6Z67OQekiSxm_aY1i7u1v1_PDNW8CxTQOrPqfKktMg@mail.gmail.com>
In-Reply-To: <CAKi4VAKh6Z67OQekiSxm_aY1i7u1v1_PDNW8CxTQOrPqfKktMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

El jue 19 jun 2014 17:08:21 CLT, Lucas De Marchi escribió:
> On Wed, Jun 18, 2014 at 9:51 PM, Cristian Rodríguez
> <crrodriguez@opensuse.org> wrote:
>> ---
>>  libkmod/libkmod-module.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
>> index 1d90f34..8046262 100644
>> --- a/libkmod/libkmod-module.c
>> +++ b/libkmod/libkmod-module.c
>> @@ -1781,7 +1781,7 @@ KMOD_EXPORT long kmod_module_get_size(const struct kmod_module *mod)
>>          * loaded.
>>          */
>>         snprintf(line, sizeof(line), "/sys/module/%s", mod->name);
>> -       dfd = open(line, O_RDONLY);
>> +       dfd = open(line, O_RDONLY|O_CLOEXEC);
>>         if (dfd < 0)
>>                 return -errno;
>>
>> --
>
> I don't know what's  the RESEND in the subject, but the patch looks
> good. I removed it and applied.
>
> Thanks.
>

That means I sent it before months ago but didn't get an answer and/or 
it applied.


--
Cristian
"I don't know the key to success, but the key to failure is trying to 
please everybody."
