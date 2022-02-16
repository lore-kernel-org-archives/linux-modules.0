Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928B7C433EF
	for <linux-modules@archiver.kernel.org>; Wed, 16 Feb 2022 07:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiBPH4R (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:56:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiBPH4Q (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 16 Feb 2022 02:56:16 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D117D6364
        for <linux-modules@vger.kernel.org>; Tue, 15 Feb 2022 23:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644998164; x=1676534164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IKC8AEla6to8QudcvQ9Qwr+t399B6c5xLiO+GKid0h0=;
  b=VrjvK/Kr5b2TJ0m8Obo7ceCG43lUVLAK9LW4HbXsMgoZCb0CaBI6w7aq
   zyP7UAQYxg583ttqI0mOgakLSs+Fr+UScpAlh0PbuKDJjxLwlPFFyWuds
   N7F/GdCWTVz5qqw6TuRxsJcCEUb/fIpYAjXidHfs8HXMwU2N9K/1lDfPP
   fR8o8nc7Ln/G4qu4ZKv8hUbKxZ6rqfbGfUWBIN2qB89aH+FpUbzhRH1dd
   j7xnYHdBaoCMPjjClEWh3y+xXli+6NO76yOoVsXHtAoCWFVRfZLH6z3c0
   scmQYsvMxkFj7tkUNKQmTkMn6fNK6qWmT8Uys1mLvEOTJrhIj53fw6vwr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="311286597"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="311286597"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:56:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="636377627"
Received: from dcanchal-mobl1.ger.corp.intel.com (HELO ldmartin-desk2.intel.com) ([10.212.233.152])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:56:04 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 0/8] Random fixes + modinfo --modname
Date:   Tue, 15 Feb 2022 23:55:25 -0800
Message-Id: <20220216075533.185693-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

First commits are some random fixes and refactors while preparing the
code base for a new API: kmod_module_new_from_name_lookup(). This new
function is used by modinfo to allow handling the argument as a module
name instead of alias or file. Main motivation is to allow to bypass
aliases set by kernel or user configuration that would otherwise forbid
to get the info from a particular module. Although for modules it's
possible to just find the correspondent file, this is not possible
for builtin modules.

Lucas De Marchi (8):
  test-initstate: Check for negative value on error
  libkmod-module: Fix return code for kmod_module_new_from_lookup()
  gitignore: ignore gtk-doc.make
  libkmod: Add helper function to iterate lookup options
  libkmod: Update docs about indexes order
  libkmod: Add lookup from module name
  modinfo: Update help message with "modulename"
  modinfo: Allow to force arg as module name

 .gitignore                 |   1 +
 libkmod/libkmod-module.c   | 131 +++++++++++++++++++++++++------------
 libkmod/libkmod.h          |   3 +
 libkmod/libkmod.sym        |   1 +
 testsuite/test-initstate.c |   2 +-
 tools/modinfo.c            |  32 ++++++++-
 6 files changed, 125 insertions(+), 45 deletions(-)

-- 
2.35.1

