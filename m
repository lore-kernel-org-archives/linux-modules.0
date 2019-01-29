Return-Path: <SRS0=upSm=QF=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF8EC169C4
	for <linux-modules@archiver.kernel.org>; Tue, 29 Jan 2019 16:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9ED320881
	for <linux-modules@archiver.kernel.org>; Tue, 29 Jan 2019 16:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfA2QuM (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:50:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:56533 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfA2QuM (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Jan 2019 11:50:12 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 08:50:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="110749910"
Received: from shimjae-mobl.amr.corp.intel.com (HELO ldmartin-desk.jf.intel.com) ([10.254.54.232])
  by orsmga007.jf.intel.com with ESMTP; 29 Jan 2019 08:50:11 -0800
Date:   Tue, 29 Jan 2019 08:50:10 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        linux-modules <linux-modules@vger.kernel.org>,
        ykaliuta@redhat.com
Subject: Re: [PATCH kmod] libkmod-signature: implement pkcs7 parsing with
 openssl
Message-ID: <20190129165010.kkcd3xrdgpf3uqkc@ldmartin-desk.jf.intel.com>
References: <20190125133808.27363-1-yauheni.kaliuta@redhat.com>
 <CAKi4VA+Zy==+=UzzghN261tcukcPBd0B5dyTjNXbCTEYyXyY5A@mail.gmail.com>
 <xunyk1ir8yxs.fsf@redhat.com>
 <CAKi4VA+YGwBqg6kDb9mrgxqm7X4UCQD-Tu9PqXhm6bbRrG5Uaw@mail.gmail.com>
 <xunybm3z94j6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xunybm3z94j6.fsf@redhat.com>
User-Agent: NeoMutt/20180716
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jan 29, 2019 at 11:50:05AM +0200, Yauheni Kaliuta wrote:
>Hi, Lucas!
>
>>>>>> On Mon, 28 Jan 2019 10:05:24 -0800, Lucas De Marchi  wrote:
> > On Sat, Jan 26, 2019 at 3:01 AM Yauheni Kaliuta
> > <yauheni.kaliuta@redhat.com> wrote:
> >>
>
>[...]
> >> >> +
> >> >> +       pvt->cms = cms;
> >> >> +       pvt->key_id = key_id_str;
> >> >> +       pvt->sno = sno_bn;
> >> >> +       sig_info->private = pvt;
> >>
> >> > why do you keep pvt around if the only thing you will do with
> >> > it later is to free it?
> >> > AFAICS the only thing that needs to remain around is the str
> >> > so we can free it after the user used it (because normal
> >> > signature is backed in memory by the mem object, while these
> >> > are openssl structs)
> >>
> >> I should keep them until kmod_module_get_info() makes the copies.
> >>
> >> cms is openssl struct
> >> sno_bn is allocated by openssl and must be freed later
> >> key_id_str is allocated here since the size in unknown in advance
> >> and must be freed later.
> >>
> >> Or what did I miss?
>
> > we could just duplicate the information that we want stored and keep
> > the openssl context contained
> > to just this function. I thought the only one would be key_str_id, but
> > missed that sig and signer
> > also need to have their backing object around.
>
>If I duplicate it here then without cleanup I'll have memory
>leak, no?

yes, my idea was to just leave it simpler and add a

if (pkcs7)
        free(key_id)

Lucas De Marchi

>
>In the old code they were pointers inside the module image and
>freed with the image itself.
>
>-- 
>WBR,
>Yauheni Kaliuta
