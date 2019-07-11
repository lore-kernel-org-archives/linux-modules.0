Return-Path: <SRS0=YoU0=VI=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E22EC74A42
	for <linux-modules@archiver.kernel.org>; Thu, 11 Jul 2019 07:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A2F206B8
	for <linux-modules@archiver.kernel.org>; Thu, 11 Jul 2019 07:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=guestpostingfirm-com.20150623.gappssmtp.com header.i=@guestpostingfirm-com.20150623.gappssmtp.com header.b="BJvWXFe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfGKHXn (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 11 Jul 2019 03:23:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36630 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKHXn (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 11 Jul 2019 03:23:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so5059907wrs.3
        for <linux-modules@vger.kernel.org>; Thu, 11 Jul 2019 00:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=guestpostingfirm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:reply-to:to:subject:content-transfer-encoding
         :date:message-id;
        bh=66ehVdCq6fTOKq95CnVe8FMkQ0yXSBLsK2lqugaT9/w=;
        b=BJvWXFe4ll43twoPbyp65XCAclt0ACffPEKSDRIkWKqnOeK0/VcBRr2yrJvRB0w4hR
         q6pGLQ0caWFkt7R+M3G7p92Dmh5jXWk8/SxkjUYHaYtrx0PMbflt12El+9L1d3SIkWr0
         wjsOmdZcvC41bOiU5a5NXcHnHPIhV3ddz+lOZwGCFWmiXkbujGAIv3yqs4PEqK+YIZkj
         GzKxLdmZwWxd3dzOfKH+Gye4KQLO1JMAjiPTIVYMQ91eeO/5e5uvo8fGmUDP6oS8+uFm
         IdUHrWEuq53jXZR88jY2KZ7XaXJAMjN9z6WeBrXKzfD6xh4g7GSY7fAmdJekgazxwUTm
         vUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:reply-to:to:subject
         :content-transfer-encoding:date:message-id;
        bh=66ehVdCq6fTOKq95CnVe8FMkQ0yXSBLsK2lqugaT9/w=;
        b=Kn+F+VyM6wXKn7J8SyTBodd1EPRgyGunbrxFL6cGevUe4PIBHz4eJ2M0FvxSjsvzY+
         q8DLZ6Ruc/3uHze/1ypGa33TITBN1IXO/1183sf1fDC9lUmb/VzRf0vbN498VGK6J5hv
         luZViunkqrbLYpBf4QMhxpVOwchowKcwnJjFx//clrqVNCK5/28FZzjd7eucfwdfgGpj
         yJEBrS2p+DYPhP33otp8dXNAO4JUTJfclNSN/gCz4olPi1gprnYsCk0YzP5Vm2iutYOB
         2qMj2zZ/f7zOZvM3/I0n5jNv9D4gcoYVwzVcuIkF8PnK93FOISKbvAMpIRmxb9kuVmPw
         GWeA==
X-Gm-Message-State: APjAAAUK6pNgIADBWSnaTCbNJeZaF+QH60nidrWqwHo/CCh8aolCk8YG
        +2s5XqfywggxEJtLTl0ScL9i22Lc
X-Google-Smtp-Source: APXvYqyo+1vrnwL8BRZ9KxnVgITrmYc+5L8EzxG7LRqHWKfcxDUmm3+7SzBnbvtWs1dwthzPytjWGg==
X-Received: by 2002:a05:6000:187:: with SMTP id p7mr2761752wrx.189.1562829820991;
        Thu, 11 Jul 2019 00:23:40 -0700 (PDT)
Received: from 72.255.54.232 ([72.255.54.232])
        by smtp.gmail.com with ESMTPSA id k124sm6632840wmk.47.2019.07.11.00.23.39
        for <linux-modules@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 11 Jul 2019 00:23:40 -0700 (PDT)
MIME-Version: 1.0
From:   "Max Micklem" <max@guestpostingfirm.com>
Reply-To: max@guestpostingfirm.com
To:     linux-modules@vger.kernel.org
Subject: Paid post
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailer: Smart_Send_3_1_6
Date:   Thu, 11 Jul 2019 12:23:19 +0500
Message-ID: <43484116166081723513570@DESKTOP-O7KVLJL>
X-Antivirus: AVG (VPS 190710-8, 10/07/2019), Outbound message
X-Antivirus-Status: Clean
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hello,

I have an OFFER for you!

I want a sponsored post on your website with unique and engaging content. 

The content should have do follow links with no porn or casino sites.

PAYMENT method will be PayPal or Payoneer (Totally your choice!)

Let me know about your rates per post. If the deal gets done I will definit=
ely consider you in coming future as well.

Regards,

Max

Blogger Outreach Expert

---
This email has been checked for viruses by AVG.
https://www.avg.com

