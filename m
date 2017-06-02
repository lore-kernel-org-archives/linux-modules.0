MIME-Version: 1.0
In-Reply-To: <20170509190924.9087-3-yauheni.kaliuta@redhat.com>
References: <CAKi4VALJgW=RbpCT4kfix9sACzzz68=LZ-FhUUORXxHMcTA__g@mail.gmail.com>
	<20170509190924.9087-1-yauheni.kaliuta@redhat.com>
	<20170509190924.9087-3-yauheni.kaliuta@redhat.com>
Date: Thu, 1 Jun 2017 20:23:56 -0700
Message-ID: <CAKi4VAL6Az82hhPJ6zyv2ne0PsaUnu7eb7FE80mWYM30p=bBfg@mail.gmail.com>
Subject: Re: [PATCHv2 2/4] depmod: rewrite depmod modules search with scratchbuf
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Tue, May 9, 2017 at 12:09 PM, Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
> The recursive search code used used pretty big, PATH_MAX,
> automatic storage buffer for the module directory scanning. Some
> time ago there was scratchbuf implemented, which dynamically
> reallocates its buffer on demand. The patch takes it in use for
> the scanning code also. The initial size is hardcoded to 256
> bytes which sounds good enough for most usecases so there should
> be not many reallocations.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---

Applied, thanks.

Lucas De Marchi
