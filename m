Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87CBC64E7B
	for <linux-modules@archiver.kernel.org>; Thu,  3 Dec 2020 09:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A8720C56
	for <linux-modules@archiver.kernel.org>; Thu,  3 Dec 2020 09:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgLCJuc (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 3 Dec 2020 04:50:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:46643 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbgLCJub (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 3 Dec 2020 04:50:31 -0500
IronPort-SDR: CLIEjxN5KEmrQ/atT9QeozXPSF7npj5qn2dSE7xvCT5E8o6LBZXIE3QfJSHSDd6AqF83BU5R7d
 NT8oUYIncXcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="160221561"
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="160221561"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 01:49:51 -0800
IronPort-SDR: aAfKyuGeU0CB0x3yxhEyQjgAEsUAYKawfENEzBSeL1ZZqqJiDHnBdCcBPkvmojHTLJPjFxuVqh
 OPlFIiD9l63g==
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="316415182"
Received: from kvikashs-mobl1.amr.corp.intel.com (HELO ldmartin-desk1.intel.com) ([10.254.178.134])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 01:49:50 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org, lucas.de.marchi@gmail.com,
        patchwork-bot@kernel.org, Shuo Wang <wangshuo47@huawei.com>
Cc:     hushiyuan@huawei.com
Subject: Re: [PATCH] NEWS: fix typo
Date:   Thu,  3 Dec 2020 01:49:35 -0800
Message-Id: <160698893481.49294.5586143633145480389.b4-ty@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125013121.4196-1-wangshuo47@huawei.com>
References: <20201125013121.4196-1-wangshuo47@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, 25 Nov 2020 09:31:21 +0800, Shuo Wang wrote:
> 


Applied, thanks!

[1/1] NEWS: fix typo
      commit: c72433254ee0bda8db5d8d78a643c481a51f88a5

Best regards,
-- 
Lucas De Marchi <lucas.demarchi@intel.com>
