MIME-Version: 1.0
Date: Fri, 3 Aug 2018 14:07:34 -0700
References: <20180730190146.GA8535@localhost>
In-Reply-To: <20180730190146.GA8535@localhost>
Message-ID: <CAKi4VALpRspPNWTGsZbpHhH=UKECUF+=wYa0aLZnxZ0=USLxRg@mail.gmail.com>
Subject: Re: [PATCH] Verify memory sizes on 32 bit systems.
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jul 30, 2018 at 12:02 PM Tobias Stoeckmann
<tobias@stoeckmann.org> wrote:
>
> Large file system support is activated by default, which means that
> on 32 bit systems, off_t is 64 bit in size.
>
> Using st.st_size or any other 64 bit variable with mmap can lead to
> integer truncation and therefore insufficient memory mapping.
>
> Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
> ---
>  libkmod/libkmod-file.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
> index 5eeba6a..86f34c6 100644
> --- a/libkmod/libkmod-file.c
> +++ b/libkmod/libkmod-file.c
> @@ -255,6 +255,8 @@ static int load_reg(struct kmod_file *file)
>                 return -errno;
>
>         file->size = st.st_size;
> +       if ((uintmax_t)st.st_size > (uintmax_t)SIZE_MAX)

why casting?

Lucas De Marchi

> +               return -EFBIG;
>         file->memory = mmap(NULL, file->size, PROT_READ, MAP_PRIVATE,
>                             file->fd, 0);
>         if (file->memory == MAP_FAILED)
> --
> 2.13.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-modules" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Lucas De Marchi
