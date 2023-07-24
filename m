Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987CEEB64DD
	for <linux-modules@archiver.kernel.org>; Mon, 24 Jul 2023 20:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjGXUbV (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 24 Jul 2023 16:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGXUbU (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 24 Jul 2023 16:31:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F571728;
        Mon, 24 Jul 2023 13:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AYmPB6eKX/pK+eH7NmvpIyaBhO0aePPARgfiAYIigdk=; b=wFoyhuxXtvPIqJZ6PEFFXJ9fjV
        mJohraR43/WrtV99f3DQJwBTVIQBSOMjsE8vCVdJJVSw1jzPDQ1IKaDjzFbp41x69Z+TTlDlJiYn7
        IBLp4HqTpzfnIH7z8fbaI9jB/iQI55djcyNegdh2D6tGQ3XSrTu/0hx4C8ZuZqWMQYS3whJr0c6OR
        4dbHevzw5168GzLw2TWpHAWltiXahXdFP+TbkxcCCWQs71kncRwLvv165YxrTiQ5fM3vxR7APQViS
        yeMRGOtCA6Up4tdHnRjYJeWsLuuqVAigN/8CyIlT8MuJWswCiTs5HzO6xYlYrEJoxAazxg6lS5ror
        tTLK+A3w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qO2D8-005NqM-0A;
        Mon, 24 Jul 2023 20:31:18 +0000
Date:   Mon, 24 Jul 2023 13:31:18 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     syzbot <syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com>
Cc:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] [modules?] KASAN: invalid-access Read in
 init_module_from_file
Message-ID: <ZL7fllo9Td1gJmHo@bombadil.infradead.org>
References: <0000000000000e4cc105ff68937b@google.com>
 <ZL7Una9vhJpX+dkb@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL7Una9vhJpX+dkb@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6
