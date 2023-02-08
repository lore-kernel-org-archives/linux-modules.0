Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41419C05027
	for <linux-modules@archiver.kernel.org>; Wed,  8 Feb 2023 08:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjBHIhZ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 8 Feb 2023 03:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBHIhZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 8 Feb 2023 03:37:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6826FF1F;
        Wed,  8 Feb 2023 00:37:23 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675845441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDbjeGgIYWaFAExc2nluK89DKG6OXifSTuEpjBp5fwI=;
        b=QyZBW7lq3MBckKY/jl+SMVkPNApyyxouz1QP/+JsSP7uqUqR/CzFzQmh0LMQsytXdhfL/B
        bxK+a/sOgm5fcazzmjiUxdK9PIEH7FWkhh2JpkBCbIwISmWo1WxrFVrxJkhkV/azPYnmf6
        /mL+9mq+F045Glth7VDG4YzFUp7seqDT0/Ad6w7aeT9moTkKBeIhgHI6B4ENtENyUdNeXC
        vPYybrptemIOqUP7XVIy/sskq1p3GmuWRA8KVuDj/eFColW2v8i1V/AmbzR2Us3U2TccNI
        wji4o67nx3ZYHeAbIRTW/06H+k1N2NbeGUUt3KLdZMH0EFVlE9PHJUMzxsk4Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675845441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDbjeGgIYWaFAExc2nluK89DKG6OXifSTuEpjBp5fwI=;
        b=tZ4E57KZE9hJ6JtORuVoYAHVh3WSKDm8aPh0PgMBx6oxbaeMpVpumMjV/K3XJjDxNJen8D
        mE07vsS7egJa9GDg==
To:     Song Liu <song@kernel.org>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de, kernel-team@meta.com, Song Liu <song@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v10] module: replace module_layout with module_memory
In-Reply-To: <20230207002802.2514802-1-song@kernel.org>
References: <20230207002802.2514802-1-song@kernel.org>
Date:   Wed, 08 Feb 2023 09:37:21 +0100
Message-ID: <87357gv9ha.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Feb 06 2023 at 16:28, Song Liu wrote:
> module_layout manages different types of memory (text, data, rodata, etc.)
> in one allocation, which is problematic for some reasons:
>
> 1. It is hard to enable CONFIG_STRICT_MODULE_RWX.
> 2. It is hard to use huge pages in modules (and not break strict rwx).
> 3. Many archs uses module_layout for arch-specific data, but it is not
>    obvious how these data are used (are they RO, RX, or RW?)
>
> Improve the scenario by replacing 2 (or 3) module_layout per module with
> up to 7 module_memory per module:
>
>         MOD_TEXT,
>         MOD_DATA,
>         MOD_RODATA,
>         MOD_RO_AFTER_INIT,
>         MOD_INIT_TEXT,
>         MOD_INIT_DATA,
>         MOD_INIT_RODATA,
>
> and allocating them separately. This adds slightly more entries to
> mod_tree (from up to 3 entries per module, to up to 7 entries per
> module). However, this at most adds a small constant overhead to
> __module_address(), which is expected to be fast.
>
> Various archs use module_layout for different data. These data are put
> into different module_memory based on their location in module_layout.
> IOW, data that used to go with text is allocated with MOD_MEM_TYPE_TEXT;
> data that used to go with data is allocated with MOD_MEM_TYPE_DATA, etc.
>
> module_memory simplifies quite some of the module code. For example,
> ARCH_WANTS_MODULES_DATA_IN_VMALLOC is a lot cleaner, as it just uses a
> different allocator for the data. kernel/module/strict_rwx.c is also
> much cleaner with module_memory.
>
> Signed-off-by: Song Liu <song@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>

With the comment update folded in:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
