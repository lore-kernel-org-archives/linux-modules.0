Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C01A706F
	for <linux-modules@vger.kernel.org>; Mon, 30 Dec 2024 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735567351; cv=none; b=GIMEo0/UTj1XRVYfu9Xr67V4Yks8U9jy5XyCX2xMXlk/ZTEtW/zpa2hg3uErqMbs3TvdGyoXuMdGCkP0kyU55upOnb2/ldeeSZFvdEHLht9g8zcddxMir2vtbPCAAFgBs8aGSPn5Euwfa1/cl56H61bWv6uLwow4DM10OsO6D8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735567351; c=relaxed/simple;
	bh=HquHmcZ+IK1gFRwkTRVt471/y2J4BoWJ3Pf6uqRKv28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFJy1ijo7rRfxnjoEwNRBur96aYw9DdjOuFJkhZTusQXSeOXiCzieTsCXg+GsS0l5asZMijoMcmrkXqB2qgu8AVdNc05eXm7Whv5EqF5qm01b2KrAko8pbp0UM13I+jCCG392sS8AfMb99AABqtLvXWoct1Z2A6bS261fLTzMas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S08Jzw/X; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S08Jzw/X"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436202dd730so66142875e9.2
        for <linux-modules@vger.kernel.org>; Mon, 30 Dec 2024 06:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735567348; x=1736172148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ghxaxa8kqE7ZwKhklMmmPiZe5prcODEZKOXRrOwpZlo=;
        b=S08Jzw/X0dNyJ3olsp7A2FQoayGZ9j1nwj+RRMJsdKb1ErmM01khyM5/tC2uvPg/vc
         K8xUekH94JA1jT5nEuoqINRQy97afjk35HlGFhgfX4UsHdWbaTam7Iy/klh633FKUQ16
         dbrBCAnmDIA+IOEkQg7qQR5BJQZFK1cHQEou/QsROxrX+Mp/2RQfq4r18zZlxFN9kqkt
         KcO/43tRVyMtp+DyM2zoE8tION3xOIjPoV7NI7hkSsjPhKRS8xv+aw6rbiLrUWl54j3C
         xr/Scqpb+t8Cyahj1t+YFvtY1a7kHVauSWYBZuQgA0eN2fF42stKe8xlYCT+lg0o4Fpj
         EjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735567348; x=1736172148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ghxaxa8kqE7ZwKhklMmmPiZe5prcODEZKOXRrOwpZlo=;
        b=Dpk+hSHUtBYJkhvxAS31aHU9ffeIXUj2f56ZCIO3oQWCN4kSzNpfeButfiYbT/Mp1e
         uaAaaN+bZplQAbY6Y1AM4S0xFDRKQDpnOm+d682GMokSqOqAQoGMmtWl0cG06GNHlLL+
         zNluIxbcCQbmOIyvWIu+aU1OKYdGwp/a05o2GU0Y+55VgA+t8VfATumKFYz1Z1+5Jm/e
         y1NbbWxLfRakUFiTfRbk4hM6dYVBoTgzGo9luOS42wiFzM3hMEgJ7hbEKBY5LTtuuIxt
         BXO75abLv0DvRCkTIHT6aX0xQY7BNEOKUcVVJI/4oMg/LR6Uky5AcUluhppD239EmLbU
         ic6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvp3AWuIXqnC4fNqy+T7mCbdpVjk++D10dV/kGRLKI/sKMJKIcIVGmlu/QpmG3F4ZvVJaud2jJbpftwVl+@vger.kernel.org
X-Gm-Message-State: AOJu0YwflmCVWQlvE4nqzE6q/OxeRIVvrzulH1D6v6oaR0Kx1vM0AxbO
	iuwo+hi2i5AvU+8bV771S4yPkTz4GEM1B6y+UmMNZ0uYkHcFAxzpnoBgXi9hkLc=
X-Gm-Gg: ASbGnctc+u+t/F21pI7x39CAJ+kj0aSRxtBXJSe0dsF9uLoKkClSEzco0iNXUySim4Y
	0VC4ki905sZO8WvIzwGI/pWeAU3EKZQATyDBrS9I5J6Hz2SCRPyf+XvIVLFv4Ite/XHe2SOtL5+
	+T7chZzHzR7j7pWvCEHmtcKFdeIuKXEOrcSOE1euN743gA7s8nqlwbtbiYlLZVGKLQqu4rHzhhN
	OHhdutEFXZTEZT5JZHx2l3DyYAfA7fsSLIrJj4WxOerFhEuSD8iA0ov7H2a
X-Google-Smtp-Source: AGHT+IFfKuRGvzP8k7Idtjz2pEXJrGPo/qoDpDzGYiMu75C8ujYym5YbjEq79bE7btiUuBJE8GDKcw==
X-Received: by 2002:a05:600c:198c:b0:431:3bf9:3ebb with SMTP id 5b1f17b1804b1-43668b5e045mr269685485e9.24.1735567347998;
        Mon, 30 Dec 2024 06:02:27 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e140sm30816423f8f.79.2024.12.30.06.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 06:02:27 -0800 (PST)
Message-ID: <f9b9795a-ab0c-49b6-92a1-b887f923279b@suse.com>
Date: Mon, 30 Dec 2024 15:02:25 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] module: get symbol crc back to unsigned
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-modules@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Matthew Maurer <mmaurer@google.com>
References: <20241228154603.2234284-1-masahiroy@kernel.org>
 <20241228154603.2234284-2-masahiroy@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241228154603.2234284-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/28/24 16:45, Masahiro Yamada wrote:
> Commit 71810db27c1c ("modversions: treat symbol CRCs as 32 bit
> quantities") changed the CRC fields to s32 because the __kcrctab and
> __kcrctab_gpl sections contained relative references to the actual
> CRC values stored in the .rodata section when CONFIG_MODULE_REL_CRCS=y.
> 
> Commit 7b4537199a4a ("kbuild: link symbol CRCs at final link, removing
> CONFIG_MODULE_REL_CRCS") removed this complexity. Now, the __kcrctab
> and __kcrctab_gpl sections directly contain the CRC values in all cases.
> 
> The genksyms tool outputs unsigned 32-bit CRC values, so u32 is preferred
> over s32.
> 
> No functional changes are intended.
> 
> Regardless of this change, the CRC value is assigned to the u32 variable,
> 'crcval' before the comparison, as seen in kernel/module/version.c:
> 
>     crcval = *crc;
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

I understand the plan is for this to go through the kbuild tree with the
rest of the extended modversions + Rust support.

-- 
Thanks,
Petr
