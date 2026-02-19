Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC18261B9C
	for <linux-modules@vger.kernel.org>; Thu, 19 Feb 2026 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771519317; cv=pass; b=gMaAQeyOK3Sg40pVz7b1DBt78SZVG7pNgHo35NPHOj+de8i1mc3SYxxpXMOZwXeGXTzY0x5hsGS/yvgiYB4ilCjVIiUycrUBo0oZjxuzroA8g6E1p794IM/yFhGZhu7uEW88MYJI2u37nb9ZefBd//FBoz9jAND98flLooxmblk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771519317; c=relaxed/simple;
	bh=NF77huHe5rkrdzkBygha6Y5vKcZWFw7n1c1mg2d7OWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qvii5Cx4imKdN+YVSV4uVzSDdaOhU/BRiN/N17Buok/J8mRjCE17ZkneAeMhm3rPCwKNn0CCiyxximti1IprwjPuLFfwK5tvdpMv+HN+a3B8LOPZJMXE12l12ljnoV7WPThfGN6JK9a9jQJQJQkjJP6pEqY9Xk2mPTYXn8sCCIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WgASqz3E; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WgASqz3E"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65821afe680so10971a12.1
        for <linux-modules@vger.kernel.org>; Thu, 19 Feb 2026 08:41:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771519313; cv=none;
        d=google.com; s=arc-20240605;
        b=IPxqpBXAFBo73g0pnfhhw6QW6hp67eOyT7veWkTpbQVpuZL87QeQHWEZAgqtcDc29/
         EbijIHFpt7tI1edvDoOcbekIPU5UxXlv+SxJND2Lt5wI/pd+18S+j/lTHqC/seC6I9w7
         anLHd2U2K1/IVSi/tw4bxSqEizL9t4Y1zhLqQGck8FjBD59l0wAXJu2/+AeErDok7v+Y
         gh5pWw4tdWKRbTqFqDqCVR1SWLVcsX1VGx9kRmXGowyPW/C5sa+yYavhEl4pl3gAax0J
         Wo2fk0wEuJZKZVK+sQSH1BhtCOtQYA6iv6UxYoMhthiT1myXyMprdoroXh2IVDzdl9BK
         i2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hf1LaDkijcdD11OckoGjxI5yaxmlZ2c5i9FpCf0YHmA=;
        fh=nJ6ZI6tIULog0BDVyPqx5MgKJku2861e8s0KNkPmeRA=;
        b=XvYzeGVYRypf263lHLfiHbns+olMsGW+qB+00KL8bPlu7892qumbYkr+T8qN38m/18
         NESmDK2UwLUP4f2H2i+eZg11bCNFyjGIj0qd9HhiJSuLDqqrItxdasmjr5jQfkW2q+QQ
         f0gFEyIfXzQMfCnTVyx5iUN21ve6yefQ338J4SCfHSqyc9D/uuucF/03hasmEFcCCDsh
         IHhb8jBImWARzC5ziEHhPuWviXSNe/japKe1WaX3k0yIu2tgEquDpgcrK8eYa1pvO7JI
         KD9GcuE1BCpRVe3ca6Gjx6Z6MlCThsu4Qz9mjB7PHzY7D5gWF6Juemy3nrdmr1P0o2Xc
         xxag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771519313; x=1772124113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hf1LaDkijcdD11OckoGjxI5yaxmlZ2c5i9FpCf0YHmA=;
        b=WgASqz3EEgNugzn16VoiaRhlKMLATDAmlCWDnGVNWPECEQayGXla8VtuyMa6FOuXag
         9Wx1oiZduzyTddZpqsPqBHKqVzY5a5E2oaLJKtMcuugKLctPPwET9BOCHOv5bgAsaNcW
         l3ClsdAOQiQx9wmqKUDgw0mgsRCxUo+CS+7+eorjjCYMS8DCrLl+76h8M8P/eqde/mIf
         oWVo+ekXKlqwu6oeAarw2pTksw2tNgehl9a2xWb7mi+vbvZGo94KGWBSfHk6cG3JJEL6
         RsP7kxfJ1vtHEO14c308mLklqNs68N1mwSAGSGhKSMi5xUGNf9HAjDhLnfG5cLW/t1AP
         lK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771519313; x=1772124113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hf1LaDkijcdD11OckoGjxI5yaxmlZ2c5i9FpCf0YHmA=;
        b=lRxp63y7qIhrtkwb9wg8MNbV6xRk08KfbcUS1fb4JMQmvVSTNElFr5M3WAHygHj3k2
         HgqE3Nu1NyesR/kVjKTdHD59xPq9HQRXnfjxKm45If6XtuAc4PjlZfv1BxW6JPcQIOO+
         UbbH5AyobXhCADQcoHea1MsDvNpVXq5fDw2GG57TJGfIWuaB8TagLVVVEdpJMBn7xDnK
         WirZ8UhGqsAuLf8xhE23+hpDl9i5JjFD68QxVoVZmx/eC5qrWTH2tWc0+yX+e0F43cKr
         5/Jo0m84jYbAGhLPDXBKYuBrdOeUu6ipo1WMZXjZ3fgSMu1o0SqTz6q33MWa9BdfS//T
         /7pA==
X-Forwarded-Encrypted: i=1; AJvYcCUHOZUt2OXl/rjUeN0zLZzGDYLHcw9qTk6HXEgkvtHmN6kbFAahhKn1DSOj+bzRdeM4+ammKkm1lz9rMgj+@vger.kernel.org
X-Gm-Message-State: AOJu0YyOrvVY6EUd0bmBPV2hxvyqpxI+fbh1rh14nR7T4RB++8N83PmT
	jEXuREbzCkjA1OjVoZ2a+pxiw24ZDFlJM0WgVyrGJ70bVdmEHcA/sme351jKoRb0bJcGSxTccX7
	mJIRUSz9jymlYlYDoadIV0eFTbNPDqmSAuuWsBx6P
X-Gm-Gg: AZuq6aLwH/t3inZIclbqiIBCWUBPqXcVU1PqLe1M6T7AEp5de398cOmrZIYMC3Ir72Q
	6pH2yPFRGy5jWP4XDb0n+22Y1oSjgFvWsKinMSwlokVC1pZycA1JxO1Z3GNc3ZQ4YNagZROFt2w
	sMl/kgAhYEmfwJsAC0ePt0TpqgAplyxh0pmOPGwdVopsLjGc6+N9UjgDjbUQOi9FkdYjANaF7ZK
	LESqsETe97eTMgdjXSr3XWvuqYxpV2yX9+KDtWLEFGK8JBLJHeq7F2amKgUlmcCdcepg3UqCadG
	M0+c
X-Received: by 2002:aa7:d3cb:0:b0:659:477f:1b2e with SMTP id
 4fb4d7f45d1cf-65e4b20063fmr29312a12.1.1771519312806; Thu, 19 Feb 2026
 08:41:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219-fix-builtin-strlen-v1-1-3ec3efc0cda7@samsung.com>
In-Reply-To: <20260219-fix-builtin-strlen-v1-1-3ec3efc0cda7@samsung.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 19 Feb 2026 08:41:16 -0800
X-Gm-Features: AaiRm50ztl1YAKf4o4yq5SO0KUP9Egu2t60RMIfKV9RIEvHT-22XzAxle8jkPbs
Message-ID: <CABCJKuf8jh_yxQcR1=uMeuWOueXyoM5=L-QpTuBenRi_MZK_Gg@mail.gmail.com>
Subject: Re: [PATCH] builtin: mark __builtin_strlen() as integer constant expression
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Chris Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, 
	Aaron Tomlin <atomlin@atomlin.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Thu, Feb 19, 2026 at 8:11=E2=80=AFAM Daniel Gomez <da.gomez@kernel.org> =
wrote:
>
> From: Daniel Gomez <da.gomez@samsung.com>
>
> Commit ae83f3b72621 ("module: Add compile-time check for embedded
> NUL characters") in the Linux kernel added static assert checks for
> __builtin_strlen() inside MODULE_INFO() macros. But sparse does not mark
> the result as CEF_SET_ICE during evaluation, making these assertions
> fail with:
>
>     error: static assertion failed: "MODULE_INFO(...) contains embedded
>     NUL byte"
>
> Fix by marking __builtin_strlen() as an integer constant expression at
> eval time. This matches other builtins like __builtin_constant_p() or
> __builtin_safe_p().
>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
> Discussion:
> https://lore.kernel.org/all/aTc9s210am0YqMV4@agluck-desk3/

It looks like Al had a more complete fix for this issue, but I guess
it never ended up in the sparse repo?

https://lore.kernel.org/all/aUV7kyjxlijuy5sC@agluck-desk3/

Sami
