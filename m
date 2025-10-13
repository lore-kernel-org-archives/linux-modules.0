Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB35223DC1;
	Mon, 13 Oct 2025 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372830; cv=none; b=kXiHjV2p7u46Z+3iA3z4/L7zOfm5euBQQnF/I2ZUQtcwR8NEx0JAg3rYerElMN6Y6NSCQsAgP32ApryWq7RK7HfE321Djp/xr7vW3BFB9lvIat0T/L6VwrQp/dmALPwyA0SuZPCS9PimEpmzmYpiqGAk66i/cdM1IDjA/cxfi9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372830; c=relaxed/simple;
	bh=9qS09/oL1ZW/4+fX9C/TuDIUBMfU9E9dZdPEuUhgxh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9vr8V6YIYlj31cowi0ip6ylbV5CMUels0D1IoXHwnGMdR7g6QLgSH5Yz1WAWz0jIBFptLq09bsjZnTAiQTYxuTA8Xw5EMFw9yeWCbMD5mQklYMiirIYi2sFfeWnxW6uh2AtMyOAuPUoH+iD5RQ+cBEhc+UCU/KTTuo7eNAJcXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqxS7dqH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqxS7dqH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760372829; x=1791908829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9qS09/oL1ZW/4+fX9C/TuDIUBMfU9E9dZdPEuUhgxh0=;
  b=IqxS7dqHFaXjOjiq8V6RR0tr5HcDr0f3Gp5wLgHm5Tzy15TV7yiHaxCc
   VUNjMvacojz3avI3CR1vchdHjBw6oCFO92iDspSEdIRwX3zHMBjnAZzlB
   +o3brd9ADGaUrqDzahFP6fUqyl1Iy1+/vNK5y29b5d2FBRhlmHRBXEQbK
   02O2c97FfbYBEIAU29PYrsWxR+wwzRIASPssw+Sz6jEphhuIYx6937Ucv
   gbNjQQqxzODVU3q2yyIc22rpDOtTGVU2sbb6Ki7k93SUFxiZvWH4Cbjc3
   uaZ8fEfo5sn1u7Qhfm7wV70MqS9SQWUcQ5nAJQ3TC5xFRzlRqawbRRqwf
   Q==;
X-CSE-ConnectionGUID: 5qpq3Bo5RDqFA7faGUD6uQ==
X-CSE-MsgGUID: hBiYqKicTnKU27qE3xh67w==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62409335"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="62409335"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 09:26:59 -0700
X-CSE-ConnectionGUID: Ie2DvTwKTU67H+OMSUMQug==
X-CSE-MsgGUID: FmJ/hBHIQ8mf9ipCEpV7wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="205331726"
Received: from lucas-s2600cw.jf.intel.com ([10.54.55.69])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 09:26:58 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 2/2] module: Simplify warning on positive returns from module_init()
Date: Mon, 13 Oct 2025 09:26:24 -0700
Message-ID: <20251013-module-warn-ret-v1-2-ab65b41af01f@intel.com>
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

It should now be rare to trigger this warning - it doesn't need to be so
verbose. Make it follow the usual style in the module loading code.

For the same reason, drop the dump_stack().

Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 kernel/module/main.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 74ff87b13c517..31c54bf6df4b2 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3045,13 +3045,9 @@ static noinline int do_init_module(struct module *mod)
 		}
 		goto fail_free_freeinit;
 	}
-	if (ret > 0) {
-		pr_warn("%s: '%s'->init suspiciously returned %d, it should "
-			"follow 0/-E convention\n"
-			"%s: loading module anyway...\n",
-			__func__, mod->name, ret, __func__);
-		dump_stack();
-	}
+	if (ret > 0)
+		pr_warn("%s: init suspiciously returned %d, it should follow 0/-E convention\n",
+			mod->name, ret);
 
 	/* Now it's a first class citizen! */
 	mod->state = MODULE_STATE_LIVE;

-- 
2.51.0

