MIME-Version: 1.0
In-Reply-To: <1416213389-6292-1-git-send-email-ncopa@alpinelinux.org>
References: <1416213389-6292-1-git-send-email-ncopa@alpinelinux.org>
Date: Mon, 17 Nov 2014 13:01:59 -0200
Message-ID: <CAKi4VAL8EoBuXJak5aGaHqk8_qTbXtoU6am+Cf+-u8W449wy2g@mail.gmail.com>
Subject: Re: [PATCH] util: fix build on systems missing strndupa
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi

On Mon, Nov 17, 2014 at 6:36 AM, Natanael Copa <ncopa@alpinelinux.org> wrote:
> we need include shared/missing.h to be able to compile on sysmtes that
> lacks strndupa.
> ---

Applied, thanks.

-- 
Lucas De Marchi
