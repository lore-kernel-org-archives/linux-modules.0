Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ED3C433DB
	for <linux-modules@archiver.kernel.org>; Sat,  6 Feb 2021 04:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F5064F06
	for <linux-modules@archiver.kernel.org>; Sat,  6 Feb 2021 04:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhBFECo (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 5 Feb 2021 23:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhBFEAh (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 5 Feb 2021 23:00:37 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA54DC06174A
        for <linux-modules@vger.kernel.org>; Fri,  5 Feb 2021 19:59:56 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h12so13337125lfp.9
        for <linux-modules@vger.kernel.org>; Fri, 05 Feb 2021 19:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BTnpehy4CTdCVEKest/1e3IaXzLBSmY6XBhUozP0tzg=;
        b=gyQejwXcnRMSWLQsrbg5CYpp09f/16cPj0qFk1ag5wOA6BxFuhdS1LhJiMbPXp0VM+
         2K0oCPvxXx6Hmckc3YJPUF6VAcjTjn/I4XxK/cHPqS+ATuPzA2KsW/PE+fApr9BQL4g1
         GgLBgqCZuk3pBrZLFSbDEUuTUuPg6nz5Ojoa8rHGC7KTdKN0caOQmjnz9LYh6HymMkTn
         4ev40PoHQjeDdIvO3zYiMlBpboqywsyedIgBdGsEZ5LwJqZma4zrRP8iEgwr6DvOGzvJ
         SPa3UsxQU76qdiI4m+W1EQ+X9meXYD84fzO3cUKWr6rmFsouY5JU5P9CLw8O9CuOOTg1
         ChWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BTnpehy4CTdCVEKest/1e3IaXzLBSmY6XBhUozP0tzg=;
        b=Ar8pyS0UMvBR+n/VyhDknqtvFPz8jFKR2fh3HLQ46YRiOBaE0UzbTLGy4njLP8GD2C
         EBebJoXOItvfnOAIZ26zJBZl/8kiR4uLr+Fgl7a8r4lYxhgk8mj2ty+g4ARhKRdhcRMU
         AGCKaHBnBClMIHlssNVUehuO05wGe5xsJn9c7PB31x09Y0O+DrzBamdQvHl/gPV+RFF5
         iF3+eYvajzFAly52JfF21ZP2ktF9scqnpjRIHL3nxilYipNFaV5xNRYYzn75up9LDNh+
         XlJJxBnc0+YgeRdB+uS1vehWMHQ1XpTj4++TimZuPQhhJan/toUCNEqqKcHFIA/crM+B
         yW5A==
X-Gm-Message-State: AOAM532HvbPAWvVbKuEo0h82zFWBeptc0bilHgdCLqPXeNItCST3SRtL
        Dzu/mim0mrOXwkYGG/L4avlHxffunEmmdFRqI4Q=
X-Google-Smtp-Source: ABdhPJy2NR59GS/alYtqMtdg4teECoXRAWO4CKe38hcROnVQtQ0VdcfPYBYFSzoM0LfCzEh1upVeZ9Aa8gvFT7SHU8w=
X-Received: by 2002:a05:6512:49b:: with SMTP id v27mr4373239lfq.220.1612583995189;
 Fri, 05 Feb 2021 19:59:55 -0800 (PST)
MIME-Version: 1.0
References: <20210130023600.24239-1-lucas.demarchi@intel.com>
In-Reply-To: <20210130023600.24239-1-lucas.demarchi@intel.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Fri, 5 Feb 2021 19:59:43 -0800
Message-ID: <CAKi4VAKU4h5Z2ri=xYq=n3gtktKXNUPmwbO954f65WhnhvLGpw@mail.gmail.com>
Subject: Re: [PATCH 1/2] testsuite: compress modules if feature is enabled
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Petr Vorel <petr.vorel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Pushed, thanks for reviews.

Lucas De Marchi

On Sat, Jan 30, 2021 at 1:40 AM Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
>
> Since the output needs to be the same, regardless if the module is
> compressed, change populate-modules.sh to conditionally compress the
> module if that feature is enabled.
>
> This way we can execute the tests with any build-time configuration and
> it should still pass.
>
> Suggested-by: Michal Such=C3=A1nek <msuchanek@suse.de>
> ---
>  Makefile.am                   |  2 +-
>  testsuite/populate-modules.sh | 27 ++++++++++++++++++---------
>  testsuite/test-depmod.c       |  2 --
>  3 files changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index b29e943..24a586e 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -249,7 +249,7 @@ CREATE_ROOTFS =3D $(AM_V_GEN) ( $(RM) -rf $(ROOTFS) &=
& mkdir -p $(dir $(ROOTFS)) &
>                                 find $(ROOTFS) -type d -exec chmod +w {} =
\; && \
>                                 find $(ROOTFS) -type f -name .gitignore -=
exec rm -f {} \; && \
>                                 $(top_srcdir)/testsuite/populate-modules.=
sh \
> -                                       $(MODULE_PLAYGROUND) $(ROOTFS) ) =
&& \
> +                                       $(MODULE_PLAYGROUND) $(ROOTFS) $(=
top_builddir)/config.h ) && \
>                                 touch testsuite/stamp-rootfs
>
>  build-module-playground:
> diff --git a/testsuite/populate-modules.sh b/testsuite/populate-modules.s=
h
> index b0cc932..ae43884 100755
> --- a/testsuite/populate-modules.sh
> +++ b/testsuite/populate-modules.sh
> @@ -4,6 +4,12 @@ set -e
>
>  MODULE_PLAYGROUND=3D$1
>  ROOTFS=3D$2
> +CONFIG_H=3D$3
> +
> +feature_enabled() {
> +       local feature=3D$1
> +       grep KMOD_FEATURES  $CONFIG_H | head -n 1 | grep -q \+$feature
> +}
>
>  declare -A map
>  map=3D(
> @@ -99,15 +105,18 @@ done
>
>  # start poking the final rootfs...
>
> -# gzip these modules
> -for m in "${gzip_array[@]}"; do
> -    gzip "$ROOTFS/$m"
> -done
> -
> -# zstd-compress these modules
> -for m in "${zstd_array[@]}"; do
> -    zstd --rm $ROOTFS/$m
> -done
> +# compress modules with each format if feature is enabled
> +if feature_enabled ZLIB; then
> +       for m in "${gzip_array[@]}"; do
> +           gzip "$ROOTFS/$m"
> +       done
> +fi
> +
> +if feature_enabled ZSTD; then
> +       for m in "${zstd_array[@]}"; do
> +           zstd --rm $ROOTFS/$m
> +       done
> +fi
>
>  for m in "${attach_sha1_array[@]}"; do
>      cat "${MODULE_PLAYGROUND}/dummy.sha1" >>"${ROOTFS}/$m"
> diff --git a/testsuite/test-depmod.c b/testsuite/test-depmod.c
> index 261559c..d7802d7 100644
> --- a/testsuite/test-depmod.c
> +++ b/testsuite/test-depmod.c
> @@ -25,7 +25,6 @@
>
>  #include "testsuite.h"
>
> -#ifdef ENABLE_ZLIB
>  #define MODULES_ORDER_UNAME "4.4.4"
>  #define MODULES_ORDER_ROOTFS TESTSUITE_ROOTFS "test-depmod/modules-order=
-compressed"
>  #define MODULES_ORDER_LIB_MODULES MODULES_ORDER_ROOTFS "/lib/modules/" M=
ODULES_ORDER_UNAME
> @@ -57,7 +56,6 @@ DEFINE_TEST(depmod_modules_order_for_compressed,
>                         { }
>                 },
>         });
> -#endif
>
>  #define SEARCH_ORDER_SIMPLE_ROOTFS TESTSUITE_ROOTFS "test-depmod/search-=
order-simple"
>  static noreturn int depmod_search_order_simple(const struct test *t)
> --
> 2.30.0
>
