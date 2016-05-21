MIME-Version: 1.0
In-Reply-To: <1462199904-797-1-git-send-email-hector.oron@gmail.com>
References: <1462199904-797-1-git-send-email-hector.oron@gmail.com>
Date: Sat, 21 May 2016 15:09:02 -0300
Message-ID: <CAKi4VAKUnezzv6ENBz6P53GKOLwG89giB_aRMTNMUeNt3uofEQ@mail.gmail.com>
Subject: Re: [PATCH] kmod: compiling with old sed version (!ERE support)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: hector.oron@gmail.com
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, May 2, 2016 at 11:38 AM,  <hector.oron@gmail.com> wrote:
> From: H=C3=A9ctor Or=C3=B3n Mart=C3=ADnez <hector.oron@gmail.com>
>
>   Makefile.am uses `sed -E', which it is found on BSD sed; however a
>   replacement on GNU sed would be `sed -r'. Both intend to use extended
>   regular expressions (ERE). However I have a system that does not suppor=
t
>   those, in benefit for portability could you consider replacing ERE by B=
RE.
>
> Signed-off-by: H=C3=A9ctor Or=C3=B3n Mart=C3=ADnez <hector.oron@gmail.com=
>
> ---

Applied, thanks.

Lucas De Marchi
