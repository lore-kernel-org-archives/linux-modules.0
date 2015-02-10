MIME-Version: 1.0
In-Reply-To: <20150209222251.GA22303@localhost>
References: <20150209222251.GA22303@localhost>
Date: Tue, 10 Feb 2015 00:56:07 -0200
Message-ID: <CAKi4VAK4Bp43VDTRhY7dETZ+sdnvh886vicUrASdCmn9+dtUqA@mail.gmail.com>
Subject: Re: [PATCH] Prevent offset + size overflow.
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, Feb 9, 2015 at 8:22 PM, Tobias Stoeckmann <tobias@stoeckmann.org> wrote:
> Hi,
>
> it is possible to overflow uint64_t by summing variables offset and
> size up in elf_get_section_info. Thee values are extracted from module
> file and are possibly maliciously tampered with.
>
> If offset is in valid range and size very large, the result will
> overflow and the size check passes. Later on, this will most likely
> lead to a segmentation fault due to accessing uninitialized memory.

Indeed, thanks for looking into this.

>
> Attached please find a proof of concept module, which will trigger
> a segmentation fault on modinfo. Tested on amd64:
>
> tobias:~$ modinfo poc.ko
> filename:       /home/tobias/poc.ko
> Segmentation fault
>
>
> Tobias
>
> PS: There are more errors of this type in the ELF handling code, so let
>     me know if you are okay with the additional check in the if-block.
>     I will send patches like this one for the other occurrences then.

The more critical ones (if any) are the ones in the path of loading a
module. For modinfo and depmod, although desirable to have it fixed
it's not as critical since there's little use of this code outside of
kmod tools. Anyway the fix looks good I would accept for fixes like
this. However see the suggestion below.

> ---
>  libkmod/libkmod-elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libkmod/libkmod-elf.c b/libkmod/libkmod-elf.c
> index d1b0f33..8a8a73d 100644
> --- a/libkmod/libkmod-elf.c
> +++ b/libkmod/libkmod-elf.c
> @@ -251,7 +251,7 @@ static inline int elf_get_section_info(const struct kmod_elf *elf, uint16_t idx,
>  #undef READV
>
>         min_size = *offset + *size;
> -       if (min_size > elf->size) {
> +       if (ULLONG_MAX - *offset < *size || min_size > elf->size) {

could we use __builtin_uaddl_overflow() for this? then it would be
(whitespace damaged):

diff --git a/libkmod/libkmod-elf.c b/libkmod/libkmod-elf.c
index d1b0f33..c8c922c 100644
--- a/libkmod/libkmod-elf.c
+++ b/libkmod/libkmod-elf.c
@@ -250,8 +250,8 @@ static inline int elf_get_section_info(const
struct kmod_elf *elf, uint16_t idx,
        }
 #undef READV

-       min_size = *offset + *size;
-       if (min_size > elf->size) {
+       if (__builtin_uaddl_overflow(*offset, *size, &min_size)
+           || min_size > elf->size) {
                ELFDBG(elf, "out-of-bounds: %"PRIu64" >= %"PRIu64"
(ELF size)\n",
                       min_size, elf->size);
                return -EINVAL;

AFAICS only gcc >= 5.0 supports this builtin (clang also has it). So
we may want to add a fallback in missing.h. I just added the support
in the build system so we can check for this builtin.


thanks again.

-- 
Lucas De Marchi
