Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505622;
	b=YVMU8PdIZwnTV+jBVj0wGYxKGJFBHwQrEq0GHGSDOYVWSDSacIUVJ4kSXQWI5L9PpNq2
	 uWnmrcr+nDasNXpOUXiifRga3X3iyG++NctGHR+t2oZBq4xk86PZ10KZqty6Xu/VSW64w
	 VszsYkmgJYh8bTDkkZTmyW+ZhxKvlSoFseBlAKlKCYQDIzjDlyFAsbppAP8Q8PzkiTKO0
	 fNCriR70g01GT/SztvR+21TtzPlQ9vwe0gD8P05GXHV7Ced+fBNoiO8FUkR2/76O07AI+
	 AKaRi8gUQc5gm4nFcVhwb1rtOUWr2FgqbgUIqixg6D2DgeMCABU+rAXfUrqlp7crIRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505622;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ICum0JAKfDirRcbtMAFqCyRh4kigsK9BGaaoW68KlyI=;
	b=4IYrdowGNL6vAU2pWc5SsmzFHSalEgrY8XkEJyAR64ylJ2vNARal0U4I0yMTnXPq4OrG
	 RebcUtXex5DLUTyg3rzlAAe+CgLdSuVE4l7mqA+ToyrWdtu4r+eZixyxOXjjL6uGp9l0Z
	 jE0gBXJ+N/F25tfAI5eX4702HoOJI8/lY8fk45NVzu8koRz4+imCCwIBW0hUipPCwS9Az
	 qCaxykp/NUii1Ogk+dchsjIFB+4R+v+h28OOAUL1pRbZzG5Zx25SlqSvl/v8vWkv4u0T9
	 apZoZFe2sBdvjAsjfn1XylR3PUgv2Xsjef2n5iljL6OhcM5kHj3ATcbV/CBH20Q1dqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E11t66iS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE72606C22A
	for <linux-modules@vger.kernel.org>; Tue, 20 Oct 2026 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E11t66iS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600571F000C4;
	Tue, 20 Oct 2026 14:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505621;
	bh=ICum0JAKfDirRcbtMAFqCyRh4kigsK9BGaaoW68KlyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E11t66iSpTjjQeZP7kLMxylH7DJQGcYr5lJKuxb8NLVkYq2OPL73B3jR8fL4tiMSp
	 1UR4bHhi9KTM0MzjxdhgUZ2I7izhwR7LM/7FfisdBdyrDqkF/S0mEmcoUpgm8MQinG
	 8V+Uf5YbtZJ1nFJZslWK8JvJsS8fVq5HDSdbLvyXTg7r8WJ5mqmETKMbHAvUaVMPpw
	 cz+nHJ8XCULVE5xYZ5O1Gqp+pQZlRowQoppIbiwHs0bbjIqQSjavxd+48mCJ05MrMH
	 Y0kOpyweMq22JGGk+ZLWx+M9wWRsn0aY5XzCGXLZ7i4iMG7fo3S2+dxpaHANqIlMq7
	 Kf/gqNr1TVMzw==
Message-ID: <sashiko-outbox-179099@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] module: Fix data race on mod_unload_taint::count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20261020-taint-unload-v1-2-d1c764889afc@suse.com>
References: <20261020-taint-unload-v1-0-d1c764889afc@suse.com>
 <20261020-taint-unload-v1-2-d1c764889afc@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:13:40 +0000
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] module: data race and uninitialized read of count in try_add_tai=
nted_module()
--

commit 742b3a34fee074246edb757213ccfc148f6e7300
Author: Petr Pavlu <petr.pavlu@suse.com>

module: Fix data race on mod_unload_taint::count

This commit fixes a data race on mod_unload_taint::count between updates
serialized by module_mutex and concurrent RCU readers by changing the
field to unsigned int and using WRITE_ONCE()/READ_ONCE() accesses.

> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> index 061161cc79d90..70ef20b97c84a 100644
> --- a/kernel/module/internal.h
> +++ b/kernel/module/internal.h
> @@ -257,7 +257,13 @@ struct mod_unload_taint {
>  	struct list_head list;
>  	char name[MODULE_NAME_LEN];
>  	unsigned long taints;
> -	u64 count;
> +
> +	/*
> +	 * Number of times a module with this name and taint combination has
> +	 * been unloaded. Updates are serialized by module_mutex and use
> +	 * WRITE_ONCE(). Readers that may run concurrently use READ_ONCE().
> +	 */
> +	unsigned int count;
>  };
> =20
>  int try_add_tainted_module(struct module *mod);
> diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
> index 5bcd1c2701f07..873fceb305268 100644
> --- a/kernel/module/tracking.c
> +++ b/kernel/module/tracking.c
> @@ -28,7 +28,10 @@ int try_add_tainted_module(struct module *mod)
>  				lockdep_is_held(&module_mutex)) {
>  		if (!strcmp(mod_taint->name, mod->name) &&
>  		    mod_taint->taints =3D=3D mod->taints) {
> -			mod_taint->count++;
> +			unsigned int count =3D mod_taint->count;
> +
> +			if (count !=3D UINT_MAX)
> +				WRITE_ONCE(mod_taint->count, count + 1);
>  			goto out;
>  		}
>  	}

[Severity: Medium]
Does try_add_tainted_module() in kernel/module/tracking.c still have a
data race and potential uninitialized read on mod_taint->count when
allocating a new entry?

Further down in try_add_tainted_module(), a newly allocated entry is
published via list_add_rcu() before mod_taint->count is initialized:

	mod_taint =3D kmalloc_obj(*mod_taint);
	if (unlikely(!mod_taint))
		return -ENOMEM;
	strscpy(mod_taint->name, mod->name, MODULE_NAME_LEN);
	mod_taint->taints =3D mod->taints;
	list_add_rcu(&mod_taint->list, &unloaded_tainted_modules);
	mod_taint->count =3D 1;

Because kmalloc_obj() does not zero-initialize the allocation and
list_add_rcu() publishes the entry to unloaded_tainted_modules first,
concurrent RCU readers in print_unloaded_tainted_modules() or
unloaded_tainted_modules_seq_show() can observe mod_taint and execute
READ_ONCE(mod_taint->count) while mod_taint->count still contains
uninitialized slab memory, or race with the plain store setting it to 1.

Should mod_taint->count =3D 1 be initialized before calling list_add_rcu()?

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-taint-unlo=
ad-v1-0-d1c764889afc@suse.com?part=3D2
