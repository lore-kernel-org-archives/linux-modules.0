Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DBC101FA
	for <linux-modules@vger.kernel.org>; Wed,  4 Oct 2023 13:12:32 +0000 (UTC)
X-Greylist: delayed 479 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Oct 2023 06:12:29 PDT
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29544B0
	for <linux-modules@vger.kernel.org>; Wed,  4 Oct 2023 06:12:28 -0700 (PDT)
Received: from desktop (unknown [114.214.233.200])
	by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 45BBB80008D
	for <linux-modules@vger.kernel.org>; Wed,  4 Oct 2023 21:04:27 +0800 (CST)
Date: Wed, 4 Oct 2023 21:04:26 +0800
From: Wu Zhenyu <wuzhenyu@ustc.edu>
To: linux-modules@vger.kernel.org
Message-ID: <7kcjhcgniwih2uuybjol4eckevgvbihfkavjeigdvbyvh5p62t@fjzo7uwqtdvs>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSR8aVkgYSh0YSU1JSk0eSlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKT1VJSk9VSUhIVUlLS1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8afaca28aeb03akuuu45bbb80008d
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhg6GSo6Fzw5PiMhLRUjN04D
	Q1YKCxBVSlVKTUJNT0lPTU1MQ0hCVTMWGhIXVQwOARMeFQIOOw4IDxhVHh8ORVlXWRILWUFZSkpP
	VUlKT1VJSEhVSUtLWVdZCAFZQUpDTE83Bg++
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_20,MISSING_SUBJECT,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wu Zhenyu <wuzhenyu@ustc.edu>
To: linux-modules@vger.kernel.org
Subject: [PATCH] libkmod: use realpath
Date: Wed,  4 Oct 2023 21:04:08 +0800
Message-ID: <20231004130426.1673502-1-wuzhenyu@ustc.edu>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

$ modinfo ../Linux-Device-Driver/eg_07_ioctl/ioctl.ko | head -n1
filename:       /home/wzy/Desktop/kmod/../Linux-Device-Driver/eg_07_ioctl/ioctl.ko
$ tools/modinfo ../Linux-Device-Driver/eg_07_ioctl/ioctl.ko | head -n1
filename:       /home/wzy/Desktop/Linux-Device-Driver/eg_07_ioctl/ioctl.ko
---
 libkmod/libkmod-module.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 585da41..bdc1427 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -794,15 +794,17 @@ KMOD_EXPORT const char *kmod_module_get_name(const struct kmod_module *mod)
  */
 KMOD_EXPORT const char *kmod_module_get_path(const struct kmod_module *mod)
 {
-	char *line;
+	char *line, *path;
 
 	if (mod == NULL)
 		return NULL;
 
 	DBG(mod->ctx, "name='%s' path='%s'\n", mod->name, mod->path);
 
-	if (mod->path != NULL)
-		return mod->path;
+	if (mod->path != NULL) {
+		path = malloc(strlen(mod->path));
+		return realpath(mod->path, path);
+	}
 	if (mod->init.dep)
 		return NULL;
 
-- 
2.42.0

