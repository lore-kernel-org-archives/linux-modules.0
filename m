Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF39199FAC;
	Fri, 22 Aug 2025 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867311; cv=none; b=Qp2sKS2g59Xs3nqRQulzHbBboNY1QgCYSiMa0GUYj63WHALiFrt3R2fGxfCChnGeQ3eO/IK6H7vdAU1T9tJ1GuIipJnhFrYOj/rK/8QRhrB3Q17mOFLTRJWCzI1is2udeKACEvFdlHLUrn7jCxLO4MQiZAHRycVPQ1YAP9phsCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867311; c=relaxed/simple;
	bh=O+dmbiGEj8F46QTVyVP57VP1t3B7/OZvoSp/KF+0DlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0brTVauRiyu7SaaV7JP+f2lWqFTygMgpcOh9jynchQc2PFfh9A396w6nsm25HV0W/jqG7ggxnOFQFv3N4dCXLSI132uNQ5eZ3hA975CixErKUmghiPackLsVgRsNawsx3iXDZcn7mWUFuSrH/gJNwwvVgDYySuRG8QS99uACio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fpzh8o+b; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpzh8o+b"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4717330f9eso1448404a12.1;
        Fri, 22 Aug 2025 05:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755867310; x=1756472110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YeEm17f+SxN+MAIvXYQ6rN85sdmuGJRyZf4VEhc4oUU=;
        b=Fpzh8o+bgXx7VkVR2jAuLfGYkkcH5S6WK+flWtjDo65Ht6DbmiOImY6zsXT+XIC2XZ
         OGEtMkLI/mti05Hn+Og9PCXb2dTdEfzmb1A6CUf+NyEWt3OvSQ+upDzfkId4J/Bk4VqJ
         oBgWZJoR2L3BnJOmyvllw9PlJsWhXDE2t5BeMChF95zjmUxJvBuOOpDpy9X3Kgu9SnQN
         DuIDHqG5ALyT3javrPpY6Ijr+otEXvgR5EA+Eo1DuUy4mGRmIjxMC3LMBvXFROCPbDEB
         lK4KaC2hm9bDKSekTQl4xD/GwH8WNM0XSl0q8llSaWzJGylHGWg3Yyso2HVOpeg+TkI4
         0RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867310; x=1756472110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YeEm17f+SxN+MAIvXYQ6rN85sdmuGJRyZf4VEhc4oUU=;
        b=p/CjSgJ3tD5D1XypMw22OYEAMWFgwXZtE3F+p2ATUhIJI7RmRWtSkEPNoT8UjTWWQG
         wJnwnvVNDlr5dgpU5L+iOT3RkLunkfAkcxc/IAt5CiCmU0fL/2DIYrHT6i28KHHb4Q4m
         UuW4MvAiltZHqL0fnYRV0c+4qCRSoncZf6g4/hI3Z5IRHCncT9v3PfKLe+vxtAskmHXj
         rnfdprY7vXN4vvSuycX2p7tSWpkXn8q7DZQNQpTq1XY+mARQHTv7WpQv6qiuDp4ettGl
         rwJrSceAMSfFtBvXqM4BrfTS34DD5J2MVR1Pi4XSyJRKSjn5hJe9cshtfeVJV/E8ebBf
         UFIw==
X-Forwarded-Encrypted: i=1; AJvYcCU1yn9Cz6jFJkB3fOSJif4i76wUVK3+3+IZtqS9PnwojG8LxQP5RJ+rWELqmXukcg4+j27cxuIssIpMCLk=@vger.kernel.org, AJvYcCV6luGR0zJ9xSeUiJOtoRIQkAr3D9n3CbCUNyqK/pr7wE8CID2RQ9/gXJGpaZJiTgljkv9o57RS+hKqewTriA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz060gCcltqEE50IAHA4mUwkfw47JnwyCDmu0aqj74QySAgaoQX
	zcAFVcISJehvLniiI4i3tBj7Y5T1gy/CLDg0NRgpJGhC02DW3Lb3HSpJ
X-Gm-Gg: ASbGncub+/Zhq1d6KKtkElkmTanDGu7sJ9KKJuNzDZD22aW1J82vs6OFVkMcAbm0xR4
	DXaXMtoo0LA6AdepD18qsVCtkNGTF4gK39jVUUQCEzGz9tlGND1t8XugVMK2xA7NRfB+xtE8muU
	Vw774T1QwxR4klLnuduZ1dn4P2T86VCNwqgEIpLh5dBQ9xpy0ZTVkCa5yZ3Xeb58HVORNEIMaNY
	hDiLVm3Dpw5ByBvIi9xVavF56ltjpIWeVYditraTZlLCl7HPKN9cQys+jDbWFXIeO36W+WYhYiW
	S5XKUbXFjjhe7aLsBRAS8VSkUvJ1qICI0yh3oyGuSSUcL90AXlDsMZIN+wApWBnXgZDkFPnVFyA
	jHbR1memM8iqowQS+O3JwMCkoeyEqJZ1IVtdzZKGiTUv0M9Aa5VP8kZniF129/hU1LzUpcM0+MZ
	A=
X-Google-Smtp-Source: AGHT+IFgOU+qUZBP02uevKCYNqgjB3GnS0PwtJ2Pjgl76CyFA+zLtwYIxb9Gb7VERWn+wtTilxreIg==
X-Received: by 2002:a17:903:1251:b0:234:a139:11fb with SMTP id d9443c01a7336-2462ee88d12mr37661165ad.27.1755867309657;
        Fri, 22 Aug 2025 05:55:09 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed377843sm83617285ad.57.2025.08.22.05.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:55:09 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 0/5] Module loading error handling improvements
Date: Fri, 22 Aug 2025 20:54:49 +0800
Message-ID: <20250822125454.1287066-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses several issues related to module loading error
handling, particularly around force loading and signature verification.

The most critical fix is in patch 1, which resolves a bug where signed
modules were incorrectly rejected when loaded with the -f flag (force
load).

The others improve the user experience when troubleshooting
module loading issues while maintaining the security guarantees of
module signing.

Jinchao Wang (5):
  module: Fix module_sig_check() for modules with ignored modversions/vermagic
  module: signing: Use pr_err for signature rejection
  module: show why force load fails
  module: centralize no-versions force load check
  module: separate vermagic and livepatch checks

 kernel/module/main.c    | 13 +++++++------
 kernel/module/signing.c | 15 +++++----------
 kernel/module/version.c |  9 +++++----
 3 files changed, 17 insertions(+), 20 deletions(-)

-- 
2.43.0

