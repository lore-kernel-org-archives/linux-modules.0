Return-Path: <tobias@stoeckmann.org>
Date: Fri, 3 Aug 2018 23:51:35 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] Verify memory sizes on 32 bit systems.
Message-ID: <20180803215135.GA55860@pepper.home.stoeckmann.org>
References: <20180730190146.GA8535@localhost>
 <CAKi4VALpRspPNWTGsZbpHhH=UKECUF+=wYa0aLZnxZ0=USLxRg@mail.gmail.com>
 <20180803211007.GA97622@pepper.home.stoeckmann.org>
 <CAKi4VAKK5MSODC-VbFWG2d0p-eUXqrPbpNiomJb6+BEhfWjBVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKi4VAKK5MSODC-VbFWG2d0p-eUXqrPbpNiomJb6+BEhfWjBVQ@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>

On Fri, Aug 03, 2018 at 02:33:51PM -0700, Lucas De Marchi wrote:
> so you are casting the *sign* away, ok. But casting only st.st_size
> should suffice.

I've just tried with some examples and I couldn't trigger the
warning which I have seen in other situations like this, i.e.
"always false due to limited range of data type".

If I cast the off_t to size_t, the compiler knows that it is not
possible that it could ever be larger than SIZE_MAX, optimizing
the block away. So I took uintmax_t.

But as long as there's no annoying warning, I am fine with just
casting st_size.


Tobias
