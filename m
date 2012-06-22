MIME-Version: 1.0
In-Reply-To: <20120622015341.GA3414@kroah.com>
References: <8762blyedn.fsf@rustcorp.com.au>
	<87obpfxdpr.fsf@rustcorp.com.au>
	<20120522230218.24007.3556.stgit@warthog.procyon.org.uk>
	<7474.1337782847@redhat.com>
	<5107.1337868051@redhat.com>
	<87r4u6w58c.fsf@rustcorp.com.au>
	<20120622015341.GA3414@kroah.com>
Date: Fri, 22 Jun 2012 00:29:46 -0300
Message-ID: <CAKi4VA+ntfH=ezAU77T3WFr6kqgXMb9npJ_msSQyCwps75yuEA@mail.gmail.com>
Subject: Re: [PATCH 00/23] Crypto keys and module signing
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, David Howells <dhowells@redhat.com>, kyle@mcmartin.ca,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	keyrings@linux-nfs.org, linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi,

Sorry to jump into this discussion only now, but
linux-modules@vger.kernel.org was not CC'ed and I was not following
LKML last month.

On Thu, Jun 21, 2012 at 10:53 PM, Greg KH <gregkh@linuxfoundation.org> wrot=
e:
> On Sun, May 27, 2012 at 03:11:23PM +0930, Rusty Russell wrote:
>> > > > Why would you want multiple signatures? =C2=A0That just complicate=
s things.
>> > >
>> > > The code above stays pretty simple; if the signature fails, you set =
size
>> > > to i, and loop again. =C2=A0As I said, if you know exactly how you'r=
e going
>> > > to strip the modules, you can avoid storing the stripped module and
>> > > simply append both signatures.
>> >
>> > You still haven't justified it. =C2=A0One of your arguments about reje=
cting the ELF
>> > parsing version was that it was too big for no useful extra value that=
 I could
>> > justify. =C2=A0Supporting multiple signatures adds extra size and comp=
lexity for no
>> > obvious value.
>>
>> One loop is a lot easier to justify that the ELF-parsing mess. =C2=A0And=
 it
>> can be done in a backwards compatible way tomorrow: old kernels will
>> only check the last signature.
>>
>> I had assumed you'd rather maintain a stable strip util which you can
>> use on kernel modules than rework your module builds. =C2=A0I guess not.
>
> To dig an old thread up, but what really is wrong with the original ELF
> section stuff? =C2=A0Why encode "magic" values on the end of the kernel
> module that then require all userspace tools to be modified in order to
> properly handle this?
>
> When I first did this so many many years ago an elf section made it so
> easy to handle. =C2=A0Userspace didn't need to be modified, and everyone
> knows how to handle elf sections, even the kernel does :)

Indeed. What's wrong with creating an ELF section for this and let
kernel deal with it? I fail to see the need for init_module2()

I need to catch up with this discussion though since I was not aware of tha=
t.


Lucas De Marchi

>
> And I think we really want the ability to have multiple signatures, the
> whole "chain of trust" thing that is needed will work out much better if
> multiple signatures are allowed. =C2=A0Putting it in an elf section allow=
s
> this to work out easier, right?
>
> confused,

me too.


Lucas De Marchi
