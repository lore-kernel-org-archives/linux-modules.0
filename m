MIME-Version: 1.0
In-Reply-To: <CACB1Aes6O1+Obj3Kp5cesoLbUN3uNKNvmQc1Q=8yQTFqkbtf8g@mail.gmail.com>
References: <CACB1Aes6O1+Obj3Kp5cesoLbUN3uNKNvmQc1Q=8yQTFqkbtf8g@mail.gmail.com>
Date: Sun, 18 May 2014 15:55:20 -0300
Message-ID: <CAKi4VAKbosbmvXae_pSCX8NMSpR7XsYzqw8bkchYXXeoR63o+g@mail.gmail.com>
Subject: Re: [PATCH] Fix use-after-free in libkmod / depmod fails to deal with symlinks
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Lukas Anzinger <l.anzinger@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Sun, May 18, 2014 at 1:59 PM, Lukas Anzinger <l.anzinger@gmail.com> wrote:
> Hi,
>
> I found a bug in the hash implementation that is part of libkmod. As a
> result depmod fails to deal with modules if they are the *target* of a
> symlink. (The symlink must be also part of the directory hierarchy
> that depmod parses.)
>
> I.e. the following scenario causes depmod to not handle symbols of
> module rtai_sched.ko:
>
> $ cd /lib/modules/$(uname -r)/rtai
> $ ls -l rtai_*sched.ko
> lrwxrwxrwx 1 root root     13 Apr 30 12:12 rtai_ksched.ko -> rtai_sched.ko
> -rw-r--r-- 1 root root 100925 Apr 30 12:12 rtai_sched.ko
>
> The following patch fixes that problem:
>
> From 4363adddbdd0ac121f9a8ce0082b0f7fa132a1b0 Mon Sep 17 00:00:00 2001
> From: Lukas Anzinger <lukas@lukasanzinger.at>
> Date: Sun, 18 May 2014 18:40:19 +0200
> Subject: [PATCH] Fix use-after-free in hash implementation.
>
> If a value is added to the hash under a key that already exists the new value
> replaces the old value for that key. Since key can be a pointer to data that
> is part of value and freed by hash->free_value(), the key must be also
> replaced and not only the value. Otherwise key potentially points to freed data.
> ---
>  libkmod/libkmod-hash.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libkmod/libkmod-hash.c b/libkmod/libkmod-hash.c
> index c751d2d..eb7afb7 100644
> --- a/libkmod/libkmod-hash.c
> +++ b/libkmod/libkmod-hash.c
> @@ -169,6 +169,7 @@ int hash_add(struct hash *hash, const char *key,
> const void *value)
>          if (c == 0) {
>              if (hash->free_value)
>                  hash->free_value((void *)entry->value);
> +            entry->key = key;
>              entry->value = value;
>              return 0;
>          } else if (c < 0) {
> --

Looks good. Thanks.


> 1.9.1
>
> I've also written a blog post that describes the problem in great
> detail. If you're interested how I found that bug you might want to
> read this article:
> https://www.notinventedhere.org/articles/linux/why-implementing-your-own-data-structures-in-c-is-a-bad-idea.html

Except your TL;DR is wrong. The hash implementation was not written
from scratch, but rather parts were taken from existing
implementations. The most used implementation was Eina. If you look at
the last comment at
http://www.politreco.com/2013/09/optimizing-hash-table-with-kmod-as-testbed/
you will see that even Eina incorporated some changes back.

It's a nice blog post, but with lots of unnecessary noise accusing
kmod of NIH for such a simple bug caused by out-of-tree modules (thus
not really tested).


Lucas De Marchi
