Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BCBC433EF
	for <linux-modules@archiver.kernel.org>; Thu, 30 Jun 2022 09:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiF3JLR (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 30 Jun 2022 05:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiF3JLR (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 30 Jun 2022 05:11:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F165319290
        for <linux-modules@vger.kernel.org>; Thu, 30 Jun 2022 02:11:15 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LYXZn10T4zkWml
        for <linux-modules@vger.kernel.org>; Thu, 30 Jun 2022 17:09:21 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 17:11:13 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 17:11:12 +0800
From:   <luhuaxin1@huawei.com>
To:     <linux-modules@vger.kernel.org>
CC:     <lucas.de.marchi@gmail.com>
Subject: [PATCH] libkmod: Support SM3 hash algorithm
Date:   Thu, 30 Jun 2022 14:36:05 +0800
Message-ID: <20220630063605.9192-1-luhuaxin1@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: HuaxinLu <luhuaxin1@huawei.com>

SM3 has been supported in kernel and cryptographic libraries like openssl.
This patch adds support for the SM3 algorithm of kmod.

Signed-off-by: HuaxinLu <luhuaxin1@huawei.com>
---
 libkmod/libkmod-signature.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
index 4e8748c..4ae5af6 100644
--- a/libkmod/libkmod-signature.c
+++ b/libkmod/libkmod-signature.c
@@ -56,6 +56,7 @@ enum pkey_hash_algo {
 	PKEY_HASH_SHA384,
 	PKEY_HASH_SHA512,
 	PKEY_HASH_SHA224,
+	PKEY_HASH_SM3,
 	PKEY_HASH__LAST
 };
 
@@ -68,6 +69,7 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
 	[PKEY_HASH_SHA384]	= "sha384",
 	[PKEY_HASH_SHA512]	= "sha512",
 	[PKEY_HASH_SHA224]	= "sha224",
+	[PKEY_HASH_SM3]		= "sm3",
 };
 
 enum pkey_id_type {
@@ -161,6 +163,10 @@ static int obj_to_hash_algo(const ASN1_OBJECT *o)
 		return PKEY_HASH_SHA512;
 	case NID_sha224:
 		return PKEY_HASH_SHA224;
+# ifndef OPENSSL_NO_SM3
+	case NID_sm3:
+		return PKEY_HASH_SM3;
+# endif
 	default:
 		return -1;
 	}
-- 
2.33.0

