Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062D130EF62
	for <linux-modules@vger.kernel.org>; Mon, 10 Nov 2025 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793345; cv=none; b=dHTDVLKJh2DwaZnR6SZ42DAtWtG4dI+LqQdQrE3F09ba/eOnLaj0+bJS53H5D3WtEbfhxSyYeC9V6M77yNKSRjk2R5S7qXprXYITN07EN11P0IJ97MGQmyRUYXBo8NZuiOz6INyxYhDanpEcTWMeKG2qTVhCVwdKHuRsnS15niw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793345; c=relaxed/simple;
	bh=WCn2M9Pn98zQCwXGhIe94Mp208rWyyDEa7Ij/HDRHtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4iGN9zjyaOwshXniDCm4B7BZTLoRCxRm/QBd/27doV6OZjsFaBgIV8bnXkKCBPcBPJmobOp8nAWidmbO0rnG2mRpIgNPeKQ+BrLLkRe1XOVsZLBpsnITtMMDpAFlCUL6fcr6ml0/ncYvYFZ0tartZb3ZNFzuQSfGzM9TZJ/cgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXCIop9C; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXCIop9C"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29806bd4776so2714495ad.0
        for <linux-modules@vger.kernel.org>; Mon, 10 Nov 2025 08:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762793343; x=1763398143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCn2M9Pn98zQCwXGhIe94Mp208rWyyDEa7Ij/HDRHtE=;
        b=LXCIop9C9154lwZg3Trtm3kb7fxgwtRrx/MWfU21BhkvGi1QP8dHv3OAgCWJtm01hK
         sQzeTMCj9AAr+qxes3HBTPDDwt+FhNNRhgoZPAoUJF/KDNwqjy9azSHvI5ez49Oi5W/Q
         cRe9LcY2DZJfksaFhejhBVfAJNu57XIA8qFIn7VzWA3LWJ3Ett3CijAsRTTpzEgEMi50
         X7Ccwwxua/Wefi5U9121aYnrM9GinZ2kc4vZF6bOmH0rFAae6lb/iLvfK8iqdpkNIyYo
         NBF/v2yqn7x6o2qKP0RxJ82yYoFHS3LM1V6sEPbNEzM4Gcdw8a/BO9otQvGHsEEtTdb/
         svHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762793343; x=1763398143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WCn2M9Pn98zQCwXGhIe94Mp208rWyyDEa7Ij/HDRHtE=;
        b=JYitXnqnCN3KakNddQ2B0mGtG7Cau5jzZrtV+3y6/sUcXi7VWgvh1PfifC8Cx/2k4f
         T4F6EGJSA44g1OUik2Xpq4Si84Yg7hfwxFupWAHFKwBJuodkRXEWgDNvDEkll5fTY3QN
         +yl7JmsQ3x7/8idyd6f76rtA8XTr0xD6Xn0PBeRUV+/mSszV8c66XeIXFjxW3WO34qDz
         TdB8DPEmsoWArGQyt0/6mxtLMmx9cWIxmLs/RQz4dmelDjnTmKmjt9MkmTrx7o0DjARO
         E8vNGUBwoQGn46htqWmd7SlVUvIhvHd5o9HPCcpqu3hiIrLy0NPcYYsgVnWTNIU5+CaF
         gDbw==
X-Forwarded-Encrypted: i=1; AJvYcCUWhTVld65SomCccDTBCzuMl4G/BxBO+P+nwHQd7H5US7UelUYpERGWhAMDSpXwLkdJYgXa1o5ZFIUPLld5@vger.kernel.org
X-Gm-Message-State: AOJu0YyiEbk4Skh8Bf+XBP5NfdSZn4K9d8SiLL4kDdhYaHXCkVmXukkb
	qWLYH1K3FQchgbu8P/zUhH/pFBmYl3A2qwucOK+Nel/vbX+p4btUW0v3XlddmoqKbQwGnKoYT0H
	Y4YtzhqMTUmv29AjZTTrEXY+B/FZumhY=
X-Gm-Gg: ASbGncv409nOfgJIV0epw3gGDnPSdXki9kF30Z7Je/xx5X9YjF0Ko/ugOqqQvnwWjWZ
	to02V0OA20J/SvZw3+/ziRDO55xJdC04S8PZLc3aCvx4DTNnST6ObTLL9blDbeF1FwIspHqEK5/
	pna02fRLsNvbpOoBQPAsfqS+c5Ck1GOWj4sR15hiRNuCjzLxQbODld6J+FQV9yRei95MqABAs6C
	gkHReGZAWN2vwz1jymLdvwtV1LJ551059EWKeGx4mtrZMdpOtOfJ5PBYLN9PCdSun+lay9EjsnG
	O+bsxwtOEOHKBIOs8Rijga8OxkOux3N4o0ndVVmTgHbJcoiAq60A8bTa7yZW60Ss04xi8JoK0HK
	xJ9imGbEU4GVCyQ==
X-Google-Smtp-Source: AGHT+IH5I1+eyd6kWRNYzgBd7iVcE03A1u5jBf0zW8VtsXhcRPQLzp8sRacyFb9Hd3dmI6N+ld/TjvRphEHH4nekiBM=
X-Received: by 2002:a17:902:d506:b0:290:ad79:c617 with SMTP id
 d9443c01a7336-297e5611fd3mr70148695ad.1.1762793343249; Mon, 10 Nov 2025
 08:49:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org> <aRH9Tjf0tszyQhKX@google.com>
In-Reply-To: <aRH9Tjf0tszyQhKX@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Nov 2025 17:48:51 +0100
X-Gm-Features: AWmQ_bnW52r8h-0gmyLN7ivgaSD0gXN5MS8PTRXx5xySmJt3bBV43-xYwc4HHKc
Message-ID: <CANiq72m4K+UZxodnKqdx3cowbYB+Mj_Z0gB63j=3jE+E-x+3UA@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:57=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Is gendwarfksyms actually present in 6.12 upstream? I know we have it in
> Android's 6.12 branch, but I thought we backported for Android only.

No, you are right, this is just me being overeager. It should be:

Cc: stable@vger.kernel.org # Needed in 6.17.y.

It would only be needed in 6.12.y if someone actually backports the
feature (which does rarely happen, so I guess someone could have found
it useful since there is no Fixes tag, but hopefully people would grep
the log in that case...).

Thanks!

Cheers,
Miguel
