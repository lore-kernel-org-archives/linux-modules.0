Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E139DC433EF
	for <linux-modules@archiver.kernel.org>; Mon, 21 Feb 2022 10:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353501AbiBUKRL (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 21 Feb 2022 05:17:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354646AbiBUKQe (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 21 Feb 2022 05:16:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2D772B19B
        for <linux-modules@vger.kernel.org>; Mon, 21 Feb 2022 01:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645436117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XZrTlvfXotnswsvjd0YUM1RHyK8H1Vt0nzlWoZF1MZ8=;
        b=Jpc6N6pQduzbigZ7mQbBny61HM+t4qxqu6QTMg+appmLOIA294AePnp2rwz3pEOSgbIzMN
        u3ORcrEqylLJSg0aW1ZZgS3k4DVIP6peIB1rrq9g5t1PjmG2kaFcaQe5BHGSOJxMLayGZ3
        /3hHLcAHXfBkmToLAly0OneMfgaeojc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-51MFrOPFMNaK-lxzMp-l0Q-1; Mon, 21 Feb 2022 04:35:16 -0500
X-MC-Unique: 51MFrOPFMNaK-lxzMp-l0Q-1
Received: by mail-lj1-f199.google.com with SMTP id q21-20020a2eb4b5000000b002463ddac45bso1412366ljm.19
        for <linux-modules@vger.kernel.org>; Mon, 21 Feb 2022 01:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZrTlvfXotnswsvjd0YUM1RHyK8H1Vt0nzlWoZF1MZ8=;
        b=sW/CaWaNUrEhUGMn17Ra71PVwBqeIsDQzNxz2jK4YeuTfbVz6sPe/wQ3x8QODNj0Ic
         of8t6Isq2b9xkbBECK5vva2azmimlnCFdc/3UFSd71O3BCp6SLP5gk25rxkg9icjuYSt
         xVot2Au3e7Pdg72F+BTirAdfLfAfT3kUOsLR2k4gJO8MAtpZ26jW+fVhz0GUsQ3OgH4C
         hR6otjChUL29HaQ1M/CNcqQkva2Be6GDYkOVJrQXBDN/Ogc3Ea5ApbrpjY06gx8dTfVA
         G8yI6Rftu5imsxu1FgwFBDdG/C2kQaTmb2LJbJXIFw/19UC6JiUOD4PcHEbm+8RfY8bA
         5cmw==
X-Gm-Message-State: AOAM5322RY255JY8PUbMMxcoSicKcMLw9vnfXjCTAjTQKcywjPstXNZi
        PVgCjBvBrWKCytUrQjSp8cNJytlSQ/YqDYojtXvD4urfcE5KVb45MxL5HZ/PzZ88Uuj/oJiYktk
        R+/6sGpN6l19wjNPwO1e6zU9wb0AsFhv4Y890wnDT
X-Received: by 2002:a05:6512:308b:b0:443:5f54:dcae with SMTP id z11-20020a056512308b00b004435f54dcaemr14171278lfd.79.1645436114862;
        Mon, 21 Feb 2022 01:35:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwdWTU1J1Wp/gQK1TNV+7EzlpZp9cTyOBUeVKlHJPSRNNZyZzwbpneTb+o1FHTpSs4OLUS8lczju7vAM4M784=
X-Received: by 2002:a05:6512:308b:b0:443:5f54:dcae with SMTP id
 z11-20020a056512308b00b004435f54dcaemr14171262lfd.79.1645436114662; Mon, 21
 Feb 2022 01:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20220218212511.887059-1-atomlin@redhat.com> <20220218212511.887059-7-atomlin@redhat.com>
 <0555ad08-365c-ae49-0f6b-973fd16866c9@csgroup.eu>
In-Reply-To: <0555ad08-365c-ae49-0f6b-973fd16866c9@csgroup.eu>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Mon, 21 Feb 2022 09:35:03 +0000
Message-ID: <CANfR36ja_NYoBFYOAO02a4LOp_wDzD=8NVqhCY0PEOXC3-dsvg@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] module: Move strict rwx support to a separate file
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
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
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon 2022-02-21 06:31 +0000, Christophe Leroy wrote:
>    CC      kernel/module/strict_rwx.o
> In file included from ./include/linux/build_bug.h:5,
>                   from ./include/linux/container_of.h:5,
>                   from ./include/linux/list.h:5,
>                   from ./include/linux/module.h:12,
>                   from kernel/module/strict_rwx.c:8:
> kernel/module/strict_rwx.c: In function 'frob_rodata':
> kernel/module/strict_rwx.c:16:17: error: implicit declaration of
> function 'PAGE_ALIGNED'; did you mean 'IS_ALIGNED'?
> [-Werror=implicit-function-declaration]
>     16 |         BUG_ON(!PAGE_ALIGNED(layout->base));
>        |                 ^~~~~~~~~~~~
> ./include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
>     78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>        |                                             ^
> kernel/module/strict_rwx.c:16:9: note: in expansion of macro 'BUG_ON'
>     16 |         BUG_ON(!PAGE_ALIGNED(layout->base));
>        |         ^~~~~~
> cc1: some warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:288 : kernel/module/strict_rwx.o]
> Erreur 1
>
>
>
> You have to include <linux/mm.h>

Christophe,

Strange, I have not seen this before. Locally, looking at
kernel/module/strict_rwx.i it is eventually included. Anyhow, you are
right. Also, it will not hurt due to the multiple-include optimisation
found in include/linux/mm.h.


Kind regards,

-- 
Aaron Tomlin

