Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73B0C43460
	for <linux-modules@archiver.kernel.org>; Tue, 13 Apr 2021 11:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D2C61042
	for <linux-modules@archiver.kernel.org>; Tue, 13 Apr 2021 11:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhDMLUp (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 13 Apr 2021 07:20:45 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:43553 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhDMLUo (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 13 Apr 2021 07:20:44 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210413112022epoutp02b75bcbc13ff6593e3734994bc9bd0100~1ZvAkQQIA1114911149epoutp02W
        for <linux-modules@vger.kernel.org>; Tue, 13 Apr 2021 11:20:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210413112022epoutp02b75bcbc13ff6593e3734994bc9bd0100~1ZvAkQQIA1114911149epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1618312822;
        bh=3c/iXf/evzyx+nDQtBYIwAmVdy4BsCUcmtJS4imYxiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ds2xAuzT3hsnQjT97Nbxvd8Bs9UsawQ3903LbaRXBPEYtjz0wxmXWB3B8xCk1naDV
         lcaUFpFnYAfHz9g6ZImLT8YXlwkFnBps8apwy+ownZh7nY9ipD84sOi2RPriQ33Fi+
         1qFI1OR5KcJ2L8/D73+wKDGPWLih0fsocUGW/F5c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210413112022epcas1p1749744f2f22a2a579dafc3e5d6d18625~1ZvAAKM9h3093630936epcas1p1I;
        Tue, 13 Apr 2021 11:20:22 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4FKNSM4rn3z4x9Pt; Tue, 13 Apr
        2021 11:20:19 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.B6.02277.37E75706; Tue, 13 Apr 2021 20:20:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210413112019epcas1p22c64b861d296333a64c348020c7ca20e~1Zu9MjKwJ2326723267epcas1p28;
        Tue, 13 Apr 2021 11:20:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210413112019epsmtrp1399f4bce2bc987b1f2146008842b1bc8~1Zu9Ls-ZA2092420924epsmtrp1E;
        Tue, 13 Apr 2021 11:20:19 +0000 (GMT)
X-AuditID: b6c32a36-4d7ff700000108e5-ed-60757e739c79
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.6B.08745.27E75706; Tue, 13 Apr 2021 20:20:18 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.223]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210413112018epsmtip21919d8017f9a9b4a9f535944a745b09f~1Zu87ltfX1912719127epsmtip2I;
        Tue, 13 Apr 2021 11:20:18 +0000 (GMT)
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
To:     linux-modules@vger.kernel.org, lucas.de.marchi@gmail.com
Cc:     gladkov.alexey@gmail.com, sw0312.kim@samsung.com,
        sungguk.na@samsung.com
Subject: [PATCH 2/2] libkmod: fix possible double free with wrong
 modules.builtin.modinfo
Date:   Tue, 13 Apr 2021 20:23:15 +0900
Message-Id: <20210413112315.18907-3-sw0312.kim@samsung.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20210413112315.18907-1-sw0312.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmrm5xXWmCwZl9ihYL3wdaNMz+zmqx
        unMCo8WOeQcZLWZMfsnmwOqxc9Zddo++LasYPT5vkgtgjsq2yUhNTEktUkjNS85PycxLt1Xy
        Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHaqKRQlphTChQKSCwuVtK3synKLy1JVcjI
        Ly6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzrh8aA5TwTS2ihtX5rM3MDazdjFy
        cEgImEhsXcjfxcjFISSwg1Gi5fkkJgjnE6PE7Wt/2SGcz4wSR7oambsYOcE6fs7Zzg5iCwns
        YpS4/jwXougLo8ScjQfAEmwCOhL7l/xmBbFFBGwkprx+xAJiMwv4SDy9+IIFZLWwQLTE+lv1
        ICaLgKpE1y9tkApeAWuJX5dOsUCskpe4sOEW2BROoCkzvixkg6gRlDg58wnURHmJ5q2zmUFO
        kBA4xi7Rde0lK0Szi8Se5iWMELawxKvjW9ghbCmJl/1t7BANzYwSS5f8YoFweoAeWHQbqttY
        Yv/SyUwg1zELaEqs36UPEVaU2Pl7LiPEZj6Jd197oMHIK9HRJgRRoiKx8+gkNoiwlMSsDcEQ
        YQ+Jb1PWgX0uJNDPKLHOcAKjwiwk38xC8s0shLULGJlXMYqlFhTnpqcWGxYYIcfuJkZw6tMy
        28E46e0HvUOMTByMhxglOJiVRHjdppQkCPGmJFZWpRblxxeV5qQWH2I0BQb1RGYp0eR8YPLN
        K4k3NDUyNja2MDE0MzU0VBLnTTR4EC8kkJ5YkpqdmlqQWgTTx8TBKdXAJGv/5virZyublqoZ
        fmv/OzlV3U/B65dUfftfUXGTrlJzt/vOabJL33420r5xM15zZYj+y+qHjIyuLx76G/17oHFM
        omJpvmJA3ro5Opd/aZ1pvOZ5U/WAoZvKhV0pUw2sJwUoXNjyOyfvTUB48gKHvXdn8cxl3fBF
        0iKg2STT1Nnyjm3A5W3LYh6z3liuFl4YlOXCHfzr8KUzEm7uHnk6Cfyy687Y9G44mZjgtczD
        ufJo60UF3ygTm96neruWt+75eCbip0nZyY8MtpVzJh2+KmoSuq1upaoVV+h2ptmHfA5IWemk
        e6dM4HR4ndWef9G7def+7fqTa698DreffrzjUlNq9iupfeoTftp+90xVYinOSDTUYi4qTgQA
        vhS7qgYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSvG5RXWmCwZFTFhYL3wdaNMz+zmqx
        unMCo8WOeQcZLWZMfsnmwOqxc9Zddo++LasYPT5vkgtgjuKySUnNySxLLdK3S+DKuHxoDlPB
        NLaKG1fmszcwNrN2MXJySAiYSPycs529i5GLQ0hgB6PEl1+PoRJSEnO/bWfsYuQAsoUlDh8u
        hqj5xChx/8laZpAaNgEdif1LfoPViwjYSXxdcR4sziwQIHHkxlVGEFtYIFLizba3YHNYBFQl
        un5pg4R5Bawlfl06xQKxSl7iwoZbYGM4BWwkZnxZyAZSLgRU8/xDOUS5oMTJmU9YIKbLSzRv
        nc08gVFgFpLULCSpBYxMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgsNUS2sH455V
        H/QOMTJxMB5ilOBgVhLhdZtSkiDEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs
        1NSC1CKYLBMHp1QDk7l3+dTLCrOSrkipPvlwIbvtyLQt9vw32li9jobHmBRd5NX0VNzHuewJ
        b7DAhcet0ZEBma6ZRpu9PgXIPZW/fahmeYT9vktF2l9ULGtu/tvc+eDJDJPD/ldC3IPuWufw
        3E609T3hNVX6daas/F3WfW2OeSYPX+QnzwkPypTK+DozP9Y6tjh9zotVNy/7iRooLzE9nsZ+
        QGPuS1NX8WUXLzecn/Fg0qlirnNnOsJ3l02P6nTQrCzU6ty/njme75vfVqGVB/bKvF5+Qsii
        acrUredM9yWc/F5XeT+32G3RujctN5Zkeuz+5r/Mnfktv4BX0qGc3+ckuWqPPWhddiH/hVsN
        78/p9x4YfLrNnrD+ghJLcUaioRZzUXEiANZLOgLCAgAA
X-CMS-MailID: 20210413112019epcas1p22c64b861d296333a64c348020c7ca20e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210413112019epcas1p22c64b861d296333a64c348020c7ca20e
References: <20210413112315.18907-1-sw0312.kim@samsung.com>
        <CGME20210413112019epcas1p22c64b861d296333a64c348020c7ca20e@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Fix double free for *modinfo with non '\0' terminated wrong
modules.builtin.modinfo, which is because EOF is minus value.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 libkmod/libkmod-builtin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libkmod/libkmod-builtin.c b/libkmod/libkmod-builtin.c
index a75a542f6942..a002cb5ee2c6 100644
--- a/libkmod/libkmod-builtin.c
+++ b/libkmod/libkmod-builtin.c
@@ -313,7 +313,7 @@ ssize_t kmod_builtin_get_modinfo(struct kmod_ctx *ctx, const char *modname,
 	while (offset < iter->next) {
 		offset = get_string(iter, pos, &line, &linesz);
 		if (offset <= 0) {
-			count = (offset) ? -errno : -EOF;
+			count = (offset) ? -errno : -EINVAL;
 			free(*modinfo);
 			goto fail;
 		}
-- 
2.19.2

