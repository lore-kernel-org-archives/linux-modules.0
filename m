Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C228C6FD1D
	for <linux-modules@archiver.kernel.org>; Wed, 15 Mar 2023 20:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjCOUmq (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 15 Mar 2023 16:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCOUmp (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 15 Mar 2023 16:42:45 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4966770D
        for <linux-modules@vger.kernel.org>; Wed, 15 Mar 2023 13:42:44 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-17786581fe1so15109271fac.10
        for <linux-modules@vger.kernel.org>; Wed, 15 Mar 2023 13:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678912964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTJ2WQqzCp342VzXKKxKrb6Tcop1tbY216MnndJN7sQ=;
        b=hWgmkRx8RZmNnPKBjbZ3vIInOgxqUkG1Nli4lVeXL5nTKOCfHgWydHCGHT77yqdP2X
         MCaMMT8pGdJBc3FZS8SG6HpIFozsrOGGRKq5L7Kt5rmqKutwucBQXV1SJH4tQ8W5lIRR
         onHgFUXxvpBQstIBiFZNzfLlYd1zCe77tN1gCYOLeRuy9CLKEKzirEogPd0i1gnYDRxo
         w/IqIAYRcw/36WYC/Gw98J+NVF+8HwkE1mST+UlAvOZoar0Nd+r+3xhCl/uWIDUnNiPk
         OpO3sq+Kq2OXpaWeFtrTTIwwqUfY8Bn2ift/OMHZ1pyRYQP+4bhrWJH5oC2b/wxoDpO4
         gdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678912964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTJ2WQqzCp342VzXKKxKrb6Tcop1tbY216MnndJN7sQ=;
        b=QJgtKqQrOQq9f8Tk20gEzb7twmEKirBLvuHt094+uaBuDhoxR2WkqZqCx3LjkaMrIf
         6zdtHIS4dcsKWWPlgdRaZvod0uElxBqlfkwcQXAQqolV/HN8pgMOig7oL0On4D0prOuy
         giHVl6+F+QoVEuYfQTjX98jYRwTdF/EhkuSFLEfsdpS6EzMNEcx4bns44cHdf/6QrRGc
         bIWCGVpODSXyxCjA/pJpTlgcdo1m6/jxQlnDo4T82YIL8ttKp2bZaI2QL0ZckWErpA6V
         opWDfStr2fGpSMzHg5dtB+J92n0oPnqjbWb3mUi2/lupKRVzbb5dxTKTRYQl5JVzcPOt
         z7XA==
X-Gm-Message-State: AO0yUKWJhU+/IARVpncNIZ4qJaZU8HqXg24iQF/sW/tXye1ggXcCzZnI
        6KePfuoYz6qnHtYGS6b9r/smhw5B5HOyArwYjcRk5lbdleU=
X-Google-Smtp-Source: AK7set+FReR4XqbWnaRh930lCwNBx9FyHBIZTL6tblJ8yZ1fzNHd3HKWtbe1Xzi8G8WU3RzY9o0cqnRBhGX1FAXRI74=
X-Received: by 2002:a05:6870:7f84:b0:17a:d7c7:a19d with SMTP id
 aw4-20020a0568707f8400b0017ad7c7a19dmr771163oac.5.1678912963104; Wed, 15 Mar
 2023 13:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txaQfHkjs6nWcwBtnYQXtr996dyht7wasJ7QOovjepmAw@mail.gmail.com>
In-Reply-To: <CAPM=9txaQfHkjs6nWcwBtnYQXtr996dyht7wasJ7QOovjepmAw@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 15 Mar 2023 13:42:31 -0700
Message-ID: <CAF6AEGtHLwUMU71bciM3HbmRePYYgiW8c07yzu5FXymOfemWjQ@mail.gmail.com>
Subject: Re: enhancing module info to allow grouping of firmwares
To:     Dave Airlie <airlied@gmail.com>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-modules@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Mar 15, 2023 at 1:35=E2=80=AFPM Dave Airlie <airlied@gmail.com> wro=
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

We have a kind of similar problem with drm/msm and various other SoC
drivers that need fw which is signed with a device or vendor specific
tree.  We've partially solved that with using firmware-name from
devicetree to specify the correct device specific fw needs to be
loaded (ie. something like "qcom/LENOVO/81JL/qcdxkmsuc850.mbn") but
I've no idea how dracut should figure out what fw files should end up
in an initrd

BR,
-R
