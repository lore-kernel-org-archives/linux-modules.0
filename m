Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42527C433B4
	for <linux-modules@archiver.kernel.org>; Tue, 13 Apr 2021 11:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18AC661042
	for <linux-modules@archiver.kernel.org>; Tue, 13 Apr 2021 11:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbhDMLUo (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 13 Apr 2021 07:20:44 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:44904 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhDMLUn (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 13 Apr 2021 07:20:43 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210413112021epoutp01c3c580e5fb30a2de9c40c36d053e5568~1Zu-2uoXs1042110421epoutp01-
        for <linux-modules@vger.kernel.org>; Tue, 13 Apr 2021 11:20:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210413112021epoutp01c3c580e5fb30a2de9c40c36d053e5568~1Zu-2uoXs1042110421epoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618312821;
        bh=Z5WeoyV9b7rmxiDt8gnxoyFCLUXsMef3Q9ea22mxqWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K0CPPxcGmViiuGZcUCMLfi2EqUTtM95YC/c0nQzzI2o0E9xgCS9cOVw5Op8c8/3qp
         /M0TELUfT17zKfJKO7Wwsl/NPYEveStR9EtdIJkDVNftsOnB4d3HwlPedVBWTxC00r
         v4FrThIbfHRz3ZxQkR7QhnW37YBF63B9MVUyAafc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210413112021epcas1p4b742a5aa4bf39ed308d00d08c73e5dbe~1Zu-gKZ8U0392103921epcas1p4r;
        Tue, 13 Apr 2021 11:20:21 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4FKNSN1G1hz4x9Px; Tue, 13 Apr
        2021 11:20:20 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.BD.10347.37E75706; Tue, 13 Apr 2021 20:20:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210413112018epcas1p4e7e6b23060a83694867b07a1f1afc200~1Zu9DkJVq0393903939epcas1p4T;
        Tue, 13 Apr 2021 11:20:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210413112018epsmtrp13251972a5917129ccbd4a95535b6c7a5~1Zu9C3aIN2069620696epsmtrp1_;
        Tue, 13 Apr 2021 11:20:18 +0000 (GMT)
X-AuditID: b6c32a39-15dff7000002286b-f0-60757e739bce
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.6B.08745.27E75706; Tue, 13 Apr 2021 20:20:18 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.223]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210413112018epsmtip224c8170bbc560ba0661fa54021a6c954~1Zu81Gkj81774517745epsmtip2g;
        Tue, 13 Apr 2021 11:20:18 +0000 (GMT)
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
To:     linux-modules@vger.kernel.org, lucas.de.marchi@gmail.com
Cc:     gladkov.alexey@gmail.com, sw0312.kim@samsung.com,
        sungguk.na@samsung.com
Subject: [PATCH 1/2] libkmod: fix an overflow with wrong
 modules.builtin.modinfo
Date:   Tue, 13 Apr 2021 20:23:14 +0900
Message-Id: <20210413112315.18907-2-sw0312.kim@samsung.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20210413112315.18907-1-sw0312.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmvm5xXWmCweeZkhYL3wdaNMz+zmqx
        unMCo8WOeQcZLWZMfsnmwOqxc9Zddo++LasYPT5vkgtgjsq2yUhNTEktUkjNS85PycxLt1Xy
        Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHaqKRQlphTChQKSCwuVtK3synKLy1JVcjI
        Ly6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzljT/Yi1oJ214uy2/YwNjJNZuhg5
        OSQETCQ+v3wPZHNxCAnsYJR49fUIlPOJUeL3jWlMEM5nRommzZ3MMC0fTndBJXYxSuy/d5Ud
        wvnCKLHzeCPYYDYBHYn9S36zgtgiAjYSU14/AoszC/hIPL34AswWFgiS+H3oGNhUFgFViTt/
        jzCB2LwC1hKHn/6HOlBe4sKGW2BzOIHmzPiykA2iRlDi5MwnUDPlJZq3zmYGOUJC4BS7xP5L
        /VCnukgsXbyHEcIWlnh1fAs7hC0l8bK/jR2ioZlRYumSXywQTg+jxJxFt1khqowl9i+dDHQS
        B9AKTYn1u/QhwooSO3/PZYTYzCfx7msPK0iJhACvREebEESJisTOo5PYIMJSErM2BEOEPSRe
        Ht7BDAmsfkaJt5/2MU9gVJiF5J9ZSP6ZhbB4ASPzKkax1ILi3PTUYsMCU+Q43sQIToNaljsY
        p7/9oHeIkYmD8RCjBAezkgiv25SSBCHelMTKqtSi/Pii0pzU4kOMpsDQnsgsJZqcD0zEeSXx
        hqZGxsbGFiaGZqaGhkrivEkGD+KFBNITS1KzU1MLUotg+pg4OKUamMLdbJfvf2T5QsCBM8jh
        u5LbLquDCROWH1dVfCb5jP+NtuDU99dYpv/XLTjcnizIeXIvt/s5Xtu7M9b7TGBLZ3nYpsp6
        k60rJnPp2rNS5noPfLwie47FOU4N27r96Ptou/0+/uUlvw/t3SIiprfV3MNm4j09cw6RiwIf
        Lu66/Ovr2hsmL7bfM3pQnPSXKThYw3p3j7zfVHdW5j3Paq7oTXl/ZeW7bK+AxxdO8hZMdFQR
        NDu33vOSkOyEl5qJHsc9C/+t25S1Nt3gW47Wnwdl/HfmS3apBx/unXjxSkTU14Kn5rvFhWQZ
        exfXbft0qK5hc8FUTe/zha4m/soZ+4R+7sk10JsaFJZlExe53zxYTImlOCPRUIu5qDgRAK3M
        01AMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvG5RXWmCwccTRhYL3wdaNMz+zmqx
        unMCo8WOeQcZLWZMfsnmwOqxc9Zddo++LasYPT5vkgtgjuKySUnNySxLLdK3S+DKWNP9iLWg
        nbXi7Lb9jA2Mk1m6GDk5JARMJD6c7mLqYuTiEBLYwSgx+cAudoiElMTcb9sZuxg5gGxhicOH
        iyFqPjFKXG/cwgpSwyagI7F/yW8wW0TATuLrivPMIDazQIDEkRtXGUFsYSD78PzlYDNZBFQl
        7vw9wgRi8wpYSxx++h/qCHmJCxtugc3hFLCRmPFlIRvIXiGgmucfyiHKBSVOznzCAjFeXqJ5
        62zmCYwCs5CkZiFJLWBkWsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERyoWlo7GPes
        +qB3iJGJg/EQowQHs5IIr9uUkgQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRm
        p6YWpBbBZJk4OKUamDLKG9RWLj8v0Sb96UfcDHWm3+W+jU4vb00vqEnKsZN+V/K6aD1fyeJn
        fLLKDVW7d7Y5Zqbo2AlJrVyx7X+Bu2ijna93qPnl2JtrMl86rt/9oCotRMs+xPDYivPT1e1m
        JjOePf11+anNpXodsiZvJT865W/eNHtjv7bYn8nL0mJ8j1rf37X2u9peQXO7uTZrV1auWfuH
        xfzbU//mFYLGF2aqW0488X4ym8fcC6cF4z/XevFmO6VIXjzZffx1p77jE8mg/IVbRZfLVs07
        ffbG1OVr63Z0CconnrV493r1Zt9Tb8/clWjTW7Rs4Yozs39zKBXkK8k16G18J1kjZlD9SvBD
        23mnBbM6ejj2yv5NeKfEUpyRaKjFXFScCAD+dK0ywwIAAA==
X-CMS-MailID: 20210413112018epcas1p4e7e6b23060a83694867b07a1f1afc200
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210413112018epcas1p4e7e6b23060a83694867b07a1f1afc200
References: <20210413112315.18907-1-sw0312.kim@samsung.com>
        <CGME20210413112018epcas1p4e7e6b23060a83694867b07a1f1afc200@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Fix a possbile overflow with exact PATH_MAX length modname
in wrong modules.builtin.modinfo.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 libkmod/libkmod-builtin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod-builtin.c b/libkmod/libkmod-builtin.c
index fc9a37644261..a75a542f6942 100644
--- a/libkmod/libkmod-builtin.c
+++ b/libkmod/libkmod-builtin.c
@@ -246,7 +246,7 @@ bool kmod_builtin_iter_get_modname(struct kmod_builtin_iter *iter,
 
 	len = dot - line;
 
-	if (len > PATH_MAX) {
+	if (len >= PATH_MAX) {
 		sv_errno = ENAMETOOLONG;
 		goto fail;
 	}
-- 
2.19.2

