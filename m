Return-Path: <lucas.de.marchi@gmail.com>
Received: from localhost.localdomain (ip-64-134-188-214.public.wayport.net. [64.134.188.214])
        by mx.google.com with ESMTPSA id u52sm27473992yhg.5.2013.11.18.06.05.18
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2013 06:05:20 -0800 (PST)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Subject: [PATCH 8/9] file: use _cleanup_free_
Date: Mon, 18 Nov 2013 12:04:26 -0200
Message-Id: <1384783467-23476-9-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
References: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
List-ID: <linux-modules.vger.kernel.org>

---
 libkmod/libkmod-file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libkmod/libkmod-file.c b/libkmod/libkmod-file.c
index 390f018..feb4a15 100644
--- a/libkmod/libkmod-file.c
+++ b/libkmod/libkmod-file.c
@@ -175,13 +175,12 @@ static int load_zlib(struct kmod_file *file)
 {
 	int err = 0;
 	off_t did = 0, total = 0;
-	unsigned char *p = NULL;
+	_cleanup_free_ unsigned char *p = NULL;
 
 	errno = 0;
 	file->gzf = gzdopen(file->fd, "rb");
-	if (file->gzf == NULL) {
+	if (file->gzf == NULL)
 		return -errno;
-	}
 	file->fd = -1; /* now owned by gzf due gzdopen() */
 
 	for (;;) {
@@ -215,9 +214,10 @@ static int load_zlib(struct kmod_file *file)
 
 	file->memory = p;
 	file->size = did;
+	p = NULL;
 	return 0;
+
 error:
-	free(p);
 	gzclose(file->gzf);
 	return err;
 }
-- 
1.8.4.2
