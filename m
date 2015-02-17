MIME-Version: 1.0
In-Reply-To: <20150211204703.GA12794@localhost>
References: <20150211204703.GA12794@localhost>
Date: Tue, 17 Feb 2015 14:58:17 -0200
Message-ID: <CAKi4VALhLxQHpaAUqProwAsfBYBevNAxRN864t1=2kgyM9n3Jg@mail.gmail.com>
Subject: Re: [PATCH] libkmod: check size in elf_get_mem (Take 2)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 11, 2015 at 6:47 PM, Tobias Stoeckmann
<tobias@stoeckmann.org> wrote:
> Revision 2 of this patch, fixes wrong boundary checks of previous attempt.
> Can definitely need some review here. :)

Since this message is going directly to the commit, please put
sentences like above after the "---" in your email. This way "git am"
works and I don't have to manually edit the commit message. Also
there's no need to "sign" the email.


> The function elf_get_mem properly checks if offset is smaller than elf->size,
> but does not perform further memory size validations.
>
> Supply desired size as third argument to elf_get_mem, which is in sync
> with elf_get_uint/elf_set_uint then.
>
> As you can see, further unbounded string operations like strlen are still
> prone to lead to out-of-bounds access, which will be covered in another patch.
> ---
>  libkmod/libkmod-elf.c | 54 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 35 insertions(+), 19 deletions(-)
>
> diff --git a/libkmod/libkmod-elf.c b/libkmod/libkmod-elf.c
> index 2f50ad2..ebd3dea 100644
> --- a/libkmod/libkmod-elf.c
> +++ b/libkmod/libkmod-elf.c
> @@ -197,12 +197,15 @@ static inline int elf_set_uint(struct kmod_elf *elf, uint64_t offset, uint64_t s
>         return 0;
>  }
>
> -static inline const void *elf_get_mem(const struct kmod_elf *elf, uint64_t offset)
> +static inline const void *elf_get_mem(const struct kmod_elf *elf, uint64_t offset, uint64_t size)
>  {
> -       assert(offset < elf->size);
> -       if (offset >= elf->size) {
> -               ELFDBG(elf, "out-of-bounds: %"PRIu64" >= %"PRIu64" (ELF size)\n",
> -                      offset, elf->size);
> +       uint64_t end;
> +
> +       assert(!addu64_overflow(offset, size, &end));

assert may be defined to nothing if "NDEBUG" is define at compile
time. So don't put this check with side-effects inside the assert().
If the check would be always on (which is what we want here) we need
to replace the assert with proper "if (!addu64...() || end >
elf->size)"

the rest looks good.

-- 
Lucas De Marchi
