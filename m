Return-Path: <SRS0=/hZG=QI=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D886FC282D8
	for <linux-modules@archiver.kernel.org>; Fri,  1 Feb 2019 20:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DC420863
	for <linux-modules@archiver.kernel.org>; Fri,  1 Feb 2019 20:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfBAUUC (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:20:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728326AbfBAUUC (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 1 Feb 2019 15:20:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6445F42BC0;
        Fri,  1 Feb 2019 20:20:02 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-117-34.ams2.redhat.com [10.36.117.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F8F05C72B;
        Fri,  1 Feb 2019 20:20:01 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     ykaliuta@redhat.com, Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH kmod v3 0/2] read pkcs7 signature with openssl
Date:   Fri,  1 Feb 2019 22:20:00 +0200
Message-Id: <20190201202002.5508-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 01 Feb 2019 20:20:02 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The same as before but with the test.

I found, that using _cleanup_() is more inconvenient, since it will
require wrappers for the types as for _cleanup_free().

Changelog:

v1->v2 no changes, just non-rfc
v2->v3 test added

Yauheni Kaliuta (2):
  testsuite: add modinfo pkcs7 signature test
  libkmod-signature: implement pkcs7 parsing with openssl

 Makefile.am                                   |   4 +-
 configure.ac                                  |  11 +
 libkmod/libkmod-internal.h                    |   3 +
 libkmod/libkmod-module.c                      |   3 +
 libkmod/libkmod-signature.c                   | 197 +++++++++++++++++-
 testsuite/module-playground/dummy.pkcs7       | Bin 0 -> 721 bytes
 testsuite/populate-modules.sh                 |   9 +
 .../test-modinfo/correct-sig_hashalgo.txt     |   2 +-
 .../test-modinfo/correct-sig_key.txt          |   2 +-
 .../test-modinfo/correct-signer.txt           |   2 +-
 testsuite/test-modinfo.c                      |   3 +-
 11 files changed, 227 insertions(+), 9 deletions(-)
 create mode 100644 testsuite/module-playground/dummy.pkcs7

-- 
2.20.1

