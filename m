Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381D4EB64DD
	for <linux-modules@archiver.kernel.org>; Mon, 24 Jul 2023 19:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGXTqH (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 24 Jul 2023 15:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGXTqG (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 24 Jul 2023 15:46:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8698B170E;
        Mon, 24 Jul 2023 12:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ijMl1Cv9y9enj5ovf4v4qSeTqopWOU/OBedk6+5VrX0=; b=o/MKFZwzv0jFes6m40Ybq+6Z0l
        OWIXSREb5FqwPLK9im6nfojshNNzR9gGww1EgQvj76Ej9giQjz3yyzFzjd7Rj3nJetHlcUkV9fjIe
        cNSMlm/f+nZl+Fxhi9N5p3eiqBsOnPOeIw1dXWBX8uA8DcJqXJom7btsb/G+h8HlnamwkaC/mjjtP
        SRw7Q4CT8pAJQQr4a/m2eLHsCGCh+H7hneUdZpjKETk+toWv44Q2f1yUxdj+Xo2KqkFl9rtT3fFg2
        CCezJyFkdXV4rOpe1TAP3jleOtN3PXyl6k+LcnwXQtHFnFIzrp5x+H6CEXXi/bgoPpgV8zDPR+LFq
        akNUH4qg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qO1VN-005K1E-1M;
        Mon, 24 Jul 2023 19:46:05 +0000
Date:   Mon, 24 Jul 2023 12:46:05 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     syzbot <syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com>
Cc:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [modules?] general protection fault in sys_finit_module
Message-ID: <ZL7U/V3SFaJndkhW@bombadil.infradead.org>
References: <00000000000094ac8b05ffae2bf2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000094ac8b05ffae2bf2@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6
