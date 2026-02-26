Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83062E7621
	for <linux-modules@vger.kernel.org>; Thu, 26 Feb 2026 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131183; cv=pass; b=ZvkaAygO2N5Ab9IX9eLPoiTKFxFWDeiBOTw5iaZBd60aXf6UTrht3xlvDPuwFXNHE7K74snEplcquqdwTnvHeywR790cuNfAR/7NtzEa7P67fSR8bTvdp5QR3PZZ2XALtygUYOJgFPT429E6DoxBFnBRAVZjCZQMmZMvc1UJjvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131183; c=relaxed/simple;
	bh=+3cHqP/CtaLXwL2fWRFC8YJBiL/GRMMotjHF+n9QyHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqfYytGzvp8BeZumhGFoHG7/5eYwQYfNyVfD5RX8ylytFycZ+Pil1uRq/ETCPNXBSELALFKuHrahAhmQQXX89MZ341t7BQXW/ItqWCANS4+Rq1Keu4xwJLRIr1hc7PnLm6Bds8CPxYYxWGolwe4L2kgk/n9ZSVCc5N0f1bcu8qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vzvgwdcl; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vzvgwdcl"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65f3a35ff13so1100a12.0
        for <linux-modules@vger.kernel.org>; Thu, 26 Feb 2026 10:39:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772131180; cv=none;
        d=google.com; s=arc-20240605;
        b=ePmGuNt/xBAQSn3jkIEnE+1wr1tRFjguF6q6Ozq8CYlnGbl92rBoUFoLHeeyW3E1sS
         8elszQ22Tz4TpoIUXltH4ajje1C1sPDeqMUUqGgj+sU6xBDxC0AbdTXyp/XVDv+EKrkp
         fZlBFQl2lSVywEiwxSjiPts1jU4kmfebmY0+ReRScbmRncJDjh2FK3O0EORiqy5cBcrj
         0B4m44ff8zx/KxPiEwbMWfKi+n0kf1PX1HDLac4f6ASbvgE43Z1yX1jnETsHFprXe5fj
         /aj64JlWsKBKL3DpNJCgidlmYRBFkkNB2MY1c3uwXsIe7MD0lNVCxCZAr2B9aisgllCw
         RL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+3cHqP/CtaLXwL2fWRFC8YJBiL/GRMMotjHF+n9QyHM=;
        fh=S6Vjs4aazgyOh0/i5xLHvO4GgtZ2mmzXdyiwA1AYs3c=;
        b=Yv2YHfSeR62VBqt112VlrUmDciOE1sCEzfLXh31nIbobH9lyyM6rTwZXiClOFVnf5w
         dd1Ms2LoACmvNoS95yJtKb6T7PhgmDIthz/3CnsUWVSmGxcYji0e8diAcBj3l3auP8yp
         I0WHmRAzbiT/7YZPnSqVlPJBcJi350sJNGJU2x9+RwBDcWCHJ/Bmggau8vm/eJ6w2mXH
         rWQWEJsY2ebPsKdb03xqUSZ9cx1GuMvHMEa9tsbpac1/c7lHHvc1vtFPFsKJIA5z6lNg
         MBwZszVwdV9z6gBKckxnJdWC+1LI67K4cbdUxaePohb1z5si65P7RQvvXAt5/ScwpMyQ
         vS0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772131180; x=1772735980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3cHqP/CtaLXwL2fWRFC8YJBiL/GRMMotjHF+n9QyHM=;
        b=vzvgwdclLp8knYjRgNv2NF7vbcqefmSDoQn3teMXmNoXCKgG7Q+Oiz04oAnwv7/Fmq
         R/lNDJ28z8m2FFTw7rEGJsBjzwQINJochZjI2IsNzA/hcJ+tcv+0+LPONfFz+pUJQuQT
         qxrvtRu1Y+XjGHwf4GVDeh5wboupZk1jtU9aCIJU/TzBve4iHRG46w3YSdWdkCkRMGSj
         4QbnqSS1v2d0S5TznhQGsf41TcjFZiAbS0Xt6/JJdtyShwFQLt3Y0GoGcid0/ZsA7MbF
         jFHHzKddE8nNUSdqHv8ZNkiIgpgeHo+YcCHG/N6HKzDwdla48sXe5SK4mG+hLB7azpmG
         xAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772131180; x=1772735980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+3cHqP/CtaLXwL2fWRFC8YJBiL/GRMMotjHF+n9QyHM=;
        b=n4y2yAVmnlN+0d1LbppqYELSuHAtJLxUvXx4XKON8EnicjsqgXm6hINYdPCT34ZNrz
         +qR/TxQnCGwdapMjqZNQTuHEsZTRjxIw0e+A2lydwaIEH3XgGeRfZjNmyFh7mJRA4n3Q
         +/XAw38WQWdaUbJoSg2mBxHjKW32Ffg4jsX2o82rU6XPLGhkthC8NTy4usxdcaEzuV+w
         i9s/BvWUQqLz6i66UQof4+7/U7LkgC+TZUIoLGGq7ETyM0uIuBcpPr29Q/skeU3C+Fs5
         0nRoRDnmhZdRPYLVB0XrhgNFoJFXv2AB/ZvSh9lbEE0EF4UUbWatEQ6zwHyGcx8OBou5
         UdtA==
X-Forwarded-Encrypted: i=1; AJvYcCUWrXyoe6+M6I6PWxE2LWncJ+z6acjtV2rM6pcAw1zM2c3mft8+YwxgXjSjiE0Xv/0GOjuRwwVBFKHgmy6H@vger.kernel.org
X-Gm-Message-State: AOJu0YyY4lolZc2jlxDX7ZIA0end0T/v7OcmgW6Nj1kncFJu+P+j0EZU
	Itlad9WLmbOHHd3NqIG3VLGdr5CuIG2mCdP9S7wFyOjljVJeu169Amxk3FuzUG1NkOYtJhZ63mI
	+3TqiPrqjzBn8XOCkuMvOE+n2gWT9e9oo4FiaYMOv
X-Gm-Gg: ATEYQzxaGGyUTN4aFo2+YDSbLu4+Yl2umkE5ukNv531TiEa5z2iNLDBz2oLTjpm7uIv
	s3lneD3+QfVd3+lw+kPNGnWn7bRiKh4zevQ63tUYq8AFtbmHvhLsMcpoQVjLoZ7xjDi+GJAWjoT
	6bygnNDpsMyf4a8X+rni6n87BfcRZuZ8Bi1UtMnO1d3mdx54jXomkrbDWvmEqoKqqLmuPSFovMs
	z+DHA6YFBnVlNSseoYjG2GaCWxm+1JuHEds+HCCLjl0yQl4h395eWCf3zqdXaC3C51JTAP0uMsv
	RPXU
X-Received: by 2002:aa7:d292:0:b0:65f:ddaf:d1c5 with SMTP id
 4fb4d7f45d1cf-65fddbf1827mr3660a12.12.1772131179631; Thu, 26 Feb 2026
 10:39:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231094004.37851-1-laoar.shao@gmail.com> <CALOAHbA5fkK8XSqo62=k1hVX+krx58eUWMLNwMdwncAp+Xn4=w@mail.gmail.com>
In-Reply-To: <CALOAHbA5fkK8XSqo62=k1hVX+krx58eUWMLNwMdwncAp+Xn4=w@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 26 Feb 2026 10:39:03 -0800
X-Gm-Features: AaiRm525IjvAgP2m8U1ztRPIt1NFKWi9elaaOHMPnFuFw6PDgAFCBbR_5SlT25o
Message-ID: <CABCJKuetWVkjqMPR371cEs9hhSd-kzBFNz1UyQk=t2C1Yc=ETQ@mail.gmail.com>
Subject: Re: [PATCH v2] module: print version for external modules in print_modules()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	atomlin@atomlin.com, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 6:19=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
> Just checking in on this patch. It looks like it hasn't been merged
> yet. Is it good to go, or does it need something else?

The patch looks reasonable to me. I have it in my queue for v7.1.

Sami
