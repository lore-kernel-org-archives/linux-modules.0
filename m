Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730B7C61DA4
	for <linux-modules@archiver.kernel.org>; Thu, 16 Feb 2023 19:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjBPTQh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 16 Feb 2023 14:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPTQh (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 16 Feb 2023 14:16:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FE64C3F9;
        Thu, 16 Feb 2023 11:16:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F47160A54;
        Thu, 16 Feb 2023 19:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1A6C4339C;
        Thu, 16 Feb 2023 19:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676574995;
        bh=5bm3NoeSiw5m5JezQB5vTpYr1RD7lH2eTbAPQpdi5d4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UT5GYH4KNmrDYU7vbtv8aOWUFu419mkcWoa0NlwNz9D+6HQqVJPIGhmR5MwTHTtIu
         XMNRcMe1zud7i/pATJerg2IbRygANb1ME9wVcrtxYjVIXbnIamsB9XmaJDcRyiS8R2
         DqS8iMR/AYPRtqOm3zo4SyhiTraNwCqP1YjRIFDSZqMTMqESvJHhPKonr6YJ5Yx3sG
         dpxxfH4/EZPfyKK00g6fsbbwdiiXlihdWWrI6H7gcTIssdOgqw1zyTjMyM3BbZyI+T
         ul2U6DRg3oXcyJXzk0M4R6WmFg1EkPIIk/Ni8m5lZzeuuCpRn1gnE65/Do7opD/6BO
         aQ2Qa3/1IW1+A==
Date:   Thu, 16 Feb 2023 13:16:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>, mcgrof@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Subject: Re: [PATCH v2 0/7] MODULE_LICENSE removals, first tranche
Message-ID: <20230216191632.GA3325180@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+5vczghnTF5nUut@spud>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Feb 16, 2023 at 06:01:23PM +0000, Conor Dooley wrote:
> On Thu, Feb 16, 2023 at 11:43:33AM -0600, Bjorn Helgaas wrote:

> ...
> I noticed that (as requested!) Nick dropped the change to the microchip
> driver.
> Would you like me to resend patch 3/11 of [1] to clear the decks of
> "incorrect" MODULE_LICENSE usage?

Thanks for noticing that.  I removed MODULE_LICENSE from
pcie-microchip-host.c for now.  We can easily add it back when [1] is
merged.

I haven't talked to Lorenzo about the series [1] is part of, but just
from the mailing list traffic, it looks like there are a couple open
questions (MSI config probing [2], "ranges" and address translation
stuff [3,4]), so that will likely miss this merge window.

Bjorn

> 1 - https://lore.kernel.org/linux-pci/20230111125323.1911373-4-daire.mcnamara@microchip.com/

[2] https://lore.kernel.org/r/Y9uiWscjKQpD7JvE@lpieralisi
[3] https://lore.kernel.org/r/Y9uebWEvuJYO31j1@lpieralisi
[4] https://lore.kernel.org/r/8dfc14be-a978-d84b-52e4-d421599fc783@arm.com
