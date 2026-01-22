Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D283DA2C4
	for <linux-modules@vger.kernel.org>; Thu, 22 Jan 2026 23:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769125598; cv=none; b=OLX5xJ3U86b3tDd5j+meJ2ejh75cDJDFH5kTVXzfufVMcfYHJxAwYA7CaNuy7w+iIcTFsdawsgw1FYTvL8nJemjXk3gm/BXGBqPW4shn16UiINZAY6cilj07OghRYZrSg58L5Oe6guDCBJF+Zbd9QhUXn11XvW0GRIG8lNk/PvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769125598; c=relaxed/simple;
	bh=WBt42ZoL9H4sqfzW7XxkBn82+w80swTPZfEc5VkkJcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j56jbI7ebrY7EfK/BPhl4sKs5uyrYZfWtnBXdKafZNWrZ5QTk1HpwpAUZwpZ0UKN+nmK9dxjNVyC3ZqL3m9KNcgeHm0Z9Q13YrXfWE7dUY70hYZf9GpCUf4dOG+1B0IgT4pBXucOjmYGB0Ost9tJpEdm5IvGalb4nIAfO+5cIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeSonPpt; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeSonPpt"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6610c5b014cso810590eaf.0
        for <linux-modules@vger.kernel.org>; Thu, 22 Jan 2026 15:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769125590; x=1769730390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dPh2B3A23jzmDxsvkquxO9OUhxXjWjo9YoRmPG2ooSA=;
        b=AeSonPptT+nJ0pI4GZ6kg4kKGAlQEoiXAsrbYIGEq2+8KQRVEe0bbvqvvRUrp9JU99
         syfTCG0gEc0sf3CcfW3Hg02TOVzTh9ptorAxE9qwkdjXLVRcienS6g3Eq2Oing/94kpQ
         /8vMs8RwIpYcmS4Cm1UljW39KP6vSKk3gmyNZwFCzsvkzJVu8Yuj8OyiWaX47hLVE6D9
         nZCxTZtwwa3/G7v00ydfLhoycW+4BaYVzKtDhC8Hm0Ht5Ab2xtzeYlxfJWwHcvvxmGuQ
         EWE1v1jne2TfvA20bGPoy291wY6EURuukRptJJYCQ4BQLlg76N/6297iEgsw/T5Xd9Az
         tovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769125590; x=1769730390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPh2B3A23jzmDxsvkquxO9OUhxXjWjo9YoRmPG2ooSA=;
        b=saaawCcS1GISoLUf0gL2xLEsH8AGTxr6JJodh040sgFUgEAE7+EHzdln+TMhLe0E56
         rCPC9MDg6tzv5XMdwxlSc54xnnunGTweWfZSDijpyQ0SWW7Vwdsu/GQQKTWCyK40hNUU
         zNoI2w/CBdLJn972tGWqIaMm41lKaHumpe/FW1rt8W51tO06JEphZrHnNXJKKZdilLUI
         sJKld/L0asXyLZ7RVnw3J/yLJjx2K8bfEwyVO/T2Psr2Ox8aqJD3rnqlQGCVFTnkPbZk
         AydBM8Q0EtpjAk3CQXxFU67QReZSDacqiP1/U9qrWKH2zqiNyDC7xmiDcQXWWcfPXmEQ
         V6LQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6BQirWVRQA8dHpITULqRV4gz8/o9Gmp4i5T2DWvq8ql0DofAMh9/+NHwHaSrKUTIBLiqI7+7RHkqTdeyT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/pI2thO17N/1A/YIsm9D9dTcpTau8H2eFK6w09sd+nvmRvMYp
	xmkRBf0ayy14HtXcXB2qfwRfUV0aXJX9d4g78eZrGYzxZeODJVvI3Ubm/ZRNVpeKh9M=
X-Gm-Gg: AZuq6aLoZL3qYnQ7uVgJpYAHLvxm5Pw6Pw8kmkdYTynAN21c1Aeoqv+6poB2uxTtIDD
	XsFS54CFRzAemsz/wwpLtJlvnbR3ItcS2cpso6/DXNzR7v+CWpWFzk7gIovVMDc6c/aZS4LJV4P
	2HyHADo+tz9meF44el+6q0rosEdoPfBgvCRBo5ARQiFBHrkobt8tTpazwD3dy3uhxGpjHo8Gqt3
	FiNBOzhVa1nZ5+Bm+mjBFMrLuFDxHl5v95nbry5LZANkgZbx/S8uTV1AeupJKIs9WN12JcT+MIF
	rjzGGtUsK37gByCLmqIqMjqUUjG2Lv5QtDDr666IxWNFu5eqac2i7DXDYF7ZD90qB6fYV1QhsH0
	U3va8BiS6V41o1JKyBFIFU/lXj5l52KpPVKB+b0YmjXskbB0kTENOEzWqh+Y+hFKvmMEx/1IDWZ
	/wNrbk0K1afJ6fXnMAZY8aSnavmHOz9eyDVI8l
X-Received: by 2002:a05:6820:208:b0:65f:71ec:4ec8 with SMTP id 006d021491bc7-662cab51cd7mr684170eaf.47.1769125590501;
        Thu, 22 Jan 2026 15:46:30 -0800 (PST)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-662cb4e5b2fsm349655eaf.1.2026.01.22.15.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 15:46:29 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org
Subject: [RFC PATCH 1/1] module: speed modprobe by adding name_crc to struct module
Date: Thu, 22 Jan 2026 16:46:21 -0700
Message-ID: <20260122234621.3403276-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"modprobe foo" currently does strcmp on the name, this can be improved.

So this commit:

1. adds name_crc to struct module
2. modpost.c computes the value and
3. outputs it for "modinfo foo" to see/use.

4. adds hotpath to find_module_all()
   this uses name_crc to do quick "name-check"
   falls back to strcmp only to guard against collisions.

This should significantly reduce modprobe workload, and shorten module
load-time.

Since it alters struct module, its binary incompatible. This means:

1. RFC for its wide "blast radius".
2. suitable for major version bump *only*

3. it opens door for further struct module reorg, to:
   a. segregate fields by "temperature"
   b. pack out paholes.
   c. improve cache locality (by reordering coldest on bottom)
      name should be cold now.
      bikeshedding is appropriate here.

NB: this isn't a substitute for CONFIG_MODULE_SIG.
It reimplements crc_le(), doesn't reuse kernel's version.

CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Petr Pavlu <petr.pavlu@suse.com>
CC: Daniel Gomez <da.gomez@kernel.org>
CC: Sami Tolvanen <samitolvanen@google.com>
CC: Aaron Tomlin <atomlin@atomlin.com>
CC: linux-modules@vger.kernel.org

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

 '#' will be ignored, and an empty message aborts the commit.
---
 include/linux/module.h | 15 ++++++++-------
 kernel/module/main.c   |  8 ++++++--
 scripts/mod/modpost.c  | 18 ++++++++++++++++++
 scripts/mod/modpost.h  |  6 +++++-
 4 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index d80c3ea57472..4ea6c5ae3374 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -402,10 +402,18 @@ struct klp_modinfo {
 
 struct module {
 	enum module_state state;
+	u32 name_hash;
 
 	/* Member of list of modules */
 	struct list_head list;
 
+	/* Sysfs stuff. */
+	struct module_kobject mkobj;
+	struct module_attribute *modinfo_attrs;
+	const char *version;
+	const char *srcversion;
+	struct kobject *holders_dir;
+
 	/* Unique handle for this module */
 	char name[MODULE_NAME_LEN];
 
@@ -414,13 +422,6 @@ struct module {
 	unsigned char build_id[BUILD_ID_SIZE_MAX];
 #endif
 
-	/* Sysfs stuff. */
-	struct module_kobject mkobj;
-	struct module_attribute *modinfo_attrs;
-	const char *version;
-	const char *srcversion;
-	struct kobject *holders_dir;
-
 	/* Exported symbols */
 	const struct kernel_symbol *syms;
 	const u32 *crcs;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d855f43a2be3..685218b2c5ef 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -39,6 +39,7 @@
 #include <linux/mutex.h>
 #include <linux/rculist.h>
 #include <linux/uaccess.h>
+#include <linux/crc32.h>
 #include <asm/cacheflush.h>
 #include <linux/set_memory.h>
 #include <asm/mmu_context.h>
@@ -431,13 +432,16 @@ struct module *find_module_all(const char *name, size_t len,
 			       bool even_unformed)
 {
 	struct module *mod;
+	u32 incoming_name_hash = crc32_le(0, name, len);
 
 	list_for_each_entry_rcu(mod, &modules, list,
 				lockdep_is_held(&module_mutex)) {
 		if (!even_unformed && mod->state == MODULE_STATE_UNFORMED)
 			continue;
-		if (strlen(mod->name) == len && !memcmp(mod->name, name, len))
-			return mod;
+		if (mod->name_hash == incoming_name_hash) {
+			if (strlen(mod->name) == len && !memcmp(mod->name, name, len))
+				return mod;
+		}
 	}
 	return NULL;
 }
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 755b842f1f9b..ae90e0bf9330 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -21,6 +21,22 @@
 #include <stdbool.h>
 #include <errno.h>
 
+/* Local CRC32 implementation for modpost.c */
+#define CRCPOLY_LE 0xEDB88320
+
+typedef uint32_t u32;
+
+static u32 crc32_le(u32 crc,  char  *p, size_t len)
+{
+	int i;
+	while (len--) {
+		crc ^= *p++;
+		for (i = 0; i < 8; i++)
+			crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE : 0);
+	}
+	return crc;
+}
+
 #include <hash.h>
 #include <hashtable.h>
 #include <list.h>
@@ -1581,6 +1597,7 @@ static void read_symbols(const char *modname)
 
 	/* strip trailing .o */
 	mod = new_module(modname, strlen(modname) - strlen(".o"));
+	mod->name_hash = crc32_le(0, mod->name, strlen(mod->name));
 
 	/* save .no_trim_symbol section for later use */
 	if (info.no_trim_symbol_len) {
@@ -1834,6 +1851,7 @@ static void add_header(struct buffer *b, struct module *mod)
 	buf_printf(b, "#include <linux/compiler.h>\n");
 	buf_printf(b, "\n");
 	buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
+	buf_printf(b, "MODULE_INFO(name_crc, \"0x%08x\");\n", mod->name_hash);
 	buf_printf(b, "\n");
 	buf_printf(b, "__visible struct module __this_module\n");
 	buf_printf(b, "__section(\".gnu.linkonce.this_module\") = {\n");
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 2aecb8f25c87..3fc3cfd0a039 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -11,11 +11,14 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <elf.h>
+#include <stdint.h>
 #include "../../include/linux/module_symbol.h"
 
 #include <list_types.h>
 #include "elfconfig.h"
 
+typedef uint32_t u32;
+
 /* On BSD-alike OSes elf.h defines these according to host's word size */
 #undef ELF_ST_BIND
 #undef ELF_ST_TYPE
@@ -126,7 +129,8 @@ struct module {
 	bool seen;
 	bool has_init;
 	bool has_cleanup;
-	char	     srcversion[25];
+		char         srcversion[25];
+		u32          name_hash;
 	// Missing namespace dependencies
 	struct list_head missing_namespaces;
 	// Actual imported namespaces
-- 
2.52.0

