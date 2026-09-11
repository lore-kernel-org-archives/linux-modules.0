Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60831376A12
	for <linux-modules@vger.kernel.org>; Fri, 11 Sep 2026 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138354; cv=none; b=uRQkspDWLDY/FXfU1J6gISIhYlTLB5MI1vimACWzTD3QTZXYuvfZq9DG85KkDXSr5k8np1H9q4Q1ccVugrIXAoFDnuckgF2ed6ROkV3x6/5mppowswxnXvHHVQw/58e/vyubFPPYHy7xqufb3ne1i+t9xjtWsmiyB2YJrXceDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138354; c=relaxed/simple;
	bh=d1e660q0bqMHeE8ElCfB3GFaNqo5AA3j2Q/7I7qwMQk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KoiwFeMchKAryO9Ao45lYb2UXyK/Ya6C4zUhj2r7aW2mdsuW9Ziaz6wnB0y687KLRhsk51tV/Hn8r/WN7uvh4+wjThUiG97Y5xYS4eJ2cV1LKZKsOv/ID59uGnTn3eGD0uUzkZbXHwlF7kPUnnbn4gkCj6kivpGU/UvqoAHuJcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThdpLp6Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThdpLp6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6C61F000FF;
	Fri, 11 Sep 2026 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138352;
	bh=d1e660q0bqMHeE8ElCfB3GFaNqo5AA3j2Q/7I7qwMQk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ThdpLp6Ymp5+O0IUZh/x1c1uKFk57bactIjasF2JEoRcD+0AKJpQv9Z8ZCKr1Oavr
	 5SbW9nTADz2NMJRaxp4D1FnX6hxl07Qrp07Vju9Li/g9/xmO5gVX8MAd7aYlXKFNAK
	 KkU4qnzN0azbJ8JXQP8IC3Mjj4rrJPQl1X6iRAeatsSlspWQXQK/XRja7995aTPRQf
	 0ZUnLtX5ZvAQqOhPlqlt/mRmtSBs5wAuF/c1mw9X+XRG+KxwoknkFd1Yj2h3KMNUkO
	 pzQeXzlshdCqAYci9Pfcjk2Yis7lmn3gVW3KSw6UdKuTk11E0VY2Ks90abvl0AUisU
	 IuvVj0imyY+9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] umh, treewide: Explicitly include linux/umh.h
 where needed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: "Mark Fasheh" <mark@fasheh.com>, "Joseph Qi" <joseph.qi@linux.alibaba.com>, "Anna
 Schumaker" <anna@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, hannes@cmpxchg.org, linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org, "Chuck
 Lever" <cel@kernel.org>, mkoutny@suse.com, "Joel Becker" <jlbec@evilplan.org>, tj@kernel.org
In-Reply-To: <20260911-module-include-kmod-v3-1-6ebccc3e0731@suse.com>
References: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
 <20260911-module-include-kmod-v3-1-6ebccc3e0731@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:52:31 +0000
Message-Id: <20260911145232.3A6C61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

> The usermode helper declarations were previously provided by linux/kmod.h
> but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
> moved them to linux/umh.h in 2017.
>=20
> Add explicit includes of linux/umh.h to files that use usermode helpers a=
nd
> remove linux/kmod.h where it is no longer needed.
>=20
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-module-inc=
lude-kmod-v3-0-6ebccc3e0731@suse.com?part=3D1

