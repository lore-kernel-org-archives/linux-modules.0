Return-Path: <SRS0=Y+s7=PU=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B300C43387
	for <linux-modules@archiver.kernel.org>; Sat, 12 Jan 2019 17:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0367620836
	for <linux-modules@archiver.kernel.org>; Sat, 12 Jan 2019 17:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfALR3F (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 12 Jan 2019 12:29:05 -0500
Received: from che.mayfirst.org ([162.247.75.118]:49321 "EHLO che.mayfirst.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfALR3F (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sat, 12 Jan 2019 12:29:05 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Jan 2019 12:29:05 EST
Received: from fifthhorseman.net (unknown [IPv6:2001:470:1f07:60d:b4c1:b6ff:fe27:67bb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by che.mayfirst.org (Postfix) with ESMTPSA id A0593F99A
        for <linux-modules@vger.kernel.org>; Sat, 12 Jan 2019 12:22:22 -0500 (EST)
Received: by fifthhorseman.net (Postfix, from userid 1000)
        id E4ED82054B; Sat, 12 Jan 2019 12:22:19 -0500 (EST)
From:   Daniel Kahn Gillmor <dkg@fifthhorseman.net>
To:     linux-modules@vger.kernel.org
Subject: [kmod] Fix typo
Date:   Sat, 12 Jan 2019 12:22:19 -0500
Message-Id: <20190112172219.13152-1-dkg@fifthhorseman.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

---
 man/modprobe.d.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/modprobe.d.xml b/man/modprobe.d.xml
index 47878e2..211af84 100644
--- a/man/modprobe.d.xml
+++ b/man/modprobe.d.xml
@@ -63,7 +63,7 @@
       module commands as underscore conversion happens automatically.
     </para>
     <para>
-      The format of and files under <filename>modprobe.d</filename> is
+      The format of files under <filename>modprobe.d</filename> is
       simple: one command per line, with blank lines and lines starting
       with '#' ignored (useful for adding comments).  A '\' at the end
       of a line causes it to continue on the next line, which makes the
-- 
2.20.1

