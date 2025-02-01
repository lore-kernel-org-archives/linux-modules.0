Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738C11C548A
	for <linux-modules@vger.kernel.org>; Sat,  1 Feb 2025 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738440622; cv=none; b=fUfL5YlTM2zL0DEmTLngPdhxUWySXUSwzNI6pd7rH8vvTWE6HMBgBf8+77bkRWmEQs38OpUFlK1S/MrWc184IJM3QYkCAMjMK7DIMmCkqZ/cDnzZG1mzhlOCk5OsyKfarGY6e7SdtHfFTx5UmZeFxVTy2BD5+P93KY9I9JxGvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738440622; c=relaxed/simple;
	bh=dwKZ9e6C8H5YVBM0MWljIbNoLbFovSt/j2W45tqojAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaD7CUnAbpyG/1PkAkjH3GZ5AzB07Hoq7moZwshJuJQrqT8FJYASeMoyMalBd44qWfJ9bYoVbWDdq6K7Hv/QnMzL2Bl2Np7ScB2rSLXmJlgnQfWY2PWJ14menbVJYyZ9u2CBleEw8YoRwzwxfkhUI97GyZCv2KPzVU9ktJ6acE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eJeqYeMB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eJeqYeMB"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab6f636d821so424575166b.1
        for <linux-modules@vger.kernel.org>; Sat, 01 Feb 2025 12:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738440618; x=1739045418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m7/IZGOLu+lbC+EOSNvACW6MUOzlKWZfo7umiRgi7s4=;
        b=eJeqYeMB14Z7Wm4KMdi76qshfnQAciRQ8pLyBry5mXobsg4YhIhYqihLWAG/7MAR+v
         z8G1iz8aEp/sKF4Bx4Nhy1VR4xGlkQZaSdjWXrIhIysQlt1cokKsa949yAa12y7TxySM
         4MTfPu//iBwEHTt4RA2LsM8Vi2p4lODoWpw60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738440618; x=1739045418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7/IZGOLu+lbC+EOSNvACW6MUOzlKWZfo7umiRgi7s4=;
        b=YbdPL7AZm5qLoh4oEYVtep5nYRhuhxPaaDkmu16nLcEwV5yzkm/PLCEfS3SkE77V67
         WBeskL4nL9Q578fu2YWHHfxSjxKu6Z+Gi4HS7BgHYHEbaXVC61MiBnK8vHKwuUhfuy3p
         6RV6Rq4XVyKaxcl7hk59KjxzL0UelLHDirzFNISppeNptYbtdLJB7SF2R/IIv9eC9vRY
         RGlv/dHvOFTArd8zCs5QkSWaaMlHk+QofCUmbi1jlFvw3KbKjF93H4VF3NsEcU39sX51
         dJ9lX0jMannbSOpRnOAwSuskcGZQIaWv3sF3yeftibYuDJw5nPMQEuKE5SIkr5a++wPu
         dnfA==
X-Forwarded-Encrypted: i=1; AJvYcCWZvk4vd2yjsGbgMKS0DS3LArNMJjnPpgyUDWqO9vJJilGuV9eMZprPS536An+HwNURZ2Q5iiENkz/0C/qp@vger.kernel.org
X-Gm-Message-State: AOJu0YxBPRz2SErEXwRtBK6ZcYW/kpDlWa7Rump51DTvTR/FucYRQlOI
	LAMfFSeWeG6i4+DNrJXexjtpXxM+1QiQA1c7I6DAtqFb+zRz5D7du5uWrcIWu11c8gfn+zMJdyI
	X73s=
X-Gm-Gg: ASbGnctdUOdY6Hv9PQEqrayCWataSOhy1sBBcpzGHWddTFEX3LeneJoodL+MzGzUP5m
	kS/ASR4yOBh+OSDzPyOiiHLlK8dexKC+SGsrxq6kSvEeayiIIe0ZzAbYv9DnPrIyIv30JXJqp95
	4TnA5f7HhZQf4xQ7GgzAjuwI80Mdbg8xfYk1qULM8hD1y66ykbqDzLFMkV2vIPqsXqp2768LuHq
	HhPijgPV26FpePU1CHhbnnotgQMIzB7T2mZ99IODUmzbPYmKSK0xMbXz5SPd9KPQvlKY+aWakRI
	t6J2KA5ig7GVHJVv+hwqA0bWYcbVh/e1HuwrKedtL61ZmyqoTVHQvxnlc/X4mlm7RQ==
X-Google-Smtp-Source: AGHT+IHIMCsGP+3s6I8ne4rDznL6xTsfOdVvYoNZaHMelYr2fCUlJnyJhyPUxfkmWCBq+MBLARTHog==
X-Received: by 2002:a17:906:5785:b0:ab6:d575:9540 with SMTP id a640c23a62f3a-ab6d575972fmr1516689666b.50.1738440618594;
        Sat, 01 Feb 2025 12:10:18 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6ff432351sm288499966b.68.2025.02.01.12.10.17
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 12:10:17 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dc10fe4e62so6013019a12.1
        for <linux-modules@vger.kernel.org>; Sat, 01 Feb 2025 12:10:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPKL7k4UHlW07TXtMxqw/rk587C7Odn5K1M5EIEAkIiT264xuF29j8Ixe7PofW7kAeIPFmzpsE2w1ZVA3Z@vger.kernel.org
X-Received: by 2002:a05:6402:270a:b0:5db:d9ac:b302 with SMTP id
 4fb4d7f45d1cf-5dc5effb6c9mr16000184a12.32.1738440616999; Sat, 01 Feb 2025
 12:10:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201185143.1745708-1-masahiroy@kernel.org>
In-Reply-To: <20250201185143.1745708-1-masahiroy@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 1 Feb 2025 12:10:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWTPjGk5BDUu-49LeTAr21qurcv9BnjmrYi=ZqbFfufg@mail.gmail.com>
X-Gm-Features: AWEUYZlBdDHAj8QtpERwR2LQThxWjeLDU2DywKdmKDGbnm9LYxABBIuPfrICgqA
Message-ID: <CAHk-=wiWTPjGk5BDUu-49LeTAr21qurcv9BnjmrYi=ZqbFfufg@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: keep symbols for symbol_get() even with CONFIG_TRIM_UNUSED_KSYMS
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Daniel Gomez <da.gomez@samsung.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Feb 2025 at 10:51, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This commit addresses the issue by leveraging modpost. Symbol names
> passed to symbol_get() are recorded in the special .no_trim_symbol
> section, which is then parsed by modpost to forcibly keep such symbols.
> The .no_trim_symbol section is discarded by the linker scripts, so there
> is no impact on the size of the final vmlinux or modules.

LGTM. And I still assume that I'll just get it in some future kbuild fixes pull.

          Linus
