Return-Path: <SRS0=7sMs=US=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98ABC31E49
	for <linux-modules@archiver.kernel.org>; Wed, 19 Jun 2019 09:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8421620B1F
	for <linux-modules@archiver.kernel.org>; Wed, 19 Jun 2019 09:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globexadvertising.com header.i=@globexadvertising.com header.b="PHlBZjI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfFSJxw (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:53:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35407 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfFSJxw (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 19 Jun 2019 05:53:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so2682180wrv.2
        for <linux-modules@vger.kernel.org>; Wed, 19 Jun 2019 02:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globexadvertising.com; s=google;
        h=mime-version:from:reply-to:to:subject:content-transfer-encoding
         :date:message-id;
        bh=uoeWkqjmry2yX1Y1qWK4fhVNF8oSHFkJBu/VVpBobKM=;
        b=PHlBZjI1g3fCXpgIvNP9sejzHgZzUwk/73i2jTyFpqWpjUjFIr3kLrQ5pPecKmiSA4
         WRQFsmfHJIQ03HoqwaYqDqqJq/0MCo1/9o/hZ6uLng4OiNKZy6jnGmK+rznkbW0kQAL8
         BBYnZq8uwK6jIQhmsbj34izGf7Gz5+Qz73hbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:reply-to:to:subject
         :content-transfer-encoding:date:message-id;
        bh=uoeWkqjmry2yX1Y1qWK4fhVNF8oSHFkJBu/VVpBobKM=;
        b=SETETdgWvMT8fQFAMeUzDAZ007aCUoi72GhjPq2wTcOCKQHFzQfvtIwWxfYuOl4P+O
         NYqN/iFJSCZiQ0LM2bU9/3tEyjdRf0Gzkwz4BCXVXsIaOxr3gMm2QIcPANXb3Kwhi5Y3
         Ymv8LhZTw9Q+tNCEzhg0OymYHIbDo/FDEIZudVeXzo5bXrBPf8ZCE+UMy0NaAxs+IyFw
         5uUWxP+CgKjn+2ZOCqaE0XNfIAXvhVeIVlIrubH+cTpnthCCzC3R+css31TdX3pgvB2h
         q38fnEmnacwF9pdw169DBb95oMZfcZdbq88AFFbdPxQCK1yNE4/592uQMGF2q9edl2+l
         Xnhw==
X-Gm-Message-State: APjAAAWCUABV1Zam/ORna5ofnA7DYcbICj3wBswQmGWMRpsA7+n36Xbc
        4KokZh+oKMuocq9Hh4lBzwCY2SkNoaKpHg==
X-Google-Smtp-Source: APXvYqzZK4qWQPazMaBlDWP6EqYKOFAyVOUawneQcJTO0AlRLZ+AYsvsLrLSsB+nBMT+2VR2+O8hhQ==
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr29645299wrw.266.1560938029185;
        Wed, 19 Jun 2019 02:53:49 -0700 (PDT)
Received: from 72.255.54.232 ([72.255.54.232])
        by smtp.gmail.com with ESMTPSA id t6sm1060197wmb.29.2019.06.19.02.53.47
        for <linux-modules@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 19 Jun 2019 02:53:48 -0700 (PDT)
MIME-Version: 1.0
From:   "Aqib Raja" <aqib@globexadvertising.com>
Reply-To: aqib@globexadvertising.com
To:     linux-modules@vger.kernel.org
Subject: Paid Post Request
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailer: Smart_Send_3_1_6
Date:   Wed, 19 Jun 2019 15:23:45 +0530
Message-ID: <5152258403672452723118@DESKTOP-OM6H6T2>
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi,
I am Aqib Raja, Strategic Partnerships Manager at Globex Marketing. I would=
 like to build a long-term working relationship with you that can benefit u=
s both.=20
Our firm will need a Do Follow backlink from your website for which I=92ll =
pay via Paypal or Payoneer.
I=92ll send you plagiarism free, high-quality articles that are relevant to=
 your blog. You don=92t even have to include any sponsored tags.=20
Please let know if you would be interested in working with our firm. Feel f=
ree to ask if you have any query.=20
Looking forward to hearing from you soon.=20

Best Regards,
Aqib Raja
(Strategic Partnerships Manager at Globex)
