Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895BB24169A;
	Mon, 10 Nov 2025 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787871; cv=none; b=LLc/+fRehmw/2av6WoC7Hh/kA73NiYavKzl5j34O3tjzK2/EgKLh5+SRXC79XjsmL6OAW9jfyNqL0InA4nVCWQ4pySV6IWP7/JBCnINOF48N9j08QJvXUCy9p7pDNsvNgv4fEI7vkJ2JhPAhL9Sa/pUBOBF9ACVhk2rkw6KPXeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787871; c=relaxed/simple;
	bh=QP8oacYKLVsmnu+iuxXTiGIQwJLtP0opRzzvlntxhk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8mlWeMP6iy+WaP6w1krkYNjuvSMZFgNa7ZvvBH4zC4cyA8QRL/qgihKgrjB3hexs0/Hh5MSQULkhoVHocZTvuwzFawkfZbvMAcqTvXEbuZxs8gcAy3df3wkkj2Q28ZIUVrAOt8KyQUTVz03zpV048c3sROLIZn6gWM6RZe1Fj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuXbbjVR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuXbbjVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1462AC4CEF5;
	Mon, 10 Nov 2025 15:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787871;
	bh=QP8oacYKLVsmnu+iuxXTiGIQwJLtP0opRzzvlntxhk0=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PuXbbjVR3EurWNeIKMGa5jzk5wJtPwmH5Rt8KPzT63A0TEFz6gzrGCS67Z/oFz5NP
	 snuBRlQ+Uemqxszpn8irDW9nnN+IjeAc///D3GJUGengTep2kH/StpQ5koY+0T2ilL
	 m4yCoYJvLkjn/ylYsNig48dcSUn6O3AVg8wVNU8+30RRO15uWX1+WRXC1FzohenLLE
	 n5B0OM0Ax7B/U2iKIM/7VN+u3RW4o253z3wwEnujGhIUGcOMPxQyIehxRFwVIajfvJ
	 urxAkTl1FAjnsFQWro0D4DGmxm8F7BZRqVfhrihoUzcYIhAPytfmgIDrwhWsCOtSTa
	 pSzAgoMdJeXIw==
Message-ID: <ea36d12b-15b9-4c1c-b81f-75834bc3269a@kernel.org>
Date: Mon, 10 Nov 2025 16:17:47 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 1/2] module: Override -EEXISTS module return
To: Lucas De Marchi <lucas.demarchi@intel.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Petr Pavlu <petr.pavlu@suse.com>
References: <20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com>
 <20251013-module-warn-ret-v1-1-ab65b41af01f@intel.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20251013-module-warn-ret-v1-1-ab65b41af01f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/10/2025 18.26, Lucas De Marchi wrote:
> The -EEXIST errno is reserved by the module loading functionality. When
> userspace calls [f]init_module(), it expects a -EEXIST to mean that the
> module is already loaded in the kernel. If module_init() returns it,
> that is not true anymore.
> 
> Add a warning and override the return code to workaround modules
> currently returning the wrong code. It's expected that they eventually
> migrate to a better suited error.

I've been following the thread (and apologies for the delay) and reviewing the
patches, and I do not believe we should push this workaround. While this "fixes"
the bug reported, it also hides the real problem and drivers will continue
misusing EEXIST at module initialization.

From the bug report thread, I agree with Christophe's suggestion that
nf_conntrack_helpers_register() should return EBUSY instead of EEXIST. This
would fix the root cause for this particular module and will allow others to
change their module behavior, if we also follow up with proper documentation
about EEXIST.

> 
> Closes: https://lore.kernel.org/all/aKLzsAX14ybEjHfJ@orbyte.nwl.cc/
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  kernel/module/main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c66b261849362..74ff87b13c517 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3038,6 +3038,11 @@ static noinline int do_init_module(struct module *mod)
>  	if (mod->init != NULL)
>  		ret = do_one_initcall(mod->init);
>  	if (ret < 0) {
> +		if (ret == -EEXIST) {
> +			pr_warn("%s: init suspiciously returned -EEXIST: Overriding with -EBUSY\n",
> +				mod->name);
> +			ret = -EBUSY;
> +		}
>  		goto fail_free_freeinit;
>  	}
>  	if (ret > 0) {
> 
