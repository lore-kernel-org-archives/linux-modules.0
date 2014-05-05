Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>, "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Gustavo Sverzut Barbieri <barbieri@gmail.com>, linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] Fix recursion loop in mod_count_all_dependencies()
In-Reply-To: <20140502141357.GA24741@politreco>
References: <53484327.5Nr2aWdyWz5+36kD%matwey.kornilov@gmail.com> <CAKi4VALtbKS=wj1KncN+kt+5hRPLDYxzkuDDg-3Cm+wr2mK5JQ@mail.gmail.com> <CANkykrBdJ-u-OWWgBZj_Jsghd8oqhC6AtRK7dvs=EGFt7EozMQ@mail.gmail.com> <CAJs94EZbVaS=N0xpAQbAySBzX_e6JR1o8FJkrJ0f4buCWvsZSA@mail.gmail.com> <20140502141357.GA24741@politreco>
Date: Mon, 05 May 2014 11:15:00 +0930
Message-ID: <87a9axc82r.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
> [ CC'ing Rusty ]
>
> Rusty, when facing module loops, shouldn't we let depmod fail? kmod and
> module-init-tools since always just warned about them, but it's really a
> bug in the module if they exist. See below.

Yes.  Soft dependencies can loop, but hard dependencies should barf.
Note that in the case where two modules could satisfy a dependencies,
it may not be a real loop?

Cheers,
Rusty.
