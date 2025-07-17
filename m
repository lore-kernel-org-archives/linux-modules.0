Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234701EE7D5;
	Thu, 17 Jul 2025 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780241; cv=none; b=Jjqr36BbeqSb5RsvbECnaDL3GEXd+vngjXX4x3mweuVRQKk3qO2+vg6f3zdzNwmiVP9d0o9NLn3P8b7QcjeE6gFWIrdaoREO1bV9vHAINkQGNA7L1qNVwTx379VcZIm227NaGrRhMkNLX6OXYczRXBVLYiQ5bq8ujewTI3kJmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780241; c=relaxed/simple;
	bh=SrahtwhRyPeT5mMq8vNAvmfQIs5W5u0hvdNenpQLR5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbJChsOf2OVDDkxw1Cfe5z38x0ydXqjT+5POiSTtyxgLmW+aXkT6KXTRYDHbIUZEfTKX0rfF5DCAuqg/7qEPBxEfsAJir+NeUwdsyBFznldeMyaAwiWZBUUwiWCvP6DkGq1s8dJi9nsn0Q8OviOR3Ql54k6UWlu0haIzNkt5P1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vw79HJ1L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vw79HJ1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E25C4CEE3;
	Thu, 17 Jul 2025 19:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752780240;
	bh=SrahtwhRyPeT5mMq8vNAvmfQIs5W5u0hvdNenpQLR5E=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vw79HJ1L9olg45TWezuMarp0JCw1I3mx6M3WkoaAHlBxzDQbqD4i2896ddwczAcZn
	 hZ5Lix+f4vbfyTZjOUtTOm5IvyJZhJS3eAkPObeg6OJNh3nYWsWDX6c3hRxVqcVSfb
	 mK+G3rK9elyTlMSyodOZm9OEGM7M96OXQTOqjiPHdbQnQElyPUHNrmlblckPbQL4jT
	 6kMM+K1zEjsIvTp6XXK4WetWY8EkvwJCVWvT2Eu/MYFgVHXJoCBI2TkOyvz/XBej2n
	 KCWd3BfL3OP4bcz6fcfsF0UxiC9bOrcvii9k3qU+J9aWvXrvO72BEZBCzdvP2fYVDW
	 DaISfrrFR3LCA==
Message-ID: <15f52f4c-7809-46ab-9e13-bd487f35a80c@kernel.org>
Date: Thu, 17 Jul 2025 21:23:56 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 3/5] module: Restore the moduleparam prefix length check
To: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630143535.267745-1-petr.pavlu@suse.com>
 <20250630143535.267745-4-petr.pavlu@suse.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250630143535.267745-4-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/06/2025 16.32, Petr Pavlu wrote:
> The moduleparam code allows modules to provide their own definition of
> MODULE_PARAM_PREFIX, instead of using the default KBUILD_MODNAME ".".
> 
> Commit 730b69d22525 ("module: check kernel param length at compile time,
> not runtime") added a check to ensure the prefix doesn't exceed
> MODULE_NAME_LEN, as this is what param_sysfs_builtin() expects.
> 
> Later, commit 58f86cc89c33 ("VERIFY_OCTAL_PERMISSIONS: stricter checking
> for sysfs perms.") removed this check, but there is no indication this was
> intentional.
> 
> Since the check is still useful for param_sysfs_builtin() to function
> properly, reintroduce it in __module_param_call(), but in a modernized form
> using static_assert().
> 
> While here, clean up the __module_param_call() comments. In particular,
> remove the comment "Default value instead of permissions?", which comes
> from commit 9774a1f54f17 ("[PATCH] Compile-time check re world-writeable
> module params"). This comment was related to the test variable
> __param_perm_check_##name, which was removed in the previously mentioned
> commit 58f86cc89c33.
> 
> Fixes: 58f86cc89c33 ("VERIFY_OCTAL_PERMISSIONS: stricter checking for sysfs perms.")
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  include/linux/moduleparam.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index bfb85fd13e1f..110e9d09de24 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -282,10 +282,9 @@ struct kparam_array
>  #define __moduleparam_const const
>  #endif
>  
> -/* This is the fundamental function for registering boot/module
> -   parameters. */
> +/* This is the fundamental function for registering boot/module parameters. */
>  #define __module_param_call(prefix, name, ops, arg, perm, level, flags)	\
> -	/* Default value instead of permissions? */			\
> +	static_assert(sizeof(""prefix) - 1 <= MAX_PARAM_PREFIX_LEN);	\

Can you clarify if -1 to remove the dot from prefix?

Final code 
	static_assert(sizeof(""prefix) - 1 <= __MODULE_NAME_LEN);	\

with __MODULE_NAME_LEN being:

#define __MODULE_NAME_LEN (64 - sizeof(unsigned long))


>  	static const char __param_str_##name[] = prefix #name;		\
>  	static struct kernel_param __moduleparam_const __param_##name	\
>  	__used __section("__param")					\
