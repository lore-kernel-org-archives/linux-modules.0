Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF9256C6A;
	Tue, 10 Jun 2025 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749581785; cv=none; b=oMEtXDJIJVyK7prA4CxJ7gDt5K7LKxrG40Iaj9CitQthhVjyncaHUpJedzID8MBtq+LjPr/kjfaYBPCya0DlR3jzyumO+Tp5HbQyuASwT9SagwCBhkLPU+Lq6FQ/oPvUkjFEFM0zurgWhRVf6vtOMLbWEs1/lFYZ5IKtKZ0u/Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749581785; c=relaxed/simple;
	bh=QaPveLJ2D71mlviZ77bwRIovgXlyug6vVb21zt3qDsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XvI19S4ULkG92qn4zEx76hL+dEG+rFTlKgUrFoK8gPh1XXpUYzu2zYEGrXizb0jssRHO0BOqutXsmQnadJNSBpWL2YyIhywMNda2UKfGYAsIXVT7TthhmAtsDIfHVNx03R+r5EOwqeik6vAQWia9j9zxpjZ6Wvm8CEaerB7FV+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dS5RQN7s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dS5RQN7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DA6C4CEED;
	Tue, 10 Jun 2025 18:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749581785;
	bh=QaPveLJ2D71mlviZ77bwRIovgXlyug6vVb21zt3qDsE=;
	h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
	b=dS5RQN7sAgxvKpvVmyNsyMC5vCttzECvO0ltR7OQlNuoGO+tsvRJt9Wuk4NRv/IF7
	 lAZXAXdgaxrf4w9CSI3rUdYtZocc9y2dOMAoVlj+vT6kazo/UUbiYlZWi/Gg7k650m
	 5b8hk+ArQk7ia0lXRG+e9eVx/bke4LzwNj6bEM0tmKDKE9SmKdbPipW+yaTee9lgeL
	 Kosza5P16stDd+cRlOVjhrzL2K2QnGe0p0m0VcKKYYg8GmdllyEuYncjUeqNSfL+8U
	 eVPWZoQBjW9U8+2gxToSQaFbv1u+Yb9sXyfa4SQp4/QYvUWbM+amhXaNC9oHLXg50w
	 evwtdOfYnIOAQ==
Message-ID: <4c5d1ff8-7018-489c-b238-d838080b66ce@kernel.org>
Date: Tue, 10 Jun 2025 20:56:22 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] module: Avoid unnecessary return value initialization
 in move_module()
To: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250607161823.409691-1-petr.pavlu@suse.com>
 <20250607161823.409691-3-petr.pavlu@suse.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250607161823.409691-3-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/06/2025 18.16, Petr Pavlu wrote:
> All error conditions in move_module() set the return value by updating the
> ret variable. Therefore, it is not necessary to the initialize the variable
> when declaring it.
> 
> Remove the unnecessary initialization.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

> ---
>  kernel/module/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 322b38c0a782..06511607075c 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2615,7 +2615,7 @@ static int move_module(struct module *mod, struct load_info *info)
>  {
>  	int i;
>  	enum mod_mem_type t;
> -	int ret = -ENOMEM;
> +	int ret;

Nit:

We can "merge" all integers in one line.
