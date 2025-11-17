Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B077834B187
	for <linux-modules@vger.kernel.org>; Mon, 17 Nov 2025 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763412018; cv=none; b=JMe1AGJZbYbI6D+NttNTtmktcNECriBwiUAnwLIg9PSh6yB6ao4ZOuGRyXymnVJtKfqTV2jdHQm5yki5y5XcCsC9KdRbkkFREQ/4jB8DCZITNOikvYoU2y0//nlXB7Jv2uDWEPeCskxq477cYjU2UQTW1A1mblarasSLp6dt1qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763412018; c=relaxed/simple;
	bh=1H0cLi2JOo6HkpMxCBZrFspi0FwuOmWdAXdzNOV92yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmxHrYC2QJUKuOL9BFk/4qVF+OnWKYdfhoYIrky5yJjquTQtnpGdeMQ4EUnxsea58O3LDSqNzREK5I5AHtD4yY4+QmrBy9GGlGlpUl5hJ3BvlVxM1SfGFW+EfzS5g3wS90uQDG4EfKREyDQJ1aWx1PU46Od9ckl7oZe//j0TMZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQMv2rcH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQMv2rcH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-295c64cb951so53885ad.0
        for <linux-modules@vger.kernel.org>; Mon, 17 Nov 2025 12:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763412013; x=1764016813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1H0cLi2JOo6HkpMxCBZrFspi0FwuOmWdAXdzNOV92yA=;
        b=eQMv2rcH4r0WpDavc+kHqE2gJ8sDfN/n1piP94Ir8Z5tgssywVVP0igfpOrWoqawWg
         6hWn+5Ueu/rmSstKI63ytb6E3vVdSVnUIpyjhFG25QT+Ed9gN1pA1gMmTHUMaBcNvETh
         5RYd6lGbdqWFpjAzl7yuzj+ou/G7mLxMbqNTRfIc6iLwwiOcH0KO/sjLZq3M/LJJA1nk
         UQSWh9Of93Hv09j+XToABgbOSj4uMkZa+/dxYlX0cS4clHhhGouI7mvkQTvyVBiue0zu
         YtBXZUholdFVCCRyMZJrT1UOfzxVIuYTROiWtXsKsEdqPjLK/c4L7PY6jTcf8MWTaJXF
         YXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763412013; x=1764016813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1H0cLi2JOo6HkpMxCBZrFspi0FwuOmWdAXdzNOV92yA=;
        b=HieR31mUK2GSLBRjrwd30QLoe1OxpieswLSUNRd+fd/v36aHoR3XPdalIfgjLkhoow
         +natJu5U7cYZfdOO26w7AIs6H/c342Te/sAI8knX90R8IsuQY081X8WoD8S+WG5QHfhE
         7HH8i75N8RPyicNRogrP78X33NcDgTyfHRqQG0GCwZGzD90hSHaTUnPPcg27yEjc1c4y
         lrUwpS0Dvp2lu8fIsGCjZ3KYLt6UpM50KUcrhzOERdCqqs8+4BzYJzOGOGKF9SiBdHwA
         omXb/aX6szw5d7E2AtDKyNq4ztAeVZug+o4I2pq1GcZ/J1q5JA+uuSpt4vMandvt8be1
         vHfg==
X-Gm-Message-State: AOJu0Yx/ZCDVNYf/WpubKFlJUfqqnANLPLTvPhJ0h9A9VLR66MZgHc+Q
	ZPtVYPLHue9IqtWK0BqNvVFdZLw5GXKzhOmPv1NDgkwCeQpFaVMmgyZlfSvdRxiR6y4LqwKi91O
	eqZOr+AvqZ6OUHU4J8QZWryCnKi3pG353D/J55QqE
X-Gm-Gg: ASbGncu17BAUrRK9iQQvPpBIGTru7QwbpT7k1l5nzt1zxeey1jamcOtc3syLPPns+Rg
	tZDB8j42L2oykZ8kl3JmKUq8aRoldttWTRK7zbpf0oQhstGVg2gakw3pmVbrvkf3F+NfdwmiN1A
	0+tsha7Mt0Ahcq5ZFAYFxL7LJEchcVwYthqejTp3vGzi/lWOIbP9GA254eg6mdwY3/xUbOWsHrq
	genBgePQ0LYMmmyaWA2RZ+Hi7pHUshofXoaS81AQxGJ1F0+MJA/Q4kAClAag6iEHNcT
X-Google-Smtp-Source: AGHT+IGRvbW4d/tIwNtyHY0u+4ZKoC2/gi1CFz+eeP0CV681ftV7r/gK4h5K+JNL4Shy2rRd6rguma3V9C0i2eAjQHA=
X-Received: by 2002:a05:7022:6182:b0:119:e56b:c1d5 with SMTP id
 a92af1059eb24-11c765a9e8emr21688c88.0.1763412013146; Mon, 17 Nov 2025
 12:40:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aRcxzPxtJblVSh1y@kitsune.suse.cz>
In-Reply-To: <aRcxzPxtJblVSh1y@kitsune.suse.cz>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 17 Nov 2025 12:39:36 -0800
X-Gm-Features: AWmQ_blW76vh0PVkmggdMwvKwkljCLQHPM3W9uXuIORf5C0lZqXX4jqFUb23g2I
Message-ID: <CABCJKufeEaZ1hsyHsr5=RxR=AcpMu6nnYypwvcmS-ZxjZNV77A@mail.gmail.com>
Subject: Re: gendwarksyms not 32bit-clean
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Fri, Nov 14, 2025 at 5:42=E2=80=AFAM Michal Such=C3=A1nek <msuchanek@sus=
e.de> wrote:
> I tried to build kernel with gendwarfksyms and it does not work on
> 32bit:
[...]
>
> Can you fix it, or make it depend on host being 64bit?

Thanks for the report. Can you test if this fixes the issue for you?

https://lore.kernel.org/linux-modules/20251117203806.970840-2-samitolvanen@=
google.com/

Sami
