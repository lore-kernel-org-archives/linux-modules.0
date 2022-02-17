Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE874C433EF
	for <linux-modules@archiver.kernel.org>; Thu, 17 Feb 2022 08:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiBQILx (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 17 Feb 2022 03:11:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiBQILw (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 17 Feb 2022 03:11:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA7213F00
        for <linux-modules@vger.kernel.org>; Thu, 17 Feb 2022 00:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CJ9wA5xZQ6IvOuKPSHCb1ZSzuqaxhhVACBmGtrCWtd4=; b=GZNG87X0SyHft2CPw+VL2zw/KM
        IVkeI6DorTBIjh3gx7qQRZnTUgMdAs4PHPhCWhr3s2ujqIlG28ImYQ67Abtyku4rJDMxpGOEANobJ
        VzBLMjH2Ra8gKn+jSfyMxaycbPF39jk7gHNpDZ8BjnkXXgAfcTV4Kh6fQ4Isjk8KgBJeaT/tGwSzQ
        o9z5Jq3ELn+LYOcn+sEYK+ss5i4KjdIoFffRKJoDIr1zb5J95Df5r6NvDUAdost5yKlrrccVgGqlD
        hKlJyst0vyhPN335DL90gVWVmXvTmCcp+vbauSXmu59MH3rjrv7FxVWp2fJ1zr4OJYc3lOa4cGg5b
        jSSa4PQw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKbt3-009NUf-PE; Thu, 17 Feb 2022 08:11:37 +0000
Date:   Thu, 17 Feb 2022 00:11:37 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 0/8] Random fixes + modinfo --modname
Message-ID: <Yg4DOfCUvIpDDBRd@bombadil.infradead.org>
References: <20220216075533.185693-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216075533.185693-1-lucas.demarchi@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Feb 15, 2022 at 11:55:25PM -0800, Lucas De Marchi wrote:
> First commits are some random fixes and refactors while preparing the
> code base for a new API: kmod_module_new_from_name_lookup(). This new
> function is used by modinfo to allow handling the argument as a module
> name instead of alias or file. Main motivation is to allow to bypass
> aliases set by kernel or user configuration that would otherwise forbid
> to get the info from a particular module. Although for modules it's
> possible to just find the correspondent file, this is not possible
> for builtin modules.

For 1-7:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
