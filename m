Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E9EC433EF
	for <linux-modules@archiver.kernel.org>; Sun,  6 Feb 2022 16:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbiBFQy7 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 6 Feb 2022 11:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiBFQy6 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 6 Feb 2022 11:54:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61304C043184
        for <linux-modules@vger.kernel.org>; Sun,  6 Feb 2022 08:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644166496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wGN0aCaJ6VNVrO8pLls0lDkqT7d3PIX0pXAwRUixJPc=;
        b=Bkfy/5bMfK/X3aVgBorpjHaLrl3ybZb3wgkQZDXQQPpYOH7cUTr23e7X0qntvpETnUyCwp
        udQcqkPb3EtTOpWx9Vifg/Uq7/ZuYLy473dqxHij9e39wlAqLmB44olqoDSEUpcQcaSpv8
        0P+FTDCRFEERXynZj5qVGWIC0swQhu8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-IAyXP6GHMZ--S5iFQ2kQHA-1; Sun, 06 Feb 2022 11:54:55 -0500
X-MC-Unique: IAyXP6GHMZ--S5iFQ2kQHA-1
Received: by mail-wm1-f70.google.com with SMTP id l4-20020a05600c4f0400b0037bb2ce79d8so2495776wmq.9
        for <linux-modules@vger.kernel.org>; Sun, 06 Feb 2022 08:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wGN0aCaJ6VNVrO8pLls0lDkqT7d3PIX0pXAwRUixJPc=;
        b=04XmDLhRbMV93C/C89g1dF4Li7NWvPoyP5d9Nd3W/Fc0x44omb/N3e8w5Jv/lD4Nbb
         R+CmD7Bm1XgHKN0hmv0Jj9H99SgbS/XKdsqMfAI3DX0CQ/FMsmhmRVjRvUEYLlPiRq5D
         VvkIjsgId+TbNMutSx7GiifwK+u9sMa39nRJflV0KnVTsgI8RPqVB/VNuukS+HNyf3Bb
         CMc/qeNEadK91xRcdTeGhyCLNPWzMR8o6GGozWrzwVZFx9cFWfaldcHihlkU+yEkV09h
         MxQcv4l9ykVhdHyR48Xz6DPlvvg3N7TNGVVL4+kX3k7KR1ShH5nqVrdGcIecH36+1Fva
         nATQ==
X-Gm-Message-State: AOAM530brXDWUOe2yAy74boysbUUJxRq37uu5S33DzqNLi/9RFu/Hn6D
        wOY80rS8sUt6MO2+JoLcprVqjacd/jCrYl82lLORfDsA9Lc2mUMD03HcXViZ5FW/NjQqUkiNpVT
        8FcneaPN9t1yLMjV8Aqdx+8ZK
X-Received: by 2002:a05:600c:3584:: with SMTP id p4mr7346525wmq.69.1644166493982;
        Sun, 06 Feb 2022 08:54:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzI7l54iRHrlfaoSdBdIIrtfn3hw3WwzyqoYLSQlDRSZBn2Zp18nT6IhyGVrbRGstkN3YzPjA==
X-Received: by 2002:a05:600c:3584:: with SMTP id p4mr7346509wmq.69.1644166493777;
        Sun, 06 Feb 2022 08:54:53 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p15sm7506809wrq.66.2022.02.06.08.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 08:54:53 -0800 (PST)
Date:   Sun, 6 Feb 2022 16:54:52 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Michal Suchanek <msuchanek@suse.de>,
        "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "void@manifault.com" <void@manifault.com>,
        "joe@perches.com" <joe@perches.com>
Subject: Re: [RFC PATCH v4 00/13] module: core code clean up
Message-ID: <20220206165452.ytpk4epltqr6pgyu@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220130213214.1042497-1-atomlin@redhat.com>
 <Yfsf2SGELhQ71Ovo@bombadil.infradead.org>
 <1ae3a950-8c1e-a212-e557-8f112a16457d@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ae3a950-8c1e-a212-e557-8f112a16457d@csgroup.eu>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu 2022-02-03 18:01 +0000, Christophe Leroy wrote:
> I have another comment: I think patch 5 should be dropped.

Fair enough.

> Having something behave based on a CONFIG_ARCH_HAS_SOMETHING item is 
> wrong. It is not because a plateform selects 
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX that the module core should behave 
> differentely than with other platforms as far as the user has not 
> selected CONFIG_STRICT_MODULE_RWX.
> 
> And the topic here is wrong. It is a coincidence if making that stuff 
> depend on CONFIG_ARCH_HAS_STRICT_MODULE_RWX works. This is just because 
> the only architectures that do the module allocation without Exec flag 
> are architectures that have also selected 
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX. But it should also work on other 
> architectures.
> 
> I don't know exactly what was the motivation for commit 93651f80dcb6 
> ("modules: fix compile error if don't have strict module rwx") at the 
> first place but it is just wrong and we should fix it.
> 
> module_enable_x() should work just fine regardless of 
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX.

The above does make sense, to me.


Kind regards,

-- 
Aaron Tomlin

