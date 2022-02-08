Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F79BC433EF
	for <linux-modules@archiver.kernel.org>; Tue,  8 Feb 2022 11:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356063AbiBHLbW (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 8 Feb 2022 06:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356029AbiBHKFn (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 8 Feb 2022 05:05:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C25BC03FEC3
        for <linux-modules@vger.kernel.org>; Tue,  8 Feb 2022 02:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644314739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rnpsDmBPmJ2P6qKlOUE8aXbjL0kFSyGBtiEVa9bJyyM=;
        b=cMQKpePWLp9enfW2FGDeutgbudoIfoPLsFJSIPbaJwD3SaRPIeTDOs6lcQ255i1UUzCsoU
        ScqxbrNLxoQyA4IjziOKoQ9GlZX3j8JQMT2XNccQcpsvL3LnJoa4oN4awUk1qonjh4aws2
        OB9mnkjMnMLdeGPa0dLvJBWwGfGKQ6E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-ujZmhL5YMl6KE33DDEYXgw-1; Tue, 08 Feb 2022 05:05:38 -0500
X-MC-Unique: ujZmhL5YMl6KE33DDEYXgw-1
Received: by mail-wm1-f72.google.com with SMTP id u14-20020a05600c210e00b0037bddd0562eso341393wml.1
        for <linux-modules@vger.kernel.org>; Tue, 08 Feb 2022 02:05:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rnpsDmBPmJ2P6qKlOUE8aXbjL0kFSyGBtiEVa9bJyyM=;
        b=qjW9AUidypBNh7qx7OWhViqHZLXYXNbTPPHLupbfbn8Ok89Txi0Y1Z5NqkdHD/Ab5t
         1zGTOMJgNP1PQRggg/THipLoAdM4gzsAMpXd8bvEniNdkJeZNYGGAGP0AshOqFOM1BZA
         irjmpTpV6sB3UQkHjTG0dNLVmsZOMSUZrbAk6kF0w2JnmPOT2yQLMV6C8LRJfPT1sEhz
         LKziO74iAT9/Mqz0687rqwVp1psMt8GD6XcxgcWrzRq+34qylSzgqODqCoazBNdLV0ou
         bIIt5Nm3pj/iyciwjvzAOePI/sSWDdm9L1RZu1ci6pfgbEAdHL+cs2gZWh920reNehgh
         W1WQ==
X-Gm-Message-State: AOAM532B+usaOvRecWU0G/ni/1ydY+7DhZxH42keL+TXaovubKJwHdlH
        WBgiqYuOKcKTIRv96bXfi7jfxrV+6S/WqU7dHwifAb9aqI+1QV6/6kULINNQERBY7AKSVUzio2c
        VFDyxi3bRGDUyJllvQx6mmGog
X-Received: by 2002:a05:600c:1e86:: with SMTP id be6mr445590wmb.79.1644314737450;
        Tue, 08 Feb 2022 02:05:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzAOv0fEw2XktAsGBPhVL/P5zLic2ZMR945PIWQg7DEmQ6lTgu0tbw2/EsqIOqwYvk9kRdMQ==
X-Received: by 2002:a05:600c:1e86:: with SMTP id be6mr445563wmb.79.1644314737240;
        Tue, 08 Feb 2022 02:05:37 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id y10sm1556985wmi.47.2022.02.08.02.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 02:05:36 -0800 (PST)
Date:   Tue, 8 Feb 2022 10:05:36 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Michal Suchanek <msuchanek@suse.de>,
        "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "void@manifault.com" <void@manifault.com>,
        "joe@perches.com" <joe@perches.com>
Subject: Re: [RFC PATCH v4 00/13] module: core code clean up
Message-ID: <20220208100536.dvxl5nccp4tygimw@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220130213214.1042497-1-atomlin@redhat.com>
 <Yfsf2SGELhQ71Ovo@bombadil.infradead.org>
 <1ae3a950-8c1e-a212-e557-8f112a16457d@csgroup.eu>
 <20220207164659.ap42at2nphxu4q6o@ava.usersys.com>
 <b0a54f00-b9ac-df55-e8d2-d3eb95039a95@csgroup.eu>
 <20220207180148.bbstggd4yr5ozfrf@ava.usersys.com>
 <MRZP264MB2988F32D78CC49C4C9E486CBED2D9@MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MRZP264MB2988F32D78CC49C4C9E486CBED2D9@MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue 2022-02-08 07:50 +0000, Christophe Leroy wrote:
> As we know the code will be back in main.c at the end, I looks easier to
> me to not move it at all by not applying your patch 5.

Looking at your proposed solution once again, I do agree now.


Kind regards,

-- 
Aaron Tomlin

