Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E499C433ED
	for <linux-modules@archiver.kernel.org>; Mon,  3 May 2021 10:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1236D611C2
	for <linux-modules@archiver.kernel.org>; Mon,  3 May 2021 10:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhECKzU (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 3 May 2021 06:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233137AbhECKzT (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 3 May 2021 06:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620039266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZW3zydGyb2RfryVIfVVyBzFX/AgCreb4VIlASiPiw9I=;
        b=UPcdzv2GIx7M01bIoWcNOLo5pUbgMQ1IS2W5b4majtNc2aKJTOTrrVL/2GIsL50cIMeH1/
        FSjI/3SV1tsqKcum+UuwnQnJphBwPcym8aU5pPe+9L1aRRlxtHIk+RxCZTWQ8gx4g1e+Gp
        oqwBBEyMJphJr9g393BdD6eMDPRwy4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-pKNWoqigOfKdaiGGz-2KMg-1; Mon, 03 May 2021 06:54:23 -0400
X-MC-Unique: pKNWoqigOfKdaiGGz-2KMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F3F8801817;
        Mon,  3 May 2021 10:54:22 +0000 (UTC)
Received: from rvarghes.bos.com (ovpn-112-56.phx2.redhat.com [10.3.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71CCA5C241;
        Mon,  3 May 2021 10:54:18 +0000 (UTC)
From:   Reuben Varghese <rvarghes@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     lucas.de.marchi@gmail.com, yauheni.kaliuta@redhat.com,
        Reuben Varghese <rvarghes@redhat.com>
Subject: [PATCH 0/2] Introduce inclusive language in kmod
Date:   Mon,  3 May 2021 03:53:45 -0700
Message-Id: <20210503105347.979635-1-rvarghes@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

In July 2020, linux moved to adopt inclusive and neutral language.
This includes replacing words slave/master with alternative terms
like primary/secondary or the words blacklist/whitelist with
blocklist/passlist. 

This patchset aims at editing the existing kmod code to make it inclusive.
This is mainly achieved by refactoring the blacklist command to blocklist.

The first patch refactors the term and updates the relevant documentation.

Since changing blacklist to blocklist and completely removing support for the
term blacklist will most likely break many systems, temporary support for the
term blacklist with a warning is introduced as part of the fallback patch.

That being said, two possible approaches of phasing out the term 
blacklist are listed below:
Approach 1: The moment the word blacklist is seen when reading the config file,
overwrite it to blocklist in the user's config file. The benefit of this approach
would be that we could stop support for the term blacklist immediately while at 
the same time not breaking any systems.

Approach 2: Add a warning each time the term blacklist is encountered.
This is the approach that is currently implemented. It is less aggresive
than approach 1 and serves the purpose of removing the term blacklist from
most places in the code.

Reuben Varghese (2):
  Refactor all instances of blacklist to blocklist and update
    documentation
  Continue temporary support for Blacklist command with warnings

 Makefile.am                                   |  6 +--
 NEWS                                          | 12 ++---
 libkmod/docs/libkmod-sections.txt             |  4 +-
 libkmod/libkmod-config.c                      | 50 ++++++++++--------
 libkmod/libkmod-internal.h                    |  4 +-
 libkmod/libkmod-module.c                      | 52 +++++++++----------
 libkmod/libkmod.h                             | 12 ++---
 libkmod/libkmod.sym                           |  4 +-
 libkmod/python/kmod/_libkmod_h.pxd            |  2 +-
 libkmod/python/kmod/kmod.pyx                  |  2 +-
 man/modprobe.d.xml                            |  8 ++-
 man/modprobe.xml                              |  4 +-
 testsuite/.gitignore                          |  6 +--
 .../etc/modprobe.d/modprobe.conf              |  2 -
 .../etc/modprobe.d/modprobe.conf              |  2 +
 .../{test-blacklist.c => test-blocklist.c}    | 12 ++---
 tools/insert.c                                |  6 +--
 tools/modprobe.c                              | 18 +++----
 18 files changed, 109 insertions(+), 97 deletions(-)
 delete mode 100644 testsuite/rootfs-pristine/test-blacklist/etc/modprobe.d/modprobe.conf
 create mode 100644 testsuite/rootfs-pristine/test-blocklist/etc/modprobe.d/modprobe.conf
 rename testsuite/{test-blacklist.c => test-blocklist.c} (90%)

-- 
2.27.0

