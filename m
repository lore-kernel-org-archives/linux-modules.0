Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921CA3E1201
	for <linux-modules@vger.kernel.org>; Thu, 16 Apr 2026 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350980; cv=none; b=Fb7BZfpFzJWEWB9n4h/9hjLCz84ygWJCKTOfzmXp63Kz2VfJbaQlILGRV4/pFfXxC+1XXO+085qjaU863pge7DkO0YZ64Q2Rbp5PKl8rKKqYCCyyTUbvwq0w9zGh56tBL5PAMeuqCW34SGu8HXg2En2Tlgy2KCdkd5XXxnUuc+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350980; c=relaxed/simple;
	bh=qWFuADgouw7Y28f8Ks2Rqs0pWL1FBVPTXx/dspPKr4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpeP8qWV6QU0CDV/A6nGoIYFMAuMhqP1V1iYphjY39vjNvSmIS9PscuWFHY8WcheyLFDHriqbBydAgWdcrlKtUZdrA5o0Tei8+zZFMx0AxJFlYfJNXjRRThE9ZgeA0udLjMaquG8Vk4PNGGftfr88RDg02QzZRsh00FVXTgZkCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lo0S5bUs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lo0S5bUs"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488c21c636dso49800145e9.2
        for <linux-modules@vger.kernel.org>; Thu, 16 Apr 2026 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776350976; x=1776955776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXwMjFpu/xE0paqzhDs94eqBbHdGY9DRyzE65FFhgNk=;
        b=Lo0S5bUsorsa2EhvKSEGUWW7+50RKG/1eB+lWtByeYAXgBOBBMOXr6Bfc85/ah8XG5
         hpjjV9Amogif+o5ANdx/MhPZBlvaXZQLm/sjsWiuax7JXjKs75B6kjIQy7yVOdAliXHE
         SG2gE5C2VUr3due1blQsoQ6RhJ/sm3RfpSEW0kJiAVQwpYaJyDKpB0W7G0LrmIH32Y9q
         Cm2jDTxYgMMHxXqL1xvch7hp5HlqL4LT0w1sOuDAOlQL0ygybgABc1A2oEMBR7T55eou
         +KlNH6iN+L28qcJSd+J0AuHrmCCs30UFG7C1bWDBkPKiEBcKOzz1gn35RIw/FN+gvNsv
         5cGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776350976; x=1776955776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXwMjFpu/xE0paqzhDs94eqBbHdGY9DRyzE65FFhgNk=;
        b=EX7abElJEXsUt/YGbcaP9BUt5JOGOFGLbC+m57W2ntOb6aeF1X4Ma3u8Xtp7nPaKc1
         jSTeJO25JxnrX+ob+ASR9ZkXaRqbCjGEB6lvEzkpXbmGFzxhMUhMN5d1Qf6JK2mrUXNf
         vmKTVPD5r6uM+aqt+4PaUZ48UEeIaa8kNyle/S46H6w/UgVgFGaI+AEaTD/5+ECET+XC
         pa+r1T/M+YKz5NVrpkW7sWPKfqN9JWLlI/QywP4gPJzkYvQjGzl5JXOjMi1tjxr5DpXm
         BSYdVV8l/CodxFnVPUZjhysnoyUh0sXZGpPkVMbf4rhKUTfLBmov8ZvyJ7Kpgw+/WoIl
         f7CQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LEQbF0eEJWfKZYKK/yzEz3dO5m9VzuxJU0EZf8NYEiQMqpL5xu6Ue3JerBSiLLNzt+ogHatB9PTofxUw2@vger.kernel.org
X-Gm-Message-State: AOJu0Yygb5h4+qG9BdbGLb94smimtNqGwbz7qZqUJ8NFZU8cNlLXWLFJ
	XTBqt2K6Tlw3tE3rQxm3csaC0FNUL0PHR6oi69GcRK+6ORd2LPisSkycG19yER/6hU4=
X-Gm-Gg: AeBDietwgvqvYSSn+JlKfVYGfsbWVaAn9lRBT+c+6fVcXFktr2a9i9sFJ9YxAjsefE4
	tFU5i8vYrHEHVHLOx9ZPDJTZEu6kP4JK02JJVa4s3prbZclVgeEeSz7Pt+3YocWhn33ZXwzzPCs
	YTWeDeRWmyK0AX7vxDIugaaPyV0KfkmzXFugeVpLXQQzo73gVonmvKLAfFbKLKuswmLXK4JPgRR
	WoflZkIHMz9cDhQ9BeL8AzrlMP3rpJUwfrpyIOGkfH0w10B75D3iJOonk5AohnVqeB1vTXt5pth
	7f0MTq/pvwoQU2+UFUhWc3N/qIljPlvqpXKGEXQgC+BpsE32v16DrbVSupcWtCT607MjNQHKwqW
	ZZNPU+9XtWu/e2qEIvo3sKSIhV70ea8S/79SvduuOkhd2/ypEYpsA4+IbUG4XDpoNbSZ+3iUDr4
	CGeZafS28iAuojoQRDQuTYu+JMxRPRVfnifRkM
X-Received: by 2002:a05:600c:8904:b0:487:1c2:6a56 with SMTP id 5b1f17b1804b1-488d67ec89amr276975035e9.3.1776350975981;
        Thu, 16 Apr 2026 07:49:35 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818e51sm95699055e9.5.2026.04.16.07.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 07:49:35 -0700 (PDT)
Date: Thu, 16 Apr 2026 16:49:32 +0200
From: Petr Mladek <pmladek@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Song Chen <chensong_2000@189.cn>, rafael@kernel.org, lenb@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, viresh.kumar@linaro.org,
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	bmarzins@redhat.com, song@kernel.org, yukuai@fnnas.com,
	linan122@huawei.com, jason.wessel@windriver.com, danielt@kernel.org,
	dianders@chromium.org, horms@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	paulmck@kernel.org, frederic@kernel.org, mcgrof@kernel.org,
	da.gomez@kernel.org, samitolvanen@google.com, atomlin@atomlin.com,
	jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
	live-patching@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] kernel/module: Decouple klp and ftrace from
 load_module
Message-ID: <aeD2_FrFL6E3dbAC@pathway.suse.cz>
References: <20260413080701.180976-1-chensong_2000@189.cn>
 <1191caf5-6a61-4622-a15e-854d3701f4fc@suse.com>
 <a35f5f94-7d5a-4347-974b-b270c89ef241@189.cn>
 <1db425bf-58a9-4768-8c38-3ae25d7662a5@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1db425bf-58a9-4768-8c38-3ae25d7662a5@suse.com>

On Thu 2026-04-16 13:18:30, Petr Pavlu wrote:
> On 4/15/26 8:43 AM, Song Chen wrote:
> > On 4/14/26 22:33, Petr Pavlu wrote:
> >> On 4/13/26 10:07 AM, chensong_2000@189.cn wrote:
> >>> diff --git a/include/linux/module.h b/include/linux/module.h
> >>> index 14f391b186c6..0bdd56f9defd 100644
> >>> --- a/include/linux/module.h
> >>> +++ b/include/linux/module.h
> >>> @@ -308,6 +308,14 @@ enum module_state {
> >>>       MODULE_STATE_COMING,    /* Full formed, running module_init. */
> >>>       MODULE_STATE_GOING,    /* Going away. */
> >>>       MODULE_STATE_UNFORMED,    /* Still setting it up. */
> >>> +    MODULE_STATE_FORMED,
> >>
> >> I don't see a reason to add a new module state. Why is it necessary and
> >> how does it fit with the existing states?
> >>
> > because once notifier fails in state MODULE_STATE_UNFORMED (now only ftrace has someting to do in this state), notifier chain will roll back by calling blocking_notifier_call_chain_robust, i'm afraid MODULE_STATE_GOING is going to jeopardise the notifers which don't handle it appropriately, like:
> > 
> > case MODULE_STATE_COMING:
> >      kmalloc();
> > case MODULE_STATE_GOING:
> >      kfree();
> 
> My understanding is that the current module "state machine" operates as
> follows. Transitions marked with an asterisk (*) are announced via the
> module notifier.
> 
> ---> UNFORMED --*> COMING --*> LIVE --*> GOING -.
>         ^            |                     ^    |
>         |            '---------------------*    |
>         '---------------------------------------'
> 
> The new code aims to replace the current ftrace_module_init() call in
> load_module(). To achieve this, it adds a notification for the UNFORMED
> state (only when loading a module) and introduces a new FORMED state for
> rollback. FORMED is purely a fake state because it never appears in
> module::state. The new structure is as follows:
> 
>         ,--*> (FORMED)
>         |
> --*> UNFORMED --*> COMING --*> LIVE --*> GOING -.
>         ^            |                     ^    |
>         |            '---------------------*    |
>         '---------------------------------------'
> 
> I'm afraid this is quite complex and inconsistent. Unless it can be kept
> simple, we would be just replacing one special handling with a different
> complexity, which is not worth it.

> >>
> >>> +    if (err)
> >>> +        goto ddebug_cleanup;
> >>>         /* Finally it's fully formed, ready to start executing. */
> >>>       err = complete_formation(mod, info);
> >>> -    if (err)
> >>> +    if (err) {
> >>> +        blocking_notifier_call_chain_reverse(&module_notify_list,
> >>> +                MODULE_STATE_FORMED, mod);
> >>>           goto ddebug_cleanup;
> >>> +    }
> >>>   -    err = prepare_coming_module(mod);
> >>> +    err = prepare_module_state_transaction(mod,
> >>> +                MODULE_STATE_COMING, MODULE_STATE_GOING);
> >>>       if (err)
> >>>           goto bug_cleanup;
> >>>   @@ -3522,7 +3519,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
> >>>       destroy_params(mod->kp, mod->num_kp);
> >>>       blocking_notifier_call_chain(&module_notify_list,
> >>>                        MODULE_STATE_GOING, mod);
> >>
> >> My understanding is that all notifier chains for MODULE_STATE_GOING
> >> should be reversed.
> > yes, all, from lowest priority notifier to highest.
> > I will resend patch 1 which was failed due to my proxy setting.
> 
> What I meant here is that the call:
> 
> blocking_notifier_call_chain(&module_notify_list, MODULE_STATE_GOING, mod);
> 
> should be replaced with:
> 
> blocking_notifier_call_chain_reverse(&module_notify_list, MODULE_STATE_GOING, mod);
> 
> > 
> >>
> >>> -    klp_module_going(mod);
> >>>    bug_cleanup:
> >>>       mod->state = MODULE_STATE_GOING;
> >>>       /* module_bug_cleanup needs module_mutex protection */
> >>
> >> The patch removes the klp_module_going() cleanup call in load_module().
> >> Similarly, the ftrace_release_mod() call under the ddebug_cleanup label
> >> should be removed and appropriately replaced with a cleanup via
> >> a notifier.
> >>
> >     err = prepare_module_state_transaction(mod,
> >                 MODULE_STATE_UNFORMED, MODULE_STATE_FORMED);
> >     if (err)
> >         goto ddebug_cleanup;
> > 
> > ftrace will be cleanup in blocking_notifier_call_chain_robust rolling back.
> > 
> >     err = prepare_module_state_transaction(mod,
> >                 MODULE_STATE_COMING, MODULE_STATE_GOING);
> > 
> > each notifier including ftrace and klp will be cleanup in blocking_notifier_call_chain_robust rolling back.
> > 
> > if all notifiers are successful in MODULE_STATE_COMING, they all will be clean up in
> >  coming_cleanup:
> >     mod->state = MODULE_STATE_GOING;
> >     destroy_params(mod->kp, mod->num_kp);
> >     blocking_notifier_call_chain(&module_notify_list,
> >                      MODULE_STATE_GOING, mod);
> > 
> > if  something wrong underneath.
> 
> My point is that the patch leaves a call to ftrace_release_mod() in
> load_module(), which I expected to be handled via a notifier.

I think that I have got it. The ftrace code needs two notifiers when
the module is being loaded and two when it is going.

This is why Sond added the new state. But I think that we would
need two new states to call:

    + ftrace_module_init() in MODULE_STATE_UNFORMED
    + ftrace_module_enable() in MODULE_STATE_FORMED

and

    + ftrace_free_mem() in MODULE_STATE_PRE_GOING
    + ftrace_free_mem() in MODULE_STATE_GOING


By using the ascii art:

 -*> UNFORMED -*> FORMED -> COMING -*> LIVE -*> PRE_GOING -*> GOING -.
              |          |         |                ^           ^    ^
              |          |         '----------------'           |    |
              |          '--------------------------------------'    |
              '------------------------------------------------------'


But I think that this is not worth it.

Best Regards,
Petr
