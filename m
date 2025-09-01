Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062471DF99C;
	Mon,  1 Sep 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756751344; cv=none; b=VcvJPCGBk6zFHSdNPfKHam94RUcIhIWTz4wCXtaYntQvJSuawPmXDxWIi31K4vWW8wXm9pdnRdO3YAVNrJyChpzcKPHVytHzXRMMYARVFkJqjIIUg0VmsflJfyXG0IGWvEpeyPQG0r+yq3AV0UDKN8B1frznjswbZVCo8E+e3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756751344; c=relaxed/simple;
	bh=dzOhUlVc9gBe0VMWsZUvVSBE7vCESrQZhPDVMQ4opio=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZI2gYy1XM9BSWk+5Xb5tKUOZKKT3S95/QQEDCHNaGrhSi0R97UFTYl53zbCFS5E/2Cqa9nostXSkYBNzffCgm+EoJHc6XoNNTkQHpDA7rPvUlu39pJ5OzkFxrCdRv+gvZlYs7pHelkFFH8t3cWsR1C45RZ28LlXwjhqcdF5NSRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5ZEhyQk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5ZEhyQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B094C4CEF0;
	Mon,  1 Sep 2025 18:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756751343;
	bh=dzOhUlVc9gBe0VMWsZUvVSBE7vCESrQZhPDVMQ4opio=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To:From;
	b=h5ZEhyQkJz4XvfOZztAx5EqhVSNb+TqkYzuwip5vAdV+6MHwZuzIfgp3834e+ZitU
	 0YfeaDm9TPvVNvleqt1fOl4ZcMLk1MpKOBf743EaY18a/D5QfEfTCfzaR+mTcYC6fU
	 L0prernfE1rxCI1OPZRGmglgD9EwGG432y13hzJ+8kNmL1BHQHktsIk6CN3FJfa90B
	 0ZVwOdOkJk/8SISnKL1TsEiGhAROrOc9KQQTdq9/t0vLl+pc8hk0pdCtmjfmHE6Ryj
	 4cq5vi5pXFqVuL6BclvtanCG1kCMx1Ioxt7oDhaZhn5rpaAmuTHzApJ6935COseDC0
	 /bYbjIFzr4z8w==
Message-ID: <851c227e-5d1e-44bb-80ca-d9e230e8ccfe@kernel.org>
Date: Mon, 1 Sep 2025 20:29:00 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH v3 2/4] module: show why force load fails
To: Jinchao Wang <wangjinchao600@gmail.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250829084927.156676-1-wangjinchao600@gmail.com>
 <20250829084927.156676-3-wangjinchao600@gmail.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250829084927.156676-3-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/08/2025 10.49, Jinchao Wang wrote:
> Include reason in error message when force loading is disabled.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  kernel/module/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c66b26184936..e7484c6ce6e3 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1083,6 +1083,7 @@ int try_to_force_load(struct module *mod, const char *reason)
>  	add_taint_module(mod, TAINT_FORCED_MODULE, LOCKDEP_NOW_UNRELIABLE);
>  	return 0;
>  #else
> +	pr_err("%s: %s, force load is not supported\n", mod->name, reason);
>  	return -ENOEXEC;
>  #endif
>  }

I don't think is good to inform via kernel log buffer what the kernel supports
or what not. And definitely, not as an error.

