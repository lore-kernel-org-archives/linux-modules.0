Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49950C77B7A
	for <linux-modules@archiver.kernel.org>; Fri, 19 May 2023 07:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjESHEA (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 19 May 2023 03:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjESHD6 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 19 May 2023 03:03:58 -0400
X-Greylist: delayed 72220 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 May 2023 00:03:55 PDT
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49E610C6
        for <linux-modules@vger.kernel.org>; Fri, 19 May 2023 00:03:55 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2c95:0:640:f90:0])
        by forward501a.mail.yandex.net (Yandex) with ESMTP id DA9385E5FD;
        Fri, 19 May 2023 10:03:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id q3YeLPZDSCg0-zXCjXCL2;
        Fri, 19 May 2023 10:03:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1684479832;
        bh=vspJqxgQRGZfQQsdr21FuDMbF0MMrAp73ygfGBYTjHg=;
        h=Subject:From:In-Reply-To:Cc:Date:References:To:Message-ID;
        b=cK+EUOyQsdDCaVmmKK8TfJGo516MIVdvTnGEoj6ofbPEQQ8Kjtm5xlCjH6CDteqll
         KzyEI+uIKg4zZ2OY9D4+N3Ndj1nCON0RR6N1NFkvnV4HQsaN5rSjxhJ2PtvdqYv7MV
         0rYdiwQpqVv6FkYP57mTHYo89hms8k+5DT0MM1Js=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <882bbaa6-34a4-9921-6603-596834e085d6@yandex.ru>
Date:   Fri, 19 May 2023 10:03:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20230518054730.11237-1-dmantipov@yandex.ru>
 <3422a991-55ff-785b-f659-29bf65823a61@csgroup.eu>
Content-Language: en-US
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] modprobe: prefer -ENODATA over -ENOENT if no section
 found
In-Reply-To: <3422a991-55ff-785b-f659-29bf65823a61@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 5/19/23 09:52, Christophe Leroy wrote:

> Fine, but can you show the text message modprobe provides with your
> change, so that we can see if the change provides a somewhat better less
> confusing message ?

Sure, now it is expected to be:

$ modprobe --dump-modversions /lib/modules/6.2.15-300.fc38.x86_64/extra/crystalhd/crystalhd.ko.xz
modprobe: FATAL: could not get modversions of /lib/modules/6.2.15-300.fc38.x86_64/extra/crystalhd/crystalhd.ko.xz: No data available

I'm not insisting on -ENODATA, but IMO -ENOENT is not suitable in this case at all.

Dmitry

