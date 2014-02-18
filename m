MIME-Version: 1.0
In-Reply-To: <20140218191020.12a65822@gentp.lnet>
References: <20140216222340.153307f5@gentp.lnet>
	<CA+5PVA417O+uny=q5yZk22gVZi2zojrUGHQrq05XuXDUSW_KgA@mail.gmail.com>
	<20140218191020.12a65822@gentp.lnet>
Date: Tue, 18 Feb 2014 15:39:39 -0300
Message-ID: <CAKi4VAKVGhfzXrAhL1KYP6NwngTZt6mTNHfAE3phZm=fN1GCVA@mail.gmail.com>
Subject: Re: Proposal: Add a depmod wrapper for kmod to aid SELinux
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Luis Ressel <aranea@aixah.de>
Cc: Josh Boyer <jwboyer@fedoraproject.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Feb 18, 2014 at 3:10 PM, Luis Ressel <aranea@aixah.de> wrote:
> On Mon, 17 Feb 2014 08:47:05 -0500
> Josh Boyer <jwboyer@fedoraproject.org> wrote:
>
>> Can you elaborate on the different set of SELinux labels/permissions
>> for depmod?  Fedora ships with SELinux enforcing enabled and we've not
>> had any issues with depmod being under the system_u:object_r:bin_t:s0
>> label.  I'm curious what you're trying to set depmod to and why.
>
> That's because Fedora uses a "targeted" SELinux policy by default and
> therefore only restricts the permissions of daemons. Users are
> "unconfined" - they keep their full permission set. Depmod is called
> interactively and gets full root access, just as without SELinux.
>
> I use a "strict" policy which also restricts users. In that case, root
> normally doesn't have the permissions needed by modprobe or depmod.
> Thus, they have to be labeled specially: depmod_t for depmod and
> insmod_t for the other kmod tools.
>
>> This seems somewhat over-engineered.  Wouldn't it be simpler to copy
>> the kmod binary itself to a real file called 'depmod' during the
>> installation?
>
> You're absolutely right. I just didn't think of that. In some cases
> this might create an unpleasant size overhead, but for kmod that
> overhead is negligible. Since kmod's make install target doesn't create
> the symlinks, it also doesn't have to care about this. I therefore
> withdraw my proposal.

You can use hardlinks as well, so you don't have the size overhead:

=E2=94=94 bin =E2=9E=A4 ls -li kmod
1450802 -rwxr-xr-x 2 root root 665285 Jan 26 18:07 kmod
=E2=94=94 bin =E2=9E=A4 ls -li modprobe
1450802 -rwxr-xr-x 2 root root 665285 Jan 26 18:07 modprobe
=E2=94=94 bin =E2=9E=A4 ./modprobe -h
Usage:
        modprobe [options] [-i] [-b] modulename
        ...


>
> However, in case you add the functionality of creating the symlinks to
> the Makefile in the future, it would be neat to offer this approach as
> a configurable alternative. (Only for depmod, though, the other tools
> can stay symlinks).

ok... in the very first versions kmod we had code in the install
target to create the symlinks... However back then we had to deal with
all different distros putting modprobe/depmod in different
directories. We decided to stop doing that and let the distros create
them.

My personal plan is to move away from modprobe/insmod/rmmod/depmod and
instead use only kmod as a tool. I'll remember your problem with
SELinux if/when we have a useful kmod tool and provide an alternative

Lucas De Marchi
