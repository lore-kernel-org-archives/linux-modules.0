Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9C6C10F1E
	for <linux-modules@archiver.kernel.org>; Tue, 20 Dec 2022 06:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiLTGmh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 20 Dec 2022 01:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiLTGmh (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 20 Dec 2022 01:42:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E58D638E;
        Mon, 19 Dec 2022 22:42:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0171A6126A;
        Tue, 20 Dec 2022 06:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029F7C433EF;
        Tue, 20 Dec 2022 06:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671518555;
        bh=pJg59eEbDrTHT3EvkLJr90ygo6dXBmfxI4CFuzh7TgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n7QD3dU0Dzvmed797Zk/oNZCINLzav8FMnFFr1TUmczshyq5KmkR/uS3Lk1pOI6g1
         vNfAZtti9DlQEUs5r6OksJOMVL8XMSFj5wB//4IvssZaVBbC6cRwvu0QA42fuIuhKB
         vqSPEcMVnlQhx49xb2J+Bcxo3+q8ZAzsdvteFaT8=
Date:   Tue, 20 Dec 2022 07:42:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v9 01/10] imx: Fix typo
Message-ID: <Y6FZWOC1DSHHZNWy@kroah.com>
References: <20221219191855.2010466-1-allenwebb@google.com>
 <20221219204619.2205248-1-allenwebb@google.com>
 <20221219204619.2205248-2-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219204619.2205248-2-allenwebb@google.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Dec 19, 2022 at 02:46:09PM -0600, Allen Webb wrote:
> A one character difference in the name supplied to MODULE_DEVICE_TABLE
> breaks a future patch set, so fix the typo.

Breaking a future change is not worth a stable backport, right?  Doesn't
this fix a real issue now?  If so, please explain that.

thanks,

greg k-h
