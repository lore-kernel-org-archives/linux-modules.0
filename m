Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB44EB64DD
	for <linux-modules@archiver.kernel.org>; Mon,  3 Jul 2023 10:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjGCKpj (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 3 Jul 2023 06:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjGCKpi (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 3 Jul 2023 06:45:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83893C1;
        Mon,  3 Jul 2023 03:45:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D96A1FD74;
        Mon,  3 Jul 2023 10:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688381135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=caF63ymnbWmBVrCY3MqQ90BV6mN7gkQAVN98pVotegQ=;
        b=uDAp/WRFWp1Id23i5jD0oFSMtqv/8ajkG5z5ytxiqke1V33N0kBA1HEtg5gXCHiGDOQm1C
        IRBOlvYazIHCDAy+5oKcXmu2pZSeqNLZ5AFuSivXAQiVGqO4GwyhIfvXELO5CpyNeGG1lO
        pxH8mJYQxwGipMI2oNTIxQPfUUTAWMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688381135;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=caF63ymnbWmBVrCY3MqQ90BV6mN7gkQAVN98pVotegQ=;
        b=0B6S5TivaSxyV+31peKJ5USlMrF1kX3/PNpYUF9qF79iG7tsgm9nNXWSGaPD1sAHW62lIM
        BsqDgmKgYkcix4Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3AFF138FC;
        Mon,  3 Jul 2023 10:45:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 07++Oc6momSHPQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 03 Jul 2023 10:45:34 +0000
Date:   Mon, 3 Jul 2023 12:45:33 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: print module name on refcount error
Message-ID: <20230703124533.5fc7396d@endymion.delvare>
In-Reply-To: <20230701175727.292b84f6@endymion.delvare>
References: <20230626123252.73dbc139@endymion.delvare>
        <ZJ9fvQZ4k+zFfXbN@bombadil.infradead.org>
        <20230701175727.292b84f6@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sat, 1 Jul 2023 17:57:27 +0200, Jean Delvare wrote:
> On Fri, 30 Jun 2023 16:05:33 -0700, Luis Chamberlain wrote:
> > On Mon, Jun 26, 2023 at 12:32:52PM +0200, Jean Delvare wrote:  
> > > If module_put() triggers a refcount error, include the culprit
> > > module name in the warning message, to easy further investigation of
> > > the issue.
> > > 
> > > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > > Suggested-by: Michal Hocko <mhocko@suse.com>
> > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > ---
> > >  kernel/module/main.c |    4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > --- linux-6.3.orig/kernel/module/main.c
> > > +++ linux-6.3/kernel/module/main.c
> > > @@ -850,7 +850,9 @@ void module_put(struct module *module)
> > >  	if (module) {
> > >  		preempt_disable();
> > >  		ret = atomic_dec_if_positive(&module->refcnt);
> > > -		WARN_ON(ret < 0);	/* Failed to put refcount */
> > > +		WARN(ret < 0,
> > > +		     KERN_WARNING "Failed to put refcount for module %s\n",
> > > +		     module->name);
> > >  		trace_module_put(module, _RET_IP_);
> > >  		preempt_enable();
> > >  	}
> > 
> > The mod struct ends up actually being allocated, we first read the ELF
> > passed by userspace and we end up allocating space for struct module
> > when reading the ELF section ".gnu.linkonce.this_module". We cache
> > the ELF section index in info->index.mod, we finally copy the module
> > into the allocated space with move_module().
> > 
> > In linux-next code this is much more clear now. 
> > 
> > What prevents us from racing to free the module and thus invalidating
> > the name?
> > 
> > For instance the system call to delete_module() could hammer and
> > so have tons of threads racing try_stop_module(), eventually one of
> > them could win and free_module() would kick in gear.
> > 
> > What prevents code from racing the free with a random module_put()
> > called by some other piece of code?
> > 
> > I realize this may implicate even the existing code seems racy.  
> 
> You are the maintainer so I'll trust your expertise, but this is how I
> understand it: if we hit this WARN, this means reference counting is
> screwed. If this is an underflow, we still have a reference to the
> module while refcnt is zero, meaning the module could be removed at any
> time. This is inherent to the issue we are reporting, and not related
> to the proposed change. The name is just one field of struct module,
> refcnt is in the very same situation already.
> 
> So the whole piece of code is best effort reporting and assumes (both
> before and after my proposed change) that nobody attempted to unload
> the module yet.

I thought some more about it and one potential problem with my proposed
change is if the module has indeed already been freed and the memory
already reused for a different purpose. We are in trouble already (we
just called atomic_dec_if_positive on a random memory location) but the
WARN message could become very messy if the memory where module.name
used to reside no longer contains any string terminator (binary zero).

So we probably want to play it safe and add a length limitation when
printing the module name. Something like:

		WARN(ret < 0,
		     KERN_WARNING "Failed to put refcount for module %.*s\n",
		     (int)MODULE_NAME_LEN, module->name);

-- 
Jean Delvare
SUSE L3 Support
