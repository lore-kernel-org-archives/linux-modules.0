Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46BEC61DA4
	for <linux-modules@archiver.kernel.org>; Wed, 15 Mar 2023 20:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCOU46 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 15 Mar 2023 16:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCOU45 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 15 Mar 2023 16:56:57 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734156FFE3
        for <linux-modules@vger.kernel.org>; Wed, 15 Mar 2023 13:56:56 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id bp19so15147920oib.4
        for <linux-modules@vger.kernel.org>; Wed, 15 Mar 2023 13:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678913816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5nQ/qpzt0oaqB3uXUI9DghvbDHZxBYtU4vb8xaNMZg=;
        b=BBJzoCdlv2m4yAlxDru7UMmXGx0atT8eNve/djKAdP6JF0Pa0fln3nteM7CtcXH7ge
         7tmEDx30QfS2rFzhb5xSSzZ8XdD/qL8u55PncGJs0N2KGgOQnvHVJkCsVGOezF8pLCQJ
         3Taol/hTDlr5vJ3tGpHQHEldYK1W+YQ8VMqUJGQsFsOyskArA+AUEVf9B3c/QXjTobM8
         EeEpn+50MYeDI1J22FNfrpHShSeHcSC/s5U8H4tMdiLTq3aPLND/BFpMCXxnMGw7Fp0O
         EwLEC+p1oY/cu+jGyZUT19Z9r0ioMWIj8XZ3YGzGixCIiLcQZyWDueLBVBbkhyh1wDiO
         9Fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678913816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5nQ/qpzt0oaqB3uXUI9DghvbDHZxBYtU4vb8xaNMZg=;
        b=TAlquKvhXjOfrq9L7o8kL5FW6L6SeYjgtiAiT8BDigEyXXPMz7r01BNq4N5tzffCBx
         lmEBFcOPbIZbgmN01DEGmJUJXrN1kNjs1bkPwePDvaqcIjQDxfyh9hiQbxyhsCl2vfro
         8PODImHvZKiCS/5cYiB8JCSopaAyzC7nu+n4dVPST9wLH4rqQ1dwmam5I+6TDLAr/kj5
         oPpowqeIbZ9tsEMkQjTCw5PzUecmWmM/IsPjtRQTYabWMNHd97WM7Vl37FMvTB7WnPpm
         rbpF06J7RWT4vrbUGOjP0Omasjna27YB0VmOE3B8Pxx8zby28blEyVFE/LwqleSkmqzK
         8S5w==
X-Gm-Message-State: AO0yUKWL+ik+nGgkIslBQ/Z4QiiXLBR/gSpPOzWAixo6Ckkl4qRdlID4
        2b4QHBRJ7Z7Y6Je8LQNN4fB3ZnRftppAtIV+Xzo=
X-Google-Smtp-Source: AK7set/frHFe10zRlzzkYZdrBNvEStbLGdbm1JDTXvS4gaJeZWDN0ckW8LGWeG0vDfE3Sinfoewb0jUzmpK7Fy1UPjE=
X-Received: by 2002:a05:6808:354:b0:384:23ed:1ff6 with SMTP id
 j20-20020a056808035400b0038423ed1ff6mr1201172oie.3.1678913815757; Wed, 15 Mar
 2023 13:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txaQfHkjs6nWcwBtnYQXtr996dyht7wasJ7QOovjepmAw@mail.gmail.com>
In-Reply-To: <CAPM=9txaQfHkjs6nWcwBtnYQXtr996dyht7wasJ7QOovjepmAw@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 15 Mar 2023 16:56:43 -0400
Message-ID: <CADnq5_PdxFdvVwVnQ2n4vXXPYKe0ZOVYBPT0Kf+6aPuQLc960g@mail.gmail.com>
Subject: Re: enhancing module info to allow grouping of firmwares
To:     Dave Airlie <airlied@gmail.com>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-modules@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Mar 15, 2023 at 4:35=E2=80=AFPM Dave Airlie <airlied@gmail.com> wro=
te:
>
> Hey moduly/firmware people,
>
> We are facing a problem in the future of NVIDIA providing giant
> firmwares for their devices that are version locked with unstable
> APIs. Even if they weren't version locked we'd likely have to support
> multiple major versions over time.
>
> Now this becomes a problem because when you generate multiple
> initramfs and stick them into /boot over time the number of firmwares
> MODULE_FIRMWARE will match will increase and dracut will shove them
> all into the initramfs.
>
> I think one way to mitigate that would be to provide some sort of
> grouping of module firmwares that are acceptable, and having dracut
> only pick one from the list to provide in the initramfs (hopefully the
> latest one). That way the driver can provide a list of MODULE_FIRMWARE
> lines and userspace knows they are a group.
>
> I've just little idea how we could expose this via current module
> info, happy to try and come up with an enhanced scheme maybe with a
> fallback to just include all of them but was just wanting to get some
> feedback on whether this was something that anyone has ever considered
> before now.

What about bundling the compatible FWs together into one big FW
package and tag it with some sort of common metadata header that the
driver can parse.  That would keep all cross FW compatibilities
together.  Then on the driver side, change the firmware name specified
in the kernel to match whatever is required for that kernel version.
E.g., one kernel could specify nv_fw_1_0.bin and another could specify
nv_fw_2_1.bin, etc.  It's pretty ugly and not a great user experience
if there is no backwards compat, but it should work as only the
compatible FW would be copied to the initrd.

Alex


>
> Thanks,
> Dave.
