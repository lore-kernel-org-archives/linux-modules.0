Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F4E26C391;
	Sun, 16 Nov 2025 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763326028; cv=none; b=npezrKh02LfTnzEmW4IEi3fEKPbfLG736CsgmtatzzfSnXJFYtr85VDvtUV44X/5fYasWQAf9TlJebcSX1hUGNeUqlr8oePS+B9xP4Yb/R1HRwp0LH2VCmiW2N/+VFOpnqZDV++xM0azzAVqVhsVpkKhftcoarcRFLvEyn/gn2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763326028; c=relaxed/simple;
	bh=uEUtseXctBO1c9g6MbQnExHZoAF/5JlA8du0eN3gtz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+D8T0PHtyQ0W2qKwnHyxRMZxECu9JAE0XfrObk789pWYwNPKoSMEkJiBgGLRbzFtbnsIAriZvOMF0oeOkR89DXJH93P+OjAgdV0CST2IoSJtLaPWiMIuYEjWTjrtGV4eGeQPlhbHptbpwL78bm369fLIzw3M4cF7Zqgj6FFvhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDxq0/Of; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDxq0/Of"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4ADC4AF09;
	Sun, 16 Nov 2025 20:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763326028;
	bh=uEUtseXctBO1c9g6MbQnExHZoAF/5JlA8du0eN3gtz4=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JDxq0/OfxrogmGGi9R0XFe/KV+HSryZ36t9L3bn3uIeVDU7pbQMb0Okg2R2YCx1dy
	 sOqJV2nM/brug9Xl5eMP8QpDNMsI8e2t3IzL+VFdht94rm1EPpLouRoB7kCZQC6zQy
	 9PtykB0Tg32oGpnTeT1br37catvbqFGaZSyDJ4CMVgOhfpbkFqe3bpJNbBW6Z4jNGM
	 xmh9zLfqueKAC2aIha6KLp1P+1T3TuCByj2r1VYl5adtVXKh51sqKNRbgErM4Tam9Y
	 P4IdBr6U7CM83fGK3L0eMe3OWc6YSH7qwHkYOfzcg4FJWcihHcN6vpnjB+A1eSgiBu
	 U1ujrZQSw/D/Q==
Message-ID: <bd56ed6d-eddf-4821-9a44-ea295629123c@kernel.org>
Date: Sun, 16 Nov 2025 21:47:05 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 0/2] module: Tweak return and warning
To: Lucas De Marchi <lucas.demarchi@intel.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Petr Pavlu <petr.pavlu@suse.com>
References: <20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/10/2025 18.26, Lucas De Marchi wrote:
> Do not let userspace tools and end users confused on the return code and
> log messages.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

LGTM,

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

> ---
> Lucas De Marchi (2):
>       module: Override -EEXISTS module return
>       module: Simplify warning on positive returns from module_init()
> 
>  kernel/module/main.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
> change-id: 20251013-module-warn-ret-59f085298055
> 
> Lucas De Marchi
> 

