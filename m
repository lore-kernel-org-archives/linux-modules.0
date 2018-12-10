Return-Path: <SRS0=3Epf=OT=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EE0C04EB8
	for <linux-modules@archiver.kernel.org>; Mon, 10 Dec 2018 21:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378CA20821
	for <linux-modules@archiver.kernel.org>; Mon, 10 Dec 2018 21:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378CA20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbeLJV3v (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:29:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:35780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727034AbeLJV3v (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 10 Dec 2018 16:29:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F30A7AE65
        for <linux-modules@vger.kernel.org>; Mon, 10 Dec 2018 21:29:49 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH v2 0/3] Fix dependency file corruption with parallel depmod invocation
Date:   Mon, 10 Dec 2018 22:29:31 +0100
Message-Id: <cover.1544476531.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207154557.5865-1-msuchanek@suse.de>
References: <20181207154557.5865-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The files produced by depmod may be corrupted if multiple depmod processes
running in parallel try to update them. Since there is nothing stopping the
user running depmod in parallel this looks like a bug in depmod.

When a package manager is used it synchronizes adding or removeing module files
and depmod invocation. However, user might use other script that is not
synchronized with package manager or invoke depmod by hand.

When global synchronizarion is missing we cannot guarantee completely
consistent state because adding and removing module files is anynchronous.
However, we should guarantee the system is bootable if the user did not remove
the modules needed for boot. For that the dependency file should not get
removed or corrupted.

Thanks

Michal

Michal Suchanek (3):
  depmod: prevent module dependency files missing during depmod
    invocation.
  depmod: prevent module dependency files corruption due to parallel
    invocation.
  depmod: shut up gcc insufficinet buffer warning.

 tools/depmod.c | 64 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 20 deletions(-)

-- 
2.19.2

