Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8B0C433EF
	for <linux-modules@archiver.kernel.org>; Tue, 29 Mar 2022 09:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbiC2JHq (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 29 Mar 2022 05:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiC2JHj (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 29 Mar 2022 05:07:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2838B241B7A
        for <linux-modules@vger.kernel.org>; Tue, 29 Mar 2022 02:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648544757; x=1680080757;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kbUousrLP5s0776xpRyC27A6iddacqyOy95LoW7/YBE=;
  b=fX/ppVVEEH0t/3tEgSgrPxsUdbCJIANESX5NS6IHINr6V/OIu2IXcLIM
   Cip6yB/xiDQJGTiDLcBOgLOlU68/5vIibzBP3fL/8SMY6yJfG3nPgoIiV
   OnbuQOzLEk3BWpzY2DRQ4jhvGRgOQiiFbPLT90dfPIqYNXvIuWJNWE27j
   rsNLD7Kcn7dWW64TwKoeQTLNNBmDo26Lf1/1+uLNIT8d4lCHVMOkCOlEE
   YJOfvye6PVLyNHEovOLswHnEebM/YtOSgp0TOKSfcCIbGb49mI8D+nj1F
   BLUgpzWO2TVfE7F7KoD3Csqc7/4ptDdB2JGd6Bh5q+xPGBxMnHZGGIWjd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="239134282"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="239134282"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 02:05:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="585502834"
Received: from mlopezja-mobl.amr.corp.intel.com (HELO ldmartin-desk2.intel.com) ([10.255.231.179])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 02:05:55 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 0/4] modprobe -r fixes and refactors
Date:   Tue, 29 Mar 2022 02:05:34 -0700
Message-Id: <20220329090540.38255-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Fixes and refactors that I noticed were needed while preparing support
for "patient module removal[1][2]" in modprobe.

The added functionality will be sent on top of these.

[1] https://lore.kernel.org/linux-modules/20210803202417.462197-1-mcgrof@kernel.org/
[2] https://lore.kernel.org/linux-modules/20210810051602.3067384-1-mcgrof@kernel.org/

Lucas De Marchi (4):
  modprobe: Rename rmmod_do_deps_list
  modprobe: Fix holders removal
  modprobe: Move check for remove_holders to caller
  modprobe: Make rmmod_do_module() contain all the removal sequence

 tools/modprobe.c | 64 ++++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

-- 
2.35.1

