Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770E8C433EF
	for <linux-modules@archiver.kernel.org>; Mon, 21 Mar 2022 13:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345032AbiCUNlO (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 21 Mar 2022 09:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347880AbiCUNlN (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 21 Mar 2022 09:41:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D61D17056
        for <linux-modules@vger.kernel.org>; Mon, 21 Mar 2022 06:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647869987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q9Yz/N5m2IUmgkpbDZQCDFxoF6QbXF0nHMv1RhuJ7EQ=;
        b=eeWVu80VWZv3+Q0wAQkXSxaVLJHc4ZwLF+O2dKYAMiGydbx1wmYw/HkdDq8VM0xeB0EgCi
        jPA2H7SXkQvGbsRqn2NDx4QfGa2fpfnU+a+iTR/q/zlxfOUaMWoVhE6mUEtg2zrkXkq096
        28tbjuJmvFsQxkqk/OtDDQ2Mn4H6VCY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-LDaS05kaOyaRWnQsZnFRmw-1; Mon, 21 Mar 2022 09:39:46 -0400
X-MC-Unique: LDaS05kaOyaRWnQsZnFRmw-1
Received: by mail-wr1-f69.google.com with SMTP id z1-20020adfec81000000b001f1f7e7ec99so3100379wrn.17
        for <linux-modules@vger.kernel.org>; Mon, 21 Mar 2022 06:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q9Yz/N5m2IUmgkpbDZQCDFxoF6QbXF0nHMv1RhuJ7EQ=;
        b=36+wzW2SH96jnz03eN8skUk1FIUFrHaFWmhC+v2FnFOfS3er58Ul/2gwyfPfo1D6m5
         3+NwWgbipRMaO0FPEu6o3j5WZHP9gugWJHObre1GQyGBT8hC9xreFraaB10mFL6W4WfW
         kL39eGeLCko1+zoOjI1Mqs+IKjfca+xHcn1qqk6thrN+TcgjoG23CXMamf0sFgOQpHkM
         Mm3Pj0NMUsf3PDOFfMQpHuLjD5RA07nVdvPLdvJJnkCY9i04t6Hf8txLIx8UTWEPLMKb
         iHq4Na+nKDOvIRDvEm+pLuAUZM1slsFrTbb6t2Xrh0C9hwgmQs21hIG+2WkUcr5E8+I/
         BnKg==
X-Gm-Message-State: AOAM5324UorCVqlHCgGA8iSXPWmMquVp9PwrvjZzjSRsx7HJEn3z4/jM
        0cPBRL0Jaf3KZ8UtDh+u7slUynsNFIwDFB5AZxENG/7ZzpQzNKAWgH3P9mtt3xIKv3BgiGk2QAJ
        L4NEDIfOwC0zYBa3GBYHyiETl
X-Received: by 2002:a05:600c:a08:b0:38c:93c8:36e9 with SMTP id z8-20020a05600c0a0800b0038c93c836e9mr10899980wmp.97.1647869984820;
        Mon, 21 Mar 2022 06:39:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVkVUoJJOUY7M9Nab0zaNGhzmb3ekBQCRL1ZNysNrFMu8ck2yxo2AYSL4QPYibzYPewRYeog==
X-Received: by 2002:a05:600c:a08:b0:38c:93c8:36e9 with SMTP id z8-20020a05600c0a0800b0038c93c836e9mr10899960wmp.97.1647869984636;
        Mon, 21 Mar 2022 06:39:44 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b0038c6ec42c38sm13575059wmq.6.2022.03.21.06.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 06:39:43 -0700 (PDT)
Date:   Mon, 21 Mar 2022 13:39:42 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        Maninder Singh <maninder1.s@samsung.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "v.narang@samsung.com" <v.narang@samsung.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "avimalin@gmail.com" <avimalin@gmail.com>
Subject: Re: [PATCH v3] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Message-ID: <20220321133942.pbv7vvkn5r62ky5x@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <CGME20220315155109epcas5p249963f50d68ee368edb569b1a9e7d63c@epcas5p2.samsung.com>
 <20220315155100.516107-1-maninder1.s@samsung.com>
 <YjDScHjMUbqYV4s4@bombadil.infradead.org>
 <62c74547-deb0-539a-c1cc-64b2ac334c94@csgroup.eu>
 <YjGe961XL8GW7Qeh@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YjGe961XL8GW7Qeh@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed 2022-03-16 01:25 -0700, Luis Chamberlain wrote:
> I know this has been quite a bit of churn, but given Aaron's series I
> really hope we're goint to be in a better place for maintenance for
> modules long term.
> 
> I guess I gotta go automate tests to these things somehow too.

Hi Luis,

I can send a v12 now if you'd like?


Kind regards,

-- 
Aaron Tomlin

