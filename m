Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9A9C43334
	for <linux-modules@archiver.kernel.org>; Sun,  3 Jul 2022 13:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiGCN5U (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 3 Jul 2022 09:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiGCN5T (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 3 Jul 2022 09:57:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F77CF58
        for <linux-modules@vger.kernel.org>; Sun,  3 Jul 2022 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656856637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WDfzjz194PcCWxTAzz6bDcDIHTW8QXy07c2UacTGGhM=;
        b=UQKOcf2x3AUX+qJtWyJTvGEP8agjcgq+5DocV3CVcHrkqeaZplCB5B5AfMKjxwHxjeK8Dm
        SgGccC9NuANPchGPDrDpWn8MxHHb6E4D4FwQCYp4r09aTui5NAd4K2qtwOZdSwg4v7lAXD
        p+prWbpmrKBpitQm6LGEY2g7E7fDUrQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-EZpTJufeO6WEVJQJ9dUxZg-1; Sun, 03 Jul 2022 09:57:10 -0400
X-MC-Unique: EZpTJufeO6WEVJQJ9dUxZg-1
Received: by mail-wm1-f70.google.com with SMTP id 18-20020a05600c021200b003a19b2beb0aso914732wmi.1
        for <linux-modules@vger.kernel.org>; Sun, 03 Jul 2022 06:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WDfzjz194PcCWxTAzz6bDcDIHTW8QXy07c2UacTGGhM=;
        b=kulcqu1uU7u3IZYVQYWTT4QXYObmDJ6A8+uh2UZ6NjZMkSi1xxw4EfihKpxSjC8c4+
         7ItFvOeRuOnGj2l+Mkhwi2/XLqzPioSYnjrhIeyyRiW/pVc8zSmWAiFKQxN8MKbfvX7n
         xThkEevzPv2tadRcQygPbdHtBISbSGGQIWywditIbBZ6NNxzFUuq4UkLqM0IKQg1wRpo
         aFiO/JwU5n9GLP9h8P1EFb+lLu01Onxs3190XKn6vkTQ0VP1SoUgtDNRw/SEsno2Pru4
         LOyZlFsmBtFNS5qX8FBBOJ8+ZybEP7arZKHTdhzuFaY3qzK7jArbHYb0bi4UgIhMv3TG
         vSzg==
X-Gm-Message-State: AJIora/r0/setKJjyAsNuCVuKkL2KWz+Z6hdq/YT3jJN9sAq1thWA8Kv
        ZG82kaG3L/2VvseP5QHVR+4fHZhfhaYCv32u/FOLKfswd9oLGz1rS9vKBbD6uUztoh8mBfImWKp
        6AxJW2b5kz9qgZsF/31hryO8E
X-Received: by 2002:a05:600c:1e13:b0:3a0:45c9:8480 with SMTP id ay19-20020a05600c1e1300b003a045c98480mr28929885wmb.51.1656856629686;
        Sun, 03 Jul 2022 06:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vMV0/K1HCQLYKV63GnYHKrDh7xS2FLDOGOPdw9hQdu6D2Nby5TPOEGWoKjXnC6/KsNeq+l8Q==
X-Received: by 2002:a05:600c:1e13:b0:3a0:45c9:8480 with SMTP id ay19-20020a05600c1e1300b003a045c98480mr28929852wmb.51.1656856629421;
        Sun, 03 Jul 2022 06:57:09 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c144900b0039ee51fda45sm16618553wmi.2.2022.07.03.06.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 06:57:08 -0700 (PDT)
Date:   Sun, 3 Jul 2022 14:57:08 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, christophe.leroy@csgroup.eu,
        cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 09/14] module: Move kallsyms support into a separate
 file
Message-ID: <20220703135708.kn535pdrqv24f7kn@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220310102413.3438665-1-atomlin@redhat.com>
 <20220310102413.3438665-10-atomlin@redhat.com>
 <20220628000526.11c57cd8@gandalf.local.home>
 <20220628081906.jln2ombfej5473xi@ava.usersys.com>
 <Yr92YtG12f+II+ea@bombadil.infradead.org>
 <20220703083324.az24ou7nrngvp73v@ava.usersys.com>
 <20220703092305.1e5da4c2@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220703092305.1e5da4c2@rorschach.local.home>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sun 2022-07-03 09:23 -0400, Steven Rostedt wrote:
> BTW, *NEVER* modify code that you are moving. Really, *NEVER* do that!
> 
> It makes debugging much more difficult, like in this very case.
> 
> *ALWAYS* have the moving of code be a separate patch. Keep as most
> identical as humanly possible. Even keep white space errors the same!
> You can add a clean up patch before or after the move. But never do it
> as one patch!

Hi Steve,

I completely agree and noted.

> You even stated "no functional change" which was a lie. Converting
> strlcpy() to strscpy() *is* a functional change!

Understood.


Kind regards,

-- 
Aaron Tomlin

