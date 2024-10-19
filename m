Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1389813C816;
	Sat, 19 Oct 2024 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729375822; cv=none; b=WPALMXhSMDtoIhwIrccNVs+3FdOSRHtFCXUOcRoHFMT5097UKm51eS25+JIoVCGbE5/EdeUiiegzjijw89KOJOOsha02T1q0zkIpZ2mT3Y22gy69DNbn3VU9EAwmPzElmbih4D9fvlG93uCE27mgpCBuEzmdRVjce9SXMR3o1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729375822; c=relaxed/simple;
	bh=0B0VcEbPn1VvdEiFRhd+49vZuwZkGAIaCtI+62iJep8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa8VL4fensrXmljaEiuPGIC+8s8+xWWRclEXTob1fD4x0j+I1y6SEteMblhvOefBEjoQVCedZMHw97vKawdcaTDEN8Vno8MQWzFtTr3QgcC+YnBYomcM7nKJ5o2hycFdppV0lhxNDzIZ5et+X14Dqe/i7JF/xeUfZGpnTWiTmok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVFOJYGg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVFOJYGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E34C4CEC5;
	Sat, 19 Oct 2024 22:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729375821;
	bh=0B0VcEbPn1VvdEiFRhd+49vZuwZkGAIaCtI+62iJep8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVFOJYGgh3szznAZyAoNv3lVXQ0bnY0MsM9k39NIGkWUYnHM1hNzYeNK0yoQ6ZdqJ
	 kKGSwRCrDC9U+v/TgX1iSFYo7qCzT9AZlcfodgE52M1sBilrd6+d2r2cSpOyU6+waP
	 D6LUKZXJedlFNntgM1JvHWlU8+HH3eq7viW2aV61wK7teCk29ol5BEwOQoNJRUmqZy
	 tqVhPxAJ0ddru7hRgFV413wkuJZS5YqeWt1xyMsDSVWFSOV62Adm8hTfBqkJVHGxc9
	 KHP6UZimE/OSAnsqsQz0z88IcfrGBiFhGTi3maKPp6MRehGk1bmfk2CEMjWJc4TgxM
	 60HMeDgRoRGOA==
Date: Sat, 19 Oct 2024 15:10:19 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Maurer <mmaurer@google.com>, Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	samitolvanen@google.com, petr.pavlu@suse.com, da.gomez@samsung.com
Subject: Re: [PATCH 00/12] Module Validation Refactor
Message-ID: <ZxQuS1KDS0-ekHOz@bombadil.infradead.org>
References: <20241015231651.3851138-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015231651.3851138-1-mmaurer@google.com>

On Tue, Oct 15, 2024 at 11:16:34PM +0000, Matthew Maurer wrote:
> Split out from Extended MODVERSIONS Support [1]
> 
> This series refactors module validation during loading to ensure that
> everything is checked on its way in. This is intended to make the code
> robust enough that we can more confidently add new pieces like extended
> MODVERSIONS.
> 
> [1] https://lore.kernel.org/all/20240925233854.90072-1-mmaurer@google.com/

Thanks! KPD [0] picked this up and ran automated tests for us using kdevops,
and the tests passed [1], I've included that into the last commit log and
pushed to modules-next [2].

[0] https://github.com/facebookincubator/kernel-patches-daemon
[1] https://github.com/linux-kdevops/linux-modules-kpd/actions/runs/11420095343
[2] git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git

  Luis
