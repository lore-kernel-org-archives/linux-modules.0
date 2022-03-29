Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC84EC433EF
	for <linux-modules@archiver.kernel.org>; Tue, 29 Mar 2022 09:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiC2JIA (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Mar 2022 05:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiC2JHl (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Mar 2022 05:07:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37BA242201
        for <linux-modules@vger.kernel.org>; Tue, 29 Mar 2022 02:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648544759; x=1680080759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SX6Rb/HKFg/+JyY0RR92+nOatpAw4Y6382LxugLc99s=;
  b=DEXAwELz1ZUjP+W/UPFyRW7uiy37exrWNzXpWW0ywkIjMwLwBZzYSYoV
   MWZ1X1St89h+Di7fh+k4tu5d7MrLNJBeIRn4tSelfyxzBulXHMFmtdTZG
   WzeVB9h+oIIE0sB1R4r6sC/HFn7e0SytGcPQXGn89P0eRys99ektF2Vkl
   QIGn24kCNoPFCXGcUAXYh63VJjRgYDUznW8pdhDmEhaphpuSll4zJqbdf
   YQblvXJXoUymWZuRVOz83Ij1StoBZF6j45HQX5UYKzXSaNKohmi2Dfha5
   3QaKeJb9wKPG4/awTWR8yT2OmBCSiI06NqWgdSSENrhX3fLX9iw5hNjDF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="239134291"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="239134291"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 02:05:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="585502847"
Received: from mlopezja-mobl.amr.corp.intel.com (HELO ldmartin-desk2.intel.com) ([10.255.231.179])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 02:05:55 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 3/4] modprobe: Move check for remove_holders to caller
Date:   Tue, 29 Mar 2022 02:05:38 -0700
Message-Id: <20220329090540.38255-5-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329090540.38255-1-lucas.demarchi@intel.com>
References: <20220329090540.38255-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Do not mix the flags with and additional boolean from arguments.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 tools/modprobe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/modprobe.c b/tools/modprobe.c
index ceb4ff6..0d9b805 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -418,7 +418,7 @@ static int rmmod_do_module(struct kmod_module *mod, int flags)
 
 	rmmod_do_modlist(post, false);
 
-	if ((flags & RMMOD_FLAG_REMOVE_HOLDERS) && remove_holders) {
+	if (flags & RMMOD_FLAG_REMOVE_HOLDERS) {
 		struct kmod_list *holders = kmod_module_get_holders(mod);
 
 		err = rmmod_do_modlist(holders, true);
@@ -471,7 +471,9 @@ static int rmmod(struct kmod_ctx *ctx, const char *alias)
 
 	kmod_list_foreach(l, list) {
 		struct kmod_module *mod = kmod_module_get_module(l);
-		err = rmmod_do_module(mod, RMMOD_FLAG_REMOVE_HOLDERS);
+		int flags = remove_holders ? RMMOD_FLAG_REMOVE_HOLDERS : 0;
+
+		err = rmmod_do_module(mod, flags);
 		kmod_module_unref(mod);
 		if (err < 0)
 			break;
-- 
2.35.1

