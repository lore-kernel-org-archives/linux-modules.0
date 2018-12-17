Return-Path: <SRS0=eugf=O2=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E13C43444
	for <linux-modules@archiver.kernel.org>; Mon, 17 Dec 2018 22:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E8B21783
	for <linux-modules@archiver.kernel.org>; Mon, 17 Dec 2018 22:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbeLQWqt (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:46:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:60890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728131AbeLQWqt (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 17 Dec 2018 17:46:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE832B03F;
        Mon, 17 Dec 2018 22:46:47 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH v3 1/3] depmod: prevent module dependency files missing during depmod invocation.
Date:   Mon, 17 Dec 2018 23:46:27 +0100
Message-Id: <20181217224629.22687-2-msuchanek@suse.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181217224629.22687-1-msuchanek@suse.de>
References: <20181207154557.5865-1-msuchanek@suse.de>
 <20181217224629.22687-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Depmod deletes the module dependency files before moving the temporary
files in their place. This results in user seeing no dependency files
while they are updated. Remove the unlink call. The rename call should
suffice to move the new file in place and unlink the old one. It should
also do both atomically so there is no window when no dependency file
exists.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 tools/depmod.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index 989d9077926c..18c0d61b2db3 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2451,7 +2451,6 @@ static int depmod_output(struct depmod *depmod, FILE *out)
 			break;
 		}
 
-		unlinkat(dfd, itr->name, 0);
 		if (renameat(dfd, tmp, dfd, itr->name) != 0) {
 			err = -errno;
 			CRIT("renameat(%s, %s, %s, %s): %m\n",
-- 
2.19.2

