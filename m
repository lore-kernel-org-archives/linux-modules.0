Return-Path: <SRS0=fLgB=ZA=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A259FC6196
	for <linux-modules@archiver.kernel.org>; Fri,  8 Nov 2019 17:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC2A21D7E
	for <linux-modules@archiver.kernel.org>; Fri,  8 Nov 2019 17:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfKHRZn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:25:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52243 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727168AbfKHRZn (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 8 Nov 2019 12:25:43 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-XRXUA6GzO9CljTly2oy7XA-1; Fri, 08 Nov 2019 12:25:38 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62BF98017DD;
        Fri,  8 Nov 2019 17:25:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.43.2.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0DC01001DC2;
        Fri,  8 Nov 2019 17:25:36 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH v2 1/4] libkmod: Add parser for modules.builtin.modinfo
Date:   Fri,  8 Nov 2019 18:25:20 +0100
Message-Id: <20191108172524.468494-2-gladkov.alexey@gmail.com>
In-Reply-To: <20191108172524.468494-1-gladkov.alexey@gmail.com>
References: <20191108172524.468494-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: XRXUA6GzO9CljTly2oy7XA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The kernel since version v5.2-rc1 exports information about built-in
modules in the modules.builtin.modinfo. Information is stored in
the same format as in the separate modules (null-terminated string
array). The module name is a prefix for each line.

$ tr '\0' '\n' < modules.builtin.modinfo
ext4.softdep=pre: crc32c
ext4.license=GPL
ext4.description=Fourth Extended Filesystem
ext4.author=Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others
ext4.alias=fs-ext4
ext4.alias=ext3
ext4.alias=fs-ext3
ext4.alias=ext2
ext4.alias=fs-ext2
md_mod.alias=block-major-9-*
md_mod.alias=md
md_mod.description=MD RAID framework
md_mod.license=GPL
md_mod.parmtype=create_on_open:bool
md_mod.parmtype=start_dirty_degraded:int
...

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 Makefile.am                |   1 +
 libkmod/libkmod-builtin.c  | 329 +++++++++++++++++++++++++++++++++++++
 libkmod/libkmod-internal.h |   8 +
 3 files changed, 338 insertions(+)
 create mode 100644 libkmod/libkmod-builtin.c

diff --git a/Makefile.am b/Makefile.am
index c5c2f06..176dcfc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -68,6 +68,7 @@ libkmod_libkmod_la_SOURCES = \
 	libkmod/libkmod.h \
 	libkmod/libkmod-internal.h \
 	libkmod/libkmod.c \
+	libkmod/libkmod-builtin.c \
 	libkmod/libkmod-list.c \
 	libkmod/libkmod-config.c \
 	libkmod/libkmod-index.c \
diff --git a/libkmod/libkmod-builtin.c b/libkmod/libkmod-builtin.c
new file mode 100644
index 0000000..c7b888a
--- /dev/null
+++ b/libkmod/libkmod-builtin.c
@@ -0,0 +1,329 @@
+/*
+ * libkmod - interface to kernel built-in modules
+ *
+ * Copyright (C) 2019  Alexey Gladkov <gladkov.alexey@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#include "libkmod.h"
+#include "libkmod-internal.h"
+
+#define MODULES_BUILTIN_MODINFO "modules.builtin.modinfo"
+
+struct kmod_builtin_iter {
+	struct kmod_ctx *ctx;
+
+	// The file descriptor.
+	int file;
+
+	// The total size in bytes.
+	ssize_t size;
+
+	// The offset of current module.
+	off_t pos;
+
+	// The offset at which the next module is located.
+	off_t next;
+
+	// Number of strings in the current block.
+	ssize_t nstrings;
+
+	// Internal buffer and its size.
+	size_t bufsz;
+	char *buf;
+};
+
+struct kmod_builtin_iter *kmod_builtin_iter_new(struct kmod_ctx *ctx)
+{
+	char path[PATH_MAX];
+	int file, sv_errno;
+	struct stat sb;
+	struct kmod_builtin_iter *iter = NULL;
+	const char *dirname = kmod_get_dirname(ctx);
+	size_t len = strlen(dirname);
+
+	file = -1;
+
+	if ((len + 1 + strlen(MODULES_BUILTIN_MODINFO) + 1) >= PATH_MAX) {
+		sv_errno = ENAMETOOLONG;
+		goto fail;
+	}
+
+	snprintf(path, PATH_MAX, "%s/%s", dirname, MODULES_BUILTIN_MODINFO);
+
+	file = open(path, O_RDONLY|O_CLOEXEC);
+	if (file < 0) {
+		sv_errno = errno;
+		goto fail;
+	}
+
+	if (fstat(file, &sb) < 0) {
+		sv_errno = errno;
+		goto fail;
+	}
+
+	iter = malloc(sizeof(*iter));
+	if (!iter) {
+		sv_errno = ENOMEM;
+		goto fail;
+	}
+
+	iter->ctx = ctx;
+	iter->file = file;
+	iter->size = sb.st_size;
+	iter->nstrings = 0;
+	iter->pos = 0;
+	iter->next = 0;
+	iter->bufsz = 0;
+	iter->buf = NULL;
+
+	return iter;
+fail:
+	if (file >= 0)
+		close(file);
+
+	errno = sv_errno;
+
+	return iter;
+}
+
+void kmod_builtin_iter_free(struct kmod_builtin_iter *iter)
+{
+	close(iter->file);
+	free(iter->buf);
+	free(iter);
+}
+
+static off_t get_string(struct kmod_builtin_iter *iter, off_t offset,
+			char **line, size_t *size)
+{
+	int sv_errno;
+	char *nullp = NULL;
+	size_t linesz = 0;
+
+	while (!nullp) {
+		char buf[BUFSIZ];
+		ssize_t sz;
+		size_t partsz;
+
+		sz = pread(iter->file, buf, BUFSIZ, offset);
+		if (sz < 0) {
+			sv_errno = errno;
+			goto fail;
+		} else if (sz == 0) {
+			offset = 0;
+			break;
+		}
+
+		nullp = memchr(buf, '\0', (size_t) sz);
+		partsz = (size_t)((nullp) ? (nullp - buf) + 1 : sz);
+		offset += (off_t) partsz;
+
+		if (iter->bufsz < linesz + partsz) {
+			iter->bufsz = linesz + partsz;
+			iter->buf = realloc(iter->buf, iter->bufsz);
+
+			if (!iter->buf) {
+				sv_errno = errno;
+				goto fail;
+			}
+		}
+
+		strncpy(iter->buf + linesz, buf, partsz);
+		linesz += partsz;
+	}
+
+	if (linesz) {
+		*line = iter->buf;
+		*size = linesz;
+	}
+
+	return offset;
+fail:
+	errno = sv_errno;
+	return -1;
+}
+
+bool kmod_builtin_iter_next(struct kmod_builtin_iter *iter)
+{
+	char *line,  *modname;
+	size_t linesz;
+	off_t pos, offset, modlen;
+
+	modname = NULL;
+
+	iter->nstrings = 0;
+	offset = pos = iter->next;
+
+	while (offset < iter->size) {
+		char *dot;
+		off_t len;
+
+		offset = get_string(iter, pos, &line, &linesz);
+		if (offset <= 0) {
+			if (offset)
+				ERR(iter->ctx, "get_string: %s\n", strerror(errno));
+			pos = iter->size;
+			break;
+		}
+
+		dot = strchr(line, '.');
+		if (!dot) {
+			ERR(iter->ctx, "kmod_builtin_iter_next: unexpected string without modname prefix\n");
+			pos = iter->size;
+			break;
+		}
+
+		len = dot - line;
+
+		if (!modname) {
+			modname = strdup(line);
+			modlen = len;
+		} else if (modlen != len || strncmp(modname, line, len)) {
+			break;
+		}
+
+		iter->nstrings++;
+		pos = offset;
+	}
+
+	iter->pos = iter->next;
+	iter->next = pos;
+
+	free(modname);
+
+	return (iter->pos < iter->size);
+}
+
+bool kmod_builtin_iter_get_modname(struct kmod_builtin_iter *iter,
+				char modname[static PATH_MAX])
+{
+	int sv_errno;
+	char *line, *dot;
+	size_t linesz, len;
+	off_t offset;
+
+	if (iter->pos == iter->size)
+		return false;
+
+	line = NULL;
+
+	offset = get_string(iter, iter->pos, &line, &linesz);
+	if (offset <= 0) {
+		sv_errno = errno;
+		if (offset)
+			ERR(iter->ctx, "get_string: %s\n", strerror(errno));
+		goto fail;
+	}
+
+	dot = strchr(line, '.');
+	if (!dot) {
+		sv_errno = errno;
+		ERR(iter->ctx, "kmod_builtin_iter_get_modname: unexpected string without modname prefix\n");
+		goto fail;
+	}
+
+	len = dot - line;
+
+	if (len > PATH_MAX) {
+		sv_errno = ENAMETOOLONG;
+		goto fail;
+	}
+
+	strncpy(modname, line, len);
+	modname[len] = '\0';
+
+	return true;
+fail:
+	errno = sv_errno;
+	return false;
+}
+
+/* array will be allocated with strings in a single malloc, just free *array */
+ssize_t kmod_builtin_get_modinfo(struct kmod_ctx *ctx, const char *modname,
+				char ***modinfo)
+{
+	ssize_t count = 0;
+	char *s, *line = NULL;
+	size_t i, n, linesz, modlen, size;
+	off_t pos, offset;
+
+	char *name = NULL;
+	char buf[PATH_MAX];
+
+	struct kmod_builtin_iter *iter = kmod_builtin_iter_new(ctx);
+
+	if (!iter)
+		return -1;
+
+	while (!name && kmod_builtin_iter_next(iter)) {
+		if (!kmod_builtin_iter_get_modname(iter, buf)) {
+			count = -errno;
+			goto fail;
+		}
+
+		if (strcmp(modname, buf))
+			continue;
+
+		name = buf;
+	}
+
+	if (!name) {
+		count = -ENOSYS;
+		goto fail;
+	}
+
+	modlen = strlen(modname) + 1;
+	count = iter->nstrings;
+	size = iter->next - iter->pos - (modlen * count);
+
+	*modinfo = malloc(size + sizeof(char *) * (count + 1));
+	if (!*modinfo) {
+		count = -errno;
+		goto fail;
+	}
+
+	s = (char *)(*modinfo + count + 1);
+	i = 0;
+
+	n = 0;
+	offset = pos = iter->pos;
+
+	while (offset < iter->next) {
+		offset = get_string(iter, pos, &line, &linesz);
+		if (offset <= 0) {
+			count = (offset) ? -errno : -EOF;
+			goto fail;
+		}
+
+		strcpy(s + i, line + modlen);
+		(*modinfo)[n++] = s + i;
+		i += linesz - modlen;
+
+		pos = offset;
+	}
+fail:
+	kmod_builtin_iter_free(iter);
+	return count;
+}
diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index a65ddd1..df01df1 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -193,3 +193,11 @@ struct kmod_signature_info {
 };
 bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signature_info *sig_info) _must_check_ __attribute__((nonnull(1, 2)));
 void kmod_module_signature_info_free(struct kmod_signature_info *sig_info) __attribute__((nonnull));
+
+/* libkmod-builtin.c */
+struct kmod_builtin_iter;
+struct kmod_builtin_iter *kmod_builtin_iter_new(struct kmod_ctx *ctx) __attribute__((nonnull(1)));
+void kmod_builtin_iter_free(struct kmod_builtin_iter *iter) __attribute__((nonnull(1)));
+bool kmod_builtin_iter_next(struct kmod_builtin_iter *iter) __attribute__((nonnull(1)));
+bool kmod_builtin_iter_get_modname(struct kmod_builtin_iter *iter, char modname[static PATH_MAX]) __attribute__((nonnull(1, 2)));
+ssize_t kmod_builtin_get_modinfo(struct kmod_ctx *ctx, const char *modname, char ***modinfo) __attribute__((nonnull(1, 2, 3)));
-- 
2.21.0

