Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8147C1A705
	for <linux-modules@vger.kernel.org>; Fri, 27 Oct 2023 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j7i09mvV"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792B7121
	for <linux-modules@vger.kernel.org>; Fri, 27 Oct 2023 05:27:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-408382da7f0so15265865e9.0
        for <linux-modules@vger.kernel.org>; Fri, 27 Oct 2023 05:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698409646; x=1699014446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ShpExnipWNoGHM8TmERMpEvZiu9LbbtWo0359LRRBpg=;
        b=j7i09mvVrP6uvJKoVM2fT157c9ImZp0ywtrWtWTOUw7oRcJscil1EtyUuTAdtn9PpQ
         c+9Wkt+wnl0uAIFK1WLrgFIKNLe2j5uRoyDvESvu6G0T/j4FwJCefk8ZsS32eaqdfPXE
         UEomSITjvCtVi8stGgZEalvBFaxecJYo/hcLShS4d06obLsO7qZMVyUXuaxMBvglF5ZZ
         RhYDenhtv+sXLUehQXF+0kpi1yeI20nAwQAjcFVFRALb2VOuDxDMGk8NSHjAkZoxAVug
         2Vf78CuUnofK7HOsB9eGemrf/q/ScbiaEebFetcTspFrHwRDDtfJj1fP0XlGRRMw84Ow
         DVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698409646; x=1699014446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShpExnipWNoGHM8TmERMpEvZiu9LbbtWo0359LRRBpg=;
        b=f6vZZHLTTkeRo2NVXec3sS2oyMXXQl5FfON5F4CbWIPILxdo4CR8Pda8gzIApQ9SVZ
         t+wKJYRbrtboVNVweU0rZTFZtVxcJ+29JV0KjG9uq3Jmjrww3Tj44MyIYgrXb6+hvK6K
         XEnh/PC4is0ll0ONHGvvEbjdzCqO6Nvv0h4Dao1YYajMq0j0QU6D2rWsqaByHSLqj0jx
         9yaQkwaKW0jYdpRSkZhCr+DVEVkAI2ZAcCK0G2C/BFEPcNgAs/WW6zbq412UGWrqaXY+
         /apL9cH46izjPdFvrnQAVL2/b09BJBRf8WPjuH072mT9y6BtPsDeSWZfosT++xjB1TtW
         zWnw==
X-Gm-Message-State: AOJu0Yymj8Nt8OsgNlOHFzyYK2RLY8V47HG5s8df+ER02I+2Jn8sST5f
	p/MRA957/OhULmg97KU9V1tmTw==
X-Google-Smtp-Source: AGHT+IGePza+z4TfX66FZcDIf8/JNx8JVqKKHGbjY0Df9benTN6EIO45xrAYlVcVOsPga6unZ62FpA==
X-Received: by 2002:a05:600c:474f:b0:405:359a:c965 with SMTP id w15-20020a05600c474f00b00405359ac965mr2195472wmo.4.1698409645782;
        Fri, 27 Oct 2023 05:27:25 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c444a00b00401d8181f8bsm4981081wmn.25.2023.10.27.05.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 05:27:25 -0700 (PDT)
Date: Fri, 27 Oct 2023 15:27:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Joey Jiao <quic_jiangenj@quicinc.com>,
	linux-modules@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, quic_likaid@quicinc.com,
	Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] module: Add CONFIG_MODULE_DISABLE_INIT_FREE option
Message-ID: <a57e4eb8-329b-4503-bcd8-892ef44d8194@kadam.mountain>
References: <20231013062711.28852-1-quic_jiangenj@quicinc.com>
 <b2b20956-d80e-462c-8261-a41802996197@kadam.mountain>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2b20956-d80e-462c-8261-a41802996197@kadam.mountain>

On Fri, Oct 27, 2023 at 03:00:00PM +0300, Dan Carpenter wrote:
> 607c543f939d8c kernel/module.c      Andrii Nakryiko  2020-11-20  2579  #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> 607c543f939d8c kernel/module.c      Andrii Nakryiko  2020-11-20  2580  	/* .BTF is not SHF_ALLOC and will get removed, so sanitize pointer */
> 607c543f939d8c kernel/module.c      Andrii Nakryiko  2020-11-20  2581  	mod->btf_data = NULL;
> 607c543f939d8c kernel/module.c      Andrii Nakryiko  2020-11-20  2582  #endif
> c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2583  	/*
> c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2584  	 * We want to free module_init, but be aware that kallsyms may be
> 0be964be0d4508 kernel/module.c      Peter Zijlstra   2015-05-27  2585  	 * walking this with preempt disabled.  In all the failure paths, we
> cb2f55369d3a9e kernel/module.c      Paul E. McKenney 2018-11-06  2586  	 * call synchronize_rcu(), but we don't want to slow down the success
> 1a7b7d9220819a kernel/module.c      Rick Edgecombe   2019-04-25  2587  	 * path. module_memfree() cannot be called in an interrupt, so do the
> 1a7b7d9220819a kernel/module.c      Rick Edgecombe   2019-04-25  2588  	 * work and call synchronize_rcu() in a work queue.
> 1a7b7d9220819a kernel/module.c      Rick Edgecombe   2019-04-25  2589  	 *
> ae646f0b9ca135 kernel/module.c      Jeffrey Hugo     2018-05-11  2590  	 * Note that module_alloc() on most architectures creates W+X page
> ae646f0b9ca135 kernel/module.c      Jeffrey Hugo     2018-05-11  2591  	 * mappings which won't be cleaned up until do_free_init() runs.  Any
> ae646f0b9ca135 kernel/module.c      Jeffrey Hugo     2018-05-11  2592  	 * code such as mark_rodata_ro() which depends on those mappings to
> ae646f0b9ca135 kernel/module.c      Jeffrey Hugo     2018-05-11  2593  	 * be cleaned up needs to sync with the queued work - ie
> cb2f55369d3a9e kernel/module.c      Paul E. McKenney 2018-11-06  2594  	 * rcu_barrier()
> c749637909eea5 kernel/module.c      Rusty Russell    2015-01-20  2595  	 */
> 36022a47582048 kernel/module/main.c Joey Jiao        2023-10-13  2596  	if (!IS_ENABLED(CONFIG_MODULE_DISABLE_INIT_FREE) &&
> 36022a47582048 kernel/module/main.c Joey Jiao        2023-10-13  2597  	    llist_add(&freeinit->node, &init_free_list))
> 
> Let's not allocate freeinit if CONFIG_MODULE_DISABLE_INIT_FREE is not
> enabled.

Wait.  It's the other way around actually.  freeinit isn't used if
CONFIG_MODULE_DISABLE_INIT_FREE is enabled.

regards,
dan carpenter

