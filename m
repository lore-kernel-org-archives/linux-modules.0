Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8674BC77B6C
	for <linux-modules@archiver.kernel.org>; Thu,  6 Apr 2023 19:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbjDFTBv (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 6 Apr 2023 15:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240428AbjDFTBc (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 6 Apr 2023 15:01:32 -0400
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3E4A5CD
        for <linux-modules@vger.kernel.org>; Thu,  6 Apr 2023 12:01:07 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id 3-20020a6b1403000000b007588213c81aso24825911iou.18
        for <linux-modules@vger.kernel.org>; Thu, 06 Apr 2023 12:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680807666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ei4XEWjw7tArTwCoMKhp2ugctsL7jq49nRaYDRBL1Mc=;
        b=fbhRqzlGZlbPiWZ5IBGIy4z7rckgpL+76StH6hDf38wyBwByXbCIsFAmlVE0cVG5TK
         HqsTdsJmsOQJn26fMUBbDBhi697JYKpNT9cxQeU2fDWUSLG/eByrdUnKIe23vrDVZxqf
         ZBP1v4gu3dj1CHb/wtHjIhqoU1bMKJKU3wrEELXyN2gGsZyVLOip7UnrYagQr/ev81xN
         b3Bd3vKO5r1GVoi09bRFAB8/a7Y+D6JuDR595SthHnsolBMZsbGW92HOBuSfhM/J8OsN
         ba5cd5hdIpxcz5JXh8vvJQADy3Ad8PB/eaqfwUiX7uO/j4zE7x5OlmQhexuRZ9/HWi41
         5dOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ei4XEWjw7tArTwCoMKhp2ugctsL7jq49nRaYDRBL1Mc=;
        b=K5iqlLg0fsH2n13vHamy7zwQt9ceSdQkdEi8Eg+sGd+Qj5SuDpHE4lvwW3nkL8F+Xf
         2ZR54LgduMrd9IoITJssRkf5eCqZjNOx708jYRNxLrTHemvzGFVx65t3iCN1g4dsbLB8
         fHo27nSICh82pD2XzT6KqNSYD/OROtHeV0WgU1fyh6lERpju029sgbInzGWHvife8EYA
         5W2lhPvhkkNLx/hgLT/lm6IPX6rfDXYqf8gRcyhMAtEt3HvdFijJW70TVAF1n9bawdap
         +/k2rHWZCLSSvJZipjVt8wO5vjKS3IWYWIpnWC127vEHvorXayfVQbht+fuLYS03B2PJ
         lYWQ==
X-Gm-Message-State: AAQBX9c+QlQgvJNLwMT30ksU3Z7il2fLgv0viVoZxCnAUj0PQzbKYzdX
        GQeJ6oA9oHSvLwdGGOHDE3Mm3eSP5gFz7nvgRK3ZxkZTJHVrgYc+bMg4X4cBfRxIgcmHYvrF75j
        I42eTkApGW8W0IicvU+6PzJxz7PwiJZcwgW8ItVFvSo1xwwZwp7yH0+5701n+EPYCWSe/rtJu3D
        9QWNI=
X-Google-Smtp-Source: AKy350ZZbJ29Gs9P2JWFiLO/pUBF8z9KEDzLtRKohDDgzI4f5p+saGHIi3qNgDRvjyVBK16Y4yqOOCNY933bmd4=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a02:2a45:0:b0:406:c43f:6320 with SMTP id
 w66-20020a022a45000000b00406c43f6320mr4089875jaw.0.1680807666582; Thu, 06 Apr
 2023 12:01:06 -0700 (PDT)
Date:   Thu,  6 Apr 2023 14:00:28 -0500
In-Reply-To: <20230406190030.968972-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219204619.2205248-1-allenwebb@google.com> <20230406190030.968972-1-allenwebb@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406190030.968972-10-allenwebb@google.com>
Subject: [PATCH v10 09/11] Documentation: Include modules.builtin.alias
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     gregkh@linuxfoundation.org, mcgrof@kernel.org,
        christophe.leroy@csgroup.eu, nick.alcock@oracle.com,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Update the documentation to include the presense and use case of
modules.builtin.alias.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Allen Webb <allenwebb@google.com>
---
 Documentation/kbuild/kbuild.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 5202186728b4..b27c66c3ca9e 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -17,6 +17,13 @@ modules.builtin
 This file lists all modules that are built into the kernel. This is used
 by modprobe to not fail when trying to load something builtin.
 
+modules.builtin.alias
+---------------------
+This file lists all match-id based aliases for modules built into the kernel.
+An example usage of the built-in aliases is to enable software such as
+USBGuard to allow or block devices outside of just the vendor, product, and
+device ID. This enables more flexible security policies in userspace.
+
 modules.builtin.modinfo
 -----------------------
 This file contains modinfo from all modules that are built into the kernel.
-- 
2.39.2

