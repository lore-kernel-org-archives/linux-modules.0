Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C545721576E
	for <linux-modules@vger.kernel.org>; Thu,  6 Nov 2025 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437464; cv=none; b=kvLBRC++7TWNMU5yr+sn6/FuoFyHcfraE8li7qEYL/DPYTsdBHHxy9/48CGq500z7CQ0RZpIgVS4w+Bne1FB2+zYa3A7yLrdPOHmGJkWI2gx0J05tWIlGVst9rwnoOw1q12A03ekE65pls9EHkOyPKeshbngeqDnhiOYrPeaZf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437464; c=relaxed/simple;
	bh=bUL9CATlSKCEFp9SchPtm2+vj/Y9WiYH7wXBHCxt2fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlA9b7AcGVQnWWsjUWaOKcr+f46xgSqVh9H2/cduj+68Fzpqk/Vce150RyU+dDDS9FlT4cO1PMqHvcbBpilTeq8y6Uhj55gmq8hD3/fYGmTxw9WfCJCwWSO9A5OvOatDalaJxnZZtASgqlSMR6JoyVkKX8W12JWcdys1+AidWfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKPEwIRA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKPEwIRA"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7ae1c96ece1so139661b3a.0
        for <linux-modules@vger.kernel.org>; Thu, 06 Nov 2025 05:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762437462; x=1763042262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUL9CATlSKCEFp9SchPtm2+vj/Y9WiYH7wXBHCxt2fE=;
        b=LKPEwIRAXcgo0WUatz2FJwXHuzJR84+959Q2PsTzhRDesNq0l5VC2crRTDpgK8TyPb
         ojev3/+4mMr4mdMsq34AasGyEx/tYa8rGO0D2J8Lhw450Qct6Srr8qfdWrXcG5aSF9ue
         4YtCupyd2LdQFXIjRSs6NU3qvWaUuLtqFR7g66G77bWNT3H7zJF6Q3qz8ViVhdp9Akf/
         NuP/ojSTWmPTAvaC+to17m7Sdld7gkIiDeHiWeqdmCzyeMM28dqqTor3kPi0bQMKXPOZ
         gl4qY4uJMdnMSgjWm8N/7AMJia5LritAQxUH0yHxl8g3CIK0gt2rOn9N4cG9qCCbW+D+
         z/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762437462; x=1763042262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUL9CATlSKCEFp9SchPtm2+vj/Y9WiYH7wXBHCxt2fE=;
        b=g2f+o3h6HivCj0EZioVx7aNyEZTO5g6xgrUDNd+2qoYzDVdfsuhujWixySJRmADklZ
         gsLf5Wclnoj3x+hjmjyEtv3zlzalbvdK9TR1j8LZyjUBuCSwC7P0IquUTbk3M8J6lY+C
         2DqqK2c9ExjGyvu8k6HGG22jgrUoidO9CaE2k/NkgtR15V5xS4+TRtbmyM6vRNtMbXdy
         sRyXJYU1cVj++xq5c7EA6ZATz+nqygHzPJCKVUMhYkil6OefSKAROjtKFgcj5c8NkNxv
         sipOAJSS7+ZZ/D0e5NFfgtl3RC5XOCPUWS/uzJEHpPkSYT1tf9dM7Wx4kMGa5uSSS9A5
         JCgw==
X-Forwarded-Encrypted: i=1; AJvYcCXRvk4xONbgudM7gSvZ87NLDXDL1MHBV7y1ohUyNVF2hHjHXSWe2ASxMH6vIZDmIepbw2ecFORPQSaWSSHo@vger.kernel.org
X-Gm-Message-State: AOJu0YyadFTDJ7txdvAxCcgYQhgBAHWC8jRnFtTxEvamV35bLQ5Rswjw
	5/IxWL9KX4bbx/wy4ZAd+0qfkwAZGsGRaZJmP+T9BxPgyJj6ToSZNyFAb9I1cx85xcUFNHhHFwp
	OhSb+L8vS/9GBZmEq/+vV4rXi48k4t4tvwZt71f4=
X-Gm-Gg: ASbGncsORUVUBskbaTg4tC4F3CnVA93OK4H+thhg2S6Y7VSly0HQfPZk9R79rVt9h78
	t1feTLwWobvFpLwAkoLPB/A5xVBFCt8OTvV3P4iTatZ9OlcaqxVsrPnsRr4JquNL1qMmmBup262
	2a9R0pN4+WcDL3d2KJFmTN/Cri9jS5aoUaC9rST8iNzWP/idM5HSPY3NamxvIsk+OncM/KSAG4/
	Q86XCnMu0xjQ98cZZD4TRvl6D0VJDNx2Vb4lbR7i6LrOukkAKfWamUVwUe4bRYiHAl8qV0s7ttz
	3mjveFyHtmzuk518X39ea+6s8kPI0B9T9TH5/LOWu4cqPZCYdTLMreu5Yj6IqS4bw+s9OJRnlEs
	vFauH2+VRt0Zxkw==
X-Google-Smtp-Source: AGHT+IEfIacu7s6ycCoXlIjtrZumJqQD9mwD7KRNq1JmFtRpawOaWyWJr8khm/TbVRECay6vyiuPhyfPEI4cfE8PXsY=
X-Received: by 2002:a05:6a20:3c8e:b0:341:fcbf:90b9 with SMTP id
 adf61e73a8af0-350f650d87dmr2226863637.4.1762437462015; Thu, 06 Nov 2025
 05:57:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b8c1c73d-bf8b-4bf2-beb1-84ffdcd60547@163.com>
In-Reply-To: <b8c1c73d-bf8b-4bf2-beb1-84ffdcd60547@163.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Nov 2025 14:57:29 +0100
X-Gm-Features: AWmQ_blZbO9Jzsw7nDP57RH9_Ct2efcf_gJ3fIi9rJydGF2_Lre72Afjk4gaiDU
Message-ID: <CANiq72kX4Yep3pNVq8Ge=txQbPnMO=zKsci5cPgz5LDS=D6NoQ@mail.gmail.com>
Subject: Re: Only rust/bindings.o build fail on rust-1.91.0
To: Haiyue Wang <haiyuewa@163.com>, Sami Tolvanen <samitolvanen@google.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	linux-modules@vger.kernel.org, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:08=E2=80=AFPM Haiyue Wang <haiyuewa@163.com> wrote=
:
>
> Strange thing is that ONLY 'rust/bindings.o'failed. And if I add
> '$(obj)/bindings.o: private skip_gendwarfksyms =3D 1', rust build
> will be successful.

Thanks for the report!

Would you mind copy-pasting/attaching the your kernel config file
instead? i.e. the `.config` file (the `rustc` flags aren't the best to
reproduce the issue).

Cc'ing Sami as well.

Cheers,
Miguel
