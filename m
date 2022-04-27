Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654B4C433EF
	for <linux-modules@archiver.kernel.org>; Wed, 27 Apr 2022 09:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiD0JNG (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 27 Apr 2022 05:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbiD0JNE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 27 Apr 2022 05:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77940CFB81
        for <linux-modules@vger.kernel.org>; Wed, 27 Apr 2022 02:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651050444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VlP3askR5SLt3D/mCVopQREcxnxlzFTELhmls5ml/4o=;
        b=cEBeAVxtrpzlaoAdq40g/5/8Jv9uM3NNPf7WvlAHoMo7fqx58h76RIFpg8OcfneJNczTxr
        kzFd7u+PHgQ289qmsizBAMFCUhjEGQ+ValjjqpFYmieYyup9YZzTB654PlCpJiXr4E9h8/
        nh3CFRu4zaz5jjLL7jS8VaUIYl29NX8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-aHFbNqGcMn6yyixuLDbmYQ-1; Wed, 27 Apr 2022 05:07:22 -0400
X-MC-Unique: aHFbNqGcMn6yyixuLDbmYQ-1
Received: by mail-wm1-f71.google.com with SMTP id n37-20020a05600c502500b0038fdc1394c6so496554wmr.6
        for <linux-modules@vger.kernel.org>; Wed, 27 Apr 2022 02:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VlP3askR5SLt3D/mCVopQREcxnxlzFTELhmls5ml/4o=;
        b=JEfKXTr0Sf9yFLc6gaRXTBMOWPD7FTh1MPqF5gbFkSDLPG/gB72+QHRvlWVQcGgYQ+
         ywZXaFYiaPia8+XoFIHNep198BOSdctFpaORT2hJ2ZMARjFJZfFk//V3lNRtv/xzuNu/
         jvm3aFX/fd6/XIFxp+4Cv3Ae3Re6tdaWXgqOfXxtwGnW3gGwSE7hevYyVw44SY21YE50
         SvXKzid1qTMB2kcgumguLeDV4FbDKzHBjnWOa/BmvxMqfC1AzzM/GX8aZdSMFjJ6hkD6
         c926SUFvqOtfyv1Uor4/28hbGJ3ldQUvvlje3vaUckDzgWZyaV2yL/W7xTMki9mctf4a
         98rA==
X-Gm-Message-State: AOAM530mP1HYxB6bX7cOFfw1QTp03c/MrHtUt7q0rAKquO54b5YW+VzK
        dcbJfWUrxG72Tj4jByfdKZKViGtd7/THYWrZkdU1B6baA2Ewgcy1DpE9+QXFg2bqxYOCmr2t71D
        wM2ksNbSU3oRyfLzz5yEQ2PcT
X-Received: by 2002:a5d:6102:0:b0:20a:db89:724f with SMTP id v2-20020a5d6102000000b0020adb89724fmr11259451wrt.59.1651050441685;
        Wed, 27 Apr 2022 02:07:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS6PdfRBkjuFq+2OuKCjksKEbdx1UuoLoYLoAqcMXQdqjUwnhJzSb/Jr7tt/piyg/czfgP9w==
X-Received: by 2002:a5d:6102:0:b0:20a:db89:724f with SMTP id v2-20020a5d6102000000b0020adb89724fmr11259419wrt.59.1651050441433;
        Wed, 27 Apr 2022 02:07:21 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm1302186wrd.32.2022.04.27.02.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 02:07:20 -0700 (PDT)
Date:   Wed, 27 Apr 2022 10:07:19 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     k@ava.usersys.com, cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, oleksandr@natalenko.name,
        neelx@redhat.com
Subject: Re: [PATCH v4 0/2] module: Introduce module unload taint tracking
Message-ID: <20220427090719.qbtjwvde4wwzmruh@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220425090841.3958494-1-atomlin@redhat.com>
 <YmcvZQSiu95MUvxI@bombadil.infradead.org>
 <20220426083930.hltsfxoe6ax6dspj@ava.usersys.com>
 <YmgcXSXTM80/3R8b@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmgcXSXTM80/3R8b@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue 2022-04-26 09:22 -0700, Luis Chamberlain wrote:
> I'd rather see the effort than not, given all the effort to already split things.
> I think it keeps things pretty tidy and it can scale / and its easier to review.

Fair enough. I'll create another iteration of the series.

-- 
Aaron Tomlin

