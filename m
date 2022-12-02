Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF1DC4332F
	for <linux-modules@archiver.kernel.org>; Fri,  2 Dec 2022 22:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbiLBWsX (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 2 Dec 2022 17:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiLBWsL (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 2 Dec 2022 17:48:11 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C88A6CEB
        for <linux-modules@vger.kernel.org>; Fri,  2 Dec 2022 14:48:08 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id j20-20020a056e02219400b00300a22a7fe0so6782838ila.3
        for <linux-modules@vger.kernel.org>; Fri, 02 Dec 2022 14:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZkL2mzVFhVdShj7BdixsMt9iJ1crReLgzm32R5ZX4A=;
        b=eTxd1if7I2PlmTTqNfma8EthWz1pu5SyQ/Trbnp3mDe+8QjCa+w7N7/qQuwYTnsYAe
         xDm+pjLN/1+uOxoghtWda8DcBxyEZZ/atuAYO34dgOBsPLtC6uYVLdF8v6lfDn8YUvRJ
         Q8X0p3Vmr26UD6VFov0sxjtaGZJLlMcfRzUrzvIM95S9T+oKE51PiQZvrxkIh/pZjQuS
         98sVQ9xr4bPQqwBExHo9uR+GzT86VRV0bhmd+lWqvWWSPrWN/NbIpw+dltxWTe709qzj
         ib9y2Y9oe43/FDrWFq6s8HTOZd+ibhul981XarIZoHGTjjjU/K3+9Lw2xh+rnZjtpaXf
         0fYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZkL2mzVFhVdShj7BdixsMt9iJ1crReLgzm32R5ZX4A=;
        b=bysHpcP0N+8C8T9P3HZoFK3OxQo6UUWvpNPOxAfFvNQiZm+7mrhyV4JimiOIMv13pk
         EkDyJ7LIcO4aK7GMpPvmKDKuCWXysLItABzCjU47yZuoBh2k9KokYW5CELqFROecu0xF
         FAR3Wli3V3c2HkRFzKbswr7nukhRCjiE+pL8g7GQY2h7zv5kBlvcUkBy8DetGL9iQ2NF
         LKFd08ySQB1D9L4SQqk5Vt+AQiUCyQW+SkJqHIzdL7Eug7+krei9Yicr9CJDG1obYYxT
         AAlDV1vUgdhS7hLtPgyC60PZIrJdpbhxQn7Fci1Il3I9O/mSG5nRVii221NTLU9A1ABS
         QcEw==
X-Gm-Message-State: ANoB5pmBsAX8SeVU2pmzAg124qAc59ilZ7AoH8nBgEj/FPIeyMvMPXoT
        S/gutC9LcK3j4KdOeUUMYIiS/Qy5x/droEIeVdAIdL6UnHDUwpGucpnq5A4xfNQQ5m+iklHUej+
        DEUFYL8T0j6+j6QaVEVSR7P39JicmSm9tN76PxHrW0VNrRI46+bIKTd/ODYVdB8T2Pw4BEsKAWI
        DA7cU=
X-Google-Smtp-Source: AA0mqf4CUEbp5f3KOGSPXC6yqYWsYvWS7F4SXJGXcppDhUu8bi4voAssmnRsRF4p1fkxFN+LhhnRUF4J3/qbJmk=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6602:408b:b0:6bb:f9be:3691 with SMTP
 id bl11-20020a056602408b00b006bbf9be3691mr31961743iob.123.1670021288075; Fri,
 02 Dec 2022 14:48:08 -0800 (PST)
Date:   Fri,  2 Dec 2022 16:47:44 -0600
In-Reply-To: <20221202224744.1447448-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221202224540.1446952-1-allenwebb@google.com> <20221202224744.1447448-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221202224744.1447448-5-allenwebb@google.com>
Subject: [PATCH v6 5/5] drivers: Implement module modaliases for USB
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

Add the per-subsystem logic needed to print match-based modaliases to
the USB subsystem, so the modalias sysfs attribute for modules will
function for modules that register USB drivers.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 drivers/base/Makefile          |   2 +-
 drivers/base/base.h            |   8 +
 drivers/base/mod_devicetable.c | 257 +++++++++++++++++++++++++++++++++
 drivers/usb/core/driver.c      |   2 +
 4 files changed, 268 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/mod_devicetable.c

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 83217d243c25b..924d46ae987f4 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -15,7 +15,7 @@ obj-y				+= firmware_loader/
 obj-$(CONFIG_NUMA)	+= node.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory.o
 ifeq ($(CONFIG_SYSFS),y)
-obj-$(CONFIG_MODULES)	+= module.o
+obj-$(CONFIG_MODULES)	+= mod_devicetable.o module.o
 endif
 obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
 obj-$(CONFIG_REGMAP)	+= regmap/
diff --git a/drivers/base/base.h b/drivers/base/base.h
index b902d1ecc247f..fec56271104fa 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -173,6 +173,14 @@ static inline void module_add_driver(struct module *mod,
 static inline void module_remove_driver(struct device_driver *drv) { }
 #endif
 
+#if defined(CONFIG_SYSFS) && defined(CONFIG_MODULES)
+ssize_t usb_drv_to_modalias(struct device_driver *drv, char *buf,
+			    size_t count);
+#else
+static inline ssize_t usb_drv_to_modalias(struct device_driver *drv, char *buf,
+					  size_t count) { return -EINVAL; }
+#endif
+
 #ifdef CONFIG_DEVTMPFS
 extern int devtmpfs_init(void);
 #else
diff --git a/drivers/base/mod_devicetable.c b/drivers/base/mod_devicetable.c
new file mode 100644
index 0000000000000..d7f198aad430f
--- /dev/null
+++ b/drivers/base/mod_devicetable.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mod_devicetable.c - helpers for displaying modaliases through sysfs.
+ *
+ * This borrows a lot from file2alias.c
+ */
+
+#include <linux/device/bus.h>
+#include <linux/device.h>
+#include <linux/usb.h>
+
+#include "base.h"
+#include "../usb/core/usb.h"
+
+/* Helper macro to add a modalias field to the string buffer associated with
+ * a match id.
+ *
+ * Note that:
+ *   + len should be a ssize_t and is modified in the macro
+ *   + sep should be a string literal and is concatenated as part of a format
+ *     string
+ *   + field is the struct field of the match id
+ */
+#define ADD(buf, count, len, sep, cond, field)				\
+do {				                                        \
+	char *buf_ = buf;						\
+	size_t count_ = count;                                          \
+	if (cond)							\
+		(len) += scnprintf(&buf_[len],				\
+			count_ - (len),					\
+			sizeof(field) == 1 ? (sep "%02X") :		\
+			sizeof(field) == 2 ? (sep "%04X") :		\
+			sizeof(field) == 4 ? (sep "%08X") : "",		\
+			(field));					\
+	else								\
+		(len) += scnprintf(&buf_[len], count_ - (len), (sep "*")); \
+} while (0)
+
+#ifdef CONFIG_USB
+/* USB related modaliases can be split because of device number matching, so
+ * this function handles individual modaliases for one segment of the range.
+ */
+static ssize_t usb_id_to_modalias(const struct usb_device_id *id,
+				  unsigned int bcdDevice_initial,
+				  int bcdDevice_initial_digits,
+				  unsigned char range_lo,
+				  unsigned char range_hi,
+				  unsigned char max, const char *mod_name,
+				  char *buf, size_t count)
+{
+	ssize_t len = 0;
+
+	ADD(buf, count, len, "alias usb:v",
+	    id->match_flags & USB_DEVICE_ID_MATCH_VENDOR, id->idVendor);
+	ADD(buf, count, len, "p", id->match_flags & USB_DEVICE_ID_MATCH_PRODUCT,
+	    id->idProduct);
+
+	len += scnprintf(&buf[len], count - len, "d");
+	if (bcdDevice_initial_digits)
+		len += scnprintf(&buf[len], count - len, "%0*X",
+			bcdDevice_initial_digits, bcdDevice_initial);
+	if (range_lo == range_hi) {
+		len += scnprintf(&buf[len], count - len, "%X", range_lo);
+	} else if (range_lo > 0 || range_hi < max) {
+		if (range_lo > 0x9 || range_hi < 0xA) {
+			len += scnprintf(&buf[len], count - len, "[%X-%X]",
+					 range_lo, range_hi);
+		} else {
+			len += scnprintf(&buf[len], count - len,
+				range_lo < 0x9 ? "[%X-9" : "[%X",
+				range_lo);
+			len += scnprintf(&buf[len], count - len,
+				range_hi > 0xA ? "A-%X]" : "%X]",
+				range_hi);
+		}
+	}
+	if (bcdDevice_initial_digits < (sizeof(id->bcdDevice_lo) * 2 - 1))
+		len += scnprintf(&buf[len], count - len, "*");
+
+	ADD(buf, count, len, "dc",
+	    id->match_flags & USB_DEVICE_ID_MATCH_DEV_CLASS, id->bDeviceClass);
+	ADD(buf, count, len, "dsc",
+	    id->match_flags & USB_DEVICE_ID_MATCH_DEV_SUBCLASS,
+	    id->bDeviceSubClass);
+	ADD(buf, count, len, "dp",
+	    id->match_flags & USB_DEVICE_ID_MATCH_DEV_PROTOCOL,
+	    id->bDeviceProtocol);
+	ADD(buf, count, len, "ic",
+	    id->match_flags & USB_DEVICE_ID_MATCH_INT_CLASS,
+	    id->bInterfaceClass);
+	ADD(buf, count, len, "isc",
+	    id->match_flags & USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	    id->bInterfaceSubClass);
+	ADD(buf, count, len, "ip",
+	    id->match_flags & USB_DEVICE_ID_MATCH_INT_PROTOCOL,
+	    id->bInterfaceProtocol);
+	ADD(buf, count, len, "in",
+	    id->match_flags & USB_DEVICE_ID_MATCH_INT_NUMBER,
+	    id->bInterfaceNumber);
+
+	len += scnprintf(&buf[len], count - len, " %s\n", mod_name);
+	return len;
+}
+
+/* Handles increment/decrement of BCD formatted integers */
+/* Returns the previous value, so it works like i++ or i-- */
+static unsigned int incbcd(unsigned int *bcd,
+			   int inc,
+			   unsigned char max,
+			   size_t chars)
+{
+	unsigned int init = *bcd, i, j;
+	unsigned long long c, dec = 0, div;
+
+	/* If bcd is not in BCD format, just increment */
+	if (max > 0x9) {
+		*bcd += inc;
+		return init;
+	}
+
+	/* Convert BCD to Decimal */
+	for (i = 0 ; i < chars ; i++) {
+		c = (*bcd >> (i << 2)) & 0xf;
+		c = c > 9 ? 9 : c; /* force to bcd just in case */
+		for (j = 0 ; j < i ; j++)
+			c = c * 10;
+		dec += c;
+	}
+
+	/* Do our increment/decrement */
+	dec += inc;
+	*bcd  = 0;
+
+	/* Convert back to BCD */
+	for (i = 0 ; i < chars ; i++) {
+		for (c = 1, j = 0 ; j < i ; j++)
+			c = c * 10;
+		div = dec;
+		(void)do_div(div, c); /* div = div / c */
+		c = do_div(div, 10); /* c = div % 10; div = div / 10 */
+		*bcd += c << (i << 2);
+	}
+	return init;
+}
+
+/* Print the modaliases for the specified struct usb_device_id. */
+static ssize_t usb_id_to_modalias_multi(const struct usb_device_id *id,
+					const char *mod_name, char *buf,
+					size_t count)
+{
+	ssize_t len = 0;
+	unsigned int devlo, devhi;
+	unsigned char chi, clo, max;
+	int ndigits;
+
+	devlo = id->match_flags & USB_DEVICE_ID_MATCH_DEV_LO ?
+		id->bcdDevice_lo : 0x0U;
+	devhi = id->match_flags & USB_DEVICE_ID_MATCH_DEV_HI ?
+		id->bcdDevice_hi : ~0x0U;
+
+	/* Figure out if this entry is in bcd or hex format */
+	max = 0x9; /* Default to decimal format */
+	for (ndigits = 0 ; ndigits < sizeof(id->bcdDevice_lo) * 2 ; ndigits++) {
+		clo = (devlo >> (ndigits << 2)) & 0xf;
+		chi = ((devhi > 0x9999 ? 0x9999 : devhi) >>
+		       (ndigits << 2)) & 0xf;
+		if (clo > max || chi > max) {
+			max = 0xf;
+			break;
+		}
+	}
+
+	/*
+	 * Some modules (visor) have empty slots as placeholder for
+	 * run-time specification that results in catch-all alias
+	 */
+	if (!(id->idVendor || id->idProduct || id->bDeviceClass ||
+	      id->bInterfaceClass))
+		return len;
+
+	/* Convert numeric bcdDevice range into fnmatch-able pattern(s) */
+	for (ndigits = sizeof(id->bcdDevice_lo) * 2 - 1; devlo <= devhi;
+	     ndigits--) {
+		clo = devlo & 0xf;
+		chi = devhi & 0xf;
+		/* If we are in bcd mode, truncate if necessary */
+		if (chi > max)
+			chi = max;
+		devlo >>= 4;
+		devhi >>= 4;
+
+		if (devlo == devhi || !ndigits) {
+			len += usb_id_to_modalias(id, devlo, ndigits, clo, chi,
+						  max, mod_name, buf + len,
+						  count - len);
+			break;
+		}
+
+		if (clo > 0x0)
+			len += usb_id_to_modalias(id,
+				incbcd(&devlo, 1, max,
+				       sizeof(id->bcdDevice_lo) * 2),
+				ndigits, clo, max, max, mod_name, buf + len,
+				count - len);
+
+		if (chi < max)
+			len += usb_id_to_modalias(id,
+				incbcd(&devhi, -1, max,
+				       sizeof(id->bcdDevice_lo) * 2),
+				ndigits, 0x0, chi, max, mod_name, buf + len,
+				count - len);
+	}
+	return len;
+}
+
+/* Print the modaliases for the given driver assumed to be an usb_driver or
+ * usb_device_driver.
+ *
+ * "alias" is prepended and the module name is appended to each modalias to
+ * match the format in modules.aliases.
+ *
+ * The modaliases will be written out to @buf with @count being the maximum
+ * bytes to write. The return value is a negative errno on error or the number
+ * of bytes written to @buf on success.
+ */
+ssize_t usb_drv_to_modalias(struct device_driver *drv, char *buf,
+			    size_t count)
+{
+	ssize_t len = 0;
+	const struct usb_device_id *id;
+	const char *mod_name;
+
+	if (drv->bus != &usb_bus_type)
+		return -EINVAL;
+
+	if (drv->owner)
+		mod_name = drv->owner->name;
+	else
+		mod_name = drv->mod_name;
+
+	if (is_usb_device_driver(drv))
+		id = to_usb_device_driver(drv)->id_table;
+	else
+		id = to_usb_driver(drv)->id_table;
+	if (!id)
+		return len;
+
+	for (; id->match_flags; id++) {
+		len += usb_id_to_modalias_multi(id, mod_name, buf + len,
+						count - len);
+	}
+	return len;
+}
+#else
+inline ssize_t usb_drv_to_modalias(struct device_driver *drv, char *buf,
+				   size_t count){ return 0; }
+#endif
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 7e7e119c253fb..fdbc197b64c9c 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -32,6 +32,7 @@
 #include <linux/usb/quirks.h>
 #include <linux/usb/hcd.h>
 
+#include "../../base/base.h"
 #include "usb.h"
 
 
@@ -2030,4 +2031,5 @@ struct bus_type usb_bus_type = {
 	.match =	usb_device_match,
 	.uevent =	usb_uevent,
 	.need_parent_lock =	true,
+	.drv_to_modalias = usb_drv_to_modalias,
 };
-- 
2.37.3

