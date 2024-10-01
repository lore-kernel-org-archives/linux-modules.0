Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6038F1C8FD5
	for <linux-modules@vger.kernel.org>; Tue,  1 Oct 2024 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792195; cv=none; b=JMOhwii6qICjyyameImtjbQbF3a8aEiZfNILRNNo7M6oY25Pn3VXQJUqOjdCztEuQLi1lRMcTj02qSu6J6qLBNXYrxrfHUC4OUOnOLqlmEV9PCsxDh2TJplm9PcdNAuAmvAbqY+LkeWU2MYvZ0zED+z244bsMpWFbbKuB2K8I+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792195; c=relaxed/simple;
	bh=KZ6gxq2XwRcWtv8D5rnzb8GbirDDkQOi0Cssa0mv4jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTu1dCJonxPf8TC+cz5lVhNZPJZf9s3Dcv0LVS50TRm/Yc8s/3VVbWTSPRBUeaiPfN6H75nVXtLE/cX2AqTEgmWbxY/9HMz2B4agrT9zLefilASRJClvwWBTjEUc+G2G3nyFEIES+Y2FWtF+7WlP9FoYW9y6Hmq5305qXUE998o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ux7DY547; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ux7DY547"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5399041167cso3979499e87.0
        for <linux-modules@vger.kernel.org>; Tue, 01 Oct 2024 07:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727792190; x=1728396990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1y1eDJ+lKiKTVFnuA1FG1rr27+98ONVA3jJSEumLGkM=;
        b=Ux7DY547cRRiPvPq5LwdAb4+zcqqRbj63AE2h0qTsNC2ZYxUX9t4gG9VqjRmB6x6ec
         VmFdHYqkSuyzr+fbiofgv5kktWDmJg1Cvgn+YAgkqhlM7ti3xFagWELKopk05QH2T9Ns
         W9DhKYVb9gHc7y8/6vsL9dle9DwKwXql0peIaBtOfZgrAwqsS806ue8hvsRE5keJ9qIu
         4xDkpZqUYh7Gk4InAjyWv0mNwLcf0eIh1sdwGuASqZ4EOkAicXxwGDmid97ff15nrtOt
         LZwg/HS2zWaQ/iE60Qv8rsQ6xclVOrlyActcil3AEpCBqG0lee5klonUNMOInun/w6TE
         L6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727792190; x=1728396990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1y1eDJ+lKiKTVFnuA1FG1rr27+98ONVA3jJSEumLGkM=;
        b=L2OGh8txmqjY3Mdg0yUh0QIV6b8vf6ReoObdZFqX0Fcx+cCTb6H/y33uSOaNibdPJv
         8KrwZRtM4EwjkWJZTiiIZ2ebyG3YJW09es9Mi1DMfoESVCKgPY4Xo+R2lWBlJGecKlRt
         eVp61BPY1zDaMQqeGGYwLuIFNeVnQnMc1OSxVQ87VHLZtYfborjNduisXifZXjK8QudX
         hsCSSCOPC7Z1t73uKqrMhY1yQP6O+rH2Yn1hUNoq5YFKuaMG9pfVQvMhGRm0h1MfV/S9
         HnMjDW884hRhPrsjlbvrB+rN7ABMC06fmp4vpuvN8cS3FUUx01fBD7aHh5VeLI7wSLte
         nZuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXadTzsILi0eI9N+O8ODst2DpzIlujVHSgrHHQPDe82BbPsjYOyM81UQ2k7ovxvwCJ8CWkRUaappvzN8Y1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+0hS0q6MJGLz8ijT1XGpJb68K74hWT4Agm9j6O6YAkd3ydjH9
	fK7heSAmZSVV2aE+RLL3f6pmp3A3AfD2XvzVZ55s63nKAhmvgac+cvsoLynqe8k=
X-Google-Smtp-Source: AGHT+IEzx34F6+yE7XgQFu9qIVSJy8ZDXJAMsrzTVer9/GuJ3EjuwlRAW1LXhB1QTpJqjxs6itlZSg==
X-Received: by 2002:a05:6512:6618:b0:539:89a8:600f with SMTP id 2adb3069b0e04-53989a86942mr9581897e87.23.1727792190265;
        Tue, 01 Oct 2024 07:16:30 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c70d3sm717663766b.78.2024.10.01.07.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:16:29 -0700 (PDT)
Message-ID: <f0eee8a9-766a-463c-bc36-676e49efe950@suse.com>
Date: Tue, 1 Oct 2024 16:16:28 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/20] gendwarfksyms: Expand structure types
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
 <20240923181846.549877-32-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240923181846.549877-32-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/24 20:18, Sami Tolvanen wrote:
> Recursively expand DWARF structure types, i.e. structs, unions, and
> enums. Also include relevant DWARF attributes in type strings to
> encode structure layout, for example.
> 
> Example output with --dump-dies:
> 
>   subprogram (
>     formal_parameter structure_type &str {
>       member pointer_type {
>         base_type u8 byte_size(1) encoding(7)
>       } data_ptr data_member_location(0) ,
>       member base_type usize byte_size(8) encoding(7) length data_member_location(8)
>     } byte_size(16) alignment(8) msg
>   )
>   -> base_type void
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  scripts/gendwarfksyms/dwarf.c         | 137 +++++++++++++++++++++++++-
>  scripts/gendwarfksyms/gendwarfksyms.h |   5 +
>  2 files changed, 140 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
> index caf25da0a9b9..b7f1dc29cb9c 100644
> --- a/scripts/gendwarfksyms/dwarf.c
> +++ b/scripts/gendwarfksyms/dwarf.c
> @@ -205,9 +205,13 @@ static void process_fqn(struct die *cache, Dwarf_Die *die)
>  				    value);                                \
>  	}
>  
> +DEFINE_PROCESS_UDATA_ATTRIBUTE(accessibility)
>  DEFINE_PROCESS_UDATA_ATTRIBUTE(alignment)
> +DEFINE_PROCESS_UDATA_ATTRIBUTE(bit_size)
>  DEFINE_PROCESS_UDATA_ATTRIBUTE(byte_size)
>  DEFINE_PROCESS_UDATA_ATTRIBUTE(encoding)
> +DEFINE_PROCESS_UDATA_ATTRIBUTE(data_bit_offset)
> +DEFINE_PROCESS_UDATA_ATTRIBUTE(data_member_location)
>  
>  /* Match functions -- die_match_callback_t */
>  #define DEFINE_MATCH(type)                                     \
> @@ -216,8 +220,11 @@ DEFINE_PROCESS_UDATA_ATTRIBUTE(encoding)
>  		return dwarf_tag(die) == DW_TAG_##type##_type; \
>  	}
>  
> +DEFINE_MATCH(enumerator)
>  DEFINE_MATCH(formal_parameter)
> +DEFINE_MATCH(member)
>  DEFINE_MATCH(subrange)
> +DEFINE_MATCH(variant)
>  
>  bool match_all(Dwarf_Die *die)
>  {
> @@ -295,6 +302,10 @@ static void __process_list_type(struct state *state, struct die *cache,
>  		process(cache, " ");
>  		process(cache, name);
>  	}
> +	process_accessibility_attr(cache, die);
> +	process_bit_size_attr(cache, die);
> +	process_data_bit_offset_attr(cache, die);
> +	process_data_member_location_attr(cache, die);
>  }
>  
>  #define DEFINE_PROCESS_LIST_TYPE(type)                                       \
> @@ -305,6 +316,7 @@ static void __process_list_type(struct state *state, struct die *cache,
>  	}
>  
>  DEFINE_PROCESS_LIST_TYPE(formal_parameter)
> +DEFINE_PROCESS_LIST_TYPE(member)
>  
>  /* Container types with DW_AT_type */
>  static void __process_type(struct state *state, struct die *cache,
> @@ -337,6 +349,7 @@ DEFINE_PROCESS_TYPE(reference)
>  DEFINE_PROCESS_TYPE(restrict)
>  DEFINE_PROCESS_TYPE(rvalue_reference)
>  DEFINE_PROCESS_TYPE(shared)
> +DEFINE_PROCESS_TYPE(template_type_parameter)
>  DEFINE_PROCESS_TYPE(volatile)
>  DEFINE_PROCESS_TYPE(typedef)
>  
> @@ -390,6 +403,106 @@ static void process_subroutine_type(struct state *state, struct die *cache,
>  	__process_subroutine_type(state, cache, die, "subroutine_type");
>  }
>  
> +static void process_variant_type(struct state *state, struct die *cache,
> +				 Dwarf_Die *die)
> +{
> +	process_list_comma(state, cache);
> +	process(cache, "variant {");
> +	process_linebreak(cache, 1);
> +	check(process_die_container(state, cache, die, process_type,
> +				    match_member_type));
> +	process_linebreak(cache, -1);
> +	process(cache, "}");
> +}
> +
> +static void process_variant_part_type(struct state *state, struct die *cache,
> +				      Dwarf_Die *die)
> +{
> +	process_list_comma(state, cache);
> +	process(cache, "variant_part {");
> +	process_linebreak(cache, 1);
> +	check(process_die_container(state, cache, die, process_type,
> +				    match_variant_type));
> +	process_linebreak(cache, -1);
> +	process(cache, "}");
> +}

For variant types, should the tool worry also about DW_AT_discr and
DW_AT_discr_value?

> +
> +static int ___process_structure_type(struct state *state, struct die *cache,
> +				     Dwarf_Die *die)
> +{
> +	switch (dwarf_tag(die)) {
> +	case DW_TAG_member:
> +	case DW_TAG_variant_part:
> +		return check(process_type(state, cache, die));
> +	case DW_TAG_class_type:
> +	case DW_TAG_enumeration_type:
> +	case DW_TAG_structure_type:
> +	case DW_TAG_template_type_parameter:
> +	case DW_TAG_union_type:
> +	case DW_TAG_subprogram:
> +		/* Skip non-member types, including member functions */
> +		return 0;
> +	default:
> +		error("unexpected structure_type child: %x", dwarf_tag(die));
> +	}
> +}
> +
> +static void __process_structure_type(struct state *state, struct die *cache,
> +				     Dwarf_Die *die, const char *type,
> +				     die_callback_t process_func,
> +				     die_match_callback_t match_func)
> +{
> +	process(cache, type);
> +	process_fqn(cache, die);
> +	process(cache, " {");
> +	process_linebreak(cache, 1);
> +
> +	check(process_die_container(state, cache, die, process_func,
> +				    match_func));
> +
> +	process_linebreak(cache, -1);
> +	process(cache, "}");
> +
> +	process_byte_size_attr(cache, die);
> +	process_alignment_attr(cache, die);
> +}
> +
> +#define DEFINE_PROCESS_STRUCTURE_TYPE(structure)                        \
> +	static void process_##structure##_type(                         \
> +		struct state *state, struct die *cache, Dwarf_Die *die) \
> +	{                                                               \
> +		__process_structure_type(state, cache, die,             \
> +					 #structure "_type",            \
> +					 ___process_structure_type,     \
> +					 match_all);                    \
> +	}
> +
> +DEFINE_PROCESS_STRUCTURE_TYPE(class)
> +DEFINE_PROCESS_STRUCTURE_TYPE(structure)
> +DEFINE_PROCESS_STRUCTURE_TYPE(union)
> +
> +static void process_enumerator_type(struct state *state, struct die *cache,
> +				    Dwarf_Die *die)
> +{
> +	Dwarf_Word value;
> +
> +	process_list_comma(state, cache);
> +	process(cache, "enumerator");
> +	process_fqn(cache, die);
> +
> +	if (get_udata_attr(die, DW_AT_const_value, &value)) {
> +		process(cache, " = ");
> +		process_fmt(cache, "%" PRIu64, value);
> +	}
> +}
> +
> +static void process_enumeration_type(struct state *state, struct die *cache,
> +				     Dwarf_Die *die)
> +{
> +	__process_structure_type(state, cache, die, "enumeration_type",
> +				 process_type, match_enumerator_type);
> +}
> +
>  static void process_base_type(struct state *state, struct die *cache,
>  			      Dwarf_Die *die)
>  {
> @@ -400,6 +513,16 @@ static void process_base_type(struct state *state, struct die *cache,
>  	process_alignment_attr(cache, die);
>  }
>  
> +static void process_unspecified_type(struct state *state, struct die *cache,
> +				     Dwarf_Die *die)
> +{
> +	/*
> +	 * These can be emitted for stand-elone assembly code, which means we
> +	 * might run into them in vmlinux.o.
> +	 */

Nit: stand-elone -> stand-alone.

> +	process(cache, "unspecified_type");
> +}
> +
>  static void process_cached(struct state *state, struct die *cache,
>  			   Dwarf_Die *die)
>  {
> @@ -460,17 +583,27 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
>  	PROCESS_TYPE(rvalue_reference)
>  	PROCESS_TYPE(shared)
>  	PROCESS_TYPE(volatile)
> +	/* Container types */
> +	PROCESS_TYPE(class)
> +	PROCESS_TYPE(structure)
> +	PROCESS_TYPE(union)
> +	PROCESS_TYPE(enumeration)
>  	/* Subtypes */
> +	PROCESS_TYPE(enumerator)
>  	PROCESS_TYPE(formal_parameter)
> +	PROCESS_TYPE(member)
>  	PROCESS_TYPE(subrange)
> +	PROCESS_TYPE(template_type_parameter)
> +	PROCESS_TYPE(variant)
> +	PROCESS_TYPE(variant_part)
>  	/* Other types */
>  	PROCESS_TYPE(array)
>  	PROCESS_TYPE(base)
>  	PROCESS_TYPE(subroutine)
>  	PROCESS_TYPE(typedef)
> +	PROCESS_TYPE(unspecified)
>  	default:
> -		debug("unimplemented type: %x", tag);
> -		break;
> +		error("unexpected type: %x", tag);
>  	}
>  
>  	/* Update cache state and append to the parent (if any) */
> diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
> index d5186472f705..ad50e35e3351 100644
> --- a/scripts/gendwarfksyms/gendwarfksyms.h
> +++ b/scripts/gendwarfksyms/gendwarfksyms.h
> @@ -63,8 +63,13 @@ extern int dump_dies;
>  #define checkp(expr) __check(expr, __res < 0)
>  
>  /* Consistent aliases (DW_TAG_<type>_type) for DWARF tags */
> +#define DW_TAG_enumerator_type DW_TAG_enumerator
>  #define DW_TAG_formal_parameter_type DW_TAG_formal_parameter
> +#define DW_TAG_member_type DW_TAG_member
> +#define DW_TAG_template_type_parameter_type DW_TAG_template_type_parameter
>  #define DW_TAG_typedef_type DW_TAG_typedef
> +#define DW_TAG_variant_part_type DW_TAG_variant_part
> +#define DW_TAG_variant_type DW_TAG_variant
>  
>  /*
>   * symbols.c

-- 
Thanks,
Petr
