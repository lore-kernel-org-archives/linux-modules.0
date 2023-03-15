Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECECC7618D
	for <linux-modules@archiver.kernel.org>; Wed, 15 Mar 2023 20:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjCOUfw (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 15 Mar 2023 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjCOUfv (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 15 Mar 2023 16:35:51 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C79F3B672
        for <linux-modules@vger.kernel.org>; Wed, 15 Mar 2023 13:35:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ek18so49237783edb.6
        for <linux-modules@vger.kernel.org>; Wed, 15 Mar 2023 13:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678912544;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=STu7lwk9EWynFbyJNEYgTVBgHJBbpHb6vY8xGQ/7rhw=;
        b=FSHsf23S+z7bVQb6Vq+rVXQ4AkzThCspIf2anR6pirX8XoD4TZWwBG78EbgMEowmic
         l+0USVDmXm6eN4odnJmvDHfJT0OTXK0i/o4w3L/I+N2fVQqI7xs2GUE2qGSphtIiFki5
         hzhKrJBFDM8FjUVJtPzvrOWxqdqs8FYRFn3zXAEfqAjrjeT/ENzhp0JzmSGmkFmitpqe
         LEUbNh5/7HZDd8wmPIAEWq/H63DcebgOyUnkCPyKCtDgOg8R+0BHzTNXyM8fYtaYtys5
         /Bkr5WwITSYG0eJRBuPc6YA1P+iDN71cSfB2jBH6YzIH4G7wuF5I/DXeAMK7G2sGH2be
         TtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678912544;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=STu7lwk9EWynFbyJNEYgTVBgHJBbpHb6vY8xGQ/7rhw=;
        b=HOmHlxcH4gx+mBftUuOIJ7I3MOR09krqCyA+0Pmk0m18wNA5QiEcHYR+bQjueX4q6L
         EkDguStuopVk6+pIHyIaVKo3P/8WnE/dmYwy6WQnNFuBQQ5y4sNrBj801Z6zXbFbioQ2
         fxGPopAk8tp5f7tq7CpPdQMJJlVYZ+W2wHeyMRJbTfNg3p4WuuRg1qmmO0idGnEi5l7E
         bdMGSmsrvvSj6yC9Fuxi+vdCpxpTi5GEtfERdsnxSAdPmq5S+HJBYwZwDev8nB9K94OC
         kHrBOJQC8ywVrxOveBBm/dP0xIDVTQjLzHBVNGhXa4XvNl1CAGyxvt3r+89ry9Bf/crI
         J90Q==
X-Gm-Message-State: AO0yUKXFvJzoa8NUw72MO0sTQy+Fz2xPzhPvOEfv3pZEuH9WpcfoXBeF
        IHeSYT2C9WuS7VMMj5J0Dr99aUBTz3OyaR3TEXY=
X-Google-Smtp-Source: AK7set/MjMlEKSe8+TQ0gXyeZW7hT4mNMONUGs9jKLJ+853ZryPu0oV/iyoVSFTi3ctii6WFlS5MruFSzZDK6DgnPcM=
X-Received: by 2002:a50:874e:0:b0:4fb:2593:846 with SMTP id
 14-20020a50874e000000b004fb25930846mr2189681edv.3.1678912544317; Wed, 15 Mar
 2023 13:35:44 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 16 Mar 2023 06:35:32 +1000
Message-ID: <CAPM=9txaQfHkjs6nWcwBtnYQXtr996dyht7wasJ7QOovjepmAw@mail.gmail.com>
Subject: enhancing module info to allow grouping of firmwares
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-modules@vger.kernel.org
Cc:     dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hey moduly/firmware people,

We are facing a problem in the future of NVIDIA providing giant
firmwares for their devices that are version locked with unstable
APIs. Even if they weren't version locked we'd likely have to support
multiple major versions over time.

Now this becomes a problem because when you generate multiple
initramfs and stick them into /boot over time the number of firmwares
MODULE_FIRMWARE will match will increase and dracut will shove them
all into the initramfs.

I think one way to mitigate that would be to provide some sort of
grouping of module firmwares that are acceptable, and having dracut
only pick one from the list to provide in the initramfs (hopefully the
latest one). That way the driver can provide a list of MODULE_FIRMWARE
lines and userspace knows they are a group.

I've just little idea how we could expose this via current module
info, happy to try and come up with an enhanced scheme maybe with a
fallback to just include all of them but was just wanting to get some
feedback on whether this was something that anyone has ever considered
before now.

Thanks,
Dave.
