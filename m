Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E331EC01E
	for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718939; cv=none; b=fPBQdpqR4t7lhyNZdxvvDGClUj1a4oiBArPBwkCNgy/wwelSxyaphQsZ4QFlaYetCHpXp6U6kA3GIg+jYbcptEYsa9FvjzaXs5/n86v1AgCYz4rIuYfhNDXfxjhwB8eNwn3gHQ1pZNiHVoWAbD9XL5+uEkvTwYCNxW5J1WEtjVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718939; c=relaxed/simple;
	bh=3d/Fo1of/YfKyUkkfWKIXnvtwqa56eG5DaRlPJ0AG9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugPKQeueGjNf/GZmUDNTvMn/gDOl67vosnF6QAZwBUa8z34hJz+qTIcUQDcIVhZ7ruJ9N+EkC3S4o6mxpI1wYkSM/Z32zAIi8fKUo0ltn0NzqIKo4NQALSTtTgm5UHe1/WfYOVnDZ3a0evnWgbwrU2j3R/UPSpGFu3JZVEfhumo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxyoSDtN; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxyoSDtN"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so229674e87.2
        for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 14:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729718936; x=1730323736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3d/Fo1of/YfKyUkkfWKIXnvtwqa56eG5DaRlPJ0AG9Y=;
        b=VxyoSDtNpOZWoELm405SrlEfqJ52sDBzd2v+BZkpKZx2P4ym/SDeYufY0c6WUAP2oh
         1Z0sAYNqKEU3RHjK1yBg64MChLqQo9lhlvWX6ICJHtBi5RRp2/+xiLgoNIBCgsNWfQul
         i1XrgHdWKi2SV0Enqi70wAgxrcGBJaeUm4q9sm2BOIeCyDhXINz3HzjIf6s4+LWlXzhx
         6JGgF91AA9i5lRk50IS99W+JJcYPSK1DwHcdTkxcdOV4FPHGMOBo6xSsOzLmR5omaLZE
         TVgghQxA1y1nnru3vaeBnj00IVX6Qj+2kvUzN4XWijTGQrQ3LiOiBIZEhmg9mIQhjL1A
         opvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729718936; x=1730323736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3d/Fo1of/YfKyUkkfWKIXnvtwqa56eG5DaRlPJ0AG9Y=;
        b=jp958EOROOiRE8O2nadCTQwiRQsKLeEANxnaJdYYzVNm7szVlq3qWgnXRHN0hw21H5
         DKftBIJYuTn+oUNKXQ7UNgUOL/lqaoPMDovswYcxrTj+vbP8EkRkrI+NUOh3k7pdF5gB
         hgIlD2YpURKrHqmx5S6Q+XWwD4aOdGaE8E9uEpIBPrhRi6XujYOkYGYxbtZGvV8XH4J5
         kCn845O5pbr/lj47yP/vNSioCaFU49nYpsG4FLTOiPPdwvFJCIfGJ641wj+cQ25WU8DI
         rgwoe78faqxHUMybOUvA8HgzQVQW8bidmOKPdTjTfyS2zgGfpTedXGqqkcMBOcOO19oB
         6nLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgAlVhVXf7A+2rPXwfi6ZBTAE/QebYQFqgj5NKYhhnHsIVXaev9BOR+wOQ4mlVD8mjetge00VrGBSkR2ax@vger.kernel.org
X-Gm-Message-State: AOJu0Ywki6sC3ttXN4AuNiClaIT/tBc1zSWrdmEAwJz1RbrHW0Wu5Ht0
	RiHx+FTRVKcezLLaB5v3gkbTfd1TBMZCNX5bPRZqN6GRQdvkJnWkNIpB1v2126tv2+6gxusgGoA
	VEtSeduK/eYkxnL49xIMEjt1h0g0=
X-Google-Smtp-Source: AGHT+IHEiKKwzPVQGLtsxMnbHLGu5lDWDcVNTgLWWB/6G4oiCWmn/MFR1sojt4WWcajgOwrTYILP/YqjHcfsIHXXq98=
X-Received: by 2002:a05:6512:3c8a:b0:539:e761:c21a with SMTP id
 2adb3069b0e04-53b1a35625fmr2027171e87.48.1729718935776; Wed, 23 Oct 2024
 14:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUVTpf+XjDp=Mh0ghuk2tQwkgGd0OMUzK++RBSfhBk4+aQ@mail.gmail.com>
 <mnt2nwayrvsccxfgz3gdotna6i4w5ldi5fiuyyvwovcduacbmw@mihqgpmb3y7t>
In-Reply-To: <mnt2nwayrvsccxfgz3gdotna6i4w5ldi5fiuyyvwovcduacbmw@mihqgpmb3y7t>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 23 Oct 2024 23:28:19 +0200
Message-ID: <CA+icZUXxGVAc4jHjdY4mw8kncNEgwkFt2R+=6So=NG4P7A6Kyg@mail.gmail.com>
Subject: Re: meson: always pass complete path to kmod-symlink.sh
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Emil Velikov <emil.l.velikov@gmail.com>, linux-modules@vger.kernel.org, 
	lucas.de.marchi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 11:25=E2=80=AFPM Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
>
> On Wed, Oct 23, 2024 at 11:07:49PM +0200, Sedat Dilek wrote:
> >Hi Emil,
> >
> >commit 844835cd9a4e5f08e1a3eefb4928c5d769264894 breaks when NO DESTDIR i=
s set:
>
>
> This should fix it: https://github.com/kmod-project/kmod/pull/206
>
> There's an alternative to let meson create the symlink that depends on
> meson 0.61. Maybe we can go straight to that and remove the script.
>
> Lucas De Marchi

Thanks for the fix - works here.

Here I have meson version 1.6.0

BR,
-sed@-
