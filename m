Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38248 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753796AbbIKUz6 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Fri, 11 Sep 2015 16:55:58 -0400
From: Laura Abbott <labbott@fedoraproject.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Laura Abbott <labbott@fedoraproject.org>,
	linux-modules@vger.kernel.org
Subject: [PATCH 0/4] depmod and modprobe error message fixups
Date: Fri, 11 Sep 2015 13:55:52 -0700
Message-Id: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>


While doing some experimental work with kernel packaging,
I found a few places where a lack of error messages made
it difficult to figure out what was going on. This cleans
up the error messages to be a bit more useful.

Laura Abbott (4):
  build: Properly check for Cython
  modprobe: Add appropriate error message when path is missing
  depmod: Fix message printing before log_setup_kmod_log
  depmod: Add error message for bad version

 configure.ac     |  5 ++++-
 tools/depmod.c   | 15 +++++++++------
 tools/modprobe.c |  5 ++++-
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.4.3

