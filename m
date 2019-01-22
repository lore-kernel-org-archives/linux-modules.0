Return-Path: <SRS0=+TOZ=P6=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB668C282C3
	for <linux-modules@archiver.kernel.org>; Tue, 22 Jan 2019 22:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87ABF21726
	for <linux-modules@archiver.kernel.org>; Tue, 22 Jan 2019 22:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYxc76JW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfAVWM0 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:12:26 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:45127 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfAVWMZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 22 Jan 2019 17:12:25 -0500
Received: by mail-wr1-f48.google.com with SMTP id t6so103746wrr.12
        for <linux-modules@vger.kernel.org>; Tue, 22 Jan 2019 14:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IW/EcbZ9FnQMBrJgvUknB9tPUpbsThYwAuwKWNvyejs=;
        b=jYxc76JWPH6fzhERNRPOoegJas5zR5ToQtEWo4lzWJ39wND57RxbNSl/C7RD/L95mW
         3hpwg1gjgk26Yq87w1ATTyE3rbU7YohEOR60AUsT9B89h0r4dfcCLMEhVVra2PdCyXZ+
         EnDKEUGtb+wTg7vAUKMuEzg5djb6Oa2fExvOPLRiROzKaOv08Sb5TL1VUHXYmd7aQngo
         HrwVBhkMOywUrd/YSAIig7LqTdxLikYaV20X8HYneihmsNbxMw02+rDHWIbknsXJC1f9
         9gyHsk3KjWlELQWw7cjXbH01l42trbNkAUptif6mDRQLAezFJa6KQwmZUTXw58ebog3Z
         yi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IW/EcbZ9FnQMBrJgvUknB9tPUpbsThYwAuwKWNvyejs=;
        b=NsCrBXThlB74WyFSBm/hIiL22mt/XRN/3oKVXhshWuYUKOkJt0c/woiSYBpiEHEajl
         TaNgwqyQ8Bs6tY5rjseTcszh62HeHhtDqs23UQyqMdlwcCVXXmLJCDGGZomPqOiyLx7X
         QMOtbJOCfv+auQOkX4mYRM1M64x+6k1sor6h+a6qUMzSRNdkwUouq1x9qu/0ZxNvOQFm
         0ZOZ2Rrx4HxymzukxdHTBESlgE96/szm3yjQW4OaM1GEYMlkves/dvCK03zm1k5R4oM8
         Q2wxgRJeysAk/3AMr0JDYVSEZ300QVcGYe8/ozFxspSQ6Cnpr5gdSZdNMqNs1LpuBetm
         Bnlg==
X-Gm-Message-State: AJcUukc/Bpywjbn4Y++JvY4XBGYWY6e5/cgrgdXxdMPdy5HfiQ/xvBvF
        Eil6RClxL73iccQalPW2u/RPrcRRzobabBGTR3jT4A==
X-Google-Smtp-Source: ALg8bN7rA57iCSxxW46Q3jMyYSLbz3BSK/Xfgl6mpxMMHgeXebGvvyKKmjKfCh4/qmYhfDajtn1KA4uwAOeanCY+qZw=
X-Received: by 2002:adf:80a9:: with SMTP id 38mr32577023wrl.137.1548195143913;
 Tue, 22 Jan 2019 14:12:23 -0800 (PST)
MIME-Version: 1.0
References: <20190112172219.13152-1-dkg@fifthhorseman.net> <alpine.LNX.2.02.1901121358590.612@connie.slackware.com>
 <87imyrhuxp.fsf@fifthhorseman.net>
In-Reply-To: <87imyrhuxp.fsf@fifthhorseman.net>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 22 Jan 2019 14:12:12 -0800
Message-ID: <CAKi4VAJQ_XjwcoAFCwT0x9aZMWAvNQ4OuMcEax8OALP4fqS6dA@mail.gmail.com>
Subject: Re: [kmod] Fix typo
To:     Daniel Kahn Gillmor <dkg@fifthhorseman.net>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jan 14, 2019 at 12:32 PM Daniel Kahn Gillmor
<dkg@fifthhorseman.net> wrote:
>
> On Sat 2019-01-12 13:59:47 -0800, Robby Workman wrote:
> > I *think* that was supposed to be "of any files" when it was originally
> > typed, but either works, I suppose :-)
>
> I'm fine however it gets resolved -- just please don't leave it with the
> broken text.

a little bit of archaeology:

this line originally came from the module-init-tools' man page written
in "doc/modprobe.conf.sgml".
Grepping that repo shows that it probably was a copy of
doc/depmod.conf.sgml that
had phrase "The format of <filename>depmod.conf</filename> and files
under <filename>depmod.d</filename> is simple"

So, whoever copied it over forgot to remove the "and". Not that any of
this matter... your version or the
other are perfectly fine today :)



applied,
thanks


Lucas De Marchi
