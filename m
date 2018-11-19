Return-Path: <SRS0=h9Xf=N6=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D2AC43441
	for <linux-modules@archiver.kernel.org>; Mon, 19 Nov 2018 23:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC0E2080C
	for <linux-modules@archiver.kernel.org>; Mon, 19 Nov 2018 23:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qroKxBne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC0E2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbeKTKGu (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:06:50 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:50596 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbeKTKGu (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 20 Nov 2018 05:06:50 -0500
Received: by mail-wm1-f41.google.com with SMTP id 125so409835wmh.0
        for <linux-modules@vger.kernel.org>; Mon, 19 Nov 2018 15:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Drz0qIiR4ibFWu0gsSkbWcNr5BgvsWA/h21/nt24HLM=;
        b=qroKxBneO1OVMNQLfIIPiTX++qa5PGl1KYeVrei5QhBWezgzkxlCHn6MOoArWLLM8c
         XcpkFvQfw3690re0jNH/Ryt2qbCYZqZm2NUXx9Il3hMEmSwhBbEM66wFPWSvsgU988qS
         WQWI4D9UL2Psl+DTAyVVqJCYxTaS1ySCfqck/DGS0YNTzCGcBe4sYtz0pg9BTB8ALSq+
         VJjFom4sXEHkI/HNdMBD5nHvrwMSQ510Lmnhe9Tq4BTPkVU06X08n5gc/qSXllw0hP/Z
         nLH1iLx+rJrN2QgLprc6wU67Si4CAK0cKgIcJANFR6Q6n8oEwYgQBqLWSbvkK68IEXRI
         Xhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Drz0qIiR4ibFWu0gsSkbWcNr5BgvsWA/h21/nt24HLM=;
        b=q3KmsHWHO/TN3aFSGpPUksv9cuvWTdUo8dScz3VV2IzT9YqWQX612g2Nv3HdPscNnw
         rVZ7NlDy+oRBwabXTRy1aLeXDq4+z5WToN3dJfbzlSKUxf21VGnAU7JYkTT8YdoeK8AJ
         qKEK/e1/fzq5swOC1dWPO12mxQOYFaEZm5y0BnBS8jZv8m7saSsmQ8n0xKuro0TCpIW8
         9ojLy493zoUAORILUL8Tm0+WuzixWH4QR6Xigv45EdkyeTH1Y0s64wuDGhhiaCTlJnTV
         2jzoj2FiAYKTui5Jfe4ZSj4iCiIoZasbFl3CpHYlhMQ+h9g/yeCdr+JevoJjJLBbIXhZ
         Djsg==
X-Gm-Message-State: AGRZ1gL0Xfcqa7gf/8pF9umobK/Sou8J92VfGAAAuqgkklTggRr+JRub
        azllqI8KmCHAmrz/f26v0OgL3J6Iy/kGwPpYkqVK0g==
X-Google-Smtp-Source: AFSGD/WKV2GoAIi1na0ZgBGcKD49Ql6Oumj5O9YJ4lemtLeK5Xri7cYZ4ghy3CYdzMAwB3YoUNFbANdXtwORRiyjq8Y=
X-Received: by 2002:a1c:bce:: with SMTP id 197-v6mr123215wml.15.1542670842435;
 Mon, 19 Nov 2018 15:40:42 -0800 (PST)
MIME-Version: 1.0
References: <xunyva4tii8c.fsf@redhat.com>
In-Reply-To: <xunyva4tii8c.fsf@redhat.com>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Mon, 19 Nov 2018 15:40:31 -0800
Message-ID: <CAKi4VA+LNKU6FSkaDFhShnt9QiZt92yyn2TJrVcjbu_JUt0oLg@mail.gmail.com>
Subject: Re: list archive
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Nov 19, 2018 at 12:29 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi!
>
> Has the list got the archives?


I was waiting to get the messages before 2011, when my archive starts.
Since no one replied, I just went ahead and sent what I have to
kernel.org admins. We  should get it on lore.kernel.org soon.


Lucas De Marchi
