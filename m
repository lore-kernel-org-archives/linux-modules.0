Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29ACEC6FD18
	for <linux-modules@archiver.kernel.org>; Wed, 19 Apr 2023 04:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDSEhF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 19 Apr 2023 00:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjDSEhE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 19 Apr 2023 00:37:04 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5357297
        for <linux-modules@vger.kernel.org>; Tue, 18 Apr 2023 21:37:02 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-yyLvVTcoMf2-qj5HLDZvig-1; Wed, 19 Apr 2023 00:36:57 -0400
X-MC-Unique: yyLvVTcoMf2-qj5HLDZvig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9807B8996E0;
        Wed, 19 Apr 2023 04:36:57 +0000 (UTC)
Received: from dreadlord.bne.redhat.com (fdacunha.bne.redhat.com [10.64.0.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F2A1C15BAD;
        Wed, 19 Apr 2023 04:36:55 +0000 (UTC)
From:   Dave Airlie <airlied@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Dave Airlie <airlied@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] modules/firmware: add a new option to denote a firmware group to choose one.
Date:   Wed, 19 Apr 2023 14:36:52 +1000
Message-Id: <20230419043652.1773413-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Dave Airlie <airlied@redhat.com>

This adds a tag that will go into the module info, only one firmware from
the group given needs to be available for this driver to work. This allows
dracut to avoid adding in firmware that aren't needed.

This just brackets a module list in the modinfo, the modules in the list
will get entries in reversed order so the last module in the list is the
preferred one.

The corresponding dracut code it at:
https://github.com/dracutdevs/dracut/pull/2309

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 include/linux/module.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 4435ad9439ab..f02448ed5e2b 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -289,6 +289,8 @@ extern typeof(name) __mod_##type##__##name##_device_table		\
  * files require multiple MODULE_FIRMWARE() specifiers */
 #define MODULE_FIRMWARE(_firmware) MODULE_INFO(firmware, _firmware)
 
+#define MODULE_FIRMWARE_GROUP_ONLY_ONE(_grpname) MODULE_INFO(firmware_group_only_one, _grpname)
+
 #define MODULE_IMPORT_NS(ns)	MODULE_INFO(import_ns, __stringify(ns))
 
 struct notifier_block;
-- 
2.39.2

