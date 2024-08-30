Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9DF12F59C;
	Fri, 30 Aug 2024 05:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724996518; cv=none; b=NC70vSvlgZudCN7RDqq++78dbWqQxNi6iiOfOp8jUbkF7VLHxM5Xd/mpgHyAMNZgwHzoqWSYH5b4P1lRDXMSrui9JvdpoHuerB4QJqcdTcWWJ2X7VqQBJID0I2ETml5J7KWlHJF3raK91pwpc/HRQAxiy7iM7T2XQxzMuOji6HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724996518; c=relaxed/simple;
	bh=WJB1Qv9t1WJLJSPM8oLL76616PtUevddQKiteAa1kJA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZQLEd2knXYfW4/3en1nvjaGFQ6pbNK6LDx4o6ISt+NXH4/UzlLehcJtb0sj7K/BIoQK9Iy/kbb8NsZxH5Ht1alj2k/WRGEgSLiH+2hhzgUo5960HdVJIOKRcIRZ+ph5KRxMHbN77/p7KASI9bmEJxeLFb77JXDiWStYbWg9dIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=f6vw7ZT/; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f6vw7ZT/"
X-UUID: 8bb28e08669211ef8593d301e5c8a9c0-20240830
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=k4A5y+j5+WAfhLRjqTomaLz8jYqVXqpj3++oyTEnWOI=;
	b=f6vw7ZT/L44ErZ6qZvbTeGbhVWmWxu241qhQA8P7nutz4WqZ6rwUMqgujvJ3aD5Jc/eucDrWbPDwSn7Pwt6WPoY/ts/l9WXaMQ33W0VAgE5HajyMig7wXw/sn2ItcwhtsvDS/9GZ7bvxtzaCQJHhUTkg8k3EVPmZRLtV6XmBcHE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:04c0c5c0-20cf-4123-a6e5-4277dea87755,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6dc6a47,CLOUDID:94266acf-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8bb28e08669211ef8593d301e5c8a9c0-20240830
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <chunhui.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1789130880; Fri, 30 Aug 2024 13:41:46 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 29 Aug 2024 22:41:47 -0700
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 30 Aug 2024 13:41:47 +0800
From: Chunhui Li <chunhui.li@mediatek.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<wsd_upstream@mediatek.com>, Chunhui Li <chunhui.li@mediatek.com>, Xion Wang
	<xion.wang@mediatek.com>
Subject: [PATCH] module: abort module loading when sysfs setup suffer errors
Date: Fri, 30 Aug 2024 13:43:54 +0800
Message-ID: <20240830054400.26622-1-chunhui.li@mediatek.com>
X-Mailer: git-send-email 2.45.2
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

Signed-off-by: Xion Wang <xion.wang@mediatek.com>
Signed-off-by: Chunhui Li <chunhui.li@mediatek.com>
---
 kernel/module/sysfs.c | 49 ++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index 26efe1305c12..a9ee650d995d 100644
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
+	int ret = 0;
 
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
@@ -113,13 +116,16 @@ static void add_sect_attrs(struct module *mod, const struct load_info *info)
 	}
 	*gattr = NULL;
 
-	if (sysfs_create_group(&mod->mkobj.kobj, &sect_attrs->grp))
+	if (sysfs_create_group(&mod->mkobj.kobj, &sect_attrs->grp)) {
+		ret = -EIO;
 		goto out;
+	}
 
 	mod->sect_attrs = sect_attrs;
-	return;
+	return 0;
 out:
 	free_sect_attrs(sect_attrs);
+	return ret;
 }
 
 static void remove_sect_attrs(struct module *mod)
@@ -158,15 +164,16 @@ static void free_notes_attrs(struct module_notes_attrs *notes_attrs,
 	kfree(notes_attrs);
 }
 
-static void add_notes_attrs(struct module *mod, const struct load_info *info)
+static int add_notes_attrs(struct module *mod, const struct load_info *info)
 {
 	unsigned int notes, loaded, i;
 	struct module_notes_attrs *notes_attrs;
 	struct bin_attribute *nattr;
+	int ret = 0;
 
 	/* failed to create section attributes, so can't create notes */
 	if (!mod->sect_attrs)
-		return;
+		return -EINVAL;
 
 	/* Count notes sections and allocate structures.  */
 	notes = 0;
@@ -176,12 +183,12 @@ static void add_notes_attrs(struct module *mod, const struct load_info *info)
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
@@ -201,19 +208,24 @@ static void add_notes_attrs(struct module *mod, const struct load_info *info)
 	}
 
 	notes_attrs->dir = kobject_create_and_add("notes", &mod->mkobj.kobj);
-	if (!notes_attrs->dir)
+	if (!notes_attrs->dir) {
+		ret = -ENOMEM;
 		goto out;
+	}
 
 	for (i = 0; i < notes; ++i)
 		if (sysfs_create_bin_file(notes_attrs->dir,
-					  &notes_attrs->attrs[i]))
+					  &notes_attrs->attrs[i])) {
+			ret = -EIO;
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
@@ -385,11 +397,20 @@ int mod_sysfs_setup(struct module *mod,
 	if (err)
 		goto out_unreg_modinfo_attrs;
 
-	add_sect_attrs(mod, info);
-	add_notes_attrs(mod, info);
+	err = add_sect_attrs(mod, info);
+	if (err)
+		goto out_unreg_sect_attrs;
+
+	err = add_notes_attrs(mod, info);
+	if (err)
+		goto out_unreg_notes_attrs;
 
 	return 0;
 
+out_unreg_notes_attrs:
+	remove_notes_attrs(mod);
+out_unreg_sect_attrs:
+	remove_sect_attrs(mod);
 out_unreg_modinfo_attrs:
 	module_remove_modinfo_attrs(mod, -1);
 out_unreg_param:
-- 
2.45.2

