Return-Path: <SRS0=upSm=QF=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9D3C169C4
	for <linux-modules@archiver.kernel.org>; Tue, 29 Jan 2019 18:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D384E2080F
	for <linux-modules@archiver.kernel.org>; Tue, 29 Jan 2019 18:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfA2Sen (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:34:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbfA2Sen (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Jan 2019 13:34:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 507F689ACD;
        Tue, 29 Jan 2019 18:34:43 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-117-34.ams2.redhat.com [10.36.117.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EE645D985;
        Tue, 29 Jan 2019 18:34:41 +0000 (UTC)
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
        <xunyva27750c.fsf@redhat.com>
        <20190129180345.dujswjq2c5lrjajm@ldmartin-desk.jf.intel.com>
Date:   Tue, 29 Jan 2019 20:34:43 +0200
In-Reply-To: <20190129180345.dujswjq2c5lrjajm@ldmartin-desk.jf.intel.com>
        (Lucas De Marchi's message of "Tue, 29 Jan 2019 10:03:45 -0800")
Message-ID: <xunyr2cv71oc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 29 Jan 2019 18:34:43 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

>>>>> On Tue, 29 Jan 2019 10:03:45 -0800, Lucas De Marchi  wrote:

[...]

 >> > yes, my idea was to just leave it simpler and add a
 >> 
 >> > if (pkcs7)
 >> >        free(key_id)
 >> 
 >> Ah, got it, thanks!
 >> 
 >> Well, if it's not a show stopper for you, I would rather keep it
 >> as in the original proposal since it does not inject
 >> implementation details to the upper level.

 > ok, we may revisit this later. What's the status of the test
 > for testsuite?

Haven't checked yet, sorry (caught some flu).

 > Are you going to send a v2 (3?) including the test?

Yes if everything finally works.

-- 
WBR,
Yauheni Kaliuta
