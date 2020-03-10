Return-Path: <SRS0=Ow/D=43=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3E8C18E5B
	for <linux-modules@archiver.kernel.org>; Tue, 10 Mar 2020 05:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EB62467C
	for <linux-modules@archiver.kernel.org>; Tue, 10 Mar 2020 05:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgCJFBl (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 10 Mar 2020 01:01:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:16457 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgCJFBl (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 10 Mar 2020 01:01:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 22:01:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="353525574"
Received: from ldmartin1-desk.jf.intel.com ([10.165.21.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2020 22:01:39 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Yanko Kaneti <yaneti@declera.com>, gladkov.alexey@gmail.com,
        auke-jan.h.kok@intel.com,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 2/6] depmod: do not output .bin to stdout
Date:   Mon,  9 Mar 2020 22:00:25 -0700
Message-Id: <20200310050029.27678-3-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310050029.27678-1-lucas.demarchi@intel.com>
References: <20200310050029.27678-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

index_write() relies on fseek/ftell to manage the position to which we
are write and thus needs the file stream to support it.

Right now when trying to write the index to stdout we fail with:

	depmod: tools/depmod.c:416: index_write: Assertion `initial_offset >= 0' failed.
	Aborted (core dumped)

We have no interest in outputting our index to stdout, so just skip it
like is done with other indexes.

While at it, add/remove some newlines to improve readability.

Reported-by: Yanko Kaneti <yaneti@declera.com>
Fix: b866b2165ae6 ("Lookup aliases in the modules.builtin.modinfo")
---
 tools/depmod.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index fbbce10..875e314 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2408,8 +2408,10 @@ static int output_builtin_alias_bin(struct depmod *depmod, FILE *out)
 	struct index_node *idx;
 	struct kmod_list *l, *builtin = NULL;
 
-	idx = index_create();
+	if (out == stdout)
+		return 0;
 
+	idx = index_create();
 	if (idx == NULL) {
 		ret = -ENOMEM;
 		goto fail;
@@ -2456,7 +2458,9 @@ static int output_builtin_alias_bin(struct depmod *depmod, FILE *out)
 
 	if (count)
 		index_write(idx, out);
+
 	index_destroy(idx);
+
 fail:
 	if (builtin)
 		kmod_module_unref_list(builtin);
-- 
2.25.1

