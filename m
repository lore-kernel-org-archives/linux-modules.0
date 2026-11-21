Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795301662;
	b=4Pn6Og25UCthV9s5Q9ESbdXL1EO+55IRie8XvHVXdz+6XIgGLRZGyRJOV4a52+sWTcdI
	 Xx+6T3jfrzWgQWCZYAgMi2VBq7jxCh2/tHyTQ7P9zjmNpAMCkVGSNh32MLSoZBdrtwbOH
	 ypy+DR8mGWndf0WUiO801S2AhwvbT5fA2+rZEX0Gnx5o91Pcsklln54PB3bVJNwM7pwNU
	 zCMociWqkhTwCX/T8XAA45MtIS2nYTqWFIYcjZy+J6kJAtTIPkvr7LEu4dLQXF6H1zwXY
	 70a9RkEIb5FrsKD/qTi0/pI+CRGNxp0n40aRrxQYJu2l17v+Knti9R87o30Hvxrw8mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795301662;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ikhh2eq1MdZyQhVRZ2mvDHA+O+UuzEjUvExJW+1rcVQ=;
	b=FOf6Z5ozbdVwkaw18++ju6SF8+Z6R0pXKMa09yXuPvLzs4d+eCS5UUaYE7GtPmic5MoL
	 t1UP50F5PkKJel0uvTSfjeqpMhzski1HD5fML0Phy7Xr090TuMjN5+mNWE2Bzhs1tzsTr
	 UDLMPymebLSjn/Usl6VsjDCKIZW9kfcaGBclcWxNn3/t0P7Qv6zggIWj6wfSuEorCqq0/
	 kUzU9EQ5BoJfKsfzAv+Jq9xR4oHB4NbR4QPNYMpA313oEIbyG0++6B8WfD6TrEDlVvnGB
	 ihGSteP8h2fcHUmCxs2kSw4X7FHxjW6ItnDHqM0+0NLYVisK2e+J06XmkEgKYTBZc6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHaebq8K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060D606A320
	for <linux-modules@vger.kernel.org>; Sat, 21 Nov 2026 22:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHaebq8K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB5F1F000C0;
	Sat, 21 Nov 2026 22:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795301662;
	bh=Ikhh2eq1MdZyQhVRZ2mvDHA+O+UuzEjUvExJW+1rcVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BHaebq8KZ7z64Gr+/FPkHBYGQs2Eu/Mxs3QwGEIIcGkT/ULG1k0ezW4XBoMOB2/oi
	 LmEBOu39BIofp1Qb4+fO57SEMZn+wBp6vaNytxU/yc6DRjyOzscgc0zBcWMJLFnWvV
	 3JVMiplG6daDR5TdThkprv5qajwS4s41uUK2Z6xM/j70ymclc6K2HWwquuZEwPr+F5
	 cm33HwaJAtf+g86oYijBSq/9P1chuYrTmH7kTpIEpHt0d+H/x040WzW2gVs3q/CeU0
	 b+SKCvqNnjg9B4dGGTdBEo5hFvdj+pGRpId1Db9jM8sJRsThnLN+95MoQ7saWAG0h0
	 si+1OiopiVuLw==
Message-ID: <sashiko-outbox-227475@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] checkpatch.pl: generalize linker script macro
 exceptions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>
In-Reply-To: <20261121-vmlinux-lds-v1-6-49818f3f5cc0@gmail.com>
References: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
 <20261121-vmlinux-lds-v1-6-49818f3f5cc0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 22:54:21 +0000
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] checkpatch: literal slash in regex in process() breaks
  *.lds.h matching
--

commit 1481804dada7e62db737a08856db566e01d7b6bb
Author: Jim Cromie <jim.cromie@gmail.com>

checkpatch.pl: generalize linker script macro exceptions

This commit replaces three explicit vmlinux.lds.h path checks in process()
with a pattern intended to match any *.lds.h linker script header.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index b8b64f7201915..318e1f2577fd4 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6016,7 +6016,7 @@ sub process {
>  # Usually multi-statement macros should be enclosed in a do {} while
>  # (0) loop.  Grab the first statement and ensure its the whole macro
>  # if its not enclosed in a known good container
> -		if ($realfile !~ m@/vmlinux.lds.h$@ &&
> +		if ($realfile !~ m@/\.lds\.h$@ &&
>  		    $line =3D~ /^.\s*\#\s*define\s*$Ident(\()?/) {
>  			my $ln =3D $linenr;
>  			my $cnt =3D $realcnt;
> @@ -6175,7 +6175,7 @@ sub process {
> =20
>  # check for line continuations outside of #defines, preprocessor #, and =
asm
> =20
> -		} elsif ($realfile =3D~ m@/vmlinux.lds.h$@) {
> +		} elsif ($realfile =3D~ m@/\.lds\.h$@) {
>  		    $line =3D~ s/(\w+)/$maybe_linker_symbol{$1}++/ge;
>  		    #print "REAL: $realfile\nln: $line\nkeys:", sort keys %maybe_linke=
r_symbol;
>  		} else {
> @@ -6192,7 +6192,7 @@ sub process {
>  # single-statement macros do not need to be enclosed in do while (0) loo=
p,
>  # macro should not end with a semicolon
>  		if ($perl_version_ok &&
> -		    $realfile !~ m@/vmlinux.lds.h$@ &&
> +		    $realfile !~ m@/\.lds\.h$@ &&
>  		    $line =3D~ /^.\s*\#\s*define\s+$Ident(\()?/) {
>  			my $ln =3D $linenr;
>  			my $cnt =3D $realcnt;

[Severity: Medium]
Does m@/\.lds\.h$@ fail to match vmlinux.lds.h and other *.lds.h files?

Because m@...@ uses @ as the regex delimiter, the leading / is matched as
a literal path separator, so the pattern only matches a file literally
named .lds.h.  As a result, this regression causes checkpatch to stop
excluding vmlinux.lds.h and other *.lds.h headers from macro and line
continuation checks (unlike the earlier m@.*\.lds\.h$@ check in
process()).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-vmlinux-ld=
s-v1-0-49818f3f5cc0@gmail.com?part=3D6
