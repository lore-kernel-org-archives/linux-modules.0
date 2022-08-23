Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFCCC32772
	for <linux-modules@archiver.kernel.org>; Tue, 23 Aug 2022 20:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiHWUMY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 23 Aug 2022 16:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiHWUMC (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 23 Aug 2022 16:12:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A217435C
        for <linux-modules@vger.kernel.org>; Tue, 23 Aug 2022 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661283151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H+uuhl1NN5QAxVTi9BhvP08GGdmaB2im78PYqW4VJEw=;
        b=TEIZ63yiSTRQqzSQnr2HhogApCnUQegefG+g4g3WDz9g/OeYtomw/sSudU3/skeQbMw68w
        6UJkziwNi4IrfgF3A+T6C/tbSNcvdxjaS6BiIPi8Q0zXac9UGO2PUCUkb7ym06ljYQz1vr
        n1M5tkSmIrRZVH03TvVzynPo60UWQh4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-646-9shGXT8qMb6sqpqlRu2CZw-1; Tue, 23 Aug 2022 15:32:29 -0400
X-MC-Unique: 9shGXT8qMb6sqpqlRu2CZw-1
Received: by mail-wm1-f69.google.com with SMTP id f18-20020a05600c4e9200b003a5f81299caso8367853wmq.7
        for <linux-modules@vger.kernel.org>; Tue, 23 Aug 2022 12:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=H+uuhl1NN5QAxVTi9BhvP08GGdmaB2im78PYqW4VJEw=;
        b=uK2xPj3esS2FQCikpA1WM4iGgOcfnnY9kdH3U6nE+KwqNoKjJgdNt4EIwdh/dP5hTr
         +fdb/3KKvCwAi7dcndIVws+nk4vkOIsQ/j4Zi6u1+cCOOgvohbYaX/s8EVcUsYY1fj/5
         YBum6ICHt5oWa417kfdzvZNTUwN41ftMVDbJpje4IF5BQrhfLy+RzE6CvumuiWOlFPbY
         UAGKkZRhvpCUZ0K8PN8S3/YHtqPTABtt/7Yl1ea/iK4RcFzXZTs0XkdaGbW5k/QR4uVC
         zI+pCcfv3udoZhAlYEs5Ao44qL66JGYd3has6emzehxx5/ys5wdNEcRK49oteGy//B6E
         RfGg==
X-Gm-Message-State: ACgBeo1N61ajqSdUI/bj74A75AWaHnRwy85HpV2gmQOff84pQ7oJeaQ4
        0ygZtxfAUqieh6yhVXckhNek041ce9ZgZKXb+fudxOzZeJMFtieN/Zs9oX5Y1FL+7oV2IVaEyq+
        UWMPxZv+23NIk4UEg7aHekayX
X-Received: by 2002:a05:600c:3514:b0:3a5:dc71:d9c4 with SMTP id h20-20020a05600c351400b003a5dc71d9c4mr3164887wmq.42.1661283147975;
        Tue, 23 Aug 2022 12:32:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6vhXh7wc08Je7KJIA0KF0gMVDREzyVEI+mbql4xGLu+MnUDvZwRlIZchn/+sMZztXegMEpMg==
X-Received: by 2002:a05:600c:3514:b0:3a5:dc71:d9c4 with SMTP id h20-20020a05600c351400b003a5dc71d9c4mr3164879wmq.42.1661283147767;
        Tue, 23 Aug 2022 12:32:27 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c1d9000b003a5fcae64d4sm19528005wms.29.2022.08.23.12.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 12:32:26 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com
Subject: [PATCH modules-next] module: Add debugfs interface to view unloaded tainted modules
Date:   Tue, 23 Aug 2022 20:32:25 +0100
Message-Id: <20220823193225.2072649-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This patch provides debug/modules/unloaded_tainted file to see
a record of unloaded tainted modules.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/tracking.c | 66 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 7f8133044d09..015e641bc346 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -10,6 +10,7 @@
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/list.h>
+#include <linux/debugfs.h>
 #include <linux/rculist.h>
 #include "internal.h"
 
@@ -59,3 +60,68 @@ void print_unloaded_tainted_modules(void)
 		}
 	}
 }
+
+#ifdef CONFIG_DEBUG_FS
+static void *unloaded_tainted_modules_seq_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&module_mutex);
+	return seq_list_start_rcu(&unloaded_tainted_modules, *pos);
+}
+
+static void *unloaded_tainted_modules_seq_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	return seq_list_next_rcu(p, &unloaded_tainted_modules, pos);
+}
+
+static void unloaded_tainted_modules_seq_stop(struct seq_file *m, void *p)
+{
+	mutex_unlock(&module_mutex);
+}
+
+static int unloaded_tainted_modules_seq_show(struct seq_file *m, void *p)
+{
+	struct mod_unload_taint *mod_taint;
+	char buf[MODULE_FLAGS_BUF_SIZE];
+	size_t l;
+
+	mod_taint = list_entry(p, struct mod_unload_taint, list);
+	l = module_flags_taint(mod_taint->taints, buf);
+	buf[l++] = '\0';
+
+	seq_printf(m, "%s (%s) %llu", mod_taint->name, buf, mod_taint->count);
+	seq_puts(m, "\n");
+
+	return 0;
+}
+
+static const struct seq_operations unloaded_tainted_modules_seq_ops = {
+	.start = unloaded_tainted_modules_seq_start,
+	.next  = unloaded_tainted_modules_seq_next,
+	.stop  = unloaded_tainted_modules_seq_stop,
+	.show  = unloaded_tainted_modules_seq_show,
+};
+
+static int unloaded_tainted_modules_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &unloaded_tainted_modules_seq_ops);
+}
+
+static const struct file_operations unloaded_tainted_modules_fops = {
+	.open = unloaded_tainted_modules_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static int __init unloaded_tainted_modules_init(void)
+{
+	struct dentry *dir;
+
+	dir = debugfs_create_dir("modules", NULL);
+	debugfs_create_file("unloaded_tainted", 0444, dir, NULL,
+			    &unloaded_tainted_modules_fops);
+
+	return 0;
+}
+module_init(unloaded_tainted_modules_init);
+#endif /* CONFIG_DEBUG_FS */

base-commit: 554694ba120b87e39cf732ed632e6a0c52fafb7c
-- 
2.37.1

