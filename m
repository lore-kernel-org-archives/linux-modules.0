Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499DFC433EF
	for <linux-modules@archiver.kernel.org>; Sun,  6 Feb 2022 14:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242953AbiBFOmz (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 6 Feb 2022 09:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239277AbiBFOmy (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 6 Feb 2022 09:42:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC803C043183
        for <linux-modules@vger.kernel.org>; Sun,  6 Feb 2022 06:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644158572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kdl8CfH3Z3HiaQzbi8nArohvqswPkyc3SDVPBJGLfj4=;
        b=K72JF9qJvi6HnLfdt9Es68hmzDpj8UpOuVZF7ozady7U40oTxv3ktisDc+tLELNUxKkzS8
        5I7UjwSID+uyM7p5h+fGBfYiz5Y1YdgTnwGoSLnvk2VoSSiBx5prAKpdchU6GTNBJFBjPk
        UEk07o8FjFr+pKe5dD0g4dMsuXVPf/s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-A4nbJPL_MoemUsmHTeRPhw-1; Sun, 06 Feb 2022 09:42:50 -0500
X-MC-Unique: A4nbJPL_MoemUsmHTeRPhw-1
Received: by mail-wm1-f72.google.com with SMTP id p2-20020a05600c430200b0037bb72b5865so172359wme.8
        for <linux-modules@vger.kernel.org>; Sun, 06 Feb 2022 06:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kdl8CfH3Z3HiaQzbi8nArohvqswPkyc3SDVPBJGLfj4=;
        b=BvGnDX1UJk8O5hqUF/P1y0K8bQQmgmeGDpUWiwdG/K745LHBRzvNa8VsN2OvDF0bf0
         MWOrGx+y5FTr0aurlIkou9lFGxFs/fbvVNnn3G4PLUx+AI6WxJysoF5k0WrOD3w1GEfJ
         VoVMw41rjN5dWMN6RNFvRBl8svuq4e1M0/lSaQxuzIdCNDZpU11tftSh4E8owZd0BB51
         nyBwTVg6NeTIlaR1d96Pd293BKMETB0RGtJrzWmJZ3ryG5M2lOoeOHZmfl2cbhkHvDfN
         UQ51mXpxh/x1T7cQauTyg4+Jt5STa535G0c3oINpsqUtcRWH/004XaSsKYt9oUMsL2CT
         IiPQ==
X-Gm-Message-State: AOAM531qpUnhUN6S5PEuCzKi67rWynYri6IixJXN2LLQdZ5WoxL1l0Su
        kD/139m5OTwrp8vlI0Xw3fFjFKIOORjszj1tnHQBa/GlZ1ZzUozUXv1PETsxN7kGiFj4Xs+Kzuh
        SmxXfaQ191L2OqCnJG0OKOi5r
X-Received: by 2002:a05:6000:1001:: with SMTP id a1mr6713125wrx.230.1644158569747;
        Sun, 06 Feb 2022 06:42:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5HUKPoAB+azfk61camj45+zxovHaHwEzO+suKg+ekvuId+ykStSst/zq3NR4RoL4UfMJj/w==
X-Received: by 2002:a05:6000:1001:: with SMTP id a1mr6713114wrx.230.1644158569569;
        Sun, 06 Feb 2022 06:42:49 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id c10sm1179758wrq.87.2022.02.06.06.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 06:42:49 -0800 (PST)
Date:   Sun, 6 Feb 2022 14:42:48 +0000
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
Message-ID: <20220206144248.xidnurpm6xsacws3@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220130213214.1042497-1-atomlin@redhat.com>
 <Yfsf2SGELhQ71Ovo@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yfsf2SGELhQ71Ovo@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed 2022-02-02 16:20 -0800, Luis Chamberlain wrote:
> Thanks for all this work Aaron! Can you drop the RFC prefix,
> rebase onto linus' latest tree (as he already merged my
> modules-next, so his tree is more up to date), and submit again?

No problem and will do.

> I'll then apply this to my modules-next, and then ask Christophe to
> rebase on top of that.
> 
> Michal, you'd be up next if you want to go through modules-next.
> 
> Aaron, please Cc Christophe and Michal on your next respin.

Sure.

Kind regards,

-- 
Aaron Tomlin

