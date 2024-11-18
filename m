Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C28197531;
	Mon, 18 Nov 2024 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963225; cv=none; b=bEEuUSCxoD9DQbNXCue8Cd8iNLT/6uVi7F2vlKo8+wpGjxvlJqTbzpu0Wj9i6ksocRs4GSGxLt9+1wXFuPL/fmY+3oInnwmPItDhqTlwrmu+6KVkflic9L45/woc1Jcl2Ock8w5k4z5S2KOX4alQ2HbN+6a8SvLQvPdNM+6Fs+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963225; c=relaxed/simple;
	bh=VLlWWb+bp88p/8PVtJyLoFuhW7AOLShcs0cDY4Jxk1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbxlpn08dJVa0VNM0T70QLEzp9C/D3+FbmvdCnV//7e9MHsCyh6U0ofdQd7Tbs3b4RXOzTsvebnKXbNRvCaEtpJJarot7qwBEz1RZhYx4MWX1SB+vs5fI1oK/JMyYb17r1g1dbS9owpEH2oeAz5YPfie8I98/H/W3JDOgqerOCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivZ4nS5I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivZ4nS5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0994DC4CECC;
	Mon, 18 Nov 2024 20:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731963225;
	bh=VLlWWb+bp88p/8PVtJyLoFuhW7AOLShcs0cDY4Jxk1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivZ4nS5ItmhdmqEqyzZ+7LgNTrIUmGnXgUM9GeYM2al1RGi1bnZBUk4B3POiJqovT
	 KmO5ISspBmXCx2tSWSHyiJzTsejV6AADt38aC1GQXf0iJB6hONkLscOhRge8HSsOb5
	 ZWAETB1d5vFajVZTaRX6N9+q1X9uOCRVmxT0W/PZDxcwBYo/VTT+DDLPEYSwWzUBUR
	 UiQs7bDYQlhFKcPD6Cd62yGxa4eydswUo7LBqfyvzbSicvDR5Bdw2waPb4u4ijhMsR
	 +v9ULmyvdNgzPl+A45NY8UaUWxUuqqpC8juKS4BriIpHewkzGtr7o8wvojXNCIy7Qz
	 hHNHS9MEvXTRw==
Date: Mon, 18 Nov 2024 12:53:43 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: u.kleine-koenig@baylibre.com, petr.pavlu@suse.com,
	samitolvanen@google.com, da.gomez@samsung.com,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@leemhuis.info, vv@tuxedocomputers.com, cs@tuxedo.de,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH v5 2/2] module: Block a module by TUXEDO from accessing
 GPL symbols
Message-ID: <ZzupV6H_Jy2Zhryp@bombadil.infradead.org>
References: <20241115185253.1299264-1-wse@tuxedocomputers.com>
 <20241115185253.1299264-3-wse@tuxedocomputers.com>
 <0f663358-e5e1-452b-8280-0be90ae7e7de@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f663358-e5e1-452b-8280-0be90ae7e7de@tuxedocomputers.com>

On Mon, Nov 18, 2024 at 11:10:28AM +0100, Werner Sembach wrote:
> Hi,
> 
> Am 15.11.24 um 19:50 schrieb Werner Sembach:
> > From: Uwe Kleine-König <ukleinek@kernel.org>
> > 
> > TUXEDO has not yet relicensed a module for GPLv2+ as a reply from former
> > contributers the committed code under GPLv3+ is awaited.
> > 
> > Teach the module loader that this module is not GPLv2 compatible despite
> > the declaration to be GPLv2 compatible until the relicensing is complete.
> 
> The relicensing is complete so this patch can be dropped entierly

Good to hear this has been resolved, the first patch is still a nice
cleanup so I'll take that in after the merge window, there's no need
to rush that in.

 Lis
