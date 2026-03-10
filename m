Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4AB3859E3
	for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148490; cv=none; b=uXc0/4B+GDx8QMTeLOw67AFuF+jIqLl8zZAnw7IxeRLPupqiZje5vL5Ftjp//D5RzR7vkzRQpOoHSrKuNOhJL1ABr+Sm8LVDIlDnyBvB7x7pWfHRlMDgh0R72XZreX+MaIEU9NKjYUElo+0PcRiTLKbgD59tv0LnueEppUuOOSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148490; c=relaxed/simple;
	bh=AqSw/iuvlsvi6nywDAOSpzCpQg5Io0D4nPJjBsa9Y/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQFji3kT09x6ArKsC+ZrtzhBdUKwB8aQofE5BKdb7KxScyfxO5ndMAXKFnCwuwytDxbDg3akJNjO0C+FvxJkHE+qqRKdRhjsyeqOM5EoMxL1t9wvDAiHG91Vb03kFMFDMd/SKSz9e5oVMgtGQXCTuaOzkxPRJy2r1zogEwqPtPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=osoHnbYW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="osoHnbYW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NRC5YCUWEPcYBeWZ/oFrfw+ZslBdzRy+OcEiJ7XGpZ8=; b=osoHnbYWlmBMVz+UIaEZFr0Jpj
	kagLDEQbVevkzUZgJfJGDIKpnGqfkayMQUnKsPYNcz+jSluHwldIfW7+UECw8uke4wbaYpN17fZwk
	xWTcwNiD9D0G8f0lD4Qx5dnXL7j7EIs2jH2plxH9nMPQp/7iJgz5AYzsJ5k2vNnVw7dkVstO6DKrq
	RRFnabJqdVEXVAUFL8P67RMqMDAQPlpF/IXvhwkZGH9gtKfeBj0VleknjdZRDYnjsZLXo4qLceclk
	ky77aQhc/WJdxra7DvorojxRMoj8CdMuNmo7NXm0VWBk6/sqpigcZvsMuhtKp2+hGd3kJ0Ff5hAMH
	Pw3O5UrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzwvA-00000009ZBv-3dBY;
	Tue, 10 Mar 2026 13:14:48 +0000
Date: Tue, 10 Mar 2026 06:14:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, atomlin@atomlin.com,
	da.gomez@kernel.org, linux-modules@vger.kernel.org,
	mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com
Subject: Re: [PATCH v3] module: print version for external modules in
 print_modules()
Message-ID: <abAZSCbSEGUhTdUn@infradead.org>
References: <aa-6wILF90Y4ndnd@infradead.org>
 <4215f061-488b-4c2b-98b3-45db4aabed5e@gmail.com>
 <abAXjc6OihRcdoAA@infradead.org>
 <CALOAHbA3g=UVavYgxJXH_5v0TYMLd6QKUTd=HDbD74Cp+9Kgvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbA3g=UVavYgxJXH_5v0TYMLd6QKUTd=HDbD74Cp+9Kgvg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 10, 2026 at 09:11:48PM +0800, Yafang Shao wrote:
> > > Could you please explain the rationale behind introducing
> > > EXPORT_SYMBOL_GPL() and TAINT_OOT_MODULE ?
> >
> > Your straw man doesn't make any sense to me.
> 
> This solution has been approved by all MODULE SUPPORT maintainers. Are
> you on the maintainer list?
> Please help keep our discussions polite.

I don't know what your are trying to say.  You brought up a totally
unrelated strawman argument, and when I remind you of that you're
arguing about politeness and maintainer files?
