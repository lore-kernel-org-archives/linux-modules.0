Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199B425333F;
	Sat, 11 Apr 2026 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775913658; cv=none; b=vBWucIW7gPzFTnjOzmuydWBH8qkE6GtflUqinm4/IA1qZyU8R4srOTm95Rquy9BixRfPg1SGkl8x6Ha8FDtvN8Ktg5GedsZ82OtPU6Spyh0ZwSet2kitvQdGwF5Dx7FV2zkDbWT7G0kv8n+G8eDrEVSmwN5rASy0ZPQWu7hI/90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775913658; c=relaxed/simple;
	bh=KexCEwsn8tgj8ITmKZkHfakCP/z0b/n2hvVLRpyAIKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwX5f+mBpLOnoaU2dQJPas1NrBjxEdt8RjuJWcX7vnOJP99H6lc7FkND0yQM+g2Mx3i79Pi1wdPIgwE1EBm38nN6OTwp5QHapnrXuJ2m7y0KwxJ32Z3dqwLBO63uSJXni/c0LgKaVRI5Ys60rczKu4L43bC8VBaVhsMfDaals/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=eUJgZxSj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E6jIQjo5; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="eUJgZxSj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E6jIQjo5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1790BEC04A9;
	Sat, 11 Apr 2026 09:20:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 11 Apr 2026 09:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775913655; x=1776000055; bh=FdCyEOQqIs
	qz8wwEc6yrYhoUb6n6TEFycu4E+exCaYM=; b=eUJgZxSjRH2h/tbhmjzrWyEDCW
	79QrcTu63tRrNa+lA6It3JnYWsDEmexGMTGo7afd5PVVpVLV/i32qUuLxVCDDWME
	p3kyeBuHN8oCCLcUWJ8ktIBfsBnamRZ9hC2Urr3p7H60SWSByao8ppeiGZtdDABi
	zOaPES97H46MPQFQMiodtatP5GexNuhhoBxqErl/e++RVQtwG+0Df9UxtEKyKTIu
	rkEubA31n1kc/c3W38kqlUg8YdZO21crflWOoLAKqKAWsOv5fUzM6cXjvvuMzTCh
	GERcSP/vUQLmY6Z4M9JH8Zo4OKZZJvhwDRHof22fq6xYFtjODBF/3fC/O8gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775913655; x=1776000055; bh=FdCyEOQqIsqz8wwEc6yrYhoUb6n6TEFycu4
	E+exCaYM=; b=E6jIQjo5tOsiCW5jSfMYqzh/P4caQNAIWbA8ZUD5w32RezaX0QB
	BUYZkSHyhrg8FBQqmZoGCcYvaGIGXUtJa2l4eqaGoBA8oRTU0LJ9Z4jzI1MmU648
	Ua4uH3ja8QIrSAd6OFCKb/1WY0I6obqfcmaKAHx8S8ac/HzaUBwToVGM1RyqohSI
	hBAAhV8no/lm64Z+0/vs335R6k882UC+z9L8jseIyMHI/J6V+K/3/6z9zoM76cKS
	Sn6offNN/KJFJ4L+Lz0d+21CbA0UWoeMVSPnhu6unEpnsTYLzuCoogIg4gk+ZQ+c
	98KpDCYS00VcQTJDv4vy6G356id5qstFp8g==
X-ME-Sender: <xms:tkraaVsDwdB006d-M6SmNh9GMLSkFXVC_sqOq7oCQUKtfdi5uQpxyg>
    <xme:tkraadvQEqwCnAGGe40RpsHvRLdJs4XBp3vug5psc97w8R29eWY5Y3gZQ5o7in4SO
    qwHx1rC5zI4glh7HVfpzKctqZ7szLPtFxe6SgOLFj2vqe1A2A>
X-ME-Received: <xmr:tkraaU9E7N33VNO4c63BJvHYTEwycQ2Rf3pAa0Lflzy7XxnSIk8kS2gPBqq1XJuNBTLS-wmlOC0fkvGjyOLzQ6U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefvdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvvedvle
    ejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homhdpnhgspghrtghpthhtohepfeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peifvghniihhrgholhhirghosehruhgtrdgvughurdgtnhdprhgtphhtthhopehmtghgrh
    hofheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthhrrdhprghvlhhusehsuhhs
    vgdrtghomhdprhgtphhtthhopegurgdrghhomhgviieskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepshgrmhhithholhhvrghnvghnsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmohguuh
    hlvghssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhr
    qdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghtohhmlh
    hinhesrghtohhmlhhinhdrtghomh
X-ME-Proxy: <xmx:tkraaW9IvdmJVJLtTvKOZU_bEwrZA9Ff9sjW9OY8ze7BIVXsCZ7S4A>
    <xmx:tkraaY89RMra1qdYnwkak3vWdGYeXtdapt5EY-S0c3bqC_Ye-whRNw>
    <xmx:tkraacHOb071ZP7CVlXOPTpQzbIJX7pUcO3xoSQEhn4sR1qw-kEw7Q>
    <xmx:tkraaXZ0-f2lul_FfU7g0jVbrEUKI8CAy3f630BoyUDuh7dFl3TUug>
    <xmx:t0raacOCr6qyKEXdyq5-8gL-cytbJXMm2oGmXE_1KpiGMgApK4DiC-zM>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Apr 2026 09:20:54 -0400 (EDT)
Date: Sat, 11 Apr 2026 15:20:52 +0200
From: Greg KH <greg@kroah.com>
To: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
	samitolvanen@google.com, ojeda@kernel.org,
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org,
	atomlin@atomlin.com, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] rust: module_param: support bool parameters
Message-ID: <2026041118-croak-serving-ff5e@gregkh>
References: <20260411130254.3510128-1-wenzhaoliao@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411130254.3510128-1-wenzhaoliao@ruc.edu.cn>

On Sat, Apr 11, 2026 at 09:02:53AM -0400, Wenzhao Liao wrote:
> Sorry for the earlier noise and for our unfamiliarity with parts of the
> kernel submission process, which created extra burden for maintainers.
> 
> This patch adds boolean module parameter support to the Rust `module!`
> parameter path.
> 
> It implements `ModuleParam` for `bool` and wires `PARAM_OPS_BOOL` into
> the Rust module parameter machinery, so Rust-side parsing reuses the
> existing kernel `kstrtobool()` semantics through `kstrtobool_bytes()`
> instead of introducing a separate parser. A boolean parameter is also
> added to `samples/rust/rust_minimal.rs` as a small reference user and
> build-time validation point.

What driver needs this feature?  Module options should be very rare
going forward as they are 1990's technology and do not fit the "modern"
kernel model at all.

thanks,

greg k-h
