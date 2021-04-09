Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5893EC433B4
	for <linux-modules@archiver.kernel.org>; Fri,  9 Apr 2021 09:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27DC16115C
	for <linux-modules@archiver.kernel.org>; Fri,  9 Apr 2021 09:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhDIJlw (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 9 Apr 2021 05:41:52 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:14201 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhDIJlv (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 9 Apr 2021 05:41:51 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210409094135epoutp01edd9275209803a215832be245d6dd532~0Jzndl5r40120901209epoutp01D
        for <linux-modules@vger.kernel.org>; Fri,  9 Apr 2021 09:41:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210409094135epoutp01edd9275209803a215832be245d6dd532~0Jzndl5r40120901209epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617961295;
        bh=Ta1b2nr8nnpqJ5WB1BJ83T/MOr6ZO7j35qi2r2WNfd4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=KemzX8cPbd3Q5RGCBAqR8e9FRL1im16XAl3NiRSdZfkt08vpDsuJL8nJJxUVbICza
         8vljiEV8YF/yP9HoR/Cc/3/Lf6QvYQgyZXgD7Cn/ThkewiV8M4/qEqMh7Qo8qrRkxj
         3Qg9WZRTZWNWOAy8+gu71u36c7VZhZ7rcC18sSGo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210409094135epcas1p3b00b5a823a22bd5698d03261e968fbaa~0JznJKdpg3067730677epcas1p3S;
        Fri,  9 Apr 2021 09:41:35 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FGtSF6yxtz4x9Pv; Fri,  9 Apr
        2021 09:41:33 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.AC.07927.D4120706; Fri,  9 Apr 2021 18:41:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210409094133epcas1p2cfb973c9ea1065ffbb018e98f9a60b10~0JzlZIy0S1845118451epcas1p2F;
        Fri,  9 Apr 2021 09:41:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210409094133epsmtrp1c39ce27a8dcc96b45860ef38ced10ad5~0JzlYeKX70133001330epsmtrp1d;
        Fri,  9 Apr 2021 09:41:33 +0000 (GMT)
X-AuditID: b6c32a35-9a5ff70000011ef7-2c-6070214d5d2b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F6.22.33967.D4120706; Fri,  9 Apr 2021 18:41:33 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.223]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210409094133epsmtip10b349ba568d94076878f12409be0cc21~0JzlIe_zE2455424554epsmtip1L;
        Fri,  9 Apr 2021 09:41:33 +0000 (GMT)
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
To:     linux-modules@vger.kernel.org, lucas.de.marchi@gmail.com
Cc:     sw0312.kim@samsung.com, sungguk.na@samsung.com
Subject: [PATCH] libkmod-config: fix a memory leak when kmod_list_append()
 fails
Date:   Fri,  9 Apr 2021 18:44:23 +0900
Message-Id: <20210409094423.966-1-sw0312.kim@samsung.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7bCmvq6vYkGCwctnphYNs7+zWqzunMBo
        sWPeQUaLGZNfsjmweOycdZfdo2/LKkaPz5vkApijsm0yUhNTUosUUvOS81My89JtlbyD453j
        Tc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgLYpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yV
        UgtScgosC/SKE3OLS/PS9ZLzc60MDQyMTIEKE7IzpvxdxVJwhbXixoRbjA2MZ1m6GDk5JARM
        JPatXsvcxcjFISSwg1Fi3YpnLBDOJ0aJ3e9XgFUJCXxjlLjySxum4/mJ24wQ8b2MEl8bCyAa
        vjBKHNr8gQkkwSagI7F/yW9WEFtEwEZiyutHQIM4OJgFjCTeXmcGCQsLBElsedQBVsIioCpx
        fPU3dhCbV8BSYtHlNVDXyUtc2HCLFSIuKHFy5hOwODNQvHnrbGaImmXsEqsvm0DYLhLfDx9j
        h7CFJV4d3wJlS0m87G9jB7lTQqCZUWLpkl8sEE4Po8ScRbdZIaqMJfYvncwEcaimxPpd+hBh
        RYmdv+cyQizmk3j3tYcVpERCgFeio00IokRFYufRSWwQYSmJWRuCIUwPiS0HZSEhFSvxb9I2
        1gmM8rOQPDMLyTOzENYuYGRexSiWWlCcm55abFhgiByjmxjBqU3LdAfjxLcf9A4xMnEwHmKU
        4GBWEuFtbs5PEOJNSaysSi3Kjy8qzUktPsRoCgzeicxSosn5wOSaVxJvaGpkbGxsYWJoZmpo
        qCTOm2TwIF5IID2xJDU7NbUgtQimj4mDU6qBafX9lEMnZabEnW+9vlVv96T8zcn6bEm3+DkT
        XRYuPZo0f5rkkYzfR6OitnAfux0klbrBWOynwqnUFnu1nsUhJ2ZFfu57y/fsSdzjryd/yEqK
        Oz9/cKsi94lM5jPpg2eFhNa32FZ+DBESYOfqOX2crXaN9LryXAfXT3+OWSYz9TNZ6Vk8/f47
        uNx7/nSBD2k2fu/X3skK1vDbfp3n5s/cdgEzLTlRo8Bzex2V75dnGjkJOX+TXL7howrbrCjv
        wsCVDScmai8X2x39SfyK15ZppkK3Q2ZtOK5TpKWyKfyD4wdO03oDLcEDl+0u14pHTTqcPWHD
        Cy7vRWmXymT7vge/X5spXJdluvFLq86ytnu3lFiKMxINtZiLihMB5cTsE/YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKLMWRmVeSWpSXmKPExsWy7bCSnK6vYkGCwY1N/BYNs7+zWqzunMBo
        sWPeQUaLGZNfsjmweOycdZfdo2/LKkaPz5vkApijuGxSUnMyy1KL9O0SuDKm/F3FUnCFteLG
        hFuMDYxnWboYOTkkBEwknp+4zdjFyMUhJLCbUeL4yQ5WiISUxNxv24ESHEC2sMThw8UQNZ8Y
        JT5vPMsEUsMmoCOxf8lvsHoRATuJryvOM4PYzEBD357cyw5iCwsESPw+fBwsziKgKnF89Tew
        OK+ApcSiy2ugjpCXuLDhFitEXFDi5MwnLBBz5CWat85mnsDINwtJahaS1AJGplWMkqkFxbnp
        ucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMEhp6W5g3H7qg96hxiZOBgPMUpwMCuJ8DY35ycI8aYk
        VlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwKQS68un594cZsTe
        5DHb7WxLt6JZ//9XhpkFwQd4Yx0XJTwRuDYtcc1MFnerqDWpPN4zZSKf+DL2bM54s0/Akyut
        /vX7/SrlckpJrQEeIUa/Dj7bXnOz5RaT4+rdxrOcJYx/H339Yo/PF4YvNT2fXJfkhp+K2/L9
        3idOtTizjsscD//qfTo9XUXlxH9bnx0XLv8xqUsIihf/yTz/iMQK6x2zK+0S+GftrZbZKna1
        xYLrwPOPG84rzO7K8Vm8YFaDCtuTqfGSG5Mzwys/pf41ea32XvHCSkff1ttVH1c3LFxo9lHc
        +0T70kbVT4eWL7wnVcr4/3plSN++vx5W4la7/tezfhewdG8rU576w2GSuxJLcUaioRZzUXEi
        ANSTKMmoAgAA
X-CMS-MailID: 20210409094133epcas1p2cfb973c9ea1065ffbb018e98f9a60b10
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210409094133epcas1p2cfb973c9ea1065ffbb018e98f9a60b10
References: <CGME20210409094133epcas1p2cfb973c9ea1065ffbb018e98f9a60b10@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From kmod_config_new(), when kmod_list_append() fails,
fix not list-appended kmod_config_path leak.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 libkmod/libkmod-config.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libkmod/libkmod-config.c b/libkmod/libkmod-config.c
index 4fdd40f86dea..e83621b34157 100644
--- a/libkmod/libkmod-config.c
+++ b/libkmod/libkmod-config.c
@@ -909,8 +909,10 @@ int kmod_config_new(struct kmod_ctx *ctx, struct kmod_config **p_config,
 		memcpy(cf->path, path, pathlen);
 
 		tmp = kmod_list_append(path_list, cf);
-		if (tmp == NULL)
+		if (tmp == NULL) {
+			free(cf);
 			goto oom;
+		}
 		path_list = tmp;
 	}
 
-- 
2.19.2

