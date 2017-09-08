MIME-Version: 1.0
In-Reply-To: <20170809000942.GV27873@wotan.suse.de>
References: <1500645920-28490-1-git-send-email-matt.redfearn@imgtec.com>
	<20170802001200.GD18884@wotan.suse.de>
	<20170809000942.GV27873@wotan.suse.de>
Date: Fri, 8 Sep 2017 14:23:23 -0700
Message-ID: <CAKi4VA+11OV=28_uFa+JLY64oQ11+V8pF8eM5Y_Nx1UfCnAhCg@mail.gmail.com>
Subject: Re: [RFC PATCH] exec: Avoid recursive modprobe for binary format handlers
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Mian Yousaf Kaukab <yousaf.kaukab@suse.com>, Matt Redfearn <matt.redfearn@imgtec.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dan Carpenter <dan.carpenter@oracle.com>, Kees Cook <keescook@chromium.org>,
	Jessica Yu <jeyu@redhat.com>, Michal Marek <mmarek@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@linux-mips.org,
	Petr Mladek <pmladek@suse.com>, linux-fsdevel@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Tue, Aug 8, 2017 at 5:09 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Wed, Aug 02, 2017 at 02:12:00AM +0200, Luis R. Rodriguez wrote:
>> On Fri, Jul 21, 2017 at 03:05:20PM +0100, Matt Redfearn wrote:
>> > diff --git a/fs/exec.c b/fs/exec.c
>> > index 62175cbcc801..004bb50a01fe 100644
>> > --- a/fs/exec.c
>> > +++ b/fs/exec.c
>> > @@ -1644,6 +1644,9 @@ int search_binary_handler(struct linux_binprm *bprm)
>> >             if (printable(bprm->buf[0]) && printable(bprm->buf[1]) &&
>> >                 printable(bprm->buf[2]) && printable(bprm->buf[3]))
>> >                     return retval;
>> > +           /* Game over if we need to load a module to execute modprobe */
>> > +           if (strcmp(bprm->filename, modprobe_path) == 0)
>> > +                   return retval;
>>
>> Wouldn't this just break having a binfmt used for modprobe always?
>
> The place where you put the check is when a system has CONFIG_MODULES
> and a first search for built-in handlers yielded no results so it would
> not break that for built-in.
>
> Thinking about this a little further, having an binfmd handler not built-in
> seems to really be the issue in this particular case and indeed having one as
> modular really just makes no sense as modprobe would be needed.
>
> Although the alternative patch I suggested still makes sense for a *generic
> loop detection complaint/error fix, putting this check in place and bailing
> still makes sense as well, but this sort of thing seems to be the type of
> system build error userspace could try to pick up on pro-actively, ie you
> should not get to the point you boot into this, the build system should somehow
> complain about it.
>
> Cc'ing linux-modules folks to see if perhaps kmod could do something about this
> more proactively.

Tracking at runtime with modprobe/libkmod would be really difficult as
a module can be loaded
from different sources. I don't see a reliable way to do that. One
thing often forgotten
is that due to install rules the user can even add anything as a
dependency with kmod not
even knowing about (softdep is related, but at least kmod knows what
the user is trying to do
and use it to handle dependencies).

For this particular case, not going through the modprobe helper would
be a way to accomplish that since
you wouldn't need the corresponding binfmt module to run modprobe.
Udev handles module
loading via libkmod , but the only way to trigger it is via the rules
rather than via a request from kernel.


Lucas De Marchi
