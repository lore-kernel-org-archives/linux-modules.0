Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE77C47886E;
	Mon, 18 May 2026 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121275; cv=none; b=ul9g7DG9SNsNk+CWseFOT2BRo2O2NGGKXe5ZVxtJFKImQGu3QIjVYn3mPdtW8TQXPyJfkfYpbbDADJf0EthoMNH05kboGwkE8jFVaFIbyUUjAgiz5AOlBXqiIUI9XVVHNQG50QY1FTeozrrFO3Y0fPkid5rzXjLKpgLF5LRIHsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121275; c=relaxed/simple;
	bh=4ovUSVlsIvBgxFkMAwIXQGZSlg7tcGA+QS26l5de8oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUu0TLon1YM1e+w39YdaS2XSnClXGDluxF+4dx5OEPysVPp15Zm8dlt0YI5fpgkKWOlXpRU92uXDtFuF5+K0Y3HtrGnvmbfsG53xdMWpgvWBxZI3hYLdG3f+yWLY0m9jxmqWZB2kLJ5mwqR7ovkyGstI4gHNWQxS0JZRyN8ax0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/ezEnb0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/ezEnb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5FAC2BCB7;
	Mon, 18 May 2026 16:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779121271;
	bh=4ovUSVlsIvBgxFkMAwIXQGZSlg7tcGA+QS26l5de8oY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e/ezEnb0KYd2gfaJ3NYVQKeJL238+8WbJbN/+x808RyvcwYBCirB2ZLYL7nyIgkoL
	 ikJEPSIgdYLhmc3cjGjepV7WHnBKTuZFi4JWf0uGG8w5IWHzSu6TPHABRxXVbaBOHA
	 fvTHo9fUaqZeo6IPHbtUNYgsrQGiMsuPZRHOwfqplL5DZQBJQDGI0ImHVRAKePm+65
	 IZmngkQ7WFVX6zMRKNyKiLP0sB8sqzgEIjNRGuFD78/FXrz4GJDm5Qh1gEI+AwE6JQ
	 VgUE0JhCNNeVyuD9aXSpHP0eZ3TdQMLwnaxce0gMvGScwmELViUSGMGXIiXDBo4/cN
	 k8Z94vWYXdztA==
Message-ID: <be6734b9-112e-4e71-9013-1c6dc5f750da@kernel.org>
Date: Mon, 18 May 2026 18:21:07 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: decompress: check return value of
 module_extend_max_pages()
To: Andrii Kuchmenko <capyenglishlite@gmail.com>,
 linux-modules@vger.kernel.org
Cc: mcgrof@kernel.org, dmitry.torokhov@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260518143233.16091-1-capyenglishlite@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260518143233.16091-1-capyenglishlite@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/05/2026 à 16:32, Andrii Kuchmenko a écrit :
> [Vous ne recevez pas souvent de courriers de capyenglishlite@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> module_extend_max_pages() calls kvrealloc() internally and returns
> -ENOMEM on allocation failure. The return value is never checked.
> The decompression loop then continues calling module_get_next_page(),
> which writes struct page pointers into info->pages[]. When used_pages
> reaches the stale max_pages value (not updated due to the failed
> extend), a subsequent write to info->pages[used_pages++] goes out of
> bounds into adjacent heap memory.
> 
> Adjacent slab objects in the same kmalloc cache (pipe_buffer,
> seq_operations, cred) can be corrupted, potentially leading to local
> privilege escalation on kernels without SLAB_VIRTUAL mitigation.
> 
> The call order in finit_module() is:
> 
>    module_decompress()    <- vulnerable, runs FIRST
>    load_module()
>      module_sig_check()   <- signature check, runs SECOND
> 
> Decompression happens before signature verification. A crafted
> compressed module submitted via finit_module(MODULE_INIT_COMPRESSED_FILE)
> reaches this code path before any signature gate is applied. On kernels
> with module.sig_enforce=0 (default without SecureBoot) or with
> unprivileged user namespaces (Ubuntu, Debian default), this is
> reachable without CAP_SYS_MODULE.
> 
> Confirmed present in mainline (tested on v6.14-rc3).
> 
> Fix: add the missing error check after module_extend_max_pages() and
> return immediately on failure. This matches the pattern used by every
> other kvrealloc() caller in the module loading path.
> 
> Fixes: 169a58ad824d ("module: add in-kernel support for decompressing")
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrii Kuchmenko <capyenglishlite@gmail.com>
> ---
> Changes in v2:
>   - Remove unnecessary initialization of 'error' to 0 (Christophe Leroy)
>   - Remove unrelated blank line after if (error) return error (Christophe Leroy)
> 
>   kernel/module/decompress.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
> --- a/kernel/module/decompress.c
> +++ b/kernel/module/decompress.c
> @@ -XXX,9 +XXX,12 @@ int module_decompress(struct load_info *info,
>                                  const void *buf, size_t size)
>   {
>          unsigned int n_pages;
>          int error;
>          ssize_t data_size;
> 
>          n_pages = DIV_ROUND_UP(size, PAGE_SIZE) * 2;
>          error = module_extend_max_pages(info, n_pages);
> +       if (error)
> +               return error;
>          data_size = MODULE_DECOMPRESS_FN(info, buf, size);
>          if (data_size < 0) {
>                  error = data_size;
> --
> 2.39.0

