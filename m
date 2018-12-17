Return-Path: <SRS0=eugf=O2=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B15C43387
	for <linux-modules@archiver.kernel.org>; Mon, 17 Dec 2018 22:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E6E21473
	for <linux-modules@archiver.kernel.org>; Mon, 17 Dec 2018 22:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbeLQWqt (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:46:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:60884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727909AbeLQWqt (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 17 Dec 2018 17:46:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 72B7EB018;
        Mon, 17 Dec 2018 22:46:47 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH v3 0/3] Fix dependency file corruption with parallel depmod invocation
Date:   Mon, 17 Dec 2018 23:46:26 +0100
Message-Id: <20181217224629.22687-1-msuchanek@suse.de>
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

v3:
 - remove superfluous whitespace, open flag, and duplicate nul termination

v2:
 - split into separate patches, add gcc warning fix

Michal Suchanek (3):
  depmod: prevent module dependency files missing during depmod
    invocation.
  depmod: prevent module dependency files corruption due to parallel
    invocation.
  depmod: shut up gcc insufficinet buffer warning.

 tools/depmod.c | 61 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 19 deletions(-)

-- 
2.19.2

