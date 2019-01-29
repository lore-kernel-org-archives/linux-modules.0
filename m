Return-Path: <SRS0=upSm=QF=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7C2C169C4
	for <linux-modules@archiver.kernel.org>; Tue, 29 Jan 2019 09:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753CB20870
	for <linux-modules@archiver.kernel.org>; Tue, 29 Jan 2019 09:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbfA2JuK (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:50:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfA2JuK (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Jan 2019 04:50:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F21FD356E4;
        Tue, 29 Jan 2019 09:50:09 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-117-34.ams2.redhat.com [10.36.117.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DF865C6D9;
        Tue, 29 Jan 2019 09:50:04 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>, ykaliuta@redhat.com,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH kmod] libkmod-signature: implement pkcs7 parsing with openssl
References: <20190125133808.27363-1-yauheni.kaliuta@redhat.com>
        <CAKi4VA+Zy==+=UzzghN261tcukcPBd0B5dyTjNXbCTEYyXyY5A@mail.gmail.com>
        <xunyk1ir8yxs.fsf@redhat.com>
        <CAKi4VA+YGwBqg6kDb9mrgxqm7X4UCQD-Tu9PqXhm6bbRrG5Uaw@mail.gmail.com>
Date:   Tue, 29 Jan 2019 11:50:05 +0200
In-Reply-To: <CAKi4VA+YGwBqg6kDb9mrgxqm7X4UCQD-Tu9PqXhm6bbRrG5Uaw@mail.gmail.com>
        (Lucas De Marchi's message of "Mon, 28 Jan 2019 10:05:24 -0800")
Message-ID: <xunybm3z94j6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 29 Jan 2019 09:50:10 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

>>>>> On Mon, 28 Jan 2019 10:05:24 -0800, Lucas De Marchi  wrote:
 > On Sat, Jan 26, 2019 at 3:01 AM Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:
 >> 

[...]
 >> >> +
 >> >> +       pvt->cms = cms;
 >> >> +       pvt->key_id = key_id_str;
 >> >> +       pvt->sno = sno_bn;
 >> >> +       sig_info->private = pvt;
 >> 
 >> > why do you keep pvt around if the only thing you will do with
 >> > it later is to free it?
 >> > AFAICS the only thing that needs to remain around is the str
 >> > so we can free it after the user used it (because normal
 >> > signature is backed in memory by the mem object, while these
 >> > are openssl structs)
 >> 
 >> I should keep them until kmod_module_get_info() makes the copies.
 >> 
 >> cms is openssl struct
 >> sno_bn is allocated by openssl and must be freed later
 >> key_id_str is allocated here since the size in unknown in advance
 >> and must be freed later.
 >> 
 >> Or what did I miss?

 > we could just duplicate the information that we want stored and keep
 > the openssl context contained
 > to just this function. I thought the only one would be key_str_id, but
 > missed that sig and signer
 > also need to have their backing object around.

If I duplicate it here then without cleanup I'll have memory
leak, no?

In the old code they were pointers inside the module image and
freed with the image itself.

-- 
WBR,
Yauheni Kaliuta
