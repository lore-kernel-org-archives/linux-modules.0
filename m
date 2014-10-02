Return-Path: <patrickdepinguin@gmail.com>
Return-Path: <patrickdepinguin@gmail.com>
In-Reply-To: <CAKi4VAKVL7oxZ6dvHbixeihtiOD2GDkHLknht_jSg3-+hWWGBQ@mail.gmail.com>
References: <1412062906-27378-1-git-send-email-patrickdepinguin@gmail.com> <CAKi4VAKVL7oxZ6dvHbixeihtiOD2GDkHLknht_jSg3-+hWWGBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] Add dummy definition of O_CLOEXEC
From: Thomas De Schampheleire <patrickdepinguin@gmail.com>
Date: Thu, 02 Oct 2014 07:31:01 +0200
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: linux-modules <linux-modules@vger.kernel.org>,Robert Yang <liezhi.yang@windriver.com>
Message-ID: <060ab96a-8175-4b77-94a6-6bb843129087@email.android.com>
List-ID: <linux-modules.vger.kernel.org>

Lucas De Marchi <lucas.de.marchi@gmail.com> schreef:
>On Tue, Sep 30, 2014 at 4:41 AM, Thomas De Schampheleire
><patrickdepinguin@gmail.com> wrote:
>> From: Robert Yang <liezhi.yang@windriver.com>
>>
>> O_CLOEXEC is introduced from Linux 2.6.23, so old kernel doesn't have
>> it, we need check before use.
>
>Humn... Do we really want to support kernels older than 2.6.23?
>
>Adding a workaround like this IMO will just hide bugs because we rely
>on O_CLOEXEC semantics. Doing nothing is not really what we want.
>Maybe if ancient downstream distros want the workaround they can
>define O_CLOEXEC by themselves during build... passing it in CFLAGS
>should work
>

This is the same type of distro for which the
 implementation of be32toh was needed: RHEL5.
Ancient, yes, but still supported and used in corporate
 environments, also to build modern systems, for
 example using Buildroot or Openembedded.

The patch comes from openembedded and is about
 to be integrated in Buildroot too, but it's far more
 advantageous to have such changes integrated
 upstream.

Thanks,
Thomas
