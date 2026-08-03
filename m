Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154E4361DDC
	for <linux-modules@vger.kernel.org>; Mon,  3 Aug 2026 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785728233; cv=none; b=gPn9I18V1IoLW8IVZptuuH3zA6tYMMmhWJC9ZHLpGeHt6eyQIR8IjTPCTTOcn6ZeB0q0kQwtQ5CrR6X/swjc6FB0tu6Q+LTri+qbCsBeFOTbbKyhFixC90Ogxpo4drN8MVYFjl3XcsJGGDCn498607AGQ9opD2/mWB8XH4/4P1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785728233; c=relaxed/simple;
	bh=F1S5Pvd5Z+LMqG8BdiymERDatg9HivJI7gSTkI1wBjE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fcHqiP+uucTm0iLD2Ssq5bPcaJJK1PA6yR+rOwrbSwt9BIG5+5g8gEEniqTaxGmoeF0HUdwMMB7UbZF2VLb9GWALw4/+fPWBjoxdzy5UWZidqFxZ+/vP2goaYnF4EM+ewJGr9J5VWJvbALRQdzLbNUAFX/yHa3i+wCBLKm8wOkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H98oNAOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H98oNAOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6EB1F000E9;
	Mon,  3 Aug 2026 03:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785728231;
	bh=b1gHp9TLxUMCMamlGacxLwHNQ5jJ/7VQXvqaXZMEggc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H98oNAOE/RZIKbkM4D4QZ/DBjx1yljD7/itO5yEb0aYkpFs9rPijCJaQdR8mQ21vJ
	 /x0c+VQlhZqeYRYsi8318Ylw74oRIqPRJZ5+C3nv96ST7eow4lTGrmXhTavo3ZgbDI
	 YUBCa/MPrYGfFOsrj2tYytVsw9XlqgQq/9LJHFJs2SxCWRfuuTt1EWTcWNPFgOBBQU
	 WSw+A51EM0RSGGmxwfrFWeQH6aMgy5LALMYccCjHGqAyYNb7FW5FLtTu7FahId4igU
	 eP8TMwJnc/Fv7JGDlJ3AtwdmyWTdH+4C3Kp0JjL6osCM96xkirdB0VXSQxTPP/RNJA
	 W8S0BrA68ZWLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/14] objtool/klp: Normalize Module.symvers paths to
 module names
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Poimboeuf" <jpoimboe@kernel.org>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <dbe1b72931bd3c31b751fd0729613d9f2226fff6.1785727106.git.jpoimboe@kernel.org>
References: <cover.1785727106.git.jpoimboe@kernel.org>
 <dbe1b72931bd3c31b751fd0729613d9f2226fff6.1785727106.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 03:37:11 +0000
Message-Id: <20260803033711.7C6EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] normalize_modname() returns an interior pointer, causing the ori=
ginal heap allocation base pointer to be lost in read_exports() and __find_=
modname().
--

--- Patch [2]: [PATCH 02/14] objtool/klp: Normalize Module.symvers paths to=
 module names ---
commit 8f5aadae3b846aa3bb569cfc55ef783d4449690f
Author: Joe Lawrence <joe.lawrence@redhat.com>

objtool/klp: Normalize Module.symvers paths to module names

This commit normalizes Module.symvers object paths to runtime module names
for exported symbols to prevent a crash during livepatch loading. It extrac=
ts
the module name processing into a shared normalize_modname() helper.

> diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
> index aeb99d572300c..15d37d955af0e 100644
> --- a/tools/objtool/klp-diff.c
> +++ b/tools/objtool/klp-diff.c
> @@ -83,6 +83,35 @@ static char *escape_str(const char *orig)
[ ... ]
> +static char *normalize_modname(char *name)
> +{
> +	char *slash =3D strrchr(name, '/');
> +
> +	if (slash)
> +		name =3D slash + 1;
> +
> +	for (char *c =3D name; *c; c++) {
> +		if (*c =3D=3D '-')
> +			*c =3D '_';
> +		else if (*c =3D=3D '.') {
> +			*c =3D '\0';
> +			break;
> +		}
> +	}
> +	return name;
> +}
> +
>  static int read_exports(void)
>  {
[ ... ]
> @@ -150,6 +179,9 @@ static int read_exports(void)
>  			return -1;
>  		}
> =20
> +		if (strcmp(export->mod, "vmlinux"))
> +			export->mod =3D normalize_modname(export->mod);
> +

[Severity: Medium]
Does this assignment leak the original pointer returned by strdup()?

Looking at read_exports(), export->mod is allocated via strdup() right
before this check:

        export->mod =3D strdup(mod);
        if (!export->mod) {
                ERROR_GLIBC("strdup");
                return -1;
        }

        if (strcmp(export->mod, "vmlinux"))
                export->mod =3D normalize_modname(export->mod);

When processing module paths with a slash, normalize_modname() returns
an interior pointer (slash + 1).

If this offset pointer overwrites export->mod, the original base
address from strdup() is permanently lost.=20

While objtool often relies on process termination for cleanup, if these
strings are ever freed later, passing an interior pointer to free() will
cause an invalid free crash.

Could this be avoided by shifting the string contents in-place with
memmove() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785727106.gi=
t.jpoimboe@kernel.org?part=3D2
