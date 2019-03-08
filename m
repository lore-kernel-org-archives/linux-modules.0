Return-Path: <SRS0=VdMu=RL=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE06C43381
	for <linux-modules@archiver.kernel.org>; Fri,  8 Mar 2019 21:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535F220851
	for <linux-modules@archiver.kernel.org>; Fri,  8 Mar 2019 21:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfCHVJX (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:09:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:36456 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfCHVJX (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 8 Mar 2019 16:09:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 13:09:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="281041922"
Received: from sflabarb-mobl.amr.corp.intel.com (HELO ldmartin-desk.amr.corp.intel.com) ([10.251.140.19])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2019 13:09:22 -0800
Date:   Fri, 8 Mar 2019 13:09:22 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH] tools: Print a message if refcnt attribute is missing
Message-ID: <20190308210922.3apss26mnedktu34@ldmartin-desk.amr.corp.intel.com>
References: <20190308203907.17030-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190308203907.17030-1-ezequiel@collabora.com>
User-Agent: NeoMutt/20180716
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri, Mar 08, 2019 at 05:39:07PM -0300, Ezequiel Garcia wrote:
>Currently, check_module_inuse returns a wrong user message
>if the kernel is built without module unloading support.
>
>Fix it by returning a more specific error, in case 'refcnt'
>attribute is missing.

Applied, thanks.

Lucas De Marchi

>---
> tools/remove.c | 9 ++++++---
> tools/rmmod.c  | 9 ++++++---
> 2 files changed, 12 insertions(+), 6 deletions(-)
>
>diff --git a/tools/remove.c b/tools/remove.c
>index 07e2cc0c83cd..387ef0ed17ce 100644
>--- a/tools/remove.c
>+++ b/tools/remove.c
>@@ -44,7 +44,7 @@ static void help(void)
>
> static int check_module_inuse(struct kmod_module *mod) {
> 	struct kmod_list *holders;
>-	int state;
>+	int state, ret;
>
> 	state = kmod_module_get_initstate(mod);
>
>@@ -74,12 +74,15 @@ static int check_module_inuse(struct kmod_module *mod) {
> 		return -EBUSY;
> 	}
>
>-	if (kmod_module_get_refcnt(mod) != 0) {
>+	ret = kmod_module_get_refcnt(mod);
>+	if (ret > 0) {
> 		ERR("Module %s is in use\n", kmod_module_get_name(mod));
> 		return -EBUSY;
>+	} else if (ret == -ENOENT) {
>+		ERR("Module unloading is not supported\n");
> 	}
>
>-	return 0;
>+	return ret;
> }
>
> static int do_remove(int argc, char *argv[])
>diff --git a/tools/rmmod.c b/tools/rmmod.c
>index bcdea4c57262..3942e7b439bd 100644
>--- a/tools/rmmod.c
>+++ b/tools/rmmod.c
>@@ -63,7 +63,7 @@ static void help(void)
>
> static int check_module_inuse(struct kmod_module *mod) {
> 	struct kmod_list *holders;
>-	int state;
>+	int state, ret;
>
> 	state = kmod_module_get_initstate(mod);
>
>@@ -93,12 +93,15 @@ static int check_module_inuse(struct kmod_module *mod) {
> 		return -EBUSY;
> 	}
>
>-	if (kmod_module_get_refcnt(mod) != 0) {
>+	ret = kmod_module_get_refcnt(mod);
>+	if (ret > 0) {
> 		ERR("Module %s is in use\n", kmod_module_get_name(mod));
> 		return -EBUSY;
>+	} else if (ret == -ENOENT) {
>+		ERR("Module unloading is not supported\n");
> 	}
>
>-	return 0;
>+	return ret;
> }
>
> static int do_rmmod(int argc, char *argv[])
>-- 
>2.20.1
>
