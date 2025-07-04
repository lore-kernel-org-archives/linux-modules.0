Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283791EF391;
	Fri,  4 Jul 2025 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751658025; cv=none; b=FkxnJvFgAUBsXfN6rAF/Id7t5JZnYvU9v3leXvoXqn74cH2LyK9lvGlkPcI7xUZ+YZYx+ONeKv2wJQB9MFker8kowWzRkTu7Ip6LJvRL0vJH3w5M7dcjvoDRDxfmiPKECticah5tCOFZALgURlYA9vqi/y7Xivw+TLffROCR1mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751658025; c=relaxed/simple;
	bh=C4l5zxyRkHkDKD3EQWWYfM1YsLti1iscNM70wSqSgUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=to1Jop2R2AKTxE0vREbKL3r4ZbLagp0+ASx/oYSZ+HURqfZP3qjNMt8MCJQi4OwlMHFNpOmGlXx0ajQfxYAoQeT3h1ykwBONy+PlOy2swCaLsZk7BJbC5fPxZSI2yHvfyqdYb/bDgbNSTCrsBHiUFBg/gharnJCNpF5HyV1URd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO6K0Ecs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO6K0Ecs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB90C4CEE3;
	Fri,  4 Jul 2025 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751658024;
	bh=C4l5zxyRkHkDKD3EQWWYfM1YsLti1iscNM70wSqSgUY=;
	h=From:Date:Subject:To:Cc:From;
	b=FO6K0Ecsr6cJjn0QgDCY1P2sacN4491CyB7M0D9EbBhgpckW+eOB3qCIdFbjpERat
	 eFS3k1vyLiu2+gEJxOyq2tOlgxdondn3vA9Ok0qpvYAJHB6Aw3sjkwbpLBH+N2GJtm
	 y6Y8IaczIEahEUc0yqedU/nMOVo6UXri66gNVgnc4Gx8QtKA+28N67igLbKd4iKDkH
	 7AWNADtVLrIBPH+zGxUcepVBmqf1S0Gjhgq5ZGwDSWYSJ085+AWd+6/YN01C9uBU+7
	 TxY3WO4Tlx9Ebd51lHmg/GQYj7ggUvV6VfXx/73V2MvxiMG1hxMV3452ejal1yZ3CU
	 bSxx+Nldr1iuQ==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Fri, 04 Jul 2025 21:39:59 +0200
Subject: [PATCH] MAINTAINERS: update Daniel Gomez's role and email address
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-add-dagomez-maintainer-v1-1-5fc32033c51c@samsung.com>
X-B4-Tracking: v=1; b=H4sIAA8uaGgC/x2MwQ5GMBAGX0X2bJOiwu9VxKGxH/ag/rQiQry7x
 mEOc5i5KSIoInXZTQGHRt18kiLPaFycn8Eqyak0ZW0aY9mJsLh5W3Hx6tTvCQQW26JoxFbTD5T
 if8Ck5zfuh+d5Adf77ANoAAAA
X-Change-ID: 20250704-add-dagomez-maintainer-d48e17d43f9e
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.com>, Sami Tolvanen <samitolvanen@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1966; i=da.gomez@samsung.com;
 h=from:subject:message-id; bh=S/iikURRf5oCaytoYYJVR26dMzVDVdQzYjPG8cAoBL4=;
 b=owEBbQKS/ZANAwAIAUCeo8QfGVH7AcsmYgBoaC4Zg2XlLOjmAr9xHsFm/1rsvdT64u7MaW2wC
 vnNE3EP/7WJAjMEAAEIAB0WIQTvdRrhHw9z4bnGPFNAnqPEHxlR+wUCaGguGQAKCRBAnqPEHxlR
 +6yzD/9cD09Ff690H9MGIyw3mjdajxZ99yPrgCUuWOM3AxImsa0D1GZtQaKgXlH8OYWNSarHd4m
 SjaEDNTRjOK5vf9FzVNZO4er0wG3oCWJyVuqJltbBgCbUNlp7xQSGOhsNIV0Myl38iqrGpRepCD
 36Gzkb+YsiJTaKG3M+mo7ucQ09mAKvRPPmnoJxUrXv/LMT2hZxqNV+WNw4yIEVKk0saEbblGMcN
 yjIWDcr2MQm0kdgoUcudbUgZutZyOytRFbxNRSolCLCMjpY810C2AhnG0Q8A+DvOGj0G1fV4Knj
 CReZJ2Qqdxxj9cNYdpehJobW6Y6zGpxFry6BvM+myPWbpbyaEDY8xYfgG3RT53rTVCH14+YCOB9
 MwEux5F+ji2pvxI46IeBa83/CqzreDWubxKUEvfoD1Qk/KtFLHUWSfbkaUSjlDuB29ZapX2fmHq
 iH5OnXYyLGtKufZ1XIF5vjXgoDwd3USVHaltXdbvzHPQlmX5/ykHxshdUmhYsbD8BZpuzp6CPZU
 3CJGDR/+cnLkcL0TS23gXqSi6YVJEME2SA5vs7YxtpN2cHOVIlxjDMzUXG6uaUl/A8E6GUROK7L
 hMXUrkfI7fdDOJsbkdy3zaLJ4a7PrG7FmnUUJwA/7cX1WGV5XbHwt7gzccCx/8soQ+tnD4Cgd4B
 Sql0SrOmHcH8H/A==
X-Developer-Key: i=da.gomez@samsung.com; a=openpgp;
 fpr=B2A7A9CFDD03B540FF58B27185F56EA4E9E8138F

From: Daniel Gomez <da.gomez@samsung.com>

Update Daniel Gomez's modules reviewer role to maintainer. This is
according to the plan [1][2] of scaling with more reviewers for modules
(for the incoming Rust support [3]) and rotate [4] every 6 months.

[1] Link:
https://lore.kernel.org/linux-modules/
ZsPANzx4-5DrOl5m@bombadil.infradead.org

https://lore.kernel.org/linux-modules/
a3701a9a-5b42-4581-a150-67d84601061c@suse.com

[2] Link:
https://lore.kernel.org/linux-modules/
458901be-1da8-4987-9c72-5aa3da6db15e@suse.com

[3] Link:
https://lore.kernel.org/linux-modules/
20250702-module-params-v3-v14-0-5b1cc32311af@kernel.org

[4] Link:
https://lore.kernel.org/linux-modules/
Z3gDAnPlA3SZEbgl@bombadil.infradead.org

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
There are fixes [1][2] to be sent for this release cycle that fix a bug
introduced in v6.16-rc1 and in v6.4-rc1.

[1] Link:
https://lore.kernel.org/oe-lkp/202506041623.e45e4f7d-lkp@intel.com/
https://lore.kernel.org/linux-modules/20250610163328.URcsSUC1@linutronix.de/

[2] Link:
https://lore.kernel.org/linux-modules/20250618122730.51324-1-petr.pavlu@suse.com/
https://lore.kernel.org/linux-modules/20230319213542.1790479-3-mcgrof@kernel.org/
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4bac4ea21b64..bf07c0acd1e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16820,8 +16820,8 @@ F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
 MODULE SUPPORT
 M:	Luis Chamberlain <mcgrof@kernel.org>
 M:	Petr Pavlu <petr.pavlu@suse.com>
+M:	Daniel Gomez <da.gomez@kernel.org>
 R:	Sami Tolvanen <samitolvanen@google.com>
-R:	Daniel Gomez <da.gomez@samsung.com>
 L:	linux-modules@vger.kernel.org
 L:	linux-kernel@vger.kernel.org
 S:	Maintained

---
base-commit: 60481cbdfae129753633cf03f061293b6e0c8bf4
change-id: 20250704-add-dagomez-maintainer-d48e17d43f9e

Best regards,
--  
Daniel Gomez <da.gomez@samsung.com>

