Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hmM7Xeaa"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66453181;
	Thu, 16 Nov 2023 09:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EGB0vGjW+NZmH1KV7ZusM44EJIy7WocoQO8gjJ04laQ=; b=hmM7Xeaa9/7wgUcUiyV0v0TOOr
	q11CzoIpaSMRn3jbe5Ik3K2TqwgoIH54hHbgK3ZwBEnNXgnfs2i3gs1SZ88ub4PKjZY5HdA1RSPbK
	nOpMy0eEiglW7sOx8q8LKM0oKmRaIG4I5RFWs9hHmddY9/mDh1o0JPDDIZJTe5UMkxwEEdd/rMiRa
	fqoaTQn3rZUbRhNm4g1yq8ZwFjYovjI5yE7gl4aXI2kLYKQxgSoz5k/UU6Vba1eBr+TnBgoOvc7oF
	1D9bxFrjyDMA9tsR3PzgEd+gFbrRDqM+PTOPII+lMN5bfl1wzJ8cmQdD7iGuJGw48Kiq4OZ/fvklq
	6XySaSTw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r3gH4-0049tr-0z;
	Thu, 16 Nov 2023 17:35:30 +0000
Date: Thu, 16 Nov 2023 09:35:30 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] Modules: Introduce boot-time module signature
 flexibility
Message-ID: <ZVZS4hw5dGB4aPz3@bombadil.infradead.org>
References: <20230914112739.112729-1-alessandro.carminati@gmail.com>
 <20230914112739.112729-2-alessandro.carminati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914112739.112729-2-alessandro.carminati@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Sep 14, 2023 at 11:27:38AM +0000, Alessandro Carminati (Red Hat) wrote:
> This commit introduces a novel boot argument parameter that provides an
> advanced level of control over the verification of module signatures
> during the initial stages of booting. With this enhancement, we gain the
> capability to postpone the verification of module signatures to after
> intrd stage is finished.
> 
> Given that bootloader-provided artifacts are commonly employed
> post-verification,

Is such a thing expressed with a kernel config? If so then shouldn't
this be default for those uses cases?

> Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
> ---
>  include/linux/module.h  |  4 +++
>  kernel/module/main.c    | 14 ++++++-----
>  kernel/module/signing.c | 56 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 68 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index a98e188cf37b..9899aeac43b0 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -34,6 +34,10 @@
>  
>  #define MODULE_NAME_LEN MAX_PARAM_PREFIX_LEN
>  
> +#ifdef CONFIG_MODULE_SIG
> +extern int module_sig_check_wait;
> +#endif

Please add under is_module_sig_enforced. That's one new line Vs 3 new ones.

I see the code which skips module signature verification and the knobs
but I don't see the code which complete the promise to do the actual
signature verification post initrd / initramfs state. What gives?

  Luis
