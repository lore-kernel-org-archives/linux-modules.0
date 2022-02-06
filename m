Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1500C433F5
	for <linux-modules@archiver.kernel.org>; Sun,  6 Feb 2022 14:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242976AbiBFOm3 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 6 Feb 2022 09:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238787AbiBFOmW (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 6 Feb 2022 09:42:22 -0500
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 06:42:07 PST
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CECEC06173B
        for <linux-modules@vger.kernel.org>; Sun,  6 Feb 2022 06:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644158526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3xo75bD0PDOaBPfVsPyq+FCl95QCjNPeMKREfcTC2z4=;
        b=R+ERPZcigu1+ComU8sH+0RQoWK6MQGWsq9/uM4EkiiUGw6O5vLd1qiqQe1xC5BITQ3flnt
        k5GWj4HjXu43GQTXiAUNpGA81ykJtVcak2Bi2EKA+/2gPjEK6CnTGQ+AqpY3tO8ZqVouHK
        xI+7ZM+xmNW+yASgfbOMTQrz8DYVuYU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-uXdInh9jOEiSuhb5Wh7K2g-1; Sun, 06 Feb 2022 09:41:00 -0500
X-MC-Unique: uXdInh9jOEiSuhb5Wh7K2g-1
Received: by mail-wm1-f70.google.com with SMTP id 130-20020a1c0288000000b0037bc5cbd027so434446wmc.8
        for <linux-modules@vger.kernel.org>; Sun, 06 Feb 2022 06:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3xo75bD0PDOaBPfVsPyq+FCl95QCjNPeMKREfcTC2z4=;
        b=OD64waw5m4PgeaKn2uF8S3E32yJLKm6lndwep2HhcvmR1HtQOVy352xMHQdHR7/A3S
         wi8duBji7QxIc/XuvLV1XAi24+cLiDGnKMCBaGLceNFCfn34jyqJXzMsh5U96Mg6plac
         +BD1Ep0gy566KjjBdwv3gKRiU5M+eE5Ig48k4mUJBJRoXHKj8qYJeAvUFIgmh3apJ+mL
         dK5TPAyaww00b9YxsOYsdpX2p7NXZmBh5wv1wPm8k5UetH4u7h3v8oyvuPk0KJT4+98d
         9+87U9FsILMGUbFTQHRA4Q9QFjW5tVx9slJc5+xsWNumfbpX342ly76KvZAJkyP5bA+q
         Pp3Q==
X-Gm-Message-State: AOAM5311N/QBOESvrS7Yb1ViPTRXAt2lHdX0G7NR8RL1QTIo38AcBudU
        pdDEnYu8FredG5iIcTBE7XIKlURDsrnyJwk/DOci6Qm2aQMApcrHFBU4MLwuLbu+/Xv+KnTgrtN
        0wIYecIAMPxQekRHzzbH26ywY
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr7307807wmc.183.1644158459546;
        Sun, 06 Feb 2022 06:40:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzm/kRptajKDTAh89yC1ciHnNdlI1yp9Czrsc5eMbNPyYfBFvivYGaNPSqesEaBuIRdpJvwwA==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr7307795wmc.183.1644158459401;
        Sun, 06 Feb 2022 06:40:59 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p15sm834616wma.27.2022.02.06.06.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 06:40:58 -0800 (PST)
Date:   Sun, 6 Feb 2022 14:40:57 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, void@manifault.com,
        joe@perches.com
Subject: Re: [RFC PATCH v4 00/13] module: core code clean up
Message-ID: <20220206144057.sp4ldrxq2eqp5g4k@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220130213214.1042497-1-atomlin@redhat.com>
 <YfnwB0GkXln4KaGk@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YfnwB0GkXln4KaGk@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue 2022-02-01 18:44 -0800, Luis Chamberlain wrote:
> Nice, can you get this tested with 0day? You can ask for your tree to
> be tested, see:
> 
> https://01.org/lkp/documentation/0-day-test-service
> 
> See the question, "Which git tree and which mailing list will be tested?
> How can I opt-in or opt-out from it?"

Thanks for this information Luis.



Kind regards,

-- 
Aaron Tomlin

