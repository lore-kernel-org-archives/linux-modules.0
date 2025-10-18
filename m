Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387982441A6;
	Sat, 18 Oct 2025 20:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760819644; cv=none; b=VDnWhcR08EMoHsBHq1nZmsGQsVMJDO7DnARLtDYkJnI51Uoz+TrxqC04ajoF045YoSOySQGXSiZA5Bbgw39/0gm0doLlVURGjGzVbi05LupuHhrr6ZktaEUefO1io1GpU74xjSkBe0s3JsGMCrL9Ql+q/6mRs6/EbdG1stmQsGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760819644; c=relaxed/simple;
	bh=qDa8dNRA7HvXBHymxnFXRXDRH7wM3VWNwm2gtCpL+8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5HXJwHA0PhDguHOZcpFxkSFADjrvprpTjERSSPqmy/laTm6S0QcCVkXml192wodO/6R4QISXlD6r5Go31JRHxDSsZjbG7JQKDZ9pSH7dBkp96ljTXQjaAkvxpSm7fdyuNwOFGGHwp3LmsaK7tv2KaqWYxe/9+WzZZz500WoJfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvIn3uZP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvIn3uZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DEDC4CEF8;
	Sat, 18 Oct 2025 20:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760819643;
	bh=qDa8dNRA7HvXBHymxnFXRXDRH7wM3VWNwm2gtCpL+8c=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mvIn3uZPhjBYp1aWcR4ekTpznp/TSUpcg9uKf4wiXcWgBCVT3Z7ETE2+qpX5GdgM2
	 YSKhfr8ajjGXhcFv4Yqrlj9zbRMIqRdtb0KtSKXk9f4ToyUAqFeUSTeAof80z8tMhS
	 1Uz5XYKW2dvShit2u3Jb65X6MhSsdwSD0V1Ua9tsG6+KL9vwI3gsY8et8mDoTIPL6d
	 /Zrw7CFLnLxyNt56JqL+JO5Rt4VujtSPrDLkl7cyAv6LoTuurGxYa6J72MJ4tHei0C
	 D1ZhNJbVIUaxP7ZnHRj9pDlDhSBMomC2UtChqw4IfWNJuuYLlbcujbK2VvtyemB4Pw
	 gpuDgcVGDOLEw==
Message-ID: <1431286d-e802-44ab-b40d-86bcfed42e3a@kernel.org>
Date: Sat, 18 Oct 2025 22:33:59 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add myself as reviewer for module support
To: Aaron Tomlin <atomlin@atomlin.com>, mcgrof@kernel.org,
 petr.pavlu@suse.com, samitolvanen@google.com
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251018180210.347619-1-atomlin@atomlin.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20251018180210.347619-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/10/2025 20.02, Aaron Tomlin wrote:
> Voluntering as a reviewer for Module support.
> 
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 545a4776795e..c6c860ccdbef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17392,6 +17392,7 @@ M:	Luis Chamberlain <mcgrof@kernel.org>
>  M:	Petr Pavlu <petr.pavlu@suse.com>
>  M:	Daniel Gomez <da.gomez@kernel.org>
>  R:	Sami Tolvanen <samitolvanen@google.com>
> +R:	Aaron Tomlin <atomlin@atomlin.com>
>  L:	linux-modules@vger.kernel.org
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained

Help is much appreciated.

FYI, I'm currently the one sending PRs to Linus, and I plan to send some of the
reviewed fixes next week. In addition, by the end of rc3/rc4, we'll be ready to
merge Andreas' patches with Rust module parameter support, leveraging kdevops
CI integration.

This patch, if/when acked-by the rest of the maintainers, can be merged in any
of these 2 planned PRs.

Acked-by: Daniel Gomez <da.gomez@samsung.com>
