Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD65BC433F5
	for <linux-modules@archiver.kernel.org>; Sun, 28 Nov 2021 05:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhK1Fyj (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 28 Nov 2021 00:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhK1Fwi (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 28 Nov 2021 00:52:38 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C723C061757;
        Sat, 27 Nov 2021 21:48:27 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id j11so2445413pgs.2;
        Sat, 27 Nov 2021 21:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=VgaXODT8rvEp7+LP/IWv4fPFevLuEz8EvhuPo+PJq8Q=;
        b=G85qJm9qxY5gvnOdBSyBvF22Pjf3ZTQtQ/bo+vW79HSOyrRvW/1sb6f+DqKj+KIBs6
         VsN9EAXtJF0t/TShg++GgZ/cKpe5Vof+eYk+McNAc99uz8IJJRf2UqGjCkLUEGcCtuTb
         JLWBeCNFDX0fnNx2SyZslbt/mfzfGBkaum3UbPOIgmyNQK4Oad+yNWJUGWJIPiKhu2Ko
         SpbVoVOHDtG80HacS4myZUqJf5cJJWFPlMW4A1vqUlmefp9CualjgojL5UEotv6I/TTK
         6x3xZAJChTNEXMdBeMonIQImmbEB9/aXDWDrqoj3ruVJdqaEqt8WNT1bKIqwzxEs8dCT
         fhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VgaXODT8rvEp7+LP/IWv4fPFevLuEz8EvhuPo+PJq8Q=;
        b=uXfLxLQNaR6wZDr5OoVg+EMbtD0oR53yhoZiEmbovYHSbboPb46IbHktNvta44U8Tv
         UHZzyhkMgUAUy5nGolN/El2RyzgjF8RcKFKuhZn/A/eCZpNzeqTJx+cZaVb8vXkAcbnF
         jSyslHyM85vLW7xSqdkjAh5Cf2Z8rxQWGx56UkSMdXSXbgER2naiHpfWgSKftlHhDT9u
         QLzvVHpc1sC7S3P262DtojTE5I0pH5AqowvD8AR1ZkSYkIJbPaearhhR3jyUmWrBeSlD
         hUCySKssaAWAbru6xAqgr0KVw0CUSoBLMPmHkVhBDL4kU2nvAQ8xtXxcQEf2xcjkGJes
         tutw==
X-Gm-Message-State: AOAM531SSi2Ko1pN2MuQ3CQrm3YfpdBFF3ygWk6MtVZjYequYDfLVZ9o
        oz4uvaQpcFc/W7/zjJzr+rw=
X-Google-Smtp-Source: ABdhPJx8LPLXhkYopx5j9mL9L9ETh9TzfFjQ6gtpgZegZxUNhSlNPnRg6OlPaV2q2snyFTLuutBSJw==
X-Received: by 2002:aa7:9af6:0:b0:4a2:fa4a:714c with SMTP id y22-20020aa79af6000000b004a2fa4a714cmr31163936pfp.40.1638078505977;
        Sat, 27 Nov 2021 21:48:25 -0800 (PST)
Received: from google.com ([2620:15c:202:201:e23c:e000:4b6b:2f2d])
        by smtp.gmail.com with ESMTPSA id g22sm12901237pfj.29.2021.11.27.21.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 21:48:24 -0800 (PST)
Date:   Sat, 27 Nov 2021 21:48:22 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: [PATCH] module: add in-kernel support for decompressing
Message-ID: <YaMYJv539OEBz5B/@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="24sMaNk0u/i0IHj3"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


--24sMaNk0u/i0IHj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Current scheme of having userspace decompress kernel modules before
loading them into the kernel runs afoul of LoadPin security policy, as
it loses link between the source of kernel module on the disk and binary
blob that is being loaded into the kernel. To solve this issue let's
implement decompression in kernel, so that we can pass a file descriptor
of compressed module file into finit_module() which will keep LoadPin
happy.

To let userspace know what compression/decompression scheme kernel
supports it will create /sys/module/compression attribute. kmod can read
this attribute and decide if it can pass compressed file to
finit_module(). New MODULE_INIT_COMPRESSED_DATA flag indicates that the
kernel should attempt to decompress the data read from file descriptor
prior to trying load the module.

To simplify things kernel will only implement single decompression
method matching compression method selected when generating modules.
This patch implements gzip and xz; more can be added later,

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

I am also attaching a patch to kmod to make use of this new facility.

Thanks!

 include/uapi/linux/module.h |   1 +
 init/Kconfig                |  12 ++
 kernel/Makefile             |   1 +
 kernel/module-internal.h    |  18 +++
 kernel/module.c             |  35 +++--
 kernel/module_decompress.c  | 271 ++++++++++++++++++++++++++++++++++++
 6 files changed, 327 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/module.h b/include/uapi/linux/module.h
index 50d98ec5e866..becab4a1c5db 100644
--- a/include/uapi/linux/module.h
+++ b/include/uapi/linux/module.h
@@ -5,5 +5,6 @@
 /* Flags for sys_finit_module: */
 #define MODULE_INIT_IGNORE_MODVERSIONS	1
 #define MODULE_INIT_IGNORE_VERMAGIC	2
+#define MODULE_INIT_COMPRESSED_DATA	4
 
 #endif /* _UAPI_LINUX_MODULE_H */
diff --git a/init/Kconfig b/init/Kconfig
index 03d3c21e28a3..a3f37ae7436d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2309,6 +2309,18 @@ config MODULE_COMPRESS_ZSTD
 
 endchoice
 
+config MODULE_DECOMPRESS
+	bool "Support in-kernel module decompression"
+	select ZLIB_INFLATE if MODULE_COMPRESS_GZIP
+	select XZ_DEC if MODULE_COMPRESS_XZ
+	help
+
+	  Support for decompressing kernel modules by the kernel itself
+	  instead of relying on userspace to perform this task. Useful when
+	  load pinning security policy is enabled.
+
+	  If unsure, say N.
+
 config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
 	bool "Allow loading of modules with missing namespace imports"
 	help
diff --git a/kernel/Makefile b/kernel/Makefile
index 186c49582f45..56f4ee97f328 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -67,6 +67,7 @@ obj-y += up.o
 endif
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
+obj-$(CONFIG_MODULE_DECOMPRESS) += module_decompress.o
 obj-$(CONFIG_MODULE_SIG) += module_signing.o
 obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
diff --git a/kernel/module-internal.h b/kernel/module-internal.h
index 33783abc377b..3c1143d2c8c7 100644
--- a/kernel/module-internal.h
+++ b/kernel/module-internal.h
@@ -22,6 +22,11 @@ struct load_info {
 	bool sig_ok;
 #ifdef CONFIG_KALLSYMS
 	unsigned long mod_kallsyms_init_off;
+#endif
+#ifdef CONFIG_MODULE_DECOMPRESS
+	struct page **pages;
+	unsigned int max_pages;
+	unsigned int used_pages;
 #endif
 	struct {
 		unsigned int sym, str, mod, vers, info, pcpu;
@@ -29,3 +34,16 @@ struct load_info {
 };
 
 extern int mod_verify_sig(const void *mod, struct load_info *info);
+
+#ifdef CONFIG_MODULE_DECOMPRESS
+int module_decompress(struct load_info *info, const void *buf, size_t size);
+void module_decompress_cleanup(struct load_info *info);
+#else
+int module_decompress(struct load_info *info, const void *buf, size_t size)
+{
+	return -EOPNOTSUPP;
+}
+void module_decompress_cleanup(struct load_info *info)
+{
+}
+#endif
diff --git a/kernel/module.c b/kernel/module.c
index 84a9141a5e15..eeab85ea1627 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3174,9 +3174,12 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	return err;
 }
 
-static void free_copy(struct load_info *info)
+static void free_copy(struct load_info *info, int flags)
 {
-	vfree(info->hdr);
+	if (flags & MODULE_INIT_COMPRESSED_DATA)
+		module_decompress_cleanup(info);
+	else
+		vfree(info->hdr);
 }
 
 static int rewrite_section_headers(struct load_info *info, int flags)
@@ -4125,7 +4128,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	}
 
 	/* Get rid of temporary copy. */
-	free_copy(info);
+	free_copy(info, flags);
 
 	/* Done! */
 	trace_module_load(mod);
@@ -4174,7 +4177,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	module_deallocate(mod, info);
  free_copy:
-	free_copy(info);
+	free_copy(info, flags);
 	return err;
 }
 
@@ -4201,7 +4204,8 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
 SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 {
 	struct load_info info = { };
-	void *hdr = NULL;
+	void *buf = NULL;
+	int len;
 	int err;
 
 	err = may_init_module();
@@ -4211,15 +4215,24 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 	pr_debug("finit_module: fd=%d, uargs=%p, flags=%i\n", fd, uargs, flags);
 
 	if (flags & ~(MODULE_INIT_IGNORE_MODVERSIONS
-		      |MODULE_INIT_IGNORE_VERMAGIC))
+		      |MODULE_INIT_IGNORE_VERMAGIC
+		      |MODULE_INIT_COMPRESSED_DATA))
 		return -EINVAL;
 
-	err = kernel_read_file_from_fd(fd, 0, &hdr, INT_MAX, NULL,
+	len = kernel_read_file_from_fd(fd, 0, &buf, INT_MAX, NULL,
 				       READING_MODULE);
-	if (err < 0)
-		return err;
-	info.hdr = hdr;
-	info.len = err;
+	if (len < 0)
+		return len;
+
+	if (flags & MODULE_INIT_COMPRESSED_DATA) {
+		err = module_decompress(&info, buf, len);
+		vfree(buf); /* compressed data is no longer needed */
+		if (err)
+			return err;
+	} else {
+		info.hdr = buf;
+		info.len = len;
+	}
 
 	return load_module(&info, uargs, flags);
 }
diff --git a/kernel/module_decompress.c b/kernel/module_decompress.c
new file mode 100644
index 000000000000..590ca00aa098
--- /dev/null
+++ b/kernel/module_decompress.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2021 Google LLC.
+ */
+
+#include <linux/init.h>
+#include <linux/highmem.h>
+#include <linux/kobject.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/vmalloc.h>
+
+#include "module-internal.h"
+
+static int module_extend_max_pages(struct load_info *info, unsigned int extent)
+{
+	struct page **new_pages;
+
+	new_pages = kvmalloc_array(info->max_pages + extent,
+				   sizeof(info->pages), GFP_KERNEL);
+	if (!new_pages)
+		return -ENOMEM;
+
+	memcpy(new_pages, info->pages, info->max_pages * sizeof(info->pages));
+	kvfree(info->pages);
+	info->pages = new_pages;
+	info->max_pages += extent;
+
+	return 0;
+}
+
+static struct page *module_get_next_page(struct load_info *info)
+{
+	struct page *page;
+	int error;
+
+	if (info->max_pages == info->used_pages) {
+		error = module_extend_max_pages(info, info->used_pages);
+		if (error)
+			return ERR_PTR(error);
+	}
+
+	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+
+	info->pages[info->used_pages++] = page;
+	return page;
+}
+
+#ifdef CONFIG_MODULE_COMPRESS_GZIP
+#include <linux/zlib.h>
+#define MODULE_COMPRESSION	gzip
+#define MODULE_DECOMPRESS_FN	module_gzip_decompress
+
+/*
+ * Calculate length of the header which consists of signature, header
+ * flags, time stamp and operating system ID (10 bytes total), plus
+ * an optional filename.
+ */
+static size_t module_gzip_header_len(const u8 *buf, size_t size)
+{
+	const u8 signature[] = { 0x1f, 0x8b, 0x08 };
+	size_t len = 10;
+
+	if (size < len || memcmp(buf, signature, sizeof(signature)))
+		return 0;
+
+	if (buf[3] & 0x08) {
+		do {
+			/*
+			 * If we can't find the end of the file name we must
+			 * be dealing with a corrupted file.
+			 */
+			if (len == size)
+				return 0;
+		} while (buf[len++] != '\0');
+	}
+
+	return len;
+}
+
+static ssize_t module_gzip_decompress(struct load_info *info,
+				      const void *buf, size_t size)
+{
+	struct z_stream_s s = { 0 };
+	size_t new_size = 0;
+	size_t gzip_hdr_len;
+	ssize_t retval;
+	int rc;
+
+	gzip_hdr_len = module_gzip_header_len(buf, size);
+	if (!gzip_hdr_len) {
+		pr_err("not a gzip compressed module\n");
+		return -EINVAL;
+	}
+
+	s.next_in = buf + gzip_hdr_len;
+	s.avail_in = size - gzip_hdr_len;
+
+	s.workspace = kmalloc(zlib_inflate_workspacesize(), GFP_KERNEL);
+	if (!s.workspace)
+		return -ENOMEM;
+
+	rc = zlib_inflateInit2(&s, -MAX_WBITS);
+	if (rc != Z_OK) {
+		pr_err("failed to initialize decompresser: %d\n", rc);
+		retval = -EINVAL;
+		goto out;
+	}
+
+	do {
+		struct page *page = module_get_next_page(info);
+		if (!page) {
+			retval = -ENOMEM;
+			goto out_inflate_end;
+		}
+
+		s.next_out = kmap(page);
+		s.avail_out = PAGE_SIZE;
+		rc = zlib_inflate(&s, 0);
+		kunmap(page);
+
+		new_size += PAGE_SIZE - s.avail_out;
+	} while (rc == Z_OK);
+
+	if (rc != Z_STREAM_END) {
+		pr_err("decompression failed with status %d\n", rc);
+		retval = -EINVAL;
+		goto out_inflate_end;
+	}
+
+	retval = new_size;
+
+out_inflate_end:
+	zlib_inflateEnd(&s);
+out:
+	kfree(s.workspace);
+	return retval;
+}
+#elif CONFIG_MODULE_COMPRESS_XZ
+#include <linux/xz.h>
+#define MODULE_COMPRESSION	xz
+#define MODULE_DECOMPRESS_FN	module_xz_decompress
+
+static ssize_t module_xz_decompress(struct load_info *info,
+				    const void *buf, size_t size)
+{
+	static const u8 signature[] = { 0xfd, '7', 'z', 'X', 'Z', 0 };
+	struct xz_dec *xz_dec;
+	struct xz_buf xz_buf;
+	enum xz_ret xz_ret;
+	size_t new_size = 0;
+	ssize_t retval;
+
+	if (size < sizeof(signature) ||
+	    memcmp(buf, signature, sizeof(signature))) {
+		pr_err("not an xz compressed module\n");
+		return -EINVAL;
+	}
+
+	xz_dec = xz_dec_init(XZ_DYNALLOC, (u32)-1);
+	if (!xz_dec)
+		return -ENOMEM;
+
+	xz_buf.in_size = size;
+	xz_buf.in = buf;
+	xz_buf.in_pos = 0;
+
+	do {
+		struct page *page = module_get_next_page(info);
+		if (!page) {
+			retval = -ENOMEM;
+			goto out;
+		}
+
+		xz_buf.out = kmap(page);
+		xz_buf.out_pos = 0;
+		xz_buf.out_size = PAGE_SIZE;
+		xz_ret = xz_dec_run(xz_dec, &xz_buf);
+		kunmap(page);
+
+		new_size += xz_buf.out_pos;
+	} while (xz_buf.out_pos == PAGE_SIZE && xz_ret == XZ_OK);
+
+	if (xz_ret != XZ_STREAM_END) {
+		pr_err("decompression failed with status %d\n", xz_ret);
+		retval = -EINVAL;
+		goto out;
+	}
+
+	retval = new_size;
+
+ out:
+	xz_dec_end(xz_dec);
+	return retval;
+}
+#else
+#error "Unexpected configuration for CONFIG_MODULE_DECOMPRESS"
+#endif
+
+int module_decompress(struct load_info *info, const void *buf, size_t size)
+{
+	unsigned int n_pages;
+	ssize_t data_size;
+	int error;
+
+	/*
+	 * Start with number of pages twice as big as needed for
+	 * compressed data.
+	 */
+	n_pages = DIV_ROUND_UP(size, PAGE_SIZE) * 2;
+	error = module_extend_max_pages(info, n_pages);
+
+	data_size = MODULE_DECOMPRESS_FN(info, buf, size);
+	if (data_size < 0) {
+		error = data_size;
+		goto err;
+	}
+
+	info->hdr = vmap(info->pages, info->used_pages, VM_MAP, PAGE_KERNEL);
+	if (!info->hdr) {
+		error = -ENOMEM;
+		goto err;
+	}
+
+	info->len = data_size;
+	return 0;
+
+err:
+	module_decompress_cleanup(info);
+	return error;
+}
+
+void module_decompress_cleanup(struct load_info *info)
+{
+	int i;
+
+	if (info->hdr)
+		vunmap(info->hdr);
+
+	for (i = 0; i < info->used_pages; i++)
+		__free_page(info->pages[i]);
+
+	kvfree(info->pages);
+
+	info->pages = NULL;
+	info->max_pages = info->used_pages = 0;
+}
+
+static ssize_t compression_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", __stringify(MODULE_COMPRESSION));
+}
+static struct kobj_attribute module_compression_attr = __ATTR_RO(compression);
+
+static int __init module_decompress_sysfs_init(void)
+{
+	int error;
+
+	error = sysfs_create_file(&module_kset->kobj,
+				  &module_compression_attr.attr);
+	if (error)
+		pr_warn("Failed to create 'compression' attribute");
+
+	return 0;
+}
+module_init(module_decompress_sysfs_init);
-- 
2.34.0.rc2.393.gf8c9666880-goog


-- 
Dmitry

--24sMaNk0u/i0IHj3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-kmod-add-support-for-passing-compressed-modules-dire.patch"

From 45b430985585164fe2d600795805f6d02b04ac96 Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 14 Nov 2021 14:25:27 -0800
Subject: [PATCH] kmod: add support for passing compressed modules directly
 into kernel

Kernel's load pinning facilities interfere with loading compressed
modules, because if decompression happens in userspace and module is
instantiated via init_module() call there is no way for kernel to
ascertain that module data is coming from a trusted source. To solve
this issue module decompression support was added to the kernel.

Let's use the new kernel facility, and if kernel indicates (via
/sys/module/compression) that that it can handle certain compression
scheme, then use finit_module() and pass a file descriptor to the
compressed module instead of init_module() with decompressed data.
---
 libkmod/libkmod-file.c     | 41 +++++++++++++++++++-------------------
 libkmod/libkmod-internal.h |  9 ++++++++-
 libkmod/libkmod-module.c   | 41 +++++++++++++++++++++++++++++++++++++-
 shared/missing.h           |  4 ++++
 4 files changed, 73 insertions(+), 22 deletions(-)

diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index b6a8cc9..9f1b99e 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -48,17 +48,11 @@ struct file_ops {
 };
 
 struct kmod_file {
-#ifdef ENABLE_ZSTD
-	bool zstd_used;
-#endif
-#ifdef ENABLE_XZ
-	bool xz_used;
-#endif
+	enum kmod_compression compression;
 #ifdef ENABLE_ZLIB
 	gzFile gzf;
 #endif
 	int fd;
-	bool direct;
 	off_t size;
 	void *memory;
 	const struct file_ops *ops;
@@ -179,7 +173,7 @@ static int load_zstd(struct kmod_file *file)
 
 	ZSTD_freeDStream(dstr);
 	free((void *)zst_inb.src);
-	file->zstd_used = true;
+	file->compression = KMOD_COMPRESSION_ZSTD;
 	file->memory = zst_outb.dst;
 	file->size = zst_outb.pos;
 	return 0;
@@ -193,7 +187,7 @@ out:
 
 static void unload_zstd(struct kmod_file *file)
 {
-	if (!file->zstd_used)
+	if (file->compression != KMOD_COMPRESSION_ZSTD)
 		return;
 	free(file->memory);
 }
@@ -272,7 +266,7 @@ static int xz_uncompress(lzma_stream *strm, struct kmod_file *file)
 			goto out;
 		}
 	}
-	file->xz_used = true;
+	file->compression = KMOD_COMPRESSION_XZ;
 	file->memory = p;
 	file->size = total;
 	return 0;
@@ -302,7 +296,7 @@ static int load_xz(struct kmod_file *file)
 
 static void unload_xz(struct kmod_file *file)
 {
-	if (!file->xz_used)
+	if (file->compression != KMOD_COMPRESSION_XZ)
 		return;
 	free(file->memory);
 }
@@ -314,15 +308,20 @@ static const char magic_xz[] = {0xfd, '7', 'z', 'X', 'Z', 0};
 #define READ_STEP (4 * 1024 * 1024)
 static int load_zlib(struct kmod_file *file)
 {
+	int gzf_fd;
 	int err = 0;
 	off_t did = 0, total = 0;
 	_cleanup_free_ unsigned char *p = NULL;
 
 	errno = 0;
-	file->gzf = gzdopen(file->fd, "rb");
+
+	gzf_fd = dup(file->fd);
+	if (gzf_fd < 0)
+		return -errno;
+
+	file->gzf = gzdopen(gzf_fd, "rb");
 	if (file->gzf == NULL)
 		return -errno;
-	file->fd = -1; /* now owned by gzf due gzdopen() */
 
 	for (;;) {
 		int r;
@@ -353,22 +352,24 @@ static int load_zlib(struct kmod_file *file)
 		did += r;
 	}
 
+	file->compression = KMOD_COMPRESSION_GZIP;
 	file->memory = p;
 	file->size = did;
 	p = NULL;
 	return 0;
 
 error:
-	gzclose(file->gzf);
+	if (file->gzf)
+		gzclose(file->gzf);
 	return err;
 }
 
 static void unload_zlib(struct kmod_file *file)
 {
-	if (file->gzf == NULL)
+	if (file->compression != KMOD_COMPRESSION_GZIP)
 		return;
 	free(file->memory);
-	gzclose(file->gzf); /* closes file->fd */
+	gzclose(file->gzf);
 }
 
 static const char magic_zlib[] = {0x1f, 0x8b};
@@ -403,7 +404,8 @@ static int load_reg(struct kmod_file *file)
 			    file->fd, 0);
 	if (file->memory == MAP_FAILED)
 		return -errno;
-	file->direct = true;
+
+	file->compression = KMOD_COMPRESSION_NONE;
 	return 0;
 }
 
@@ -447,7 +449,6 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx,
 			magic_size_max = itr->magic_size;
 	}
 
-	file->direct = false;
 	if (magic_size_max > 0) {
 		char *buf = alloca(magic_size_max + 1);
 		ssize_t sz;
@@ -501,9 +502,9 @@ off_t kmod_file_get_size(const struct kmod_file *file)
 	return file->size;
 }
 
-bool kmod_file_get_direct(const struct kmod_file *file)
+enum kmod_compression kmod_file_get_compression(const struct kmod_file *file)
 {
-	return file->direct;
+	return file->compression;
 }
 
 int kmod_file_get_fd(const struct kmod_file *file)
diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index c22644a..a8405b3 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -48,6 +48,13 @@ static _always_inline_ _printf_format_(2, 3) void
 #  endif
 #endif
 
+enum kmod_compression {
+	KMOD_COMPRESSION_NONE,
+	KMOD_COMPRESSION_GZIP,
+	KMOD_COMPRESSION_XZ,
+	KMOD_COMPRESSION_ZSTD,
+};
+
 void kmod_log(const struct kmod_ctx *ctx,
 		int priority, const char *file, int line, const char *fn,
 		const char *format, ...) __attribute__((format(printf, 6, 7))) __attribute__((nonnull(1, 3, 5)));
@@ -155,7 +162,7 @@ struct kmod_file *kmod_file_open(const struct kmod_ctx *ctx, const char *filenam
 struct kmod_elf *kmod_file_get_elf(struct kmod_file *file) __attribute__((nonnull(1)));
 void *kmod_file_get_contents(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
 off_t kmod_file_get_size(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
-bool kmod_file_get_direct(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
+enum kmod_compression kmod_file_get_compression(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
 int kmod_file_get_fd(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
 void kmod_file_unref(struct kmod_file *file) __attribute__((nonnull(1)));
 
diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 6e0ff1a..dd38848 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -802,6 +802,39 @@ KMOD_EXPORT int kmod_module_remove_module(struct kmod_module *mod,
 	return err;
 }
 
+static enum kmod_compression kmod_get_supported_compression(struct kmod_module *mod)
+{
+	static const char path[] = "/sys/module/compression";
+	char buf[16];
+	int err;
+	int fd;
+
+	fd = open(path, O_RDONLY|O_CLOEXEC);
+	if (fd < 0) {
+		DBG(mod->ctx, "could not open '%s': %s\n",
+			path, strerror(errno));
+		goto fail;
+	}
+
+	err = read_str_safe(fd, buf, sizeof(buf));
+	close(fd);
+	if (err < 0) {
+		ERR(mod->ctx, "could not read from '%s': %s\n",
+			path, strerror(-err));
+		goto fail;
+	}
+
+	if (streq(buf, "gzip\n"))
+		return KMOD_COMPRESSION_GZIP;
+	else if (streq(buf, "xz\n"))
+		return KMOD_COMPRESSION_XZ;
+	else if (streq(buf, "zstd\n"))
+		return KMOD_COMPRESSION_ZSTD;
+
+fail:
+	return KMOD_COMPRESSION_NONE;
+}
+
 extern long init_module(const void *mem, unsigned long len, const char *args);
 
 /**
@@ -829,6 +862,7 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
 	struct kmod_elf *elf;
 	const char *path;
 	const char *args = options ? options : "";
+	enum kmod_compression compression;
 
 	if (mod == NULL)
 		return -ENOENT;
@@ -847,7 +881,9 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
 		}
 	}
 
-	if (kmod_file_get_direct(mod->file)) {
+	compression = kmod_file_get_compression(mod->file);
+	if (compression == KMOD_COMPRESSION_NONE ||
+	    compression == kmod_get_supported_compression(mod)) {
 		unsigned int kernel_flags = 0;
 
 		if (flags & KMOD_INSERT_FORCE_VERMAGIC)
@@ -855,6 +891,9 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
 		if (flags & KMOD_INSERT_FORCE_MODVERSION)
 			kernel_flags |= MODULE_INIT_IGNORE_MODVERSIONS;
 
+		if (compression != KMOD_COMPRESSION_NONE)
+			kernel_flags |= MODULE_INIT_COMPRESSED_DATA;
+
 		err = finit_module(kmod_file_get_fd(mod->file), args, kernel_flags);
 		if (err == 0 || errno != ENOSYS)
 			goto init_finished;
diff --git a/shared/missing.h b/shared/missing.h
index 4c0d136..f1e68b6 100644
--- a/shared/missing.h
+++ b/shared/missing.h
@@ -15,6 +15,10 @@
 # define MODULE_INIT_IGNORE_VERMAGIC 2
 #endif
 
+#ifndef MODULE_INIT_COMPRESSED_DATA
+# define MODULE_INIT_COMPRESSED_DATA 4
+#endif
+
 #ifndef __NR_finit_module
 # define __NR_finit_module -1
 #endif
-- 
2.34.0.rc2.393.gf8c9666880-goog


--24sMaNk0u/i0IHj3--
