Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7432E36CE1E
	for <linux-modules@vger.kernel.org>; Tue, 18 Nov 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482867; cv=none; b=hZ+PlucZWIaFrEouwSHFeDbNAr03lXZwDFKT/+eMtT3rZw3zGBnnPsLnufO76oPqkdWVK9KfyxRsZUwHgY1L3kshcLy4X+3ygQEAEgRzBLTfoCafWFaHfEs/r8w0yIGNDqgBRlRQj1+yCPpeOfpxTTAyGcpX+cWTwWw0+ISAJP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482867; c=relaxed/simple;
	bh=faOfBULiO6Qp0WVmE8McFWL4GEnAP8ye2ZQBGtxMog4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppA6T/AxTec+IlXdxYqrKcNcge/FkuoKeUwzyQbrwNGpgdXDdzM0LiPPmX/u61OxPCGHZli54iInadLGcVgfAknuUTSj22Iy68hmsQgJ7d84LAWhDqNZaPbWWqQkwFPEuUgepONDAuAZf6pOAa82Gr/UIFn3o4IRZzc0jmOmGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zqwcb0P4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zqwcb0P4"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b8f70154354so534506a12.2
        for <linux-modules@vger.kernel.org>; Tue, 18 Nov 2025 08:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763482865; x=1764087665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faOfBULiO6Qp0WVmE8McFWL4GEnAP8ye2ZQBGtxMog4=;
        b=Zqwcb0P48+Opg0PaoHzGH2nKmoyDyyWA0N0PNFgCZOOvSciSj3ry1FttgSdglPBrLu
         OvABB3L07dtuewiVowNYjlByh7RpAr2ZENjqlwK8K5b6nbe2CsalMtbjLWt+qQn7I+qP
         p0evDGvas187GEDn4kAZShlo1qDSOjoJlKWiO6ova8+TadWigOgVTkCPOG2rcotHtH7C
         UfQpu+AHtSbVZCssdbrPNPaQuWsHvevEsxO8ss+k8JhTuBvI1QUt40iUmWvjvT+tgn0z
         Xqc5Gz+Ouvx/1vYgVcKShvUxqGgLGR9JtSBlTwyrMAYot+lJRjK+TlDP6ZkKFIugUIWX
         UhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763482865; x=1764087665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=faOfBULiO6Qp0WVmE8McFWL4GEnAP8ye2ZQBGtxMog4=;
        b=QtPahPxbLAZMtTaSDv9SMU6iUzp0gQovG8EyTSCh+hlh+pMCu41xps+xxsKVcgm09g
         oZKDX5Z8V/9DDdUI0tzzmhub/EiGCJ8XKz16PekG+o5ZZSZHa/eJUnW6CqA8S5nK35nI
         ytnbh9BuOyz+ShZNdOw8/CpPL37Qd6PsUGu+ozrkbjOt218rY1ELWY2x+mHgQ6QzlMM7
         betDiOxdwjKUfAc4ZoVxV7syGYmsmh2iAnjSPzzdnrGWnkqz0n1psZ3IN3dT3usDH8Ng
         toxntx9lxJmk941pNafPwUHv9hQi12qn8zLf+lpt9QyfD/ScEYaxZyPLbk1vKiZuICSs
         +lMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0XYzkgU2UTIdQ9mH9jdsO9+MEVzdG1Ch0QT0XEwG13a+CNMY2fevBUA6CLcdhcUu/X9UdoCw8l/Fbuh03@vger.kernel.org
X-Gm-Message-State: AOJu0YxFuNM9XHj8XQ4a75OrODZTqoaD9q9XoS4lQsQtr36Yy9RtS/pt
	KGvMnNMu2MZ/ly14/zruZLmbK5VqeJq3PFq+STVZyRbJWKySRdsjgxzMJJ1C6qL6Y8wfUgUfyWI
	aEeRoA+oG3Tcg2Xrai5Cw/aeLdSMEWm0=
X-Gm-Gg: ASbGncsurOTkIlZ6CeyFozcdLRgmX1furtXzrMWwZhVaJ4x/qCjzmxiA+5ONVe27N9n
	LZky1nMjI9+k9pbOJfent6Iyah9IcYg8g0Vpe2McPvzvkJCEmsD5+MJmMlaGLGGZ0Wd3FTz2SwS
	KBgsKOSjk7A5GkjlBdmCfmIYvpsmZR+x3MvDGoBu52SAr2MG4+A81uJqFoIevRyyOpFzdZvE9rQ
	0URMTJ1Aq15XUx7KJ1q1Fs1DVdCZ0b+LBkKZbw9kW4Rq8mLmDiPQbMHtxIOvZ3skb739S5Oq+uO
	Qsvfd8br8Smx4FFDm9NXPwSnrRmac+fPvmu4QMMT4+I2oHH77xSR6FVv3U2j8uhIk2GCFacOWqP
	/W0Eov0WuLwmyiA==
X-Google-Smtp-Source: AGHT+IFVRdNsejBm6GKYlYca1Ngn1yJHjVdLnMU26Ia9C7PKBAIRtq1oGRAnFqiiyXtONzw3uw69CCzFP8m6+uCM7y0=
X-Received: by 2002:a05:7022:ea46:10b0:11b:65e:f33 with SMTP id
 a92af1059eb24-11c78ddf633mr1026663c88.1.1763482864497; Tue, 18 Nov 2025
 08:21:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org> <20251118145741.1042013-1-gprocida@google.com>
In-Reply-To: <20251118145741.1042013-1-gprocida@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 18 Nov 2025 17:20:50 +0100
X-Gm-Features: AWmQ_bnVmxUteFT3dr5VfpkhZiAQKyOG1ub40EZh79PVRCrhks9ZqnFaWxh_hDc
Message-ID: <CANiq72nsU1YH3ihkaTiVjF_YUZY2nSKbc7j3xLTcHDC-4-Y5iQ@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: Giuliano Procida <gprocida@google.com>, Sami Tolvanen <samitolvanen@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 3:58=E2=80=AFPM Giuliano Procida <gprocida@google.c=
om> wrote:
>
> This results in the -T foo option being ignored in the case there were
> no symbols. I think it would be better, consistent with the
> documentation and expectations, for the file to be produced empty.
>
> This means that just the for loop should be skipped, say by adding the
> condition there with &&.
>
> If you disagree, then please update the documentation to match the new
> behaviour.

Sounds reasonable. If there were users relying on that, then it may be
best to keep the behavior as it was. But up to the maintainers what
would make the most sense here of course (moving Sami to the To:).

Since the commit is in mainline and it seems you already thought about
the solution, I imagine a patch would be welcome.

Thanks!

Cheers,
Miguel
