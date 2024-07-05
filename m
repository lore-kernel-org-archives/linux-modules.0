Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD214A4C7
	for <linux-modules@vger.kernel.org>; Fri,  5 Jul 2024 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179228; cv=none; b=H02EftqS0PeLAdIJDnikVC7p/r+wcT1dt0TIpew5aIDmp7+nWzGKrs+4GnCi0egci45vV9msfcL8tiM52zuGkOr1wLr84Rpz09FNmxTYhGrFpBp9CtSoBaRiZtcDtEFUoic26L/RUcyFpmD+l3kw2y62xU1TTp/dB1H9juVKRd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179228; c=relaxed/simple;
	bh=Yqm2Y05glE2XpD8UBy9Za6PAr7oCx+v4mZPjneDT06Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FV6nMQaeHEpNOJHx1umIiqL9IXXzjIM+0DaO8s9vU7k3WrJnPRmOQC8rozE04ilj4zbSwtFgZ8APfnEUpHOITw9uZPtin30hV393nNhpmTTyruM4yGCAh2ApeV3RqoBBXz+CM66a//H2YC6++VppkXypaScmm1Vz/Nuw0vQkk0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=dL3nFrWD; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="dL3nFrWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1720179219; x=1720438419;
	bh=Yqm2Y05glE2XpD8UBy9Za6PAr7oCx+v4mZPjneDT06Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dL3nFrWDVRhvyLcNlSe+g65txsjpcHUKDo2psuBpjHU26zsoplUbmW9GeuPsbrX+n
	 lujfxAs7bP92/8FIDCZ6c9tHEvx01h/Vx+QiMcEqn8PLOjdWpaPQ/mKsiziRdQYvho
	 R77rhiVhRspH8MsomjMqY4k7sHKAmJOFqtecrGX1rlfvMDV6UnnlBFmX9zWst7/ikY
	 +UHxOYjzLHP2RuJmHNBXLeBymLdhY7+XfvEOly1iqN81lSdpkIWgmN0XcRCi22dYgH
	 XkB3YhJ683ifXyT8EIH5GEygFgeCmSkL7Qb+CcVaN3k5pF30YaryIDMnoNkt65B9Wd
	 32warv0r/NhjA==
Date: Fri, 05 Jul 2024 11:33:36 +0000
To: Adam Bratschi-Kaye <ark.email@gmail.com>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <87frso2hvk.fsf@metaspace.dk>
In-Reply-To: <20240705111455.142790-1-nmi@metaspace.dk>
References: <20240705111455.142790-1-nmi@metaspace.dk>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: 2b7babd3678f2e69ff10fab1e8f2a40279773b39
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Adam,

"Andreas Hindborg" <nmi@metaspace.dk> writes:

> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> This patch includes changes required for Rust kernel modules to utilize
> module parameters. This code implements read only support for integer
> types without `sysfs` support.
>
> This code is a reduced and updated version of code by Adam available in t=
he
> original `rust` branch [1].
>
> [1] https://github.com/Rust-for-Linux/linux/tree/bc22545f38d74473cfef3e9f=
d65432733435b79f
>
> Cc: Adam Bratschi-Kaye <ark.email@gmail.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

Two questions for you: a) Can I put your sign off on this patch, and b)
how would you prefer attribution on this patch?

Best regards,
Andreas

