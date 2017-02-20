Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
        Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH RFC 3/3] depmod: handle nested loops
References: <1478683053.4155.8.camel@suse.com>
	<1478864601-3259-1-git-send-email-yauheni.kaliuta@redhat.com>
	<1478864601-3259-4-git-send-email-yauheni.kaliuta@redhat.com>
	<CAKi4VAKJUzXptH0AQARsP=H2dxQfuQOHaR1ERCHsE87_ewMx=g@mail.gmail.com>
Date: Mon, 20 Feb 2017 16:16:37 +0200
In-Reply-To: <CAKi4VAKJUzXptH0AQARsP=H2dxQfuQOHaR1ERCHsE87_ewMx=g@mail.gmail.com>
	(Lucas De Marchi's message of "Mon, 13 Feb 2017 00:30:53 -0800")
Message-ID: <xuny8tp1ueuy.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

>>>>> On Mon, 13 Feb 2017 00:30:53 -0800, Lucas De Marchi  wrote:

 > On Fri, Nov 11, 2016 at 3:43 AM, Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:
 >> This is a rework of depmod report cycles logic to make it
 >> tolerant to more complex loops.
 >> 
 >> The patch tries to remember own path for vertexes which makes it
 >> possible to handle configurations with common edges and
 >> non-cyclic modules.
 >> 
 >> It assumes that the previous dependency calculations can not give
 >> as input something like
 >> 
 >> mod_a -> mod_b -> <loop>, but
 >> 
 >> <loop> -> mod_a -> mod_b should be fine.
 >> 
 >> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
 >> ---
 >> tools/depmod.c | 287 ++++++++++++++++++++++++++++++++++++++++-----------------
 >> 1 file changed, 204 insertions(+), 83 deletions(-)

[...]

 >> --

 > Rest looks good.

I'm sending v2 which addresses your comments.

One question: there is a bunch of memory leaks in -ENOMEM error path (what
doesn't sound as a real problem for depmod tool since it should exit anyway
after that). Would you like me to fix it as well?

-- 
WBR,
Yauheni Kaliuta
