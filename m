Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9041E4120
	for <linux-modules@vger.kernel.org>; Tue,  3 Dec 2024 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226916; cv=none; b=t64bL6NNDOre7+IEwWy3vb02l2yvgjTpG+AY0LVT8L60rfGOBzUqI6EsVqzdUnn/dOict0ZQj3KbSnJJk+C0u0Hvi4q8Hq/vi4+Wr7bv69DLgBNXP6u4GzOF8d4X1PSEk/bY9MLzw0K/TIet8I5TG8jxEw7SRnSNAngynHAMA1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226916; c=relaxed/simple;
	bh=v8zoQZ6dwqd3xojwqV6vSH8uy1LrM8PkPp2K6MbPIqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4dJ7Sa6xI1cluf7B/vSjWnzyEU/e69S9t1IqS6/VnPh/jYwrR3svE8t9S/KIa0sOx4AmCnKU4ammFDQBU7o1Y5wEo9GIo1KJ3sWRBgHOxpFHFwlt2nNeDAMKX7UHw4P1BMEfuJ2vT6xetfV0fc/sjYhfb9V7xooiVE3fB6Snvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IfxbmrlE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IfxbmrlE"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434aabd688fso34892445e9.3
        for <linux-modules@vger.kernel.org>; Tue, 03 Dec 2024 03:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733226912; x=1733831712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=on3sYEGd2/W0CVrqLqHMmcTuEZdP/rp7cfagL/Up9EA=;
        b=IfxbmrlEq/cqZnRsNzpIw3k4ZKN1AYKDms//u9Np+68kMEFfO82QqNFmCtJhIBQ9rg
         eOHHV7XJ6DaTmnVFaT/3ayaEtFDKCz1TDAVRnkICnOutUExmg90hUn7IPEK8aBlPGcjw
         nJt6YPntx1ghfjwpcXOQcLgmk08cXTcBizL712fE4CtXnwMRx2puZw7nbMgrmcTBabin
         JEmrloHTNsNTWZMG5AMOvkVPnY/+jS5rmdx6QenoxxTtZB5Yqvg7fGZ4NPQAdIF5rhyL
         BL38DQBZBZ0sRK96U09l10l5+98Doa1QouMpNKJNv6RnzwFTb1eGQaubvXyfX89LWoON
         DS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733226912; x=1733831712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=on3sYEGd2/W0CVrqLqHMmcTuEZdP/rp7cfagL/Up9EA=;
        b=Pq/gmSEjlzTknw+z0M740U+7YYYiNOQ7VPNGJ45FnJkvg41NYVVX1m/DG8uLMP8rQJ
         NcnA5oqqgMPvGAIxWSEBr/9tS9QbCs1R7Aj3lTSLRY1uUESgwL1oNJcAT0A3HdUfYdxM
         02AW8NQyu1PFTUeGf1SX50Q0hmwCZMtp+pzdc3AMYxkY94F8NisaYnogmvmzpHFDQxyc
         T10UmCRK1yOi+9/G8/hCfNARs/CLZ1l08NagxNacBrV1S/3TQ3PMxU10lORfSx/yafna
         6+6zDQI9ZmaXPtUUcmlg4ScDts/POowcyTJwOWuDokPz98xZfgBoGLJiBeoUd2Pwv/F4
         V09w==
X-Forwarded-Encrypted: i=1; AJvYcCU2z3S+jcpvYFneOA8Wc0XCJ54xy/gObUGscxTIRDWpBfB3KzI1Ltc0H4fqX2h3RDIakLXuUO6ks7/7SYY/@vger.kernel.org
X-Gm-Message-State: AOJu0YynfHpVg6MA4PqsOdSwrITtKZdPzVS2lgivVcTcj0rmBYJ5hTpO
	8DfmQ3NI4yMaYXMEYCloL+Kzma8BG5Q0ire0GvWd+07tNdo2mV1MvtC48zJEio8=
X-Gm-Gg: ASbGncsVhwFSVJdJ1t2nv2aPonsnTBWHAxqd/qPUJjP/zURev8Xke7i0vmBx8y4wNiQ
	GXOW9NsfDlwU3z6z5qWOUUkNBMSpBc3c4VJ9JPKfQxLMuYLwyyM3+TyJRzaAUiMdhTz/4w2M39D
	7OaOIDGqUELjYe5hwP48uutPi52B6bTsm2VPl91kxJ5YJJcYckpsZGS+FPVCZLvMZW15bkqKi1T
	vURi02ckWIAYcrG53GLyRB96VP4gvMbePw16x48S4DFsra/uFpd/Q==
X-Google-Smtp-Source: AGHT+IEOoaKE+Jx2lB/U0/CuOwfrHNpbiVubl22ruotoapXCu3d/MzBK3IqvDfPWg35JXHbV7cl2rQ==
X-Received: by 2002:a05:6000:1ac7:b0:385:f44a:a64 with SMTP id ffacd0b85a97d-385fd3d0816mr1896449f8f.24.1733226912618;
        Tue, 03 Dec 2024 03:55:12 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36557sm15172989f8f.24.2024.12.03.03.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 03:55:12 -0800 (PST)
Message-ID: <ba893003-afda-4615-bf96-79b62bee51a0@suse.com>
Date: Tue, 3 Dec 2024 12:55:11 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/18] gendwarfksyms: Add symbol versioning
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
References: <20241121204220.2378181-20-samitolvanen@google.com>
 <20241121204220.2378181-32-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241121204220.2378181-32-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 21:42, Sami Tolvanen wrote:
> Calculate symbol versions from the fully expanded type strings in
> type_map, and output the versions in a genksyms-compatible format.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
