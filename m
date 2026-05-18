Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF8031F9A1;
	Mon, 18 May 2026 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103119; cv=none; b=iUK+swg8NsJzNSA8qfCpmOCmUjSW5LtZShgkQR7EcnNcK3MjOwc2IzA4jhUY/cud8sOALpkHJJvSjqVIFWNXcxP9i9gfhf+Ssle1BLwjJALkG307JeXHkrGGcHDM335YHwdhC9a+wpYEKNkK+6SiEriI+8pXZ22RFsjWm2j6Tk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103119; c=relaxed/simple;
	bh=g9oigkZAnSfNfWv7VgFXGodLGkyR1hOlWNHwF+NTWU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYGLlvv3QlAGnM88bg0huhHemERQoHGh5nr2fdvO9obT3u/zY1BiS3xduc+I/SxO/UvzHx3LQwFJhdJvc/s17NGgVczWQ6ctqskPMCUJw4E/xyT3gsZpqrV6+KmEemcWjzUAMB0WJNCVJ3FbJum6NNYQYtDRpwpOQVbWgvU6HjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=lerK9hyU; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="lerK9hyU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779103091; x=1779362291;
	bh=uLsnoGQ0i5yHMXKMyVYaC5fl5YpXpo5gCg4PnRmRGnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=lerK9hyUvdfdmFqtyzNJANYjFIp1rsY0wAG6suGCksSz9dQRc/x5VjgmP4vywzBD9
	 uchD+6l96ORs0sVVuJwVOnC6E+Ald063AZPTYYrYgCSXWx4aGQoCAC4wGbV8Geb90M
	 xDqJ61ThZNDt4jh34EtzVSYdempkgGfWyg9EAjr4Gpsgi/jD++SIR64HE9mloSLPsY
	 tnlTYPFPBPPZK3ut06fk12Lhy7nwl2alRfAZciN7boI95IP15+6NrqA6cDMELMLhN7
	 d1yAXSa6ZRLCUVi69RfX4YBRF8mkookG/KOrKf7L04k+x2XQ0lS1VBsR3HuCF6t+Fl
	 zpJoFBBgtH9dg==
X-Pm-Submission-Id: 4gJwJt1bbVz1DFG2
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Xiaobo Liu <cppcoffee@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	atomlin@atomlin.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org
Subject: Re: [PATCH] rust: kernel: module_param: replace pr_warn with pr_warn_once
Date: Mon, 18 May 2026 14:18:02 +0300
Message-ID: <20260518111805.65576-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260518104735.34906-1-cppcoffee@gmail.com>
References: <20260518104735.34906-1-cppcoffee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 May 2026 18:47:35 +0800=0D
Xiaobo Liu <cppcoffee@gmail.com> wrote:=0D
=0D
> Signed-off-by: Xiaobo Liu <cppcoffee@gmail.com>=0D
> ---=0D
=0D
You need to write description for the change.=0D
=0D
Onur=0D
=0D
>  rust/kernel/module_param.rs | 4 ++--=0D
>  1 file changed, 2 insertions(+), 2 deletions(-)=0D
> =0D
> diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs=0D
> index 6a8a7a875..fedb709fa 100644=0D
> --- a/rust/kernel/module_param.rs=0D
> +++ b/rust/kernel/module_param.rs=0D
> @@ -62,8 +62,8 @@ pub trait ModuleParam: Sized + Copy {=0D
>      // NOTE: If we start supporting arguments without values, val _is_ a=
llowed=0D
>      // to be null here.=0D
>      if val.is_null() {=0D
> -        // TODO: Use pr_warn_once available.=0D
> -        crate::pr_warn!("Null pointer passed to `module_param::set_param=
`");=0D
> +        crate::pr_warn_once!("Null pointer passed to `module_param::set_=
param`");=0D
>          return EINVAL.to_errno();=0D
>      }=0D
>  =0D
> -- =0D
> 2.34.1=0D
> =0D
=0D
