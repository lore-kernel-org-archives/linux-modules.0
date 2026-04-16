Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560543A5E84
	for <linux-modules@vger.kernel.org>; Thu, 16 Apr 2026 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335634; cv=none; b=o+s8wkZ5s8G/wyOAA7ZeQK/1cB43pHAfaLmmkTJH/PdwgnZ4E2XVbu7jpDp/s8pP2ZuTVN0zXn36eRFf4tbodIFrYT55A0wbnkj4BOGHacyifvNXtrVP1dg9kXltuMUySIHDu1iDJfLeZ8S22WiWyGTh+dm2HmZ37t7aPi5N+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335634; c=relaxed/simple;
	bh=PnkhtnPlWqR69u9/G7kOgPwF0gnYlgcUF1nrMIPg0fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8YiN9s99PKVsrLBcGO3a6sg8BpF9sPBfQZagp4bUh8xv6/GewHa48gj4WIr2iclZO3zlRlaorwWfGbD1yMk1FxXW+UFdQeFY5yTHwOSZhtB5O2P0t4irYk8Z9/tuVMDat/FVlmMJvo+d8ZsqmdiJuyoSt6KBaJVBiUHzP0GNFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yw99Yy5m; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yw99Yy5m"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4888375f735so77860235e9.3
        for <linux-modules@vger.kernel.org>; Thu, 16 Apr 2026 03:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776335627; x=1776940427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PFX0kfy1JVc6bVB6CE0bGMq+YH6jFLY5/9CO0YM6hrU=;
        b=Yw99Yy5m7kvN1KSa9pxCJ+rj4LVOuiacf7mjAZ1+hedrfUk5JyPIN6zYHYbyElzPIe
         x9JebNsVvvlrV/hoQwDjPkr/KB/PctEr7qKlO6OLJoafdSkZB9jeLeiL/a4vvE1M0t3/
         om3eA/uaTfwen6E5V1J4ngTZ+wAbgwElWypa4jFVmTWBptmpaTJTIPBbe6XRWVKrTzwu
         tebPL2lxwUgYQLNII1kDn9OyLAGJsxMAwVBH4Hvo76H6AxeHISu9mKkqAdAa5je+hRlh
         rg54EVzzcMHE6qqQpg2GAWy6DRWd74af5HXg0FkOYrlGVCqvUn9fRdyfGdcpNr1UxK7W
         J7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776335627; x=1776940427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFX0kfy1JVc6bVB6CE0bGMq+YH6jFLY5/9CO0YM6hrU=;
        b=rTP68ko5SkOrlMIfCQ9CHYONcoOvxEBidGPtXYHljrWI6yPhl9O1O02yY5AxqkWKQS
         hit1jV4m3jRMl8MW0CzW8szx55D9ZJI+esv7tNWb0GzXJxWISsOIIfWHJ77QfA2U5jCf
         gVOOi6V5ZE/XT9IoEtGI79QQYH5PwfefofH8EbNB5yQMrocfn/SmzmSAOStT2+waLw3Y
         v6aqn/6IQiNtBaf9C1QeUURnSTYoApeVs+gxAZ1p0gJfbZb23xMK/clO9PAGOS93mLJg
         BoXh6ar02+xPQULq09enf3BQuWKm5dNPeoU3nL/js1u4d8H2cQMrjozHN9wf3Uh+4sKd
         352g==
X-Forwarded-Encrypted: i=1; AFNElJ/Is46VXD55NC2X8rYwn/7Q1gkXNbv5QjPNjWm9R+I8QzTcG/RhNsyeaKcAG1NCzOhRjywkSpTSyHVbMYrI@vger.kernel.org
X-Gm-Message-State: AOJu0YyeEHHsyVeYp7QLySvbBc1F7h0iFXi9gFOcqQD/pWfsdgBdyugK
	MQAD94Yib8mw183t+f25S3x7ktQ8ufSodQnwuIuxA6BwSpNAxGua9zBMwSCCuTMXNlM=
X-Gm-Gg: AeBDiesqTHmzWnob0g3zLMpSew/7fPOdv6PZMw2r+m8NSYZAeUFQ+B41IeeL/Dd8eYj
	7Qxr59UjSiRWQzbTZsuR8Xa4evlic6N2H19zwr7b9ydcHjqNVW0/OE/F3wd+YS8jmj+iF+DVOVK
	TVxrTzibE4a++g8m06A4kYBm/Ko/mmxt/etaCKKCUNBfNpJgRJX25hRm9WJlPWLGRA1+KEJQQee
	CnMSZJC4xwq40/L7qZHdQRzMZqHsH6xPhwOm0GuICJYfXawZA/IRtjObXmP2dZDdJlOAXDYadzq
	J1CxdAeCLQTCB41YSXMLs0iOKC4QxNihIq7dQwS/jGaWr6RiM+qiWvK4hv5dy8DUI8yi2goTXLJ
	m7jfvelWC3iFjEPG1P9gCd/dZlMDwciwexH1a3Y64yS0C50Xni5Cc4hKXQRh12HtbUFksbUsj/C
	/h8d16PQV2UOt1sHlqlXxrkpy6vw==
X-Received: by 2002:a05:600c:3b96:b0:488:b098:b653 with SMTP id 5b1f17b1804b1-488d67f0a8amr350880245e9.13.1776335626808;
        Thu, 16 Apr 2026 03:33:46 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead402ee8sm12369872f8f.37.2026.04.16.03.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 03:33:46 -0700 (PDT)
Date: Thu, 16 Apr 2026 12:33:43 +0200
From: Petr Mladek <pmladek@suse.com>
To: chensong_2000@189.cn
Cc: rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, viresh.kumar@linaro.org, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, bmarzins@redhat.com,
	song@kernel.org, yukuai@fnnas.com, linan122@huawei.com,
	jason.wessel@windriver.com, danielt@kernel.org,
	dianders@chromium.org, horms@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	paulmck@kernel.org, frederic@kernel.org, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	atomlin@atomlin.com, jpoimboe@kernel.org, jikos@kernel.org,
	mbenes@suse.cz, joe.lawrence@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, live-patching@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] kernel/notifier: replace single-linked list with
 double-linked list for reverse traversal
Message-ID: <aeC7ByGA5MHBcGQR@pathway.suse.cz>
References: <20260415070137.17860-1-chensong_2000@189.cn>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415070137.17860-1-chensong_2000@189.cn>

On Wed 2026-04-15 15:01:37, chensong_2000@189.cn wrote:
> From: Song Chen <chensong_2000@189.cn>
> 
> The current notifier chain implementation uses a single-linked list
> (struct notifier_block *next), which only supports forward traversal
> in priority order. This makes it difficult to handle cleanup/teardown
> scenarios that require notifiers to be called in reverse priority order.
> 
> A concrete example is the ordering dependency between ftrace and
> livepatch during module load/unload. see the detail here [1].
> 
> This patch replaces the single-linked list in struct notifier_block
> with a struct list_head, converting the notifier chain into a
> doubly-linked list sorted in descending priority order. Based on
> this, a new function notifier_call_chain_reverse() is introduced,
> which traverses the chain in reverse (ascending priority order).
> The corresponding blocking_notifier_call_chain_reverse() is also
> added as the locking wrapper for blocking notifier chains.
> 
> The internal notifier_call_chain_robust() is updated to use
> notifier_call_chain_reverse() for rollback: on error, it records
> the failing notifier (last_nb) and the count of successfully called
> notifiers (nr), then rolls back exactly those nr-1 notifiers in
> reverse order starting from last_nb's predecessor, without needing
> to know the total length of the chain.
> 
> With this change, subsystems with symmetric setup/teardown ordering
> requirements can register a single notifier_block with one priority
> value, and rely on blocking_notifier_call_chain() for forward
> traversal and blocking_notifier_call_chain_reverse() for reverse
> traversal, without needing hard-coded call sequences or separate
> notifier registrations for each direction.
> 
> [1]:https://lore.kernel.org/all
> 	/alpine.LNX.2.00.1602172216491.22700@cbobk.fhfr.pm/
> 
> --- a/include/linux/notifier.h
> +++ b/include/linux/notifier.h
> @@ -53,41 +53,41 @@ typedef	int (*notifier_fn_t)(struct notifier_block *nb,
[...]
>  struct notifier_block {
>  	notifier_fn_t notifier_call;
> -	struct notifier_block __rcu *next;
> +	struct list_head __rcu entry;
>  	int priority;
>  };
[...]
>  #define ATOMIC_INIT_NOTIFIER_HEAD(name) do {	\
>  		spin_lock_init(&(name)->lock);	\
> -		(name)->head = NULL;		\
> +		INIT_LIST_HEAD(&(name)->head);		\

I would expect the RCU variant here, aka INIT_LIST_HEAD_RCU().

> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -14,39 +14,47 @@
>   *	are layered on top of these, with appropriate locking added.
>   */
>  
> -static int notifier_chain_register(struct notifier_block **nl,
> +static int notifier_chain_register(struct list_head *nl,
>  				   struct notifier_block *n,
>  				   bool unique_priority)
>  {
> -	while ((*nl) != NULL) {
> -		if (unlikely((*nl) == n)) {
> +	struct notifier_block *cur;
> +
> +	list_for_each_entry(cur, nl, entry) {
> +		if (unlikely(cur == n)) {
>  			WARN(1, "notifier callback %ps already registered",
>  			     n->notifier_call);
>  			return -EEXIST;
>  		}
> -		if (n->priority > (*nl)->priority)
> -			break;
> -		if (n->priority == (*nl)->priority && unique_priority)
> +
> +		if (n->priority == cur->priority && unique_priority)
>  			return -EBUSY;
> -		nl = &((*nl)->next);
> +
> +		if (n->priority > cur->priority) {
> +			list_add_tail(&n->entry, &cur->entry);
> +			goto out;
> +		}
>  	}
> -	n->next = *nl;
> -	rcu_assign_pointer(*nl, n);
> +
> +	list_add_tail(&n->entry, nl);

I would expect list_add_tail_rcu() here.

> @@ -59,25 +67,25 @@ static int notifier_chain_unregister(struct notifier_block **nl,
>   *			value of this parameter is -1.
>   *	@nr_calls:	Records the number of notifications sent. Don't care
>   *			value of this field is NULL.
> + *	@last_nb:  Records the last called notifier block for rolling back
>   *	Return:		notifier_call_chain returns the value returned by the
>   *			last notifier function called.
>   */
> -static int notifier_call_chain(struct notifier_block **nl,
> +static int notifier_call_chain(struct list_head *nl,
>  			       unsigned long val, void *v,
> -			       int nr_to_call, int *nr_calls)
> +			       int nr_to_call, int *nr_calls,
> +				   struct notifier_block **last_nb)
>  {
>  	int ret = NOTIFY_DONE;
> -	struct notifier_block *nb, *next_nb;
> -
> -	nb = rcu_dereference_raw(*nl);
> +	struct notifier_block *nb;
>  
> -	while (nb && nr_to_call) {
> -		next_nb = rcu_dereference_raw(nb->next);
> +	if (!nr_to_call)
> +		return ret;
>  
> +	list_for_each_entry(nb, nl, entry) {

I would expect the RCU variant here, aka list_for_each_rcu()

These are just two random examples which I found by a quick look.

I guess that the notifier API is very old and it does not use all
the RCU API features which allow to track safety when
CONFIG_PROVE_RCU and CONFIG_PROVE_RCU_LIST are enabled.

It actually might be worth to audit the code and make it right.

>  #ifdef CONFIG_DEBUG_NOTIFIERS
>  		if (unlikely(!func_ptr_is_kernel_text(nb->notifier_call))) {
>  			WARN(1, "Invalid notifier called!");
> -			nb = next_nb;
>  			continue;
>  		}
>  #endif

That said, I am not sure if the ftrace/livepatching handlers are
the right motivation for this. Especially when I see the
complexity of the 2nd patch [*]

After thinking more about it. I am not even sure that the ftrace and
livepatching callbacks are good candidates for generic notifiers.
They are too special. It is not only about ordering them against
each other. But it is also about ordering them against other
notifiers. The ftrace/livepatching callbacks must be the first/last
during module load/release.

[*] The 2nd patch is not archived by lore for some reason.
    I have found only a review but it gives a good picture, see
    https://lore.kernel.org/all/1191caf5-6a61-4622-a15e-854d3701f4fc@suse.com/

Best Regards,
Petr
