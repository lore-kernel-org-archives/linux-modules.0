Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E0435519
	for <linux-modules@vger.kernel.org>; Tue, 10 Oct 2023 22:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qxcllpn9"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BD798;
	Tue, 10 Oct 2023 15:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GC2Zo8w3qa1p/gg7pwDrOZOfPLZQVYf+w0DHvJnVE8M=; b=qxcllpn94k9taiJWwKPRaifOWu
	Zek/PxhRD8VqWF24HxhcCh/7SU3bcsl8yxNYCoh6JUDqBhbEuhJveW1NeTwpdpAG6vtEj9ZcPSrF9
	EH4Aa4xp8OzWDWdcu36xtrb4eXHHoCxzJqZG0ZMiq6YZtbg5Lxu9wiXtLoKB/m65K7VNXqasChjyz
	hP9akOy46HVjZpCbvMaSfF37G63fVIoljV6B5AC2R6lyTkHcNn7pop0z+Ftp66QTMOPHGfArKrUW+
	FdSBnQL0Yt8/Gi0brT9OTcRkLga1T8H4Qy6W76dgASS9gA6dtpiNmKMkpuQhK/Cbe2qZrFo3jr88c
	UEe6Pwlw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qqLL2-00EHGM-2n;
	Tue, 10 Oct 2023 22:36:28 +0000
Date: Tue, 10 Oct 2023 15:36:28 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Joey Jiao <quic_jiangenj@quicinc.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Add CONFIG_MODULE_LOAD_IN_SEQUENCE option
Message-ID: <ZSXR7PJmXZpZxQ2R@bombadil.infradead.org>
References: <20231009045636.4143-1-quic_jiangenj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009045636.4143-1-quic_jiangenj@quicinc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 10:26:35AM +0530, Joey Jiao wrote:
> When modprobe cmds are executed one by one, the final loaded modules
> are not in fixed sequence as expected.
> 
> Add the option to make sure modules are in fixed sequence across reboot.
> 
> Signed-off-by: Joey Jiao <quic_jiangenj@quicinc.com>
> ---
>  kernel/module/Kconfig | 11 +++++++++++
>  kernel/module/main.c  |  6 ++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index 33a2e991f608..b45a45f31d6d 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -389,4 +389,15 @@ config MODULES_TREE_LOOKUP
>  	def_bool y
>  	depends on PERF_EVENTS || TRACING || CFI_CLANG
>  
> +config MODULE_LOAD_IN_SEQUENCE
> +	bool "Load module in sequence"
> +	default n
> +	help
> +	  By default, modules are loaded in random sequence depending on when modprobe
> +	  is executed.
> +
> +	  This option allows modules to be loaded in sequence if modprobe cmds are
> +	  executed one by one in sequence. This option is helpful during syzkaller fuzzing
> +	  to make sure module is loaded into fixed address across device reboot.
> +
>  endif # MODULES
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 98fedfdb8db5..587fd84083ae 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2593,11 +2593,17 @@ static noinline int do_init_module(struct module *mod)
>  	 * be cleaned up needs to sync with the queued work - ie
>  	 * rcu_barrier()
>  	 */
> +#ifdef CONFIG_MODULE_LOAD_IN_SEQUENCE
> +	llist_add(&freeinit->node, &init_free_list);
> +#else
>  	if (llist_add(&freeinit->node, &init_free_list))
>  		schedule_work(&init_free_wq);
> +#endif

How is ignoring an error ensuring ordering?

>  	mutex_unlock(&module_mutex);
> +#ifdef CONFIG_MODULE_LOAD_IN_SEQUENCE
>  	wake_up_all(&module_wq);
> +#endif

Why are you making this only now be called with this new kconfig option?

  Luis
