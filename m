Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184C538A
	for <linux-modules@vger.kernel.org>; Thu, 17 Oct 2024 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729125895; cv=none; b=OspFdsMZd9VW9r6F3F/SqMraaIQxQ9ctOw0bEbEOiAwjF1zW3IS08nhwX4c5QZ63zta34RNILA3P3vc/5QYbLc8SzslRAFqVA2qknm2EvqOZWY2iV+AaP3liqaYrJv/6k+7H/6n5sudPjaD5wyuV4g1DkuYdTxHYky/YIZ66VHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729125895; c=relaxed/simple;
	bh=q38Gk75NQ3Y05W/bT7Aw1wLV2+4Q3MEANDoCrYZhOww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksTT0DGOofHGJGUEYm7cBbPx6jSuZEn98geF4hYPmpM9+BJHkO8btaFR6wJyoMrS9tTFTxioseKIEYHBIa/2IaAy0qQPBzi6m2Sx5SioWF1VGQSeCsb0ygTM9QW18VuGRMTgJ+ABGdXMnlb41sTI627ggC+W1eN1PDfoXP7+610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VDbs4/gw; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VDbs4/gw"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460969c49f2so126421cf.0
        for <linux-modules@vger.kernel.org>; Wed, 16 Oct 2024 17:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729125892; x=1729730692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDVTSiiju+/i8uVx/5igK7HXQnS/pAXMN54tJaymcIs=;
        b=VDbs4/gw+LgN0yybuhmMRR7SNsLjmqZoaRJ+NZNgSyghJhvqIXEtkBZsIPvjW1ugF5
         0E9Nm/Ikme5acGHyo2UgjFWmDHzbb6mUKfITV3prU33ddEsMxOJkZSC29zdCQLfKxn3d
         xqTUo74V82cqjO3hhXDhHAJKATJ+tjwDC060H8bYcaKgFQX79aUmOCcnyEXcG1guuD9a
         GFH+GubmNhdRfoRTBaI1+MpkvItC0RWd5LFChZxNm7vjv5lMl6GACUXiKSx7WE5w0Vds
         /pnrf5o90psBjQpw5DgCcQHtYY740eir5JW9c0IeYkqZpsADDzBSFy7SmQd9tZckAuAa
         nfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729125892; x=1729730692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDVTSiiju+/i8uVx/5igK7HXQnS/pAXMN54tJaymcIs=;
        b=fIgRdp3R734bLp6IkoAFyCN9tZv8Q84UlAl9pe6t9qfNheuNqQ5iylH4Fm0a1cFgEh
         e+bfpdoBLGrrr7xNSGQOz0t3YMMTJ1BrfhV1Al6M5R9AsouQGuWN7vBT1wk0T4S3x/pu
         /2SB0ScIhk8Bb9e1uQnUdXZGfgTn3XoCbZaN5TH2MHJIXYISVaSnKkaYwEZjSrAnmRuV
         HgG2MR3WLtjcBPZoic91wgGoZuR/XVmxqfaqx4XSGcSDaFO9V8oQWtXxXJ0HE87gMjRz
         KQaHww3EmPXBP1AyyF89pTW41BS9e5kjoCbT8o0zryg8/7sc0IFvfNQGvBd0IC2HcAfP
         daBw==
X-Forwarded-Encrypted: i=1; AJvYcCXdRrJvDMniLH0gNENGWEWVo2xXWUh5qIE2+YpaSAtQy4KvGoahq/TV9zqFIljYnAKBk0x6ENnAjVC452Nb@vger.kernel.org
X-Gm-Message-State: AOJu0YxzVgG17+Zqeh4L7dzT87BuDPnv4C+4VS5tGd1ceo8s3c+KaVTb
	t7MJU83HjuVIWppVTDnmkwfOZix5SjoEQ3BgPlTD/sMaNrKCK6Hivql54zw44L0egGswBNszOJQ
	MUZBrQwvrOb6S2LTiwPlTtdxkQFchEDN0t3lipoegjrCZ0kNnEWXi
X-Google-Smtp-Source: AGHT+IHGsHS9kd3lV9IPjVl/ZP3eT/Hgf527JCJgpbosa0wkAa/UhNg9JyYeaHygJfVEjoItGGw850c9B3soz7Ac6tQ=
X-Received: by 2002:a05:622a:1303:b0:45f:7d4:5007 with SMTP id
 d75a77b69052e-4609c8e1a90mr1672431cf.18.1729125891569; Wed, 16 Oct 2024
 17:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015231651.3851138-1-mmaurer@google.com>
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 16 Oct 2024 17:44:14 -0700
Message-ID: <CABCJKucRKzMXF-mCxztAgOJxofEGAd33DMC_MHgPBsTmsdJcww@mail.gmail.com>
Subject: Re: [PATCH 00/12] Module Validation Refactor
To: Matthew Maurer <mmaurer@google.com>
Cc: mcgrof@kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 15, 2024 at 4:16=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> Split out from Extended MODVERSIONS Support [1]
>
> This series refactors module validation during loading to ensure that
> everything is checked on its way in. This is intended to make the code
> robust enough that we can more confidently add new pieces like extended
> MODVERSIONS.
>
> [1] https://lore.kernel.org/all/20240925233854.90072-1-mmaurer@google.com=
/
>
> Matthew Maurer (12):
>   module: Take const arg in validate_section_offset
>   module: Factor out elf_validity_ehdr
>   module: Factor out elf_validity_cache_sechdrs
>   module: Factor out elf_validity_cache_secstrings
>   module: Factor out elf_validity_cache_index_info
>   module: Factor out elf_validity_cache_index_mod
>   module: Factor out elf_validity_cache_index_sym
>   module: Factor out elf_validity_cache_index_str
>   module: Group section index calculations together
>   module: Factor out elf_validity_cache_strtab
>   module: Additional validation in elf_validity_cache_strtab
>   module: Reformat struct for code style
>
>  kernel/module/internal.h |   7 +-
>  kernel/module/main.c     | 569 +++++++++++++++++++++++++++++----------
>  2 files changed, 428 insertions(+), 148 deletions(-)

Looks like these patches are unchanged from the pre-split version[1].
For the series:

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

[1] https://lore.kernel.org/linux-modules/20240925233854.90072-1-mmaurer@go=
ogle.com/

Sami
