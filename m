MIME-Version: 1.0
In-Reply-To: <060ab96a-8175-4b77-94a6-6bb843129087@email.android.com>
References: <1412062906-27378-1-git-send-email-patrickdepinguin@gmail.com>
	<CAKi4VAKVL7oxZ6dvHbixeihtiOD2GDkHLknht_jSg3-+hWWGBQ@mail.gmail.com>
	<060ab96a-8175-4b77-94a6-6bb843129087@email.android.com>
Date: Thu, 2 Oct 2014 09:07:06 -0300
Message-ID: <CAKi4VAKpGe7q0Q3HhVCr+0-iGgBBMC5TGcSOckHBed56zs5TNg@mail.gmail.com>
Subject: Re: [PATCH] Add dummy definition of O_CLOEXEC
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Thomas De Schampheleire <patrickdepinguin@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, Robert Yang <liezhi.yang@windriver.com>,
	buildroot <buildroot@busybox.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Oct 2, 2014 at 2:31 AM, Thomas De Schampheleire
<patrickdepinguin@gmail.com> wrote:
> Lucas De Marchi <lucas.de.marchi@gmail.com> schreef:
>>On Tue, Sep 30, 2014 at 4:41 AM, Thomas De Schampheleire
>><patrickdepinguin@gmail.com> wrote:
>>> From: Robert Yang <liezhi.yang@windriver.com>
>>>
>>> O_CLOEXEC is introduced from Linux 2.6.23, so old kernel doesn't have
>>> it, we need check before use.
>>
>>Humn... Do we really want to support kernels older than 2.6.23?
>>
>>Adding a workaround like this IMO will just hide bugs because we rely
>>on O_CLOEXEC semantics. Doing nothing is not really what we want.
>>Maybe if ancient downstream distros want the workaround they can
>>define O_CLOEXEC by themselves during build... passing it in CFLAGS
>>should work
>>
>
> This is the same type of distro for which the
>  implementation of be32toh was needed: RHEL5.

Similar, but not the same. For the implementation of be32toh we depend
on *libc* having it. As I said in the original email, I was surprised
a libc could possibly miss it, but I was ok with adding a fallback
implementation (maybe we should even go one step further and do what
systemd does to check our use cases with sparse).


> Ancient, yes, but still supported and used in corporate
>  environments, also to build modern systems, for
>  example using Buildroot or Openembedded.

That's my worry. If you are building modern systems and you don't have
O_CLOEXEC (and assuming you are not trying to put 2.6.22 in your
embedded system), I'd say you are using the wrong headers, from host
instead of target.

> The patch comes from openembedded and is about
>  to be integrated in Buildroot too, but it's far more
>  advantageous to have such changes integrated
>  upstream.


They shouldn't be defining O_CLOEXEC to 0 in the first place. I don't
want to support leaking file descriptors to child process. You are
silently giving different behavior to your target depending on the
machine it was built with :-o.

CC'ing buildroot mailing list. Peter, do you do this for other packages as well?


-- 
Lucas De Marchi
