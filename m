Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE4A29CEA
	for <linux-modules@vger.kernel.org>; Tue,  9 Jul 2024 04:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720500499; cv=none; b=X63EHib7hZkEv/NzfWlrAdiShXenZORImXXzTswhLL1KfRBj+lxcZ1ep0T2Dvsxtz9DP6bWkn/YmIBDRT397g8PevrZA/vjYbrhLDRnjsPldUlLas0vXxni9Lrc5tZdpdN88j9EsUEr4jiwku44jX3x5FFfeQS2J2Qew3T3YNPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720500499; c=relaxed/simple;
	bh=i242BUVvpxa+YHvIeLIUetBbivRu7IbeGF/tZornNWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eA51cENbMXuZDYhZLYcY+ITQB/wNb+Ww7lzcGOtxbAPuyVGNAuVFf8A4lvGwAiZuYI9BqXP7bcTjIQeDc2Npg/Z7dsAJ3dRL2bHA54LnYc9/SNLiOFNpt0xM+iWgfuYe2ILGMRPbGaud1gkCevRXTFARgH0WQ0KH3IzSYTgEU80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODAA9Jjx; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODAA9Jjx"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79f014a53b7so251492485a.1
        for <linux-modules@vger.kernel.org>; Mon, 08 Jul 2024 21:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720500496; x=1721105296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLzjRFFyTahFg9pjzHmLot5JvgrNlwKoD9kPUwV8NJs=;
        b=ODAA9JjxboFVjiUpIkgNcswnUjGRwDZniGO5yt+A9GoFV2jrOml2Mdkg4J5l+XwJxk
         93La6n8S6R1zBuo2WFcNcMcbmGp5c/v5s6gKu5hDUyAKG82RhLrYf0rWaQPwd5X+8SA9
         4nsiIUqGhVzELkAtqF5xWeX2Sh7C/TugAfVc9MX8EPNjEOtmTX4QcBhM7Gi8rXLtMlW9
         LqDhSyDqE2j4zxd3pqajuK/JNc5i4l415yznraoH5x7c5HAL/qpgISooZebsnsPOZQEY
         JmMYYXyq1C9J7BuZ+YpSHTDiL5wvJo1vp2hbnPvX6osZpt1yYo/N2byv6/WpBT8Kd5ta
         2d0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720500496; x=1721105296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLzjRFFyTahFg9pjzHmLot5JvgrNlwKoD9kPUwV8NJs=;
        b=u6B30TeLeT4EyXO1bpgQkhb/budFgrMZTc5KlRAJRvIGV0ssgzleCb538g1OhqGoqS
         qguXd0yXZ+dZ+lABsKwZs4wPt8U1cuglC4nYbTxz7qSGC+3QshyQqMPV5SYSdkML1Y26
         itWa/E2q2e840W6HdqiXlAIs1CLiTS7i8iyL28i3t7RcpCRK5XZcZ6Fhz3pRcvXH6OMR
         9yZyoV7V5yGc/Fpr3kqafmoaI4FtKi8FhqcA9/UAoNWkTQpY1Ilr8bAZRM90KeGou2uu
         i3X9K4f2WmwUB/ATWoBSLnNc8mFa55jgNC1zPQknXNdt3GFAJgdIgYhUIEpXDBnjP17m
         cRZw==
X-Gm-Message-State: AOJu0Yy80ZQDxvBf4cmTVwj2Woz2wquzxZrUe5z+6WgnP6nud4r+ut9M
	YI0Z8rNCcsWceDjZY5xPMfcaewOqXufX6DfvWgGdYCbVUKIegULeNR9pSw==
X-Google-Smtp-Source: AGHT+IGUWxAYpwSFF3lN2xgPBnmQ4RwEoWktvXoKl0DvqWPbp4x9tM+BuIgdyy925itsEihpxzphcQ==
X-Received: by 2002:a05:620a:135c:b0:79f:baf:ed0f with SMTP id af79cd13be357-79f19a1f545mr176991685a.23.1720500496020;
        Mon, 08 Jul 2024 21:48:16 -0700 (PDT)
Received: from ldmartin-desk2.intel.com ([2600:1702:4eb6:3000::3f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1902ac2esm58639985a.59.2024.07.08.21.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 21:48:14 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 3/3] build/ci: Add distcheck
Date: Mon,  8 Jul 2024 23:47:58 -0500
Message-ID: <20240709044758.67725-4-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709044758.67725-1-lucas.de.marchi@gmail.com>
References: <20240709044758.67725-1-lucas.de.marchi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a step to test if distcheck is working.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 .github/workflows/main.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index f366846..b3b2fdf 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -47,3 +47,8 @@ jobs:
         run: |
           cd build
           DESTDIR=$PWD/inst make install
+
+      - name: distcheck
+        run: |
+          cd build
+          make distcheck
-- 
2.45.2

