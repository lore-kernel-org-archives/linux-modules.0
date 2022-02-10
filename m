Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805C4C433FE
	for <linux-modules@archiver.kernel.org>; Thu, 10 Feb 2022 17:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245157AbiBJRXE (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 10 Feb 2022 12:23:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245151AbiBJRXD (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 10 Feb 2022 12:23:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFD7C192
        for <linux-modules@vger.kernel.org>; Thu, 10 Feb 2022 09:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644513783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ynVF8sk+blUB4Pf3mmCXTcuxk0sjOGV7wHhHJzKIAWU=;
        b=GNE7y1EQ+nH2YPdaaufxVDoDlWMKJ3bdfIAemeZChwj2W2FOkYgwVN+TbptXG6gwgkCiDY
        7TA6Ob/ir7XQIXfVFvJ1a9RH4pEosWrirj5dk8qs3gnxGTVZjZhsExT1GDlkMKxlLB8+Fc
        jtEnHkwjeM0teCm2kZzpSMOwu7zU58Y=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-R1i6gxiOP-CGPsG9KUrh5Q-1; Thu, 10 Feb 2022 12:23:02 -0500
X-MC-Unique: R1i6gxiOP-CGPsG9KUrh5Q-1
Received: by mail-lj1-f198.google.com with SMTP id u4-20020a2e8544000000b0023aeea9107dso2859566ljj.21
        for <linux-modules@vger.kernel.org>; Thu, 10 Feb 2022 09:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynVF8sk+blUB4Pf3mmCXTcuxk0sjOGV7wHhHJzKIAWU=;
        b=U6zq6W9+TOn8Di4IjkJj7EWA2o/Hzom2vtdcyTdoo9gcl9+3CxZbXlvVyw3G5lOhGE
         E5sO9hAu7CR84hg8gknSQ0obYWvVuWD7JsIF+kA3Z3szqxevOL2r48zCGZNOl7GM3lze
         T38Mu1hwmbavzOyd9Sj7XseG3g7D1EV3xN4Da8DLvuMJXKFw95zW0WaG/0T5bEegR61y
         /wGUC9Bjc6SD9QIgNFGnB0imWypMxvQHR0VnTNXkz87LgGRDPR8Nxnnnr8NuVK8r7wOf
         6wwvMf+xbVahtrCRkzxMQFY9cHcZIGmwKFsIdMjgxiiOR2WWib4diw2SL4Ul8ZbKn6NC
         roBQ==
X-Gm-Message-State: AOAM531zkItXSRR/x0oOyVIFwzFC5VozwvOdsrOjbbJ+kwnKfSHup7VB
        8n+Hc+C55/H9FvZ/WpMX53oWTokBNYTY2JvbMq5XXDKGXdSv6kVIK4p8vU8g+ilTjNmrAoqOADd
        XGKg/oQN5OvBEvhmN5CwMzldZ6y7ajarMZRR82WvH
X-Received: by 2002:ac2:4f03:: with SMTP id k3mr5947160lfr.163.1644513781187;
        Thu, 10 Feb 2022 09:23:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPurdZCWhcjjdeAf5612b8cWLNqPESaOHdxPEE20Dxz4GIR53J+a3BP/HcMeMBWYo4B10uWd7TQRzczUyBK0U=
X-Received: by 2002:ac2:4f03:: with SMTP id k3mr5947139lfr.163.1644513781032;
 Thu, 10 Feb 2022 09:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20220209170358.3266629-1-atomlin@redhat.com> <20220209170358.3266629-2-atomlin@redhat.com>
 <a22eb1b0-3fb5-a70e-cf6f-022571538efb@csgroup.eu> <CANfR36jh3yg9nqXkpCUWPeHV+sSD6yne9j1=uA5vyUpYOC8t9g@mail.gmail.com>
 <926e5c35d50ec5f6d7e789831be96744ca8d6423.camel@perches.com>
In-Reply-To: <926e5c35d50ec5f6d7e789831be96744ca8d6423.camel@perches.com>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Thu, 10 Feb 2022 17:22:50 +0000
Message-ID: <CANfR36gxWAPHN+ruFifaJ+j2Nppw+Xocd4iyWYzw0LFD=WxUTg@mail.gmail.com>
Subject: Re: [PATCH v5 01/13] module: Move all into module/
To:     Joe Perches <joe@perches.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
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
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu 2022-02-10 09:02 -0800, Joe Perches wrote:
> On Thu, 2022-02-10 at 14:45 +0000, Aaron Tomlin wrote:
> Better would be:
>
> F:    kernel/module/
>
> in case it ever gets subdirectories too.

Agreed.

-- 
Aaron Tomlin

