Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5933554B;
	Tue, 16 Dec 2025 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765910694; cv=none; b=szsnxjVHsaDEeoUxu+KrUdxe/WW8+9BsJStfuSfgcFVyClfIP8jZl3UmHJV96uOgl7ojnfybG3Jwuc6TnHRlLa1tE3wGsLEOEtuv5ErgFcXK90EWKlSgidsyjiX3arAA8aALy4TmrHhrziOu5TYy5netPXp76/Za2tbpuWRgNow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765910694; c=relaxed/simple;
	bh=i/eK0A9mHA/LYRMXp9kXb4cZR/ni4luwZgKc/W1mh7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUfD4hNIpgMpnC96/rnMrWsdt8l8AVSE7wm9u8qOCsBIrpcCdMCxZqi+ngP7B1m35TzD7fjGjRo8JKA24A2jalhyx7+9/gtoR0wFB399VFwQ+C4+mFX9uQLZD5gl1dxxboiQ5PhWfv2vWCzjRk2cJzBB7Q2MgjCs07nSwPKeU9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WI7vxk/7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WI7vxk/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629A3C4CEF1;
	Tue, 16 Dec 2025 18:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765910693;
	bh=i/eK0A9mHA/LYRMXp9kXb4cZR/ni4luwZgKc/W1mh7A=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WI7vxk/7ef5UJj1l3VZiFoG9t2RvgPWnIFf0XhrcdfkSNlsocShAzr5LeC1iPjm07
	 XtAuGknoPsX2AwzJOxaW9e4CiP6aQdayWnfNXrQLGj4ROUsISk4pXiH2DLkHOFta0i
	 eJ+2Q2ZAvOPVDB3v12ZXw3DxszVsXYfjOmdui8qkcIKQEkP/jOnvHX/3SJRr5vvwjn
	 14tX+wO7dNjXJKg1QZ9vwRT06LuK6bO3LQFeNp3ULRPzijAibpTVpJAnwGQ0Uf7BRG
	 VEpgz42Z3Wi4kqMVWdkQxnty0xyuZhxdQu6n1fftvrN3iKmE9FsmTUckONupM9CEY7
	 pne4CzGh1DGMA==
Message-ID: <08eabb74-eaec-4dad-bf60-1413398396fb@kernel.org>
Date: Tue, 16 Dec 2025 19:44:50 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update module subsystem maintainers and
 repository
To: Sami Tolvanen <samitolvanen@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251215215545.1332626-2-samitolvanen@google.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20251215215545.1332626-2-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/12/2025 22.55, Sami Tolvanen wrote:
> Add myself as a maintainer for module support as I'll be handling pull
> requests for the next six months according to the previously announced
> rotation [1][2].  Also, update the git repository link to point to the
> modules tree, which is already used by linux-next.
> 
> Link: https://lore.kernel.org/linux-modules/Z3gDAnPlA3SZEbgl@bombadil.infradead.org [1]
> Link: https://lore.kernel.org/linux-modules/20251203234840.3720-1-da.gomez@kernel.org/ [2]
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b11839cba9d..0c18b87925f0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17613,12 +17613,12 @@ MODULE SUPPORT
>  M:	Luis Chamberlain <mcgrof@kernel.org>
>  M:	Petr Pavlu <petr.pavlu@suse.com>
>  M:	Daniel Gomez <da.gomez@kernel.org>
> -R:	Sami Tolvanen <samitolvanen@google.com>
> +M:	Sami Tolvanen <samitolvanen@google.com>
>  R:	Aaron Tomlin <atomlin@atomlin.com>
>  L:	linux-modules@vger.kernel.org
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git modules-next
>  F:	include/linux/kmod.h
>  F:	include/linux/module*.h
>  F:	kernel/module/
> 
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8

Acked-by: Daniel Gomez <da.gomez@samsung.com>
