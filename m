Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE2D86349
	for <linux-modules@vger.kernel.org>; Mon, 28 Apr 2025 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848031; cv=none; b=dh2M5f9/5h11ZbBen3LIVDPaJ39ONAgkAdbvGzjByiBFSOaecxRXH/isjNmmrP1dFgiUlWIXB3QY6uZw8VmFxqsgmfmFpQMmqIgeThOlqbO0kaSn9IpTe6bXQaSlMkVbdSCcXuuCOhZfYs5Gbm/amwMcpIlDhKt2i344w7KqH5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848031; c=relaxed/simple;
	bh=8Ze9MKPRr2ibTiFbLm3WcNCVvEbM/ekMvV4s7tGQnxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMHOs4mJzFZkOY49nbZkOtajXRmP9W+s9t3+LpruNapOy63sPHOPBYlhBCx3HhqSL6D7eZYpOV08te9B2DEvZfJrNjCsypkLQBf7QbLVB8hhqpbZkWEfOtHJLf2h3O0EdQr0DjEZQR232OhiEbSBjZWfFZpDIJWrNZOqSIP7XT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fbfAri0D; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fbfAri0D"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so7533822a12.3
        for <linux-modules@vger.kernel.org>; Mon, 28 Apr 2025 06:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745848027; x=1746452827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JsbHP9q7QPdde2LygIdicngaffCZ7TvF689TrjkFFsw=;
        b=fbfAri0DEJAiPZ1Y4eVLbzkIU7dOwOwHXz3h42i6v+8xhJhUwW3/sAE5vaiBM34cdl
         65InoTPgb0jTjSifXnd4jdCD/EHMlLaMFCtRGev8ZDvMYtGjJ0sOXp40ZM7UZC6zDEry
         EbW1oNg9M0iq0mhPOOREnQH4vEhmWJDJfV3zdTuUkmGVFf2Sd6DVHAZsKRnbz0Bt21uc
         lZuz6R5SlDdR1pcamkzv4u4aKr76szotKqnT+uSySlRPPZmyCQkoKrVrMUOgnE2NLNl7
         GqnfYhMZdl6XYmNhJM+SOnf51cpGuhVZ9pxYqQ7jyUg8u3qDbJf5sL/n2yKdbChrKPlw
         mCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745848027; x=1746452827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsbHP9q7QPdde2LygIdicngaffCZ7TvF689TrjkFFsw=;
        b=A6HGgMA7aVNqYR5yT/ilCilfA5w2TuvpUncllktjeemyp7XWRbxOkeJbZgUC90yaO6
         YxLIdVXqewCV37HD8GVwP4zD/zGAXDZtLoFn0NC/0gskncFpuZyNbAt2RymoGyT6eruI
         Cgf6XUEQ+Dedqpf/FBhJrF5L1va98vsGaxfeYt9KsUtIhzaBkDNAcnv0VFOBP24FkYKR
         BexA2GENS609+sjlufUdRXJzCRh8KHT7yOasNVOF+8ck5mLYErDuYUt9oP799X6rZwNa
         BxNLeI3mmW/Bd8AhYt/1Bl6Lmail8gSsAh7THsq65uA47xpMk/vcu6EKE7aAkfhPk628
         aPPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/8ZxnAozNBbpkXk2rHLad6XJoFdqxUKO3HtqPFC27V+RGLBzqLAn0dxMsJcliaPg+zdA6tY7iXTL8Ob1F@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu2sGzaTLcCllXokgOln8QkXZVJuIHGVCXNKR2SL7j2Mu9twR6
	kbdP2MKp+ZJ1a3uKswKlhktlJE2BEcFT7ZAd0/JJZnyPgtuxlz/WBFGqkqpuMmA=
X-Gm-Gg: ASbGncuX95Of0vvqc49rFzW4yS5ZGZsrhA/rssiP0WZ/fVZrhxhuZD4Zq88otujC/Vs
	YVvNffnxje9ulbrD/7Kg1QyUa7B9YSnX0jVJPhMWubM0+Y7rOCQAQOONipXX2CyI8giwiOmve66
	0wCGpvazmH7x/BaUxXSDyGXcagLFVEbEmXHs/e4tBuSw4qwS6psmAyx6LozsBSp536NDcEH7imz
	XHb4+kAZJdkeKrbX4aKpPDv1vAY0UKtRHsJZ6/79CNJ0EOduEkWdnKaDCGGjQ0KQYDBKJoiVv6j
	vNIPZXw7DMDuSsc5QiQQwei+NUCN0tDs5vVNFZoIXLRCZL5IUvD3lg==
X-Google-Smtp-Source: AGHT+IGqzwh1ITeNsAX9KP5aHUN5/8acCZdGikSmJ/7V9wS42pujwbYDhXZIt1HuZsg7+acKpE7tzg==
X-Received: by 2002:a17:907:1b22:b0:aca:a687:a409 with SMTP id a640c23a62f3a-ace71098d4bmr1176725166b.17.1745848027469;
        Mon, 28 Apr 2025 06:47:07 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41bc36sm622902966b.33.2025.04.28.06.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 06:47:07 -0700 (PDT)
Message-ID: <65c912cc-3a27-4b0b-913e-784ff6d07221@suse.com>
Date: Mon, 28 Apr 2025 15:47:06 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] Add generated modalias to modules.builtin.modinfo
To: Alexey Gladkov <legion@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <cover.1745591072.git.legion@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <cover.1745591072.git.legion@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/25 18:16, Alexey Gladkov wrote:
> The modules.builtin.modinfo file is used by userspace (kmod to be specific) to
> get information about builtin modules. Among other information about the module,
> information about module aliases is stored. This is very important to determine
> that a particular modalias will be handled by a module that is inside the
> kernel.
> 
> There are several mechanisms for creating modalias for modules:
> 
> The first is to explicitly specify the MODULE_ALIAS of the macro. In this case,
> the aliases go into the '.modinfo' section of the module if it is compiled
> separately or into vmlinux.o if it is builtin into the kernel.
> 
> The second is the use of MODULE_DEVICE_TABLE followed by the use of the
> modpost utility. In this case, vmlinux.o no longer has this information and
> does not get it into modules.builtin.modinfo.
> 
> For example:
> 
> $ modinfo pci:v00008086d0000A36Dsv00001043sd00008694bc0Csc03i30
> modinfo: ERROR: Module pci:v00008086d0000A36Dsv00001043sd00008694bc0Csc03i30 not found.
> 
> $ modinfo xhci_pci
> name:           xhci_pci
> filename:       (builtin)
> license:        GPL
> file:           drivers/usb/host/xhci-pci
> description:    xHCI PCI Host Controller Driver
> 
> The builtin module is missing alias "pci:v*d*sv*sd*bc0Csc03i30*" which will be
> generated by modpost if the module is built separately.

Could you explain what is currently broken because the device-table
alias information isn't available? I think adding this information is
reasonable, both for consistency and so kmod can display accurate
information, but is there more that I'm missing?

-- 
Thanks,
Petr
