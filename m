Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D953AA502
	for <linux-modules@vger.kernel.org>; Tue,  2 Jun 2026 23:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780441465; cv=none; b=Y1jHXyFcLmCLo0IAMwFfZpKTnlovak11HTvLfLn3LE1YMDySXQfeVKnarr3XsY+zsKYEHHX6FEqV7WGi4+x0EcoB7scDbbF7EOnBqeNn8/ifpz4AO4kmggfYYSrD4P6RPvb5Y6HUALV2y0ApTwTjo8pXcC0fkakLmrIgwvOJA/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780441465; c=relaxed/simple;
	bh=UJzgVoSfZxGf5Dfa9HDxqbVfQ2RGGdwlMIqiVF6Vwzs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oANM+Qhy9feVSBUEB+3ot4Uj6hKuJ3/o7+l+v6pSabmXpqcz0I1DVVXGDR8Omg8fHzJbL3hkdQsKpH/MS15WNHI24Ivk099gQqtU6pKnD1Qp/cCh88OAawgJ2qfm/MTkphzVrxXHp9055+u7hDgkwkBlF9KVUPOd/MF8yj7FMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CizY8bl+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CizY8bl+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F0C1F00893;
	Tue,  2 Jun 2026 23:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780441464;
	bh=e8pD82abenmhtzUS6zrV0kfI/f9uAit9BPSAUHZjHJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CizY8bl+eS1Lm8sYyF1fxOJj+9LOpdKloDuZTuir7aHwYxzXbf8cWpTPODofFIiXl
	 EhTG/q2+wgM7xnB7bR+PtvI1iptCQgnQvPnlQ6sAsI17Ny0sVsuMDjQOfiGSpu1VWa
	 sbhfCcjb4IDwXv8an7iq6sLSbD1M2/KH4qEMEeC1UkQROQETkpWQMd2Sp9KmMN2yyF
	 baQZfEpDKwKvGJM4Swb5BqjixpcthV1b0+qxw3VsTlclBdQjEvQibZzEMw5OCI8gun
	 iznqbY5M5GBgPAENL7bHV5n0koud/70R+brHW2/icPebUFTf/fqM9So0JduuyrP0uH
	 XU3lXmCT9SMHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/25] dyndbg: Upgrade class param storage to u64 for
 64-bit classmaps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260602-dd-maint-2-v4-18-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-18-19a1445585a8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 23:04:23 +0000
Message-Id: <20260602230424.61F0C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete 64-bit conversion in `drm_debug_enabled_raw()` prevents =
checking categories >=3D 32 on 32-bit architectures.
--

commit 9ed1108f13f83f85b038d937d383fae3b647f69a
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: Upgrade class param storage to u64 for 64-bit classmaps
   =20
This commit upgrades the dynamic debug class parameter storage to u64 to
support 64-bit classmaps without truncation on 32-bit architectures. It also
updates __drm_debug to use u64.

> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index ab017b05e1751..21a0ced0b2f20 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -39,7 +39,7 @@ struct drm_device;
>  struct seq_file;
> =20
>  /* Do *not* use outside of drm_print.[ch]! */
> -extern unsigned long __drm_debug;
> +extern u64 __drm_debug;

[Severity: Low]
With __drm_debug upgraded to u64, does drm_debug_enabled_raw() also need
to be updated to use BIT_ULL() instead of BIT()?

Currently it evaluates using BIT():

static inline bool drm_debug_enabled_raw(enum drm_debug_category category)
{
	return unlikely(__drm_debug & BIT(category));
}

On 32-bit architectures, BIT() evaluates to a 32-bit unsigned long. While
this might not cause issues right now with the current number of debug
categories, it limits the 64-bit conversion and prevents checking categories
>=3D 32 since the bitwise operation would evaluate as 32-bit before the che=
ck
against __drm_debug.

Since the commit message notes "further changes to drm later", is this
already planned for a follow-up patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-dd-maint-2=
-v4-0-19a1445585a8@gmail.com?part=3D18
