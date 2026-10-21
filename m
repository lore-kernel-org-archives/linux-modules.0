Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792575889;
	b=jj+9qHNlTZiUM8PAztyR3KSMAEARzr5v1FzWiikLqhRl+JH7+znBUHfOUCZSenxklXRz
	 0OzJfkwscMjKMam39l4qkcqI4B89//RbESplGEw+15WKEUO559przNWzgdjmGkIyBSwqd
	 zZNMvZZNYmnn0drsCK/sRJBvY7Q48dUOft4v7Ko32UWN+RuEASYoUl/2sVbTYor8yu5CN
	 2JuQ/Z2J0zVcMGT52qL/A3A3rY6bbPsIK8Iz+9QKTrUX9l+jBf/oJkwJHBAZ/xE2yUsc9
	 AcH/D0KVnLePlIyLySlNmgFAbLU+Awrsf7WP6ypNQRG+cBIYNKPri6Gj8CcknQjJebQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4wdEo8+3sGqfbZwZCNWKmwnBJlPn4YSxWgWSRHqE+f4=;
	b=mTGumx+EBPrCwCHYvJZIRRmqNB6CQwpQPcuYQfBFavsKmZbgzkYlFcIILWsULIbeDrr+
	 8bG9pYmGfTM4Wh0eJ3Jv4OJb+GqiN8wlhFh/6tlLBj6iuubXeqF6qSMuObnZnnqMhEBY8
	 b1xVhZq0JAQjKl9EH4NJJ/GcOc8B1SaJ/Z1dPyDRPh7r+/YuaNUn8HSKPzvx0QHjV5UVl
	 /dFxTcr816P4cdIEyafnrpgvENV64db6KmRwBEMZ3tgWVYjV0tmQ4LX/yeBOme4rttEHI
	 TeGNxBC8tnZtw0dVHrrtD1tqPgSTYvne0D9tfWbszTEV2hggEC+mlmPeZnW6Y1lnHAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hBUBamqX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E4E606A31D
	for <linux-modules@vger.kernel.org>; Wed, 21 Oct 2026 09:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4E4E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hBUBamqX
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35159e0092aso63754eec.2
        for <linux-modules@vger.kernel.org>; Wed, 21 Oct 2026 02:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792575888; cv=none;
        d=google.com; s=arc-20260327;
        b=DCdGQvxv2lhAkepZOwbvb/dH99g6nxLTPJp/9vcFJOFxHa2taw07g01+WadgoQRgN5
         2jM+5QTK3gkyb2wfLnDjMl2/de64C8fegOQg4cuCJAwP+/dSeaL0KLZJdWCNdigCbkKc
         10RXMHy6xNWUMmi3cafTUB2/1hPLi4sf+uk8ws31Y7ulWLPVL2JyFg1sR4SHWK8OkOPk
         DC2NWf+PZxe9f3dY3FmBXToCANyQ5dxul7cPt5NhTXyr3g0v6KksFFbd5EEOMjmfyeGW
         njeNhCl5o7b5DbjN0W0bOqiy9WR7ns1iP5tiGiDyTzY3ZytQv8i+Z90l1cH22lBy+Ts1
         HJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4wdEo8+3sGqfbZwZCNWKmwnBJlPn4YSxWgWSRHqE+f4=;
        fh=qBLGjWoWYOfsQr1KNDGKsmdLQt1igU3MmdJntbb3pjU=;
        b=ntveYoEYGeG7Y91BB8FuC6OozOLhSJXoju1xB8gYs8mh6CEDc+YiKFg4JshMEA0P0d
         HM2Olr2JCmzI4YHKf9O+wyqI4YGyCvmn12jRoAu6VPw4MVi7FNqmTyLrFxs/6o3gLXEF
         ntW/Hb+m03GV9fGg1ch1sqt6NuadyReuSdBmCtsWqlh04xPGY57WHnzNFTx8hXVUKjNb
         uWNRtMZCIQpte+01L3rHX9VmZq/apy859cSRkBcWMBTf6JUJUQUV7FT0pmIBrru4AlhK
         UTHvaubORqpjSri+cRTg5zFQdu+X8G9Yk1SQQlx+/0CT3Cbk+2hfjaZnfHCRWxJWu3GI
         QcTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792575888; x=1793180688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4wdEo8+3sGqfbZwZCNWKmwnBJlPn4YSxWgWSRHqE+f4=;
        b=hBUBamqXA+oWdt5ptEKRaT4hVRRRU3E8B9VaN7HeCDsMa0JJvk1/GJFvem6KOjjNnl
         X7+5hi6GfgiuAmUjEmReh8JP+zNeLccgjrAHtTQzGruOIGbItqMDvxhhTGlk1Ib2xt3A
         3j3yEFYPd5CG7jZeBRRTc5Bw7uWtjrkjkPp9sMnb4vi9lHew+RswdQsBmzbcQmjc8dPr
         NvF+UHp/WostECPHLJ3T2jgAKqTI8sWrUuTgRwXUH7VTDGEPqQ4A7k8T2qAAESMvhOQe
         mz7c7sPNVfaQpFfMPexPfeNV1ZOUr4NJ61GoqGRxgxHfe87J07Bqo8IrWfiR6qNCd4Y6
         GQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792575888; x=1793180688;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4wdEo8+3sGqfbZwZCNWKmwnBJlPn4YSxWgWSRHqE+f4=;
        b=pcxQkLHlF0I2VsFv/+uEbLwbeSIdyl+WXc0dpnGcCYgmDa/j9UnDbm7nli9wQwNzQ1
         FaPmcYiwzy61qELvX0IzR+14c8q+/bvuVV45j6CU7MpKLx3/t1UDmyrZnE8cUmPWqXdW
         HLIu2499oBI1MDVUft6bRbHT1XYTDk26ldHK6afzLoO+pfmPIbbdmmYolQEidROitxT5
         nDUim8XXhRZvtmDr25zonA9Rz6cPBMR3aOr+rnUhM3Us7Cwm48Q8++OjHQnlKnSOGVF5
         a/q+/EmMKsmM74vUXMeyoz1NCePIYH21EZuAm1CypByqz3dEIMt29qsa9UuWjynuFX0/
         rR4Q==
X-Forwarded-Encrypted: i=1; AKwUvByar2XI8pP8n0rLA4il4Um4lBoyhznC3gSKr6mvl8RVtYVWfK93kQ9JAiN5DUdfhRocnYa6s0NrKU3nb6Pu@vger.kernel.org
X-Gm-Message-State: AFq9FYJMd7ri9GWOPouOT6GAoNgWgCNC4GC89KwagomJ+oOmqkt0fUXq
	yttGhj4IWt5RAByYYANxGYLplG/WaEraav86cPF0GRSdMAv06XxvciqESzvJHZT40h0wPGGG7tj
	WsENxVdE0zPJGHnuu6GS8AjzQO/W/G+k=
X-Gm-Gg: AYBFou0T8ZjzvrTn1N3qaIJADOUHaCy+Qk9Wpuz+6xQ5O7xvbo87BBiIBDOiu16d8qX
	CEqJ2WpSa9Tl9YFq3Vnl3eAu7ovC13rgUqff13p5ZDAlRCGWQJSIMAk1MTVn92HcNAYtgfThmbe
	yG/lv0H+WVI/LGp7dChSNGWUCdrlk0GdATP7AyY1dAD5CjGAiqXdsJjDLQIeqti3sdRolxWX8Lo
	5+SZyGTVT4QRNiGRsjfNsXz/3BSvGsgoSEWb/4XjNLP7aNplM9HnGVDyaVUGf74GFJZldD3mtn+
	Nbr3uxP9z2zHQlbo7Bge3FYNGP4Wi9RY7cvO70aRHjNJ/DIzEJCxhTm82/5hwtft4sn3+xhpQcR
	5QgoZSVUDcQd+WMa2mZhloIsQSx/nog5AnGGrFHbY98p7M8WiSoMpXf8a1EgBpmccHsKf2uj78/
	ebTmAX5PRALvrANWmKl1fYPhn4ogQiPaAKXJFyWJCbftjcsGdpZ2jh1HMhC1LTFRuRdNbfGFidf
	ETMKxpu3QFIEvg2SBSNj18Vbn8LuqP4r2zQ
X-Received: by 2002:a05:7301:18a5:b0:35c:492b:e310 with SMTP id
 5a478bee46e88-3674866f609mr4077866eec.0.1792575888075; Wed, 21 Oct 2026
 02:44:48 -0700 (PDT)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019151243.1595858-1-gprocida@google.com> <CANiq72nqq4oGBWVtSMBhXS6G4H7fYg07ysD7SjnOWWt7R9_ajw@mail.gmail.com>
 <0736f8a2-4f02-486a-9552-dfec74032fad@suse.com>
In-Reply-To: <0736f8a2-4f02-486a-9552-dfec74032fad@suse.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 21 Oct 2026 11:44:34 +0200
X-Gm-Features: AclHuK8amX5EU3v7dgjd5CokhSsYsGgsy-NTiRUBGb12KSwkI1ip79L6KXWAwqg
Message-ID: <CANiq72n8V9=-Wwz9aQOo+VrO5pMqJ5w5hd-44jGjxJ8kXF-Gkw@mail.gmail.com>
Subject: Re: [PATCH] rust: exports: emit ___EXPORT_SYMBOL without C declarations
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Giuliano Procida <gprocida@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:27=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> w=
rote:
>
> It should be also ok to move EXPORT_SYMBOL_RUST_GPL() directly into
> include/linux/export.h.

Yeah, that sounds great to me. Probably with a small comment added,
and removing the one in Nova too (which this patch should do anyway --
it is going away, but still).

Cheers,
Miguel
