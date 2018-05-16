MIME-Version: 1.0
In-Reply-To: <HE1PR0702MB380494D3270EE7E7626C844898930@HE1PR0702MB3804.eurprd07.prod.outlook.com>
References: <HE1PR0702MB3804B2EA7AE44D23D39C946698930@HE1PR0702MB3804.eurprd07.prod.outlook.com>
	<HE1PR0702MB380494D3270EE7E7626C844898930@HE1PR0702MB3804.eurprd07.prod.outlook.com>
Date: Wed, 16 May 2018 10:31:06 -0700
Message-ID: <CAKi4VALqbaW-9iLP_fG_s8tqAEeJqOGXsbF=EWk0r7+4YXXVhA@mail.gmail.com>
Subject: Re: kmod-25 bootstrap typo
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Jakov Simunic <jakov.simunic@ericsson.com>
Cc: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Tue, May 15, 2018 at 1:33 AM, Jakov Simunic
<jakov.simunic@ericsson.com> wrote:
> Hello,
> I've noticed a typo in the kmod bootstrap, line 63:
>        echo "$topdir/configure CFLAGS="-g -O2" $args $hackargs"
> should be:
>         echo "$topdir/configure CFLAGS='-g -O2' $args $hackargs"

The right way would actually to send the patch with your change.
Anyway, this is a small enough change that I can just replicate.

Applied, thanks


Lucas De Marchi
