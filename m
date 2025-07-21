Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F87DA95;
	Mon, 21 Jul 2025 04:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753073563; cv=none; b=e4m/ESZnyKctXM9QzNGN/XwrTbyfytmGuSi1MstkArVeAI2XbvBIf3WPXGlpBF/VRfb0qBb9VlRih2PJ3AKcwEwMH471KhDYgY244GEZ4YIg2uvlZDJ4s2CKbd2K/6Rw9Ytr+He8FODuDLVPe38ZkX5TwK1XrbzGlSCllsfnCeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753073563; c=relaxed/simple;
	bh=iFIckDhmh46+JBvPEiXW40w2jmhdwOKLz3CH/4sGys4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CfocBkaQaBL8eaM63k6UKGJikqQMiUoSKg+V6LDgJHvXaIp1CNyWL6HQ+QF53peenKBQHetnsBLZJ5ld2/q+E2nJGEVwF5JyvdRdXr1p4/w7BPnVbB33tBUxPtSew4wQtK68ZHBri65gS314h0WxrYZTpKzi8LZXXkfMX3XG41o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrI1BPNl; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrI1BPNl"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-75001b1bd76so2330615b3a.2;
        Sun, 20 Jul 2025 21:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753073561; x=1753678361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I/rwEe6pL2DF04u25wQFRb2SlRQeQrgkAGmuOAnxsCs=;
        b=XrI1BPNl/hARoAVTV3JPwWy6+Sfeuqo11pMlxOrEKOb7KLhe9MdpCDfF4knmEOYsZb
         kJt1N4dcbdgykx4x77qqB0u4ice3yOobei9WFuKgUr/TWeP4XkitppBGlRmBeCjVC1si
         V4uCkaTXTKaNdvMhCJKhv1GQc2Z0NSmvxg3EtsOMB+3GWsY6zy7Okq0x3InF5P+4AMzq
         NPIYeot0BE60iuSop2RmkclxJMPT6k5aO1VTqo5SiAKiDri+9b3ct4ThZwbcTI4Xr+ZO
         1duGVWqdL17oxChr4+zykV0UMXVwlW1CrCwRDwNQd1hoB7hAm+MmTnD2gCi0xNPsDpAw
         fdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753073561; x=1753678361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/rwEe6pL2DF04u25wQFRb2SlRQeQrgkAGmuOAnxsCs=;
        b=IgAV+Qjgagqat0YxUJED/bWcOrzIpJe8w3rVLBi9Afuw0OBaRUmknsLuYNFT6LCNXd
         e1tadn2LAQAco6lHwiFcXNX5I9glOw2neeffC9y9pit+jLaf7VvlOap+AZgtfIEY3q3d
         FgyNz7TvmRfw1ylVQvTm+J5KACOats5djyukeAlh6lRdNqo6RsOHCkzIf7vi9RiDoodY
         IXjSxyjEZlLqeHcbGjN8o9F+osXhPsEXkbCcrFppCBzW/Lu60oM6MyXd7jGpm9KqaTfi
         iQpNEPPGU6U3sYtmAC5Wlmvakq9hjtdY9Wb0NHA/DvmY3252LlLLTVbYImyAojH5dilu
         ZNHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0cSWmrcBHOnrBx1tfLWwJRpNcOm4AtGVm34JpGwFmew+B6xPIW2ULd1f2BH6J3mK65DDMv+Jvfk9MPI0e@vger.kernel.org
X-Gm-Message-State: AOJu0YzqkAAovLEmtDXPrFQEIdYMrDwZgEALwO/hf/gMP+l5L59k94W/
	/vQux/FLlcjQMYbKx4F17T/8zeETlbO30T8VndJ2GcPLsdfZN5dqHK/jkt/tKXVZfEU=
X-Gm-Gg: ASbGncsRVqifWdmbnTrqtK24zDtZ+6ZjJbn/U406re3qZATApH6MS3j7QKJEsrwxgf/
	LEPqOdRFinu5QrqyeH87z9tf4beo9OZHkODImZao1hN/je+ISudsRLNQJ+jRZK6qgrJ17OjlPIv
	43ibLgXoqBnOu0Ey36zcHGbWkWSrGeCwTXChQt2lQvRcXZxgMIp5QHbqS5rZ6NgrFWzIFyB/qFm
	jYn8PbTAx9H/YGe3vm+DMv4tvhEI+JSn/cFai+lS/UIJJKsqrBxJt/FBas61vI/GdPQkJkrn4ag
	9uc4l+WWY8WURqFelLg3Icmq2N7OzqyR85r17VWuOTYzcU0acpqDrrITmZJcDVSWjzVFWu+dafB
	9l098NEOE0v1BXdAOHcPpOSPufpA=
X-Google-Smtp-Source: AGHT+IF07eh+CugTSLl+wj5WqVKAOwprNgaoF1PSpy+urZ+jDqq8P+VPJk1dfTzezt3dhZTK1L9Lrg==
X-Received: by 2002:a05:6a20:6a05:b0:220:2d0f:f8e1 with SMTP id adf61e73a8af0-23810e500f4mr29784210637.3.1753073560750;
        Sun, 20 Jul 2025 21:52:40 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::4008])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb155e25sm4927365b3a.94.2025.07.20.21.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 21:52:40 -0700 (PDT)
From: Wang Jinchao <wangjinchao600@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: linux-kernel@vger.kernel.org,
	Wang Jinchao <wangjinchao600@gmail.com>,
	linux-modules@vger.kernel.org
Subject: [PATCH] module: pr_debug when there is no version info
Date: Mon, 21 Jul 2025 12:52:22 +0800
Message-ID: <20250721045224.391745-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there is no version information, modprobe and insmod only
report "invalid format".
Print the actual cause to make it easier to diagnose the issue.
This helps developers quickly identify version-related module
loading failures.
Signed-off-by: Wang Jinchao <wangjinchao600@gmail.com>
---
 kernel/module/version.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/module/version.c b/kernel/module/version.c
index 2beefeba82d9..bc28c697ff3a 100644
--- a/kernel/module/version.c
+++ b/kernel/module/version.c
@@ -42,8 +42,10 @@ int check_version(const struct load_info *info,
 	}
 
 	/* No versions at all?  modprobe --force does this. */
-	if (versindex == 0)
+	if (versindex == 0) {
+		pr_debug("No version info for module %s\n", info->name);
 		return try_to_force_load(mod, symname) == 0;
+	}
 
 	versions = (void *)sechdrs[versindex].sh_addr;
 	num_versions = sechdrs[versindex].sh_size
-- 
2.43.0

