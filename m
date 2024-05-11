Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15EB1CAB5;
	Sat, 11 May 2024 22:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715467322; cv=none; b=hDGDvX2ZCGqtnARA3HizMhVIIC0i87tU0IErUVKODUXe49JjbosSyEfXgVbYFjlbdYBpTlOi4hBz+KfMxzJ0BZpGynE2R/xeTQDQSW70Nvo9pKrBTZBjrXa6sgpx1DnEtBjHd7nHWXKPEmxqkBCn5Emkusify4a/Eot3XGXJbmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715467322; c=relaxed/simple;
	bh=ImT+zG46hw75vkYt5VczaukzYwC+i9ZZIbn292nmwbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIimumnSLhukwj+5MMALgznBMd1PnL+Ac0kBnigJSGJhldPQ4MpyIxqcg8Lypz6Pzw2/Ra3l93rddrh4gTofa4sl3cjXD9PjZ9UNoqgIrFBDLQv2cYgNU2sfiI4WfGn1M2wfdvVujWW9ZHeWm+pwIDGmrV0rHrfvD9N7DFLy1Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EeNmwkY1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EeNmwkY1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qAHFM88/yKEIIWcahJngYsB9RtXSWKVbO/YNrJK1KEE=; b=EeNmwkY1RBzj2ofjbPzXHiZB4X
	9Z7b7O8YHs5P87z08Mux3zlmyjmZfhq78sCJBuFmpVzbE/HMF8UrC6+4TpiDTlFhHkoq6dflzufKp
	w1jYdQxwvPtdmbDBuKDkM2Fptwjb2ynEk24Xm8A/gAI0bV0NGzV00WDC9KyrnKI5ROrOVRhOHD0Tk
	Ub38CUkDUzFjez18TSWHNgK3hqOK+b1Y7yyFssWtjko5DIpJvPHZjIWN7vyQgu1z2ZMR1pSS9ljWz
	4ZtP5U1fXs669lCqKOEFJ5lAZJWUGDSifWYTmWQt6vAycIVZE55NrLgLl07jrr/TzOyb6hosrJz6a
	j5aCQSwg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5vPZ-00000008qCI-2kct;
	Sat, 11 May 2024 22:41:52 +0000
Date: Sat, 11 May 2024 15:41:45 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: wangyao@lemote.com, Masahiro Yamada <masahiroy@kernel.org>
Cc: masahiroy@kernel.org, ainux.wang@gmail.com,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modules: Drop the .export_symbol section from the final
 modules
Message-ID: <Zj_0KU2cInEUbsW3@bombadil.infradead.org>
References: <20240417053530.30995-1-wangyao@lemote.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417053530.30995-1-wangyao@lemote.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Apr 17, 2024 at 01:35:30PM +0800, wangyao@lemote.com wrote:
> From: Wang Yao <wangyao@lemote.com>
> 
> Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
> forget drop the .export_symbol section from the final modules.
> 
> Signed-off-by: Wang Yao <wangyao@lemote.com>

Masahiro, commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by
modpost") was your change, wanna address / take it through your
tree? It makes sense to me though.

  Luis

> ---
>  scripts/module.lds.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index bf5bcf2836d8..89ff01a22634 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -13,6 +13,7 @@ SECTIONS {
>  	/DISCARD/ : {
>  		*(.discard)
>  		*(.discard.*)
> +		*(.export_symbol)
>  	}
>  
>  	__ksymtab		0 : { *(SORT(___ksymtab+*)) }
> -- 
> 2.27.0
> 
