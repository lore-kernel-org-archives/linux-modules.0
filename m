Return-Path: <SRS0=njZi=QB=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05D4C282C0
	for <linux-modules@archiver.kernel.org>; Fri, 25 Jan 2019 13:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84452085B
	for <linux-modules@archiver.kernel.org>; Fri, 25 Jan 2019 13:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfAYNkZ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:40:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfAYNkZ (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 25 Jan 2019 08:40:25 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D856A89ADF;
        Fri, 25 Jan 2019 13:40:24 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-117-34.ams2.redhat.com [10.36.117.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42D5E1048117;
        Fri, 25 Jan 2019 13:40:22 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-modules <linux-modules@vger.kernel.org>,
        Ferry van Steen <Ferry.van.Steen@citrus.nl>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH RFC PKCS7 asn1c 0/2] asn1c version of PKCS#7 parser
References: <20180308135810.4309-1-yauheni.kaliuta@redhat.com>
        <xunyva2gfon3.fsf@redhat.com>
        <20190122210351.4484098d@kitsune.suse.cz>
        <CAKi4VALJcbwq2SKpb3fBw022gBO1kBe0qL9=Vszg2OOBps+dtA@mail.gmail.com>
        <20190122230703.1635f8ca@naga>
Date:   Fri, 25 Jan 2019 15:40:22 +0200
In-Reply-To: <20190122230703.1635f8ca@naga> ("Michal \=\?utf-8\?Q\?Such\=C3\=A1n\?\=
 \=\?utf-8\?Q\?ek\=22's\?\= message of
        "Tue, 22 Jan 2019 23:07:03 +0100")
Message-ID: <xunyr2d097p5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 25 Jan 2019 13:40:25 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi, Michal!

>>>>> On Tue, 22 Jan 2019 23:07:03 +0100, Michal Suchánek  wrote:

 > On Tue, 22 Jan 2019 12:43:45 -0800
 > Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:

 >> On Tue, Jan 22, 2019 at 12:03 PM Michal Suchánek <msuchanek@suse.de>
 >> wrote:
 >> >
 >> > On Tue, 22 Jan 2019 22:01:04 +0200
 >> > Yauheni Kaliuta <yauheni.kaliuta@redhat.com> wrote:
 >> >  
 >> > > Hi!
 >> > >
 >> > > Looks like OpenSUSE took the RFC patch.
 >> > >
 >> > > The diverging doesn't sound nice, frankly speaking.  
 >> >
 >> > Is there an upstream solution?
 >> >
 >> > The diverging is caused by lack of support upstream.  
 >> 
 >> Mea culpa for not deciding with which implementation to go for the
 >> next release. We actually have 3 possible implementations: one with
 >> openssl, one with gnutls and
 >> this one lifting the implementation from the kernel to be used in
 >> userspace.

 > This is not really about lifting the kernel implementation. It is more
 > about using a parser generator to generate code that parses the
 > signature. asn1c is specialized on asn1 encoded data such as the PKCS#7
 > signature.

 >> 
 >> It would be good to know from downstream their preference to weigh in
 >> the decision.

 > I think with the size of initrd currently in openSUSE nobody will
 > notice a crypto library or two added. For other distributions 0.5M size
 > increase in ramdisk may be more noticeable.

 >  15M /boot/initrd-4.19.4-1-default
 > 1.7M /usr/lib64/libgnutls.so.30.22.0
 > 437K /usr/lib64/libssl.so.1.1

 > Between gnutls and openssl my impression is that openssl is
 > more likely to be included with other tools anyway in more
 > featureful ramdisks (ie.  kdump over ssh or live system over
 > https will need SSL). openssl is is also smaller of the two.

Fine. I've resent the openssl version. If you know anybody,
security related, for review, I would appriciate for it.

-- 
WBR,
Yauheni Kaliuta
