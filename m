MIME-Version: 1.0
Date: Fri, 3 Aug 2018 14:33:51 -0700
References: <20180730190146.GA8535@localhost>
	<CAKi4VALpRspPNWTGsZbpHhH=UKECUF+=wYa0aLZnxZ0=USLxRg@mail.gmail.com>
	<20180803211007.GA97622@pepper.home.stoeckmann.org>
In-Reply-To: <20180803211007.GA97622@pepper.home.stoeckmann.org>
Message-ID: <CAKi4VAKK5MSODC-VbFWG2d0p-eUXqrPbpNiomJb6+BEhfWjBVQ@mail.gmail.com>
Subject: Re: [PATCH] Verify memory sizes on 32 bit systems.
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Fri, Aug 3, 2018 at 2:10 PM Tobias Stoeckmann <tobias@stoeckmann.org> wrote:
>
> On Fri, Aug 03, 2018 at 02:07:34PM -0700, Lucas De Marchi wrote:
> > > +       if ((uintmax_t)st.st_size > (uintmax_t)SIZE_MAX)
> >
> > why casting?
>
> Without casting, a warning could be triggered on 64 bit systems,
> because on these systems a signed 64 bit int (off_t) is compared
> with an unsigned 64 bit int (size_t) which could never be larger.
>
> Casting it to uintmax_t, which is at least 64 bits in size,
> silences this error.

so you are casting the *sign* away, ok. But casting only st.st_size
should suffice.

Lucas De Marchi

>
> No technical reason beyond that.
>
>
> Tobias



-- 
Lucas De Marchi
