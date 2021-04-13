Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCE1C433ED
	for <linux-modules@archiver.kernel.org>; Tue, 13 Apr 2021 11:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D88E361019
	for <linux-modules@archiver.kernel.org>; Tue, 13 Apr 2021 11:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbhDMLUo (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 13 Apr 2021 07:20:44 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:50793 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhDMLUm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 13 Apr 2021 07:20:42 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210413112021epoutp0309ff7d3e207f2c15d3c27c98df47a8b7~1Zu-a4GaR0457704577epoutp03J
        for <linux-modules@vger.kernel.org>; Tue, 13 Apr 2021 11:20:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210413112021epoutp0309ff7d3e207f2c15d3c27c98df47a8b7~1Zu-a4GaR0457704577epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618312821;
        bh=i7Pa84uTtq7ulejaYf7YPH4YJXfkUmP22ZwPQD4EZqo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Y6abWrqI/9zfJCevxy5pcsig+9qfo908yg5Lj3vpl3jt9Az1XYYKwtLCMz7x0yk+1
         zqBSPfsRed0z6/lKYLfoPRT/bmGWNmCTp0L1cxtyxYN8tQ19/kLBbXFaWM9MEcQ2Qt
         g5DDw385F98r37oHaMbpnivY4YSJDR2fhpmxK5Mw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210413112020epcas1p4c245ef5237151425d86f4ba504048b6f~1Zu_6cRy20392103921epcas1p4p;
        Tue, 13 Apr 2021 11:20:20 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FKNSM3STHz4x9Q3; Tue, 13 Apr
        2021 11:20:19 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.49.22618.37E75706; Tue, 13 Apr 2021 20:20:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210413112018epcas1p15c2cb9693086133c145845030df145ef~1Zu9Aq0Fu1901219012epcas1p1C;
        Tue, 13 Apr 2021 11:20:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210413112018epsmtrp214b6fb70d6fb6fb7015c2992bc962e7c~1Zu8-bzsh3028130281epsmtrp2C;
        Tue, 13 Apr 2021 11:20:18 +0000 (GMT)
X-AuditID: b6c32a38-e63ff7000001585a-0b-60757e73e11f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.AA.33967.27E75706; Tue, 13 Apr 2021 20:20:18 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.223]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210413112018epsmtip2e4c06af636d83e2c3779ccf63eb74bb5~1Zu8vhzCo1867418674epsmtip2H;
        Tue, 13 Apr 2021 11:20:18 +0000 (GMT)
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
To:     linux-modules@vger.kernel.org, lucas.de.marchi@gmail.com
Cc:     gladkov.alexey@gmail.com, sw0312.kim@samsung.com,
        sungguk.na@samsung.com
Subject: [PATCH 0/2] harden libkmod-builtin with wrong
 modules.builtin.modinfo
Date:   Tue, 13 Apr 2021 20:23:13 +0900
Message-Id: <20210413112315.18907-1-sw0312.kim@samsung.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmgW5xXWmCwb1DEhYL3wdaNMz+zmqx
        unMCo8WOeQcZLWZMfsnmwOqxc9Zddo++LasYPT5vkgtgjsq2yUhNTEktUkjNS85PycxLt1Xy
        Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHaqKRQlphTChQKSCwuVtK3synKLy1JVcjI
        Ly6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzph97BBTwWLminPH37M2MF5l6mLk
        5JAQMJH423eLuYuRi0NIYAejxKN/u9kgnE+MEv8+PIJyvjFK7Hu2iw2mZfnyqawQib2MEi86
        JzJCOF8YJWZMWMAIUsUmoCOxf8lvVhBbRMBGYsrrRywgNrOAj8TTiy/AbGGBAInmaxBTWQRU
        Jb4d3Qt2FK+AtcTtiZegDpSXuLDhFitEXFDi5MwnUHPkJZq3zmaGqNnELtF9VQLCdpF43NLB
        CGELS7w6voUdwpaS+PxuL9g7EgLNjBJLl/xigXB6GCXmLLrNClFlLLF/6WSgzRxAGzQl1u/S
        hwgrSuz8PZcRYjGfxLuvPawgJRICvBIdbUIQJSoSO49OYoMIS0nM2hAMEfaQ+PT8F9jJQgKx
        Enc3rGKfwCg/C8k3s5B8Mwth7wJG5lWMYqkFxbnpqcWGBSbIsbqJEZzqtCx2MM59+0HvECMT
        B+MhRgkOZiURXrcpJQlCvCmJlVWpRfnxRaU5qcWHGE2B4TuRWUo0OR+YbPNK4g1NjYyNjS1M
        DM1MDQ2VxHmTDB7ECwmkJ5akZqemFqQWwfQxcXBKNTBZbVx8Q2qyz7Orb0PPvjI892WxZ+77
        nauCPUp3bm7TYAo4pNl/6eqN3ZO2aE4Jjf6meH4rr/Gd+KPhi2w3BqnPfb6TbeWtOzN1vnnM
        3j75vulGY/sePi+9KfMm5Puk7OJ6xq+hcfR79qqVNdnpc+/f2hV7i+nvtt2b7vjXCKt/2TRd
        7OhXi0vc64LzHedduBrsGX9Vjzv2zfZpizdtSOYxrp/zIp7nFceux3yBa2PC+O+nVDz4/eVt
        v9n1sjZGL710m6fizMv2fRBaFcg7b+OEM4HcHneiZqqofdjHkvRbM2b6oq+POd2Or563dV7w
        xtPTdpnrJwfleKo8vLNNSd+k3P/hxMx55xd9+H430fWv+j4lluKMREMt5qLiRADrYgFv/gMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsWy7bCSvG5RXWmCQdd1HYuF7wMtGmZ/Z7VY
        3TmB0WLHvIOMFjMmv2RzYPXYOesuu0ffllWMHp83yQUwR3HZpKTmZJalFunbJXBlzD52iKlg
        MXPFuePvWRsYrzJ1MXJySAiYSCxfPpUVxBYS2M0oceiBH0RcSmLut+2MXYwcQLawxOHDxV2M
        XEAlnxgletcfZwepYRPQkdi/5DdYr4iAncTXFeeZQWxmgQCJIzeuMoLYwgJ+Elf//QSzWQRU
        Jb4d3Qu2l1fAWuL2xEtQN8hLXNhwixUiLihxcuYTFog58hLNW2czT2Dkm4UkNQtJagEj0ypG
        ydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjODA09Lcwbh91Qe9Q4xMHIyHGCU4mJVEeN2m
        lCQI8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwGSd+UVF
        dZliFEvkov7HmYErOPau1PTjmugw88S900J1mtnzfH4oz9wrvnbX3x322u+W7V8xKej+GrY5
        Sw9unlK6fdFvK+ZjSjwrvbeyGLZt1lG2ODOd/W5bcfVytvnr3uQpv+69mPZO+8uk2eVKnbuY
        z1ttmLBV7n/cDFOu937Xp7+7bHItbM9PneoFtctlnjdP/jdhySz+OQtNDb9VT7F4+yGogqGI
        LzRVtF217sq+VX+uccRHpZYrqrxYobJrNXOh44sdgXOtXiceafokEMZ41tPpfe2yhUtMZ5+O
        m8VySzC0cEroxaJL3VpbvG/ejeraEfD9Uv+t5j1J3z03a+5Nc9vx+fcn263JFY2POJ/fUmIp
        zkg01GIuKk4EAMeJ3aOrAgAA
X-CMS-MailID: 20210413112018epcas1p15c2cb9693086133c145845030df145ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210413112018epcas1p15c2cb9693086133c145845030df145ef
References: <CGME20210413112018epcas1p15c2cb9693086133c145845030df145ef@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The wrong data in modules.builtin.modinfo can cause overflow or
double free from modinfo with libkmod-builtin. Fix the error
cases with strict checking.

Seung-Woo Kim (2):
  libkmod: fix an overflow with wrong modules.builtin.modinfo
  libkmod: fix possible double free with wrong modules.builtin.modinfo

 libkmod/libkmod-builtin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.19.2

