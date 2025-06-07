Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779441C8616
	for <linux-modules@vger.kernel.org>; Sat,  7 Jun 2025 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749313283; cv=none; b=UvtAJ8+txqCI4aOBBITQD4Hf/mntIUDT4TLfdfzXYCUBN6vp7N5ceqpbAialgXRheS6KNbvbzgjKo3ISfKhQjyASSRQ9x0Y8zM3A9BO20NuysgmZt3zaNYIzAHnOjfATnGTTO3j7Zyl5RcuW0OENuZkOyMxh+A75MaNI9HNJ+Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749313283; c=relaxed/simple;
	bh=yS39zyBnMfHaSeoQ0X/1PfxxvV2rs6V8w1tf9X8XSak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQuGvStPHRGIvzmi6B+i/enT8FZPRptySWwZ2DRLLAFIED+sXx2Y+J+3OZIpyUnCdjQmJN7IqIbI8W5qgM6hxAaGWw6mj0ykPbV3EVRExZ0RzkIMjVDTFYeUC14B+eFUz4lW1G9p5f7sl2QjEhlFmsZOAWaLKN1+02whoJptUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QCtKTsRr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QCtKTsRr"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a35c894313so2590860f8f.2
        for <linux-modules@vger.kernel.org>; Sat, 07 Jun 2025 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749313278; x=1749918078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qKdIt6ySfsyC1rITEINP15T63UfdWJd+2u0hTqqtgk=;
        b=QCtKTsRrWHEbtZUbd/OCZpS5LQunyQiEwuIzTdbzdZlyeH+MzcRVoculVFyeyUzYtq
         AIbDZqZWLRVVJ8h9nXB5JVKRsSrJBR4bI8Fw4IzekpWdjXMwr6PooC2frOLYzZ3ZQ/ZS
         1EY0uHTaTALQZ2xaDuL7NtLkngV6uFwLq2NvvfLGTPAPG+fVJgCW0sgGbrm6zRZx1sjj
         hFi0jCuzEGTDWBGPGz7ZBltjv19qzUWqJV+pzNOAp6SbEVfdlIcbLquAPOWfcj569XjI
         YM7vWaf7hH9e1GH921oaemgwf/ezBqbaIFFiFqzj4pbZzcb5k/lHpU027vqNi/Ajlk1l
         Nk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749313278; x=1749918078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qKdIt6ySfsyC1rITEINP15T63UfdWJd+2u0hTqqtgk=;
        b=HeGc/1+hOaY6sBJGiLzXcm2Z/WKxr1Af0btUpNjXDdRR5pl+HpiV+6QT7SGn++sVGh
         yZz4PQaJsf4uR3TZfg9Kaa9hRl81lsk4CQfkwBig3sYvXm8uxPIS17RJt41g+IWJsqi6
         RfLO1pdHVIkBMXScSn88RjoVQpNr61VpjSKcJej90j59Oqz47kNMCLx0/8QvVxVIovxE
         53quAdJnC5fsDrMLAO8f0KeiZDclVdPAoRVjOKcU3g5D+c60knT3/XKrbVGMuSKsWrsr
         yvFHWD36bynBwf0xaE+YQl0PFG9JN3LFHFCpSy2ETWW0tepW+apxl13Wp/Z9roM8zZuq
         7q9A==
X-Gm-Message-State: AOJu0YxUNlQwqWHSDPBXrRxE7YB88PWCM877UZgjztagVALhZVh+DyjH
	FYXKCr/2q3lohOFZ8wed1fWWJsgtBr1JfNuUcOnwElnmaI8BfY1qgLlvVDm6gcdnLUpV5S6DPjv
	b6qEGrbU=
X-Gm-Gg: ASbGncv9dZejYuUGNL2Rai0U8/3QvgfjUBEk3eJh7ARE176V5PQlLLjZBbJaDPGMKqC
	caucnAaVnSGQyKxQ+gJlh7ZcuOR4GiMWoMwnyMu9ItgufdiMioak02bdMJIbcB2gkUIXueWM9ta
	G4UjoOL9rSZxAg4zUqI7cHmK5kV33xWMLungQDRIwbtQ6fyNuvcB0mEDREaZDmBiKWDvI0Xe+7R
	yhJOe+dudsaIGxrJrWnnibligPpOPd83WzSlWAp9Eu7mHvjE5QTHTb4btGBQnv3v7jp0pHmo43P
	rauLfACTyrS4vmrHhzUwPqRVb21mMRGP5s23SRRNLHZVLZI5TuTDyxNveo8HFIsJC67QqyA=
X-Google-Smtp-Source: AGHT+IFh6+oH90GRtrMoNrq78peuoljilpbPTZ7rDeQaNRcR3EO6gPLCfmQumbO8QK7SYZ51/feM+Q==
X-Received: by 2002:a05:6000:2410:b0:3a4:f379:65bc with SMTP id ffacd0b85a97d-3a531cdd100mr6256542f8f.40.1749313277773;
        Sat, 07 Jun 2025 09:21:17 -0700 (PDT)
Received: from zovi.suse.cz (109-81-1-248.rct.o2.cz. [109.81.1.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5324364f1sm5088096f8f.58.2025.06.07.09.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 09:21:17 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] module: Fix memory deallocation on error path in move_module()
Date: Sat,  7 Jun 2025 18:16:27 +0200
Message-ID: <20250607161823.409691-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607161823.409691-1-petr.pavlu@suse.com>
References: <20250607161823.409691-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function move_module() uses the variable t to track how many memory
types it has allocated and consequently how many should be freed if an
error occurs.

The variable is initially set to 0 and is updated when a call to
module_memory_alloc() fails. However, move_module() can fail for other
reasons as well, in which case t remains set to 0 and no memory is freed.

Fix the problem by setting t to MOD_MEM_NUM_TYPES after all memory types
have been allocated. Additionally, make the deallocation loop more robust
by not relying on the mod_mem_type_t enum having a signed integer as its
underlying type.

Fixes: c7ee8aebf6c0 ("module: add stop-grap sanity check on module memcpy()")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 08b59c37735e..322b38c0a782 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2614,7 +2614,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 static int move_module(struct module *mod, struct load_info *info)
 {
 	int i;
-	enum mod_mem_type t = 0;
+	enum mod_mem_type t;
 	int ret = -ENOMEM;
 	bool codetag_section_found = false;
 
@@ -2630,6 +2630,7 @@ static int move_module(struct module *mod, struct load_info *info)
 			goto out_err;
 		}
 	}
+	t = MOD_MEM_NUM_TYPES;
 
 	/* Transfer each section which specifies SHF_ALLOC */
 	pr_debug("Final section addresses for %s:\n", mod->name);
@@ -2693,8 +2694,8 @@ static int move_module(struct module *mod, struct load_info *info)
 	return 0;
 out_err:
 	module_memory_restore_rox(mod);
-	for (t--; t >= 0; t--)
-		module_memory_free(mod, t);
+	for (; t > 0; t--)
+		module_memory_free(mod, t - 1);
 	if (codetag_section_found)
 		codetag_free_module_sections(mod);
 
-- 
2.49.0

