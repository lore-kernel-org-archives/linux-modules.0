Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA03C433F5
	for <linux-modules@archiver.kernel.org>; Wed,  6 Apr 2022 22:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiDFWWt (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 6 Apr 2022 18:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiDFWWp (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 6 Apr 2022 18:22:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39A7BD7D2
        for <linux-modules@vger.kernel.org>; Wed,  6 Apr 2022 15:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nh7vVd/DU0wHhE0fXZz6lh2EHmT8+WDYi62JBAlBgn0=; b=O6B4WoADMwe9oFpkY5bBSaZ9uA
        5nloMWpWG0qW/kW709x4es4110iTcWgYNbNWorMyRg2fVrYnHE9yqlBK4ITK7ZoDu5H/8da8ANSbk
        iY7NWGmA9f+4eO+R8ITB9Jbx4+BPirZcVt5h0b5HKN9eAvbQcZKIi+Np56qzkwcfX2C6xOqvGAJl8
        mV0E05ozdm6xcYY72tjegJbIE1EZh8Bao1OfXg3XOc31kjG2V64THXC+iYc5MZVNNYQaDCixf7vhR
        RWaxylzgxgAgmx+6MpyZ2H45uga0oZlfi0XepE+2wK9bXLlVhPtFrmDkPGntDyshjXZudYWE5hcED
        Xi3ids7g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncE19-0087Zs-0y; Wed, 06 Apr 2022 22:20:47 +0000
Date:   Wed, 6 Apr 2022 15:20:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/4] modprobe: Fix holders removal
Message-ID: <Yk4SPqOwmcUbVYG0@bombadil.infradead.org>
References: <20220329090540.38255-1-lucas.demarchi@intel.com>
 <20220329090540.38255-4-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329090540.38255-4-lucas.demarchi@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Mar 29, 2022 at 02:05:37AM -0700, Lucas De Marchi wrote:
> The idea behind --remove-dependencies was to remove other modules that
> depend on the current module being removed. It's the reverse
> dependency list, not the dependency list of the current module: that
> never works since the current module would still hold a ref on it.
> 
> Fix it by replacing the call to kmod_module_get_dependencies() with
> kmod_module_get_holders() when using that option. Also try to cleanup
> the confusion by renaming the option to --remove-holders: "holder" is
> the name used in sysfs and by libkmod to refer to a "live" reverse
> dependency like what we are interested in.
> 
> Before:
> 	./tools/modprobe -D -r --remove-dependencies video
> 	rmmod video
> 
> After:
> 	./tools/modprobe -D -r --remove-holders video
> 	rmmod i915
> 	rmmod thinkpad_acpi
> 	rmmod video
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

