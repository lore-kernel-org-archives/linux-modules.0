Return-Path: <jason.vas.dias@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4502a7e5-930f-15b6-fbef-929df29d5ef0@infradead.org>
References: <CAKi4VA+1krn9rdBWE69DkhNZSrxJoeYzyPgvn-SUk8U0=CxFkw@mail.gmail.com>
 <54EB4C83.2000500@suse.cz> <CAKi4VAJwvtLaF1GTw1dg__CXHGjwOwJqUS=g5B0rbPNp1w8dDg@mail.gmail.com>
 <4502a7e5-930f-15b6-fbef-929df29d5ef0@infradead.org>
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Thu, 10 May 2018 12:03:01 +0000
Message-ID: <CALyZvKzDYUFxbkZW=zVP6Z5KV3QQGJaZb6uW35qkZRV2xYUzJg@mail.gmail.com>
Subject: Re: Differences between builtins and modules
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>, Harish Jenny K N <harish_kandiga@mentor.com>,
	linux-modules <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

Sorry I didn't see this mail until now - RE:

Randy Dunlap <rdunlap@infradead.org> wrote:
> Would someone please answer/reply to this (related) kernel bugzilla entry:
> https://bugzilla.kernel.org/show_bug.cgi?id=118661

Yes, I raised this bug because I think modinfo should return 0 exit status
if a requested module is built-in, not just when it has been loaded, like
this modified version does:
$ modinfo snd
modinfo: ERROR: Module snd not found.
built-in: snd
$ echo $?
0

What was the query about the Bug 118661 that needs to be answered ?
I don't see any query on the bug report - just a comment from someone
who also agrees modinfo should return OK for a built-in module .

Glad to hear someone is finally considering fixing modinfo to report
status of built-in modules - with only a 2 year response time.

Thanks & Best Regards,
Jason
