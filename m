Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8223279EA;
	Fri, 18 Apr 2025 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744935293; cv=none; b=IEbMXUzL5LXyfSHf/agWB1W4LM2FTwGxiW0BLx3XLhExGQwHMippcHib5S8FBd4MWCqI573zHB8WFN1wYCfRYDnVh3iyi3NJ3GaWD9ED28Jg/vPCE91iL73/wfboVW2p1u/8xYTZh33H8QhE3avBsSjP4wG2IcBATTNB8XQflvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744935293; c=relaxed/simple;
	bh=hE3gi+RaoNDxs30dIL2e2OznMaVZAykaUs9GDtNTaaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBd2JQzXTbsDP5S/MhRp1zVJvRZfvXcevCDzRmyZ6R3lx1RIXMjtAdhiM9q7/8EqjJW6FjLX/iShcIeso9Q/u/+f3aotk2yHz+xkrXjI+zpZEPNhxwnVS/CNTc9fqWGev6Id6NKW6lZKiBOjm0g4DnxFfNU436+ehisIYK0GEBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d52cTEIj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d52cTEIj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F50C4CEE4;
	Fri, 18 Apr 2025 00:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744935292;
	bh=hE3gi+RaoNDxs30dIL2e2OznMaVZAykaUs9GDtNTaaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d52cTEIjeD1oQVkyEvbRncjn5YFqK10TocTOu2X+QfNo8sj0cURh3U3+8dwRFDggN
	 SRNqR1tdvbousQnZPHtGbktrPgjmrfgjEPxIweyT3d+GWKBfpH/3Eej8lgxclFXIP/
	 VwSaSRF4IftizWRzpskhgti+xGkkn1IDgAqchfRg+usEzsJG7eVg8XDmO1g3dGOkny
	 02SJ+TcHc3lVJ6RMNL5MCdIOm3Fa90LxRA9Lj2eh5W8eibDRYuuH9uAwcrIP1+ljDM
	 u58WVZe0d6kSQuzuwrhL9qmdNpY0Vxj6X7Ao4KpYnbjT0CgvD3OYQPb/N1C8nib31A
	 qKh2FKxVJSf+Q==
Date: Thu, 17 Apr 2025 17:14:51 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Herton R. Krzesinski" <herton@redhat.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, petr.pavlu@suse.com,
	samitolvanen@google.com, da.gomez@samsung.com
Subject: Re: [PATCH] lib/test_kmod: do not hardcode/depend on any filesystem
Message-ID: <aAGZe_mDBZ7DcG2o@bombadil.infradead.org>
References: <20250418000834.672343-1-herton@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418000834.672343-1-herton@redhat.com>

On Thu, Apr 17, 2025 at 09:08:34PM -0300, Herton R. Krzesinski wrote:
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
> Signed-off-by: Herton R. Krzesinski <herton@redhat.com>
> ---
>  lib/Kconfig.debug |  6 -----
>  lib/test_kmod.c   | 64 +++++++++++++++++++++++++----------------------
>  2 files changed, 34 insertions(+), 36 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 9fe4d8dfe578..1e0f8cbf0365 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2983,13 +2983,7 @@ config TEST_DYNAMIC_DEBUG
>  config TEST_KMOD
>  	tristate "kmod stress tester"
>  	depends on m
> -	depends on NETDEVICES && NET_CORE && INET # for TUN
> -	depends on BLOCK
> -	depends on PAGE_SIZE_LESS_THAN_256KB # for BTRFS

Please read the commit log that added PAGE_SIZE_LESS_THAN_256KB, what
do we want to do about those complaining about that? Maybe Cc the
author of that patch.

Other than that, it looks good to me. Did you run the selftest?

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
