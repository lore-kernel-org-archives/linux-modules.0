Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB563305976
	for <linux-modules@vger.kernel.org>; Fri, 16 Jan 2026 00:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525155; cv=none; b=uUAJQdyykVApC3dcJY28VqLkjqdsY34NDOGSnD2ysEeZxp8Z3vTvfOuTSPprMEozCFexbdXvbagKpAu5jl+RmxwjLuNN9SI4fNRgFm1zuTY6VQoG1nEX1PRzHI2r3pgryZ2vrtE4LR7zJdl1wkmEkC6FN1RBUF6zvG/sKevzpek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525155; c=relaxed/simple;
	bh=FJKJ7E4hlPJk8URtEkobbu/LjDHIArjU9hWqerPdiXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+B0spRt4O3gz652MwzoXQ2/Wy4SjXso9cWVBkvdUSSUaVKcxfs7of+4+kyxnyGwTeqaPupZ9mVVNC4T/4y79H4MyfTb0/G4Lk3/7HR64e8ScUDIAz97+LSJb55Az8T5s7cMWTzQmFAHWUcCciJTxvktSzc/BYPkVyf9MiFBiAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QZHAUMD/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QZHAUMD/"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b9d01e473so2592335a12.2
        for <linux-modules@vger.kernel.org>; Thu, 15 Jan 2026 16:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1768525152; x=1769129952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LOdeBQCcrvI8C8Fmh1iWea264jcstgubwlFySsR1PiE=;
        b=QZHAUMD/IJ6o/fgvuPrCH+6N8yZFBXlqGyQdg0XI4wdvpSIXsfo1Bz/sH7Bz6RRrW2
         dVtaPTsre9LHI+xBTW0FG/VKDDAMMfV425M6uZPa1lxZQZHclnPU00POG/0scbQIXrZh
         78Qn+Dn2281d8AyVonkJyPC1/nk8M5mVlK9qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525152; x=1769129952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOdeBQCcrvI8C8Fmh1iWea264jcstgubwlFySsR1PiE=;
        b=pIAciv6cwJxdnA2qUNDk6COFNYe06Gpu2njWiwjkJW7ZLFh3lTG4FxD8I/N8A+pFtH
         SpSXJXNVdAjLuZyXuT6awM3l1uhckBkE0Iek4Qn1H3VmwT4It18sjFp7McfeqC9AUI2y
         2UGi8Mfzg7qBTNGodUNptEYZbKRCerAu1AkoX9P0i4+QUCtJKGA+rOWCmTGC5q7ookNB
         C7yqmENS07e87pt83Fo+H1iVvLBQHjHheX8FTyMzU2qXf9uOuaSI/dLnOSneq0hz0PKD
         xWAxG9qQPnvKkL0v0+06MgH7K5s3uwf9Z0ECL9DU4xi3KOR9VZ0fvH3Tppb1VLo293+o
         jwpw==
X-Forwarded-Encrypted: i=1; AJvYcCVnsDQlA05Z7GdGO4T3Znu/8PW4zI+bs+MvyB2uAwZuJY2wYk3G1aBt0A/NpG+my6sGSF3TyyUFc+O9Wit1@vger.kernel.org
X-Gm-Message-State: AOJu0Yytv7N/vIf/oYT8IbQ1hY66mNJ2ft7gpC5IkF+gAimljc81TzAl
	6XO+RpQmiQGm+DD/2cHj5UPEaTfTvalvsZVwHHBhYJEQhHwxX4e9xyVqwGY/X9MnqU7Uxey+9sz
	glayCpXw=
X-Gm-Gg: AY/fxX4ZOr0/fD3j1rNa13EXWtkEbTO6587S4hxZsxfokw4S7QF6yQ62YtbWsOxmEpc
	jlB/LddkSG7a9sfpGa4MFHCoF7++mGWwQiJ8+trWTozkaXqvvsgKr6o6qMVUmtkGJ9UqzcnxVmv
	m5e96esM46cJ5GkkpwMs+APEbot9PwEgkBRE4G2lt+Ep/Q8BDMUJhc2UZ40OfwYqYR/CdTpDeEN
	T6LBsSd4Wh3RKQfjPkDTloBW73tmsW3/JR44KXfHDS0TO0tBjw6uSAKz4urgqlHsrKyMywEUbwr
	8cNQzdCXC4HQ8P8GBDufdCO1FXLj81pkKdbZCKEHYPZ7MvTdgtbJY1ycwJ8Zi3/KIdKoJtiDRQz
	/qZrEWskH5/Th8+ydH89GkhFaRhJXIvHt52eCIjc3uqVmTJI5NQqZG4pOKG34+mIVGtjWJw2ARL
	zu+lIN9T+bAZz/a4g+idpRw03T+MV4bQhtVO+bxrURGlQSYN4SUYK0g1CC34xPf5Pn4loJhIY=
X-Received: by 2002:a05:6402:1d4a:b0:64d:16ba:b1c4 with SMTP id 4fb4d7f45d1cf-65452acddc5mr1031645a12.19.1768525151881;
        Thu, 15 Jan 2026 16:59:11 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-654533cc5e1sm896518a12.19.2026.01.15.16.59.11
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 16:59:11 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64d0d41404cso2572598a12.0
        for <linux-modules@vger.kernel.org>; Thu, 15 Jan 2026 16:59:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWerwfOq9PRMvQFAxpMMlngAL0lT3ESY7Rf/TGh8c4croZxYlThv28cC6YgLtwMsjr5zvTy4zwzaauKT225@vger.kernel.org
X-Received: by 2002:a17:907:846:b0:b87:1eaf:377c with SMTP id
 a640c23a62f3a-b8792f79e1fmr111655166b.38.1768525151173; Thu, 15 Jan 2026
 16:59:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116000431.643070-1-tim.bird@sony.com>
In-Reply-To: <20260116000431.643070-1-tim.bird@sony.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Jan 2026 16:58:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgZyDxoAr5kLiPF2_6YhxpdjhwwEoa2JTZG82tZ4BHFHw@mail.gmail.com>
X-Gm-Features: AZwV_QjuN5goLR-cDxAGObxHJ56ckXkQWXbqPvyCGZu0bVCEnvBNNJpfgZqKfhg
Message-ID: <CAHk-=wgZyDxoAr5kLiPF2_6YhxpdjhwwEoa2JTZG82tZ4BHFHw@mail.gmail.com>
Subject: Re: [PATCH] kernel: modules: Add SPDX license identifier to kmod.c
To: Tim Bird <tim.bird@sony.com>
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	linux-spdx@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jan 2026 at 16:04, Tim Bird <tim.bird@sony.com> wrote:
>
> kmod.c was originally introduced in the kernel in February
> of 1998 by Linus Torvalds - who was familiar with kernel
> licensing at the time this was introduced.

Lol.

Applied.

               Linus
