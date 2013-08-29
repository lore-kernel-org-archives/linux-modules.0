Return-Path: <thomas.petazzoni@free-electrons.com>
Date: Thu, 29 Aug 2013 09:49:32 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] Add configure check for _Static_assert()
Message-ID: <20130829094932.20c35e84@skate>
In-Reply-To: <CAKi4VALsZAMwKyT8U-Jcg+E_Hm_CyiwKJf+Kr3Y-JP_7Ze5D6w@mail.gmail.com>
References: <1377704031-12501-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAKi4VALsZAMwKyT8U-Jcg+E_Hm_CyiwKJf+Kr3Y-JP_7Ze5D6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-modules.vger.kernel.org>

Dear Lucas De Marchi,

On Thu, 29 Aug 2013 00:55:04 -0300, Lucas De Marchi wrote:
> Hi Thomas,
> 
> On Wed, Aug 28, 2013 at 12:33 PM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > Commit 8efede20ef ("Use _Static_assert") introduced the usage of
> > _Static_assert(). However, _Static_assert() is a fairly new thing,
> > since it was introduced only in gcc 4.6. In order to support older
> 
> What distro is still in gcc 4.6? Is it a LTS one?

It's not a distro. As you know, I work on the Buildroot project, a tool
that builds rootfs for embedded Linux systems using cross-compilation.
One of the package we have is obviously kmod, but since we support a
wide range of architectures, not all of them are necessarily fully
up-to-date in terms of compiler version. The specific example that
raised the problem is a gcc 4.5.x toolchain for PowerPC provided by
Mentor Graphics Sourcery CodeBench (formerly known as CodeSourcery).

> > +#if defined(HAVE_STATIC_ASSERT)
> >  #define assert_cc(expr) \
> >         _Static_assert((expr), #expr)
> > +#else
> > +#define assert_cc(expr)
> 
> could you then define it similarly to what it was before then in this #else?
> 
> I think this would do it (totally untested) with the downside of an
> ugly build error.
> 
> #define assert_cc(expr) \
>        do { (void) sizeof(char [1 - 2*!(expr)]); } while(0)

Sure, will fix this and resend.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
