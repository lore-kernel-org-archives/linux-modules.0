Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBFD282EE;
	Wed, 11 Sep 2024 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726025169; cv=none; b=iNeGfd5dGPB2dvNQPrFPpFlyuEVugv0mgJgEXubEJWfBvUL5QmWWqSKSQ2/qPH20tfnnZww1kH57T2DbtKOYq7ilC725N6lBnXxpIzY+12QjH/YO/cR7fQPbp1bSrmpvUWlvCPutmbS0uzpQhFY8rJt8xx2xd/GZ2qAo9D+ZHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726025169; c=relaxed/simple;
	bh=9iVG5ANw0tv40iwbOJMp2Z8mcvfOVbsWS0Y5OJSrvUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pd/i2lArwPYhpHs/DZWwldA5+cKMKhvJ9dMPj1Hix2Ip27P2uGaNht4dDEm2/MgqcRcb3GKc0bi8wMmGrK5VGNVE33dEHv/CNg4REmept4EuehwnLLLEedBXrzsUtNR2mz96XcsQoyeuw/V3P/oVCF8aR39Lukt+gNVAere5ND0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Md7bxa0p; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Md7bxa0p"
X-UUID: 90eb7eac6fed11efb66947d174671e26-20240911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=M7PNOHSKrYvHhP6Orsr+BtKgtk6bwXfb0FUKcwyBpD0=;
	b=Md7bxa0puKqqpr+8L1FBfYNLYSBKsBhHBBOvDx1+wg8p7erjcn7l2iaJLZwq9uk7ezOrvPeq6QTUtI1NItKvvwI7ONTAIyPqSjyrx87dMPjNXc44cTtaUD2va+OPpz1pMJUl539HpFZp3AvrciyMVcrlBiTlpWl8XV9OI5rNjCg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:5074788f-9cb4-48b2-948e-db751426adaf,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6dc6a47,CLOUDID:24d8c5bf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 90eb7eac6fed11efb66947d174671e26-20240911
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <chunhui.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1122315246; Wed, 11 Sep 2024 11:26:00 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 11 Sep 2024 11:25:58 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 11 Sep 2024 11:25:58 +0800
From: Chunhui Li <chunhui.li@mediatek.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<wsd_upstream@mediatek.com>, Chunhui Li <chunhui.li@mediatek.com>, Petr Pavlu
	<petr.pavlu@suse.com>, kernel test robot <lkp@intel.com>, Xion Wang
	<xion.wang@mediatek.com>
Subject: [PATCH v4 1/1] module: abort module loading when sysfs setup suffer errors
Date: Wed, 11 Sep 2024 11:28:02 +0800
Message-ID: <20240911032802.22413-2-chunhui.li@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911032802.22413-1-chunhui.li@mediatek.com>
References: <20240911032802.22413-1-chunhui.li@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

When insmod a kernel module, if fails in add_notes_attrs or
add_sysfs_attrs such as memory allocation fail, mod_sysfs_setup
will still return success, but we can't access user interface
on android device.

Patch for make mod_sysfs_setup can check the error of
add_notes_attrs and add_sysfs_attrs

Fixes: db939b519bea ("Module section offsets in /sys/module")
Fixes: 6d76013381ed ("Add /sys/module/name/notes")
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409010016.3XIFSmRA-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202409072018.qfEzZbO7-lkp@intel.com/
Signed-off-by: Xion Wang <xion.wang@mediatek.com>
Signed-off-by: Chunhui Li <chunhui.li@mediatek.com>
---
 kernel/module/sysfs.c | 63 ++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 21 deletions(-)

diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index 26efe1305c12..456358e1fdc4 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -69,12 +69,13 @@ static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
 	kfree(sect_attrs);
 }
 
-static void add_sect_attrs(struct module *mod, const struct load_info *info)
+static int add_sect_attrs(struct module *mod, const struct load_info *info)
 {
 	unsigned int nloaded = 0, i, size[2];
 	struct module_sect_attrs *sect_attrs;
 	struct module_sect_attr *sattr;
 	struct bin_attribute **gattr;
+	int ret;
 
 	/* Count loaded sections and allocate structures */
 	for (i = 0; i < info->hdr->e_shnum; i++)
@@ -85,7 +86,7 @@ static void add_sect_attrs(struct module *mod, const struct load_info *info)
 	size[1] = (nloaded + 1) * sizeof(sect_attrs->grp.bin_attrs[0]);
 	sect_attrs = kzalloc(size[0] + size[1], GFP_KERNEL);
 	if (!sect_attrs)
-		return;
+		return -ENOMEM;
 
 	/* Setup section attributes. */
 	sect_attrs->grp.name = "sections";
@@ -103,8 +104,10 @@ static void add_sect_attrs(struct module *mod, const struct load_info *info)
 		sattr->address = sec->sh_addr;
 		sattr->battr.attr.name =
 			kstrdup(info->secstrings + sec->sh_name, GFP_KERNEL);
-		if (!sattr->battr.attr.name)
+		if (!sattr->battr.attr.name) {
+			ret = -ENOMEM;
 			goto out;
+		}
 		sect_attrs->nsections++;
 		sattr->battr.read = module_sect_read;
 		sattr->battr.size = MODULE_SECT_READ_SIZE;
@@ -113,13 +116,15 @@ static void add_sect_attrs(struct module *mod, const struct load_info *info)
 	}
 	*gattr = NULL;
 
-	if (sysfs_create_group(&mod->mkobj.kobj, &sect_attrs->grp))
+	ret = sysfs_create_group(&mod->mkobj.kobj, &sect_attrs->grp);
+	if (ret)
 		goto out;
 
 	mod->sect_attrs = sect_attrs;
-	return;
+	return 0;
 out:
 	free_sect_attrs(sect_attrs);
+	return ret;
 }
 
 static void remove_sect_attrs(struct module *mod)
@@ -158,15 +163,12 @@ static void free_notes_attrs(struct module_notes_attrs *notes_attrs,
 	kfree(notes_attrs);
 }
 
-static void add_notes_attrs(struct module *mod, const struct load_info *info)
+static int add_notes_attrs(struct module *mod, const struct load_info *info)
 {
 	unsigned int notes, loaded, i;
 	struct module_notes_attrs *notes_attrs;
 	struct bin_attribute *nattr;
-
-	/* failed to create section attributes, so can't create notes */
-	if (!mod->sect_attrs)
-		return;
+	int ret;
 
 	/* Count notes sections and allocate structures.  */
 	notes = 0;
@@ -176,12 +178,12 @@ static void add_notes_attrs(struct module *mod, const struct load_info *info)
 			++notes;
 
 	if (notes == 0)
-		return;
+		return 0;
 
 	notes_attrs = kzalloc(struct_size(notes_attrs, attrs, notes),
 			      GFP_KERNEL);
 	if (!notes_attrs)
-		return;
+		return -ENOMEM;
 
 	notes_attrs->notes = notes;
 	nattr = &notes_attrs->attrs[0];
@@ -201,19 +203,23 @@ static void add_notes_attrs(struct module *mod, const struct load_info *info)
 	}
 
 	notes_attrs->dir = kobject_create_and_add("notes", &mod->mkobj.kobj);
-	if (!notes_attrs->dir)
+	if (!notes_attrs->dir) {
+		ret = -ENOMEM;
 		goto out;
+	}
 
-	for (i = 0; i < notes; ++i)
-		if (sysfs_create_bin_file(notes_attrs->dir,
-					  &notes_attrs->attrs[i]))
+	for (i = 0; i < notes; ++i) {
+		ret = sysfs_create_bin_file(notes_attrs->dir, &notes_attrs->attrs[i]);
+		if (ret)
 			goto out;
+	}
 
 	mod->notes_attrs = notes_attrs;
-	return;
+	return 0;
 
 out:
 	free_notes_attrs(notes_attrs, i);
+	return ret;
 }
 
 static void remove_notes_attrs(struct module *mod)
@@ -223,9 +229,15 @@ static void remove_notes_attrs(struct module *mod)
 }
 
 #else /* !CONFIG_KALLSYMS */
-static inline void add_sect_attrs(struct module *mod, const struct load_info *info) { }
+static inline int add_sect_attrs(struct module *mod, const struct load_info *info)
+{
+	return 0;
+}
 static inline void remove_sect_attrs(struct module *mod) { }
-static inline void add_notes_attrs(struct module *mod, const struct load_info *info) { }
+static inline int add_notes_attrs(struct module *mod, const struct load_info *info)
+{
+	return 0;
+}
 static inline void remove_notes_attrs(struct module *mod) { }
 #endif /* CONFIG_KALLSYMS */
 
@@ -385,11 +397,20 @@ int mod_sysfs_setup(struct module *mod,
 	if (err)
 		goto out_unreg_modinfo_attrs;
 
-	add_sect_attrs(mod, info);
-	add_notes_attrs(mod, info);
+	err = add_sect_attrs(mod, info);
+	if (err)
+		goto out_del_usage_links;
+
+	err = add_notes_attrs(mod, info);
+	if (err)
+		goto out_unreg_sect_attrs;
 
 	return 0;
 
+out_unreg_sect_attrs:
+	remove_sect_attrs(mod);
+out_del_usage_links:
+	del_usage_links(mod);
 out_unreg_modinfo_attrs:
 	module_remove_modinfo_attrs(mod, -1);
 out_unreg_param:
-- 
2.45.2

