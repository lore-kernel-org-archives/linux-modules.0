MIME-Version: 1.0
In-Reply-To: <20150225115336.GA31354@sepie.suse.cz>
References: <CAKi4VA+1krn9rdBWE69DkhNZSrxJoeYzyPgvn-SUk8U0=CxFkw@mail.gmail.com>
	<54EB4C83.2000500@suse.cz>
	<CAKi4VAJwvtLaF1GTw1dg__CXHGjwOwJqUS=g5B0rbPNp1w8dDg@mail.gmail.com>
	<20150225115336.GA31354@sepie.suse.cz>
Date: Sat, 28 Feb 2015 14:24:26 -0300
Message-ID: <CAKi4VAKcDR+BLMDsZ-L5a=xhWOAnPb389P4C-gOVu_J0P3xkmQ@mail.gmail.com>
Subject: Re: Differences between builtins and modules
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michal Marek <mmarek@suse.cz>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Harish Jenny K N <harish_kandiga@mentor.com>,
	linux-modules <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 25, 2015 at 8:53 AM, Michal Marek <mmarek@suse.cz> wrote:
> On Tue, Feb 24, 2015 at 10:02:55PM -0300, Lucas De Marchi wrote:
>> On Mon, Feb 23, 2015 at 12:51 PM, Michal Marek <mmarek@suse.cz> wrote:
>> > On 2015-02-23 15:30, Lucas De Marchi wrote:
>> >> My questions are:
>> >> 1) should we put *all* the "modules" in the builtin index?
>> >
>> > You mean all *.o files that do not end up in some *.ko? That won't work,
>> > because unlike module names, the names of object files are not global.
>>
>> I was actually meaning anything that can have a directory under
>> /sys/module/. I figure we can't easily know this.
>
> I see. Well, we could generate the .modinfo section also for builtin
> object files and discard it from vmlinux later, like this:
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index ac78910..efe1798 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -683,6 +683,7 @@
>         EXIT_CALL                                                       \
>         *(.discard)                                                     \
>         *(.discard.*)                                                   \
> +       *(.modinfo)                                                     \
>         }
>
>  /**
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index 1c9effa..f38abfa 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -16,23 +16,17 @@
>  /* Chosen so that structs with an unsigned long line up. */
>  #define MAX_PARAM_PREFIX_LEN (64 - sizeof(unsigned long))
>
> -#ifdef MODULE
>  #define __MODULE_INFO(tag, name, info)                                   \
>  static const char __UNIQUE_ID(name)[]                                    \
>    __used __attribute__((section(".modinfo"), unused, aligned(1)))        \
>    = __stringify(tag) "=" info
> -#else  /* !MODULE */
> -/* This struct is here for syntactic coherency, it is not used */
> -#define __MODULE_INFO(tag, name, info)                                   \
> -  struct __UNIQUE_ID(name) {}
> -#endif
>  #define __MODULE_PARM_TYPE(name, _type)                                          \
> -  __MODULE_INFO(parmtype, name##type, #name ":" _type)
> +  __MODULE_INFO(parmtype, name##type, MODULE_PARAM_PREFIX #name ":" _type)
>
>  /* One for each parameter, describing how to use it.  Some files do
>     multiple of these per line, so can't just use MODULE_INFO. */
>  #define MODULE_PARM_DESC(_parm, desc) \
> -       __MODULE_INFO(parm, _parm, #_parm ":" desc)
> +       __MODULE_INFO(parm, _parm, MODULE_PARAM_PREFIX #_parm ":" desc)
>
>  struct kernel_param;
>
> Then some script would look at the parmtype= fields in the built-in.o
> files and complement the list of builtin modules. However, the question
> is whether this is worth it. As far as I understand, the problem is just
> the discrepancy between modules.builtin and /sys/module. In practice, no
> sane tool is going to need to modprobe 'vt' or 'printk', because there
> is no configuration in which these modules would exist.

Indeed, not sure it's worth it. I did the change in kmod so we don't
check /sys/module anymore [1]. If this is problematic for distros then
maybe we add a patch like yours to the kernel so they are also present
in modules.builtin index.

thanks

-- 
Lucas De Marchi

[1] https://git.kernel.org/cgit/utils/kernel/kmod/kmod.git/commit/?id=fd44a98ae2eb5eb32161088954ab21e58e19dfc4
