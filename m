Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE2FC83F12
	for <linux-modules@archiver.kernel.org>; Tue, 29 Aug 2023 17:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjH2RKd (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Aug 2023 13:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbjH2RKS (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Aug 2023 13:10:18 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77463FC
        for <linux-modules@vger.kernel.org>; Tue, 29 Aug 2023 10:10:15 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C97CB3F659
        for <linux-modules@vger.kernel.org>; Tue, 29 Aug 2023 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693329013;
        bh=tMPbpJTwbXilNPb6CkF4RbuZPZAvY4oEyiXr97ubnVE=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=aGYNbXNmkVj5i9rP54r/dunvcgzXGn4g0k8vJ9tqP1+99+sKDXLE9nanWBuurRvq2
         u11p+ugTxxob++s8/hOeQrTzT/EMXzQoIvXmeXy5hF/IPbQUlyVIK7HALrVhcYTffF
         k9KVKXyosEMjpBwx/XNEJcLQlmbWdMF/v4Gjlgp50e5F926p3SqX7ZRrxt6EOp2t5R
         l9Uq7IPlqdSRL4fdqNqYLypkYOq/OwIsyO7wVK+kv+U/4O/MC9VxjkvA2B92FHZas/
         v3g3EvOaoYGXHXOUoxSUKZ4zWsNqO4M951xloRDzEzUmKXAyTCSJKPsK99uiSRD349
         +x77dVwlbZqSw==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99df23d6926so339611866b.0
        for <linux-modules@vger.kernel.org>; Tue, 29 Aug 2023 10:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329013; x=1693933813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMPbpJTwbXilNPb6CkF4RbuZPZAvY4oEyiXr97ubnVE=;
        b=GIgd8TYMNJfnQeEuwoVd6mo0yqHcDpxBBDdQvW1PuZBcwBx3KoAqHCV5TiK02/9yNz
         WNbz9SAWzpUroEFPAP7AuJgjRrhZC80IN533D7I2QfI/0m8XRoLu12/92X5i7LdCXvf7
         6kS627AYuUduynwlf3aREsEufkSMegZj2rMtN3kPuRfuMJ+fcT8f4c3olBRqKpvwUQ/s
         dcic1mVeWssBJFYKghX0ICsSSXKfAn2wxaff4GtXj/sGoaiGTwK6jyZfquG+scJJ1Md+
         EezPhOki73/+PN8NuX57ChLgStiYbR6XGWUs4DNKybT5u7gLb1hUEl0e6tkbUF79yojk
         I7Mw==
X-Gm-Message-State: AOJu0Yy8CaKcJVuLDKLdKV3ptOQjXlJ0ctaQNF8M7QFFWiKugLV7sbn2
        0nQ5yEYtA2SXdFzHlboN/6eKayUqwtO5ocdc8/DTjouPeqNKDz8O1mQ3lwW/JF2xwnlbAUnfm/z
        kFs80cJ1pvFrTSwmBPWSPuqXeQ9U9FTKU4RLtA27Il4N1AzNLHPM=
X-Received: by 2002:a17:907:7602:b0:9a1:d400:39e7 with SMTP id jx2-20020a170907760200b009a1d40039e7mr14299934ejc.5.1693329013530;
        Tue, 29 Aug 2023 10:10:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE19u9QCEvg8N+EPCvD9DF8cmg3+BQIqt2MlJEdZR3XmjEtS9N8URSV55uc6rx8MUo0JcuCPQ==
X-Received: by 2002:a17:907:7602:b0:9a1:d400:39e7 with SMTP id jx2-20020a170907760200b009a1d40039e7mr14299919ejc.5.1693329013204;
        Tue, 29 Aug 2023 10:10:13 -0700 (PDT)
Received: from localhost (host-95-252-65-153.retail.telecomitalia.it. [95.252.65.153])
        by smtp.gmail.com with ESMTPSA id h7-20020a170906718700b0099bcf1c07c6sm6193989ejk.138.2023.08.29.10.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:10:12 -0700 (PDT)
Date:   Tue, 29 Aug 2023 19:10:11 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH] libkmod: allow to fallback to user-space decompression
Message-ID: <ZO4mc0aJHJj5IiuC@righiandr-XPS-13-7390>
References: <20230829123808.325202-1-andrea.righi@canonical.com>
 <yxq5obi4rh2k54xw3fm6mtg36gmvluophe7slmc352wwccak27@2azm6bid2l5r>
 <ZO4NbbE8SvVkzN6R@righiandr-XPS-13-7390>
 <ZO4gA5mhGK1nN54Q@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO4gA5mhGK1nN54Q@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Aug 29, 2023 at 09:42:43AM -0700, Luis Chamberlain wrote:
> On Tue, Aug 29, 2023 at 05:23:25PM +0200, Andrea Righi wrote:
> > For the records, I've also sent this patch to address the issue from a
> > kernel perspective:
> > https://lore.kernel.org/lkml/20230829120508.317611-1-andrea.righi@canonical.com/T/#u
> > 
> > That seems to solve the issue in my particular case, but I'm not sure if
> > that's a valid solution across all architectures.
> 
> I can't think of a reason why it would regress on other architectures.
> We'll give it a spin soon fast as it will be on its way to Linus today.

Cool! Yes, if this patch can be applied we don't really need to change
libkmod and if there are other spots in the decompress code that can use
vmalloc() we can adjust them in a similar way.

Thanks,
-Andrea
