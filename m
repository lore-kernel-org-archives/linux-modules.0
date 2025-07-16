Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF715285C97;
	Wed, 16 Jul 2025 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695390; cv=none; b=trmq+7aF+/UKdyVGMcs7Je/kzvwnVrYw1xeK5OmyhxSJsKB2N7hKaYK2sZWj5COScnWSidV45nWiei5uA9rCyEcGT9zkftF58optpS9jPh6DXar/irnpvqrLLXp4ItyFwTow210fwKlR1ye5YylqOVIpbZeJGiJp4r/RHait2Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695390; c=relaxed/simple;
	bh=naZosONXgGsB0yNa80E1IlZkykjMXmAAtYPj6w7Gbww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgqvlpAbswU+Hr8QQrtVkf+nA0m3v6KpxjOMLxQbhp8Fr9ER5GCixi3z197kjIfzui9FI2BZ0f0TcUU/qHrQhn57lBks4wcpMaaq81Az4puSuwxnJIuVkd+mnV+G8uzoghVv26ZyWArKmm0dnh28Lh1INgk60M0C1umCf7WdonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2R3KgGY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2R3KgGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404E3C4CEE7;
	Wed, 16 Jul 2025 19:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752695389;
	bh=naZosONXgGsB0yNa80E1IlZkykjMXmAAtYPj6w7Gbww=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r2R3KgGYJKviiabCuPcbDjoHed2l17sqEGJCVBYI/LRUFJHtxCHYi9jFLX5mDMDPY
	 esW61fxUo4mfxjKr6JUSvRnTtqpgEr2ChLJ39ERbb6ICUh17fJf9Zdrcb7zWFWKBS/
	 oh/GJoMcH0V6CQ+4X3FFZFjlJXXQ2eItjmCD1xxIINoHWSACJV3NBQLgk7MXm7eFeP
	 qXMNhmzitfpLmr09aEmFHEE+iM8krntNXJ4snbdkxCPyCKxZZB1JPU9Ub0vCT+DP7r
	 TCeEqDSO5fTCl+E63b5w47mCh/QMOM5f1SG/dBx4QRUbhv7MFbl6UTHo+XcP+TNuFa
	 dTBSnFEhsF+ng==
Message-ID: <e836cb49-0afe-4a28-801e-3daa4981f642@kernel.org>
Date: Wed, 16 Jul 2025 21:49:46 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 2/5] module: Remove unnecessary +1 from
 last_unloaded_module::name size
To: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630143535.267745-1-petr.pavlu@suse.com>
 <20250630143535.267745-3-petr.pavlu@suse.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250630143535.267745-3-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/06/2025 16.32, Petr Pavlu wrote:
> The variable last_unloaded_module::name tracks the name of the last
> unloaded module. It is a string copy of module::name, which is
> MODULE_NAME_LEN bytes in size and includes the NUL terminator. Therefore,
> the size of last_unloaded_module::name can also be just MODULE_NAME_LEN,
> without the need for an extra byte.
> 
> Fixes: e14af7eeb47e ("debug: track and print last unloaded module in the oops trace")
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  kernel/module/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 933a9854cb7d..04173543639c 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -580,7 +580,7 @@ MODINFO_ATTR(version);
>  MODINFO_ATTR(srcversion);
>  
>  static struct {
> -	char name[MODULE_NAME_LEN + 1];
> +	char name[MODULE_NAME_LEN];
>  	char taints[MODULE_FLAGS_BUF_SIZE];
>  } last_unloaded_module;
>  

LGTM,

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

