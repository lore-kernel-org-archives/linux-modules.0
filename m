Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E5AC433EF
	for <linux-modules@archiver.kernel.org>; Sun, 12 Jun 2022 19:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiFLTgC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 12 Jun 2022 15:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiFLTgB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 12 Jun 2022 15:36:01 -0400
Received: from relay5.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00E041FBE;
        Sun, 12 Jun 2022 12:35:58 -0700 (PDT)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id D94A2805DD;
        Sun, 12 Jun 2022 19:35:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 0298639;
        Sun, 12 Jun 2022 19:35:56 +0000 (UTC)
Message-ID: <61a0e770b1738579a076bd4642c27a7ca8e6c297.camel@perches.com>
Subject: Re: [PATCH 1/2] module: Fix ERRORs reported by checkpatch.pl
From:   Joe Perches <joe@perches.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 12 Jun 2022 12:35:55 -0700
In-Reply-To: <ad08695b528a812c83ff563d3bcaf3f7038fecb0.1655055854.git.christophe.leroy@csgroup.eu>
References: <ad08695b528a812c83ff563d3bcaf3f7038fecb0.1655055854.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Stat-Signature: o91tcnchmhbusgnt67stgjzpcc8dzi74
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 0298639
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19DNU9X5r40/SOwdVrtPMQfXB60jf11mq0=
X-HE-Tag: 1655062556-311092
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sun, 2022-06-12 at 19:44 +0200, Christophe Leroy wrote:
> Checkpatch reports following errors:

There are many conditions that checkpatch reports that do
not need fixing.

checkpatch is a mindless script.  It's not always right.

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
[]
> diff --git a/kernel/module/main.c b/kernel/module/main.c
[]
> @@ -1111,9 +1111,9 @@ resolve_symbol_wait(struct module *mod,
>  	const struct kernel_symbol *ksym;
>  	char owner[MODULE_NAME_LEN];
>  
> +	ksym = resolve_symbol(mod, info, name, owner);
>  	if (wait_event_interruptible_timeout(module_wq,

Did you verify this change by looking at the code for
wait_event_interruptible_timeout?

> -			!IS_ERR(ksym = resolve_symbol(mod, info, name, owner))
> -			|| PTR_ERR(ksym) != -EBUSY,
> +			!IS_ERR(ksym) || PTR_ERR(ksym) != -EBUSY,
>  					     30 * HZ) <= 0) {
>  		pr_warn("%s: gave up waiting for init of module %s.\n",
>  			mod->name, owner);

