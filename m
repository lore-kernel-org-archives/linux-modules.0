Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44442EB64DD
	for <linux-modules@archiver.kernel.org>; Mon, 24 Jul 2023 19:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGXToa (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 24 Jul 2023 15:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGXTo3 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 24 Jul 2023 15:44:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E810170E;
        Mon, 24 Jul 2023 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ijMl1Cv9y9enj5ovf4v4qSeTqopWOU/OBedk6+5VrX0=; b=YyikBxOqP4IJ1kWID/9hDC8NVf
        zOz/gVRaTSMkAGC4NSWDNH3v/k6lQMVblxGnrLI+U+XTZkdxMXporuJykIHv5VMrWBKzB6hbbAM8f
        oS9M2AVyyV4K2w/Nmo/6FdGvG1rRvvT0HfAxOc3djXxUrjKf3G68o9izAbb/dZoij7msSPx51SkFk
        8zuAvzqLb6LqIgc+ZlxDYKN1Wr0pA3XD4FMPy8HZ9kib03KSz59iL2jEYhvDrba1B36HdOwAiY+sE
        naOgOJIHgkxWogEFf8mrT7zKmGNAKy6bnEFRduUydeNJqfSiVLmgQls4RJhRH/zQCy81jYAZHUz9W
        PRsXugNg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qO1Tp-005JrW-0J;
        Mon, 24 Jul 2023 19:44:29 +0000
Date:   Mon, 24 Jul 2023 12:44:29 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     syzbot <syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com>
Cc:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [modules?] KASAN: invalid-access Read in
 init_module_from_file
Message-ID: <ZL7Una9vhJpX+dkb@bombadil.infradead.org>
References: <0000000000000e4cc105ff68937b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000e4cc105ff68937b@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6
