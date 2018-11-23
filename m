Return-Path: <SRS0=Ba8G=OC=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FCBC43441
	for <linux-modules@archiver.kernel.org>; Fri, 23 Nov 2018 21:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D842C20664
	for <linux-modules@archiver.kernel.org>; Fri, 23 Nov 2018 21:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D842C20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeKXIjW (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 24 Nov 2018 03:39:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeKXIjW (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sat, 24 Nov 2018 03:39:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3982C30820C5;
        Fri, 23 Nov 2018 21:53:23 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-110.ams2.redhat.com [10.36.116.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B68C1019639;
        Fri, 23 Nov 2018 21:53:22 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     ykaliuta@redhat.com, Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [RFC PATCH 0/2] Unify symbol access API
Date:   Fri, 23 Nov 2018 23:53:20 +0200
Message-Id: <20181123215322.5438-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 23 Nov 2018 21:53:23 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi!

I'm not very happy with the naming, but how do you like the idea in general?


Yauheni Kaliuta (2):
  libkmod: module: introduce common symbol API.
  libkmod: module: make old symbol access API as wrapper to the new

 libkmod/libkmod-module.c | 387 ++++++++++++++++-----------------------
 libkmod/libkmod.h        |  12 ++
 2 files changed, 171 insertions(+), 228 deletions(-)

-- 
2.19.1

