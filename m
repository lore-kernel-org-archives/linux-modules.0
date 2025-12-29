Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759A9EEB3
	for <linux-modules@vger.kernel.org>; Mon, 29 Dec 2025 02:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766976369; cv=none; b=b3lNNjxlRRG4pyt48sAuq+ISPbg/aYu0JaM2XbIvea8DZsQncSa49NB5Md0qtqLEnQeW6VPbbyCW5ESoXjOAAQCReqrvVUG1aSbLMEEd56nII/iSuKEA3FEsSHRk6IQ0QOvlJo1OgHzNZYoD/OW8zorEsONnwqSjLeeWOaTIi1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766976369; c=relaxed/simple;
	bh=JMdXEp8ZZfYGi58KsjbVQIHRcDrf3D/zHBQgB8IXIXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XqEeO4q6pZrTdO7ORJ6iDA/Hg5IsuhYK675PTH7Ytji620IF5FsLevsGW3xKKGE32WzbfBT1phcc9p+j6un/JuMqu+UoiXDDFgCvm0YlIxtImeHkpl3L4SBSiclnKfuyOqQWNdDd8zHV3GHvVr10uO4TrpKymm7YjMInMduHGyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPkRZ7bX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPkRZ7bX"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0bb2f093aso87064505ad.3
        for <linux-modules@vger.kernel.org>; Sun, 28 Dec 2025 18:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766976367; x=1767581167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hvsZccGmypaQdk3tHNL83bEg1blkjlqraDO3AgV6BlE=;
        b=YPkRZ7bXsEeDUskeQ6bF7NxCuiaKd8xGqfl7wzEsE7gSb2UCU8EG0ttNZGhLYPvCt5
         LdAMnFg272SSNWSCnsIx+K+rl/Tt0+LCbpo4nfidTsi/RpRfLZdbXsIWJkiajIRk50N0
         7teW/e+ECuooXZKHHLk8ANYjR69Cy/+nMrFWtNArMN6EWybJx8gUlqYbA2hQV+8tDdK1
         S5DTC8V815vSBsrJ0VQeCAjx1XZXSVrVnozSL7y/2eayswq6fLboEUpHqgofvMdA5oJo
         /wYAXKDWCxnbX17wejY6Ge8il4rA9pRAxp+q5OLZiEfe2OL7HOwtc8A5NPFj+Ac8G/le
         +TwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766976367; x=1767581167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvsZccGmypaQdk3tHNL83bEg1blkjlqraDO3AgV6BlE=;
        b=F1HXUrZIwz1/t5yPYeTAfCdMo/YevUTPqD/dmSPwHG6t8fviaM+aQu9FxICEpFRp2+
         N4FtgbGILvCaQM+j4ed3G2L3vHhz2yWus1/IGR2VhS03eSxDre/Zpva4BEMXj6MV9/zr
         UrD+LcaELXt7hpoiQY7vpET1z5cL2MP+vxkzCb4MDSK5GJxIl6x+x22V89QhGkSSJy+8
         uZ4B8G45UKZw1Pn7p9Cue3K6xaa4MNJBhQLDoxYshcRuHDBPmWdZYY4AxjDPeX9eO+K6
         oiAM4XJBbeEuS+VQ47ezobsMD8bE0839n9dVjaZdlwxV9RM5Q59/P1QLA78e+lBwLuAT
         160Q==
X-Gm-Message-State: AOJu0YwAh1HPV1mYNCFZYsl85eH2SUW2aYYd9Z1mmdlffByORBZerQ1L
	0eWKgtH43OHhSZqjARlYGqGPC47NKM4NGyaGcj6zdpAnPvkunCDi2m72
X-Gm-Gg: AY/fxX4ScZ3Z/1o0dXpBWdaEaPK+WV8l6sSAIKQfUW3Vz2krF9c+9qZ3MWmR05fKzt4
	/BXB9EoUWYR20I9GgodaMBRYiWqmfvEJq/gZSr4/4qMSE1tXMZDJIxFa2CQClVQcoPDmvS3Gy4U
	MDhBEwUQNA7A8VEa5CcNKsQQAci4M55s6VoHab71HcYQ/nxlRmigGe8BBxgjjEsRCw4RghW5yDD
	xcs6IBfDm4iwGn/06TaDT0zP1O2XnTFRH+4SgXps+/doYOHKdRF73qw941Abo1PCb2z9uyL/M3+
	yEGtVOld2qkf0dNRJJRX8BOnGiKBWU/rSpO3ce7gTdGF/GIvv53dmEBwUJmoG+k/eRnOWrnsA35
	e9vva0MIFTXkiIYEYc41PJLg4LdvzCOV9/jXi+sy74u+rK2Vzpr/ek9I4Y4wn2n7zDlouQunBxL
	KbFSS9iPerN1oCXGKROuzzs2+y2hmoVKJzepj7eQ1EAeD9
X-Google-Smtp-Source: AGHT+IEZzWuW7nYClb3WUIhupeoVpz3DcKELJiPvuQZ7eMljWgZc0EcZ59jpTYUi4GlKIFiDKo3E4g==
X-Received: by 2002:a17:903:2342:b0:2a0:d5b0:dd80 with SMTP id d9443c01a7336-2a2f2a3ae13mr265783725ad.54.1766976366721;
        Sun, 28 Dec 2025 18:46:06 -0800 (PST)
Received: from localhost.localdomain ([2409:891f:1b62:23f0:1ee:bb12:84d9:847d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66473sm235580885ad.13.2025.12.28.18.46.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Dec 2025 18:46:06 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	atomlin@atomlin.com
Cc: linux-modules@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] module: show module version directly in print_modules()
Date: Mon, 29 Dec 2025 10:45:56 +0800
Message-ID: <20251229024556.25946-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We maintain a vmcore analysis script on each server that automatically
parses /var/crash/XXXX/vmcore-dmesg.txt to categorize vmcores. This helps
us save considerable effort by avoiding analysis of known bugs.

For vmcores triggered by a driver bug, the system calls print_modules() to
list the loaded modules. However, print_modules() does not output module
version information. Across a large fleet of servers, there are often many
different module versions running simultaneously, and we need to know which
driver version caused a given vmcore.

Currently, the only reliable way to obtain the module version associated
with a vmcore is to analyze the /var/crash/XXXX/vmcore file itself—an
operation that is resource-intensive. Therefore, we propose printing the
driver version directly in the log, which is far more efficient.

- Before this patch

  Modules linked in: xfs nvidia-535.274.02(PO) nvme_core-1.0 mlx_compat(O)
  Unloaded tainted modules: nvidia_peermem(PO):1

- After this patch

  Modules linked in: xfs nvidia(PO) nvme_core mlx_compat(O)
  Unloaded tainted modules: nvidia_peermem(PO):1

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/module/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 710ee30b3bea..1ad9afec8730 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3901,7 +3901,10 @@ void print_modules(void)
 	list_for_each_entry_rcu(mod, &modules, list) {
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
-		pr_cont(" %s%s", mod->name, module_flags(mod, buf, true));
+		pr_cont(" %s", mod->name);
+		if (mod->version)
+			pr_cont("-%s", mod->version);
+		pr_cont("%s", module_flags(mod, buf, true));
 	}
 
 	print_unloaded_tainted_modules();
-- 
2.43.5

