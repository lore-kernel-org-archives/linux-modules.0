Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C7D379C5C
	for <linux-modules@vger.kernel.org>; Tue, 15 Sep 2026 07:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789456212; cv=none; b=IZojhOz5KeisYoCfbjdfHw2TZUH1cyMcP4VFrrK3O9F93QaUyelKuSZRISGR6AAXFWLphd7Krcc/GQl5dD9B68yr9xTol9dZF5Yq9FEJt+gRHAK/w4qjEuu+WnJqG5D1BTbhNC+Mewid52bhlSY7ZE5x7pycrOY4AdelCLsgx5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789456212; c=relaxed/simple;
	bh=LIwSniWOgFPhhyLTqGccqzKIq8MrM+Dl44OlE7NjnW4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fWNFfpUDbf3EeCen01BbV+qV0pkedV8dghbLYvI94ciH3PTZR3JKy4BJJvzCBcVI5L3j8vhSc1EA2/K0Y8+lR7WAar1AE1Ok/g8b9ayO6bdwhoFvIOn+NBnpgngr3kz3ZirvZ6qUpVzVzc46q/UQExgdIzbJov7onQkQIwfLCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLpZ8j6Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLpZ8j6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C93B1F000FF;
	Tue, 15 Sep 2026 07:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789456210;
	bh=rBgKMYvhiNBAsH1W7IYUZMxTqhcKrKPZ2y8OC2p/PIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XLpZ8j6YJ5oG/e0AXWm7HaH8AmnfEuto1W9LXNS8TbI5cxN4SAdhwpxwhcdcJGJNu
	 ttgSEkj+/iWgkotItRhqxAe7hvwwf8zH5UsbqdQpx/cphjw0rZVrNK9YfV3Dm1aUzU
	 kzKwcVtlgtVcQradnaMjkyMauW2qr9lPVcEVTKIi1ItBTaSLk6iDMuLKC0bd8xZ3ls
	 ujCsEZpjirw80PA0lzdak+HUom6HNUOGWa0OdcR87ksefJrXT7W9pkhNC/LWiMmpne
	 dJQMebEYcwmAkXdnCkL1XREMle3OZm23geB8+0vEy8wyO+tZfnEeur+mmuO9jUmjNC
	 9Hb36BSM10HrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/6] alloc_tag: Defer /proc/allocinfo removal to a
 workqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Ge" <hao.ge@linux.dev>
Cc: linux-modules@vger.kernel.org
In-Reply-To: <20260915070001.113559-7-hao.ge@linux.dev>
References: <20260915070001.113559-1-hao.ge@linux.dev>
 <20260915070001.113559-7-hao.ge@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 07:10:10 +0000
Message-Id: <20260915071010.8C93B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: memory leak in alloc_tag_init() when proc_create() fails
--

commit 4e566e12e21d0ae73ee9a25235cceeeff9cef087
Author: Hao Ge <hao.ge@linux.dev>

alloc_tag: Defer /proc/allocinfo removal to a workqueue

shutdown_mem_profiling() calls remove_proc_entry() from
reserve_module_tags(), which runs under mod_lock held for write.
remove_proc_entry() waits for readers, and a reader takes mod_lock for
read in allocinfo_start(). This commit moves remove_proc_entry() to a
workqueue and relocates file creation to avoid panics.

> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 1ca0409b492b8..cfa0fc84b68f9 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c

[ ... ]

> @@ -1358,16 +1366,10 @@ static int __init alloc_tag_init(void)
>  		return 0;
>  	}
> =20
> -	if (!proc_create(ALLOCINFO_FILE_NAME, 0400, NULL, &allocinfo_proc_ops))=
 {
> -		pr_err("Failed to create %s file\n", ALLOCINFO_FILE_NAME);
> -		shutdown_mem_profiling(false);
> -		return -ENOMEM;
> -	}
> -
>  	res =3D alloc_mod_tags_mem();
>  	if (res) {
>  		pr_err("Failed to reserve address space for module tags, errno =3D %d\=
n", res);
> -		shutdown_mem_profiling(true);
> +		shutdown_mem_profiling(false);
>  		return res;
>  	}
> =20
> @@ -1375,10 +1377,16 @@ static int __init alloc_tag_init(void)
>  	if (IS_ERR(alloc_tag_cttype)) {
>  		pr_err("Allocation tags registration failed, errno =3D %pe\n", alloc_t=
ag_cttype);
>  		free_mod_tags_mem();
> -		shutdown_mem_profiling(true);
> +		shutdown_mem_profiling(false);
>  		return PTR_ERR(alloc_tag_cttype);
>  	}
> =20
> +	if (!proc_create(ALLOCINFO_FILE_NAME, 0400, NULL, &allocinfo_proc_ops))=
 {
> +		pr_err("Failed to create %s file\n", ALLOCINFO_FILE_NAME);
> +		shutdown_mem_profiling(false);
> +		return -ENOMEM;

[Severity: Medium]
Does this code leak the memory allocated by alloc_mod_tags_mem()?

Since the proc_create() call was relocated to execute after
alloc_mod_tags_mem(), this error path seems to exit without unwinding the
previous allocation by calling free_mod_tags_mem(), directly introducing a
memory leak when procfs creation fails in mm/alloc_tag.c:alloc_tag_init().

> +	}
> +
>  	return 0;
>  }
>  module_init(alloc_tag_init);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915070001.1135=
59-1-hao.ge@linux.dev?part=3D6
