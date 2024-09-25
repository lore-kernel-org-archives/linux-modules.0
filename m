Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41368158DCC
	for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727305210; cv=none; b=AShJ5/61VhWDk8oVWxSrst6S+WX0T9IEBJAJRAOK0pXmsDdV61dcG4uwKrRvIIdZOEFMSMUvgaN2F8ikU1GYWPNvcN/dz0Hjrtw+1veh7LcJ0ufJ4jqyjFh8wytCHqAqxtCARaFvQreLF++EgDd+zZ5EGCDgwDNPvILLBR4g92g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727305210; c=relaxed/simple;
	bh=kQStd7Sr/RrN6skcJm3qMMqtRvr2awicCI5PoWvm6FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTVoY/gQn/icMvrZGwGSvNoZukeBuyEq3rj8JY/mCYLZghKCOjqJfUnYxXu9r4lSWgyllouaH9qlmPl2jtr471+fIX5PVmuYiE2q9kZPDFP5QroMtCLDIbHdGfNKIMk4jryXS1L0Zu+j3CSxUd/SrPw7gvaUiXc7oullJrxZLW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IcomXzl5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IcomXzl5"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b061b7299so38565ad.1
        for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 16:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727305209; x=1727910009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vl8E5j+ZmDbmKOpu44SNpmShgOamIMtl/ODRrZ2cGY4=;
        b=IcomXzl5tWEX1JaDgotIOyN48qUKBEo4AgZJF7Vasz2qOzWowsC1mo6dVWq1TxaFpb
         39rRcbbIQFUkXBSt3uTZ3J9SvWDXYHPOI0o2N/CRlGbJjCWgUNj5z8t6xzKKJaQW3hIt
         O8L+xJNAdHFNW/3jIYOJ09RLG0CynCiPLCmCkVW8ZfE/DXLjdufok9H2QYvJ+3VXLHav
         0bYA5jN9/fVjzgflicpwQ7cc7cY1rxGjtr87j7P2Ht/r8T1TZLiGQ2XXwc5+G5eKPKkJ
         l7I6RWK2QD6aTkRIMfEYiMSfglb+/joCAke+E9V3X7e8y8HbcrwzhLxGwivHD9gTEPrJ
         UR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727305209; x=1727910009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vl8E5j+ZmDbmKOpu44SNpmShgOamIMtl/ODRrZ2cGY4=;
        b=o07le6sve5gJh+XniILioS+sN7X1a/sa5ZVa/icqKfCofslmwau8nQw6prVChqZH5j
         2BCisblntzh5F4J+pF+Uz3YX4c9XSyq71qt0SiYpywZn1My7cIOskTBF6z00nluY+HGy
         oTnaF2S0sLphM3LVbjAdquMUdCLL8zNT3s7VsV7sWJF0h04Tq+Fv8XCcMRQFKSd6q/HZ
         EidtrEr69WSQ7XeKLHw9Xi+yBRw/Yp6ijE5hm3twHcf7sL+ybVr758dfpXEsNLvAbRTg
         ONzZSFWOzUsFW6gTMlqflYqCnoATZ/sYLAbTdfAZrhlkWCUe96+fQ1uRnArjg3wGvNEx
         hV7w==
X-Forwarded-Encrypted: i=1; AJvYcCXohRr0KhKtcDM2pO6H/VBcoVWqIOj+R+oQfe+Qi58DOZ5bdf02GHBehfujMBBbppDiWCH4BtLI7gl+RKNb@vger.kernel.org
X-Gm-Message-State: AOJu0YzIYEcG8M0HmJYcomkRpAlGq7JO9EK/KdzHL9pkhvf0X6kIQTl1
	wLnCJs/UKxadbjyVkLLwJsY7MXnR+XkaCns7qRSnPnYtEkAo1bCLGv7JUmHc2Q==
X-Google-Smtp-Source: AGHT+IFG1pBJvk67WuIMPqXmbr6qCgX/nanvp1+Hex9+YWAbxaQzu9KQp5bWrdANVwkkvt84iFfWmg==
X-Received: by 2002:a17:902:ec83:b0:206:a87c:2873 with SMTP id d9443c01a7336-20b202f1655mr563355ad.5.1727305208163;
        Wed, 25 Sep 2024 16:00:08 -0700 (PDT)
Received: from google.com (164.135.233.35.bc.googleusercontent.com. [35.233.135.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc8493cdsm3190227b3a.88.2024.09.25.16.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 16:00:07 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:00:00 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Matthew Maurer <mmaurer@google.com>
Cc: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org,
	gary@garyguo.net, mcgrof@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Naveen N Rao <naveen@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	neal@gompa.dev, marcan@marcan.st, j@jannau.net,
	asahi@lists.linux.dev, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linuxppc-dev@lists.ozlabs.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v4 14/16] modules: Support extended MODVERSIONS info
Message-ID: <20240925230000.GA3176650@google.com>
References: <20240924212024.540574-1-mmaurer@google.com>
 <20240924212024.540574-15-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924212024.540574-15-mmaurer@google.com>

Hi Matt,

On Tue, Sep 24, 2024 at 09:19:56PM +0000, Matthew Maurer wrote:
> +static void dedotify_ext_version_names(char *str_seq, unsigned long size)
> +{
> +	unsigned long out = 0;
> +	unsigned long in;
> +	char last = '\0';
> +
> +	for (in = 0; in < size; in++) {
> +		if (last == '\0')
> +			/* Skip one leading dot */
> +			if (str_seq[in] == '.')
> +				in++;

Thanks for addressing Michael's comment, this looks correct to me.

Nit: might be cleaner in a single if statement though:

	/* Skip one leading dot */
	if (last == '\0' && str_seq[in] == '.')
		in++;

> +void modversion_ext_start(const struct load_info *info,
> +			  struct modversion_info_ext *start)
> +{
> +	unsigned int crc_idx = info->index.vers_ext_crc;
> +	unsigned int name_idx = info->index.vers_ext_name;
> +	Elf_Shdr *sechdrs = info->sechdrs;
> +
> +	/*
> +	 * Both of these fields are needed for this to be useful
> +	 * Any future fields should be initialized to NULL if absent.
> +	 */
> +	if ((crc_idx == 0) || (name_idx == 0))
> +		start->remaining = 0;
> +
> +	start->crc = (const s32 *)sechdrs[crc_idx].sh_addr;
> +	start->name = (const char *)sechdrs[name_idx].sh_addr;
> +	start->remaining = sechdrs[crc_idx].sh_size / sizeof(*start->crc);
> +}

This looks unchanged from v3, so I think my comment from there
still applies:

https://lore.kernel.org/lkml/CABCJKufJK0WO92wnW09VTLqZk0ODxhuKQG=HbKE-va0urJU1Vg@mail.gmail.com/

Sami
