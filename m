Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D623C77B7A
	for <linux-modules@archiver.kernel.org>; Wed, 31 May 2023 05:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjEaFBo (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 31 May 2023 01:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjEaFBn (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 31 May 2023 01:01:43 -0400
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [178.154.239.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E8FE5
        for <linux-modules@vger.kernel.org>; Tue, 30 May 2023 22:01:40 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:160b:0:640:acd0:0])
        by forward502c.mail.yandex.net (Yandex) with ESMTP id 2C7E85EF01;
        Wed, 31 May 2023 08:01:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id b1Fa3rfDbKo0-q1FrHN32;
        Wed, 31 May 2023 08:01:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1685509297;
        bh=dvbJ7sQkJwNzNU6rrkmGKOaylovwa5PgToyUo1mXa7A=;
        h=Subject:From:In-Reply-To:Cc:Date:References:To:Message-ID;
        b=WH4uQTL8hyoj9tjr/MJnTTXC33obC/rKHXSAvh6r8nd0zPSltcS7IA+LL+YZRMQgT
         3R9Xk8jXPnZtU8HLuvplzR6YuYvFoEVrsTYNZKetTgoV2hRk9LjewyIdbJEJxecYiR
         NGcII1wW3wAIUiELlFXqH8E73F8Xv6kQeAci+ZXY=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <3720aa5a-e6bc-9829-7d46-17ac65d69877@yandex.ru>
Date:   Wed, 31 May 2023 08:01:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <926001fd-34bb-83ee-be77-ccbded164615@csgroup.eu>
 <20230519074108.401180-1-dmantipov@yandex.ru>
 <ry5ekq7cvyugnvo2ykhuktmngqoq5zomtc2zvjwtevtd5s4ueo@7wwzksbprtzu>
Content-Language: en-US
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] shared: avoid passing {NULL, 0} array to bsearch()
In-Reply-To: <ry5ekq7cvyugnvo2ykhuktmngqoq5zomtc2zvjwtevtd5s4ueo@7wwzksbprtzu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 5/30/23 23:21, Lucas De Marchi wrote:

> I'd avoid the unbalanced brackets and replace the bucket->entries
> check with a return-early style. Would you be ok with me squashing this
> into your patch?

Sure as you wish.

> However I'm curious about this *runtime* error you went through. Does it
> have a backtrace? There are other places we call bsearch() passing
> bucket->entries, but that should be an imposibble runtime situation
> since we bail out on context creation if we can't create the hash table.

This one is from something running under 'make check' (note I've added sleep()
calls to have a time frame to attach gdb, so actual line numbers are shifted):

(gdb) bt
#0  0x000000000040924a in hash_find (hash=0x1034400, key=0x7fff71657d50 "btusb") at shared/hash.c:246
#1  0x0000000000405661 in kmod_pool_get_module (ctx=0x10342a0, key=0x7fff71657d50 "btusb")
     at libkmod/libkmod.c:403
#2  0x0000000000407cfe in kmod_module_new (ctx=0x10342a0, key=0x7fff71657d50 "btusb",
     name=0x7fff71657d50 "btusb", namelen=5, alias=0x0, aliaslen=0, mod=0x7fff71658d88)
     at libkmod/libkmod-module.c:270
#3  0x0000000000407f3f in kmod_module_new_from_name (ctx=0x10342a0, name=0x7fff71658d90 "btusb",
     mod=0x7fff71658d88) at libkmod/libkmod-module.c:341
#4  0x000000000040824b in kmod_module_new_from_loaded (ctx=0x10342a0, list=0x7fff71659df8)
     at libkmod/libkmod-module.c:1736
#5  0x000000000040262a in loaded_1 (t=0x40c0b8 <sloaded_10>) at testsuite/test-loaded.c:41
#6  0x0000000000402be9 in test_run_spawned (t=0x40c0b8 <sloaded_10>) at testsuite/testsuite.c:151
#7  0x0000000000404d3e in test_run (t=0x40c0b8 <sloaded_10>) at testsuite/testsuite.c:1080
#8  0x00000000004028ac in main (argc=3, argv=0x7fff7165a038) at testsuite/test-loaded.c:91

(gdb) bt full
#0  0x000000000040924a in hash_find (hash=0x1034400, key=0x7fff71657d50 "btusb") at shared/hash.c:246
         keylen = 5
         hashval = 2921571348
         pos = 20
         bucket = 0x1034558
         se = {key = 0x7fff71657d50 "btusb", value = 0x0}
         entry = 0x0
(More stack frames follow...)

(gdb) p *((struct hash_bucket *)0x1034558)
$1 = {entries = 0x0, used = 0, total = 0}

That is, the bucket is non-NULL but empty, so bsearch() is called
as bsearch([whatever], NULL, 0, [some more stuff]). On my system
(Fedora 38 with glibc 2.37), bsearch() is declared as:

extern void *bsearch (const void *__key, const void *__base,
                       size_t __nmemb, size_t __size, __compar_fn_t __compar)
      __nonnull ((1, 2, 5));

So NULL '__base' causes the sanitizer to complain.

Dmitry
