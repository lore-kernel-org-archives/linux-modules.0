Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C648B1CBE88;
	Fri,  6 Sep 2024 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623754; cv=none; b=kg05rUfGSkguxZ59AAv2hJbyWz6zFAKx88IEH5JaEDe0fbpxWL51t6DbkhH4nhZ7wJv91c3pcVOBzOZnaX2ryNSxhNu/dwxAo1wYPH1506mzVx3FZo/lq3QvF4ehr1bLHEsncH5PcxV7wOkp8Lr5w3NjLzabiolthRr1VyhIaeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623754; c=relaxed/simple;
	bh=W4JBXB09S57ifbmAiMz+UGK3IQQT73lKtAolK1IhVq0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NAPsDTsa9bpsF1i/m/3SCfR+ot3yck1+flUPqbVv/fbKOc9dRSSDeYURUCGx5Awbz4WJ1nAYAppjiTcKeVY2g4eem4O0HbgcosXKio+wi2wPI0M3q0XUZGLa+WjKOoCnDDsJfMI5GicqRF5zrGC2aUz5t8+X4B28FftoZsSmSqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZWt2M7uz; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZWt2M7uz"
X-UUID: f2897f246c4611efb66947d174671e26-20240906
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=beik/VlMt7ACJaNEqGOg9cRTm/n3szkE5kz6nm0GEnY=;
	b=ZWt2M7uzV5unzd9yKzQM6mmB/CDWp1ycPJmQsp9QCgq6ahlbqs6jXfdOmRGnwygATX+Kqd7FMIElDz1BFAVA5j/yZlzvLJu9IZYTyq2fipyEhp5sUO73AtHqfANkW1P1jW1oarP+O2qq6PktUqZP8VJzBB30aQN2MdqIHBMiJ2A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:80c814b5-aa78-4108-8d84-e13714aeda88,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:541d8fbf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f2897f246c4611efb66947d174671e26-20240906
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <chunhui.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 128470242; Fri, 06 Sep 2024 19:55:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 6 Sep 2024 04:55:43 -0700
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 6 Sep 2024 19:55:42 +0800
From: Chunhui Li <chunhui.li@mediatek.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<wsd_upstream@mediatek.com>, Chunhui Li <chunhui.li@mediatek.com>
Subject: [PATCH v3 0/1] fix module sysfs patch defect
Date: Fri, 6 Sep 2024 19:57:47 +0800
Message-ID: <20240906115748.5367-1-chunhui.li@mediatek.com>
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

I have update the patch base on your feedback, please help review again.

V3:
-Fix initial value;
-Remove unnecessary checks about mod->sects_attrs
-Check sysfs_creat_* return value as error code
-Reorder the reveral of successful operations before exiting

We will use the information recorded in mod->sects_attrs for debugging.
   When a panic occurs in a .ko, we can use gdb to load the symbols of the .ko file
along with the coredump, and use the text segment address and init.text segment address
in mod->sects_attrs to debug. 
   If there is an error in add_sysfs_setup and the .ko is still loaded and runs normally,
when the ko suffer panic later, we would not be able to access the loading addresses
of the ko, which would prevent us from being able to debug effectively.
   Therefore, it is desired that if there is an error during load module, it should prevent
the ko from being inserted with insmod. This ensures that as long as the .ko is
successfully loaded, all necessary information for debugging is available.

Thanks for your time.


Chunhui Li (1):
  module: abort module loading when sysfs setup suffer errors

 kernel/module/sysfs.c | 57 +++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 21 deletions(-)

-- 
2.45.2

