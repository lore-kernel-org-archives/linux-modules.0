Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78624ECAAD3
	for <linux-modules@archiver.kernel.org>; Mon, 19 Sep 2022 12:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiISMdR (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 19 Sep 2022 08:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiISMdQ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Sep 2022 08:33:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E21D19003;
        Mon, 19 Sep 2022 05:33:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D011121EB9;
        Mon, 19 Sep 2022 12:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663590793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nFtfJqiiLLlBX4A5XDU37N4CWJ4B5UR+eZPaw2x+mUQ=;
        b=kRGkz8R4NmiA85uSlObHpgpZ76tEcSa8DCcemP+XzlVThl2cGv9y36ERQspu8hsz4sdnhm
        yUwW9bQdrdC/X6g8dUA13lp9OV54d97o0/nv7i5FDFzmu163DqXYYc5+AxNeV4RLqSojXf
        +Y6SRpz3msToo8ORs9lqV9Jl5XiAlVM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A52AF13A96;
        Mon, 19 Sep 2022 12:33:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rlBGJ4lhKGN4LAAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Mon, 19 Sep 2022 12:33:13 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     mcgrof@kernel.org
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2 0/2] module: Merge same-name module load requests
Date:   Mon, 19 Sep 2022 14:32:31 +0200
Message-Id: <20220919123233.8538-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Changes since v1 [1]:
- Change the error returned by a duplicate load when the main insert
  fails from -ENODEV to -EBUSY.
- Change the error returned by a duplicate load when a same-name module
  is going from -EAGAIN to -EBUSY.
- Use a per-shared_load_info completion object to inform waiting loads
  when the main one is done.
- Add a patch to correct wake up of module_wq.

[1] https://lore.kernel.org/linux-modules/20220905084131.14567-1-petr.pavlu@suse.com/

Petr Pavlu (2):
  module: Correct wake up of module_wq
  module: Merge same-name module load requests

 kernel/module/main.c | 214 ++++++++++++++++++++++++++++++-------------
 1 file changed, 150 insertions(+), 64 deletions(-)

-- 
2.35.3

