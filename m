Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9365C433EF
	for <linux-modules@archiver.kernel.org>; Tue, 21 Dec 2021 11:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhLULon (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 21 Dec 2021 06:44:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229635AbhLULom (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 21 Dec 2021 06:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640087082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wbwxDN6wj5FeFXwr7pjnR/9gTyWUAmPUku3aTqaGEOY=;
        b=X2TP4WtkKa239W7YhyP5LLaheIUVb7TCj3K4Abci7pKIN/wmlBmHP/mjozmh9BIpOpidAC
        Zy1fTvX3ZXizMjO1wPMOzcibVbKAxg3rNd6rzs3RIxYohAQk4fYOBQugHzboXL+7gwLtLv
        tEZJNFbcGag5WfV7o8jCKTRb5f0BxtA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-FBUMMwB5NdKZoH_AC_Elyw-1; Tue, 21 Dec 2021 06:44:41 -0500
X-MC-Unique: FBUMMwB5NdKZoH_AC_Elyw-1
Received: by mail-wm1-f70.google.com with SMTP id f202-20020a1c1fd3000000b00344f1cae317so672788wmf.0
        for <linux-modules@vger.kernel.org>; Tue, 21 Dec 2021 03:44:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wbwxDN6wj5FeFXwr7pjnR/9gTyWUAmPUku3aTqaGEOY=;
        b=D9E+DqR5aiX+nzLnZ537U+PXT1Qh7uCTIPxGhSXHDKaC8ojvs+OzUCr80AxpltX1xi
         KeFplqvQuc06uOfOEAKVPUdP1mfPQxZ17+DlgcEJSwENTFUl4Wb3jVW05qW+Ya0GYfCB
         qthbBGDej/OijisreGw7voiFnEchlp2wYErG0T87d0+Q2E+iTilhyRjrlxZ9rRU+JG6I
         hcGvjhZ5oXoG9Td9h1ap7Cew3yiX/93XILiwU0Lj6cp3ORuBtUcfAf4+8R0gQ0rWhMBh
         Cy8FP12j2Zn8VeDjdTXoz0JWGhwFeVnPuMu8Moi3IKmSnT7Z5UK8y66CoNZcxrCSyG33
         ry6A==
X-Gm-Message-State: AOAM530AXe0/2yp8TLKBEw4SuScHedRAqq0TpMyf1zCyA7S4Y1GTXjG2
        0Zm4NLiJwKu7vPmEQI8GoCDfaw03KrveuI2XfZheSviE4Vyo7zBvE+AuqVfKoIBomLLF5022tVb
        TTP1oZQpR/IBIPq8HllvziKqA
X-Received: by 2002:a05:6000:1688:: with SMTP id y8mr2226114wrd.682.1640087079994;
        Tue, 21 Dec 2021 03:44:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/jkUzjPboutyA7ZKw6bugiCMhEIJ/J5UCT3C0AchPv48wFvUEdKBJxeBkwaNlPk1TKH7zOg==
X-Received: by 2002:a05:6000:1688:: with SMTP id y8mr2226106wrd.682.1640087079786;
        Tue, 21 Dec 2021 03:44:39 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id n9sm2318886wmq.37.2021.12.21.03.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 03:44:39 -0800 (PST)
Date:   Tue, 21 Dec 2021 11:44:38 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Allen <allen.lkml@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, atomlin@atomlin.com
Subject: Re: [RFC PATCH] module: Introduce module unload taint tracking
Message-ID: <20211221114438.lbbnte2f7u6xi5ii@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20211124173327.3878177-1-atomlin@redhat.com>
 <YbEZ4HgSYQEPuRmS@bombadil.infradead.org>
 <20211209153131.a54fdfbci4qnyy6h@ava.usersys.com>
 <CAOMdWSKzH2uzD6XDN21x_R7_iThBko75s9tHTTMKxbG2pdFYMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOMdWSKzH2uzD6XDN21x_R7_iThBko75s9tHTTMKxbG2pdFYMg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon 2021-12-13 18:30 +0530, Allen wrote:
> Aaron, Luis,

Hi Allen

> I have some ideas and did some work on it. Let me know if we could work
> together on this.

Yes, we can. What have you done so far?

Kind regards,

-- 
Aaron Tomlin

