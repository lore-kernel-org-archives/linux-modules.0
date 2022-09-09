Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8780ECAAD5
	for <linux-modules@archiver.kernel.org>; Fri,  9 Sep 2022 00:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIIABW (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 8 Sep 2022 20:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIIABV (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 8 Sep 2022 20:01:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3817F230
        for <linux-modules@vger.kernel.org>; Thu,  8 Sep 2022 17:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9LvxNjKg4IBcXl0mJS8aXBKx/IuWuIV4RwWljryvcwA=; b=B1diwTDMu0bSfkVD0jUzJ+B2xA
        efRal0MLMKsNK1Dv0VTkrAb5VIKCbXEi8a35LbhWYqvWjaej+uv7pTerLJrHAGN9gF4rhtStsTsoo
        MEt5+KT9ozeFYeTVg92Z3NLkDhjOI42adxpPYtMMYaaIyIL2W1ri4GqNAqKJsaP8wKGNT3hw7nYky
        +C8C6m3mPOqdYUFH6hxgz8GJ4jWbL9+4YaUrTNMxYdxB+e9O3vEkFiXxQKzm2koSNtbPY60uFT6kt
        cdi5sR0HT0H4lXOuWfKjvqPO0Ntuy0HINy8hcI7wg0cP1EI/qDQCCx1VAzQd+8hNeY/ASre0duZXZ
        j1Z4c9jQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWRSS-00A4ew-5y; Fri, 09 Sep 2022 00:01:20 +0000
Date:   Thu, 8 Sep 2022 17:01:20 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     dmitry.torokhov@gmail.com, linux-modules@vger.kernel.org
Subject: Re: [PATCH resend] module/decompress: generate sysfs string at
 compile time
Message-ID: <YxqCUMLj4fOCpr35@bombadil.infradead.org>
References: <20220906080317.15426-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906080317.15426-1-ddiss@suse.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Sep 06, 2022 at 10:03:18AM +0200, David Disseldorp wrote:
> compression_show() before (with noinline):
>    0xffffffff810b5ff0 <+0>:     mov    %rdx,%rdi
>    0xffffffff810b5ff3 <+3>:     mov    $0xffffffff81b55629,%rsi
>    0xffffffff810b5ffa <+10>:    mov    $0xffffffff81b0cde2,%rdx
>    0xffffffff810b6001 <+17>:    call   0xffffffff811b8fd0 <sysfs_emit>
>    0xffffffff810b6006 <+22>:    cltq
>    0xffffffff810b6008 <+24>:    ret
> 
> After:
>    0xffffffff810b5ff0 <+0>:     mov    $0xffffffff81b0cde2,%rsi
>    0xffffffff810b5ff7 <+7>:     mov    %rdx,%rdi
>    0xffffffff810b5ffa <+10>:    call   0xffffffff811b8fd0 <sysfs_emit>
>    0xffffffff810b5fff <+15>:    cltq
>    0xffffffff810b6001 <+17>:    ret
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Thanks! Queued up to modules-testing.

  Luis
