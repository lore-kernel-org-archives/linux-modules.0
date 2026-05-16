Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FB827707;
	Sat, 16 May 2026 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778900641; cv=none; b=VNYaCjlBSkMwDsWdtuTNFUI6jAv/vjKaWuh8WZwYYQyi7lnzStf5uqiIDktMu+wmCQHQh7O5Gy3xhTwjDwV0J4GSpEEBsQhIxPIQ+nsCebOcgl3NtiMouj7UIuFjCGYflBlNPnw0ocfq17+djs3aB0e0peHplbbIOCd6bcfCZ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778900641; c=relaxed/simple;
	bh=Ag617hFqG7BHCVNrDUKuZW1Ts3GM5eNhi1t8ofu7UbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MajTPT6I6q7BEWXmzyPySHBDvOrXBr7qmV8uLJ1u+580Wca5qY2Ynlg8NZP8ONOeoq8dXAd8V5MNz/FsAiK6CNzEXEF6zpRuDqbrMMgl4cl7QbqtRMUhaQ9Bf6rTdc7guOkW7VILsnF8WYBsX8H78STpBeK7bJLjnQH6u8BC5rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cb1nTPv4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cb1nTPv4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=b/I3PflPPdq6PvBh/NoGqB8Qc6JnpQZG4wiTlJF/3BI=; b=Cb1nTPv4QM0NpQ9d1Tz795+05E
	VSt2MJIb9AL9XdzUd3YeYlKboqxCV/m4LqQHwGjqAC3h2odpmTV975GxaFxZGCFwzb1i1n6qJzOHR
	sBtL8T+TSCBpSPYqcOqvjLyYSQ05Bi/u+cQTxpAIs7tcGMUgiHJABx8Qc5CTnBmc3Xv6SB3tvTz3f
	/ytQsfDaT0jjvCmjOZb2dC0O5Lzmsif5ysw26bHNVgrivbooOwJAfhkiq/aCOEXyYRRLLeTRHoYv+
	TtXT7Ty3IrBfwmf8TqSrDx4Vjmn6kjTt6bAUhQEr6mgWZ8XMjDx+SUWrIkwWTaPvyoxAbHiic60WA
	X1nimc5g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO5Jk-0000000A0AS-0Q0k;
	Sat, 16 May 2026 03:03:56 +0000
Message-ID: <b7d5c3a6-1d57-469b-857a-f381e55735dc@infradead.org>
Date: Fri, 15 May 2026 20:03:55 -0700
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] module: add CONFIG_MODULE_RESTRICT_AUTOLOAD
To: Michal Gorlas <michal.gorlas@9elements.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
References: <20260515-autoload_restrict-v1-0-40b7c03ddd04@9elements.com>
 <20260515-autoload_restrict-v1-1-40b7c03ddd04@9elements.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260515-autoload_restrict-v1-1-40b7c03ddd04@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/26 10:20 AM, Michal Gorlas wrote:
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index 43b1bb01fd27..c9e01bb848c0 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -337,6 +337,21 @@ config MODULE_SIG_HASH
>  
>  endif # MODULE_SIG || IMA_APPRAISE_MODSIG
>  
> +config MODULE_RESTRICT_AUTOLOAD
> +	bool "Restrict module auto-loading to privileged users"
> +	default n
> +	help
> +	  Restrict module auto-loading in response to use of some feature
> +	  implemented by an unloaded module to CAP_SYS_ADMIN. Enabling this
> +	  option helps reducing the attack surface where unprivileged users

	         helps reduce
or
	         helps to reduce

> +	  can abuse auto-loading to cause a vulnerable module to load that is
> +	  then exploited.
> +
> +	  Note that this option also prevents a benign use of auto-loading for
> +	  a non-root users. Thus if enabled, the root user should execute
> +	  modprobe manually if needed, or add the module to the list of modules
> +	  loaded at the boot by modifying init scripts.

-- 
~Randy

