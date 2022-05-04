Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FC6C433F5
	for <linux-modules@archiver.kernel.org>; Wed,  4 May 2022 19:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiEDTuT (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 4 May 2022 15:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358601AbiEDTuT (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 4 May 2022 15:50:19 -0400
Received: from condef-07.nifty.com (condef-07.nifty.com [202.248.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81D61BE96
        for <linux-modules@vger.kernel.org>; Wed,  4 May 2022 12:46:41 -0700 (PDT)
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-07.nifty.com with ESMTP id 244JhtBm000978
        for <linux-modules@vger.kernel.org>; Thu, 5 May 2022 04:43:55 +0900
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 244JhL7k001234;
        Thu, 5 May 2022 04:43:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 244JhL7k001234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651693402;
        bh=NtOPCiHOzYlkJIRKdMAZ3FSXrEPjfH/3gnPWepxEaJ8=;
        h=From:To:Cc:Subject:Date:From;
        b=Jz/0NXe8GvKHKCSOmfo8IfbYqM0U5EqHnepA0S0+RgqKBzXGao6OdcuvG4Fo5rcwc
         GtO5GRX1htIHPYObISNubytvRxK529tWnONSUD/7q5ks6ct3l2g2Ptw6ixYLvRdVp6
         a28YeftXaGcCAP17niD8aF1HxEXgF5IO99w2MkceefOBHRmonm8/qnyKvWjN4DQqxE
         SbtiGT+kz7sargdPgHPz66CKQulWyw4wIsQ9rYrjRymXs6OWQetCR4u5uwbXU8hHmP
         U65RxdgL/lMPyPx8tETlMY5kF2LzTbl32+YIOqZByGqMVIiat5e+BCxSR+kS6bWwLj
         fi4FimVYBLQ2A==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 0/3] module: trivial cleanups for symbol search
Date:   Thu,  5 May 2022 04:42:42 +0900
Message-Id: <20220504194245.1088063-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


Masahiro Yamada (3):
  module: do not pass opaque pointer for symbol search
  module: do not binary-search in __ksymtab_gpl if fsa->gplok is false
  module: merge check_exported_symbol() into
    find_exported_symbol_in_section()

 kernel/module.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

-- 
2.32.0

