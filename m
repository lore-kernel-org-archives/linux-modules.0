Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02740C433EF
	for <linux-modules@archiver.kernel.org>; Wed, 29 Dec 2021 08:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239391AbhL2I7E (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 29 Dec 2021 03:59:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60947 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239439AbhL2I7D (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 29 Dec 2021 03:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640768343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZWOEN7VG4jXIP35MPsYStOELlrvFsfJHsjcJKLQOyCo=;
        b=U0w1FVSNuL7ejVLKjA4/msxO2h9mqMSdsXWzjHQLjmZgSlTD3YBHrK7wzUQq7+nS5JjM6S
        8uOnSivB7P/5W1iyjFoX9rzFd/VuGIgcpw2TzSgqzgBlTXsuW9dUjD8RqmJH5rOyOCzXPb
        BcxnxP7Vr+sdzmeILzAPsAq4R4iI8Cg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-91S6G8dkNkSUwEluY5p0IQ-1; Wed, 29 Dec 2021 03:59:00 -0500
X-MC-Unique: 91S6G8dkNkSUwEluY5p0IQ-1
Received: by mail-wm1-f71.google.com with SMTP id z13-20020a05600c0a0d00b003457d6619f8so5827432wmp.1
        for <linux-modules@vger.kernel.org>; Wed, 29 Dec 2021 00:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZWOEN7VG4jXIP35MPsYStOELlrvFsfJHsjcJKLQOyCo=;
        b=LR211E1o+6dky9DU62zc0WMAfQ3CVTGictRMtjSl2wIyMr1hMputyX93gbeLYLloD5
         +yy0TGfrjIVrX1EbCJ+10gz4kdXRJbkAQwWgaq5MEJfOCKE9AVln/JmIDaluTyWlqn+c
         mfUJDY93z6hpShFkhV1yaNFvvm5uAfSPWQPcGvwilL0stoFICJDCPTcr9WadUVbCir7P
         r8uAi7oYaa2Bo7im4TK+3Kj0EFf9r5gjYNCLdSSI6mmI57SXOxA3cdFYLsxXMxITg8cY
         Flg/nl5RrY3WMeLnycBSBnLXm/3ZeffIWoWOpZzyJLgJP7w4dmZY47TqazeURjKAup/y
         Pbbw==
X-Gm-Message-State: AOAM532gziCUCd/stn6lszymF/GhNATOhUNeX/J/ke6JT1309ZkbRtLc
        +vSL6oQJOi8AwAEIBbB4Tr/uHxxmKTXkgr5fayxuJ2w2Ra/r+xxFWvmUmMJCMr3GU1IFRuEgjcI
        kAsetLEqyGe5mAXWLWxCa4uE2
X-Received: by 2002:adf:82f6:: with SMTP id 109mr19696840wrc.169.1640768338976;
        Wed, 29 Dec 2021 00:58:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygLKaNE7oOH8dIDgyOilc8TLTN9ihP1j9sD0P+FRkcvWryxJUcXkZvCs8HHUxQV1JmZtowBA==
X-Received: by 2002:adf:82f6:: with SMTP id 109mr19696830wrc.169.1640768338827;
        Wed, 29 Dec 2021 00:58:58 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f6sm20620425wri.115.2021.12.29.00.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 00:58:58 -0800 (PST)
Date:   Wed, 29 Dec 2021 08:58:57 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, allen.lkml@gmail.com
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: Re: [RFC PATCH 00/12] module: core code clean up
Message-ID: <20211229085857.jj7exfjqzevuclcp@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <YbKUUJUtjBk/n913@bombadil.infradead.org>
 <20211228213041.1356334-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211228213041.1356334-1-atomlin@redhat.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue 2021-12-28 21:30 +0000, Aaron Tomlin wrote:
> Hi Luis, Allen,

Adding Allen.

-- 
Aaron Tomlin

