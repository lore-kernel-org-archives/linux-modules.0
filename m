MIME-Version: 1.0
In-Reply-To: <20160111155526.GA26391@piware.de>
References: <20160110151023.GA9659@x>
	<CAKi4VAJJJ+nDene80fmzzm4WN_2=VLXrq7qc-urNYToQew+LgQ@mail.gmail.com>
	<20160111155526.GA26391@piware.de>
Date: Mon, 11 Jan 2016 14:06:02 -0200
Message-ID: <CAKi4VAKAFA9uiHvjp_HN_KNCD8SbYk1SE6+yWGTYckwwAmM_vQ@mail.gmail.com>
Subject: Re: Bug#810367: [PATCH] depmod: Don't insert comment in
 modules.devname if otherwise empty
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Martin Pitt <mpitt@debian.org>
Cc: 810367@bugs.debian.org, Josh Triplett <josh@joshtriplett.org>,
	linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Martin

On Mon, Jan 11, 2016 at 1:55 PM, Martin Pitt <mpitt@debian.org> wrote:
> Hey Josh, Lucas,
>
> Lucas De Marchi [2016-01-11 10:43 -0200]:
>> On Sun, Jan 10, 2016 at 1:10 PM, Josh Triplett <josh@joshtriplett.org> wrote:
>> > This allows tools to detect the file as empty, such as via systemd's
>> > ConditionFileNotEmpty.
>
> As pointed out on https://github.com/systemd/systemd/pull/2301: Why
> does this file get created at all if it's going to be empty?

The only reason I can think of is to avoid breaking current programs
that depend on its existence since it is created since forever.

Lucas De Marchi
