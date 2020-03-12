Return-Path: <SRS0=YI0I=45=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E51C10DCE
	for <linux-modules@archiver.kernel.org>; Thu, 12 Mar 2020 06:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6733C20578
	for <linux-modules@archiver.kernel.org>; Thu, 12 Mar 2020 06:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Dk6p7kIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbgCLGxU (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 12 Mar 2020 02:53:20 -0400
Received: from forward105o.mail.yandex.net ([37.140.190.183]:33965 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387831AbgCLGxT (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 12 Mar 2020 02:53:19 -0400
Received: from forward100q.mail.yandex.net (forward100q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb97])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id B3FAA4202F52
        for <linux-modules@vger.kernel.org>; Thu, 12 Mar 2020 09:53:16 +0300 (MSK)
Received: from mxback5q.mail.yandex.net (mxback5q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:b716:ad89])
        by forward100q.mail.yandex.net (Yandex) with ESMTP id B07777080019
        for <linux-modules@vger.kernel.org>; Thu, 12 Mar 2020 09:53:16 +0300 (MSK)
Received: from vla4-a16f3368381d.qloud-c.yandex.net (vla4-a16f3368381d.qloud-c.yandex.net [2a02:6b8:c17:d85:0:640:a16f:3368])
        by mxback5q.mail.yandex.net (mxback/Yandex) with ESMTP id PhV7Ars6mq-rGoqFAEI;
        Thu, 12 Mar 2020 09:53:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1583995996;
        bh=5sngX1X65618H8XEfFWIY7RCm3QBVbYtHH9WSKqRzxA=;
        h=In-Reply-To:Date:References:To:From:Subject:Message-ID;
        b=Dk6p7kISj3Y5WLvwhH64+/p8uoBfnm6zos1z1vXJS9xcQQJwHiF1TwjGhz1H5ZUO+
         lQ32lNqIDa/b7qy1pPEbYdHd6Mo6uuEIndi/tAxgN8PrnIsCSZzxBJkJcY614DAzwp
         6GRpOX8iZdfPZTLjKcOfPULo7wk/AmXcO3qrJsMg=
Authentication-Results: mxback5q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla4-a16f3368381d.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id oViXAF7snZ-rGZeTg1B;
        Thu, 12 Mar 2020 09:53:16 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [RFE] Who's using a module?
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     linux-modules@vger.kernel.org
References: <b623f4a2-8b9b-edd9-3546-281155d90d4a@yandex.ru>
Message-ID: <53f0a2d1-51ba-51a7-2362-083c5248a0c4@yandex.ru>
Date:   Thu, 12 Mar 2020 09:53:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <b623f4a2-8b9b-edd9-3546-281155d90d4a@yandex.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Once in a while there's a need to remove a module (for example because you rebuilt it, or to reload it with different parameters, or whatever…). And then doing `rmmod modulename` and `modprobe -r modulename` gives:

     rmmod: ERROR: Module modulename is in use

If you're lucky, firing up `lsmod | grep modulename` will get you offenders inside "used by" column. But often there's nothing except the count above zero. It is very easy to reproduce if you check `lsmod` output for your graphics driver. I checked it on `i915` and `amdgpu`: when graphics session is opened you can't remove it and `lsmod` doesn't show who's using it.

There's very popular and old question on SO¹ that at the moment has over 55k views, and the only answer that seem to work for people is insanely big and convoluted; it is using a custom kernel driver and kernel tracing capabilities. I guess this amount of research means: no, currently there's no easy way to get who's using a module.

It would be amazing if kernel has capability to figure out who's using a module.

1: https://stackoverflow.com/questions/448999/is-there-a-way-to-figure-out-what-is-using-a-linux-kernel-module

P.S.: please, add me to CC when replying, I'm not subscribed to the list.
P.P.S: it's a resend since the previous email apparently got lost.
