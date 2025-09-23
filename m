Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7BB3112AB
	for <linux-modules@vger.kernel.org>; Tue, 23 Sep 2025 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612075; cv=none; b=bQrjI2X4utOZOinOGeTk1uUMESDaNy/WQJJKhtp1SaZO0CIMt9xrg6HANxCjbUSsWr5yAverkF7oVPw/NUcQn07S2kfrBccr2gK2BT96FCYkNNT4tNgdCCOUXoHSNWuMc1i4YQh+Y6Nen/ClWrhtovxdi8hbgl9ITwP/abo4Lt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612075; c=relaxed/simple;
	bh=I0Zqp3aLmoFnbeKGX9RUVxOmba0uAJjiVPrKJLO0FsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIp5MHY1cNoTp8TkRjjBvcRLe6Af4NdQW9w6IRChpgWDHGXOSpbDMNlyJBY8oqXPyxRqZmSbhEd0DVyaecvyzatyHhFKvXfYQfz6Nu38zyPAsws3y48UNzaFujC4ZwXyh1QC/Nb05tasjzmPywis4rzULOurFa2/ZEnJ6su2V30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eYsCUfki; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eYsCUfki"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46de78b595dso8942415e9.1
        for <linux-modules@vger.kernel.org>; Tue, 23 Sep 2025 00:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758612072; x=1759216872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0vHNZoddHXA/3i7ivpnsJevwTi0Ys5SuR8VWS3aVs4=;
        b=eYsCUfkiF9Wa4oaKv4bh2MBISE6Hdvcc42rcTGNgsKyOtRGyYV9eRNKb0X5NjHZHT+
         z5Xto8YMVfbuA5MOpr2h8xxPZPLc+BTOi2ZDbRuwUi7ZDjy+gKjtRTTcdE9O/4U5XHtu
         FL/ayo9wAuvNikmMb0kx5QPK/A322CMaW9fNH+MWT7hoYsUykxWmnFbbp2FS7NNEqV8i
         NcEWDRMmWMXRSBGZUxiCY3P8I3v2T+wkzCedWf/AZR0FrpFh8AmZOejsoVP//6JZlWzr
         /ksBTyQrAkVd890TKlMFl4wKTRdAayEQ3dnNKu0Xyk1MREe+ob/CMBlmkkbWmSH9NBZ1
         kVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758612072; x=1759216872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0vHNZoddHXA/3i7ivpnsJevwTi0Ys5SuR8VWS3aVs4=;
        b=LFlJn013yWDmNX+dPxI+6NBG9RnuFhxEn4HyXM/tqGDlIbd6eo4+5eKMuRtEft1vsm
         24ubDanlkMvMO97OantBTEBjnpzbNBdEMhNrPyjACI/CcGej/cbnAQW2wvZ2xXlAlY2q
         fF0BMt2/bpPtxXWO8KOO+atnXpKhRxwRBrw82DYLqtMu2Joj27Ugi1k+fxeVS2y0gKEM
         iUCFFykabQFKuX9qAoTvVHtleF/QQ9i0MeH3FGkNMBiP3cAWrUoLrpTFdBzOZJM+/EXo
         nHikbS5xAxHDhiKL3REMP6msU3MleulRe/AfX/zd2S50iReE+H7XBlie8K5dqS2HDBJF
         B7fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmt9n5WCAkGBkP9sQE81+t1sBP4ZYPypOxXVIJrB8uuc+GKsSEWff++byZCjKWIzo4QFvn+YoxlhGvfOQ7@vger.kernel.org
X-Gm-Message-State: AOJu0YxFTcDnbxJSk/wC48kmeoCfK4+4GvoyxHdyFnQSG0P3rJXBIiAe
	MF3Xhg5OkJ7F41MLoGPga+ekLXTvnX+qoZq/eefMyI89RuujTcYuYOZzqIjmXF0YoBY=
X-Gm-Gg: ASbGncurATO/bOQSbwBOR5ep3lefTcRC3HOj4uyFSF0v4CQtPRPDHtwsNY6MtUG+ZJf
	XfxD9M4F0KPehOtH9/+852TP+stzgZoYYmJjI7njghhQWBFcUV8RnmbqIGFrtXoE7eZwjpK6lsu
	9+5UA5lLRIkp42PgYw9Dv2b5AVX97hvFAxIl8Pane5VGDrSgMwZsxLtb+Le3OCRS3e5dAdqhWmn
	JWQxI4KEiE/vLyS5dj6WKMG4pofE5YzdcvJV6ORTWfNEl8XqWp1/KgmIaEbIZEAMfF3XTnWPlSX
	tr78TxFlwYmfRVLIzWekT7B/DgKre9WSWy8/wAw5EG6LCje1PtJB9Vn8O26nbUURuQ8qJY/PxZv
	p4+AU9/4I9S7+b1ygMUWOs1L4CoRORplR/YqV+ogVevQ=
X-Google-Smtp-Source: AGHT+IGPgcr7IZ/cHgNios+dXUo/2nI5H1IxnpZDpH+seBhbwldJOO4fgAuZy0CsstZyEwUeIBIkUA==
X-Received: by 2002:a05:600c:1906:b0:45c:b56c:4183 with SMTP id 5b1f17b1804b1-46e1dab6235mr16271435e9.18.1758612071858;
        Tue, 23 Sep 2025 00:21:11 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e1ceaa012sm10119455e9.1.2025.09.23.00.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 00:21:11 -0700 (PDT)
Message-ID: <000808f3-10cf-46ad-94f9-95a142c08b59@suse.com>
Date: Tue, 23 Sep 2025 09:21:10 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] module: enable force unloading of modules that have
 crashed during init
To: julian-lagattuta <julian.lagattuta@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250918201109.24620-2-julian.lagattuta@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250918201109.24620-2-julian.lagattuta@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 10:11 PM, julian-lagattuta wrote:
> Running a module that encounters a fatal error during the initcall leaves
> the module in a state where it cannot be forcefully unloaded since it is 
> "being used" despite there being no reason it couldn't be unloaded. 
> This means that unloading the crashed module requires rebooting.
> 
> This patch allows modules that have crashed during initialization to be
> forcefully unloaded with CONFIG_MODULE_FORCE_UNLOAD enabled.

Could you please explain the motivation for doing this in more detail?

I think we shouldn't attempt to do anything clever with modules that
crashed during initialization. Such a module can already leave the
system in an unstable state and trying to recover can cause even more
problems. For instance, I don't see how it is safe to call the module's
exit function.

-- 
Thanks,
Petr
