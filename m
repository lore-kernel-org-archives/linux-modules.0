Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:63715 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814AbbAULht (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Wed, 21 Jan 2015 06:37:49 -0500
From: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
To: <linux-modules@vger.kernel.org>
Subject: [PATCH 4/4] util: remove dead code in freadline_wrapped
Date: Wed, 21 Jan 2015 09:37:23 -0200
Message-ID: <1421840243-26082-4-git-send-email-caio.oliveira@intel.com>
In-Reply-To: <1421840243-26082-1-git-send-email-caio.oliveira@intel.com>
References: <1421840243-26082-1-git-send-email-caio.oliveira@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Each loop iteration starts with 'i < size'. When i is changed
the invariant is kept by checking if 'i == size' and growing the
buffer.
---
 shared/util.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/shared/util.c b/shared/util.c
index 479f0fe..1a2b17c 100644
--- a/shared/util.c
+++ b/shared/util.c
@@ -314,13 +314,7 @@ char *freadline_wrapped(FILE *fp, unsigned int *linenum)
 			n++;
 
 			{
-				char *ret;
-				if (i == size) {
-					ret = realloc(buf, size + 1);
-					if (!ret)
-						return NULL;
-				} else
-					ret = buf;
+				char *ret = buf;
 				ret[i] = '\0';
 				buf = NULL;
 				if (linenum)
-- 
2.2.2

