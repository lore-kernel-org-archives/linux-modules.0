Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF08136A340
	for <linux-modules@vger.kernel.org>; Fri, 11 Sep 2026 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138352; cv=none; b=kn6PjJf1rWnGaNJLVPb11YiiXIFIzwOY8iknShARxL6cF4MW7zkfhyODMmmbmuTTH0u396XwYi2DoHfwCWD9TuVEyPg+58mffYNcCje2fbMvycZhMVBqrnQ2rfwo4mVbMb19/n+1xq8BXRqBCGGKuliOcBCeDsfPOWyprzY4rZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138352; c=relaxed/simple;
	bh=sVfwpVRyt/VC/mMjuLzN3CzfiY31hqAWvVtTiSgiWp4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RRMvefKX4U3+j34Mqw/LQJxNQD/yEhh0vHBfiXwefLjEMP2A7t8L5zCN271VXpxjxkcO7pNLqaP47+u2Pxpcj2rapYwSsPg17/cfmu+uVgjN4e9jAypXC/xSJtJSf31JWUmsFA69frYENHP+oUOw05g4wzHAvcuZPmwFY1e064U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCBwWXTu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCBwWXTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AAB1F000FF;
	Fri, 11 Sep 2026 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138350;
	bh=sVfwpVRyt/VC/mMjuLzN3CzfiY31hqAWvVtTiSgiWp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dCBwWXTu8eJXbblv1rr5FJS8lhcDAFXKt0sUgVA4dJx1CaUO3egUcL8XY3R5zTcoP
	 F3ZpKHrybCbMBAo7x/cJuYTTZTGrt+ENZQQtaOiAYoBKWhOh1GyZE/gNNPWZGnYyrG
	 gTEVJOfvC7GQT3oNelLAP8HRyWRyKkw79XlCDa1RBWPReUsReitE9Q25zBbXrWWI3Y
	 vlAWrYqXj/sLRzmpyFLztcmx9TVEnRJLlRX/zeFdHsjWZj1HmaXOxUW1r1WiZ7EDcX
	 fV6lHJFlo3yt50YSfHImFXMaWibOd6FJZCrL0ZTMeA96McWUEx5zmiswuHWXdnZE8v
	 FeApGxMugkHbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] time/jiffies: Include linux/sysctl.h for
 proc_int_u2k_conv_uop(), ...
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: "Mark Fasheh" <mark@fasheh.com>, tj@kernel.org, "Anna Schumaker" <anna@kernel.org>, mkoutny@suse.com, dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, hannes@cmpxchg.org, "Chuck Lever" <cel@kernel.org>, "Joseph
 Qi" <joseph.qi@linux.alibaba.com>, "Joel Becker" <jlbec@evilplan.org>
In-Reply-To: <20260911-module-include-kmod-v3-2-6ebccc3e0731@suse.com>
References: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
 <20260911-module-include-kmod-v3-2-6ebccc3e0731@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:52:29 +0000
Message-Id: <20260911145230.00AAB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

> jiffies.c uses proc_int_u2k_conv_uop(), proc_int_k2u_conv_kop(),
> proc_int_conv(), proc_dointvec_conv() and proc_doulongvec_minmax_conv(),
> which are declared in linux/sysctl.h. It currently gets that header
> indirectly through linux/module.h -> linux/kmod.h, but the latter no long=
er
> needs to include linux/sysctl.h.
>=20
> Include linux/sysctl.h directly in jiffies.c ahead of removing the
> unnecessary include from linux/kmod.h.
>=20
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-module-inc=
lude-kmod-v3-0-6ebccc3e0731@suse.com?part=3D2

