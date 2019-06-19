Return-Path: <SRS0=7sMs=US=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDD9C31E49
	for <linux-modules@archiver.kernel.org>; Wed, 19 Jun 2019 11:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44002070B
	for <linux-modules@archiver.kernel.org>; Wed, 19 Jun 2019 11:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgoNVzWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfFSLDY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:03:24 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:46576 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfFSLDY (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 19 Jun 2019 07:03:24 -0400
Received: by mail-wr1-f54.google.com with SMTP id n4so2837025wrw.13
        for <linux-modules@vger.kernel.org>; Wed, 19 Jun 2019 04:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/8f+OogZ3M30TyOF/ptBZT5LtrdWxe8YyqrFAeuCziY=;
        b=vgoNVzWbZ2XE4VePmLM5E1OtySyTXkL4e7CM/YycB5wT8gj+SWe0sF2BKtrY9of5T7
         uBzFJgnI04nUAAWE5MWheuU+U6Hk7gRjRe/85LSfYcpcJEyKmsbSdoBGAxQd+lXFqvSb
         0wpV0KYe2uPQjQDTUuT+99EFgkYoPp2NNfRZhj7EmBAFPRX4yzdwlZTwmDWvVzVL98WB
         hDuH9jg/uH0nZlKoJOaWWuEu4pxrYDnQwY0KYiZVT5CUX+UP7F2E0iHcT0tB+8Md6507
         yto+6pNcjCAgXuo80tNOFhTmTzpmFhP8vIa4EhV2SNuTqUh7UzO5yFlhDzeJV0cph5Sn
         340g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/8f+OogZ3M30TyOF/ptBZT5LtrdWxe8YyqrFAeuCziY=;
        b=cXVsLH4M/wSmZs1PWkgJYoyR+/Vw2Qs79WHa0ndCRWTcUYlyTNN5UahjItmabLVAP+
         4C8eb+qKO1dhH1SRQVIhmR5VdYX7UGhBWoEvDdkxhBoxZPLIxhVJ9TL/gsAH5Uv4/XF5
         u0I8YJ09tFXBvzD9ZewXVAaaf1meDLgc5qfY4TUoSwJdIgXWi6qLER9r2MYjZqbvPHV9
         OIOQG7FtWi2Feb0wXwJL3vjcmbsy0bk1OetQlFGDzyrW9711g+oL59O9dPJoHi4ICS85
         zu1OQSljnp5KvpFi4Bt+XVY4UNnkQs0t8AiegLMZlJVjk2H59votlhZz04j4A55oPi3B
         q6mA==
X-Gm-Message-State: APjAAAVfTQa1c6xEeBOLpcpIvSCVrYWcsr4fKXF4/XcBc8jrl0adBYR8
        TkQtxnC8k5OIHsAWeMazWTZQqyD+
X-Google-Smtp-Source: APXvYqxzFZAf3aiHojOPhs2nrpReaXpF7KQ1AzXtZppQJvYyXLcAa1YbTCmBan1WaQOH9MVx1gS83w==
X-Received: by 2002:adf:f181:: with SMTP id h1mr9390622wro.18.1560942201813;
        Wed, 19 Jun 2019 04:03:21 -0700 (PDT)
Received: from [1.154.60.230] ([91.253.81.145])
        by smtp.gmail.com with ESMTPSA id u25sm1262038wmc.3.2019.06.19.04.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 04:03:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Paid Post Request
From:   Mirko Banchi <mk.banchi@gmail.com>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <5152258403672452723118@DESKTOP-OM6H6T2>
Date:   Wed, 19 Jun 2019 13:03:19 +0200
Cc:     linux-modules@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <085C083A-E40D-48BC-AC4A-01DA30F25177@gmail.com>
References: <5152258403672452723118@DESKTOP-OM6H6T2>
To:     aqib@globexadvertising.com
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Ciucciami l=E2=80=99uccello.

M.

> Il giorno 19 giu 2019, alle ore 11:53, Aqib Raja <aqib@globexadvertising.c=
om> ha scritto:
>=20
> Hi,
> I am Aqib Raja, Strategic Partnerships Manager at Globex Marketing. I woul=
d like to build a long-term working relationship with you that can benefit u=
s both.=20
> Our firm will need a Do Follow backlink from your website for which I=E2=80=
=99ll pay via Paypal or Payoneer.
> I=E2=80=99ll send you plagiarism free, high-quality articles that are rele=
vant to your blog. You don=E2=80=99t even have to include any sponsored tags=
.=20
> Please let know if you would be interested in working with our firm. Feel f=
ree to ask if you have any query.=20
> Looking forward to hearing from you soon.=20
>=20
> Best Regards,
> Aqib Raja
> (Strategic Partnerships Manager at Globex)
