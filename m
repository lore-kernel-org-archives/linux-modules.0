Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB825374E7A
	for <linux-modules@vger.kernel.org>; Mon, 24 Aug 2026 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561097; cv=none; b=TgysfC9xBVBP5FCGiLDN1Qkp3yU92eNbMKo4XSwD1JNMHYyllnu74Pl2rBXTCKWe/rWX3bSr/E9X8iqeRX71qwpiOYFVkVOpR6jcEd9dHvS9YL9KmaOB381mNHDUzqwJ3+YrMO+Qf+CMv3Gbu7teEiEFpa6A2+U/SRdQDQjGWTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561097; c=relaxed/simple;
	bh=5bELOV6KWz5KF3i9w3Hr+vCvrTivDxgDVqZTegju/wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xi31YF1e7FsHyLBU4xAb1W+wju7slvFzVSd4AYcj06T9SVZ4ZqRqLZqod++47FKRFVLqmtns8xJeIZbd9waAuyVxbih5pmWE6g+O3hlA4OIsN+4XzorWkS9cGsgzmCNFOyYU6iJFJsm38MnaRYF6TwqJL6LuTuKfyEZ72D2eHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTq7OY3v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTq7OY3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78BB1F00A3D
	for <linux-modules@vger.kernel.org>; Mon, 24 Aug 2026 08:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561095;
	bh=wCL+QGPeEsmIxcpLLsbeW3zh//upcJ2W+JFxJg847N4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hTq7OY3vYJizNam6BQgoyJIDYseZuFZglvbzfMiaSbxj7EVvAIGSVOHj2uM8+blJe
	 hmRA0hxHKZ/2yc9qhxp8imc9qtlmdLZ2aWHMDftqDCp0yZaAG3zmR+rnD3vwpeM5UL
	 MTGWbM+h36q3Mz5TkPjoiSuBSl0bR6a62Lq/OFBcByCsBTKFEJbekNH64m/BH1gTYO
	 wIvxPgh1vQxY9S33DsLq19ij4RrJ3Ai05kIUBvXoJTBwu6agOXFmNFWz1Uz+kHN0D4
	 MHxcd9drqSifLCYLd0dihVOcl3dm0uQ4DXCGoxehMjBU5qlKl2Kyo3G+2qzw+NNAds
	 HuWHdw9axKkdw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15d47266baso359635966b.3
        for <linux-modules@vger.kernel.org>; Mon, 24 Aug 2026 01:44:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro1jsgXk8MdN8ds0xAlnsrS7rd+I5S4MIC4J3Y51S0aqBdZK4ui22v2n40zDDO9651E6kq1Ml5VUNnGRppN@vger.kernel.org
X-Gm-Message-State: AFuF++nf9HSz6VlKsHVUN3jvEpU613WSA1d66FTzaZx6vhb1L6aFlupM
	Sg2+dUuSFLsnphAuoYcaiRZH0NRt7W09MlVIgEaeAI4MLzycyajyQThSD295OHI/VaL/ndQtgfb
	LHNHwUrnNG7YM46agKqELt9CAFDtk2U8=
X-Received: by 2002:a17:907:97d5:b0:c20:21be:ea75 with SMTP id
 a640c23a62f3a-c246a33ea8bmr2617673766b.8.1787561094467; Mon, 24 Aug 2026
 01:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820125007.22943-1-yangtiezhu@loongson.cn> <20260820125007.22943-2-yangtiezhu@loongson.cn>
In-Reply-To: <20260820125007.22943-2-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 24 Aug 2026 16:45:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5ihmy7REGKkid3jKqZ0_KJU5js37ZrNFp7HmWYtuHzpA@mail.gmail.com>
X-Gm-Features: AcwNN1WUejfSU-euTVopVVkocrgajia3X00RbTefdMLH8MHKxNP3iUIEaIEhG-o
Message-ID: <CAAhV-H5ihmy7REGKkid3jKqZ0_KJU5js37ZrNFp7HmWYtuHzpA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] module/kallsyms: Rename is_mapping_symbol() to is_ignored_kernel_symbol()
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Petr Pavlu <petr.pavlu@suse.com>, linux-modules@vger.kernel.org, 
	loongarch@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu,

On Thu, Aug 20, 2026 at 8:50=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> The helper function is_mapping_symbol() historically checks for both
> local labels prefixed with ".L" or "L0" and mapping symbols prefixed
> with "$".
>
> Rename it to is_ignored_kernel_symbol() to better reflect this actual
> behavior and scope, preventing conceptual confusion.
I think is_ignored_symbol() is enough, no "kernel" needed.

Huacai

>
> While at it, update the related non-module files, no functional changes.
>
> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  include/linux/module_symbol.h | 7 +++++--
>  kernel/module/kallsyms.c      | 2 +-
>  scripts/faddr2line            | 2 +-
>  scripts/mod/modpost.h         | 2 +-
>  tools/perf/util/symbol.h      | 4 +---
>  5 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.=
h
> index 574609aced99..698d3db2b37e 100644
> --- a/include/linux/module_symbol.h
> +++ b/include/linux/module_symbol.h
> @@ -7,8 +7,11 @@ enum ksym_flags {
>         KSYM_FLAG_GPL_ONLY      =3D 1 << 0,
>  };
>
> -/* This ignores the intensely annoying "mapping symbols" found in ELF fi=
les. */
> -static inline bool is_mapping_symbol(const char *str)
> +/*
> + * Ignore local labels (.L*, L0*) and mapping symbols ($*). These symbol=
s are
> + * not useful for the kernel, for example, they should not appear in kal=
lsyms.
> + */
> +static inline bool is_ignored_kernel_symbol(const char *str)
>  {
>         if (str[0] =3D=3D '.' && str[1] =3D=3D 'L')
>                 return true;
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index f23126d804b2..a52942fd0e07 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -294,7 +294,7 @@ static const char *find_kallsyms_symbol(struct module=
 *mod,
>                  * and inserted at a whim.
>                  */
>                 if (*kallsyms_symbol_name(kallsyms, i) =3D=3D '\0' ||
> -                   is_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
> +                   is_ignored_kernel_symbol(kallsyms_symbol_name(kallsym=
s, i)))
>                         continue;
>
>                 if (thisval <=3D addr && thisval > bestval) {
> diff --git a/scripts/faddr2line b/scripts/faddr2line
> index 622875396bcf..3aca197d513f 100755
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -243,7 +243,7 @@ __faddr2line() {
>                         local cur_sym_elf_size=3D${fields[2]}
>                         local cur_sym_name=3D${fields[7]:-}
>
> -                       # is_mapping_symbol(cur_sym_name)
> +                       # is_ignored_kernel_symbol(cur_sym_name)
>                         if [[ ${cur_sym_name} =3D~ ^(\.L|L0|\$) ]]; then
>                                 continue
>                         fi
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 2aecb8f25c87..d9c21d479dd8 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -198,7 +198,7 @@ static inline bool is_valid_name(struct elf_info *elf=
, Elf_Sym *sym)
>
>         if (!name || !strlen(name))
>                 return false;
> -       return !is_mapping_symbol(name);
> +       return !is_ignored_kernel_symbol(name);
>  }
>
>  /* symsearch.c */
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index a71525335703..8b0780046938 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -31,9 +31,7 @@ struct build_id;
>  struct perf_env;
>
>  /*
> - * Ignore kernel mapping symbols, matching kernel is_mapping_symbol() lo=
gic.
> - * This checks for '$' prefix (used by ARM, AArch64, RISC-V) and
> - * x86 local symbol prefixes (.L* and L0*).
> + * Ignore local labels and mapping symbols, matching kernel is_ignored_k=
ernel_symbol() logic.
>   * Only use this for kernel symbols (kallsyms, ksymbol events, kernel EL=
F DSOs).
>   */
>  static inline bool is_ignored_kernel_symbol(const char *str)
> --
> 2.42.0
>
>
