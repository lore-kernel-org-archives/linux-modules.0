Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221131400D
	for <linux-modules@vger.kernel.org>; Wed,  4 Oct 2023 13:17:36 +0000 (UTC)
X-Greylist: delayed 585 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Oct 2023 06:17:30 PDT
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9698F98
	for <linux-modules@vger.kernel.org>; Wed,  4 Oct 2023 06:17:29 -0700 (PDT)
Received: from desktop (unknown [114.214.233.200])
	by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 186A7800058;
	Wed,  4 Oct 2023 21:07:42 +0800 (CST)
Date: Wed, 4 Oct 2023 21:07:41 +0800
From: Wu Zhenyu <wuzhenyu@ustc.edu>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH] libkmod: use realpath
Message-ID: <2gfubiqrbq5lhu3znkas3eglk35s6wbl4ss6bh4wpfirzrsqfa@vf3gd4kmc3ty>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTE0fVkxJGhoYHR1OS0JOGVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKT1VJSk9VSUhIVUlLS1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8afacd21c6b03akuuu186a7800058
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OU06Syo4DDw8LiMvVhVNN0I4
	DTEaCQhVSlVKTUJNT0lPQ01JTUNLVTMWGhIXVQwOARMeFQIOOw4IDxhVHh8ORVlXWRILWUFZSkpP
	VUlKT1VJSEhVSUtLWVdZCAFZQUlKSEg3Bg++
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Forgot to mention. This commit can be modified freely to statisfy the maintainers :)

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


