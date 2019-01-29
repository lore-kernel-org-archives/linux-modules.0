Return-Path: <SRS0=upSm=QF=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224E6C169C4
	for <linux-modules@archiver.kernel.org>; Tue, 29 Jan 2019 17:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8B02087E
	for <linux-modules@archiver.kernel.org>; Tue, 29 Jan 2019 17:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfA2RW7 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:22:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfA2RW7 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Jan 2019 12:22:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50E5741A26;
        Tue, 29 Jan 2019 17:22:59 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-117-34.ams2.redhat.com [10.36.117.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E543A179CB;
        Tue, 29 Jan 2019 17:22:42 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-modules <linux-modules@vger.kernel.org>,
        ykaliuta@redhat.com
Subject: Re: [PATCH kmod] libkmod-signature: implement pkcs7 parsing with openssl
References: <20190125133808.27363-1-yauheni.kaliuta@redhat.com>
        <CAKi4VA+Zy==+=UzzghN261tcukcPBd0B5dyTjNXbCTEYyXyY5A@mail.gmail.com>
        <xunyk1ir8yxs.fsf@redhat.com>
        <CAKi4VA+YGwBqg6kDb9mrgxqm7X4UCQD-Tu9PqXhm6bbRrG5Uaw@mail.gmail.com>
        <xunybm3z94j6.fsf@redhat.com>
        <20190129165010.kkcd3xrdgpf3uqkc@ldmartin-desk.jf.intel.com>
Date:   Tue, 29 Jan 2019 19:22:43 +0200
In-Reply-To: <20190129165010.kkcd3xrdgpf3uqkc@ldmartin-desk.jf.intel.com>
        (Lucas De Marchi's message of "Tue, 29 Jan 2019 08:50:10 -0800")
Message-ID: <xunyva27750c.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 29 Jan 2019 17:22:59 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

>>>>> On Tue, 29 Jan 2019 08:50:10 -0800, Lucas De Marchi  wrote:

 > On Tue, Jan 29, 2019 at 11:50:05AM +0200, Yauheni Kaliuta wrote:
 >> Hi, Lucas!
 >> 
 >>>>>>> On Mon, 28 Jan 2019 10:05:24 -0800, Lucas De Marchi  wrote:
 >> > On Sat, Jan 26, 2019 at 3:01 AM Yauheni Kaliuta
 >> > <yauheni.kaliuta@redhat.com> wrote:
 >> >>
 >> 
 >> [...]
 >> >> >> +
 >> >> >> +       pvt->cms = cms;
 >> >> >> +       pvt->key_id = key_id_str;
 >> >> >> +       pvt->sno = sno_bn;
 >> >> >> +       sig_info->private = pvt;
 >> >>
 >> >> > why do you keep pvt around if the only thing you will do with
 >> >> > it later is to free it?
 >> >> > AFAICS the only thing that needs to remain around is the str
 >> >> > so we can free it after the user used it (because normal
 >> >> > signature is backed in memory by the mem object, while these
 >> >> > are openssl structs)
 >> >>
 >> >> I should keep them until kmod_module_get_info() makes the copies.
 >> >>
 >> >> cms is openssl struct
 >> >> sno_bn is allocated by openssl and must be freed later
 >> >> key_id_str is allocated here since the size in unknown in advance
 >> >> and must be freed later.
 >> >>
 >> >> Or what did I miss?
 >> 
 >> > we could just duplicate the information that we want stored and keep
 >> > the openssl context contained
 >> > to just this function. I thought the only one would be key_str_id, but
 >> > missed that sig and signer
 >> > also need to have their backing object around.
 >> 
 >> If I duplicate it here then without cleanup I'll have memory
 >> leak, no?

 > yes, my idea was to just leave it simpler and add a

 > if (pkcs7)
 >        free(key_id)

Ah, got it, thanks!

Well, if it's not a show stopper for you, I would rather keep it
as in the original proposal since it does not inject
implementation details to the upper level.

 > Lucas De Marchi

 >> 
 >> In the old code they were pointers inside the module image and
 >> freed with the image itself.
 >> 
 >> -- 
 >> WBR,
 >> Yauheni Kaliuta


-- 
WBR,
Yauheni Kaliuta
