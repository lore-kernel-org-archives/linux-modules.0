Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:50721 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbdFYOyQ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 25 Jun 2017 10:54:16 -0400
Received: from localhost ([93.225.48.83]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPSA (Nemesis) id
 0LfKWX-1e8yGy1FV3-00p3WS for <linux-modules@vger.kernel.org>; Sun, 25 Jun
 2017 16:54:13 +0200
Date: Sun, 25 Jun 2017 16:55:37 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: linux-modules@vger.kernel.org
Subject: [PATCH] libkmod: Verify memory sizes on 32 bit systems.
Message-ID: <20170625145537.GA31667@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Large file system support is activated by default, which means that
on 32 bit systems, off_t is 64 bit in size.

Using st.st_size or any other 64 bit variable with mmap can lead to
integer truncation and therefore insufficient memory mapping.

Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
---
 libkmod/libkmod-file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index 5eeba6a..86f34c6 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -255,6 +255,8 @@ static int load_reg(struct kmod_file *file)
 		return -errno;
 
 	file->size = st.st_size;
+	if ((uintmax_t)st.st_size > (uintmax_t)SIZE_MAX)
+		return -EFBIG;
 	file->memory = mmap(NULL, file->size, PROT_READ, MAP_PRIVATE,
 			    file->fd, 0);
 	if (file->memory == MAP_FAILED)
-- 
2.13.2

