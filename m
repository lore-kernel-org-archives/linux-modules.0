Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F75BC61DA4
	for <linux-modules@archiver.kernel.org>; Thu,  9 Feb 2023 19:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjBITUI (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 9 Feb 2023 14:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBITUH (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 9 Feb 2023 14:20:07 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415D42CFD4
        for <linux-modules@vger.kernel.org>; Thu,  9 Feb 2023 11:20:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u21so3039460edv.3
        for <linux-modules@vger.kernel.org>; Thu, 09 Feb 2023 11:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LdggQTflvZzQ/I0tP5I+cmNDZ6KtTTg2bosec0I4kE0=;
        b=Sr8xONeTIiuLexZeIXd7NjeGBTIZlQEuSmzPfx8i32DnS/kY1PjwSGcFhhFczMEmSf
         FluuUVeUpqju2bB6r339XFLg1WodYWCwBQj85rGXG2uWXKyCrRNuv4K3eWMMCo9VRnfw
         3xzw6uSkO7aZ7mwZD+mPWiDPQ/LYYrDX5BCdUzk6ES3nsHM3gkyvfU6Z0DhFtWJHb3HB
         4ZQDkQPq8yHt0utdy8zq5PxO3cuWIH/dMFFMFGN+gHGhpwIgUwTQ3xOUYE+OBosy7qBx
         rGo4G4wBGNM3lGWnrbLBv8eifDf6FIF6hMmExeMubKZwAuW085B/IkIkjMTdC5WfPtHj
         wXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LdggQTflvZzQ/I0tP5I+cmNDZ6KtTTg2bosec0I4kE0=;
        b=RYVzsCrxE4ZsYF2euCtWykMTp1D0j3RnlRrgR1Q1vFuevw5+23s06ZZLHeYqJl0RpZ
         0xYMF0cNbev+/B2N4MOvDUK3ZtLaQIT/v5+uHdFxcxLRTZyoSC6SJ37N5gSwn5uBBnrc
         d66RwXlQ4N6mLcs5grtKy2NzkV4nh9PLi84WQpAYDFhXLNlWk++DM/tde/g1srsbgLVa
         W3ABaVd9P+GsXzWCbwyzmo963oUdPunQBbRmZ5nVqYej65RA37yt3XIFcNnJ6p3lYbII
         8XBCUnGP/wcwoXbN6KDpRlUj1F/V/vnpNVcyPxffw4lNMePlgh0HfyKbQkPYbTjblODb
         nvmQ==
X-Gm-Message-State: AO0yUKXijemAZnrZNZGyX+yV1+1ujXei6zLazjp2jkCEmKetc2kKHpR1
        mTZN4p69nyM++axsr6zkMRA3D3miXS4=
X-Google-Smtp-Source: AK7set8sBvmvcLtduSd72x1jWtjJ00CnIPSpeuUwbdmXh5535z6NGTTVFgCCFvRLoPO9qBfhVlAnuQ==
X-Received: by 2002:a50:871e:0:b0:4aa:a216:c15 with SMTP id i30-20020a50871e000000b004aaa2160c15mr14822363edb.10.1675970403796;
        Thu, 09 Feb 2023 11:20:03 -0800 (PST)
Received: from ldmartin-desk2.lan ([134.134.137.81])
        by smtp.gmail.com with ESMTPSA id k26-20020a50c09a000000b004a21304f5a0sm1188942edf.72.2023.02.09.11.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 11:20:02 -0800 (PST)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     emil.l.velikov@gmail.com,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 1/2] testsuite: Move setup-rootfs logic from Makefile to script
Date:   Thu,  9 Feb 2023 11:19:45 -0800
Message-Id: <20230209191946.243317-1-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

It's easier to implement the logic outside of the Makefile, so rename
the populate-modules.sh script to setup-rootfs.sh and move the
additional logic from the makefile to the script.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 Makefile.am                                   | 10 ++--------
 .../{populate-modules.sh => setup-rootfs.sh}  | 19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 10 deletions(-)
 rename testsuite/{populate-modules.sh => setup-rootfs.sh} (94%)

diff --git a/Makefile.am b/Makefile.am
index b0a654c..021b315 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -239,18 +239,12 @@ endif
 # TESTSUITE
 # ------------------------------------------------------------------------------
 
-EXTRA_DIST += testsuite/populate-modules.sh
+EXTRA_DIST += testsuite/setup-rootfs.sh
 
 MODULE_PLAYGROUND = testsuite/module-playground
 ROOTFS = testsuite/rootfs
 ROOTFS_PRISTINE = $(top_srcdir)/testsuite/rootfs-pristine
-CREATE_ROOTFS = $(AM_V_GEN) ( $(RM) -rf $(ROOTFS) && mkdir -p $(dir $(ROOTFS)) && \
-				cp -r $(ROOTFS_PRISTINE) $(ROOTFS) && \
-				find $(ROOTFS) -type d -exec chmod +w {} \; && \
-				find $(ROOTFS) -type f -name .gitignore -exec rm -f {} \; && \
-				$(top_srcdir)/testsuite/populate-modules.sh \
-					$(MODULE_PLAYGROUND) $(ROOTFS) $(top_builddir)/config.h ) && \
-				touch testsuite/stamp-rootfs
+CREATE_ROOTFS = $(AM_V_GEN) $(top_srcdir)/testsuite/setup-rootfs.sh $(ROOTFS_PRISTINE) $(ROOTFS) $(MODULE_PLAYGROUND) $(top_builddir)/config.h
 
 build-module-playground:
 	$(AM_V_GEN)if test "$(top_srcdir)" != "$(top_builddir)"; then \
diff --git a/testsuite/populate-modules.sh b/testsuite/setup-rootfs.sh
similarity index 94%
rename from testsuite/populate-modules.sh
rename to testsuite/setup-rootfs.sh
index 5009cac..d155a30 100755
--- a/testsuite/populate-modules.sh
+++ b/testsuite/setup-rootfs.sh
@@ -2,9 +2,20 @@
 
 set -e
 
-MODULE_PLAYGROUND=$1
+ROOTFS_PRISTINE=$1
 ROOTFS=$2
-CONFIG_H=$3
+MODULE_PLAYGROUND=$3
+CONFIG_H=$4
+
+# create rootfs from rootfs-pristine
+
+create_rootfs() {
+	rm -rf "$ROOTFS"
+	mkdir -p $(dirname "$ROOTFS")
+	cp -r "$ROOTFS_PRISTINE" "$ROOTFS"
+	find "$ROOTFS" -type d -exec chmod +w {} \;
+	find "$ROOTFS" -type f -name .gitignore -exec rm -f {} \;
+}
 
 feature_enabled() {
 	local feature=$1
@@ -99,6 +110,8 @@ attach_pkcs7_array=(
     "test-modinfo/mod-simple-pkcs7.ko"
     )
 
+create_rootfs
+
 for k in "${!map[@]}"; do
     dst=${ROOTFS}/$k
     src=${MODULE_PLAYGROUND}/${map[$k]}
@@ -143,3 +156,5 @@ done
 for m in "${attach_pkcs7_array[@]}"; do
     cat "${MODULE_PLAYGROUND}/dummy.pkcs7" >>"${ROOTFS}/$m"
 done
+
+touch testsuite/stamp-rootfs
-- 
2.39.1

