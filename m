Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C93C47082
	for <linux-modules@archiver.kernel.org>; Tue,  8 Jun 2021 06:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9749D611BD
	for <linux-modules@archiver.kernel.org>; Tue,  8 Jun 2021 06:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFHGa7 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhFHGa6 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 8 Jun 2021 02:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623133745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qECj53O4QHNV+bLCLR3ZarXf1YceN7o4r43RSu5nAgM=;
        b=Bg2nRPvmyRNUhN3MrDrBDOPIjpLDfy56MvPPp3bv/Z17fFWhyktPkUnTk2ncoeHP4jwS1F
        BKQD9eN0slDAEsdL8J0aHpH0ceoDMkG6OzRnZc3bswMt6jcvdClrN7FGCZTPBwZkR9iKlV
        26gOelsLrLc1d+U8k7zh6O+E3TQMrNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-QcWJ2EHTPKee8zEDRfnTJQ-1; Tue, 08 Jun 2021 02:29:04 -0400
X-MC-Unique: QcWJ2EHTPKee8zEDRfnTJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85EAB801B13;
        Tue,  8 Jun 2021 06:29:03 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-84.ams2.redhat.com [10.36.112.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D7FB5C1BB;
        Tue,  8 Jun 2021 06:29:02 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     lucas.de.marchi@gmail.com, Yauheni Kaliuta <ykaliuta@redhat.com>
Subject: [PATCH 0/2] Fix a couple of potential problem (static analysis)
Date:   Tue,  8 Jun 2021 09:28:59 +0300
Message-Id: <20210608062859.93959-1-ykaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


Yauheni Kaliuta (2):
  libkmod-module: check "new_from_name" return value in get_builtin
  libkmod-builtin: consider final NIL in name length check

 libkmod/libkmod-builtin.c | 2 +-
 libkmod/libkmod-module.c  | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.31.1

