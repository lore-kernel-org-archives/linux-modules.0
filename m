Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EDC2857CD;
	Fri, 16 Jan 2026 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550424; cv=none; b=EnGp2UBtW/1aM5cr5SdyK0uxXzNOYXqgNAK0LBPtq/G5YpPtuab/VW7CN+EPa+01i7zvXKWvYcIuj8eCRQMgSOM2QoOPgwGn89vzDicjEUEd/HvmqBxqscH/s7bXx+YlqmIMcb8AUJfRzYNG1QBarQSb43zW1QowwELb86q5qLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550424; c=relaxed/simple;
	bh=ff5/FSolBb+BFDDW3e1XptDyKw1ylSIpP5yjlQG/v+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THm3Xexo607x5ff9ZXjfaIN+xnJ392a7PmebMMYgHMSqqd/gxQBlp0cY+8MTt5Br4xUiaAb2rhFesuYHtsoWZHkWFoVlWAXT36YMHMQZ0gkQim6+AW+KUAih18zTrlHdXXT59DEqN/rGT4Eo+09egYoBpG8OX58fGbY2atoD2hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEaTbsLC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEaTbsLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6209C116C6;
	Fri, 16 Jan 2026 08:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768550424;
	bh=ff5/FSolBb+BFDDW3e1XptDyKw1ylSIpP5yjlQG/v+Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UEaTbsLCenpSnkbSuT7rGuwN6jC5QzF45cOSPAjZSHJdVLSlmGzGPXEWwmAi4iJRK
	 6n96ZWRxq/jzRG590bsHL6kPpFKk+ADLbnbSOd3TZx7E/wZ73tsYxdhK/u7cKQnNz+
	 czIv8d/Eao8M8FeeNg/yNK+znYd5Mrunfnvnp/TO622J3zhA7LKySKwa2h/eOY5HpH
	 8VtO50kf6pzgu52DetWIboLSf4ckHD4VAnlQhpdureo2Z4WyF+5RBQ1f5sxYlaHPtM
	 +xF6K78WUXivfA0Dcdz1pxdNJEywtQj5PPZpVRJeZQ4o74HkwLhhbroOvEPUKH0vCb
	 v1DYkqTHgsRmw==
Message-ID: <3beb5db7-efb8-4a68-b5fb-aa2aed2ac52f@kernel.org>
Date: Fri, 16 Jan 2026 09:00:18 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel: modules: Add SPDX license identifier to kmod.c
To: Tim Bird <tim.bird@sony.com>, torvalds@linux-foundation.org,
 mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org
Cc: linux-spdx@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260116000431.643070-1-tim.bird@sony.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260116000431.643070-1-tim.bird@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 16/01/2026 à 01:04, Tim Bird a écrit :
> [Vous ne recevez pas souvent de courriers de tim.bird@sony.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Add a GPL-2.0 license identifier line for this file.
> 
> kmod.c was originally introduced in the kernel in February
> of 1998 by Linus Torvalds - who was familiar with kernel
> licensing at the time this was introduced.

1998 ?

This file has Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org> 
added by commit 8660484ed1cf ("module: add debugging auto-load duplicate 
module support")

> 
> Signed-off-by: Tim Bird <tim.bird@sony.com>
> ---
>   kernel/module/kmod.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
> index 25f253812512..a25dccdf7aa7 100644
> --- a/kernel/module/kmod.c
> +++ b/kernel/module/kmod.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * kmod - the kernel module loader
>    *
> --
> 2.43.0
> 
> 

