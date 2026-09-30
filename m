Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1497B4BD373
	for <linux-modules@vger.kernel.org>; Wed, 30 Sep 2026 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770441; cv=pass; b=XxP6YaRuYUzWKDGKNz6LTCougfwRGJZRKGldXRukmqWO5AIc/kcY/pDi5orfxutGnKwf2kvGlCHVxLCuye+aB/DQU4Hfdtyey8ws71hNivQuuYBkL2OisN0R5RAjNoXH9fv4nctA2c44PyYE2m/m5YMEbt/wthCS1m+U7nxB3iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770441; c=relaxed/simple;
	bh=2n4+UnejlqYn1u6OpHJx7OaKBKukorY5gDQh8E11BEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnFbV5keBCqUmwvPrFOhY+iGwWrURB9gC21jXjPS+GWqb2ZajqzPuoUCivLL7hJcT34SE14MwYLUJc4sVbbUlKT2vea1GoUzUZA3XN7tP2XiT4CBsCfGvU8SJDxOZri6I/BgUlBaUKP49PH/8pLm/w9bWXEDbk/QJ6Lkf3xBv+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr6HBdvp; arc=pass smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr6HBdvp"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-1431a73fa1eso350889c88.0
        for <linux-modules@vger.kernel.org>; Wed, 30 Sep 2026 05:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790770439; cv=none;
        d=google.com; s=arc-20260327;
        b=hXwjg2A/hPJfPELeF89KQpP6JJRL0BM5dqpHQ0gsj0kboJpcH9oXp8BkxH0UTK8B8N
         c27LIUh7k8paEsnhzgKf86KLuF6TCANyIoelkXuTyMLSHXT8MYxJ4I319NPR6JWe4PcR
         eZixCSovK0lzfpTy+8iG2hWDmDvL++lQqbAepqBvMfNjxlnl/iwdGwJ3yb4CHESWcpH/
         R4GX19bPPmYmG+cfWyBoemVPdJdxM+/QVpXxP8OapNBKWqBRbgz+dkBLLjJ4/cH4yY3C
         j21sGoHkGkAXHVTXUpeIV/xA5gbvP5xFHq71AFdWCpl85pGLP+v0J5zH64hEGNJs+O8R
         5d+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2n4+UnejlqYn1u6OpHJx7OaKBKukorY5gDQh8E11BEI=;
        fh=vDUWHhgE1JQKDqQDJk23uhO1I52cbg3Ypta74XnX24s=;
        b=delL6H40YdYroVEae7sWPI8whF+k9U5tGrKeeQL5n3qnEwMh5QfM9z83ZbcsKSgKgL
         Ydb6ltNep6M2mQo5Sg4GJ89CTYcINNd1APRsOYimzeTb7QAtK9Dbgcf/jnjoqRTYmJM5
         Q4txhjU0ZPTPKMiXZgj/sq/neNIRcnDA6R77wukQBtEfE+w/MyBBoDXQP+Kepdm68lOO
         WRXV9E7gBiB6w7nqMLKvKpmNHgUkedTQAxtf3hOvHm88jyiwJj9AFYVCNX0ChrDYJyCQ
         J47SSxYI1rPI4WOn0CNl/855Ikg+KONUzJ/Ef+LzphrmKgSOncY0O+N9VMg0dOI/1EKJ
         Y9Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790770439; x=1791375239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2n4+UnejlqYn1u6OpHJx7OaKBKukorY5gDQh8E11BEI=;
        b=Lr6HBdvpcK5gG3UJ90OoWJqwkSP6ZlqHmdnYLL+cfa8QgrsMSWUTgBdya7bqYL/BE+
         TL0+0tKyL7s/C09bRHjxMhn4KGCtk0j/3MsLAuW2KD+imYKJTOYHBJPsFPje1/U/7fnj
         wTP9ARh4w1acgjLpMKbpP809VU6qXT8PU6vLSnQYI7m6GZ2iQnuRrEwVuevDYuQojgRQ
         JgdbG5xKOVKW86YoRYQdWHO+mC7Vct3h2YiYvL5Lx9Ukw/9ECCGRGqlSkKgQTGppYSy9
         Cl4MR4Y6q58tyC1Fqem2oh01WjE6UxPOr4ZzIq4QkauTDulcjkOUDDRjbiqLMSQYPYXs
         Mldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790770439; x=1791375239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2n4+UnejlqYn1u6OpHJx7OaKBKukorY5gDQh8E11BEI=;
        b=ZQ9K6LAGBK8XqDtk3R7pZdsmfTXfcWidapgsnjR0GhEiVnHK2pCn7fTEdAn0Ih0rif
         b7gA4MGHOyQ0fIb4VR3uYvu+kiSpvymlnIfXem85ShQrhcgG2sb2QVD5xL7/QH4Tgit9
         xukqWMOyRY/D7aSfKepXxLCErORs1eyM85MOlZddodlRHcffVgrdH9+OGUnYcq+Q9Qq7
         S94kdRpJ2rYY2uRZtdhz71AmCWzB4ky+Mo9oBg38AlTLN7W+H8mJNt8DkWkl8u6hvhaX
         jGPsWEevocjnu5uLl29VXbIT+afpemXRrfnc3YZIRQOPDT+Pzz7y74i8keXE2cR+v1A/
         DCXA==
X-Forwarded-Encrypted: i=1; AKwUvBxBCOz+oCLYY754azZqlAxm9s/YEVuP3z1xGxy7BMDCNFRKUnl9/H/UZCM6OH6B1KoO9vMGi81ZS9lhQnUq@vger.kernel.org
X-Gm-Message-State: AFq9FYKzRgYt4MjBSK39NFv5ixa9XvtFFG02AB/0f8ve/e4RIIlQd3T/
	QicHQPKS8a5hMVH3KAj4zVmGBRTtx2/t/P4beGAihE/mAvlopR6n1fceUy6XVoKO6c5UnmbSwhV
	OF91a9VlRMvId9uUtBkPvEauzAZIreDs=
X-Gm-Gg: AYBFou02JXg8u3SlV3NYN0hWRkldAUb/vrxCGfLXXNg94GNMzpmoZTuPp9x2AV9gKBU
	gh2ROG3EUPsrW06W8qC7LtUaVZrX4tdvnUimCxQbctP94cAEnmq5j/VyCMjsbmNagunOBXekvYC
	+JXEPA2ZSTIyzbmr886m0tJzT0v4+QrZQeoMUPhbSC8zjaJZHSWcQBhLRYLJiGLvBlGTJ8mf+5f
	/TBd/vo2g7+0hppRwAshuflGc51gLmRqp1+bCU/h4ZHS30P6nfLh3QWo+dOxkL+5qzRLX86x6Pi
	MdT9fFljKR//mQ1VRY7kbvHmYnBVGKNDC3PlivacmfwCbhIr/jDcQhSZz+sj46QBMNxLIGoCrQD
	iDLm8M4LCppa8P5xHpgZkum7EiqlIk7eh26C0RTh9XH71gGwByXR+nig3w1Q3N+uD6/2MJN4UCR
	KJyWVKWC00e0NZH7t0tIpRkXFaS4TlMpAtSpACbSmcmHR4Kqq3BAs=
X-Received: by 2002:a05:7301:6192:10b0:34b:101f:cdaf with SMTP id
 5a478bee46e88-34cde6749bbmr2785844eec.1.1790770438477; Wed, 30 Sep 2026
 05:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917051147.98775-1-tweek@google.com>
In-Reply-To: <20260917051147.98775-1-tweek@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Sep 2026 14:13:45 +0200
X-Gm-Features: AclHuK-6adfLavzkp4ECmLqb4CW3_hXGJszcDPcphNHw_O5mw99JF2JHAArmZF8
Message-ID: <CANiq72nRLF7PmqqVUrAiw_M3dYZCr9ifoo+Q4SuXfBQsAFH-pQ@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: allow non-ASCII characters in `authors`
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 7:11=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> Module authors may have non-ASCII characters in their names. In C,
> `MODULE_AUTHOR` allows arbitrary string literals which are emitted as
> raw UTF-8 bytes into the `.modinfo` section, and multiple in-tree
> modules use non-ASCII author names.
>
> Originally, the single `author` field permitted arbitrary string literals
> including non-ASCII characters. When support for multiple authors was
> introduced in commit 38559da6afb2 ("rust: module: introduce `authors`
> key"), it reused the `expect_string_array` helper that had originally bee=
n
> added for module aliases. Because that helper enforced an ASCII check,
> `authors` inadvertently became restricted to ASCII-only string literals.
> Later, when the macro parsing was rewritten to use `syn` in commit
> c578ad703ae9 ("rust: macros: use `syn` to parse `module!` macro"), this
> restriction was carried over by using AsciiLitStr in `authors` type.
>
> Change the element type of `authors` in `ModuleInfo` from `AsciiLitStr`
> to `LitStr` so that UTF-8 author names are permitted.
>
> Fixes: 38559da6afb2 ("rust: module: introduce `authors` key")
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

This looks good, thanks! We did discuss allowing non-ASCII long ago,
so this wasn't intentional.

Petr & modules: I can pick this on up (an Acked-by would be nice!),
unless you want to pick it.

By the way:

Cc: stable@vger.kernel.org

Cheers,
Miguel
