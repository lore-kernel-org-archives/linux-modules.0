Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFBFC001B0
	for <linux-modules@archiver.kernel.org>; Tue,  4 Jul 2023 02:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjGDCzF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 3 Jul 2023 22:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjGDCzE (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 3 Jul 2023 22:55:04 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38CD1B2
        for <linux-modules@vger.kernel.org>; Mon,  3 Jul 2023 19:55:01 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-wHWhqlMSPwm3HmExVeIYhQ-1; Mon, 03 Jul 2023 22:53:33 -0400
X-MC-Unique: wHWhqlMSPwm3HmExVeIYhQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F4241C29AE0;
        Tue,  4 Jul 2023 02:53:32 +0000 (UTC)
Received: from nomad.redhat.com (vpn2-54-59.bne.redhat.com [10.64.54.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 467D740C6CD0;
        Tue,  4 Jul 2023 02:53:30 +0000 (UTC)
From:   Dave Airlie <airlied@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
Cc:     Dave Airlie <airlied@redhat.com>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/2] docs: module: start adding some docs for MODULE_ macros.
Date:   Tue,  4 Jul 2023 12:50:49 +1000
Message-ID: <20230704025322.2623556-2-airlied@gmail.com>
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

In order to add a new macro, Luis suggested converting some docs
for the new ones.

This tries to keep exisiting module_init, module_exit where they are,
and adds the new docs to the module section.

Cc: linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 Documentation/core-api/kernel-api.rst |  3 ++
 Documentation/driver-api/basics.rst   |  2 +-
 include/linux/module.h                | 76 ++++++++++++++++++---------
 3 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 9b3f3e5f5a95..5079e48dd58c 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -226,6 +226,9 @@ Kernel module auto-loading
 .. kernel-doc:: kernel/module/kmod.c
    :export:
 
+.. kernel-doc:: include/linux/module.h
+   :no-identifiers: module_init module_exit klp_modinfo
+
 Module debugging
 ----------------
 
diff --git a/Documentation/driver-api/basics.rst b/Documentation/driver-api/basics.rst
index 4b4d8e28d3be..fea42d6cad80 100644
--- a/Documentation/driver-api/basics.rst
+++ b/Documentation/driver-api/basics.rst
@@ -5,7 +5,7 @@ Driver Entry and Exit points
 ----------------------------
 
 .. kernel-doc:: include/linux/module.h
-   :internal:
+   :identifiers: module_init module_exit
 
 Driver device table
 -------------------
diff --git a/include/linux/module.h b/include/linux/module.h
index 9e56763dff81..b255db33b40f 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -183,23 +183,27 @@ extern void cleanup_module(void);
 #define MODULE_FILE	MODULE_INFO(file, KBUILD_MODFILE);
 #endif
 
-/*
+/**
+ * MODULE_LICENSE - module license
+ * @_license: license covering this module.
+ *
  * The following license idents are currently accepted as indicating free
  * software modules
  *
- *	"GPL"				[GNU Public License v2]
- *	"GPL v2"			[GNU Public License v2]
- *	"GPL and additional rights"	[GNU Public License v2 rights and more]
- *	"Dual BSD/GPL"			[GNU Public License v2
- *					 or BSD license choice]
- *	"Dual MIT/GPL"			[GNU Public License v2
- *					 or MIT license choice]
- *	"Dual MPL/GPL"			[GNU Public License v2
- *					 or Mozilla license choice]
+ *    "GPL"                        [GNU Public License v2]
  *
- * The following other idents are available
+ *    "GPL v2"                     [GNU Public License v2]
  *
- *	"Proprietary"			[Non free products]
+ *    "GPL and additional rights"  [GNU Public License v2 rights and more]
+ *
+ *    "Dual BSD/GPL"               [GNU Public License v2 or BSD license choice]
+ *
+ *    "Dual MIT/GPL"               [GNU Public License v2 or MIT license choice]
+ *
+ *    "Dual MPL/GPL"               [GNU Public License v2 or Mozilla license choice]
+ *
+ * The following other idents are available
+ *    "Proprietary"                [Non free products]
  *
  * Both "GPL v2" and "GPL" (the latter also in dual licensed strings) are
  * merely stating that the module is licensed under the GPL v2, but are not
@@ -222,20 +226,26 @@ extern void cleanup_module(void);
  * is a GPL combined work.
  *
  * This exists for several reasons
- * 1.	So modinfo can show license info for users wanting to vet their setup
- *	is free
+ *
+ * 1.	So modinfo can show license info for users wanting to vet their setup is free
+ *
  * 2.	So the community can ignore bug reports including proprietary modules
+ *
  * 3.	So vendors can do likewise based on their own policies
  */
 #define MODULE_LICENSE(_license) MODULE_FILE MODULE_INFO(license, _license)
 
-/*
- * Author(s), use "Name <email>" or just "Name", for multiple
- * authors use multiple MODULE_AUTHOR() statements/lines.
+/**
+ * MODULE_AUTHOR - Module author
+ * @_author: Author(s), use "Name <email>" or just "Name", for multiple
+ *           authors use multiple MODULE_AUTHOR() statements/lines.
  */
 #define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)
 
-/* What your module does. */
+/**
+ * MODULE_DESCRIPTION - Module description
+ * @_description: What your module does.
+ */
 #define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
 
 #ifdef MODULE
@@ -247,19 +257,23 @@ extern typeof(name) __mod_##type##__##name##_device_table		\
 #define MODULE_DEVICE_TABLE(type, name)
 #endif
 
-/* Version of form [<epoch>:]<version>[-<extra-version>].
+/**
+ * MODULE_VERSION: version of module
+ * @_version: version in the form below
+ *
+ * Version of form [<epoch>:]<version>[-<extra-version>].
  * Or for CVS/RCS ID version, everything but the number is stripped.
  * <epoch>: A (small) unsigned integer which allows you to start versions
  * anew. If not mentioned, it's zero.  eg. "2:1.0" is after
  * "1:2.0".
-
+ *
  * <version>: The <version> may contain only alphanumerics and the
- * character `.'.  Ordered by numeric sort for numeric parts,
+ * character '.'.  Ordered by numeric sort for numeric parts,
  * ascii sort for ascii parts (as per RPM or DEB algorithm).
-
+ *
  * <extraversion>: Like <version>, but inserted for local
  * customizations, eg "rh3" or "rusty1".
-
+ *
  * Using this automatically adds a checksum of the .c files and the
  * local headers in "srcversion".
  */
@@ -285,11 +299,21 @@ extern typeof(name) __mod_##type##__##name##_device_table		\
 		}
 #endif
 
-/* Optional firmware file (or files) needed by the module
- * format is simply firmware file name.  Multiple firmware
- * files require multiple MODULE_FIRMWARE() specifiers */
+/**
+ * MODULE_FIRMWARE - Optional firmware files needed by the module
+ * @_firmware: firmware file name
+ *
+ * Multiple firmware files require multiple MODULE_FIRMWARE() specifiers.
+ */
 #define MODULE_FIRMWARE(_firmware) MODULE_INFO(firmware, _firmware)
 
+/**
+ * MODULE_IMPORT_NS - Set the symbol namespace for the module.
+ * @ns: symbol namespace to import the module into.
+ *
+ * This adds a modinfo tag 'import_ns' to the module. This is observed
+ * by userspace at module loading time.
+ */
 #define MODULE_IMPORT_NS(ns)	MODULE_INFO(import_ns, __stringify(ns))
 
 struct notifier_block;
-- 
2.41.0

