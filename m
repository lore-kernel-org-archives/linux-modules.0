Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:46268 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab3IFF7G (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 6 Sep 2013 01:59:06 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r865x5wI027633
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-modules@vger.kernel.org>; Thu, 5 Sep 2013 22:59:05 -0700 (PDT)
From: Randy MacLeod <Randy.MacLeod@windriver.com>
To: <linux-modules@vger.kernel.org>
CC: <randy.macleod@windriver.com>
Subject: [PATCH] kmod: be32toh for older boxen
Date: Fri, 6 Sep 2013 01:59:00 -0400
Message-ID: <1378447141-11568-1-git-send-email-Randy.MacLeod@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

The attached patch fixes kmod when built on RHEL-5.9.
I need to do this for a yocto cross-compile.
I've also built on Ubuntu-12.04.

No run-time testing as the change seems simple enough.

Let me now if any changes are needed since this is my first
patch to kmod.

Thanks,

// Randy

Randy MacLeod (1):
  kmod-native: Add back-up implementation of be32toh().

 configure.ac                |  1 +
 libkmod/libkmod-signature.c | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
1.8.2.1

