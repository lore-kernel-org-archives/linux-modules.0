Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F88A92E
	for <linux-modules@vger.kernel.org>; Fri, 16 Jan 2026 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768521897; cv=none; b=sdD0WWbtUA1O7EFoEXGn37/LW3WmiBAtNRrZSmlbmJeqZDw4g7fPd5G0C0i30IDuAysYXhHilL2TorsfYEFx67vuC/baxkoSUw+Dh5TDiTZz2BB6G2SfKNWcIYEE7zAMOvwXoHC7aICJlktw0RHGCBlbPWmuRWsOyjHprW5OLl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768521897; c=relaxed/simple;
	bh=0vsSIAvl/ImXHMP0ElVUbBoGN50hVFzvXE0aU8VJAsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YjbbH4MLYNccdv4vgtbvW6HCsD6BDG8ZZMloX5V7299wvqjmwGBOieeKCDwtIAD4YZD6z3MpYsSSB0ln4FQPqwkG0REUHjg+D2le3lO6TEskGd7nMtdUhXsaWPrYUY4KaTfJ2QTYojXn7FdAbUcKv//CqnoFLDSmKxMovBsPb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id gWNHvl9TMKXDJgXKbvcumD; Fri, 16 Jan 2026 00:04:49 +0000
Received: from host2044.hostmonster.com ([67.20.76.238])
	by cmsmtp with ESMTPS
	id gXKavqVF4Os9RgXKav65ex; Fri, 16 Jan 2026 00:04:49 +0000
X-Authority-Analysis: v=2.4 cv=HPPDFptv c=1 sm=1 tr=0 ts=696980a1
 a=O1AQXT3IpLm5MaED65xONQ==:117 a=uc9KWs4yn0V/JYYSH7YHpg==:17
 a=vUbySO9Y5rIA:10 a=z6gsHLkEAAAA:8 a=5uySVRI38VskozMhrtQA:9
 a=iekntanDnrheIxGr1pkv:22
Received: from [66.118.46.62] (port=41710 helo=timdesk..)
	by host2044.hostmonster.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <tim.bird@sony.com>)
	id 1vgXKY-00000001kKi-2ZdU;
	Thu, 15 Jan 2026 17:04:46 -0700
From: Tim Bird <tim.bird@sony.com>
To: torvalds@linux-foundation.org,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org
Cc: linux-spdx@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Bird <tim.bird@sony.com>
Subject: [PATCH] kernel: modules: Add SPDX license identifier to kmod.c
Date: Thu, 15 Jan 2026 17:04:31 -0700
Message-ID: <20260116000431.643070-1-tim.bird@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host2044.hostmonster.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sony.com
X-BWhitelist: no
X-Source-IP: 66.118.46.62
X-Source-L: No
X-Exim-ID: 1vgXKY-00000001kKi-2ZdU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (timdesk..) [66.118.46.62]:41710
X-Source-Auth: tim@bird.org
X-Email-Count: 3
X-Org: HG=bhshared_hm;ORG=bluehost;
X-Source-Cap: YmlyZG9yZztiaXJkb3JnO2hvc3QyMDQ0Lmhvc3Rtb25zdGVyLmNvbQ==
X-Local-Domain: no
X-CMAE-Envelope: MS4xfGfa24eLmqR7HAC/CfTKhSHY34DGrlWUJegAf9ppQXx1pXGdh6i2U5k/cOceG8M3OM/vVwQMia4uH4xlSb/LEqgVRupql5VHibEt9WxynlGSYOnpTpvF
 O5IEpxlbx1XFVvnFQIHNxymTwn9K5d+CiW/zlLHx0Z08vv/KrngxDY6uAHWDniCcVxcEJUBy5glsWqxVuXIR5Z41sPjqbqXIjlQ=

Add a GPL-2.0 license identifier line for this file.

kmod.c was originally introduced in the kernel in February
of 1998 by Linus Torvalds - who was familiar with kernel
licensing at the time this was introduced.

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
 kernel/module/kmod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
index 25f253812512..a25dccdf7aa7 100644
--- a/kernel/module/kmod.c
+++ b/kernel/module/kmod.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * kmod - the kernel module loader
  *
-- 
2.43.0

