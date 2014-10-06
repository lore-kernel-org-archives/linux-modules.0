MIME-Version: 1.0
In-Reply-To: <CAAXf6LVjWD+08NPqtwJWFVhTz4KE8nnEQNRU+cyNzQz4HQYBKg@mail.gmail.com>
References: <1412062906-27378-1-git-send-email-patrickdepinguin@gmail.com>
	<CAKi4VAKVL7oxZ6dvHbixeihtiOD2GDkHLknht_jSg3-+hWWGBQ@mail.gmail.com>
	<060ab96a-8175-4b77-94a6-6bb843129087@email.android.com>
	<CAKi4VAKpGe7q0Q3HhVCr+0-iGgBBMC5TGcSOckHBed56zs5TNg@mail.gmail.com>
	<CAAXf6LX90woPh+2tm6yCa8EGgGrvYx8D8v+q0tJS1DY5=dM+Rw@mail.gmail.com>
	<CAKi4VAK=FcaCGDbzVwKvYWtLEqF-0uu0WEmbjQHtP5VmoKABdQ@mail.gmail.com>
	<CAAXf6LVjWD+08NPqtwJWFVhTz4KE8nnEQNRU+cyNzQz4HQYBKg@mail.gmail.com>
Date: Mon, 6 Oct 2014 19:42:33 -0300
Message-ID: <CAKi4VALmguvjHkx+fZzxLHA0oKrOdexUhmRFO+8=rk8xw65rRw@mail.gmail.com>
Subject: Re: [PATCH] Add dummy definition of O_CLOEXEC
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Thomas De Schampheleire <patrickdepinguin@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, Robert Yang <liezhi.yang@windriver.com>,
	buildroot <buildroot@busybox.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Fri, Oct 3, 2014 at 7:27 AM, Thomas De Schampheleire
<patrickdepinguin@gmail.com> wrote:
> Hi Lucas,
>
> On Thu, Oct 2, 2014 at 7:55 PM, Lucas De Marchi
> <lucas.de.marchi@gmail.com> wrote:
>
>>>> They shouldn't be defining O_CLOEXEC to 0 in the first place. I don't
>>>> want to support leaking file descriptors to child process. You are
>>>> silently giving different behavior to your target depending on the
>>>> machine it was built with :-o.
>>>
>>> As explained above, this is not what is happening. The O_CLOEXEC dummy
>>> definition to 0 is only relevant when building host tools (depmod) on
>>> old systems like RHEL5. These host tools are effectively run on the
>>> same host where they are built. When building for the target, or when
>>> building on modern host systems, the dummy does not set in and there
>>> is anyway no impact.
>>>
>>> Hope this clarifies,
>>
>> Yep, this clarifies, thanks.
>>
>> However it only makes sense for this specific scenario, i.e. you don't
>> care for depmod leaking fds on the host... It's not something
>> acceptable to do on upstream, sorry.
>
> I'm trying to understand the reason you object to this patch.
>
> We both agree that the dummy implementation of O_CLOEXEC will only
> take effect when building kmod using kernel headers < 2.6.23, correct?

yes. But I don't want to pretend that kmod works fine there. It doesn't.

> In such a case, there are three paths:
>
> 1. Don't make any change (the current situation). In this case, kmod
> cannot be compiled due to the missing O_CLOEXEC definition and thus
> cannot be used at all.
>
> 2. Add a dummy definition (as proposed by the patch) to allow
> compilation of kmod. In this case, the O_CLOEXEC flag will not take
> effect, indeed with the leaking file descriptors into child processes,
> but only in this exceptional case where kmod is built for older
> kernels.

The problem here is that you are silently accepting the misbehave.

>
> 3. Use explicit fcntl(..., FD_CLOEXEC...) calls after the open's.
> However, this is not easily done without impact on the standard case
> with modern headers. I assume you will like this even less.
>
> To me, case 2 seems a valid solution to an otherwise unusable kmod on
> systems with old kernels / kernel headers. The impact of the leaked
> file descriptors is to be accepted in this case.

I'm all for accepting the leaked file descriptors *in this case*. Not
in the general case in which one takes kmod and realizes it works fine
in < 2.6.23. Because it doesn't and pretending it does is just asking
for invalid bug reports.

So as I said, I don't think this is material for upstream.

What we could do is to hide the definition of O_CLOEXEC behind a
configure flag... but then the amount of ifdef, the benefits from it
and having to maintain that on build sys don't pay off IMO.

> However, if you still feel this is not upstreamable, then I will back
> off and hope that Peter will accept the patch in Buildroot :)

I do think this could be accepted there. AFAICS he already acked on
it. Just make sure this is a patch that gets applied on host-kmod
only, not the one running on target. Let's try this approach and come
back to what I suggested above if it becomes too troublesome to
downstream?


-- 
Lucas De Marchi
