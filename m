Return-Path: <mpe@ellerman.id.au>
Message-ID: <1456993831.335.1.camel@ellerman.id.au>
Subject: [RESEND PATCH] depmod: Ignore PowerPC64 ABIv2 .TOC. symbol
From: Michael Ellerman <mpe@ellerman.id.au>
To: linux-modules@vger.kernel.org
Cc: Anton Blanchard <anton@samba.org>, Alan Modra <amodra@gmail.com>, Ulrich
	Weigand <Ulrich.Weigand@de.ibm.com>, lucas.de.marchi@gmail.com
Date: Thu, 03 Mar 2016 19:30:31 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-modules.vger.kernel.org>

From: Anton Blanchard <anton@samba.org>

The .TOC. symbol on the PowerPC64 ABIv2 identifies the GOT
pointer, similar to how other architectures use _GLOBAL_OFFSET_TABLE_.

This is not a symbol that needs relocation, and should be ignored
by depmod.

---
 tools/depmod.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/depmod.c b/tools/depmod.c
index 6e9bb4d..a2e07c1 100644
--- a/tools/depmod.c
+++ b/tools/depmod.c
@@ -2153,6 +2153,8 @@ static void depmod_add_fake_syms(struct depmod *depmod)
 	depmod_symbol_add(depmod, "__this_module", true, 0, NULL);
 	/* On S390, this is faked up too */
 	depmod_symbol_add(depmod, "_GLOBAL_OFFSET_TABLE_", true, 0, NULL);
+	/* On PowerPC64 ABIv2, .TOC. is more or less _GLOBAL_OFFSET_TABLE_ */
+	depmod_symbol_add(depmod, "TOC.", true, 0, NULL);
 }
 
 static int depmod_load_symvers(struct depmod *depmod, const char *filename)
