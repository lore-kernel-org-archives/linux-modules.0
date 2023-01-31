Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D2AC38142
	for <linux-modules@archiver.kernel.org>; Tue, 31 Jan 2023 12:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjAaMEo (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 31 Jan 2023 07:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjAaMEk (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 31 Jan 2023 07:04:40 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473B44DE0A;
        Tue, 31 Jan 2023 04:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=nwfnr4oaGL0A6pm/AiOnFComuIifMB1GYDZBfuM6Jrw=; b=cR69uUZtgGx21FvYG6V0lBkbFf
        Qnu3XhyvsA8RTgM8hIai27D7M2w1vPffyXAxucd+apVyqlxxSf7BdX77G04dpvOumiHHI819d+OZb
        rf7JjGqYvMuaaQbKBqmrboWEdyBXu4wxEur+N5H8iuDwCJvss8rJbWDxOeuHElR9SC3npJZvIhJlu
        OMjN2d+5aCyvfkYSYQkTddUr4nfwZWTZMb//Q1QJdNL/iqKdttOUoJ0DQj/oBdgBDO7bYKrNAXEXA
        Jt6+bhU9jvCsiVfWvs7ukkUWAggORSAqo0PxnmDZG1VytaI3JZVbGH/Wz7WnS22wdOq9sScuHHIjQ
        xbrIIdQg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pMpMf-004LOc-1j;
        Tue, 31 Jan 2023 12:03:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B190300446;
        Tue, 31 Jan 2023 13:04:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3BC820835864; Tue, 31 Jan 2023 13:04:25 +0100 (CET)
Date:   Tue, 31 Jan 2023 13:04:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4] module: replace module_layout with module_memory
Message-ID: <Y9kDyUaOe57IL/yF@hirez.programming.kicks-ass.net>
References: <20230130182109.3571524-1-song@kernel.org>
 <Y9jau76YwdCElzZ0@hirez.programming.kicks-ass.net>
 <1302e2b6-8980-e6e5-7433-6754634c98f3@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1302e2b6-8980-e6e5-7433-6754634c98f3@csgroup.eu>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jan 31, 2023 at 10:58:56AM +0000, Christophe Leroy wrote:
> 
> 
> Le 31/01/2023 à 10:09, Peter Zijlstra a écrit :
> 
> >> @@ -573,23 +574,33 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
> >>   bool is_module_percpu_address(unsigned long addr);
> >>   bool is_module_text_address(unsigned long addr);
> >>   
> >> +static inline bool within_module_mem_type(unsigned long addr,
> >> +					  const struct module *mod,
> >> +					  enum mod_mem_type type)
> >> +{
> >> +	unsigned long base, size;
> >> +
> >> +	base = (unsigned long)mod->mem[type].base;
> >> +	size = mod->mem[type].size;
> >> +
> >> +	return base <= addr && addr < base + size;
> > 
> > Possible (as inspired by all the above is_{init,core}() etc..
> > 
> > 	return addr - base < size;
> > 
> 
> In kernel/module/main.c we have a function called within(). Maybe that 
> function could be lifted in module.h and used.

More sharing more good. But I don't think we can lift a 'within'
function to the global namespace, that's just asking for pain.

> > static inline bool within_module_mem_types(unsigned long addr,
> > 					   const struct module *mod,
> > 					   enum mod_mem_type first,
> > 					   enum mod_mem_type last)
> > {
> > 	for (enum mod_mem_type type = first; type <= last; type++) {
> > 		if (within_module_mem_type(addr, mod, type))
> > 			return true;
> > 	}
> > 	return false;
> > }
> 
> Well, ok but what garanties it will always be contiguous types ?
> And you can't anymore see at first look what types it is.
> 
> I prefer it to be explicit with within_module_mem_type(TYPE1) || 
> within_module_mem_type(TYPE2) || within_module_mem_type(TYPE3). By the 
> way we could make the function name shorter, even within() may be a 
> better name as it is used only inside module code.
> 
> Something like
> 
> 	return within(addr, mod, MOD_TEXT) || within(addr, mod, MOD_DATA) ||
> 	       within(addr, mod, MOD_RODATA) || within(addr, mod, 
> MOD_RO_AFTER_INIT);

Urgh, how about?

	for_each_mod_mem_type(type) {
		if (!mod_mem_type_is_init(type) && within(addr, mod, type))
			return true;
	}
	return false;

Then you have have a bunch of mod_mem_type_id_foo() filter functions
that are non-contiguous without having to endlessly repeat stuff
manually.
