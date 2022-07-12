Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32943C43334
	for <linux-modules@archiver.kernel.org>; Tue, 12 Jul 2022 19:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiGLTd1 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 12 Jul 2022 15:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiGLTdL (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 12 Jul 2022 15:33:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1DF8245B;
        Tue, 12 Jul 2022 12:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mz3uiLBDPsOt1VzIpjwZMOerOHNzoGUVpwp83xBphr8=; b=z1dg9AinunEfgUZNUkIFL/epIL
        4xaEXeEdg7IWggJ8gQposn9zp1vzaBN8rzAc/hjcHy8CEkT7Q/C9l9G891JER8qzTyeFfFMOrUBQr
        GoGHU5nat5gxjZJfQREzq3aBMGZJQqFo2o5TmWZhxZEoabRKoJj2VaXIIAm5f73RhgXn5iOyZrAxw
        5YWbXalgWKbeLr/OyOnUTnXVnhblHLe3AaoC6B8wjJNLQ18ez9a7OJuAVA0AdqkN6nTh5o9suqHKM
        R7TDIGn3FxmjD3/bPvp7gKpYErqaBEPqj2hE0l8OcTpwkv1pNXdBrsMUBC0joXABW0WWJniyVr+vi
        B+fcCmbQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBLFi-00E56D-OI; Tue, 12 Jul 2022 19:08:58 +0000
Date:   Tue, 12 Jul 2022 12:08:58 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: Move module's Kconfig items in kernel/module/
Message-ID: <Ys3GyoTcW1b0gQuF@bombadil.infradead.org>
References: <fdc6016e2414a26f17a17024d287087627052ea6.1657605146.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdc6016e2414a26f17a17024d287087627052ea6.1657605146.git.christophe.leroy@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jul 12, 2022 at 07:52:33AM +0200, Christophe Leroy wrote:
> In init/Kconfig, the part dedicated to modules is quite large.
> 
> Move it into a dedicated Kconfig in kernel/module/
> 
> MODULES_TREE_LOOKUP was outside of the 'if MODULES', but as it is
> only used when MODULES are set, move it in with everything else to
> avoid confusion.
> 
> MODULE_SIG_FORMAT is left in init/Kconfig because this configuration
> item is not used in kernel/modules/ but in kernel/ and can be
> selected independently from CONFIG_MODULES. It is for instance
> selected from security/integrity/ima/Kconfig.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks, rapplied and pushed! This should be in linux-next soon.

  Luis
