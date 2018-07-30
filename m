Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:35508 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729561AbeG3UiL (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 30 Jul 2018 16:38:11 -0400
Received: from localhost ([217.87.206.98]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.129]) with ESMTPSA (Nemesis) id
 0MQJuC-1fY1hY0y68-00Tkym for <linux-modules@vger.kernel.org>; Mon, 30 Jul
 2018 21:01:48 +0200
Date: Mon, 30 Jul 2018 21:01:46 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: linux-modules@vger.kernel.org
Subject: [PATCH] Verify memory sizes on 32 bit systems.
Message-ID: <20180730190146.GA8535@localhost>
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

