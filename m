Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D193AC6FD18
	for <linux-modules@archiver.kernel.org>; Fri, 31 Mar 2023 03:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjCaDmT (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 30 Mar 2023 23:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCaDmS (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 30 Mar 2023 23:42:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC257CC3E
        for <linux-modules@vger.kernel.org>; Thu, 30 Mar 2023 20:42:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso7483488pjc.1
        for <linux-modules@vger.kernel.org>; Thu, 30 Mar 2023 20:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680234136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D2yoA6/ZMAiU5n58XnU5GRn99au0wJfFSmiuyy5JMiA=;
        b=l2BgSx22kuf8Hs3D7qJk6EE10cDBOjYG0ia03DbUz+keXgFSqQ0kOnwuvFo1mqJ7e8
         sr2sOplzSkPKNkE9f69WVC7cUXhYU+E/lJhlnq9gDVmZxBMPX8IDgw7cLxCFn7kC+pdl
         eP+vfO5qQh+5YySDiX2/XfMPhhzlNGGAVojJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680234136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2yoA6/ZMAiU5n58XnU5GRn99au0wJfFSmiuyy5JMiA=;
        b=2aJulsi/OheTCs5UMq/7szPgM60fBl1cQ4r1LLgQpSwnFm11H34BYuN+S3s0RPmWXS
         JACO8tMqAXrAadoTSWSoY5j5KnRXMQd7oObv1NK1I4RA9QbzAjUOENo5cuD9028pNXHI
         vfzfRee/GuPy/Q02hvhlnavfWny4JtVT4a4nlmuymYM74yYGDo1OIGPz/N8AS/aw4sXU
         ZDoFy3KClZHq1JJ4wum8JfdImwg73F1+IaUPdjirx8TqzbzjnhQnNLR5Ge43GudJAnnk
         ae2KsSqF7eXBQ/VpdBuy1rNVKDhtq/GD8P4+P59tGzqmDZtS6+1SmpqFaPgUJtQQkhG5
         2h1Q==
X-Gm-Message-State: AAQBX9fkTbj/1/TvIIlKsawiltXG5ZLSuXCqg8OIU2B1JtmJfBvJ3WNq
        3FkjTjQ+dY8lHWU+cp0rRsZfVw==
X-Google-Smtp-Source: AKy350YEadHnIPucAgMaeBL0HMKusS65/ZM2KAeXc/wd10yIBt72Hu/asTJYkl9H5ZaueGU8YrY2TA==
X-Received: by 2002:a17:903:230d:b0:1a1:9787:507d with SMTP id d13-20020a170903230d00b001a19787507dmr9866306plh.3.1680234136348;
        Thu, 30 Mar 2023 20:42:16 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902aa8900b001a1d7329235sm427500plr.234.2023.03.30.20.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 20:42:15 -0700 (PDT)
Date:   Fri, 31 Mar 2023 12:42:09 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>, david@redhat.com,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        petr.pavlu@suse.com, prarit@redhat.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        song@kernel.org, rppt@kernel.org, willy@infradead.org,
        vbabka@suse.cz, mhocko@suse.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH 4/7] sempahore: add a helper for a concurrency limiter
Message-ID: <20230331034209.GA12892@google.com>
References: <20230329053149.3976378-1-mcgrof@kernel.org>
 <20230329053149.3976378-5-mcgrof@kernel.org>
 <20230329072112.GG4253@hirez.programming.kicks-ass.net>
 <ZCPuFLDgU5fBFtug@bombadil.infradead.org>
 <20230329091935.GP4253@hirez.programming.kicks-ass.net>
 <CAHk-=whF6Ta_KcJP2eC78+Mstv+vAku8ATRMbv98sf9VhdvySQ@mail.gmail.com>
 <20230330115626.GA124812@hirez.programming.kicks-ass.net>
 <CAHk-=wgF34MkhZnM_Kc1zggTWCAQ=BzEgAaAbE5wDM07bWiYeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgF34MkhZnM_Kc1zggTWCAQ=BzEgAaAbE5wDM07bWiYeg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On (23/03/30 09:23), Linus Torvalds wrote:
> Although we also do have some other issues - I think down_trylock() is
> ok in irq contexts, but mutex_trylock() is not. Maybe that's why
> printk uses semaphores? I forget.

Yes, correct. IIRC we also cannot safely call mutex_unlock() from IRQ
context because it takes some internal mutex spin_lock in a non-IRQ-safe
manner. Semaphore is OK in this regard, both semaphore try_lock() and
unlock() can be called from IRQ.
