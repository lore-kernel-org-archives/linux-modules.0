Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DC3C001B0
	for <linux-modules@archiver.kernel.org>; Tue,  8 Aug 2023 16:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjHHQSN (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjHHQQP (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 8 Aug 2023 12:16:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682D730DF;
        Tue,  8 Aug 2023 08:48:13 -0700 (PDT)
X-UUID: d511d7ce35c511ee9cb5633481061a41-20230808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sTBXTXgg1FJwPGo4j7K5vvqI1OKJzEYPfvBF8BSajHY=;
        b=Ss9WLDIA+9Z/G6ps45Ui37MZVX7CCWy4l7FgVrVmBNoH4PrDjC5NDwt5R5TY5yz3LzfhVM6TSnGgLuHRQuV3jLPKvaNsCr9xOrx+4oj6Zq4/fuAwEPRfc+aI7QJPVN0UwoRP+YbjHT2eY8888kozS2EsquM8d/zdB7gUjE6CgZ8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:11beb84a-1321-43d3-82e3-40f56c4b19c5,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:0ad78a4,CLOUDID:4eb5f042-d291-4e62-b539-43d7d78362ba,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d511d7ce35c511ee9cb5633481061a41-20230808
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 766388302; Tue, 08 Aug 2023 16:30:29 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Aug 2023 16:30:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 8 Aug 2023 16:30:28 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <chinwen.chang@mediatek.com>, <qun-wei.lin@mediatek.com>,
        <linux-mm@kvack.org>, <linux-modules@vger.kernel.org>,
        <casper.li@mediatek.com>, <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 1/8] scripts/gdb/symbols: add specific ko module load command
Date:   Tue, 8 Aug 2023 16:30:11 +0800
Message-ID: <20230808083020.22254-2-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230808083020.22254-1-Kuan-Ying.Lee@mediatek.com>
References: <20230808083020.22254-1-Kuan-Ying.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Add lx-symbols <ko_path> command to support add specific
ko module.

Example output like below:
(gdb) lx-symbols mm/kasan/kasan_test.ko
loading @0xffff800002d30000: mm/kasan/kasan_test.ko

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 scripts/gdb/linux/symbols.py | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index c8047f4441e6..5179edd1b627 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -111,11 +111,12 @@ lx-symbols command."""
         return "{textaddr} {sections}".format(
             textaddr=textaddr, sections="".join(args))
 
-    def load_module_symbols(self, module):
+    def load_module_symbols(self, module, module_file=None):
         module_name = module['name'].string()
         module_addr = str(module['mem'][constants.LX_MOD_TEXT]['base']).split()[0]
 
-        module_file = self._get_module_file(module_name)
+        if not module_file:
+            module_file = self._get_module_file(module_name)
         if not module_file and not self.module_files_updated:
             self._update_module_files()
             module_file = self._get_module_file(module_name)
@@ -138,6 +139,19 @@ lx-symbols command."""
         else:
             gdb.write("no module object found for '{0}'\n".format(module_name))
 
+    def load_ko_symbols(self, mod_path):
+        self.loaded_modules = []
+        module_list = modules.module_list()
+
+        for module in module_list:
+            module_name = module['name'].string()
+            module_pattern = ".*/{0}\.ko(?:.debug)?$".format(
+                module_name.replace("_", r"[_\-]"))
+            if re.match(module_pattern, mod_path) and os.path.exists(mod_path):
+                self.load_module_symbols(module, mod_path)
+                return
+        raise gdb.GdbError("%s is not a valid .ko\n" % mod_path)
+
     def load_all_symbols(self):
         gdb.write("loading vmlinux\n")
 
@@ -176,6 +190,11 @@ lx-symbols command."""
         self.module_files = []
         self.module_files_updated = False
 
+        argv = gdb.string_to_argv(arg)
+        if len(argv) == 1:
+            self.load_ko_symbols(argv[0])
+            return
+
         self.load_all_symbols()
 
         if hasattr(gdb, 'Breakpoint'):
-- 
2.18.0

