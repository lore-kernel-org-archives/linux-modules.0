Return-Path: <SRS0=VPp+=AY=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_HELO_IP_MISMATCH,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0A5C433E2
	for <linux-modules@archiver.kernel.org>; Mon, 13 Jul 2020 13:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F07520738
	for <linux-modules@archiver.kernel.org>; Mon, 13 Jul 2020 13:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linksbuildingcompany-com.20150623.gappssmtp.com header.i=@linksbuildingcompany-com.20150623.gappssmtp.com header.b="Iv/EWpvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgGMNJQ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbgGMNJP (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 13 Jul 2020 09:09:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCD4C061755
        for <linux-modules@vger.kernel.org>; Mon, 13 Jul 2020 06:09:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so13110633wmh.2
        for <linux-modules@vger.kernel.org>; Mon, 13 Jul 2020 06:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linksbuildingcompany-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:reply-to:to:subject:content-transfer-encoding
         :date:message-id;
        bh=E3CW8TZhR9fK3nKSDpyW8cnZyWM6QFjrGmrSwMcIieI=;
        b=Iv/EWpvDbyNFVmomoXg3GMI1dYHMgp3ro6UNrCkUVgqis0g1B6Gz5NMLRlDHioV9Ao
         ythCKWO4ox+V9QVOXikanDmT+yIOLhgXAoiadLvEV1xG4VrSY+zKv0jtUTozFcuXxTH3
         GdAixQXBT4yioPQYEfTfdD3C46iiB5hHMGWXbHrjbYNa6UatuqmGsyDVtlQNLGhNI6tY
         MdPs8LoV5koblT/enkiCx3nFwILTiyDfZ74GaQdTu4tVx461u5Zrlq+IKsYwJ78lIVCS
         v0J53omlkLj60aHRVJmY2jU4bWFpaLEx2BhagAJKhJltBl9/t0rsEBTyCKQ1QopMvz/M
         ka5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:reply-to:to:subject
         :content-transfer-encoding:date:message-id;
        bh=E3CW8TZhR9fK3nKSDpyW8cnZyWM6QFjrGmrSwMcIieI=;
        b=HubJPkcZXIgBrPa0s8TNFd1/aSGTPsgzLuLeepiKog9ujYBoPBeLJk/et0Q8SV3QrN
         MvXw+s3mRrm6fBSyEFdS7sPXy/DJUqGUukDySFcf6G5RrAKPIcB29YXfS5q9erzQNPIA
         3pk9tbmgrHQ5KuI22rq2NwboVToext1Ju1WSK9yP7HcIQQJ9ftbYWOIBE7bqXHsXZeTA
         33sM4erhVzTvacNJ4ry/fdIp2zBZY+XSvti+z82RT1ZW5EEIcneCsHFrso5lSLwu7Ty7
         yOSBfIReUCSl81Ln167mQ9yqSAmIbr8cUsWzRKSWQ8mtijSx4xUdr3uzECflse/z1/WR
         lUEg==
X-Gm-Message-State: AOAM532dgyiPJdezlGXvl7u2omTqT1GReVCJuD3THNGJ0+Ahy26VPISB
        BX0AjJBjjUBHuj3sZrhmS6f9SUAk8RbqbQ==
X-Google-Smtp-Source: ABdhPJz61ihWJufURhvC08zKjtwPSGpzjktJ6FDbU9POsXX7p7EvZ2CiJyg238RZPi6QWfphxAXCDQ==
X-Received: by 2002:a1c:1f09:: with SMTP id f9mr19765126wmf.137.1594645752705;
        Mon, 13 Jul 2020 06:09:12 -0700 (PDT)
Received: from 172.69.244.145 ([72.255.37.183])
        by smtp.gmail.com with ESMTPSA id x185sm23115296wmg.41.2020.07.13.06.09.11
        for <linux-modules@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Jul 2020 06:09:12 -0700 (PDT)
MIME-Version: 1.0
From:   "Seth" <seth@linksbuildingcompany.com>
Reply-To: seth@linksbuildingcompany.com
To:     linux-modules@vger.kernel.org
Subject: Guest Post Submission - Paid Task
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailer: Smart_Send_3_1_6
Date:   Mon, 13 Jul 2020 18:09:08 +0500
Message-ID: <911642335314455718545@DESKTOP-OM6H6T2>
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hello,

Hopefully you are fine.

We are a professional Outreach company looking for blogs forblog posting. I=
 came across your blog on Google, and I=92m writing to express myinterest i=
n posting content on your site.

We also have a writing agency, where all our writers arenative speakers and=
 will ensure that whatever that is posted on your site willbe of high quali=
ty and relevant to your site.

All payments will be made via PayPal or Pioneer. Whichevermethod you prefer=
 for the do =96 follow back link. Please notify me of the priceper post.

Let me know if you are interested.

I look forward to hearing from you,

Best Regards,

Seth johann
