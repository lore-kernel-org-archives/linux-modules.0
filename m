Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF0324716
	for <linux-modules@vger.kernel.org>; Wed, 11 Mar 2026 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263535; cv=none; b=L4H3jIfjsNXzRaugSUqKstV1oGclVChQfTRFxxRf838z6ctW2zmrEE/f2wxDaK+8fR2ssxdk+rOYOOt86zuygHulJ06kofedVIREheOE7J59c85+RUFJc2FthzWYtWbs4ryFX6+Xawuybt4ETNWZUz+6FwdGrbJMumsfMTHg6J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263535; c=relaxed/simple;
	bh=QQfTmCsvjuP9DFFtDxR1itB3grzbZ//YtLxljgkYJ4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXKp42AyRb4oZJ/5rctIICJQeCDWP9T4+gwkWcwJkfrMolG6ooIdyqYrep5OiJaec2AZcV8jEn/oDiR3bcMjQuQemy1Mjjxgr2ZOPF4tLYpmUWuPMmiCwP58WxJThOTS2VbLJM5XQPQ+wbXNF4gDiutwusvIccLjJndqBg6qPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pCqSkzkP; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pCqSkzkP"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4e9697so1143c88.1
        for <linux-modules@vger.kernel.org>; Wed, 11 Mar 2026 14:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773263533; x=1773868333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rtz42F1xPwBdJk/xPFFDJA5HY6dDuesaKHHTOQD4ozQ=;
        b=pCqSkzkP0jdT7nSyygeEPqipsrBQOCibr1Fa/tMzyjQLtUX4n37AYM/9UZiMRjZF1E
         UYzUIrFg98oWoM+Tmb0xOeFunSbeSc0F6OlG4Ek5UrOfMFHF2q9sRm9x/3Bwj3cIO4jZ
         aHr8UFC3kvHjNENa1/uCQY/xIhMhoNC2ufFcJ7RsUSi/yrVS6tgP0hGjnNW/CnjkljxX
         ovC6zjAmphgh1gnSocZ/skXu0dvBldL+seHOLq4aSpu9pyoB/3rOO7EoD11ZVR+CWtvX
         WWGM+NUrBWpfql1xx5cMfZRAlFb5x6a3tw79AgR8NgWN7iqCIORh9ahR9HjgwOgJu9nI
         l8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773263533; x=1773868333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtz42F1xPwBdJk/xPFFDJA5HY6dDuesaKHHTOQD4ozQ=;
        b=rd/UNrFFwj9wpt4AkDzhsA4WaOyOHFWoGo+QUD0JO34VKmPv8RQCyemAnoALGb1yis
         xKrxO5cl6H9s5jepWfqFLQnb8gPAi6qvfUobw61AngBY3G3tdM0P5E75jaJuK/eIZH38
         5KMWAI/HIHGE6Kh8vUPxPfCoWJD5ggwPG0yComKcSSTaq9uCIe1X9xQOaBqdZjonmZru
         Hawa8ZBzaMwNPBgE64C+gbYSuvd9ucmAKKsv+BG7Vha61uOLf7NJw9md6V9QMnYvHgVv
         zLEsvrLuT41ARkbBnI9sKuabYTQW1a71b1HMLi/EzrlSrTNKi11vBjiZbt3gMfsv5pm4
         N8Ng==
X-Gm-Message-State: AOJu0Yw1muLfSCt+kU2T/GzOwVnVITMkcNWUkjYJWN0CXAg5rB+34NyX
	AWWZiyyKZfLVhQ2mjPmW5uc/OQCTNmOBk9kjSZL5tGvjd2cS3a0eS+tAsEaXNbWpiQ==
X-Gm-Gg: ATEYQzxfIj0k4G5VODtdh74OeEiJC6afgqyAhmUntCkvMmMVhnkmXJKOdDAl59SqOXM
	kxM9aW5lySJxg2qJWrpPgz7FQKmO4qIv51lK3smHEPhla6LzkyThNwdPrzM44rQuqX3n1nGe62i
	2ZC7+criMUNCxjv2w0a/fkkFxjRSxIEYvqQnam3/cYYglDO8DlXBoILlU0s3keBhhfIrlrUG+9p
	q2CbAs/zJ8yAOToeWIoAbetYW8bB30vbtfK0J+h5zNLMgC0tmaD8lKy8G1mN9nYo6K+7apOZ8w+
	bH+mI55m+E/fp3uFcWsAaVRgnVMNWYLDMuDvIIiPY/+XQr/fzh6+tA62VgItpl1ZLoseeN3WAQX
	lsrTc9mFB1YYlQ+e/FP/1DCG6xtTNKngZral48fh64cCGFvkPwuiE1ZcysPDEe+7ujtbX6+21/t
	+zFBouRp+UZJ/2N0tYwCumwC6lPoRVy2N3F62vDkREPwtWTeIu/WDjfVncuQRgdRZqPD8=
X-Received: by 2002:a05:701b:231b:b0:120:5719:1856 with SMTP id a92af1059eb24-128ed17640dmr48302c88.20.1773263532267;
        Wed, 11 Mar 2026 14:12:12 -0700 (PDT)
Received: from google.com (197.23.125.34.bc.googleusercontent.com. [34.125.23.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7c1780bsm4480538c88.7.2026.03.11.14.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 14:12:11 -0700 (PDT)
Date: Wed, 11 Mar 2026 21:12:07 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>, Petr Mladek <pmladek@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v2] module.lds,codetag: force 0 sh_addr for sections
Message-ID: <20260311211207.GA2440964@google.com>
References: <20260305015237.299727-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305015237.299727-1-joe.lawrence@redhat.com>

On Wed, Mar 04, 2026 at 08:52:37PM -0500, Joe Lawrence wrote:
> Commit 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and
> related macros") added .text and made .data, .bss, and .rodata sections
> unconditional in the module linker script, but without an explicit
> address like the other sections in the same file.
> 
> When linking modules with ld.bfd -r, sections defined without an address
> inherit the location counter, resulting in non-zero sh_addr values in
> the .ko.  Relocatable objects are expected to have sh_addr=0 for these
> sections and these non-zero addresses confuse elfutils and have been
> reported to cause segmentation faults in SystemTap [1].
> 
> Add the 0 address specifier to all sections in module.lds, including the
> .codetag.* sections via MOD_SEPARATE_CODETAG_SECTIONS macro.
> 
> Link: https://sourceware.org/bugzilla/show_bug.cgi?id=33958
> Fixes: 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros")
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  include/asm-generic/codetag.lds.h |  2 +-
>  scripts/module.lds.S              | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> v2:
> - Update the MOD_SEPARATE_CODETAG_SECTION for .codetag.* as well [Petr]

Do we also need similar changes in any of the architecture-specific module
linker scripts (arch/*/include/asm/module.lds.h)?

Sami
