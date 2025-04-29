Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E552BE0E5
	for <linux-modules@vger.kernel.org>; Tue, 29 Apr 2025 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918753; cv=none; b=MKUed2/S/DymLTT2Y2lNqsJaSRRo7W3oY0+6ToUyW1HFN+yhBb0yvRyDY8Q32Y9dwG6m++3ZSAfhB0WY4D/a+0HlBbwXM1oRhHp0Wzb+opWv1fXayMQBMgJLoxVtiHRs0v0iPTo1PQ/056EeDOI7Sop9HECl3XUgOaEoyS6D6Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918753; c=relaxed/simple;
	bh=f7pDvu6ECsrsgKYQON9e4/9xdDrHgFQnB0lkO8B+Jvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIs8vCRhE5cZWQSsBjWKoWnMmW7JWkFEDdTFarxZC2A8cVQoRo5SlenK55wbKbARBbY5nDOQNxj/kXR+4417Hb5MgPgyMiXfvxYwBZSmr0pBIsmreNRH/osDj0CWMRJU3JAc8Ti0DSql3klEHJ9pfKVdmtLtA6wOIh9rv0IGcIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ANFeMDFn; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ANFeMDFn"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aca99fc253bso867034466b.0
        for <linux-modules@vger.kernel.org>; Tue, 29 Apr 2025 02:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745918748; x=1746523548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ElOoSWZpM3ikc1lzKjU4ubLyP5Lg55VfCDoToohcAo=;
        b=ANFeMDFnUZ9pZMC2WwJnUSeW+cB9AbQht4pnAUVrwa75Di0bV4qxEboKarEi3nng+/
         0dhOhW/zE2BuMCAXXvli9vySzDLi1mxuhhTZK2dqDrSu6hP2ugWwJ69sOgTb44S3Iljs
         lhKWVhKf2OAcbnBQiBVRU+kLfF+ke3FlG69HGQdVL3yzEBB1KPQWTUmBMhMuBXVMSysp
         mOyE+XP2sQIgp0IhZvyIxGE8LAO6oarVdRbaU/mgv98EVPE84V4dbGMXqXjAO8al03J/
         GWv0uCuFl9BSeoQv/FwveK3rZ1+0I1cGYEYiqf39KzC7h8qZfYoDTk3ij/r1Z6LzVEfi
         Tcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918748; x=1746523548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ElOoSWZpM3ikc1lzKjU4ubLyP5Lg55VfCDoToohcAo=;
        b=RzrILskTkIMOAztt9NpXyRtc+/qF4uFgg6NeRz7PxlYGO3NQjtY/L5QV9+wDnXbX2Z
         tPqUJPez6KujMijRfdgtbZgTTwJU6ZhhTK7nkcykcNX5kU3SUt/gFxg4Mbf+DI0L511F
         C1c9YiXTVXVczVxIITxOA0u/S+T/G3d1UDxPs+gazqyeFr362ZSVeAjEoZ0Qlx7zi/jp
         +4d8q5IKNkXKo/3KH1gSfhQRRns+3B0PCKb+Ig7+Hm/HKl8GljcHLEFi4FjAnJ97cCYq
         AXMd45GEEZihsNovZIQzkflZtTfNQwTFfMEjHNoiJmOmGQH52qaUd8dhOyjNUZE/W1/N
         hK+w==
X-Forwarded-Encrypted: i=1; AJvYcCUOjn6D/Ksy03kRbI+cnH7k8O0YmaBbKw2lyWHgM3kY9FFIEzbkFRV0CnZo3KCFE1s5YQz8wNAfN7retM4/@vger.kernel.org
X-Gm-Message-State: AOJu0YwxRh+fXPVi+v3ZOQyD7py3rfoYFfKUxbr+te2NOqf2nAuqfQFY
	MFRWdnFkqMIn1dAH+MV9sl9AQGHivZcSaCaGt/WmxfeSKZRcGkA9unqkUd550eI=
X-Gm-Gg: ASbGncuANR4nW/yKhtxY7+dQp5nTQNbTvvxt9EmwzvYtwz79b9lixLGuLAO33TGHZL7
	Br7EefupdJREhYYHOZ8nkmn78cHytIEnUMYeKVuWUkTIaYJuCivWEBSTBy7EszGjXcSS5bCpwIG
	lRR6NsLnjyzplxX0YZb+TZY/Bj/woMKIVO5T7K3SxAoiLg0FWFlLbtDk/yeqM+Rcn3baTzGGQtB
	FlgyS5QJxdut9l2LKZVT0fcasQzZlV+KClfcdMGQiDGohhWs7W8preioNND5B4lh/x+X1Z1FfEY
	/T798rCAf+HMOncUNfVIVzPVUPA2UoleL4CVfoh5k00=
X-Google-Smtp-Source: AGHT+IFVTRdbb47gFd4dQ11iXGeiIng/kvnJTSM3K0lql6xfI+bbFj82/8CO5oL3FIVEmuzn0vU+WA==
X-Received: by 2002:a17:907:3e05:b0:ace:8398:b772 with SMTP id a640c23a62f3a-ace848f183amr1218151666b.14.1745918748343;
        Tue, 29 Apr 2025 02:25:48 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41bbc3sm752256966b.3.2025.04.29.02.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 02:25:47 -0700 (PDT)
Message-ID: <cf3ff619-6177-42e1-8f64-74cf4cbb8672@suse.com>
Date: Tue, 29 Apr 2025 11:25:47 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/7] modpost: Create modalias for builtin modules
To: Alexey Gladkov <legion@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <cover.1745591072.git.legion@kernel.org>
 <bb0d887760a474e5e7f9db0e9933eee81a5d9ea3.1745591072.git.legion@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <bb0d887760a474e5e7f9db0e9933eee81a5d9ea3.1745591072.git.legion@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/25 18:16, Alexey Gladkov wrote:
> For some modules, modalias is generated using the modpost utility and
> the section is added to the module file.
> 
> When a module is added inside vmlinux, modpost does not generate
> modalias for such modules and the information is lost.
> 
> As a result kmod (which uses modules.builtin.modinfo in userspace)
> cannot determine that modalias is handled by a builtin kernel module.
> 
> $ cat /sys/devices/pci0000:00/0000:00:14.0/modalias
> pci:v00008086d0000A36Dsv00001043sd00008694bc0Csc03i30
> 
> $ modinfo xhci_pci
> name:           xhci_pci
> filename:       (builtin)
> license:        GPL
> file:           drivers/usb/host/xhci-pci
> description:    xHCI PCI Host Controller Driver
> 
> Missing modalias "pci:v*d*sv*sd*bc0Csc03i30*" which will be generated by
> modpost if the module is built separately.
> 
> To fix this it is necessary to generate the same modalias for vmlinux as
> for the individual modules. Fortunately '.vmlinux.export.o' is already
> generated from which '.modinfo' can be extracted in the same way as for
> vmlinux.o.
> 
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  include/linux/module.h   |  4 ----
>  scripts/mod/file2alias.c | 13 ++++++++++++-
>  scripts/mod/modpost.c    | 21 ++++++++++++++++++---
>  scripts/mod/modpost.h    |  7 ++++++-
>  4 files changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 7250b4a527ec..6225793ddcd4 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -257,14 +257,10 @@ extern void cleanup_module(void);
>  	__PASTE(type,			\
>  	__PASTE(__, name)))))))
>  
> -#ifdef MODULE
>  /* Creates an alias so file2alias.c can find device table. */
>  #define MODULE_DEVICE_TABLE(type, name)			\
>  extern typeof(name) __mod_device_table(type, name)	\
>    __attribute__ ((unused, alias(__stringify(name))))
> -#else  /* !MODULE */
> -#define MODULE_DEVICE_TABLE(type, name)
> -#endif
>  
>  /* Version of form [<epoch>:]<version>[-<extra-version>].
>   * Or for CVS/RCS ID version, everything but the number is stripped.
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index dff1799a4c79..0fa3f031b904 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -1471,7 +1471,8 @@ static const struct devtable devtable[] = {
>  /* Create MODULE_ALIAS() statements.
>   * At this time, we cannot write the actual output C source yet,
>   * so we write into the mod->dev_table_buf buffer. */
> -void handle_moddevtable(struct module *mod, struct elf_info *info,
> +void handle_moddevtable(struct list_head *modules,
> +			struct module *mod, struct elf_info *info,
>  			Elf_Sym *sym, const char *symname)
>  {
>  	void *symval;

The new modules parameter is unused.

> @@ -1509,6 +1510,16 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
>  	typelen = name - type;
>  	name += strlen("__");
>  
> +	if (mod->is_vmlinux) {
> +		struct module *builtin_mod;
> +
> +		builtin_mod = new_module(modname, modnamelen);
> +		builtin_mod->is_vmlinux = mod->is_vmlinux;
> +		builtin_mod->dump_file = MODULE_BUILTIN_FNAME;

The module.dump_file member is described in scripts/mod/modpost.h as
"path to the .symvers file if loaded from a file". However, that is not
the case here.

Similarly, the module struct in scripts/mod/modpost.h is commented as
"represent a module (vmlinux or *.ko)", but this patch expands its scope
to also include builtin modules.

I'm not sure it's best to overload this data in this way. I think mixing
actual files and "logical" modules in the modules list is somewhat
confusing.

An alternative would be to keep a single module struct for vmlinux and
record the discovered aliases under it?

-- 
Thanks,
Petr
