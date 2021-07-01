Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7EBC11F64
	for <linux-modules@archiver.kernel.org>; Thu,  1 Jul 2021 16:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93929613E3
	for <linux-modules@archiver.kernel.org>; Thu,  1 Jul 2021 16:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhGAQ2X (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhGAQ2X (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 1 Jul 2021 12:28:23 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD39AC061762
        for <linux-modules@vger.kernel.org>; Thu,  1 Jul 2021 09:25:51 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id r4-20020a0568301204b029047d1030ef5cso161586otp.12
        for <linux-modules@vger.kernel.org>; Thu, 01 Jul 2021 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=AFwJc8ho+bs+aAImi2kEPoBHTQSAvoUULI/CUwslYp0=;
        b=T1oQwkyUAegQHoU8i/DbxGhSazL4v8dZJ7TWdnWZWS4Bsv7XqT/uswiD6by3cYjwHu
         Hw9kF71AeAUHomog41JoLVs2MGK/0HeeU5xfqYnradFg/X9Jp17nFPMWXY8gnA5PBYpQ
         2ZmKUK0LZusPaF8T2pzQPaKCCPpiRW6tfLVGEuVEfHiUHPf2sCvSEugAXGtAOMjP0ag+
         YzN0cq+a4gVdHluj2g6rSwtEnU2qIm8rvvnDu8Rgm38Yrntagxugifwzlpq6Qt9AsEEb
         BWSpnP2cCKWVLAOhExaby8DmRuFxw359QK5jna72MH2exFYG6cEAcrJXwh4MRejiGUZS
         6eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=AFwJc8ho+bs+aAImi2kEPoBHTQSAvoUULI/CUwslYp0=;
        b=SZmSYZU9Z0KAvppMKMCEjZWSCsSTgv2zpVBmb8yUiBzvPr4qfgzFV11AZQe7FywkOT
         mvD8FfIB7GkEqn1/kn9/1Y/SjI6eP90jg54LgNJiAQqBxb6JDUuoTSq2r2SbDBJWgeyo
         a232fD15NnAgX5ZjCjiojgdJmP0RBBf+L0pvrKOEkEr+DxR0kHg+s0LVCiOePqZnG3Js
         7qt5EdnVPXpqOtLvvqniLY5JJ5to8h7Ij8psfrrLBQJgcK6ZmlzFexjrDnauyCwgSeuw
         pKCJw9waLTI3lfWvMQPKzFszt2cJq4T2YoCr8XVVe1hbMofIMrgpO/2PUQ4gZc9xbdbI
         BTxw==
X-Gm-Message-State: AOAM533G6ZqtstcH6/uuQIUM5E5hb190PikvS6xjhSYx0Qhf4Yq+Q1df
        SPf+dBdhKhwhlB09XsCgxc41wNA+6nM=
X-Google-Smtp-Source: ABdhPJxGe5awT3F/p4PEnEgsPtC7V+bZvUh7qvvFiC/FSwDe/AnHi5oQwo/ZgT2FgekWMzMAw6HZyQ==
X-Received: by 2002:a9d:862:: with SMTP id 89mr698252oty.276.1625156751159;
        Thu, 01 Jul 2021 09:25:51 -0700 (PDT)
Received: from ian.penurio.us ([47.184.51.90])
        by smtp.gmail.com with ESMTPSA id x3sm81950oie.24.2021.07.01.09.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 09:25:50 -0700 (PDT)
X-Mozilla-News-Host: news://lore.kernel.org:119
To:     linux-modules@vger.kernel.org, kernelnewbies@kernelnewbies.org
From:   Ian Pilcher <arequipeno@gmail.com>
Subject: Seeking advice on "monkey patching" a driver
Message-ID: <30faa352-0f60-10b9-887e-b2ee522d0a16@gmail.com>
Date:   Thu, 1 Jul 2021 11:25:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

I maintain a couple of out-of-tree modules that enable "mainstream"
distributions to be used on the Thecus N5550 NAS.

  https://github.com/ipilcher/n5550/tree/master/modules

The disk activity LEDs in this NAS are software controlled, so the
n5550_ahci_leds module exists to "inject" a wrapper around libahci's
qc_issue() function which triggers the correct LED (if any).

 
https://github.com/ipilcher/n5550/blob/25538096fffd7942be8b7f2c66af580620a422b6/modules/n5550_ahci_leds.c#L225

It's certainly a hack, but it makes use of the modules much simpler, as
there's no need to patch and rebuild libahci, override the distro-
provided module, etc.  As long as modprobe is configured to load
n5550_ahci_leds immediately after libahci and before any consumers of
libahci are loaded, things "just work".

The current version of n5550_ahci_leds attempts to ensure that no
libahci consumers are loaded before it modifies libahci's
ahci_ops.qc_issue.  It does this by:

   * locking module_mutex
   * getting a reference to the libahci module (with find_module())
   * checking libahci's reference count
   * grabbing a reference to *itself* to prevent itself from being
     unloaded
   * modifying ahci_ops.qc_issue
   * unlocking module_mutex

(There similar logic in the n5550_ahci_leds_enabled_store function to
reverse the modifications, if no other libahci consumers are loaded.)

It's very possible that some or all of these precautions are
unnecessary (or that they're inadequate).  I am most definitely not an
expert at kernel development or the details of the kernel's module
loading mechanism.  I and few others have, however, been successfully
using these modules for a number of years.

I've just discovered that neither module_mutex nor find_module() are
available in recent kernels, and I'm unsure how to proceed.  The two
options that I've been able to think of thus far are:

* YOLO!  I can simply remove the checks from the module and rely on user
   space to ensure that n5550_ahci_leds is loaded before any libahci
   consumers load (i.e. before udevd starts).

* kprobes - I have a feeling that this is the "correct" way to do this
   (and it would have the benefit of working even if libahci or its
   consumers aren't built as modules).  OTOH, it isn't clear how I would
   go about accessing the arguments passed into the function without
   JProbes, and I'm not thrilled with the idea of adding additional
   overhead and/or locking to the disk I/O path.

I'd really appreciate any thoughts, advice, ideas, links etc.

Thanks!

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================
