Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C00BC001B0
	for <linux-modules@archiver.kernel.org>; Tue,  8 Aug 2023 19:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbjHHTpG (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjHHToq (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 8 Aug 2023 15:44:46 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EED46FC9
        for <linux-modules@vger.kernel.org>; Tue,  8 Aug 2023 09:48:06 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1bbb9fcac6bso24403fac.1
        for <linux-modules@vger.kernel.org>; Tue, 08 Aug 2023 09:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691513285; x=1692118085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kb4epZ0hVQjvrS5RqNy38MOhVst2cqtQlkC7YBmZyjc=;
        b=fNv2VsWLWXzrAnrcJBu7Juv9Tez1x0iS2nX174u1/svb4J8tsWl/YypNVXfwENVc9g
         R1bylUtMDI8J8zgzT9Id7usfHP2VMdW9Ykc0SvWfn7DGJpazOUXSt9XJWYyctjpAp93d
         eHkDVVTzFPcvbYpxVJbMPkSdpzZJrDheXvcECM8m5no1G25oNk2HioPUr9cNre8tW/Wf
         BYucLsvEB8tFXH0Vdv1OQncxYoaS9hf9GDsxIaO3vCt+xPMDKYReByjtPypnYQRhjZrI
         swzGi36xvGi3CXgcQOqNrmROIGDiDRPt7Aac62NG2f0cajTPcHyLYIgfuJlNaaiwLEF3
         oMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513285; x=1692118085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kb4epZ0hVQjvrS5RqNy38MOhVst2cqtQlkC7YBmZyjc=;
        b=eu9GnAYzVF2Y3jPZMVcCgjRF3akLvjWJIs6OSAWYI9/lDHaG+5TRYn1tPBch2bb8kG
         FjkilcYkNr2itGgm9wFJCgo+oKNGVsqf3SxGxkA7vGfkGkQuyU8BWYC3z0mCkxC6BgTA
         POpS/Nunu3tzWYVLvavIvPMQu3GRB1/Pqb9hnarr7okwYgFCfbe7ADxumnNW67oXrPdM
         vGzcmayQc20Ryt7u3dzyEA233YF6DQleBYXIUmo4DkPJEcDdSw1HKUR8VReBJMGeMqRX
         AM4gnKqh9DZkRf7sl9yCCNbAoA5v9H70vNL8EsAMk4eeikS18K6gDl7HJIjUDc3nH5Yv
         HVgA==
X-Gm-Message-State: AOJu0YxB9gGQ0p5IrcOROpuj83ZaWczn4XAER/LzTrQrCSUgcr9FQSSZ
        OKEepGfzfy+P7vAArh4KTMx30e0R0UbNpurDTmPLQnVb90KzmSBo
X-Google-Smtp-Source: AGHT+IF66ZIg71BsvfIXpCtaWYgCcZU8SNpF3fi8QtXBlp/Ozl2bOkN0RcX0VeXVj4YAJiEXbN2H1G1ZyCw5KxmnN8o=
X-Received: by 2002:a25:aa21:0:b0:d15:3761:3513 with SMTP id
 s30-20020a25aa21000000b00d1537613513mr9704045ybi.19.1691486159218; Tue, 08
 Aug 2023 02:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230801173544.1929519-1-hch@lst.de> <20230801173544.1929519-3-hch@lst.de>
In-Reply-To: <20230801173544.1929519-3-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 11:15:23 +0200
Message-ID: <CAPDyKForXd2GFVmXXM8hsnAYSQcKhp84t1aOunppUY+MFe0qag@mail.gmail.com>
Subject: Re: [PATCH 2/5] mmc: au1xmmc: force non-modular build and remove
 symbol_get usage
To:     Christoph Hellwig <hch@lst.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, 1 Aug 2023 at 19:36, Christoph Hellwig <hch@lst.de> wrote:
>
> au1xmmc is split somewhat awkwardly into the main mmc subsystem driver,
> and callbacks in platform_data that sit under arch/mips/ and are
> always built in.  The latter than call mmc_detect_change through
> symbol_get.  Remove the use of symbol_get by requiring the driver
> to be built in.  In the future the interrupt handlers for card
> insert/eject detection should probably be moved into the main driver,
> and which point it can be built modular again.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

If not too late, feel free to add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  arch/mips/alchemy/devboards/db1000.c |  8 +-------
>  arch/mips/alchemy/devboards/db1200.c | 19 ++-----------------
>  arch/mips/alchemy/devboards/db1300.c | 10 +---------
>  drivers/mmc/host/Kconfig             |  4 ++--
>  4 files changed, 6 insertions(+), 35 deletions(-)
>
> diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
> index 79d66faa84828d..012da042d0a4f7 100644
> --- a/arch/mips/alchemy/devboards/db1000.c
> +++ b/arch/mips/alchemy/devboards/db1000.c
> @@ -14,7 +14,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/leds.h>
>  #include <linux/mmc/host.h>
> -#include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/spi/spi.h>
> @@ -167,12 +166,7 @@ static struct platform_device db1x00_audio_dev = {
>
>  static irqreturn_t db1100_mmc_cd(int irq, void *ptr)
>  {
> -       void (*mmc_cd)(struct mmc_host *, unsigned long);
> -       /* link against CONFIG_MMC=m */
> -       mmc_cd = symbol_get(mmc_detect_change);
> -       mmc_cd(ptr, msecs_to_jiffies(500));
> -       symbol_put(mmc_detect_change);
> -
> +       mmc_detect_change(ptr, msecs_to_jiffies(500));
>         return IRQ_HANDLED;
>  }
>
> diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
> index 1864eb935ca57f..76080c71a2a7b6 100644
> --- a/arch/mips/alchemy/devboards/db1200.c
> +++ b/arch/mips/alchemy/devboards/db1200.c
> @@ -10,7 +10,6 @@
>  #include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> -#include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/leds.h>
> @@ -340,14 +339,7 @@ static irqreturn_t db1200_mmc_cd(int irq, void *ptr)
>
>  static irqreturn_t db1200_mmc_cdfn(int irq, void *ptr)
>  {
> -       void (*mmc_cd)(struct mmc_host *, unsigned long);
> -
> -       /* link against CONFIG_MMC=m */
> -       mmc_cd = symbol_get(mmc_detect_change);
> -       if (mmc_cd) {
> -               mmc_cd(ptr, msecs_to_jiffies(200));
> -               symbol_put(mmc_detect_change);
> -       }
> +       mmc_detect_change(ptr, msecs_to_jiffies(200));
>
>         msleep(100);    /* debounce */
>         if (irq == DB1200_SD0_INSERT_INT)
> @@ -431,14 +423,7 @@ static irqreturn_t pb1200_mmc1_cd(int irq, void *ptr)
>
>  static irqreturn_t pb1200_mmc1_cdfn(int irq, void *ptr)
>  {
> -       void (*mmc_cd)(struct mmc_host *, unsigned long);
> -
> -       /* link against CONFIG_MMC=m */
> -       mmc_cd = symbol_get(mmc_detect_change);
> -       if (mmc_cd) {
> -               mmc_cd(ptr, msecs_to_jiffies(200));
> -               symbol_put(mmc_detect_change);
> -       }
> +       mmc_detect_change(ptr, msecs_to_jiffies(200));
>
>         msleep(100);    /* debounce */
>         if (irq == PB1200_SD1_INSERT_INT)
> diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
> index e70e529ddd914d..ff61901329c626 100644
> --- a/arch/mips/alchemy/devboards/db1300.c
> +++ b/arch/mips/alchemy/devboards/db1300.c
> @@ -17,7 +17,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/ata_platform.h>
>  #include <linux/mmc/host.h>
> -#include <linux/module.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/platnand.h>
>  #include <linux/platform_device.h>
> @@ -459,14 +458,7 @@ static irqreturn_t db1300_mmc_cd(int irq, void *ptr)
>
>  static irqreturn_t db1300_mmc_cdfn(int irq, void *ptr)
>  {
> -       void (*mmc_cd)(struct mmc_host *, unsigned long);
> -
> -       /* link against CONFIG_MMC=m.  We can only be called once MMC core has
> -        * initialized the controller, so symbol_get() should always succeed.
> -        */
> -       mmc_cd = symbol_get(mmc_detect_change);
> -       mmc_cd(ptr, msecs_to_jiffies(200));
> -       symbol_put(mmc_detect_change);
> +       mmc_detect_change(ptr, msecs_to_jiffies(200));
>
>         msleep(100);    /* debounce */
>         if (irq == DB1300_SD1_INSERT_INT)
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 159a3e9490aed8..f7afd179dd10bf 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -526,11 +526,11 @@ config MMC_ALCOR
>           of Alcor Micro PCI-E card reader
>
>  config MMC_AU1X
> -       tristate "Alchemy AU1XX0 MMC Card Interface support"
> +       bool "Alchemy AU1XX0 MMC Card Interface support"
>         depends on MIPS_ALCHEMY
>         help
>           This selects the AMD Alchemy(R) Multimedia card interface.
> -         If you have a Alchemy platform with a MMC slot, say Y or M here.
> +         If you have a Alchemy platform with a MMC slot, say Y here.
>
>           If unsure, say N.
>
> --
> 2.39.2
>
