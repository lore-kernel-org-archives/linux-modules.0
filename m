Return-Path: <patrickdepinguin@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKi4VAKpGe7q0Q3HhVCr+0-iGgBBMC5TGcSOckHBed56zs5TNg@mail.gmail.com>
References: <1412062906-27378-1-git-send-email-patrickdepinguin@gmail.com>
 <CAKi4VAKVL7oxZ6dvHbixeihtiOD2GDkHLknht_jSg3-+hWWGBQ@mail.gmail.com>
 <060ab96a-8175-4b77-94a6-6bb843129087@email.android.com> <CAKi4VAKpGe7q0Q3HhVCr+0-iGgBBMC5TGcSOckHBed56zs5TNg@mail.gmail.com>
From: Thomas De Schampheleire <patrickdepinguin@gmail.com>
Date: Thu, 2 Oct 2014 15:29:36 +0200
Message-ID: <CAAXf6LX90woPh+2tm6yCa8EGgGrvYx8D8v+q0tJS1DY5=dM+Rw@mail.gmail.com>
Subject: Re: [PATCH] Add dummy definition of O_CLOEXEC
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, Robert Yang <liezhi.yang@windriver.com>,
	buildroot <buildroot@busybox.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Oct 2, 2014 at 2:07 PM, Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
> On Thu, Oct 2, 2014 at 2:31 AM, Thomas De Schampheleire
> <patrickdepinguin@gmail.com> wrote:
>> Lucas De Marchi <lucas.de.marchi@gmail.com> schreef:
>>>On Tue, Sep 30, 2014 at 4:41 AM, Thomas De Schampheleire
>>><patrickdepinguin@gmail.com> wrote:
>>>> From: Robert Yang <liezhi.yang@windriver.com>
>>>>
>>>> O_CLOEXEC is introduced from Linux 2.6.23, so old kernel doesn't have
>>>> it, we need check before use.
>>>
>>>Humn... Do we really want to support kernels older than 2.6.23?
>>>
>>>Adding a workaround like this IMO will just hide bugs because we rely
>>>on O_CLOEXEC semantics. Doing nothing is not really what we want.
>>>Maybe if ancient downstream distros want the workaround they can
>>>define O_CLOEXEC by themselves during build... passing it in CFLAGS
>>>should work
>>>
>>
>> This is the same type of distro for which the
>>  implementation of be32toh was needed: RHEL5.
>
> Similar, but not the same. For the implementation of be32toh we depend
> on *libc* having it. As I said in the original email, I was surprised
> a libc could possibly miss it, but I was ok with adding a fallback
> implementation (maybe we should even go one step further and do what
> systemd does to check our use cases with sparse).
>
>
>> Ancient, yes, but still supported and used in corporate
>>  environments, also to build modern systems, for
>>  example using Buildroot or Openembedded.
>
> That's my worry. If you are building modern systems and you don't have
> O_CLOEXEC (and assuming you are not trying to put 2.6.22 in your
> embedded system), I'd say you are using the wrong headers, from host
> instead of target.

In Buildroot, we're not leaking host kernel headers into the target.
The kernel headers used for target compilation are those coming with
the toolchain, which are recent kernel headers supporting O_CLOEXEC.

The problem I'm encountering (and people on OpenEmbedded apparently
have too) is when building host-kmod, that is the kmod tools that run
on the host system (depmod -->  kmod). These are (in buildroot at
least) built using the toolchain on the host system, and thus with the
kernel headers from the host system.
On RHEL5 systems these are old kernel headers from pre-O_CLOEXEC times.

>
>> The patch comes from openembedded and is about
>>  to be integrated in Buildroot too, but it's far more
>>  advantageous to have such changes integrated
>>  upstream.
>
>
> They shouldn't be defining O_CLOEXEC to 0 in the first place. I don't
> want to support leaking file descriptors to child process. You are
> silently giving different behavior to your target depending on the
> machine it was built with :-o.

As explained above, this is not what is happening. The O_CLOEXEC dummy
definition to 0 is only relevant when building host tools (depmod) on
old systems like RHEL5. These host tools are effectively run on the
same host where they are built. When building for the target, or when
building on modern host systems, the dummy does not set in and there
is anyway no impact.

Hope this clarifies,

Thomas
