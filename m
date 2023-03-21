Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BFAC6FD1C
	for <linux-modules@archiver.kernel.org>; Tue, 21 Mar 2023 01:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjCUBFj (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 20 Mar 2023 21:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCUBFi (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 20 Mar 2023 21:05:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11072D7C;
        Mon, 20 Mar 2023 18:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SkDOq+hVqkKXkhf0jfq2Q2uknXMxqTESy/4finPiMSg=; b=K5rWtRwy9tx+8UE96OJRFamwKe
        b5uDIw4Dy5VnQwvKXwl2nTUGxdD+SEwF7a9TZBm1A0gA+x8UqKmhgjp02+gsUjMK6d+cPbK3C1SZS
        nZL5LLyhv8YEtjaADUL/QHOuokC9+RIST8Hz4IwpRcamqcMdNOW5MA9R9gPARxwjtmavliuRgAysx
        hgy3S8gewrBsYWvSUDkSfiDzW6Q9tdzx4h5guXdJasGXWHrU/r+giblhqaW5Tnu58v+Wa9R52DV0d
        oaCTrC/vgfvonQWImKcSVgeL36U/5k/HHQ3fHtLQXKChbitjPKXKicrVtFZpb+cdk0nSuIPDigV8a
        94+zci3Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peQQH-00Auho-0a;
        Tue, 21 Mar 2023 01:04:21 +0000
Date:   Mon, 20 Mar 2023 18:04:21 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Colin King (gmail)" <colin.i.king@gmail.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, david@redhat.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org
Subject: Re: [PATCH v2] stress-module: stress finit_module() and
 delete_module()
Message-ID: <ZBkClVqkTp5b+gut@bombadil.infradead.org>
References: <ZBUA6E3kYh0Xuu/c@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBUA6E3kYh0Xuu/c@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Mar 17, 2023 at 05:08:08PM -0700, Luis Chamberlain wrote:
> I'm not sure yet why we don't see the module delete work, I guess
> because it's refcnt is still not 0 and so the unload probably won't
> help at all unless we have a loop just dedicated to that.

<insert self deprecating humor>
The reason was because the module_name is the full path, and the system
call wants just the module name.
</end self deprecating humor>

I'll fix.

  Luis
