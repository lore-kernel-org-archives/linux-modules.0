Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A74CC433EF
	for <linux-modules@archiver.kernel.org>; Thu, 10 Feb 2022 02:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiBJCSm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 9 Feb 2022 21:18:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBJCSm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 9 Feb 2022 21:18:42 -0500
Received: from condef-07.nifty.com (condef-07.nifty.com [202.248.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637F825CA
        for <linux-modules@vger.kernel.org>; Wed,  9 Feb 2022 18:18:44 -0800 (PST)
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-07.nifty.com with ESMTP id 21A2ExII029095
        for <linux-modules@vger.kernel.org>; Thu, 10 Feb 2022 11:14:59 +0900
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 21A2ERFY000422;
        Thu, 10 Feb 2022 11:14:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 21A2ERFY000422
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644459268;
        bh=3AAw6YRK4e3HO7seDRZU3ZBhWHuW/wWXLHT0RzaT0+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVaqdJTLn45xUcyz2vn+5v2nK5Vx3HXqfn3QIxFeWby6EenNdWREw2HJtSK12uRS9
         Hv6gqWwuIIBBumHr1VoxJba5UBlGkZYw012iOs3V2/PQVjiDNkvuQXfunxpMANR2Li
         MSqvO8EYqcJKE7AN26rN5AoTvUvM8Em8yTNXb5pOuZAHJ3vgeBlOs59UdhaWS7zi+O
         RFeUpn7ty5f4h4Iil/lAHubh04hPfChWrrLW55eoS97JVUV4RpS202iqL+O0DJ1P/F
         6vJScjErYavAQDl+Zl1YvPDuwK8zn/bywd3zbP8B8dx1rOIF6BGos9k7SfzUxpnIy4
         QJbH+6bMcJ7JA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-modules@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] modprobe: remove unneeded variable str_start
Date:   Thu, 10 Feb 2022 11:14:23 +0900
Message-Id: <20220210021423.3388827-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210021423.3388827-1-masahiroy@kernel.org>
References: <20220210021423.3388827-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The variable 'str_start' is not useful here.

Replace it with 'str'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 tools/modprobe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/modprobe.c b/tools/modprobe.c
index b6b2947..324fcfd 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -683,7 +683,7 @@ static int options_from_array(char **args, int nargs, char **output)
 static char **prepend_options_from_env(int *p_argc, char **orig_argv)
 {
 	const char *p, *env = getenv("MODPROBE_OPTIONS");
-	char **new_argv, *str_start, *str_end, *str, *s, *quote;
+	char **new_argv, *str_end, *str, *s, *quote;
 	int i, argc = *p_argc;
 	size_t envlen, space_count = 0;
 
@@ -701,10 +701,10 @@ static char **prepend_options_from_env(int *p_argc, char **orig_argv)
 		return NULL;
 
 	new_argv[0] = orig_argv[0];
-	str_start = str = (char *) (new_argv + argc + space_count + 3);
+	str = (char *) (new_argv + argc + space_count + 3);
 	memcpy(str, env, envlen + 1);
 
-	str_end = str_start + envlen;
+	str_end = str + envlen;
 
 	quote = NULL;
 	for (i = 1, s = str; *s != '\0'; s++) {
-- 
2.32.0

