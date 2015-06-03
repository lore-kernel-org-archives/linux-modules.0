MIME-Version: 1.0
In-Reply-To: <CAPXgP10M6W18VwEvRzc_d1Vk_-zPqo_Y4=nwdh-Nk5v6mujMHA@mail.gmail.com>
References: <20150531152932.GA16337@rhlx01.hs-esslingen.de>
	<87r3pwgd0b.fsf@rustcorp.com.au>
	<CAKi4VAJfhM0UMOmFkQ40RW5gJGKch8AH8QEvuiYtj93O+YTNwA@mail.gmail.com>
	<CAPXgP10M6W18VwEvRzc_d1Vk_-zPqo_Y4=nwdh-Nk5v6mujMHA@mail.gmail.com>
Date: Wed, 3 Jun 2015 14:51:09 -0300
Message-ID: <CAKi4VA+n2aJAo9mDX4mnx=3kcGBLwJJAVa+KSYVBPvoMhEErpQ@mail.gmail.com>
Subject: Re: [PATCH] modules: CONFIG_MODULE_COMPRESS: add hint that userspace
 support may easily be missing.
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Kay Sievers <kay@vrfy.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andreas Mohr <andi@lisas.de>,
	Andrew Morton <akpm@linux-foundation.org>, Bertrand Jacquin <beber@meleeweb.net>,
	"Marco d'Itri" <md@linux.it>, linux-modules <linux-modules@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>, Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Jun 3, 2015 at 2:36 PM, Kay Sievers <kay@vrfy.org> wrote:
> On Wed, Jun 3, 2015 at 7:30 PM, Lucas De Marchi
> <lucas.de.marchi@gmail.com> wrote:
>> On Mon, Jun 1, 2015 at 3:26 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>>> Andreas Mohr <andi@lisas.de> writes:
>>>> Hi,
>>>>
>>>> I just had a not so nice experience
>>>> when finally upgrading to a new 4.1-rc5
>>>> with CONFIG_MODULE_COMPRESS newly enabled -
>>>> userspace binary parts (kmod 18 or 20 in my case)
>>>> did not have compression enabled
>>>> (at least on Debian 8pre, vs. encountering it enabled on FC21)
>>>> since it does not seem to be
>>>> the default build configuration of kmod (yet?).
>>>
>>> Sure.  Let's get the maintainers to insert the actual version required
>>> in the help text though.
>>
>> kmod supports gz since the first version and xz since version 3.  So both
>> of them can be safely fall into "it's supported since the beginning of
>> kmod IMO".
>>
>> Regarding the "default configuration", there's no such thing. Each distribution
>> uses a different one.
>
> You could add something similar to this:
>
> $ /usr/lib/systemd/systemd --version
> systemd 220
> +PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP
> +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS
> +KMOD +IDN

Indeed.  I'm planning to do a release very soon and add something like
this to it. If anyone is
interested in contributing such patch it's very welcome, too :-)

-- 
Lucas De Marchi
