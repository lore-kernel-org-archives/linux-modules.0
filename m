Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2CB3E2ACD
	for <linux-modules@vger.kernel.org>; Tue, 19 May 2026 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225816; cv=none; b=EnOUxaR7fh8/RHJhQbtbSP/1OBiR3mQ1rL0xiYlEcH5dZI26ew1RU52YjjJBJ6nufZm9BnniaDtRjjsYKHJswPZ0TV3PKYQAyUbqaqdzzRj/1zgOXX8kMUS+y5KEBudgITMs8mhuiQTWNMSs6BaXi6RQn9yz/udRYzVqxH2aU2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225816; c=relaxed/simple;
	bh=lWpu8BLqWj1TfNJlm3ClQfJmScLbNoYxCmBu95VgfzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOW9PBIuoITEo2uSQrDghcO7DOeULAzf7g16ZWVVq3GiAmFmbXF7ExM5t6xtwFS6CcoA6jchYGEryYVb2Rw5FEpc9RD59o4Jh+rgZFh2EmQhqibYukpgdujpDBqcu+SgadHhAY4KN24005YyqZgLoJiAsYxEqLksQICB2EJj/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OlUf+Sdl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OlUf+Sdl"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso495ad.0
        for <linux-modules@vger.kernel.org>; Tue, 19 May 2026 14:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779225815; x=1779830615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JQ56lnoRLJyhWveNJGv3cFgJb4oUuS+nNxeIsg+gH7Y=;
        b=OlUf+SdlQxGGE420K3w/hBZFOOiiyiNflgf+i0Ze7GEHpZwBHdXHBw5SWQmvBaRWBz
         Itss8MFwpuN4P9ZSEB7H7maXMWl5Hwk9L4djSAxmS38ESM+99UhFvPNOLXS/bLLam9JB
         ANIFxm6w7VADD/C/VxC4fuhIsIw+iR8uLEcrGC/xYAjf5ywx3ZRlGpERtoVRc9zRGOMZ
         0tCeFsPx8Qt1hSgfCBBEBEB7sxguj9ao2PeduAvI5wmKwT9Hp1ROwIU24ulKGq4zVehq
         qZ1F6Rhq0HjG7LACg7VyHTIApf2kzIIlAaWYmEH4oF59YdgAuW9zffLpckZhVN+HlANc
         cofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779225815; x=1779830615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQ56lnoRLJyhWveNJGv3cFgJb4oUuS+nNxeIsg+gH7Y=;
        b=JLBzrkkSRZE2HAR4SxWtr9E5kBhQ/NSRHYMLQqkK1ulm2rYK1e5K6luwPjO4ktjkQP
         inGeMPHUpTXgmCJHMd/qvMQr7HzNlo4AaMU/x6PdaCf0/CbBGfVVypGRL06r16G0sEF5
         AqEeWRPsoBsKftwioJTFViHyLGVNpRzVbK4ueWnl+0gVnNzL8Eyez07tVYKtORO/8O6l
         iqhJ7u6IfXO16bnwrEYyn2D2MRUZSLNQG7j+Fnc+aVt7OOOg8BigNVFaRfYEAqcf8Nkm
         zdqwiMh4vnoAW60QLWa+8kpI8xhJT3vrTswajHCNSzUQcpeKXQ5IR+omgZR59Kbqx+Wy
         pgjA==
X-Gm-Message-State: AOJu0YyOpy5yLCuZhk9pl/rIOpy6SQBbrpJY/c7cVOC6gtH7APKeETZj
	aCq798ySRumit8ET6F7RHjJxwboxbxgNM+7eNafzSrzArzQ2yT7/Giz39j1FkEAe6NVuwVG5WCF
	scqQ89ijxpsE=
X-Gm-Gg: Acq92OFuI1mfKUF1wNOhO7/SbqcPEH4bpiT3k30/jwFEY8/V7a+hBCi0lyMa2eCzaeT
	9pbsO0S9VJF//en3wA970+HlblbQphsZzW5HRT02M/SvdYgZXvhmD7+akj6t5aDukJdE7wW8ERn
	LhK05xCpkXOkUJjTF/E8upX87SDQ4cOFdFKt7Y0IOmoKzb8f6/GZcpTu7L0opJ1CYv/TxkJg219
	MX1wGIgYvnsOJXUJeLd5aVZI4UKR1gCOQMeZLRh2cNnKrGnJTfJI0pEl9/V7w6oxENWTIU/Zmc7
	zKz2X/pbPx0nnMojDNTMwx0we2U/uTQ+C5gPhHBW93T+NYHcdK1lrh1J6Y2sCiE+/6OMR1QQyoq
	b+K6uHprxesawvWvj9KYkxYQn/jQiRYeWBm7Nhn29cXwUpobzP8Kwy3hy0OaZHjvtMyG6RLQkB9
	mZtC1BcKuAYYiYMncMFXI6taT4ehP3tsxsJjavPDrZmFhPtcYGSZW9ZKnZzJcAyTG7NftGox4qW
	8IIffo=
X-Received: by 2002:a17:902:ef52:b0:2bd:6dad:7ccb with SMTP id d9443c01a7336-2bdb32bb6damr8726015ad.23.1779225814226;
        Tue, 19 May 2026 14:23:34 -0700 (PDT)
Received: from google.com (171.46.125.34.bc.googleusercontent.com. [34.125.46.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f196660easm18608271b3a.11.2026.05.19.14.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 14:23:33 -0700 (PDT)
Date: Tue, 19 May 2026 21:23:28 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Andrii Kuchmenko <capyenglishlite@gmail.com>
Cc: linux-modules@vger.kernel.org, chleroy@kernel.org, mcgrof@kernel.org,
	dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] module: decompress: check return value of
 module_extend_max_pages()
Message-ID: <20260519212328.GA2614626@google.com>
References: <20260518143233.16091-1-capyenglishlite@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518143233.16091-1-capyenglishlite@gmail.com>

Hi Andrii,

On Mon, May 18, 2026 at 05:32:33PM +0300, Andrii Kuchmenko wrote:
> module_extend_max_pages() calls kvrealloc() internally and returns
> -ENOMEM on allocation failure. The return value is never checked.

We should definitely fix this, but I'm not sure the rest of the
commit message is entirely accurate.

> The decompression loop then continues calling module_get_next_page(),
> which writes struct page pointers into info->pages[]. When used_pages
> reaches the stale max_pages value (not updated due to the failed
> extend), a subsequent write to info->pages[used_pages++] goes out of
> bounds into adjacent heap memory.
> 
> Adjacent slab objects in the same kmalloc cache (pipe_buffer,
> seq_operations, cred) can be corrupted, potentially leading to local
> privilege escalation on kernels without SLAB_VIRTUAL mitigation.

Looking at the code:

- struct load_info info is zero-initialized in init_module_from_file().

- If module_extend_max_pages() fails, info->pages remains NULL and
  info->max_pages and info->used_pages both remain 0.

- module_get_next_page() sees info->max_pages == info->used_pages
  immediately and calls module_extend_max_pages(info, 0).

- kvrealloc() is called with a size of 0 and it returns ZERO_SIZE_PTR.

- Because ZERO_SIZE_PTR != NULL, module_extend_max_pages() sets
  info->pages to ZERO_SIZE_PTR and returns 0.

- module_get_next_page() writes to info->pages[info->used_pages++],
  and the write to ZERO_SIZE_PTR results in an immediate oops.

This isn't great, but I do not see a potential for an out-of-bounds
write or slab corruption in this specific case. What am I missing?

Sami
