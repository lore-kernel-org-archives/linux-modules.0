Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B286333;
	Wed,  8 Jan 2025 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736363823; cv=none; b=GWPUV3n+kPe+d95ujCsv79DkHlE/HPU0r732hqmtIevV8yKrIZP9tK9cWgUGTu79/n0FuePBR1XeMxArdo2nidmr8PP5Tn4eVKmLGgSC4UD4AcRnt/YyfsON4nsmggumebgtLEjXwYwn75dEm3m8LHFBYSubd8rD7QLEHgOA04A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736363823; c=relaxed/simple;
	bh=jGvUUgBb5r0pOAeKKtF/A/HSUQcWln1ioZSAjG0jdLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zapxm+K25JKNf2bKtQgdJ//p9ihs98VG4pBQueUrxYbtITE34F0tss81hM5Cxo4jpuh9dCKFC0JaBmRShaJNEgr0S11JFKL5Z4B8VQ7veVzWklOA904ukPB9Z0nvp2N+7TAGspdaerqoRaV/qG3OXeZH8Yr4vJcf4IyelwPGJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ka14tEAR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ka14tEAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94FFC4CED3;
	Wed,  8 Jan 2025 19:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736363823;
	bh=jGvUUgBb5r0pOAeKKtF/A/HSUQcWln1ioZSAjG0jdLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ka14tEARPZy8pKUUBKv0oDsbnzFUS6yul2vGTxMj6RF8/DzUJ+AgYL8V/sKjidwHc
	 fqaJDfQC4W/S7hmbmzpmrNf6pHgvq88WD08IgTZkxcAFPwy3J+hhU3uyMRibC3puw1
	 Bs/7aZoCGD/ma/N3AAVxp5dovh+xzmubwrpqXqW8qNWhmQl2fKEc8M0h9ajDZxArhB
	 hJwq+keCIJrLiNjWs5+Q7mu2DMlC1uf5bLjvNnrDsu9GRjCcxn7CaPf3VZQPg0m6qx
	 ttbtma+lRRLROV6s30NT537B/kyDRh8NXTrQXuzIJJAWZ7/tEylHeucykSKH9JwGjP
	 aAzfmszq4WjfQ==
Date: Wed, 8 Jan 2025 11:17:01 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v1 0/3] module: Don't fail module loading when setting
 ro_after_init section RO failed
Message-ID: <Z37PLciJqq5xMvTf@bombadil.infradead.org>
References: <cover.1733427536.git.christophe.leroy@csgroup.eu>
 <f0e892c7-43cd-4310-9d60-1d6e839f5bb2@suse.com>
 <202501061610.203636A9C@keescook>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501061610.203636A9C@keescook>

On Mon, Jan 06, 2025 at 04:13:29PM -0800, Kees Cook wrote:
> On Fri, Jan 03, 2025 at 05:13:32PM +0100, Petr Pavlu wrote:
> > On 12/5/24 20:46, Christophe Leroy wrote:
> > > This series reworks module loading to avoid leaving the module in a
> > > stale state when protecting ro_after_init section fails.
> > > 
> > > Once module init has succeded it is too late to cancel loading.
> 
> Is there at least a big WARN about the ro failing? That should let more
> sensitive system owners react to the situation if it looks like an
> active attack on memory protections.
> 
> (And maybe we should set a TAINT flag, but perhaps this is too specific
> a failure mode for that?)

I don't see a taint flag too far fetched in value. I think its a
sensible compromise, and may be useful for other future set_memory_*()
failures.

 Luis
