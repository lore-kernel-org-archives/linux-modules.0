Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9BEC77B7D
	for <linux-modules@archiver.kernel.org>; Thu, 18 May 2023 09:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjERJOm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 18 May 2023 05:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjERJOm (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 18 May 2023 05:14:42 -0400
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C27A1FE5
        for <linux-modules@vger.kernel.org>; Thu, 18 May 2023 02:14:39 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:4212:0:640:eaad:0])
        by forward102b.mail.yandex.net (Yandex) with ESMTP id 110A460046
        for <linux-modules@vger.kernel.org>; Thu, 18 May 2023 12:14:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id MEZ5Z4NWs0U0-PGwCv2Mn;
        Thu, 18 May 2023 12:14:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1684401277;
        bh=R5N7xWVsTNusFFEODQynWDoVimz3FCQvfYapmxj3d5A=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=FiqRDY1RQXriPyKQkNSHAhg7AvTAdN6GUd37pHJvUCif1+rMeCmFqb+x4MSM374eS
         5EC2bu/dKs/Dk/grg/8bfs/y7FGAYYBCkM/uo4i0Ea28kWAOr49q7jCgYOXEGYRT7s
         9mGMuho6TrVwccEXpHtBqGoq0kqrc3INGp1nOtzQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     linux-modules@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] shared: fix warning reported by UBSan
Date:   Thu, 18 May 2023 12:14:19 +0300
Message-Id: <20230518091419.53038-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Fix the following warning reported by UBSan (as of gcc-13.1.1):

shared/hash.c:244:35: runtime error: null pointer passed as
argument 2, which is declared to never be null

i.e. avoid passing {NULL, 0} array to bsearch().

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 shared/hash.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/shared/hash.c b/shared/hash.c
index 7fe3f80..0e09c99 100644
--- a/shared/hash.c
+++ b/shared/hash.c
@@ -241,12 +241,12 @@ void *hash_find(const struct hash *hash, const char *key)
 		.key = key,
 		.value = NULL
 	};
-	const struct hash_entry *entry = bsearch(
-		&se, bucket->entries, bucket->used,
-		sizeof(struct hash_entry), hash_entry_cmp);
-	if (entry == NULL)
-		return NULL;
-	return (void *)entry->value;
+	const struct hash_entry *entry =
+		(bucket->entries ?
+		 bsearch(&se, bucket->entries, bucket->used,
+			 sizeof(struct hash_entry), hash_entry_cmp) :
+		 NULL);
+	return entry ? (void *)entry->value : NULL;
 }
 
 int hash_del(struct hash *hash, const char *key)
-- 
2.40.1

