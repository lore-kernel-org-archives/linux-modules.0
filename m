Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200712820DB
	for <linux-modules@vger.kernel.org>; Wed,  8 Oct 2025 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929551; cv=none; b=smEns+bFJmve3yfUozQPdJE0T5KH9RLQTwdQMc5gF5pGznd19oOLS/rduAv6bsM514qGgFtEDdhMfI50tzPr7qX4rAG7SlgrxGCHQOUEQyrSxn7VNvKBs3THirvF8AjS1iRRoBCtn43dguMD5NoCxmXwWNWNgajHGuDl3qpDvfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929551; c=relaxed/simple;
	bh=MFp9KUdYt6xEG2KBVkL/DRBGqry+bbucB+9ElbhxNuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EszkW+RhZJgnvui8znARPMljUHY3GqzHyyOEIMCFRd0xty8ZcFrp1CziB0u3UXsVP1KoE5w0KTQCLUUrTkxe24PTrXbYz0HHd8Mst1+wBiSZZ+RkV8/BuvIJ6dVpxec7THvocGvYbbWzB9EyzaqVzeOv9SjYoo4Oo4Q/MI2oTi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NPTt3lRa; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NPTt3lRa"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso6040746f8f.1
        for <linux-modules@vger.kernel.org>; Wed, 08 Oct 2025 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759929546; x=1760534346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jozU4MCtlsfVf9HK2ileSJtZZH6tHRFGD8OutqReHLk=;
        b=NPTt3lRaVKHqE5xh2rBbCkXQByy+0thnAN0grg/XTTIi8YM9OzUKCEhjXpdlx2xM3l
         eQqnmDPVeI+sw1ERUJ8OtD2G8MsDei1stRSCyFnZXtebkVKt/hvTVZKOSI0bK8XupgSu
         q32aBcW4QbEYMu9mCv2GYYoSWLs/gvgx1uDmHfkeoeAUVNErGuadNoGuJyPqmBBhvyrw
         r63Jt4XvukLbc8jDbfOhkra5WzYyhNTtctxuUuTxgMtA3Eo+cHCUzQOKqxPQL9bRx8pq
         NFmP8tXBtekHA6YJwZQyTscFS8qsir5kb1j8UwfIfz5FtS2Wk6fem2s9AMqKWxrGvol9
         usYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929546; x=1760534346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jozU4MCtlsfVf9HK2ileSJtZZH6tHRFGD8OutqReHLk=;
        b=dG2egpEIHZ/4r28j5cqVbKk3U5lXE2jXK/IHJJd4heREjZoF/3dAaYT31v7pu7elUE
         9r0Xe9TXEEzfKGNuxuXz5FHBodVlwj2QmOyXsT3cl3/eCMA8wt1LtpdafY/CAfTscFS5
         pZUddHKKYIKwi2I7n8fsXPxlr3umL+kB5xkivVq1dHBf0s8TKHO3WlkERoEBV69p05O/
         alpxAO5qCc7QZn6RPZebGyAvOzsmZUhLtYZy16TxRM1v2lXiNvmLAnvpEDUjnHrlAqIC
         QxUdF9vnAe0cF5jWNQlnMJu/cBiE0CnogPXgWiqMAvj5wEEaCBbjgtmseb6LrSi2Vac/
         h1iA==
X-Forwarded-Encrypted: i=1; AJvYcCWLUVfkHVnNgoXziODtH+pjjK6DehJjc6Y0rsEd08JpE+ofaR6S0r0izrjRdDWiCm6UPU1CuR2Z/+ocAWZl@vger.kernel.org
X-Gm-Message-State: AOJu0Yxci8ImtccNDWeyeRHzk/+nw63qkXoDLv75kP54p+IDe4glGZPG
	TAyJJndOpmdap4CTaYe+8gc2G8ntgPNk34ofsG4dNBZBHeXbOoS3HZ5n2EwF8E+Rslk=
X-Gm-Gg: ASbGncuU1P2npOCEE4cQrF6vOwF7Arecp+qhzd6wZ2z1oI0GsBoJtNFWsqDAiGZ2KHB
	W+dTqYLdECpcEreJCJcy8qRo0clGTiZtdLC+uJHltCc3fc8efDet5rT64OpHyZiicC+BE1DFkl7
	n3z0+FNCLCRZ7ygNQC6lFBXfRgcY4n7HamsUeSLr6OmdN5oArv9wCX7sjFk0yQiUVaDLqA0/wjX
	Rh+g4CDeFdxNp7Wd3tb7CfClgBetCQs4FnUbdHRY4l4QLiZkp/9PRC1nwegQFIlKX9s1wUYhY2a
	UNOH8CPD8FQV9T9wxLCyS6GbO2RikjG5YOWx2Oxyvqi/JNPCIhr/XXMwtFYQjxkY+vcw4ywbpxs
	y+UGghD1JrFbUfxwixPKKSuiwJEOhvXGn5hYVOSYrt4H8NftwrzAnkAiMgEQpPeHQLM77m4GY5h
	k=
X-Google-Smtp-Source: AGHT+IEaXUHfbuYM9nod7N9dOjKMSODtcO4+dyB2TLSlYEg1pQ+Lkd4II4POhjx99lRaAkInHDE4Dg==
X-Received: by 2002:a05:6000:2dc9:b0:407:7a7:1cb6 with SMTP id ffacd0b85a97d-4266e8e637amr2098415f8f.55.1759929546358;
        Wed, 08 Oct 2025 06:19:06 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e96e0sm29841221f8f.33.2025.10.08.06.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 06:19:06 -0700 (PDT)
Message-ID: <fdec30b6-e3d0-4694-ba29-3bc99960346a@suse.com>
Date: Wed, 8 Oct 2025 15:19:05 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] module loader: use kflagstab instead of *_gpl
 sections
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Nicolas Schier <nicolas.schier@linux.dev>,
 Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250829105418.3053274-1-sidnayyar@google.com>
 <20250829105418.3053274-5-sidnayyar@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829105418.3053274-5-sidnayyar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 12:54 PM, Siddharth Nayyar wrote:
> Read __kflagstab section for vmlinux and modules to determine whether
> kernel symbols are GPL only.
> 
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
> ---
> [...]
> @@ -2607,6 +2605,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  				     sizeof(*mod->gpl_syms),
>  				     &mod->num_gpl_syms);
>  	mod->gpl_crcs = section_addr(info, "__kcrctab_gpl");
> +	mod->flagstab = section_addr(info, "__kflagstab");
>  
>  #ifdef CONFIG_CONSTRUCTORS
>  	mod->ctors = section_objs(info, ".ctors",

The module loader should always at least get through the signature and
blacklist checks without crashing due to a corrupted ELF file. After
that point, the module content is to be trusted, but we try to error out
for most issues that would cause problems later on.

For __kflagstab, I believe it would be useful to check that the section
is present to prevent the code from potentially crashing due to a NULL
dereference deep in find_exported_symbol_in_section(). You can rename
check_export_symbol_versions() to check_export_symbol_sections() and add
the following:

	if (mod->num_syms && !mod->flagstab) {
		pr_err("%s: no flags for exported symbols\n", mod->name);
		return -ENOEXEC;
	}

-- 
Thanks,
Petr
