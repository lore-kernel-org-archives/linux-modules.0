Return-Path: <martin@piware.de>
Date: Mon, 11 Jan 2016 16:55:26 +0100
From: Martin Pitt <mpitt@debian.org>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>, 810367@bugs.debian.org
Cc: Josh Triplett <josh@joshtriplett.org>,
	linux-modules <linux-modules@vger.kernel.org>
Subject: Re: Bug#810367: [PATCH] depmod: Don't insert comment in
 modules.devname if otherwise empty
Message-ID: <20160111155526.GA26391@piware.de>
References: <20160110151023.GA9659@x>
 <CAKi4VAJJJ+nDene80fmzzm4WN_2=VLXrq7qc-urNYToQew+LgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKi4VAJJJ+nDene80fmzzm4WN_2=VLXrq7qc-urNYToQew+LgQ@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>

Hey Josh, Lucas,

Lucas De Marchi [2016-01-11 10:43 -0200]:
> On Sun, Jan 10, 2016 at 1:10 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> > This allows tools to detect the file as empty, such as via systemd's
> > ConditionFileNotEmpty.

As pointed out on https://github.com/systemd/systemd/pull/2301: Why
does this file get created at all if it's going to be empty?

Thanks,

Martin
-- 
Martin Pitt                        | http://www.piware.de
Ubuntu Developer (www.ubuntu.com)  | Debian Developer  (www.debian.org)
