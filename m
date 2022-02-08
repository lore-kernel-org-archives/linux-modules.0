Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C31C433EF
	for <linux-modules@archiver.kernel.org>; Tue,  8 Feb 2022 15:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbiBHPS7 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 8 Feb 2022 10:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353210AbiBHPS7 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 8 Feb 2022 10:18:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EE0AC06157A
        for <linux-modules@vger.kernel.org>; Tue,  8 Feb 2022 07:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644333537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g1dLWDlmAylsVAbFh6dRuuTZBM7U6UZUvU1LhCTc2yU=;
        b=flUpgXq44x+f0mO57dp4hx5VDlip8gCZc7xvHd9CWpfA7WktHMqBxJZWMX4JfRx/SUYF6R
        UFax4CY7E1Fyd/bYHsjjn75ZcwvjR3eL8IOf+7moQnfZjlZEbKbXPEC6lZYQ7myVV+x+Y8
        rN9fEfqoqPKXwdC3N+rp6YiujSBl4fs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-FR2OKvSkPd-pnttcGkSflQ-1; Tue, 08 Feb 2022 10:18:56 -0500
X-MC-Unique: FR2OKvSkPd-pnttcGkSflQ-1
Received: by mail-wr1-f72.google.com with SMTP id v9-20020adfa1c9000000b001e33e5dbd5fso553284wrv.17
        for <linux-modules@vger.kernel.org>; Tue, 08 Feb 2022 07:18:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g1dLWDlmAylsVAbFh6dRuuTZBM7U6UZUvU1LhCTc2yU=;
        b=ldx2mkN3xqnMgy82+tDhlrbXPNAZHcMkOOiDxZyZha2Mdz9gdorWiyoaERKUzWYB9z
         pVf1mCYmB+JdT0lDl/T8fxu5BQr0ronTkR/3+y7QoUiNYSZK1KmrC5qHnOgVWww74xHI
         xbnMisFFtMGbcMavcVcI6YyoJw9q6GDU+wGS0q77MbW39ryY8w8IZYuU4OeQ2pebewj8
         fgJuvR8Sab5tQXMQQWOdKFvNERolK7TecVJLf2fCZZd1nuttQ1/jdugDzNwWrfAYJPBO
         FTnVwT6WVZU1xcWqR1Phm4e9Stw5pkUiaB6jdJ92zqFFjqy7p4Yxw1M/Dkw+Cet6iId8
         /USg==
X-Gm-Message-State: AOAM530wg9yHK9otdL90/jQGHWNEY0WXGOEseouQbIE7g1HjVFUcrDVH
        mZN0db/CQH8J35YdR+tTKCAnDGkEmyJaD3ah5078YgtR4eGxTQ/0ASTksJudEmankQTp5lxwS75
        c0manQVyipdiVyPtGcOFkshPj
X-Received: by 2002:a05:600c:3846:: with SMTP id s6mr1562118wmr.26.1644333535417;
        Tue, 08 Feb 2022 07:18:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxlF2zSt7RYRFVBT770zFzAYkbM60g4+C9WVjw78vwP9vz+XHesCTBfEzpGpKZYFpy9H8xlRg==
X-Received: by 2002:a05:600c:3846:: with SMTP id s6mr1562097wmr.26.1644333535246;
        Tue, 08 Feb 2022 07:18:55 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f13sm2630160wmq.29.2022.02.08.07.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 07:18:54 -0800 (PST)
Date:   Tue, 8 Feb 2022 15:18:53 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     mcgrof@kernel.org, cl@linux.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, void@manifault.com,
        joe@perches.com
Subject: Re: [RFC PATCH v4 03/13] module: Move livepatch support to a
 separate file
Message-ID: <20220208151853.avy4e7sgyutuempk@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220130213214.1042497-1-atomlin@redhat.com>
 <20220130213214.1042497-4-atomlin@redhat.com>
 <YgJXEhiwn5B4Psxa@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgJXEhiwn5B4Psxa@alley>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue 2022-02-08 12:42 +0100, Petr Mladek wrote:
> This should go to internal.h.
> 
> Alternative is to move both is_livepatch_module() and
> set_livepatch_module() into include/linux/livepatch.h.
> 
> I do not have strong opinion.

Hi Petr,

Firstly, thank you for your feedback.

In my opinion, I believe is_livepatch_module() should remain as it may
continue to be used externally i.e., outside of kernel/module/; albeit,
indeed set_livepatch_module() should be moved to kernel/module/internal.h
given its use is exclusive to core code.


Kind regards,

-- 
Aaron Tomlin

