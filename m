MIME-Version: 1.0
In-Reply-To: <87a9axc82r.fsf@rustcorp.com.au>
References: <53484327.5Nr2aWdyWz5+36kD%matwey.kornilov@gmail.com>
	<CAKi4VALtbKS=wj1KncN+kt+5hRPLDYxzkuDDg-3Cm+wr2mK5JQ@mail.gmail.com>
	<CANkykrBdJ-u-OWWgBZj_Jsghd8oqhC6AtRK7dvs=EGFt7EozMQ@mail.gmail.com>
	<CAJs94EZbVaS=N0xpAQbAySBzX_e6JR1o8FJkrJ0f4buCWvsZSA@mail.gmail.com>
	<20140502141357.GA24741@politreco>
	<87a9axc82r.fsf@rustcorp.com.au>
Date: Mon, 5 May 2014 01:29:10 -0300
Message-ID: <CAKi4VAL4+nErBqO+z-LJCYxuMqEHmsv0272ju6xQQ2W9ra3+wg@mail.gmail.com>
Subject: Re: [PATCH] Fix recursion loop in mod_count_all_dependencies()
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
	Gustavo Sverzut Barbieri <barbieri@gmail.com>, linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Sun, May 4, 2014 at 10:45 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
>> [ CC'ing Rusty ]
>>
>> Rusty, when facing module loops, shouldn't we let depmod fail? kmod and
>> module-init-tools since always just warned about them, but it's really a
>> bug in the module if they exist. See below.
>
> Yes.  Soft dependencies can loop, but hard dependencies should barf.

Ok, then we shouldn't need to fix anything here. Just make depmod die
early and maybe add a better error message (like saying A -> B -> C ->
A, instead of only saying that A, B and C are in a loop like we do
today)

> Note that in the case where two modules could satisfy a dependencies,
> it may not be a real loop?

What do you mean here? How could that be the case for *depmod*?


Lucas De Marchi
