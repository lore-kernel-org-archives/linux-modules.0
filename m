Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F55C433E0
	for <linux-modules@archiver.kernel.org>; Fri,  8 Jan 2021 01:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10CED23435
	for <linux-modules@archiver.kernel.org>; Fri,  8 Jan 2021 01:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbhAHBye (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 7 Jan 2021 20:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbhAHBye (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 7 Jan 2021 20:54:34 -0500
X-Greylist: delayed 565 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Jan 2021 17:53:54 PST
Received: from attila.bofh.it (attila.bofh.it [IPv6:2001:4b78:2000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AA2C0612F5
        for <linux-modules@vger.kernel.org>; Thu,  7 Jan 2021 17:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.it;
 i=@linux.it; q=dns/txt; s=attila; t=1610070264; h=date : to : subject
 : message-id : mime-version : content-type : from : from;
 bh=E4lKXejveB1Zc7xqeBHuV1+FqQO6+TDrNl7L77mAT3U=;
 b=a7EwL+fJUbPWtJ1tt8GB0pPZw8DEKY/LvtXBb4lEJURC5tJ/hnDUCGTSLig4n1xwN6V6q
 iOZ2aVfewqJOPha+axJZ3+MosmNTn3IzPXKdZM5EO+m4ERGjEgejZ13Qxa6TWMfAdvzV47+
 0oV0iNPbz/xblpf6MgdAaJK2zf2dd84=
Received: by attila.bofh.it (Postfix, from userid 10)
        id DFB4512BB6C; Fri,  8 Jan 2021 02:44:24 +0100 (CET)
Received: by bongo.bofh.it (Postfix, from userid 1000)
        id 6906F8408DC; Fri,  8 Jan 2021 02:44:18 +0100 (CET)
Date:   Fri, 8 Jan 2021 02:44:18 +0100
To:     linux-modules@vger.kernel.org
Subject: Bug#970871: "modinfo -F" always shows name for built-ins
Message-ID: <X/e48mOg7WfVxRc0@bongo.bofh.it>
Mail-Followup-To: linux-modules@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EKDgjC3SsCpUydss"
Content-Disposition: inline
From:   Marco d'Itri <md@Linux.IT>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


--EKDgjC3SsCpUydss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patch fixes this.

----- Forwarded message from Ben Hutchings <ben@decadent.org.uk> -----

From: Ben Hutchings <ben@decadent.org.uk>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: Bug#970871: "modinfo -F" always shows name for built-ins

Package: kmod
Version: 27+20200310-2
Severity: normal

Now that the kernel provides module information for potentially
modular code that's actually built-in, it's possible to query these
built-ins with "modinfo -F".  However, this doesn't work quite right:

$ modinfo -Flicense e1000e
GPL v2
$ modinfo -Flicense bitrev
name:           bitrev
GPL

Ben.

-- System Information:
Debian Release: bullseye/sid
  APT prefers unstable-debug
  APT policy: (500, 'unstable-debug'), (500, 'stable-updates'), (500, 'unstable'), (500, 'stable'), (1, 'experimental')
Architecture: amd64 (x86_64)
Foreign Architectures: i386

Kernel: Linux 5.8.0-1-amd64 (SMP w/2 CPU threads)
Locale: LANG=en_GB.UTF-8, LC_CTYPE=en_GB.UTF-8 (charmap=UTF-8), LANGUAGE not set
Shell: /bin/sh linked to /bin/dash
Init: systemd (via /run/systemd/system)
LSM: AppArmor: enabled

Versions of packages kmod depends on:
ii  libc6      2.31-3
ii  libkmod2   27+20200310-2
ii  liblzma5   5.2.4-1+b1
ii  libssl1.1  1.1.1g-1
ii  lsb-base   11.1.0

kmod recommends no packages.

kmod suggests no packages.

-- no debconf information

----- End forwarded message -----

-- 
ciao,
Marco

--EKDgjC3SsCpUydss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=fix_modinfo_F

--- a/tools/modinfo.c
+++ b/tools/modinfo.c
@@ -178,7 +178,11 @@ static int modinfo_do(struct kmod_module
 	is_builtin = (filename == NULL);
 
 	if (is_builtin) {
-		printf("%-16s%s%c", "name:", kmod_module_get_name(mod), separator);
+		if (field == NULL)
+			printf("%-16s%s%c", "name:",
+			       kmod_module_get_name(mod), separator);
+		else if (field != NULL && streq(field, "name"))
+			printf("%s%c", kmod_module_get_name(mod), separator);
 		filename = "(builtin)";
 	}
 

--EKDgjC3SsCpUydss--
