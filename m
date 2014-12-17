MIME-Version: 1.0
In-Reply-To: <5490BFD6.2000504@gentoo.org>
References: <54810109.7030409@gentoo.org>
	<CAKi4VAL1C00z-pO8ODcvDD-=CfPjgpM1SMg53HsDJ6QTWQFgDQ@mail.gmail.com>
	<5490BFD6.2000504@gentoo.org>
Date: Wed, 17 Dec 2014 00:44:03 -0200
Message-ID: <CAKi4VAL+i-XbUY2WFucBukrpJoZu5TZ=wGW=iMVN655MxVALZQ@mail.gmail.com>
Subject: Re: [PATCH] build: Do not force diagnostics-color flag
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Mike Auty <ikelos@gentoo.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Dec 16, 2014 at 9:27 PM, Mike Auty <ikelos@gentoo.org> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hiya,
>
> On 16/12/14 20:46, Lucas De Marchi wrote:
>> Do we really need to specify the colors ourselves? Systemd's
>> commit seems to only export any value in the variable to get the
>> default ones.
>
> No, but if the data isn't important anyway, I figured we might as well
> load it with the default value as something useful for anyone that
> happens to read the line.  Submitting what was in the systemd patch
> seemed embarrassing, but if you think it's more confusing then I'm
> happy to include some bogus text of your choosing.

The problem is that then we don't follow whatever the default becomes
when a new gcc is released. A simple "yes" instead of "oh, shiny"
would do the job, too :-)

I'm amending it to your patch and applying.

Thanks
Lucas De Marchi
