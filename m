Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D04F24A063;
	Mon, 13 Oct 2025 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372831; cv=none; b=sonRG5R+JbapTi8N6fD02O09LL+3/0DwRpHZmOKssOc4yeTi08rdRSXwq2wT9INn/tPGB3Dp+1fqB+7c9bQmrB7GAt0SObOdMAProXwBhmu26dOW2PyHZYL6JqcPzjkDtvlOOp2L/Z3DMwbtzeVqyibbiMISlUUx4wr5CyMWFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372831; c=relaxed/simple;
	bh=5iLdmqPa99v7UTHnW6tvGbtWO3GHkHMbLz5IL+MzR64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWRnC+TeCqlMKYzQ67PSZRute/6b2mdHxmuXUD86kEVydoINfnOf5DQyUUem2e/Gr586/hf9OstEexxU+cFB0pqmEakX8iVcNv9qOlrP3kjcrMX6wLAuq4FB0OYkxLo+uXkbe8F5Bq6EwI4JH5IV79GSc1tqEbDBi3MgCdY2y/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZjedRFd; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZjedRFd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760372830; x=1791908830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5iLdmqPa99v7UTHnW6tvGbtWO3GHkHMbLz5IL+MzR64=;
  b=aZjedRFdNFRinmlhz1nxlRV7wNWVGraPAL0CxHuDwu5UM1bAMnwOdvvh
   c+G5O/pNtEKrqtQflJS/a0uvOmQFuaA/QGCA2JRWNEv2Zg8ltV9xX9+Jv
   ta+FjkUj+J6BeYG6kQJg9UrUZUH9aLYbUJ2L01hVnbOfaId0l/Umg4AMc
   zANkFhw7A4J3lpOijz/M5gensu4V/qSHsQ1F20k58A09F7kIIWCgNPkFS
   xRq52e2Gn/VgtNgiM26fo4L/5LLSEQnTuSpNakhGgtZbBadeHoy7uu4pD
   nh0Ggp0w5Lvopn39t43Yud/sk/+cCe3CztnKKkMbzOqwsgxzEREVX5eXQ
   Q==;
X-CSE-ConnectionGUID: jqHBjjQoQIWcy8g1fxk2dA==
X-CSE-MsgGUID: jaCNamssQD2BZ2CpWrnBYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62409333"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="62409333"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 09:26:58 -0700
X-CSE-ConnectionGUID: ZRj8VDwqSV2wAQPkPP5jCA==
X-CSE-MsgGUID: acgVpgwRTgSKHED3BGtKhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="205331722"
Received: from lucas-s2600cw.jf.intel.com ([10.54.55.69])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 09:26:58 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 1/2] module: Override -EEXISTS module return
Date: Mon, 13 Oct 2025 09:26:23 -0700
Message-ID: <20251013-module-warn-ret-v1-1-ab65b41af01f@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com>
References: <20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-bd47d
Content-Transfer-Encoding: 8bit

The -EEXIST errno is reserved by the module loading functionality. When
userspace calls [f]init_module(), it expects a -EEXIST to mean that the
module is already loaded in the kernel. If module_init() returns it,
that is not true anymore.

Add a warning and override the return code to workaround modules
currently returning the wrong code. It's expected that they eventually
migrate to a better suited error.

Closes: https://lore.kernel.org/all/aKLzsAX14ybEjHfJ@orbyte.nwl.cc/
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 kernel/module/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b261849362..74ff87b13c517 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3038,6 +3038,11 @@ static noinline int do_init_module(struct module *mod)
 	if (mod->init != NULL)
 		ret = do_one_initcall(mod->init);
 	if (ret < 0) {
+		if (ret == -EEXIST) {
+			pr_warn("%s: init suspiciously returned -EEXIST: Overriding with -EBUSY\n",
+				mod->name);
+			ret = -EBUSY;
+		}
 		goto fail_free_freeinit;
 	}
 	if (ret > 0) {

-- 
2.51.0

