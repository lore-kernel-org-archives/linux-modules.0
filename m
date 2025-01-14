Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59861552FC
	for <linux-modules@vger.kernel.org>; Tue, 14 Jan 2025 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871367; cv=none; b=F97aHma7WSIuyxU6XL8ZAPeaLg9jxJdmB1Ae3ueay91dkPRKCOWriJj87JvwdVx4R7nwY8mAiBtp417jP5D7qerMW9nI/yS48IOoAS0Ou5nB5Gykm7HIYjl0ygcbnaWH5+uzY8fGYIRE1LVXpXzNwETY+IZfTUavjrewPHJc1uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871367; c=relaxed/simple;
	bh=OzjxDewEwUoFmZDlqj/rXaQEJ3MlmH9gIL7xuLQfnAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gij//o9r1nsT+uS5VJPORdcnX10WRzm60NL8F8hDTNRNZ0cV4xtA5ocWNuw1DErEjT/a6gbnC0GRu9xryAdAMujWrsFYUNMAInx7BxuFYPEjqCOBehbnJy0uS5SJmt1BA5g0muGQhNeYukX3JgPfy28MoFvvKJonQW1j23AyucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=arulpandiyan.vadivel@siemens.com header.b=kSY6Kd6P; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=arulpandiyan.vadivel@siemens.com header.b="kSY6Kd6P"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202501141615529e7a9db89bda16a6d7
        for <linux-modules@vger.kernel.org>;
        Tue, 14 Jan 2025 17:15:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=arulpandiyan.vadivel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=m13rf/fo4REE8bUbLVn7lVoeLJdU0fGKILMfr63i7Cc=;
 b=kSY6Kd6PqSMUpGfS9Ao+WemIrkK7BB9Pi0pT3G6L+xrlO8G6WSIBu/iCCN2+VLh6tMdB/1
 tSDuJ4hzCDNA3euc0yQOdCGmRFauReJa1xLk7QQJaOCWK5VLSMtil1A39P7uiTdYguMKQ29+
 UCz8zOE4nxTelLYAoBv5VxOcnFnthvgd/0Bot0stdK3LE5JPdD3M8R2NXIgGCk8sXm7rJTSH
 1wAKhaqx78BUr0xuTUNgA0UbgQEEnfOvz9x4S8ppJAXYBOAiPj6yqm/sG1NOUg+fZsT9P25V
 1eSbXAbVhiWXJSYLGCmwA+YuZRokG4OMcP0Epw/3HeHJ3O4EC+uEDtKQ==;
From: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
To: linux-security-module@vger.kernel.org
Cc: linux-modules@vger.kernel.org,
	cedric.hombourger@siemens.com,
	srikanth.krishnakar@siemens.com,
	Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
Subject: [PATCH] loadpin: remove MODULE_COMPRESS_NONE as it is no longer supported
Date: Tue, 14 Jan 2025 21:47:29 +0530
Message-Id: <20250114161729.77142-1-arulpandiyan.vadivel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328317:519-21489:flowmailer

Updated the MODULE_COMPRESS_NONE with MODULE_COMPRESS as it was no longer
available from kernel modules.

Fixes: c7ff693fa209 ("module: Split modules_install compression and in-kernel decompression")
Signed-off-by: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
---
Changes in v2:
Reword the commit message
Modify logic and add Fixes tag.
---
 security/loadpin/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
index 848f8b4a60190..d82bcdb34cc8a 100644
--- a/security/loadpin/Kconfig
+++ b/security/loadpin/Kconfig
@@ -16,7 +16,7 @@ config SECURITY_LOADPIN_ENFORCE
 	depends on SECURITY_LOADPIN
 	# Module compression breaks LoadPin unless modules are decompressed in
 	# the kernel.
-	depends on !MODULES || (MODULE_COMPRESS_NONE || MODULE_DECOMPRESS)
+	depends on !MODULES || (!MODULE_COMPRESS || MODULE_DECOMPRESS)
 	help
 	  If selected, LoadPin will enforce pinning at boot. If not
 	  selected, it can be enabled at boot with the kernel parameter
-- 
2.39.5

