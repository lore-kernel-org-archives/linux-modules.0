Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AFFC433B4
	for <linux-modules@archiver.kernel.org>; Tue, 18 May 2021 15:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E76256108B
	for <linux-modules@archiver.kernel.org>; Tue, 18 May 2021 15:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343937AbhERPFJ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 18 May 2021 11:05:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237976AbhERPFH (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 18 May 2021 11:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621350229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nP2Im8V1djRELgCoRsNmnO9kp5s9a8pkKX/PqopV7MI=;
        b=OSAQA7IiUWivwrpsx5ShPTfRjizcIZHEmadkgnF+hRHS71s9RlDklrz+i4m55A0pfIWB3M
        IV59wadvvuV+P4LYtg97I+iFsEfou08ZdmYQbnMMbljAJjVKAFRnTgNV6Q6d6sfGoMcGND
        nLQqVeZ8PiNv666CFrQwYGQ2MxjPsyc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-7t4GNqEMO8e8OjvzZ8WZZQ-1; Tue, 18 May 2021 11:03:46 -0400
X-MC-Unique: 7t4GNqEMO8e8OjvzZ8WZZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C198A805754;
        Tue, 18 May 2021 15:03:45 +0000 (UTC)
Received: from rvarghes.bos.com (ovpn-114-37.phx2.redhat.com [10.3.114.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C2B710074E0;
        Tue, 18 May 2021 15:03:34 +0000 (UTC)
From:   Reuben Varghese <rvarghes@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     lucas.de.marchi@gmail.com, yauheni.kaliuta@redhat.com,
        Reuben Varghese <rvarghes@redhat.com>
Subject: [PATCH v2 0/3] Introduce inclusive language in kmod
Date:   Tue, 18 May 2021 08:03:16 -0700
Message-Id: <20210518150319.60941-1-rvarghes@redhat.com>
In-Reply-To: <CAKi4VA+QqSkZMk+8=-9j7qH+_e7CRjW1mc+tVZ2V9Y+f=khe0w@mail.gmail.com>
References: <CAKi4VA+QqSkZMk+8=-9j7qH+_e7CRjW1mc+tVZ2V9Y+f=khe0w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

In July 2020, linux moved to adopt inclusive and neutral language.
This includes replacing words slave/master with alternative terms
like primary/secondary or the words blacklist/whitelist with
blocklist/passlist. 

This patchset aims at editing the existing kmod code to make it inclusive.
This is mainly achieved by refactoring the blacklist command to blocklist.

The first and second patch update the term and the documentation respectively.

Since changing blacklist to blocklist and completely removing support for the
term blacklist will most likely break many systems. Temporary support for the
blacklist term is introduced as part of the third patch.

Reuben Varghese (1):
  Continue temporary support for Blacklist command

reubenvarghese1 (2):
  Refactor all instances of blacklist to blocklist
  Update documentation reflecting change from blacklist to blocklist

 Makefile.am                                   |  6 +--
 NEWS                                          | 12 ++---
 libkmod/docs/libkmod-sections.txt             |  4 +-
 libkmod/libkmod-config.c                      | 43 +++++++--------
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
 18 files changed, 102 insertions(+), 97 deletions(-)
 delete mode 100644 testsuite/rootfs-pristine/test-blacklist/etc/modprobe.d/modprobe.conf
 create mode 100644 testsuite/rootfs-pristine/test-blocklist/etc/modprobe.d/modprobe.conf
 rename testsuite/{test-blacklist.c => test-blocklist.c} (90%)

-- 
2.27.0

