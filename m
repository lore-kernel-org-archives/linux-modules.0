Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4627AC433EF
	for <linux-modules@archiver.kernel.org>; Wed, 27 Apr 2022 07:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243556AbiD0Hne (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 27 Apr 2022 03:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243381AbiD0Hnd (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 27 Apr 2022 03:43:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A61B220C6;
        Wed, 27 Apr 2022 00:40:20 -0700 (PDT)
X-UUID: 3868d8e972a44e1bbaf17d8f407df134-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:3b79211b-b839-4c4e-820a-2cb1e094fa2d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:3b79211b-b839-4c4e-820a-2cb1e094fa2d,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:8fccde2e-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:-5,EDM:-3,File:nil,QS:
        0,BEC:nil
X-UUID: 3868d8e972a44e1bbaf17d8f407df134-20220427
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1148150781; Wed, 27 Apr 2022 15:40:13 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 27 Apr 2022 15:40:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Apr 2022 15:40:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 15:40:11 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <mcgrof@kernel.org>
CC:     <atomlin@redhat.com>, <lecopzer.chen@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-modules@vger.kernel.org>, <matthias.bgg@gmail.com>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH] module: show disallowed symbol name for inherit_taint()
Date:   Wed, 27 Apr 2022 15:40:11 +0800
Message-ID: <20220427074011.32364-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <YmgdUKmfym1/XnhP@bombadil.infradead.org>
References: <YmgdUKmfym1/XnhP@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

 
> Can you base your changes on modules-next [0] and resend and Cc
> atomlin@redhat.com?
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next
> 
>   Luis
> 

I've rebased on modules-next and resend [1].

[1] https://lore.kernel.org/lkml/20220427073606.29752-1-lecopzer.chen@mediatek.com/

thanks,
Lecopzer
