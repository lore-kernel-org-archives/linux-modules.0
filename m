MIME-Version: 1.0
In-Reply-To: <20150214233452.GA7778@localhost>
References: <20150214233452.GA7778@localhost>
Date: Sun, 15 Feb 2015 09:46:56 -0200
Message-ID: <CAKi4VAJ+K-6FnZxGETWzVh3pDch1k9bU_3-xtZmM2QmE1esf_g@mail.gmail.com>
Subject: Re: [PATCH] Fix segmentation fault on empty signature key
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Sat, Feb 14, 2015 at 9:34 PM, Tobias Stoeckmann
<tobias@stoeckmann.org> wrote:
> Hi,
>
> a segmentation fault occurs if a module has an empty key attached to
> its signature.
>
> This happens because it's assumed that at least one key byte is
> available, subtracting it in libkmod-module line 2249.  This -1 value
> is casted to an unsigned data type later on, resulting in illegal
> memory access.
>
> Attached please find a proof of concept module, tested on amd64:
>
> tobias:~$ modinfo 0sig.ko
> filename:       /home/tobias/0sig.ko
> Segmentation fault

Same here, please also send the source code of the module. Even if for
actually testing this behavior we have to ship a pre-compiled module,
I want all the modules in the testsuite to have its source code in the
testsuite to avoid license issues.


-- 
Lucas De Marchi
