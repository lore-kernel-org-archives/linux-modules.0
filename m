Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691747;
	b=5c+XhA6o/wMEyEptmspMvbhncJBPVyN+0neEvN7cpExgdqLjdtcL/Joe5H9cX77FzwhO
	 95RPtmyjWJqquoEfzjZulmauW4BTcycO24Ml/5V8Lg0l9JvYypoH0pA7YsBOKZgBGn7Z4
	 pj+x7PopAv9TVcntlpTm7UMTWYUKqPgUBaSWSc1pSOqQquNlKs+gmWo/yHF+6MQe8gQEA
	 sod4i6ZyIt6dKBAkrbaW0/9DXPkBdH1UmYBf0dAAIx6YRFqSg2I5XrddxFXs+KOwRM0YY
	 jyJ3zxf/JHRT6EGdzqRMxPS/vaemuEdbuAh2xSToCx66azDtk/HHFHtIu6ASrq1ctDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691747;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Apy5tRrCYzro5qQhtzsCNnlTXKiawBRdqLWNjFyyG3s=;
	b=fsDiOcixuYI7OsxRu65u8ufjh1Tms0YuGEKCvCsj/TVAXozETQenSw3wdDbh6wCUvsUD
	 sV2XQeQsH6rcXtZS7qishXAuiHtzbK43BOnh91jV4nb/di54fl6DqqQDcEX3PzQ5Hrm70
	 XlqQqoy41DWdv6DQVPn+7iAUKXZZBMzRGFgvXNY0G8o21tTd7DNkkaOlWBfi9ktGVeQXT
	 qPbbKlIQaK95XGrt6jbgkZjhOEiw/myHVnLqkLKtzMdTYa7XUQtLnrcNgiGVE3nkUdG/F
	 mkfp0zMtcvYmLJK0JGfVBY3sTciA0GVThhJHgFVtRJlrTF4RAaPMP45Ub7jdJJIbJ1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RmgZ3qEX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC04D606A319;
	Thu, 22 Oct 2026 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RmgZ3qEX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170AF1F01828;
	Thu, 22 Oct 2026 17:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792691746;
	bh=Apy5tRrCYzro5qQhtzsCNnlTXKiawBRdqLWNjFyyG3s=;
	h=From:To:Cc:Subject:Date;
	b=RmgZ3qEXD1i6KMUHkDauSidnoRGJzUak1lWypsQX7HluLyu/AlGJCWHQsdaK7dYVq
	 H7iQd4/4vQtoCH578SsK544b7KZ16Bxw3xg4ELUqRB1B+ylQcnZ40iYzrkvdgSz1JN
	 VHf/Ki/eKr9UI2eTgMP04Tbb5v+k5KcY/UXngN1O6q45FwvfgvMsQ92/ZPlRW9rPGD
	 ItrLKIOwLAaihIUzpiULNS/kYFTPCD0+4BwRY4lbr8hK1criTPI2IFS3/w0r7v+WF5
	 P9YwFHJ6lhbNispIKn7MUBaHbTdy6sQUpfW8XXyiQgj4oZEh4zRXEp63GvyTG32kHw
	 YPnRG0erd3xyQ==
From: Sasha Levin <sashal@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/fbdev: Replace __MODULE_STRING() with __stringify()
Date: Thu, 22 Oct 2026 13:55:43 -0400
Message-ID: <20261022175543.1831620-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 08abfa5a161e ("drivers: Replace __MODULE_STRING() with
__stringify()") converted the drm_fbdev_overalloc parameter description
in drm_fb_helper.c ahead of the removal of __MODULE_STRING().

Commit 6b5a66fd9f21 ("drm/fbdev: Move fbdev module parameters next to
module init") moved that parameter into drm_kms_helper_common.c while it
still used __MODULE_STRING(), so the conversion never reached the moved
code. drm_kms_helper_common.c is now the last user of the macro, and
removing the macro breaks the build with CONFIG_DRM_FBDEV_EMULATION=y:

  drivers/gpu/drm/drm_kms_helper_common.c:46:18: error: expected ')' before '__MODULE_STRING'

Use __stringify() instead. The parameter description is unchanged.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
This depends on 6b5a66fd9f21 in drm-next and 08abfa5a161e in
modules-next, both queued for 7.4. Petr plans to remove
__MODULE_STRING() once his conversions are in mainline, so this needs to
land first, either through drm-misc after 7.4-rc1 or together with the
removal patch.

Build-tested on next-20261022 (x86_64, gcc) with __MODULE_STRING()
removed from module.h. The parameter description in modinfo is
unchanged.

 drivers/gpu/drm/drm_kms_helper_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_kms_helper_common.c b/drivers/gpu/drm/drm_kms_helper_common.c
index 1e55ecac46989..346f6c4c0b234 100644
--- a/drivers/gpu/drm/drm_kms_helper_common.c
+++ b/drivers/gpu/drm/drm_kms_helper_common.c
@@ -28,6 +28,7 @@
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/stringify.h>
 
 #include "drm_crtc_helper_internal.h"
 #include "drm_panic_internal.h"
@@ -43,7 +44,7 @@ EXPORT_SYMBOL(drm_fbdev_overalloc);
 module_param(drm_fbdev_overalloc, int, 0444);
 MODULE_PARM_DESC(drm_fbdev_overalloc,
 		 "Overallocation of the fbdev buffer (%) [default="
-		 __MODULE_STRING(CONFIG_DRM_FBDEV_OVERALLOC) "]");
+		 __stringify(CONFIG_DRM_FBDEV_OVERALLOC) "]");
 
 /*
  * In order to keep user-space compatibility, we want in certain use-cases
-- 
2.53.0

