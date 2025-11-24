Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E948314D17
	for <linux-modules@vger.kernel.org>; Mon, 24 Nov 2025 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007594; cv=none; b=ISahXQTLCISbyCmqYFHuzOdkL0CQf/rp1u6BefUlfkt/G+P/640aF9/54np3os087wtO6JhOxe1o0lzPKkJC5e2erHj4cQwoXW4pcVG7VhhBm4jYRJL3uJTh5RGB/fd6KajVfknieQRn/6D1hQEdtzpY14ze9cE1TlHfw1FKERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007594; c=relaxed/simple;
	bh=4jyjA348Uccis+uPWmeHP3/Cr7AKyDETtMz1PjRInZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iV/+uCPIxB4iMDoYirTSU442ZNePaYx+S53ZJB8n1LhQqFf0ZPC/eDinTHsSYHq6dojxjpkC1QpLw5vL1pOiA9mETCw2YhFnFP+cKVaLb6/byscBoE4rgs/fkV13mJovrBLAaaC6Ed8lY2kKqQ+1zfjm63Cxq2+WgIFxFYVee3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=bJfgEjmE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bJfgEjmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685CBC4CEF1
	for <linux-modules@vger.kernel.org>; Mon, 24 Nov 2025 18:06:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bJfgEjmE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1764007590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zi2tifdlnm4pilxLA5hX4iEYZ93yOyBEU+BXbr3Wug0=;
	b=bJfgEjmETChnLppoIv6NT9bWBm3wI4/mCbWKrAymfn1VES+mbp32JL97LFvDxqmeueLv4O
	FFCaD69mAbNsuPwF201bdzYtwP4UDgBUR9ztYOjJUFiFK/o354Jg+YhauFgxFBxVQdw4eo
	yqdJx45EXqfxaQG7IeR79zPkIMAkrHU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cc2fc63f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-modules@vger.kernel.org>;
	Mon, 24 Nov 2025 18:06:29 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c6cc44ff62so3094022a34.3
        for <linux-modules@vger.kernel.org>; Mon, 24 Nov 2025 10:06:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV26ANaALyNEAMj+4DhYykSCEZGfyEd8qbpF2jiHax3+gtO3gR6ZZepxG9vQFfE4WYFWZZDutxzjZOy6UIH@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn1G2KtpYz7Bplwm/7eQT1U5b0BzAdLUouj4aYdIQpmiMUvEar
	v9KKMEcjQEzLWDeig/Hvd6buYTVgsyycqnzA4RAEextQ01PXz/+dr49YxYyyCdTbrGCfqdlXAce
	REFnzDKomrrySeDtkiinxYvBhtbYZAEA=
X-Google-Smtp-Source: AGHT+IG9yFbAB9mPY1ah1S5DbEkyC1/NUapcR00z5eBy/hk+C134+OhB4O0SLZVWNpbSJa6pmV5YrLb6e0Z4ZggBlyM=
X-Received: by 2002:a05:6830:2644:b0:78a:8b0d:cd54 with SMTP id
 46e09a7af769-7c798cfe6a7mr7062422a34.34.1764007587801; Mon, 24 Nov 2025
 10:06:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120104439.2620205-6-dhowells@redhat.com> <20251120104439.2620205-1-dhowells@redhat.com>
 <3374841.1763975577@warthog.procyon.org.uk> <20251124164914.GA6186@sol> <3647621.1764005088@warthog.procyon.org.uk>
In-Reply-To: <3647621.1764005088@warthog.procyon.org.uk>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 24 Nov 2025 19:06:20 +0100
X-Gmail-Original-Message-ID: <CAHmME9pPWGKAdm83wKhc3iHCjgZ8gOtZnt=+6x5V6D1prMb2Gw@mail.gmail.com>
X-Gm-Features: AWmQ_blyTgayiMTPgpS1b7DE0B0LOV2Mh4edriTwnBqHPtexJGQ8-Mu5aOF6q1A
Message-ID: <CAHmME9pPWGKAdm83wKhc3iHCjgZ8gOtZnt=+6x5V6D1prMb2Gw@mail.gmail.com>
Subject: Re: [PATCH v10 5/8] crypto: Add ML-DSA crypto_sig support
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Stephan Mueller <smueller@chronox.de>, Lukas Wunner <lukas@wunner.de>, 
	Ignat Korchagin <ignat@cloudflare.com>, linux-crypto@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 6:25=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Eric Biggers <ebiggers@kernel.org> wrote:
>
> > Still not really sure what the point is.  There's only one user of
> > crypto_sig, and it could just call the ML-DSA functions directly.
>
> Is it your aim to kill off the crypto/ dir and all the (old) crypto API?

Probably entirely killing off the old API is going to be fraught
because its abstraction has leaked out to userspace. But to the extent
we can minimize its use over time, I think that's a good thing. Even
for crypto usages that generalize to a few different ciphers of one
variety or another, I think being explicit about which ciphers and
having purpose-built dispatchers is usually a better route.

Jason
