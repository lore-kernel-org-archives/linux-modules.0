Return-Path: <tobias@stoeckmann.org>
Date: Fri, 3 Aug 2018 23:10:07 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] Verify memory sizes on 32 bit systems.
Message-ID: <20180803211007.GA97622@pepper.home.stoeckmann.org>
References: <20180730190146.GA8535@localhost>
 <CAKi4VALpRspPNWTGsZbpHhH=UKECUF+=wYa0aLZnxZ0=USLxRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKi4VALpRspPNWTGsZbpHhH=UKECUF+=wYa0aLZnxZ0=USLxRg@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>

On Fri, Aug 03, 2018 at 02:07:34PM -0700, Lucas De Marchi wrote:
> > +       if ((uintmax_t)st.st_size > (uintmax_t)SIZE_MAX)
> 
> why casting?

Without casting, a warning could be triggered on 64 bit systems,
because on these systems a signed 64 bit int (off_t) is compared
with an unsigned 64 bit int (size_t) which could never be larger.

Casting it to uintmax_t, which is at least 64 bits in size,
silences this error.

No technical reason beyond that.


Tobias
