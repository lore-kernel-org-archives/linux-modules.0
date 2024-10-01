Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC9D1C688B
	for <linux-modules@vger.kernel.org>; Tue,  1 Oct 2024 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791602; cv=none; b=LXGQIhlNNd1kvXQ7HoYk5bmCqrp63cmNsSPjoJSGAE9kBTuwmuvRuw+y7yOTjO2BD6O9Y2gXXMghfmoiEdRDBbSmHmpslg/BARce1ANnkHs5cyWyZMFNu4A6PosAPLiU9BviGHszCGprFE3t2zWQ4sME6MQa5N/ENae6FwDgD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791602; c=relaxed/simple;
	bh=+iPU0fn7EcCoD2zDRl9DsTdDWwII4IZpnhiKWSKXYYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qG9rl1x/5mlALRJpipAtLt9NueNlt1POEzrfc99QPtp9LJDVRXNkTrWRKt23sJJ9rdw5XHsiy4GAKwcLGW+uLJE84HvWlKRgwICR29N5ncLEhID17ru1EpLDd5Ife2bmZyGbQiSY4dp9r0OsQGN3zEzjECS+0R+dRq7zL4wCmdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VsvkS81i; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VsvkS81i"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a843bef98so810432966b.2
        for <linux-modules@vger.kernel.org>; Tue, 01 Oct 2024 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727791598; x=1728396398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v601Jif6kUJQ/8x19L1lzXuOdJ1nqvtNT1DrvI83GPk=;
        b=VsvkS81ijI9YJMiDakOynegLu1HLRzux5tHOT8EbOh0f+Jmh06fihnHuON/BRrRyOJ
         KCilOxeT/YG+83m6DVCSvQfgoVbQy0yPpGjudJ5kA0PQm3mTEvD0x3p6yNXbCEL/YrdH
         OsLfo1Q5zgeJ7WU6rhdqKAeTEBPXblCb51lHcZQ/Xk63u2YBIZpAXN8fqcO9MoNLSlmN
         iJyX0XYzd4xJlcefGEtOsAtYmEpnMRs/juIV/nWF/Dkkn+FPTEA1Lz/6OstbC1m4Zq/4
         N50a93mk8F7LJXblOxTQL0sgYVtRc8DvBq0mxgSrg4dQDuccEpMFWyiBjd+ntUVB+tWW
         rdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791598; x=1728396398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v601Jif6kUJQ/8x19L1lzXuOdJ1nqvtNT1DrvI83GPk=;
        b=O7OfhXbBCodVLAycsLQ3ik6CSf8y8cCoxCOJT1UeH/UT90/sMWQAgKcGEKBXbzkTfM
         nZ+p9eyShLdNLtNQaDqdf9fXbi2X7Hy5W8wKqn5VhDyId8F5dqfxZNRPuCJhncJ0rJFM
         Aj+N7yx3QYzcJj0tvDqRi8JuHPbv+PKtxJS4Zwf4CZCOuYJyhreAaplGBu/9J0Hokm2S
         yb15ZRBCU3zYnKTrKFk0/RfD3V1Z9UMHyViH2WfXQjlnm6Gu7aVS3HG5BNPl0yDBrjPC
         j8yn3YjcxyBY/Oz8M2HWg/9rP6TOaF1VLaPUEvi0JFUc+iaWQ39ytIf3hA4rQ9fCvXPt
         /g8A==
X-Forwarded-Encrypted: i=1; AJvYcCVi+tDjYGFu8bQ7vuWzKSbG8WsvDqFRR7CTyE24O4gPuXW95S3/obPLeCb6XEdB2ccKrKsSco58h0cKYFiV@vger.kernel.org
X-Gm-Message-State: AOJu0YzOd7Dg9aQwkJn5eLXx+IGkeF8EPWs1tnbnOGWGU/jCMRW2eWjv
	YefahT16qXuagbSNzgIZvpQceWKq12BP98J7NMQKsSGu0dAWPhELOIwp4LKMWTc=
X-Google-Smtp-Source: AGHT+IFp3Q4YscNnmzkDRKzqWL4zun2XT48a4SluqA7j+TucG3ehRZU0wpASdP4zYHp+pPG27ZOTtg==
X-Received: by 2002:a17:906:f591:b0:a86:92a5:247a with SMTP id a640c23a62f3a-a93c491554emr1525004266b.17.1727791598210;
        Tue, 01 Oct 2024 07:06:38 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c29844a1sm732393066b.172.2024.10.01.07.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:06:37 -0700 (PDT)
Message-ID: <429b7310-3724-48a2-a8ac-e686c6945024@suse.com>
Date: Tue, 1 Oct 2024 16:06:37 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/20] gendwarfksyms: Add address matching
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
 Petr Pavlu <petr.pavlu@suse.com>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20240923181846.549877-22-samitolvanen@google.com>
 <20240923181846.549877-26-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240923181846.549877-26-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/24 20:18, Sami Tolvanen wrote:
> The compiler may choose not to emit type information in DWARF for all
> aliases, but it's possible for each alias to be exported separately.
> To ensure we find type information for the aliases as well, read
> {section, address} tuples from the symbol table and match symbols also
> by address.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  scripts/gendwarfksyms/gendwarfksyms.c |   2 +
>  scripts/gendwarfksyms/gendwarfksyms.h |  13 +++
>  scripts/gendwarfksyms/symbols.c       | 153 +++++++++++++++++++++++++-
>  3 files changed, 165 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/gendwarfksyms/gendwarfksyms.c b/scripts/gendwarfksyms/gendwarfksyms.c
> index 096a334fa5b3..5032ec487626 100644
> --- a/scripts/gendwarfksyms/gendwarfksyms.c
> +++ b/scripts/gendwarfksyms/gendwarfksyms.c
> @@ -105,6 +105,8 @@ int main(int argc, char **argv)
>  			return -1;
>  		}
>  
> +		symbol_read_symtab(fd);
> +
>  		dwfl = dwfl_begin(&callbacks);
>  		if (!dwfl) {
>  			error("dwfl_begin failed for '%s': %s", argv[n],
> diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
> index 1a10d18f178e..a058647e2361 100644
> --- a/scripts/gendwarfksyms/gendwarfksyms.h
> +++ b/scripts/gendwarfksyms/gendwarfksyms.h
> @@ -66,14 +66,27 @@ extern int dump_dies;
>   * symbols.c
>   */
>  
> +static inline unsigned int addr_hash(uintptr_t addr)
> +{
> +	return hash_ptr((const void *)addr);
> +}
> +
> +struct symbol_addr {
> +	uint32_t section;
> +	Elf64_Addr address;
> +};
> +
>  struct symbol {
>  	const char *name;
> +	struct symbol_addr addr;
> +	struct hlist_node addr_hash;
>  	struct hlist_node name_hash;
>  };
>  
>  typedef void (*symbol_callback_t)(struct symbol *, void *arg);
>  
>  void symbol_read_exports(FILE *file);
> +void symbol_read_symtab(int fd);
>  struct symbol *symbol_get(const char *name);
>  
>  /*
> diff --git a/scripts/gendwarfksyms/symbols.c b/scripts/gendwarfksyms/symbols.c
> index 1809be93d18c..d84b46675dd1 100644
> --- a/scripts/gendwarfksyms/symbols.c
> +++ b/scripts/gendwarfksyms/symbols.c
> @@ -6,9 +6,41 @@
>  #include "gendwarfksyms.h"
>  
>  #define SYMBOL_HASH_BITS 15
> +
> +/* struct symbol_addr -> struct symbol */
> +static HASHTABLE_DEFINE(symbol_addrs, 1 << SYMBOL_HASH_BITS);
> +/* name -> struct symbol */
>  static HASHTABLE_DEFINE(symbol_names, 1 << SYMBOL_HASH_BITS);
>  
> -static int for_each(const char *name, symbol_callback_t func, void *data)
> +static inline unsigned int symbol_addr_hash(const struct symbol_addr *addr)
> +{
> +	return hash_32(addr->section ^ addr_hash(addr->address));
> +}
> +
> +static int __for_each_addr(struct symbol *sym, symbol_callback_t func,
> +			   void *data)
> +{
> +	struct hlist_node *tmp;
> +	struct symbol *match = NULL;
> +	int processed = 0;
> +
> +	hash_for_each_possible_safe(symbol_addrs, match, tmp, addr_hash,
> +				    symbol_addr_hash(&sym->addr)) {
> +		if (match == sym)
> +			continue; /* Already processed */
> +
> +		if (match->addr.section == sym->addr.section &&
> +		    match->addr.address == sym->addr.address) {
> +			func(match, data);
> +			++processed;
> +		}
> +	}
> +
> +	return processed;
> +}
> +
> +static int for_each(const char *name, bool name_only, symbol_callback_t func,
> +		    void *data)
>  {
>  	struct hlist_node *tmp;
>  	struct symbol *match;
> @@ -21,9 +53,13 @@ static int for_each(const char *name, symbol_callback_t func, void *data)
>  		if (strcmp(match->name, name))
>  			continue;
>  
> +		/* Call func for the match, and all address matches */
>  		if (func)
>  			func(match, data);
>  
> +		if (!name_only && match->addr.section != SHN_UNDEF)
> +			return checkp(__for_each_addr(match, func, data)) + 1;
> +
>  		return 1;
>  	}
>  
> @@ -32,7 +68,7 @@ static int for_each(const char *name, symbol_callback_t func, void *data)
>  
>  static bool is_exported(const char *name)
>  {
> -	return checkp(for_each(name, NULL, NULL)) > 0;
> +	return checkp(for_each(name, true, NULL, NULL)) > 0;
>  }
>  
>  void symbol_read_exports(FILE *file)
> @@ -55,6 +91,7 @@ void symbol_read_exports(FILE *file)
>  
>  		sym = xcalloc(1, sizeof(struct symbol));
>  		sym->name = name;
> +		sym->addr.section = SHN_UNDEF;
>  
>  		hash_add(symbol_names, &sym->name_hash, hash_str(sym->name));
>  		++nsym;
> @@ -77,6 +114,116 @@ struct symbol *symbol_get(const char *name)
>  {
>  	struct symbol *sym = NULL;
>  
> -	for_each(name, get_symbol, &sym);
> +	for_each(name, false, get_symbol, &sym);
>  	return sym;
>  }

What is the reason that the for_each() call in symbol_get() is invoked
with name_only=false?

> +
> +typedef void (*elf_symbol_callback_t)(const char *name, GElf_Sym *sym,
> +				      Elf32_Word xndx, void *arg);
> +
> +static void elf_for_each_global(int fd, elf_symbol_callback_t func, void *arg)
> +{
> +	size_t sym_size;
> +	GElf_Shdr shdr_mem;
> +	GElf_Shdr *shdr;
> +	Elf_Data *xndx_data = NULL;
> +	Elf_Scn *scn;
> +	Elf *elf;
> +
> +	if (elf_version(EV_CURRENT) != EV_CURRENT)
> +		error("elf_version failed: %s", elf_errmsg(-1));
> +
> +	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
> +	if (!elf)
> +		error("elf_begin failed: %s", elf_errmsg(-1));
> +
> +	scn = elf_nextscn(elf, NULL);
> +
> +	while (scn) {
> +		shdr = gelf_getshdr(scn, &shdr_mem);
> +
> +		if (shdr && shdr->sh_type == SHT_SYMTAB_SHNDX) {
> +			xndx_data = elf_getdata(scn, NULL);
> +			break;
> +		}
> +
> +		scn = elf_nextscn(elf, scn);
> +	}
> +
> +	sym_size = gelf_fsize(elf, ELF_T_SYM, 1, EV_CURRENT);
> +	scn = elf_nextscn(elf, NULL);
> +
> +	while (scn) {
> +		shdr = gelf_getshdr(scn, &shdr_mem);
> +
> +		if (shdr && shdr->sh_type == SHT_SYMTAB) {
> +			Elf_Data *data = elf_getdata(scn, NULL);
> +			unsigned int nsyms;
> +			unsigned int n;
> +
> +			if (shdr->sh_entsize != sym_size)
> +				error("expected sh_entsize (%lu) to be %zu",
> +				      shdr->sh_entsize, sym_size);
> +
> +			nsyms = shdr->sh_size / shdr->sh_entsize;
> +
> +			for (n = 1; n < nsyms; ++n) {
> +				const char *name = NULL;
> +				Elf32_Word xndx = 0;
> +				GElf_Sym sym_mem;
> +				GElf_Sym *sym;
> +
> +				sym = gelf_getsymshndx(data, xndx_data, n,
> +						       &sym_mem, &xndx);

Please check for sym==NULL in case the file is malformed, e.g.
.symtab_shndx is truncated.

> +
> +				if (GELF_ST_BIND(sym->st_info) == STB_LOCAL)
> +					continue;
> +
> +				if (sym->st_shndx != SHN_XINDEX)
> +					xndx = sym->st_shndx;
> +
> +				name = elf_strptr(elf, shdr->sh_link,
> +						  sym->st_name);
> +
> +				/* Skip empty symbol names */
> +				if (name && *name)
> +					func(name, sym, xndx, arg);
> +			}
> +		}
> +
> +		scn = elf_nextscn(elf, scn);
> +	}
> +
> +	check(elf_end(elf));
> +}
> +
> +static void set_symbol_addr(struct symbol *sym, void *arg)
> +{
> +	struct symbol_addr *addr = arg;
> +
> +	if (sym->addr.section == SHN_UNDEF) {
> +		sym->addr = *addr;
> +		hash_add(symbol_addrs, &sym->addr_hash,
> +			 symbol_addr_hash(&sym->addr));
> +
> +		debug("%s -> { %u, %lx }", sym->name, sym->addr.section,
> +		      sym->addr.address);
> +	} else {
> +		warn("multiple addresses for symbol %s?", sym->name);
> +	}
> +}
> +
> +static void elf_set_symbol_addr(const char *name, GElf_Sym *sym,
> +				Elf32_Word xndx, void *arg)
> +{
> +	struct symbol_addr addr = { .section = xndx, .address = sym->st_value };
> +
> +	/* Set addresses for exported symbols */
> +	if (addr.section != SHN_UNDEF)
> +		for_each(name, true, set_symbol_addr, &addr);
> +}
> +
> +void symbol_read_symtab(int fd)
> +{
> +	elf_for_each_global(fd, elf_set_symbol_addr, NULL);
> +}

-- 
Thanks,
Petr
