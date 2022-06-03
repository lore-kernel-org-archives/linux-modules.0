Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742B1C43334
	for <linux-modules@archiver.kernel.org>; Fri,  3 Jun 2022 21:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240077AbiFCVvJ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiFCVvH (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 3 Jun 2022 17:51:07 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46037580D4
        for <linux-modules@vger.kernel.org>; Fri,  3 Jun 2022 14:51:03 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s68so8184600pgs.10
        for <linux-modules@vger.kernel.org>; Fri, 03 Jun 2022 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dqigf7FbZ7L2uJAFMzsjV2jroU2wneUVxTmKCSGYE4o=;
        b=noanq8he4Qq7CTV1dSQP4IOYzLInVIpEt2uhKVZL2GxpIV+viLUPr4/HyGnV4MJ6Fz
         3QWZ2f/b6Qnmr4MeaGjDKumfH8k1FEMwBHjdd1Y9eoqQJNUmO8zU3xWtaa2To0yaCbBu
         CRpsMG7NUKUZpMBuL08jOOUgefEKXjG5dq9yD2PA/BRqiMo90IyQ/WeJBkiQiyt82CsV
         /dZ+Y20/+ZukUSRvk6+Hu5kUVckmxtUz9eTMacTh8jEjSGYGU0t6Ul6DxJfqqGaWYPth
         YX9qj1jGpt3CZdunYqwBpyOtycKc3S3P2LXnNjZmysYpX/Z4+RLm8aiRwfnCmawpAWQT
         YLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dqigf7FbZ7L2uJAFMzsjV2jroU2wneUVxTmKCSGYE4o=;
        b=g1E1m5/37/WuAF8cCtMUV8gzxpaotDd39Z/tRpurafn4ffUHdF0eu5B+ptzzyspmG3
         9jGtxMYoMvyEL4fswZbQk7Huc075RYY9FDZ/YGcO1IXgnj9tJ4v7Ev67wgASLFypkW0O
         4vxG0+TN/n1y0JWZPktDi/JDhU6/eaY2Dn+LY3ezORHLRAyFJrDHo8vyMtQJ0fUfKLuJ
         32G76kzs6OY8BV8OBWuP/XpqdJrU4V3elvgKTtd9eoeO18+4Hj9CJKpuIpn6p6Bis8QC
         dy3Cq168/F6sDFhLuB9nHMDe/rrq/mLoxvziwAlYxbcWLqaoSmQpg6DMRxM76sVNBXrB
         G3Qw==
X-Gm-Message-State: AOAM530pyH1QSbiCFKIYDk1J3dvypeOwPqeFygsv1h0haUNngxb9MEOv
        gh7OMmOepqF2uulQ8YVRA0kFtzLFydA=
X-Google-Smtp-Source: ABdhPJx3VmfSBKVmWxeXKNh92dxDjmvLG2gPbwSXfqa7l+8D3JWRpWeuAEXIlbesS+fE+MTBy1Pykw==
X-Received: by 2002:a63:6cc6:0:b0:3fa:a7f0:e4c0 with SMTP id h189-20020a636cc6000000b003faa7f0e4c0mr10660846pgc.18.1654293062241;
        Fri, 03 Jun 2022 14:51:02 -0700 (PDT)
Received: from ldmartin-desk2.. ([50.45.187.67])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b00163ffe73300sm6032866plg.137.2022.06.03.14.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 14:51:00 -0700 (PDT)
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
To:     linux-modules@vger.kernel.org
Cc:     Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 1/8] modprobe: Move -R to "Query options"
Date:   Fri,  3 Jun 2022 14:50:40 -0700
Message-Id: <20220603215047.9607-2-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
References: <20220603215047.9607-1-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 tools/modprobe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/modprobe.c b/tools/modprobe.c
index a825fb5..caaf87f 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -110,7 +110,6 @@ static void help(void)
 		"\t-r, --remove                Remove modules instead of inserting\n"
 		"\t    --remove-dependencies   Deprecated: use --remove-holders\n"
 		"\t    --remove-holders        Also remove module holders (use together with -r)\n"
-		"\t-R, --resolve-alias         Only lookup and print alias and exit\n"
 		"\t    --first-time            Fail if module already inserted or removed\n"
 		"\t-i, --ignore-install        Ignore install commands\n"
 		"\t-i, --ignore-remove         Ignore remove commands\n"
@@ -122,6 +121,7 @@ static void help(void)
 		"\t    --force-vermagic        Ignore module's version magic\n"
 		"\n"
 		"Query Options:\n"
+		"\t-R, --resolve-alias         Only lookup and print alias and exit\n"
 		"\t-D, --show-depends          Only print module dependencies and exit\n"
 		"\t-c, --showconfig            Print out known configuration and exit\n"
 		"\t-c, --show-config           Same as --showconfig\n"
@@ -800,9 +800,6 @@ static int do_modprobe(int argc, char **orig_argv)
 		case 5:
 			remove_holders = 1;
 			break;
-		case 'R':
-			lookup_only = 1;
-			break;
 		case 3:
 			first_time = 1;
 			break;
@@ -826,6 +823,9 @@ static int do_modprobe(int argc, char **orig_argv)
 			dry_run = 1;
 			do_show = 1;
 			break;
+		case 'R':
+			lookup_only = 1;
+			break;
 		case 'c':
 			do_show_config = 1;
 			break;
-- 
2.36.1

