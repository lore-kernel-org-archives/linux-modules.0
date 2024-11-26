Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC41D45EF;
	Tue, 26 Nov 2024 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646762; cv=none; b=X3Ok6H6MiqlbyLEgWAmd5Jb6f4KhRZugjV4MIWJro6559oFUsAyvFvknQqgznzmNSygOijsrF2LfO7VoGJOVqZ0qYM6jIdcByMfx9j3JtFY6ifZr5zY3MsU9lg98ScSSqDfMwUY+Jv0mJHlFWAaAMKlUYdhlIY6A+l2YDKFD/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646762; c=relaxed/simple;
	bh=Pokx8t1BVIEDen+c8yz2MWmOH0ECe7Yvn4d7gHgLk1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5tqqG30HHG7J2bo3NP2RfVhe9uNrhyxjLFK3kwUphEWZaMPxg0Feb65jN4hr51BRkYFv+vRUC+PBkz+KdZLQLAkKJR70lx+ILXPvnLPmaSZyd/FuZGG9qvyk0GrK/rLgtZ9rjF5I6WSPEXXUXGbfVH1IPc01Q+kg9IFf1f4o8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEdWpo8H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEdWpo8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C272C4CECF;
	Tue, 26 Nov 2024 18:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732646762;
	bh=Pokx8t1BVIEDen+c8yz2MWmOH0ECe7Yvn4d7gHgLk1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEdWpo8HiZ1zL2rudJC6okCbAnW4JcGCE+lC3dX9ESQIgjlQ5CuKTEItiXemMqd0p
	 TF9bqGvP49IgpyMYxLl/UJLQRyErlIhdZwTZLs3M/Gw771YU78jji4bdytXd4jVHCt
	 zrjm4x3ZbLpx+psssTZse9C8uttm2x2lKqP+5zSHyrOLGg/sfN6yJO8g79COfZ/4gU
	 DFxKjULhZt9y+bGviQII7B2m6AbyLK7B4etW1SCHyIjiC5KdjY7Hvk3ehBfksJrZ17
	 fPvgmDpgd1eCV5xMxA+5lv4TUg61AIV/ffBbIEQaRNTl+pX8qwkcb6l8DXZXRLJIhC
	 NE0UWGxDE1A5A==
Date: Tue, 26 Nov 2024 10:46:00 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Song Chen <chensong_2000@189.cn>, samitolvanen@google.com,
	da.gomez@samsung.com, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH] kmod: verify module name before invoking modprobe
Message-ID: <Z0YXaN1dHnEFUluE@bombadil.infradead.org>
References: <20241110114233.97169-1-chensong_2000@189.cn>
 <21423aea-65c3-430e-932d-2ba70b6b9ac3@suse.com>
 <524b444f-4b81-4005-b93a-39b7d3fd3db1@189.cn>
 <8ea8dfed-608f-44b9-8adb-fb1798619215@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ea8dfed-608f-44b9-8adb-fb1798619215@suse.com>

On Mon, Nov 18, 2024 at 01:54:14PM +0100, Petr Pavlu wrote:
> I'm however not sure about rejecting empty strings as is also done by
> the patch. Consider a call to request_module("mod%s", suffix) where the
> suffix could be empty to select the default variant, or non-empty to
> select e.g. some optimized version of the module. Only the caller knows
> if the suffix being empty is valid or not.
> 
> I've checked if this pattern is currently used in the kernel and wasn't
> able to find anything, so that is good. However, I'm not sure if
> request_module() should flat-out reject this use.

This patch also fails to pass a simple boot test with our Linux kernel
modules CI:

https://github.com/linux-kdevops/kdevops/blob/main/docs/kernel-ci/linux-modules-kdevops-ci.md
https://patchwork.kernel.org/project/linux-modules/patch/20241110114233.97169-1-chensong_2000@189.cn/

For persistent results see this and download the tarball for results:

https://github.com/search?q=repo%3Alinux-kdevops%2Fkdevops-results-archive+is%3Acommit+%22linux-modules-kpd%3A%22&type=commits

So please boot test any future patch before posting and make sure its
based on modules-next:

https://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/
modules-next

You can reproduce yourself with kdevops [0]:

make selftests-modules
make -j80
make bringup
make linux # it fails here with your patch applied
make selftests-baseline

For a more elaborate description of our CI setup:

https://github.com/linux-kdevops/kdevops/blob/main/docs/kernel-ci/README.md

[0] https://github.com/linux-kdevops/kdevops

  Luis
