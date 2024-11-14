Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883F318A931;
	Thu, 14 Nov 2024 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731612118; cv=none; b=fN6g09vM9/I4EDj3GSKF4iFzx/6OyZ25hMXgur17yP5jAjZRn/q3g0apzS6Y1H7eJbEV9i5c9UFuMSAzKA2HiKGLvmJQa45Pv52J3hgdG4BPmKRHA8tSfedKvQQJ8N2n3asyARoEJfW4DsEqQQyRM/ts0tpOGYKDQBc7KLqTSc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731612118; c=relaxed/simple;
	bh=XC8iiyJApXLhMiu+6nbcK2VG/DyAHPKlbnOAVlbKong=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aH7R561HjaEklOisp6PeXImxQ5TkflVP2Cgbq3RX5HBXjOX63WOECuF7WA+ptdcAD2XlEmLaTNzV8zpvabHhTwB0lCBwnzgOE7w8CbNzOax8kWYAezBVa3lyC6DceiYGnOT+j0tauAhsmU11pGCzQuTik8tXa0Ogk+W27xzZ534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LE3y9yze; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE3y9yze"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83aaa5513feso5267339f.0;
        Thu, 14 Nov 2024 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731612115; x=1732216915; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XC8iiyJApXLhMiu+6nbcK2VG/DyAHPKlbnOAVlbKong=;
        b=LE3y9yzehpruVpgATBitEOhyQzYxvfaAhNSzuu9gLXsQP2brgp6cYP60aGoHj9YKmR
         tV9T6/LtfhALCn7zBN9uFyqksB8EfWoCfDZOB21XMReAJInnEDUAzXLHvgr/GlQQXECh
         3Dx9s6MF5GrZykhxQpeAIxD0OhaIRz2PvKunG/xB/dReukFW/2dSmlAkaEQaxp++6sKx
         rnS63Qjnbc+QaQpsFtNEIMXW6yXjjoLkqVv/LQHHKNlNRxMCWQ/PI6g3z8sBpkOgQFmD
         sMaHZKIvAsM0FARfJyv8aa/WzpVVVmzmXM0O+xO3Td7JdENFaafN1s1a9abGs8oWQpIk
         ljFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731612115; x=1732216915;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XC8iiyJApXLhMiu+6nbcK2VG/DyAHPKlbnOAVlbKong=;
        b=VluBVHFdcU4E4tArTdHF3TaRL3R0PqC9vVQCf7HSZizaFMzT0iYXUDu1f3uGyjLGc1
         DUvkCIRkHm1kJd8pDH0TLI1D7GUiKQDluvi3pKVGFt9DGN3fOvXeXBZ9lAJiHJ3sEe8y
         Ci3aVXEOoKPS+9nldpsnQfYY2aWhgBSCpSEObrEbKWYO76dmvvm1d1PF3Chpk8ju0nok
         aGv55TGPaGnsZH22Rfy6q/hFZ1Aqp4ywzijd/q1umiKFcvwBnhRHQAZj6TN1EDgb3WIf
         ETpYG9kXzBsqgpM9TjFGedsI+O+xwWWLUxM7estlt9HNd9tTomsZm5UGLJD4Ghd5ZDyd
         CDjw==
X-Forwarded-Encrypted: i=1; AJvYcCVHpDI5bIYH4VLbVMMpEDMqKw5wzsVYUJPyavS/SWoYc9Bi2zImzsicykGI7qi1JnyqQLtQza9ur+GrMsc=@vger.kernel.org, AJvYcCX0jYWrYJ+MGRWhC24G/Ek8FkBLI3rdVve18HmQjC3HWS8kQ0T2Y0JuUFgRL8uyaf2qu1Uqe1qOrxvC4Ry6hA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Gg5gt+KnsgYdZowDGZoqhnFulf/XSh6qkZe5R49H8mzKhLul
	NRec6EtiGDsVdlg9hXdEBWSJ62fLiOa5h5dEGnmQlRrMDt6LUHOv
X-Gm-Gg: ASbGnct4fv9X0etDKbFH+s2D/vhmnvToZS6gU8jOUkvvsg7QlWHihJMtCwlfP+ycqnT
	yxG8puQuZERV/KUzaIoRwO/18G+ZcUOdzoSCOT0Y5ZER3Exh29i2ahXqzWfd7fl2VO8ZH3o+e+4
	gmDBQwXuG93fFpCs/3B/zdZEeXFq4MJdj5c66zO1dHKPVNWVe5fgcf8zhD8pRfbNT7mEaLzF7ov
	uoD4Km1YYXRG4wk81fB8kUGSSf8bJKA+E6Nhi4kS6aFUA==
X-Google-Smtp-Source: AGHT+IHrPCVp3BqrOxz4DodhPkJU8yaSoAS/rM608NSQx/ZYTsigWVXeEh5GgkGmq7ue0o0/KD5gYg==
X-Received: by 2002:a05:6602:160e:b0:83a:addb:7196 with SMTP id ca18e2360f4ac-83e6c084c72mr9613139f.1.1731612115395;
        Thu, 14 Nov 2024 11:21:55 -0800 (PST)
Received: from kf-ir16 ([2607:fb91:759:8d6:15e3:d4fb:c375:8d87])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83e606295e0sm40942939f.31.2024.11.14.11.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:21:54 -0800 (PST)
Date: Thu, 14 Nov 2024 13:21:41 -0600
From: Aaron Rainbolt <arraybolt3@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Luis
 Chamberlain <mcgrof@kernel.org>, Werner Sembach <wse@tuxedocomputers.com>,
 tux@tuxedocomputers.com, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Thorsten
 Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 2/2] module: Block modules by Tuxedo from accessing GPL
 symbols
Message-ID: <20241114131843.0df6a5a2@kf-ir16>
In-Reply-To: <ZzYgrc4cNqlhezCs@infradead.org>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <20241114103133.547032-6-ukleinek@kernel.org>
 <ZzYgrc4cNqlhezCs@infradead.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LDAvI8DcqDGDjEFs_KnDAzy";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/LDAvI8DcqDGDjEFs_KnDAzy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Nov 2024 08:09:17 -0800
Christoph Hellwig <hch@infradead.org> wrote:

> Thanks for doing this!
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>

(Just as a heads-up, I have no affiliation with Tuxedo. Also, I've
tried to tone down my email a bit, but I am pretty upset after looking
at this, and really, *really* do not want to use a kernel that has this
patch set merged. Also, I'm speaking strictly in my own capacity here.)

I might be misunderstanding things here, but does this patch set
prevent end-users from compiling and using Tuxedo's modules themselves
if they want to? AIUI, it's fine to distribute GPLv3 code that is
intended to link against GPLv2 code as long as you don't distribute the
binary you get after compiling and linking. It looks to me like this
patch will prevent users from compiling Tuxedo's modules for personal
use on their own systems though. I personally dislike that for ethical
reasons - I should be able to use whatever code I legally obtain on my
system, and I don't like my use of Linux being wielded against another
open-source project by requiring them to relicense their code or no one
will be able to use their modules.

--
Aaron
Ubuntu Developer
Launchpad: https://launchpad.net/~arraybolt3
Matrix: @arraybolt3:ubuntu.com
Github: https://github.com/ArrayBolt3
Mastodon: @arraybolt3@theres.life

--Sig_/LDAvI8DcqDGDjEFs_KnDAzy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEudh48PFXwyPDa0wGpwkWDXPHkQkFAmc2TcUACgkQpwkWDXPH
kQnvPhAAkJ/SnCu1XlXng/V15hGKPgrQDfruBdbyMwqe6lZBW4oiE1vWqLpXXIwa
CqqwD5yXDC90sWqDNwZVwjmo/f2rpXjAQ+JhJgOLyEBDsetyiovFoAupmScPttcb
PM9I0PjXbafx560cn/c8/t8OH0J6AFkKL848E/EQumUUXEG+a0pdGheN/xGsuzpx
E/g1iv7Cv6VF5qs/xnQ32dwJM7Sw4qHdjTetbYWgyq+mWBiR+4r3iuknvMlRhLbc
9WNlaSJ2CtC6Qy+TsJm/uC0Ob84/xxHFBpMc7QJLp2cqYV5X9rbIzcgHxgeaYL1C
aeRP6mx9dG7FNdkukxttI1OCKebc6to2ySNRcfznuH/JnGf4YS+dYcwGiGteaI12
ZQleX9P5aG88Y+epEFXbYtYcV3MAJ1UPv0k3uT9F46YAe8f9jz4LmEMzqN3tRHGW
vmug+iq4PA/iqN5cBOgGpqWugg81rpJaS9Vi2q0qowYJsU63WypEb6BwsNNbPScw
S+e+aTRzCFzp2tftPHs7hi9E9wLqvA0XzmnG3jZqq0abiTXkGo232BVT2kcTXGTT
qoMhbAtVPcIvIgZJ3mQEzS8rsZcwPREp/jEamkMg8kCneaPOS754PC8zVGwVZnQU
kgf2/P1tcYZxMGyUB01oQthpZyoU5azOivNqdcGpW+FJWNzE5TE=
=S1nN
-----END PGP SIGNATURE-----

--Sig_/LDAvI8DcqDGDjEFs_KnDAzy--
