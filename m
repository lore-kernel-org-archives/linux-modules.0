Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AEECCA485
	for <linux-modules@archiver.kernel.org>; Fri, 22 Jul 2022 02:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiGVCZK (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 21 Jul 2022 22:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiGVCY4 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 21 Jul 2022 22:24:56 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EE398213
        for <linux-modules@vger.kernel.org>; Thu, 21 Jul 2022 19:24:43 -0700 (PDT)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9D6833F130
        for <linux-modules@vger.kernel.org>; Fri, 22 Jul 2022 02:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658456681;
        bh=rPPCOknk12Lnh3nWhsdYWqa1mH1t/OQEcqVOb72oZWk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=PJgksh3jPRgTS/TSF2s7rGtKyZIZ1p9t4d5lNzBR3Umb/RV99jkT045FR4TlvDfIp
         grq3jPQ+y6TgDbA/yXpJ5ujHswLLSQ1USwg4JlrLbQqTqQdQ5GfpuAMEgNT+xiv6xQ
         Ph2VOx7GUR0Ml5vCoZ9z+slukKb8+m96wUn68qjUCQY7szt0IN7xJk2l/8syobPptT
         HOqHbN79OYINtlyDxalwma+ST7YEZ2Ona9lSUCGNxgvlYXDHW73QYwO8XQ4JQ26lpj
         6AeWPoBdyALv/6QISem9ANAN/z4DrOgQdkRv7rNEti1R73j35p8oI1LIv6RuUKWPrK
         7K+y0A5Hh8aLQ==
Received: by mail-ot1-f69.google.com with SMTP id f4-20020a056830204400b0061c9d50ace0so1629063otp.5
        for <linux-modules@vger.kernel.org>; Thu, 21 Jul 2022 19:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPPCOknk12Lnh3nWhsdYWqa1mH1t/OQEcqVOb72oZWk=;
        b=dR9eavRvn9ifCKc/yBTL7GOTOo4fqJTWuNZOEeheuTh3D1VwOZgClyyqlJfMnnsDaj
         gLrPXFrmXXTp0Y5jo0mLIefk9LN+zSqi6F5178yJ9Q8Bhngbgx+Tc89DyWFPYHZOZCOp
         i3Y0R69OEO36Cl8okL2dMlma8F2T6/Hyhwk5iYOQtjmNLZUBFvOKdKWNQI8k2Ia7SVcx
         5THuE2XQc8fzYJ2n0+9FHwuAxTUEaKPx7JVy4Q0YmOMbEucD4N104mGj23IQJYP6+l1T
         pDstrzjTVNQryTdy6uvGDQB/1BYWGHH5dOtFKmVYHoZ7cs+CHd2CX0Zwh7070XoxC1jh
         Nngg==
X-Gm-Message-State: AJIora+LJcAlIs7lxmv6zf4X/c1WXcqbKktZ9GO+6kCY/342qRfhp5xE
        LvQ5a4r+/Fzb9MPpwlIfPIAKR05vypsr1C1ae9mDdURYQnZtN+fbYVXpKF63h7kYiABzFH6WdB/
        xGpXQk/ws8FzieQszlAsYEuB8kFrH0aW1edvgVP1mM4M=
X-Received: by 2002:a05:6808:d52:b0:339:c88b:8100 with SMTP id w18-20020a0568080d5200b00339c88b8100mr5817222oik.93.1658456679122;
        Thu, 21 Jul 2022 19:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1shUKvZ85RWsVY2FWznWPtQPVSjurfGAiTl4rOQmkm6bAI1hnYtfZhQRHhT4FIYWpHeOcMWbw==
X-Received: by 2002:a05:6808:d52:b0:339:c88b:8100 with SMTP id w18-20020a0568080d5200b00339c88b8100mr5817215oik.93.1658456678903;
        Thu, 21 Jul 2022 19:24:38 -0700 (PDT)
Received: from mfo-t470.. ([2804:14c:4e1:8732:c479:1206:16fb:ce1f])
        by smtp.gmail.com with ESMTPSA id k23-20020a056870959700b000f5f4ad194bsm1814528oao.25.2022.07.21.19.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 19:24:38 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: [RFC PATCH 5/6] netfilter: conntrack: use MODULE_SYSCTL_TABLE
Date:   Thu, 21 Jul 2022 23:24:15 -0300
Message-Id: <20220722022416.137548-6-mfo@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220722022416.137548-1-mfo@canonical.com>
References: <20220722022416.137548-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Let's take nf_conntrack as an (actually helpful) example and exerciser,
as it has many sysctl entries, and other module aliases already.

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 net/netfilter/nf_conntrack_standalone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 05895878610c..2da628f054cf 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -980,6 +980,8 @@ static struct ctl_table nf_ct_sysctl_table[] = {
 	{}
 };
 
+MODULE_SYSCTL_TABLE(nf_ct_sysctl_table);
+
 static struct ctl_table nf_ct_netfilter_table[] = {
 	{
 		.procname	= "nf_conntrack_max",
@@ -991,6 +993,8 @@ static struct ctl_table nf_ct_netfilter_table[] = {
 	{ }
 };
 
+/* MODULE_SYSCTL_TABLE(nf_ct_sysctl_table) already includes nf_conntrack_max. */
+
 static void nf_conntrack_standalone_init_tcp_sysctl(struct net *net,
 						    struct ctl_table *table)
 {
-- 
2.25.1

