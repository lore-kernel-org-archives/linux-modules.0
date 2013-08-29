Return-Path: <lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
In-Reply-To: <20130829094932.20c35e84@skate>
References: <1377704031-12501-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAKi4VALsZAMwKyT8U-Jcg+E_Hm_CyiwKJf+Kr3Y-JP_7Ze5D6w@mail.gmail.com> <20130829094932.20c35e84@skate>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 29 Aug 2013 17:19:34 -0300
Message-ID: <CAMOw1v7LAk0mmd-qkH4AscbMz06qSf+Cag0L_9LbNpsc8Vkf7Q@mail.gmail.com>
Subject: Re: [PATCH] Add configure check for _Static_assert()
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-modules.vger.kernel.org>

On Thu, Aug 29, 2013 at 4:49 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Lucas De Marchi,
>
> On Thu, 29 Aug 2013 00:55:04 -0300, Lucas De Marchi wrote:
>> Hi Thomas,
>>
>> On Wed, Aug 28, 2013 at 12:33 PM, Thomas Petazzoni
>> <thomas.petazzoni@free-electrons.com> wrote:
>> > Commit 8efede20ef ("Use _Static_assert") introduced the usage of
>> > _Static_assert(). However, _Static_assert() is a fairly new thing,
>> > since it was introduced only in gcc 4.6. In order to support older
>>
>> What distro is still in gcc 4.6? Is it a LTS one?
>
> It's not a distro. As you know, I work on the Buildroot project, a tool
> that builds rootfs for embedded Linux systems using cross-compilation.
> One of the package we have is obviously kmod, but since we support a
> wide range of architectures, not all of them are necessarily fully
> up-to-date in terms of compiler version. The specific example that
> raised the problem is a gcc 4.5.x toolchain for PowerPC provided by
> Mentor Graphics Sourcery CodeBench (formerly known as CodeSourcery).

ok

>
>> > +#if defined(HAVE_STATIC_ASSERT)
>> >  #define assert_cc(expr) \
>> >         _Static_assert((expr), #expr)
>> > +#else
>> > +#define assert_cc(expr)
>>
>> could you then define it similarly to what it was before then in this #else?
>>
>> I think this would do it (totally untested) with the downside of an
>> ugly build error.
>>
>> #define assert_cc(expr) \
>>        do { (void) sizeof(char [1 - 2*!(expr)]); } while(0)
>
> Sure, will fix this and resend.

ok

Lucas De Marchi
