Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24416217F5C;
	Fri, 18 Apr 2025 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998862; cv=none; b=JWG+X7mAAZlaxjruv+MEkTTWuEEXJSGhswQhzXhtzUDtuw99h+EZyg5G2y6IXEbwb2+/i+IMzM29234CKlUIbGcIo4wKvFY6HjDTqQvY8wIT2p45hCoYeJgqQugxVuww6aCaPuI6NE9O6ltvKgpKiWDX3lG6HZ+QIGHc+VVSBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998862; c=relaxed/simple;
	bh=9cYa1Hm/dFyTJ7WGFSaj4hjXw2maM5HCA6uwj7QdIxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBjUe57eHJ0UgGMY95e8S4LyqKnNzGX100DQxOGKMs8rY4wl7rIDUBoDnCYGFxEtyKNRcgC461G9pm1BFJXhdrkqenl+kif9ZmEdv0zFHYjrfgkS/nLBTihfnsZRAK/6+rnWyor4XH/tpZPtdDuJzWfgMMeNV4H/pbyhb5c/l7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ttdsx5d1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ttdsx5d1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6F3C4CEE2;
	Fri, 18 Apr 2025 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744998860;
	bh=9cYa1Hm/dFyTJ7WGFSaj4hjXw2maM5HCA6uwj7QdIxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ttdsx5d10ynpzoY1bodLZebYNr8zFQyvsRK9Fu19mESmvye77khnlf7OuOUl+HD6y
	 uOygUTmkj5SAFQNB6ZvlhmdnNADCvVU1cMjrJOgFwSo+x11lX3aGXbTPGkYNNM+itX
	 JX8FGI1glMVpVrJeErhf3Mt4izT+S1bAA7+Yv2MdAbuE/wYjtcnZfQQ6QUXOnGDU+e
	 DhaR8XWlGyeq49n2gWAJ6e8dr3SYrH86aK8yrFfAMMETu/QDD7YJV9Bro3e/yKeZFU
	 b3htj7DEcSeCH3tTdcnoj2vXGUsECeUM4TZdlQMMWopyzQIEkaFQmbcNtBHayIFvsm
	 R1d8yD5hWk/KA==
Date: Fri, 18 Apr 2025 10:54:18 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Herton R. Krzesinski" <herton@redhat.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, petr.pavlu@suse.com,
	samitolvanen@google.com, da.gomez@samsung.com, nathan@kernel.org
Subject: Re: [PATCH v2] lib/test_kmod: do not hardcode/depend on any
 filesystem
Message-ID: <aAKRygQdkdlyZ_ai@bombadil.infradead.org>
References: <20250418165047.702487-1-herton@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418165047.702487-1-herton@redhat.com>

On Fri, Apr 18, 2025 at 01:50:47PM -0300, Herton R. Krzesinski wrote:
> Right now test_kmod has hardcoded dependencies on btrfs/xfs. That
> is not optimal since you end up needing to select/build them, but it
> is not really required since other fs could be selected for the testing.
> Also, we can't change the default/driver module used for testing on
> initialization.
> 
> Thus make it more generic: introduce two module parameters (start_driver
> and start_test_fs), which allow to select which modules/fs to use for
> the testing on test_kmod initialization. Then it's up to the user to
> select which modules/fs to use for testing based on his config. However,
> keep test_module as required default.
> 
> This way, config/modules becomes selectable as when the testing is done
> from selftests (userspace).
> 
> While at it, also change trigger_config_run_type, since at module
> initialization we already set the defaults at __kmod_config_init and
> should not need to do it again in test_kmod_init(), thus we can
> avoid to again set test_driver/test_fs.
> 
> v2: also update tools/testing/selftests/kmod/config with the removed
> dependencies.
> 
> Signed-off-by: Herton R. Krzesinski <herton@redhat.com>

Reviewed-by: Luis Chambelrain <mcgrof@kernel.org>

  Luis
