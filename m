MIME-Version: 1.0
In-Reply-To: <20161123152339.27531-3-yauheni.kaliuta@redhat.com>
References: <20161123152339.27531-1-yauheni.kaliuta@redhat.com>
	<20161123152339.27531-3-yauheni.kaliuta@redhat.com>
Date: Tue, 9 May 2017 00:04:17 -0700
Message-ID: <CAKi4VALOnVDC0328eNphmNASqAjxWhQ=hWu=XmPwwiAGJQD-1Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] depmod: search key: move builtin detection under
 the add function
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, aris@redhat.com,
	Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Wed, Nov 23, 2016 at 7:23 AM, Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
> Prepare to implement external directories support.
>
> It's better to isolated behaviour difference under the
> cfg_search_add() call, then make the client code aware of it.
>
> In case of external modules/directories support, there will be
> one more keyword added, so making the clients aware of it makes
> even less sense.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---


Applied, thanks.


Lucas De Marchi
