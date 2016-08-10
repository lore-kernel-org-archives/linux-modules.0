Return-Path: <lucas.de.marchi@gmail.com>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 3/3] depmod: fix string overflow
Date: Wed, 10 Aug 2016 15:37:13 -0300
Message-Id: <1470854233-19810-3-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1470854233-19810-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1470854233-19810-1-git-send-email-lucas.de.marchi@gmail.com>
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

Use scratchbuf to fix issue with strcpy that may overflow the buffer we
declared in the stack.
---
 tools/depmod.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/depmod.c b/tools/depmod.c
index a2e07c1..be9e001 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -35,6 +35,7 @@
 #include <shared/hash.h>
 #include <shared/macro.h>
 #include <shared/util.h>
+#include <shared/scratchbuf.h>
 
 #include <libkmod/libkmod.h>
 
@@ -1920,6 +1921,7 @@ static int output_symbols_bin(struct depmod *depmod, FILE *out)
 {
 	struct index_node *idx;
 	char alias[1024];
+	struct scratchbuf salias;
 	size_t baselen = sizeof("symbol:") - 1;
 	struct hash_iter iter;
 	const void *v;
@@ -1932,16 +1934,21 @@ static int output_symbols_bin(struct depmod *depmod, FILE *out)
 		return -ENOMEM;
 
 	memcpy(alias, "symbol:", baselen);
+	scratchbuf_init(&salias, alias, sizeof(alias));
+
 	hash_iter_init(depmod->symbols, &iter);
 
 	while (hash_iter_next(&iter, NULL, &v)) {
 		int duplicate;
 		const struct symbol *sym = v;
+		size_t len;
 
 		if (sym->owner == NULL)
 			continue;
 
-		strcpy(alias + baselen, sym->name);
+		len = strlen(sym->name);
+		scratchbuf_alloc(&salias, baselen + len + 1);
+		memcpy(scratchbuf_str(&salias) + baselen, sym->name, len + 1);
 		duplicate = index_insert(idx, alias, sym->owner->modname,
 							sym->owner->idx);
 
@@ -1951,6 +1958,7 @@ static int output_symbols_bin(struct depmod *depmod, FILE *out)
 	}
 
 	index_write(idx, out);
+	scratchbuf_release(&salias);
 	index_destroy(idx);
 
 	return 0;
-- 
2.7.4
