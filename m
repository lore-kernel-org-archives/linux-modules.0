Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DB6C46467
	for <linux-modules@archiver.kernel.org>; Fri, 20 Jan 2023 00:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjATAIa (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 19 Jan 2023 19:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjATAI3 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 19 Jan 2023 19:08:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5D1A25AE
        for <linux-modules@vger.kernel.org>; Thu, 19 Jan 2023 16:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZiDzJJAeQ0EYh88LzIuW6Tw+q3BThMmeAR6UeNi2sKo=; b=XTqaZWaglqiRIG/j7LXCHTi4ZS
        Qr/NvLA1v90WZUwjfgi12Tp7nVV2NLTLB4pY7dEoNayG2UNQCkkimv9G8KEIKzC9REu6Je/PT7bnw
        A1pA4krElN5T0j8ZPplajTwCbXfXxoO2r16Ekb809IWfrHElUbf+09p96XQruN+dAZZKcRUgSGZl5
        7QkMI81V0EyUtbTI28dg222A18s12kw/dsfOISUhcRVk/BIfpgtEl7WMDNglAC4KMuT11QcYQaWP7
        jyxe3wfQDnWuJ7BwIOFuUHtqeiPup8clXzLoK2sy8xK+Q5SE0hZ50jUo4o70Dk9WyDIz3gLXUPSwA
        SwaaeSbw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIexD-007hDz-MN; Fri, 20 Jan 2023 00:08:24 +0000
Date:   Thu, 19 Jan 2023 16:08:23 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Chandler Sobel-Sorenson <chandler@genome.arizona.edu>
Cc:     linux-modules@vger.kernel.org
Subject: Re: When adding a module, what does "Exec format error" / "Skipping
 invalid relocation target" mean, and how to fix it?
Message-ID: <Y8nbdxufr3ysl+wi@bombadil.infradead.org>
References: <0f95a92e-d898-562e-06d9-8e0456062e36@genome.arizona.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f95a92e-d898-562e-06d9-8e0456062e36@genome.arizona.edu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jan 17, 2023 at 05:42:38PM -0700, Chandler Sobel-Sorenson wrote:
> 
> # modprobe -v qat_c62x
> insmod /lib/modules/4.19.0-5-amd64/updates/drivers/crypto/qat/qat_common/intel_qat.ko
> modprobe: ERROR: could not insert 'qat_c62x': Exec format error
> 
> # modprobe -v intel_qat
> insmod /lib/modules/4.19.0-5-amd64/updates/drivers/crypto/qat/qat_common/intel_qat.ko
> modprobe: ERROR: could not insert 'intel_qat': Exec format error

As of v5.10 we now have merged commit 14721add58ef267344bee254bc276c9139b7b665 
("module: Add more error message for failed kernel module loading")
which helps expand on this being more friendly:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=14721add58ef267344bee254bc276c9139b7b665

> #
> 
> Meanwhile, the system log shows:
> 
> <date> <host> kernel: [<uptime>] module: x86/modules: Skipping invalid relocation target, existing value is nonzero for type 1, loc 000000005c09d38d, val ffffffffc09ba2fe
> <date> <host> kernel: [<uptime>] module: x86/modules: Skipping invalid relocation target, existing value is nonzero for type 1, loc 00000000690eef73, val ffffffffc0b572fe
> <date> <host> kernel: [<uptime>] module: x86/modules: Skipping invalid relocation target, existing value is nonzero for type 1, loc 000000007d30ad16, val ffffffffc0c862fe
> <date> <host> kernel: [<uptime>] module: x86/modules: Skipping invalid relocation target, existing value is nonzero for type 1, loc 00000000671d2da7, val ffffffffc0cd82fe
> <date> <host> kernel: [<uptime>] module: x86/modules: Skipping invalid relocation target, existing value is nonzero for type 1, loc 0000000072877855, val ffffffffc0d2a2fe
> 
> What are these errors even talking about, what is the cause, and possible solutions?
> 
> Thanks so much!

That's from apply_relocate_add(). The locs are supposed to be
0 and they are not so it bails. That relocation type is 1 so
R_X86_64_64.

https://en.wikipedia.org/wiki/Relocation_(computing)

Did you really build the module yourself? It doesn't even seem
you have kernel headers.

  Luis
