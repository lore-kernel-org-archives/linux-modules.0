Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89879417D8E
	for <linux-modules@vger.kernel.org>; Mon, 20 Jul 2026 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550765; cv=none; b=XiRV/n2/ABnIMUACqDvwDR0A9Ds+AvBUBhDjB5gcc2B06Yw9Q7gJ1uhkQEP8WDLosaTUxT5BJe+6Gxf2z+vB6hrxhafDpIYR+Vv4/wWnjQZFGko7z0L1+AIx9c+tiu2KfFTkcNjlcpl/ehDL77XUWwlZESYHtizbRSnWZrJUeSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550765; c=relaxed/simple;
	bh=xTHLIk37Eq+w+KQBQgARISE8w/0yCI8vsnAkP+I4apQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IzTlDoRhgCvo+CMMU9UzdfaEi2NlMVAuff7Pg1zupioIAXNn+8Yh50xHBsl06YTlxfK+6W2rIlmW18yannkZnPDtWQFjvQYcYwpjCOUgHfZ8WIVfChF2eZoqRB0ij1B7cKf2ZxZRheHP8e5RdlQSiF5f2qinOy5WHL2X3uhKHak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y23IxL9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y23IxL9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8D01F00A3A;
	Mon, 20 Jul 2026 12:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784550764;
	bh=chxKrjACihObeZE9lHene/pQ91WxJyKi7rDew/Qivmw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y23IxL9NcCGQT5i28BOzCNlYeHqD++Wkrs3gHaZBVXT28AHUUIjCTjfzkwcddywDc
	 vFxUcgxbtMUxAavbHJSVWtX/RzecuLxhtWSh0HN0tN4HazGc165c8R6PPEHi9mZtjy
	 Ai8pYNxMGXRGns7iM35E9rSY1lzd7J7C2s8lzKT3Wo00vBFfeUujdzJ+Vi92ZKwnU8
	 5vgO0z24cG/FTpb+OsR9ZSZMLo+vHHZJe5svFJnZw/XUwKb9IOjJO2rQmvrVGGi2IW
	 XL2WrG36D5ma4WUEExIYgm/5POh1OrcsRU7a8tNxspgF9MRzCWfKazFA6Au/LxtEoE
	 GqiOTLUfz9fig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] module/dups: Clean up includes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260720121621.750661-6-petr.pavlu@suse.com>
References: <20260720121621.750661-1-petr.pavlu@suse.com>
 <20260720121621.750661-6-petr.pavlu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 12:32:43 +0000
Message-Id: <20260720123244.4F8D01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The function `kmod_dup_request_exists_wait()` mixes `goto`-based er=
ror/cleanup handling with `scoped_guard()` declarations, violating subsyste=
m guidelines.
--

--- Patch [5]: [PATCH 5/5] module/dups: Clean up includes ---
commit 94d1ce7350f8ea78793315796cdc680daf4e1298
Author: Petr Pavlu <petr.pavlu@suse.com>

module/dups: Clean up includes

This patch cleans up the #include directives in kernel/module/dups.c.
It explicitly includes the headers for all definitions and functions
relied upon by the file.

> diff --git a/kernel/module/dups.c b/kernel/module/dups.c
> index 43cec4cec4fdb..76faa662f14d8 100644
> --- a/kernel/module/dups.c
> +++ b/kernel/module/dups.c
> @@ -7,30 +7,22 @@
> =20
>  #define pr_fmt(fmt)     "module: " fmt
> =20
> +#include <linux/bug.h>
> +#include <linux/cleanup.h>

[Severity: Low]
Does kmod_dup_request_exists_wait() violate the cleanup subsystem guidelines
by mixing goto labels and scoped_guard() declarations?

kernel/module/dups.c:kmod_dup_request_exists_wait() {
	...
	scoped_guard(mutex, &kmod_dup_mutex) {
		kmod_req =3D kmod_dup_request_lookup(module_name);
		if (kmod_req) {
			get_kmod_req(kmod_req);
			goto dup_req;
		}
		...
	}
	...
dup_req:
	...
	if (!wait) {
		...
		goto out;
	}
	...
out:
	put_kmod_req(kmod_req);
	return true;
}

The cleanup subsystem guidelines expect that usage of goto and cleanup
helpers are never mixed in the same function.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720121621.7506=
61-1-petr.pavlu@suse.com?part=3D5
