Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58635 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbcFALML (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Wed, 1 Jun 2016 07:12:11 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25F8780B22
	for <linux-modules@vger.kernel.org>; Wed,  1 Jun 2016 11:12:10 +0000 (UTC)
Date: Wed, 1 Jun 2016 19:12:07 +0800
From: Honggang LI <honli@redhat.com>
To: linux-modules@vger.kernel.org
Subject: kmod documentation issue -- module parameters must after modulename
Message-ID: <20160601111207.GB28228@dhcp-13-42.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

upstream-git]$ git clone https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git
upstream-git]$ cd kmod
kmod]$ grep -w -n fred -r .
./man/modprobe.d.xml:144:            This can be useful because users expect "modprobe fred opt=1" to
                                                                              ^^^^^^^^^^^^^^^^^^^
./man/modprobe.d.xml:148:            --ignore-install fred $CMDLINE_OPTS"
                                                      ^^^^^^^^^^^^^^^^^^
						      
"modprobe fred opt=1" should be "modprobe opt=1 fred"
"fred $CMDLINE_OPTS" should be "$CMDLINE_OPTS fred"

Please fix it.

thanks
