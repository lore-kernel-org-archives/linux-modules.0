Return-Path: <lucas.de.marchi@gmail.com>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	David Herrmann <dh.herrmann@googlemail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Kay Sievers <kay@vrfy.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH] libkmod-module: fix return code in error path
Date: Sat, 13 Jun 2015 18:45:12 -0300
Message-Id: <1434231912-20614-1-git-send-email-lucas.de.marchi@gmail.com>
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

ENOSYS is the wrong errno to return when we don't find a module in
kmod_module_insert_module(). Why is it there in the first place?  This
goes back to kmod v1 when we couldn't load modules by names, but we
should give a path instead.

708624a ("ELF: initial support for modinfo and strip of modversions and
vermagic.") changed that so we do a lazy-search by the module path in
this function. Later  f304afe ("Change error message to reflect
reality") fixed the log message but the return coded remained the same.
---

CC'ing here people from systemd who were bitten by this bug in kmod:
https://github.com/systemd/systemd/pull/166

I'm not sure about changing the return code since it was returning ENOSYS since
v1 :-/.  However maybe the best thing to do is just treat it as a bug and let
the patch to be backported by distros that want it.  Thoughts?


 libkmod/libkmod-module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 366308f..50b2ff9 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -830,7 +830,7 @@ KMOD_EXPORT int kmod_module_insert_module(struct kmod_module *mod,
 	path = kmod_module_get_path(mod);
 	if (path == NULL) {
 		ERR(mod->ctx, "could not find module by name='%s'\n", mod->name);
-		return -ENOSYS;
+		return -ENOENT;
 	}
 
 	mod->file = kmod_file_open(mod->ctx, path);
-- 
2.4.3
