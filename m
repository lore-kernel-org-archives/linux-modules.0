Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE89F304989;
	Fri, 22 Aug 2025 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867322; cv=none; b=mqcW5+Q7pX+JUjlNvuuSYa8U14MfB8yqOCIRs13BNRVoioqYUgAHHA3PJ0A0dyY8SbQ4ps0oS98hWKizX9exNULsmi8LIP1jnBj8yy5de1Rb81yaZu1m+oGoh3X13tvrw/Dg2bihoblaSJtGSn0mGBZ5huvd7NT19JGfCZz++RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867322; c=relaxed/simple;
	bh=8jjYGS5PeFKcozsVZLXrvKIwWo7k8S7vhYJP/tMr/ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t76uHYbSfOpsOam4tdKgClNueknahhRdCiL7ZDchN4aTRRVe6sqP5CfEiFqjpak416n/MiMNN1MLKrEcqVpAwV4oXrazeffM+51XRkpU8EiwQcDTBewMoYu3Pf7jNpTAbyIVgw6YWwbkpUvVphbdhcFjmdq3R+hor21yoWHUULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OImhc/LJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OImhc/LJ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2445811e19dso17147965ad.1;
        Fri, 22 Aug 2025 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755867320; x=1756472120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAU8pFNlFHyGhl4ZEBlmiIHJhRLnwySKV8rZz4maxqE=;
        b=OImhc/LJT1wXu1JtJWB7rf95WULXO7dyLVBFzr/9LXUSdBRSkcn/W7Sy3VCBjUfH6s
         +GsSHUMtsWBLkXtpUKGI9bwZMp4bGgYg6RDSsRdoqeuMb3J219zo+CM9lPc9IbvoBwZq
         P6yb8guDcrDzTGfz6/AjMjfL2EGHpxO0EuEn49iPNH15ckSGP1xcjGaOP0GsCql/JInv
         WINEwZZB78OhvptzaZqI1KorK2/wGRCNhPBKFtuTWy9JdPHOZoHR5/KcVhXS59FglUln
         +PwN8t7/+alPvBNKkeoiB0AnVQRDJnZQTFSbRwzbZyEljA87VsrrCdLGd5O/AXj6NIEe
         cbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755867320; x=1756472120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAU8pFNlFHyGhl4ZEBlmiIHJhRLnwySKV8rZz4maxqE=;
        b=ax50lWNI4GhofiPvSrDSp7SvU37/jIewGUAGUdu6LrhRACIKQmQdP/2AeE8kKrH3Q0
         /eML67Q9QJpuJE73AItlxuFpYtRnoAvFlkwgCFMBU3w4B0XkiNd1Jenov7tod+wY8H6R
         Ggrgu180W2Oamv+m+SSECw0p9ar/+ZxjjGiu3Se7VpaB2q9xbQR2RYKF5NXf4pPlBXls
         0+g1rYoHiOl3ZUU+BgsJHSrECHc4oRWE80BKsjLaphFPY9573cnaAEv8CsSyfkawOvoc
         T8c+Hoh8NgEcravdKNibP6Gs76+9eZVZMhqY4IKHo/RojdKLErVnrEh99dx94eOar89M
         eGlg==
X-Forwarded-Encrypted: i=1; AJvYcCVeZzDVckqJUB5YQek5KJRch+/pqwp9BVYQJg/HfWP7fT29hZbBQQ5GIV1yIcO7lqoPDdr+aEVpq9yfN2qXFw==@vger.kernel.org, AJvYcCX2SHxSDcO78sjvu3UuM4Xk9v2LVZr3CItlHOBUJ307KfswkxaUkBk5ViifijJJnQ2+DK95YVBllaqbAwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb+nQvH25QUTdSGO0hPQN7aMttHotv01iZB7ZS5kJ925pHTzT7
	F7h/FTEDZM3kqeBMUOBA3aLm4S0z1PDU3AnUpJkiZ9x/GZjGDn37VUiq
X-Gm-Gg: ASbGncvuz0paQ42hKJKSQiFiXE/pqFiR8qkhlTO+mzp34/GLfY3Pb4B/EB7Ja9dhWod
	aSluflNFuTqAmxUJHxx2+ADYl0qZ8XZfPhnAtsHX0UAPUMoEI2IEoGBJlROq20x3ISriuvXKLHX
	bwVPPNFMvphrlCCbMrUK9t9KvQtpSvR309JiL/8PbdHTwLrSAkSujcE89m9o0KEz2Qi92Nc2kLe
	XUF5ivS8ksTfVQzEfeEA3cg0MGDuKiZhnAiA7n8FS5HnpafbP6vfcJyPhlE6gcHkcPgSv28u9gC
	4AP9AxLYNXTQ2dlk7LjS/qoMPvVxT+Q/YbQb2ao5eI5HsdqnyxbrnJoAZb25oCIRQjQOO+xnbbI
	TMFAv78h37P+YSQmhuom6GdUB3nxod8VZnocvL2lrIieHyXGp0Kqq26gnd01CaAgu3yeGUb7g0E
	A=
X-Google-Smtp-Source: AGHT+IHsxQLMXCnBGCn/SEkfUyC+Su4X0WaERT4vmagBCKbCjWYWNvIO5t7fXkE6TBOF395yO3CUHA==
X-Received: by 2002:a17:902:e744:b0:243:43a:fa34 with SMTP id d9443c01a7336-2462ef706d0mr47925235ad.49.1755867320131;
        Fri, 22 Aug 2025 05:55:20 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed377843sm83617285ad.57.2025.08.22.05.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:55:19 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 3/5] module: show why force load fails
Date: Fri, 22 Aug 2025 20:54:52 +0800
Message-ID: <20250822125454.1287066-4-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822125454.1287066-1-wangjinchao600@gmail.com>
References: <20250822125454.1287066-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include reason in error message when force loading is disabled.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/module/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..a426bd8a18b5 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1083,6 +1083,7 @@ int try_to_force_load(struct module *mod, const char *reason)
 	add_taint_module(mod, TAINT_FORCED_MODULE, LOCKDEP_NOW_UNRELIABLE);
 	return 0;
 #else
+	pr_err("%s force load is not supported\n", reason);
 	return -ENOEXEC;
 #endif
 }
-- 
2.43.0

