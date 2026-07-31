Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C82428472
	for <linux-modules@vger.kernel.org>; Fri, 31 Jul 2026 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504949; cv=none; b=HKCncRiHFAcJgDXlwOXPUVoMrNdyigOwHY2Dzs1d6Jxo/2bB4s9RQxLPDuaQYWxUOmcmINXrrRJqRbjOXvqG5DIZyaK6ERdM0diZeeWWH1Ua1CXpSm+nEv8s2CumXB1OYEQpJ7764vHMsfnkFMts4zsxqfRaaxk4QRGAos4xShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504949; c=relaxed/simple;
	bh=5lIqIN4onCpxt8xay3++N/c4GoscyYlJpo1tEjsJVe0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JRL0PgavkZAb0ZTc4GhVxpLOGFNJnPB0hqEfmZRCQh5xY1BcntiELg6siltgZZUrzPR5u76PPKJynYl7+zjRR9OSJWbU61Ic7XHcfKjVPPgHnw2yIXXCHETRpHpfDB/oOC9G/FUvKjleZkoA3q30Q/G7lbGMPCUZVgKkvnvXNGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4yQAOpy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4yQAOpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3850C1F00A3A;
	Fri, 31 Jul 2026 13:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504947;
	bh=Z7eahAYvtDz3wbeUwQgpPNU6cmrUk3NyiqVRvjG0+X0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R4yQAOpypbkSmYeq10FoFOYijx+ifBDWizUdBFQLx+K7VXBVJYAXwUx3eVLxQwWnr
	 jAf2MrWLcig+kAQBB6GlkWzobPoE+Ghb/pAztjVV/lyCv6faLL0es/qRYl5wsYvbhn
	 WtfrDz8J1BQtEMdEuskxDRyDeb8ivzLy94sXuv2D+WQ8LbAW9yQdwqag/pnbWZjFPf
	 q1r0SOdwMuhKLGUS04R19Y4Te3PlhToGD24XIdGe6AXQEAg+i3spLtlwIQFGK6mVoQ
	 Pnih5YiNauoTaDU1asKuAMF4J+8Ep3IxsR+uq2i+P+yaEdzJl1xVk/LknpgFcnYnrN
	 11iUaY/xb8iHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] module: remove srcversion module attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260731-module_ver_remove-v2-2-c9163858f382@linuxfoundation.org>
References: <20260731-module_ver_remove-v2-0-c9163858f382@linuxfoundation.org>
 <20260731-module_ver_remove-v2-2-c9163858f382@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:35:46 +0000
Message-Id: <20260731133547.3850C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Incomplete feature removal leaves `sumversion.c` as entirely dead c=
ode that is still compiled.
- [Low] The `-a` command-line option was not removed from the `getopt` stri=
ng, causing silent failures if passed.
- [Low] DRBD modules unconditionally report their version string as `"built=
-in"` even when dynamically loaded.
--

--- Patch [2]: [PATCH v2 2/2] module: remove srcversion module attribute ---
commit 461ecb5f73545c4d962415cbd1b5ef67b64b2f0a
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

module: remove srcversion module attribute

This commit removes the srcversion module attribute from the kernel and the
helper module tools. Since module versions are no longer used, the
associated logic is dropped.

> diff --git a/drivers/block/drbd/drbd_buildtag.c b/drivers/block/drbd/drbd=
_buildtag.c
> index cd0389488f63e..22f1e842f9ced 100644
> --- a/drivers/block/drbd/drbd_buildtag.c
> +++ b/drivers/block/drbd/drbd_buildtag.c
> @@ -10,13 +10,8 @@ const char *drbd_buildtag(void)
> =20
>  	static char buildtag[38] =3D "\0uilt-in";
> =20
> -	if (buildtag[0] =3D=3D 0) {
> -#ifdef MODULE
> -		sprintf(buildtag, "srcversion: %-24s", THIS_MODULE->srcversion);
> -#else
> +	if (buildtag[0] =3D=3D 0)
>  		buildtag[0] =3D 'b';
> -#endif
> -	}
> =20
>  	return buildtag;
>  }

[Severity: Low]
With the removal of the conditional logic in drbd_buildtag(), will this
unconditionally report the DRBD module version string as "built-in" even
when it is dynamically loaded?

[ ... ]

> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index a7b72a81d2482..2e969be7f414c 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c

[ ... ]

> @@ -2327,9 +2306,6 @@ int main(int argc, char **argv)
>  		case 'o':
>  			dump_write =3D optarg;
>  			break;
> -		case 'a':
> -			all_versions =3D true;
> -			break;
>  		case 'T':
>  			files_source =3D optarg;
>  			break;

[Severity: Low]
Should the 'a' flag also be removed from the getopt() option string earlier
in main()?

scripts/mod/modpost.c:main() {
    ...
	while ((opt =3D getopt(argc, argv, "ei:MmnT:to:au:WwENd:xb")) !=3D -1) {
    ...
}

If the deprecated -a flag is passed to modpost, getopt considers it valid
and returns 'a'. Since the switch statement no longer has a case for 'a', it
falls through to the default case and silently calls exit(1) without
emitting an invalid option error message.

[ ... ]

> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 2aecb8f25c87e..2c2f1d2b40211 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -126,7 +126,6 @@ struct module {
>  	bool seen;
>  	bool has_init;
>  	bool has_cleanup;
> -	char	     srcversion[25];
>  	// Missing namespace dependencies
>  	struct list_head missing_namespaces;
>  	// Actual imported namespaces

[Severity: Low]
Since the srcversion feature is being removed, should
scripts/mod/sumversion.c also be deleted and removed from modpost-objs in
scripts/mod/Makefile?

The file appears to be dead code now that its only entry point
get_src_version() is never called, though the function declaration still
remains further down in scripts/mod/modpost.h.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-module_ver=
_remove-v2-0-c9163858f382@linuxfoundation.org?part=3D2
