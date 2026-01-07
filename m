Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8290328B67
	for <linux-modules@vger.kernel.org>; Wed,  7 Jan 2026 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767794403; cv=none; b=Sm4t8ROnMEoDr+EwFN++EcRbYugbqR3GEUVgIEl+to0IydEGvVBVCzYxlYSRIjdpuN+SCTOFCis8U2S4qPFQbxA2+7i3uwjqGH7MXuh3duHTovkOgs8ikD2oZCN1mHZr76Mp9VUAmxVe/WyFh8NDn/dUDcECGMSc3vuZ5vE7wng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767794403; c=relaxed/simple;
	bh=TrNOZ6HpS6QFZtTMyoW+Wf0WTeQJHYUhQM0CiAPXgec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYs4ocE+Ick6nK8vjtc14yO8MC8VO5CAAbu/+4lp1Ek/ptZ37qbTrUqE9y8YMJqgz0vh2rJ3DiZoBTtRTIQl//LHJC0u66I6V9y1sJruiK/YRZ/g2uj4njjG41uZiYvq5MI/S3SVyjOwe0+l7jVhT7mysWy72ezdFlY9IK0304k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=f+VOfcMf; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="f+VOfcMf"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5959187c5a9so1953906e87.1
        for <linux-modules@vger.kernel.org>; Wed, 07 Jan 2026 06:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767794400; x=1768399200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nLSyDph51skBA6xT8p5KzKOmafgGpX1ihcuW8dmXLk=;
        b=f+VOfcMfdCYhA4DRixHaJ/P15g3Y+KhLXx9aXPu0cr+N4b534DUGr09Z6gKLXdsC5B
         0a+2vyO6aiy6w7zEhFDc0jAc5KHerMNeIxmiO3cMvitGWz0ddPyOf9wBZdLcDYCXJeg8
         YS9buXZxlF5Kplxxt7bOQBeQTqkKc3hZWLV8SAlVfER7s1uAPT1Yo3ox/ewtnML7nrvd
         gzV8K7W4n91mw9VXj/1YB5y9oLjE2ZkG2t0kZWaYCnMa5JlPYcTNhL9IyYQwRk9bLiBP
         dCxJEtBUE2gfz9djpE/USDBD/9BGEMZDwTCuSOUVrYuFX8/l7D6IMhgmFQN49ukvMD3x
         +BwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767794400; x=1768399200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6nLSyDph51skBA6xT8p5KzKOmafgGpX1ihcuW8dmXLk=;
        b=k5HpxfYujqj/cMa/Us2beUUIzsxg2GMZpWSt+GZhE/BqkBJvTozMpSVizskSYpw1uV
         G/wd91Q0d4UuFrXKowBqFRcjNqH3IHEGKem9EUUYpZQoc/nEwVK6EMG6BxsBpzq+zPQh
         BFQOnIpWRMIjTuuGkKiaNhcp0Rhu8abENdBh/kl6LxCIen7Z02y2Ieio3Yx/uDWfNcLj
         001Ecbjo/SLjerRcSbjTGShfTl0DmbhFs3e3MYo88Pe/PjDhNKn+c+hVebf6f3I404Zk
         8NgL/Z4IXjaK61VkaBae8iPFw9IG26KeHkJWnDHWYJuHrsshDOPy7PHnW1h27hTEVMN7
         hmiw==
X-Forwarded-Encrypted: i=1; AJvYcCWV0cfQngb3qqbeG/Q04nqEetRJAMAuIdZdfgikO6eOgJGMUReU11pPypHiHb8hRY/pGhQ46Lt/c5dgMcSg@vger.kernel.org
X-Gm-Message-State: AOJu0YybGisMnA9GvbvS3yB69LbBrVqmcbDqo4kwFkI0OoeDx6lA/tmy
	ThjRo735aVwm8csk80eGq0I4SRgrjubJr3/vqyrk+jfj6leGBE5ELj33/kor0cd1AFL3zr1wIzK
	AYAtSqblimb1IQUL2r3/w/V0ljCPF/MpdAGNO4iB0QQ==
X-Gm-Gg: AY/fxX4Iv9k4w/mi8cMJ89rYH4Q/YDXFBcLOvdwcnoDVptnF8YV9cYiV3TSdk8fA1WR
	6grI4vnDCM8pc9iS3x5M4ZkSBp+Mp5Rdw82dTs4jnwvpCOJq6dYT/KeS1jexUWZHreys4qHir1x
	TUXbqe+3CBED71oiZ/M1W96+9QTV60YX++pmA7ENSY2fjrLkIo/h4QAgZPC/i5ycSb9kl95wYbo
	XweDEUp2kUzz6OMOBZ+g5bqKG0qaVBfctXqnYjs/MkBpJNWxcoJ78+egen+6mzCMbL+dzo1aGdf
	LpFA0DaKBiooqQ==
X-Google-Smtp-Source: AGHT+IEHYfi0dlZf2YFiZv8lqVOnOsYUzA5eTbLyIL6UM3u5CJcQUUMyunitfw+FxpRXUzE0Q5OSUPDvSRXxOsia/QM=
X-Received: by 2002:a05:6512:39cf:b0:59a:1bdf:c437 with SMTP id
 2adb3069b0e04-59b6ef094bdmr951885e87.11.1767794399867; Wed, 07 Jan 2026
 05:59:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105152145.1801972-1-dhowells@redhat.com> <20260105152145.1801972-3-dhowells@redhat.com>
 <CALrw=nFj9OEsREJ8Kxox3U6N8y=e00ZawxEkCPOb5-6_k=7+nQ@mail.gmail.com> <2366240.1767794004@warthog.procyon.org.uk>
In-Reply-To: <2366240.1767794004@warthog.procyon.org.uk>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 7 Jan 2026 13:59:48 +0000
X-Gm-Features: AQt7F2plMc4I4NtJi5fV1xvI4Yfd3PKBoxKSGD1WG5sCKDWXR-Ox669ezz_yn9M
Message-ID: <CALrw=nEmPVNRvno2=48d5k+txRv=CKKezsKt5YunoKHUaNhGmQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/8] pkcs7: Allow the signing algo to calculate the
 digest itself
To: David Howells <dhowells@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Eric Biggers <ebiggers@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>, Stephan Mueller <smueller@chronox.de>, 
	linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 1:53=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
>
> Ignat Korchagin <ignat@cloudflare.com> wrote:
>
> > > +                       ret =3D -ENOMEM;
> > > +                       sig->digest =3D kmalloc(umax(sinfo->authattrs=
_len, sig->digest_size),
> > > +                                             GFP_KERNEL);
> >
> > Can we refactor this so we allocate the right size from the start.
>
> The problem is that we don't know the right size until we've tried parsin=
g it.
>
> > Alternatively, should we just unconditionally use this approach
> > "overallocating" some times?
>
> In some ways, what I'd rather do is push the hash calculation down into t=
he
> crypto/ layer for all public key algos.

Probably better indeed

> Also, we probably don't actually need to copy the authattrs, just retain =
a
> pointer into the source buffer and the length since we don't intend to ke=
ep
> the digest around beyond the verification procedure.  So I might be able =
to
> get away with just a flag saying I don't need to free it.
>
> However, there's an intermediate hash if there are authattrs, so I will n=
eed
> to store that somewhere - though that could be allocated on demand.
>
> David
>

Ignat
