Return-Path: <SRS0=+TOZ=P6=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1807C282C3
	for <linux-modules@archiver.kernel.org>; Tue, 22 Jan 2019 22:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48FE21850
	for <linux-modules@archiver.kernel.org>; Tue, 22 Jan 2019 22:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfAVWHH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:07:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:40336 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725925AbfAVWHG (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 22 Jan 2019 17:07:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8CB22AE6B;
        Tue, 22 Jan 2019 22:07:05 +0000 (UTC)
Date:   Tue, 22 Jan 2019 23:07:03 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        linux-modules <linux-modules@vger.kernel.org>,
        Ferry van Steen <Ferry.van.Steen@citrus.nl>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH RFC PKCS7 asn1c 0/2] asn1c version of PKCS#7 parser
Message-ID: <20190122230703.1635f8ca@naga>
In-Reply-To: <CAKi4VALJcbwq2SKpb3fBw022gBO1kBe0qL9=Vszg2OOBps+dtA@mail.gmail.com>
References: <20180308135810.4309-1-yauheni.kaliuta@redhat.com>
        <xunyva2gfon3.fsf@redhat.com>
        <20190122210351.4484098d@kitsune.suse.cz>
        <CAKi4VALJcbwq2SKpb3fBw022gBO1kBe0qL9=Vszg2OOBps+dtA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, 22 Jan 2019 12:43:45 -0800
Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:

> On Tue, Jan 22, 2019 at 12:03 PM Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > On Tue, 22 Jan 2019 22:01:04 +0200
> > Yauheni Kaliuta <yauheni.kaliuta@redhat.com> wrote:
> >  
> > > Hi!
> > >
> > > Looks like OpenSUSE took the RFC patch.
> > >
> > > The diverging doesn't sound nice, frankly speaking.  
> >
> > Is there an upstream solution?
> >
> > The diverging is caused by lack of support upstream.  
> 
> Mea culpa for not deciding with which implementation to go for the
> next release. We actually have 3 possible implementations: one with
> openssl, one with gnutls and
> this one lifting the implementation from the kernel to be used in userspace.

This is not really about lifting the kernel implementation. It is more
about using a parser generator to generate code that parses the
signature. asn1c is specialized on asn1 encoded data such as the PKCS#7
signature.

> 
> It would be good to know from downstream their preference to weigh in
> the decision.

I think with the size of initrd currently in openSUSE nobody will
notice a crypto library or two added. For other distributions 0.5M size
increase in ramdisk may be more noticeable.

 15M /boot/initrd-4.19.4-1-default
1.7M /usr/lib64/libgnutls.so.30.22.0
437K /usr/lib64/libssl.so.1.1

Between gnutls and openssl my impression is that openssl is more likely
to be included with other tools anyway in more featureful ramdisks (ie.
kdump over ssh or live system over https will need SSL). openssl is
is also smaller of the two.

Thanks

Michal
