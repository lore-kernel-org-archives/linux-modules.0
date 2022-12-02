Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB74C4708D
	for <linux-modules@archiver.kernel.org>; Fri,  2 Dec 2022 22:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiLBWsL (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 2 Dec 2022 17:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiLBWsG (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 2 Dec 2022 17:48:06 -0500
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AC4A320E
        for <linux-modules@vger.kernel.org>; Fri,  2 Dec 2022 14:48:04 -0800 (PST)
Received: by mail-io1-xd4a.google.com with SMTP id z6-20020a056602080600b006dfd603be92so5762451iow.11
        for <linux-modules@vger.kernel.org>; Fri, 02 Dec 2022 14:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w0T1pgiMYpCvdig9Y/8aobVm5Xu54pAwpfqLNShdHMY=;
        b=Z7v+z+IwVUZK/AlbMeBHs81PzaHdZaOivRiZ9GgiMwNfs2wwPL53ecIB4AEN/DjARc
         8tJhA4wzXXBNUOnMja42hDHidI3OXv/rkAVJC6CrchNrRCFL38S+hoX+YIKXezmDseTD
         lOIY0w95Fa1nChba2iZIflZMF8qjsDWr9FhimNVGAz0qAGE1K1hgefhtCMjfwv1LX+HN
         EvNBWmVa7A5+EOjVkDc+XIZKhJ6SdaUPlW8ZLfYK3uWI9Rzl3nkzMNag2pxB94BZuPnm
         VVB/P5stQ+dVTBXS1bZsSaMrnnsoJfstqIldT6ruSdRurJjx6rP56RZTTQhBBfG1qVXi
         WZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w0T1pgiMYpCvdig9Y/8aobVm5Xu54pAwpfqLNShdHMY=;
        b=kNiXFa6HEYywVCVXJf6vYHqkTngUHMxrrwFGBDNp/gmOWzh31uewQqo5HWc4wwcjWf
         IKrSCa+U3Gdl0H+YUt4WLeplXRL6oYIcSgMXclDwXVkGUZ8Qtcm67VpzUg2W+V0W8PGE
         F8uu4gYDlRDmjCp2uw//e6wwZbYJ1C4Qw3qw4HoDSJWdOx2ds/9aLbcTgwPbcC0Yd50V
         pj2aZ3W4tDarmnaOjpykW4eNHNuanLxeitwlzDXqYaUaEII63E9Ui1rtDlPRq/DBAux5
         w5oLhf1B7PQifihhggvmq3tD9zttH3ks7YbBYYX+g9LvGDRlZfCW98wbJlQgn3HpIyCc
         dJEw==
X-Gm-Message-State: ANoB5pmJjbXZYWQ2F2xXuCBYregdsd0MPCCC8dOPozuGGBj9YTAnF1oN
        KI3lf2qqFrPW34neO3p+0U/6/aufx+aorWIVrloW5OFsJDLfXWmtLr51BIgZxFN17bQB//KZ7/u
        TR0LvEsXPR6Sa/MPQkvuxhucS+2JuGumbqX7sjSJbt5TFV3Bhzf7d7nFGk0WV2Gq/8jnLpCKx9q
        hF278=
X-Google-Smtp-Source: AA0mqf454uOaBRdpMH7tQImIKU8IeKBYSabjea74gyZ46dDF++UaofNevPRXdyplXUheey6pXGyw7mFiDxiEwU4=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a6b:f414:0:b0:6d1:88ee:a64f with SMTP id
 i20-20020a6bf414000000b006d188eea64fmr25213041iog.61.1670021283902; Fri, 02
 Dec 2022 14:48:03 -0800 (PST)
Date:   Fri,  2 Dec 2022 16:47:42 -0600
In-Reply-To: <20221202224744.1447448-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221202224540.1446952-1-allenwebb@google.com> <20221202224744.1447448-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221202224744.1447448-3-allenwebb@google.com>
Subject: [PATCH v6 3/5] Implement modalias sysfs attribute for modules
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

When the modalias attribute is read, invoke a subsystem-specific
callback for each driver registered by the specific module.

The intent of the new modalias attribute is to expose the
match-id-based modaliases to userspace for builtin and loaded kernel
modules.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 include/linux/device/bus.h |  7 +++++
 kernel/module/sysfs.c      | 57 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 82a5583437099..cce0bedec63d9 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -61,6 +61,10 @@ struct fwnode_handle;
  *			this bus.
  * @dma_cleanup:	Called to cleanup DMA configuration on a device on
  *			this bus.
+ * @drv_to_modalias:    Called to convert the matching IDs in a
+ *                      struct device_driver to their corresponding modaliases.
+ *                      Note that the struct device_driver is expected to belong
+ *                      to this bus.
  * @pm:		Power management operations of this bus, callback the specific
  *		device driver's pm-ops.
  * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
@@ -107,6 +111,9 @@ struct bus_type {
 	int (*dma_configure)(struct device *dev);
 	void (*dma_cleanup)(struct device *dev);
 
+	ssize_t (*drv_to_modalias)(struct device_driver *drv, char *buf,
+				   size_t count);
+
 	const struct dev_pm_ops *pm;
 
 	const struct iommu_ops *iommu_ops;
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index 8dafec7455fbe..651c677c4ab96 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2008 Rusty Russell
  */
 
+#include <linux/device/bus.h>
+#include <linux/device/driver.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
@@ -240,11 +242,64 @@ static inline void add_notes_attrs(struct module *mod, const struct load_info *i
 static inline void remove_notes_attrs(struct module *mod) { }
 #endif /* CONFIG_KALLSYMS */
 
+/* Track of the buffer and module identity in callbacks when walking the list of
+ * drivers for each bus.
+ */
+struct modalias_bus_print_state {
+	struct module_kobject *mk;
+	char *buf;
+	size_t count;
+	ssize_t len;
+};
+
+static int print_modalias_for_drv(struct device_driver *drv, void *p)
+{
+	struct modalias_bus_print_state *s = p;
+	struct module_kobject *mk = s->mk;
+	ssize_t len;
+	/* Skip drivers that do not match this module. */
+	if (mk->mod) {
+		if (mk->mod != drv->owner)
+			return 0;
+	} else if (!mk->kobj.name || !drv->mod_name ||
+		   strcmp(mk->kobj.name, drv->mod_name))
+		return 0;
+
+	if (drv->bus && drv->bus->drv_to_modalias) {
+		len = drv->bus->drv_to_modalias(drv, s->buf + s->len,
+						s->count - s->len);
+		if (len < 0)
+			return len;
+		s->len += len;
+	}
+	return 0;
+}
+
+static int print_modalias_for_bus(struct bus_type *type, void *p)
+{
+	return bus_for_each_drv(type, NULL, p, print_modalias_for_drv);
+}
+
 static ssize_t module_modalias_read(struct file *filp, struct kobject *kobj,
 				    struct bin_attribute *bin_attr,
 				    char *buf, loff_t pos, size_t count)
 {
-	return 0;
+	struct module_kobject *mk = container_of(kobj, struct module_kobject,
+						 kobj);
+	struct modalias_bus_print_state state = {mk, buf, count, 0};
+	int error = 0;
+
+	if (pos != 0)
+		return -EINVAL;
+
+	error = bus_for_each(&state, print_modalias_for_bus);
+	if (error)
+		return error;
+
+	/*
+	 * The caller checked the pos and count against our size.
+	 */
+	return state.len;
 }
 
 /* Used in kernel/params.c for builtin modules.
-- 
2.37.3

