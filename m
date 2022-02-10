Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78113C433F5
	for <linux-modules@archiver.kernel.org>; Thu, 10 Feb 2022 16:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244177AbiBJQ0o (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 10 Feb 2022 11:26:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244190AbiBJQ0n (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 10 Feb 2022 11:26:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E4A0C4C
        for <linux-modules@vger.kernel.org>; Thu, 10 Feb 2022 08:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644510402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rY3phGFyqzvqC5XqBvgZRHwWvJirMd+irMKZuvfo6EI=;
        b=RRtfBSydLtl+XiDxn7Gqj+KNvu6c2XQ2YOwk3yUCdljhWbb8s1h/UmC9i4EqFvMouH7dm0
        SS1acdBF5alzNbhoF7j3BsUe7RgslNpQAgRKMCJqqhZuxAOh72qBTbSXaLRiLIKoIB63/K
        SOv9rZo2KQs6LkBN70iXOuPe9LHNUyE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-bC-3wos1NfS8mbZz_6Ojrg-1; Thu, 10 Feb 2022 11:26:39 -0500
X-MC-Unique: bC-3wos1NfS8mbZz_6Ojrg-1
Received: by mail-lj1-f198.google.com with SMTP id y19-20020a2e9793000000b0023f158d6cc0so2797107lji.10
        for <linux-modules@vger.kernel.org>; Thu, 10 Feb 2022 08:26:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rY3phGFyqzvqC5XqBvgZRHwWvJirMd+irMKZuvfo6EI=;
        b=NegLvd8qLEkUhDKf48YopYGMq4AcEAi9x1exvSkXhxyoI6eLgh08n4eoLUABUAkBuY
         PQbhLNenI03ZcOHcFLW5UPAjiV1gHS8zF+GHx2TljSCzMLVoQeG0DA1VuzKZ02WHrx/h
         RSyzQ4z/PWXmrnZ4JMKJA513OpkNg/NypfTOqEu80uIHOydm77Zuj/Cc6VB9tHeOMw6x
         34+1U45H17/0tlnw6zjB2WSjFbjsj+P3yDKm1hCjMl6or91mEjR9u8fs97O5hYEjgILp
         6EiyWg5ITcU9+cvizlGfseEuE0y57Etd3Qb3QdDoFviyKXZxMshP6pPtPd8UTdFuzuOo
         ds9w==
X-Gm-Message-State: AOAM5323pFs4QoHnnEbD9nB7KI+kOQ+f5JtrHC9PoKZnG2iUwmC12kZx
        GWYUuneGQLtjjbSQzytMkAkqZUGxB8A49c/PJ9WJvA8F0lB5P35bq/4ttjCXSUu8RJ3jQOBuAom
        dByzbpWC6X+Gme8LaNDA3+cMbJJt+3fnI6A6A4dX3
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr5338838ljj.85.1644510397651;
        Thu, 10 Feb 2022 08:26:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9JIlgHvIwzA75M+U5BYw5VLOvJhfEKK89UxctqRfc/hcGRqbB7269Gq1HJ/earlGgnR33FLSJpEfMa8PkcNk=
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr5338822ljj.85.1644510397492;
 Thu, 10 Feb 2022 08:26:37 -0800 (PST)
MIME-Version: 1.0
References: <20220209170358.3266629-1-atomlin@redhat.com> <20220209170358.3266629-3-atomlin@redhat.com>
 <f40fd2b2-2038-a53b-23ec-8f63941a2103@csgroup.eu>
In-Reply-To: <f40fd2b2-2038-a53b-23ec-8f63941a2103@csgroup.eu>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Thu, 10 Feb 2022 16:26:26 +0000
Message-ID: <CANfR36jWjL9c1p8huGR8mh=XWXoNEc=Y8SmwXFCusEQ6CbuKmA@mail.gmail.com>
Subject: Re: [PATCH v5 02/13] module: Simple refactor in preparation for split
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
        "void@manifault.com" <void@manifault.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu 2022-02-10 11:18 +0000, Christophe Leroy wrote:
> > +#define MODULE_SECT_READ_SIZE (3 /* "0x", "\n" */ + (BITS_PER_LONG / 4))
>
> This is used only in sysfs.c, why move it to internal.h ?

Agreed. Since use is exclusive to kernel/module/sysfs.c it should be moved.

Kind regards,

-- 
Aaron Tomlin

