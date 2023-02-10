Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E3AC636CD
	for <linux-modules@archiver.kernel.org>; Fri, 10 Feb 2023 11:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjBJLQT (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 10 Feb 2023 06:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjBJLQQ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 10 Feb 2023 06:16:16 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76063D2
        for <linux-modules@vger.kernel.org>; Fri, 10 Feb 2023 03:16:14 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4c24993965eso62814117b3.12
        for <linux-modules@vger.kernel.org>; Fri, 10 Feb 2023 03:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sT7CuQLdekmws37QVDxmBdTGmPVYkKIzMao5SnK+OJI=;
        b=KJNKJYqT1uYO69W/uPeOcsDIHUYAzketK/HCdbLp2cgquL4/52JxT6/IEbqiyo1Au7
         7rQdFFNKbDHc28QBW800nYKzP8fKJafsgO4+fHW7LXrSJBOk4mQ6PbYB2u2rQh6p4oWc
         /WfpdYZWr+Pf2ChZ+s9Xb9VP8GZJjESY+KBheWIDhqVzNs8X7nDsKbCm4xrow+ymKjT9
         pVjEIs1pRFZEDG/kYN5sA6z3lv0KkFYSKGJCSTC92V1rRus0NjBoD2smRQmr8gP19qxa
         L4JSbKtVSJbp9+qMvTeUdT8AqEnBZH6f7gqo9MPCewdrbQLZb5dCpfjmO7xlFxCe1hNv
         2Y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sT7CuQLdekmws37QVDxmBdTGmPVYkKIzMao5SnK+OJI=;
        b=5CxJXSuhsaKxcNuQFSc2MmFrU49QDEENpEcVrMZwmZVtQIpKaxRyDCzIjq5TjTi8ww
         mva+NOV7HsmnGuqlj4G/vDaOgAqDp4V+SYgc51ftXB54KT/0v3I3HVT3O6DGGP4+ZvvS
         vPZ7JJIZdQcZN28IaIxbqPPLveFU6ZmBczpzU5a8Q37mk8TtvRrDgw06r6ErVvbeww2p
         0XaMOoAXJtRnCwjASKVDx32R7+cTeJ67/X9Q1fZsKEWnq7i30Q7CyAU6BvnA2FdYd0/U
         IKDE5dp4HOLAT84MHkO+NN9aaS84Wn1GZwe0tUC5yxEWlQjpeySYqTlgpACLUiOLiElU
         i9yA==
X-Gm-Message-State: AO0yUKUXGRKap6W4kLBqOpW0QsxGcTexDhHjq2gfvN6hPpe5/JIs6tWt
        tlKt7kE+e8sykFv5XyMYcKLnfyTU+iwcESC4FO7kn3iMnY0=
X-Google-Smtp-Source: AK7set9gPxZNSI2vwuzn/cmcCKmXtXyxGSdpMGKnXVKqv36xan4FGrbBH/SdI6b/yYD8qyOszXquDe27km/xWmh4m+E=
X-Received: by 2002:a0d:d688:0:b0:506:5e35:e3bc with SMTP id
 y130-20020a0dd688000000b005065e35e3bcmr1966542ywd.139.1676027773626; Fri, 10
 Feb 2023 03:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20230209191946.243317-1-lucas.de.marchi@gmail.com> <20230209191946.243317-2-lucas.de.marchi@gmail.com>
In-Reply-To: <20230209191946.243317-2-lucas.de.marchi@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Fri, 10 Feb 2023 11:16:02 +0000
Message-ID: <CACvgo53f36vk_AwZ+VR-aK_xSrps2TodYPp9aP5r13qM9hvrqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] testsuite: Handle different sysconfdir
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, 9 Feb 2023 at 19:20, Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:
>
> Instead of skipping tests if sysconfdir isn't /etc, just handle it
> during the rootfs setup logic.
>

Nice. I'm far from an expert in the kmod codebase but the series looks
good IMHO. For the two:
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

SIde note: while looking through the Makefile.am I've noticed we're
doig manual SED substitution. Didn't look too closely but it should be
possible to:
 - add respective files to the AC_CONFIG_FILES section (barring .in suffix)
 - drop the explicit makefile rules, sed command and extra_dist/cleanfiles

Don't think I'll have the time to submit a patch, I'm literally on the
train right now heading out for a while.

HTH
Emil
