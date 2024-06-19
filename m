Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297295FBB1;
	Wed, 19 Jun 2024 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785860; cv=none; b=DM02OR48QwhmxCIsfe1NjiKxE4ldoZSE9wKf8jSo99jnjsTcI9eE29Ms69yDw+UhekHQKRiUEikrDxICBn84y551axPaJscsLw0CdQDvY/r524qOTSHfOfexzpGl9n570YMMZZe73OI1lgWAUD5x0WSvPTsbWHoHMSRZo2xwa1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785860; c=relaxed/simple;
	bh=6t6LPo6KB4T7Xhw11JvM6OKrv7NGo7ATHTH9MbWDWjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ntf/vrn9eILWSR3qqQ7runMlK//8g8GX56aUX9AD+KpuKCTu3/5TrKIhcW6AyGykSBSEwawusnQs5jyn7IKoj2k9UI4CmVWL5L9lF9ymGvm+7U7FcjWHhsVBburgjaz3p/QXYW3dkxuhMvgrggPmgmX5d1bkLu+CoO/bk+/iCfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PerXvv4r; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PerXvv4r"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3737dc4a669so25597965ab.0;
        Wed, 19 Jun 2024 01:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718785858; x=1719390658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gN+wjFKhTOCT+2IXXI1zItvi9uGT3PVnpu+/RhI2psY=;
        b=PerXvv4rV0R29PFJPN97dmcE4pdN3mKOsZciYUxyVWq+3Y5C+XlGZqwpvhIJS0j+6s
         tWJhmnGscud1GckF7dPNIN9XPnwJTRPFX21vvjoEeRD5yTSKnvlXBlnaH/tAuTN3G1fv
         t7u8SXWcGYpYTtl92T3bkdgrBsF9rCRP36tI4nQkdl2bpxBDBFPGRst1o4P2vYVjjOhK
         AUGatGUYeXiPsP5lwotJwQ8XMQe2OCO3Bef8xi6PNuwel2rhAVahw8PdknVLt9+HfvPX
         Txh4XFsUQf+tTgpo5eyOKt38ClhgeRLhb2b9BZusUHpEdIRit0vbKeom2PULc3QORVwr
         4omQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718785858; x=1719390658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gN+wjFKhTOCT+2IXXI1zItvi9uGT3PVnpu+/RhI2psY=;
        b=Y0mTYEsF3vKbIJmO9y4nZClpMDLcY3APU3QsIwvVEpnzfSy/F8jsOPdc+AAC3viRtX
         6+JJ24GMF10YRRSQ8yGZRKT6PVu3H15K+OeCx9euPcLYqD3vheCkocI6bXeD/K2+RvCF
         XpFUGfouiXgn8BCbG4YoNQyBB+gtqTL5HDLxf6MUPVsOjV8f0+NdjZE/SV8hf964nmX+
         DusNCMmhiA/shptpbcdy3RtbW69MRayfXoFlUvwuucpqfTuLDIpPueWK4IsejCglL6oU
         /oaC5D01fGeY1Wvzpk+8bmHq/ijEKUd/uJskKQs+dOD4+PUkIw6ipatB71mKyJZOgB8w
         bVTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe82nFt6k/RPAPTKGS4/fZRYq2SuAjHn00JxaSWVXVXwA6sA1PMfSgI+8S+JKF59f0i0znP7BZZunPmYqTyXiklmYXQHHDvJZDkdOE
X-Gm-Message-State: AOJu0Yy/KPh0ji2I8bt6oSLXZnzSngP6FZlkpLs5zFb8mnxFB8Y/vOX3
	YxI8YLTJH4q2BwnNo91SLgXIBmZ7d7PmngPX4InUsLLEaXVw5hvW
X-Google-Smtp-Source: AGHT+IHP27fhfKPSiFfK+9z/QFg1s4ZnSqXIMKSbPRjjLLjp47rKRzbt97NO8emMT2FrDUYPaeyHfw==
X-Received: by 2002:a92:c266:0:b0:375:e06f:4b79 with SMTP id e9e14a558f8ab-3761d727d3fmr18965685ab.31.1718785858134;
        Wed, 19 Jun 2024 01:30:58 -0700 (PDT)
Received: from localhost.localdomain ([114.111.24.234])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee3ba48c1sm9134808a12.81.2024.06.19.01.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:30:57 -0700 (PDT)
From: Yusong Gao <a869920004@gmail.com>
To: mcgrof@kernel.org
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	a869920004@gmail.com
Subject: [PATCH v2] module: Add log information for loading module failures
Date: Wed, 19 Jun 2024 08:30:37 +0000
Message-Id: <20240619083037.1070310-1-a869920004@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add log information in kernel-space when loading module failures.
Try to load the unsigned module and the module with bad signature
when set 1 to /sys/module/module/parameters/sig_enforce.

Unsigned module case:
(linux) insmod unsigned.ko
[   18.714661] Loading of unsigned module is rejected
insmod: can't insert 'unsigned.ko': Key was rejected by service
(linux)

Bad signature module case:
(linux) insmod bad_signature.ko
insmod: can't insert 'bad_signature.ko': Key was rejected by service
(linux)

There have different logging behavior the bad signature case only log
in user-space, add log info for fatal errors in module_sig_check().

Signed-off-by: Yusong Gao <a869920004@gmail.com>
---
V2: Change print level from notice to debug.
---
 kernel/module/signing.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index a2ff4242e623..b0c7b30e4d89 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -113,6 +113,7 @@ int module_sig_check(struct load_info *info, int flags)
 		 * unparseable signatures, and signature check failures --
 		 * even if signatures aren't required.
 		 */
+		pr_debug("Loading module failed (errno=%d)\n", -err);
 		return err;
 	}
 
-- 
2.34.1

