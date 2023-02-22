Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57A0C61DA4
	for <linux-modules@archiver.kernel.org>; Wed, 22 Feb 2023 11:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBVLum (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 22 Feb 2023 06:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjBVLuf (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 22 Feb 2023 06:50:35 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C3034038
        for <linux-modules@vger.kernel.org>; Wed, 22 Feb 2023 03:50:34 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536a5be71a8so121029437b3.2
        for <linux-modules@vger.kernel.org>; Wed, 22 Feb 2023 03:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mgU03jFHJMwZKwYZ+eYJkdchSfa4nWF3XxM2OR0eQHA=;
        b=b/SSroTcbfzuhmPD//LwH++hnSli3FpCoM52f82sLOHRNH3m1IlV7wfAG27NSCvOqn
         1S6C8fqVfIUgfGq9YcBR98/iVPN+0uQlce9XGFNu5diyc9kJGbRdtJk+VJKmT7gijgg2
         uzyAhovKU5QSmZ53xkNx1CwhTDukQxU/VfnF1q+GiqcRvGPQynPxQcaH/NG4hSn5ntt6
         3OnFBJGS2mxS5zFBQvyq4hboFuvCQD77BRXYTarXTKDR80AzyCygPbWRIideoVNH4EUb
         QmLTxFTglcVlBCLAbZfcFI30Deh3Fz7C2zMSwxdtN6KB6AAyy9yrXlPwIYcHra/0suFX
         F01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgU03jFHJMwZKwYZ+eYJkdchSfa4nWF3XxM2OR0eQHA=;
        b=sxTQutJkVMlw0EKHc1OAQX45xDlLfg1mPWmRfOzE8565wtIli84qCv3+YWHHuF9Hdw
         23jhSa8Jp0DQpMmhD4jAHfjSLnW5CLsiU+lJw3jNX6iBpMKFvuh/RgIDwPCCQ5S+19Ja
         oDN5BrxzcNqF7i3eL8V3NOrAcDKHNxcbWVCZuEi0D64A9W8s3JvZkqnNNZfmnZFJqFFn
         awORcKpHw+ymgcnWHP+/AiYTmhB/3/MXv0pfs3dcS7y1LIDB2zNL2MPgtEclKGywVQwP
         iE+ZknfJagnX1KgAC0WVpQgdp4EwNOE32xfQja8jQfg3YXGY06xChN/qHERGZTA07OiC
         oLug==
X-Gm-Message-State: AO0yUKU9IFMj7nGLJjmVLJC+a2/q6+5Kb/kn7HR5mFvtYS77ZSz0WIok
        Anzn4IWx/OgWCryxeJlmSLkxVkkP08PKf9o/HBGKJVmSb0o=
X-Google-Smtp-Source: AK7set+wF4rMz3JZcybwKoOT/pOA/loC4GlnGOtDd+RQTowF5gEJlr7WETTWS3alndNwxRD0QjFh7a8N4etVUud55JU=
X-Received: by 2002:a81:df08:0:b0:527:c046:6627 with SMTP id
 c8-20020a81df08000000b00527c0466627mr243560ywn.93.1677066634121; Wed, 22 Feb
 2023 03:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20230221131929.106951-1-emil.l.velikov@gmail.com> <167702625292.356650.2246926470690447394.b4-ty@gmail.com>
In-Reply-To: <167702625292.356650.2246926470690447394.b4-ty@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 22 Feb 2023 11:50:22 +0000
Message-ID: <CACvgo52Ok9-X63+F=_ZytV04D+Kv=qVqCkJ4EvWBT_ikPS6YVQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] kmod: Paper cuts - dead code removal, don't SED manually
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Greetings Lucas,

On Wed, 22 Feb 2023 at 00:40, Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:

> My intention is to release kmod 31 soon. Let me know if you have
> anything pending that you'd like in the next release.  If nothing is pending I may just
> do a release in the next days/week.
>

There are no other patches on my end - rolling a release would be great.

Thanks o/
Emil
