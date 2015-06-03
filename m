MIME-Version: 1.0
In-Reply-To: <87r3pwgd0b.fsf@rustcorp.com.au>
References: <20150531152932.GA16337@rhlx01.hs-esslingen.de>
	<87r3pwgd0b.fsf@rustcorp.com.au>
Date: Wed, 3 Jun 2015 14:30:32 -0300
Message-ID: <CAKi4VAJfhM0UMOmFkQ40RW5gJGKch8AH8QEvuiYtj93O+YTNwA@mail.gmail.com>
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

On Mon, Jun 1, 2015 at 3:26 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Andreas Mohr <andi@lisas.de> writes:
>> Hi,
>>
>> I just had a not so nice experience
>> when finally upgrading to a new 4.1-rc5
>> with CONFIG_MODULE_COMPRESS newly enabled -
>> userspace binary parts (kmod 18 or 20 in my case)
>> did not have compression enabled
>> (at least on Debian 8pre, vs. encountering it enabled on FC21)
>> since it does not seem to be
>> the default build configuration of kmod (yet?).
>
> Sure.  Let's get the maintainers to insert the actual version required
> in the help text though.

kmod supports gz since the first version and xz since version 3.  So both
of them can be safely fall into "it's supported since the beginning of
kmod IMO".

Regarding the "default configuration", there's no such thing. Each distribution
uses a different one.

-- 
Lucas De Marchi
