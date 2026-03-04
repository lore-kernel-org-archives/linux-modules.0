Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0036C581
	for <linux-modules@vger.kernel.org>; Wed,  4 Mar 2026 23:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772666947; cv=none; b=n31/OYNknDB6wySOVH1UbqTckPOPl45bBqwRRfJrrbbM3MRwaIPAZXuSyN3/HVarWKmD3VooFVbGsyDj9iyDFJg/9D0BvaVdCXeGwHrmhKYveWxrmeN+rcJDMJivZpeEB4dQOz9jmOOOxjEemvy8OQppL2MuQNGAEScS/Q7yz6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772666947; c=relaxed/simple;
	bh=0gHapI30/+/be7JhTBpIoOsGZ0qVwShIt9lUzEuDuck=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mkBY4k3COw6y/QzH7do5yB/2T4ox7JSxUd29KY8JyXZ3YiOTtgfAOBypT+JnoGN7FV36+ejdjpRzQb8kL12rr9Rb9yJ6aBec+ap1npqfIyghVgtMy7IeJUv1StpVV4yauEmxa3wy0Y3Fih1T4GrmbNll7PUxhFT3t3JakVjLt1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FasJElsW; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FasJElsW"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2be21146933so3997569eec.1
        for <linux-modules@vger.kernel.org>; Wed, 04 Mar 2026 15:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772666945; x=1773271745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n7h8W+ClGkt164cnjJsLpftPjj5hWQFNeBKB5yKZwAI=;
        b=FasJElsWjKxfyaS+U5nYucyUQszqd+JfLqYrGtz89zd4zK5dL1OKyyt8BtdnpRpeq/
         eQzEVRakZ6T14ZxxdRFPN9snMpYwNAceFPmAkGE/upuny69M9tlcZJvV+umHmo4vEylX
         DcSavHJfX3CNf2LkxHs8keozIaiMQLQf21PvKPnqlMHxg28uXDSd5LPuQMaiTloLsttz
         fHAmay8rPQfOtpRNO3Iyo8RpC5QgRThvqLVFViATQN6DVtNfO4GJllcUZUNNt32OY6vl
         CI57SNKhkivG+4HVw2DXqjzZ1gkaEssjApBV9mO3kyydyT56ksspWh4BOtAlZoxAuD3I
         /6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772666945; x=1773271745;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n7h8W+ClGkt164cnjJsLpftPjj5hWQFNeBKB5yKZwAI=;
        b=EJtzArMIhqhDi8EWIxvlvuQF1NtZ/rGYN7WdLVzp8bbvhFYnL9gyh9FBIUjaCSbWLI
         ck7/m0V6DTHohub5S07YnFAAUwylCaawfpxfkUSMpgbXfoJ5Db3SPYsTp5HmdByDkbHD
         UIPBQQJNKRf/U1KekqbfhILvkS8+QUXwEroXz/djpLFPtm1Tx07ZDO4UFmiaX/BPuS4i
         U2f+cwcdfB8owYxvev5/7g63kdJD9IIltkXwwXsSEVoWK9zXbwlJa3BB/6gWsAgbEenF
         ZGDDWktKeEHdixq1o9Amk2jE3SzGIvEc8DFICwg0bzSv3/mPg0bxUHz3yRwEc667uGVg
         8BNw==
X-Forwarded-Encrypted: i=1; AJvYcCVbjPs/nj3h64Ivaq/SD/CrzMZE9oB/jM8hl2DMX9M7OCHOTaTYFAxRL7MTJQNrF6YlrxQh1s4OLtnC1Pav@vger.kernel.org
X-Gm-Message-State: AOJu0YwhoasV3qkXfRn4LqY2CzaMdDtn1sL38dn2EGvfroYSqmfcVkcN
	B3rxF5XWLG9hSFntevYGzGgb/1+JSdpVSKsxW2cGLkFEboZnP0v2P4+DBOtBNGShDgcv804tWl8
	RgeDMtGCGv5FUhcwuTaoo4dVGfxxA5A==
X-Received: from dya11.prod.google.com ([2002:a05:693c:620b:b0:2be:1421:f19])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:6c1f:b0:2b7:95d5:3a32 with SMTP id 5a478bee46e88-2be30fcfe10mr1445559eec.1.1772666944786;
 Wed, 04 Mar 2026 15:29:04 -0800 (PST)
Date: Wed,  4 Mar 2026 23:28:58 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580; i=samitolvanen@google.com;
 h=from:subject; bh=0gHapI30/+/be7JhTBpIoOsGZ0qVwShIt9lUzEuDuck=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJkrDthkPV9555Fx9QUp6Zo+hi/xeyTKmTK3ftK/lnLc5
 XPJuTN9HaUsDGJcDLJiiiwtX1dv3f3dKfXV5yIJmDmsTCBDGLg4BWAi2iEMf/gX/jn18/xx58qE
 JzUPtq5tNd1Y2yp86ERW3+O/Gznjl+kxMtzyeSxyvnBW1oa/QnWrHjUtWiii8aTTg+mSo7mSq4t sDxcA
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304232900.149281-2-samitolvanen@google.com>
Subject: [GIT PULL] Modules fixes for v7.0-rc3
From: Sami Tolvanen <samitolvanen@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Content-Type: text/plain; charset="UTF-8"

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modules-7.0-rc3.fixes

for you to fetch changes up to f9d69d5e7bde2295eb7488a56f094ac8f5383b92:

  module: Fix kernel panic when a symbol st_shndx is out of bounds (2026-02-23 19:37:28 +0000)

----------------------------------------------------------------
Modules fixes for v7.0-rc3

- Fix a potential kernel panic in the module loader by adding a bounds
  check for the ELF section index. This prevents crashes if attempting
  to load a module that uses SHN_XINDEX or is corrupted.

- Fix the Kconfig menu layout for module versioning, signing, and
  compression options so they correctly appear as submenus in menuconfig.

- Remove a redundant lockdep_free_key_range() call in the load_module()
  error path. This is already handled by module_deallocate() calling
  free_mod_mem() since the module_memory rework.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

----------------------------------------------------------------
Ihor Solodrai (1):
      module: Fix kernel panic when a symbol st_shndx is out of bounds

Petr Pavlu (2):
      module: Remove duplicate freeing of lockdep classes
      module: Fix the modversions and signing submenus

 kernel/module/Kconfig | 23 +++++++++++++----------
 kernel/module/main.c  | 13 +++++++------
 2 files changed, 20 insertions(+), 16 deletions(-)
