MIME-Version: 1.0
In-Reply-To: <1478864601-3259-1-git-send-email-yauheni.kaliuta@redhat.com>
References: <1478683053.4155.8.camel@suse.com>
	<1478864601-3259-1-git-send-email-yauheni.kaliuta@redhat.com>
Date: Mon, 13 Feb 2017 00:32:29 -0800
Message-ID: <CAKi4VA+dTLSTqk2T4jY8T=BgsGzzzGJ6P2zQfGpcXT=MtquXYg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Proposal for cycles handling
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Mian Yousaf Kaukab <yousaf.kaukab@suse.com>, bjorn.andersson@linaro.org,
	Jessica Yu <jeyu@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Fri, Nov 11, 2016 at 3:43 AM, Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
> Back to the discussion, does it make any sense?
>
> This is an RFC proposal of dependency loops reporting.
>
> Yauheni Kaliuta (3):
>   testsuite: depmod: check netsted loops reporting
>   libkmod: list: export list handling functions
>   depmod: handle nested loops

I added some comments. It's looking good and I'd like to get this in
to do a release this week.

thanks for fixing this.

Lucas De Marchi
