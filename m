Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935350AbcKWPWn (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Wed, 23 Nov 2016 10:22:43 -0500
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules@vger.kernel.org
Cc: aris@redhat.com, Lucas De Marchi <lucas.demarchi@intel.com>,
        yauheni.kaliuta@redhat.com
Subject: [PATCH RFC 0/3] depmod: implement external directories support
Date: Wed, 23 Nov 2016 17:23:36 +0200
Message-Id: <20161123152339.27531-1-yauheni.kaliuta@redhat.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Would it be possible to implement something like external
directories support in depmod (see PATCH 3 description).

I'll copy here the part:

This is a pretty simple extention of existing logic, since now
depmod already is able to:

a) scan modules with full path from command line without -a
switch;
b) detects broken symbol dependencies and broken modversions,
what assumes, that modules are already are not built for the
existing kernel.

Yauheni Kaliuta (3):
  depmod: create depmod dir independent search function
  depmod: search key: move builtin detection under the add function
  depmod: implement external directories support

 tools/depmod.c | 209 +++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 175 insertions(+), 34 deletions(-)

-- 
2.9.3

