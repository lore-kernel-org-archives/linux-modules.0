Return-Path: <lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
In-Reply-To: <20130730165442.GI674@rampage>
References: <1375166895-20350-1-git-send-email-lucas.demarchi@profusion.mobi>
 <20130730131717.GF674@rampage> <CAKi4VALD+Kkq6ijg+-UXOcAaohGSUpCahNQT0oodCCOa9SZ54A@mail.gmail.com>
 <20130730165442.GI674@rampage>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 30 Jul 2013 14:53:09 -0300
Message-ID: <CAMOw1v7vN1C7s_bkNym4CXiwEJxT=q0K9H+ajoy6UUw8f6jwkA@mail.gmail.com>
Subject: Re: [PATCH 1/3] shell-completion: Add initial completion for kmod
To: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jul 30, 2013 at 1:54 PM, Dave Reisner <d@falconindy.com> wrote:
> On Tue, Jul 30, 2013 at 11:25:27AM -0300, Lucas De Marchi wrote:
>> On Tue, Jul 30, 2013 at 10:17 AM, Dave Reisner <d@falconindy.com> wrote:
>> > On Tue, Jul 30, 2013 at 03:48:13AM -0300, Lucas De Marchi wrote:
>> >> From: Lucas De Marchi <lucas.demarchi@intel.com>
>> >>
>> >> Skeleton pulled from udevadm in systemd and adapted to kmod needs.
>> >> ---
>> >>  NEWS                       |  2 +-
>> >>  shell-completion/bash/kmod | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>> >>  2 files changed, 54 insertions(+), 1 deletion(-)
>> >>  create mode 100644 shell-completion/bash/kmod
>> >>
>> >> diff --git a/NEWS b/NEWS
>> >> index 1dff366..491146d 100644
>> >> --- a/NEWS
>> >> +++ b/NEWS
>> >> @@ -6,7 +6,7 @@ kmod 15
>> >>
>> >>  - New features:
>> >>       - kmod static-nodes creates parent directories if given a -o option
>> >> -     - kmod binary doesn't statically link to libkmod
>> >> +     - kmod binary statically link to libkmod
>> >>
>> >>  kmod 14
>> >>  =======
>> >> diff --git a/shell-completion/bash/kmod b/shell-completion/bash/kmod
>> >> new file mode 100644
>> >> index 0000000..81dbf46
>> >> --- /dev/null
>> >> +++ b/shell-completion/bash/kmod
>> >> @@ -0,0 +1,53 @@
>> >> +# kmod completion                                          -*- shell-script -*-
>> >> +#
>> >> +# This file is part of systemd.
>> >> +#
>> >> +# Copyright 2010 Ran Benita
>> >> +# Copyright (C) 2013  Intel Corporation. All rights reserved.
>> >> +#
>> >> +# systemd is free software; you can redistribute it and/or modify it
>> >> +# under the terms of the GNU Lesser General Public License as published by
>> >> +# the Free Software Foundation; either version 2.1 of the License, or
>> >> +# (at your option) any later version.
>> >> +#
>> >> +# systemd is distributed in the hope that it will be useful, but
>> >> +# WITHOUT ANY WARRANTY; without even the implied warranty of
>> >> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
>> >> +# General Public License for more details.
>> >> +#
>> >> +# You should have received a copy of the GNU Lesser General Public License
>> >> +# along with systemd; If not, see <http://www.gnu.org/licenses/>.
>> >> +
>> >> +__contains_word () {
>> >> +    local word=$1; shift
>> >> +    for w in $*; do [[ $w = $word ]] && return 0; done
>> >
>> > Should be "$@", not $*, and "$word", not $word.
>>
>> As said in the commit message, this was taken from systemd. You may
>> want to change there as well ;-)
>>
>
> Yeah, been meaning to do that for a while now.
>
>> >
>> >> +    return 1
>> >> +}
>> >> +
>> >> +_kmod() {
>> >> +    local cur=${COMP_WORDS[COMP_CWORD]} prev=${COMP_WORDS[COMP_CWORD-1]}
>> >> +    local verb comps
>> >> +
>> >> +    local -A VERBS=(
>> >> +     [HELP]='help'
>> >> +     [LIST]='list'
>> >> +     [STATIC-NODES]='static-nodes'
>> >
>> > It seems you have tabs here instead of spaces. I think you probably want
>>
>> It seems like emacs is not passing the experimentation period.
>>
>> > the top level actions in a single list, not broken out like this.
>> > Subsequent options for the toplevel actions would want to be broken out
>> > in an associative array like you have here.
>>
>> But then how can I take the different actions needed by -f, -o?
>
> Writing completion for a "multi-call" tool like this is painful. I'd
> suggest switching on the verb and writing a separate function for each
> one. I guess udevadm does something similar to this, but it doesn't mean
> I have to agree with it ;) It's a strange mapping, and I don't really
> see what it accomplishes.

A follow up: like you suggested here and on IRC... each subcommand now
can have its own function and is called with "if declare -F
_kmod_${func} > /dev/null; then _kmod_${func}; fi" in the end of
_kmod function


Thanks, it's now pushed.

Lucas De Marchi
