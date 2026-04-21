Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9A439EF2D
	for <linux-modules@vger.kernel.org>; Tue, 21 Apr 2026 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762328; cv=none; b=IBOPPQTYlMxvxy3ddMrTFJSb3JuclrbRA9gUlgEl4Hb9N67nAtuVjC3TMlrhd5Tjcdp1Kd4JJUka9SwRTaxe7txAL3deNtfKdoKZagG/bEgYBwBH8bc1PSKbtAaoWn/EyRoY7U4JbO/MvWvAfeSdISVS+ROXrU8nHwHAPnxpb/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762328; c=relaxed/simple;
	bh=jNS11TxrGCzC/ayr6dWUKwMQYFcjJbkoMNjsM92foRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ht0B4d+QI1/hHajtWBAA/scuasz2eMPJ8ZhyLNhMfsej9cjxqCpR9D0v5f0ZnVPTDLl91rWqVV1Jh1Vov6Cq76PG0FFYKuyhf0exKsytQ6v8kz8B8BKTnzaNQPL4amX2mxCPoJRcpwI3PwfT6cX6v2YojPfwpkq6wvnCfM8th7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xcc1CP1c; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xcc1CP1c"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-441209fb77eso177880f8f.1
        for <linux-modules@vger.kernel.org>; Tue, 21 Apr 2026 02:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776762325; x=1777367125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bq9QG9cvLvgk2UCX7BCWel9Xe8wLb+Jo7joT5Pt0764=;
        b=Xcc1CP1cnpjrdwUmB5v0J4Irq7DUhlBQD21ey2Ch8Kf6N2zXz11+vDy6TZgmIaAUJC
         +zoEz8FhqsnU8ZDeplIlW5qDu4M1jS604a2J+/T4WHykYlPpreT7WCgIS73DUOordZhU
         GSQpP79dJgdMCPtm+L0j6TbNe5PuLwUFNi+EpHD1QPWzLgzk5WJ2OJHQfvHv7r2ufHNM
         nX6nSDXwcL1hB+Q6aa5W7/7q/7STQTSZPxNsZMvv51vHikW+kMIXBLc6pQtRVKpk8XIr
         0PPbT4gMMmh5vdD5GsAgJgoWAemXJ+aXAnYSthNEwj6jZRtccCdx87/R/FK10xXMgnxj
         3nYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776762325; x=1777367125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bq9QG9cvLvgk2UCX7BCWel9Xe8wLb+Jo7joT5Pt0764=;
        b=IgrMo+qsIdgCHgCPGWfdBpZJn1pcPDbL+ddchPz4gaM7k8NJ1jjochzZLNcQeRAp0E
         OQUVZNuXpU16u7J0PSOXxt148SqkMIsEIZySBy8uFHB5IzslO8rHiaeuSTuxTfKhSY5V
         4kwNV0RugOkzG8mByFruRpmH7ticxSoWi+y/mMEQsv3i9VV1Hj028iLe5jgZceQItxhl
         UZIIHIuuW7+xRe5/dMPZJW2PJrHLJXGwM5E7YG+a60aAZEaD88D/aHE66RwjdXQRLvZ5
         yW088wRJLCeRuH1xfwbr0HYhc522ROXyRFJbKD+3yaq1ULoKqmbBnxJLw3vFR/S7MP23
         c3Fw==
X-Forwarded-Encrypted: i=1; AFNElJ+hQ2jCXQ3GAntbd70qIg2rhIeH9rbUlXum7pPkKSRLpxperjgZsOZIRVeugeqt3rirbX8r3G6P7vOb1qbb@vger.kernel.org
X-Gm-Message-State: AOJu0YzHo0ldekfvP87qrzBykW95xHdoUfNUWXEMHmQo2U/Y4kUqcrA5
	1ptkEb0+UQsgFqiHaSABhnBJllLM2NA3XGgg8gyj1W7i/zXWqam8bU7KyyTj7KF5/OY=
X-Gm-Gg: AeBDietCoPVzVC848Gpa/H4w86iPE6u6c1FcA6GAWWJpudE9zrFHviEM6nRUKGwW/rA
	wE3TYsqOEWHUfdWp7xLY6CeXCYGKXdeyd1+m7LWBn9Q/k1MfVdkEHmg6jJlT+Ha9he5oqcjdU38
	Y3X+QufyVKzLklBy0mUMhYRyOFS6/Mr6C84BOH5X/Qx0PXXxsRNireKAIFsID0vBri//cwvEVGC
	DbPhaJPLPg21NwsH8iTQfSU17LbLPSsjP99BH6nUQePPnM8MSBMGiOYCYJ+UcUTkgWEEyP5BsB4
	eF1PzeapZv9ZbolsfcyFZ0qXyoXVQr6pbaTu8zFNl9UeBeigJvQc7q4UWp+r4RgxyGM5M4nc5vE
	EFz+IrLtkl1tmbSeWzwuOqpnQ8AigPDGb96xu74K1ugC+4Rdjkb8oc8jbdfBY+MyZE3M14pA+m3
	HTVT3DBLAh1J6GPk3bgeRVFMM8jUTlTvCTe0s994PXnSk8PGG3NXc=
X-Received: by 2002:a5d:5c81:0:b0:43d:729e:f23a with SMTP id ffacd0b85a97d-43fe408dab9mr19081632f8f.22.1776762324596;
        Tue, 21 Apr 2026 02:05:24 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb135asm39945351f8f.6.2026.04.21.02.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 02:05:24 -0700 (PDT)
Date: Tue, 21 Apr 2026 11:05:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: chensong_2000@189.cn, rafael@kernel.org, lenb@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, viresh.kumar@linaro.org,
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	bmarzins@redhat.com, song@kernel.org, yukuai@fnnas.com,
	linan122@huawei.com, jason.wessel@windriver.com, danielt@kernel.org,
	dianders@chromium.org, horms@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	paulmck@kernel.org, frederic@kernel.org, mcgrof@kernel.org,
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
	atomlin@atomlin.com, jpoimboe@kernel.org, jikos@kernel.org,
	mbenes@suse.cz, joe.lawrence@redhat.com, rostedt@goodmis.org,
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
	live-patching@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] kernel/notifier: replace single-linked list with
 double-linked list for reverse traversal
Message-ID: <aec90caYZDHDAHgw@pathway.suse.cz>
References: <20260415070137.17860-1-chensong_2000@189.cn>
 <20260420144429.57b45f2beece690bceea96ec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420144429.57b45f2beece690bceea96ec@kernel.org>

On Mon 2026-04-20 14:44:29, Masami Hiramatsu wrote:
> Hi Song,
> 
> On Wed, 15 Apr 2026 15:01:37 +0800
> chensong_2000@189.cn wrote:
> 
> > From: Song Chen <chensong_2000@189.cn>
> > 
> > The current notifier chain implementation uses a single-linked list
> > (struct notifier_block *next), which only supports forward traversal
> > in priority order. This makes it difficult to handle cleanup/teardown
> > scenarios that require notifiers to be called in reverse priority order.
> 
> What about introducing a new notification callback API that allows you
> to describe dependencies between callback functions?
> 
> For example, when registering a callback, you could register a string
> as an ID and specify whether to call it before or after that ID,
> or you could register a comparison function that is called when adding
> to a list. (I prefer @name and @depends fields so that it can be easily
> maintained.)

This looks too complex. It would make sense only
when this API has more users.

Also this won't be enough for the ftrace/livepatch callbacks.
They need to be ordered against against each other. But they
also need to be called before/after all other callbacks.
For example, when the module is loaded:

   + 1st frace
   + 2nd livepatch
   + then other notifiers

See the commit c1bf08ac26e92122 ("ftrace: Be first to run code
modification on modules").

> This would allow for better dependency building when adding to the list.
 
> > 
> > A concrete example is the ordering dependency between ftrace and
> > livepatch during module load/unload. see the detail here [1].
> 
> If this only concerns notification callback issues with the ftrace
> and livepatch modules, it's far more robust to simply call the
> necessary processing directly when the modules load and unload,
> rather than registering notification callbacks externally.
> 
> There are fprobe, kprobe and its trace-events, all of them are using
> ftrace as its fundation layer. In this case, I always needs to
> consider callback order when a module is unloaded.
> 
> If ftrace is working as a part of module callbacks, it will conflict
> with fprobe/kprobe module callback. Of course we can reorder it with
> modifying its priority. But this is ugly, because when we introduce
> a new other feature which depends on another layer, we need to
> reorder the callback's priority number on the list.
> 
> Based on the above, I don't think this can be resolved simply by
> changing the list of notification callbacks to a bidirectional list.

I agree. I would keep it as is (hardcoded).

Best Regards,
Petr
