Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD8F9C0;
	Sat,  5 Jul 2025 01:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751679001; cv=none; b=VII4g30qJiIyEXqNyDrnvcNz0+boA6AlUnX9uuoW4+xaPubb2raNbaDWLGGkH7JAvh9zPjIhpDMwP1D2oZmi8H5tcS1iwZs2CjOcO8r8e7pmgJnKnyWKmq/mYQgIWTgXSzluiSxZbDlrTMCXPut/dVqClH1rsJJZQZ984DW8Hv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751679001; c=relaxed/simple;
	bh=3/J0WWh19RKWl2SE/iZvbcpt1fwAZDP1U6IABhgKVrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxjdyjZFzoXerWDhql175goN5rwFhpGO5ejHZyNXnxlgjXWD2SO5mAB1MBQA/17Hx+iE8Xi7+u6YN8b8ZLbizr2+gF+ekxP9nHsEnUTsQr08OkVcKTXhT/M8rBxBABO7cUqJa89wh4i9Rt3faz9KVTS2KmDMAi9m8+3rUbnHmFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAUk5igQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAUk5igQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030C4C4CEE3;
	Sat,  5 Jul 2025 01:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751679001;
	bh=3/J0WWh19RKWl2SE/iZvbcpt1fwAZDP1U6IABhgKVrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jAUk5igQbUHFfiwnJo5o7hpdUfZVXoU3p+sVzR60YUH7PmLNG3UVMHDdE4T1gSbxO
	 XIOMl1htYHfkQP5AHf26reOgbAj/+mXWyixLpbxb8W/PpFrJFrm+nRh8+okKkm+CIy
	 ytkuA2vR5SPHAAj7bHe/VQ3+IPS0Qfte6cMSEs8VbgD/TUxgO2D04nrCVIWDkRJ7Zm
	 2oEdqtaPiw3k0RFMgIQrK/1Zb+v2PSOSr+3E9icOMS5/mA3LfDePb4MoLtryh4WaYR
	 2nZtxQmm1h8YqgdigOIiFGOcdGJJ/qeWxzeevdIvjW1zCRKkiK6oXN54vzemjHgOnk
	 yit5loBdlV//w==
Date: Fri, 4 Jul 2025 18:29:59 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH] MAINTAINERS: update Daniel Gomez's role and email address
Message-ID: <aGiAF8IQ4PRYn0th@bombadil.infradead.org>
References: <20250704-add-dagomez-maintainer-v1-1-5fc32033c51c@samsung.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-add-dagomez-maintainer-v1-1-5fc32033c51c@samsung.com>

On Fri, Jul 04, 2025 at 09:39:59PM +0200, Daniel Gomez wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> Update Daniel Gomez's modules reviewer role to maintainer. This is
> according to the plan [1][2] of scaling with more reviewers for modules
> (for the incoming Rust support [3]) and rotate [4] every 6 months.
> 
> [1] Link:
> https://lore.kernel.org/linux-modules/
> ZsPANzx4-5DrOl5m@bombadil.infradead.org
> 
> https://lore.kernel.org/linux-modules/
> a3701a9a-5b42-4581-a150-67d84601061c@suse.com
> 
> [2] Link:
> https://lore.kernel.org/linux-modules/
> 458901be-1da8-4987-9c72-5aa3da6db15e@suse.com
> 
> [3] Link:
> https://lore.kernel.org/linux-modules/
> 20250702-module-params-v3-v14-0-5b1cc32311af@kernel.org
> 
> [4] Link:
> https://lore.kernel.org/linux-modules/
> Z3gDAnPlA3SZEbgl@bombadil.infradead.org
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>

Linus -- just a heads up, Daniel is next up from the Rust world
to take on modules. After 6 months from now it will be Sami. Petr
has done great but the goal was to get more blood from the Rust
world. This has been working well so far so I think after Sami
I'll just go as a reviewer and eventually focus on other things.

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

> ---
> There are fixes [1][2] to be sent for this release cycle that fix a bug
> introduced in v6.16-rc1 and in v6.4-rc1.
> 
> [1] Link:
> https://lore.kernel.org/oe-lkp/202506041623.e45e4f7d-lkp@intel.com/
> https://lore.kernel.org/linux-modules/20250610163328.URcsSUC1@linutronix.de/
> 
> [2] Link:
> https://lore.kernel.org/linux-modules/20250618122730.51324-1-petr.pavlu@suse.com/
> https://lore.kernel.org/linux-modules/20230319213542.1790479-3-mcgrof@kernel.org/
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4bac4ea21b64..bf07c0acd1e1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16820,8 +16820,8 @@ F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
>  MODULE SUPPORT
>  M:	Luis Chamberlain <mcgrof@kernel.org>
>  M:	Petr Pavlu <petr.pavlu@suse.com>
> +M:	Daniel Gomez <da.gomez@kernel.org>
>  R:	Sami Tolvanen <samitolvanen@google.com>
> -R:	Daniel Gomez <da.gomez@samsung.com>
>  L:	linux-modules@vger.kernel.org
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
> 
> ---
> base-commit: 60481cbdfae129753633cf03f061293b6e0c8bf4
> change-id: 20250704-add-dagomez-maintainer-d48e17d43f9e
> 
> Best regards,
> --  
> Daniel Gomez <da.gomez@samsung.com>
> 
> 
