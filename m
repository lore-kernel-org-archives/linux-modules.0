Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F1126FDA7;
	Fri,  9 May 2025 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746775691; cv=none; b=l9foF/VMF8kWo/9FIPUd+9kMaUwsojhuAzVa1l0UJtfYDiri8LnUesKRcmt+xRb8J+Ls4ytx/qRT4LJ8rJp0ByyKmWbEC3Pxe06Erdhemdpy5EKHqX7uY6Sy+H/nMFAIk8ncwLfu9COblQEGxCgo8y9YSYJEnPBTfTtc3S2A90g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746775691; c=relaxed/simple;
	bh=Ov6WTSmPcRqqmbQnF9ivBjIVimf0CJ35r0KM5SNX83M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auFJEewrieAzkF5iT3m0wju8++8d+obOv4ajm1qcO3tlwGcRyMh+GHSAiIUsp6rEfkLoUw0XTRxe4FgIlxji3H+PtR8T2ikjR1kzg13fNmKc9pAjzrNS8UoodYUYHTELOhXrfQsFpuE3Zt0lZ4GMiDqC6v6l7bFsgqwCuMZKRos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OExiCV7i; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OExiCV7i"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af5f28ecbcaso141831a12.0;
        Fri, 09 May 2025 00:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746775689; x=1747380489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ov6WTSmPcRqqmbQnF9ivBjIVimf0CJ35r0KM5SNX83M=;
        b=OExiCV7i96IvO3Sf6x2FpNwxFeEMaon03TDc/JSz2btp1u4MOsWvJnVtC2+YLJ/WBJ
         qRiQJUuSMqqpw0J+O5OD9F4WFdNE60jvyqyvDjt7vSlC0F3qNrDAcvdioBCdqZFDjD03
         MKBniYvW1P5rnHEpujHem0hg/w2vytPwzN654wkJzbf0Mt6dU4TdRTh9G6BOA51RpGTa
         fOOhrGoirOp6HSrv5DiORyJztAZBIZGQpvOPPc4YkkNXkrNyO7tRfaIOVtNNiP1IeVpd
         DJTrTaXU+diPVeP0UcpGvxZ5fMxcI6mR7VmQvA7FdvRBwOwWB9ZvHuyJUchGZYkFwwge
         XEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746775689; x=1747380489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ov6WTSmPcRqqmbQnF9ivBjIVimf0CJ35r0KM5SNX83M=;
        b=EUb2DsjnBcqedS+XSL9teOvmIEKtpKVfoGMwJdFMmM8+55DnIwQm49Fvk71Ni/7oA1
         JZojtT20yx6nE/6ob6KL+OuMNFDBefbZHXoHU0Dhye/ieNdycN1Qf2p3XrjEKWGGqd9S
         kSWybMedlaql0TwmRSGDthyJVjfUsDEx2O77kYJULlDcfElVPJgTZztTdAkZ64Xa5kSs
         OT1M2Qs+Sci4SHZiqGIeClf0WdAt/0Tc4TpLkHim1NgSXpYlajqzJ9YC9iDo+HNZ0MlJ
         xItOG6YKsJW9heaZ+vBWQG99e+ai8uY3xPOXD0rvcHK3S+FXOFqF5I2dy/MM3VX32apT
         NmCg==
X-Forwarded-Encrypted: i=1; AJvYcCVj5IlbrcN9M+wQ+crmdNCD1qHriiXwp4MJQCtHgX0wOAKI9IZLVAz3BjP3vyTpgF6vNhr+N8aEmyB4hLdGqIA=@vger.kernel.org, AJvYcCXnYYzr+yWZyTD2nFmUfjfvpoy0CnTWZqLsfP+Vfwp5SPiUvvzgOzEBBaUVVIu3QwVHXB1A2L7c5nXzkxE0@vger.kernel.org
X-Gm-Message-State: AOJu0YwAysvHEZBmUPf57+sZqx8m5T5ALXe7Y+v7jy9gramAbVuMNCxM
	SL2FzcptQ2iigl75B+DAes9Dl2to8+hHOjPOyxfQPwq+ZR5DoGs9MxUJymU9sJ0WxiMAmXHsYn8
	Z+WOlQqMUrcB2op4kAiQrrS7Op9A=
X-Gm-Gg: ASbGnct+927Gh1oDhPglWHmc5lXLNcaFgUe4vXG0HiSU0RUCfaD+NZ9CD+kRLD/PTo6
	4OOepc+HUAZKY1/8EsuTFRyxCW+c5bMANMMlvK9if+2LBRiJqntTxLb+gJ0wYgazfKunDAD8bzd
	9A2PiJIfGt7FssGFuIgdSatg==
X-Google-Smtp-Source: AGHT+IEYeN5v5TsmNAVX5/zFyrsgqTLSTqDluUCaA0q90511E9XGc3V3Wl2WPMD86tu44NTBwH7DpnodAwumQZ0G3oY=
X-Received: by 2002:a17:903:3a8d:b0:22e:7913:d360 with SMTP id
 d9443c01a7336-22fc8b5bea1mr13956745ad.7.1746775688981; Fri, 09 May 2025
 00:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308044506.14458-1-fujita.tomonori@gmail.com>
 <CANiq72=LEma8DEgpy-z6hCK_xv2Vk91MLbGGC5=votDAVP-3mg@mail.gmail.com> <20250509.131622.164788613577030480.fujita.tomonori@gmail.com>
In-Reply-To: <20250509.131622.164788613577030480.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 9 May 2025 09:27:55 +0200
X-Gm-Features: AX0GCFv8sE8RswZuY7qr6HM6GTumnWf-keuvFmnzyQeQSg0OqA-suiQU3GQQJCI
Message-ID: <CANiq72n_ySP_K_2m28C9L3FOqRtqn8ohkWqtX1Fe9L0szGxSzA@mail.gmail.com>
Subject: Re: [PATCH v1] rust: module: place cleanup_module() in .exit.text section
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, rust-for-linux@vger.kernel.org, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 6:16=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Do I need to update the commit message and submit a v2 of this patch?

I think it is OK, i.e. we can add what you wrote above when applying
(though it always helps to do it on your side when it is a non-trivial
change).

By the way, Cc'ing MODULE SUPPORT in case they want to say something
(or even take it themselves).

Thanks!

Cheers,
Miguel
