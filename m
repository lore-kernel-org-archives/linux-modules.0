MIME-Version: 1.0
In-Reply-To: <1377541250-10193-2-git-send-email-maillist-kmod@barfooze.de>
References: <1377541250-10193-1-git-send-email-maillist-kmod@barfooze.de>
	<1377541250-10193-2-git-send-email-maillist-kmod@barfooze.de>
Date: Mon, 26 Aug 2013 20:18:51 -0300
Message-ID: <CAKi4VALHoH3AYJff-AGNFKctrKX3vS8MFtLqos0ejv_pfaGjWQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] check if __GLIBC__ is defined before using _FILE_OFFSET_BITS
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: John Spencer <maillist-kmod@barfooze.de>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, Aug 26, 2013 at 3:20 PM, John Spencer <maillist-kmod@barfooze.de> wrote:
> _FILE_OFFSET_BITS is a glibc internal macro.
> musl provides 64bit off_t by default, but
> defines stat64 etc as macros to make glibc-centric
> programs happy. however the expansion causes
> problems with the hack used here to work around
> glibc's 32bit past...

AFAIK this define comes from AC_SYS_LARGEFILE in autoconf and ends up
in our config.h. Checking for the libc in source code is not much
future proof and I'd like to avoid it.  If this is not the right
define to pick, is there any other one?

Maybe it would be better to do like this:

#ifndef _FILE_OFFSET_BITS
#ifndef stat64
WRAP_2ARGS(int, -1, stat64, struct stat64*);
#endif
...

Because if it's a macro, there's no need to wrap the call.

Lucas De Marchi
