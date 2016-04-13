MIME-Version: 1.0
In-Reply-To: <20160405003237.GK21187@decadent.org.uk>
References: <20160405001611.GJ21187@decadent.org.uk>
	<20160405003237.GK21187@decadent.org.uk>
Date: Wed, 13 Apr 2016 01:05:56 -0300
Message-ID: <CAKi4VAK64gR8U2n6=fO8o9Y1m7bTJsmeDLQcpegjF+57=_e8VA@mail.gmail.com>
Subject: Re: [PATCH v2] libkmod: Add support for detached module signatures
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-modules <linux-modules@vger.kernel.org>, 820010@bugs.debian.org,
	Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi,

CC'ing Rusty

On Mon, Apr 4, 2016 at 9:32 PM, Ben Hutchings <ben@decadent.org.uk> wrote:
> Debian will not sign modules during the kernel package build, as this
> conflicts with the goal of reproducible builds.  Instead, we will
> generate detached signatures offline and include them in a second
> package.

Is this a decision already? It doesn't look as a good reason - you
would already need to provide a signing key (CONFIG_MODULE_SIG_KEY)
anyway for this to work. How is leaving the module signature in
another package be any better than just signing the module?  If you
have the signature, the build is just as reproducible as before.

> We could attach the signatures when building this second package or at
> installation time, but that leads to duplication of all modules,
> either in the archive or on users' systems.
>
> To avoid this, add support to libkmod for concatenating modules with
> detached signatures (files with the '.sig' extension) at load time.

this has the drawback that finit_module() can't be used.


> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> v2: Fix syntax error in the xz case
>
> Missed this because I didn't realise the Debian package disables gzip
> and xz support.
>
> Ben.
>
>  libkmod/libkmod-file.c | 110 +++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 103 insertions(+), 7 deletions(-)
>
> diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
> index 5eeba6a912a2..cb1da3c9e2ae 100644
> --- a/libkmod/libkmod-file.c
> +++ b/libkmod/libkmod-file.c

...

> @@ -292,12 +370,25 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
>         if (file == NULL)
>                 return NULL;
>
> +       file->sig_fd = -1;
> +
>         file->fd = open(filename, O_RDONLY|O_CLOEXEC);
>         if (file->fd < 0) {
>                 err = -errno;
>                 goto error;
>         }
>
> +       /* Try to open a detached signature.  If it's missing, that's OK. */
> +       if (asprintf(&sig_filename, "%s.sig", filename) < 0) {
> +               err = -errno;
> +               goto error;
> +       }
> +       file->sig_fd = open(sig_filename, O_RDONLY|O_CLOEXEC);
> +       if (file->sig_fd < 0 && errno != ENOENT) {
> +               err = -errno;
> +               goto error;
> +       }

This can't really work if the module is being loaded uncompressed (I
think nowadays we can even add support for compressed modules...
Rusty, any input here?).

When the module is being directly loaded, the direct flag gets set so
kmod_module_insert_module() knows it can try to use finit_module().
Since you have an external signature what would happen is that we
would load the signature, but try to load the module in the kernel
without it.

I'm still not convinced the split module + signature is actually a good thing.


Lucas De Marchi
