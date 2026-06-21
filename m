Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE1F25A359;
	Sun, 21 Jun 2026 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782071087; cv=none; b=qf2DHWCfQR2hj0kkaYHWnmJxa3GD8VzDiTTzf4BhKPV0jRsSGlDwZlnr+Z7kyPwz2BC7kCqjKYhSS7E+h/2TRHo6O8hnh5zyU9NVarvJxnDzdKAf4IsGP9swMhJd6FUzOMuPn/Pu967Gfa9bN131YS6iU3wp7QvSXAPLhE+JqaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782071087; c=relaxed/simple;
	bh=cWeb52D/iFIsBIo/TMoeP1sMqPXvb1PWoaup82ZpGD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHxRLyxr4WxK5O6qfw+Mb2XFotR34oiwyZlb1xPP+Fa5IPfDA2NWB7wse5FPy3BOD4yWw+GdKEYbElqZh/VUxFkyqrc/pYfvwq+J3sE+GJd/BN7tVttRgthOBHouftkOcmzeBYwEmK7I5Dy+uxpBZMu3HAAnkmZtKTl4s38fHhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p6/gGHRR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p6/gGHRR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/ge2LfSi6SJh6RtEJ8h4K8CBdMsdzcj8v9US9u9tAME=; b=p6/gGHRRYwZ0NBH1mtYTaeLMDi
	t4IoVciv5phPW5zruwCN2D0jghDWwx8dHydqy2bB64+hV3pvLix5ohMS3DBe6ZTmtawRf+X7RQSQu
	lRfio7rD4H32Bx4/KurUKu8i+nkFg6ukxj8PUISP9Ixm9wPXug3FoGXj/3kHHeVO3wQtaUS4lssHE
	0cK9ZKoiQ8grnUOgvj1/LfxnZlpYIwQrAv+I+tosZz3GbRhWRa7dQkmIznl/NUGDeC+j+bJj8bEWf
	O98JaGBnIljn/NdkPd6KpJCCAORqL0aA/JvLoROSyolwrLtFtS33AnmIVz8AM+6J9qscAQkTOCRV/
	0h+LzqUw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbO60-000000048Gq-1Xq4;
	Sun, 21 Jun 2026 19:44:44 +0000
Message-ID: <9069a13d-bed2-4e1b-9675-4c6bfe42e4f2@infradead.org>
Date: Sun, 21 Jun 2026 12:44:43 -0700
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] params: fix path of /sys/module/XYZ/parameters/ in
 comment
To: Zenghui Yu <zenghui.yu@linux.dev>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
 samitolvanen@google.com, atomlin@atomlin.com
References: <20260621082223.11439-1-zenghui.yu@linux.dev>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260621082223.11439-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/21/26 1:22 AM, Zenghui Yu wrote:
> The comment wrongly references to /sys/modules/XYZ/parameters/ directory
> instead of /sys/module/XYZ/parameters/. Fix it.
> 
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
> 
> kernel/params.c is not covered by any MAINTAINERS entry. I assume it should
> be a "MODULE SUPPORT" stuff?
> 
>  kernel/params.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index a668863a4bb6..3456b104efc9 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -538,7 +538,7 @@ const struct kernel_param_ops param_ops_string = {
>  };
>  EXPORT_SYMBOL(param_ops_string);
>  
> -/* sysfs output in /sys/modules/XYZ/parameters/ */
> +/* sysfs output in /sys/module/XYZ/parameters/ */
>  #define to_module_attr(n) container_of_const(n, struct module_attribute, attr)
>  #define to_module_kobject(n) container_of(n, struct module_kobject, kobj)
>  

-- 
~Randy
