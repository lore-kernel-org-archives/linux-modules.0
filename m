Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3C72C0F7B;
	Mon, 25 Aug 2025 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113355; cv=none; b=QRlvGQT+rHGH3IM2oLMQ0vu7TxRsvfihngmBcdlcXSytn9LH5GCCqkwSYF6GAdHR418zP17Lh4xDUtlDBanTunooQS2U2f9BkIRIstcgu2i0qSY0JN1GAL0UUoj4zfaYPra1VGOLl+NlGsEBGIiAKd5rkW+nhEz8nC+46mYIX7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113355; c=relaxed/simple;
	bh=3ZXsqREqoufGsZLipmttAUsjylpFAnJVVdaq4IIhGzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DrU1EMOwGmE24/jv2GNEkdP0PW+0y+S9khuWdbg38R92QpmcL8j4V7zwhKZhA/dLxj49p4+IbYWQ7GR69+9CdC+m2+wlNNPVhFq3zJnrEYVnXdDrVeORGRmS/NT7HtVJGPUyLzHixR4UU6jnTVoUoa0ALGaEBbFIfy2ZyedbSxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlfzGdvA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlfzGdvA"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24687a76debso11457665ad.0;
        Mon, 25 Aug 2025 02:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756113353; x=1756718153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0rUDlMA9JVkHsxYy01KICb2t+8xKrpjBn6FOITPjmos=;
        b=hlfzGdvAqETm82fAMYB9Ov9Kjepe7TOk6uVHF5KMJOLmRzHeTxdsqNbWXE7HOhuzsU
         pPlMx5coqg+j1uFXAZlFeteIyxTiJLhB7Ljl0ViiVnilsRlBvThgLqNGj7MQ7+PDDxlP
         jMF+64lE2loR4tRnaDRsEVSHPPkFqeZLaOHzqsGud7RBYDNjJCeMxYiwpOoUZ1Q+5DzF
         HRc2ebCV8XDQHJdjQctC6uPkWYxePSs7C4xLCywYlJYapeVpMGmZXHra0zm0lAT7uVwb
         UNJCRwuXJQlCCmWf4ylHgvtSjCljFPvvBOcW5YZ/Ye8D2ZFelejcjdHTN40ihwflnxib
         5KVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113353; x=1756718153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rUDlMA9JVkHsxYy01KICb2t+8xKrpjBn6FOITPjmos=;
        b=QyotUEa4UXUxdMMayTh24uIc0/Sw7KCuNF44JGunGv5/pxQSFjyFRoJS5fMHrpmvys
         CBun2ita2txw1LazRGrk1pa7E1oegopsYYvyqH3RV6u5tF5Rwefs4Oq4X8YUz0zEu/AY
         q4JOC/m2M7t1zwT5Xz8ENGAdhS56qcl/3BMqKVHvYuLQzQGEu6fOiy+Yw+kgmeAoQVnQ
         KHCipvDBfg6CXVxyiLO0dzGKXrfWQjqPclooDa+T4pURPu0EcnpTkbZOfkadqk7BO/8f
         198DHydbVflfJSZNXa4NGvEqb2MIr/Y5upsDVzCUaO37zGC0xjNKsbNfBL93WnS/xWP1
         rFPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXc53Z+G78cjGTN41EIorm9zfsd4tBeNcTCKJMYpalnvPaNxguGQMGe516/dbbCKxZdW1LRwEMycYEREo=@vger.kernel.org, AJvYcCV2PIicUvNFB/zsqqJoNWGeGmdQkUiNPVTtvfJTOV4nmZng1THsU7w75h4dCWEDbVGGD79RSvcpxS7W/u1kxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpYGpEzDYVChyAAigRhABkmMhh56y8uzVLufsuSHVYSuPxnZju
	37V/TAiRkQ8Y0po07UgTyCGcmvrf1vCQN5rh9W5w1l0ozHEGzBrg7Ibq
X-Gm-Gg: ASbGncsTq9lXl20JaTeeT0/kGYr4MrIKX7Dg5CaZmDGqcga1E/y5CqmB4JLgrEK9QD6
	QGh3G7PtCow+6jbIHyGDv9qJEM5WfLyMuGccLbQ4Ouax3hP8MChyYqjLOFp4OWKiynt15+xibwr
	fV2ZbyFB0kbP7T6VYVyNoTuzSNsmEcJMd6VAlyyahq1JqkdEbGi70DzsH1jJ+BD/NlXhZIsgvZ8
	vVc0JhEsyFnB97OD6obTKfGyT9cNkjfsIsyggUgSFKLwq2dDwypItfo9wM+t+2VwLVB6Bh71RLo
	qRoJS3GxZ+Jjl/0P29HWj7gmOR2RRhNLMu5UwmHiSxpBes6nUTkP+dNXRewhqPpGWjlSZPzSxvP
	w8fp4pTi/V47bn4F9sco5mFCpMm4ze6+nKE3D+N/cwHg87K7L2PsFVOsxnzHfgES+WP7Ztz+i5E
	k=
X-Google-Smtp-Source: AGHT+IHzFoiB4RFKJZa0IBEVCArIVCjpShZCto+Fh8aFRBe7LqWUlmLL8yTCkYLt6SYMzTi2PYFFTA==
X-Received: by 2002:a17:903:234c:b0:231:d0da:5e1f with SMTP id d9443c01a7336-246337acf29mr114424065ad.21.1756113353215;
        Mon, 25 Aug 2025 02:15:53 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b1525sm62792245ad.54.2025.08.25.02.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:15:52 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v2 0/4] module: logging and code improvements
Date: Mon, 25 Aug 2025 17:15:31 +0800
Message-ID: <20250825091545.18607-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of patches cleans up and refactors the kernel's module loading
code. The goal is to make the subsystem's logging clearer and its internal
logic more straightforward for developers to understand.

The patches in this series: 

- module: signing: Use pr_err for signature rejection
  Makes module signature rejection messages more visible.
- module: show why force load fails 
  Adds a reason to the error message when force loading is disabled.
- module: centralize no-versions force load check
  Refactors the code to centralize the "no versions" force load check.
- module: separate vermagic and livepatch checks
  Improves code organization by separating vermagic and livepatch checks.

Changes from v1:
A patch was dropped because it was based on a misunderstanding
of the ignore versioning flag's original intent.

v1 link:
https://lore.kernel.org/all/20250822125454.1287066-1-wangjinchao600@gmail.com/T/#mf748b6e97934f7a463dfdafbb426965f3e0ad646


Jinchao Wang (4):
  module: signing: Use pr_err for signature rejection
  module: show why force load fails
  module: centralize no-versions force load check
  module: separate vermagic and livepatch checks

 kernel/module/main.c    | 13 +++++++------
 kernel/module/signing.c |  2 +-
 kernel/module/version.c |  9 +++++----
 3 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.43.0

