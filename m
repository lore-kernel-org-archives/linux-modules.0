Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ABD8F48;
	Sun,  7 Sep 2025 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208067; cv=none; b=nz1bHheYIiGok19zxnhWtbeWfXVlyGNFEW8g1bg3seGR4hU+6iAf8WpoqOTH5FUd4V0mE7plLVOrJ2TG01rKYhvON7vjLalpNaP+71b0jAinaEbmRhj9XTClH25ZpCHFaG9xK5RullZTRSaSXOUqRB39y4k8az8rAcjfSjqahLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208067; c=relaxed/simple;
	bh=e3TYx7R8/86eXJjne9oTkCtmsElQ7E+A0gJDTrMLkqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJsWE7xQctj4GS+4D9nMN3PDR5yiLTIUgo1ieC7QU/GeyFQYy0qRirMYHDW6QyTR2G/x5VLo7yT/iyUkmZ7Xh7KZdkbVySKVnfKtGcA+kYzPcdo1mDqUh67sVuULTnvLlCSS0O9YSU0NCONpSpwpB7L907R1EVl6LFBq1gi/OXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLGivMaI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLGivMaI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215A6C4CEE7;
	Sun,  7 Sep 2025 01:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757208067;
	bh=e3TYx7R8/86eXJjne9oTkCtmsElQ7E+A0gJDTrMLkqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLGivMaITAr7JnBlZ//M2a79WkNkUOCOe0fJuGgsZtmi5eZ3Z3rSLUVo5yzB83Pn+
	 +jjU6aHldxEA4hm6j9IL86VHUdxVh9jNbYoDfM0HNnaUQy3WYQk71N8+mARk0LJe0N
	 AwSf2r4G3Fkf0sm1O/38My/xmcePfbpoloDhXincclIc/eEAz/1rw+zSnCubu7xkKo
	 skGOTC4Qn5UFZSt+MBlxfcn3x4WMDVIOYvOVe9qcKd1BI+VrbBTAcpmT5K3UxlsSRw
	 2XD6QNEAG01mPjWe5X1ORuhrXOMx3MTZAlHf/VShisEEXueVAheZDzQkw1yrDIE4V0
	 Nu5FpCS7g+2SQ==
Date: Sat, 6 Sep 2025 18:21:05 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Fidal Palamparambil <rootuserhere@gmail.com>
Cc: linux-modules@vger.kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
	samitolvanen@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module : fix signature checker pointer arithmetic and
 bounds check
Message-ID: <aLzeAZGc4Mv8wAIx@bombadil.infradead.org>
References: <20250905154550.130-1-rootuserhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250905154550.130-1-rootuserhere@gmail.com>

On Fri, Sep 05, 2025 at 07:45:49PM +0400, Fidal Palamparambil wrote:
> From: Fidal palamparambil <rootuserhere@gmail.com>
> 
> This patch fixes :
>  - invalid module_param type (bool_enable_only → bool)
>  - unsafe pointer arithmetic on void *
>  - missing bounds check for sig_len, preventing underflow/OOB
>  - export set_module_sig_enforced for consistency
> 
> Signed-off-by : Fidal Palamparambil <rootuserhere@gmail.com>
> Signed-off-by: Fidal palamparambil <rootuserhere@gmail.com>

I will ask that other maintainer ignore your patches moving forward.
Clearly this is garbage gen AI crap code. The list, the double SOB,
and your clear wreckless post is a good example to just never want
to apply any patch from you.

  Luis
