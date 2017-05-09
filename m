Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Subject: [PATCHv2 2/4] depmod: rewrite depmod modules search with scratchbuf
Date: Tue,  9 May 2017 22:09:22 +0300
Message-Id: <20170509190924.9087-3-yauheni.kaliuta@redhat.com>
In-Reply-To: <20170509190924.9087-1-yauheni.kaliuta@redhat.com>
References: <CAKi4VALJgW=RbpCT4kfix9sACzzz68=LZ-FhUUORXxHMcTA__g@mail.gmail.com>
 <20170509190924.9087-1-yauheni.kaliuta@redhat.com>
List-ID: <linux-modules.vger.kernel.org>

The recursive search code used used pretty big, PATH_MAX,
automatic storage buffer for the module directory scanning. Some
time ago there was scratchbuf implemented, which dynamically
reallocates its buffer on demand. The patch takes it in use for
the scanning code also. The initial size is hardcoded to 256
bytes which sounds good enough for most usecases so there should
be not many reallocations.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/depmod.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index cfed864ff6c1..a9a02bbb1aa7 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -1108,10 +1108,11 @@ add:
 	return 0;
 }
 
-static int depmod_modules_search_dir(struct depmod *depmod, DIR *d, size_t baselen, char *path)
+static int depmod_modules_search_dir(struct depmod *depmod, DIR *d, size_t baselen, struct scratchbuf *s_path)
 {
 	struct dirent *de;
 	int err = 0, dfd = dirfd(d);
+	char *path;
 
 	while ((de = readdir(d)) != NULL) {
 		const char *name = de->d_name;
@@ -1124,11 +1125,13 @@ static int depmod_modules_search_dir(struct depmod *depmod, DIR *d, size_t basel
 		if (streq(name, "build") || streq(name, "source"))
 			continue;
 		namelen = strlen(name);
-		if (baselen + namelen + 2 >= PATH_MAX) {
-			path[baselen] = '\0';
-			ERR("path is too long %s%s\n", path, name);
+		if (scratchbuf_alloc(s_path, baselen + namelen + 2) < 0) {
+			err = -ENOMEM;
+			ERR("No memory\n");
 			continue;
 		}
+
+		path = scratchbuf_str(s_path);
 		memcpy(path + baselen, name, namelen + 1);
 
 		if (de->d_type == DT_REG)
@@ -1154,10 +1157,6 @@ static int depmod_modules_search_dir(struct depmod *depmod, DIR *d, size_t basel
 		if (is_dir) {
 			int fd;
 			DIR *subdir;
-			if (baselen + namelen + 2 + NAME_MAX >= PATH_MAX) {
-				ERR("directory path is too long %s\n", path);
-				continue;
-			}
 			fd = openat(dfd, name, O_RDONLY);
 			if (fd < 0) {
 				ERR("openat(%d, %s, O_RDONLY): %m\n",
@@ -1174,7 +1173,7 @@ static int depmod_modules_search_dir(struct depmod *depmod, DIR *d, size_t basel
 			path[baselen + namelen + 1] = '\0';
 			err = depmod_modules_search_dir(depmod, subdir,
 							baselen + namelen + 1,
-							path);
+							s_path);
 			closedir(subdir);
 		} else {
 			err = depmod_modules_search_file(depmod, baselen,
@@ -1187,14 +1186,16 @@ static int depmod_modules_search_dir(struct depmod *depmod, DIR *d, size_t basel
 			err = 0; /* ignore errors */
 		}
 	}
-
 	return err;
 }
 
 static int depmod_modules_search_path(struct depmod *depmod,
 				      const char *path)
 {
-	char path_buf[PATH_MAX];
+	char buf[256];
+	_cleanup_(scratchbuf_release) struct scratchbuf s_path_buf =
+		SCRATCHBUF_INITIALIZER(buf);
+	char *path_buf;
 	DIR *d;
 	size_t baselen;
 	int err;
@@ -1207,12 +1208,20 @@ static int depmod_modules_search_path(struct depmod *depmod,
 	}
 
 	baselen = strlen(path);
+
+	if (scratchbuf_alloc(&s_path_buf, baselen + 2) < 0) {
+		err = -ENOMEM;
+		goto out;
+	}
+	path_buf = scratchbuf_str(&s_path_buf);
+
 	memcpy(path_buf, path, baselen);
 	path_buf[baselen] = '/';
 	baselen++;
 	path_buf[baselen] = '\0';
 
-	err = depmod_modules_search_dir(depmod, d, baselen, path_buf);
+	err = depmod_modules_search_dir(depmod, d, baselen, &s_path_buf);
+out:
 	closedir(d);
 	return err;
 }
-- 
2.12.2.639.g584f8975d2d9
