Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C82D7BF
	for <linux-modules@vger.kernel.org>; Mon, 12 May 2025 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061556; cv=none; b=uJUh866dNWhGmGpcX1OKr9Sb8JszGJQVjMsfwhzULdfmckSR6rCGDsuYkk0CiprpZ7vRy0Q5o05TRV19sH2pKLF/gDSYnXwl6aEaKlBo7YnVDeDOsMgY2lWfKxhs68CdaWxZlgzSEMTnLid+jt8l7UnkiHzQKJVA0cNzb/1dr/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061556; c=relaxed/simple;
	bh=YxitOD7J5I/UtmC0dH1Zgo6JjFI+JvFFNRDPbpGHmgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBuAcAWXVHUkWC4u8dfDgcWimKVrBIufgWnzgDBPHkRsUD+6NUIZttt62dmNisus0+wvHBMxkT7erursl7UezXT5dKdzmWIa9zYDpYfGfdYmsOhTO/yLlbhbcLLzaS+ZwqF9Z9fvA3yYaLRdkyNSjLYz2+g9m0+XUIcCuEVcutc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C+kdhAh6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C+kdhAh6"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5fbee322ddaso8488480a12.0
        for <linux-modules@vger.kernel.org>; Mon, 12 May 2025 07:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747061551; x=1747666351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sL36AD5JIr2gOBFJxdoW/HqoISwrQ7JPwgG6VNc1uf0=;
        b=C+kdhAh69DteB2BlK49StjkovVk5QGefpdiIDMppJH8Roh88hmkOLxPnR2DFzMTA49
         px7Zge4kUxF1RoVICBL5j8NHQJAs6CpfCFF3r+fCpcrjp0YdQcZwNbgzLA07AACn8b6G
         FT2bJSDP9JhssTniyiEShJ0+sBG+2wsGV8OwUsnnR8pM3k1GbXXjLs323ZTRvdZJTVpi
         LYMkPqQ+4n/851xe2A47BY/MEZ+wcGNctxvI9pDXiJuYYxKK7yC0Pm5y/esfaeoAshbt
         7VKFudT42eWaQhoI0x32XIDpW41zCvmYDEJfya8i5mu4WD/bqry2FSZQD07rtiAsSMVR
         qyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747061551; x=1747666351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sL36AD5JIr2gOBFJxdoW/HqoISwrQ7JPwgG6VNc1uf0=;
        b=NntepgcSo92ggx9Lxj1tQ4QnGXx9ywUMxh8Q46LuRcNjdTqfmQUlOh1CbZma6OVKmL
         KqgPlFPAcY4jwvSD/I0Fi15dzgzRm8woIL9oNtsjPcLYpBslzer0Wn6Ysx2dSMqB5y9+
         GQ239OlyFKV/7cqiDUqYKd1UxDaYQPPiA+vRjlSy/HeZ1lAHI+D5nHm8VXPR96wFeip2
         C7lusnurMektc2bphvV19rbOWponUM5tCX6Spn2NqVXEOmFpPz/aU2KfUUvaKc4Rli7w
         KE36WqXxFqxP5wcSpx03dFfT/3lOBWCoqjDY5iHPrCnZXMFF5fgFW4Ou6xm4Za3qCT7q
         0HHw==
X-Forwarded-Encrypted: i=1; AJvYcCU+hp7XCiOydZjGB218p0vywLaeHyojKmXoNwdQXV7WvbAyCwzf56+HUfNIl0XCkU5wjTvAMuA528BqZmpQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5YXZJNEd4tgG/GH0Fkk8fCYF+6HR62wq91JzXOSNpvmzPIbtg
	J7pz+e688zMOP5RGLrfKLh4rYc9sUu9lry3/kIRRTGbF5fCvSmNp6nOG2mqi/7qLuBDiPCrJHRs
	C
X-Gm-Gg: ASbGncuYXJvEhdE/bFbcaOepuoY0/CWJGMhKmhDoRK3G/YwXD8I+rbtwCG1/4CSLK6m
	+tnds4hoC5WbtQ6GKhkyDjIG0BHzhOU1PLZD3D4FFcxgJRdyMuJuMSdHjDA8u6QY5nU0BJVaPUI
	LEZTVq5ayKtuCTWE6glw4WDIKtnvTBh6OQFoSWLLDzmnAiufCL7C8zOr5fExKJfZPuo+rnszepQ
	DfS6Py3E+I5biSiMRoLqhCf36Y8iRVxva5PFUUNWdSspePDn0jefWGz5+5Om9FcPDpvZPbe4oIE
	KFlfXv6ZDijg9ARvbE8fuBKwfbeLwc0IWnEviTiDD0R8FIGf805rsA==
X-Google-Smtp-Source: AGHT+IE/pkPyU+0I7L6tAz+2K5JYCY+Yzm4eb6rt65pfdv4WcrCBgFVGHp5u/6We4LlRpbOxpUQzww==
X-Received: by 2002:a05:6402:510d:b0:5ee:497:89fc with SMTP id 4fb4d7f45d1cf-5fca081ad13mr11822462a12.33.1747061550973;
        Mon, 12 May 2025 07:52:30 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fd0142152bsm3717001a12.19.2025.05.12.07.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 07:52:30 -0700 (PDT)
Message-ID: <66feb171-f528-44e8-990a-ad0c85fa52fd@suse.com>
Date: Mon, 12 May 2025 16:52:29 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] modpost: Create modalias for builtin modules
To: Alexey Gladkov <legion@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <cover.1745591072.git.legion@kernel.org>
 <20250509164237.2886508-5-legion@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250509164237.2886508-5-legion@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 18:42, Alexey Gladkov wrote:
> For some modules, modalias is generated using the modpost utility and
> the section is added to the module file.
> 
> When a module is added inside vmlinux, modpost does not generate
> modalias for such modules and the information is lost.
> 
> As a result kmod (which uses modules.builtin.modinfo in userspace)
> cannot determine that modalias is handled by a builtin kernel module.
> 
> $ cat /sys/devices/pci0000:00/0000:00:14.0/modalias
> pci:v00008086d0000A36Dsv00001043sd00008694bc0Csc03i30
> 
> $ modinfo xhci_pci
> name:           xhci_pci
> filename:       (builtin)
> license:        GPL
> file:           drivers/usb/host/xhci-pci
> description:    xHCI PCI Host Controller Driver
> 
> Missing modalias "pci:v*d*sv*sd*bc0Csc03i30*" which will be generated by
> modpost if the module is built separately.
> 
> To fix this it is necessary to generate the same modalias for vmlinux as
> for the individual modules. Fortunately '.vmlinux.export.o' is already
> generated from which '.modinfo' can be extracted in the same way as for
> vmlinux.o.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr
