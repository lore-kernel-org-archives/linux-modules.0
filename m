MIME-Version: 1.0
In-Reply-To: <20170222094159.3187-3-yauheni.kaliuta@redhat.com>
References: <CAKi4VA+4KsvtNje0TVBfp2PtPtyLOBVvYfC5uMJZHBnynWfP=g@mail.gmail.com>
	<20170222094159.3187-1-yauheni.kaliuta@redhat.com>
	<20170222094159.3187-3-yauheni.kaliuta@redhat.com>
Date: Thu, 23 Feb 2017 14:30:00 -0800
Message-ID: <CAKi4VAJcbm9a1UzpCEMFP3T-JpQGTFpnQY9M-3-+QrkQkDTEuA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] depmod: handle nested loops
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Mian Yousaf Kaukab <yousaf.kaukab@suse.com>, bjorn.andersson@linaro.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 22, 2017 at 1:41 AM, Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
> This is a rework of depmod report cycles logic to make it
> tolerant to more complex loops.
>
> The patch tries to remember own path for vertexes which makes it
> possible to handle configurations with common edges and
> non-cyclic modules.
>
> It assumes that the previous dependency calculations can not give
> as input something like
>
> mod_a -> mod_b -> <loop>, but
>
> <loop> -> mod_a -> mod_b should be fine.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---

Patches applied.

thanks
Lucas De Marchi
