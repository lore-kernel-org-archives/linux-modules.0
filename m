Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBF21CF83
	for <linux-modules@vger.kernel.org>; Mon,  2 Oct 2023 16:57:43 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E9EB8
	for <linux-modules@vger.kernel.org>; Mon,  2 Oct 2023 09:57:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c60a514f3aso53625ad.3
        for <linux-modules@vger.kernel.org>; Mon, 02 Oct 2023 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696265861; x=1696870661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i59JrJXWn0I4GHAvwruiaJLmC8yZXpZX5lGiOcVDgzc=;
        b=PeLHX79hqfPPghINRHy0NyX1l38B9zVeBq+7a8z4kHmh4FFCx+7eB6/gKx3ef/oszV
         fiWE6PMcj9ge30QBGjV+52aCFjzmMO5wu0nFmyJg3zX1SN5xfYr9SM63OEtfb4tKS2Dl
         MfXWWLL1Ej+9ZQra2TN8dWtqRfklqut//hn8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265861; x=1696870661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i59JrJXWn0I4GHAvwruiaJLmC8yZXpZX5lGiOcVDgzc=;
        b=Dg6iVtHhnyJ7ic7AkFWZkPaBqVj5WdqYi7bSg8HOYZPf7xKH28aE26K81H0RXXvuDn
         RLKn1yhxFUQcsppzFarY3w+SVQWwCICQjVRRYfGJ+42UR0atARmIH7tLcHOJ21xayfph
         DK8RWi8T+kJHTuNxBrRvS9O2D4C5t1hthrWVyEJ6rWHNrM7BvRepd1rhViA4aOiChNgm
         tMsY1RZnBzpK2xu5FIOjm+uc/v6NLj4MqU1TkGGsiKZGfjOgyy5/XYSThRyLvQqa7gVf
         17YjgtL1jEY8Qz4oTjRxbkAytwZN/OCQeb+vITvcaIiGsnlxd37FRHbmbC4eJmi8YlEV
         Y6/Q==
X-Gm-Message-State: AOJu0YwGFthzF6ssxW3ux23/l57JtrY3Y053eTxZhGV+q0WLmR2hGNdO
	nDGcan9mgQaf0Tw/EmoYxdeNhw==
X-Google-Smtp-Source: AGHT+IGnn5OV17hnLKq0t7/owjFSVTDzAdiCLLhTlLFY2ZcuMqxzI7nr2Ppl/kYZdYMGR2rJMkFcew==
X-Received: by 2002:a17:902:c409:b0:1c5:f4c7:b4d5 with SMTP id k9-20020a170902c40900b001c5f4c7b4d5mr14735849plk.34.1696265860790;
        Mon, 02 Oct 2023 09:57:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h21-20020a170902f7d500b001c728609574sm10420569plw.6.2023.10.02.09.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:57:40 -0700 (PDT)
Date: Mon, 2 Oct 2023 09:57:37 -0700
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/5] params: Do not go over the limit when getting the
 string length
Message-ID: <202310020956.AF556DC@keescook>
References: <20231002124856.2455696-1-andriy.shevchenko@linux.intel.com>
 <20231002124856.2455696-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002124856.2455696-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 03:48:53PM +0300, Andy Shevchenko wrote:
> We can use strnlen() even on early stages and it prevents from
> going over the string boundaries in case it's already too long.

It makes sense to avoid calling strlen() multiple times. I don't have
much opinion one way or another about using strnlen() here, since we
know the string will be terminated.

-Kees

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/params.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index 626fa8265932..f8e3c4139854 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -260,7 +260,10 @@ EXPORT_SYMBOL_GPL(param_set_uint_minmax);
>  
>  int param_set_charp(const char *val, const struct kernel_param *kp)
>  {
> -	if (strlen(val) > 1024) {
> +	size_t len, maxlen = 1024;
> +
> +	len = strnlen(val, maxlen + 1);
> +	if (len == maxlen + 1) {
>  		pr_err("%s: string parameter too long\n", kp->name);
>  		return -ENOSPC;
>  	}
> @@ -270,7 +273,7 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
>  	/* This is a hack.  We can't kmalloc in early boot, and we
>  	 * don't need to; this mangled commandline is preserved. */
>  	if (slab_is_available()) {
> -		*(char **)kp->arg = kmalloc_parameter(strlen(val)+1);
> +		*(char **)kp->arg = kmalloc_parameter(len + 1);
>  		if (!*(char **)kp->arg)
>  			return -ENOMEM;
>  		strcpy(*(char **)kp->arg, val);
> @@ -508,7 +511,7 @@ int param_set_copystring(const char *val, const struct kernel_param *kp)
>  {
>  	const struct kparam_string *kps = kp->str;
>  
> -	if (strlen(val)+1 > kps->maxlen) {
> +	if (strnlen(val, kps->maxlen) == kps->maxlen) {
>  		pr_err("%s: string doesn't fit in %u chars.\n",
>  		       kp->name, kps->maxlen-1);
>  		return -ENOSPC;
> -- 
> 2.40.0.1.gaa8946217a0b
> 

-- 
Kees Cook
