Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C3171E43
	for <linux-modules@vger.kernel.org>; Mon,  2 Dec 2024 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156070; cv=none; b=uv4OdkaBrGgtqHWgJHtu+vryYRWu/6piDmcgComDQksWVgJYNXycDptsP+AI1Oqr3yfVo8bDdioQHSkkTzaBfCoUY2vfnqJM5eXl6UT5SJBjAAsdtRFOCZjkgk05jlK705fKBrk/XyaIMB48VUSty7aB2Uk8tyEk16wLs11KRgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156070; c=relaxed/simple;
	bh=OwIXuOkl98ecBMfXkAdimvKCgH93U2DB6vsnaTQrIw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYp9GBNgxOvvVxW+rxVjvY+RPA1HSclDu1Tj8wCQzaYZ3rcxYYmJC44HtdXpZ7IIuDoIfYncdgBG4Bdf1rT1rUviL1GGOnT4DYo+HIfAXSUqHa9pWXPCPh9E3ctH5Q9rxmrNkjMbgwFHX6y2Dp+7iFTen2M2wgfglky4DZu/Jjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=foiYXTCb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="foiYXTCb"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4349f160d62so37819135e9.2
        for <linux-modules@vger.kernel.org>; Mon, 02 Dec 2024 08:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733156066; x=1733760866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JkqtF7gf3rzskqYkgv0SBovnNKd2qwXos1/as7nPpuk=;
        b=foiYXTCb5ubz5C1P3skEksMF9LdXPe0Kee+UfgBu7IEZBRzEiI53KnK1sXdqfSewho
         E3PYpFf3M8sM0Mgjr5v3wSkDmb/n/qjqHmkb3WRNN0G2O8JZsNq//1xxu0xbXwvHYuaN
         m3qQx7scKoI+DRZ5xcuxLTDfdLANkIgEfAloJE6WPnV30UAK0PA+aIYBtRd4kQZuKzIq
         fe41ql8JZgefHy4jGp03muOGGtlMjRAqmKu5IxSE+XpW9Pw5VIs2UfNiAJCd5xXnTrl4
         eJjUgH0Fclbx6zUUaXUvuAQ41g0hAxD9UomxC4vN3D5Ky6AIoExAm4tXFzI14vTqE54/
         0yQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733156066; x=1733760866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JkqtF7gf3rzskqYkgv0SBovnNKd2qwXos1/as7nPpuk=;
        b=ZXXBMtXqLwvFznzpfGolh8jkkpk81kN1Ovcqdn2epqR8jajhg/ODMMBr3LkNSVg17L
         /+T30LMgO4XWbEN6LpCOmfbTexBylVjyWjLjbf1y6VpMjU4ZXB7PhbFZATavoobQR9pJ
         G8J4PhheKX6cit3sJAy5vN/ox+eWM1t2McsVMm3JbeqisB9Cjfztdfa9dM9vqlOMKD5I
         jM4SyyMTXGzocvpqjRRUOr0A5oZniarXV23fo0iziX7vWUBtTMzM6dv1vf4nngAUnNa0
         mjPDbKH7gVP0qnxjlC0A647TFvDS/2rD1OWBSMXS1RQJoqWQuS5z/+Xjf0eSQJW3m7bn
         hXiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXiODTsQ23ShDrGdENIC1wmmSxXnoRvXkr0sQZcMvRL0mYVkKK/VhM/70+Vpsw8nVvazd3Ph9d+9icIzbr@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyt6C89dI80tAUxAMbV1V3U0blqk7xdF8IPplnC6wuVnv1+Yvo
	qi4f7Gyq1HHYXS/O64onTvEbtfsEF1R+Xe9mCDOMBjjmGDCxIsdvciBfjfwoSPY=
X-Gm-Gg: ASbGncs8MkxGKNUSj/j5l43LxE0hv15HJUNdniiCUrZR1F9k92cEUKsUVznplgU2Kn4
	t2VBkShKrhb6mWvY0VT6npLbok5K7/UZjb5I9a8EP6mFHGQ0yS8KjtC1zn6NMdKJqcLg9N1Pxnz
	dkbEnRBgEkgtnyv1QY/Pl4Vxzqk4clMSeuoeRnyV/zMRmgnUwJQLh4mR6jqV4HCT+XErwDlTAwF
	Ne+IVW92vSKFe04zz9VtHvzcKfT9Bnru5B8mt2QvGhBzpClTnA2aA==
X-Google-Smtp-Source: AGHT+IFYutETRRcXML+QIddm9XhVvanLL6JGdMr2H3NcnNfxeBujp0ZUmjFwG3N6uzej8qITOTWbNA==
X-Received: by 2002:a05:600c:5253:b0:434:9e1d:7629 with SMTP id 5b1f17b1804b1-434a9e07911mr188863885e9.33.1733156065599;
        Mon, 02 Dec 2024 08:14:25 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa781200sm187506945e9.25.2024.12.02.08.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 08:14:25 -0800 (PST)
Message-ID: <409987f4-d124-48f7-b49c-dd61a4798bef@suse.com>
Date: Mon, 2 Dec 2024 17:14:24 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/18] gendwarfksyms: Limit structure expansion
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>,
 Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20241121204220.2378181-20-samitolvanen@google.com>
 <20241121204220.2378181-29-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241121204220.2378181-29-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 21:42, Sami Tolvanen wrote:
> Expand each structure type only once per exported symbol. This
> is necessary to support self-referential structures, which would
> otherwise result in infinite recursion, and it's sufficient for
> catching ABI changes.
> 
> Types defined in .c files are opaque to external users and thus
> cannot affect the ABI. Consider type definitions in .c files to
> be declarations to prevent opaque types from changing symbol
> versions.

Thanks for adding support for skipping types defined in .c files. That
is a useful feature that genksyms has.

I was also recently thinking that it would be great if genksyms could
skip definitions that are in internal header files, for example,
kernel/events/internal.h. Perhaps something that could be added in the
future..

I've noted one nit below, but the patch looks sensible to me, feel free
to use:
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

> @@ -79,6 +80,55 @@ static bool match_export_symbol(struct state *state, Dwarf_Die *die)
>  	return !!state->sym;
>  }
>  
> +/* DW_AT_decl_file -> struct srcfile */
> +static struct cache srcfile_cache;
> +
> +static bool is_definition_private(Dwarf_Die *die)
> +{
> +	Dwarf_Word filenum;
> +	Dwarf_Files *files;
> +	Dwarf_Die cudie;
> +	const char *s;
> +	int res;
> +
> +	/*
> +	 * Definitions in .c files cannot change the public ABI,
> +	 * so consider them private.
> +	 */
> +	if (!get_udata_attr(die, DW_AT_decl_file, &filenum))
> +		return false;
> +
> +	res = cache_get(&srcfile_cache, filenum);
> +	if (res >= 0)
> +		return !!res;
> +
> +	if (!dwarf_cu_die(die->cu, &cudie, NULL, NULL, NULL, NULL, NULL, NULL))
> +		error("dwarf_cu_die failed: '%s'", dwarf_errmsg(-1));
> +
> +	if (dwarf_getsrcfiles(&cudie, &files, NULL))
> +		error("dwarf_getsrcfiles failed: '%s'", dwarf_errmsg(-1));
> +
> +	s = dwarf_filesrc(files, filenum, NULL, NULL);
> +	if (!s)
> +		error("dwarf_filesrc failed: '%s'", dwarf_errmsg(-1));
> +
> +	s = strrchr(s, '.');
> +	res = s && !strcmp(s, ".c");
> +	cache_set(&srcfile_cache, filenum, res);
> +
> +	return !!res;
> +}
> +
> +static bool is_declaration(Dwarf_Die *die)
> +{
> +	bool value;
> +
> +	if (get_flag_attr(die, DW_AT_declaration, &value) && value)
> +		return true;
> +
> +	return is_definition_private(die);
> +}

Nit: When I read the is_declaration() function in isolation, it is not
clear to me what determining if a definition is private has to do with
the type being a declaration. I think this and related logic in
__process_structure_type() would be easier to follow if the return value
of is_declaration() was negated and the function renamed, for example,
to is_kabi_definition().

-- 
Thanks,
Petr
