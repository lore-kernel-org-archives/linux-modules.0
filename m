Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CF62135B2
	for <linux-modules@vger.kernel.org>; Tue, 14 Jan 2025 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894277; cv=none; b=ttM7bMq76lmz9Qa/opeXUp8vktrRjkDaATcuGUASPwXgiwfMq+DpsOJDdP+oyrOCq4oTLZoVyFjf58UppA5DyzdaSAmHa1UQrQ2R0Hqx2rimt8WfK58oJXDZpB/6BJyjfm6ICez7RFet7FLhIwf80CMBQsm/j6gMxSPp5wlvRvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894277; c=relaxed/simple;
	bh=yJYtsZDkIkwsYPIHs8wMil9Sit/8GnVWTYwatLbEb5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjyMUBM+3mZ2H5V7GtOHQgOUeR93mfVTzNyDCszJUi+csJgRx7GMWz/ga0BFp651m94s0+GRJ6ozCaEJseZveuudoyCku0mc2GDDyH7Pk037IeVNEWgbD0hHITj9da3Rtcft17TL+VHzlbRVwautT2P+F0gV5lEnGqXSo+5qQ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mRsQj5Ng; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRsQj5Ng"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3e638e1b4so10968a12.1
        for <linux-modules@vger.kernel.org>; Tue, 14 Jan 2025 14:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736894274; x=1737499074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhewvc0rlvRCgGYWjSq7dUWNB25MtiRnI42ivjzLA6o=;
        b=mRsQj5NgOVs7k7xZitA5Ai18Bhs0YKeguUO1Ad6lJp4dlZFsoVeJUbrs7ouWnYA1cC
         +IVH9n18/wnpqfiTNs7CYm5KFmKDEFg/fNJvrDVsS3JuTIw1ZyhItQUqmVV0UV6bpqjN
         CelCbrzcnVv9SP+Wse2T7QZhL2wjLq2FqjIxahsNXow+Fk1atVeWUjQQCIRrQA8vptTM
         I6vhtSw2Uw+p3bSbqhMwGhDeT19LRxc/rLYJS1A7MIKOfk8TEWyeevhpuYi4fl200g0h
         4BI1GdmD21keA9ihby63veY7MNZnztobI597Gs4DhQuSef7Myrowhtll/AQSJb2JOlmh
         NhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736894274; x=1737499074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhewvc0rlvRCgGYWjSq7dUWNB25MtiRnI42ivjzLA6o=;
        b=eu6rSbXp86zaEKZd3l5I19+w8sr++WK4Un2fImzgkH+89Q9krNeEch7xm2uoMl3hWR
         8imCapqOvtLkd489FWyi7LPvDcrjP4hzBlJfDnqWL51zuN5qHOv+E4pG8Ewdcc4hNxtp
         mSDVCvSk3czD2N/kY1uGCH0cGCXgullg1XQGG7k/AcUhKoBSIouPhctT+3BSDRaEjPtV
         xXb+59fdwCOkokapOpuzFxyjgcYYYOHcgpe3p3wnxOYWVc4Zx6t13wmQub9y91HAnmKy
         jozPhcKrBdj87a5UZ+1X7hmrT5VSAUhoDI6+gzavOQtHp0yw6fMOi5toivQy/AVoahDF
         p+UA==
X-Forwarded-Encrypted: i=1; AJvYcCX0e1ePY26I8Q3RX/STGwcWbaAqNA5iPJejF2T5tYCQn1rEA2+YwsfWzBXVkHSbLY1Y5zrJzJOk/TQekzft@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8c8sAnLDI5jKbGH1E/O+exKJbtNpwkWSt3XDYE6LiTurYivNX
	XHE+QAouRks7WIbaesJ4JG1HHHUvgEywdxcnTh0KM/6Kv8UpHlbWHFtla00VzT8hGhsNXgO0z6G
	O2pR5edPuZRAsgsIZc0gLfMQvYxQ8CDDy1qxK
X-Gm-Gg: ASbGncv/Kp19Vl4XT1kcFMsZDd+RU13rt/PZ7+aIVZxuelFbSIAIkKavPCSH5Wil94P
	HJrD767w41u15iXlEIUK4l/1cbd/r4w5bshp4l8FAhuftdz2/SQqcTUqY7h8SuaXzUA==
X-Google-Smtp-Source: AGHT+IFxV/+LWb7rZqzzpeNq94QSi0/wj2KBwRrfewb1dYDrG51yGVlC8KmFWvSCHqR6B4QImpgficY4mvPq1IsCOjk=
X-Received: by 2002:aa7:cd63:0:b0:5d1:10a4:de9 with SMTP id
 4fb4d7f45d1cf-5da0dd8ba26mr6111a12.7.1736894273479; Tue, 14 Jan 2025 14:37:53
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1665d54c-178f-ff72-e627-776e7c76798b@redhat.com>
In-Reply-To: <1665d54c-178f-ff72-e627-776e7c76798b@redhat.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 14 Jan 2025 22:37:16 +0000
X-Gm-Features: AbW1kvb7q22e-ZCZw2yHynCIbJxCi4YQ7liI9mcSIxSVecdFlHMafWLNe0q15gw
Message-ID: <CABCJKud9RCJzVZ2VuTRoaBavOC9bnyTv_W_-AC3mGOy9AY7dWA@mail.gmail.com>
Subject: Re: Unaligned accesses when loading modules
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikulas,

On Tue, Jan 14, 2025 at 6:07=E2=80=AFPM Mikulas Patocka <mpatocka@redhat.co=
m> wrote:
>
> Hi
>
> On PA-RISC, with the kernel 6.12.9, I get unaligned pointer warnings when
> a module is loaded. The warnings are caused by the fact that the
> .gnu.linkonce.this_module section is not aligned to the appropriate
> boundary. If I dump the module content with "objdump -h configs.ko", I ge=
t
> this. Note that the .gnu.linkonce.this_module has "File off 000042d2" and
> "Algn 2**4".
>
> On x86-64, the same misalignment can be seen, but it doesn't cause
> warnings because unaligned pointers are handled in hardware.
>
> This seems to be a bug in the linker, because when I compile an old kerne=
l
> with a new linker, I also get the misalignment. Do you have an idea how t=
o
> work around this bug?

Does explicitly specifying section alignment in the module linker
script fix this by any chance?

> kernel-6.12.9, binutils from Debian ports:
> [...]
> kernel 6.10, older binutils:

Which exact versions of binutils were used here? I don't see the
alignment issue with binutils 2.42 on either x86_64 or parisc64, so I
assume you're testing with something newer?

$ hppa64-linux-gnu-ld.bfd --version
GNU ld (GNU Binutils for Debian) 2.42.50.20240625

$ hppa64-linux-gnu-objdump -h configs.ko | grep -E '(format|this_module)'
configs.ko:     file format elf64-hppa-linux
 17 .gnu.linkonce.this_module 00000300  0000000000000000
0000000000000000  00005c50  2**4

Sami
