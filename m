Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from gerolde.archlinux.org ([66.211.214.132]:36988 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab3ISO4L (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 19 Sep 2013 10:56:11 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: linux-modules@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] static-nodes: add shell consumable format
Date: Thu, 19 Sep 2013 10:48:56 -0400
Message-Id: <1379602136-3937-1-git-send-email-dreisner@archlinux.org>
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

This adds an additional format to kmod static-nodes, which writes
output as shell commands, e.g.:

  mknod '/dev/btrfs-control' c 10 234
  mknod '/dev/loop-control' c 10 237
  mkdir -m 755 -p '/dev/net'
  mknod '/dev/net/tun' c 10 200

Consumers of this format can simply pipe the output to a shell,
creating the necessary static nodes. This could be useful for an
initramfs which doesn't have systemd-tmpfiles but which still relies on
static node creation which recent udev will no longer handle.
---
 tools/static-nodes.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/static-nodes.c b/tools/static-nodes.c
index 0195390..2d68537 100644
--- a/tools/static-nodes.c
+++ b/tools/static-nodes.c
@@ -43,11 +43,13 @@ struct static_nodes_format {
 static const struct static_nodes_format static_nodes_format_human;
 static const struct static_nodes_format static_nodes_format_tmpfiles;
 static const struct static_nodes_format static_nodes_format_devname;
+static const struct static_nodes_format static_nodes_format_shell;
 
 static const struct static_nodes_format *static_nodes_formats[] = {
 	&static_nodes_format_human,
 	&static_nodes_format_tmpfiles,
 	&static_nodes_format_devname,
+	&static_nodes_format_shell,
 };
 
 static const char cmdopts_s[] = "o:f:h";
@@ -126,6 +128,28 @@ static const struct static_nodes_format static_nodes_format_devname = {
 	.description = "the modules.devname format.",
 };
 
+static int write_shell(FILE *out, char modname[], char devname[], char type, unsigned int maj, unsigned int min)
+{
+	const char *dir = strrchr(devname, '/');
+
+	if (dir) {
+		if (fprintf(out, "mkdir -m 755 -p '/dev/%.*s'\n",
+					(int)(dir - devname), devname) < 0)
+			return EXIT_FAILURE;
+	}
+
+	if (fprintf(out, "mknod '/dev/%s' %c %u %u\n", devname, type, maj, min) < 0)
+		return EXIT_FAILURE;
+
+	return EXIT_SUCCESS;
+}
+
+static const struct static_nodes_format static_nodes_format_shell = {
+	.name = "shell",
+	.write = write_shell,
+	.description = "mknod commands for consumption by a shell.",
+};
+
 static void help(void)
 {
 	size_t i;
-- 
1.8.4

