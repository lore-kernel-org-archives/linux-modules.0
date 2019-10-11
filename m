Return-Path: <SRS0=2Kvf=YE=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3395C47404
	for <linux-modules@archiver.kernel.org>; Fri, 11 Oct 2019 15:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70909206A1
	for <linux-modules@archiver.kernel.org>; Fri, 11 Oct 2019 15:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570807891;
	bh=7XYT1FrNF/XG4yYUuKPaYoFH46Pe0/yvmDiTNuOUoZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w+O3vhDnKpSEOr/2/OpX5B56+/ahX/972p5noPT/q3DVMP7FRd0RS/tNFU/fgBUVk
	 BEqkBrxFs2aoql5ByZt+5CQm86l1CYIoGuuygRk9ic519xUTFrBBD8ewggPVRnnE5W
	 24MDHUuNnxFtdAQFxZeXp2nJT0WiO2ymnDoXF0kU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfJKPbb (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfJKPbb (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 11 Oct 2019 11:31:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6FD02190F;
        Fri, 11 Oct 2019 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570807890;
        bh=7XYT1FrNF/XG4yYUuKPaYoFH46Pe0/yvmDiTNuOUoZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+fcPI92HOL/DpOJYIcHbu+iQHMnLhY6qNwcmmeDA7UXS3DEmw1WP13J2hdA8xRzp
         g3mXfgH9EEydj627HOjuhVdb9hLuLdzMUumvySgoEP1tTAynPG6QHnc+mrfdEsTjjy
         NJfwtEUNImRD89kJVnw91KA8uQe2xC1jQYsZrz7k=
Date:   Fri, 11 Oct 2019 17:31:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Martijn Coenen <maco@android.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Shaun Ruffell <sruffell@sruffell.net>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH 4/4] export: avoid code duplication in
 include/linux/export.h
Message-ID: <20191011153127.GA1283883@kroah.com>
References: <20191010151443.7399-1-maennich@google.com>
 <20191010151443.7399-5-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010151443.7399-5-maennich@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Oct 10, 2019 at 04:14:43PM +0100, Matthias Maennich wrote:
> Now that the namespace value is not part of the __ksymtab entry name
> anymore, we can simplify the implementation of EXPORT_SYMBOL*. By
> allowing the empty string "" to represent 'no namespace', we can unify
> the implementation and drop a lot redundant code.  That increases
> readability and maintainability.
> 
> As Masahiro pointed out earlier,
> "The drawback of this change is, it grows the code size. When the symbol
> has no namespace, sym->namespace was previously NULL, but it is now am
> empty string "". So, it increases 1 byte for every no namespace
> EXPORT_SYMBOL. A typical kernel configuration has 10K exported symbols,
> so it increases 10KB in rough estimation."

10Kb of non-swapable memory isn't good.  But if you care about that, you
can get it back with the option to compile away any non-used symbols,
and that shouldn't be affected by this change, right?

That being said, the code is a lot cleaner, so I have no objection to
it.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
