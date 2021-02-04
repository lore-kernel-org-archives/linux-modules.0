Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4F9C4332B
	for <linux-modules@archiver.kernel.org>; Thu,  4 Feb 2021 10:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A266164F53
	for <linux-modules@archiver.kernel.org>; Thu,  4 Feb 2021 10:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbhBDKZi (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 4 Feb 2021 05:25:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:58750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235452AbhBDKZb (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 4 Feb 2021 05:25:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5629B009;
        Thu,  4 Feb 2021 10:24:49 +0000 (UTC)
Date:   Thu, 4 Feb 2021 11:24:48 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org,
        Michal =?iso-8859-2?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH 1/2] testsuite: compress modules if feature is enabled
Message-ID: <20210130023600.24239-1-lucas.demarchi@intel.com>
Reply-To: Petr Vorel <pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>
Message-ID: <20210204102448.umXmKwV9iexUvrzwVjybzIIm9phiF_Hf84fJxHG4aAg@z>

Hi,

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Great, thank you!

> +feature_enabled() {
> +	local feature=$1
> +	grep KMOD_FEATURES  $CONFIG_H | head -n 1 | grep -q \+$feature
nit: using grep single time is IMHO enough
grep -q "define KMOD_FEATURES.*\+$feature" $CONFIG_H
> +}

Kind regards,
Petr
