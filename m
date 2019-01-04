Return-Path: <SRS0=6D95=PM=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BB8C43387
	for <linux-modules@archiver.kernel.org>; Fri,  4 Jan 2019 21:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DE921872
	for <linux-modules@archiver.kernel.org>; Fri,  4 Jan 2019 21:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfADVlZ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:41:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfADVlY (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 4 Jan 2019 16:41:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C580713374;
        Fri,  4 Jan 2019 21:41:24 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5FE219C7C;
        Fri,  4 Jan 2019 21:41:23 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     ykaliuta@redhat.com, Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH kmod 0/2] testsuite: abstraction to compare file descriptor
Date:   Fri,  4 Jan 2019 23:41:32 +0200
Message-Id: <20190104214134.23971-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 04 Jan 2019 21:41:24 +0000 (UTC)
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Factor out common code to handle comparation of stdout/stderr to the
template.

The first patch is made to make reviewing of the change of the
original logic easier.

Yauheni Kaliuta (2):
  testsuite: track number of descriptors instead of their state
  testsuite: factor out fd related parameters to a structure

 testsuite/testsuite.c | 362 +++++++++++++++++++++++++-----------------
 1 file changed, 219 insertions(+), 143 deletions(-)

-- 
2.20.0

