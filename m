Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783813;
	b=dFTf1mvqoKHABNufXbURKDxt39JsLniho3CSyWT3NI8l9Z5I0X4r6QwXgEsN46nv2r0F
	 MuFXsLn7DqAkp/m+RivwkvzXbX2n7M1U+96xe8wYQQL0UfqnlMzVddR3AIEt/+XMNIoMX
	 fcyeKQZODQ+Mk4VWJroGKR9a3y4SIojuuvUqge1Xp6J/mqFC0ZZh0GW+E34CsufNsmfLf
	 cHkwX2YwFku2O8C9ZCNJJ7+RPBSomK/OhRG32C2/LtT7L3x5Fuag+6CLqaMGBJ8lHw3s3
	 ebJsjZ/pM2yPVNwwU5URSHo++/RHCANVHg9pL5UVQ65qFI0yBfVnV8uo3ByW8xrEn3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type;
	bh=FnO1x2d+/C83Q2nzhrZlov1274fH/sTNuAJTsOOpadI=;
	b=u+lf9QBzBIdfQEDHxklTJCzIODyKugIX5QE36pu/obQYJSCE0C3G6n7SWOVa2Z9NgD6I
	 miVAZMzXnucCnCKRfX5P1cC4sKnznoicuYY4BqAjLBgCfEUly1H65dZ1OGDN/mPc2pLYV
	 /BC4d4dkOv3Te0mXxwsqj2E0xG2c4CcXOgOQFr8E5Iu28b6z0hn2mITIZjrR5oPl3CKtm
	 k/Sx3ijjGscdIpl5dqOyvVFNktewXzTGK1PRWguBXUNt1zDmgT34xHg9A65q8Nz5VYnm7
	 6vnnDOcGLSb/ceo2gs3Q9kGB2Oe+0qAGBXziGTZuSq32P3+yem63jx+GZ1ALLyEbENg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e9ZhQYbE;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E53606A31E
	for <linux-modules@vger.kernel.org>; Fri, 27 Nov 2026 12:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85E53606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e9ZhQYbE
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-497614c95f0so4603619f8f.1
        for <linux-modules@vger.kernel.org>; Fri, 27 Nov 2026 04:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795783812; x=1796388612; darn=vger.kernel.org;
        h=content-type:in-reply-to:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FnO1x2d+/C83Q2nzhrZlov1274fH/sTNuAJTsOOpadI=;
        b=e9ZhQYbE6j7PdWndI6E/2lrL2HAR+5o3DKCqdxs+8QL88rGptmUYZUjO3wQoUmxHp2
         veL+isNGvrK0WolaksoAQX4UHCAOGcet8/S3f12ygEWaEUmFPMNBdUhl3TZp3WAEGqf3
         4JT/Ef0JQEMP4Oe+fJBC0GH5e7tP42q+y8WCvFT+61J0p9Q9z3xO55YzUId+Pxj6K19T
         zx7Vr0wDZVwA57cWGopIVIqQ7y4uI+eAr0pS5Ht7IXmXMtfPzr9WE/niv/XqviILKLo7
         7sNEuxs7jD+uDSpbiduWphjj9Cgkl4SrtM8rQjSZJ7JL/mrssShWA0D4c/n94T9oWNSh
         /6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795783812; x=1796388612;
        h=content-type:in-reply-to:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FnO1x2d+/C83Q2nzhrZlov1274fH/sTNuAJTsOOpadI=;
        b=hiSUNCCN0lSc6fmlRsP0LJiNhPU2agu/bqEA3l5HjHz6J2c56wHZ5AHwTehJTGNdWL
         /V0ZTOfSKSZ+6HgRYdwGdfJC/ik8aXv0GT7zw+7qT0bCrI8QQAMINXGpJKy+njvPLjuq
         IQNpyCMXmnPgAhqTa/5ofIT8pMQOvo0ZBfaxl/lNZexFrS0YMyEqMlA5Y+NvNSzW7JVw
         QT+7yS2wHrIzmgJRf7iQ+qenWOqQusJMIQRrHiFtN8P6tDXCuK/mMRbSEvjqa1U6R03Q
         PVwfEH+NTVOKKaB89oRBP9VYNzd11w6tR1vVwc+CpJdqsPutzPlqXMBo3BBQHKyXtd4E
         dHmQ==
X-Forwarded-Encrypted: i=1; AL+hErEybepwNTTJhuGv+f/EMju/dH/ZO6CPZlt1pyK+aS4iXF+/D8u2b6vD93rKNuqQL+mcMU0UNocbggBYn55V@vger.kernel.org
X-Gm-Message-State: APuU4Z+uC8kESxNHAy1bijW6mKUgSfdeBr6+5V7l8CcUg2d78pJJRbsH
	we6LOlmsUdyizJH4GFr0+4CkD1UQ8gNshqZIoDllzmYZced2lH3jK1Ys
X-Gm-Gg: AZFdTZe1nX+bDT4WTP+3ZMtM4akTpYhCl2v3ek7gGWSzHIJTrp/aD1Pw90JtWq7CVzP
	ukb9rVEYrqUxk8LBZ4HgldRstBMxPxQCy6+jrOHqPWxK2zeopfgOOr7oYvvPAwHE54z2uxgDoPj
	te2tqNnHDcsgiqpbovaU48GfHXY8GSoHjIuWXLhOegoY3TOU9VXQoJpEdSl6+WvvjRhwbxteBwc
	DutCE5e0G/LwB+F98BoLQeKHdy8x4ifLCxzy7ehxnPMHY9xv1JPMz6AcWxEXmZIJOE+d1neYLx3
	r/XhTQAE17sCIxkDmS3bmEJ5zkRf9xSomWcp7IjOpnHIPGc11QLbC7X3WxMOnTLXM0D182PlAEo
	fQqL4/QljNgwbQI3nUZMBIXdA0IjOQ/deMqm6xI9KmrmL7xznz0uMfABiNAnQfhZCfuU1RCjX1h
	aP03pUcmhKhlxMqjtF30zy/1tVUQ0NQ7n3rahob3UVbOdIY3/sNG0a8bCK5w8ZWxEz2/yiFjn4l
	YIkDN0y1g6edZ+elOdrIxxOeqNup/Mk8x/qdFmERSxU65coBczqCGttFFNSdVSrZz8wdQgFFvJV
	zu621EmWu/95JBguXD3t/fBwk8P5cGXiZEq0hf8RCQtZoc2X9dof40ape/o0PzXsY+W+bcjpDlH
	R5l0SBCeO/KJmTLD/OQ==
X-Received: by 2002:a05:6000:41d3:b0:48e:d36:77 with SMTP id ffacd0b85a97d-4abaa97737emr47215381f8f.4.1795783811629;
        Fri, 27 Nov 2026 04:50:11 -0800 (PST)
Received: from [192.168.0.41] (bl22-190-205.dsl.telepac.pt. [2.83.190.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm47852629f8f.16.2026.11.27.04.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 04:50:10 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <d9151015-1316-42fc-89b1-d93cb0249d6e@gmail.com>
Date: Fri, 27 Nov 2026 12:50:08 +0000
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] scripts: add bit count parameter back to host hash
 functions
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: nathan@kernel.org, nsc@kernel.org, samitolvanen@google.com,
 ljs@kernel.org, david.laight.linux@gmail.com, sashal@kernel.org,
 lzsx618@gmail.com, zuoan.penguin@gmail.com, petr.pavlu@suse.com,
 jani.nikula@intel.com, xur@google.com, sidnayyar@google.com,
 robertusdchris@gmail.com, acourbot@nvidia.com,
 linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261127000015.3662267-1-julianbraha@gmail.com>
 <20261127000015.3662267-2-julianbraha@gmail.com>
 <CAHk-=wjcmmgrJy6rknMOTJ76O92QSAMSUaUPKC6N=pASPsxPmA@mail.gmail.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <CAHk-=wjcmmgrJy6rknMOTJ76O92QSAMSUaUPKC6N=pASPsxPmA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jQ00QMhwmgorNfZxtX025rYx"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jQ00QMhwmgorNfZxtX025rYx
Content-Type: multipart/mixed; boundary="------------OtdfgwIauxllpYjoIU7uHsIu";
 protected-headers="v1"; hp="clear"
Message-ID: <d9151015-1316-42fc-89b1-d93cb0249d6e@gmail.com>
Date: Fri, 27 Nov 2026 12:50:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] scripts: add bit count parameter back to host hash
 functions
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: nathan@kernel.org, nsc@kernel.org, samitolvanen@google.com,
 ljs@kernel.org, david.laight.linux@gmail.com, sashal@kernel.org,
 lzsx618@gmail.com, zuoan.penguin@gmail.com, petr.pavlu@suse.com,
 jani.nikula@intel.com, xur@google.com, sidnayyar@google.com,
 robertusdchris@gmail.com, acourbot@nvidia.com,
 linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261127000015.3662267-1-julianbraha@gmail.com>
 <20261127000015.3662267-2-julianbraha@gmail.com>
 <CAHk-=wjcmmgrJy6rknMOTJ76O92QSAMSUaUPKC6N=pASPsxPmA@mail.gmail.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <CAHk-=wjcmmgrJy6rknMOTJ76O92QSAMSUaUPKC6N=pASPsxPmA@mail.gmail.com>

--------------OtdfgwIauxllpYjoIU7uHsIu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/27/26 01:16, Linus Torvalds wrote:
> On Thu, 26 Nov 2026 at 16:00, Julian Braha <julianbraha@gmail.com> wrot=
e:
>> Accordingly, adjust the callers of 'hash_32()' and 'hash_ptr()' to use=

>> the additional parameter. This is a pure refactor (no functional chang=
es),
>> so pass 32 to preserve the existing behavior.
> I think this is the wrong approach.
>=20
> I'd suggest hiding the size of the hash table in the table itself, sinc=

> ethey are all constant sizes.
>=20
> You can do it with some typedef tricks - not exactly pretty macros, but=

> the end result ends up pretty nice from a user standpoint.
>=20
> Something like the appended TOTALLY UNTESTED patch.  It builds, but it'=
s
> literally a quick hack.
>=20
> What it does is to turn each hashtable into a 'union' type that has the=

> hashtable head array (as 'hlist[]'), and then a special 'hash_bits[]'
> array.
>=20
> And the 'hash_bits[]' array isn't actually used as an array, it's
> literally just used for its size: it's the number of bits the hash tabl=
e
> has.
>=20
> So now you can take such a hashtable type, and always turn it into the
> number of bits with just
>=20
>    sizeof(hashtable.hash_bits)
>=20
> so now the hash table itself inherently carries its size in bits with i=
t
> - no need for 'ilog2()' or any other crap to calculate the bits.
>=20
> And at that point, you can now just use the high bits of the hased
> value, and you don't need to pass in any hash table sizes.
>=20
> You can actually even pass pointers to these things around, but you hav=
e
> to do it with that original named type, because the size is carried in
> the *type* itself, and it's not just an anonymous array.  Nothing in th=
e
> tree does that
>=20
> We can't use this trick in the kernel, because the kernel hash tables
> aren't all fixed sizes.  But for the scripting code, this should make
> the hashing really syntactically simple because the size is always
> there.
It's a fair point - I see why it was simplified in the first place.

Will take a close look at your code. Thanks!

- Julian Braha

--------------OtdfgwIauxllpYjoIU7uHsIu--

--------------jQ00QMhwmgorNfZxtX025rYx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQT6qjll++tIFxF8TUPElYPCBXNxIAUCawl8gQUDAAAAAAAKCRDElYPCBXNxILMM
AQCI30PiL/2psxDIoyOwHOQ9RY6h7g5E5tfq+Gq63YwniQEAhEr91ZFvAJF3tQJGNDhi8qqDWe5b
5WTY6N2nBSYumAg=
=nk8c
-----END PGP SIGNATURE-----

--------------jQ00QMhwmgorNfZxtX025rYx--
