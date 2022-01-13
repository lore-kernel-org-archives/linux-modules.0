Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0B5C433EF
	for <linux-modules@archiver.kernel.org>; Thu, 13 Jan 2022 09:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiAMJXK (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 13 Jan 2022 04:23:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233735AbiAMJXJ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 13 Jan 2022 04:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642065789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1hPX2NhGvNI/hltjD58R6gX5RpgFP8ru9lDgC/nr++s=;
        b=DOiCo18c1hphvPEUTnnCSRsd6+U0EL7475ugQr+hc6IcjwJGWotYL852tl1Di+RuhgxMx7
        VKLDT7vpPJxwyWtkCVE8VtWaQt/cWWdUJkGQXovfnNwaVTszafDR3SN8C7kkRJU9gBbFA7
        WOm9cwwTV9HV7cu1P3Y3ER7VSge8dS4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-45xpw2E6M729cjR3eibfGg-1; Thu, 13 Jan 2022 04:23:07 -0500
X-MC-Unique: 45xpw2E6M729cjR3eibfGg-1
Received: by mail-wm1-f70.google.com with SMTP id 14-20020a05600c024e00b0034a83f7391aso2008632wmj.4
        for <linux-modules@vger.kernel.org>; Thu, 13 Jan 2022 01:23:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1hPX2NhGvNI/hltjD58R6gX5RpgFP8ru9lDgC/nr++s=;
        b=G3dy5l9TpLyc9d2tILObCuj6Lk9vcRiRkJjJBhTB+ntCRqdOJ7/Xn6YoYDgXqdNPYm
         pUAzMY46XhlIbo/p9Jz1y4kgInbk6vV3PXMdwg0wBH1G6q7QMr+Isf6f0QmrbPBHAYr0
         4TzG+T4T+Gxcec1Ph1i485OPvZN6CmWiS7ifgH56C7yO4Nc9o81k4GJIoPEHhf9R+Cjz
         r8vHdhPMBOhPzSLabn0x2aSidExiGWwqYLNdzQh/8HjR4lcuKHB6SUOlLYE9rQ28EiBB
         nwcnL+doXGzu5wGA15FPPUYT3R7IEjuqPLGWq0biLYvECU0RbEtc3hvI9WR/FLmZactX
         VNag==
X-Gm-Message-State: AOAM5315YRhS7Iz5paeL4G/h7n3OkOF7pCFFb3OLFNWd/0RiDBmVSdfB
        TWca8liaIrF/M5xgicp/ElQPP4Rb6LqUwpZE9C8DTQMj/RbN2blFnjdf/H9tjURsx+wND+vnp5h
        6gfuh2x9u15IyPCgzTUonhLNg
X-Received: by 2002:a1c:f616:: with SMTP id w22mr2937444wmc.75.1642065786704;
        Thu, 13 Jan 2022 01:23:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpYM5wf8R2hHTozXrisz5AtIoPofliMJ4qxbH+yf3kHAG+gYnDOXLO2pwW5bFiIBUseKX59w==
X-Received: by 2002:a1c:f616:: with SMTP id w22mr2937429wmc.75.1642065786481;
        Thu, 13 Jan 2022 01:23:06 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id j11sm2690364wmq.23.2022.01.13.01.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 01:23:05 -0800 (PST)
Date:   Thu, 13 Jan 2022 09:23:05 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Allen <allen.lkml@gmail.com>, Christoph Lameter <cl@linux.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com
Subject: Re: [RFC PATCH v2 00/13] module: core code clean up
Message-ID: <20220113092305.vx3kexfqhplxirmh@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220106234319.2067842-1-atomlin@redhat.com>
 <CAOMdWSJHm9bRAcrB6U+FsRiK6Fg2bbtbUH82w54VD7kbFmnVsA@mail.gmail.com>
 <CAOMdWS+Sn1sZJt8ocig5U7d7qG3N8oJBW-D1ey0qbZ3AXF-JWg@mail.gmail.com>
 <20220112132104.7emyelwuv3jmmhdt@ava.usersys.com>
 <Yd75OzrhrjDp7CVa@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yd75OzrhrjDp7CVa@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed 2022-01-12 07:52 -0800, Luis Chamberlain wrote:
> On Wed, Jan 12, 2022 at 01:21:04PM +0000, Aaron Tomlin wrote:
> Please work off of modules-next tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next
> 
> That is, this tree on the modules-next branch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git

Understood.


Kind regards,

-- 
Aaron Tomlin

