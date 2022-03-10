Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A6CC433EF
	for <linux-modules@archiver.kernel.org>; Thu, 10 Mar 2022 10:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbiCJKb6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 10 Mar 2022 05:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238858AbiCJKb5 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 10 Mar 2022 05:31:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E725213DE32
        for <linux-modules@vger.kernel.org>; Thu, 10 Mar 2022 02:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646908256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=StOK/wtVvoGK+JwIiQv3+3Ca437x9eZB8wXtv30yF44=;
        b=X3yAMWTRyKDMer1QwozBCA5hu11QlnEqjZzwm87s0612jrQNoRcnGtNl9gSt97pHPo8vVw
        b+TsgR481jF9D6O/CTmEWWgL9mtll8Uc7hJJezx2gu8PAF/Vc6n7LbxflW6h4fduS/bLXl
        eqv/wwUPmgohC4EEcWAmF/u+xyxQrv8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-bAKIjJspP4GEBjBOa2oJgw-1; Thu, 10 Mar 2022 05:30:55 -0500
X-MC-Unique: bAKIjJspP4GEBjBOa2oJgw-1
Received: by mail-wm1-f69.google.com with SMTP id 20-20020a05600c231400b00389886f6b23so2110465wmo.6
        for <linux-modules@vger.kernel.org>; Thu, 10 Mar 2022 02:30:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=StOK/wtVvoGK+JwIiQv3+3Ca437x9eZB8wXtv30yF44=;
        b=sAZ+cpkZR9HPsupSPKGa7tK9Eh9GG2h41H/rc+C7VAee8tZ46aTpVBb1QWAMEALMag
         75+E8cBAv9eKZNOMKEFL1mrvuiSGVbmN20MXvAaAAg/4iDcBRF1cNnXqABzUpb509F/7
         VMBIqO50mW9azKYm3TsssFvL7P+jaGS7h5TejL/xKLelmogVvOIzbM4fz98tqIDbYVcT
         dshPfN/yWua6CUBTgoteoaCG/jh66ip8ddg/jYRu/kXj2Sw3G67GR049680lZHj/gIFs
         mQlhdFX9Kjs36jqNin0KS+wA2+ZMGc5Q63//Jn1uGITWZ5F/gcYJHXn5il9RAGeNZhJl
         Z08g==
X-Gm-Message-State: AOAM5315Malr+jqxZdDBs5yrMY/lcqMCpZsoRV3DRcSjRxpnfChdcS8P
        nd0r3DkOmq9bQFlqEBArMAjSSfe4EIq+ZMFsuPu0giDmpSshACbybEKY6X7BBxbajb4orQ0MMb4
        3EF1aXAm9ow9228BNS1L8ppLX
X-Received: by 2002:a5d:634a:0:b0:1f0:4a80:3254 with SMTP id b10-20020a5d634a000000b001f04a803254mr2944339wrw.255.1646908252085;
        Thu, 10 Mar 2022 02:30:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDsRdi/VCWAofn/QF02QNwgDC5hHfYU0czmIRIHiow2Rqdo0YIdN2KblyYXozR6fDHiWM08g==
X-Received: by 2002:a5d:634a:0:b0:1f0:4a80:3254 with SMTP id b10-20020a5d634a000000b001f04a803254mr2944322wrw.255.1646908251842;
        Thu, 10 Mar 2022 02:30:51 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d48cc000000b001e6114938a8sm3826638wrs.56.2022.03.10.02.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 02:30:51 -0800 (PST)
Date:   Thu, 10 Mar 2022 10:30:49 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH v11 13/14] module: Move kdb module related code out of
 main kdb code
Message-ID: <20220310103049.exabwlfe2z5lsiuv@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220310102413.3438665-1-atomlin@redhat.com>
 <20220310102625.3441888-1-atomlin@redhat.com>
 <20220310102625.3441888-2-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220310102625.3441888-2-atomlin@redhat.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu 2022-03-10 10:26 +0000, Aaron Tomlin wrote:
> No functional change.

Hi Luis,

Sorry about this divergence. This was an error via 'git send-email'.

Kind regards,

-- 
Aaron Tomlin

