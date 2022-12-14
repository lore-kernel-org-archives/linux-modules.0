Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC37BC4332F
	for <linux-modules@archiver.kernel.org>; Wed, 14 Dec 2022 06:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiLNGnb (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 14 Dec 2022 01:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLNGnb (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 14 Dec 2022 01:43:31 -0500
Received: from condef-08.nifty.com (condef-08.nifty.com [202.248.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6065FF0
        for <linux-modules@vger.kernel.org>; Tue, 13 Dec 2022 22:43:29 -0800 (PST)
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-08.nifty.com with ESMTP id 2BE6eamB019952
        for <linux-modules@vger.kernel.org>; Wed, 14 Dec 2022 15:40:36 +0900
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2BE6e7G5028741;
        Wed, 14 Dec 2022 15:40:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2BE6e7G5028741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1671000008;
        bh=TgseHxxGOH7WNGeiNAW21e/LKoZwpSsIdjyiUdPDJTo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s6OWYd7Fvbv8fmre/3yKWhNWoV21b4YFWFUbLc+Ocg30+5KXxDcAu8xBEDqojGSs9
         FS3OcP0M7zaFN22F6qLezlbJRPBjXD4hJqopx1EctCY3kcYibnUg69XUnRwgrxA7CO
         RPoGNJ8Gr2A5pqz9EwQdhFi6beNVmp5Dtf+BgHhIQl4ozwbmk6zaMUvxZsvTznRBqs
         g53OwRiUlKjzpqhX3uJRKozh4GrwpY81RHeXTyZjXedkCFPZrNUk2FAhqWDPpTOTp8
         3fbeZOgbzuq2V8WbJBqhIR9qHTXgqUokBcqSyJnZr+RZluzNiSwWXLzcaTzooaPzjI
         fd6miqE3bJ9uw==
X-Nifty-SrcIP: [209.85.167.174]
Received: by mail-oi1-f174.google.com with SMTP id m204so1887047oib.6;
        Tue, 13 Dec 2022 22:40:07 -0800 (PST)
X-Gm-Message-State: ANoB5plRBzrpZaHD93+Dg7XiKamLF9VSSxuIDNH6HfJgVt1w2b4eKpiy
        Bor7p8mKDW2pAr6clA3tBatyAQbdxCboZXQIrOs=
X-Google-Smtp-Source: AA0mqf5LtLQWNwCy7KczhxVc6ewW+evjDlEVcPWYkygj7lFcfRXdh3kevThHhFNT79ssZikIp8lkGUz+I4w93/di6q0=
X-Received: by 2002:aca:1709:0:b0:35e:7c55:b015 with SMTP id
 j9-20020aca1709000000b0035e7c55b015mr69062oii.287.1671000006142; Tue, 13 Dec
 2022 22:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20221211130408.2800314-1-masahiroy@kernel.org>
In-Reply-To: <20221211130408.2800314-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 14 Dec 2022 15:39:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNARzGX8U5B9y3gST+qW9DVWcdAz3hAQQ=t+Bg8ZAjWSGrQ@mail.gmail.com>
Message-ID: <CAK7LNARzGX8U5B9y3gST+qW9DVWcdAz3hAQQ=t+Bg8ZAjWSGrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: change module.order to list *.o instead of *.ko
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sun, Dec 11, 2022 at 10:04 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> scripts/Makefile.build replaces the suffix .o with .ko, then
> scripts/Makefile.modpost calls the sed command to change .ko back
> to the original .o suffix.
>
> Instead of converting the suffixes back-and-forth, store the .o paths
> in modules.order, and replace it with .ko in 'make modules_install'.
>
> This avoids the unneeded sed command.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>



0day bot reported a breakage when CONFIG_TRIM_UNUSED_KSYMS=y

I will squash the following diff.




diff --git a/scripts/gen_autoksyms.sh b/scripts/gen_autoksyms.sh
index 653fadbad302..12bcfae940ee 100755
--- a/scripts/gen_autoksyms.sh
+++ b/scripts/gen_autoksyms.sh
@@ -48,7 +48,7 @@ cat > "$output_file" << EOT
 EOT

 {
-       [ -n "${read_modorder}" ] && sed 's/ko$/usyms/' modules.order
| xargs cat
+       [ -n "${read_modorder}" ] && sed 's/o$/usyms/' modules.order | xargs cat
        echo "$needed_symbols"
        [ -n "$ksym_wl" ] && cat "$ksym_wl"
 } | sed -e 's/ /\n/g' | sed -n -e '/^$/!p' |





> ---
>
>  Makefile                                    |  2 +-
>  scripts/Makefile.build                      |  2 +-
>  scripts/Makefile.modfinal                   |  6 +++---
>  scripts/Makefile.modinst                    |  2 +-
>  scripts/Makefile.modpost                    |  7 +++++--
>  scripts/clang-tools/gen_compile_commands.py |  8 ++++----
>  scripts/mod/modpost.c                       | 11 ++++-------
>  scripts/modules-check.sh                    |  2 +-
>  8 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 8b5930d521fc..669e25970917 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1569,7 +1569,7 @@ __modinst_pre:
>                 rm -f $(MODLIB)/build ; \
>                 ln -s $(CURDIR) $(MODLIB)/build ; \
>         fi
> -       @sed 's:^:kernel/:' modules.order > $(MODLIB)/modules.order
> +       @sed 's:^\(.*\)\.o$$:kernel/\1.ko:' modules.order > $(MODLIB)/modules.order
>         @cp -f modules.builtin $(MODLIB)/
>         @cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 799df12b53f3..267eb7aac5b2 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -435,7 +435,7 @@ $(obj)/built-in.a: $(real-obj-y) FORCE
>  # modules.order unless contained modules are updated.
>
>  cmd_modules_order = { $(foreach m, $(real-prereqs), \
> -       $(if $(filter %/modules.order, $m), cat $m, echo $(patsubst %.o,%.ko,$m));) :; } \
> +       $(if $(filter %/modules.order, $m), cat $m, echo $m);) :; } \
>         > $@
>
>  $(obj)/modules.order: $(obj-m) FORCE
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 83f2797e530c..a30d5b08eee9 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -15,7 +15,7 @@ include $(srctree)/scripts/Makefile.lib
>  # find all modules listed in modules.order
>  modules := $(call read-file, $(MODORDER))
>
> -__modfinal: $(modules)
> +__modfinal: $(modules:%.o=%.ko)
>         @:
>
>  # modname and part-of-module are set to make c_flags define proper module flags
> @@ -57,13 +57,13 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
>         printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
>
>  # Re-generate module BTFs if either module's .ko or vmlinux changed
> -$(modules): %.ko: %.o %.mod.o scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),vmlinux) FORCE
> +%.ko: %.o %.mod.o scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),vmlinux) FORCE
>         +$(call if_changed_except,ld_ko_o,vmlinux)
>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>         +$(if $(newer-prereqs),$(call cmd,btf_ko))
>  endif
>
> -targets += $(modules) $(modules:.ko=.mod.o)
> +targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o)
>
>  # Add FORCE to the prequisites of a target to force it to be always rebuilt.
>  # ---------------------------------------------------------------------------
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index 65aac6be78ec..836391e5d209 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -26,7 +26,7 @@ suffix-$(CONFIG_MODULE_COMPRESS_GZIP) := .gz
>  suffix-$(CONFIG_MODULE_COMPRESS_XZ)    := .xz
>  suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)  := .zst
>
> -modules := $(patsubst $(extmod_prefix)%, $(dst)/%$(suffix-y), $(modules))
> +modules := $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(modules))
>
>  __modinst: $(modules)
>         @:
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 55a72f5eb76d..f814a6acd200 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -107,7 +107,10 @@ ifneq ($(KBUILD_MODPOST_WARN)$(missing-input),)
>  modpost-args += -w
>  endif
>
> -modorder-if-needed := $(if $(KBUILD_MODULES), $(MODORDER))
> +ifdef KBUILD_MODULES
> +modorder-if-needed := $(MODORDER)
> +modpost-args += -T $(MODORDER)
> +endif
>
>  MODPOST = scripts/mod/modpost
>
> @@ -119,7 +122,7 @@ quiet_cmd_modpost = MODPOST $@
>                 echo >&2 "WARNING: $(missing-input) is missing."; \
>                 echo >&2 "         Modules may not have dependencies or modversions."; \
>                 echo >&2 "         You may get many unresolved symbol warnings.";) \
> -       sed 's/ko$$/o/' $(or $(modorder-if-needed), /dev/null) | $(MODPOST) $(modpost-args) -T - $(vmlinux.o-if-present)
> +       $(MODPOST) $(modpost-args) $(vmlinux.o-if-present)
>
>  targets += $(output-symdump)
>  $(output-symdump): $(modorder-if-needed) $(vmlinux.o-if-present) $(module.symvers-if-present) $(MODPOST) FORCE
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> index d800b2c0af97..0227522959a4 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -138,10 +138,10 @@ def cmdfiles_for_modorder(modorder):
>      """
>      with open(modorder) as f:
>          for line in f:
> -            ko = line.rstrip()
> -            base, ext = os.path.splitext(ko)
> -            if ext != '.ko':
> -                sys.exit('{}: module path must end with .ko'.format(ko))
> +            obj = line.rstrip()
> +            base, ext = os.path.splitext(obj)
> +            if ext != '.o':
> +                sys.exit('{}: module path must end with .o'.format(obj))
>              mod = base + '.mod'
>              # Read from *.mod, to get a list of objects that compose the module.
>              with open(mod) as m:
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 56d856f2e511..b48838a71bf6 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1856,11 +1856,9 @@ static void read_symbols_from_files(const char *filename)
>         FILE *in = stdin;
>         char fname[PATH_MAX];
>
> -       if (strcmp(filename, "-") != 0) {
> -               in = fopen(filename, "r");
> -               if (!in)
> -                       fatal("Can't open filenames file %s: %m", filename);
> -       }
> +       in = fopen(filename, "r");
> +       if (!in)
> +               fatal("Can't open filenames file %s: %m", filename);
>
>         while (fgets(fname, PATH_MAX, in) != NULL) {
>                 if (strends(fname, "\n"))
> @@ -1868,8 +1866,7 @@ static void read_symbols_from_files(const char *filename)
>                 read_symbols(fname);
>         }
>
> -       if (in != stdin)
> -               fclose(in);
> +       fclose(in);
>  }
>
>  #define SZ 500
> diff --git a/scripts/modules-check.sh b/scripts/modules-check.sh
> index e06327722263..4c8da90de78e 100755
> --- a/scripts/modules-check.sh
> +++ b/scripts/modules-check.sh
> @@ -16,7 +16,7 @@ check_same_name_modules()
>         for m in $(sed 's:.*/::' "$1" | sort | uniq -d)
>         do
>                 echo "error: the following would cause module name conflict:" >&2
> -               sed -n "/\/$m/s:^:  :p" "$1" >&2
> +               sed -n "/\/$m/s:^\(.*\)\.o\$:  \1.ko:p" "$1" >&2
>                 exit_code=1
>         done
>  }
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
