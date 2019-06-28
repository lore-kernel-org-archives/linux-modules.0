Return-Path: <SRS0=4apf=U3=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99481C4321A
	for <linux-modules@archiver.kernel.org>; Fri, 28 Jun 2019 13:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3CA2083B
	for <linux-modules@archiver.kernel.org>; Fri, 28 Jun 2019 13:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfF1NQi (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:16:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11853 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfF1NQi (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 28 Jun 2019 09:16:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3E1130C5844
        for <linux-modules@vger.kernel.org>; Fri, 28 Jun 2019 13:16:37 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-97.ams2.redhat.com [10.36.117.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43F3E5D705
        for <linux-modules@vger.kernel.org>; Fri, 28 Jun 2019 13:16:37 +0000 (UTC)
To:     linux-modules@vger.kernel.org
From:   Harald Hoyer <harald@redhat.com>
Subject: multiple softdeps
Openpgp: preference=signencrypt
Autocrypt: addr=harald@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0bfb6f60-0042-f6be-24ed-7803b6ac759c@redhat.com>
Date:   Fri, 28 Jun 2019 15:16:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 28 Jun 2019 13:16:37 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi,

could you please enlighten me about kernel module softdeps?

$ modinfo cifs | grep soft
softdep:        pre: ccm
softdep:        pre: aead2
softdep:        pre: sha512
softdep:        pre: sha256
softdep:        pre: cmac
softdep:        pre: aes
softdep:        pre: nls
softdep:        pre: md5
softdep:        pre: md4
softdep:        pre: hmac
softdep:        pre: ecb
softdep:        pre: des
softdep:        pre: arc4

$ grep cifs /lib/modules/$(uname -r)/modules.softdep
softdep cifs pre: ccm
softdep cifs pre: aead2
softdep cifs pre: sha512
softdep cifs pre: sha256
softdep cifs pre: cmac
softdep cifs pre: aes
softdep cifs pre: nls
softdep cifs pre: md5
softdep cifs pre: md4
softdep cifs pre: hmac
softdep cifs pre: ecb
softdep cifs pre: des
softdep cifs pre: arc4

But, calling kmod_module_get_softdeps() on the cifs module only returns one module in the pre list ("ccm").

Is my understanding about how softdeps work wrong, or is the cifs module misconfigured, or is libkmod buggy?
Please CC me, as I am not subscribed to the mailing list.


softdeps-test.c:

#include <stdio.h>
#include <libkmod.h>
#include <stdlib.h>

int main() {
    int err;
    struct kmod_ctx *ctx = NULL;
    struct kmod_list *list = NULL;
    struct kmod_list *modpre = NULL;
    struct kmod_list *modpost = NULL;
    struct kmod_list *itr, *l;

    ctx = kmod_new(NULL, NULL);

    err = kmod_module_new_from_lookup(ctx, "cifs", &list);
    if (err < 0) {
        perror("kmod_module_new_from_lookup");
        return EXIT_FAILURE;
    }

    kmod_list_foreach(l, list) {
        struct kmod_module *mod = NULL;
        mod = kmod_module_get_module(l);

        kmod_module_get_softdeps(mod, &modpre, &modpost);

        kmod_list_foreach(itr, modpre) {
            struct kmod_module *mod = NULL;
            const char *path = NULL;
            mod = kmod_module_get_module(itr);
            path = kmod_module_get_path(mod);
            puts(path);
        }
    }
}
