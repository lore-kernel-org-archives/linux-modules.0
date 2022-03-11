Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA31C433F5
	for <linux-modules@archiver.kernel.org>; Fri, 11 Mar 2022 16:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbiCKQDu (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350248AbiCKQDE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 11 Mar 2022 11:03:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 067F91CE984
        for <linux-modules@vger.kernel.org>; Fri, 11 Mar 2022 08:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647014517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rzupkkLJorsxLrR+OX5BVyDV3vQCDlEKQHwxOJHubCQ=;
        b=dIpFZphqOUrcy3vRpe0kU2J3kBTuw+stciQYZ60nKAITFMUhPwqNwKhXUmYdpN50aLMvmV
        oFr40t2BjXxwDI7kH52RYt5amu0poR/qJAoSMuASn50MFCmNAYSiCTMPyusDHNG2498c2u
        ne+++OyXLRnSK6wpyLREjk3Ji2Tk/2s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-M_n-FtoNOvefKkWvlA5eCQ-1; Fri, 11 Mar 2022 11:01:56 -0500
X-MC-Unique: M_n-FtoNOvefKkWvlA5eCQ-1
Received: by mail-wr1-f70.google.com with SMTP id y13-20020adfee0d000000b001f1fa450a3dso2982808wrn.11
        for <linux-modules@vger.kernel.org>; Fri, 11 Mar 2022 08:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rzupkkLJorsxLrR+OX5BVyDV3vQCDlEKQHwxOJHubCQ=;
        b=0K/zk/8CpHKk5+3R/CMYmpSMxdgu1sR7Nvbo56ta5/HyBE5lBs1ZdjU28CsLn9cJG7
         mfpSf6h0JvwDND6G5MBU98uqueeIeT//sRmddK2YvjqnsayUyo0wK+uNYM9eP7bDyTQm
         Ki3T2a18AI2uyRPArh9i6KXcAUFQpzhGqOKh/Nmh+cZQCD83NO/UiXi9OYxpzd6Nz6Ot
         V26/SC3HPyPDG8eOpbIXhmOLbv1fesL3plArPhRNKJpiXpKKSkB9cJKF67xCgDnCVV3N
         RtON0vsKC98FR0A3bgzPhrcnGz32J4Wt5jCBgJJUcCBm+CZxpFbkRD4Eo37ue/bPq6zf
         XMtA==
X-Gm-Message-State: AOAM532jBh55PJ8RJVOHen1nOx2beudAuJl0VA6ZJW3Ut7lM8x6Uay7O
        tPsdOBiIXbQ5xW8ddXlHkXycz4MUfDB5X0Knojip7TzNc/ihSgeA957CJ9r1qFVIKiP0Foc2ttd
        g/smzU5wFN1SKv+qI5eMK7x6J
X-Received: by 2002:a5d:684b:0:b0:1f1:fc5d:d91c with SMTP id o11-20020a5d684b000000b001f1fc5dd91cmr7821701wrw.266.1647014514850;
        Fri, 11 Mar 2022 08:01:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuysRnBXAFiroTtcVLgk2nMYmL7tDhq1rUhjyinUARX5WWN8WwymIFesIXi0FesbUeSQhPGg==
X-Received: by 2002:a5d:684b:0:b0:1f1:fc5d:d91c with SMTP id o11-20020a5d684b000000b001f1fc5dd91cmr7821672wrw.266.1647014514642;
        Fri, 11 Mar 2022 08:01:54 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id x2-20020adff0c2000000b001f1fa284a32sm6996838wro.115.2022.03.11.08.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:01:53 -0800 (PST)
Date:   Fri, 11 Mar 2022 16:01:53 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, christophe.leroy@csgroup.eu,
        hch@infradead.org, cl@linux.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com
Subject: Re: [PATCH] kdb: Remove redundant module related references
Message-ID: <20220311160153.3k2avq24mpjyrdpy@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220307174741.2889588-1-atomlin@redhat.com>
 <20220308105203.2981099-1-atomlin@redhat.com>
 <20220309120640.uumh46n2l37jaddf@maple.lan>
 <YiporeSIrkFg/YS8@bombadil.infradead.org>
 <20220311154723.ezo3wvgg4puu2zk7@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220311154723.ezo3wvgg4puu2zk7@maple.lan>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri 2022-03-11 15:47 +0000, Daniel Thompson wrote:
> On the whole it doesn't really matter much... but landing the
> independent parts via the normal route for kgdb code reduces what I
> have to remember acking.

Hi Daniel,

Any thoughts on this [1]? Unfortunately, the wrong In-Reply-To was
specified. So sorry about that. I will send another iteration of the series
so that it'll be easier for Luis to apply to mcgrof/modules-testing or
mcgrof/modules-next but after we have more feedback.

[1]: https://lore.kernel.org/lkml/20220310102625.3441888-2-atomlin@redhat.com/


Kind regards,

-- 
Aaron Tomlin

