Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625141;
	b=SuoX3Bd3fjCSkDB+3bP875Nit4UXnhzG39yiWkLOerlb/QQp2KHPZM9nF5o8DWWbRVmv
	 Si1GnVzvJ9WXY8dI9tFMMliCQex6NTorGtRu3tNk4w5+mgjxOWMSlPrZGOxXA7m/8VjMZ
	 xT2sQfY7ouKXpKJASVO5bFCVnrcykpcWsf3SPxW53MfxwimC6jNAH3E+WttpGO2x4qCQ/
	 GirxHWvrJMPvDmhn7PraOxl4N3V7re1ZT94MoGcwv/4i6r0bochn9DClI+fvVBctXoLET
	 PZzDo+q0dUKMtpevrMI/OR6cb6q4xoNIVcZOeRfm+hJ1LExu9O/F5Y55Smg8f8Dnrkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qzSNzkmnLjAnm2o7UEPNC82u2CvWGqHDymHqRLR8nws=;
	b=4PdYzgAIxzS4GiFoTH0T3NkIzz7GII8czOebG9G6nkDmDeEYinnhURw0QSTFF/plo93H
	 gPk/Ee9DaMA6WBmGXlYfLQV7RINg6CADeXIQ9rmLaFjYkEk8y5m5FOA+bNa4gWo+KL+89
	 ibklrx3U4CjZbNyDuR3NHLoG5Sywsl6wlmw8IhjiFfMGh9a2tgROlol1IT2G6RC47w4zK
	 9N7ef78q/xkMKF0ftON09/zG/Pw6Xgp1sUNf9I6K55VIoetA/ST1sFYf0+Z+2QPbIxzMz
	 z/KThIGE3bEJ1AepK6P2hffHWL4oxpG22Pp0hHLe/IWdxTO53Bdxma/8u9WDJdTOU2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VeMZMFlK;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270FD606A33F
	for <linux-modules@vger.kernel.org>; Wed, 25 Nov 2026 16:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 270FD606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VeMZMFlK
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4a68190a2a7so4950859f8f.1
        for <linux-modules@vger.kernel.org>; Wed, 25 Nov 2026 08:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795625138; x=1796229938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qzSNzkmnLjAnm2o7UEPNC82u2CvWGqHDymHqRLR8nws=;
        b=VeMZMFlK4XeBzwrDD6z4Doe5ujZ5PmFlBvgdtXgvDNgqyB2+a2sCMN2wk+r327T/uW
         /r2BhYppBsmLCfA6wEf9rqAgdyevRRA01ag2IXLdtngT05rT8V5qUBbFQDnjjQgYE2gf
         VRO105Wv3wS0sYOzpdh62UmMxKFuJZsiAfPK9beaxT/i9ZUHpkfJOUrelw8QBpX9lGS4
         m35Q/nRZpkrOo84dL5yj6BJK1saMLREXy289b+W8lcU1Li54eo2LPH2XZ2BzxTKFv4V2
         TU/7Cyf6kqOyQ8kgJ2U5PgB/NbN2a8Bu0WSQShF93YOhfgaUMd2kQPQDvfuKKEMIIK8r
         gfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625138; x=1796229938;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qzSNzkmnLjAnm2o7UEPNC82u2CvWGqHDymHqRLR8nws=;
        b=FJnjQggBaFWq4TeSMWTl2BsPffP6QEzVUfi2NSE/OpLKFDp+IFSJ6W6suYWm1lVhGy
         evJIaa+7swz76TX2r0lfg4xGQCwVNkREOe+d/E4TeKWTZ88vZkv1UTNqTQn9i8Q6US5R
         WiAy7XK3H8+/6n8XxMH08r5b9fhnIJsJKpri78VfRQndQKothDmJnIuDGZ3fldOyZQkO
         4Yd5czcYfmFsK3iBKQzpgHu14Y+bHT7GDrHJnlC0IxBP4iJp20ZukozbJZadCxCfjPbE
         ES06AHyp49VTHkFOvbnN5ykjxfumxMRxeQzKEaw/58biuPTITQDWQaSzOCyJ8JDgeaYb
         VNTA==
X-Forwarded-Encrypted: i=1; AL+hErEKuOfKJdMGveEZ+nqZ+wBDiPcTkTx5hC+Y5crq9HQnXaORPMwHbRsUugKTsmC+9Qa/WqtoC30R/K4qcR/4@vger.kernel.org
X-Gm-Message-State: APuU4Z/2O4Oc3ZA+taj7JZkSDypVi0uRWGhnbrr4AyTBgwDy5AckrkgP
	Kijwtp7p2x8Bd460HZlprFX7SRgE8/HbLfjuAI+GjqH+XD4iyKZ2y50EWK66buRsDSA=
X-Gm-Gg: AZFdTZcflIuVT0YdO9KfMi+0HzLzwQE19WG74whUF4HQ3DvCaJxWlQlf1QLTT6Seo8t
	G0CxR7RRwf5hddEXQ4sccHmEeR0+fnIGRAc/qFlmD5v0bgfvj2+tnqIHXKHXDq9bdbiX+tHGIIV
	sDy4lNWMpD2fhB1mcp8JrhBHgJ5PJzmoaTbdlIP/o8+O3kutpsZW/UDhHU3kCzHI0FCgoox9OwU
	km4wg0c7t8xWMosOBzGu4C5MZnSFUbGh1bs5tnMr6VUs+qlAZunDcWcnHFQWJNre5NAFfnYJ2Kp
	3a41JXE6/JipecF+ccfao+3/9S8ZzhMsrs0eW7JwoKEnEdzkjYaGcSqw7212E72ebqgqahc4OFq
	0WUfgEWVkjUJ+oAT8ZIz30innxVzJaiBQjHrfU99WrSdf0w0saDzgPx4eZFHsz5hR4+JBuGJ8CL
	bHrcx4Huy2kFdEuKw3sl/B6wDpigp+J9bBu66ht7yrkN/KCH8bZkzrp+w4g02pXv0CrjANCTblR
	qg0/9AQF2RrXwBZ5Oi0b5FccCRhIRWand5x85/RFNnCAv4ZiX31XeI0TZQWShhSd9bvOyt5r3v7
	ehBJdneRPUj5LkIQp553xmyDn2qW56zJEDLG/p92qu8runfFqJ3dR8K1moe+Amp38w==
X-Received: by 2002:a05:6000:4617:b0:48d:f464:6989 with SMTP id ffacd0b85a97d-4abb18cbe2cmr35982135f8f.27.1795625138335;
        Wed, 25 Nov 2026 08:45:38 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c50sm34852448f8f.37.2026.11.25.08.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 08:45:37 -0800 (PST)
Message-ID: <0c2e606e-e0b8-4466-b9dd-4db14cc35d1d@suse.com>
Date: Wed, 25 Nov 2026 17:45:36 +0100
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/9] module: Add module_kallsyms_find_name()
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 David Laight <david.laight.linux@gmail.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-modules@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-13-wusamuel@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261113221248.3535369-13-wusamuel@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/26 11:12 PM, Samuel Wu wrote:
> KALLSYMS_QUERY_BY_NAME, added later in this series, needs to find a
> symbol name or prefix across module symbols in one pass.
> module_get_kallsym() walks the module list from the head and runs an
> export bsearch() for every symbol index.
> 
> Add module_kallsyms_find_name(), and put the shared query struct in
> linux/kallsyms.h, so we have a more efficient linear walk.
> 
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
> [...]
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index 1ff8ce857d92..72006c9bad42 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -406,6 +406,63 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
>  	return -ERANGE;
>  }
>  
> +/**
> + * module_kallsyms_find_name - Find a module symbol by name or prefix
> + * @symnum: in: index to start at; out: index of the match. The index
> + *          counts the symbols of the searched modules in list order.
> + * @q: name query; if @q->modname is set, only that module is searched
> + * @value: set to the symbol address
> + * @name: set to the symbol name (KSYM_NAME_LEN bytes)
> + * @module_name: set to the module name (MODULE_NAME_LEN bytes)
> + *
> + * Undefined (SHN_UNDEF) symbols are skipped.
> + *
> + * Return: 0 on a match, or -ENOENT.
> + */
> +int module_kallsyms_find_name(unsigned int *symnum,
> +			      const struct kallsyms_name_query *q,
> +			      unsigned long *value, char *name,
> +			      char *module_name)

Nit: kernel/module/kallsyms.c already contains a zoo of lookup functions
with similar names. Adding module_kallsyms_find_name() adds more to the
confusion, being similar to module_kallsyms_lookup_name() and
find_kallsyms_symbol_value().

I suggest calling it module_kallsyms_query_name() to match the
kallsyms_name_query parameter and to express that this is a structured
query, as opposed to a simple by-name lookup. It might be a good idea to
similarly stick to "query" instead of "find" in kernel/kallsyms.c.

Otherwise, this looks ok to me from the modules perspective. Feel free
to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
