Return-Path: <matwey.kornilov@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20140502141357.GA24741@politreco>
References: <53484327.5Nr2aWdyWz5+36kD%matwey.kornilov@gmail.com>
 <CAKi4VALtbKS=wj1KncN+kt+5hRPLDYxzkuDDg-3Cm+wr2mK5JQ@mail.gmail.com>
 <CANkykrBdJ-u-OWWgBZj_Jsghd8oqhC6AtRK7dvs=EGFt7EozMQ@mail.gmail.com>
 <CAJs94EZbVaS=N0xpAQbAySBzX_e6JR1o8FJkrJ0f4buCWvsZSA@mail.gmail.com> <20140502141357.GA24741@politreco>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Fri, 2 May 2014 18:29:45 +0400
Message-ID: <CAJs94EZJKA1QFAbnQ+2PSwQ06a_LJT5L9wZayXGRoJBcPWNSDg@mail.gmail.com>
Subject: Re: [PATCH] Fix recursion loop in mod_count_all_dependencies()
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Gustavo Sverzut Barbieri <barbieri@gmail.com>, linux-modules <linux-modules@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-modules.vger.kernel.org>

2014-05-02 18:13 GMT+04:00 Lucas De Marchi <lucas.de.marchi@gmail.com>:
> leading to an
> infinite recursion loop in mod_count_all_dependencies() as pointed out
> by Matwey V. Kornilov <matwey.kornilov@gmail.com> in the mailing list.

Yes, my patch was intended mostly to highlight the issue. As a
'proper' solution I would prefer more informative output, i.e all the
elements of the single loop are printed out.


-- 
With best regards,
Matwey V. Kornilov
http://blog.matwey.name
xmpp:0x2207@jabber.ru
