Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B31DE4CB
	for <linux-modules@vger.kernel.org>; Thu, 17 Oct 2024 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174208; cv=none; b=Y3zJlB+EixWuzrAwax3a4v61umwL2JLEMdBCqkKMMKa7NE5qWoUP3GHhAf4jjzxw0HjDFIpET0E+8qRIpl6/NahpUDRZ4u4m/oY4Fr5mS64/eaqLNEVzrL4Nr14PS/uqDjVENIDpwzFYmcGJHFVRLcZdo4U+7IwhfnjIDp3IQRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174208; c=relaxed/simple;
	bh=ImKjS1mAlM/QGNcooKsvSkdmdgnP6JCFSjvMcq5jt2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGJCFLHUHSqJa7NnoF6aVugGW5ZaOsXilx5y0VMYv+eowGYwTI74Ne2d4aGJnXVRy3f4PYAlLbVtcMWoBY3XvmZVLV0jdfBpynnmdx4+NR5ZbvG1qOTxlWqIofdSJyJYHD/q/kkU7UqZnlG4eAlxGKhLESeMFiVy3+Clg5RNx1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bZVI0BD0; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bZVI0BD0"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so1440364e87.1
        for <linux-modules@vger.kernel.org>; Thu, 17 Oct 2024 07:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729174201; x=1729779001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffWX4sOiGU0Gsj52d9Xu9O70WErhSlef0BU/L7bSCGY=;
        b=bZVI0BD04kEtK/l/7PQ3x1QdrXMwALUErZEw7IrgpfTZQZl9YoM6LTlsEoGz93ynlq
         c9mzxhucKmRLdXectCeptS5Jkwkr9gdfGWVzAyukSkl0WAGIRWwJyYC8ymyFcez4nBqH
         djVKSuEJI2oXLU1GGbXNkVAc4Ud5C4TIY60gBkAggx/Bc1WihSkBGwG9EN4jOL83DfXo
         +NVF3Pd/ZvmzEMrhaP6HALHOQdiTkDk8q87/+7i0dtUhhaMyOsPEgNVKX0fIbnhmOg5G
         eQilvHjSFRUFgyFLE5Y+wSTaKHhiVuwchyHkjHYBmw4Q/lH1n6Z3jpams3T5zl/1yZid
         UEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729174201; x=1729779001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffWX4sOiGU0Gsj52d9Xu9O70WErhSlef0BU/L7bSCGY=;
        b=xJ7hekLAMbDIQdLC6KOVujiGAJEM8+fceO9DPB+YX95enT+Wf2ZACnJpAHn06pW9C1
         fox2nXBysXfi3de75N/cu+RI5o350c4DLLmG+kTr27zQ6GaZ/42AHC6FSmUVmQbxK3+g
         zcX4uKgIbrqJplOp+CiJvinJQeYiWdV56OLdUt61gTIXcERcRe/HgLFLBAxwGLF5YtRO
         M1YlPCLtDsHmGtUZ1fZjAuECItnN9aT7Rb+SCsHpQP1bJizK7sjIG5ZWibyviY6oUOtF
         E+nkgyKonaRHbtCRC4HGCQREMMlXZOqUq9+LNZzHQO+k1EUmxo36JJdwhbh6C36QePsv
         1aZA==
X-Forwarded-Encrypted: i=1; AJvYcCXGUbYe/1b6Sl7rlqf4bMOJVkp4juyNhSw8MMsgoZH7J+DLu5TGgUMZ1n+ibDg4vmGQSGrpGoHDyCzqQ0B8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1T5e88hmaQOVOJ7gcUt4mSNhT4zMp8uejPvjXqvUnlDEVqm0F
	yJT4cZ6FvFjzF5y9ZcMxSdD4lGo1YeaDhMdv6SJuj3fhXQRMSv69s0ATh7BY3MQ=
X-Google-Smtp-Source: AGHT+IHtZ6iuGFS0h/96h+eqk0OJejp1EEqmyNTB75Id/1Au+oEGx2EvNsYPOJigxq2qwKknsnsYqA==
X-Received: by 2002:a05:6512:3b1e:b0:539:eb2f:a026 with SMTP id 2adb3069b0e04-53a03f36264mr5616478e87.33.1729174201351;
        Thu, 17 Oct 2024 07:10:01 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29895da9sm301265766b.214.2024.10.17.07.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 07:10:01 -0700 (PDT)
Message-ID: <cb0eb97c-bb47-4465-af4f-3b5dfcf41681@suse.com>
Date: Thu, 17 Oct 2024 16:09:59 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/19] gendwarfksyms: Add die_map debugging
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
References: <20241008183823.36676-21-samitolvanen@google.com>
 <20241008183823.36676-32-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241008183823.36676-32-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 20:38, Sami Tolvanen wrote:
> Debugging the DWARF processing can be somewhat challenging, so add
> more detailed debugging output for die_map operations. Add the
> --dump-die-map flag, which adds color coded tags to the output for
> die_map changes.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Acked-by: Neal Gompa <neal@gompa.dev>

Looks ok to me, feel free to use:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr
