Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5E3EB64DC
	for <linux-modules@archiver.kernel.org>; Tue,  4 Jul 2023 02:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjGDCzE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 3 Jul 2023 22:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGDCzD (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 3 Jul 2023 22:55:03 -0400
X-Greylist: delayed 85 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jul 2023 19:55:01 PDT
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97C312E
        for <linux-modules@vger.kernel.org>; Mon,  3 Jul 2023 19:55:01 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-_iF5EIEuPq-CXRbxskslHQ-1; Mon, 03 Jul 2023 22:53:28 -0400
X-MC-Unique: _iF5EIEuPq-CXRbxskslHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACCB2809F8F;
        Tue,  4 Jul 2023 02:53:27 +0000 (UTC)
Received: from nomad.redhat.com (vpn2-54-59.bne.redhat.com [10.64.54.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B120840C6CD0;
        Tue,  4 Jul 2023 02:53:26 +0000 (UTC)
From:   Dave Airlie <airlied@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
Subject: modules: firmware groups attempt two
Date:   Tue,  4 Jul 2023 12:50:48 +1000
Message-ID: <20230704025322.2623556-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This is a second attempt at firmware grouping so we can have dracut
only pull one firmware into the initramfs instead of a bunch of legacy ones.

v1 got derailed when it was pointed out that ordering isn't consistent in
modinfo with C to sections, so that plan no longer was feasible.

This was the simplest next best option, it keeps the group tags, and
adds a new list of acceptable firmwares. New dracut will ignore legacy
firmware in favour of the list, old dracut will just read the legacy info
lines.

This is ugly because it requires duplication, but I can't think of a nice
way beyond horrible unscaleable C preprocessor tricks to make it nicer.

Dave.


