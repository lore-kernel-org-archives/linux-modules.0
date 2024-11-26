Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86751CF284;
	Tue, 26 Nov 2024 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732651086; cv=none; b=FA7AWBmOq9LtoDQbai3YH+4ckn/qBAK9jL+Npx9KQp6Nt28EyJ9mOoYFRsBKGj7wWDhvGCG/FYctWJTui/mG9Q3RN4exrLcLLSpwWmRp7fuMy3sndrYHXVo25NlIta/+eaFeWlOslJYfDh+NLHqkNKnRXtHNSb2/ZmQf8Q3pT40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732651086; c=relaxed/simple;
	bh=dWUZ64bCRV/Y+gcm4cJBoHTThoGpVSgCTCr7MIBr9IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yo/CoQ91aEZrvUcDP9nBSosRkk3pbElq+u/Q28VrWDcr6azPUCycgS28Mel+9KZ9EcmVQApfFksRg66WZCO3aeRoSnDIJFkkle/OPMt0YFR2miZn7AXejdD/7ZGC7IKKW5wv6+9+HYIScTRcxmy30YAPx7LEvnjFxp2B3/vw2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bW94JTtd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bW94JTtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F358C4CECF;
	Tue, 26 Nov 2024 19:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732651085;
	bh=dWUZ64bCRV/Y+gcm4cJBoHTThoGpVSgCTCr7MIBr9IU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bW94JTtdNb5bW1Ty3xyLF+eg/qDhd/JRrUtfR93+jB/5IFrtMV0zfzhjIm0AFYsMJ
	 xPNvM+OC8ydfoTVZJ3WBdguS7iQJRghr+U89wnvw3kAVnmFfYr903HSBkBX7T8A/66
	 WLYQzK5sploB1XIj01WslWf6beJkI0TWQHugMXIcvXN/7uUOU2UFVg4vtbICjZ2DZu
	 fv6csQGcOhM6cT4wHk6itEw8UJd3z9Gs4RYmhrF0FbPJ71wbgbYV5zVODXPT6QSqLo
	 nlm5XyMlfQj87pSjG6rS69DhD2V04DGX0NH1GgqNgTQJCwtOycHcAWQCpgwR7SB64e
	 N7Ms9mJXGOMng==
Date: Tue, 26 Nov 2024 11:58:02 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/3] module: Split module_enable_rodata_ro()
Message-ID: <Z0YoSrSNCIcvHsBl@bombadil.infradead.org>
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>

On Sat, Nov 09, 2024 at 11:35:35AM +0100, Christophe Leroy wrote:
> module_enable_rodata_ro() is called twice, once before module init
> to set rodata sections readonly and once after module init to set
> rodata_after_init section readonly.
> 
> The second time, only the rodata_after_init section needs to be
> set to read-only, no need to re-apply it to already set rodata.
> 
> Split module_enable_rodata_ro() in two.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Didn't see a respin so this will have to be a post v6.13-rc1 fix.

  Luis
