Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDACD35B64A;
	Fri, 23 Jan 2026 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168350; cv=none; b=dE9mTlPAlHH2w2Lb5dVNvQep8LCZpXlKMKesUgtDQY4zLaZ0hwi5Yw4wJQt1zh5MWitqBRV4AlHx4MmSAY4C4m2CuXT8WxaFlKIfxb/WoFiCasSporkN7fxVHZXtoqJ0RN1mHFBep+1PBXrHYH99S+iv22qpcpuAjLGdpe96UZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168350; c=relaxed/simple;
	bh=S8JqAJ26GnU0nV6ZUiIbzkEBN50OMkiLOLi8r5Hb5+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OACFzxHCmip96lct2x/ABmAUfhqShvwYgiaEA2jI2zlnarNFK96OoKijp4KdPRofxUNgUMuBvtjlaqE8JTnTCUHntIchgx3T/qGy0gqWpWg7p/O3byN456iWLtOINnYvHAvyAARL24wPbl8GBPjhHhnCiopVYNqnN06qQ1FJX0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7ukc/nt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7ukc/nt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C5AC4CEF1;
	Fri, 23 Jan 2026 11:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769168350;
	bh=S8JqAJ26GnU0nV6ZUiIbzkEBN50OMkiLOLi8r5Hb5+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m7ukc/nt4NbJdRyjo9xi9EvdGxwDx8AXlzezi58qq6e/xpYydIY8ey1VgKOoLEP+G
	 WOPnl47Xf61pnqKO64xVgg99VicauITo2AjY3lF+Xtb6356M/WbxDEDuJ+W6tEYCcc
	 0mmkw9WimARqjtLT/u/QdcC4DU16AV580SvtuGR8e8wcQkL8tLA7WxW/XN9StcSxNk
	 yoORdUFxFb4UZO65F/fX/IR3x7b4qeaugsTSHl3p8LDXGYKitgN/W7UejitTr/eZwb
	 8P5sas5fBbrGh1NVZ5qA8Hv3aFL18ozOoIpJf8Mg1FzcMWY+M1gnMrbuahU8U0Jk4I
	 PYgGBROqBBMrw==
Message-ID: <6277616a-e66d-4ed1-b5d2-270f95d6eacc@kernel.org>
Date: Fri, 23 Jan 2026 12:39:06 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] module: speed modprobe by adding name_crc to
 struct module
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org
References: <20260122234621.3403276-1-jim.cromie@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260122234621.3403276-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/01/2026 à 00:46, Jim Cromie a écrit :
> [Vous ne recevez pas souvent de courriers de jim.cromie@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> "modprobe foo" currently does strcmp on the name, this can be improved.
> 
> So this commit:
> 
> 1. adds name_crc to struct module
> 2. modpost.c computes the value and
> 3. outputs it for "modinfo foo" to see/use.
> 
> 4. adds hotpath to find_module_all()
>     this uses name_crc to do quick "name-check"
>     falls back to strcmp only to guard against collisions.
> 
> This should significantly reduce modprobe workload, and shorten module
> load-time.

Any numbers of how significant is the reduction ?

> 
> Since it alters struct module, its binary incompatible. This means:
> 
> 1. RFC for its wide "blast radius".
> 2. suitable for major version bump *only*
> 
> 3. it opens door for further struct module reorg, to:
>     a. segregate fields by "temperature"
>     b. pack out paholes.
>     c. improve cache locality (by reordering coldest on bottom)
>        name should be cold now.
>        bikeshedding is appropriate here.
> 
> NB: this isn't a substitute for CONFIG_MODULE_SIG.
> It reimplements crc_le(), doesn't reuse kernel's version.

Why not use the kernel's version ?

> 
> CC: Luis Chamberlain <mcgrof@kernel.org>
> CC: Petr Pavlu <petr.pavlu@suse.com>
> CC: Daniel Gomez <da.gomez@kernel.org>
> CC: Sami Tolvanen <samitolvanen@google.com>
> CC: Aaron Tomlin <atomlin@atomlin.com>
> CC: linux-modules@vger.kernel.org
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> 
>   '#' will be ignored, and an empty message aborts the commit.
> ---
>   include/linux/module.h | 15 ++++++++-------
>   kernel/module/main.c   |  8 ++++++--
>   scripts/mod/modpost.c  | 18 ++++++++++++++++++
>   scripts/mod/modpost.h  |  6 +++++-
>   4 files changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index d80c3ea57472..4ea6c5ae3374 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -402,10 +402,18 @@ struct klp_modinfo {
> 
>   struct module {
>          enum module_state state;
> +       u32 name_hash;

In the subject you say "name_crc"

> 
>          /* Member of list of modules */
>          struct list_head list;
> 
> +       /* Sysfs stuff. */
> +       struct module_kobject mkobj;
> +       struct module_attribute *modinfo_attrs;
> +       const char *version;
> +       const char *srcversion;
> +       struct kobject *holders_dir;
> +

Shouldn't this move be another patch ?

>          /* Unique handle for this module */
>          char name[MODULE_NAME_LEN];
> 
> @@ -414,13 +422,6 @@ struct module {
>          unsigned char build_id[BUILD_ID_SIZE_MAX];
>   #endif
> 
> -       /* Sysfs stuff. */
> -       struct module_kobject mkobj;
> -       struct module_attribute *modinfo_attrs;
> -       const char *version;
> -       const char *srcversion;
> -       struct kobject *holders_dir;
> -
>          /* Exported symbols */
>          const struct kernel_symbol *syms;
>          const u32 *crcs;
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d855f43a2be3..685218b2c5ef 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -39,6 +39,7 @@
>   #include <linux/mutex.h>
>   #include <linux/rculist.h>
>   #include <linux/uaccess.h>
> +#include <linux/crc32.h>
>   #include <asm/cacheflush.h>
>   #include <linux/set_memory.h>
>   #include <asm/mmu_context.h>
> @@ -431,13 +432,16 @@ struct module *find_module_all(const char *name, size_t len,
>                                 bool even_unformed)
>   {
>          struct module *mod;
> +       u32 incoming_name_hash = crc32_le(0, name, len);
> 
>          list_for_each_entry_rcu(mod, &modules, list,
>                                  lockdep_is_held(&module_mutex)) {
>                  if (!even_unformed && mod->state == MODULE_STATE_UNFORMED)
>                          continue;
> -               if (strlen(mod->name) == len && !memcmp(mod->name, name, len))
> -                       return mod;
> +               if (mod->name_hash == incoming_name_hash) {
> +                       if (strlen(mod->name) == len && !memcmp(mod->name, name, len))
> +                               return mod;
> +               }

Why not just adding the following instead of modifing existing test:

	if (mod->name_hash != incoming_name_hash)
		continue;

>          }
>          return NULL;
>   }
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 755b842f1f9b..ae90e0bf9330 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -21,6 +21,22 @@
>   #include <stdbool.h>
>   #include <errno.h>
> 
> +/* Local CRC32 implementation for modpost.c */
> +#define CRCPOLY_LE 0xEDB88320
> +
> +typedef uint32_t u32;
> +
> +static u32 crc32_le(u32 crc,  char  *p, size_t len)
> +{
> +       int i;
> +       while (len--) {
> +               crc ^= *p++;
> +               for (i = 0; i < 8; i++)
> +                       crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE : 0);
> +       }
> +       return crc;
> +}
> +

Why do you re-implement crc32_le() ?

>   #include <hash.h>
>   #include <hashtable.h>
>   #include <list.h>
> @@ -1581,6 +1597,7 @@ static void read_symbols(const char *modname)
> 
>          /* strip trailing .o */
>          mod = new_module(modname, strlen(modname) - strlen(".o"));
> +       mod->name_hash = crc32_le(0, mod->name, strlen(mod->name));
> 
>          /* save .no_trim_symbol section for later use */
>          if (info.no_trim_symbol_len) {
> @@ -1834,6 +1851,7 @@ static void add_header(struct buffer *b, struct module *mod)
>          buf_printf(b, "#include <linux/compiler.h>\n");
>          buf_printf(b, "\n");
>          buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
> +       buf_printf(b, "MODULE_INFO(name_crc, \"0x%08x\");\n", mod->name_hash);
>          buf_printf(b, "\n");
>          buf_printf(b, "__visible struct module __this_module\n");
>          buf_printf(b, "__section(\".gnu.linkonce.this_module\") = {\n");
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 2aecb8f25c87..3fc3cfd0a039 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -11,11 +11,14 @@
>   #include <fcntl.h>
>   #include <unistd.h>
>   #include <elf.h>
> +#include <stdint.h>
>   #include "../../include/linux/module_symbol.h"
> 
>   #include <list_types.h>
>   #include "elfconfig.h"
> 
> +typedef uint32_t u32;
> +
>   /* On BSD-alike OSes elf.h defines these according to host's word size */
>   #undef ELF_ST_BIND
>   #undef ELF_ST_TYPE
> @@ -126,7 +129,8 @@ struct module {
>          bool seen;
>          bool has_init;
>          bool has_cleanup;
> -       char         srcversion[25];
> +               char         srcversion[25];
> +               u32          name_hash;
>          // Missing namespace dependencies
>          struct list_head missing_namespaces;
>          // Actual imported namespaces
> --
> 2.52.0
> 
> 

