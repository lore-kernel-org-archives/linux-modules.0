Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388A6C77B72
	for <linux-modules@archiver.kernel.org>; Thu, 20 Apr 2023 09:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjDTJt1 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 20 Apr 2023 05:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjDTJtF (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 20 Apr 2023 05:49:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9006EBA;
        Thu, 20 Apr 2023 02:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C80DD646CB;
        Thu, 20 Apr 2023 09:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13C3C433D2;
        Thu, 20 Apr 2023 09:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681984043;
        bh=gyILmvU2KKxp0Zf9YYHxuLE8FyhQPxnbzPdT5lOTpPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3M3YLJ/1X2XgHGJ0lF47se2C5zNkrXwK8/E5Rk1BDqO70ZFcBgOOGiV8eM7iodPG
         cg7WwiDtxLe2pLd2aEBAsCduQko+pW3wFnUVy4PNAGuRfvPNgiZPqiLdMjgZIk1XcA
         RzHhGk5qnKyJ2w0FQFm98v/L569Rx8klrCzbK7QA=
Date:   Thu, 20 Apr 2023 11:47:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mcgrof@kernel.org, christophe.leroy@csgroup.eu,
        nick.alcock@oracle.com
Subject: Re: [PATCH v10 05/11] modpost: Track module name for built-in modules
Message-ID: <ZEEKKIPvDkbiG6-S@kroah.com>
References: <20221219204619.2205248-1-allenwebb@google.com>
 <20230406190030.968972-1-allenwebb@google.com>
 <20230406190030.968972-6-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406190030.968972-6-allenwebb@google.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Apr 06, 2023 at 02:00:24PM -0500, Allen Webb wrote:
> Keep track of the module name when processing match table symbols.

This describes _what_ you are doing here, but no explanation for _why_
you want to do this.

thanks,

greg k-h
