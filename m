Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBAD33893E
	for <linux-modules@vger.kernel.org>; Tue, 21 Oct 2025 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054723; cv=none; b=XW6MbpEyvtSUFrjHK5rs9qm9A1P0tN8niNRymqunen6y5IEyX/0KDpL2JhWun36XDy6zNKPcwnRyDSsWdzMNTH/Q/8ItTmufc1KgX508ZnukIp5e98dM5HV2Bkw/wEsWn7xuvYB+NlPiRY7GDLFXvx6qFvrUV7XkK97dTaVGQ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054723; c=relaxed/simple;
	bh=cKFEf/mkujNMWCNn288lix+mx7uATbdtwPCr645LzQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jt5OEs2uBEDXIGdoR9SThPPWwrbWCQDK9ZUwYHO62gsRDNcNC8o4q18hZnCax2NAS1JtQeno3LPVShz4pWs1b1bkppv+TIRl+29w8JSiztV+8NzIVsTkXJmdRE2JIDsv4z7/YWK5U3U5grZbOJwxWso8ibZ0ViOYSaevDPVfISc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c3psRs9d; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c3psRs9d"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so53393815e9.1
        for <linux-modules@vger.kernel.org>; Tue, 21 Oct 2025 06:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761054718; x=1761659518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2DyGAU+rMA/cRZrPzQupQaBzSC5vN1SBLAXdhns1VBg=;
        b=c3psRs9dCxelf/aUOXvb+s91iQFgGtFocu21KJGzmx/OFjdFr+liPSKreuteIapmAu
         RA/9LbcZ5iWEcGese/FGlR6IqlrpXRjvg6LzBb7MAUbLgyJ18pzuF5i29JMvRywT+Cov
         uDW840jYvC17mez5rttoLLHpsvPxqeJAG1/yNveDdQ/8avt3u6wSyiF9cp+My1e1sRGj
         F8vp+ujI4lRUk93yxKLGpDg3aXDRCAwMapKTmnhO+6s1toLzcIxR2yDt01hmZVA5T725
         ayd2WCmdVXKrcafzt5LTtFc9A+aIMEPvxjdCyZfotvY6d9zDqcW1ebRNRlx8Wn1bqLb1
         IsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054718; x=1761659518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DyGAU+rMA/cRZrPzQupQaBzSC5vN1SBLAXdhns1VBg=;
        b=CesFT6Kcdw21zk4IM77j/mz/+zo8JO64Ug+o2vOgXGIg/k6f+zEj2ZZR4SUi/nMzKg
         fmVPFieevyjiU4aSD7JlzN1GtIOG1eEsP/hEIYlSN3rVE2CYPs3A44w5EOyIsmLJOGM6
         GFQDS77GXitPIIwhoeU3sdmFPc6bwDZXqiCxC0gxxwl2Ieyjv3y+LjHKJx1ZvR/ohQAU
         7ANl4SgYMAhufQ+euU2+vf8+1CE5zeuc3qSFeEwtAUULu08dp/ao9SKGmtGHz0sLvVzr
         ilZXSy4m0TmxE0aG/HHMxj/SM3HKvHoQWLYRki6g2neJ1z9xxjZIj/6QPkn3APAKLCz3
         pHCw==
X-Forwarded-Encrypted: i=1; AJvYcCWl5tJB1dmOemBZPKOjCgw2P68sVnmagLB4mKrsWI4L1hNSqp/9LgG78HYenPT8K7Mz8CRlCrr6zrzY3hLV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0CIlwQVa4Zqh2pVPJ0zAKz18CkG0R4IWP0DHpPn+KXsmGf1hk
	HmDUUwXayRe78Nbar/H+8Wn9/ptq+KqYegwCqaKaKybAWdnm0TFW0rMG0696xnBcJug=
X-Gm-Gg: ASbGncur2yG6syqKgEQiky5ccah+BxHcLqT0IFUxc2J8dUAChHFKA3k+oJ+AwIR119Z
	tRzM73pAOLF2ck3BG+94HD87CfnHKO9LJ6UjAOVA6XBAglpEvrupCBCJ61QZ825VYUSnvEJDjLv
	phRuWgfgebywVB7VoRcDpUHhFCNRqSIOIW58kiI7c+pzsA4fczwMwnPPWiYEadB+yQq84oJh5Hs
	fp9qyJJkV3D9Rw3LXb9TNp42/gSHZSLqNubY715m2iHpveI+MUgWK2yn4baA2yzF+ly9u0GnpfM
	9+wqk5zz0B8m1oi3xLnR4s86h5YqUevty3LsDPwvZOCG1efkODs365n4bSm6AL/4FF756pu0WAl
	FwvvNpyYXQdHnridCOHqEByVHSsvUN/EuDLATDvQUdGcBoN2hfJqb5RcRdzXZBdXnB++bqwq50Q
	bfsmyuD357dQuHtPty9jXPk9AKUgRs+MQ=
X-Google-Smtp-Source: AGHT+IHWJuVwFzbFlMqm8ao/URm2+K5hiKjfkJF6MOKyAoW5c12azTqzQXI62G8B/tUeCFgJ75QR4A==
X-Received: by 2002:a05:600c:45c9:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-4711791c601mr124597535e9.26.1761054718131;
        Tue, 21 Oct 2025 06:51:58 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d90bsm198104915e9.2.2025.10.21.06.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:51:57 -0700 (PDT)
Message-ID: <81080a24-e4a9-4287-8653-9d707e574d95@suse.com>
Date: Tue, 21 Oct 2025 15:51:57 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/17] modsign: Enable ML-DSA module signing
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, "Jason A . Donenfeld"
 <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Stephan Mueller <smueller@chronox.de>, Lukas Wunner <lukas@wunner.de>,
 Ignat Korchagin <ignat@cloudflare.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-crypto@vger.kernel.org,
 keyrings@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251017144311.817771-1-dhowells@redhat.com>
 <20251017144311.817771-18-dhowells@redhat.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251017144311.817771-18-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 4:43 PM, David Howells wrote:
> Allow ML-DSA module signing to be enabled.
> 
> Note that openssl's CMS_*() function suite does not, as of openssl-3.5.1,
> support the use of CMS_NOATTR with ML-DSA, so the prohibition against using
> authenticatedAttributes with module signing has to be removed.  The selected
> digest then applies only to the algorithm used to calculate the digest
> stored in the messageDigest attribute.
> 
> The ML-DSA algorithm uses its own internal choice of digest (SHAKE256)
> without regard to what's specified in the CMS message.  This is, in theory,
> configurable, but there's currently no hook in the crypto_sig API to do
> that, though possibly it could be done by parameterising the name of the
> algorithm, e.g. ("ml-dsa87(sha512)").
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Lukas Wunner <lukas@wunner.de>
> cc: Ignat Korchagin <ignat@cloudflare.com>
> cc: Stephan Mueller <smueller@chronox.de>
> cc: Eric Biggers <ebiggers@kernel.org>
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: keyrings@vger.kernel.org
> cc: linux-crypto@vger.kernel.org
> ---
>  Documentation/admin-guide/module-signing.rst | 15 +++++------
>  certs/Kconfig                                | 24 ++++++++++++++++++
>  certs/Makefile                               |  3 +++
>  crypto/asymmetric_keys/pkcs7_verify.c        |  4 ---
>  kernel/module/Kconfig                        |  5 ++++
>  scripts/sign-file.c                          | 26 ++++++++++++++------
>  6 files changed, 58 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
> index a8667a777490..6daff80c277b 100644
> --- a/Documentation/admin-guide/module-signing.rst
> +++ b/Documentation/admin-guide/module-signing.rst
> @@ -28,10 +28,11 @@ trusted userspace bits.
>  
>  This facility uses X.509 ITU-T standard certificates to encode the public keys
>  involved.  The signatures are not themselves encoded in any industrial standard
> -type.  The built-in facility currently only supports the RSA & NIST P-384 ECDSA
> -public key signing standard (though it is pluggable and permits others to be
> -used).  The possible hash algorithms that can be used are SHA-2 and SHA-3 of
> -sizes 256, 384, and 512 (the algorithm is selected by data in the signature).
> +type.  The built-in facility currently only supports the RSA, NIST P-384 ECDSA
> +and NIST FIPS-204 ML-DSA (Dilithium) public key signing standards (though it is
> +pluggable and permits others to be used).  For RSA and ECDSA, the possible hash
> +algorithms that can be used are SHA-2 and SHA-3 of sizes 256, 384, and 512 (the
> +algorithm is selected by data in the signature); ML-DSA uses SHAKE256.

This update looks ok to me. However, I'll note some problems that
I noticed in the original text, notably:

The text doesn't match the implementation because kernel/module/Kconfig
still allows selecting SHA-1 for module signing. What happened is that
commit 16ab7cb5825f ("crypto: pkcs7 - remove sha1 support") initially
removed CONFIG_MODULE_SIG_SHA1. Then, commit f2b88bab69c8
("Documentation/module-signing.txt: bring up to date") removed it from
the documentation. However, commit 203a6763ab69 ("Revert "crypto: pkcs7
- remove sha1 support"") brought back CONFIG_MODULE_SIG_SHA1 without
reverting the documentation update.

Another problem is that for MODULE_SIG_KEY_TYPE_ECDSA, certs/Kconfig
contains the line
"depends on !(MODULE_SIG_SHA256 || MODULE_SIG_SHA3_256)",
which intends to allow ECDSA only with MODULE_SIG_SHA384,
MODULE_SIG_SHA512, MODULE_SIG_SHA3_384 and MODULE_SIG_SHA3_512. This
restriction was added in commit d4f5bfe20da9 ("certs: Limit
MODULE_SIG_KEY_TYPE_ECDSA to SHA384 or SHA512") and 446b1e0b7b39
("module: enable automatic module signing with FIPS 202 SHA-3").
However, the documentation suggests that ECDSA can still be used with
SHA-2/3 of size 256.

I'll prepare fixes for these issues. For the first problem, I think we
can drop CONFIG_MODULE_SIG_SHA1 instead of correcting the documentation.

>  
>  
>  ==========================
> @@ -146,9 +147,9 @@ into vmlinux) using parameters in the::
>  
>  file (which is also generated if it does not already exist).
>  
> -One can select between RSA (``MODULE_SIG_KEY_TYPE_RSA``) and ECDSA
> -(``MODULE_SIG_KEY_TYPE_ECDSA``) to generate either RSA 4k or NIST
> -P-384 keypair.
> +One can select between RSA (``MODULE_SIG_KEY_TYPE_RSA``), ECDSA
> +(``MODULE_SIG_KEY_TYPE_ECDSA``) and ML-DSA (``MODULE_SIG_KEY_TYPE_ML_DSA``) to
> +generate an RSA 4k, a NIST P-384 keypair or an ML-DSA keypair.
>  
>  It is strongly recommended that you provide your own x509.genkey file.
>  
> diff --git a/certs/Kconfig b/certs/Kconfig
> index 78307dc25559..a09db4b2c87c 100644
> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -39,6 +39,30 @@ config MODULE_SIG_KEY_TYPE_ECDSA
>  	 Note: Remove all ECDSA signing keys, e.g. certs/signing_key.pem,
>  	 when falling back to building Linux 5.14 and older kernels.
>  
> +config MODULE_SIG_KEY_TYPE_ML_DSA_44
> +	bool "ML-DSA (Dilithium) 44"
> +	select CRYPTO_ML_DSA
> +	select LIB_SHA3
> +	help
> +	  Use an ML-DSA (Dilithium) 87 key (NIST FIPS 204) for module signing
> +	  with a SHAKE256 'hash' of the message.

Copy-and-paste error in the help message: 87 -> 44.

> +
> +config MODULE_SIG_KEY_TYPE_ML_DSA_65
> +	bool "ML-DSA (Dilithium) 65"
> +	select CRYPTO_ML_DSA
> +	select LIB_SHA3
> +	help
> +	  Use an ML-DSA (Dilithium) 87 key (NIST FIPS 204) for module signing
> +	  with a SHAKE256 'hash' of the message.

Similarly here: 87 -> 65.

> +
> +config MODULE_SIG_KEY_TYPE_ML_DSA_87
> +	bool "ML-DSA (Dilithium) 87"
> +	select CRYPTO_ML_DSA
> +	select LIB_SHA3
> +	help
> +	  Use an ML-DSA (Dilithium) 87 key (NIST FIPS 204) for module signing
> +	  with a SHAKE256 'hash' of the message.
> +

Should all MODULE_SIG_KEY_TYPE_ML_DSA_* options depend on
MODULE_SIG_SHAKE256 to match the updated
Documentation/admin-guide/module-signing.rst?

Similarly, do MODULE_SIG_KEY_TYPE_RSA and MODULE_SIG_KEY_TYPE_ECDSA
require any "depends on" update with respect to the addition of
MODULE_SIG_SHAKE256?

-- 
Thanks,
Petr
