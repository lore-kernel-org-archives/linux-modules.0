Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB6514EC73
	for <linux-modules@vger.kernel.org>; Tue,  8 Jul 2025 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006091; cv=none; b=P7Np9VRV1QB2xeioTX83sIMPaw9lwptBNrrmF8z5ucq6Ms6CAmVYPLQ8otW8txDMm7i8mbwwpqkEJzodKt4mjz+WpWiu+288jJf86eyTC2gQt0GkQMIQPBmuqHii6XA+6JArm3IaWz89H7nIj0Mru6KuLIj2M1aR7JN15OVUYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006091; c=relaxed/simple;
	bh=rhVANd2CKHs5EuwB4/lOPiX5cc+fBw9k44oRUIqhsUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0NxhOLw4mxAsDFDMzlGRMmrDRtRwpMORIxehg3tm/NBKEt/xdMIzFXTt5sxoK7SdHL0tWq55ao1MIj/ku8rvOXO2r72BhJdAI3Ojw7Nh/cOSosIIe2VIEeGWcBB6aB2tsbxO5Dd9RSSYgvbgGNfcQjUfa/vFLmB0AnJb/N0hEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EN3+A39e; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EN3+A39e"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so1014925666b.1
        for <linux-modules@vger.kernel.org>; Tue, 08 Jul 2025 13:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752006087; x=1752610887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ijYJWb4fuKBnre0sB5ESTtw7WT87hnOyRG+mP9wI11E=;
        b=EN3+A39eFX/KcKfTIQi8D2lr4WwmAjQcB54fYUZE66tHk2QM9hMiN/ccTiX3obtP4Y
         mc0AJFWH2r5Wu2E+dQJsRRZFQhzFCHRrBU5lcvlTtUPyX231zjx2U5RXlOjj2xniFnp2
         X7MYHzFeUZQfuouJIqKuMRdEjmIvRTQI8WR0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752006087; x=1752610887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijYJWb4fuKBnre0sB5ESTtw7WT87hnOyRG+mP9wI11E=;
        b=gjDy3NXrJntggGFbt6Svd0APtQytBRgrwMdcC6k7etDwxkZzTpM7p/srfZklSJtLA1
         WCDoabXmEtjCkUfEVnk1q9l+CoYdxhtR9AeAHvSJg3SbsceHRUQCNWCOluM7RqGWSk6l
         1XE1O0+bVZkTtKLmIZ2JAjCkzVZAx7mB/Y/498q05Iyb4comJ0ojYd+aNh3duzxaGp6u
         LRC/zVD9Mc/ye07UKZRkBfHsK0LJspmLloe0R92Zb5VIbQ6hlaXGS35AzNPy5QS7QJlF
         uv9gEPoHc3phw5yjV+SOU4wUUHdY1Y7GdSYDARv9rmZzxuDrMwbFo5pKzMXRgJBhOJiD
         bE2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVe8MjcvS1xlqMcLib3NACUYdUolcAKbl0urh7lWNTQ+azmIEYpmsnlpcWeO2NDMHBCu8ZkRtOgfh1mOkZZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyBwhK2QigKVD2nAt6QvdC7RMo6ProMVDGMRfEwZSwZ2rctsVsX
	HVyMBykGBgFb+DxjsxEzb7rCbDPybwRgMOCy1RQipVs0Z96VMCxm0ZD1nTlpCeFkrF3IZOLWQTJ
	wCWCS2AdW6A==
X-Gm-Gg: ASbGncs94K4IMmp2SdqwrxHQr9nHluzL5f0XdECUTQjfejGAT6RH+p5SgBRDV4/5l1C
	KYkkeNrgfMryWTL8TcXG8UZLwIGU/gspbU5C/1N1Cd+a7swrOGq8mPq+4iBZPedl5KKPpzqMvnU
	jXxV6uMTYt0n+bo67S5wU418x4VEHWqb/pgf/K0plhNix1Lj6vm5UjtfGbDdOCipcoo3RBpZrBq
	kVPflt6QS9NQlMHQv10mGdWK0eKWK4few1p2JDyyRId2CWbpQc/fP+naxbQztGEXr4PiTfWqxqJ
	qpLFoEA8R/L0wibo1/zjIdh+0PniA+cbVYscA5LcAAEC7jzDbtDrs92fnxYs7UQj9UjqN8PMEpQ
	pkTZBs0PgAMMmvKRjNkwcyGHLywbyAdli3emD
X-Google-Smtp-Source: AGHT+IHE2I0EwykafLOuRvqz8l3U3sGE/o7V3EYfzpDjO5JYl3ajk4QevDv52ARMTLwfxNezz81TKg==
X-Received: by 2002:a17:907:60d4:b0:ae0:cde3:4bbd with SMTP id a640c23a62f3a-ae3fe73fd29mr1664147766b.44.1752006087362;
        Tue, 08 Jul 2025 13:21:27 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66e8c31sm965385666b.18.2025.07.08.13.21.26
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 13:21:26 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so9483537a12.3
        for <linux-modules@vger.kernel.org>; Tue, 08 Jul 2025 13:21:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWn1pq0Klgi4FEnhfK+7HIvv+jSQgXnaZodpnIuAsDLe1eawcL6+SHy0PpC/R2Z5+JILUeHQ3nMTRVoGAj7@vger.kernel.org
X-Received: by 2002:a05:6402:13c2:b0:609:aa85:8d78 with SMTP id
 4fb4d7f45d1cf-60fd652543cmr14984957a12.8.1752006086225; Tue, 08 Jul 2025
 13:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708193822.45168-1-da.gomez@kernel.org>
In-Reply-To: <20250708193822.45168-1-da.gomez@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Jul 2025 13:21:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHRv28HBL47x-L5okG+fZDJyX432uxG3AQqbqRAgkAYQ@mail.gmail.com>
X-Gm-Features: Ac12FXxAhDZRAkaLA0YsEY4-BABaOKocyzik-IBHOi0g_zOdXugIsdaXaIH8dCI
Message-ID: <CAHk-=whHRv28HBL47x-L5okG+fZDJyX432uxG3AQqbqRAgkAYQ@mail.gmail.com>
Subject: Re: [GIT PULL] Modules fixes for v6.16-rc6
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	linux-modules@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Jul 2025 at 12:38, Daniel Gomez <da.gomez@kernel.org> wrote:
>
> Petr and Sebastian went down to the archive history  (before Git) and
> found the commit that broke it b3b91325f3c7 ("Don't relocate
> non-allocated regions in modules.").

When mentioning git commits in other trees, you really do need to
mention *which* other tree it is.

In this case, it seems to be

    https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/

that has that commit, but that's actually a kind of odd tree.

The typical bitkeeper conversion tree (which is where I suspect the
full-history conversion then got it from, unless somebody did a
separate conversion) that contains that commit is actually

    https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/

and there the commit has commit ID 1a6100caae ("Don't relocate
non-allocated regions in modules")

                 Linus
