Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89930C433F5
	for <linux-modules@archiver.kernel.org>; Tue, 21 Dec 2021 16:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbhLUQzh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 21 Dec 2021 11:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhLUQzg (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 21 Dec 2021 11:55:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EA2C061574;
        Tue, 21 Dec 2021 08:55:36 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so2146564wmj.5;
        Tue, 21 Dec 2021 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=KCvhpJrfd87tVOnD0A4Hg8GgQh1m8G6/1P2LKgguHGE=;
        b=MW9wOHdyKM6/klOEZnSYPvxHeW2YexYs9lWW0cUw1Uo7Gc4B8XFcuPenoOysQJXO5M
         Od5GpIElrcjQfXxJhcGmBjyzazMf0u5bxPH5bPYYvYk8JFhUtY9eUH4TepaxMoQqXfXG
         DHqMnqAjSjuhNV2WQ0aMONZjkqZuBt4B63tL5Tq3/10+YfzVzFgGkz9dELGt97+UmU5i
         lGhLf+i7N9Ad7DF0QR2sERpjeKMr+rwNsKjSUSeERLVmsJI6YvmZVU6Ng5gzf8IWhpre
         chP65ewpC+XqgsfOSilNZcWoBrvYQi0ikLVLNVkrXrQO4rv9N2kYwgewFUWblEXF67MU
         NYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KCvhpJrfd87tVOnD0A4Hg8GgQh1m8G6/1P2LKgguHGE=;
        b=IWJzG86afeybR5Ib+Q9RDnqF3Z9K/2EZrWjnwVcIcuJSjJwRwS7e7qMs+ycWbfJVbS
         bsSS464OeqnejByPwJHFK0RAc0TeB8VdKeFQkpP490c+MSZThQXb0+Kl1Mo4CiiN6CRe
         DfyoG1/wqDQ5q0wgn/BlRIXFDeBbxC8DCfgbHhY4952fNJmIdGPeowtqd+fLED74EwJs
         z7Zm2dyDwlFGTGedC1ff/f0fXrsuctZQvNzlozcwZPodmshSertA/Me9kC4va8g27Kkr
         tEJt3G+0y3a3NG5G3Hs0fHg0ChwWJxxo5MJXNtXqTtNLZvZ5C0Z8MmVFC3dUjmD0ev5z
         9IYg==
X-Gm-Message-State: AOAM532RDfRq6C0YLcCqxD0bLDDWM3zaqKENg2XGGbAb2VLzt58Eixfx
        mD8NSKKAmlKLtBqpMr2+BQ3OubIscxBbtRHL8JXjiHgK6sFQQQ==
X-Google-Smtp-Source: ABdhPJzydYc65SZcHV9nXcpZN526pM2AbB9zmk84p9C1GQoix45BeYIEVYaIfxngu20djJ7mI0YoCqWO4S0R7yGsPdM=
X-Received: by 2002:a7b:c951:: with SMTP id i17mr3521437wml.113.1640105734929;
 Tue, 21 Dec 2021 08:55:34 -0800 (PST)
MIME-Version: 1.0
From:   Eliyam Levy <eliyamlevy@gmail.com>
Date:   Tue, 21 Dec 2021 11:54:09 -0500
Message-ID: <CAD9KO1=gjhe1sc3MNyc3QawQgJAgwptFgsTZE903PCi3_DEyPg@mail.gmail.com>
Subject: INVALID ELF STRUCTURES
To:     linux-modules@vger.kernel.org, linux-newbie@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi,

I'm on Ubuntu 20.04 with kernel version 5.11 and I keep hitting the
"Module has invalid ELF structures" error on a kernel module I'm
building. I know this is related to the "harden ELF info handling"
patch that was introduced. Are there any useful ways to debug this? Is
there anything I should be mindful of when building the kernel module
to avoid this?

Best,
Eliyam
