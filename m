Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E9F284881
	for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150182; cv=none; b=nvYARTri+VtSWORr85XPVrNhfQVP1UfaaNVt43evVHpBF8+Oqx1FBNixP6rs41TMU5frpdYqjhpzqNpCrPYSbZGc2ndr+oh0UQzhL2TcYj4MrM/XnSke33E7mc7199eb5mWWjwoOmln6Zg9hs5Dezpipuj+n/7Zrbhh1EV6o5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150182; c=relaxed/simple;
	bh=/vRKfTAuM0lN9iIcxBK28IJFXSPh44p8WPnucfqQYTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJmGw6BQwUgeglqb0E3PjX/DXGNJcZsckY9/9hj+e97nd9kcx2Iu5ACmHml9zqUiNMj/R8MTCobUG5KhzDNiFms5xmwPepimOhKhymKlTu/HNxJ/mm/PkzxhNZmLRtU9/q4AOCp6nbLO5TyN2DSAixhjIMSnZyUmA8MMRCLeZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BI1pD+Ge; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BI1pD+Ge"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HPr3VNpZvGATaeAnIPOuxdkTlu7p9Toj6KiaZUX0HaQ=; b=BI1pD+Ge3FPV8T96NSf60BHezQ
	Wt7dSrBrl9s4PK5cLdzi19zNk/mwJc68QZTPJauZX88TkjjHuVPV00gqoqEfIBlqfwCuqEQYBlgZK
	x6G0D2q7Td5Yoj1KoMU+3YtCP261w7i4ef5uMBO75oKpxp/EEyiskfXEjydFc31M021p3Yu4F3Pj5
	fIlgHc31wQ56lB0194BANFBDvk8kvZlfSu+fjk6SCSUQxeFogtZazVetfKCJp5vbFE2mTcPf5vBYj
	Ipt/FDtQY8H6Y5VGubaHtwuzfuWgcCTpRrp3nqirlQdmbfUvRneRF5o5ZPONf4DuZtFOQh+e7yyYS
	6lqm3GOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzxMT-00000009chi-1TKM;
	Tue, 10 Mar 2026 13:43:01 +0000
Date: Tue, 10 Mar 2026 06:43:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, atomlin@atomlin.com,
	da.gomez@kernel.org, linux-modules@vger.kernel.org,
	mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com
Subject: Re: [PATCH v3] module: print version for external modules in
 print_modules()
Message-ID: <abAf5ZtiQGFoOQvT@infradead.org>
References: <aa-6wILF90Y4ndnd@infradead.org>
 <4215f061-488b-4c2b-98b3-45db4aabed5e@gmail.com>
 <abAXjc6OihRcdoAA@infradead.org>
 <CALOAHbA3g=UVavYgxJXH_5v0TYMLd6QKUTd=HDbD74Cp+9Kgvg@mail.gmail.com>
 <abAZSCbSEGUhTdUn@infradead.org>
 <CALOAHbBpAi_FM=odrNkGwXGj1d-ydn=cwURXkUGLawzOMUufuQ@mail.gmail.com>
 <abAa03DO9aLxWcwX@infradead.org>
 <CALOAHbBoX00_eDLq4X6vTrbdLG5X=9-07jW=Ba+Oa-QjtZX3MQ@mail.gmail.com>
 <abAdr6zqeqSNMJ8X@infradead.org>
 <CALOAHbCmxa0ptYTcq1EjRKMrzvFHCyyrv8CeEDYOhuuo7-QbOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbCmxa0ptYTcq1EjRKMrzvFHCyyrv8CeEDYOhuuo7-QbOw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 10, 2026 at 09:35:23PM +0800, Yafang Shao wrote:
> > Why would that matter?  You don't get a wild card to do things otherwise
> > rejected because you contributed something before.
> 
> Could you please explain why I am being characterized as a "leecher"?

Because you're adding overhead to the kernel for your out of tree code,
which only you and not the kernel project itself benefits from.
