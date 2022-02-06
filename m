Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD79BC433F5
	for <linux-modules@archiver.kernel.org>; Sun,  6 Feb 2022 17:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245684AbiBFRAP (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 6 Feb 2022 12:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245670AbiBFRAO (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 6 Feb 2022 12:00:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6E93C06173B
        for <linux-modules@vger.kernel.org>; Sun,  6 Feb 2022 09:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644166812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gr+rlvFHZLc88iZxU30W/q3Yu4fbVb5uGtYcLcCB13U=;
        b=i7XQLXpOCtSM0HDtkNf8TZq6t6DctcCu51H09ru8TVSC/0dnV8ngdG1GhThWqlAJQv5jL9
        5NTQEuz/vR0IP7e7iGEbjBvbnJcsYFcimT7LMJjJLtk5V2ipy751BqSB4qsjxvZ0+nmlxs
        9/SYxf/CXkFHEDRhZQeefKWKwYpTBHA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-WgXIh8C7OWOWuzsuwypLuQ-1; Sun, 06 Feb 2022 12:00:11 -0500
X-MC-Unique: WgXIh8C7OWOWuzsuwypLuQ-1
Received: by mail-wm1-f70.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso4450116wmb.6
        for <linux-modules@vger.kernel.org>; Sun, 06 Feb 2022 09:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gr+rlvFHZLc88iZxU30W/q3Yu4fbVb5uGtYcLcCB13U=;
        b=oFAzJ0VJy6irqdyhDNCPNslIe/4jYlj0DtO7jvV0sbAFPq0dVxGwM6kq1Xskuo7Ssw
         jTlTTneD3DqiZtum42ggLumqTiqMqVY2dBLPFLb7OxCGDbZAdSJI53wMKiMS5gCue4go
         Kk/dQqxz/GAwZYgbBY75TRYVp6xxivaRLZ3+71QFT0Ylw2e4juhGw2JHue2jra95ItXd
         +fjqBQkvVHy5FY5ZnjLTps4YMum7zxZRs7K7Rsp0HPiX8Wl1Ask1g6S6jQquRaIGpf0z
         GBX56IlGWsfVM1oVBVobQ25XvV8RMIkUZmDuRDcGZ0mzgeTY07iOSiJBq4vL82Ry0Xrc
         cTPQ==
X-Gm-Message-State: AOAM532YRsf7RbsCENoKROEZN+tgZdHpGxsmJhER9cfGVfKmNsUXlpnB
        M/XOlG8JimdRGvbVgI9WfrYkehQU/TCjHertYJ5aJstHbY3qc5RZZktG0w0xaG/2bp9PjX5DjGc
        T8uQFC2CPzIepJt07Idx4wU7b
X-Received: by 2002:a05:6000:258:: with SMTP id m24mr7120733wrz.2.1644166810570;
        Sun, 06 Feb 2022 09:00:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvmFZ6FmoMqKj+jRzNF88xYXp8uy84SvUPF3XkmfOUrST3yD/G26iHFSaMCzsUFgWkG8uaVw==
X-Received: by 2002:a05:6000:258:: with SMTP id m24mr7120721wrz.2.1644166810387;
        Sun, 06 Feb 2022 09:00:10 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id b10sm4980698wrd.8.2022.02.06.09.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 09:00:09 -0800 (PST)
Date:   Sun, 6 Feb 2022 17:00:09 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal Suchanek <msuchanek@suse.de>, cl@linux.com,
        pmladek@suse.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, live-patching@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com,
        void@manifault.com, joe@perches.com
Subject: Re: [RFC PATCH v4 00/13] module: core code clean up
Message-ID: <20220206170009.exz5slme7drxqyoa@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220130213214.1042497-1-atomlin@redhat.com>
 <Yfsf2SGELhQ71Ovo@bombadil.infradead.org>
 <Yfw2nm5X+8jRic0C@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yfw2nm5X+8jRic0C@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu 2022-02-03 12:10 -0800, Luis Chamberlain wrote:
> Linus now merged the fix in question, just be sure to use his
> latest tree, it should include 67d6212afda218d564890d1674bab28e8612170f

Hi Luis,

Sure, will do.

> If you can fix the issues from your patches which Christophe mentioned
> that would be great. Then I'll apply then and then Christophe can work
> off of that.

All right. I will try to complete this shortly.


Kind regards,

-- 
Aaron Tomlin

