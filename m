Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE456C433F5
	for <linux-modules@archiver.kernel.org>; Tue, 21 Dec 2021 21:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhLUVoz (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 21 Dec 2021 16:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLUVoz (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 21 Dec 2021 16:44:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B8CC061574;
        Tue, 21 Dec 2021 13:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g1DkaflNqTMfxBW6qRpkoRfxi8Y3JweVReOmR5YEtKQ=; b=WZU3q5IjyNqsUUkfGy2TwqqGkk
        I2pvMTNamhaxV1g9GOWAAtC04k5Td7tN8h3NmdaEnwMw3DykrIpeRjyUmqElwo4Cz1iZB1owVndni
        Bk1HwV8OryLhaFFA3UcFMf9qfqhK9AEOIrYBW25XnscPA8gpl4S13OH4SOMl3HuCi4e4FFI7j+5ht
        O+FZg3EWyZJlMmd7HjC0TfGNxf0UUFsTZUhqEntmSCnJv+/st63pi9BsRRbzEueVKI2L3HkQkuMYl
        ZuEUGWLvGWMcQBT3kBOWILToGdxouPtbxfMaK3nvCIu589QYawrnHY/+4JrQUH7wj4AtNjq4Szkfz
        /KTHSopA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzmwI-008ZSK-3J; Tue, 21 Dec 2021 21:44:54 +0000
Date:   Tue, 21 Dec 2021 13:44:54 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eliyam Levy <eliyamlevy@gmail.com>
Cc:     linux-modules@vger.kernel.org, linux-newbie@vger.kernel.org
Subject: Re: INVALID ELF STRUCTURES
Message-ID: <YcJK1rPwQVu/pX+S@bombadil.infradead.org>
References: <CAD9KO1=gjhe1sc3MNyc3QawQgJAgwptFgsTZE903PCi3_DEyPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD9KO1=gjhe1sc3MNyc3QawQgJAgwptFgsTZE903PCi3_DEyPg@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Dec 21, 2021 at 11:54:09AM -0500, Eliyam Levy wrote:
> Hi,
> 
> I'm on Ubuntu 20.04 with kernel version 5.11 and I keep hitting the
> "Module has invalid ELF structures" error on a kernel module I'm
> building. I know this is related to the "harden ELF info handling"
> patch that was introduced. Are there any useful ways to debug this? Is
> there anything I should be mindful of when building the kernel module
> to avoid this?

Look for the already merged patch, "module: change to print useful
messages from elf_validity_check()".

$ git describe --contains 7fd982f394c42f25a73fe9dfbf1e6b11fa26b40a
v5.16-rc1~95^2    

  Luis
