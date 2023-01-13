Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672D8C3DA78
	for <linux-modules@archiver.kernel.org>; Fri, 13 Jan 2023 21:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjAMVh7 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 13 Jan 2023 16:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjAMVh6 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 13 Jan 2023 16:37:58 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C946565
        for <linux-modules@vger.kernel.org>; Fri, 13 Jan 2023 13:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673645878; x=1705181878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1cSh57sIVdKdZeUqXZb9Po/no8cc22MqxFzuiAIL/4g=;
  b=HcR5JIn6h4tQOKXiXHAWkNhiwQZkOIsA/36yHJRvVrbW6+UH9/vB5c2R
   M8ISlhldGw6Syq7Mp0bRczRShBj7ViFWtl8b6fP8fBcWOUQe/xix2ff0Y
   +605aYZdJKOyzOVdRQiOBvVX4qvZdVO6+B7JNadKKwmQiT0PNJZo9k33s
   CBgtUbIs9NVrFidukWUpjbyZJ6y+iIIIGvWLUcq2R5UATNFq5wZGQ4LaD
   qFusy6sAmhXdjDW4b4ctcLWpHfIpE2WiKmiu0m5wGtOwdTJ9xsqAGQt7m
   K91uxRPWPrvNMFa6stAxNeFF6QNhgtXh2vpFAImEJrzVwwjorSRtdQ8ON
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="307661044"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="307661044"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:37:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="800725252"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="800725252"
Received: from kcknighx-mobl.amr.corp.intel.com (HELO gjsousa-mobl2.intel.com) ([10.212.91.228])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 13:37:54 -0800
From:   Gustavo Sousa <gustavo.sousa@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>
Subject: [PATCH v2 1/3] testsuite: Wrap chdir()
Date:   Fri, 13 Jan 2023 18:37:43 -0300
Message-Id: <20230113213745.227703-2-gustavo.sousa@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111152936.101040-1-gustavo.sousa@intel.com>
References: <20230111152936.101040-1-gustavo.sousa@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

One of the tests in an upcoming patch will need to change into a
specific directory to test loading a module from a relative path.

Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
---
 testsuite/path.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testsuite/path.c b/testsuite/path.c
index 964d33eb25a0..c1ae4986b865 100644
--- a/testsuite/path.c
+++ b/testsuite/path.c
@@ -185,6 +185,7 @@ TS_EXPORT int prefix ## stat ## suffix (int ver,	    \
 }
 
 WRAP_1ARG(DIR*, NULL, opendir);
+WRAP_1ARG(int, -1, chdir);
 
 WRAP_2ARGS(FILE*, NULL, fopen, const char*);
 WRAP_2ARGS(FILE*, NULL, fopen64, const char*);
-- 
2.39.0

