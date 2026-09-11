Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C802736B915
	for <linux-modules@vger.kernel.org>; Fri, 11 Sep 2026 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138353; cv=none; b=Z3BW9qoogweHaAcJvQl0HVeto3pokSV3sRslSbGbJ0b0pN4low+DGn77my9tvE4MfOf6g3MzO1O6vcDLIVQH7Xh/POKG27ib0TlYbaRFkW4iTptN7PpfTxNFA9jvKax7Qk9t/aoi7aOiz56C8/sqPs8sgdxqjHWUjdQILU5awz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138353; c=relaxed/simple;
	bh=ozHRLiliFMnW1SlnGtObXJsv2wh4qQXUNrJrJq2vbBY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q5/QVJJGaJ8YVNGl84YxqZe6bW+ikVyUsLwJ5FgKagLRQkd/1fSPrQmuW2JbqYccDjaKTmc06my/NYO7J8DFNMW/bg6FQnytIwMmr/ziho9vwYW4IP0MfDIq2BUk2PRxjS8BdVMMRwPjE6arhKkImR4DNewMp/jU1QcIlM7haw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYyTGXyi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYyTGXyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1981F00898;
	Fri, 11 Sep 2026 14:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138351;
	bh=ozHRLiliFMnW1SlnGtObXJsv2wh4qQXUNrJrJq2vbBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gYyTGXyiongFnx2ZCzh5d07wpg7CShCsdCRZkalAoax++3dgFnh3zWhDdjULqb/EL
	 YCGgAJG4TFH7mPOz1Jm9Lcm4LxJ+WxU8u/X68cq0SnxKi2kzYOYnmdbGukbv4MOXge
	 znV40VohLRIwK7f6qcq9MpgLhGl9qidTJ1/A1hqePyKrtgb+4P/9L3br4xSgHRZzdU
	 GwdUFGU3R442JNmDxHhN0usRzgKMYxKA3McRrBNqkUe2dUY5pbgUJBlyLkkioQFsWj
	 okjaDXeHx2/uSACNEF8vyi+B5IZOD39cSRXlJI0NwVBlCOVx0O0J+qOaI6ZnzPSEro
	 cCt20HtI1DDTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] module: Bring includes in linux/kmod.h up to
 date
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, "Mark Fasheh" <mark@fasheh.com>, "Joel
 Becker" <jlbec@evilplan.org>, "Anna Schumaker" <anna@kernel.org>, "Chuck
 Lever" <cel@kernel.org>, hannes@cmpxchg.org, mkoutny@suse.com, "Joseph Qi" <joseph.qi@linux.alibaba.com>, "Jeff
 Layton" <jlayton@kernel.org>, linux-modules@vger.kernel.org
In-Reply-To: <20260911-module-include-kmod-v3-3-6ebccc3e0731@suse.com>
References: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
 <20260911-module-include-kmod-v3-3-6ebccc3e0731@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:52:30 +0000
Message-Id: <20260911145231.1D1981F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

> Including linux/kmod.h alone results in 1.5 MB of preprocessed output, ev=
en
> though it provides only a few functions and macros.
>=20
> The header currently depends on:
>=20
> * __printf() -> linux/compiler_attributes.h,
> * ENOSYS -> linux/errno.h,
> * bool -> linux/types.h.
>=20
> Include only these files, reducing the preprocessed output to 10 kB.
>=20
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-module-inc=
lude-kmod-v3-0-6ebccc3e0731@suse.com?part=3D3

