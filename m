Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9C204C19
	for <linux-modules@vger.kernel.org>; Thu,  6 Mar 2025 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257993; cv=none; b=XplFqLacMK80NV98WayitQjLYJGHhbAdCMoB0IhdKXEGjsOS5z1o5rxHbcyVNMuZcl9bV5gXzYKinKsYghgbVsoS4vbERj+nndqx+qei8fiKEZUpvp5/PoMN2AAmx1FIkqePrEYfTM3daBUX3RHqSVS80HIqMy63QxTLbHSfbXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257993; c=relaxed/simple;
	bh=Qa5Et0gvv3p/BcZdyVXai6bWH3AAkZCVeICVNY2sApM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtunVl3PzEoG58ASYMSfTU0l095NMdg8B/cx6wACikghVhcKu2upyWOPWoUVX4eu2g+DnMNB3ZNtTo9R+aVh9pOHX/RIRFitRs5V9ICjX6A+xU+qVNeWPF2VsFLOS81FPR7Gu6t72uxP1pvQozqr+dJ0/JKxxD2i2uFCOCmUgkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Im3G5O1s; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Im3G5O1s"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390d98ae34dso399806f8f.3
        for <linux-modules@vger.kernel.org>; Thu, 06 Mar 2025 02:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741257989; x=1741862789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fkHTvO+oIET9PnrsPyt/L/ZeMCtN2W38zE113sj9AVM=;
        b=Im3G5O1sSPC08UfYz4n8IG52nHiwkIECHzG31snlN98TIepcZr6K7YVi5Y1J/QRQ2B
         8hdSAhuxgSN/2bvqY2ILHP88GW90jKteYVni1rsrb9AQIt25hrLDskIPPANrTqvAvOb8
         5uV9ci5SnM5yZAYjmG+lpg4fN71lOUDc5XnZ8jdZ4hT3vfGehw8M5kZ3lVQW5PJ61Wcl
         q3zIiVTHjkPtYV7zAfkjCDlVBupA31hEzDrJDjur3TnYglkQYbGruKCtQ+GHtm+Cxzqn
         eCXvRCC7vGGpnGmTgdp97sKxBf0Oh8JsmEMroULvjXKQ52GSkYI1EPOy+k9TjDtCmWTr
         8y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741257989; x=1741862789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkHTvO+oIET9PnrsPyt/L/ZeMCtN2W38zE113sj9AVM=;
        b=GJEcnUKSnMxNfBos+vDooUz/DevJqnQhOSS02FmV/BaHg2c4uXFRfFEXZLLRKK/qVo
         h/1TRMDOBy/h6kX8SrzBXbmtfD6Nqq7r2hkwQiJ9IOEp5SL2lHXysU77Whiu0mkzjneP
         CN/akGyOKQMdt4vTa2SWIucy5JyWds7FE010bhZJkqrIuKmT8ls+8HXWOrOJVdeq0UU4
         FGOJq5dW3R4/v56hoBa59c7tcqCH8gLEKPXqoO/89ZTSQRrNgeC2O2bvVxy03Pg/qgKB
         0mYhnFTC3xtQNifOM8grS3YEXk8L/6pDzX1Y+0enckkioh8mswfOMHmo2R8WIyrVPFZY
         oG8g==
X-Forwarded-Encrypted: i=1; AJvYcCUB9q8MSdNNOBzyAYM/xs9/DwgTT9lAM1091nBMAHdiG9LvnSa1wKlc0hDKP9H188IBsms+NBCCuavKP8Cg@vger.kernel.org
X-Gm-Message-State: AOJu0YwJcE9nTKYk7d76X5rRVTFCs7w4iV+zxZz/whVQPLZvmr10LfL2
	hkNDyp+YYUBVRxuC5S76Vsv14s6DzzFzLzrkmY7Cg5ONuCF0pbDm8yZ/kNWIv4o=
X-Gm-Gg: ASbGncs2FCjvJDh8JuYLzmk7R1HtTm0w7iXli43GB8p+JzOctBKyZsEqk7Uri6R6a0k
	zobq9Tp69Ar05k3C+hj+IXc6FnA0KcvBMzP8AWNlAshBvIxzZS/pVebqkTz3jplN26oQ/CMl/VJ
	T98b/y7BfSdp5DefHNzrKCsO8KTW/vqSyGIVrjGICeylGvhV4oC6hhQZQzDJnMp7LzwVyy/rheR
	xC1f0Er0/Qqrle0G8cgCZsq+F7A+m9NKIE0l7Dxo92VFjHyUp47vdtuk/4776MvJBgZmJUwG95d
	ybL3SCaTU5aPggPUCIuYl3gla49ax1ZqTgPamsyj8okRv/X4
X-Google-Smtp-Source: AGHT+IEdUBKnKntjvqVrcp/OG7ngs5sQaBxSY4kHpMJ6pNTSO9RVQTM9IznmrPcXePdKosvlXYpKOg==
X-Received: by 2002:a05:6000:2d08:b0:391:ba6:c069 with SMTP id ffacd0b85a97d-3911f7c246bmr4394632f8f.44.1741257989257;
        Thu, 06 Mar 2025 02:46:29 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd947544sm15724995e9.35.2025.03.06.02.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 02:46:28 -0800 (PST)
Message-ID: <a9b364ea-e914-47c7-bb68-627fe1b668bd@suse.com>
Date: Thu, 6 Mar 2025 11:46:27 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Taint the kernel when write-protecting
 ro_after_init fails
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Jani Nikula <jani.nikula@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250306103712.29549-1-petr.pavlu@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250306103712.29549-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+To: Christophe Leroy <christophe.leroy@csgroup.eu>

On 3/6/25 11:36, Petr Pavlu wrote:
> In the unlikely case that setting ro_after_init data to read-only fails, it
> is too late to cancel loading of the module. The loader then issues only
> a warning about the situation. Given that this reduces the kernel's
> protection, it was suggested to make the failure more visible by tainting
> the kernel.
> 
> Allow TAINT_BAD_PAGE to be set per-module and use it in this case. The flag
> is set in similar situations and has the following description in
> Documentation/admin-guide/tainted-kernels.rst: "bad page referenced or some
> unexpected page flags".
> 
> Adjust the warning that reports the failure to avoid references to internal
> functions and to add information about the kernel being tainted, both to
> match the style of other messages in the file. Additionally, merge the
> message on a single line because checkpatch.pl recommends that for the
> ability to grep for the string.
> 
> Suggested-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
> I opted to use TAINT_BAD_PAGE for now because it seemed unnecessary to me
> to introduce a new flag only for this specific case. However, if we end up
> similarly checking set_memory_*() in the boot context, a separate flag
> would be probably better.
> ---
>  kernel/module/main.c | 7 ++++---
>  kernel/panic.c       | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 1fb9ad289a6f..8f424a107b92 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3030,10 +3030,11 @@ static noinline int do_init_module(struct module *mod)
>  	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
>  #endif
>  	ret = module_enable_rodata_ro_after_init(mod);
> -	if (ret)
> -		pr_warn("%s: module_enable_rodata_ro_after_init() returned %d, "
> -			"ro_after_init data might still be writable\n",
> +	if (ret) {
> +		pr_warn("%s: write-protecting ro_after_init data failed with %d, the data might still be writable - tainting kernel\n",
>  			mod->name, ret);
> +		add_taint_module(mod, TAINT_BAD_PAGE, LOCKDEP_STILL_OK);
> +	}
>  
>  	mod_tree_remove_init(mod);
>  	module_arch_freeing_init(mod);
> diff --git a/kernel/panic.c b/kernel/panic.c
> index d8635d5cecb2..794c443bfb5c 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -497,7 +497,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
>  	TAINT_FLAG(CPU_OUT_OF_SPEC,		'S', ' ', false),
>  	TAINT_FLAG(FORCED_RMMOD,		'R', ' ', false),
>  	TAINT_FLAG(MACHINE_CHECK,		'M', ' ', false),
> -	TAINT_FLAG(BAD_PAGE,			'B', ' ', false),
> +	TAINT_FLAG(BAD_PAGE,			'B', ' ', true),
>  	TAINT_FLAG(USER,			'U', ' ', false),
>  	TAINT_FLAG(DIE,				'D', ' ', false),
>  	TAINT_FLAG(OVERRIDDEN_ACPI_TABLE,	'A', ' ', false),
> 
> base-commit: 48a5eed9ad584315c30ed35204510536235ce402

