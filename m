Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDF8C001DB
	for <linux-modules@archiver.kernel.org>; Tue,  4 Jul 2023 02:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjGDCzE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 3 Jul 2023 22:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjGDCzD (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 3 Jul 2023 22:55:03 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6B0E49
        for <linux-modules@vger.kernel.org>; Mon,  3 Jul 2023 19:55:01 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-pE3BurX5Px6usp1Ejjf5PQ-1; Mon, 03 Jul 2023 22:53:35 -0400
X-MC-Unique: pE3BurX5Px6usp1Ejjf5PQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06C1686F122;
        Tue,  4 Jul 2023 02:53:35 +0000 (UTC)
Received: from nomad.redhat.com (vpn2-54-59.bne.redhat.com [10.64.54.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8755440C6CCD;
        Tue,  4 Jul 2023 02:53:33 +0000 (UTC)
From:   Dave Airlie <airlied@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
Cc:     Dave Airlie <airlied@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/2] modules/firmware: add a new option to denote a firmware group to choose one.
Date:   Tue,  4 Jul 2023 12:50:50 +1000
Message-ID: <20230704025322.2623556-3-airlied@gmail.com>
In-Reply-To: <20230704025322.2623556-1-airlied@gmail.com>
References: <20230704025322.2623556-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: Dave Airlie <airlied@redhat.com>

This adds two tags that will go into the module info.

The first denotes a group of firmwares, when that tag is present all
MODULE_FIRMWARE lines between the tags will be ignored by new versions of
dracut.

The second makes an explicitly ordered group of firmwares to search for
inside a group setting. New dracut will pick the first available firmware
from this to put in the initramfs.

Old dracut will just ignore these tags and fallback to installing all
the firmwares.

The corresponding dracut code it at:
https://github.com/dracutdevs/dracut/pull/2309

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 include/linux/module.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index b255db33b40f..b7bef5814034 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -307,6 +307,40 @@ extern typeof(name) __mod_##type##__##name##_device_table		\
  */
 #define MODULE_FIRMWARE(_firmware) MODULE_INFO(firmware, _firmware)
 
+/**
+ * MODULE_FIRMWARE_GROUP_ONLY_ONE - Create a need only one firmware group
+ * @_grpname: group name
+ *
+ * This creates a group boundary of which the driver only needs one firmware installed.
+ * This is to allow dracut to limit the number of firmwares in the initramfs.
+ * This just creates a new entry in the modinfo section, there should be one
+ * of these entries bracketing the group of MODULE_INFO lines.
+ *
+ * Old dracut will ignore this, and just read MODULE_FIRMWARE.
+ * New dracut will ignore MODULE_FIRMWARE lines between group boundaries,
+ * and will only parse the new group list.
+ * It will pick the first found firmware from the group list.
+ *
+ * ``MODULE_FIRMWARE_GROUP_ONLY_ONE("mygroup")``
+ *
+ * ``MODULE_FIRMWARE_GROUP_LIST("firmwarev2,firmwarev1")``
+ *
+ * ``MODULE_FIRMWARE("firmwarev1")``
+ *
+ * ``MODULE_FIRMWARE("firmwarev2")``
+ *
+ * ``MODULE_FIRMWARE_GROUP_ONLY_ONE("mygroup")``
+ */
+#define MODULE_FIRMWARE_GROUP_ONLY_ONE(_grpname) MODULE_INFO(firmware_group_only_one, _grpname)
+
+/**
+ * MODULE_FIRMWARE_GROUP_LIST - Create a need one firmware list
+ * @_fwnames: firmware names in the group.
+ *
+ * See MODULE_FIRMWARE_GROUP_ONLY_ONE.
+ */
+#define MODULE_FIRMWARE_GROUP_LIST(_fwnames) MODULE_INFO(firmware_group_list, _fwnames)
+
 /**
  * MODULE_IMPORT_NS - Set the symbol namespace for the module.
  * @ns: symbol namespace to import the module into.
-- 
2.41.0

