Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DC6C433F5
	for <linux-modules@archiver.kernel.org>; Wed, 23 Feb 2022 00:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiBWA1u (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 22 Feb 2022 19:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbiBWA1s (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 22 Feb 2022 19:27:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5C053E30;
        Tue, 22 Feb 2022 16:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HgX98OwrP9QUu0q0EJFJcZeLVOY5T3k3JWd4rYr6BMo=; b=HSGt8JyaiSyOrUJRY5Ho2bSdmd
        tt5G6vXTlofiiErK/Ujm0KeRMlREfmjY4AiXNOgNvCmhIMLwEVzbUEwXXl54e1gnFm08z0HUTuAO4
        AglCy/ANITMXpUXBT9AMevUYLxlD8agzYyG2gMSuOcAEPTIPGAD23T3IEYazkF8f1jBS2a+ohIdUG
        rdLQfFUi4SRo9C0Z8f66m1IJBHxTuhYtwJCmMCSzbPuMCUA2/pUOIWyegMBK/WVQolThVPOOx6H+c
        rdvUzrIYkpfGXbsThE72Co4DGrgg4y+iSptCmrD4syM5M4I488z13tCScXYFqivizmKjEyq1bI/zy
        LFVLNwMw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMfUz-00C0ys-V7; Wed, 23 Feb 2022 00:27:17 +0000
Date:   Tue, 22 Feb 2022 16:27:17 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Aaron Tomlin <atomlin@redhat.com>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Miscellaneous cleanups
Message-ID: <YhV/ZQKsO2rElYdL@bombadil.infradead.org>
References: <cover.1645542893.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645542893.git.christophe.leroy@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Feb 22, 2022 at 04:16:30PM +0100, Christophe Leroy wrote:
> This series applies on top of my series "Allocate module text and data separately" v5.
> 
> It does some cleanup around the settling of modules's layout page flags:
> - Make module_enable_x() independent of CONFIG_ARCH_HAS_STRICT_MODULE_RWX
> - Reunify everything into strict_rwx.c
> - Change big hammer BUG_ON()s into WARN_ON()s
> - Change misleading debug_align() to strict_align()
> 
> Changes in v2/v3:
> - Rebased on top of my series "Allocate module text and data separately" v5
> - Moved the Kconfig patch out of this series, it is an independent change
> 
> Sorry for the mess in v2.

Thanks for all this work! Any chance you can actually submit this prior
to your allocate module series? This and the patch, "module: Move
module's Kconfig item in kernel/module/". Because *iff* we get enough
testing out of Aaron's changes and your cleanups, perhaps those might
be candidates for the next merge window. Then we can save all the new
functional changes for the other merge window.

  Luis
