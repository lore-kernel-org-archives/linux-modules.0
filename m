Return-Path: <SRS0=uoCS=MW=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FD5C43441
	for <linux-modules@archiver.kernel.org>; Wed, 10 Oct 2018 21:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9B220858
	for <linux-modules@archiver.kernel.org>; Wed, 10 Oct 2018 21:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7jWUaFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9B220858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbeJKFXG (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 11 Oct 2018 01:23:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34768 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeJKFXF (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 11 Oct 2018 01:23:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id l6-v6so6962678wrt.1
        for <linux-modules@vger.kernel.org>; Wed, 10 Oct 2018 14:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCgKreiyjzIn7gkLLE0fASNYCq2qNCy1sQR+sLdlBQ0=;
        b=g7jWUaFqw1RYxUsrLDEjNIBHWhckvyRLHVRbhak76kg3csUpLzVRoUDbcKwl0kQ2ug
         6/9kIshcEtOWRKkqdgh8NJYExtMkefPnCOk3gaI3rL8DyEq/noSgiMhWDp/XNp4BqLF0
         p8ofx6AntEwXwEe6w//eGiKa9wsC+vUNR0mRSY9m0Rv1pUCjRXsePpvf1LddOB6TLPOE
         f8XCh/f3BQgD5w7t6gHmEn1+R/8NpS0Vzc1uJSHnu1W4VKAMI8oN7fsZ/z4y2/RQ+bhc
         qdMuOolbgHIxmM8sv+Aa7GxFXVE16YlZh0t24ythIDxStrkY43CMzajO2puVaj/HO+XU
         mqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCgKreiyjzIn7gkLLE0fASNYCq2qNCy1sQR+sLdlBQ0=;
        b=ra+JuGGWMorqOc3WOdVFABdLSmFPWx+SvuPk3vYnM3FszHX+SE3U3BFYSpjlpORoxv
         xRkjTr7PW6KC2dlPDiW7W28KSwsymp4xmZOlYL5IWAk1/J086d+6sHfC3iS6LDHjURRB
         frw3W3UX5K/phA4r2ekzrcD1a/MZwn79d8A1mcQ3t0YKGiPedJv8zwQTBzocZHO0tYMP
         urrY26RWT4V5XprfxRCN2oEZgxcz+SaK8RDiNl3xWU6/eaMoVgMm72Fj499OmGqxInzh
         2M86TaLAYx96sjejpJQnDK4Auysz9S7gAm67CiE/Ka9yRXPIiEFekKid0GKT1nWdC1x9
         xZJw==
X-Gm-Message-State: ABuFfohb8Qae+NUNvHQ6sZqXzBHRFQJE1IqCzOKmg4StJZNCiKGkGsKa
        sxeX4XowKKgZetQgXC+NfLRoIRSEqU4do1bDngEPHA==
X-Google-Smtp-Source: ACcGV623BGDsXnr7wapPAj9JtAyhG2J8kPdQxPAS1lBxo95V5QEIoIZ1pGOFaXFNLo694KW5Ud2Tu5YSOoE43KOnXH8=
X-Received: by 2002:adf:a447:: with SMTP id e7-v6mr25197589wra.190.1539208737596;
 Wed, 10 Oct 2018 14:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181010205016.3462-1-lucas.demarchi@intel.com> <20181010215042.GA7184@cmdeoliv-mobl2.jf.intel.com>
In-Reply-To: <20181010215042.GA7184@cmdeoliv-mobl2.jf.intel.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Wed, 10 Oct 2018 14:58:46 -0700
Message-ID: <CAKi4VA+ZoLa1VNdSKP_YMND8r=d23=ck+oB+2KEcGUpqN0TYcw@mail.gmail.com>
Subject: Re: [PATCH] mkosi: allow Clear to use test modules
To:     Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, Oct 10, 2018 at 2:51 PM Caio Marcelo de Oliveira Filho
<caio.oliveira@intel.com> wrote:
>
> On Wed, Oct 10, 2018 at 01:50:16PM -0700, Lucas De Marchi wrote:
> > Now Clear has a bundle for the kernel headers, let's use it.
> > ---
> >  testsuite/mkosi/mkosi.build | 9 ++-------
> >  testsuite/mkosi/mkosi.clear | 1 +
> >  2 files changed, 3 insertions(+), 7 deletions(-)
>
> Tested the patch with 'sudo make mkosi DISTRO=clear' and all tests
> passed.
>
> LGTM.
>

applied, thanks.

Lucas De Marchi

>
> Caio
>
>


-- 
Lucas De Marchi
