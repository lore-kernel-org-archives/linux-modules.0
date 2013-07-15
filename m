Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48]:49500 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932646Ab3GOPjs (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Mon, 15 Jul 2013 11:39:48 -0400
Received: by mail-vb0-f48.google.com with SMTP id w15so3199386vbf.21
        for <linux-modules@vger.kernel.org>; Mon, 15 Jul 2013 08:39:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+mSPTi5pEN-Ps6XwndOvCfk_qZ1qnXaa4QoJsP_OPj-3yiatQ@mail.gmail.com>
References: <1373865179-18366-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1373865179-18366-2-git-send-email-lucas.demarchi@profusion.mobi> <CA+mSPTi5pEN-Ps6XwndOvCfk_qZ1qnXaa4QoJsP_OPj-3yiatQ@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 15 Jul 2013 12:39:27 -0300
Message-ID: <CAMOw1v5tu7+9GaySzLeztEa0OzBNktfss=rDo_SoiRETNh9zGw@mail.gmail.com>
Subject: Re: [PATCH 2/6] util: Add mkdir_p implementation from testsuite
To: Dave Reisner <d@falconindy.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jul 15, 2013 at 8:11 AM, Dave Reisner <d@falconindy.com> wrote:
>
> On Jul 15, 2013 1:13 AM, "Lucas De Marchi" <lucas.demarchi@profusion.mobi>
> wrote:
>>
>> From: Lucas De Marchi <lucas.demarchi@intel.com>
>>
>> ---
>>  Makefile.am             |  1 -
>>  libkmod/libkmod-util.c  | 64 ++++++++++++++++++++++++++++++++++++
>>  libkmod/libkmod-util.h  |  1 +
>>  testsuite/init_module.c |  1 -
>>  testsuite/mkdir.c       | 86
>> -------------------------------------------------
>>  testsuite/mkdir.h       | 24 --------------
>>  6 files changed, 65 insertions(+), 112 deletions(-)
>>  delete mode 100644 testsuite/mkdir.c
>>  delete mode 100644 testsuite/mkdir.h
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index 0ed944c..57b7372 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -154,7 +154,6 @@ testsuite_path_la_LDFLAGS =
>> $(TESTSUITE_OVERRIDE_LIBS_LDFLAGS)
>>  testsuite_delete_module_la_LDFLAGS = $(TESTSUITE_OVERRIDE_LIBS_LDFLAGS)
>>  testsuite_init_module_la_LDFLAGS = $(TESTSUITE_OVERRIDE_LIBS_LDFLAGS)
>>  testsuite_init_module_la_SOURCES = testsuite/init_module.c \
>> -                                  testsuite/mkdir.c testsuite/mkdir.h \
>>                                    testsuite/stripped-module.h
>>  testsuite_init_module_la_LIBADD = libkmod/libkmod-internal.la
>>
>> diff --git a/libkmod/libkmod-util.c b/libkmod/libkmod-util.c
>> index e636ae1..5c680e7 100644
>> --- a/libkmod/libkmod-util.c
>> +++ b/libkmod/libkmod-util.c
>> @@ -2,6 +2,8 @@
>>   * libkmod - interface to kernel module operations
>>   *
>>   * Copyright (C) 2011-2013  ProFUSION embedded systems
>> + * Copyright (C) 2013  Intel Corporation. All rights reserved.
>> + * Copyright (C) 2012  Lucas De Marchi <lucas.de.marchi@gmail.com>
>>   *
>>   * This library is free software; you can redistribute it and/or
>>   * modify it under the terms of the GNU Lesser General Public
>> @@ -308,6 +310,68 @@ char *path_make_absolute_cwd(const char *p)
>>         return r;
>>  }
>>
>> +static inline int is_dir(const char *path)
>> +{
>> +       struct stat st;
>> +
>> +       if (stat(path, &st) >= 0) {
>> +               if (S_ISDIR(st.st_mode))
>> +                       return 1;
>> +               return 0;
>
> Why not just return S_ISDIR(st.st_mode);

I can just blame lack of caffeine ;-). I will change it before pushing.

Thanks
Lucas De Marchi
