MIME-Version: 1.0
In-Reply-To: <1412018284-3411-1-git-send-email-patrickdepinguin@gmail.com>
References: <1412018284-3411-1-git-send-email-patrickdepinguin@gmail.com>
Date: Mon, 29 Sep 2014 17:21:49 -0300
Message-ID: <CAKi4VAK_ipx7V4rYPaebpCsaK6RzwSQNe0nSQE3fSK5TeVgGWA@mail.gmail.com>
Subject: Re: [PATCH] Add back-up implementation of be32toh()
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Thomas De Schampheleire <patrickdepinguin@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Randy MacLeod <Randy.MacLeod@windriver.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Thomas

On Mon, Sep 29, 2014 at 4:18 PM, Thomas De Schampheleire
<patrickdepinguin@gmail.com> wrote:
> From: Randy MacLeod <Randy.MacLeod@windriver.com>
>
> Older systems may not have the be32toh function defined. Check for this
> and fall back to checking the endianness and calling bswap_32 directly
> if needed.  This works on both old and new systems.
>
> [Thomas De Schampheleire <thomas.de.schampheleire@gmail.com>:
> address comments raised by Lucas De Marchi [1], update commit message]
> [1] http://www.spinics.net/lists/linux-modules/msg01129.html
> ---

Applied, thanks


-- 
Lucas De Marchi
