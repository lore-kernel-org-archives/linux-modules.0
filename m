Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, Gustavo Sverzut Barbieri <barbieri@gmail.com>, linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] Fix recursion loop in mod_count_all_dependencies()
In-Reply-To: <CAKi4VAL4+nErBqO+z-LJCYxuMqEHmsv0272ju6xQQ2W9ra3+wg@mail.gmail.com>
References: <53484327.5Nr2aWdyWz5+36kD%matwey.kornilov@gmail.com> <CAKi4VALtbKS=wj1KncN+kt+5hRPLDYxzkuDDg-3Cm+wr2mK5JQ@mail.gmail.com> <CANkykrBdJ-u-OWWgBZj_Jsghd8oqhC6AtRK7dvs=EGFt7EozMQ@mail.gmail.com> <CAJs94EZbVaS=N0xpAQbAySBzX_e6JR1o8FJkrJ0f4buCWvsZSA@mail.gmail.com> <20140502141357.GA24741@politreco> <87a9axc82r.fsf@rustcorp.com.au> <CAKi4VAL4+nErBqO+z-LJCYxuMqEHmsv0272ju6xQQ2W9ra3+wg@mail.gmail.com>
Date: Mon, 05 May 2014 19:41:33 +0930
Message-ID: <87ppjsbkmi.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
> On Sun, May 4, 2014 at 10:45 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>> Note that in the case where two modules could satisfy a dependencies,
>> it may not be a real loop?
>
> What do you mean here? How could that be the case for *depmod*?

Sorry, it's a theoretical case; no one does anything this crazy:

 A provides symbol S1.
 B provides symbol S1, needs S2.
 C needs S1, provides S2.
 D provides S2.

Cheers,
Rusty.
