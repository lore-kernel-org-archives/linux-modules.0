Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43714A627
	for <linux-modules@vger.kernel.org>; Thu, 15 Aug 2024 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754909; cv=none; b=KiRX4EeISvgzb3mMJKvin6jrKk1xb0Ss1gX0FSHtNkoW6/lhXG4HfefcZRqgJ9MWOGqzHAj1OJ7ovY5kx0bpbgI6LjtkVfie7mHAZKxLzQ8k5owy7uuujZqeRwx+Cgq/fnqYtgZSo20EvxoyTNEur5gZ1d5LHXA0gHCUyoh1E/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754909; c=relaxed/simple;
	bh=UWFk8iT+QX+XvTdHdEEQEkz3sro4r7bOKwiITHQ68Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7yIcdLpgDeKtVArsgyGG8ngBZU1j7Q7KwYeKNHbDO5sP3CJ/5gkEnZ76xc/9wTAPmoGMTRTEl45+O4ty211YIMA+ziQAwrx8ZvPkNk9H8GdxhP6wjvBZWmIXGt/Ogmkm9Qk8BQvaBCpiknZR+AEMRy5itDRpj/kh6IKN7qyPhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OBD/ahOG; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBD/ahOG"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4ef2006dcdbso482573e0c.3
        for <linux-modules@vger.kernel.org>; Thu, 15 Aug 2024 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723754905; x=1724359705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWFk8iT+QX+XvTdHdEEQEkz3sro4r7bOKwiITHQ68Hw=;
        b=OBD/ahOGj+5fGqX/GCCCQTfdWEAnUgKQKT+Sd6w5eEB5nZlXJPqXRIam8j+7yKPx4n
         njES9omzgf5ihdA3NriJLGOvoD3AwFU3f5pRDs9b2rJbRCdLf1oRF0LsT1L8X/wAqc38
         tNMFnuS7Xrj5AaoMtcFLHg7frtJ+TsFmNFfzE8vDong1Yd5lWegJpnZcZqNN0qnqRDMg
         da7etcpFhJcOSQtOWfyHstSvvoitNTd8/q5LsWs/XeDhf2o9YXM4VkhwfeJKopLpy8GK
         tZPatHH4sIs82lEiY1UAotnrMr/swjB0dbC4R5XmTWZ6ldr7RkdZ1HtYcZaOqG5JbLsb
         zREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723754905; x=1724359705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWFk8iT+QX+XvTdHdEEQEkz3sro4r7bOKwiITHQ68Hw=;
        b=I+JRXdzZr8LoiBEc5dh55LDPmSJT076nNeZuHn2KT2uY45NId8hWaOsN5Jl5KPEunc
         Hk+bbW+c9rcE4Ufo5b97NOn+ltAjRXSu02Enz7fZIi53PbdYWr6BG6LX3rrLhb+bcINy
         CBU1UIBgPjZT91qQNsLO5EmHmI4/dRimzVx+xq1tA+sQsRtvu+OwjIx79XWx+ZaMAOUq
         Z/8k/j9z4UagAhsz/V8n6doQVa58yNP1C2VofuFH2bKAH6YiJ87LybJ8wBkhkeaMlXs/
         VSRYPR01qJzRVm+e5wFssktCONtrDGp74d09w/to+s23ogVKrGwikD0Um3Ad2DMUpJbd
         LGZw==
X-Forwarded-Encrypted: i=1; AJvYcCXs9zhqoeqegRO8NPbGF8HKdJiOhLNLnMtgm8FgLK4KUpVXU0g1SjbYG7RfOtu7dGL2NxGjKK1KycMDzE05F5UdMm3x+4IcX46+06DMbA==
X-Gm-Message-State: AOJu0YwM8DVakyFeS4akDxeSLAc4R4GwyfwiRAIOXTnbcSiwdgifFkZ8
	ZVLiQMO51YupRzz27ib/ycGTiF48waJTWS6tTQewKuUt1mzFJ7xxzS/38t05ujARLpM4ioo1A5n
	nZA8EXBwll3NFJnVUusWncfVLVMxkUqCQgKBN
X-Google-Smtp-Source: AGHT+IGVnfhBG4W19/FTRIrb1hsBS75Egz6aKroeRS9ZT/fPOBGhFknbNSjR/FE1Ln68gXD8vpeEUMfZUXOrDt+XP5Q=
X-Received: by 2002:a05:6102:f12:b0:492:773e:a362 with SMTP id
 ada2fe7eead31-4977999b09cmr1311619137.25.1723754905259; Thu, 15 Aug 2024
 13:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com> <CA+icZUUdevE_n4+PgwisFdpxz=7XwaMciVKn+XnDHo-=UqRZ7A@mail.gmail.com>
In-Reply-To: <CA+icZUUdevE_n4+PgwisFdpxz=7XwaMciVKn+XnDHo-=UqRZ7A@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 15 Aug 2024 20:47:49 +0000
Message-ID: <CABCJKueVBE0oZuvsDGy-etK-LcK5p5RJg_CQJQnPQ8MuMpGyEg@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] Implement DWARF modversions
To: sedat.dilek@gmail.com
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sedat,

On Thu, Aug 15, 2024 at 8:14=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com>=
 wrote:
>
> so this work is on top of Linux v6.11-rc3

Correct. git format-patch also adds the base commit to the end of the
cover letter.

> can you tag it as gendwarfksyms-v2?

Sure. Here you go:

https://github.com/samitolvanen/linux/commits/gendwarfksyms-v2/

Thanks for taking a look!

Sami
