Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D370C359701
	for <linux-modules@vger.kernel.org>; Wed, 21 Jan 2026 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983126; cv=pass; b=THaF0Uqrk0RfC/LGDf4dcdCYqO9WukPRd+tZwWJHgorcOROIj6QjCFS9/HnqoDRaGgDebkoATv4x0uQvnJGSp/fMdHhIdmzjGfdNUC/aB8BXgEowRKkstM5BoZZ6gdog0pJ79vK2QBex4siT/QmUGUJymo+rgLKRVJXgKKRk21Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983126; c=relaxed/simple;
	bh=NcPcHijqCx7t3zPi3d2W+9QUjcbq1aI+GVwFFFeFbq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpExtbEDMocdfckdts4UtNdv15IPNkkJNWcTrrKa7B7RW5IMqBqVwXDv6s+BHngWebHJBGoEw/7j/msQAGn+KjGe6SCZZCa33FBxrOwow1Y/pCJYnnn9rQz1QzWZZWSjNZ2tD41kQckLSeX4mKceBtNKgMRbiUg2fYfuXWb0PPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZdVhO9OQ; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZdVhO9OQ"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59b76844f89so6102758e87.1
        for <linux-modules@vger.kernel.org>; Wed, 21 Jan 2026 00:12:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768983123; cv=none;
        d=google.com; s=arc-20240605;
        b=TeNbi3BRNISyAQ3vA0Fn5lFWCkYS6mbL86cqiMvA2tJiWj22lNZQWQCq4zJ7RsMb3u
         dEL0gZU1PLdnhT+KFqJQhsPmrJYMoP4MjZCMZaqTIw2cS/ZPG6IFmtioKA3sx9wy3Zji
         pLzuJR5uAyofPIZbZJHFg4lcHUapNAZ84/GLksbWWIHWCmHDRACpubdFtCSyj1t9AxML
         SgDXK+aTPvOi5YMyGJp0S65mlZSYv9HhoLY9WF2GyeLucrttN529Gc9TVDCeyoTA7Jh6
         DDeOFjGUBEluR435fMxro1soptc338mrENZDU8s5PVBq/db8ziTFJpEEkW9WVM2JHjK4
         ODYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7fXCBugNbG8UpDEmEOBmP8ra4Bif5NvnVW2PAsTZKdM=;
        fh=FW/mR3lPXFS4crxqEY7w24qCsi7FHYtL9r6EaOzoRe0=;
        b=OwR37kn/3jjKRt0jrwCKXZe3jBAkEO7VrVfCrxuhJKIQr5esE+ChnMZCLyINaB7bSt
         klqC56ZmFaeM7KYq8uBtG3nHyk4K29EvnVPpCM8nqFJ0zL7vimpBkyrnO0CkXHvgzsgz
         gDLMHY2sWzvQ5n//pS7yyNFs9GTyAqudNBH8toKPTf1EYL4OGlhurOF/+YH8XhT+vNaK
         U3+eHvI33go7d+wtDuO+1heNQcYlzs7yMoFB7fAb19LtnHWywh7ljZoDCW5z1hCkgI25
         wyWgpXgwxhvHeV1b2kkbtsilYb1/hpOXHVrk/kAhDPadONCz62Zda7MnmgUmcHobFaBX
         5Exg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768983123; x=1769587923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fXCBugNbG8UpDEmEOBmP8ra4Bif5NvnVW2PAsTZKdM=;
        b=ZdVhO9OQUc0wiKmBFlmD8k8TUGqsMUSipCPOvNPYADDKeiTc6sa99VIgDi2FHKkZ/U
         Awkh2QH5dLTlkwim2U0tmBzoezXZIt391oDRSB8q2+eF46TUcVLaE5lyHBezcI0rGyGX
         3gRH2QPt/ybJ8oj79BkHF/V87RMdLtTZx/m3mQPAaxSwc3316N9I+ufcZQa/FAOHBKrx
         KkDqoxXHMtVYME+lgECQbFbuNoTnZztld4VI8sgtKWgUzM01s/I6jl0t28uH8S7NCGDj
         cKdh0oboHRLvXVG6ac6s4kUaodyOt0hTQG5dVDS3n4mumRZ3/0/OgbiW1TKMj8abHGzo
         z98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768983123; x=1769587923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7fXCBugNbG8UpDEmEOBmP8ra4Bif5NvnVW2PAsTZKdM=;
        b=a0e8xHYwCTepO3Qy1omy/QCuWr3PshLv+0MONlCuh+vLUPcl7ja9VQ+ha7KaIAGe3N
         nSHvD7xVwQC4bFnIkL3s3HMJxzgKwg9CceglZaoQw3s9fkUXimt/IN/hVZBnDBRWnnLK
         qQFqpcy2kDU3HzBvz86vMel1Z7FxdgJDr2sa0t5swdjlFX31z/5mgpFB0gPLdNu4CvK8
         /ogxl4bBFoxNRHvcdfbk6CcsxC35+VHWXPZmQhZn0hZCG9h+bprAFW3gSuJ8TRvV3z2o
         nBrxD4H1YISM8c/R8JDfSomWiejzznJS1Q9G85+HQHRdeQrkHp/HDDH5HPa/gYEiV4KZ
         NVoA==
X-Forwarded-Encrypted: i=1; AJvYcCWnEsiMTrFLbyRzQL5B0WuAoMm4zQcS5SxfuapgXu84dlVA28lWif+xC/Dg+cpPHg/fNTUgzE8p18aphhpK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8IlT/BKHn3euyVjP61KSVOfj6uezAE+MT8WU0YN67gLxrde7X
	cmrGLg5t8HDdMwVV6EpKQttgSL5ploPAMbHAAEnjBplih4arNjbxzJD+CifJh+VpsmXCneK9oLu
	14RHl1CCWRF/d7XC4K2/T8fXOIisCCdrT/cxP3BQySWi/wfMWBgPea19BIA==
X-Gm-Gg: AZuq6aIJjaILxkDdm0zWK0F0augwrR1yxbHpCVWSPlb+IynWoOLDGt7nmagCXU4RbjV
	5aTfe54WVspTgnZfDIDBjbXCKsOGrCV+JWSGT2+DelrcC4JeXGmdIEg9xxd2Cz1M916XSTDV6DN
	1LfmbOK/eBGTlZ2RmpkKuYj1i7kk0OrYTWx738N5AYsfiSMouTsw7WqHvI0y5ZuQyqPZ6Z9aXfC
	W5WElIslxjxTAZOEGNcZpW8RwJN2hgjDACNQiFM6TvT8JK4eQNoXbbbrUY+aOpW+FmmNbOraPDB
	LMVZtjzZFP4EFIgXcUR/IdALXlIW
X-Received: by 2002:a05:6512:138f:b0:59a:183c:4863 with SMTP id
 2adb3069b0e04-59baeeb1d8cmr5444078e87.8.1768983122854; Wed, 21 Jan 2026
 00:12:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120224108.GC6191@quark> <20260120145103.1176337-1-dhowells@redhat.com>
 <20260120145103.1176337-8-dhowells@redhat.com> <1416722.1768950957@warthog.procyon.org.uk>
 <20260120233617.GA10653@quark>
In-Reply-To: <20260120233617.GA10653@quark>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 21 Jan 2026 08:11:51 +0000
X-Gm-Features: AZwV_QiRbs3OO4qM3uwaFGGNt_nfptg6k5-iiQUJvwUGMqgS-PCFW0-TncfBeF8
Message-ID: <CALrw=nGHEf3zT0yb2ybpH58ah4dT4_H11TseDL7Fs-w7RBY6hQ@mail.gmail.com>
Subject: Re: [PATCH v13 07/12] crypto: Add RSASSA-PSS support
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>, Stephan Mueller <smueller@chronox.de>, 
	linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tadeusz Struk <tadeusz.struk@intel.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 11:36=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> On Tue, Jan 20, 2026 at 11:15:57PM +0000, David Howells wrote:
> > Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > > As I mentioned in another reply, error-prone string parsing isn't a
> > > great choice.  C has native support for function parameters.
> >
> > But is constrained that it has to work with KEYCTL_PKEY_VERIFY's info
> > parameter.
>
> The cover letter of this patchset summarizes it as "These patches add
> ML-DSA module signing and RSASSA-PSS module signing."  Adding
> KEYCTL_PKEY_VERIFY support for these algorithms would be a significant
> new UAPI feature that would need its own justification and its own
> documentation and test updates.
>
> However, it was established pretty clearly in past discussions that
> KEYCTL_PKEY_* are a mistake and basically exist only for backwards
> compatibility with iwd.

I disagree that it was "established". It is some folks opinion here,
but I find it quite useful and hope it would be actually extended by
good algorithm support.

> So I don't understand why you're advocating for adding new features to
> them.
>
> - Eric
