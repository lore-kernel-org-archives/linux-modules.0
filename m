Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740C83C1992
	for <linux-modules@vger.kernel.org>; Fri, 10 Jul 2026 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702815; cv=pass; b=dG5/lYKlKCCMBPlrkH/rJ3Gb2NpRt09jCOqGKH+hZHDUoaKKGRGUDIc+ytMNakzAvjuC8wr111nIwdyNLvPOm4vNvHQeOddiFsVc4+GLbYfWfUYyW8Y8NUiFNCHfGaQlQUs3PRkz57CamZCw5gz8YgjMtrUHAq/UTvAKUswdI8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702815; c=relaxed/simple;
	bh=jYDyQC5noxejHXMcaXIqnvEa/ZDQ8QvkOkZRRR3SPwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTHSdoTvo7M3TXijzk2Qa+l3IZs5bHSLpR/9bxJ9h+as6qA7pEZ8kbuG2GwOYi+699juylr7g6JDLQgkcDiYPAMevU9dYgV+lEdFsdxau76aG/pjjZg+6FBXlbBmO2Dw4UxWHzHJJrcTXBtcoqDUDvxyfZ7yRCtmCUT17+wsCtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kug4WfUC; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kug4WfUC"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37f9e2642deso150318a91.1
        for <linux-modules@vger.kernel.org>; Fri, 10 Jul 2026 10:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783702814; cv=none;
        d=google.com; s=arc-20260327;
        b=ZVRp3nX9qGKMFSyFmStFqGL9CHYg2RYkGaH3wA/0HEHN5pM4pRw/3EvqNPw94xeA6g
         zyRPjy4AIiyJTunV2DaEWE0D4g8Z0l2AM1NeHRGwlIsyy6WA9SlOA2lwHs7IfkrKsRvZ
         JcewtyH7ck4TA3LMQ/AB9J4Oq3Wzm00cEJegZDW1d7TFtOXDdOASgx/gXGj5ytLLjhQn
         k1wg2gcvanq2Gcwnt+54WHAkhCWZXd6eTo6Whtl9y6CecZxtqaEpMsaxNeyPpz/XGuCN
         smVeIaA34ABqrPM/f8mCR1Btfcs/hYfubSOWV18g/KbQbvydxylY6mP37LCMllncSo2k
         AYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jYDyQC5noxejHXMcaXIqnvEa/ZDQ8QvkOkZRRR3SPwE=;
        fh=g71WAbTZ57zWVfl5rKTXp4KIG2mMO+tpqZ22KPcxJ9s=;
        b=SQO64r572KGG58MWGEL3grtrjRuRv4unlen7MrjMtwD89cY2JPuevsFYYQMXp62pdk
         WfmY/uMWPXf6+OWHxo53+BNnpwOpBga8184S3GyISKTn8loBYqSqDmjERj0ejdZNLKqr
         xNH3eHkZICItEDBKyCOdGkllgN2H5I8vcTEvTzapFL+84C2OWSGn+A5KGrklEiEyUOyn
         IqwqccVEaNQC+woBl6cxL0fCj5zxzq++k0S25o6RHzFQuRsCuQVdwMVgIa0VyTVWARgn
         15UOSt7+ZLXH4Vc2a/i0xhQJDpUZXsONOMRWTp9VznsNWdTtkB+dFWbdgVAtAcnbOwpf
         Pc1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783702814; x=1784307614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jYDyQC5noxejHXMcaXIqnvEa/ZDQ8QvkOkZRRR3SPwE=;
        b=Kug4WfUC8S9j1KqP70ew0x97rg3wc6lN1bGxVT+0VAPYHXTzU1OAPEKp6TUMB3xjWR
         yIvccfaucyfE9X7dbAelNXHEnMioXdtfRx6NL91Q8eaeTITq6zlwMyufS7weyapUm1E6
         EMAXcq0P4ps0xyrxE58CYCiBqEIjPD82JOpBSc1BMNQ+5HR012IfGy8YPPvVdPX6/ixr
         OaWq1jp0yA0+M9lIvBDegMtjjyFSqPYA55vTqsulq0tTk1N+DSThlQzsfBqRJqeNgFez
         KOrmgEmcaXxvUZOMhNcH1C6wcqDyOuXFmhqo29sGLn8GnEwJ6sqhqYRCoBTDcBOVfE7R
         jgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783702814; x=1784307614;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jYDyQC5noxejHXMcaXIqnvEa/ZDQ8QvkOkZRRR3SPwE=;
        b=CFobW52hviONHZ4mMYlRTiol9MDJkLt4k+DYKoRlV7dTl9c0kG3gv+EKOXUZbjYs2r
         omIP9zM3seukPhqkotzmVnaFh8+F3ZBKL2fBnN1LflpfN9ffWoI7aWDR1NIWNCFBBVgJ
         miUJGRzIVEuxEWa+P6kQ861faZzflZprTlpzHD214EMiMFMF3hBteMRd8PMp4Em3FpvG
         GR9ghXsllW2dWgiXDrICUBiuQC+NcjDIj5nmcrI7+b2BCMexZ3MyhKc4UfEsldSCwmvw
         VrSjhD/Cmsw8aCowb8BYMZQTVA3MwKzbDTw9TVCC3nVOQ3Xsr1R6OsDd60BZ7wL3FJnb
         dR2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr8oRzNyJreASDyoXmwPOOfeK4BJb6ubzvhUVxCBTUl5g3AxM9pRlYtq6N9nUBa147FYFNaeAjZXUyxxzoI@vger.kernel.org
X-Gm-Message-State: AOJu0YzpADliXfzu5M61MjAyt89LneIdPC1zUxJu39JoW/EhiYsUxQa/
	4OWggJ/t+NaiUJDe1C14BIfUDMDCY5gDaGBaDjYMzZEIFJ3ZZajJul86frESx5MZl+S3MgZQHoL
	BrHY7AsKqDN5rfAXlfUIHq69RG0K1IrA=
X-Gm-Gg: AfdE7clakT1l0n70wS/9JJg2ICow6j0OmtGPt1SqGFo/TxgoWj2M3Clo3zEqfvuonnS
	7prJfszXSGtjQuqrzmZxdv9XgE1hVQ+TWg47VyFq8B/NByh/RPKsVWecR+Xh5l7CBB0ds5Kmlfz
	kUYJ35NtLdMM2hZJT8qEPV0JORkjpuo/v4oLfVOVVPvdd+TCZYUvvX2hVHTskFbc+f1ju2FqLEo
	KLanlKlPlVeGhg3Dyg6c7J3LfmO0MM61xvdk7D9uG5ZUfasw2sVmBpIlXUb26WNgrLPLDYypLbH
	5d0xUiC2dGl/XpwUOc/F3m1yrWnKafxMMryMwX7iKEPqzAvAhk+7SUHpIqb4n7VgoXYD7aQzYW8
	l4GFXgnDMtZcJ
X-Received: by 2002:a17:90a:bf17:b0:38d:90c1:2485 with SMTP id
 98e67ed59e1d1-38d90c136bamr1755634a91.5.1783702813717; Fri, 10 Jul 2026
 10:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-modules-value-ref-v2-1-12ebbf0510c9@kernel.org>
 <52feb9b1-2073-4fcf-b2d1-a7f42f1e72a5@suse.com> <CANiq72m3w7L5CmAsFvOpSh_jNk4jL8+A4vz8GEp+E8FY=TJcRA@mail.gmail.com>
 <30e500ce-e9e6-43cc-bbdf-ded7c0ae56cd@suse.com> <alEBInX9gD1M5NAr@google.com> <bd1f78bc-51b4-44b7-8e3c-7accc9e173f2@suse.com>
In-Reply-To: <bd1f78bc-51b4-44b7-8e3c-7accc9e173f2@suse.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 10 Jul 2026 19:00:01 +0200
X-Gm-Features: AUfX_myPaEXP4g2vFy2sJpxBrkO4WPpmW7nI-fz77EOc6odI1iQhqhWqVntgnb0
Message-ID: <CANiq72nxK=nCf7C-GQ8JCtaTnOaDGwGDFKoQEVb4fqNonkKn3w@mail.gmail.com>
Subject: Re: [PATCH v2] rust: module_param: return value by copy from `value`
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 5:58=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> I can't immediately reproduce this issue. I tried with linux-next
> (next-20260710), rustc 1.99.0-nightly (af3d95584 2026-07-09) and
> x86_64_defconfig with Rust enabled. What am I missing? Could you send me
> your config and the produced rust/kernel.o off-list?

I can reproduce it independently of this patch.

It looks like `panic_null_reference_constructed`, added the other day
-- I will send the patch.

Cheers,
Miguel
