MIME-Version: 1.0
In-Reply-To: <1466172255-20955-1-git-send-email-mmarek@suse.com>
References: <1466172255-20955-1-git-send-email-mmarek@suse.com>
Date: Mon, 20 Jun 2016 09:55:57 -0300
Message-ID: <CAKi4VA+DD1gO61s1y46tetDkQAbRDUhhhUGYUM_0Nc6PiP5LEQ@mail.gmail.com>
Subject: Re: [PATCH] libkmod: Handle long lines in /proc/modules
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michal Marek <mmarek@suse.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, Michal Marek <mmarek@suse.cz>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Michal,

On Fri, Jun 17, 2016 at 11:04 AM, Michal Marek <mmarek@suse.com> wrote:
> From: Michal Marek <mmarek@suse.cz>
>
> kmod_module_new_from_loaded() calls fgets with a 4k buffer. When a
> module such as usbcore is used by too many modules, the rest of the line
> is considered a beginning of another lines and we eventually get errors
> like these from lsmod:
>
> libkmod: kmod_module_get_holders: could not open '/sys/module/100,/holders': No such file or directory
>
> together with bogus entries in the output. In kmod_module_get_size, the
> problem does not affect functionality, but the line numbers in error
> messages will be wrong.

ugh, thanks for catching this.

>
> Signed-off-by: Michal Marek <mmarek@suse.com>
> ---
>
> I wrote a test case for this as well, but it is failing because the
> testsuite itself has problems with output larger than 4k. I'll send
> something later.
>
> Also, the buffer could be shrinked now, so that we do not use that much
> space on stack. Not sure if this is of interest or not. I left it as is.

Yep, I think it's reasonable to be 64 bytes since it's the maximum
length of a module name

> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 1460c6746cc4..25dcda7667b7 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -1660,13 +1660,14 @@ KMOD_EXPORT int kmod_module_new_from_loaded(struct kmod_ctx *ctx,
>                 struct kmod_module *m;
>                 struct kmod_list *node;
>                 int err;
> +               size_t len = strlen(line);
>                 char *saveptr, *name = strtok_r(line, " \t", &saveptr);
>
>                 err = kmod_module_new_from_name(ctx, name, &m);
>                 if (err < 0) {
>                         ERR(ctx, "could not get module from name '%s': %s\n",
>                                 name, strerror(-err));
> -                       continue;
> +                       goto eat_line;

I think it would be better to "eat line" before anything else, above
kmod_module_new_from_name(). So you don't need to change the flow
here.

>                 }
>
>                 node = kmod_list_append(l, m);
> @@ -1676,6 +1677,9 @@ KMOD_EXPORT int kmod_module_new_from_loaded(struct kmod_ctx *ctx,
>                         ERR(ctx, "out of memory\n");
>                         kmod_module_unref(m);
>                 }
> +eat_line:
> +               while (line[len - 1] != '\n' && fgets(line, sizeof(line), fp))
> +                       len = strlen(line);
>         }
>
>         fclose(fp);
> @@ -1825,12 +1829,13 @@ KMOD_EXPORT long kmod_module_get_size(const struct kmod_module *mod)
>         }
>
>         while (fgets(line, sizeof(line), fp)) {
> +               size_t len = strlen(line);
>                 char *saveptr, *endptr, *tok = strtok_r(line, " \t", &saveptr);
>                 long value;
>
>                 lineno++;
>                 if (tok == NULL || !streq(tok, mod->name))
> -                       continue;
> +                       goto eat_line;

same thing here.

thanks
Lucas De Marchi
