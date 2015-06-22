MIME-Version: 1.0
In-Reply-To: <CAKi4VA+ORsVxeQTRoUa7DhisaAW=uPuWr=U-Ernuek64mymPXQ@mail.gmail.com>
References: <1434974957-2995-1-git-send-email-ncopa@alpinelinux.org>
	<CAKi4VA+ORsVxeQTRoUa7DhisaAW=uPuWr=U-Ernuek64mymPXQ@mail.gmail.com>
Date: Mon, 22 Jun 2015 11:30:40 -0300
Message-ID: <CAKi4VALhw3+irr7vbwDtYjBmU_fC7_SxPeYK=2b1Frn7eS=b8A@mail.gmail.com>
Subject: Re: [PATCH] build: let sed use posix ERE instead of GNU extension
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jun 22, 2015 at 11:20 AM, Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
> Hi,
>
> On Mon, Jun 22, 2015 at 9:09 AM, Natanael Copa <ncopa@alpinelinux.org> wrote:
>> Use POSIX Extended Regular Expression (ERE) instead of the GNU extension
>> \| in the install-exec-hook. This makes it create the symlink properly
>> with busybox sed built with musl libc. It will silently create a broken
>> symlink otherwise.
>
>
> Oh... so you are running "make install" in a system with only busybox
> built with musl? :-o
>
> Anyway, this change seems sane enough so it's applied.

when pushing the CI alerted me it was failing.

        Makefile.am:111: error: blank line following trailing backslash

I fixed this up myself, but now I'm wondering if this has been at
least compile-tested.

-- 
Lucas De Marchi
