MIME-Version: 1.0
In-Reply-To: <87zj4fte9r.fsf@rustcorp.com.au>
References: <20150531152932.GA16337@rhlx01.hs-esslingen.de>
	<87r3pwgd0b.fsf@rustcorp.com.au>
	<CAKi4VAJfhM0UMOmFkQ40RW5gJGKch8AH8QEvuiYtj93O+YTNwA@mail.gmail.com>
	<87h9qouuny.fsf@rustcorp.com.au>
	<CAKi4VA+4mFsg7VCqr+3wd4dCqUtCW02YP7KYmVYF0prH5bet0g@mail.gmail.com>
	<87zj4fte9r.fsf@rustcorp.com.au>
Date: Sun, 7 Jun 2015 03:18:53 -0300
Message-ID: <CAKi4VAJpRGiTdOouP8M1eZtw5eZwRE6tLRqSLApRixEsVJv+OA@mail.gmail.com>
Subject: Re: [PATCH] modules: CONFIG_MODULE_COMPRESS: add hint that userspace
 support may easily be missing.
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andreas Mohr <andi@lisas.de>, Andrew Morton <akpm@linux-foundation.org>,
	Bertrand Jacquin <beber@meleeweb.net>, "Marco d'Itri" <md@linux.it>,
	linux-modules <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Jun 4, 2015 at 5:22 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
>>> +         gzip and xz (but doesn't by default, at least as of version 18!).
>>
>> This is pretty much misleading. There's no such a default option. It's
>> like saying kernel doesn't support feature X, Y or Z by default
>> because make defconfig doesn't turn them on.
>
> Nobody except Linus expects a defconfig to boot.
>
> I expect ./configure to give me a working tool; these *are* defaults,
> and setting them *is* your responsibility as author.  When it became an
> in-kernel option rather than some weird distro thing, the old default
> was wrong.
>
> ... Though I hadn't realized that Marco had deliberately decided to
> leave support off.  Surprising, since liblzma and libz seem required on
> Debian anyway.

As you can see, no default to something else will make distros adopt that.
I long ago decided not to provide a default for compression because it's
clearly not agreed upon.  Instead it's everything disabled and the
distro chooses what it wants to support.

So if you think the configuration for your distro should be something else,
convince the maintainer to change it showing why it's important.

FYI I'm adding in kmod the ability to query the flags used during build. So
now we have:

$ ./tools/kmod --version
kmod version 20
+XZ +ZLIB -EXPERIMENTAL

This will be present in kmod 21

-- 
Lucas De Marchi
