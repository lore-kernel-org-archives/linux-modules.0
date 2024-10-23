Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5A81C9EAC
	for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695314; cv=none; b=p7OEdrzGftosXfrK45Q3O0m4j+BijCjl85Zg0dGeKHbKJaJfHZX6eMs46woRNh3RqQMZC09M0rYYSYUEp8XaurCEEucJXGuXT8y8JVY0xYLbktguEM3//VhsKL5GxefVQ2O1tSFC2tFNIerAcndCc68uS39pNDvhYJo7vUQH1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695314; c=relaxed/simple;
	bh=ryoYcQggY/kP3u+FVq17nFJ4+xrseLriosS64MBSjiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMw+w/gpjM2FTYwcduGAwiHwJHP00C5buFq8cNLcHr7wGsRC2JXJ3tREF0LY49D2tV0mmb330DWiQJ67XsrDbIQsZIbLqTEn1hNTXIMz793GKTyHuaHiAmMOBSnObzFT7BBNafrteAzhgu668FKfY3UGiFeAJHq4hXayiNP7bM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e4uPbHcb; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e4uPbHcb"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so933167066b.0
        for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 07:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729695311; x=1730300111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gxca2+tKQUchr19uflxCnLEeCJ07Xy8uJKlCwApgGuc=;
        b=e4uPbHcb6f9d+eMF168nzKA9pBtIm0r0/3s5Dk55Q51B/BkwA2UObV3mHVvz9d1m34
         6pgsFKmoWu01QV0VgD9UrPbZdrztpsSvM6bylIvy3Gmm2uEmFJCOHo76soLnRhyN5Prp
         /JhPf7G+sRo89/pTxdcC1yXKVqXChkpt0sbjTa/7LbDVbIQigin0DFOlvffk4wwaTT24
         dHiEdm3firyi1p1FKdwt9R7ssyUlLGQqWEXPOjs0OMP0cbbMlKjdpOWIFNpc7SeJe6g4
         HKDn14rIPgB4r1nxBZ6g0ebPUu40aZT2Id8zUnY0LIuVZbHMHvdERpVzVcLNEJyVOh0G
         YZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729695311; x=1730300111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gxca2+tKQUchr19uflxCnLEeCJ07Xy8uJKlCwApgGuc=;
        b=Wkp57mkgSuHslXtb0YqY8U5MSpegaOTD5sn71INxalGw1VTlZnLWQvKx4RlgsePFJo
         whV8L6FN+5Uke2mwV2vPoVsH/qV5VoBstClN0Ab6/7o1OuIlj/HLZzh3G+EQSLOaTkuZ
         bQYLeMp/s5uABXpsefz52jpSxEakztoduL1neDszh6LqFOlIqzJ6uI728kO7mpc9cT0u
         ekewU5PU1g+qL6oFIHjHaj2KhJJsDXEPfVehI1MEtSPSWmQGRsbOmd9cD5MLGJrWnReK
         hTHQPlV+aKVYekgSfQrJjWwrnlRW1pQZ7NAQfWvJfvf71JvF2QhSYnxGhVMy2asUNm2X
         vJ7g==
X-Forwarded-Encrypted: i=1; AJvYcCUcHK5V3rfXku0848hNg9Ntbyr9/rcZJHu935JDxzg4NfY7iElrlHchatV/MYxOcIlhkqd06eKlGqop3Udc@vger.kernel.org
X-Gm-Message-State: AOJu0YzGmRjxLle7yxdh91WXN9WIJcOv53SEj7+FeKQxupZwnBUXo7j8
	sGjctBoXuvaQOsdqJ3r1gDFBWoamGP3XgnLORBPHLFttF5ZbYBbnzAgeKaAkQ9s=
X-Google-Smtp-Source: AGHT+IFF5GkyZ/SIiWUhNMG76ItfLSNQ1wsWrDDpfsA7r7xDzkAJuk4mXSah2g/qB/JAMfOt/g1vYQ==
X-Received: by 2002:a17:906:dace:b0:a9a:684e:9a64 with SMTP id a640c23a62f3a-a9abf96bd4dmr274083666b.61.1729695311081;
        Wed, 23 Oct 2024 07:55:11 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9157170esm494220166b.144.2024.10.23.07.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:55:10 -0700 (PDT)
Message-ID: <ba3199bd-e891-46af-832a-9194b64a3d39@suse.com>
Date: Wed, 23 Oct 2024 16:55:09 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/19] gendwarfksyms: Add support for symbol type
 pointers
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
 <20241008183823.36676-37-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241008183823.36676-37-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 20:38, Sami Tolvanen wrote:
> The compiler may choose not to emit type information in DWARF for
> external symbols. Clang, for example, does this for symbols not
> defined in the current TU.
> 
> To provide a way to work around this issue, add support for
> __gendwarfksyms_ptr_<symbol> pointers that force the compiler to emit
> the necessary type information in DWARF also for the missing symbols.
> 
> Example usage:
> 
>   #define GENDWARFKSYMS_PTR(sym) \
>       static typeof(sym) *__gendwarfksyms_ptr_##sym __used  \
>           __section(".discard.gendwarfksyms") = &sym;
> 
>   extern int external_symbol(void);
>   GENDWARFKSYMS_PTR(external_symbol);
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Acked-by: Neal Gompa <neal@gompa.dev>

Looks ok to me, feel free to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr
