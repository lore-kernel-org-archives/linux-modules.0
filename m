Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706DE3398B;
	Wed, 11 Sep 2024 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726025168; cv=none; b=CdEAE2uikj09td6G34P/JhSg+f7zE2XOaMRbp4qo+hLvViVMGYAQBDl7ccVODsS/ljdFew0fEH2dlrPEG1HuyCeZ9e1beZh3kzu7+R+RhWArkuaSkrb+e7u335QDvknNRNGnEElyjQMv5I+keJrdJ+LVzkAfZfwibP3ZM8gV26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726025168; c=relaxed/simple;
	bh=+X3SCw+BuMh5SR026tNl3axIv0pim9Mn4SesaL0mtrQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MsQL34VvsgguI1gs6JerQ354ZRP/4xRWxTG0jGvyhplAyqqJYNZvpATWmOUqkl76suV1ATpf0a6BOH+CfL44heqXtATpA56MjXc4bqqdvhsp0NxAJwLMwginwWAIs7uSjkwXqHC3mcdVQ33VahWit29RDAATKflpaE4d5RcDCRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IF0xk09u; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IF0xk09u"
X-UUID: 8ec893806fed11ef8b96093e013ec31c-20240911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=FFbZhKvtZxP/gqFO7T9Vq00ul+JdlHXoelqdWHdocUU=;
	b=IF0xk09uPGLJWZRN0cXPW3w0VXXbJfUN7ElB0bxq//p/km24PNpQ+UK0gjgdKVTs7j/zDvrSl9LLuYPn/QJx1dcwHdEqnDYDjFUzNerREw78z4cLIiCLyCSITPk0JxqyII2kQ89ByU0AIbE2r5e3SJzGBOTBnbICiLNNHDInMxo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:2022fd7c-d987-4b08-a4f2-886eaf0102db,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:136304d0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8ec893806fed11ef8b96093e013ec31c-20240911
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <chunhui.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 892466944; Wed, 11 Sep 2024 11:25:56 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 11 Sep 2024 11:25:55 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 11 Sep 2024 11:25:54 +0800
From: Chunhui Li <chunhui.li@mediatek.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<wsd_upstream@mediatek.com>, Chunhui Li <chunhui.li@mediatek.com>
Subject: [PATCH v4 0/1] fix sysfs patch build warning and add fixes
Date: Wed, 11 Sep 2024 11:28:01 +0800
Message-ID: <20240911032802.22413-1-chunhui.li@mediatek.com>
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

Hi Maintainer,

V4:
-Fix build warning when CONFIG_KALLSYMS is not enabled;
-Add Fixes tag;

I can't find add_sect_attrs and add_notes_attrs commit in linux.next git log,
and Petr Pavlu show /sys/module patch link when review,
so I label Fixes as below, If incorrect please notify me. 

Fixes: db939b519bea ("Module section offsets in /sys/module")
Fixes: 6d76013381ed ("Add /sys/module/name/notes")

https://github.com/mpe/linux-fullhistory/commit/db939b519bea9b88ae1c95c3b479c0b07145f2a0
[PATCH] Module section offsets in /sys/module

https://github.com/torvalds/linux/commit/6d76013381ed28979cd122eb4b249a88b5e384fa
Add /sys/module/name/notes

Thanks for your patience.

Chunhui Li (1):
  module: abort module loading when sysfs setup suffer errors

 kernel/module/sysfs.c | 63 ++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 21 deletions(-)

-- 
2.45.2

