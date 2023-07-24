Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A6BEB64DD
	for <linux-modules@archiver.kernel.org>; Mon, 24 Jul 2023 19:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjGXTn4 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 24 Jul 2023 15:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGXTn4 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 24 Jul 2023 15:43:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762A3170E;
        Mon, 24 Jul 2023 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jt72MNl3swMARzj53k4BB65l+UHgCy67wPWcGfx/NOk=; b=HikHJobVOYJmiv1G3z0sNjBRUC
        E32VxxdtnfRht167qmJJO18u//Qb1jaDqmUdIGtdOHNkxZKeoBiN2poJrR6f1pEtNJJ0IiBKNr4YF
        PILWV69/8e/P+rkfrv9wIQY9bblY4CuXo5YdyGUlS4DPpWaOBKBftEVaz/oAE1aizladxWrf7Ygmg
        cTzQ2nLGBVeKvAz1xjk3sQAe/M/KM0xA866IkiWhizPVbu4bV+Fwo2hGoEEE3TbIfy+suMjjz26gw
        nVf2XrmgqM3aTaiURwGAUcnIYQ1eANLBPv7FMYgeTIxDs/XLLQzbg9lrTXh9tmmrKjqr+Dq5euc2F
        f6ng6+qw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qO1TF-005Jop-1P;
        Mon, 24 Jul 2023 19:43:53 +0000
Date:   Mon, 24 Jul 2023 12:43:53 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     syzbot <syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com>
Cc:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [modules?] WARNING in init_module_from_file
Message-ID: <ZL7UedKQUDAUThHM@bombadil.infradead.org>
References: <00000000000076961f05ff92d4e0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000076961f05ff92d4e0@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6 
