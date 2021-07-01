Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C70C11F64
	for <linux-modules@archiver.kernel.org>; Thu,  1 Jul 2021 20:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149836138C
	for <linux-modules@archiver.kernel.org>; Thu,  1 Jul 2021 20:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhGAUFq (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 1 Jul 2021 16:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhGAUFp (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 1 Jul 2021 16:05:45 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2380C061762
        for <linux-modules@vger.kernel.org>; Thu,  1 Jul 2021 13:03:13 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 11so8706367oid.3
        for <linux-modules@vger.kernel.org>; Thu, 01 Jul 2021 13:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QYvNsiXvlZdfrYCb5R2SsjmErchboI2vPnEgtjPZt24=;
        b=EwVQpvRNr+u3T/pCuYKQPyGh35PKfRCBAzqGvpBTg0f57rig6IKsPY1shlVCUj0k+I
         AYL3+XwkhC4sLe0yLiLFhMhMkUJwl9jAccqGZu0aX5J/KUuEC+fZlYsWm0KslTuWkWqi
         xFRp7PimOSVgA+do+lqn2p4HBolOcpJtXYFS0MNlAS29SVxHb3vKa3LRKWvQTzVAhhh+
         3DeupdYHT72KVvph4kS8LVVb24oYOKw54vMYlRzLvvs1//zB44Pykj9T/k83wZVJWoe+
         YMe89nEop3zOVajsnX2x2O0ArgNf4M7cx6XDDbP3/1zF1z4xlbqmq015QXdCOxryhc+D
         30BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QYvNsiXvlZdfrYCb5R2SsjmErchboI2vPnEgtjPZt24=;
        b=hK2Ho0CbqWpqBTPYnWXKAeggsvG3dVwEmTL1NZmhO+VCZJqcpKasY9rI2TrAE5w+Rk
         42SLrI5GfUR/mB1ocT0mxliWMCqnENBw6RDLZEGSf8QroT00g+db6btx87heYBYIWGQ8
         +5ZxUUbn8dhFYyTTSdjNEGOyA9xeFtZXlPKTdY5BdGiqmcB8PYSMwAbyuJipdDndhpqO
         3SR49vNAbfR6da4xvTasWhE8g1hun9twJz0aUCKnpRF4nRiFojMDSz6AhMNwLDe9XDXQ
         0fBS1UBTogKKb2+0L7/zKP0JCVp2OotJQVXWq0Vhk9AY8a/kGv2yCh1dKi1cYKZKZRUF
         iBcg==
X-Gm-Message-State: AOAM5324SlRNDnqmBXX0QKg4A1uXdR6Ja2gjwCutJfIawtOQ3HtLcSSy
        XhCxJ5sLse39keQyW6cG/ORPCv0q3Oo=
X-Google-Smtp-Source: ABdhPJymgGW87p2llzEiPAsMFZzaMQy1DCKMaoQcLbkb1IoLhbdSrHuKYN8iUKfUpEYnfjVYglzauw==
X-Received: by 2002:aca:ad52:: with SMTP id w79mr1020492oie.86.1625169793338;
        Thu, 01 Jul 2021 13:03:13 -0700 (PDT)
Received: from ian.penurio.us ([47.184.51.90])
        by smtp.gmail.com with ESMTPSA id j22sm140680otl.46.2021.07.01.13.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 13:03:12 -0700 (PDT)
Subject: Re: Seeking advice on "monkey patching" a driver
To:     Greg KH <greg@kroah.com>
Cc:     linux-modules@vger.kernel.org, kernelnewbies@kernelnewbies.org
References: <30faa352-0f60-10b9-887e-b2ee522d0a16@gmail.com>
 <YN4Ccf96sqMoPJM3@kroah.com>
From:   Ian Pilcher <arequipeno@gmail.com>
Message-ID: <b6e41740-94b7-e32e-5d57-deb7b730b2d9@gmail.com>
Date:   Thu, 1 Jul 2021 15:03:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YN4Ccf96sqMoPJM3@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 7/1/21 12:59 PM, Greg KH wrote:
> Oh that's horrible, please no, do not do that :)

Indeed it is, but it works, and it meets my main objective, which is to
allow the use of distribution kernel packages and modules.

> How about a third option, the correct one:
> 	- submit your code changes upstream and they get merged into the
> 	  main kernel tree and no monkeypatching is ever needed at all!
> 
> Have you submitted your changes upstream to the existing drivers?  What
> is preventing that from happening today?

There are a couple of reasons that I've never attempted to do this.

* Scope of work - Currently, there is simply no mechanism to call an LED
   trigger from the ahci or libahci modules, presumably because this is
   something that  really ought to be done by the hardware.  So I would
   have to add some sort of generic framework to associate LED triggers
   with AHCI ports.

   I probably also don't really have the knowledge to do this.  I am not
   familiar with locking, memory management, etc. in the kernel.  Just
   because my "hack" works on a specific 2-core NAS doesn't mean that it
   won't cause all sorts of breakage on a higher-performance system with
   more parallelism.

* (Probable) lack of upstream interest - As I mentioned, disk activity
   LEDs really ought to be handled by the hardware.  I don't know of any
   other system that suffers from this particular limitation.  So this
   is a very, very niche use case.  (Most users of this hardware use the
   manufacturer's "firmware".)

   I did ask about this on the linux-ide mailing list long ago when I
   first wrote the modules, but I don't think that I ever received a
   response, which reinforces my belief that upstream isn't likely to be
   receptive.

I've invested significant time in kernel patches in the past, only to
see them ultimately not be accepted, so I would need to know that
upstream was truly interested in such a feature before I would consider
making such a commitment.

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================
