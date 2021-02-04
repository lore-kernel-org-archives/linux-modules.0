Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8872DC433E0
	for <linux-modules@archiver.kernel.org>; Thu,  4 Feb 2021 10:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340F464E34
	for <linux-modules@archiver.kernel.org>; Thu,  4 Feb 2021 10:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbhBDKeh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 4 Feb 2021 05:34:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:44824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235594AbhBDKdY (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Thu, 4 Feb 2021 05:33:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02C2DB038;
        Thu,  4 Feb 2021 10:32:43 +0000 (UTC)
Date:   Thu, 4 Feb 2021 11:32:41 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org,
        Michal =?iso-8859-2?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH 2/2] testsuite: also test xz compression
Message-ID: <20210130023600.24239-2-lucas.demarchi@intel.com>
Reply-To: Petr Vorel <pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>
Message-ID: <20210204103241.UGBQouieIcsTwaoPjBGsLort2BtZfbwOA74rVq35kAI@z>

Hi,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks!

BTW I still have issues with testsuite/test-depmod locally, but probably my
wrong setup (testing also other configure options than this one):

$ CFLAGS='-g -O2' --enable-debug && make -j`nproc` && make check

depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.order at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
depmod: WARNING: could not open modules.builtin at /lib/modules/4.4.4: No such file or directory
TESTSUITE: running depmod_search_order_override, in forked context
TESTSUITE: SKIPPED: depmod_search_order_override
TESTSUITE: ------
TESTSUITE: running depmod_search_order_external_last, in forked context
TESTSUITE: 'depmod_search_order_external_last' [31183] exited with return code 0
TESTSUITE: PASSED: depmod_search_order_external_last
TESTSUITE: ------
TESTSUITE: running depmod_search_order_external_first, in forked context
TESTSUITE: SKIPPED: depmod_search_order_external_first
TESTSUITE: ------
TESTSUITE: running depmod_detect_loop, in forked context
TESTSUITE: SKIPPED: depmod_detect_loop
TESTSUITE: ------
TESTSUITE: running depmod_search_order_same_prefix, in forked context
TESTSUITE: 'depmod_search_order_same_prefix' [31182] exited with return code 0
TESTSUITE: ERR: sizes do not match /src/kmod/testsuite/rootfs/test-depmod/search-order-same-prefix/lib/modules/4.4.4/correct-modules.dep /src/kmod/testsuite/rootfs/test-depmod/search-order-same-prefix/lib/modules/4.4.4/modules.dep
TESTSUITE: ERR: FAILED: exit ok but outputs do not match: depmod_search_order_same_prefix
TESTSUITE: ------
FAIL testsuite/test-depmod (exit status: 1)

Kind regards,
Petr
