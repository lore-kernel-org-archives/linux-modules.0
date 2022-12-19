Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E55C4332F
	for <linux-modules@archiver.kernel.org>; Mon, 19 Dec 2022 20:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiLSUvn (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Dec 2022 15:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiLSUvN (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Dec 2022 15:51:13 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B6A12ABA
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:49:34 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id v21so2386155uam.1
        for <linux-modules@vger.kernel.org>; Mon, 19 Dec 2022 12:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8tVwqhBd9WrUEVcokm03nya2VEvh1CGdtbU6YyAGtA4=;
        b=MnmCpzBECMDDhtwaoc3yhPhxY89r0Hr1fzV5xBe0ETW4gFvQFaJ31NSwW7JfA8JZEI
         D7/SVoLcmh2oZZmdkpO3q0sPXlA6TwzdlowxsD37vFiibnWPk/WGyPZ58cLLg7ebmV35
         R7uUoTU3AZKe7pc1AFsPo21NK+xFcnNAsKcrCpJA6W7FxrM/YRNDph7dG+XlnjTmqwpf
         17zXU374OzqVEu71umGd0cKODaDMF3NwFisz0n5S4gqLusxGFkJe19OhutrVJDlkdvV6
         vKmMjVVLOGEFP+vMXLdzXZLuLYmCa1o5xAtAEn8/LKvgdma/32bQeeWR6YLKqaskK7gZ
         bJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tVwqhBd9WrUEVcokm03nya2VEvh1CGdtbU6YyAGtA4=;
        b=PAH0Er73VezfXywhogcvWFNgK06kQQzKZt0uiu4JjuYSvKM05ZjWKNFQQLb8n1BNl3
         aOEfIE9gA3dLLtZnvMQ7Kg8ryvdcQ801P4XpLNy63BkI87ZjGkSIbGziUrxW7oF0Kytn
         56sdnRCmKBQf/cRsaFgieUfcWyqN28WrhRUxyH+b3OeuSTIV7QuYmOhHxmxMgRZfbCND
         v+EleW+R/WkfHwpKon5ZIvnQzd8jxsrGBpzT3r8/8zOL2VOYe18xblJbHURqkXrjOlCx
         x61pTPWUMw5MspUSzs/991sFD1E6tVHyqRCPi87qnZVV1kIwCuSPulfhZ3i+8Mx6Qcjt
         UH9A==
X-Gm-Message-State: ANoB5pl0D3d5w1/KTuWLTtUGHXsD3ZNTDtGBiUhbfzBQoAWm1hdJC1o7
        QY0yNWIlewtTqfKJLjL8gQ5kaJyhD8BsZqvR09IWVHoSD3J9JfQ7GkQ=
X-Google-Smtp-Source: AA0mqf5jAa4/yU9XdonLaWXZFMkupivcGxl+vw6h5P7R3kVzoaGd6CRUVXlhyBkLnXTdBGSKfyYxu/AgTeK8bROQ9B8=
X-Received: by 2002:ab0:7e89:0:b0:42a:c56b:8050 with SMTP id
 j9-20020ab07e89000000b0042ac56b8050mr3603084uax.108.1671482972933; Mon, 19
 Dec 2022 12:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com>
 <20221219204619.2205248-1-allenwebb@google.com> <20221219204619.2205248-11-allenwebb@google.com>
In-Reply-To: <20221219204619.2205248-11-allenwebb@google.com>
From:   Allen Webb <allenwebb@google.com>
Date:   Mon, 19 Dec 2022 14:49:21 -0600
Message-ID: <CAJzde06FdTuj4HbZ+tAuOzFPY3C9XUMEKk-MVNj+E6z8r61uyA@mail.gmail.com>
Subject: Re: [PATCH v9 10/10] docs: Include modules.builtin.alias
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Please disregard this patch. I updated the commit message and this was
hanging around in my outgoing directory afterward.

On Mon, Dec 19, 2022 at 2:46 PM Allen Webb <allenwebb@google.com> wrote:
>
> Update the documentation to include the presense and use case of
> modules.builtin.alias.
>
> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---
>  Documentation/kbuild/kbuild.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
> index 08f575e6236c..1c7c02040a54 100644
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -17,6 +17,12 @@ modules.builtin
>  This file lists all modules that are built into the kernel. This is used
>  by modprobe to not fail when trying to load something builtin.
>
> +modules.builtin.alias
> +---------------------
> +This file lists all match-id based aliases for modules built into the kernel.
> +These are intended to enable userspace to make authorization decisions based
> +on which modules are likely to be bound to a device after it is authorized.
> +
>  modules.builtin.modinfo
>  -----------------------
>  This file contains modinfo from all modules that are built into the kernel.
> --
> 2.37.3
>
