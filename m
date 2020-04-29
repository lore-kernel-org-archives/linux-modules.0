Return-Path: <SRS0=EbFF=6N=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6B4C83003
	for <linux-modules@archiver.kernel.org>; Wed, 29 Apr 2020 08:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB99206D9
	for <linux-modules@archiver.kernel.org>; Wed, 29 Apr 2020 08:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnaJ2uu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgD2IYt (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:24:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30453 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726366AbgD2IYt (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 29 Apr 2020 04:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588148688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GpKAT3+Sw38fLfhMFmA3rWSib4LfvOT/wJINooksYKc=;
        b=WnaJ2uu3OJxVjP3J8wtNQrJtkwnHnAWWQ/BZu6SGy3Ibnw6nKFwb4PLzm+3eeKtySccQmW
        LKEhAxMdR2k+59qUyJd4sHy5PacEkeikkEBNVgHqLt+QgWpQ8VcyeoypgDUDO2K0eaoGoC
        Q7h9G0fXJ1B9SyjMADaV37yhwaaaGlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-8VOVJAV1NlK3s8TiK-dYSA-1; Wed, 29 Apr 2020 04:24:44 -0400
X-MC-Unique: 8VOVJAV1NlK3s8TiK-dYSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E725107ACCA;
        Wed, 29 Apr 2020 08:24:43 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-113-1.ams2.redhat.com [10.36.113.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76F31600D2;
        Wed, 29 Apr 2020 08:24:42 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-modules <linux-modules@vger.kernel.org>
Subject: Re: exit from log_printf()
References: <xuny7dy1glgs.fsf@redhat.com>
        <CAKi4VALCzXJdZY-ABC-tZ=wpyfM0m-CE02FdZ3nDD2q-AE8kog@mail.gmail.com>
Date:   Wed, 29 Apr 2020 11:24:40 +0300
In-Reply-To: <CAKi4VALCzXJdZY-ABC-tZ=wpyfM0m-CE02FdZ3nDD2q-AE8kog@mail.gmail.com>
        (Lucas De Marchi's message of "Tue, 28 Apr 2020 23:44:03 -0700")
Message-ID: <xuny368mhf7b.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

>>>>> On Tue, 28 Apr 2020 23:44:03 -0700, Lucas De Marchi  wrote:

 > On Mon, Apr 27, 2020 at 5:31 AM Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:
 >> 
 >> Hi, Lucas!
 >> 
 >> I have a question about exit call from tools/log.c:log_printf()
 >> (https://github.com/lucasdemarchi/kmod/blob/master/tools/log.c#L140)
 >> 
 >> What is the reasoning behind that?
 >> 
 >> At the first glance it looks a bit incorrect (pretty surprising
 >> to have exit in print()).

 > If we log a critical error, there's nothing we can do except
 > exit.  Note that this is only used by the binaries, not the
 > library.

So, it should not be fatal then, right? See the usecase below.


 > There's potential for abuse, but it's pretty common to have
 > something with that behavior.

 > Lucas De Marchi

 >> 
 >> Discovered while trying to remove several modules when one of
 >> them cannod be removed:
 >> 
 >> $ modprobe -r libata pcspkr
 >> modprobe: FATAL: Module libata is in use.
 >> 
 >> $ lsmod | grep pcsp
 >> pcspkr                 16384  0
 >> 
 >> 
 >> --
 >> WBR,
 >> Yauheni Kaliuta
 >> 


 > -- 
 > Lucas De Marchi


-- 
WBR,
Yauheni Kaliuta

