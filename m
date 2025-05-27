Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696424888D
	for <linux-modules@vger.kernel.org>; Tue, 27 May 2025 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748332550; cv=none; b=GI2v9DC8/Z07TnFabMiHhaiKJlQiAdtMUD1zDmoN9CPh2IJewVce+ykOsU5TTLtemQOSa/SoE6RTQHhcudvG/S6KBJEcCuxZCIcTv5HD1Z89dSeO9jEGB6pXMsUgMzB65qJgElOMjNWblj74IDey34xrhkc6+CuwgVuXeHWblPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748332550; c=relaxed/simple;
	bh=DSqmTgfY7dHzFTdbczYIQKSSfxjU6gLpEJ4Vcv0tVlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKCE1SosE86qL8TUqlOG+DhFThBYEc5IKtdqCWAs871I3QrFP4qMpSUReKiQHMx0MyQrMuiqLri4OaeK7bpo5pHvqzB7PnGZLtVxyxhyhMlOY5hXlsY+kIUGKg+5tVhLEt7FfYUL08gi4fVPhYXjX/xFYRiedz+KzFA3IWKqWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gp55y0tg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gp55y0tg"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a365a6804eso1848667f8f.3
        for <linux-modules@vger.kernel.org>; Tue, 27 May 2025 00:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748332546; x=1748937346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4V1pVAjxvwYLOelIoYLXWbI8rf88pC3QzgaJmIacw0=;
        b=Gp55y0tgzlodcl+PCJ2VbvUuQbYKR4cb4OzFCMyLmasyu0nm2xAx54OwvaEYdoLVAI
         xboCyqEigH85EDbMN8tVBdkuKzhKErdNW8UAk3eLJFNZ/ixi9uGbDWRWUMWa95aQ0evv
         KBAXd4v79YlVQxXQGGwH6Zel2zIboVDb5yc9TJQYHZR0mCkvgjThJeIT8pJlLbqrpAPK
         esNDyYJRGRSTYuiM8EOeD9G3EdFhqTwGoOyEF2WycYyQTBsKaMuqw1+VWkzGMRHJLJae
         isDWlQB5zjnDwIjjnD7T+7Kat6R9TvLvi+Zfi2RU4h+1ROLcS+nvqxaI/759YyVU+NEn
         u01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748332546; x=1748937346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4V1pVAjxvwYLOelIoYLXWbI8rf88pC3QzgaJmIacw0=;
        b=GgtepLYTyDFmZGhnOHLNQ6eogP4yKO2Vt2+VZKdO9J+pKNk+S69pbYo3lFolsREcoR
         APYb0cnsgAlBD98Sv8E5g1P5iaWk4dWZVWGjAVrEjVsI2TMwl6KDn00Mg/6drwXxx4A7
         VDqxaQR0ScbaUbM4y2WpP5xFQpNlSAtTWDi+4yp7rA8I1ymTbKYD7kUrDVePi0sB8BpP
         wSPwzJV1KRpcXwFPxOSKriiiw5Yq8QUEekhRiO540EpEAGlkqpwjKvpXcN4Op237PwUh
         h6e42QhPny4OddjJ+vNyFZWysyMn45vJOHHl7plE47VJIQC1+/aijscXJjVn29KLLXyV
         4F2w==
X-Forwarded-Encrypted: i=1; AJvYcCWIC7OjeUe4XvbTAi5bd+xbMb37AHUCyvEHNYHxLO9IFkl/1tyGovrEIVx9N6OfcvRRBurjChgw+PvYb3Eg@vger.kernel.org
X-Gm-Message-State: AOJu0YxmRHA83UmxO1VuIo5oWZM6N/YO0N/cjLIHvFMB/yRlG0sjw3Q0
	PKOnDlJkfxah3tfBzwZNG1A4kzAfmgEkhSXnibn6U3oFiOHaD1IQbzxj1o9rPjlUQ84=
X-Gm-Gg: ASbGncvN8GVFUClyQQc7LySHcX61ay/RDYbZncyoxkBOiu2nw/rhKq8AwW9+Ye7B0kn
	jCKWreKAZ8HNUJKfbAhfbWMbNId0KITbJNlIKarztxIkZzJ2bpx3a8N6Lj5u/z4Blc/IGGaYw62
	dDzoqh+sUR3Y54h/HD23xF2ylWnX60ox+dD/23Z0AV3st9QArhKpugU3EcBq8FaskWsOC+oUxou
	LTPcDtRdqztlqgRrIMQ+eQ6/Rgqb0PTd49YCUEQeYbi5uUIvHXuNm1q4qdHOVPoQrNBg/a5VaFe
	rdeuFkGUtojorVKgG/fCHp7ZmT1XnqZPQdQL2KiG3ObcAE9DoG04xw==
X-Google-Smtp-Source: AGHT+IFUx0JRQGioBEzkta845pUECy34/zcY7WGKeuIMwmVfEbYP2vIkm10xwit2X/PhsJzPp3ehjw==
X-Received: by 2002:a05:6000:1785:b0:3a3:63d3:369a with SMTP id ffacd0b85a97d-3a4cb4602a6mr8243909f8f.25.1748332546433;
        Tue, 27 May 2025 00:55:46 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d4a24429sm6974875f8f.36.2025.05.27.00.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 00:55:46 -0700 (PDT)
Message-ID: <e31cd61f-cd64-41ff-8111-95b871534b2b@suse.com>
Date: Tue, 27 May 2025 09:55:45 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] modpost: allow "make nsdeps" to skip module-specific
 symbol namespace
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Gomez <da.gomez@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org
References: <20250522071744.2362563-1-masahiroy@kernel.org>
 <20250522071744.2362563-2-masahiroy@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250522071744.2362563-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 09:17, Masahiro Yamada wrote:
> When MODULE_IMPORT_NS() is missing, "make nsdeps" runs the Coccinelle
> script to automatically add MODULE_IMPORT_NS() to each module.
> 
> This should not occur for users of EXPORT_SYMBOL_GPL_FOR_MODULES(), which
> is intended to export a symbol to a specific module only. In such cases,
> explicitly adding MODULE_IMPORT_NS("module:...") is disallowed.
> 
> This commit handles the latter case separately in order not to trigger
> the Coccinelle, and displays the error message:
> 
>   ERROR: modpost: module "foo" uses symbol "bar", which is exported only for module "baz"
> 
> Apply the same logic for kernel space as well.
> 
> Fixes: 092a4f5985f2 ("module: Add module specific symbol namespace support")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Looks ok to me.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

Does this patch make the following note about nsdeps in
Documentation/core-api/symbol-namespaces.rst (currently only in
linux-next) obsolete and can it now be removed?

"""
Note: it will happily generate an import statement for the module namespace;
which will not work and generates build and runtime failures.
"""

-- 
Thanks,
Petr
