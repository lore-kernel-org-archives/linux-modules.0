Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99336C433F5
	for <linux-modules@archiver.kernel.org>; Fri, 30 Sep 2022 11:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiI3Lav (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiI3L3v (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 30 Sep 2022 07:29:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CF632DA2;
        Fri, 30 Sep 2022 04:20:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9EE261F8E2;
        Fri, 30 Sep 2022 11:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664536849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sq16qV9KAC6HhtR2SG4ysqHRgl4G28JmjfBwyTS++Oc=;
        b=xxu3ODCsAN/Qh9LG/9w9HvEk9+uSHbPptVsQndei0FIbAGoONJX7zSj2B0QzNCEy5/Sv2U
        UAVogGGl8qdWEwK36P4QkR9PyAGmjnhfm7Kz9/XFZ6ckRaTgH/e3LNrHqBbYLL6Dmdp5lU
        AizZB04SST5axA2ZXXsJg+Q01sM/8lE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664536849;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sq16qV9KAC6HhtR2SG4ysqHRgl4G28JmjfBwyTS++Oc=;
        b=oLziVKiJ4TCUaUb+Rhirru0RKAyr6bCwI+NCwTrjHrHjDM4Sj5fPJo8KAbE260ETGaJXC5
        sr6Qlb7NqZsN1jAQ==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 847A12C161;
        Fri, 30 Sep 2022 11:20:49 +0000 (UTC)
Date:   Fri, 30 Sep 2022 13:20:49 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: remove redundant module_sysfs_initialized
 variable
In-Reply-To: <20220929121039.702873-1-linux@rasmusvillemoes.dk>
Message-ID: <alpine.LSU.2.21.2209301320330.11771@pobox.suse.cz>
References: <20220929121039.702873-1-linux@rasmusvillemoes.dk>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, 29 Sep 2022, Rasmus Villemoes wrote:

> The variable module_sysfs_initialized is used for checking whether
> module_kset has been initialized. Checking module_kset itself works
> just fine for that.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
